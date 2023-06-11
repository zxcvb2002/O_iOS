//
//  DiaryService.swift
//  O_Team
//
//  Created by 드즈 on 2023/06/11.
//

import Foundation
import Alamofire

class RecordingResponseModel: Codable {
    let answer: String
}

class DiaryService {
    static func createDiary(){
        guard let name = UserDefaults.standard.string(forKey: "key") else { return }
        let url = "http://tarae-env.eba-uepb7id2.ap-northeast-2.elasticbeanstalk.com:80/api/record/diary"
        let paramter: Parameters = ["name":name]
        
        AF.request(url, method: .post, parameters: paramter, encoding: JSONEncoding.default)
            .responseString() { res in
                switch res.result {
                case .success(let str):
                    print(str)
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    static func createRecord(_ text: String, _ completion: @escaping (RecordingResponseModel) -> Void) {
        guard let name = UserDefaults.standard.string(forKey: "key") else { return }
        let url = "http://tarae-env.eba-uepb7id2.ap-northeast-2.elasticbeanstalk.com:80/api/record"
        let paramter: Parameters = ["name":name,
                                    "content":text]
        
        AF.request(url, method: .post, parameters: paramter, encoding: JSONEncoding.default)
            .responseDecodable(of:RecordingResponseModel.self) { res in
                switch res.result {
                case .success(let model):
                    completion(model)
                case .failure(let error):
                    print(error)
                }
            }
    }
}

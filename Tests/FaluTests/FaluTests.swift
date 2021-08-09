    import XCTest
    @testable import Falu

    final class FaluTests: XCTestCase {
        private let falu = Falu("pk_test_cbw2Bxslzkxf7sUAg6932NYm1ApTX7C0TEMbvCYss")
        
        func testMpesaPaymentRequestFails(){
            let mpesa = MpesaPaymentRequest(
                phone: "+254722000000",
                reference: "254722000000",
                paybill: true,
                destination: "00110"
            )
            
            let request = PaymentRequest(amount: 100, currency: "kes", mpesa: mpesa)
            var faluError: FaluError? = nil
            let expectation = self.expectation(description: "Payments")
            
            falu.createPayment(request: request) { result in
                if case .failure(let error) = result{
                    faluError = error
                    expectation.fulfill()
                }
            }
            
            waitForExpectations(timeout: 5, handler: nil)
            XCTAssertNotNil(faluError)
        }
    }

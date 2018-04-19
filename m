Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753126AbeDSGI4 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 02:08:56 -0400
Received: from mail-he1eur01on0067.outbound.protection.outlook.com ([104.47.0.67]:15232
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751957AbeDSGIz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 02:08:55 -0400
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=nxp.com;
From: Anson Huang <Anson.Huang@nxp.com>
To: daniel.lezcano@linaro.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Cc: Linux-imx@nxp.com
Subject: [PATCH] clocksource: imx-tpm: correct -ETIME return condition check
Date: Thu, 19 Apr 2018 14:04:43 +0800
Message-Id: <1524117883-2484-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR03CA0029.apcprd03.prod.outlook.com
 (2603:1096:203:2f::17) To HE1PR04MB1322.eurprd04.prod.outlook.com
 (2a01:111:e400:5889::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB1322;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1322;3:EPIbjBlJziQaGXnenUUfwrDorASDxGjEztVoSu9l5VePLD8nqWZIwyxCMjgrGejRW+0LPJPrgf4Nn0gyQx0UhyHKogDjWqRFOKBRmXQv4Vv9NX+ArMVldnS4YjlvVqUdtOPlo+xJEyQXFjkWEONSAPqD6bEIHyZSvMGhgNMW8Lc+ALiMB/x/rHMVzp1bhFBXKz9w9iKotAv6XRF1oJTu3FTUrk7TcU4dtye9rTVAEMUjvJnt3iHs63Bmx6X8QML9;25:LBTpYWbqlBq8JMjLffT8Byq9v0hfzLJ+4Zi85/+RCWpDadjq7cOMlnjoNkDoelIFIS+AiktbFj5J7BJNZp+DADYpWz0LlJAvb8dLVlMjZxdfWDYvOxpWjOfLlFD3I5q/4lUn1qfWF3Ah9JQcH0DcNJIrMDhlZNOhU+LPtzbU7y84rLvO4TrV3YOnj4tE4F/GX0Jef8qASz6NQIMCM0VS/3jELwpJ35In9PE9SalfzTiAwBOgucCiMIkrgHU9BlDrVZbJYfI95gTLSX6FnOsE7LbVrqkWKwJwZ0wyb0JQhOMSRIZ68nwseiyFR3kUJ/Xd+tRtW7ddc/UKymojsklHwA==;31:lDdinSQpcAXFX2MaplxdKwQyezMPUAVTHyryAYx/IS2FldWZKFV+cEGGVl9mqGBjfbMxtDiniO+GYZ6WC++rUQPgZvKqWdzX4JeXS85pDkWUJ2DA6k1K8aBuwaj6zGcKPpPYGmYd7MUwcqgGzY03sGKAluzZA2Ai46lT62oVts4pJhbevMQCImkFdKxmjhywdYc7BgKT58W73NNbbcR85KCoBytPkV330ck6f5wvCF8=
X-MS-TrafficTypeDiagnostic: HE1PR04MB1322:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1322;20:V3fa1SAqLVV30sH3kLXn+3ISfNTojKkc2ISrpVIbjDVfbW7suJ0JVA0v+C2I4yCrINupNULHjDT7wubxv5/qxLxdLAPUwBdmWxaQ5QIieDBg7VXlySKwIeAPQt28mMUiqqXHtNDf0E/Fhz4chiJIBfLLCERZfqqUnMQQWSoZy8SuenZdKi4FHFxgLlb6LcOwM10i4V3iZPryza6NkwBy+os5jkc3UiHeImX3mj5sYABRzDXYYwLgZPpBng5QUVgjnA2TS3AnWFH08PEhy4yXWAwCccMmpojc8Rg8Hcvfi+Iwuk02Thyohw7pH2eeQWvFOx1BnD2bk3thYdhYZxdazi4f0AoT/GQ7ovZQzS/GMBQkvQ4pH8A6m8d151M0AAaxvwGPIrIuLemrSBW3kLQAGeDThjkSGEnOnj1r/QC7kVSVtwANkEQIqjtJwliNkLQh+B7UtMweBt/OGKMaxI2MfoAPq5LNm/+qHE+K4dkx2VYEr7xPhNMlmkeS3xqnGxN+;4:GBHBXsgswcntSBZRYPz5o6I4nPtCMzA4EDvY2EzBLHNzh3jUJuZfQFmllsdTe8te3aQmwdbpFKUxPCCZB75FWH7N0jgqeVAjiW2DgioYqswWDJgWEVTCE2ZNoD0dQHl4wLSsfObup8tUeSDAGZTKxnYaf4kJghcpYTGhXf4s6br15YeN+oQrU4DVod9HEVEtPS+IQRgCXn/6XgB5o/s5GY1neQbQigS99O+rEvw0HBUdSIVhGsgsMqSoh1c4BOTSTRc1+OpgCuEG5d0eDeYBaWMQmFjs0ekGQA2WuhBHmHmNSSnsb364FAqU5PAJrW1n
X-Microsoft-Antispam-PRVS: <HE1PR04MB13224B7F0F2C530E5B4CF86DF5B50@HE1PR04MB1322.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231232)(944501327)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(6072148)(201708071742011);SRVR:HE1PR04MB1322;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB1322;
X-Forefront-PRVS: 0647963F84
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(366004)(39860400002)(346002)(396003)(39380400002)(6116002)(316002)(59450400001)(8936002)(81166006)(6512007)(1857600001)(186003)(16586007)(25786009)(4326008)(50226002)(16526019)(52116002)(305945005)(51416003)(3846002)(7736002)(66066001)(478600001)(476003)(5660300001)(956004)(2906002)(2616005)(26005)(6506007)(386003)(53936002)(36756003)(48376002)(86362001)(50466002)(6486002)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB1322;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;MLV:sfv;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1322;23:/aX3Z9HrBwIA2mNwEUQd9CwyeWvxdn3O4ebX7eRSp4LvhO5VaHAaKJ7Rnvu4ZjJ9ToLaU13CFQL/rPD0KRtxYPph7MryxBvGHZriG+LI59IZpMFVOdq/JTdVXDf6jzrMLpAZWlBzmwd1rG2HNSna+al5Is+htmJDiQyWgRnK0pm0e03U5lAlUVvTt3CNGCn9GOrwmWZXxeSI/r0gqNW+cj4Nn0GndNS8976FBqsbl8apFbZH/A3Ei+REb6dtLgEBlHgLQTN1T10PrLhDXIUxedxn+LV1NazgeZVGdzYLF6KRlJouyn5BKCr1Q98QHt7ar+obsqc9N4bvq1EsVIcEkgiTei6S9Rk/pVa8hKe8TtIZZMoKAUe6wOHF3/EWdjLKtnTVg3arwUcSwFOVxxbMj9qc58kLbEeRv1rEybeX8Ov9NiDpMSA/9IiorqKALQicPnswPp17jV1sWmZWLxVc4ED8spM93n/0Jyf85qtiWXACJMvbtOBhsvXSA71+g/38ddCDSvC9+lYuF3DJ7HCZ1XGgs/quEONoE7lT3649FnYRTa3bCSyRYQ6pxQGOB9qr3qNBAFdf1Qh8k1xVgcAk2zNJEQZrcv6HxUQh2P0tbhLdAGyx74p6L0281kdWFfntdM70zwqF/xqH5Z7AtCkJCLiS5JkLz4Wzba836vEeUhQZrQJX3CsISMe4zUQLKgqxBFAbNUo3fZCvk3MVcb56Yd485nAX3cNC9zG5VmQEJrYkSXYb1lS5ZajCP5yIByPEBZ2jux4eYfVmJQBTX1kikEtT2JpIIbTiDINJv6TL3c3qV1qF4yZgSwnnymSPd6iOaHCVz24d8t0dzOjDOMzpQTOVvCTLfhV6T8ULorBxBFgXr5T95SMUc6TfthAOA7Yymioja5TMk2g/fvSLju57Krqw/VEYlBPMx3minsM21rvpGsEsZg/eNFwCBBZRJj6H
X-Microsoft-Antispam-Message-Info: ZUUlq85D16BP1Pqrj+qQMwrzj7ZItC8txyAIcrkrwgfnZ4d4z6Xe4dWRxRmMuRPh4OuMlakSugG8+Ef/ImULy3MVx6LtJz4Hv9SyAMUuUDZ2QVEWy4jH7cpbd7XdWzXKuydi0BMqbIiyhAm+Cms3rVOljjR3BODfb6qDKTNcFmf9mp7imYzvy0yHbEP0LZSY
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1322;6:z+FL7i8UhzPW6LUQNOYY5jcOGNPLE05Ts2tAgmadN4QzD2rcMaCBFJ/8K6od65AzqTNKXquQU4wMnHURydn7sgLq2uMqYfruZMedYaPIhJFL2R97OIYycCoamPYItlkNk4ANOUfeufbPyGai82aLvnpLvMDJlT0YXlHa09UBbzKmjIiDGaZMMwsz6hRuN0T5JG7IPt0Mtw2sVXT5djK4PSGj/GR4sLMEaRHF2icVFqNZRaXBDOXw9LPLRyzarYBKWTOH5IipD/f3RupFOKxLQRXnbSAR+XAISPa2RkY7XtLFwoJjk1+tziMDID76qf8EPQyOrXdVuLa4H5cU+pFZjJ1ePRNeYGOS3Lr3+ZAeSHihKbU+bW9wxkayboV3p89V0q3ylaO/DRH+WYuRvrs0O66rdi5hr32VQkjplzHs1XyFEMW880qQteqEyicp4Ybcde/ai5Epc7XhUz/INd+Krg==;5:JHtVEdQ+d32cgr8MTWiZ2bdTKaTZTXcT822kl/HN4G1KmoZgkpPGANK72SZ+NpS55rPeRUf+grFXyU7PaBy79BOlDPjtKH1/2mkxTpeGkTv1NeKLF2R1kQY+VsiXAN8ptxYSOyAQkeVGFXFOqv2Lqnm7rG9H0W4/vj+N4YDv6S8=;24:1sfm30Nndo99TjcPSMHL1AsCH61sd8fZRNHol+dXhZ4Ddnv77IDtzlGg4VZLYrCl0Glf+DwDm19ngv8ttpBXxbxkAA0zUTkoInU/Y1QmNpw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1322;7:/g1EwLLKvB5v03bc1rdA0LbtZKO42Y5iVTP1e2kEeyMu448SbOxVWQJFd+j9BjQ/USapQa7fHqboP7VpiDM5u+XwLLx/3OjZ7+p53Vfy1lLzJHRTqvll5kdxAerUqkeJ+zYb5AgcQUWTIudU4N0jMIjqumKDgUkE0IuAu2W1GXzap+funMJIxRSu45szGtB1K79x/XdWSRPOgUnibdYiGVtbA7kiU4XgOq+gM3RWZZvS5tVQihdbckPfV90yTI2i
X-MS-Office365-Filtering-Correlation-Id: b03943ac-b9b9-456f-4bb8-08d5a5bc056e
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2018 06:08:49.0247
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b03943ac-b9b9-456f-4bb8-08d5a5bc056e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB1322
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The additional brakets added to tpm_set_next_event's return
value computation causes (int) forced type conversion NOT
taking effect, and the incorrect value return will cause
various system timer issue, like RCU stall etc..

This patch removes the additional brakets to make sure
tpm_set_next_event always returns correct value.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
	resend, since I got failure message of sending mail to linux-kernel@vger.kernel.org.
 drivers/clocksource/timer-imx-tpm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-imx-tpm.c b/drivers/clocksource/timer-imx-tpm.c
index 05d97a6..6c83184 100644
--- a/drivers/clocksource/timer-imx-tpm.c
+++ b/drivers/clocksource/timer-imx-tpm.c
@@ -114,7 +114,7 @@ static int tpm_set_next_event(unsigned long delta,
 	 * of writing CNT registers which may cause the min_delta event got
 	 * missed, so we need add a ETIME check here in case it happened.
 	 */
-	return (int)((next - now) <= 0) ? -ETIME : 0;
+	return (int)(next - now) <= 0 ? -ETIME : 0;
 }
 
 static int tpm_set_state_oneshot(struct clock_event_device *evt)
-- 
2.7.4

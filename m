Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753256AbeDKMth (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 08:49:37 -0400
Received: from mail-he1eur01on0136.outbound.protection.outlook.com ([104.47.0.136]:41568
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753154AbeDKMta (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 08:49:30 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Subject: [PATCH 2/2] iio: potentiometer: mcp4531: switch to using .probe_new
Date: Wed, 11 Apr 2018 14:49:15 +0200
Message-Id: <20180411124915.9587-2-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180411124915.9587-1-peda@axentia.se>
References: <20180411124915.9587-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR0701CA0087.eurprd07.prod.outlook.com
 (2603:10a6:3:64::31) To VI1PR0202MB2781.eurprd02.prod.outlook.com
 (2603:10a6:800:da::19)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:VI1PR0202MB2781;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2781;3:HGFvbbNg/VDYyPfRs+0s7QRrI0Wt8AvEg1dpldSVWbbvyfuOSYBNWCyHZNq42qVQY5ku5nJoD0FmvuFipAwne/nfTSd/PubLUCK04nYehQiKZUTePf5xxYdz19W0bBSXmSrnx4tNmt6D4ph3pFVEwD9GT/tIBPpMoxkJomDyWXIeND/0brl9pA7ZAhU6yCpdFKqluBuKfq7K8+Ry/oJUZgZZcLl/iQQE2pDU168gRlxIsGKmQ8aT4zihzV2mjR/7;25:V1klaA3nh+h/0LwxPfcgUv+7bWZqnJ5U7G1ZVCRsIMq7XJ3kyOey0TzCI3KkmRWMeUh5ILVftElVNIKOOiDy94jVHiGajRnBACHHTiBvt8gSFGxN0HvytColp8XBk5DgQX+W8ODxhlYads1aDVR+he5zJ1UzsLJTvobycT4FCQaQ6ToYH42/HNUBtERIjFYkz4rU4VWjwHh5Onry9WZcOcnLppx18QzwCmmvZ/v6dPt+kHs1ya1YFSH/RRjr6oi61MVQLThcQhoTvkCcPtmB+URkaZGJcOmXs0FBJ2Wre7B+Ya6YmyDGHfJpKYrPpC8uRjndXkMIWnNeN6xWdUzubQ==;31:KaaQbEP3qmPHhV8DvtHdefjqRGCew8DUt7Xcfuw7wlern9h3hIbZIgJ35HpedFy3PrnGK1xuKBLsqe1eZPdHumBg9uMRlXWRtmuCicbxwd8O+Xu6/S5pWyNoVJJGGRZ4B6L8QKCN56VTxBlHDkYv4fvAyFk+OhLQ1LCZsE+YWIFScY6QLy7MA3mOygsODvbRqrkgjn/a1ZT4KWI5Bn7/pd4gET1UCTURFZYHDY0P2NE=
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2781:
X-Microsoft-Antispam-PRVS: <VI1PR0202MB2781A1B79388DAAC6891A976BCBD0@VI1PR0202MB2781.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(6041310)(2016111802025)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(6043046)(201708071742011);SRVR:VI1PR0202MB2781;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0202MB2781;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2781;4:RXXcykA4DjQHzclEldevh35fOQGFUDjfiYi9dG/NOiSI22aVa4Sf4dRtt3bSUsythWLBI+9/Z4Wi3DS88sFviFVjtnh0R1QrHXnN47cIAs4hs9sPl/cIPHRB57pK6/GXAGzrdFcwbLka0DyxkgfZBVBnQTzJR+8ji9K/3XOFVm+vbZdJq5kPhzajiPzL/UHNPuv+y4PNz8thiby8pHu+8XrlCpUAc5vU+SwufoZSJACMKTk8wLUR0c33S6sU+eD+YTq/LnUp//r6qShOfBy5YA==
X-Forefront-PRVS: 0639027A9E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39830400003)(39380400002)(396003)(376002)(346002)(199004)(189003)(6506007)(74482002)(6666003)(8666007)(6486002)(68736007)(6916009)(478600001)(105586002)(386003)(51416003)(16586007)(76176011)(186003)(54906003)(2351001)(53936002)(25786009)(52116002)(26005)(16526019)(86362001)(446003)(11346002)(7736002)(2616005)(956004)(486006)(48376002)(2361001)(8936002)(4326008)(36756003)(81166006)(316002)(81156014)(8676002)(97736004)(1076002)(5660300001)(2906002)(3846002)(66066001)(305945005)(6116002)(47776003)(50466002)(476003)(50226002)(6512007)(106356001)(142923001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0202MB2781;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0202MB2781;23:8snePFUziB/uVjRDgI+WxMxu1jvlgUVCVS2p3CO?=
 =?us-ascii?Q?YIeHDaWjM3xfaYuCVsCDzP1qPKu8nZk2lep4G44BW+VYIKlHgs0JTHhJ9EO+?=
 =?us-ascii?Q?q73DJq7Brf6yGWkVy/JxglWfWMjS8Qk4LvSbbaiRIM+OzdD/KFZdRNDVlAqE?=
 =?us-ascii?Q?oygBChjV23BZc0bblXfJ/Fhhxmpw/j0PpqJEIih1TlhKT2xB+CzJNej43dOo?=
 =?us-ascii?Q?qiMJftf9/lfQZwowbInfAXDGzJ7A2vu35PQtWd6PKPw+HtWx6hFK2TYeTYns?=
 =?us-ascii?Q?GmVMfiEwdwkMIDDgHWDC5e7aLkOKxuVS6ieSdg3A4f3mmcTD52KnytUdm8RA?=
 =?us-ascii?Q?N23BjPz+g3vpAqmyNu4/HgMgZNfIjlqg2fINd7iIsacRSuyCczeA2x7uZl/R?=
 =?us-ascii?Q?tGV34E7/lWqT1EXGQ04SxgV4cCEK/9Wqf4pqQXHMrBqDRtEVfxDG0HC8s2tE?=
 =?us-ascii?Q?8U9IyF+YwHGPgp1VGJZAa2ylrcS3rd2QJq0BW54ckjzV8LH9raqVsPef4pEy?=
 =?us-ascii?Q?a5zQy8yarHZmeaqJVly4SRKGyw2c3852cdENHpF4CD6093qdnxp4f0UeOtwj?=
 =?us-ascii?Q?ui5YlSgPmzvxOQtF71AqyZc8rV8yLAs6Hi0ohThgTcCvV4y69JcNaA27xnI2?=
 =?us-ascii?Q?M+4FypPrz8rjEoivcy8hFhMZ84QIqQLNTPfjsvuAFKv/wQjnnE8DczBjVHJk?=
 =?us-ascii?Q?4UOeNcOM4P+NORq+ClWr5SksQIrQ7nz/B8utNFs8NUpkymYwGTGHBTDhBYyQ?=
 =?us-ascii?Q?TdwOXzwZNULefancsBr4ob1qUcnA5qGF6dk7clVcccm6vKV43lEkJQZNeLwb?=
 =?us-ascii?Q?cpH5esj22mRAzMMhLAYKKAQhFIz7bVAWMmlFJ4FR7P29oLoLSubNScl/R+QP?=
 =?us-ascii?Q?Nkhn2pAKtVUOptKVPqfdRPesZ4qsWODKCYowOEBq63r40l3OaHQODi3pNgEs?=
 =?us-ascii?Q?s833w5m27PrfEa6hjnKnlgES6yQK6TwW3Q66McqfsefSJyNbLO08me6keFjt?=
 =?us-ascii?Q?dTnfHGqeh6J+Sfl5sOiWsoK4KRNg05TAkz8+kvRkFkUMY9SoaR1wzJ1CqBAu?=
 =?us-ascii?Q?QV0eKtT+798lrzvi5Y2OF+0wecu5ojsCJlCXiyGaCx3rE0cFbgR2WQKM2IWE?=
 =?us-ascii?Q?r7YQJ+mVyHPpvfauoaHVY8OCv7mqZkKMH6nIfDfyf7GJc0jgiyUem31oOhtA?=
 =?us-ascii?Q?Vu20QoeoukqNE8eSILN5gG6Mr4jUj6ksNfs1GWmOjZmxumG+VYm446Ucmdy2?=
 =?us-ascii?Q?u1wR0FmWuHarlMxrQcy+rbssLNHp1QvscIWafUo67tNLxS9vvi977lpJmsY+?=
 =?us-ascii?Q?N+zUrFHziab9liTJ1k8j07LcDXtKvTv8jHa/ujoh1BMke?=
X-Microsoft-Antispam-Message-Info: qU5PFAAJDBEthQUaqC/J0FY82eOGIMvM4kOnDo55jFT/kW+uEcGUUgF+cPjX77WJTijTn6SaYn8f99oJm9aQV9w0Wm2MuR5LGjO1pUo/+2OzI6grMAtya587DPyGfEpPsS3+gZ2mNdlrNGsgAZGlcvOLSCekYjeql9wozxBYwO9Bu8FzOjBBJHeX2Wq7bGEu
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2781;6:gwaRQQZU+V6FAKjQSxFt3ZozwKrexDfSgApPr242Fdj1JMgGJMwZKgwAxrvRt1+8jb5fjCKh94tTWHfHsbXfpCtTw2IB0lbn29AM1v+ZKEK6tQJsDf0q0/mh9ZI3Wa4x/WfKk7QCwhup3KC1xZt3EdWbHfNMSmumOw8wlf/WGoAsmisF/ZjGO5JWNfcLwTHfvxQiKjJBVAQoUFyqZ3BSHHJ+olHnIy7H62Wt/0gKJ0hiFWZ2fFTgshPMNUtmnUpwH4xxCC6rlVkj+pco/T5VtOGDCmAlTkSposUnpYZ0M53Z1j27vP4m1I1bqhk0Eh0913rK3qeYFImwA8U9OZFFfwE6uGG8PYuBLrss/zUleDJWJvs+fEA5Hi2/IzmmuoS3PjwrkmO4MNIgCiuw8b+a0I3Mrqi+kbpeUQVtapmpaURVY1DQI8rwwYUpq3yNBzMXItG79NlnBgaLOMf6XAWrTA==;5:rr4auahdIN2VV8lxXopPOi+VFSEMdQyShhpMFML8SdzN5Y5DsgaKsu5U3CP1VYR73zg2q1mh+OSnNCVzOzNLbPx4ykgYOg2dWzKikCm/WQMdG/gLNq9AWSYoq6Zwj83lFFxp7df/JBSECLszmm7Q13mvfEQGzpQvMjjjdG6FigA=;24:DuWl/40HQbDODeCeW+6QSwoDCtU+pVvp1HgE7qbms1Vkjj789t0OWWUqJewXC7Hf5XAS9PI0RX6hTm5GlAwO2c2Qx8udj1+I7SCd3233elA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2781;7:Mo6beBV/uk/ciXF0WSLH1jtqVYok+ZvVHtpY7DyzxjwRwEdPKG6RS/RGh5tC2f9PiDNCEtk64JUxcXG5rmkpbIBIqlZUFdDVbNygXGtMCXTSK6RwGI46V8rEl7XrUVVjeVGAGe/lpW1rDe/lZWdskhm5ieSmnXW1RclazVCpdG+ac7wnGnkp/tcx0RtABr+YLCcocgIv0av9G/DhPAl2S9mrXRv+VTPXnsSJGF/NmW+NESqAs3wjsXNTXPOA2RvO
X-MS-Office365-Filtering-Correlation-Id: 330fe655-c007-4b22-0d6c-08d59faaa8b8
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2018 12:49:26.1215 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 330fe655-c007-4b22-0d6c-08d59faaa8b8
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2781
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new probe style for i2c drivers.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/iio/potentiometer/mcp4531.c | 145 ++++++++++++++++++------------------
 1 file changed, 72 insertions(+), 73 deletions(-)

diff --git a/drivers/iio/potentiometer/mcp4531.c b/drivers/iio/potentiometer/mcp4531.c
index 114ab876fcc6..df894af6cccb 100644
--- a/drivers/iio/potentiometer/mcp4531.c
+++ b/drivers/iio/potentiometer/mcp4531.c
@@ -209,6 +209,75 @@ static const struct iio_info mcp4531_info = {
 	.write_raw = mcp4531_write_raw,
 };
 
+static const struct i2c_device_id mcp4531_id[] = {
+	{ "mcp4531-502", MCP453x_502 },
+	{ "mcp4531-103", MCP453x_103 },
+	{ "mcp4531-503", MCP453x_503 },
+	{ "mcp4531-104", MCP453x_104 },
+	{ "mcp4532-502", MCP453x_502 },
+	{ "mcp4532-103", MCP453x_103 },
+	{ "mcp4532-503", MCP453x_503 },
+	{ "mcp4532-104", MCP453x_104 },
+	{ "mcp4541-502", MCP454x_502 },
+	{ "mcp4541-103", MCP454x_103 },
+	{ "mcp4541-503", MCP454x_503 },
+	{ "mcp4541-104", MCP454x_104 },
+	{ "mcp4542-502", MCP454x_502 },
+	{ "mcp4542-103", MCP454x_103 },
+	{ "mcp4542-503", MCP454x_503 },
+	{ "mcp4542-104", MCP454x_104 },
+	{ "mcp4551-502", MCP455x_502 },
+	{ "mcp4551-103", MCP455x_103 },
+	{ "mcp4551-503", MCP455x_503 },
+	{ "mcp4551-104", MCP455x_104 },
+	{ "mcp4552-502", MCP455x_502 },
+	{ "mcp4552-103", MCP455x_103 },
+	{ "mcp4552-503", MCP455x_503 },
+	{ "mcp4552-104", MCP455x_104 },
+	{ "mcp4561-502", MCP456x_502 },
+	{ "mcp4561-103", MCP456x_103 },
+	{ "mcp4561-503", MCP456x_503 },
+	{ "mcp4561-104", MCP456x_104 },
+	{ "mcp4562-502", MCP456x_502 },
+	{ "mcp4562-103", MCP456x_103 },
+	{ "mcp4562-503", MCP456x_503 },
+	{ "mcp4562-104", MCP456x_104 },
+	{ "mcp4631-502", MCP463x_502 },
+	{ "mcp4631-103", MCP463x_103 },
+	{ "mcp4631-503", MCP463x_503 },
+	{ "mcp4631-104", MCP463x_104 },
+	{ "mcp4632-502", MCP463x_502 },
+	{ "mcp4632-103", MCP463x_103 },
+	{ "mcp4632-503", MCP463x_503 },
+	{ "mcp4632-104", MCP463x_104 },
+	{ "mcp4641-502", MCP464x_502 },
+	{ "mcp4641-103", MCP464x_103 },
+	{ "mcp4641-503", MCP464x_503 },
+	{ "mcp4641-104", MCP464x_104 },
+	{ "mcp4642-502", MCP464x_502 },
+	{ "mcp4642-103", MCP464x_103 },
+	{ "mcp4642-503", MCP464x_503 },
+	{ "mcp4642-104", MCP464x_104 },
+	{ "mcp4651-502", MCP465x_502 },
+	{ "mcp4651-103", MCP465x_103 },
+	{ "mcp4651-503", MCP465x_503 },
+	{ "mcp4651-104", MCP465x_104 },
+	{ "mcp4652-502", MCP465x_502 },
+	{ "mcp4652-103", MCP465x_103 },
+	{ "mcp4652-503", MCP465x_503 },
+	{ "mcp4652-104", MCP465x_104 },
+	{ "mcp4661-502", MCP466x_502 },
+	{ "mcp4661-103", MCP466x_103 },
+	{ "mcp4661-503", MCP466x_503 },
+	{ "mcp4661-104", MCP466x_104 },
+	{ "mcp4662-502", MCP466x_502 },
+	{ "mcp4662-103", MCP466x_103 },
+	{ "mcp4662-503", MCP466x_503 },
+	{ "mcp4662-104", MCP466x_104 },
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, mcp4531_id);
+
 #ifdef CONFIG_OF
 
 #define MCP4531_COMPATIBLE(of_compatible, cfg) {	\
@@ -286,8 +355,7 @@ static const struct of_device_id mcp4531_of_match[] = {
 MODULE_DEVICE_TABLE(of, mcp4531_of_match);
 #endif
 
-static int mcp4531_probe(struct i2c_client *client,
-			 const struct i2c_device_id *id)
+static int mcp4531_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
 	struct mcp4531_data *data;
@@ -311,7 +379,7 @@ static int mcp4531_probe(struct i2c_client *client,
 	if (match)
 		data->cfg = of_device_get_match_data(dev);
 	else
-		data->cfg = &mcp4531_cfg[id->driver_data];
+		data->cfg = &mcp4531_cfg[i2c_match_id(mcp4531_id, client)->driver_data];
 
 	indio_dev->dev.parent = dev;
 	indio_dev->info = &mcp4531_info;
@@ -322,81 +390,12 @@ static int mcp4531_probe(struct i2c_client *client,
 	return devm_iio_device_register(dev, indio_dev);
 }
 
-static const struct i2c_device_id mcp4531_id[] = {
-	{ "mcp4531-502", MCP453x_502 },
-	{ "mcp4531-103", MCP453x_103 },
-	{ "mcp4531-503", MCP453x_503 },
-	{ "mcp4531-104", MCP453x_104 },
-	{ "mcp4532-502", MCP453x_502 },
-	{ "mcp4532-103", MCP453x_103 },
-	{ "mcp4532-503", MCP453x_503 },
-	{ "mcp4532-104", MCP453x_104 },
-	{ "mcp4541-502", MCP454x_502 },
-	{ "mcp4541-103", MCP454x_103 },
-	{ "mcp4541-503", MCP454x_503 },
-	{ "mcp4541-104", MCP454x_104 },
-	{ "mcp4542-502", MCP454x_502 },
-	{ "mcp4542-103", MCP454x_103 },
-	{ "mcp4542-503", MCP454x_503 },
-	{ "mcp4542-104", MCP454x_104 },
-	{ "mcp4551-502", MCP455x_502 },
-	{ "mcp4551-103", MCP455x_103 },
-	{ "mcp4551-503", MCP455x_503 },
-	{ "mcp4551-104", MCP455x_104 },
-	{ "mcp4552-502", MCP455x_502 },
-	{ "mcp4552-103", MCP455x_103 },
-	{ "mcp4552-503", MCP455x_503 },
-	{ "mcp4552-104", MCP455x_104 },
-	{ "mcp4561-502", MCP456x_502 },
-	{ "mcp4561-103", MCP456x_103 },
-	{ "mcp4561-503", MCP456x_503 },
-	{ "mcp4561-104", MCP456x_104 },
-	{ "mcp4562-502", MCP456x_502 },
-	{ "mcp4562-103", MCP456x_103 },
-	{ "mcp4562-503", MCP456x_503 },
-	{ "mcp4562-104", MCP456x_104 },
-	{ "mcp4631-502", MCP463x_502 },
-	{ "mcp4631-103", MCP463x_103 },
-	{ "mcp4631-503", MCP463x_503 },
-	{ "mcp4631-104", MCP463x_104 },
-	{ "mcp4632-502", MCP463x_502 },
-	{ "mcp4632-103", MCP463x_103 },
-	{ "mcp4632-503", MCP463x_503 },
-	{ "mcp4632-104", MCP463x_104 },
-	{ "mcp4641-502", MCP464x_502 },
-	{ "mcp4641-103", MCP464x_103 },
-	{ "mcp4641-503", MCP464x_503 },
-	{ "mcp4641-104", MCP464x_104 },
-	{ "mcp4642-502", MCP464x_502 },
-	{ "mcp4642-103", MCP464x_103 },
-	{ "mcp4642-503", MCP464x_503 },
-	{ "mcp4642-104", MCP464x_104 },
-	{ "mcp4651-502", MCP465x_502 },
-	{ "mcp4651-103", MCP465x_103 },
-	{ "mcp4651-503", MCP465x_503 },
-	{ "mcp4651-104", MCP465x_104 },
-	{ "mcp4652-502", MCP465x_502 },
-	{ "mcp4652-103", MCP465x_103 },
-	{ "mcp4652-503", MCP465x_503 },
-	{ "mcp4652-104", MCP465x_104 },
-	{ "mcp4661-502", MCP466x_502 },
-	{ "mcp4661-103", MCP466x_103 },
-	{ "mcp4661-503", MCP466x_503 },
-	{ "mcp4661-104", MCP466x_104 },
-	{ "mcp4662-502", MCP466x_502 },
-	{ "mcp4662-103", MCP466x_103 },
-	{ "mcp4662-503", MCP466x_503 },
-	{ "mcp4662-104", MCP466x_104 },
-	{}
-};
-MODULE_DEVICE_TABLE(i2c, mcp4531_id);
-
 static struct i2c_driver mcp4531_driver = {
 	.driver = {
 		.name	= "mcp4531",
 		.of_match_table = of_match_ptr(mcp4531_of_match),
 	},
-	.probe		= mcp4531_probe,
+	.probe_new	= mcp4531_probe,
 	.id_table	= mcp4531_id,
 };
 
-- 
2.11.0

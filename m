Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753238AbeDKMtb (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 08:49:31 -0400
Received: from mail-he1eur01on0136.outbound.protection.outlook.com ([104.47.0.136]:41568
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752944AbeDKMt2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 08:49:28 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Subject: [PATCH 1/2] iio: potentiometer: mcp4018: switch to using .probe_new
Date: Wed, 11 Apr 2018 14:49:14 +0200
Message-Id: <20180411124915.9587-1-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR0701CA0087.eurprd07.prod.outlook.com
 (2603:10a6:3:64::31) To VI1PR0202MB2781.eurprd02.prod.outlook.com
 (2603:10a6:800:da::19)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:VI1PR0202MB2781;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2781;3:vJ9Ft0EvKudbm1mKRP9lnvrLO9ftjRt47w/vFXYTG2KZgM6DduAyTZMzI3mUI2Qm2gEaIThBUoXN9ZcuW7Y+AhNN+3ql9Q8eEUnaQe0TXjRI9IK3++hQLvRRohU1fF3LnyIH3Vf1LlTRJ7FDhgvuc+84zxPq/A00YMCjmv+LTVE1tmum+1A6fHmV6OqfHjBf5GOrT6FsT2GbzrntIAk9H69+lBwYpoZa06FGUpzXJ/yiorYa+xfm8hkXWEGyN2q7;25:A2TAhocLXDMGoWKMRNe7Y5vBQh13c/HdmmR5hjlRSdoLHCg2VzT7I1tmTcnNWNUpGkjPSyx4WBN2j8w7oTB8z1VAAXC1XoZoPFWpbqhkBrqnXv7IUQ1Qcgbk1LZCp9b3jY7R3af3RtbJrAQ0lyY+/ZyaIT8YU6fHGqiZX1o3VNeRuVd5afJZtORmYzK+ykmLLHDwNr8QCA8AjqMT8s3+dXdI4wkSNxESbvdzd5+CkoL840RhLKEVLmCpm1XH4LqSyt2O/TpKIFIbaH4QRCXtZ6PUwM/euyEf/E9YCcY3jkqafguEfyNBaMWXenoRv9p93sFiCz87inuPEKxQpNXO6w==;31:kKUJ28KJVO4n/kJRJB8qnkOkpaAMLNFmj4bWbpPxRwedUjxWwB59WgD4T5Ph0OFC519MLK0Gg9Oma57qnDlwrHRogm3rgEds+ugsaSXIbiVwzcCIoUKpD7Zn1H1n70uwJbhCwK+oaPDrc1oohZdoNaMELMnrD6qtrgYTkbCBoj8DrRwy6tPAAi2jMJ9ZcS/QMtlSZbrP1EscTPQiXifFEvFKZtp2Ps4FIJ97nL6aPIc=
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2781:
X-Microsoft-Antispam-PRVS: <VI1PR0202MB27816E02EC7CAAEFDFF507D4BCBD0@VI1PR0202MB2781.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(6041310)(2016111802025)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(6043046)(201708071742011);SRVR:VI1PR0202MB2781;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0202MB2781;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2781;4:L2s8xC2kA6WeNAHHqFKQT9B2RFnYoC8n5oJKwVKcZPXOAZ5anORlODBzw3cD12Q+7IiMml0Trm3vq7Ks278kU/TQWHNGD6V4/rtAe6fD4NuHHIJycmG/+YJWsqUKHJF/a8gqzHjsn+lYAVRkNE3kNyPCNzTGKSXeVvoqqh0Ps21cYk9wrlaDv9cfwR0+na8n4+EB1cNfeO4UgBhoDBZjBZmP6aAEo0i2MR4NgIRkmgQrDwYGLMqlcfeZJsGLGnwQeQBvJOun7/9IVQ9UJ+yzqQ==
X-Forefront-PRVS: 0639027A9E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39830400003)(39380400002)(396003)(376002)(346002)(199004)(189003)(6506007)(74482002)(6666003)(8666007)(6486002)(68736007)(6916009)(478600001)(105586002)(386003)(51416003)(16586007)(186003)(54906003)(2351001)(53936002)(25786009)(52116002)(26005)(16526019)(86362001)(7736002)(2616005)(956004)(486006)(48376002)(2361001)(8936002)(4326008)(36756003)(81166006)(316002)(81156014)(8676002)(97736004)(1076002)(5660300001)(2906002)(3846002)(66066001)(305945005)(6116002)(47776003)(50466002)(476003)(50226002)(6512007)(106356001)(142923001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0202MB2781;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0202MB2781;23:hf9VLfsqnAP0xRB5I9TWnqE9Xw40PbBODp3UHFx?=
 =?us-ascii?Q?MBeIPtbCnt3w1obYm4wDVe/8aatH/zAnnL0+NmlvYKwNOrDZV8NUjrKcfExJ?=
 =?us-ascii?Q?fNQvJphfCrdmlOKlCHQ99Avlb2DxdTzGCPm67TcIWlTN2IuLFB75LCyK97pG?=
 =?us-ascii?Q?eG9u8EHcMuwXHQ/n/lqoYcm+Tr2iIyd6fGYT/y+JxYRi8olzX0KSJasrdiAx?=
 =?us-ascii?Q?af2Wo0XnAvTVJo2pvpZBsmr3swOxRqVpliiNb5nKv1+LXCl+y1AJruCYlcnI?=
 =?us-ascii?Q?VEL2F3mPsy6vRVinxovdsoWqAXi5ucl1t0pA8M/gZYGJTMWW8elXKOdgJFY6?=
 =?us-ascii?Q?2RfIuA9ax0BvALaxD6CX3AfqoQlhNCbdj2LVbWB1e0+KGLJbSRFTcYB2Mecl?=
 =?us-ascii?Q?xXdkgDAPLQA4vXIe0JumRYYoQ149U8wD4Gu3JEqk+Y+bqK2z/Gg3YsGlTXsf?=
 =?us-ascii?Q?Q9W4E4CXWJ7VM/4WgzvrI7HshffdB3+ClA6g9tfhngw/AHyHG1w235AH/xbu?=
 =?us-ascii?Q?yDnL/FvNHeI3g6/PKUFt/9/befsnhnu8cLmHo1B1gaZoF4f4TLs/eVRvfWLo?=
 =?us-ascii?Q?lqBmwNd90g901GrJAhy1VkhLZyDPU/AW2ZZxFvX1q9KmRi8U2uaWMWgx89gl?=
 =?us-ascii?Q?zlDKkTvpbfvmYnCQ86HlNtxUyA4jbJLt5wCDSNTJR5uFKi5yIAJH/0OvdWVM?=
 =?us-ascii?Q?xrQknbjxYE9xUKJPj8aN/sCu3oWLebTrkcJ2T5QS+COiPnFsCRlCrkSrxeC+?=
 =?us-ascii?Q?UOOfx+0pfN5Gw/l6eWhmFliu+BW04fzU4TIn07aWmIMM1Am7u3XQSvhNQMto?=
 =?us-ascii?Q?V+EBO9kVmzdayInUXuGKFmSrXGwmkF9eEkbh0j0iV/9xqbZASQg35xZrGsnS?=
 =?us-ascii?Q?G1SimhWQP8v/W0Cv/rqRLsq+cW5uTuDKmWXdM7yaKC40WKCEXlQjBkyWlD7b?=
 =?us-ascii?Q?+B1zF/6ZFjyHt5vGX+r6/TN4NQqYqdesrG9sPjHKyxldueqblcKucyYVje7r?=
 =?us-ascii?Q?N0stCz1fHXbI10Fz+HvHxp+G8Q48QniC6fknOI/qeFhQyj5yvC3SchaKQ60s?=
 =?us-ascii?Q?VUmJ9umQKWNh0aBqpWCu7oqziDw9QUvbT3B5QaCTQOCDsjpSKlsLoCsint/e?=
 =?us-ascii?Q?43uErNRJ9JsmKiqQcSwBwaMEkHPyg05nZ6OEkJjzKQSwbKzSUITCZRJR60g9?=
 =?us-ascii?Q?uY/18zpiD48/7wRy/GzQJSwfh2fX1K/4aQLayiI+5iQ86UY1CD++OvpFDNYp?=
 =?us-ascii?Q?DqNcxS+QQnInt0aiYEh+VRQecMLca8NT+RTq7t/cgzsXiWuqpnPpULqsV4Nd?=
 =?us-ascii?Q?lEQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: 5UsyaH4jJOf3cnwoSDpC5d7gP6nBlhmAUzurlp7GTub2Z1ZI+DKcoiUM7DQa6YS5PWDfpmleS71LMsr2sUEZ6e2AgNUumvg6M5rAt2j5kPo71RYMqqP8hqVuRssZDkuF+HGXzGAv/P3KWEvo4DcuUlWdmpluBtD1Z5eNEAnnWD3MihWe7q5p0sw12XiTz//I
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2781;6:QbBy1SOGanx64qJPSVgcxTfmfLuYshjmhl6icUB0pfIFDNtSBgdj58fqmhZMVT9DWOTtRRbRAw0FFTqBDI5ABf1nigJnwRpjrs/EbIvVYtHVkHngSesrd2R3WjiHvA6Mn9a5ydd+Wat7q0RGvBWG3zdtRDGFxXUoJjDviRssEQ53V/+rjp7c+B/Ayyra0htCMrKrt1kZZmOF1O+1hvQNGffulTJY24ITtyGYFi/VlOh6C0Az9jEfHdvYKEcTeHkvagr6qgGAEVWfR8VaXlxf+iQHzpTOf/hJ21Nmoav0CqIrl6JIpMU0Kli8zkIX6UpaVEj7a8k8GBaXE7h1UBxkKQQ10ENtqvUHOacrHgLLFHBCTnwVLVIgaGCBJ0bbEAsD1OQ7zB/3IXPg5WJMo2Bp1klX2m/+be+4R0Sc/9DrrlB1Wncwar6EIpCt463DSVqoSKi87w0sCGECeN7p8GYQeA==;5:kZzgV8QjmLLH+WsZf6xOfVf+JeKVHTHhZnAY3zerTobIewjgtgdwup6Ef5uGW1hrHd54GQz60ZNLIEI7vH5bxHsEix0NUP/lZQiWKZJTGqX9wPeEXrf1AnfYoT6YTYpcJ0sZygcDILwufwVE4Rh0L+gJopcOUe4V9vr9bZtGfL8=;24:WC2VANJo8Y75lwYZXEjbUwQN/9Oz56D/EShwpGnnaGu2AZ0DCIqGKmuqFwnZ9JLQ0szxUWwozDP/Bh7f+1a12arO74GmBkle/Bn5P1Y5pzo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2781;7:HljKv4QuZqsO+1uHs2cOBxbd/WN/6oR9m4aWZyBhOnSQVzxYDfUiEfez4U8iaoWIvMDPCRoFrVn2K96qiw4xb0Cuh2eXP5nj3FNecWulKxCvR1+oSX/JclTRnffzJBs3oLjP7t2EqqC5eZwsJLhUvjmAe0AumHoM9Hg5BjfcdjQRjt3RkZYzjjLdmUZXPiw26r71rqaIFInL5JYIoitq5+EjMIGh+GSCgeCHGh9PDtGPaLSlgvHHCQJHYlH6+BV4
X-MS-Office365-Filtering-Correlation-Id: 66eac798-744b-4a7c-f56f-08d59faaa75b
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2018 12:49:23.8559 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66eac798-744b-4a7c-f56f-08d59faaa75b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2781
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new probe style for i2c drivers.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/iio/potentiometer/mcp4018.c | 41 ++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 21 deletions(-)

diff --git a/drivers/iio/potentiometer/mcp4018.c b/drivers/iio/potentiometer/mcp4018.c
index 601b25d1f387..320a7c929777 100644
--- a/drivers/iio/potentiometer/mcp4018.c
+++ b/drivers/iio/potentiometer/mcp4018.c
@@ -99,6 +99,23 @@ static const struct iio_info mcp4018_info = {
 	.write_raw = mcp4018_write_raw,
 };
 
+static const struct i2c_device_id mcp4018_id[] = {
+	{ "mcp4017-502", MCP4018_502 },
+	{ "mcp4017-103", MCP4018_103 },
+	{ "mcp4017-503", MCP4018_503 },
+	{ "mcp4017-104", MCP4018_104 },
+	{ "mcp4018-502", MCP4018_502 },
+	{ "mcp4018-103", MCP4018_103 },
+	{ "mcp4018-503", MCP4018_503 },
+	{ "mcp4018-104", MCP4018_104 },
+	{ "mcp4019-502", MCP4018_502 },
+	{ "mcp4019-103", MCP4018_103 },
+	{ "mcp4019-503", MCP4018_503 },
+	{ "mcp4019-104", MCP4018_104 },
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, mcp4018_id);
+
 #ifdef CONFIG_OF
 
 #define MCP4018_COMPATIBLE(of_compatible, cfg) {	\
@@ -125,8 +142,7 @@ MODULE_DEVICE_TABLE(of, mcp4018_of_match);
 
 #endif
 
-static int mcp4018_probe(struct i2c_client *client,
-			 const struct i2c_device_id *id)
+static int mcp4018_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
 	struct mcp4018_data *data;
@@ -150,7 +166,7 @@ static int mcp4018_probe(struct i2c_client *client,
 	if (match)
 		data->cfg = of_device_get_match_data(dev);
 	else
-		data->cfg = &mcp4018_cfg[id->driver_data];
+		data->cfg = &mcp4018_cfg[i2c_match_id(mcp4018_id, client)->driver_data];
 
 	indio_dev->dev.parent = dev;
 	indio_dev->info = &mcp4018_info;
@@ -161,29 +177,12 @@ static int mcp4018_probe(struct i2c_client *client,
 	return devm_iio_device_register(dev, indio_dev);
 }
 
-static const struct i2c_device_id mcp4018_id[] = {
-	{ "mcp4017-502", MCP4018_502 },
-	{ "mcp4017-103", MCP4018_103 },
-	{ "mcp4017-503", MCP4018_503 },
-	{ "mcp4017-104", MCP4018_104 },
-	{ "mcp4018-502", MCP4018_502 },
-	{ "mcp4018-103", MCP4018_103 },
-	{ "mcp4018-503", MCP4018_503 },
-	{ "mcp4018-104", MCP4018_104 },
-	{ "mcp4019-502", MCP4018_502 },
-	{ "mcp4019-103", MCP4018_103 },
-	{ "mcp4019-503", MCP4018_503 },
-	{ "mcp4019-104", MCP4018_104 },
-	{}
-};
-MODULE_DEVICE_TABLE(i2c, mcp4018_id);
-
 static struct i2c_driver mcp4018_driver = {
 	.driver = {
 		.name	= "mcp4018",
 		.of_match_table = of_match_ptr(mcp4018_of_match),
 	},
-	.probe		= mcp4018_probe,
+	.probe_new	= mcp4018_probe,
 	.id_table	= mcp4018_id,
 };
 
-- 
2.11.0

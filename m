Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753447AbeFDOWq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 10:22:46 -0400
Received: from mail-by2nam03on0076.outbound.protection.outlook.com ([104.47.42.76]:19632
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752222AbeFDOWn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 10:22:43 -0400
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
From: Stefan Popa <stefan.popa@analog.com>
To: <jic23@kernel.org>, <Michael.Hennerich@analog.com>, <lars@metafoo.de>
CC: <knaack.h@gmx.de>, <pmeerw@pmeerw.net>, <linux-pm@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stefan.popa@analog.com>
Subject: [PATCH] iio:dac:ad5686: Add AD5311R support
Date: Mon, 4 Jun 2018 17:22:07 +0300
Message-ID: <1528122127-1911-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(39380400002)(396003)(39860400002)(2980300002)(438002)(189003)(199004)(4326008)(5660300001)(106002)(2906002)(106466001)(26005)(126002)(486006)(2616005)(476003)(8936002)(50226002)(47776003)(6666003)(246002)(8666007)(1857600001)(6306002)(107886003)(336012)(77096007)(16586007)(186003)(44832011)(2201001)(54906003)(110136005)(316002)(51416003)(575784001)(7696005)(478600001)(426003)(36756003)(966005)(48376002)(53416004)(356003)(72206003)(8676002)(7636002)(305945005)(50466002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR03MB3420;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BN1BFFO11FD024;1:TkvWdPOOAW4eoP5SksSfaAMPME96hqE7JOa//Y1P/KhHCgOyjlfCLb7qP6YsJKfClCypl7/PQ+lm3ev+JzsP3jQ+BvFCnZpMZ0MbG8oL0lzkBke9rHyyOWALKCB4VwmB
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:DM6PR03MB3420;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR03MB3420;3:+KXT/yfWB0vrJe4RQh0qvB4D5Slo2Nky46DULBXeqApzeij4qMJBnhT6ZtCDsRDRUIckww+TyqW1CGGXt+xGuUaMMGfsVV1g0q7H+z8ooYstCa9OexeU3V/gtru60ceSrZN82hL4yVVGuHZGQ6kWfPBpfPsMwWrUny3wWYy4P3FIkimbpg/STc3/B5/Z1Lmv/4wH326C/3y7tNvg0/sXuYCqjpSf9IZ/5xZViGSek5hfG+ZWlbYFvm6cqBjIqtIrp7zxScJcvwYsLblIh59ykHMH6ldD0Q2J1nD9rXozMt1TxMpuLckd9TKX6g4V4r3nh6fetDKlG52tf+ylnMyIwwxFRee6Tnn2kEA59kGhHtQ=;25:FyT97oOvw6e3hSOwHhJ159UXQEywvEt+13GLZffPiOtrwK1bMbe95ksvHhWqU1pwF6sEibEtHLrBf4EJW4Zl+YKPzXYisC9+V9C887gll3LEoBfSMQu4NMC+rtr73erA5Iuhbu1usTA1l4Vvab/UL63G7hdbjVFAtdR6OWB1kw7n8ueLPkOnTZ9U7Y/OdB75avwW422yi5Je59SkK3tp7fdy0XnUebxCjcXguogEbJS2ZswFw22X9n973IAA4/A0KOhL4Yjgricp/n+Gxd7qWtStHj9jWihQfG0Xd49wsshMURGUxrHVePm4p0rRBpodKyBTQgME8wAC3TAfVsCVXw==
X-MS-TrafficTypeDiagnostic: DM6PR03MB3420:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR03MB3420;31:PaLQESUl35+RiB4ltAveYTv9SXN0yk48KCX/6FWVyn/Mj8uoIsnoATz7IkfgMa0A1Ed1DgrpKC2Zl1j0BG2IIeVzez2ruGYWc16hsk4TBW97jigpfI9RCk4uFaN9S5aB5sdqAlrcqwcHPIEISG1ha4aDABcZ9vPOoYGnMXmC165ohohuzDl1vjsTzjcPKyg9vuBYLcYl4Qg6+diWQg+NImJfQL67+16Ti8quAPXzwdw=;20:ITv4Jn2JkedCmoVqN4LCApvHDcQbyoHs99IFqGH8u9KfU+wUeG8BB0k4R5D81USSp9u++xXHWNQCZayZxFkyn6Eb36bT18/THR9The6RGJy8Jpe/UVGz0RXGP2WWh1iRXPfNSaDIxlksPsEgbisGam7CV3MwTLGY/d40xtxe5Bbg89w36m+yjF5V2+fc5pXenbUcwUpPVDjuRCHEOqf9e6uJdmuUEgV6hSAcbgg5PEnwqpdxr+67E23/hS/Fnut9OJT3t2xT8TYmuS5R8dfKVe1dc3fSdECISuxow6IfwGaoDsbtLPSWdY+c/E+toxb8f4+kMuRTKX7Ta/dM/HigmrrzUsShOl76lJu360VgyAbsd/86yWvqHyurJTewRoMOS2GSRVIigmLaIXonnkIRT0NygfTS30QPVUOQafvvKEvKzVamOKisYTFL1OkrjCMY5DyzpTHvda9UV7CJHExQ0SAGBxjd6fqwA/XyXlE8FIit2a70PWW9rR2B+Rqmn26N
X-Microsoft-Antispam-PRVS: <DM6PR03MB342064E91C2FB0B340A4DB0F9D670@DM6PR03MB3420.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(270121546159015)(232431446821674);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93004095)(3002001)(10201501046)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:DM6PR03MB3420;BCL:0;PCL:0;RULEID:;SRVR:DM6PR03MB3420;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR03MB3420;4:Yt4Y0VndnfIPmOQF0G6hDBZlovqH3yKky0Cic6OeevKJ6YNgp7UHj3dhCbHmczrdTbOy5860W7L+EAPAgH82kCT0YmJRHVw8IZ7tlPIuZHf6pUGIDcIqpLrYB+FFDCZQrGm37leEVbVnE5lgSnoshvsR12rujXQIzgv01rRKSlsA0DVpdS3PD2EJSO90lD1NB6u3PhnL8C/qAzzAHYniDFTdNeGQ9NNTPOnU7aSuag2q2epb/4ZCdIoz13nOiFSfeGrgFMvOQwYNO3RkqsRgWWBMXD/uRyBiB3idk7pfzzL5HawIGNAJyQrZSqPY4/0hOPU1/sPJXf8dLx0mXHUgbqXbonY/meCG9/9e+Dwb8xw=
X-Forefront-PRVS: 069373DFB6
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR03MB3420;23:LfCqui5YOY+4PgtvY5BhbZMWVU6K7fC62VyyQJ8uy?=
 =?us-ascii?Q?r759akybgDHDGsTI35n3ZzfBzqpNma9gDZ4dDwWG3eG0a0wa83Jaas56RVPv?=
 =?us-ascii?Q?3UTt4tLqJiYeFY8zk+xkzmLPzPdUBCXyXCPLSmL/5BHDxcMNd362gmiOiuoh?=
 =?us-ascii?Q?sRYX0fYlEgtj+7wikA6vJmZP/t1LQIYl1M3T5jujmtjzWUDwWZuFmPgHjkkt?=
 =?us-ascii?Q?jhOXkhqumsZKviqJbF9qOqhvvbfk3CfC76n3iPt2TcAW4E4TWOZFbkWmTKPe?=
 =?us-ascii?Q?7nXrk0nT+ut6Y4zgj7o718nrrJ5c5TYxgEeYfA7ubl5JbTk4JAHvBkrBMrbk?=
 =?us-ascii?Q?gq50iRdJcY3KRk3L+UBNs7fE0zR5JSfKpxnn2cqOkNz/0VdaysdQYU90yAV6?=
 =?us-ascii?Q?725lYATRgr/WTJXLTreUh9yfaIhEZd2L+hD4YFc4CgQ6q/zCPgQAHTROT5k7?=
 =?us-ascii?Q?pQZFbrO6qqHhjLevrv5wdtfBXNCy2WBp8JcmSBhNnMOVco0yoZ9eAnMeWMgi?=
 =?us-ascii?Q?CFmvORcI675a5vKW5YXw8b8S+HdoEaoydPv2hyVDl02Pfe+9+OFKU0bcxpOC?=
 =?us-ascii?Q?QD2cssI+x77r3/fImnARyIJ8q57c+Nhc4sfpJcpTsjhqWTd8vl7UqtB+z5xR?=
 =?us-ascii?Q?9lIZXzksYayJX92nxmJaRLgno6XdItWbTMI8sAYrlabsmn4/dp4CN3jTeApF?=
 =?us-ascii?Q?msVpviSVevSGUPeeyONqzBbhlTdbvHXRcE6q4+5y9Cbr7uFAH9ahiJTLrf5J?=
 =?us-ascii?Q?XlNqosc5AZBCyWqQ+uiloMfrWfCafL+HgxCVz5s5Er+TrJQdWuU4WdPAcTqg?=
 =?us-ascii?Q?309LAVJ4YlfTH0IbDRMg1KiwS5AZpwuqlEHjcjNnab588ZsrNVI8J4a9AovF?=
 =?us-ascii?Q?iOBrWfdlUT+3o+DYI9fzMKdGGuhXuzWH3EKeXqEt1qekdpQgMrulZjB7wMk1?=
 =?us-ascii?Q?9nRaz/e9JUUeAY7VZHFWJWx21yq2seTQdj/0OW3HaVpVA2GD0yAhipy4AaMc?=
 =?us-ascii?Q?Gl1StQJToPdFB+Y8snSNHPEYn68SM1uHRuEUrlE1CzApgR4RUeLtR6r9vRxJ?=
 =?us-ascii?Q?JWNPjkEkscJj87DWf5wEvXlJZfsJJTrup0ECqgQPLSsZIgEo/5GVh/+b2g9b?=
 =?us-ascii?Q?RWfxnbTe5hcJLCXqANxvjDZ6QY08Vd6PwIt7Se5Tll8vWyyoCrnjw=3D=3D?=
X-Microsoft-Antispam-Message-Info: Od+hk1n7tmiEUlMylfh1DUYTFuBKuSzwbFscDCYLm5FLl4FBZtQeUwYnHvS50BSikWP0QrodrAYwYyEpqZFgxSV5Q52V4YA31MHjg8jl0LDZCY9vV8mvNrGP5gBWxU6p4Egjz4rp0s+5lhMm4SGZ1W+aqU/ovGpjaYTemdxjjjrUwr4k01j7eYRu6hi2W1VE
X-Microsoft-Exchange-Diagnostics: 1;DM6PR03MB3420;6:7i9pyIYlDnbXVqMgYZbAB8Qfjypyj698cD5HhwORKXVycKLadClHT5w6NfSFf0FKzhGv0X0wbDX7GFQFkN/DWDH3WZ94z6oooJk8i4B65f/jfSrjJjqe8FjI2WhjikgpzOKw3+OoPdo8T/gjoARaeWjPtdhGnLUfaDH4R+JNlOOl5nAi9lBsq4ChTzCpDsazF5QrbbLyTR2Gtm+Vz6XGz4ko6CJKEPQJmjmsTESM+/fcdUoszSGYCgxPdWYDGZ68NfSQeYOXx/prJBiUoGRmYwmstLc/wkMa147TA9QBZbXGDZp1lDoKi9XvQH4vy1AC0ai6V7xmZ5+n9zSQxx6vpTa3PWLpHRyODfoQuNwNEz9qBwYHw9PXuUSL4sgxvVQIEWaVNpDylZmEQQvWWkZHQudJ/jxQFM6BrAGvV6XBw4zmEyqglJjNrsahK35YEAaT0i4UXWPQkmXwIrEbQvKUJQ==;5:S4VHNU4YQgXEQnBZwOZi7KYL3yPd6F9Fhri37c5/jAwKyQVuL9vyiSToB+hJGFNKz83zLbodYxfcubzR0tmQGssOzqsLPmqjWBvHMUP++Uoj877t3XvEXHmn61xKC7fdk/UYeVUO+MJGLqbs8CH+YdwrG0zOFIP8I7nHLDywqIM=;24:TCwa9qN7sN+pl5FDSV7wCjYazTxElW6vpDiZAB3uhZ646vInlLiqE6My6meZKgpcKzpu4APwzl0Y2zSM4PSEc44IvG06qD20toC2PAX63SM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM6PR03MB3420;7:md5hppDWKGKq09oWwYqiip9hrtfMZU1vgtrerB3uELozPQjYXjO1C7h3eN/FLEJX5jvRN1iikR9oa2nukrQKONVY+79q+NHzYxeYs8FCi8lazi7B9RKzck1wYKWm9PQlz1HSApkUnU/J3nlPZFMNhMnJxRoQ3ncBw9PhpGoE3ZBFsrhI/iPR2YDObZvQq98HWUJrsK4/Db0Hqfp9uWVS/3JCPuEAHJ0d0JvMAvdbX77Y69gYP4cX9WeERk+cKqvm
X-MS-Office365-Filtering-Correlation-Id: e197a150-ab4f-4d75-4205-08d5ca26a214
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2018 14:22:41.8349
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e197a150-ab4f-4d75-4205-08d5ca26a214
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB3420
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AD5311R is a single channel DAC with 10-bit precision and i2c interface.
The device includes a 2.5V internal reference which is enabled by default.

This device is similar to AD5691R/AD5692R/AD5693/AD5693R, the only
difference is that it has 10-bit precision.

Datasheet:
http://www.analog.com/media/en/technical-documentation/data-sheets/AD5310R_5311R.pdf

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
 drivers/iio/dac/ad5686.c     | 7 +++++++
 drivers/iio/dac/ad5686.h     | 1 +
 drivers/iio/dac/ad5696-i2c.c | 1 +
 3 files changed, 9 insertions(+)

diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
index e136f0f..2ddbfc3 100644
--- a/drivers/iio/dac/ad5686.c
+++ b/drivers/iio/dac/ad5686.c
@@ -221,6 +221,7 @@ static struct iio_chan_spec name[] = {				\
 		AD5868_CHANNEL(7, 7, bits, _shift),		\
 }
 
+DECLARE_AD5693_CHANNELS(ad5311r_channels, 10, 6);
 DECLARE_AD5676_CHANNELS(ad5672_channels, 12, 4);
 DECLARE_AD5676_CHANNELS(ad5676_channels, 16, 0);
 DECLARE_AD5686_CHANNELS(ad5684_channels, 12, 4);
@@ -231,6 +232,12 @@ DECLARE_AD5693_CHANNELS(ad5692r_channels, 14, 2);
 DECLARE_AD5693_CHANNELS(ad5691r_channels, 12, 4);
 
 static const struct ad5686_chip_info ad5686_chip_info_tbl[] = {
+	[ID_AD5311R] = {
+		.channels = ad5311r_channels,
+		.int_vref_mv = 2500,
+		.num_channels = 1,
+		.regmap_type = AD5693_REGMAP,
+	},
 	[ID_AD5671R] = {
 		.channels = ad5672_channels,
 		.int_vref_mv = 2500,
diff --git a/drivers/iio/dac/ad5686.h b/drivers/iio/dac/ad5686.h
index d05cda9..57b3c61 100644
--- a/drivers/iio/dac/ad5686.h
+++ b/drivers/iio/dac/ad5686.h
@@ -45,6 +45,7 @@
  * ad5686_supported_device_ids:
  */
 enum ad5686_supported_device_ids {
+	ID_AD5311R,
 	ID_AD5671R,
 	ID_AD5672R,
 	ID_AD5675R,
diff --git a/drivers/iio/dac/ad5696-i2c.c b/drivers/iio/dac/ad5696-i2c.c
index d18735d..7350d98 100644
--- a/drivers/iio/dac/ad5696-i2c.c
+++ b/drivers/iio/dac/ad5696-i2c.c
@@ -71,6 +71,7 @@ static int ad5686_i2c_remove(struct i2c_client *i2c)
 }
 
 static const struct i2c_device_id ad5686_i2c_id[] = {
+	{"ad5311r", ID_AD5311R},
 	{"ad5671r", ID_AD5671R},
 	{"ad5675r", ID_AD5675R},
 	{"ad5691r", ID_AD5691R},
-- 
2.7.4

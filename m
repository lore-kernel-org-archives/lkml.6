Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752247AbeC3N4o (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 09:56:44 -0400
Received: from mail-by2nam03on0085.outbound.protection.outlook.com ([104.47.42.85]:53671
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751250AbeC3N4k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 09:56:40 -0400
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
From: Stefan Popa <stefan.popa@analog.com>
To: <lars@metafoo.de>, <Michael.Hennerich@analog.com>, <jic23@kernel.org>
CC: <knaack.h@gmx.de>, <pmeerw@pmeerw.net>, <linux-pm@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stefan.popa@analog.com>
Subject: [PATCH 2/3] iio:dac:ad5686: Add AD5672R/AD5676/AD5676R/AD5684R/AD5685R/AD5686R support
Date: Fri, 30 Mar 2018 16:55:18 +0300
Message-ID: <1522418118-11810-2-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522418118-11810-1-git-send-email-stefan.popa@analog.com>
References: <1522418118-11810-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39380400002)(376002)(396003)(346002)(39860400002)(2980300002)(438002)(199004)(189003)(8936002)(8666007)(5660300001)(77096007)(26005)(76176011)(478600001)(50226002)(106466001)(336012)(106002)(6666003)(6306002)(48376002)(305945005)(47776003)(2906002)(186003)(72206003)(356003)(51416003)(8676002)(110136005)(316002)(2201001)(50466002)(486005)(476003)(486005)(36756003)(126002)(16586007)(54906003)(966005)(426003)(49486002)(446003)(2616005)(11346002)(4326008)(7636002)(246002)(107886003)(309714004);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR03MB2186;H:nwd2mta4.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BN1AFFO11FD006;1:8ZJNDqfQli8cQeyrPX1Pph9MLQUpSxyvUbBBfdYmhtv650SnnhuZ5I2UYRx2GZvkEP1c/JyDDA/EHpM4Qx2ZfpmhFDjbkhjuPEUU8kN7YQSGeinqS9q8xBdjNJkThV3/
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a0884ee6-4ba3-479f-813d-08d596460e16
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:CY1PR03MB2186;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR03MB2186;3:+8igk4OqmbprhrLwOPU9YlWpjpivJrAo+GbrSWGg49fko0jfwaUAFoV1XBxt+ApFNGXXpBWLjNzYfG1FtxAV4bgala1phN4RyVYriMPFxFUruLwygzLatir3rMKslVSGF67qOtyaYMokRfTsNJE4lIkxMZh4GM0p7i6YcfKvUmvHCufswYXEr73hyE4hxMm4E4XXe36mDZ3sa3lq3JRN0Bphy4C+BgFdSUM1TKqSxPfhpePKExnDcVE9b+dQrmOqwKwSq4CLF7WdzF6kXI4UMT3HbWAK3LYCiQ+VhMKpfo1AbFihBfPDanNWPBEkiQLBGHSNNKOZRIOOEBYXyiUXZL4uTe1oYURp/3LliEVAdio=;25:EZ5IGS0DKsCSWuHmkoPBwlwnldV6A3uY+YyQEidocgZNbXUA3nD1fODXRpPqMvEUplouvTdZzm5pc0QcgC73jj1kHA1FAZiirsn6OY4UrTjkB7MjfSG+fuBxWpfG1tNkNP/OgIx/O9K+x9HGszJcx/mSmRMiN3hd7WtSS48es87XZzaBE/KIVQqZF5BlL/zrTKyiWV/q1J/VJSGvoGcoCsdiUud2/KlSxYCQ5Dvz3hBSBGcffJWk+iH9x9/LbGSz5An/wIETukLNnq8jiWPJTz5d8YO+uTQs0YX/PrZJsx5FtEkUiK17FviqI9xOWWPfqWc4l8jBnFeVFL7rYrx6cw==
X-MS-TrafficTypeDiagnostic: CY1PR03MB2186:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR03MB2186;31:h07hPg/7iGv55WaNZMkHhR0oXFN7TdrT8/REfBwOOXpDYaUcT31rzvZy3umboNwMUihanYEqc8BUcBoKWqnwWnu9yn/DPCnYrpeoXQV8/sKQOzQ7DhQkiTDel8q6Q+RN2wP9eRI9HWZ6XxKEpPoaSgk7wVLuyQ/ViFwYkadPD5N2ldV4x7NShGxKk0qWzNKoUvKFfQ8TwSetnCoXegL5tKTMDgvPbSTzzUAsTJamVSc=;20:sBmw+mLhFx6qwJ74esmWsrrVpNiNRrzAD9Fag00fcuf7gbu6rNrLVBsegku35yRfcSxNSlGDZsmxMSvtCa7P4yTd++s8x+bWsjt+sOOmhcQusImY826D8G7isDb2trSwJeujzc/EkXwmYUF/NGSEEHZ4cujd1HmEEMmb0uiUk9U/95WESHbwBHqTebiVb/U1/O+AqznrtmuW/26dwDTV3OiSUAQhI2rUNBU8lWEB/m839cOzvEsv7GJ69M4EiA9YEC7twiJzLz/CIP/vNkdmYYYywvrkAyeOozW9uGpEwsNsEmMLDBK6UbuS+h4t6ZIRD4d8nUDwQY8sDbMWGUdXVscvQk7ZtebhU56LsqXWX0J1/tTOyLHo1rjHtOomeIPcrpAb1hCBHv5bkldqF4xQzhH2gUUfcgujV2v1SPrCmnXkLXS6QxTghRFsu484CjBEld1VvU4bXNBHKMW1KKHrOtvb1l3zTYM9syQTBuqJDcFYm+tmibLBhsd8t9x3gPlC
X-Microsoft-Antispam-PRVS: <CY1PR03MB2186E50C44C7D324416E21F09DA10@CY1PR03MB2186.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(270121546159015)(232431446821674);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(3002001)(10201501046)(93006095)(93004095)(6055026)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:CY1PR03MB2186;BCL:0;PCL:0;RULEID:;SRVR:CY1PR03MB2186;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR03MB2186;4:mgKj3Kjst45kA0IEshe3UddvjF355Qm2M0B1dJdA344m9xzb21gf6fnIogEfoHZsbr5sMw+RJQP+ExYGQW0q4RemWWlCHyulRbLqtQEyl5Kx3TYT1uEldJivWY54Pt/9DZa1WY6UGNsJ62a2djAwiMjtbL7c63CTLRuT2QjZuBEeExBpfXg63MAUc+kHB5OSDb6/GJV5fgXlOS5RPBhcR6XGbsnY2LU0c7SYEn4jo7EGZcVaGvJQj8mWzO99wBEaZlU55MoL7p8epJt9uKhWO6tEgb9DNogvCBJWpRaCrd6YalwKPKllMrQltci7e5QNXxN4ItCW2bqTWnwUFL5kMgklbFdYzulXCFu/2hn7Ujc=
X-Forefront-PRVS: 06274D1C43
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR03MB2186;23:nqOyOrWWSq9o1Hj7Sy9t2JYqJsXe+B8Ut03IQC79X?=
 =?us-ascii?Q?6hVrZs1BhrZlPy8n+M+h8Ut/h15IDQk/HGf2ulJLc1iqgxDgQe5Z/I5wwRIE?=
 =?us-ascii?Q?J8MEouYAiF0rQMFSrnax0gNz+QyC7TUDFOxJyG5x9kNpjRZj9nkkPonf/J6m?=
 =?us-ascii?Q?YGUx1TpgjlZaSVIflFHu8t9ezBOGVs9dhTYk1Y/x/r053OzRHlpM2+O19Fgz?=
 =?us-ascii?Q?gn0VqvdfYTZ6SobKuVrTRouVDbiUwb46Ulb5UZkoi/bNeCRGqaT4ULzvlnLj?=
 =?us-ascii?Q?SEdljsyftj2MSXy+u0DrU2ABh9D8m5bcMjEVde3HQDyY+ZXviLThBBUOIJsB?=
 =?us-ascii?Q?VgbEbjXK49QtZZr8uTyCafJcJdgicw6e1TlYKzry62ze5WaXdyeWkS2NdGwT?=
 =?us-ascii?Q?R3DqY6K9pvyF+4iyRE55erblo0pk2KEGldgkSj50wPZJWmtL375Su3hSC8Rh?=
 =?us-ascii?Q?lTMeqh+1P9zLwcmIqIjDxaeJ12odHz5iiRhRoQ9U5CyNgt4gZB5EnwxRLvds?=
 =?us-ascii?Q?meynXU51ZvGfmF12Gk9TF3FiE8g7S25OhBv+KfDfVzhWz/7SlJRJ2GshgWys?=
 =?us-ascii?Q?ItUJtyrzsyXvRieSNEn3FYJjrzeMlRbYR09whlXW+ja/ED0Y0C47ERP/TEEr?=
 =?us-ascii?Q?IRffnyzdg71rGfbx6ZJNRUB7IBhtn4a99jsU/fEkXmnVwyC6xQyufII/yINd?=
 =?us-ascii?Q?bmtffEI1P+b2HGyJZ5u45Yg/LQtVXoaNRyhh4eqzWH85Rm+QAPZowjNuyS/H?=
 =?us-ascii?Q?CM9Otmm90utqdXWm0qCkyYMlW3eCkCHadGHmhQopSsewX3xX84ivBcC1FBZw?=
 =?us-ascii?Q?KT0gmUTqIDtnJdhjrEFMqxBrEJ2yt9BS3gzimC2N3mwdO2E3zDdR86oBIcmn?=
 =?us-ascii?Q?8XZ/d/VGn8GNKVbups12HmtskQIxjvGR32vDei8hbxLjDeafT+UXKfTv1Rvz?=
 =?us-ascii?Q?MnQqhiqkt0wTpx1DGEk9zEMMXmD4r+snIGhZavixx1FY/L6FHKhpRMYZs+KO?=
 =?us-ascii?Q?3K0btEVa8SMlMRqS6JYSdnoET9U7tE84v3Tw14brOMPAG7HCXzEJ11yGgdNC?=
 =?us-ascii?Q?w9PRUxEQcnbb9iFczBh1xPs9tMhxs+JSdros2Tkel1RL5C3oRhh9mltdTS98?=
 =?us-ascii?Q?SzC800hncoUP5ZWtWBdpcs4iSIOqotLnrvcef7iYgSt9WclOQ5JMQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: DCkYfMA/RPAtS58Iv1IVi8c9W7pUl6oueIAbXT9hQsCx96nLkRLDjP2oS61Gj0eduxEMUbpxvgbSYMEGbJILdPVxAMmYPAGQDHIMIaSULk5ERgWRvUoFwcGBs8XhtuSFQJCoNR8MuG+FQm4V3lMI6DLR9dEJIiasV5GXezng62c2ewpo3yS45aoulC7yzPej
X-Microsoft-Exchange-Diagnostics: 1;CY1PR03MB2186;6:flyS+AgUwNDKVFjyjKA0bMRe5JO1+5jQP94zymJmxQ67LHESe/5/W+eZPNdHLJ7x9aMLHpGneUtjBkegIX6ZyLiP6RHcjzDlmKPEMlx68OL4mIBFFkCxmx/C0F7cLfZPMGiO+J66x8HabZy3tNKZWrQG9WRXY0qGu9PhWaNVwNIfTGalom0Z5DMIUOVHxQGEfvovSH0CUMKpx7qRsriqHiUTXPLNLwpvGPADUbK5zuhNau4xNmfzr5S8lKs2D0SrGRM+Z/h8CvUHpO03AXRYbKoLxSSnecWWU4kWhrSZ52QQGON7rR/GiATtYYi2AgSjebkHrkCrqzk5wf7FlEGQaKsq8lwGIrUEX08T+lTIkvIDOp9wtPnpoqB8jmwZGnBoa8JqyPlEX8EpV/v6t7Qtwh5NTGSGzwHXrg56M9SfKlpo2Vh8/9cc8WkbmzREemFS67N4TThJw6XCoZj+OfpJxA==;5:6LT3av36jUyVtmrRlRCCBUuCj9d6I4s19A+a0eNjs00tjIWL62PMUSDfGct6EApHzWiYkVlthizCfGeCihD54HbfVWeMZOCw2O7viUBfoSO5RsCCticCgOcH5LRrA3igD4wAirJo4E9DXCWN7X25hoQE5aZ2iZGlqhWMmQhrRo8=;24:/9a8BPxB4OUwfPZWuV3TJE4148c8dWexUHKBI72IbyolmnMCQElCjXsnOQL/qEOPnjcXeR+akI3Z7zALXyKc9nqwFYjQsj16W/ofw/0NHTo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR03MB2186;7:UqjpR8DkKyzo8OkSb+j7HC7KlCzYamVtLvsRweOEEe+TkjzsWzYXTaxvomI5fNd3WfZkYl2o0hTR0v7OiIcmHDaeZw+FwGzIxx56gxpRyhqZVjomxlTedFbsMdUz09VDxVniylbUx5BK2bW6qKp1fUmHSzGOMPkKCfcIQQc8kI4se/5Ifu0AsfoNancO5rgvvcaxq13ThV6Xm3Ta4lBg/22in4pzL2L5TjddMbUTgWJJ3uTChKlEy38t1PRMnh6d
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2018 13:56:36.9934
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0884ee6-4ba3-479f-813d-08d596460e16
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta4.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR03MB2186
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AD5684R/AD5685R/AD5686R are a family of 4 channel DACs with 12-bit,
14-bit and 16-bit precision respectively. The devices come either with a
built-in reference or no built-in reference.

The AD5672R/AD5676/AD5676R are similar, except that they have 8 channels
instead of 4.

Datasheets:
http://www.analog.com/media/en/technical-documentation/data-sheets/AD5672R_5676R.pdf
http://www.analog.com/media/en/technical-documentation/data-sheets/AD5686R_5685R_5684R.pdf

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
 drivers/iio/dac/ad5686.c | 97 ++++++++++++++++++++++++++++++++++++------------
 1 file changed, 74 insertions(+), 23 deletions(-)

diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
index f7f975c..5fb0179 100644
--- a/drivers/iio/dac/ad5686.c
+++ b/drivers/iio/dac/ad5686.c
@@ -19,8 +19,6 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 
-#define AD5686_DAC_CHANNELS			4
-
 #define AD5686_ADDR(x)				((x) << 16)
 #define AD5686_CMD(x)				((x) << 20)
 
@@ -46,12 +44,14 @@
 /**
  * struct ad5686_chip_info - chip specific information
  * @int_vref_mv:	AD5620/40/60: the internal reference voltage
+ * @num_channels:	number of channels
  * @channel:		channel specification
 */
 
 struct ad5686_chip_info {
 	u16				int_vref_mv;
-	struct iio_chan_spec		channel[AD5686_DAC_CHANNELS];
+	unsigned int			num_channels;
+	struct iio_chan_spec		*channels;
 };
 
 /**
@@ -88,9 +88,14 @@ struct ad5686_state {
  */
 
 enum ad5686_supported_device_ids {
+	ID_AD5672R,
+	ID_AD5676,
+	ID_AD5676R,
 	ID_AD5684,
-	ID_AD5685,
+	ID_AD5684R,
+	ID_AD5685R,
 	ID_AD5686,
+	ID_AD5686R
 };
 static int ad5686_spi_write(struct ad5686_state *st,
 			     u8 cmd, u8 addr, u16 val, u8 shift)
@@ -269,14 +274,14 @@ static const struct iio_chan_spec_ext_info ad5686_ext_info[] = {
 	{ },
 };
 
-#define AD5868_CHANNEL(chan, bits, _shift) {			\
+#define AD5868_CHANNEL(chan, addr, bits, _shift) {		\
 		.type = IIO_VOLTAGE,				\
 		.indexed = 1,					\
 		.output = 1,					\
 		.channel = chan,				\
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),\
-		.address = AD5686_ADDR_DAC(chan),		\
+		.address = addr,				\
 		.scan_type = {					\
 			.sign = 'u',				\
 			.realbits = (bits),			\
@@ -286,31 +291,72 @@ static const struct iio_chan_spec_ext_info ad5686_ext_info[] = {
 		.ext_info = ad5686_ext_info,			\
 }
 
+#define DECLARE_AD5686_CHANNELS(name, bits, _shift)		\
+static struct iio_chan_spec name[] = {				\
+		AD5868_CHANNEL(0, 1, bits, _shift),		\
+		AD5868_CHANNEL(1, 2, bits, _shift),		\
+		AD5868_CHANNEL(2, 4, bits, _shift),		\
+		AD5868_CHANNEL(3, 8, bits, _shift),		\
+}
+
+#define DECLARE_AD5676_CHANNELS(name, bits, _shift)		\
+static struct iio_chan_spec name[] = {				\
+		AD5868_CHANNEL(0, 0, bits, _shift),		\
+		AD5868_CHANNEL(1, 1, bits, _shift),		\
+		AD5868_CHANNEL(2, 2, bits, _shift),		\
+		AD5868_CHANNEL(3, 3, bits, _shift),		\
+		AD5868_CHANNEL(4, 4, bits, _shift),		\
+		AD5868_CHANNEL(5, 5, bits, _shift),		\
+		AD5868_CHANNEL(6, 6, bits, _shift),		\
+		AD5868_CHANNEL(7, 7, bits, _shift),		\
+}
+
+DECLARE_AD5676_CHANNELS(ad5672_channels, 12, 4);
+DECLARE_AD5676_CHANNELS(ad5676_channels, 16, 0);
+DECLARE_AD5686_CHANNELS(ad5684_channels, 12, 4);
+DECLARE_AD5686_CHANNELS(ad5685r_channels, 14, 2);
+DECLARE_AD5686_CHANNELS(ad5686_channels, 16, 0);
+
 static const struct ad5686_chip_info ad5686_chip_info_tbl[] = {
+	[ID_AD5672R] = {
+		.channels = ad5672_channels,
+		.int_vref_mv = 2500,
+		.num_channels = 8,
+	},
+	[ID_AD5676] = {
+		.channels = ad5676_channels,
+		.num_channels = 8,
+	},
+	[ID_AD5676R] = {
+		.channels = ad5676_channels,
+		.int_vref_mv = 2500,
+		.num_channels = 8,
+	},
 	[ID_AD5684] = {
-		.channel[0] = AD5868_CHANNEL(0, 12, 4),
-		.channel[1] = AD5868_CHANNEL(1, 12, 4),
-		.channel[2] = AD5868_CHANNEL(2, 12, 4),
-		.channel[3] = AD5868_CHANNEL(3, 12, 4),
+		.channels = ad5684_channels,
+		.num_channels = 4,
+	},
+	[ID_AD5684R] = {
+		.channels = ad5684_channels,
 		.int_vref_mv = 2500,
+		.num_channels = 4,
 	},
-	[ID_AD5685] = {
-		.channel[0] = AD5868_CHANNEL(0, 14, 2),
-		.channel[1] = AD5868_CHANNEL(1, 14, 2),
-		.channel[2] = AD5868_CHANNEL(2, 14, 2),
-		.channel[3] = AD5868_CHANNEL(3, 14, 2),
+	[ID_AD5685R] = {
+		.channels = ad5685r_channels,
 		.int_vref_mv = 2500,
+		.num_channels = 4,
 	},
 	[ID_AD5686] = {
-		.channel[0] = AD5868_CHANNEL(0, 16, 0),
-		.channel[1] = AD5868_CHANNEL(1, 16, 0),
-		.channel[2] = AD5868_CHANNEL(2, 16, 0),
-		.channel[3] = AD5868_CHANNEL(3, 16, 0),
+		.channels = ad5686_channels,
+		.num_channels = 4,
+	},
+	[ID_AD5686R] = {
+		.channels = ad5686_channels,
 		.int_vref_mv = 2500,
+		.num_channels = 4,
 	},
 };
 
-
 static int ad5686_probe(struct spi_device *spi)
 {
 	struct ad5686_state *st;
@@ -354,8 +400,8 @@ static int ad5686_probe(struct spi_device *spi)
 	indio_dev->name = spi_get_device_id(spi)->name;
 	indio_dev->info = &ad5686_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
-	indio_dev->channels = st->chip_info->channel;
-	indio_dev->num_channels = AD5686_DAC_CHANNELS;
+	indio_dev->channels = st->chip_info->channels;
+	indio_dev->num_channels = st->chip_info->num_channels;
 
 	ret = ad5686_spi_write(st, AD5686_CMD_INTERNAL_REFER_SETUP, 0,
 				!!voltage_uv, 0);
@@ -387,9 +433,14 @@ static int ad5686_remove(struct spi_device *spi)
 }
 
 static const struct spi_device_id ad5686_id[] = {
+	{"ad5672r", ID_AD5672R},
+	{"ad5676", ID_AD5676},
+	{"ad5676r", ID_AD5676R},
 	{"ad5684", ID_AD5684},
-	{"ad5685", ID_AD5685},
+	{"ad5684r", ID_AD5684R},
+	{"ad5685r", ID_AD5685R},
 	{"ad5686", ID_AD5686},
+	{"ad5686r", ID_AD5686R},
 	{}
 };
 MODULE_DEVICE_TABLE(spi, ad5686_id);
-- 
2.7.4

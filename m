Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753262AbeDKLy3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 07:54:29 -0400
Received: from mail-sn1nam02on0041.outbound.protection.outlook.com ([104.47.36.41]:10368
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752944AbeDKLwr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 07:52:47 -0400
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; pmeerw.net; dkim=none (message not signed)
 header.d=none;pmeerw.net; dmarc=bestguesspass action=none
 header.from=analog.com;
From: Stefan Popa <stefan.popa@analog.com>
To: <jic23@kernel.org>, <Michael.Hennerich@analog.com>, <lars@metafoo.de>
CC: <knaack.h@gmx.de>, <pmeerw@pmeerw.net>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <stefan.popa@analog.com>
Subject: [PATCH v3 3/7] iio:dac:ad5686: Add support for various number of channels
Date: Wed, 11 Apr 2018 14:52:31 +0300
Message-ID: <1523447551-13278-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523375832-29402-1-git-send-email-stefan.popa@analog.com>
References: <1523375832-29402-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(979002)(396003)(376002)(39380400002)(346002)(39840400004)(2980300002)(438002)(199004)(189003)(305945005)(5660300001)(16586007)(356003)(446003)(476003)(49486002)(7636002)(426003)(50226002)(8676002)(11346002)(126002)(486006)(186003)(2616005)(6666003)(4326008)(336012)(246002)(77096007)(48376002)(106002)(8936002)(26005)(50466002)(36756003)(7696005)(76176011)(106466001)(51416003)(2201001)(316002)(72206003)(2906002)(107886003)(110136005)(54906003)(8666007)(478600001)(47776003)(309714004)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR03MB3056;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BN1BFFO11FD007;1:EWKNrD5cKO6ejXj1ZGX7j8T4D53VdZAiAfJVAgv6mfKV5hXv69+lcK4OW5CxK9M13cIbHwedXCkgsQmJ3f0WxQSMz9J75VvLGjNsPPhGwNgYfDRu7YnF/spAyhmRQ9Iq
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:MWHPR03MB3056;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB3056;3:Y3YEJTUF3oSRvoJWohA+WjAvS02Tmd8fAn0DuThnP9e5vjVL45+2V0r9meuZhy75iB1gHjlUnf5AMyAyGXtyM8PZEaLfsqzTmx45g+dz1v9e3LoUpsSFPwYT78Cj2sTVqhFAesMQH4n8yeLJS8u2hk6SPo22WI+kpY1IvplwIeRhhVBawOuamdkSuDO4/fLFPb/cCcg66yRaX4ZJGfg7q+5Is58rmpn5ZNWa7ie+/dQtWBNrD0kqHvxD6BEC5rmVOBi1wY/Qc+FYLxfnlRWhwR9jCjAxk2dheOKfJzz/HBF0Lyd98ky7ZC1LPjaKgDNBWtFe6Xjgt2GHYUXaLG2gKw==;25:m7BCNdheltG//KYCokDuVavNB5BRiYTFWjuwdlMY0UFQVaQQxMTO+Y4PFB0AtABie8dIi0Dz1GkocfUxlLdN3M7MdbVzUpsEM/SVnBgFvoN8Dr/r9zKES3VXzjqy4Iy4uPXtNf3hPi8h6YCedD5uEb1DAdx0OV16h5/kETo7ipp7X7WhppjigXygN4Yb5D8LhwmS4OiSKMPL8mAENLLqULF+hxYB2q0IQ6CE/IDDijNE7Oq7t+4U3bEXgOCHP52LQTLKD2OVR9pXOBx+sGDwLED2sd0oEP4f5tQjp7Y6Cik8abNXycxR6HPit7XPJOYmoI1HHMStr6bCEvd8ZM2h0A==;31:GBVRIExx/chAn7vXDwPEgXQfxp3di22XMZqIaSUZVpkczy9zOzTsPGkcBWl9gleO5YZYRLpnXQpasNV0IX4LsmMXk6IozBlXPJ45UepyLntFI5RScs/L36sb6tAOkwuKW+/4brcbRpPgDqt1i7DTpnqMC1rGv/DksZCQWwEakh8MEpYBTOEIY0BNNcdXq7SzV3HNw0JVM3qNR/kp3b5S755LHnS7gA50eWzZFdEJoOI=
X-MS-TrafficTypeDiagnostic: MWHPR03MB3056:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB3056;20:t6Q05JZd7OkVUs5/xbY+++ggY8AxPuJBw/1/z84PUGUbjRZyDpiIEFDOFUZCtAfFHztdRnymfU0cEXgtVAIfJefc8HA47BD2lhtGnNnYeIRx/cl+EhUF2d2kvwkNKfLAysTjgjutXc+Zc5JurZv1oCm+jHkOdO0ZIXpechnAjINKFCyhD4a+CqArrE7iaGfLVer2YFEj5JZYpQdYkqxJ2Lxef27uT4v4K/Hb6RUyUu2aRTkeNz3TTQZfNsZjIbP14S1YxyXfGK6pMP4PTKL7nA8goAtJZCTWNJdWng1gn1fiH1ifO9aP8Nh5zaHjhQds1qnqzGihwQnxmG4GqMQHKLO7/RPfBQTyD8z3LT41Lx1tjP1gqcIYCEkmDZhS9/39TdCsFoUO7bF9HOjt6OyGZsUWaXmNz3p+audb6rezvnWVs5pUzcgJ7ue8nxcz4nw2Xm0UWaJ7qBfrPjXJBaywHhViUHCgURUvzviHGX5qmnQm/TF8ieApkn8sDEyjQtsx;4:1y6JguM+lxCZR9hh67HmfP3JVnAwAWmqYg30nP4BizkScTJICaOTaJ8hCzRJGsNX/BrSwgZu0DrIsSoFG+sd10OS01mMkY9x09Kx0n45f4m7dgh9pVUGe60kRd0+uh0x4CB+0stOG1ga0GSYAHWKfkCdJCmUoPMrOK+z0xF7x2PVKJra2AkzqzUvI3lVSCafgKAlAvcS+GMN67HaIZ7m51VsxZh1bHMgR/88IGGwSQCWXx5KC4uwFJO5X4Zksg6Jjs7LZoE76Xa0XUeovDYbb1/pFkqAmnptdP/Fm86ZTTVIXM3jMmSSJrEL1gYB5bhM
X-Microsoft-Antispam-PRVS: <MWHPR03MB30568844FA525734909A04DA9DBD0@MWHPR03MB3056.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(232431446821674);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231221)(944501327)(52105095)(93006095)(93004095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:MWHPR03MB3056;BCL:0;PCL:0;RULEID:;SRVR:MWHPR03MB3056;
X-Forefront-PRVS: 0639027A9E
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR03MB3056;23:1BO+BBlfqs6uIRDv4GYj0oRVzqJhJTIfHXAofo6c2?=
 =?us-ascii?Q?iaXifKfxBL4jT8LfUV3FrtElsCCFLbXmcrfD8qwhD7KaSZKf3tNyQ2FbSCOt?=
 =?us-ascii?Q?lCDy8bepkaVLK0HSPmF5i97scdvSVAF1TVQsejgyRh3xe8ATBRxoiRPQC0TF?=
 =?us-ascii?Q?PnxCLXZv6iEC1eBFvZ3PEvqJXVyi5h2P79ZJW4n7EjGngaKDLCH5VxCcQiCH?=
 =?us-ascii?Q?LM0xGQiOMVp/1Ik2U+5R7/iEDTYDuIke6K37U35tYugQMXQicNf+sdFnM9pu?=
 =?us-ascii?Q?m9EMVeXfafjo8tXO0lqpyN+z46Z4SuhBtGQ/cKKFK/oKKzANHgcYMnnDXhzp?=
 =?us-ascii?Q?6P6/japj1VzF/TlImz5vxAtcM5EBE5zwWvNa5WRf0Esrrw2Cgi7ERYgSLyMn?=
 =?us-ascii?Q?l3jf/UhNhe336q9yCjVw0Lg5JniAeIhtVU6rg0tYSHtrujGKcnTOd8/bmwZY?=
 =?us-ascii?Q?8QVk0eaqw/8KRwtgi99Iy8VYb+4vEgG+aqR9EkF7VLJ/M50FEbE3/5HLwil9?=
 =?us-ascii?Q?D/pwSzAXQVJDv9nPVxGFGvoEAz7e4YXfkgaG+wUsYRpp2fiL91POOFvWy7aI?=
 =?us-ascii?Q?TU4SbEyGOmdaCBLYWJFaJ1z+3yDj/ak6+Zce2yccgeJvRYOIgTLMZTvsKq6a?=
 =?us-ascii?Q?A4DUgjatUTMfWB+2DI7WsxkZ00jxIlNhX593V3uW8yDYxu/gu9ynMrPL9PNY?=
 =?us-ascii?Q?mDRuFhDdRMqOOHy7xBVwULgtAXSp9psbCqkVDMGHLcxtrRSRK0mDYqKmBrLQ?=
 =?us-ascii?Q?13LvXDp12g6BlVB4OXcanXqrPuHtOwNlvWYVtiU5NKXVQ8qijs6qQnoRA5aV?=
 =?us-ascii?Q?TzMBVZGe9o097ChMLXn5VuE7cH4jhPaObq4Dkks844rBHeMeleVYeysl4fNM?=
 =?us-ascii?Q?1jjh8BTgI1sho//q6We6De5WUDaVEDdo9TP5qhgMW4XsWWFfZpGfiJkoOPeU?=
 =?us-ascii?Q?iC+EVsWbWFu+ZBo94vLrEvGa2JXeJvd1+M9cribZeHSBIQl4NUFYyaQnn+Hh?=
 =?us-ascii?Q?QT2UFqLEb8NE+pfMhqrRSOiFDN5LLHbRE4EMa+XOhXiYWmNGWplgR7JvT2t1?=
 =?us-ascii?Q?kCXCcP57qtiyIpoOFk7cDheXXM+kdYlxPcmSOw6vkqA5CFQcg1BrXOFrxP1F?=
 =?us-ascii?Q?HlyOO3VzGIrJVQtTtKrplLYkXi1zs8z+GpRNcqv5P9W9sKMkWY4iqaO0sVDa?=
 =?us-ascii?Q?wFtNs8j6qb9WUk98UdKX324EsWONmEdndTAC8tT1bvAqItIyyMcIqc3Fw=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: AoTdbqcxhDpRMx7eRMnZJGCStAQzeelZeYaaBMVIisZR+7Tiyc60UXWYiPrlCzQjA779oialcY8AD4TYpRz73cwFk5gfMOU/bSFa/S4k1SrOgxSNKGyTr3stxVqBizhe694n9Eq2JKJUyrbyWzEf+aukpYG8RM0mr3cccb3daP/oxdK8BHPlEDKjzpD1PMlU
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB3056;6:B25H6HBqKKPqSwojw2xfj3FdTfrbtulayVJhqdsV6xWmiiNLhTtHptToVXHf3t8lrh7PVDCNyTPA8w0VINvrYTz98gR50rmGD6npEFv0fZeKlEg8T9qhdamuVz0r1kenUHbwGdM1mXk83p+mVRC4xuC91mkmTW91LTYc4dxtTD2m6RBIh/0P/j2pgAQywngZVNWLQEC0ZN8IunIE8ifQoDsVs1tsAPRuyhGHJvnidL8oSwf67iyCGqdlvE2s1qgW4xyaGdmzJ9563MNOdYBe9Gv+d7WEeqtNQ//SsvQg9WfIrtptWoq9WERTByUT6j4+1yukJACc8rbDKoAA4vbFE6nmQ4KmG9faZzLNOfAkjjsp+RpcgLOI4fKWoP/tO8zmuRlm7F1oHcHUYdA4W9Hn+vQdJFHs+EU4UmHFfKm+N+vfS/3SBBdNH8JcePY2Qi0SvDKsgKVM4xITtAI+buLNTQ==;5:vm/VhD6IfCda6yw/ognFKURFgKP6zw0a02xOE8cIh1GXuqrLHx5+CuhoE53ZAMwnmSH1DpizuhsqG8sx1d7U2ieNb8tGmLuoizVraT7WvVUiLrlWYJxgaYvMRJIMlfY3qyOgXpSlCwR3b+BGx0DWEPzTi+HSchYbdKBV1ojb4vk=;24:KyiaYCmHO2v41xy8G1CZZghbfnhUaSjfbjfSTzB8NYPl5jAAWd7UuNL/Q2s5F0HDxsfz7R/jGxrQpLrvNhi8WBDgz8p6WhDfMfo6A25GT5M=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB3056;7:mH9ih2PC2Z3qP9FYZHCiZXvHOusNxHKMeqr3niKfQdpyCvJvJRYWwUzCUgxr2xj40NoDMZdVe7ZTeQZ687+qMpaL7CRfQPWEjZc8e2iDL/JnYWEVS01ln3KWimZjRbn+RvJft8eHsfkDtajuEykIufB0xM7Rnaky4tLFfBXaqUgvr2o7cMFTPQxAQ6APWAczF5laWwgxhezA6J02sLReoxLSdb+J3exyZQxm7CKA5O9yuRaWSBuP7jH2w5v1J/0B
X-MS-Office365-Filtering-Correlation-Id: 2461eab7-aec8-42d3-97a9-08d59fa2ba9a
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2018 11:52:40.5601
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2461eab7-aec8-42d3-97a9-08d59fa2ba9a
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR03MB3056
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a new num_channels attribute as part of the
ad5686_chip_info struct which replaces the AD5686_DAC_CHANNELS define. This
is a necessary step, since this driver should support similar devices which
differ only in the number of channels.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
Changes in v2:
	- Refactored the patch to add num_channels and the new macro forms
	  for the existing parts.
Changes in v3:
	- Nothing changed, just follow the patch set version.

 drivers/iio/dac/ad5686.c | 45 +++++++++++++++++++++++++--------------------
 1 file changed, 25 insertions(+), 20 deletions(-)

diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
index e328513..87d6e6e 100644
--- a/drivers/iio/dac/ad5686.c
+++ b/drivers/iio/dac/ad5686.c
@@ -18,8 +18,6 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 
-#define AD5686_DAC_CHANNELS			4
-
 #define AD5686_ADDR(x)				((x) << 16)
 #define AD5686_CMD(x)				((x) << 20)
 
@@ -45,12 +43,14 @@
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
@@ -268,14 +268,14 @@ static const struct iio_chan_spec_ext_info ad5686_ext_info[] = {
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
@@ -285,31 +285,36 @@ static const struct iio_chan_spec_ext_info ad5686_ext_info[] = {
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
+DECLARE_AD5686_CHANNELS(ad5684_channels, 12, 4);
+DECLARE_AD5686_CHANNELS(ad5685r_channels, 14, 2);
+DECLARE_AD5686_CHANNELS(ad5686_channels, 16, 0);
+
 static const struct ad5686_chip_info ad5686_chip_info_tbl[] = {
 	[ID_AD5684] = {
-		.channel[0] = AD5868_CHANNEL(0, 12, 4),
-		.channel[1] = AD5868_CHANNEL(1, 12, 4),
-		.channel[2] = AD5868_CHANNEL(2, 12, 4),
-		.channel[3] = AD5868_CHANNEL(3, 12, 4),
+		.channels = ad5684_channels,
+		.num_channels = 4,
 		.int_vref_mv = 2500,
 	},
 	[ID_AD5685] = {
-		.channel[0] = AD5868_CHANNEL(0, 14, 2),
-		.channel[1] = AD5868_CHANNEL(1, 14, 2),
-		.channel[2] = AD5868_CHANNEL(2, 14, 2),
-		.channel[3] = AD5868_CHANNEL(3, 14, 2),
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
 		.int_vref_mv = 2500,
 	},
 };
 
-
 static int ad5686_probe(struct spi_device *spi)
 {
 	struct ad5686_state *st;
@@ -353,8 +358,8 @@ static int ad5686_probe(struct spi_device *spi)
 	indio_dev->name = spi_get_device_id(spi)->name;
 	indio_dev->info = &ad5686_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
-	indio_dev->channels = st->chip_info->channel;
-	indio_dev->num_channels = AD5686_DAC_CHANNELS;
+	indio_dev->channels = st->chip_info->channels;
+	indio_dev->num_channels = st->chip_info->num_channels;
 
 	ret = ad5686_spi_write(st, AD5686_CMD_INTERNAL_REFER_SETUP, 0,
 				!!voltage_uv, 0);
-- 
2.7.4

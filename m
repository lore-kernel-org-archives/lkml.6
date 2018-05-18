Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752513AbeERPX5 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 11:23:57 -0400
Received: from mail-by2nam01on0079.outbound.protection.outlook.com ([104.47.34.79]:52544
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752083AbeERPXx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 11:23:53 -0400
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
From: Stefan Popa <stefan.popa@analog.com>
To: <jic23@kernel.org>, <Michael.Hennerich@analog.com>, <lars@metafoo.de>
CC: <knaack.h@gmx.de>, <pmeerw@pmeerw.net>, <linux-pm@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stefan.popa@analog.com>
Subject: [PATCH v2 2/2] iio:dac:ad5686: Add AD5681R/AD5682R/AD5683/AD5683R support
Date: Fri, 18 May 2018 18:23:34 +0300
Message-ID: <1526657014-28960-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(39860400002)(39380400002)(396003)(376002)(2980300002)(438002)(189003)(199004)(2201001)(26005)(478600001)(77096007)(5660300001)(106002)(53416004)(316002)(106466001)(107886003)(966005)(186003)(7696005)(54906003)(6306002)(8666007)(51416003)(575784001)(110136005)(426003)(305945005)(356003)(7636002)(476003)(2616005)(50466002)(47776003)(126002)(486006)(246002)(336012)(4326008)(6666003)(8936002)(72206003)(36756003)(2906002)(8676002)(50226002)(44832011)(16586007)(48376002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR03MB3043;H:nwd2mta4.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BY2FFO11OLC009;1:4q2ZBIVHgbMQVnplb2yFFMZI152BjatvlpxuZNPKV2KtV3L2JGjpgOtKuJ4yy76z2BuTpEk8wIURP4H3KoumRfvIuOV8WKXW+7b/jCo9FnOkHEu8Sa+VCDXZsD/KSk+W
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:BN6PR03MB3043;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB3043;3:TTBPZ+WOjlfAPj+m1zQl/zmJq2VDqrakRT71TZ4w0jGJGXRzfoDHX0i/9U/sefKmtgo8B0Zl5VDT8bY5HoHkk1+M70oImiBKrK4VZswsDXPJdj3k0qWwwZvGpAo8vlV1Z661d18aTqXGlDCzu/CvgJwRkj4EcvyhVXk6cz2I8XMUrzN2ORC+zoRGip7hoPC8Vk3nWSLWHcbfnyzVIfZT88pL9If7kjQmW2cKLDAdlxusaDEw4SKoEKTEa+tfe8G+Hc7h0SeF41emXOqYTBbBWbWhVdAbxtxiqrqzYIHSrkikNmU7Q8vAwI40TkwCkyiD/FJfq8EO4+i+6RKoEsXeBQMtVuAwfyoiKkRaM6Bfq/E=;25:QCobmNnVbwEADDYiScAxk2mNczXg8v3RZMNrf5cFQGURMcqf7WIh7T0TyzWQAN9bU+CtGoksQTRvD69DixvEhxEWjOCIIE+4YjJE7Q6Zw4yFBewjSIIiLhAIaC+OOmGNqSKWnS72UPGzcliePZ4yvlI2evU5hxH8S2AbkCFyCAvAkQ2vj6eJHOS2qRuo6iNaG2fDDZFWiYBF+DtW6M84asZAkiV6vUsVMvBdpora1wNQjhaDvsayzjU8yN2uwptFPKauLHQVSF7MSNBWF3gwck08px6GVPv8oJZJ9hahjwTNZT48iaS3i+Sfh1JnJPDrA4J7qEfjRlP7G7OsH02XIA==
X-MS-TrafficTypeDiagnostic: BN6PR03MB3043:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB3043;31:VGVUd1JLpElb30duDDZR+k8HIQKQLG8nH55wBtQIfVMX+bQisvvzVTV5KSjm97bD9ky8IEKPNFPK7LzoZPDhzBazRT0wxwboSfIXSf9ZpT/6I+Enou9TY80/ySchAUxKRNSiguR9ZkV90Wh0XEPFGWajPzuG0bezL1j67ixeZZCvSKoMkxvh96AkBFZDg4TlYaYJ4F8lzyX3HUhEoOBLe6wVNE1WFYVSQ3myRAWMfkI=;20:dBuDRYHEeM/cMyCimo3vlPOktZiXAYp4/mdGVElHdmjQ33QHFb7c3IvE6h891oIPTQkyumF9QoeD8IXFERavymuwiAo+1E3SAwHWWqfD2GMtUWfpUNi/MZMFwTlpejyYLGDY6VJdnzMhe3E3vVA0MAiKpY3Y0UKdNUiadpcqTpXaWgpFW4/Vs1ASTzo94pl9/q8II0sTlKnAnUbSyNSamRmDj4AUQLv0d/jhqqz83C8OQ7gkQu2QHt+SWshiVwG1spsytPDeOuob/zG05PYullQ0TrBJYdcwx5XtAwftq9ZG04IwYSxX8U9s3jIr6jCXahpmxcipWbZtipU6Qe8tc4ACYcwyWiPi+4eVeE55ObPCtzbJ/Pi7gsD7taFPGOUdjJNW1x5SECx5fbdnvDRrC+YpQoyWYZ3JaImodMfKvRtH0obzk9vEDGP3w0+ltEga+aBRCJuZqWqTzaSLmhWShQz4XV/JjxQqZ8zqVIyImZZM8EzoGJVXnMNnN5aNL3rP
X-Microsoft-Antispam-PRVS: <BN6PR03MB3043F34D0DB32CACC5ABFF2D9D900@BN6PR03MB3043.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(270121546159015)(232431446821674)(17755550239193);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93004095)(3231254)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BN6PR03MB3043;BCL:0;PCL:0;RULEID:;SRVR:BN6PR03MB3043;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB3043;4:H8Pfbh/rLkUOnQBIv/geRhZikRxbLjiB0YjJKnYSs5fekj3WTVYs3kBNHg5+o/kQRMoV/fVydK6M6CVM02MaSYQ4CsAvN6kncQMEnB8G4Vh3CD0kVxQJPtaQslFMcDQC6JSsBK/wUKt3d/v3cXAe8o2GSP5XXZ0DwFKSk9HUbKkvOxrl5DE4rnJiGxA7CUm3tkJW9VPIFTgq5HYn1NSXKifkMk81yCCDYdFAYEhoIxsKqgHslKYxljcGS+PUzJ3sOqwUzh7huLtvM6VHCIKlEa7wx8DMJhehcBRibiqLQ572N4SaJUifQJTXuwTimYJuMnfM/Jp/9WNsvz5yjjVtsVdk4xGQ+cTaMf4snN5i4DLWnTJ4jj0cJa9smugrJATF
X-Forefront-PRVS: 0676F530A9
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR03MB3043;23:9XeCPQvX3bnsbOkwgK7Df+yiNv/d0Efi2NSZO+aFz?=
 =?us-ascii?Q?/uM2AwtXT/jVF65t3AUGXEtHZQmyCR7J9JDy37LWT33tP7YOqT3uAPispdZJ?=
 =?us-ascii?Q?heeQx382rLj5HO/dhsV0gzLKmzwgJzBt5O233qYChW0bh53473pQEUwHPdse?=
 =?us-ascii?Q?Nj/pXKwXIWu2AWRJ+5lGp6aolXXdDJDuVgJR3qaYibJcBOLQRjDLKO2IkIVR?=
 =?us-ascii?Q?JI3yx0ck6Db6TUax2P+nw2LOWzXUkW3OupThm3r9g62vF2db2VryjeYNNW0X?=
 =?us-ascii?Q?aqKJevl5MQp7eQxcTvjtwrXFes0p9FB4TmkDI72CsuhBwW5b3StM4+DfLGRB?=
 =?us-ascii?Q?5UtdiQXwLVjMII+mYTvWihsvCZhmxuQ3u9mshfI05SGGgjeEF8W+ECrnh9qY?=
 =?us-ascii?Q?tSQcuZcn6eLvBZt5VyBYOhb5mu9BncVkACzmo08GRr3GPJbf5JR5JfsXH79u?=
 =?us-ascii?Q?LldjFfeRHEgaZQaMDuhm/qUKRRJT4ZqpJCmEgsfCoNha94x2tW3euep16RL5?=
 =?us-ascii?Q?VQHbT0EAlryv+5RfRqf/hMywaZgzvF/XLBePEIWaThHoad7eygICaKG5Rxrl?=
 =?us-ascii?Q?MpArkQPmBxRIckUmaoAlbyRVooN0kRSa0tSX//GJ53wO4i0b+aKaWmRg+MXC?=
 =?us-ascii?Q?PYLfjyHvvIrm/qsIToBHL5JrtEnHHcu+Kxb50XGK5rUPkYGavHhP/pZVixRy?=
 =?us-ascii?Q?2ZwQXk9OdFGRTmIqWOlWK4R06iMOVI40mbc/6EAaV1IfGJjRTMZTv4+SYs0E?=
 =?us-ascii?Q?oc+aCP9ubwUh76DFzfsyJD/zxW1TMWUv6CvXBKr6DqZLXnGnkUTCto88C4RN?=
 =?us-ascii?Q?ASC0ti2zEoSJVE+07vclCRjXZDcq75kN4ei295vsIwhNTstMqV1Q0Tfu9jyq?=
 =?us-ascii?Q?Wvh539bxDeGO+faGDHcIWbj8SDrZsd6BJjP0Zeyx5zhqT/5psPJW9BXAbbag?=
 =?us-ascii?Q?Qy4GyGY4kwWGLBD60wCG3nAa1qY4Nx/wlNkBLKWda2xnBJNUb9RrIKhs8esn?=
 =?us-ascii?Q?JJylQ6yfANKhiHFwhregDfwEUfQ2zqXSN/P4SiOjtngLicrhA7Dfa/f5HInf?=
 =?us-ascii?Q?FzN/9Kz+wCro0Y84JSi8CmGndTHjkQ1hz4dequCS1MIuo9eAH4MuY3uRdfKP?=
 =?us-ascii?Q?5N7RlpGRdM=3D?=
X-Microsoft-Antispam-Message-Info: Q12U+/cWGHZt4aTWz+Me9e2TFlKmT4vykuj8USphMfiv5GVRIB/qm6mlHj7dipSYDR0h+Mcv18xKTVIbVYBEeWBHcNTEkRNnjQEYLD6UaFLH8unAGke2lEuUdhh27IZtdd7PHQbNGk7AJg3PHrlWI6oywd6cRvrBGxzkgCAw/5QEmLg2EFt/LuwiUfw/CN3z
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB3043;6:SeWq8XySQKJYperfr8EJx13T7/qb1u8xWnxNRicHmV0EZe2hJd+WtikqTVffmsXgf1Hqk+CN/Y2A2xgVywTP4lyxb9gRmOCoNwRi/8NVXOD9BCcSRaQWgZwdisHHKZZPF4+njYBBzXywDXp8AUlcAvHahA2yvRshasY2mi/3tF8nkSvVb9wmeC34ugkGBseGj7LedVAmSGfUQnsnUL4dboCalJBmBukvq+dqutssF7nNUu0a3jASp222xqQf81yQtZrql2/45JsOHa3hrQYeHm8ymfnCWpF4eN92zpRD0ze+wgqpUJNDgRX4G5TclmTyUWVRgKkTWIbAkxpqPT8734cuWMJHEjl6ArPuPjg8QkmWpSbJvpsgBGVWI0iyQqducq0zjJ9xYgsdiJnbNEdxchQmsAIuzCgiFA/1UcA1TxjkBG3jl+6Dn+8E90uSPT2pPVUtAMBUlIofABJQHFpYzw==;5:TRtwfz8I4AjAgRS79e824nWdyJ1GwuEOxGR9mTlAXo6UPiiUUHVnUsaXC3n6RPBONz9cgSElKf1CEqOLIAfeLta9dnYnfKZ2Fx4zBHV+IzY4Tv7zntS7ELlirpBw+o2pnx+cr7XWMoh2sBg7PNVK4U9d3RzJO4UNLjSh4UDjcoQ=;24:/Q6o/BxUOgHNgkeMIMrJhDbVKTVM31wV8YFDRYPCBc8HUWOn1akf/UtaOPXIRdp4r9/hYJYQWsB/GVTNNssQihyMRnzDOWIBtNxATAwOmfg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB3043;7:UgxhVhsO+ap2fpBd1InqrGsyvx1lzdwT2TAfeByA9wZH1lES+NlhzlYnO713onphPXD0hj7T691v9pQMzo5zA0VqyxWuUPPwTELORbe8D0cNqqa7beVEXZKqH+2IIXWUkys1Rm8KMP4fUti93H3ZjDBNplTufAd9dw9HjHNuiOolTjja0JkQkKMOSdDh2cIMKh8Pc3FCVWnPdmIOKFxm5OSI9N8el0yGXmO/hToD2Q3HonDf7iRt4eeWVF6thaBy
X-MS-Office365-Filtering-Correlation-Id: 8713e430-93d9-4c92-33bb-08d5bcd35c16
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2018 15:23:50.8909
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8713e430-93d9-4c92-33bb-08d5bcd35c16
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta4.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB3043
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AD5681R/AD5682R/AD5683/AD5683R are a family of one channel DACs with
12-bit, 14-bit and 16-bit precision respectively. The devices have either
no built-in reference, or built-in 2.5V reference.

These devices are similar to AD5691R/AD5692R/AD5693/AD5693R except
with a few notable differences:
 * they use the SPI interface instead of I2C
 * in the write control register, DB18 and DB17 are used for setting the
   power mode, while DB16 is the REF bit. This is why a new regmap type
   was defined and checked accordingly.
 * the shift register is 24 bits wide, the first four bits are the command
   bits followed by the data bits. As the data comprises of 20-bit, 18-bit
   or 16-bit input code, this means that 4 LSB bits are don't care. This is
   why the data needs to be shifted on the left with four bits. Therefore,
   AD5683_REGMAP is checked inside a switch case in the ad5686_spi_write()
   function. On the other hand, similar devices such as AD5693R family,
   have the 4 MSB command bits followed by 4 don't care bits.

Datasheet:
http://www.analog.com/media/en/technical-documentation/data-sheets/AD5683R_5682R_5681R_5683.pdf

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
Changes in v2:
	- Nothing changed, just to follow the patch set version.

 drivers/iio/dac/ad5686-spi.c | 42 ++++++++++++++++++++++++++++++++++--------
 drivers/iio/dac/ad5686.c     | 32 ++++++++++++++++++++++++++++++++
 drivers/iio/dac/ad5686.h     |  8 ++++++++
 3 files changed, 74 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/dac/ad5686-spi.c b/drivers/iio/dac/ad5686-spi.c
index 6bb09e9..1df9143 100644
--- a/drivers/iio/dac/ad5686-spi.c
+++ b/drivers/iio/dac/ad5686-spi.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * AD5672R, AD5676, AD5676R, AD5684, AD5684R, AD5684R, AD5685R, AD5686, AD5686R
+ * AD5672R, AD5676, AD5676R, AD5681R, AD5682R, AD5683, AD5683R,
+ * AD5684, AD5684R, AD5685R, AD5686, AD5686R
  * Digital to analog converters driver
  *
  * Copyright 2018 Analog Devices Inc.
@@ -15,12 +16,27 @@ static int ad5686_spi_write(struct ad5686_state *st,
 			    u8 cmd, u8 addr, u16 val)
 {
 	struct spi_device *spi = to_spi_device(st->dev);
-
-	st->data[0].d32 = cpu_to_be32(AD5686_CMD(cmd) |
-				      AD5686_ADDR(addr) |
-				      val);
-
-	return spi_write(spi, &st->data[0].d8[1], 3);
+	u8 tx_len, *buf;
+
+	switch (st->chip_info->regmap_type) {
+	case AD5683_REGMAP:
+		st->data[0].d32 = cpu_to_be32(AD5686_CMD(cmd) |
+					      AD5683_DATA(val));
+		buf = &st->data[0].d8[1];
+		tx_len = 3;
+		break;
+	case AD5686_REGMAP:
+		st->data[0].d32 = cpu_to_be32(AD5686_CMD(cmd) |
+					      AD5686_ADDR(addr) |
+					      val);
+		buf = &st->data[0].d8[1];
+		tx_len = 3;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return spi_write(spi, buf, tx_len);
 }
 
 static int ad5686_spi_read(struct ad5686_state *st, u8 addr)
@@ -37,9 +53,15 @@ static int ad5686_spi_read(struct ad5686_state *st, u8 addr)
 		},
 	};
 	struct spi_device *spi = to_spi_device(st->dev);
+	u8 cmd = 0;
 	int ret;
 
-	st->data[0].d32 = cpu_to_be32(AD5686_CMD(AD5686_CMD_READBACK_ENABLE) |
+	if (st->chip_info->regmap_type == AD5686_REGMAP)
+		cmd = AD5686_CMD_READBACK_ENABLE;
+	else if (st->chip_info->regmap_type == AD5683_REGMAP)
+		cmd = AD5686_CMD_READBACK_ENABLE_V2;
+
+	st->data[0].d32 = cpu_to_be32(AD5686_CMD(cmd) |
 				      AD5686_ADDR(addr));
 	st->data[1].d32 = cpu_to_be32(AD5686_CMD(AD5686_CMD_NOOP));
 
@@ -67,6 +89,10 @@ static const struct spi_device_id ad5686_spi_id[] = {
 	{"ad5672r", ID_AD5672R},
 	{"ad5676", ID_AD5676},
 	{"ad5676r", ID_AD5676R},
+	{"ad5681r", ID_AD5681R},
+	{"ad5682r", ID_AD5682R},
+	{"ad5683", ID_AD5683},
+	{"ad5683r", ID_AD5683R},
 	{"ad5684", ID_AD5684},
 	{"ad5684r", ID_AD5684R},
 	{"ad5685", ID_AD5685R}, /* Does not exist */
diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
index 1fc0c56..e136f0f 100644
--- a/drivers/iio/dac/ad5686.c
+++ b/drivers/iio/dac/ad5686.c
@@ -83,6 +83,10 @@ static ssize_t ad5686_write_dac_powerdown(struct iio_dev *indio_dev,
 		st->pwr_down_mask &= ~(0x3 << (chan->channel * 2));
 
 	switch (st->chip_info->regmap_type) {
+	case AD5683_REGMAP:
+		shift = 13;
+		ref_bit_msk = AD5683_REF_BIT_MSK;
+		break;
 	case AD5686_REGMAP:
 		shift = 0;
 		ref_bit_msk = 0;
@@ -256,6 +260,29 @@ static const struct ad5686_chip_info ad5686_chip_info_tbl[] = {
 		.num_channels = 8,
 		.regmap_type = AD5686_REGMAP,
 	},
+	[ID_AD5681R] = {
+		.channels = ad5691r_channels,
+		.int_vref_mv = 2500,
+		.num_channels = 1,
+		.regmap_type = AD5683_REGMAP,
+	},
+	[ID_AD5682R] = {
+		.channels = ad5692r_channels,
+		.int_vref_mv = 2500,
+		.num_channels = 1,
+		.regmap_type = AD5683_REGMAP,
+	},
+	[ID_AD5683] = {
+		.channels = ad5693_channels,
+		.num_channels = 1,
+		.regmap_type = AD5683_REGMAP,
+	},
+	[ID_AD5683R] = {
+		.channels = ad5693_channels,
+		.int_vref_mv = 2500,
+		.num_channels = 1,
+		.regmap_type = AD5683_REGMAP,
+	},
 	[ID_AD5684] = {
 		.channels = ad5684_channels,
 		.num_channels = 4,
@@ -385,6 +412,11 @@ int ad5686_probe(struct device *dev,
 	indio_dev->num_channels = st->chip_info->num_channels;
 
 	switch (st->chip_info->regmap_type) {
+	case AD5683_REGMAP:
+		cmd = AD5686_CMD_CONTROL_REG;
+		ref_bit_msk = AD5683_REF_BIT_MSK;
+		st->use_internal_vref = !voltage_uv;
+		break;
 	case AD5686_REGMAP:
 		cmd = AD5686_CMD_INTERNAL_REFER_SETUP;
 		ref_bit_msk = 0;
diff --git a/drivers/iio/dac/ad5686.h b/drivers/iio/dac/ad5686.h
index 6c6879d..d05cda9 100644
--- a/drivers/iio/dac/ad5686.h
+++ b/drivers/iio/dac/ad5686.h
@@ -13,6 +13,7 @@
 #include <linux/mutex.h>
 #include <linux/kernel.h>
 
+#define AD5683_DATA(x)				((x) << 4)
 #define AD5686_ADDR(x)				((x) << 16)
 #define AD5686_CMD(x)				((x) << 20)
 
@@ -36,6 +37,8 @@
 #define AD5686_LDAC_PWRDN_3STATE		0x3
 
 #define AD5686_CMD_CONTROL_REG			0x4
+#define AD5686_CMD_READBACK_ENABLE_V2		0x5
+#define AD5683_REF_BIT_MSK			BIT(12)
 #define AD5693_REF_BIT_MSK			BIT(12)
 
 /**
@@ -47,6 +50,10 @@ enum ad5686_supported_device_ids {
 	ID_AD5675R,
 	ID_AD5676,
 	ID_AD5676R,
+	ID_AD5681R,
+	ID_AD5682R,
+	ID_AD5683,
+	ID_AD5683R,
 	ID_AD5684,
 	ID_AD5684R,
 	ID_AD5685R,
@@ -64,6 +71,7 @@ enum ad5686_supported_device_ids {
 };
 
 enum ad5686_regmap_type {
+	AD5683_REGMAP,
 	AD5686_REGMAP,
 	AD5693_REGMAP
 };
-- 
2.7.4

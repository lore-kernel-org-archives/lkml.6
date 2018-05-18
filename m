Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752096AbeERORn (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 10:17:43 -0400
Received: from mail-by2nam01on0055.outbound.protection.outlook.com ([104.47.34.55]:22599
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751280AbeERORg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 10:17:36 -0400
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
From: Stefan Popa <stefan.popa@analog.com>
To: <jic23@kernel.org>, <Michael.Hennerich@analog.com>, <lars@metafoo.de>
CC: <knaack.h@gmx.de>, <pmeerw@pmeerw.net>, <linux-pm@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stefan.popa@analog.com>
Subject: [PATCH 2/2] iio:dac:ad5686: Add AD5681R/AD5682R/AD5683/AD5683R support
Date: Fri, 18 May 2018 17:17:23 +0300
Message-ID: <1526653043-23512-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(39380400002)(39860400002)(396003)(346002)(2980300002)(438002)(189003)(199004)(186003)(50226002)(2201001)(5660300001)(8676002)(316002)(72206003)(486006)(47776003)(107886003)(2906002)(2616005)(36756003)(246002)(426003)(336012)(8936002)(126002)(4326008)(476003)(6666003)(26005)(53416004)(16586007)(44832011)(8666007)(54906003)(7696005)(77096007)(6306002)(305945005)(48376002)(7636002)(966005)(478600001)(50466002)(110136005)(106466001)(106002)(356003)(51416003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR03MB3055;H:nwd2mta4.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2FFO11OLC002;1:p0TXAMjiO/D3jBcqyt4RQBCSUNQ/mHbbvchhoNVT2E7WJ+LOStoJHHHCc6m3lwMy7LI96NgHW7Q7y5clsvSvNFYE2BB2X7BnaeVjTiOy+NYBaty7VaMYaHPPDyejRN+Y
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:MWHPR03MB3055;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB3055;3:Y/x8vl7cQfzefNjE2mDhLmi6/0u7CTOtsvWtZ6PsPW/2FmXLd9lbcODCsQ1lSQcFw8AvAspIFHHAaKOj5m7lBMAc6SJU8UWQpQVMguQHg8Q5mds89/cPccrzE0Q5stIsJgPLSD/XCrXEkgCGnsYfk3HVr9ubLy7ITtI0snXpvfeA4owkpZadVBj9qa2bCqhMsl52R+RVORA5WM45M81HlH/w0Z18Hfv+qtLriCwj84sWO4pEkHgcvCAjHE0fvQxFcpDuQZaRy9v38UljrDi48ecBEGnDMrIGwvV2Gg9zlEIFFwjXBNYKvsUY7ihlvSbCV+yOX5q3yNvg3AOM7Wck67xatqhWql6O2e4/lR+U55E=;25:3aOY+Ip/hvcO9AL4ZCM0mQEGLPKvTevCUvVViVDP7y5MgOS5HFqApqZffOo8vuHIq0XwM5HxmDuQ3iTBHaJQKBQh4sSSVIFdp53vGG13CSB1CCCenVKffGK9Vzv4L0DeXaTvV/Z8j+Y61lq6Z9S8DRtoe8B3vNstCEvZtB3hwVqfZ0tmUzpxT+OcoXRVYp7A4QlzQbtV/WRgnSuYrM9xlSHTXtlpQJzk8TdlqBHlxHY59w8lvAFwgPzkNc3N1kKbwwqQ3lR+1AAWv2/DClf1c2JstToQn1LH8iz6DtIgMeBLsTWEFKDIKQfDJTJ+Ah0AE1f5HY1J40EGZjfw8vb/Sg==
X-MS-TrafficTypeDiagnostic: MWHPR03MB3055:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB3055;31:EesanGt6WnS4eBH09dfuYnhBnF2xmH6ybajqxpTpedS/NqiLfnpn+2REuHf75JYC/8zElgUY4h1gVJSgHU5PBtQvhBExF/ixqbK8SiE7U0JqcFT/D0QyLSRmNE/EEfASTW5udWs712NHhxvxNSfPWselpWI3zt88BH199VDYwhxvHDsYnPZ2f7ZYuHG1G17BwKljBVKnmV+6L9k0r0QKV3C6xUHsSa49dR4xtfm7gvU=;20:LvLtN4ePEM8g1LEHkOhoOcaOPewopp4tm253FxP80PzbCDjtU3PrN/W4wcHJem+n5XRx/vINt0AteX7ro64tP/Rk/n5hhNdR46utoQ11hz5D+rkpFuHNiBOb8i8s+IjzYbaBbL5DASxf0qpdzUV9378mJv+qaWO5z7BQVVlcEom7b2dzPjWz2LY2nzTOh5vVskZxrt8skktzci+53WV00sUG8pZsMPHSE3hN4hKCqfC3Tf30yUr9KH5sQkdntOmX9OkHGUNlGp81ruzp8SITTew5qhR7kBb/o7+/pFrjlfJotW5lrZ7cxYhWKrHJ6WkAiOtZdZBmpbINtVu1aEQ8zylEo00njV31H4OnkHThEo8NsQpt7fnqUfnEbetdC0XqLstcZunzhSKdKIFlmb8eOVqHgFC6t5CU9lVEeEs4jWaRCUoPxeu+c64HY21wvTY85bFke8uc6Nn0fmoyH68c5QZy3x1b5MVeghE/YT9O5at2gjAlvdLn7DEuFL31+9N2
X-Microsoft-Antispam-PRVS: <MWHPR03MB305528180F872517902FF2629D900@MWHPR03MB3055.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(270121546159015)(232431446821674)(17755550239193);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93004095)(3231254)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:MWHPR03MB3055;BCL:0;PCL:0;RULEID:;SRVR:MWHPR03MB3055;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB3055;4:8XxtUpg+wOcp1oMQZ9kIVi1m7jb15YNfxpYsW+qCdFg4gzRzrt7/MJYJ81nS/l2dbkM00kUcm9AzGAQ/QEV9Rr8lM3FVAcoJqeoaWbgJEWOZK1CiqlA/utsplhxeJF0+RYvMSICGhQQDZhCfcpHtJvC08O+UdMb9eI91p1AjSypIWY9QuVtVcJjZYZfzNzuvIoiG9h0JGLRuZEd84C//2AEIWcwgVMv5mFRGt2yLed2sI4lT0jDXdmNmaIPeyd9meEuXVuDLEuuO6vESKzYSwHiJNxmaaxpSb7Ld6w+9/kjeI7mVPex7/NUbMl/ckZTL9l11IBxV7UksJqgCmaIvI/q18nQsUPg4opBvWgYijV/6p1Wp4h7Z6HzaOlukRSdE
X-Forefront-PRVS: 0676F530A9
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR03MB3055;23:LHZsCn1U+vrAzutGkiIpHlq6igitzBcXGfd3NdmyU?=
 =?us-ascii?Q?y8x23LMA3M9u9WMqzMHRXuBRaKjIYmRLNhkalTLDRelFUxSiZpG9iXX9MjOv?=
 =?us-ascii?Q?lcOT3kavzpsoy4jE3W9h54UCl5P7sD8t5Pr7c4I+JH2BIBymjdyug4pvSbqc?=
 =?us-ascii?Q?wiktfuN2i3Scf63detYgYbnCgSaff/9yWBtbKhUo1FpU+UyE+hi6rhzXWOmH?=
 =?us-ascii?Q?OPZksY+bJQ7VjXJnCzv1W5/c8T4PiQ7ZoyqqBrKF8B7jhdQW+MsJxIFzyqGn?=
 =?us-ascii?Q?ZaRZEEL9meBLmt/w25oKHyEmqTR3pLGD1zADLQYtqg4027FumvmiHBCH/41+?=
 =?us-ascii?Q?8ysNSJUxfa6Yf5FgrIJzt153D2napTtKb4cQyJMVld/P5Dha15afjQ+CyMJQ?=
 =?us-ascii?Q?5/uhZP5JnowHfyHiEq1fFIWm+h6toeC7wK0LZlThCvvJeqQCISrwici0FP3w?=
 =?us-ascii?Q?rj4EmoyH5GIx3elMqASE5rt5mHyGFaiwTS8zKYuNKo6jP3lAl4n6O6gCHcmD?=
 =?us-ascii?Q?uXSsaDKh1YvDZjNyW0FkNC9s04MpKGgobuN0mdaJa+iTmYegz7o6Xoj7X0KG?=
 =?us-ascii?Q?uAXD+PKcUwGmo5BLyiKRrelGS5IosLSOBYC8AB+sAvKl7tvjjdQfxWSySL4I?=
 =?us-ascii?Q?PxKgtiO8oc1cXrCEfEqStbp4jJVmW9DC+bZV/4A0aY8jp1C/9kylqFJWJ4cW?=
 =?us-ascii?Q?wLQg7iFXbBpyORlGMLzFxcN68VW+m89wcvWoWYpcPy6YKTDSLlG/6wcbZqm1?=
 =?us-ascii?Q?mhExwkgux0Yx5HwH/orQe9k9KwqHCwIlzGz+AlvgXKGIfMk8B5ReKn5XXBwz?=
 =?us-ascii?Q?RF8VZL+UiwnBKqULkWHgb2THx9K39W6yaaTh3xaEhQBxDx3HzER/y/anVQzK?=
 =?us-ascii?Q?rK51sFGiSdWCdaLNwjUIL63+G2acb0MPdXyUkz0aFij2c/UmKLryFxNLC/WW?=
 =?us-ascii?Q?Iuh90DgCmM7Nz44hXxVhWqcPxg+85TYMRzDjZfpj2RfrO8pRjq46zyuvYCgo?=
 =?us-ascii?Q?00krGqRUli6+ThpFHzzGynR025+buQ8Ebm/eQsgJi4xdiiifvZUm08fur/wL?=
 =?us-ascii?Q?V0U+wxC2SbyB8tCSVVMvf8HTb3TpuAMogfPHlnDmYl9ZeNtCQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: 2ke2/1Y+i3EgxuPkJFUkYhjJVAZjVnPKeVqM8lYEEuEqf5SMC9L4jckoW7FnwL2egeEHtuAr1Z/0r9WgwsPFAcjiF8vo/uXP2wSesdtTPLiC1wGaHX1wGB25TDOukReI56nhf/nuEdGRLRmDYF4cgqyDpDPZmWIOFgxW6DQjlRxsuS/EHV/XmZcO0bvqdQzf
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB3055;6:nUkv/F+tYBnJERnPot/mgSALf0QchT3EDJZXqvhRwqBiOwilSVG63gZEzwh2DbDGVsszxUrAND9htes13ovyy0NwrKPsuLuak7Yy7R1HQQLb5dX1IOWZoF4o6oRVt6qmh4xI8iZiWwvd5T4hNVry1TK1ZkHivhFYk5ub/9zVH1/SRIvARah9OLf1DuGa/HX7a/IWiZmRWstce4M6MuPMh6oYrK2d7Bl4dUsCuzqQeJ44Ykpyl55dvKrvjYRbvNPlCZuOjufrjfhT7QkZjSmF0KhjqR/thfNTOzqsJXYjApl/qSJvwG2SPsNOgtkyvVKXxkBZ1fThE6Gj0lmuynZ9gdwwQImuztgNpALDU3KRwhdcO9KpAtziVucOfMNsFM6c42k3EZOB7pKkr2jHx8AUPyJFT+7RhCGZi6fVqsYAuMY1tY0CV7iKLQ598IyW1wLq6xFaIOIQ+SHbCPsT6tdfvw==;5:gWDLetTURHyqCZf8UmqK9R1n7Mln3hG8nfPAZCZ+NlyuOJOpwU2Kcb56HzgqU4sUhi6uybIfYS56bvBrzR+HI3Y1WffTcqXMBx7xRfjhGD5OunekXaod54pQQWAnpRhtm0YwiMSqA/6OggxVOQzo0Zxc51FWVEFPUxd4e919vVo=;24:eauqUdjQUcXDt24FPrgS5i/cCoP/jRisjaNaIBjekz0KgN2mKMdZuO3Qh2XW7c1dXMKCxWvH2IJTTqu2FX3CggRYGKmoBeTTvO1pIcZ6y9c=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB3055;7:fAVxLMGlI3p4RRU7MCbX3Utct6l5MqEVptyyDEQ22Lsu2xc0YRoA7jpKWeDvBgXGNvdi5Dy+ZcIVPyzKqaSTPLRkPI3fKCZunH7wctF9XH1mMbGbTe9+hbeURq9JWqGvEa/usl79605eIp/YouS/LAzO4sQAoBntqlVSkNGzY5J+E8+4rcMjcvCM/d3i779yR2FfMFHnmcWy0aDlhlPy8115kR4yoGHlmSBb75uJNrXY9g5DgYRHPlezBkBN+KcE
X-MS-Office365-Filtering-Correlation-Id: 9edaff5b-c9ab-41fb-0752-08d5bcca1a0a
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2018 14:17:34.8137
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9edaff5b-c9ab-41fb-0752-08d5bcca1a0a
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta4.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR03MB3055
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
index be803e8..1719d51 100644
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
@@ -254,6 +258,29 @@ static const struct ad5686_chip_info ad5686_chip_info_tbl[] = {
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
@@ -383,6 +410,11 @@ int ad5686_probe(struct device *dev,
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

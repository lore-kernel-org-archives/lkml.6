Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752500AbeERPXO (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 11:23:14 -0400
Received: from mail-cys01nam02on0069.outbound.protection.outlook.com ([104.47.37.69]:31184
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752054AbeERPXJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 11:23:09 -0400
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
From: Stefan Popa <stefan.popa@analog.com>
To: <jic23@kernel.org>, <Michael.Hennerich@analog.com>, <lars@metafoo.de>
CC: <knaack.h@gmx.de>, <pmeerw@pmeerw.net>, <linux-pm@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stefan.popa@analog.com>
Subject: [PATCH v2 1/2] iio:dac:ad5686: Add AD5691R/AD5692R/AD5693/AD5693R support
Date: Fri, 18 May 2018 18:22:50 +0300
Message-ID: <1526656970-28852-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(39380400002)(396003)(2980300002)(438002)(199004)(189003)(36756003)(2906002)(110136005)(107886003)(54906003)(4326008)(16586007)(6306002)(8666007)(316002)(426003)(2616005)(476003)(126002)(47776003)(486006)(336012)(966005)(44832011)(59450400001)(106002)(72206003)(26005)(186003)(2201001)(53416004)(575784001)(478600001)(50466002)(7636002)(305945005)(50226002)(48376002)(106466001)(5660300001)(356003)(246002)(8936002)(7696005)(51416003)(6666003)(8676002)(77096007)(309714004);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR03MB3044;H:nwd2mta4.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BN1BFFO11FD014;1:QMbi4dG2Tnhlv3V4sB3eF6H2sz/GEc7l7Be1qIQs/v8u9Z2OCklo2Rd7QjZU++nKcoaKBlYNlT/lB3LY5bilQVPx2DWTJasabk3Cru/EBrf+ycInm5wpOtOOIJul6gW8
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:BN6PR03MB3044;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB3044;3:xmRyLa1c9HxqyV7TitgWExSLO9KXMkE0kcHjlnr+olbiHsj9QObF41PXhG77VYlXOsWmps5OSxYSlCYt5MkRQRgj1/p0ZHKVOJ3q7ySO0n6Z0QQfKGMWpD0bH0k264HIfS2GM9Bu3dwtCpsiTfB9TtbGIkTr84xkkqhl3v/Fem0WvHnBxaPxSNxs02xhPn1f1M54Q0FaaGtAKjIUIA03dHkBqiEJafXGGoVtzdLu1eU2Nszus5feF92EFY1XSr/XlpP4XjSDJeWyT8Y9vWNU7E2bD7nvUt22bIq0w1pBoRHRO1JAGQURT06aWhHBfDq7wkHQZEN7+01NwrHquku36Kw/V/GM+V0KSMalnngKmww=;25:7ZrRXdGKQ7umTrFs1jDhm6RKniNnMjWrK60MLLNKf5PKJbyOrvF3ZkhARPgP8IXQYSHKSXI/S8xfcDk7ZKECqcEcV9QuHlwctng1PwTu1V3LOwtKqE4YEJXf7bgLI8uZXPiULk5oaz+HU1Jkj/iDIPuTnSthD7pt13aXEcuSwt84Pa0Sro4opL55yS5NNitfb4KUDlTJunBPQnPUHenyL9ezt/+aShSDQ57y2HUYHjXzLhr5+TtiKij2JIFfllNdWW7XBqiLb3Cgiv6R2iMiPeosXtOKjt1yQX5sCRD+RGklOvoBSUAXr6ZgBkomxZwKx5Q2qLS+Z/H4QBzaQqHTbg==
X-MS-TrafficTypeDiagnostic: BN6PR03MB3044:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB3044;31:N4ImzMJnYbHQuxb5bRnHg5sTKNe2MqWInxU50CuCLQTgYavbjl7K7VVIKYuv9O4xWqrFvXGR/d7K0VEYqRpCNtZSD3T63aya9Qi6QkuMm0C8Dh6nIiFyaTjCBzPkZzP4Ht92uwlSu5ckBjWbnHveyVJZwfIcsbySOz3xvivEhxBA/y0Bzhj+uTSUxxO8mLWcpHOoPr1hGppcrOc1EKHwu2eQ6qfVIJ/g3JVAvtNYCSM=;20:plTh0QaWieM2xix1qBkdlQiCxHO4xn7vcilUND7gVURJbVSIYpgqnmA27KJ8Zvc4hnsROJCzCyIpcDLi6FBC99DZOiymdybPttrKH6v8VOfBr7cV7gb5egR23jjwQru5Fi3O4Y0L5yqCGWf99Qn32TpChv7Q3XcKlv6++0n76jWEFA3HH0wesxr62DIZCNtVXF9gB5oNoLqj5QiZ6k4aZ/oRAcQHRla4KEh1TqxUQVPJILKfQt0CslQU7b0Zs489kjv9WLS2chttHzHhYg9JTVH/Oj9LR2wH7b3W1hSUK86M2xzQbfTlZyZ9Oe+CmO+gTNU9d601i8J4zynFgP9JBNtOACz6Y7XPSPAp1V3cVCe3kMNNbHc4jv7vaAc+rP05RLYbaT0JoQzJv6hi3GUBlEWsmTlNZq386QpYrLXU2ylZERibqHfvzaQGaFvrh9tQM0vDgPDIah1mlCarQ7uL8sWB9pHhIPbU5+iNV8hRYeynuDATxhq5za14tis4gW6u
X-Microsoft-Antispam-PRVS: <BN6PR03MB304403B6BA17ED7CF11B67549D900@BN6PR03MB3044.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(270121546159015)(232431446821674);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(10201501046)(93006095)(93004095)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:BN6PR03MB3044;BCL:0;PCL:0;RULEID:;SRVR:BN6PR03MB3044;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB3044;4:qUR1S67chCDmIXbdYaRraljrBc7B6N4ChlC//DMeXsTsP0sDxQOB7/PowDo8msxCxhS2d8SID94jlRyONcXvyW6eh8rsg4k+edZv+l+nyrReTSFPNUGhNof+2xxqeJQ+jkMnqy0zkxYn3P+BLNQAPeqDe0aMxbS3Z5SeIMubJ1z/GlyNov+u37+oIzEKmYsAMK0DPnY+gXbNOgUahz+jCUss6Jaq9RVJ4ooVSmTo3iV3RqIjlGA26zZVz8NIJMnau0SS5q8XrLXMNUrMTbvJpq7iZYgoYqC0uV+GUVKa0zqorVlaE+57TliHLWkQ01MngMs7Bj7Skb2fVNUFNE1V716qWZ69xzCOloqSuiMEYGQ=
X-Forefront-PRVS: 0676F530A9
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR03MB3044;23:Mv1wq5zVVgThaId9trh4evQfLnDPs4dP+7jghyGB0?=
 =?us-ascii?Q?gIXws3vSby0THdZOC5biITePbMQ1KVNmRC9gE6k2aT+fSjEYsv+RRiK+j54v?=
 =?us-ascii?Q?PBJWwUvms0Lsly/uLv0lbWK86iK1X+PfuZnKFvtn2KXFndWhQc+x+n4o8n1a?=
 =?us-ascii?Q?SYAWjsnVA2EN1+Ofd6Vg4xzpbna/nr4GEaN91WAyIoqjsfuMdcIVjJSM3kaU?=
 =?us-ascii?Q?621VtvF08cbzCWNnVuKCbVgUG+fTxNhAaSRo+w98ZgK8w4KXtuLi4G930rJ8?=
 =?us-ascii?Q?aIyhlToY1Oqqh5vtA+padp3b8RDMc+2iHLv+1+bEHw3zbkA0mVBtTbSImkvV?=
 =?us-ascii?Q?oZxslnZ9OEyQ8omFL9cODc2zLoWrRiM2+jmLe3TzDQcxvzOrE+E9X5+6ZDxK?=
 =?us-ascii?Q?L/YlN/ihVvCdVl+PP9QX0akchMVUYp2K05B6bph4/CtN89UYEmikxjJOUN1J?=
 =?us-ascii?Q?1+ZHCpjm9Z60354t0Gok9AvUgPE55VyYB57ToDwQgkkLXWRwf4FSfGf2jwV2?=
 =?us-ascii?Q?JBH+33QdUV2guDoN4yX91hX0E/0tP7bl6B1n0vQbgMG2zXBGF83aH3LTD8ny?=
 =?us-ascii?Q?oD259sDIZ/yqhA0J5D2pGY6PxaLWhiOxaSktt3EkMtUS5ouonC+n+M/Qh7dO?=
 =?us-ascii?Q?4/56VJ7cwUuxO6pcotDzxxWNu6/moOzyJzIg7o+DQoE6vyTpNasBDiUq8Gpr?=
 =?us-ascii?Q?64UpxF+G11SA//z2QOuekZrm713+76CxHcaVHfKgaKq33hW59VtwAng+Eb3a?=
 =?us-ascii?Q?OObNIxFBZoKm22uvrC9eA4jPqq4ipygFEv16cCfVFMXvDk13hl+MByWoIDgr?=
 =?us-ascii?Q?i4YlJqD6WzUXegJYpjhq6OMmc4FAKT9LogfEpiK2WkjxSckZ8+8BJs9zo4t3?=
 =?us-ascii?Q?ACPjtj5xecDaegfI6xkyLCqb5T2FqCGQyXCiH/dX9PtTL41aSovNhz5lu5SA?=
 =?us-ascii?Q?uPLawuFuy+l50bLkL8e595MlwxlSvb5Fgw26JaycR7F3yx8mysxxSCanCNN0?=
 =?us-ascii?Q?MO2uF/Y6KIqBH07ZiEfzAK6eNKa4BSY+SoVQfbPtFoLT8bhxXSabaVFqOQbK?=
 =?us-ascii?Q?okbmpn/m9XgEV44qa06O0x/Bo9ZOGz3GAy+VEhKdnAmc9RI/1j4eLVNRBfTQ?=
 =?us-ascii?Q?H+rPiBIMgeK8sTi477uR3nSMnk8zx7B6jcNteIsZGs5J5FOE4VtgdMEklGU8?=
 =?us-ascii?Q?cANQcUiYtwYElE=3D?=
X-Microsoft-Antispam-Message-Info: c4jiwgQs0087vfRom+zgDkj38rQ+WhimQzluWhGe2bK3Cl8V2mPet6buQ4DfOydIJDS3UUAXhyhTVDtXTIYPwjaSrAnDx7SVT3PBlhpo6E4hXyetsBEWTakzYD8uayx1rnojmxl4370zAEBmbSj6loCLhoXK7XhzhzpqZNPQJxkKsl1oB+6hxzoj1YsngqK0
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB3044;6:knYG+A108dfLSa9+Xu9GwF5IXGMRFmgTWKkxEAZna2SkmmC6MszsxOjuYwS3DEVcUbewLPkhZH4ya+90MsHX/aG970ziAWLCW+HN1WShK5lvrVjuT2Pv1gtWLDsM7T0He0SqiFLSKytNQapoIi9mRz4gTGgzfQHq0wwGPvX/Qc4EiYkD7xZgpyUf+UDe729IEIlvK+/QTIYJgusz02iHG7VNJIS2GY5oxZ5EPGZbmhajXIGesPrxGEVoITCXszmt0qdfIKTHTGtluOKscagA+W44opdB5VImcpHUXhfvFLsrOvZexeRRBVdXwZlHD4vaTgFpyKpMah2JMlRzrK6FqSEJeR6lh5yQiazjH/LtTicNN/CQ/8ydR8col71DRiIXIK78GpGQfJJY3zjAF5o/QuDMz5ta+r8y77/8GOJ7HX7frXmy0Xa2ivydU12sG6WqP2TrGdcuSqr3mfDiz6M0Sw==;5:AXxBof4Xjt0T5VMxLFsKP8PCrQvaZ/lp30BAl23gzkvi/mD+ou2m3HA3lnQkfMeEATtdIwkNqIDKMdVh3r3YJDY8VElQDchc0CuVnktnvBeJGEzIEMiv3pwJchbQB6SzKJye1vWENYwUITVB9aJ2u4FovXnxWtYK+LsB5sHw2Ig=;24:Uah+8j89weaGSKty53jyjcF4h6wszxGz60F3HjDUa3hUYq0ackbpWWEUOh50I1paAXm8GPLyj8cJhM1XPLW1Oi5oKlvhsn9vb1h+w1/0alA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB3044;7:lqXNXh3EMxnZYjk7bCuN+cizNxwd52eDOyXQLECA1xfwSsgmkvlAuow97Sq7AGO97lBF1FhqIcviGw8ykOx+/giMdQ9hjm10ZiBeE2H0BlWAWC8vmiNHCEPrcyHEHPLgyBlPfE5/pbSJDEgxdwlaoVMcyOzcZHKcKIRSYY63KvvBxVjbq5X6OjY5hQDXMJ7YaLHdA6/AO8i2bDaf0QtC1rHlk8vTuq4D2F1ZQ+Xj2ERsMPX+MvWkrVoUrVGfsZHT
X-MS-Office365-Filtering-Correlation-Id: f0c34a9d-888c-478f-7281-08d5bcd34183
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2018 15:23:06.4956
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0c34a9d-888c-478f-7281-08d5bcd34183
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta4.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB3044
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AD5691R/AD5692R/AD5693/AD5693R are a family of one channel DACs with
12-bit, 14-bit and 16-bit precision respectively. The devices have either
no built-in reference, or built-in 2.5V reference.

These devices are pretty similar to AD5671R/AD5675R and
AD5694/AD5694R/AD5695R/AD5696/AD5696R, except that they have one channel.
Another difference is that they use a write control register(addr 0x04) for
setting the power down modes and the internal reference instead of separate
registers for each function.

Datasheet:
http://www.analog.com/media/en/technical-documentation/data-sheets/AD5693R_5692R_5691R_5693.pdf

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
Changes in v2:
	- Removed the initialization for ref_bit_msk and shift variables
	  from ad5686_write_dac_powerdown() and ad5686_probe().
	- Added the the missing default case from
	  ad5686_write_dac_powerdown() and ad5686_probe().

 drivers/iio/dac/ad5686.c     | 93 +++++++++++++++++++++++++++++++++++++++++---
 drivers/iio/dac/ad5686.h     | 16 ++++++++
 drivers/iio/dac/ad5696-i2c.c |  7 +++-
 3 files changed, 109 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
index 89c5f08..1fc0c56 100644
--- a/drivers/iio/dac/ad5686.c
+++ b/drivers/iio/dac/ad5686.c
@@ -70,6 +70,8 @@ static ssize_t ad5686_write_dac_powerdown(struct iio_dev *indio_dev,
 	bool readin;
 	int ret;
 	struct ad5686_state *st = iio_priv(indio_dev);
+	unsigned int val, ref_bit_msk;
+	u8 shift;
 
 	ret = strtobool(buf, &readin);
 	if (ret)
@@ -80,9 +82,24 @@ static ssize_t ad5686_write_dac_powerdown(struct iio_dev *indio_dev,
 	else
 		st->pwr_down_mask &= ~(0x3 << (chan->channel * 2));
 
-	ret = st->write(st, AD5686_CMD_POWERDOWN_DAC, 0,
-			st->pwr_down_mask & st->pwr_down_mode);
+	switch (st->chip_info->regmap_type) {
+	case AD5686_REGMAP:
+		shift = 0;
+		ref_bit_msk = 0;
+		break;
+	case AD5693_REGMAP:
+		shift = 13;
+		ref_bit_msk = AD5693_REF_BIT_MSK;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	val = ((st->pwr_down_mask & st->pwr_down_mode) << shift);
+	if (!st->use_internal_vref)
+		val |= ref_bit_msk;
 
+	ret = st->write(st, AD5686_CMD_POWERDOWN_DAC, 0, val);
 
 	return ret ? ret : len;
 }
@@ -175,6 +192,11 @@ static const struct iio_chan_spec_ext_info ad5686_ext_info[] = {
 		.ext_info = ad5686_ext_info,			\
 }
 
+#define DECLARE_AD5693_CHANNELS(name, bits, _shift)		\
+static struct iio_chan_spec name[] = {				\
+		AD5868_CHANNEL(0, 0, bits, _shift),		\
+}
+
 #define DECLARE_AD5686_CHANNELS(name, bits, _shift)		\
 static struct iio_chan_spec name[] = {				\
 		AD5868_CHANNEL(0, 1, bits, _shift),		\
@@ -200,72 +222,112 @@ DECLARE_AD5676_CHANNELS(ad5676_channels, 16, 0);
 DECLARE_AD5686_CHANNELS(ad5684_channels, 12, 4);
 DECLARE_AD5686_CHANNELS(ad5685r_channels, 14, 2);
 DECLARE_AD5686_CHANNELS(ad5686_channels, 16, 0);
+DECLARE_AD5693_CHANNELS(ad5693_channels, 16, 0);
+DECLARE_AD5693_CHANNELS(ad5692r_channels, 14, 2);
+DECLARE_AD5693_CHANNELS(ad5691r_channels, 12, 4);
 
 static const struct ad5686_chip_info ad5686_chip_info_tbl[] = {
 	[ID_AD5671R] = {
 		.channels = ad5672_channels,
 		.int_vref_mv = 2500,
 		.num_channels = 8,
+		.regmap_type = AD5686_REGMAP,
 	},
 	[ID_AD5672R] = {
 		.channels = ad5672_channels,
 		.int_vref_mv = 2500,
 		.num_channels = 8,
+		.regmap_type = AD5686_REGMAP,
 	},
 	[ID_AD5675R] = {
 		.channels = ad5676_channels,
 		.int_vref_mv = 2500,
 		.num_channels = 8,
+		.regmap_type = AD5686_REGMAP,
 	},
 	[ID_AD5676] = {
 		.channels = ad5676_channels,
 		.num_channels = 8,
+		.regmap_type = AD5686_REGMAP,
 	},
 	[ID_AD5676R] = {
 		.channels = ad5676_channels,
 		.int_vref_mv = 2500,
 		.num_channels = 8,
+		.regmap_type = AD5686_REGMAP,
 	},
 	[ID_AD5684] = {
 		.channels = ad5684_channels,
 		.num_channels = 4,
+		.regmap_type = AD5686_REGMAP,
 	},
 	[ID_AD5684R] = {
 		.channels = ad5684_channels,
 		.int_vref_mv = 2500,
 		.num_channels = 4,
+		.regmap_type = AD5686_REGMAP,
 	},
 	[ID_AD5685R] = {
 		.channels = ad5685r_channels,
 		.int_vref_mv = 2500,
 		.num_channels = 4,
+		.regmap_type = AD5686_REGMAP,
 	},
 	[ID_AD5686] = {
 		.channels = ad5686_channels,
 		.num_channels = 4,
+		.regmap_type = AD5686_REGMAP,
 	},
 	[ID_AD5686R] = {
 		.channels = ad5686_channels,
 		.int_vref_mv = 2500,
 		.num_channels = 4,
+		.regmap_type = AD5686_REGMAP,
+	},
+	[ID_AD5691R] = {
+		.channels = ad5691r_channels,
+		.int_vref_mv = 2500,
+		.num_channels = 1,
+		.regmap_type = AD5693_REGMAP,
+	},
+	[ID_AD5692R] = {
+		.channels = ad5692r_channels,
+		.int_vref_mv = 2500,
+		.num_channels = 1,
+		.regmap_type = AD5693_REGMAP,
+	},
+	[ID_AD5693] = {
+		.channels = ad5693_channels,
+		.num_channels = 1,
+		.regmap_type = AD5693_REGMAP,
+	},
+	[ID_AD5693R] = {
+		.channels = ad5693_channels,
+		.int_vref_mv = 2500,
+		.num_channels = 1,
+		.regmap_type = AD5693_REGMAP,
 	},
 	[ID_AD5694] = {
 		.channels = ad5684_channels,
 		.num_channels = 4,
+		.regmap_type = AD5686_REGMAP,
 	},
 	[ID_AD5694R] = {
 		.channels = ad5684_channels,
 		.int_vref_mv = 2500,
 		.num_channels = 4,
+		.regmap_type = AD5686_REGMAP,
 	},
 	[ID_AD5696] = {
 		.channels = ad5686_channels,
 		.num_channels = 4,
+		.regmap_type = AD5686_REGMAP,
 	},
 	[ID_AD5696R] = {
 		.channels = ad5686_channels,
 		.int_vref_mv = 2500,
 		.num_channels = 4,
+		.regmap_type = AD5686_REGMAP,
 	},
 };
 
@@ -276,7 +338,9 @@ int ad5686_probe(struct device *dev,
 {
 	struct ad5686_state *st;
 	struct iio_dev *indio_dev;
-	int ret, voltage_uv = 0;
+	unsigned int val, ref_bit_msk;
+	u8 cmd;
+	int ret, i, voltage_uv = 0;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
 	if (indio_dev == NULL)
@@ -310,7 +374,8 @@ int ad5686_probe(struct device *dev,
 		st->vref_mv = st->chip_info->int_vref_mv;
 
 	/* Set all the power down mode for all channels to 1K pulldown */
-	st->pwr_down_mode = 0x55;
+	for (i = 0; i < st->chip_info->num_channels; i++)
+		st->pwr_down_mode |= (0x01 << (i * 2));
 
 	indio_dev->dev.parent = dev;
 	indio_dev->name = name;
@@ -319,8 +384,24 @@ int ad5686_probe(struct device *dev,
 	indio_dev->channels = st->chip_info->channels;
 	indio_dev->num_channels = st->chip_info->num_channels;
 
-	ret = st->write(st, AD5686_CMD_INTERNAL_REFER_SETUP,
-			0, !!voltage_uv);
+	switch (st->chip_info->regmap_type) {
+	case AD5686_REGMAP:
+		cmd = AD5686_CMD_INTERNAL_REFER_SETUP;
+		ref_bit_msk = 0;
+		break;
+	case AD5693_REGMAP:
+		cmd = AD5686_CMD_CONTROL_REG;
+		ref_bit_msk = AD5693_REF_BIT_MSK;
+		st->use_internal_vref = !voltage_uv;
+		break;
+	default:
+		ret = -EINVAL;
+		goto error_disable_reg;
+	}
+
+	val = (voltage_uv | ref_bit_msk);
+
+	ret = st->write(st, cmd, 0, !!val);
 	if (ret)
 		goto error_disable_reg;
 
diff --git a/drivers/iio/dac/ad5686.h b/drivers/iio/dac/ad5686.h
index 05f0ce9..6c6879d 100644
--- a/drivers/iio/dac/ad5686.h
+++ b/drivers/iio/dac/ad5686.h
@@ -35,6 +35,9 @@
 #define AD5686_LDAC_PWRDN_100K			0x2
 #define AD5686_LDAC_PWRDN_3STATE		0x3
 
+#define AD5686_CMD_CONTROL_REG			0x4
+#define AD5693_REF_BIT_MSK			BIT(12)
+
 /**
  * ad5686_supported_device_ids:
  */
@@ -49,6 +52,10 @@ enum ad5686_supported_device_ids {
 	ID_AD5685R,
 	ID_AD5686,
 	ID_AD5686R,
+	ID_AD5691R,
+	ID_AD5692R,
+	ID_AD5693,
+	ID_AD5693R,
 	ID_AD5694,
 	ID_AD5694R,
 	ID_AD5695R,
@@ -56,6 +63,11 @@ enum ad5686_supported_device_ids {
 	ID_AD5696R,
 };
 
+enum ad5686_regmap_type {
+	AD5686_REGMAP,
+	AD5693_REGMAP
+};
+
 struct ad5686_state;
 
 typedef int (*ad5686_write_func)(struct ad5686_state *st,
@@ -68,12 +80,14 @@ typedef int (*ad5686_read_func)(struct ad5686_state *st, u8 addr);
  * @int_vref_mv:	AD5620/40/60: the internal reference voltage
  * @num_channels:	number of channels
  * @channel:		channel specification
+ * @regmap_type:	register map layout variant
  */
 
 struct ad5686_chip_info {
 	u16				int_vref_mv;
 	unsigned int			num_channels;
 	struct iio_chan_spec		*channels;
+	enum ad5686_regmap_type		regmap_type;
 };
 
 /**
@@ -84,6 +98,7 @@ struct ad5686_chip_info {
  * @vref_mv:		actual reference voltage used
  * @pwr_down_mask:	power down mask
  * @pwr_down_mode:	current power down mode
+ * @use_internal_vref:	set to true if the internal reference voltage is used
  * @data:		spi transfer buffers
  */
 
@@ -96,6 +111,7 @@ struct ad5686_state {
 	unsigned int			pwr_down_mode;
 	ad5686_write_func		write;
 	ad5686_read_func		read;
+	bool				use_internal_vref;
 
 	/*
 	 * DMA (thus cache coherency maintenance) requires the
diff --git a/drivers/iio/dac/ad5696-i2c.c b/drivers/iio/dac/ad5696-i2c.c
index 275e032..d18735d 100644
--- a/drivers/iio/dac/ad5696-i2c.c
+++ b/drivers/iio/dac/ad5696-i2c.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * AD5671R, AD5675R, AD5694, AD5694R, AD5695R, AD5696, AD5696R
+ * AD5671R, AD5675R, AD5691R, AD5692R, AD5693, AD5693R,
+ * AD5694, AD5694R, AD5695R, AD5696, AD5696R
  * Digital to analog converters driver
  *
  * Copyright 2018 Analog Devices Inc.
@@ -72,6 +73,10 @@ static int ad5686_i2c_remove(struct i2c_client *i2c)
 static const struct i2c_device_id ad5686_i2c_id[] = {
 	{"ad5671r", ID_AD5671R},
 	{"ad5675r", ID_AD5675R},
+	{"ad5691r", ID_AD5691R},
+	{"ad5692r", ID_AD5692R},
+	{"ad5693", ID_AD5693},
+	{"ad5693r", ID_AD5693R},
 	{"ad5694", ID_AD5694},
 	{"ad5694r", ID_AD5694R},
 	{"ad5695r", ID_AD5695R},
-- 
2.7.4

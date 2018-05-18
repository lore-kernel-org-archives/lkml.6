Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751542AbeERORP (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 10:17:15 -0400
Received: from mail-co1nam03on0042.outbound.protection.outlook.com ([104.47.40.42]:30016
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750977AbeERORK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 10:17:10 -0400
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
From: Stefan Popa <stefan.popa@analog.com>
To: <jic23@kernel.org>, <Michael.Hennerich@analog.com>, <lars@metafoo.de>
CC: <knaack.h@gmx.de>, <pmeerw@pmeerw.net>, <linux-pm@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stefan.popa@analog.com>
Subject: [PATCH 1/2] iio:dac:ad5686: Add AD5691R/AD5692R/AD5693/AD5693R support
Date: Fri, 18 May 2018 17:16:34 +0300
Message-ID: <1526652994-23401-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(39860400002)(396003)(346002)(39380400002)(2980300002)(438002)(189003)(199004)(16586007)(72206003)(966005)(54906003)(478600001)(6666003)(106002)(110136005)(316002)(426003)(48376002)(5660300001)(476003)(44832011)(486006)(126002)(2616005)(50466002)(336012)(575784001)(6306002)(106466001)(53416004)(50226002)(7636002)(8936002)(186003)(8676002)(77096007)(246002)(36756003)(2201001)(305945005)(59450400001)(356003)(2906002)(47776003)(26005)(107886003)(51416003)(4326008)(7696005)(8666007)(309714004);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR03MB2484;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2FFO11OLC015;1:HBa5Z9TopPRy8zkPah066uz7hJAU2PVXHvVWMqPCxjrkNSnQbh6juaQzwRmMdkrwbGd1HnAMeGUao5IYsOFAlF9ZrnF87rdXD3l3aOJCaWraHiNHklKvRWBfffPHkAwF
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:BN6PR03MB2484;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2484;3:+AIM9HhDqNaBuYjEFUoHlBmvCMM8nM9bY1KxKy7uE7ej7mIDmltSqTfySrO0BlAgFzeptgn7iYw6GMtpxp5a/gKmHD45pqFER5T2dtVmm3u5YrCXMa7v1K1jgOLb2oneTfYaeTepyZ3SbyYpFo98owTtIGv+ZO4CO0x0NPWdjvZhOLWqhOst3H/RtvQBmLq5wp+yW7Djgw2y0CZfyxDVH0+D3rsDRTGQ8ZtuGc61VBMjIxw6cMkqp0ZY6Kz4xDxoJS9iBbGqiCMWqHi1rfIBemHkeUA9m53XtGa72yoZxFwINgqasSNP7AxGcKbXaj4yxV8/JNCj9+FxcmF+uNCXh07S56rhIbnOYAC9ycks1OE=;25:djaiiCHntejvU35n7Y0Oz4wuvvrXNUzeQi+g/ZYprQbUQiu1CM2l8ZtIRzZOFe6CaIWz/r1eCyMlIkmvo4i/y9rfONd7jhG6W38gJkwWh0S6eLPqNBfWcAHXGuY8/IUuPU/GX+T+QEvLF6KV6NwUyUozRB98Cok+Utb92W7NFa1Aqn0GGEx220aBMoX9+wRY2W21FdREeim28o9UeMvPuvRtZsdh/n2hCIjRvKPa742bB2kx4iVMaYvj7wLuRYCoLTO98jc2BRBcOpLgFeXpQKT2VOGMF7S5YPvvFncgE4S4Rv+6p8CVxNWANbzaA1s4YExfyiU9GGuJqM3zO0fySg==
X-MS-TrafficTypeDiagnostic: BN6PR03MB2484:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2484;31:SxpUdFLOC48K+2tx2lPLvEJOvhQxikuOkqY8eMHwhcoCIG0tyQb9E1vVdy7SfpRk49cF61WK3dfYJrczjEy/ucHEyL8NOspChJIVmtzShZdSmgTXx/F5HI2EXKBS8PXfbXxPBf/BUM8EbBL9iJ3y+D+45GmRRThGTH4teyahuuxOREdYRJv8sILugi3cnA+bdu+KsjSh1N7PxKc5vsBv//rCSKbgAcE/Ohsn5ldAfKc=;20:Ya1OQtcJaHcScsW9t9gaEabSRkDU+fiNjJCoPvQ7K0teEMOrkVh5Tz+CE3Dnjq9tSDEY2Z8qQwjV4qhjHVJZc52/CwA4Vi2krLgyqoP7zNw1C/E9AjEm61xexnGQGqkeR2kADpUyNIYzCFEeG18eoJSKrdXHqKEBuS4Y4hhj5ajy5e+hjnuHe6UYKPU2jz3BPD1SLG7w9Mfu2joG5GQIbZbVXlGH4OnAnXd1BOlLYbpdWIfZlgMmNj8onF9Ju/rwBCvcmIrqqyLhBowIpI9aBlLcwFQZrik3KXw3aYkAUwOYPCMZFqC5EvbfBi9OYF4WkSJimqPqt+XpPd1p4zQ3/b9b7Eqgjeeh8XVx7A/+LhnMoiOnLgetfKawr3ToValUBfkSDonzxdNwxIZJEMafgPiS/5YZj2nzkDl9NnpDq6W9/mxmfU9tda7vD43LGjmd7aJTMtJ0zaaOafx7cYwu0jBcb7uz1rgajkfN08UalWTZKeq1N8QzaTAR0JVGzBh4
X-Microsoft-Antispam-PRVS: <BN6PR03MB24840BD7729563CCFC9213AD9D900@BN6PR03MB2484.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(270121546159015)(232431446821674);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93004095)(3231254)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:BN6PR03MB2484;BCL:0;PCL:0;RULEID:;SRVR:BN6PR03MB2484;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2484;4:X1Dti6NiAc0yyCLRguiDV8epMFvETqAzq+qeflFdTrPLqMDNWN5iyUiebuNwrD7eNG7qgawmOggiuD6+ehVvujL0rk0Gaa6X4d+R+A3yxW3lqj9Tde06QB65pGDOMqz2gej4uG9ELBfEkRyZitbp3wlFkP7KDPZuAwtHlWBnqtunDXegVILa7yFzjLaz6wFXo9TAcb2hDaN6vNBrCOjsl17ydncRWwlb1RfVlc9TjOSv+866V248EmCuEJEJjUtUIaizoBZquOc2kPHvNgTe1iHC5mtATnA1e2G3RnaLVxKpZB0+5PcTAJNoyESuSufjGM+duqh1Pbn3opJH2T149L3+7eqBiDSsqVFcbGtmUQ8=
X-Forefront-PRVS: 0676F530A9
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR03MB2484;23:Pk/WIk3MCkBpzn78A6lPn1SgzJVAzrMAhlguwO+eW?=
 =?us-ascii?Q?yqWWJc8QeOOrJqQl32BSZvJZ9MmsrOQG/rlCcjTpreo+0bRGhmaRqYChhXpS?=
 =?us-ascii?Q?ZTWZyhQmUPBdwuXA4pxO8eb5N27XwbqcuXCOJ0N6e/YNt6FmtFleT3lnWKS7?=
 =?us-ascii?Q?Qo3nJHKI+8A00MdrqJHaunrY7LTHAA1mu+BsTDAy0Sfx+iLEislgB1JIFRow?=
 =?us-ascii?Q?+jcrkYFhZg9dD/STRbtG3LRa4PINksOU9Rs21bH2oOLaw+VQQC2BmNMwXwPP?=
 =?us-ascii?Q?dQXNg5bpdcO9V7CEvhDDu2LvtyYQl2xBd2VzCZI1Px0MJcy8ONubBHStDjpa?=
 =?us-ascii?Q?kx2a9O3fvQgjk37T1ZKK7ZaexufsgJidrp3Fd8IfeZbPv0ZUKGpuYrNwbHHT?=
 =?us-ascii?Q?5ye8nIsEShMe0V2eB/D5GsgfjeIFPlcGyGY8lEvoPBGZr5wggKi75WDQVsdS?=
 =?us-ascii?Q?VtCFKf2goZ+RD+uF/S+ZR4yUVTGKT4MTpcO+rKaUuFuIJE4FA24u46WGwFS0?=
 =?us-ascii?Q?dQYPLcJS7W2tfgl1NyONwHGQjbPjPf6YvAzxJvmfF9AdCLQlU+o9xXTPJeuJ?=
 =?us-ascii?Q?JEO85xq0Oy9ysMd3hYitDV3Q99T0qB7/zBJXvxjZLLXP9eFa6Ic0H9JQiLpn?=
 =?us-ascii?Q?ojDRLOdMRBtzXOgcwWhJ3NJ0RCxVznWjAh8yXydpWiGJHIW2PfxKcMegTZ9c?=
 =?us-ascii?Q?t/Uf+397+cLlr9SZh2PCFH9flXw0wylpVEj1fe9R458PPhf3s6xg+LdYBp1W?=
 =?us-ascii?Q?iuCFKaJuz0y1JCfkSeGhWAXTPTb7M1538MbWodj8mbF9yI4ny1/V/5Jxy/7g?=
 =?us-ascii?Q?RLxDGQZHvRApO9hMc5y3PRU5Pw2J6kXkxhnWdJm4DMDxxaLZyLIPdMBUNksU?=
 =?us-ascii?Q?T0B9v/bQ7tkv/UiIIfcTux4rO6FVzf40VlOvdMciKwmmNwi5B/LkuG/NWAI1?=
 =?us-ascii?Q?SGGAT4XWwVmvlZM4TOAFKaV9XVi+KfGAci4nZJDiObLtUMfihinzRQSru741?=
 =?us-ascii?Q?q8t2YVStTlau3Edj7MFx+in8DT+5wr4IfFSP5DlpuW+/UNGTkTlvN+euERwa?=
 =?us-ascii?Q?bjhp0lAIklh/QA1CSza/Y6rqJhHszUQJwTw69AMM2YWvTGmO/aBxfdQsRwKS?=
 =?us-ascii?Q?FvsVUjf6O0+DhqEQEr1dg74WvkGACxG7UcDp3FJ56vioXys5VYwiWJraW1h0?=
 =?us-ascii?Q?vtnMb52i5lfNWE=3D?=
X-Microsoft-Antispam-Message-Info: Fuo/D/uffEJAHelj0Dnrb9nMAc9V9I9ezXQBI1xNUxtp90qZpCZqdAbPJUQrkPrTr3o5UdVN73BJ6efI+deJZZSQLO7+HAu4wfMoAnpa/u6KbHZxkj6mbNpf14toY2Av+2ZfiJGBwVpizBQWywmd5kHBmf/pJbPcgilgQg5YoQ2NvJxMen4TIoOla4cZ0hFP
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2484;6:abl462uvXYSRts2L5IrUXOCeWTcQp27ENF3awFOePoewONLZGJY62jcXrTL77B+QSWtNgHsquqNI8U1dwGvWuw4momoaIRQMWc1rqfbBnBlKEYtciLSIdUWTCM1IPujpi3EYr6RfDhXeM0HVylrKZW0+tlP6NNDljJAklpcn/LsrVMzQyU2+pFVT7Cxnf6WOmd09LZ/BHTH/xEGs6ipNK1zoaZjPIzOybIrqYR19zxxrwi/3LfpUyojRor8KUpbnGmlXjvr1o3Rh58QtXmf8Xc38OQTnDRsKdCE+0g/5JhUChHFpKAmX8ILgY7ccOEWlqEp/dPKw+BqjQ751CP2Zot2s6shk+hQQStClo98D8MqDCieoZ6n19t+DiEuYC/UNF/9z+ZQUnDSfhYkFAXETEsCfrQf1khL9BmPLVEc3bm6WOhsOdTnwJ+SNny4RsTZLf4rEKTpQ4awBT8Ef3+Jx7A==;5:Qo2dzuciJzCjyEAUwZjCSyw6VMApors7G60xRvgjRoNyq22GvUOyZPm7HnO5OVa4mCPxiN0jicSEtFG1CroK5V10N13JuuEj0ARM91gyT+XCeSJ1UozfexIjmbu3wDNCsoFrCysPoPskhs/NMskoMyTzai50nqIMKuDmhyFl+dY=;24:E2+aKTIuNl4O9kYhHt1/WxcI5TCRQdew8DZpNp4Oh0M9LGl1NsO51FzP1L6y1q9eNGtAUIiXH+NB1b5QVuWqNv8anQhYUrR9ISSH7U0SINM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2484;7:9tPDs74wZeCK1TPgQ3CcHzOsQSmRXkEXTjeEkr54WKNMPhCxn0I+JWWlBgImbQ3Hz49NCBDzRlmifn9NKHLpuNQk7OGW2qLHerrNKc4sm4fe00B4FERXAi2kuXfozbMggPV4RGwDA1V6vykifNJmPkESRf2IfPfKG1q2c1Zt6Gh2/xhUGDJcXuhLRs3is7i/wNocRM1vvUIWaHdpZ/6VCjwFW5r5Im0Bt6KlVNEIHP/9N2fhkNjTDi2BzJG+vATW
X-MS-Office365-Filtering-Correlation-Id: ff429902-d079-4f5a-8b74-08d5bcca0922
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2018 14:17:06.4219
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff429902-d079-4f5a-8b74-08d5bcca0922
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB2484
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
 drivers/iio/dac/ad5686.c     | 88 +++++++++++++++++++++++++++++++++++++++++---
 drivers/iio/dac/ad5686.h     | 16 ++++++++
 drivers/iio/dac/ad5696-i2c.c |  7 +++-
 3 files changed, 104 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
index 89c5f08..be803e8 100644
--- a/drivers/iio/dac/ad5686.c
+++ b/drivers/iio/dac/ad5686.c
@@ -70,6 +70,8 @@ static ssize_t ad5686_write_dac_powerdown(struct iio_dev *indio_dev,
 	bool readin;
 	int ret;
 	struct ad5686_state *st = iio_priv(indio_dev);
+	unsigned int val, ref_bit_msk = 0;
+	u8 shift = 0;
 
 	ret = strtobool(buf, &readin);
 	if (ret)
@@ -80,9 +82,22 @@ static ssize_t ad5686_write_dac_powerdown(struct iio_dev *indio_dev,
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
+	}
 
+	val = ((st->pwr_down_mask & st->pwr_down_mode) << shift);
+	if (!st->use_internal_vref)
+		val |= ref_bit_msk;
+
+	ret = st->write(st, AD5686_CMD_POWERDOWN_DAC, 0, val);
 
 	return ret ? ret : len;
 }
@@ -175,6 +190,11 @@ static const struct iio_chan_spec_ext_info ad5686_ext_info[] = {
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
@@ -200,72 +220,112 @@ DECLARE_AD5676_CHANNELS(ad5676_channels, 16, 0);
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
 
@@ -276,7 +336,9 @@ int ad5686_probe(struct device *dev,
 {
 	struct ad5686_state *st;
 	struct iio_dev *indio_dev;
-	int ret, voltage_uv = 0;
+	unsigned int val, ref_bit_msk = 0;
+	u8 cmd = 0;
+	int ret, i, voltage_uv = 0;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
 	if (indio_dev == NULL)
@@ -310,7 +372,8 @@ int ad5686_probe(struct device *dev,
 		st->vref_mv = st->chip_info->int_vref_mv;
 
 	/* Set all the power down mode for all channels to 1K pulldown */
-	st->pwr_down_mode = 0x55;
+	for (i = 0; i < st->chip_info->num_channels; i++)
+		st->pwr_down_mode |= (0x01 << (i * 2));
 
 	indio_dev->dev.parent = dev;
 	indio_dev->name = name;
@@ -319,8 +382,21 @@ int ad5686_probe(struct device *dev,
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

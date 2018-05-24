Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032444AbeEXSJJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 14:09:09 -0400
Received: from mail-db5eur01on0085.outbound.protection.outlook.com ([104.47.2.85]:62208
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1032266AbeEXSJG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 14:09:06 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=shenwei.wang@nxp.com;
From: shenwei.wang@nxp.com
To: thierry.reding@gmail.com
Cc: linux-pwm@vger.kernel.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, Shenwei Wang <shenwei.wang@nxp.com>
Subject: [PATCH 1/1] pwm: fsl-ftm: Support the new version of FTM block on i.MX8x
Date: Thu, 24 May 2018 13:08:48 -0500
Message-Id: <20180524180848.61844-1-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.9.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [64.157.242.222]
X-ClientProxiedBy: SN4PR0501CA0025.namprd05.prod.outlook.com
 (2603:10b6:803:40::38) To AM5PR04MB3284.eurprd04.prod.outlook.com
 (2603:10a6:206:d::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM5PR04MB3284;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR04MB3284;3:wNkiBzq9XhLX2PKnnCDODQ5gZtaJArLLVatLoT5lS8TMN+CJlayU/Z0XqO5jgVBHgXoLAiUz8t1XmUV2Dc1yQKMAGX4lJ6qBopKh4n9bEham28Zf8pqaOEkc+J+2v4TaBTozbEt0dUpiOX7e19rCCTFLBcTS9+VK2Z/CZKyNQMShjnjmFUbyHcftFvExp7P7Sc1fuwf6rexHLSA39KUh+N/59MNfkpzncaEI9nR6LDA7W5/b5Yz5VfMKuCuyraM5;25:vydnZB9RKtKoNUpwaX5zAFM/9OaMxOPQZd4+8VWBUUFdKaAn7eUPY/zHAZOtBDgKTPNxx/c5uuRR8E1GmDnVne2gs4nyXXpNW6EC0kZ2nr40CS9ELEA+xYqdSvmtyjWWye3ZJhi+f1yDMZL9tV5/7CCGEtzMNHY6r9RBAZx0Wddz1QC2IzanInyE5e2IqOziMX2UyWJCde6WlaiCcXhweDcUi8cORgjr8xXBe+3JKcCPJIpeaNd2FkUGmCDFs5GRfx/fPwVBElQD2iQqnp14fzBkswGYny2X2LWorIEjRVhg96mj58DX2lcfGtJUJSfVa0bQMAgsIqYCEtRvESf2XA==;31:Z7YMf9FxKncOOPiq75dIRHMdrZn/JcQUBjJ4CvcgP+mUUz0BtpJRg88kLvlIoBx5y3RvTRcKEuw3dt2t73KBAiiWJkYusaJcyq5eNOJT/BNAf1FyyNsElgYoNY/OZo2oELAjjGwGjA9NQ8csZz2k2rnB81nfDzuDDeMtn6uxmUqGQSBFJKMBPDQFM/KMPpV1aj4zCdZV4o3dSQvCkeNpsWsTwJc+2jitruXgw7OlZ8Q=
X-MS-TrafficTypeDiagnostic: AM5PR04MB3284:
X-Microsoft-Exchange-Diagnostics: 1;AM5PR04MB3284;20:31O/uaJ8aYcXc2f7UwAFR7y2Ol7LHXZdyxMGfN9XQ+QGqQKwQwNV4c9Ux0D6TxXajsnFSGp51v5QQUUhrAQ6yZJ0LnTUHhTnDgpvVryKqN9YvMWUQ+oi930apudQuqBYWRwtj4W9zqinaRYVE8cThYcM4wRxUUSgo8q2U2SHQKkvnJjRgkmXd6utH57MV/Hi32vBbAXnUx9Xk2PR7mz/VHzMdICYEKF8/ylVcpz/e7Dj58OKqZ3xEBEP0RM19xRHp4d4QZtmI4X5ii0B/5SHxGzCwFrx8116qxWj3lg+UUkd4/yVyUi/HoYNcjU6+07dtA6pwPzB5S2kyKcU6Foal/z1cbj8tac080jldIvgASmIM+oIVYjUjlKGunc1RyfZ5/H1zGM1nTCJZlBR14zPXKJg++J0VvBO+Qz/CIGhVQ8Iq0GXPmDlYZljNm3E1A3ODi8Feg1uG9Rmndml4Vz8nF0sWLQXWqLVW2ykiwiLwKFaLSneQ1bjs3dxAmjSX6tS;4:tEtdJ2Fda53o/T/BKDLoikgNtnHSzH2iDcYqlY4pzCUqbR/cL9glFUCk7gSTld/RgVn7z3q51ZbHo5UmHU8K/G0AKA3Qe9RFtSmiYHcAOcCOAWvgxGA+H9PBPiHSuBQLvng809qgdrGGtKG9kXIdRLcZiAkpZ9RaR2sdS6B7yhyQC8bUWvJU9s+3AacnSBCkzmplueo8DpzaYSUKP0wvmX3Af0/FNDOv+GTVX0IOr0bYsmgrq1SlGenaJ4rldg0lyQx1/d/VsZ/3cZnFo46mc0ydpArctNiSqbemQ0QhCV8cwyV31kTo4b1vg0OC0kT8
X-Microsoft-Antispam-PRVS: <AM5PR04MB3284F85D3CB85C39AF0EA7C0896A0@AM5PR04MB3284.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:AM5PR04MB3284;BCL:0;PCL:0;RULEID:;SRVR:AM5PR04MB3284;
X-Forefront-PRVS: 0682FC00E8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(396003)(346002)(376002)(366004)(39860400002)(189003)(199004)(2616005)(6116002)(3846002)(8936002)(6266002)(122856001)(36756003)(50226002)(486006)(39060400002)(106356001)(51416003)(476003)(105586002)(16586007)(68736007)(81156014)(52116002)(6666003)(81166006)(316002)(6916009)(8676002)(97736004)(53936002)(1076002)(42186006)(9686003)(386003)(52956003)(85782001)(305945005)(7736002)(478600001)(5660300001)(50466002)(66066001)(2351001)(47776003)(48376002)(186003)(33896004)(2906002)(90966002)(101396001)(2361001)(26005)(59450400001)(4326008)(86362001)(85772001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR04MB3284;H:Ubuntu14.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM5PR04MB3284;23:4oZhO47h6v+bSA0jOisiKGNeOT2DLf+BpEGVMtvtt?=
 =?us-ascii?Q?SLdSHbHb+y3iofiMc4GwJQF+Q60ZDotYeulmGbvSe1l3JXFAn/8dGTKyXXSv?=
 =?us-ascii?Q?bogLQcZo3eON6vk7m2SzZWhsOjO4J45ZrW3m8ZJ1QzB1bxZzNGAP5DBBw0a7?=
 =?us-ascii?Q?rQMmLBN9xWVD4fksFSLdhHrl1wnwR8PbRDlMahesR7y998Ucr0MWVCuJOFx8?=
 =?us-ascii?Q?QGw/4qT81lapMJbmNYaIvFSLjNy/UePF1aaMI/pxPjk4P6HLdsrbNb6q8729?=
 =?us-ascii?Q?/IZl0L85RUAa6g2fLnULmz+mNH72jLS06OS5EAvFYYsIjW94ncgmC0L2qM/G?=
 =?us-ascii?Q?W3IHa31bYmpiAto7JoQ1zxskHPJrHlD7V4OnFTh26URTlF4jzfM0ghCCu+Gl?=
 =?us-ascii?Q?vKAgX+z8JgBS2JRrvGl9g5g2VWDQKZWeMApT5xWnOpfFzRaOb2TXiysgMrek?=
 =?us-ascii?Q?QTqpLzVLjqc4qsehKGaO2WDQotKnYhWr4Anu+y26WhWBfaJzPuMfRPl6QQ4G?=
 =?us-ascii?Q?3aicE4clKwx//978zOVBEUNdIleEhcz0CaUxPdVg0Hj/snjuu2i2YkuThQh5?=
 =?us-ascii?Q?SpqC9qx9ADtYO335qx9zOBFvAPFkT8I7sv+1le0ljk9VoWcBVVnxWnN/SbCz?=
 =?us-ascii?Q?H1kwOS4l/ph60LNaNfsI1yKk7QInLTzQTbAGlGX61DyHnsdyoE++lJTqmV4i?=
 =?us-ascii?Q?+Ppc3g2f5e9Z7WJJq5IRUi4iHw4oaZD/ZZ3qi1Kgffjr4oI5NReMJ28urlCj?=
 =?us-ascii?Q?bxngf4phtZy9si2hg3IsYJUZxvRQSguQ/HpnZDG85NHGjmGtlwpDMpiriyqI?=
 =?us-ascii?Q?TBsNyKDPdkdr1yZ8uDFLnhK+mBjVO2PlY8+Oe7sxabmRS17ru4PTTeuOTkEq?=
 =?us-ascii?Q?g9JvRdv3yQWjv5sv+u6/iGSFK6gEhZkb5uEafnZN2zHWAtifxyXQy30nFjny?=
 =?us-ascii?Q?cjVrtunZk7jUJ7JOHI5M9NhST4mxqJkFfauBqA+kfnyuDrddFaBgGasxcdRg?=
 =?us-ascii?Q?9D3GIBmejNS4gZONVmbdWsPMsxg35zXDnsjf1JjiyBuK2zNCH6ftMy624pS9?=
 =?us-ascii?Q?oY6cXXKSdXMb67ppf8hZhyxArBWWE8ee9TLxyCKuiHB+fULRyDozvm+7mDK0?=
 =?us-ascii?Q?RbKkC5j4bnb6ydLnOV8LZU7GWNa6Wi6RZ2ny7Q3WNwYrKTlIjMsxiSWokRbS?=
 =?us-ascii?Q?lRZYPxyU4p/i4Bx/flURHT0KvNNvzYFl/K9/EyFL2TO8AF1B5T6SX4XYaR1l?=
 =?us-ascii?Q?FBvUaUClEodpAH7qU8LMET/fFKR1tXS9GuHahwthUlSvrJq1jImN4PNtepUP?=
 =?us-ascii?Q?Gm+JR/xgpSjXUiR6aNtadza3MyaluoEZT8JcnGjaXX0?=
X-Microsoft-Antispam-Message-Info: OPEbHMR0DXnoS1EF6pegqs+A0bYU2Jix3YygUl5ok6yMiVPXtfCA8nnfy36wvcfg7xhVFraKKu0BX/BCZXB3G+VPLaYlJ5vMchoQvtI4HAOXusLJGHuvBTD2RBMiwd5UDTYAuj+esK1JRlM8LMqDkgsaRHgfiHGOx+myj0vLIqEDJTdMuUvs/8j6dMy/9Nhs
X-Microsoft-Exchange-Diagnostics: 1;AM5PR04MB3284;6:UVd4HGdVlzghrzg2k+1PHADd8PO+eGmF3TzcoePw1ZDG190quwMDZny21IUMmaNmAcI9Q/GM3M1eBPooZ6uwe79Zgh6IWQC73xckehkJWNoCYkC3ggNiZkVdYTRuR5WMYlFpH3H4ARTkdpcMsbubvAYTjpbfCGcQFpxzmaFVd2olFPdNsrJix+HrbSYpFVdMFnVjsx5hc514ktneUL9B/Kz+jVhioDsmJzBnFWtBm6dTgMMJZvQe8p+ejG8LFmhn9lRJMNY6HbcdTOip5Pfkg8xwTPIAlzvkEBCJ2xqpWfgq76JMdkJGsHC5Tsoc0zqVe9Rl7dyUyVLx0EHAAWoHw8gTwHlmU/+a4ZBaWmV9mWxPGwRNhz/uirruLl3CxKyfJK23FKBadnlxcTCnvirogPO0V5BrjEyeN7FJPDw7whOlb4iUlR/XyFqco+0IQBnXB+pM8Bvw0Lb6vppSbG28Ag==;5:l4gcQJYfn7wZq9O+g7F7Tk4i66rQ7MxIo0j+p3YRdbJ5wFObwdxhXWnXxRsNeh+D+sUsP6vLc7KuAKeRxa/JL5UOzeTyYleO6FbESFFzC84A6JI2E7ZgxCiESrwB+fmD+jBCz6hj/q7a5q4LJGHqeuEcQHqvhWz9Yhwf+QBglIY=;24:rKgr+x4Nxym2H6qB0DAiCngzw5L9o//jvybulnhgxxqXbi3nvV2tx9yPSytIrV2YLEhiryQUehkPMLvPqsT2RL3V1C/pMuRCMQk2QIl7NO4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR04MB3284;7:DM02DIuCl2fWq6bY/eUmUCk9z+iy7oQYK8yoC3e5aAlmSN1etxig5g4W0yfEutlerqCs6UD5sBmeczAkeMvjAKAyK1qabzUXuVceZf2yZxHL5Cf5u7US1QmlYjZqTu5DhQLLzr9grY8Cubb1KSFOAWXHKEs2YQ5EAO0+CsQ44hPkAy3eTwkNMqg2g4oEpW45C+lHCHGPILZMOVr47cO1mvb6JqXIHuM007iSyZkspFJ6mvGTSdRKIPtAtHOK9gZ6
X-MS-Office365-Filtering-Correlation-Id: 33d2756b-829a-4907-9a0d-08d5c1a16ef2
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2018 18:09:03.6519
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33d2756b-829a-4907-9a0d-08d5c1a16ef2
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB3284
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the new i.MX8x SoC family, the following changes were made on the FTM
block:

1. Need to enable the IPG clock before accessing any FTM registers. Because
the IPG clock is not an option for FTM counter clock source, it can't be
used as the ftm_sys clock.

2. An additional PWM enable bit was added for each PWM channel in register
FTM_SC[16:23]. It supports 8 channels. Bit16 is for channel 0, and bit23
for channel 7.

As the IP version information can not be obtained in any of the FTM
registers, a property of "fsl,has-pwmen-bits" is added in the ftm pwm
device node. If it has the property, the driver set the PWM enable bit
when a PWM channel is requested.

Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
---
 drivers/pwm/pwm-fsl-ftm.c | 35 +++++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/drivers/pwm/pwm-fsl-ftm.c b/drivers/pwm/pwm-fsl-ftm.c
index 557b4ea..0426458f 100644
--- a/drivers/pwm/pwm-fsl-ftm.c
+++ b/drivers/pwm/pwm-fsl-ftm.c
@@ -86,7 +86,9 @@ struct fsl_pwm_chip {
 	struct regmap *regmap;
 
 	int period_ns;
+	bool has_pwmen;
 
+	struct clk *ipg_clk;
 	struct clk *clk[FSL_PWM_CLK_MAX];
 };
 
@@ -97,16 +99,31 @@ static inline struct fsl_pwm_chip *to_fsl_chip(struct pwm_chip *chip)
 
 static int fsl_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 {
+	int ret;
 	struct fsl_pwm_chip *fpc = to_fsl_chip(chip);
 
-	return clk_prepare_enable(fpc->clk[FSL_PWM_CLK_SYS]);
+	ret = clk_prepare_enable(fpc->ipg_clk);
+
+	if ((!ret) && (fpc->has_pwmen)) {
+		mutex_lock(&fpc->lock);
+		regmap_update_bits(fpc->regmap, FTM_SC,
+				BIT(pwm->hwpwm + 16), BIT(pwm->hwpwm + 16));
+		mutex_unlock(&fpc->lock);
+	}
+
+	return ret;
 }
 
 static void fsl_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct fsl_pwm_chip *fpc = to_fsl_chip(chip);
 
-	clk_disable_unprepare(fpc->clk[FSL_PWM_CLK_SYS]);
+	if (fpc->has_pwmen) {
+		mutex_lock(&fpc->lock);
+		regmap_update_bits(fpc->regmap, FTM_SC, BIT(pwm->hwpwm + 16), 0);
+		mutex_unlock(&fpc->lock);
+	}
+	clk_disable_unprepare(fpc->ipg_clk);
 }
 
 static int fsl_pwm_calculate_default_ps(struct fsl_pwm_chip *fpc,
@@ -363,7 +380,7 @@ static int fsl_pwm_init(struct fsl_pwm_chip *fpc)
 {
 	int ret;
 
-	ret = clk_prepare_enable(fpc->clk[FSL_PWM_CLK_SYS]);
+	ret = clk_prepare_enable(fpc->ipg_clk);
 	if (ret)
 		return ret;
 
@@ -371,7 +388,7 @@ static int fsl_pwm_init(struct fsl_pwm_chip *fpc)
 	regmap_write(fpc->regmap, FTM_OUTINIT, 0x00);
 	regmap_write(fpc->regmap, FTM_OUTMASK, 0xFF);
 
-	clk_disable_unprepare(fpc->clk[FSL_PWM_CLK_SYS]);
+	clk_disable_unprepare(fpc->ipg_clk);
 
 	return 0;
 }
@@ -428,6 +445,10 @@ static int fsl_pwm_probe(struct platform_device *pdev)
 		return PTR_ERR(fpc->clk[FSL_PWM_CLK_SYS]);
 	}
 
+	fpc->ipg_clk = devm_clk_get(&pdev->dev, "ipg");
+	if (IS_ERR(fpc->ipg_clk))
+		fpc->ipg_clk = fpc->clk[FSL_PWM_CLK_SYS];
+
 	fpc->clk[FSL_PWM_CLK_FIX] = devm_clk_get(fpc->chip.dev, "ftm_fix");
 	if (IS_ERR(fpc->clk[FSL_PWM_CLK_FIX]))
 		return PTR_ERR(fpc->clk[FSL_PWM_CLK_FIX]);
@@ -446,6 +467,8 @@ static int fsl_pwm_probe(struct platform_device *pdev)
 	fpc->chip.of_pwm_n_cells = 3;
 	fpc->chip.base = -1;
 	fpc->chip.npwm = 8;
+	fpc->has_pwmen = of_property_read_bool(pdev->dev.of_node,
+						"fsl,ftm-has-pwmen-bits");
 
 	ret = pwmchip_add(&fpc->chip);
 	if (ret < 0) {
@@ -480,7 +503,7 @@ static int fsl_pwm_suspend(struct device *dev)
 		if (!test_bit(PWMF_REQUESTED, &pwm->flags))
 			continue;
 
-		clk_disable_unprepare(fpc->clk[FSL_PWM_CLK_SYS]);
+		clk_disable_unprepare(fpc->ipg_clk);
 
 		if (!pwm_is_enabled(pwm))
 			continue;
@@ -503,7 +526,7 @@ static int fsl_pwm_resume(struct device *dev)
 		if (!test_bit(PWMF_REQUESTED, &pwm->flags))
 			continue;
 
-		clk_prepare_enable(fpc->clk[FSL_PWM_CLK_SYS]);
+		clk_prepare_enable(fpc->ipg_clk);
 
 		if (!pwm_is_enabled(pwm))
 			continue;
-- 
2.9.2

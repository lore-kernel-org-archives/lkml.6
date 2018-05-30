Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932078AbeE3Q5n (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 12:57:43 -0400
Received: from mail-ve1eur01on0072.outbound.protection.outlook.com ([104.47.1.72]:59514
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753337AbeE3Q5i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 12:57:38 -0400
From: shenwei.wang@nxp.com
To: thierry.reding@gmail.com
Cc: linux-pwm@vger.kernel.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, Shenwei Wang <shenwei.wang@nxp.com>
Subject: [PATCH 1/1] pwm: fsl-ftm: Support the new version of FTM block on i.MX8x
Date: Wed, 30 May 2018 11:57:21 -0500
Message-Id: <20180530165721.77500-1-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.9.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [64.157.242.222]
X-ClientProxiedBy: SN2PR01CA0024.prod.exchangelabs.com (2603:10b6:804:2::34)
 To DB6PR04MB3285.eurprd04.prod.outlook.com (2603:10a6:6:11::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB6PR04MB3285;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR04MB3285;3:jGVnHPB3un74S/a1ccOF820GQT30S1hD9kvJWz8PHRJbF2XiOphLxNRZ5SZ+qVxjThXh7TE65/K+6kvgSZeNk50yWHTdN5SAgyeppFON+HFCDS0MejDuK1wqWz3Rj2pNiTadGhZo+R0k89vY9d3T/aQaHmNyRmrxGq0cFM41DvfK4ttYilBhPUqwqRYeXTR7XWpt28P86yvkyuHqeFh2EcnGMLdcFSim0Ap29BYu2vcI8jOWNe2sMqMvHn+hWTTQ;25:jDkpZDyt5neJP8HaGCg9Jp+jN+aisyoG6zRGQKgypyfGXo9/GPGZlQ307OM1F93u/HZnM0UWAv5T/f2pCeudakGjqV8PpYlyaj1bbYxxCTNWAcyZUT0l8JU0GTgArF0R9lSl0PjWOMBWBrey+5SAgnJY+WiFsJfIwthxPYm/mjqerICoAfJCLppLWG+GibbOHPkYxdckg/Rme/5HCMqYJ+mQ/kjEzTwI3qtuz2rb5G7zf1SG2/sTEA47AnL5Ewj+pchUMSJKD2OEqL+gr7JD8RPw1YH2IhvBdC8MVPi1/G1skrL/CyEu+vyiCuugJKf8B/csTs3L8IVw8TLRwM5hng==;31:6cbP3HzyH6Zn9OCfXo/VJemhuAEleHjZRgJZIxav3iYCeuFiSDRSPmMWF8nIpk48/nWANYoV2ZJQe/Q5vRHYkJBEuSgOTit+OVH4YqO+66DFinn3UCEBCq89Dpc7VsEmVFFE2oaHj3Wz7+FW/9vGBmEUwB8xkw1McuqlhyEncty70ihTe26/BMzx+0t2K7KnoSJRZhA3arH8pu+toOU34quN+33ClN1eOic+KAh+lP8=
X-MS-TrafficTypeDiagnostic: DB6PR04MB3285:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=shenwei.wang@nxp.com;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR04MB3285;20:48SMBt2AI4LImF1iy+LYaxXBvdERyh2ZZlAgttJf3yDOiIEIwWDLBj0YeKlE9DRlW1W33YTrL1gqWPhTi+h45HftVtlWslvQsBORLB0SrcQsLKX4SrzZ6L103G09XBsLY9T+OjP5ISGDLCp2JfY4A/99pdesSQiwiMIrnjNumr/H+3SUivZOGzZSA03GxkCg6BThJycqvRreQzUpVg4cWKcAHt1DbPJifcosUGHGsArnBx67gFD/I1mCZ+uPWQVlYf/DgNR5Vq5d/N9E911bvVEAPyMaUnRRXz8UxssR7az8Fa+Vcsz0He3n5r7NnehXe6ASw3qSwVLCwjDJmnH1v6UdGUk8qnvnoBvrZ6WClgNcWBr+W26mWh3esUd0Yv3zupnJ1/zsQOB91BrQPKkoKru0G0a/JWbXBQYrY3BL1XIZ/NDhO7PEu1GfMwSsFqSGb6z5ulSt7vVFThT15ar/Hi3PA/8Qc7lwJ3hiNhmoUGIzWhz+xVyO5x4Rc8M2y7WP;4:llmUIKdvUFAHf6cPFbDUkYrrVZdOH3j8qOHq5msPSUoLmIdg6/kBJSiSvawRJBoGdKF3QXFB/pKcxcJrAX+EVl/NXSH547hboEbYOvhldkOh7vqXdDLCFhwcK0GipMjfhjk5WKfdu9naYgOOhOh0jd2iqx030LKq3xEGlwFEWdzqexsgFGV5QDKCdvjTX3bfjXPlZEshkgTPq1aTcAU+wDL+n2fudQNOHiXR0XFiD9drGc+84laAJ3Xhc8oDKiBs4OTT3g1Chc/ssr13VM9gFOlnXVVXqipEjH1lDr1W9v5Y0SkqSGG0+oMiQDSfVC8f
X-Microsoft-Antispam-PRVS: <DB6PR04MB3285576C02CDF25EFBD71332896C0@DB6PR04MB3285.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:DB6PR04MB3285;BCL:0;PCL:0;RULEID:;SRVR:DB6PR04MB3285;
X-Forefront-PRVS: 0688BF9B46
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(376002)(39860400002)(366004)(346002)(396003)(199004)(189003)(16586007)(478600001)(97736004)(42186006)(39060400002)(2906002)(9686003)(7736002)(106356001)(53936002)(26005)(316002)(386003)(33896004)(122856001)(90966002)(105586002)(59450400001)(8936002)(6266002)(51416003)(2361001)(52116002)(186003)(101396001)(2351001)(50226002)(8676002)(81156014)(68736007)(85782001)(52956003)(6666003)(81166006)(47776003)(2616005)(486006)(6916009)(476003)(1076002)(6116002)(3846002)(66066001)(50466002)(5660300001)(305945005)(4326008)(86362001)(36756003)(48376002)(85772001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR04MB3285;H:Ubuntu14.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR04MB3285;23:63l80Hq+E4OG13UdyXrz3pfj7ZZ0QWwP9zSxCCNzX?=
 =?us-ascii?Q?uZseh3i4e2zV51OYru8d+DfRE716hYJb5E+xS02Sz3Rg47eZrdA/rbXE8Bo1?=
 =?us-ascii?Q?JijR6Se6RMMYIAZjbSWK3f7T5ErapleEDB/u8WAMup5kxpG2zCtwuD2ymUK0?=
 =?us-ascii?Q?Um2Jq6LE/6TUvdvYyAiKWG3t7gJhqHHm86hSassKnCqOEZ26L7I1BFJu4jI0?=
 =?us-ascii?Q?lC6Ky0fkziHTdnZCZkhEPKJcrwacTLFkSPO6OYV6aJzhlo3lY4mRNqIw+f4w?=
 =?us-ascii?Q?5izlsm2ri+Vnc79HJs9jSR3zzhgaWmkMXs2JmFBrXMSs3ySm4RT2D3jsYO46?=
 =?us-ascii?Q?nWo7i13xCt9wHW3kjeePW4X2r3M13oaSWYYO9LwBTjV8ew6t2+8La7pf5BRf?=
 =?us-ascii?Q?u81mtkpM8hfk9EN45cMJf4Z4gp3qqhnZ7erUfeGHgPxHF/S8CpG59d/5PcSS?=
 =?us-ascii?Q?NXTRmUbuhs5lo3RPZjPhKsd6tay85vnbvD00zjrE8EgEF/LPFe900XvxFcyA?=
 =?us-ascii?Q?iCcQ17o3xxjWM4P/AFTpRcsUjtgmZoAwlRXc/zBvB3q5tFwm1biGGK+HyZEt?=
 =?us-ascii?Q?pEkePngrBOxgpBHJx4kw8nS/wj2EAM5minXW6qk1zG3Euzc4r8lqtMTj+Rfe?=
 =?us-ascii?Q?WSlZeRq/E/SVmbZudcXZ0JVhsc/uirc26brbRzT494mPtjXhD6q9Z3Z96ovY?=
 =?us-ascii?Q?M1wqaJkLt4U5CFdm6OvaYHZB1hJqcdZSlv9RSxLiREXYsRrI3C9qBugNrn5y?=
 =?us-ascii?Q?pES9PKy7dG7TXzSRufdPpnTGJoJ9MRUgUH2H/aC7o6ocEVYQc32n+k4fmU/8?=
 =?us-ascii?Q?83HfA2eG+TQeJ9M4wH6SDYWNolSNIQTQavJN4kMWvv9XT46m5BbboXZRSsTg?=
 =?us-ascii?Q?7fMCgaBTxfLW9WIVQOesOXTRzsPOVzhM9SpPlREgIDeF87UKvB43iOsdnH0M?=
 =?us-ascii?Q?EdZT3Q9+1KedqJLYE45JdgMYfIZ6YrPHqSGwBiNh6B5XsPwSBuvpRTr1s02a?=
 =?us-ascii?Q?2oRRzpgLOkUkKBRmdRJ310HQg0yIGmDgSNr8VeTf8KspdptWJskVtEh8xSnv?=
 =?us-ascii?Q?YCRZQ/jnBfihJmKmgd7aGm733UdbIrJfzTPNOXn/yp1BArFzpi8/LqEOzmUY?=
 =?us-ascii?Q?2a6Ex0q/N3asWeSxu6dZy+GGgA1Ne+YF2M8mLilL903EfmJWm2O4tPFurXox?=
 =?us-ascii?Q?vjP2L5AKd+vAql6CiOVl0dwpw1ISM+CdJVuD4lzebaubEujO7Z855b9ayVs7?=
 =?us-ascii?Q?2JiXAtodcY/8Wa9b2u5rEBpv0LWlS/5jSEH+ZUElh25VE4zTlaCWwyItdn26?=
 =?us-ascii?Q?iozL+Y9E+0V1FiPonrD+9RO2OwPA/EEf9kuvgNDfjlB?=
X-Microsoft-Antispam-Message-Info: MUjswPOJAdfUyhjpUgO+R2meTePoyM2ASKNAcAdgqjZ6jud7qIvNl3wYDdlBdgAjePHVg0BLa7S9FDR/eLP4oeBgirnFWUkY4Dw1Fu550R/9IhyI29XTzBhrAJGxHJ/pcMMwL7SwlFdTMhbeivezdotoVGSsCYoOfdmHV6y8LoKkmPw2B3LhAE3CfqolHuk+
X-Microsoft-Exchange-Diagnostics: 1;DB6PR04MB3285;6:HdIvC/pICxUHWPasZNUgLDKG4eC7dbEviL0Jec2FL0n0jlCqEL5aQqLpizLcPPj6lyOSkKk+wzvlYeckES2ZBdXv130wFQkTg1nS1HE9mTRiaEJmA3fspabjqb0jPjO/OfyUq388BHOiuVZJDNzxy6YiTc3CCR2cdSajGK6gh65ZFv5BTEXndUE0TT/XjQUUbQdX0RUqJlCTV/LH+qttY+H+sm90MaSfo/2B1CB+aJ1jpO1jsoIZSPInQZZg5MkCA0DTjZuikIycwRbV3mrglbOy5BcQBXBhvN0iwuPFAJ5dJ0vFxS7AXgu48ha9VeHG0xm4ZObN7jJYPe1JKIGAynVsaPLWa+0a9asHuCiPB3OtM7tnjAhiWU2eBCSKd/vEQNbDts0aGXSA45UGFHf00u8k5MIEE6savQyGqA+MJMpWWlT+03dSMs2Ot7b95PI6CxqOGOzWAzPkIzjUIn1Q3g==;5:5RXVtWentOleujHK3atil4KbZbExwrrx6YXUhDGibqmyuBT3qBuyEI+fARkgLARIuBsWjigILZYfNsXKWhSbetxX0Ap43RxRCAIMZ9sVlBDr59id/cjgGZKqhsC/IascbWXhv457F++EYM/7PCQpfm37vc0iCujlfVelzMmPgwU=;24:92zX546b3xJb9VlX7aHDa9lLl9Oi0/jVJDbKlYRTA3f2JliDQ4BC81/utIQoMSIWOSRZ/3BkrqJUEfP+GdEdnbl5e06zuWwGdLHeN3eu7g8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR04MB3285;7:GMoKEixtqp8o0JRLMVzweYBXkpRQsn3IN8apPLznTNbtV1nyFD4kYnMgKWmcp9wXlZFVZzZfqXwSe51eqGMS4JkU3ns4GxfHV8enm8M4Q+R4g5NYEk7IfR8Jj/+8lOJDXe1e9+LrQkdLEOxniY4xE7Px/YwOe2WtMTU5aEQ9MeMvpZ3V7NY/miWZVKL5c3d5Zth5Xxhyc4MB3J4MJ27eztpy/NEs9t8nP2sNP/A7RFtq8NC+rGh66dJDmkXoxks/
X-MS-Office365-Filtering-Correlation-Id: 7a21badc-a2ea-4f08-a38a-08d5c64e718d
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2018 16:57:35.6243 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a21badc-a2ea-4f08-a38a-08d5c64e718d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB3285
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

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933251AbeCFOpA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 09:45:00 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:63116 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932313AbeCFOox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 09:44:53 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20180306144451epoutp046b9d4c504dc8a885d52865418db2d06e~ZW-z-y_Iz1173611736epoutp04T
X-AuditID: b6c32a47-19fff7000000100c-66-5a9ea9625d16
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc: Kukjin Kim <kgene@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
Subject: [PATCH 05/12] thermal: exynos: remove parsing of
 samsung,tmu[_min,_max]_efuse_value properties
Date: Tue, 06 Mar 2018 15:43:48 +0100
Message-id: <1520347435-22970-6-git-send-email-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1520347435-22970-1-git-send-email-b.zolnierkie@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrAIsWRmVeSWpSXmKPExsWy7bCmhW7SynlRBts3mlhsnLGe1WL+kXNA
        4so1Vov+x6+ZLc6f38BusekxkHt51xw2i8+9RxgtZpzfx2RxaOpeRoul1y8yWbTuPcJu8eRh
        H5sDr8eaeWsYPS5fu8jssXPWXXaPxXteMnlsWtXJ5rF5Sb1H35ZVjB6fN8kFcERx2aSk5mSW
        pRbp2yVwZex9Z1Cw1bxi95uvzA2Mc/S6GDk5JARMJP6132TtYuTiEBLYwShxbc4cNgjnO6PE
        +/ub2GCqNixdzgSR2M0o8X/TQSjnF6PElYsXGUGq2ASsJCa2rwKzRQRKJKat6mUEKWIWOMsk
        sWP7O5YuRg4OYYFMiS9f0kFqWARUJT5tnMcCYvMKeEjcO7qTHWKbnMTJY5NZQWxOAU+JEx3n
        wE6SEDjDJnH30womiCIXiYV7rrFC2MISr45vgWqWlni2aiMjREMzo8S3HXuYIRITGCX2rBeC
        sK0lDh+/CNbMLMAn0XH4LzvIcRICvBIdbVAlHhIXu7ZAzXeU2NE/mRni4zmMEmtu3GadwCi1
        gJFhFaNYakFxbnpqsVGBsV5xYm5xaV66XnJ+7iZGcLxrue9g3HbO5xCjAAejEg/vBo+5UUKs
        iWXFlbmHGCU4mJVEeCP050UJ8aYkVlalFuXHF5XmpBYfYpTmYFES520NcIkSEkhPLEnNTk0t
        SC2CyTJxcEo1MFY15VTbJOjHxyq+czedv9Ryqdn8CYwrkj9fdknWZjOsO5QUZT41VWdGKk9L
        J5PZtNRn3seO8on/Y7BiOuvOs/OMg8+nsPkLDummJN9xEyp4NuFbiqy1M9fuNxoyXqVuRv4v
        GN5W1tw9teRygZmbfrfv78BLV/imnAmzEXhV9mWfkhSLxf7rSizFGYmGWsxFxYkABi/ygfMC
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGLMWRmVeSWpSXmKPExsVy+t9jAd3ElfOiDPZ80rbYOGM9q8X8I+eA
        xJVrrBb9j18zW5w/v4HdYtNjIPfyrjlsFp97jzBazDi/j8ni0NS9jBZLr19ksmjde4Td4snD
        PjYHXo8189Ywely+dpHZY+esu+wei/e8ZPLYtKqTzWPzknqPvi2rGD0+b5IL4IjisklJzcks
        Sy3St0vgytj7zqBgq3nF7jdfmRsY5+h1MXJySAiYSGxYupypi5GLQ0hgJ6PEl7+9jBDOL0aJ
        m4vvsoFUsQlYSUxsX8UIYosIlEh0TnvNDGIzC5xlkjj4n6OLkYNDWCBT4suXdJAwi4CqxKeN
        81hAbF4BD4l7R3eyQyyTkzh5bDIriM0p4ClxouMc2HghoJrF3b/ZJjDyLGBkWMUomVpQnJue
        W2xUYJSXWq5XnJhbXJqXrpecn7uJERia2w5r9e9gfLwk/hCjAAejEg/vBo+5UUKsiWXFlbmH
        GCU4mJVEeCP050UJ8aYkVlalFuXHF5XmpBYfYpTmYFES5+XPPxYpJJCeWJKanZpakFoEk2Xi
        4JRqYHS/NEX3Q3fpNGeGDynRHs29F5a/f/5rSbV82Jvjq77t1PmsPzuzW+cnx7Z9t1+reuQy
        vji190b7LpGd2xOF5ezKdD9k7vfiERPynfI69fyRC+8nXhCdxlG9TyxOsNLW5+620I8Gv4K/
        fqwvsN2w+Mm0/Iu9nQEcEg9nh3H/4p67fpmPTsPfS7eVWIozEg21mIuKEwH7UHHJSQIAAA==
X-CMS-MailID: 20180306144449epcas2p3e19959aa4d5d9846aacf8ff1b677d352
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20180306144449epcas2p3e19959aa4d5d9846aacf8ff1b677d352
X-RootMTR: 20180306144449epcas2p3e19959aa4d5d9846aacf8ff1b677d352
References: <1520347435-22970-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180306144449epcas2p3e19959aa4d5d9846aacf8ff1b677d352@epcas2p3.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since pdata efuse values are SoC (not platform) specific just move
them from platform data to struct exynos_tmu_data instance. Then
remove parsing of samsung,tmu[_,min_,max]_efuse_value properties.

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 49 +++++++++++++++++++++++-------------
 drivers/thermal/samsung/exynos_tmu.h |  7 ------
 2 files changed, 32 insertions(+), 24 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index adfd9ef..02d34cf 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -185,6 +185,9 @@
  * @clk: pointer to the clock structure.
  * @clk_sec: pointer to the clock structure for accessing the base_second.
  * @sclk: pointer to the clock structure for accessing the tmu special clk.
+ * @efuse_value: SoC defined fuse value
+ * @min_efuse_value: minimum valid trimming data
+ * @max_efuse_value: maximum valid trimming data
  * @temp_error1: fused value of the first point trim.
  * @temp_error2: fused value of the second point trim.
  * @regulator: pointer to the TMU regulator structure.
@@ -206,6 +209,9 @@ struct exynos_tmu_data {
 	struct work_struct irq_work;
 	struct mutex lock;
 	struct clk *clk, *clk_sec, *sclk;
+	u32 efuse_value;
+	u32 min_efuse_value;
+	u32 max_efuse_value;
 	u16 temp_error1, temp_error2;
 	struct regulator *regulator;
 	struct thermal_zone_device *tzd;
@@ -301,20 +307,18 @@ static int code_to_temp(struct exynos_tmu_data *data, u16 temp_code)
 
 static void sanitize_temp_error(struct exynos_tmu_data *data, u32 trim_info)
 {
-	struct exynos_tmu_platform_data *pdata = data->pdata;
-
 	data->temp_error1 = trim_info & EXYNOS_TMU_TEMP_MASK;
 	data->temp_error2 = ((trim_info >> EXYNOS_TRIMINFO_85_SHIFT) &
 				EXYNOS_TMU_TEMP_MASK);
 
 	if (!data->temp_error1 ||
-		(pdata->min_efuse_value > data->temp_error1) ||
-		(data->temp_error1 > pdata->max_efuse_value))
-		data->temp_error1 = pdata->efuse_value & EXYNOS_TMU_TEMP_MASK;
+	    (data->min_efuse_value > data->temp_error1) ||
+	    (data->temp_error1 > data->max_efuse_value))
+		data->temp_error1 = data->efuse_value & EXYNOS_TMU_TEMP_MASK;
 
 	if (!data->temp_error2)
 		data->temp_error2 =
-			(pdata->efuse_value >> EXYNOS_TRIMINFO_85_SHIFT) &
+			(data->efuse_value >> EXYNOS_TRIMINFO_85_SHIFT) &
 			EXYNOS_TMU_TEMP_MASK;
 }
 
@@ -672,7 +676,6 @@ static int exynos7_tmu_initialize(struct platform_device *pdev)
 {
 	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
 	struct thermal_zone_device *tz = data->tzd;
-	struct exynos_tmu_platform_data *pdata = data->pdata;
 	unsigned int status, trim_info;
 	unsigned int rising_threshold = 0, falling_threshold = 0;
 	int ret = 0, threshold_code, i;
@@ -689,9 +692,9 @@ static int exynos7_tmu_initialize(struct platform_device *pdev)
 
 	data->temp_error1 = trim_info & EXYNOS7_TMU_TEMP_MASK;
 	if (!data->temp_error1 ||
-	    (pdata->min_efuse_value > data->temp_error1) ||
-	    (data->temp_error1 > pdata->max_efuse_value))
-		data->temp_error1 = pdata->efuse_value & EXYNOS_TMU_TEMP_MASK;
+	    (data->min_efuse_value > data->temp_error1) ||
+	    (data->temp_error1 > data->max_efuse_value))
+		data->temp_error1 = data->efuse_value & EXYNOS_TMU_TEMP_MASK;
 
 	/* Write temperature code for rising and falling threshold */
 	for (i = (of_thermal_get_ntrips(tz) - 1); i >= 0; i--) {
@@ -1154,13 +1157,6 @@ static int exynos_of_sensor_conf(struct device_node *np,
 	of_property_read_u32(np, "samsung,tmu_reference_voltage", &value);
 	pdata->reference_voltage = (u8)value;
 
-	of_property_read_u32(np, "samsung,tmu_efuse_value",
-			     &pdata->efuse_value);
-	of_property_read_u32(np, "samsung,tmu_min_efuse_value",
-			     &pdata->min_efuse_value);
-	of_property_read_u32(np, "samsung,tmu_max_efuse_value",
-			     &pdata->max_efuse_value);
-
 	of_property_read_u32(np, "samsung,tmu_cal_type", &pdata->cal_type);
 
 	of_node_put(np);
@@ -1214,6 +1210,9 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 		data->tmu_read = exynos4210_tmu_read;
 		data->tmu_clear_irqs = exynos4210_tmu_clear_irqs;
 		data->ntrip = 4;
+		data->efuse_value = 55;
+		data->min_efuse_value = 40;
+		data->max_efuse_value = 100;
 		break;
 	case SOC_ARCH_EXYNOS3250:
 	case SOC_ARCH_EXYNOS4412:
@@ -1227,6 +1226,13 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 		data->tmu_set_emulation = exynos4412_tmu_set_emulation;
 		data->tmu_clear_irqs = exynos4210_tmu_clear_irqs;
 		data->ntrip = 4;
+		data->efuse_value = 55;
+		if (data->soc != SOC_ARCH_EXYNOS5420 &&
+		    data->soc != SOC_ARCH_EXYNOS5420_TRIMINFO)
+			data->min_efuse_value = 40;
+		else
+			data->min_efuse_value = 0;
+		data->max_efuse_value = 100;
 		break;
 	case SOC_ARCH_EXYNOS5433:
 		data->tmu_initialize = exynos5433_tmu_initialize;
@@ -1235,6 +1241,9 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 		data->tmu_set_emulation = exynos4412_tmu_set_emulation;
 		data->tmu_clear_irqs = exynos4210_tmu_clear_irqs;
 		data->ntrip = 8;
+		data->efuse_value = 75;
+		data->min_efuse_value = 40;
+		data->max_efuse_value = 150;
 		break;
 	case SOC_ARCH_EXYNOS5440:
 		data->tmu_initialize = exynos5440_tmu_initialize;
@@ -1243,6 +1252,9 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 		data->tmu_set_emulation = exynos5440_tmu_set_emulation;
 		data->tmu_clear_irqs = exynos5440_tmu_clear_irqs;
 		data->ntrip = 4;
+		data->efuse_value = 0x5d2d;
+		data->min_efuse_value = 16;
+		data->max_efuse_value = 76;
 		break;
 	case SOC_ARCH_EXYNOS7:
 		data->tmu_initialize = exynos7_tmu_initialize;
@@ -1251,6 +1263,9 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 		data->tmu_set_emulation = exynos4412_tmu_set_emulation;
 		data->tmu_clear_irqs = exynos4210_tmu_clear_irqs;
 		data->ntrip = 8;
+		data->efuse_value = 75;
+		data->min_efuse_value = 15;
+		data->max_efuse_value = 100;
 		break;
 	default:
 		dev_err(&pdev->dev, "Platform not supported\n");
diff --git a/drivers/thermal/samsung/exynos_tmu.h b/drivers/thermal/samsung/exynos_tmu.h
index b111a01..4c49312 100644
--- a/drivers/thermal/samsung/exynos_tmu.h
+++ b/drivers/thermal/samsung/exynos_tmu.h
@@ -45,9 +45,6 @@ enum soc_type {
  * @reference_voltage: reference voltage of amplifier
  *	in the positive-TC generator block
  *	0 < reference_voltage <= 31
- * @efuse_value: platform defined fuse value
- * @min_efuse_value: minimum valid trimming data
- * @max_efuse_value: maximum valid trimming data
  * @cal_type: calibration type for temperature
  *
  * This structure is required for configuration of exynos_tmu driver.
@@ -56,10 +53,6 @@ struct exynos_tmu_platform_data {
 	u8 gain;
 	u8 reference_voltage;
 
-	u32 efuse_value;
-	u32 min_efuse_value;
-	u32 max_efuse_value;
-
 	u32 cal_type;
 };
 
-- 
1.9.1

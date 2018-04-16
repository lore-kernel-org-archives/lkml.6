Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754158AbeDPKOQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 06:14:16 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:52095 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753842AbeDPKOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 06:14:11 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180416101410epoutp028d013cd69de9a5e8a9fc9a062af0d31f~l4wLKKUqQ0411004110epoutp028
X-AuditID: b6c32a39-579ff70000000ff4-84-5ad477711205
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
Subject: [PATCH 08/14] thermal: exynos: remove parsing of
 samsung,tmu[_min,_max]_efuse_value properties
Date: Mon, 16 Apr 2018 12:11:59 +0200
Message-id: <1523873525-23718-9-git-send-email-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1523873525-23718-1-git-send-email-b.zolnierkie@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAIsWRmVeSWpSXmKPExsWy7bCmgW5h+ZUog/8tZhYbZ6xntZj3WdZi
        /pVrrBb9j18zW5w/v4Hd4vKuOWwWn3uPMFrMOL+PyeLJwz42B06PnbPusnss3vOSyWPTqk42
        jzvX9rB59G1ZxejxeZNcAFsUl01Kak5mWWqRvl0CV0bnme+sBVvNK7a+OsXcwDhHr4uRk0NC
        wERixbRr7F2MXBxCAjsYJT733WUHSQgJfGeUWLpJDqZofeMpNoiiDYwSC1a0M0M4vxglLk67
        yQpSxSZgJTGxfRUjiC0ioCVx4tJ2JpAiZoEJTBJPX81kA0kIC2RKXFzSwwxiswioSry9+pIF
        xOYV8JBoWrSAEWKdnMTJY5PBhnIKeEo0rbkGtlpCYAGbxPrO3UBFHECOi8T8M5UQ9cISr45v
        YYcIS0tcOmoLUd7MKPFtxx5miJoJjBJ71gtB2NYSh49fBJvPLMAn8e5rDytEL69ERxtUiYfE
        +3N3WCBsR4mnh1YyQkJlDqPE4nVWExilFjAyrGIUSy0ozk1PLTYsMNUrTswtLs1L10vOz93E
        CI5XLcsdjMfO+RxiFOBgVOLh3XH2cpQQa2JZcWXuIUYJDmYlEd5liUAh3pTEyqrUovz4otKc
        1OJDjNIcLErivE99zkQJCaQnlqRmp6YWpBbBZJk4OKUaGOuv8VyZ+33Ni/RvqT4rl2vfS5eL
        /nYpm0t74vzSx3d2dO34Wp4oeDWqQ946XV2v6FH97cvmtzRmLvyy3yG6g/H4UdYcO78C7i0B
        TvFe6es6nq9/7p6gf6ut4PmCEwsM1txoaplz+Yr0mar9U5vbdt6aOtEzoXdRj+pkriPMpnpi
        0c+2nN+99p0SS3FGoqEWc1FxIgCgkRSu0wIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNLMWRmVeSWpSXmKPExsVy+t9jQd3C8itRBhf2yVtsnLGe1WLeZ1mL
        +VeusVr0P37NbHH+/AZ2i8u75rBZfO49wmgx4/w+JosnD/vYHDg9ds66y+6xeM9LJo9NqzrZ
        PO5c28Pm0bdlFaPH501yAWxRXDYpqTmZZalF+nYJXBmdZ76zFmw1r9j66hRzA+McvS5GTg4J
        AROJ9Y2n2LoYuTiEBNYxSuxcN5sFwvnFKHH96SdGkCo2ASuJie2rwGwRAS2JE5e2M4EUMQtM
        YJJYsnYRO0hCWCBT4uKSHmYQm0VAVeLt1ZcsIDavgIdE06IFjBDr5CROHpvMCmJzCnhKNK25
        xgZiCwHVNE68yjiBkWcBI8MqRsnUguLc9NxiowLDvNRyveLE3OLSvHS95PzcTYzAINt2WKtv
        B+P9JfGHGAU4GJV4eHecvRwlxJpYVlyZe4hRgoNZSYR3WSJQiDclsbIqtSg/vqg0J7X4EKM0
        B4uSOO/tvGORQgLpiSWp2ampBalFMFkmDk6pBkbNgq+XTfQLynjuh72atKGhbWJc4QOm/rMi
        Vy9lhTay/YipmK/9K2l/kVLPp4SpsYUpr+xkZwSI3lNiXblBh1F8c/MXlqLCdI3pPQ135pyf
        JH+X2eZJpcDzbt4Jf3xmqH5hyd/4tdMtRbNJ4stkq/SYF1+L+L0DvAwnXRXWrLnFqcmYWRX2
        VImlOCPRUIu5qDgRANF3eTouAgAA
X-CMS-MailID: 20180416101409epcas1p4f8e0279a94322d1cc423ced6dfce3362
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20180416101409epcas1p4f8e0279a94322d1cc423ced6dfce3362
X-RootMTR: 20180416101409epcas1p4f8e0279a94322d1cc423ced6dfce3362
References: <1523873525-23718-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180416101409epcas1p4f8e0279a94322d1cc423ced6dfce3362@epcas1p4.samsung.com>
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
index 1fa162d..9a0e961 100644
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
@@ -207,6 +210,9 @@ struct exynos_tmu_data {
 	struct work_struct irq_work;
 	struct mutex lock;
 	struct clk *clk, *clk_sec, *sclk;
+	u32 efuse_value;
+	u32 min_efuse_value;
+	u32 max_efuse_value;
 	u16 temp_error1, temp_error2;
 	struct regulator *regulator;
 	struct thermal_zone_device *tzd;
@@ -283,20 +289,18 @@ static int code_to_temp(struct exynos_tmu_data *data, u16 temp_code)
 
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
 
@@ -655,7 +659,6 @@ static int exynos7_tmu_initialize(struct platform_device *pdev)
 {
 	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
 	struct thermal_zone_device *tz = data->tzd;
-	struct exynos_tmu_platform_data *pdata = data->pdata;
 	unsigned int status, trim_info;
 	unsigned int rising_threshold = 0, falling_threshold = 0;
 	int ret = 0, threshold_code, i;
@@ -672,9 +675,9 @@ static int exynos7_tmu_initialize(struct platform_device *pdev)
 
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
@@ -1136,13 +1139,6 @@ static int exynos_of_sensor_conf(struct device_node *np,
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
@@ -1196,6 +1192,9 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 		data->tmu_read = exynos4210_tmu_read;
 		data->tmu_clear_irqs = exynos4210_tmu_clear_irqs;
 		data->ntrip = 4;
+		data->efuse_value = 55;
+		data->min_efuse_value = 40;
+		data->max_efuse_value = 100;
 		break;
 	case SOC_ARCH_EXYNOS3250:
 	case SOC_ARCH_EXYNOS4412:
@@ -1209,6 +1208,13 @@ static int exynos_map_dt_data(struct platform_device *pdev)
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
@@ -1217,6 +1223,9 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 		data->tmu_set_emulation = exynos4412_tmu_set_emulation;
 		data->tmu_clear_irqs = exynos4210_tmu_clear_irqs;
 		data->ntrip = 8;
+		data->efuse_value = 75;
+		data->min_efuse_value = 40;
+		data->max_efuse_value = 150;
 		break;
 	case SOC_ARCH_EXYNOS5440:
 		data->tmu_initialize = exynos5440_tmu_initialize;
@@ -1225,6 +1234,9 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 		data->tmu_set_emulation = exynos5440_tmu_set_emulation;
 		data->tmu_clear_irqs = exynos5440_tmu_clear_irqs;
 		data->ntrip = 4;
+		data->efuse_value = 0x5d2d;
+		data->min_efuse_value = 16;
+		data->max_efuse_value = 76;
 		break;
 	case SOC_ARCH_EXYNOS7:
 		data->tmu_initialize = exynos7_tmu_initialize;
@@ -1233,6 +1245,9 @@ static int exynos_map_dt_data(struct platform_device *pdev)
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

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753792AbeCFOrS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 09:47:18 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:38671 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933079AbeCFOpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 09:45:07 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180306144505epoutp036b5cca3f98edc712d28badcba6e2ae90~ZXABbEY_G1736017360epoutp03i
X-AuditID: b6c32a45-3ebff70000001023-f8-5a9ea970d243
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
Subject: [PATCH 08/12] thermal: exynos: remove parsing of
 samsung,tmu_cal_type property
Date: Tue, 06 Mar 2018 15:43:51 +0100
Message-id: <1520347435-22970-9-git-send-email-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1520347435-22970-1-git-send-email-b.zolnierkie@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrIIsWRmVeSWpSXmKPExsWy7bCmhW7BynlRBg8mKFtsnLGe1WL+kXNA
        4so1Vov+x6+ZLc6f38BusekxkHt51xw2i8+9RxgtZpzfx2RxaOpeRoul1y8yWbTuPcJu8eRh
        H5sDr8eaeWsYPS5fu8jssXPWXXaPxXteMnlsWtXJ5rF5Sb1H35ZVjB6fN8kFcERx2aSk5mSW
        pRbp2yVwZVw4cZe14KVOxbkp55kaGBtUuxg5OSQETCQ6rq9k7WLk4hAS2MEosXPrT2YI5zuj
        xJWTc4EyHGBVRyb7QMR3M0pc+DyPCcL5xShx/exGVpBRbAJWEhPbVzGC2CICJRLTVvUyghQx
        C5xlktix/R0LSEJYIFJi09FrTCA2i4CqRNutu2DNvAIeEic23GOHuElO4uSxyWBxTgFPiRMd
        59hABkkInGCTaJ+znhmiyEXi7dJPjBC2sMSr41ugmqUlnq3ayAjR0Mwo8W3HHqiGCYwSe9YL
        QdjWEoePXwTbwCzAJ9Fx+C87xJ+8Eh1tUCUeEle+PWGDsB0lpj9bCg2XOYwSC5cuZ53AKLWA
        kWEVo1hqQXFuemqxUYGhXnFibnFpXrpecn7uJkZwxGu57mCccc7nEKMAB6MSD+8Gj7lRQqyJ
        ZcWVuYcYJTiYlUR4I/TnRQnxpiRWVqUW5ccXleakFh9ilOZgURLnbQtwiRISSE8sSc1OTS1I
        LYLJMnFwSjUwHi73uPgrnGHJKz0f7q9S/N/D9lgwJKs9Wea0eDu7zJQJd/yaeIV+y69ZXj51
        Qp/Hyj4zw6ki59xqFjDKnk/fM9H40hfGdU5fMwvmFjh7C0+xduAV+TjT/5//5/SNSbPEpdXW
        O2dPlw99dVfursK8xW8D9lbGvl7Qkzb9bawbh8kFbY49qx4vVWIpzkg01GIuKk4EAFxvPIP0
        AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGLMWRmVeSWpSXmKPExsVy+t9jAd28lfOiDDZeMrXYOGM9q8X8I+eA
        xJVrrBb9j18zW5w/v4HdYtNjIPfyrjlsFp97jzBazDi/j8ni0NS9jBZLr19ksmjde4Td4snD
        PjYHXo8189Ywely+dpHZY+esu+wei/e8ZPLYtKqTzWPzknqPvi2rGD0+b5IL4IjisklJzcks
        Sy3St0vgyrhw4i5rwUudinNTzjM1MDaodjFycEgImEgcmezTxcjFISSwk1Hi5/SDrBDOL0aJ
        47NXMnYxcnKwCVhJTGxfBWaLCJRIdE57zQxiMwucZZI4+J8DZJCwQKTEg828IGEWAVWJtlt3
        WUFsXgEPiRMb7rGD2BICchInj00Gi3MKeEqc6DjHBmILAdUs7v7NNoGRZwEjwypGydSC4tz0
        3GKjAqO81HK94sTc4tK8dL3k/NxNjMDQ3HZYq38H4+Ml8YcYBTgYlXh4N3jMjRJiTSwrrsw9
        xCjBwawkwhuhPy9KiDclsbIqtSg/vqg0J7X4EKM0B4uSOC9//rFIIYH0xJLU7NTUgtQimCwT
        B6dUA+OO/53tHGr2nPlX3H8oZOuHK+WKr1r/keHOh1Xb57GJXOjLXfM46VZfqf+MR7GZHfYf
        9HM5zoa8V2K6vqiaxW/PRiuVTLf2WYsi5KIUeHuuJmxc8Pv8ed2mVSdu+6xX5P3WK39Rr7ij
        7ON7g0cf6wKDJF6rVYlr194PVpj6caFdQHNQ0gv5AiWW4oxEQy3mouJEAHuXUDJJAgAA
X-CMS-MailID: 20180306144502epcas2p2818ee9c6d378d91fbff666549fb01931
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20180306144502epcas2p2818ee9c6d378d91fbff666549fb01931
X-RootMTR: 20180306144502epcas2p2818ee9c6d378d91fbff666549fb01931
References: <1520347435-22970-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180306144502epcas2p2818ee9c6d378d91fbff666549fb01931@epcas2p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since calibration type for temperature is SoC (not platform) specific
just move it from platform data to struct exynos_tmu_data instance.
Then remove parsing of samsung,tmu_cal_type property. Also remove no
longer needed platform data structure.

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 41 ++++++++----------------------------
 drivers/thermal/samsung/exynos_tmu.h | 10 ---------
 2 files changed, 9 insertions(+), 42 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 262ab41..ab5062b 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -177,7 +177,6 @@
  * struct exynos_tmu_data : A structure to hold the private data of the TMU
 	driver
  * @id: identifier of the one instance of the TMU controller.
- * @pdata: pointer to the tmu platform/configuration data
  * @base: base address of the single instance of the TMU controller.
  * @base_second: base address of the common registers of the TMU controller.
  * @irq: irq number of the TMU controller.
@@ -187,6 +186,7 @@
  * @clk: pointer to the clock structure.
  * @clk_sec: pointer to the clock structure for accessing the base_second.
  * @sclk: pointer to the clock structure for accessing the tmu special clk.
+ * @cal_type: calibration type for temperature
  * @efuse_value: SoC defined fuse value
  * @min_efuse_value: minimum valid trimming data
  * @max_efuse_value: maximum valid trimming data
@@ -208,7 +208,6 @@
  */
 struct exynos_tmu_data {
 	int id;
-	struct exynos_tmu_platform_data *pdata;
 	void __iomem *base;
 	void __iomem *base_second;
 	int irq;
@@ -216,6 +215,7 @@ struct exynos_tmu_data {
 	struct work_struct irq_work;
 	struct mutex lock;
 	struct clk *clk, *clk_sec, *sclk;
+	u32 cal_type;
 	u32 efuse_value;
 	u32 min_efuse_value;
 	u32 max_efuse_value;
@@ -266,10 +266,9 @@ static void exynos_report_trigger(struct exynos_tmu_data *p)
  */
 static int temp_to_code(struct exynos_tmu_data *data, u8 temp)
 {
-	struct exynos_tmu_platform_data *pdata = data->pdata;
 	int temp_code;
 
-	switch (pdata->cal_type) {
+	switch (data->cal_type) {
 	case TYPE_TWO_POINT_TRIMMING:
 		temp_code = (temp - EXYNOS_FIRST_POINT_TRIM) *
 			(data->temp_error2 - data->temp_error1) /
@@ -293,10 +292,9 @@ static int temp_to_code(struct exynos_tmu_data *data, u8 temp)
  */
 static int code_to_temp(struct exynos_tmu_data *data, u16 temp_code)
 {
-	struct exynos_tmu_platform_data *pdata = data->pdata;
 	int temp;
 
-	switch (pdata->cal_type) {
+	switch (data->cal_type) {
 	case TYPE_TWO_POINT_TRIMMING:
 		temp = (temp_code - data->temp_error1) *
 			(EXYNOS_SECOND_POINT_TRIM - EXYNOS_FIRST_POINT_TRIM) /
@@ -536,7 +534,6 @@ static int exynos4412_tmu_initialize(struct platform_device *pdev)
 static int exynos5433_tmu_initialize(struct platform_device *pdev)
 {
 	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
-	struct exynos_tmu_platform_data *pdata = data->pdata;
 	struct thermal_zone_device *tz = data->tzd;
 	unsigned int status, trim_info;
 	unsigned int rising_threshold = 0, falling_threshold = 0;
@@ -563,14 +560,12 @@ static int exynos5433_tmu_initialize(struct platform_device *pdev)
 				>> EXYNOS5433_TRIMINFO_CALIB_SEL_SHIFT;
 
 	switch (cal_type) {
-	case EXYNOS5433_TRIMINFO_ONE_POINT_TRIMMING:
-		pdata->cal_type = TYPE_ONE_POINT_TRIMMING;
-		break;
 	case EXYNOS5433_TRIMINFO_TWO_POINT_TRIMMING:
-		pdata->cal_type = TYPE_TWO_POINT_TRIMMING;
+		data->cal_type = TYPE_TWO_POINT_TRIMMING;
 		break;
+	case EXYNOS5433_TRIMINFO_ONE_POINT_TRIMMING:
 	default:
-		pdata->cal_type = TYPE_ONE_POINT_TRIMMING;
+		data->cal_type = TYPE_ONE_POINT_TRIMMING;
 		break;
 	}
 
@@ -1151,21 +1146,9 @@ static int exynos_of_get_soc_type(struct device_node *np)
 	return -EINVAL;
 }
 
-static int exynos_of_sensor_conf(struct device_node *np,
-				 struct exynos_tmu_platform_data *pdata)
-{
-	of_node_get(np);
-
-	of_property_read_u32(np, "samsung,tmu_cal_type", &pdata->cal_type);
-
-	of_node_put(np);
-	return 0;
-}
-
 static int exynos_map_dt_data(struct platform_device *pdev)
 {
 	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
-	struct exynos_tmu_platform_data *pdata;
 	struct resource res;
 
 	if (!data || !pdev->dev.of_node)
@@ -1192,14 +1175,6 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 		return -EADDRNOTAVAIL;
 	}
 
-	pdata = devm_kzalloc(&pdev->dev,
-			     sizeof(struct exynos_tmu_platform_data),
-			     GFP_KERNEL);
-	if (!pdata)
-		return -ENOMEM;
-
-	exynos_of_sensor_conf(pdev->dev.of_node, pdata);
-	data->pdata = pdata;
 	data->soc = exynos_of_get_soc_type(pdev->dev.of_node);
 
 	switch (data->soc) {
@@ -1284,6 +1259,8 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	data->cal_type = TYPE_ONE_POINT_TRIMMING;
+
 	/*
 	 * Check if the TMU shares some registers and then try to map the
 	 * memory of common registers.
diff --git a/drivers/thermal/samsung/exynos_tmu.h b/drivers/thermal/samsung/exynos_tmu.h
index 689453d..8f56f86 100644
--- a/drivers/thermal/samsung/exynos_tmu.h
+++ b/drivers/thermal/samsung/exynos_tmu.h
@@ -38,14 +38,4 @@ enum soc_type {
 	SOC_ARCH_EXYNOS7,
 };
 
-/**
- * struct exynos_tmu_platform_data
- * @cal_type: calibration type for temperature
- *
- * This structure is required for configuration of exynos_tmu driver.
- */
-struct exynos_tmu_platform_data {
-	u32 cal_type;
-};
-
 #endif /* _EXYNOS_TMU_H */
-- 
1.9.1

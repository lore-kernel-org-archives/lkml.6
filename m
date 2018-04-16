Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754229AbeDPKOX (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 06:14:23 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:52161 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753154AbeDPKOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 06:14:18 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180416101417epoutp028da7dd0c46db92f238163d4db2d20d8f~l4wRsshcQ0411004110epoutp02C
X-AuditID: b6c32a36-f57ff70000000fc2-d4-5ad477786635
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
Subject: [PATCH 10/14] thermal: exynos: remove parsing of samsung,tmu_gain
 property
Date: Mon, 16 Apr 2018 12:12:01 +0200
Message-id: <1523873525-23718-11-git-send-email-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1523873525-23718-1-git-send-email-b.zolnierkie@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAIsWRmVeSWpSXmKPExsWy7bCmnm5F+ZUog2lP1Sw2zljPajHvs6zF
        /CvXWC36H79mtjh/fgO7xeVdc9gsPvceYbSYcX4fk8WTh31sDpweO2fdZfdYvOclk8emVZ1s
        Hneu7WHz6NuyitHj8ya5ALYoLpuU1JzMstQifbsEroy2yYIF31Urfl5NamDcJ9/FyMkhIWAi
        cf7qNqYuRi4OIYEdjBI3N+yBcr4zSvTOXcbSxcgBVrXsLidEfAOjxKP9FxghnF+MEiu77zKD
        jGITsJKY2L6KEcQWEdCSOHFpO9gkZoEJTBJPX81kA0kIC4RK/Jh9HayBRUBV4v6VFawgNq+A
        p8SDNZ9ZIW6Skzh5bDKYzQkUb1pzjQ1kkITAAjaJlec2MUEUuUh07GqFahCWeHV8CzvEqdIS
        l47aQtQ3M0p827GHGaJmAqPEnvVCELa1xOHjF8F6mQX4JN597WGF6OWV6GiDKvGQeHF4EVSr
        o8SSDV+YIT6ewyix5cZ1tgmMUgsYGVYxiqUWFOempxYbFhjpFSfmFpfmpesl5+duYgTHq5bZ
        DsZF53wOMQpwMCrx8O44ezlKiDWxrLgy9xCjBAezkgjvskSgEG9KYmVValF+fFFpTmrxIUZp
        DhYlcd6nPmeihATSE0tSs1NTC1KLYLJMHJxSDYwBqVc2Xdjbdnx1ZtbuLmPxy8EXtve7uYf4
        zfy/o8Cv/vJP5V03Tzw1c3xexXPwgbmx5Z68XM3oRfqXznmIfvrCcKum+NbluR1+Jy7y514w
        tCoOu/nTwcjJw0h2osgVFTcj58SUiOa6JS5GsnePxF7ksq39tTfgp9ecAxN8N6k+MEncfERy
        KZcSS3FGoqEWc1FxIgBE4mwM0wIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOLMWRmVeSWpSXmKPExsVy+t9jQd3y8itRBtMmGVpsnLGe1WLeZ1mL
        +VeusVr0P37NbHH+/AZ2i8u75rBZfO49wmgx4/w+JosnD/vYHDg9ds66y+6xeM9LJo9NqzrZ
        PO5c28Pm0bdlFaPH501yAWxRXDYpqTmZZalF+nYJXBltkwULvqtW/Lya1MC4T76LkYNDQsBE
        Ytldzi5GLg4hgXWMEk1H17N3MXICOb8YJW7cDAax2QSsJCa2r2IEsUUEtCROXNrOBNLALDCB
        SWLJ2kVgDcICoRI/Zl9nBrFZBFQl7l9ZwQpi8wp4SjxY8xnMlhCQkzh5bDKYzQkUb1pzjQ1i
        mYdE48SrjBMYeRYwMqxilEwtKM5Nzy02KjDMSy3XK07MLS7NS9dLzs/dxAgMrm2Htfp2MN5f
        En+IUYCDUYmHd8fZy1FCrIllxZW5hxglOJiVRHiXJQKFeFMSK6tSi/Lji0pzUosPMUpzsCiJ
        897OOxYpJJCeWJKanZpakFoEk2Xi4JRqYGQRYnt1sOFYTcRWp7qE90evB31KCnJ9abBg/aeK
        5Wd3LGNdefPi/sVuVV9flTErZaz9nHPFb2lF3q5LO+U/xm0zVMl8umHL14yjvh+PLm29uvBd
        08n69vf7PLcvF1Q9oLhG7pv958dZN4P7Uvku6fXUcGzemxU5tbEw4eWLjxNN8y4sv1OcrX5V
        iaU4I9FQi7moOBEAOhU9PCoCAAA=
X-CMS-MailID: 20180416101415epcas1p1b1108c9d654a7b2832179b5c1f49ff4a
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20180416101415epcas1p1b1108c9d654a7b2832179b5c1f49ff4a
X-RootMTR: 20180416101415epcas1p1b1108c9d654a7b2832179b5c1f49ff4a
References: <1523873525-23718-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180416101415epcas1p1b1108c9d654a7b2832179b5c1f49ff4a@epcas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since pdata gain values are SoC (not platform) specific just move
it from platform data to struct exynos_tmu_data instance. Then
remove parsing of samsung,tmu_gain property.

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 18 +++++++++---------
 drivers/thermal/samsung/exynos_tmu.h |  4 ----
 2 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 6db6ef6..3cdbc09 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -192,6 +192,8 @@
  * @max_efuse_value: maximum valid trimming data
  * @temp_error1: fused value of the first point trim.
  * @temp_error2: fused value of the second point trim.
+ * @gain: gain of amplifier in the positive-TC generator block
+ *	0 < gain <= 15
  * @reference_voltage: reference voltage of amplifier
  *	in the positive-TC generator block
  *	0 < reference_voltage <= 31
@@ -219,6 +221,7 @@ struct exynos_tmu_data {
 	u32 min_efuse_value;
 	u32 max_efuse_value;
 	u16 temp_error1, temp_error2;
+	u8 gain;
 	u8 reference_voltage;
 	struct regulator *regulator;
 	struct thermal_zone_device *tzd;
@@ -368,8 +371,6 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
 
 static u32 get_con_reg(struct exynos_tmu_data *data, u32 con)
 {
-	struct exynos_tmu_platform_data *pdata = data->pdata;
-
 	if (data->soc == SOC_ARCH_EXYNOS4412 ||
 	    data->soc == SOC_ARCH_EXYNOS3250)
 		con |= (EXYNOS4412_MUX_ADDR_VALUE << EXYNOS4412_MUX_ADDR_SHIFT);
@@ -378,7 +379,7 @@ static u32 get_con_reg(struct exynos_tmu_data *data, u32 con)
 	con |= data->reference_voltage << EXYNOS_TMU_REF_VOLTAGE_SHIFT;
 
 	con &= ~(EXYNOS_TMU_BUF_SLOPE_SEL_MASK << EXYNOS_TMU_BUF_SLOPE_SEL_SHIFT);
-	con |= (pdata->gain << EXYNOS_TMU_BUF_SLOPE_SEL_SHIFT);
+	con |= (data->gain << EXYNOS_TMU_BUF_SLOPE_SEL_SHIFT);
 
 	con &= ~(EXYNOS_TMU_TRIP_MODE_MASK << EXYNOS_TMU_TRIP_MODE_SHIFT);
 	con |= (EXYNOS_NOISE_CANCEL_MODE << EXYNOS_TMU_TRIP_MODE_SHIFT);
@@ -1135,14 +1136,8 @@ static irqreturn_t exynos_tmu_irq(int irq, void *id)
 static int exynos_of_sensor_conf(struct device_node *np,
 				 struct exynos_tmu_platform_data *pdata)
 {
-	u32 value;
-	int ret;
-
 	of_node_get(np);
 
-	ret = of_property_read_u32(np, "samsung,tmu_gain", &value);
-	pdata->gain = (u8)value;
-
 	of_property_read_u32(np, "samsung,tmu_cal_type", &pdata->cal_type);
 
 	of_node_put(np);
@@ -1196,6 +1191,7 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 		data->tmu_read = exynos4210_tmu_read;
 		data->tmu_clear_irqs = exynos4210_tmu_clear_irqs;
 		data->ntrip = 4;
+		data->gain = 15;
 		data->reference_voltage = 7;
 		data->efuse_value = 55;
 		data->min_efuse_value = 40;
@@ -1213,6 +1209,7 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 		data->tmu_set_emulation = exynos4412_tmu_set_emulation;
 		data->tmu_clear_irqs = exynos4210_tmu_clear_irqs;
 		data->ntrip = 4;
+		data->gain = 8;
 		data->reference_voltage = 16;
 		data->efuse_value = 55;
 		if (data->soc != SOC_ARCH_EXYNOS5420 &&
@@ -1229,6 +1226,7 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 		data->tmu_set_emulation = exynos4412_tmu_set_emulation;
 		data->tmu_clear_irqs = exynos4210_tmu_clear_irqs;
 		data->ntrip = 8;
+		data->gain = 8;
 		if (res.start == EXYNOS5433_G3D_BASE)
 			data->reference_voltage = 23;
 		else
@@ -1244,6 +1242,7 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 		data->tmu_set_emulation = exynos5440_tmu_set_emulation;
 		data->tmu_clear_irqs = exynos5440_tmu_clear_irqs;
 		data->ntrip = 4;
+		data->gain = 5;
 		data->reference_voltage = 16;
 		data->efuse_value = 0x5d2d;
 		data->min_efuse_value = 16;
@@ -1256,6 +1255,7 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 		data->tmu_set_emulation = exynos4412_tmu_set_emulation;
 		data->tmu_clear_irqs = exynos4210_tmu_clear_irqs;
 		data->ntrip = 8;
+		data->gain = 9;
 		data->reference_voltage = 17;
 		data->efuse_value = 75;
 		data->min_efuse_value = 15;
diff --git a/drivers/thermal/samsung/exynos_tmu.h b/drivers/thermal/samsung/exynos_tmu.h
index 9f4318c..689453d 100644
--- a/drivers/thermal/samsung/exynos_tmu.h
+++ b/drivers/thermal/samsung/exynos_tmu.h
@@ -40,15 +40,11 @@ enum soc_type {
 
 /**
  * struct exynos_tmu_platform_data
- * @gain: gain of amplifier in the positive-TC generator block
- *	0 < gain <= 15
  * @cal_type: calibration type for temperature
  *
  * This structure is required for configuration of exynos_tmu driver.
  */
 struct exynos_tmu_platform_data {
-	u8 gain;
-
 	u32 cal_type;
 };
 
-- 
1.9.1

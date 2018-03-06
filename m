Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933312AbeCFOpK (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 09:45:10 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:49767 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932313AbeCFOpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 09:45:02 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180306144500epoutp028a03bfaf4a7e539ccc06563c42fd6435~ZW-8kitTd1274612746epoutp02b
X-AuditID: b6c32a47-19fff7000000100c-72-5a9ea96b2736
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
Subject: [PATCH 07/12] thermal: exynos: remove parsing of samsung,tmu_gain
 property
Date: Tue, 06 Mar 2018 15:43:50 +0100
Message-id: <1520347435-22970-8-git-send-email-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1520347435-22970-1-git-send-email-b.zolnierkie@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrAIsWRmVeSWpSXmKPExsWy7bCmqW72ynlRBp/XS1hsnLGe1WL+kXNA
        4so1Vov+x6+ZLc6f38BusekxkHt51xw2i8+9RxgtZpzfx2RxaOpeRoul1y8yWbTuPcJu8eRh
        H5sDr8eaeWsYPS5fu8jssXPWXXaPxXteMnlsWtXJ5rF5Sb1H35ZVjB6fN8kFcERx2aSk5mSW
        pRbp2yVwZVz99ZO14I9qxdKGdpYGxiPyXYycHBICJhK7Pj5i72Lk4hAS2MEo8eH8VWYI5zuj
        xPxpE4EcDrCqM4tVIeK7GSUWPJ/IBOH8YpTY2XuRDWQUm4CVxMT2VYwgtohAicS0Vb2MIEXM
        AmeZJHZsf8cCkhAWCJVoWb2dGcRmEVCVeDhxISvIBl4BD4n/+8ohTpKTOHlsMiuIzSngKXGi
        4xwbyBwJgRNsEhfeb2GCKHKR+HF0LSOELSzx6vgWdghbWuLZqo2MEA3NjBLfduxhhkhMYJTY
        s14IwraWOHz8ItgGZgE+iY7Df9kh3uSV6GiDKvGQWHrkDguE7Sixe10fNIzmMEosb53GOIFR
        agEjwypGsdSC4tz01GKjAmO94sTc4tK8dL3k/NxNjOB413LfwbjtnM8hRgEORiUe3g0ec6OE
        WBPLiitzDzFKcDArifBG6M+LEuJNSaysSi3Kjy8qzUktPsQozcGiJM7bGuASJSSQnliSmp2a
        WpBaBJNl4uCUamAMcuDJ+j6ftff68vJ4U3Pf02c1TlkVet3d9UBSvFVqx4HfNSWVdmYtbh7L
        34l/cPtso78t6UrN/J5fT5mn6B9MijTo+X9bUYpzsVaiG9vhZz3V1hlWMZefsJ/5HpihlbRf
        fGdIkeGeAus2u1UBrtuDlTy+6D97/WnJjzzPu5JN7/SdlreLCSuxFGckGmoxFxUnAgAHzEhb
        8wIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGLMWRmVeSWpSXmKPExsVy+t9jAd2slfOiDA4/kbLYOGM9q8X8I+eA
        xJVrrBb9j18zW5w/v4HdYtNjIPfyrjlsFp97jzBazDi/j8ni0NS9jBZLr19ksmjde4Td4snD
        PjYHXo8189Ywely+dpHZY+esu+wei/e8ZPLYtKqTzWPzknqPvi2rGD0+b5IL4IjisklJzcks
        Sy3St0vgyrj66ydrwR/ViqUN7SwNjEfkuxg5OCQETCTOLFbtYuTiEBLYySix6tVLVgjnF5Bz
        5DlbFyMnB5uAlcTE9lWMILaIQIlE57TXzCA2s8BZJomD/zlAbGGBUImW1dvB4iwCqhIPJy5k
        BVnAK+Ah8X9fOUhYQkBO4uSxyawgNqeAp8SJjnNg44WAShZ3/2abwMizgJFhFaNkakFxbnpu
        sVGBUV5quV5xYm5xaV66XnJ+7iZGYGhuO6zVv4Px8ZL4Q4wCHIxKPLwbPOZGCbEmlhVX5h5i
        lOBgVhLhjdCfFyXEm5JYWZValB9fVJqTWnyIUZqDRUmclz//WKSQQHpiSWp2ampBahFMlomD
        U6qBcYq5xaFbTCuaOlIWNQfv6JquZ26pG6VWtj6qPODp68kHrhwWdrDNONwxkZdPs/BKtJbR
        XTMl0bh4vwV2z7yMjSY9W9TQMqdqPd/mXfZuqlzsP6uMYs/5sdxYNN3x3iXPHeH28ybJyjU+
        4M6+GpsQ7bfu5J2zh1Mjpin+NRdkuySypbAk99JPJZbijERDLeai4kQANDFNHEkCAAA=
X-CMS-MailID: 20180306144458epcas2p1102a06fa3e58b88cad914be624e0c1db
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20180306144458epcas2p1102a06fa3e58b88cad914be624e0c1db
X-RootMTR: 20180306144458epcas2p1102a06fa3e58b88cad914be624e0c1db
References: <1520347435-22970-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180306144458epcas2p1102a06fa3e58b88cad914be624e0c1db@epcas2p1.samsung.com>
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
index 12bbf79..262ab41 100644
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
@@ -218,6 +220,7 @@ struct exynos_tmu_data {
 	u32 min_efuse_value;
 	u32 max_efuse_value;
 	u16 temp_error1, temp_error2;
+	u8 gain;
 	u8 reference_voltage;
 	struct regulator *regulator;
 	struct thermal_zone_device *tzd;
@@ -386,8 +389,6 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
 
 static u32 get_con_reg(struct exynos_tmu_data *data, u32 con)
 {
-	struct exynos_tmu_platform_data *pdata = data->pdata;
-
 	if (data->soc == SOC_ARCH_EXYNOS4412 ||
 	    data->soc == SOC_ARCH_EXYNOS3250)
 		con |= (EXYNOS4412_MUX_ADDR_VALUE << EXYNOS4412_MUX_ADDR_SHIFT);
@@ -396,7 +397,7 @@ static u32 get_con_reg(struct exynos_tmu_data *data, u32 con)
 	con |= data->reference_voltage << EXYNOS_TMU_REF_VOLTAGE_SHIFT;
 
 	con &= ~(EXYNOS_TMU_BUF_SLOPE_SEL_MASK << EXYNOS_TMU_BUF_SLOPE_SEL_SHIFT);
-	con |= (pdata->gain << EXYNOS_TMU_BUF_SLOPE_SEL_SHIFT);
+	con |= (data->gain << EXYNOS_TMU_BUF_SLOPE_SEL_SHIFT);
 
 	con &= ~(EXYNOS_TMU_TRIP_MODE_MASK << EXYNOS_TMU_TRIP_MODE_SHIFT);
 	con |= (EXYNOS_NOISE_CANCEL_MODE << EXYNOS_TMU_TRIP_MODE_SHIFT);
@@ -1153,14 +1154,8 @@ static int exynos_of_get_soc_type(struct device_node *np)
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
@@ -1214,6 +1209,7 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 		data->tmu_read = exynos4210_tmu_read;
 		data->tmu_clear_irqs = exynos4210_tmu_clear_irqs;
 		data->ntrip = 4;
+		data->gain = 15;
 		data->reference_voltage = 7;
 		data->efuse_value = 55;
 		data->min_efuse_value = 40;
@@ -1231,6 +1227,7 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 		data->tmu_set_emulation = exynos4412_tmu_set_emulation;
 		data->tmu_clear_irqs = exynos4210_tmu_clear_irqs;
 		data->ntrip = 4;
+		data->gain = 8;
 		data->reference_voltage = 16;
 		data->efuse_value = 55;
 		if (data->soc != SOC_ARCH_EXYNOS5420 &&
@@ -1247,6 +1244,7 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 		data->tmu_set_emulation = exynos4412_tmu_set_emulation;
 		data->tmu_clear_irqs = exynos4210_tmu_clear_irqs;
 		data->ntrip = 8;
+		data->gain = 8;
 		if (res.start == EXYNOS5433_G3D_BASE)
 			data->reference_voltage = 23;
 		else
@@ -1262,6 +1260,7 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 		data->tmu_set_emulation = exynos5440_tmu_set_emulation;
 		data->tmu_clear_irqs = exynos5440_tmu_clear_irqs;
 		data->ntrip = 4;
+		data->gain = 5;
 		data->reference_voltage = 16;
 		data->efuse_value = 0x5d2d;
 		data->min_efuse_value = 16;
@@ -1274,6 +1273,7 @@ static int exynos_map_dt_data(struct platform_device *pdev)
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

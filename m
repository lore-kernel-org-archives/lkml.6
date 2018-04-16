Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754689AbeDPKPz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 06:15:55 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:52140 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753975AbeDPKOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 06:14:15 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180416101413epoutp021a199993344fe90ceda5be6ea4cf48d8~l4wOcfVDg0419904199epoutp027
X-AuditID: b6c32a45-6ebff70000000fe4-7f-5ad477753ee4
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
Subject: [PATCH 09/14] thermal: exynos: remove parsing of
 samsung,tmu_reference_voltage property
Date: Mon, 16 Apr 2018 12:12:00 +0200
Message-id: <1523873525-23718-10-git-send-email-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1523873525-23718-1-git-send-email-b.zolnierkie@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIIsWRmVeSWpSXmKPExsWy7bCmmW5p+ZUogynTWS02zljPajHvs6zF
        /CvXWC36H79mtjh/fgO7xeVdc9gsPvceYbSYcX4fk8WTh31sDpweO2fdZfdYvOclk8emVZ1s
        Hneu7WHz6NuyitHj8ya5ALYoLpuU1JzMstQifbsEroyepVOYCj6rV7Q++snYwLhasYuRg0NC
        wETi5XbxLkYuDiGBHYwSByfsY+9i5ARyvjNKPH4UBWKD1Fy4fYwRomgDo0TDzHNQRb8YJfoP
        FoDYbAJWEhPbVzGC2CICWhInLm1nAmlgFpjAJPH01Uw2kISwQJLEl83HmEFsFgFViT1/1oAN
        4hXwlOi6sJkFYpucxMljk1lBbE6geNOaa2wggyQEFrBJnDj5nxmiyEXi+pyNjBC2sMSr41vY
        IWxpiWerNjJCNDQzSnzbsQeqYQKjxJ71QhC2tcTh4xfBNjAL8El0HP7LDgkLXomONqgSD4mN
        Dy+xQtiOEu3v57NCvD+HUaLt4g6mCYxSCxgZVjGKpRYU56anFhsVGOoVJ+YWl+al6yXn525i
        BEeslusOxhnnfA4xCnAwKvHw7jh7OUqINbGsuDL3EKMEB7OSCO+yRKAQb0piZVVqUX58UWlO
        avEhRmkOFiVx3gbfM1FCAumJJanZqakFqUUwWSYOTqkGxhkyyR1nUz61yiv2rPm/uejZre1v
        lV0Xf3Y8+J13Pt/kpxOv6E9vF5EtO6l9kelIsVa0WvuNw25/zV78+8Vn+c8tgkWmvKcv5tCu
        Fbs/RJ5dwGzRUjV5XgJ/x5TCL+s+znjzVNOgkGVd+Oxomw+qwSrnj339coktTprh3IKwy6Hr
        9+14wb1TNF6JpTgj0VCLuag4EQAsThKX1AIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNLMWRmVeSWpSXmKPExsVy+t9jQd2S8itRBv//q1tsnLGe1WLeZ1mL
        +VeusVr0P37NbHH+/AZ2i8u75rBZfO49wmgx4/w+JosnD/vYHDg9ds66y+6xeM9LJo9NqzrZ
        PO5c28Pm0bdlFaPH501yAWxRXDYpqTmZZalF+nYJXBk9S6cwFXxWr2h99JOxgXG1YhcjJ4eE
        gInEhdvHGLsYuTiEBNYxSmw/coEdwvnFKPH/9Fp2kCo2ASuJie2rGEFsEQEtiROXtjOBFDEL
        TGCSWLJ2EViRsECSxJfNx5hBbBYBVYk9f9aAxXkFPCW6LmxmgVgnJ3Hy2GRWEJsTKN605hob
        iC0k4CHROPEq4wRGngWMDKsYJVMLinPTc4uNCozyUsv1ihNzi0vz0vWS83M3MQKDbNthrf4d
        jI+XxB9iFOBgVOLh3XH2cpQQa2JZcWXuIUYJDmYlEd5liUAh3pTEyqrUovz4otKc1OJDjNIc
        LErivPz5xyKFBNITS1KzU1MLUotgskwcnFINjD2J8n8+rn0jYc54/rXf9Jo1+kamqWZHrsuG
        TrXOfD4zTLsylrn6eO40SR4Vc8G3rjsPlBQeOnPm2YOgojviDudOp+gG8tr73g0LfWV8JuXO
        YZ8Lr+dxdaSVb1lp+z9TsWat0JtwX0bZq+Xy2zMPiWloH9EOd9PxzXXrrg+d0SRR9CP3g/wm
        JZbijERDLeai4kQAy00COy4CAAA=
X-CMS-MailID: 20180416101412epcas2p241ac78d221c7c288e79fc410dd90d6ab
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20180416101412epcas2p241ac78d221c7c288e79fc410dd90d6ab
X-RootMTR: 20180416101412epcas2p241ac78d221c7c288e79fc410dd90d6ab
References: <1523873525-23718-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180416101412epcas2p241ac78d221c7c288e79fc410dd90d6ab@epcas2p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since pdata reference_voltage values are SoC (not platform) specific
just move it from platform data to struct exynos_tmu_data instance.
Then remove parsing of samsung,tmu_reference_voltage property.

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 18 +++++++++++++++---
 drivers/thermal/samsung/exynos_tmu.h |  4 ----
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 9a0e961..6db6ef6 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -123,6 +123,8 @@
 
 #define EXYNOS5433_PD_DET_EN			1
 
+#define EXYNOS5433_G3D_BASE			0x10070000
+
 /*exynos5440 specific registers*/
 #define EXYNOS5440_TMU_S0_7_TRIM		0x000
 #define EXYNOS5440_TMU_S0_7_CTRL		0x020
@@ -190,6 +192,9 @@
  * @max_efuse_value: maximum valid trimming data
  * @temp_error1: fused value of the first point trim.
  * @temp_error2: fused value of the second point trim.
+ * @reference_voltage: reference voltage of amplifier
+ *	in the positive-TC generator block
+ *	0 < reference_voltage <= 31
  * @regulator: pointer to the TMU regulator structure.
  * @reg_conf: pointer to structure to register with core thermal.
  * @ntrip: number of supported trip points.
@@ -214,6 +219,7 @@ struct exynos_tmu_data {
 	u32 min_efuse_value;
 	u32 max_efuse_value;
 	u16 temp_error1, temp_error2;
+	u8 reference_voltage;
 	struct regulator *regulator;
 	struct thermal_zone_device *tzd;
 	unsigned int ntrip;
@@ -369,7 +375,7 @@ static u32 get_con_reg(struct exynos_tmu_data *data, u32 con)
 		con |= (EXYNOS4412_MUX_ADDR_VALUE << EXYNOS4412_MUX_ADDR_SHIFT);
 
 	con &= ~(EXYNOS_TMU_REF_VOLTAGE_MASK << EXYNOS_TMU_REF_VOLTAGE_SHIFT);
-	con |= pdata->reference_voltage << EXYNOS_TMU_REF_VOLTAGE_SHIFT;
+	con |= data->reference_voltage << EXYNOS_TMU_REF_VOLTAGE_SHIFT;
 
 	con &= ~(EXYNOS_TMU_BUF_SLOPE_SEL_MASK << EXYNOS_TMU_BUF_SLOPE_SEL_SHIFT);
 	con |= (pdata->gain << EXYNOS_TMU_BUF_SLOPE_SEL_SHIFT);
@@ -1136,8 +1142,6 @@ static int exynos_of_sensor_conf(struct device_node *np,
 
 	ret = of_property_read_u32(np, "samsung,tmu_gain", &value);
 	pdata->gain = (u8)value;
-	of_property_read_u32(np, "samsung,tmu_reference_voltage", &value);
-	pdata->reference_voltage = (u8)value;
 
 	of_property_read_u32(np, "samsung,tmu_cal_type", &pdata->cal_type);
 
@@ -1192,6 +1196,7 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 		data->tmu_read = exynos4210_tmu_read;
 		data->tmu_clear_irqs = exynos4210_tmu_clear_irqs;
 		data->ntrip = 4;
+		data->reference_voltage = 7;
 		data->efuse_value = 55;
 		data->min_efuse_value = 40;
 		data->max_efuse_value = 100;
@@ -1208,6 +1213,7 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 		data->tmu_set_emulation = exynos4412_tmu_set_emulation;
 		data->tmu_clear_irqs = exynos4210_tmu_clear_irqs;
 		data->ntrip = 4;
+		data->reference_voltage = 16;
 		data->efuse_value = 55;
 		if (data->soc != SOC_ARCH_EXYNOS5420 &&
 		    data->soc != SOC_ARCH_EXYNOS5420_TRIMINFO)
@@ -1223,6 +1229,10 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 		data->tmu_set_emulation = exynos4412_tmu_set_emulation;
 		data->tmu_clear_irqs = exynos4210_tmu_clear_irqs;
 		data->ntrip = 8;
+		if (res.start == EXYNOS5433_G3D_BASE)
+			data->reference_voltage = 23;
+		else
+			data->reference_voltage = 16;
 		data->efuse_value = 75;
 		data->min_efuse_value = 40;
 		data->max_efuse_value = 150;
@@ -1234,6 +1244,7 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 		data->tmu_set_emulation = exynos5440_tmu_set_emulation;
 		data->tmu_clear_irqs = exynos5440_tmu_clear_irqs;
 		data->ntrip = 4;
+		data->reference_voltage = 16;
 		data->efuse_value = 0x5d2d;
 		data->min_efuse_value = 16;
 		data->max_efuse_value = 76;
@@ -1245,6 +1256,7 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 		data->tmu_set_emulation = exynos4412_tmu_set_emulation;
 		data->tmu_clear_irqs = exynos4210_tmu_clear_irqs;
 		data->ntrip = 8;
+		data->reference_voltage = 17;
 		data->efuse_value = 75;
 		data->min_efuse_value = 15;
 		data->max_efuse_value = 100;
diff --git a/drivers/thermal/samsung/exynos_tmu.h b/drivers/thermal/samsung/exynos_tmu.h
index 4c49312..9f4318c 100644
--- a/drivers/thermal/samsung/exynos_tmu.h
+++ b/drivers/thermal/samsung/exynos_tmu.h
@@ -42,16 +42,12 @@ enum soc_type {
  * struct exynos_tmu_platform_data
  * @gain: gain of amplifier in the positive-TC generator block
  *	0 < gain <= 15
- * @reference_voltage: reference voltage of amplifier
- *	in the positive-TC generator block
- *	0 < reference_voltage <= 31
  * @cal_type: calibration type for temperature
  *
  * This structure is required for configuration of exynos_tmu driver.
  */
 struct exynos_tmu_platform_data {
 	u8 gain;
-	u8 reference_voltage;
 
 	u32 cal_type;
 };
-- 
1.9.1

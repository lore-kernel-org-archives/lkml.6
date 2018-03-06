Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933190AbeCFOr4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 09:47:56 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:49753 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933172AbeCFOo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 09:44:57 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180306144455epoutp026142f0ba6f13d219a1b0dbf516093f31~ZW-3mBNek1273812738epoutp02b
X-AuditID: b6c32a46-3c1ff70000001029-3a-5a9ea9662b89
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
Subject: [PATCH 06/12] thermal: exynos: remove parsing of
 samsung,tmu_reference_voltage property
Date: Tue, 06 Mar 2018 15:43:49 +0100
Message-id: <1520347435-22970-7-git-send-email-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1520347435-22970-1-git-send-email-b.zolnierkie@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPIsWRmVeSWpSXmKPExsWy7bCmqW7aynlRBj194hYbZ6xntZh/5ByQ
        uHKN1aL/8Wtmi/PnN7BbbHoM5F7eNYfN4nPvEUaLGef3MVkcmrqX0WLp9YtMFq17j7BbPHnY
        x+bA67Fm3hpGj8vXLjJ77Jx1l91j8Z6XTB6bVnWyeWxeUu/Rt2UVo8fnTXIBHFFcNimpOZll
        qUX6dglcGXd7etgLPqtXdM2qamBcrdjFyMkhIWAi8fnaCdYuRi4OIYEdjBLrZmxih3C+M0pc
        2buCEabqaP9lVhBbSGA3o8S9fh+Iol+MEhfmPGUCSbAJWElMbF8F1iAiUCIxbVUvI0gRs8BZ
        Jokd29+xgCSEBZIk7j18A9TAwcEioCrRvMIIJMwr4CGxqPEP1DI5iZPHJoMt4xTwlDjRcY4N
        ZI6EwAk2iSVbLjNDFLlItMzdzAJhC0u8Or6FHcKWlni2aiMjREMzo8S3HXugGiYwSuxZLwRh
        W0scPn4RbAOzAJ9Ex+G/7CAHSQjwSnS0QZV4SHya8whqvqPEviW/oMEyh1Hi1ryJLBMYpRYw
        MqxiFEstKM5NTy02KjDSK07MLS7NS9dLzs/dxAiOdi23HYxLzvkcYhTgYFTi4d3gMTdKiDWx
        rLgy9xCjBAezkghvhP68KCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8rQEuUUIC6YklqdmpqQWp
        RTBZJg5OqQZG/knvXthN6lH3iji/rdN1otn5l9dnL/ZgmX6w87JXo4Gsj6vss4OmEgXXJvut
        DS98cUDl5h+/U54X+Y0OKds7Sx/5kBe2JFX7huqRIj8eJwFZlkdM+Xo3GfcIHm/wdvSqUc3m
        muj6eLm9gdezNU+f8MqFlu+JfRcxb9YncwWNwpfW06N2Gn5WYinOSDTUYi4qTgQAjPPJCPIC
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKLMWRmVeSWpSXmKPExsVy+t9jAd3UlfOiDI7etrDYOGM9q8X8I+eA
        xJVrrBb9j18zW5w/v4HdYtNjIPfyrjlsFp97jzBazDi/j8ni0NS9jBZLr19ksmjde4Td4snD
        PjYHXo8189Ywely+dpHZY+esu+wei/e8ZPLYtKqTzWPzknqPvi2rGD0+b5IL4IjisklJzcks
        Sy3St0vgyrjb08Ne8Fm9omtWVQPjasUuRk4OCQETiaP9l1lBbCGBnYwSZ27JdTFyAdm/GCWW
        fDjAApJgE7CSmNi+ihHEFhEokeic9poZxGYWOMskcfA/B4gtLJAkce/hG6YuRg4OFgFVieYV
        RiBhXgEPiUWNfxghdslJnDw2GWwXp4CnxImOc2wQez0kFnf/ZpvAyLOAkWEVo2RqQXFuem6x
        UYFRXmq5XnFibnFpXrpecn7uJkZgYG47rNW/g/HxkvhDjAIcjEo8vBs85kYJsSaWFVfmHmKU
        4GBWEuGN0J8XJcSbklhZlVqUH19UmpNafIhRmoNFSZyXP/9YpJBAemJJanZqakFqEUyWiYNT
        qoHRM1o7uFUx3nBZJ4e8SMnb7uTtAbXbjwms+5ZWsObdeW5hS7WbP9b7rN965Lh366QFqtPd
        OswvqrA8+JC2oYvvw+/uhz229yVWnjzi8tRv7ZoVVzTE+tPYjXunri75Mp0pM/HYjpK6yV1W
        XHsN5HKmPd+clbzOfunRb6/DF949u/FmzeKlzzvmK7EUZyQaajEXFScCADnBx7xIAgAA
X-CMS-MailID: 20180306144453epcas2p2d440c954c21c800e21f121418d7e5ec8
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20180306144453epcas2p2d440c954c21c800e21f121418d7e5ec8
X-RootMTR: 20180306144453epcas2p2d440c954c21c800e21f121418d7e5ec8
References: <1520347435-22970-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180306144453epcas2p2d440c954c21c800e21f121418d7e5ec8@epcas2p2.samsung.com>
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
index 02d34cf..12bbf79 100644
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
@@ -213,6 +218,7 @@ struct exynos_tmu_data {
 	u32 min_efuse_value;
 	u32 max_efuse_value;
 	u16 temp_error1, temp_error2;
+	u8 reference_voltage;
 	struct regulator *regulator;
 	struct thermal_zone_device *tzd;
 	unsigned int ntrip;
@@ -387,7 +393,7 @@ static u32 get_con_reg(struct exynos_tmu_data *data, u32 con)
 		con |= (EXYNOS4412_MUX_ADDR_VALUE << EXYNOS4412_MUX_ADDR_SHIFT);
 
 	con &= ~(EXYNOS_TMU_REF_VOLTAGE_MASK << EXYNOS_TMU_REF_VOLTAGE_SHIFT);
-	con |= pdata->reference_voltage << EXYNOS_TMU_REF_VOLTAGE_SHIFT;
+	con |= data->reference_voltage << EXYNOS_TMU_REF_VOLTAGE_SHIFT;
 
 	con &= ~(EXYNOS_TMU_BUF_SLOPE_SEL_MASK << EXYNOS_TMU_BUF_SLOPE_SEL_SHIFT);
 	con |= (pdata->gain << EXYNOS_TMU_BUF_SLOPE_SEL_SHIFT);
@@ -1154,8 +1160,6 @@ static int exynos_of_sensor_conf(struct device_node *np,
 
 	ret = of_property_read_u32(np, "samsung,tmu_gain", &value);
 	pdata->gain = (u8)value;
-	of_property_read_u32(np, "samsung,tmu_reference_voltage", &value);
-	pdata->reference_voltage = (u8)value;
 
 	of_property_read_u32(np, "samsung,tmu_cal_type", &pdata->cal_type);
 
@@ -1210,6 +1214,7 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 		data->tmu_read = exynos4210_tmu_read;
 		data->tmu_clear_irqs = exynos4210_tmu_clear_irqs;
 		data->ntrip = 4;
+		data->reference_voltage = 7;
 		data->efuse_value = 55;
 		data->min_efuse_value = 40;
 		data->max_efuse_value = 100;
@@ -1226,6 +1231,7 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 		data->tmu_set_emulation = exynos4412_tmu_set_emulation;
 		data->tmu_clear_irqs = exynos4210_tmu_clear_irqs;
 		data->ntrip = 4;
+		data->reference_voltage = 16;
 		data->efuse_value = 55;
 		if (data->soc != SOC_ARCH_EXYNOS5420 &&
 		    data->soc != SOC_ARCH_EXYNOS5420_TRIMINFO)
@@ -1241,6 +1247,10 @@ static int exynos_map_dt_data(struct platform_device *pdev)
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
@@ -1252,6 +1262,7 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 		data->tmu_set_emulation = exynos5440_tmu_set_emulation;
 		data->tmu_clear_irqs = exynos5440_tmu_clear_irqs;
 		data->ntrip = 4;
+		data->reference_voltage = 16;
 		data->efuse_value = 0x5d2d;
 		data->min_efuse_value = 16;
 		data->max_efuse_value = 76;
@@ -1263,6 +1274,7 @@ static int exynos_map_dt_data(struct platform_device *pdev)
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

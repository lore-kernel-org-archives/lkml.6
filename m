Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756145AbeDZLwo (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 07:52:44 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:48408 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755043AbeDZLw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 07:52:29 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180426115227epoutp011db912b66825ceefc3c3b2aeca9ec5c9~o_i2o2B750393003930epoutp01l
X-AuditID: b6c32a37-511ff70000001030-af-5ae1bd7a41d7
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-samsung-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH 11/18] thermal: exynos: add exynos*_tmu_set_[trip,hyst]()
 helpers
Date: Thu, 26 Apr 2018 13:51:26 +0200
Message-id: <1524743493-28113-12-git-send-email-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1524743493-28113-1-git-send-email-b.zolnierkie@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJIsWRmVeSWpSXmKPExsWy7bCmvm7V3odRBitW2FhsnLGe1WL+lWus
        Fpd3zWGz+Nx7hNFixvl9TBZPHvaxObB57Jx1l91j8Z6XTB59W1YxenzeJBfAEsVlk5Kak1mW
        WqRvl8CV8fXhB9aCl4kV15uaWRsYG/y7GDk5JARMJPadecHaxcjFISSwg1Fi2u0+dgjnO6PE
        j0dHWboYOcCqVh3ihIhvYJQ40zadEcL5xSgxfcl3FpBRbAJWEhPbVzGC2CICWhInLm1nAili
        FpjDKDGrYTdYkbBAsMSJNYfYQGwWAVWJmS/Ogdm8Ap4SL1d/ZYW4SU7i5LHJYDYnUPzCkSYW
        kEESAn9ZJaadXccOUeQisedoHxOELSzx6vgWdohTpSUuHbWFqG9mlPi2Yw8zRM0ERok964Ug
        bGuJw8cvgi1gFuCTePe1hxWil1eio00IwvSQ+H4pEaLaUWLngRNsEA8D/fJ/0i7GCYxSCxgZ
        VjGKpRYU56anFhsWGOsVJ+YWl+al6yXn525iBEeglvkOxg3nfA4xCnAwKvHwBix8ECXEmlhW
        XJl7iFGCg1lJhDe+9WGUEG9KYmVValF+fFFpTmrxIUZpDhYlcd6nPmeihATSE0tSs1NTC1KL
        YLJMHJxSDYx5irpvZDTWRZubdemdsHD4EL4wIGeNEGOfllVOesYEhaBL5/w3Km+4PPHZ8a44
        RnmzE5anrD4rnmBc5PntnnXw9HOKH9lkO84tW7iv/a749dol78+nTJPuYwjxZS1g7kjxz6n4
        +W9+3+5vP5QeTbkeuy1UfhZT/Pe0wMTMtzuO72jIPr/32CwlluKMREMt5qLiRABvrj5OvAIA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpiluLIzCtJLcpLzFFi42I5/e+xoG7V3odRBsdOaFpsnLGe1WL+lWus
        Fpd3zWGz+Nx7hNFixvl9TBZPHvaxObB57Jx1l91j8Z6XTB59W1YxenzeJBfAEsVlk5Kak1mW
        WqRvl8CV8fXhB9aCl4kV15uaWRsYG/y7GDk4JARMJFYd4uxi5OIQEljHKLFo8kYmCOcXo8Sa
        CbfZuhg5OdgErCQmtq9iBLFFBLQkTlzaDlbELDCHUeL5ijlMIAlhgWCJE2sOgTWwCKhKzHxx
        DszmFfCUeLn6KyuILSEgJ3Hy2GQwmxMofuFIEwuILSTgIXG/7z3bBEaeBYwMqxglUwuKc9Nz
        i40KDPNSy/WKE3OLS/PS9ZLzczcxAkNm22Gtvh2M95fEH2IU4GBU4uENWPggSog1say4MvcQ
        owQHs5IIb3zrwygh3pTEyqrUovz4otKc1OJDjNIcLErivLfzjkUKCaQnlqRmp6YWpBbBZJk4
        OKUaGB1uzrSrm7ghKCFFzKb8v17Qf843WZWure6NrUq7XnnvClJOm3M5rVfaM+rW5riV2hJS
        SSeOlz5aZRldu2xpqE2r4a2ba4wu/WhlDxV9IS994EvcKrM2u82Z1pvjla2rnxU/XT5vbdvt
        PJVTZWZ5Pw5u+69dVT2r4nn7SjFJ07JIVs3pZU6rlViKMxINtZiLihMBydILpBUCAAA=
X-CMS-MailID: 20180426115226epcas1p2e902011524b5ef6e0b53c314b72f35e0
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20180426115226epcas1p2e902011524b5ef6e0b53c314b72f35e0
X-RootMTR: 20180426115226epcas1p2e902011524b5ef6e0b53c314b72f35e0
References: <1524743493-28113-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180426115226epcas1p2e902011524b5ef6e0b53c314b72f35e0@epcas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add exynos*_tmu_set_[trip,hyst]() helpers and convert
all ->tmu_initialize implementations accordingly.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 282 +++++++++++++++++------------------
 1 file changed, 140 insertions(+), 142 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 82484c5..80265d2 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -305,30 +305,6 @@ static void sanitize_temp_error(struct exynos_tmu_data *data, u32 trim_info)
 			EXYNOS_TMU_TEMP_MASK;
 }
 
-static u32 get_th_reg(struct exynos_tmu_data *data, u32 threshold, bool falling)
-{
-	struct thermal_zone_device *tz = data->tzd;
-	const struct thermal_trip * const trips =
-		of_thermal_get_trip_points(tz);
-	unsigned long temp;
-	int i, ntrips = min_t(int, of_thermal_get_ntrips(tz), data->ntrip);
-
-	for (i = 0; i < ntrips; i++) {
-		if (trips[i].type == THERMAL_TRIP_CRITICAL)
-			continue;
-
-		temp = trips[i].temperature / MCELSIUS;
-		if (falling)
-			temp -= (trips[i].hysteresis / MCELSIUS);
-		else
-			threshold &= ~(0xff << 8 * i);
-
-		threshold |= temp_to_code(data, temp) << 8 * i;
-	}
-
-	return threshold;
-}
-
 static int exynos_tmu_initialize(struct platform_device *pdev)
 {
 	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
@@ -411,37 +387,79 @@ static void exynos_tmu_control(struct platform_device *pdev, bool on)
 	mutex_unlock(&data->lock);
 }
 
+static void exynos4210_tmu_set_trip_temp(struct exynos_tmu_data *data,
+					 int trip, u8 temp)
+{
+	const struct thermal_trip * const trips =
+		of_thermal_get_trip_points(data->tzd);
+	u8 ref, th_code;
+
+	ref = trips[0].temperature / MCELSIUS;
+
+	if (trip == 0) {
+		th_code = temp_to_code(data, ref);
+		writeb(th_code, data->base + EXYNOS4210_TMU_REG_THRESHOLD_TEMP);
+	}
+
+	temp -= ref;
+	writeb(temp, data->base + EXYNOS4210_TMU_REG_TRIG_LEVEL0 + trip * 4);
+}
+
 static void exynos4210_tmu_initialize(struct platform_device *pdev)
 {
 	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
 	struct thermal_zone_device *tz = data->tzd;
 	const struct thermal_trip * const trips =
 		of_thermal_get_trip_points(tz);
-	int threshold_code, i;
-	unsigned long reference, temp;
+	unsigned long temp;
+	int i;
 
 	sanitize_temp_error(data, readl(data->base + EXYNOS_TMU_REG_TRIMINFO));
 
-	/* Write temperature code for threshold */
-	reference = trips[0].temperature / MCELSIUS;
-	threshold_code = temp_to_code(data, reference);
-	writeb(threshold_code, data->base + EXYNOS4210_TMU_REG_THRESHOLD_TEMP);
-
 	for (i = 0; i < of_thermal_get_ntrips(tz); i++) {
 		temp = trips[i].temperature / MCELSIUS;
-		writeb(temp - reference, data->base +
-		       EXYNOS4210_TMU_REG_TRIG_LEVEL0 + i * 4);
+		exynos4210_tmu_set_trip_temp(data, i, temp);
+	}
+}
+
+static void exynos4412_tmu_set_trip_temp(struct exynos_tmu_data *data,
+					 int trip, u8 temp)
+{
+	u32 th, con;
+
+	th = readl(data->base + EXYNOS_THD_TEMP_RISE);
+	th &= ~(0xff << 8 * trip);
+	th |= temp_to_code(data, temp) << 8 * trip;
+	writel(th, data->base + EXYNOS_THD_TEMP_RISE);
+
+	if (trip == 3) {
+		con = readl(data->base + EXYNOS_TMU_REG_CONTROL);
+		con |= (1 << EXYNOS_TMU_THERM_TRIP_EN_SHIFT);
+		writel(con, data->base + EXYNOS_TMU_REG_CONTROL);
 	}
 }
 
+static void exynos4412_tmu_set_trip_hyst(struct exynos_tmu_data *data,
+					 int trip, u8 temp, u8 hyst)
+{
+	u32 th;
+
+	th = readl(data->base + EXYNOS_THD_TEMP_FALL);
+	th &= ~(0xff << 8 * trip);
+	if (hyst)
+		th |= temp_to_code(data, temp - hyst) << 8 * trip;
+	writel(th, data->base + EXYNOS_THD_TEMP_FALL);
+}
+
 static void exynos4412_tmu_initialize(struct platform_device *pdev)
 {
 	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
+	struct thermal_zone_device *tz = data->tzd;
 	const struct thermal_trip * const trips =
-		of_thermal_get_trip_points(data->tzd);
-	unsigned int trim_info, con, ctrl, rising_threshold;
-	int threshold_code, i;
-	unsigned long crit_temp = 0;
+		of_thermal_get_trip_points(tz);
+	unsigned long temp, hyst;
+	unsigned int trim_info, ctrl;
+	int i, ntrips = min_t(int, of_thermal_get_ntrips(tz), data->ntrip);
 
 	if (data->soc == SOC_ARCH_EXYNOS3250 ||
 	    data->soc == SOC_ARCH_EXYNOS4412 ||
@@ -465,27 +483,53 @@ static void exynos4412_tmu_initialize(struct platform_device *pdev)
 	sanitize_temp_error(data, trim_info);
 
 	/* Write temperature code for rising and falling threshold */
-	rising_threshold = readl(data->base + EXYNOS_THD_TEMP_RISE);
-	rising_threshold = get_th_reg(data, rising_threshold, false);
-	writel(rising_threshold, data->base + EXYNOS_THD_TEMP_RISE);
-	writel(get_th_reg(data, 0, true), data->base + EXYNOS_THD_TEMP_FALL);
-
-	/* if last threshold limit is also present */
-	for (i = 0; i < of_thermal_get_ntrips(data->tzd); i++) {
-		if (trips[i].type == THERMAL_TRIP_CRITICAL) {
-			crit_temp = trips[i].temperature;
-			break;
-		}
+	for (i = 0; i < ntrips; i++) {
+		temp = trips[i].temperature / MCELSIUS;
+		exynos4412_tmu_set_trip_temp(data, i, temp);
+
+		hyst = trips[i].hysteresis / MCELSIUS;
+		exynos4412_tmu_set_trip_hyst(data, i, temp, hyst);
 	}
+}
 
-	threshold_code = temp_to_code(data, crit_temp / MCELSIUS);
-	/* 1-4 level to be assigned in th0 reg */
-	rising_threshold &= ~(0xff << 8 * i);
-	rising_threshold |= threshold_code << 8 * i;
-	writel(rising_threshold, data->base + EXYNOS_THD_TEMP_RISE);
-	con = readl(data->base + EXYNOS_TMU_REG_CONTROL);
-	con |= (1 << EXYNOS_TMU_THERM_TRIP_EN_SHIFT);
-	writel(con, data->base + EXYNOS_TMU_REG_CONTROL);
+static void exynos5433_tmu_set_trip_temp(struct exynos_tmu_data *data,
+					 int trip, u8 temp)
+{
+	unsigned int reg_off, j;
+	u32 th;
+
+	if (trip > 3) {
+		reg_off = EXYNOS5433_THD_TEMP_RISE7_4;
+		j = trip - 4;
+	} else {
+		reg_off = EXYNOS5433_THD_TEMP_RISE3_0;
+		j = trip;
+	}
+
+	th = readl(data->base + reg_off);
+	th &= ~(0xff << j * 8);
+	th |= (temp_to_code(data, temp) << j * 8);
+	writel(th, data->base + reg_off);
+}
+
+static void exynos5433_tmu_set_trip_hyst(struct exynos_tmu_data *data,
+					 int trip, u8 temp, u8 hyst)
+{
+	unsigned int reg_off, j;
+	u32 th;
+
+	if (trip > 3) {
+		reg_off = EXYNOS5433_THD_TEMP_FALL7_4;
+		j = trip - 4;
+	} else {
+		reg_off = EXYNOS5433_THD_TEMP_FALL3_0;
+		j = trip;
+	}
+
+	th = readl(data->base + reg_off);
+	th &= ~(0xff << j * 8);
+	th |= (temp_to_code(data, temp - hyst) << j * 8);
+	writel(th, data->base + reg_off);
 }
 
 static void exynos5433_tmu_initialize(struct platform_device *pdev)
@@ -493,9 +537,7 @@ static void exynos5433_tmu_initialize(struct platform_device *pdev)
 	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
 	struct thermal_zone_device *tz = data->tzd;
 	unsigned int trim_info;
-	unsigned int rising_threshold = 0, falling_threshold = 0;
-	int temp, temp_hist;
-	int threshold_code, i, sensor_id, cal_type;
+	int sensor_id, cal_type, i, temp, hyst;
 
 	trim_info = readl(data->base + EXYNOS_TMU_REG_TRIMINFO);
 	sanitize_temp_error(data, trim_info);
@@ -525,111 +567,67 @@ static void exynos5433_tmu_initialize(struct platform_device *pdev)
 
 	/* Write temperature code for rising and falling threshold */
 	for (i = 0; i < of_thermal_get_ntrips(tz); i++) {
-		int rising_reg_offset, falling_reg_offset;
-		int j = 0;
-
-		switch (i) {
-		case 0:
-		case 1:
-		case 2:
-		case 3:
-			rising_reg_offset = EXYNOS5433_THD_TEMP_RISE3_0;
-			falling_reg_offset = EXYNOS5433_THD_TEMP_FALL3_0;
-			j = i;
-			break;
-		case 4:
-		case 5:
-		case 6:
-		case 7:
-			rising_reg_offset = EXYNOS5433_THD_TEMP_RISE7_4;
-			falling_reg_offset = EXYNOS5433_THD_TEMP_FALL7_4;
-			j = i - 4;
-			break;
-		default:
-			continue;
-		}
-
 		/* Write temperature code for rising threshold */
 		tz->ops->get_trip_temp(tz, i, &temp);
 		temp /= MCELSIUS;
-		threshold_code = temp_to_code(data, temp);
-
-		rising_threshold = readl(data->base + rising_reg_offset);
-		rising_threshold &= ~(0xff << j * 8);
-		rising_threshold |= (threshold_code << j * 8);
-		writel(rising_threshold, data->base + rising_reg_offset);
+		exynos5433_tmu_set_trip_temp(data, i, temp);
 
 		/* Write temperature code for falling threshold */
-		tz->ops->get_trip_hyst(tz, i, &temp_hist);
-		temp_hist = temp - (temp_hist / MCELSIUS);
-		threshold_code = temp_to_code(data, temp_hist);
-
-		falling_threshold = readl(data->base + falling_reg_offset);
-		falling_threshold &= ~(0xff << j * 8);
-		falling_threshold |= (threshold_code << j * 8);
-		writel(falling_threshold, data->base + falling_reg_offset);
+		tz->ops->get_trip_hyst(tz, i, &hyst);
+		hyst /= MCELSIUS;
+		exynos5433_tmu_set_trip_hyst(data, i, temp, hyst);
 	}
 }
 
+static void exynos7_tmu_set_trip_temp(struct exynos_tmu_data *data,
+				      int trip, u8 temp)
+{
+	unsigned int reg_off, bit_off;
+	u32 th;
+
+	reg_off = ((7 - trip) / 2) * 4;
+	bit_off = ((8 - trip) % 2);
+
+	th = readl(data->base + EXYNOS7_THD_TEMP_RISE7_6 + reg_off);
+	th &= ~(EXYNOS7_TMU_TEMP_MASK << (16 * bit_off));
+	th |= temp_to_code(data, temp) << (16 * bit_off);
+	writel(th, data->base + EXYNOS7_THD_TEMP_RISE7_6 + reg_off);
+}
+
+static void exynos7_tmu_set_trip_hyst(struct exynos_tmu_data *data,
+				      int trip, u8 temp, u8 hyst)
+{
+	unsigned int reg_off, bit_off;
+	u32 th;
+
+	reg_off = ((7 - trip) / 2) * 4;
+	bit_off = ((8 - trip) % 2);
+
+	th = readl(data->base + EXYNOS7_THD_TEMP_FALL7_6 + reg_off);
+	th &= ~(EXYNOS7_TMU_TEMP_MASK << (16 * bit_off));
+	th |= temp_to_code(data, temp - hyst) << (16 * bit_off);
+	writel(th, data->base + EXYNOS7_THD_TEMP_FALL7_6 + reg_off);
+}
+
 static void exynos7_tmu_initialize(struct platform_device *pdev)
 {
 	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
 	struct thermal_zone_device *tz = data->tzd;
 	unsigned int trim_info;
-	unsigned int rising_threshold = 0, falling_threshold = 0;
-	int threshold_code, i;
-	int temp, temp_hist;
-	unsigned int reg_off, bit_off;
+	int i, temp, hyst;
 
 	trim_info = readl(data->base + EXYNOS_TMU_REG_TRIMINFO);
 	sanitize_temp_error(data, trim_info);
 
 	/* Write temperature code for rising and falling threshold */
 	for (i = (of_thermal_get_ntrips(tz) - 1); i >= 0; i--) {
-		/*
-		 * On exynos7 there are 4 rising and 4 falling threshold
-		 * registers (0x50-0x5c and 0x60-0x6c respectively). Each
-		 * register holds the value of two threshold levels (at bit
-		 * offsets 0 and 16). Based on the fact that there are atmost
-		 * eight possible trigger levels, calculate the register and
-		 * bit offsets where the threshold levels are to be written.
-		 *
-		 * e.g. EXYNOS7_THD_TEMP_RISE7_6 (0x50)
-		 * [24:16] - Threshold level 7
-		 * [8:0] - Threshold level 6
-		 * e.g. EXYNOS7_THD_TEMP_RISE5_4 (0x54)
-		 * [24:16] - Threshold level 5
-		 * [8:0] - Threshold level 4
-		 *
-		 * and similarly for falling thresholds.
-		 *
-		 * Based on the above, calculate the register and bit offsets
-		 * for rising/falling threshold levels and populate them.
-		 */
-		reg_off = ((7 - i) / 2) * 4;
-		bit_off = ((8 - i) % 2);
-
 		tz->ops->get_trip_temp(tz, i, &temp);
 		temp /= MCELSIUS;
+		exynos7_tmu_set_trip_temp(data, i, temp);
 
-		tz->ops->get_trip_hyst(tz, i, &temp_hist);
-		temp_hist = temp - (temp_hist / MCELSIUS);
-
-		/* Set 9-bit temperature code for rising threshold levels */
-		threshold_code = temp_to_code(data, temp);
-		rising_threshold = readl(data->base +
-			EXYNOS7_THD_TEMP_RISE7_6 + reg_off);
-		rising_threshold &= ~(EXYNOS7_TMU_TEMP_MASK << (16 * bit_off));
-		rising_threshold |= threshold_code << (16 * bit_off);
-		writel(rising_threshold,
-		       data->base + EXYNOS7_THD_TEMP_RISE7_6 + reg_off);
-
-		/* Set 9-bit temperature code for falling threshold levels */
-		threshold_code = temp_to_code(data, temp_hist);
-		falling_threshold &= ~(EXYNOS7_TMU_TEMP_MASK << (16 * bit_off));
-		falling_threshold |= threshold_code << (16 * bit_off);
-		writel(falling_threshold,
-		       data->base + EXYNOS7_THD_TEMP_FALL7_6 + reg_off);
+		tz->ops->get_trip_hyst(tz, i, &hyst);
+		hyst /= MCELSIUS;
+		exynos7_tmu_set_trip_hyst(data, i, temp, hyst);
 	}
 }
 
-- 
1.9.1

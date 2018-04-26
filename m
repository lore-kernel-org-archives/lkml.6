Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755968AbeDZLzO (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 07:55:14 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:21375 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755236AbeDZLwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 07:52:37 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180426115235epoutp03d8c608aee3c1778ea987ceaa3234184b~o_i9VXMH42180121801epoutp03Z
X-AuditID: b6c32a37-511ff70000001030-c5-5ae1bd82d2cc
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-samsung-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH 14/18] thermal: exynos: move trips setting to
 exynos_tmu_initialize()
Date: Thu, 26 Apr 2018 13:51:29 +0200
Message-id: <1524743493-28113-15-git-send-email-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1524743493-28113-1-git-send-email-b.zolnierkie@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFIsWRmVeSWpSXmKPExsWy7bCmrm7T3odRBr8umVlsnLGe1WL+lWus
        Fpd3zWGz+Nx7hNFixvl9TBZPHvaxObB57Jx1l91j8Z6XTB59W1YxenzeJBfAEsVlk5Kak1mW
        WqRvl8CVcaBnDXPBZ9uKaZeuMzUwnjfuYuTkkBAwkVj48TULiC0ksINR4s0E/i5GLiD7O6PE
        94Uv2GCKVj/4zQyR2MAo8eH5DkYI5xejxIZjN5hAqtgErCQmtq9iBLFFBLQkTlzazgRSxCww
        h1FiVsNusB3CAuESL/5tYAaxWQRUJRouHwRbwSvgKfG0+To7xDo5iZPHJrOC2JxA8QtHmlhA
        BkkI/GWVOP7kOAtEkYvE60UTWSFsYYlXx7cANXMA2dISl47aQtQ3M0p827GHGaJmAqPEnvVC
        ELa1xOHjF8F6mQX4JN597WGF6OWV6GiDKvGQmPd9I1Sro8Thpl1QHwM9s6XhE+sERqkFjAyr
        GMVSC4pz01OLDQuM9YoTc4tL89L1kvNzNzGCY1DLfAfjhnM+hxgFOBiVeHgDFj6IEmJNLCuu
        zD3EKMHBrCTCG9/6MEqINyWxsiq1KD++qDQntfgQozQHi5I471OfM1FCAumJJanZqakFqUUw
        WSYOTqkGxkVt69dtmfe9qbOoxY3PP+lERd7pDsMV9/cwbOpoeZ0k/0PtfMfFZ+s3C14RXZOf
        2LLg9PyDs2xyK1NfvwpK+Hz2yAKOowE7LebrlYitLJbP2/TveznvK3nHI4vTrnlqeNXl/cub
        4zK/ettVk73Mt6czesu9SNT8wxRiuIub4US7eICnaht7ixJLcUaioRZzUXEiADG6HO69AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmluLIzCtJLcpLzFFi42I5/e+xoG7T3odRBpMucVhsnLGe1WL+lWus
        Fpd3zWGz+Nx7hNFixvl9TBZPHvaxObB57Jx1l91j8Z6XTB59W1YxenzeJBfAEsVlk5Kak1mW
        WqRvl8CVcaBnDXPBZ9uKaZeuMzUwnjfuYuTkkBAwkVj94DdzFyMXh5DAOkaJLSeusEM4vxgl
        ns5bwgZSxSZgJTGxfRUjiC0ioCVx4tJ2JpAiZoE5jBLPV8xhAkkIC4RLvPi3gRnEZhFQlWi4
        fBCsmVfAU+Jp83V2iHVyEiePTWYFsTmB4heONLGA2EICHhL3+96zTWDkWcDIsIpRMrWgODc9
        t9iowDAvtVyvODG3uDQvXS85P3cTIzBoth3W6tvBeH9J/CFGAQ5GJR7egIUPooRYE8uKK3MP
        MUpwMCuJ8Ma3PowS4k1JrKxKLcqPLyrNSS0+xCjNwaIkzns771ikkEB6YklqdmpqQWoRTJaJ
        g1OqgdFzdiHz4uiXrms/WghvtWqcx9642EveyTj5euvq4NSCH9yrfkzwCDyirSsv8OFahAPb
        UzV9t0tG0YorGze3ZD0Mz77cd2jGnqXSOVeLrh5bmWW2S6Og/Dhnmuzrg922XEt8GuY83x9x
        hyP4p0SRxzbn5Gc1cg1akyzceBYYpLTm7nz49i3fayWW4oxEQy3mouJEAKotOSgWAgAA
X-CMS-MailID: 20180426115234epcas1p47cf54556fd061e8f90a4df4a2c62f7ce
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20180426115234epcas1p47cf54556fd061e8f90a4df4a2c62f7ce
X-RootMTR: 20180426115234epcas1p47cf54556fd061e8f90a4df4a2c62f7ce
References: <1524743493-28113-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180426115234epcas1p47cf54556fd061e8f90a4df4a2c62f7ce@epcas1p4.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Add dummy exynos4210_tmu_set_trip_hyst() helper.

* Add ->tmu_set_trip_temp and ->tmu_set_trip_hyst methods to struct
  exynos_tmu_data and set them in exynos_map_dt_data().

* Move trips setting to exynos_tmu_initialize().

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 88 +++++++++++++++---------------------
 1 file changed, 37 insertions(+), 51 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 571511f..244aaf6 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -220,6 +220,10 @@ struct exynos_tmu_data {
 	unsigned int ntrip;
 	bool enabled;
 
+	void (*tmu_set_trip_temp)(struct exynos_tmu_data *data, int trip,
+				 u8 temp);
+	void (*tmu_set_trip_hyst)(struct exynos_tmu_data *data, int trip,
+				 u8 temp, u8 hyst);
 	void (*tmu_initialize)(struct platform_device *pdev);
 	void (*tmu_control)(struct platform_device *pdev, bool on);
 	int (*tmu_read)(struct exynos_tmu_data *data);
@@ -312,7 +316,7 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
 	const struct thermal_trip * const trips =
 		of_thermal_get_trip_points(tzd);
 	unsigned int status;
-	int ret = 0, temp;
+	int ret = 0, temp, hyst;
 
 	if (!trips) {
 		dev_err(&pdev->dev,
@@ -345,7 +349,24 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
 	if (!status)
 		ret = -EBUSY;
 	else {
+		int i, ntrips =
+			min_t(int, of_thermal_get_ntrips(tzd), data->ntrip);
+
 		data->tmu_initialize(pdev);
+
+		/* Write temperature code for rising and falling threshold */
+		for (i = 0; i < ntrips; i++) {
+			/* Write temperature code for rising threshold */
+			tzd->ops->get_trip_temp(tzd, i, &temp);
+			temp /= MCELSIUS;
+			data->tmu_set_trip_temp(data, i, temp);
+
+			/* Write temperature code for falling threshold */
+			tzd->ops->get_trip_hyst(tzd, i, &hyst);
+			hyst /= MCELSIUS;
+			data->tmu_set_trip_hyst(data, i, temp, hyst);
+		}
+
 		data->tmu_clear_irqs(data);
 	}
 
@@ -405,19 +426,17 @@ static void exynos4210_tmu_set_trip_temp(struct exynos_tmu_data *data,
 	writeb(temp, data->base + EXYNOS4210_TMU_REG_TRIG_LEVEL0 + trip * 4);
 }
 
+/* failing thresholds are not supported on Exynos4210 */
+static void exynos4210_tmu_set_trip_hyst(struct exynos_tmu_data *data,
+					 int trip, u8 temp, u8 hyst)
+{
+}
+
 static void exynos4210_tmu_initialize(struct platform_device *pdev)
 {
 	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
-	struct thermal_zone_device *tz = data->tzd;
-	int i, temp;
 
 	sanitize_temp_error(data, readl(data->base + EXYNOS_TMU_REG_TRIMINFO));
-
-	for (i = 0; i < of_thermal_get_ntrips(tz); i++) {
-		tz->ops->get_trip_temp(tz, i, &temp);
-		temp /= MCELSIUS;
-		exynos4210_tmu_set_trip_temp(data, i, temp);
-	}
 }
 
 static void exynos4412_tmu_set_trip_temp(struct exynos_tmu_data *data,
@@ -452,10 +471,7 @@ static void exynos4412_tmu_set_trip_hyst(struct exynos_tmu_data *data,
 static void exynos4412_tmu_initialize(struct platform_device *pdev)
 {
 	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
-	struct thermal_zone_device *tz = data->tzd;
 	unsigned int trim_info, ctrl;
-	int i, ntrips = min_t(int, of_thermal_get_ntrips(tz), data->ntrip);
-	int temp, hyst;
 
 	if (data->soc == SOC_ARCH_EXYNOS3250 ||
 	    data->soc == SOC_ARCH_EXYNOS4412 ||
@@ -477,17 +493,6 @@ static void exynos4412_tmu_initialize(struct platform_device *pdev)
 		trim_info = readl(data->base + EXYNOS_TMU_REG_TRIMINFO);
 
 	sanitize_temp_error(data, trim_info);
-
-	/* Write temperature code for rising and falling threshold */
-	for (i = 0; i < ntrips; i++) {
-		tz->ops->get_trip_temp(tz, i, &temp);
-		temp /= MCELSIUS;
-		exynos4412_tmu_set_trip_temp(data, i, temp);
-
-		tz->ops->get_trip_hyst(tz, i, &hyst);
-		hyst /= MCELSIUS;
-		exynos4412_tmu_set_trip_hyst(data, i, temp, hyst);
-	}
 }
 
 static void exynos5433_tmu_set_trip_temp(struct exynos_tmu_data *data,
@@ -533,9 +538,8 @@ static void exynos5433_tmu_set_trip_hyst(struct exynos_tmu_data *data,
 static void exynos5433_tmu_initialize(struct platform_device *pdev)
 {
 	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
-	struct thermal_zone_device *tz = data->tzd;
 	unsigned int trim_info;
-	int sensor_id, cal_type, i, temp, hyst;
+	int sensor_id, cal_type;
 
 	trim_info = readl(data->base + EXYNOS_TMU_REG_TRIMINFO);
 	sanitize_temp_error(data, trim_info);
@@ -562,19 +566,6 @@ static void exynos5433_tmu_initialize(struct platform_device *pdev)
 
 	dev_info(&pdev->dev, "Calibration type is %d-point calibration\n",
 			cal_type ?  2 : 1);
-
-	/* Write temperature code for rising and falling threshold */
-	for (i = 0; i < of_thermal_get_ntrips(tz); i++) {
-		/* Write temperature code for rising threshold */
-		tz->ops->get_trip_temp(tz, i, &temp);
-		temp /= MCELSIUS;
-		exynos5433_tmu_set_trip_temp(data, i, temp);
-
-		/* Write temperature code for falling threshold */
-		tz->ops->get_trip_hyst(tz, i, &hyst);
-		hyst /= MCELSIUS;
-		exynos5433_tmu_set_trip_hyst(data, i, temp, hyst);
-	}
 }
 
 static void exynos7_tmu_set_trip_temp(struct exynos_tmu_data *data,
@@ -610,23 +601,10 @@ static void exynos7_tmu_set_trip_hyst(struct exynos_tmu_data *data,
 static void exynos7_tmu_initialize(struct platform_device *pdev)
 {
 	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
-	struct thermal_zone_device *tz = data->tzd;
 	unsigned int trim_info;
-	int i, temp, hyst;
 
 	trim_info = readl(data->base + EXYNOS_TMU_REG_TRIMINFO);
 	sanitize_temp_error(data, trim_info);
-
-	/* Write temperature code for rising and falling threshold */
-	for (i = 0; i < of_thermal_get_ntrips(tz); i++) {
-		tz->ops->get_trip_temp(tz, i, &temp);
-		temp /= MCELSIUS;
-		exynos7_tmu_set_trip_temp(data, i, temp);
-
-		tz->ops->get_trip_hyst(tz, i, &hyst);
-		hyst /= MCELSIUS;
-		exynos7_tmu_set_trip_hyst(data, i, temp, hyst);
-	}
 }
 
 static void exynos4210_tmu_control(struct platform_device *pdev, bool on)
@@ -989,6 +967,8 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 
 	switch (data->soc) {
 	case SOC_ARCH_EXYNOS4210:
+		data->tmu_set_trip_temp = exynos4210_tmu_set_trip_temp;
+		data->tmu_set_trip_hyst = exynos4210_tmu_set_trip_hyst;
 		data->tmu_initialize = exynos4210_tmu_initialize;
 		data->tmu_control = exynos4210_tmu_control;
 		data->tmu_read = exynos4210_tmu_read;
@@ -1006,6 +986,8 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 	case SOC_ARCH_EXYNOS5260:
 	case SOC_ARCH_EXYNOS5420:
 	case SOC_ARCH_EXYNOS5420_TRIMINFO:
+		data->tmu_set_trip_temp = exynos4412_tmu_set_trip_temp;
+		data->tmu_set_trip_hyst = exynos4412_tmu_set_trip_hyst;
 		data->tmu_initialize = exynos4412_tmu_initialize;
 		data->tmu_control = exynos4210_tmu_control;
 		data->tmu_read = exynos4412_tmu_read;
@@ -1023,6 +1005,8 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 		data->max_efuse_value = 100;
 		break;
 	case SOC_ARCH_EXYNOS5433:
+		data->tmu_set_trip_temp = exynos5433_tmu_set_trip_temp;
+		data->tmu_set_trip_hyst = exynos5433_tmu_set_trip_hyst;
 		data->tmu_initialize = exynos5433_tmu_initialize;
 		data->tmu_control = exynos5433_tmu_control;
 		data->tmu_read = exynos4412_tmu_read;
@@ -1039,6 +1023,8 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 		data->max_efuse_value = 150;
 		break;
 	case SOC_ARCH_EXYNOS7:
+		data->tmu_set_trip_temp = exynos7_tmu_set_trip_temp;
+		data->tmu_set_trip_hyst = exynos7_tmu_set_trip_hyst;
 		data->tmu_initialize = exynos7_tmu_initialize;
 		data->tmu_control = exynos7_tmu_control;
 		data->tmu_read = exynos7_tmu_read;
-- 
1.9.1

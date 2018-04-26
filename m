Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755567AbeDZLww (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 07:52:52 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:48415 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755834AbeDZLwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 07:52:33 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180426115230epoutp01743e72d2f6b9aaeab754bb7e3f879bc9~o_i5OObJi0232602326epoutp01c
X-AuditID: b6c32a37-4f9ff70000001030-ba-5ae1bd7e8e89
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-samsung-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH 12/18] thermal: exynos: do not use trips structure directly
 in ->tmu_initialize
Date: Thu, 26 Apr 2018 13:51:27 +0200
Message-id: <1524743493-28113-13-git-send-email-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1524743493-28113-1-git-send-email-b.zolnierkie@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBIsWRmVeSWpSXmKPExsWy7bCmvm7d3odRBnteiVtsnLGe1WL+lWus
        Fpd3zWGz+Nx7hNFixvl9TBZPHvaxObB57Jx1l91j8Z6XTB59W1YxenzeJBfAEsVlk5Kak1mW
        WqRvl8CVMWXfVdaCD4IVh9+/YGpgfMvXxcjBISFgItF736yLkYtDSGAHo8TS2dsYIZzvjBIb
        lzSywBS9/VLXxcgJFN/AKLFzcS5EzS9Gia2TFrOBJNgErCQmtq9iBLFFBLQkTlzazgRSxCww
        h1FiVsNuFpCEsECixOz395lBbBYBVYkFf16C2bwCnhIb5mwEa5YQkJM4eWwyK4jNCRS/cKSJ
        BWSQhEAjm8SyrWuYIYpcJNac3csCYQtLvDq+hR3iUmmJS0dtIeqbGSW+7dgDVT+BUWLPeiEI
        21ri8PGLYAuYBfgk3n3tYYXo5ZXoaIMq8ZD4enkzK4TtKDFv+SY2iI+Bnlm6YDvLBEapBYwM
        qxjFUguKc9NTiw0LjPWKE3OLS/PS9ZLzczcxguNPy3wH44ZzPocYBTgYlXh4AxY+iBJiTSwr
        rsw9xCjBwawkwhvf+jBKiDclsbIqtSg/vqg0J7X4EKM0B4uSOO9TnzNRQgLpiSWp2ampBalF
        MFkmDk6pBkY/e96YDwpMP5R429/4iqqd3XSr8uCl9u/9XZrcP0NzJn2xOfTW6/e7CNbjOZI8
        3TpXGPpPPvne/umwQsHMZbevVspNWsQgrlDrGSnn+fdCm+c+aSfByGP/jBkjNhh/OXhZX1Bc
        1jin0enadXcpc84Sjcs3lNxzF99zvrFx7+GtJ7Y5pO/8aqHEUpyRaKjFXFScCAB3f9PKuwIA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkluLIzCtJLcpLzFFi42I5/e+xoG7t3odRBu82cllsnLGe1WL+lWus
        Fpd3zWGz+Nx7hNFixvl9TBZPHvaxObB57Jx1l91j8Z6XTB59W1YxenzeJBfAEsVlk5Kak1mW
        WqRvl8CVMWXfVdaCD4IVh9+/YGpgfMvXxcjBISFgIvH2S10XIxeHkMA6RoknP1ewQzi/GCU2
        H3nP3MXIycEmYCUxsX0VI4gtIqAlceLSdiaQImaBOYwSz1fMYQKZJCyQKNFxuAykhkVAVWLB
        n5dgvbwCnhIb5mwE65UQkJM4eWwyK4jNCRS/cKSJBcQWEvCQuN/3nm0CI88CRoZVjJKpBcW5
        6bnFRgWGeanlesWJucWleel6yfm5mxiBAbPtsFbfDsb7S+IPMQpwMCrx8AYsfBAlxJpYVlyZ
        e4hRgoNZSYQ3vvVhlBBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHe23nHIoUE0hNLUrNTUwtSi2Cy
        TBycUg2MeYU8cx8sO6W++7fee8WGixMTzwfzbDiucz/J+0bFtrbYehXemJOWzVWTlaOO7K0w
        f/Bqm1y5+LMj9zqXJc27sFRUbzGrfcvHM60ZvKsLxJMMRQ+9C3Bd5Nwa6mfXJBT7aguD/NFE
        5Qm7tgbM++hm6a7bnr8oWGX6puDy/2fst/7YeV5zv+RhJZbijERDLeai4kQAtDBklhQCAAA=
X-CMS-MailID: 20180426115229epcas1p42ebcc547531485a4f30284dd3be7e43a
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20180426115229epcas1p42ebcc547531485a4f30284dd3be7e43a
X-RootMTR: 20180426115229epcas1p42ebcc547531485a4f30284dd3be7e43a
References: <1524743493-28113-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180426115229epcas1p42ebcc547531485a4f30284dd3be7e43a@epcas1p4.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use ->get_trip_[temp,hyst] methods instead of using trips structure
directly in all ->tmu_initialize method implementations.

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 80265d2..12b60e2 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -409,15 +409,13 @@ static void exynos4210_tmu_initialize(struct platform_device *pdev)
 {
 	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
 	struct thermal_zone_device *tz = data->tzd;
-	const struct thermal_trip * const trips =
-		of_thermal_get_trip_points(tz);
-	unsigned long temp;
-	int i;
+	int i, temp;
 
 	sanitize_temp_error(data, readl(data->base + EXYNOS_TMU_REG_TRIMINFO));
 
 	for (i = 0; i < of_thermal_get_ntrips(tz); i++) {
-		temp = trips[i].temperature / MCELSIUS;
+		tz->ops->get_trip_temp(tz, i, &temp);
+		temp /= MCELSIUS;
 		exynos4210_tmu_set_trip_temp(data, i, temp);
 	}
 }
@@ -455,11 +453,9 @@ static void exynos4412_tmu_initialize(struct platform_device *pdev)
 {
 	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
 	struct thermal_zone_device *tz = data->tzd;
-	const struct thermal_trip * const trips =
-		of_thermal_get_trip_points(tz);
-	unsigned long temp, hyst;
 	unsigned int trim_info, ctrl;
 	int i, ntrips = min_t(int, of_thermal_get_ntrips(tz), data->ntrip);
+	int temp, hyst;
 
 	if (data->soc == SOC_ARCH_EXYNOS3250 ||
 	    data->soc == SOC_ARCH_EXYNOS4412 ||
@@ -484,10 +480,12 @@ static void exynos4412_tmu_initialize(struct platform_device *pdev)
 
 	/* Write temperature code for rising and falling threshold */
 	for (i = 0; i < ntrips; i++) {
-		temp = trips[i].temperature / MCELSIUS;
+		tz->ops->get_trip_temp(tz, i, &temp);
+		temp /= MCELSIUS;
 		exynos4412_tmu_set_trip_temp(data, i, temp);
 
-		hyst = trips[i].hysteresis / MCELSIUS;
+		tz->ops->get_trip_hyst(tz, i, &hyst);
+		hyst /= MCELSIUS;
 		exynos4412_tmu_set_trip_hyst(data, i, temp, hyst);
 	}
 }
-- 
1.9.1

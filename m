Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756029AbeDZLwY (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 07:52:24 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:14803 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755529AbeDZLwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 07:52:12 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20180426115210epoutp04c6c034f07b3f032d5c84653fcaea00e2~o_imJ4bAP1854318543epoutp04E
X-AuditID: b6c32a48-c31ff70000000fef-ec-5ae1bd69544e
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-samsung-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH 04/18] thermal: exynos: check STATUS register in
 exynos_tmu_initialize()
Date: Thu, 26 Apr 2018 13:51:19 +0200
Message-id: <1524743493-28113-5-git-send-email-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1524743493-28113-1-git-send-email-b.zolnierkie@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFIsWRmVeSWpSXmKPExsWy7bCmhW7m3odRBqdnaltsnLGe1WL+lWus
        Fpd3zWGz+Nx7hNFixvl9TBZPHvaxObB57Jx1l91j8Z6XTB59W1YxenzeJBfAEsVlk5Kak1mW
        WqRvl8CV8ffcDaaCDwoVKz7tYWlg/CnVxcjJISFgIrF+2QxGEFtIYAejxNcfxV2MXED2d0aJ
        zY2zWWGK9l+4zg6R2MAoMefyL6iOX4wSj/cZgNhsAlYSE9tXgcVFBLQkTlzazgTSwCwwh1Fi
        VsNuFpCEsECUxKOOE+wgNouAqsSKRxvAGngFPCRmd/9lgdgmJ3Hy2GSwzZwCnhIXjjSxgAyS
        EPjLKrH3w2FmiCIXiek710LZwhKvjm9hh7ClJZ6t2sgI0dDMKPFtxx6oogmMEnvWC0HY1hKH
        j18E28AswCfRcfgvUDMHUJxXoqMNqsRDYs/BFVCtjhL/5p9nhHgf6Jud7Y2sExilFjAyrGIU
        Sy0ozk1PLTYqMNErTswtLs1L10vOz93ECI5BLY8djAfO+RxiFOBgVOLhDVj4IEqINbGsuDL3
        EKMEB7OSCG9868MoId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rwNvmeihATSE0tSs1NTC1KLYLJM
        HJxSDYwWrZezdly+Vzt7yYbjvvmqBlOnGYdM9SxT0NNpLphpEspZl8BfoZAivuzGoVUsEf1+
        p7JuZ/2pDjT8+LH5/+K0Z8ViFXNWzPj4iSU4/OHkar9HUt+id1SsSovI973yYe/5j/93Vh5Q
        DNj1+99//fvFbP9y3cUnTWlQWW8yd8fHZzW3trvPKHquxFKckWioxVxUnAgAKWwjJr0CAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmluLIzCtJLcpLzFFi42I5/e+xoG7m3odRBhMfcVpsnLGe1WL+lWus
        Fpd3zWGz+Nx7hNFixvl9TBZPHvaxObB57Jx1l91j8Z6XTB59W1YxenzeJBfAEsVlk5Kak1mW
        WqRvl8CV8ffcDaaCDwoVKz7tYWlg/CnVxcjJISFgIrH/wnX2LkYuDiGBdYwSlyZfZ4VwfjFK
        PNl7lgWkik3ASmJi+ypGEFtEQEvixKXtTCBFzAJzGCWer5jDBJIQFoiSeNRxgh3EZhFQlVjx
        aANYA6+Ah8Ts7r8sEOvkJE4em8wKYnMKeEpcONIEFhcCqrnf955tAiPPAkaGVYySqQXFuem5
        xUYFRnmp5XrFibnFpXnpesn5uZsYgUGz7bBW/w7Gx0viDzEKcDAq8fAGLHwQJcSaWFZcmXuI
        UYKDWUmEN771YZQQb0piZVVqUX58UWlOavEhRmkOFiVxXv78Y5FCAumJJanZqakFqUUwWSYO
        TqkGxlCN2oByzV8PVyzn2Jgde03Uit9e0WfGskV/r2vUJnbkHjZZn/tcWa5nxU/pOFYh3aUC
        mSJF28N+9U0u22K84NatgwcOOy8vfvqo+W91E2fSa7VpCy5vN1xjHaX9q8HyYomVyO3N63p/
        XO7a8vjvTa+Lk42/Ztlqb33+iH3fHKfesrqdwVxK3kosxRmJhlrMRcWJAPA71P8WAgAA
X-CMS-MailID: 20180426115209epcas2p1af89ecf3180a396261af3b18f952877a
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20180426115209epcas2p1af89ecf3180a396261af3b18f952877a
X-RootMTR: 20180426115209epcas2p1af89ecf3180a396261af3b18f952877a
References: <1524743493-28113-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180426115209epcas2p1af89ecf3180a396261af3b18f952877a@epcas2p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

STATUS register is present on all SoCs so move its checking into
exynos_tmu_initialize().

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 45 +++++++++++-------------------------
 1 file changed, 13 insertions(+), 32 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index a0c1604..3b41666 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -331,6 +331,7 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
 	struct thermal_zone_device *tzd = data->tzd;
 	const struct thermal_trip * const trips =
 		of_thermal_get_trip_points(tzd);
+	unsigned int status;
 	int ret = 0, temp;
 
 	if (!trips) {
@@ -359,7 +360,13 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
 	clk_enable(data->clk);
 	if (!IS_ERR(data->clk_sec))
 		clk_enable(data->clk_sec);
-	ret = data->tmu_initialize(pdev);
+
+	status = readb(data->base + EXYNOS_TMU_REG_STATUS);
+	if (!status)
+		ret = -EBUSY;
+	else
+		ret = data->tmu_initialize(pdev);
+
 	clk_disable(data->clk);
 	mutex_unlock(&data->lock);
 	if (!IS_ERR(data->clk_sec))
@@ -406,13 +413,6 @@ static int exynos4210_tmu_initialize(struct platform_device *pdev)
 		of_thermal_get_trip_points(tz);
 	int ret = 0, threshold_code, i;
 	unsigned long reference, temp;
-	unsigned int status;
-
-	status = readb(data->base + EXYNOS_TMU_REG_STATUS);
-	if (!status) {
-		ret = -EBUSY;
-		goto out;
-	}
 
 	sanitize_temp_error(data, readl(data->base + EXYNOS_TMU_REG_TRIMINFO));
 
@@ -441,16 +441,10 @@ static int exynos4412_tmu_initialize(struct platform_device *pdev)
 	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
 	const struct thermal_trip * const trips =
 		of_thermal_get_trip_points(data->tzd);
-	unsigned int status, trim_info, con, ctrl, rising_threshold;
+	unsigned int trim_info, con, ctrl, rising_threshold;
 	int ret = 0, threshold_code, i;
 	unsigned long crit_temp = 0;
 
-	status = readb(data->base + EXYNOS_TMU_REG_STATUS);
-	if (!status) {
-		ret = -EBUSY;
-		goto out;
-	}
-
 	if (data->soc == SOC_ARCH_EXYNOS3250 ||
 	    data->soc == SOC_ARCH_EXYNOS4412 ||
 	    data->soc == SOC_ARCH_EXYNOS5250) {
@@ -497,7 +491,6 @@ static int exynos4412_tmu_initialize(struct platform_device *pdev)
 	con |= (1 << EXYNOS_TMU_THERM_TRIP_EN_SHIFT);
 	writel(con, data->base + EXYNOS_TMU_REG_CONTROL);
 
-out:
 	return ret;
 }
 
@@ -505,17 +498,11 @@ static int exynos5433_tmu_initialize(struct platform_device *pdev)
 {
 	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
 	struct thermal_zone_device *tz = data->tzd;
-	unsigned int status, trim_info;
+	unsigned int trim_info;
 	unsigned int rising_threshold = 0, falling_threshold = 0;
 	int temp, temp_hist;
 	int ret = 0, threshold_code, i, sensor_id, cal_type;
 
-	status = readb(data->base + EXYNOS_TMU_REG_STATUS);
-	if (!status) {
-		ret = -EBUSY;
-		goto out;
-	}
-
 	trim_info = readl(data->base + EXYNOS_TMU_REG_TRIMINFO);
 	sanitize_temp_error(data, trim_info);
 
@@ -590,7 +577,7 @@ static int exynos5433_tmu_initialize(struct platform_device *pdev)
 	}
 
 	data->tmu_clear_irqs(data);
-out:
+
 	return ret;
 }
 
@@ -598,18 +585,12 @@ static int exynos7_tmu_initialize(struct platform_device *pdev)
 {
 	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
 	struct thermal_zone_device *tz = data->tzd;
-	unsigned int status, trim_info;
+	unsigned int trim_info;
 	unsigned int rising_threshold = 0, falling_threshold = 0;
 	int ret = 0, threshold_code, i;
 	int temp, temp_hist;
 	unsigned int reg_off, bit_off;
 
-	status = readb(data->base + EXYNOS_TMU_REG_STATUS);
-	if (!status) {
-		ret = -EBUSY;
-		goto out;
-	}
-
 	trim_info = readl(data->base + EXYNOS_TMU_REG_TRIMINFO);
 
 	data->temp_error1 = trim_info & EXYNOS7_TMU_TEMP_MASK;
@@ -667,7 +648,7 @@ static int exynos7_tmu_initialize(struct platform_device *pdev)
 	}
 
 	data->tmu_clear_irqs(data);
-out:
+
 	return ret;
 }
 
-- 
1.9.1

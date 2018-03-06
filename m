Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753845AbeCFOsV (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 09:48:21 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:63098 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932228AbeCFOos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 09:44:48 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20180306144446epoutp04bca6899306f8e591fc9526efcedc0560~ZW-vaVZRR1173811738epoutp04Z
X-AuditID: b6c32a37-433ff70000001029-ca-5a9ea95d5deb
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
Subject: [PATCH 04/12] thermal: exynos: remove parsing of
 samsung,tmu_noise_cancel_mode property
Date: Tue, 06 Mar 2018 15:43:47 +0100
Message-id: <1520347435-22970-5-git-send-email-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1520347435-22970-1-git-send-email-b.zolnierkie@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrAIsWRmVeSWpSXmKPExsWy7bCmrm7synlRBm+2yFpsnLGe1WL+kXNA
        4so1Vov+x6+ZLc6f38BusekxkHt51xw2i8+9RxgtZpzfx2RxaOpeRoul1y8yWbTuPcJu8eRh
        H5sDr8eaeWsYPS5fu8jssXPWXXaPxXteMnlsWtXJ5rF5Sb1H35ZVjB6fN8kFcERx2aSk5mSW
        pRbp2yVwZcz+YFcwWbTi6cwrrA2M7wS7GDk5JARMJJp6pzF1MXJxCAnsYJTovNnEDOF8Z5SY
        /OIfC0zVr42PWCESuxklulf0sUE4vxgl5vxbygpSxSZgJTGxfRUjiC0iUCIxbVUvI0gRs8BZ
        Jokd29+BjRIWSJLoPt0JVsQioCqx/NlndhCbV8BD4u2Sa6wQ6+QkTh6bDGZzCnhKnOg4B7ZN
        QuAIm8SZu+/ZIYpcJL5sPcoGYQtLvDq+BSjOAWRLS1w6agtR38wo8W3HHmaImgmMEnvWC0HY
        1hKHj18EW8AswCfx7msPK0Qvr0RHG1SJh8T6dz+gxjtKdG3bxALx8RxGiRXdL1kmMEotYGRY
        xSiWWlCcm55abFhgrFecmFtcmpeul5yfu4kRHO9a5jsYN5zzOcQowMGoxMO7wWNulBBrYllx
        Ze4hRgkOZiUR3gj9eVFCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeQMCXKKEBNITS1KzU1MLUotg
        skwcnFINjOJ5QdFnG5R63vitmrVcpf9N+RVdr+IN+19NCE57oucxpXy7Lv+Mie0/59974/Xl
        yoYd6ytZb7x0aiqLLTtZNSvgXOJLhhOPIx16Hgtpmk76uYZpzr1b59yXaKX8etBy1rAvcaNQ
        mGbe3QVPN15OVzbxSvkf/+vzHvUM88tPtx7jZvs1b8tPVhclluKMREMt5qLiRACoUc9x8wIA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOLMWRmVeSWpSXmKPExsVy+t9jAd3YlfOiDFq2s1psnLGe1WL+kXNA
        4so1Vov+x6+ZLc6f38BusekxkHt51xw2i8+9RxgtZpzfx2RxaOpeRoul1y8yWbTuPcJu8eRh
        H5sDr8eaeWsYPS5fu8jssXPWXXaPxXteMnlsWtXJ5rF5Sb1H35ZVjB6fN8kFcERx2aSk5mSW
        pRbp2yVwZcz+YFcwWbTi6cwrrA2M7wS7GDk5JARMJH5tfMTaxcjFISSwk1Fi38JeRgjnF6PE
        p9db2UGq2ASsJCa2r2IEsUUESiQ6p71mBrGZBc4ySRz8zwFiCwskSXSf7gSrYRFQlVj+7DNY
        L6+Ah8TbJddYIbbJSZw8NhnM5hTwlDjRcY4NxBYCqlnc/ZttAiPPAkaGVYySqQXFuem5xUYF
        hnmp5XrFibnFpXnpesn5uZsYgcG57bBW3w7G+0viDzEKcDAq8fBu8JgbJcSaWFZcmXuIUYKD
        WUmEN0J/XpQQb0piZVVqUX58UWlOavEhRmkOFiVx3tt5xyKFBNITS1KzU1MLUotgskwcnFIN
        jHavPh66zt/XEBegvPTfed4dJ31CZLbJvBDnzO4p3a1W/659VhOr7DbBHbzV4iXiz5NWXuYU
        O7uOh+3kvjwW5l3GbM25u7P2zhYV3c7lev9cQ8aUjemqOtzls3sKgpp0799WlZZVrhRaZKPJ
        rvpYeMnkK1eOK9yKX2x5xKvWJOByx3HxK3/alViKMxINtZiLihMByP0kGUoCAAA=
X-CMS-MailID: 20180306144445epcas1p1b2dee15107098f5974e3c41403594ffc
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20180306144445epcas1p1b2dee15107098f5974e3c41403594ffc
X-RootMTR: 20180306144445epcas1p1b2dee15107098f5974e3c41403594ffc
References: <1520347435-22970-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180306144445epcas1p1b2dee15107098f5974e3c41403594ffc@epcas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All SoCs use the same value (4) for the noise cancel mode so just
make it explicit and remove parsing of samsung,tmu_noise_cancel_mode
property.

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 10 ++++------
 drivers/thermal/samsung/exynos_tmu.h |  3 ---
 2 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 5877dd4..adfd9ef 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -168,6 +168,8 @@
 #define EXYNOS_FIRST_POINT_TRIM			25
 #define EXYNOS_SECOND_POINT_TRIM		85
 
+#define EXYNOS_NOISE_CANCEL_MODE		4
+
 #define MCELSIUS	1000
 /**
  * struct exynos_tmu_data : A structure to hold the private data of the TMU
@@ -386,10 +388,8 @@ static u32 get_con_reg(struct exynos_tmu_data *data, u32 con)
 	con &= ~(EXYNOS_TMU_BUF_SLOPE_SEL_MASK << EXYNOS_TMU_BUF_SLOPE_SEL_SHIFT);
 	con |= (pdata->gain << EXYNOS_TMU_BUF_SLOPE_SEL_SHIFT);
 
-	if (pdata->noise_cancel_mode) {
-		con &= ~(EXYNOS_TMU_TRIP_MODE_MASK << EXYNOS_TMU_TRIP_MODE_SHIFT);
-		con |= (pdata->noise_cancel_mode << EXYNOS_TMU_TRIP_MODE_SHIFT);
-	}
+	con &= ~(EXYNOS_TMU_TRIP_MODE_MASK << EXYNOS_TMU_TRIP_MODE_SHIFT);
+	con |= (EXYNOS_NOISE_CANCEL_MODE << EXYNOS_TMU_TRIP_MODE_SHIFT);
 
 	return con;
 }
@@ -1153,8 +1153,6 @@ static int exynos_of_sensor_conf(struct device_node *np,
 	pdata->gain = (u8)value;
 	of_property_read_u32(np, "samsung,tmu_reference_voltage", &value);
 	pdata->reference_voltage = (u8)value;
-	of_property_read_u32(np, "samsung,tmu_noise_cancel_mode", &value);
-	pdata->noise_cancel_mode = (u8)value;
 
 	of_property_read_u32(np, "samsung,tmu_efuse_value",
 			     &pdata->efuse_value);
diff --git a/drivers/thermal/samsung/exynos_tmu.h b/drivers/thermal/samsung/exynos_tmu.h
index a5d8c9c..b111a01 100644
--- a/drivers/thermal/samsung/exynos_tmu.h
+++ b/drivers/thermal/samsung/exynos_tmu.h
@@ -45,8 +45,6 @@ enum soc_type {
  * @reference_voltage: reference voltage of amplifier
  *	in the positive-TC generator block
  *	0 < reference_voltage <= 31
- * @noise_cancel_mode: noise cancellation mode
- *	000, 100, 101, 110 and 111 can be different modes
  * @efuse_value: platform defined fuse value
  * @min_efuse_value: minimum valid trimming data
  * @max_efuse_value: maximum valid trimming data
@@ -57,7 +55,6 @@ enum soc_type {
 struct exynos_tmu_platform_data {
 	u8 gain;
 	u8 reference_voltage;
-	u8 noise_cancel_mode;
 
 	u32 efuse_value;
 	u32 min_efuse_value;
-- 
1.9.1

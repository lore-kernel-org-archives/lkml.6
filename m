Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755261AbeDPOWa (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 10:22:30 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:47942 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752078AbeDPOW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 10:22:28 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180416142225euoutp01ebfdd7340b6102427f57c3eb80a6fcf6~l8I7jxR0m2872128721euoutp01o
X-AuditID: cbfec7f2-1c1ff70000011644-8a-5ad4b19e3fa8
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
Subject: [PATCH v2 12/14] thermal: exynos: remove separate exynos_tmu.h
 header file
Date: Mon, 16 Apr 2018 16:22:19 +0200
Message-ID: <2686175.IEZVfBECIu@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHKsWRmVeSWpSXmKPExsWy7djP87rzNl6JMlj83chi44z1rBbzPsta
        zL9yjdWi//FrZovz5zewW1zeNYfN4nPvEUaLGef3MVk8edjH5sDpsXPWXXaPxXteMnlsWtXJ
        5nHn2h42j74tqxg9Pm+SC2CL4rJJSc3JLEst0rdL4MrY3rOAseCfZMXPySdYGhifinYxcnJI
        CJhIXF25nrGLkYtDSGAFo8TdRf+YIZwvjBIv5r1gh3A+M0qc6/zEAtOy7dM9qKrljBL39u5j
        hXA+MEp0btvLBlLFJmAlMbF9FSOILSKgJXHi0nYmkCJmgQlMEk9fzQQrEhYIlXjw/g07iM0i
        oCqx+t5CsAZeAU2JU5f+g9miAl4SW/a1M0HEBSVOznwCdgazgLxEx+VGsM0SAsvYJW5tvMMG
        cZ+LxMaj65ggbGGJV8e3sEPYMhL/d85ngmhoZpT4tmMPM0RiAqPEnvVCELa1xOHjF4GmcgBt
        0JRYv0sfImwr0bWnGSwsIcAnceOtIMQNfBKTtk1nhgjzSnS0QQ1Rk9iwbAMbzNaunSuhFnlI
        /Dv0FeoyR4lPLW1sExgVZyH5bBaSz2Yh3LCAkXkVo3hqaXFuemqxYV5quV5xYm5xaV66XnJ+
        7iZGYCo6/e/4px2MXy8lHWIU4GBU4uHdcfZylBBrYllxZe4hRgkOZiUR3mWJQCHelMTKqtSi
        /Pii0pzU4kOM0hwsSuK8cRp1UUIC6YklqdmpqQWpRTBZJg5OqQbGCQ2dLOsabmV07vrHuH2T
        YcjzsIh9DotMXps37jJczN1yeb68ksWmq2dETvtoFUwI/GSw1Z/fXsK4Yenz4vubUrOWcyUY
        LtWQeXlhTmG94dxHovK3+7z7X2zesF3lRvLK479fNLbulXcwCPHaxnv+qNMuZ+ULXdYrt/bZ
        J/1emhZi6VQg90BTiaU4I9FQi7moOBEA9VP/UkEDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFIsWRmVeSWpSXmKPExsVy+t/xu7pzN16JMph+T9Bi44z1rBbzPsta
        zL9yjdWi//FrZovz5zewW1zeNYfN4nPvEUaLGef3MVk8edjH5sDpsXPWXXaPxXteMnlsWtXJ
        5nHn2h42j74tqxg9Pm+SC2CL0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAzMrHUMzQ2j7UyMlXS
        t7NJSc3JLEst0rdL0MvY3rOAseCfZMXPySdYGhifinYxcnJICJhIbPt0j7mLkYtDSGApo8T1
        oxdZuxg5gBIyEsfXl0HUCEv8udbFBmILCbxjlJjeqgZiswlYSUxsX8UIYosIaEmcuLSdCWQO
        s0AXk8Tf693MIAlhgWCJg0/2gRWxCKhKrL63EMzmFdCUOHXpP5gtKuAlsWVfOxNEXFDi5Mwn
        LCA2s4C8RMflRlYIW0diwe5PbBMY+WchKZuFpGwWkrIFjMyrGEVSS4tz03OLjfSKE3OLS/PS
        9ZLzczcxAuNl27GfW3Ywdr0LPsQowMGoxMO74+zlKCHWxLLiytxDjBIczEoivMsSgUK8KYmV
        ValF+fFFpTmpxYcYTYGemMgsJZqcD4zlvJJ4Q1NDcwtLQ3Njc2MzCyVx3vMGlVFCAumJJanZ
        qakFqUUwfUwcnFINjLsCI29wiC1Y61Rw7+QW54861Ud9wiX32b58Ldy9/5vjnfnnNvCX9hpv
        /zoxNunb9q3rV+054rt63mQVg7d9E63eHNsWYspZ6i6p//TL84Suj2L7/IrKbuhrp27YfHF/
        2+WOnkDN/jnThUyXdy3qqnM38/1QsfVWFMsl7fCwc0ZsZqdX9odVxyqxFGckGmoxFxUnAgDs
        rxIdrQIAAA==
X-CMS-MailID: 20180416142221eucas1p1ded332b5b69a9f3f1224914e48b28c19
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180416142221eucas1p1ded332b5b69a9f3f1224914e48b28c19
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180416142221eucas1p1ded332b5b69a9f3f1224914e48b28c19
X-RootMTR: 20180416142221eucas1p1ded332b5b69a9f3f1224914e48b28c19
References: <CGME20180416142221eucas1p1ded332b5b69a9f3f1224914e48b28c19@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

exynos_tmu.h is used only by exynos_tmu.c so there is no need
for a separate include file.

Also while at it remove no longer needed cpu_cooling.h include.

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
Replacement patch for v1.

v2:
- Remove cpu_cooling.h include (as requested by Daniel)
- Add Acked-by from Daniel

 drivers/thermal/samsung/exynos_tmu.c |   17 +++++++++++++-
 drivers/thermal/samsung/exynos_tmu.h |   41 -----------------------------------
 2 files changed, 16 insertions(+), 42 deletions(-)

Index: b/drivers/thermal/samsung/exynos_tmu.c
===================================================================
--- a/drivers/thermal/samsung/exynos_tmu.c	2018-04-16 16:13:18.995562674 +0200
+++ b/drivers/thermal/samsung/exynos_tmu.c	2018-04-16 16:13:28.663562918 +0200
@@ -35,7 +35,8 @@
 #include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
 
-#include "exynos_tmu.h"
+#include <dt-bindings/thermal/thermal_exynos.h>
+
 #include "../thermal_core.h"
 
 /* Exynos generic registers */
@@ -173,6 +174,20 @@
 #define EXYNOS_NOISE_CANCEL_MODE		4
 
 #define MCELSIUS	1000
+
+enum soc_type {
+	SOC_ARCH_EXYNOS3250 = 1,
+	SOC_ARCH_EXYNOS4210,
+	SOC_ARCH_EXYNOS4412,
+	SOC_ARCH_EXYNOS5250,
+	SOC_ARCH_EXYNOS5260,
+	SOC_ARCH_EXYNOS5420,
+	SOC_ARCH_EXYNOS5420_TRIMINFO,
+	SOC_ARCH_EXYNOS5433,
+	SOC_ARCH_EXYNOS5440,
+	SOC_ARCH_EXYNOS7,
+};
+
 /**
  * struct exynos_tmu_data : A structure to hold the private data of the TMU
 	driver
Index: b/drivers/thermal/samsung/exynos_tmu.h
===================================================================
--- a/drivers/thermal/samsung/exynos_tmu.h	2018-04-16 16:13:18.995562674 +0200
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,41 +0,0 @@
-/*
- * exynos_tmu.h - Samsung EXYNOS TMU (Thermal Management Unit)
- *
- *  Copyright (C) 2011 Samsung Electronics
- *  Donggeun Kim <dg77.kim@samsung.com>
- *  Amit Daniel Kachhap <amit.daniel@samsung.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
-
-#ifndef _EXYNOS_TMU_H
-#define _EXYNOS_TMU_H
-#include <linux/cpu_cooling.h>
-#include <dt-bindings/thermal/thermal_exynos.h>
-
-enum soc_type {
-	SOC_ARCH_EXYNOS3250 = 1,
-	SOC_ARCH_EXYNOS4210,
-	SOC_ARCH_EXYNOS4412,
-	SOC_ARCH_EXYNOS5250,
-	SOC_ARCH_EXYNOS5260,
-	SOC_ARCH_EXYNOS5420,
-	SOC_ARCH_EXYNOS5420_TRIMINFO,
-	SOC_ARCH_EXYNOS5433,
-	SOC_ARCH_EXYNOS5440,
-	SOC_ARCH_EXYNOS7,
-};
-
-#endif /* _EXYNOS_TMU_H */

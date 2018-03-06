Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933493AbeCFOpb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 09:45:31 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:49832 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932313AbeCFOpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 09:45:24 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180306144522epoutp02fe21396f571f480bad09e72d05ac7b94~ZXAREmu4q1274612746epoutp02f
X-AuditID: b6c32a48-9adff70000000ff0-7a-5a9ea98103db
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
Subject: [PATCH 12/12] thermal: exynos: remove separate thermal_exynos.h
 header file
Date: Tue, 06 Mar 2018 15:43:55 +0100
Message-id: <1520347435-22970-13-git-send-email-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1520347435-22970-1-git-send-email-b.zolnierkie@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrAIsWRmVeSWpSXmKPExsWy7bCmqW7jynlRBl0npCw2zljPajH/yDkg
        ceUaq0X/49fMFufPb2C32PQYyL28aw6bxefeI4wWM87vY7I4NHUvo8XS6xeZLFr3HmG3ePKw
        j82B12PNvDWMHpevXWT22DnrLrvH4j0vmTw2repk89i8pN6jb8sqRo/Pm+QCOKK4bFJSczLL
        Uov07RK4Mpb1nGMqWCpcsfjiUvYGxskCXYycHBICJhKLnmxi62Lk4hAS2MEosff9KiaQhJDA
        d0aJe8dDYYoe/J8JVbSbUeLCx92MEM4vRonPDbsYQarYBKwkJravArNFBEokpq3qBStiFjjL
        JLFj+zsWkISwQJjElSWNbCA2i4CqxKzLt9lBbF4BT4mX/9YyQayTkzh5bDIriM0JFD/RcY4N
        In6CTWLm60II20Xi+rpuFghbWOLV8S3sELa0xLNVG8EWSwg0M0p827GHGSIxgVFiz3ohCNta
        4vDxi2ALmAX4JDoO/wVq5gCK80p0tEGVeEh8v/EY6h5HiZ2fW5ggPp7DKPH/ywzWCYxSCxgZ
        VjGKpRYU56anFhsVmOgVJ+YWl+al6yXn525iBMe7lscOxgPnfA4xCnAwKvHwbvCYGyXEmlhW
        XJl7iFGCg1lJhDdCf16UEG9KYmVValF+fFFpTmrxIUZpDhYlcd62AJcoIYH0xJLU7NTUgtQi
        mCwTB6dUA6PhjIS0lp3cnV+DVRY0HzLsVOvk/X9//atZZ3nZXt61cxFm8TNzZ59cpayndax8
        Z9eb/tOlwhOLshi9Ox5otq3dtM9p3ZHkNa9Zf+5fafWMNan/iMizU011O7m3p4ZaLJ/nZHdK
        59ZXR3UtA90pH4Ud3N9YvNn76lvliRo+/z3THpjM6n9195USS3FGoqEWc1FxIgBY+ZIT8wIA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBLMWRmVeSWpSXmKPExsVy+t9jAd2GlfOiDL5t17TYOGM9q8X8I+eA
        xJVrrBb9j18zW5w/v4HdYtNjIPfyrjlsFp97jzBazDi/j8ni0NS9jBZLr19ksmjde4Td4snD
        PjYHXo8189Ywely+dpHZY+esu+wei/e8ZPLYtKqTzWPzknqPvi2rGD0+b5IL4IjisklJzcks
        Sy3St0vgyljWc46pYKlwxeKLS9kbGCcLdDFyckgImEg8+D+TrYuRi0NIYCejxJuHi6CcX4wS
        qzfdYwapYhOwkpjYvooRxBYRKJHonPYaLM4scJZJ4uB/DhBbWCBM4kYvyCRODhYBVYlZl2+z
        g9i8Ap4SL/+tZYLYJidx8thkVhCbEyh+ouMcWL2QgIfE4u7fbBMYeRYwMqxilEwtKM5Nzy02
        KjDKSy3XK07MLS7NS9dLzs/dxAgMz22Htfp3MD5eEn+IUYCDUYmHd4PH3Cgh1sSy4srcQ4wS
        HMxKIrwR+vOihHhTEiurUovy44tKc1KLDzFKc7AoifPy5x+LFBJITyxJzU5NLUgtgskycXBK
        NTBW6q/qq9jIJf4uXTVWyPqklPqp3S/2Lb38/e+zw5PjWDN05k7/XV/IzZ9sUevEcmX9LtWz
        dYZy3ywKCi/MiEz54r870GMZg+0zwcyayzF8+UEpC3XnVVxsXfmwSW1y2LNrUwqn/4hLXab8
        Y/aWayv5m22XsMzV3cV+KfPzd91X7GfeKZtx+F1TYinOSDTUYi4qTgQAj/pAxEsCAAA=
X-CMS-MailID: 20180306144520epcas2p4950ac2762036882ccd097fd2bf629bbc
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20180306144520epcas2p4950ac2762036882ccd097fd2bf629bbc
X-RootMTR: 20180306144520epcas2p4950ac2762036882ccd097fd2bf629bbc
References: <1520347435-22970-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180306144520epcas2p4950ac2762036882ccd097fd2bf629bbc@epcas2p4.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

thermal_exynos.h is used only by exynos_tmu.c so there is no need
for a separate include file. Also while it remove unused defines.

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c         |  5 +++--
 include/dt-bindings/thermal/thermal_exynos.h | 28 ----------------------------
 2 files changed, 3 insertions(+), 30 deletions(-)
 delete mode 100644 include/dt-bindings/thermal/thermal_exynos.h

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index d8b9c3e..a16c37d 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -36,8 +36,6 @@
 #include <linux/regulator/consumer.h>
 #include <linux/cpu_cooling.h>
 
-#include <dt-bindings/thermal/thermal_exynos.h>
-
 #include "../thermal_core.h"
 
 /* Exynos generic registers */
@@ -169,6 +167,9 @@
 #define EXYNOS7_EMUL_DATA_SHIFT			7
 #define EXYNOS7_EMUL_DATA_MASK			0x1ff
 
+#define TYPE_ONE_POINT_TRIMMING			0
+#define TYPE_TWO_POINT_TRIMMING			1
+
 #define EXYNOS_FIRST_POINT_TRIM			25
 #define EXYNOS_SECOND_POINT_TRIM		85
 
diff --git a/include/dt-bindings/thermal/thermal_exynos.h b/include/dt-bindings/thermal/thermal_exynos.h
deleted file mode 100644
index 0646500..0000000
--- a/include/dt-bindings/thermal/thermal_exynos.h
+++ /dev/null
@@ -1,28 +0,0 @@
-/*
- * thermal_exynos.h - Samsung EXYNOS TMU device tree definitions
- *
- *  Copyright (C) 2014 Samsung Electronics
- *  Lukasz Majewski <l.majewski@samsung.com>
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
- */
-
-#ifndef _EXYNOS_THERMAL_TMU_DT_H
-#define _EXYNOS_THERMAL_TMU_DT_H
-
-#define TYPE_ONE_POINT_TRIMMING 0
-#define TYPE_ONE_POINT_TRIMMING_25 1
-#define TYPE_ONE_POINT_TRIMMING_85 2
-#define TYPE_TWO_POINT_TRIMMING 3
-#define TYPE_NONE 4
-
-#endif /* _EXYNOS_THERMAL_TMU_DT_H */
-- 
1.9.1

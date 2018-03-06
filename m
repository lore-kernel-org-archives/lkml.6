Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933360AbeCFOpO (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 09:45:14 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:38685 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933267AbeCFOpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 09:45:10 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180306144509epoutp039b1ee5233cc5da6a63b6a7fb9622f18b~ZXAEZzQjj2083020830epoutp03P
X-AuditID: b6c32a47-187ff7000000100c-7d-5a9ea973481d
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
Subject: [PATCH 09/12] thermal: exynos: remove separate exynos_tmu.h header
 file
Date: Tue, 06 Mar 2018 15:43:52 +0100
Message-id: <1520347435-22970-10-git-send-email-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1520347435-22970-1-git-send-email-b.zolnierkie@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPIsWRmVeSWpSXmKPExsWy7bCmhW7xynlRBpc7LS02zljPajH/yDkg
        ceUaq0X/49fMFufPb2C32PQYyL28aw6bxefeI4wWM87vY7I4NHUvo8XS6xeZLFr3HmG3ePKw
        j82B12PNvDWMHpevXWT22DnrLrvH4j0vmTw2repk89i8pN6jb8sqRo/Pm+QCOKK4bFJSczLL
        Uov07RK4Ms7sO8taMEei4knbQvYGxoUiXYwcHBICJhIb77h1MXJxCAnsYJT4vfMeO4TznVGi
        o+05K0zRr1XuXYycQPHdjBIPOtQgan4xSjxZO40RJMEmYCUxsX0VmC0iUCIxbVUvI0gRs8BZ
        Jokd29+xgCSEBYIkrq6+yg5iswioSjzpfccGYvMKeErc29QKViMhICdx8thkVhCbEyh+ouMc
        G8ggCYEzbBL/Zq5hhihykVh1oA2qQVji1fEt7BC2tMSzVRsZIRqaGSW+7dgD1TCBUWLPeiEI
        21ri8PGLYBuYBfgkOg7/ZYd4kxfoZagSD4nzX44yQdiOEk1n5kODZQ6jxL5v75gnMEotYGRY
        xSiWWlCcm55abFRgrFecmFtcmpeul5yfu4kRHO1a7jsYt53zOcQowMGoxMO7wWNulBBrYllx
        Ze4hRgkOZiUR3gj9eVFCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeVsDXKKEBNITS1KzU1MLUotg
        skwcnFINjEJM7zl4H/nkdLddttj9Oq7+7lz9Nf6R7hMOSC3fZ3Lg8bEbn5R557//uU90sc3E
        RM6bWhcTF7yZ75fNbiP3UbtIo/fwa9PlUz54pWR8CdRn9wpiTemalsibJvcwLd3A9LlM2e+n
        0vVseZOPn1YT+zLrnP+Fa3ON/Y5s937VNL/ia4UPi7+YkhJLcUaioRZzUXEiAC6/O+XyAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOLMWRmVeSWpSXmKPExsVy+t9jAd3ilfOiDFrOC1psnLGe1WL+kXNA
        4so1Vov+x6+ZLc6f38BusekxkHt51xw2i8+9RxgtZpzfx2RxaOpeRoul1y8yWbTuPcJu8eRh
        H5sDr8eaeWsYPS5fu8jssXPWXXaPxXteMnlsWtXJ5rF5Sb1H35ZVjB6fN8kFcERx2aSk5mSW
        pRbp2yVwZZzZd5a1YI5ExZO2hewNjAtFuhg5OCQETCR+rXLvYuTiEBLYySgx6eVZZgjnF6PE
        99UvGbsYOTnYBKwkJravArNFBEokOqe9ZgaxmQXOMkkc/M8BYgsLBEjsnP2RCcRmEVCVeNL7
        jg3E5hXwlLi3qZUFxJYQkJM4eWwyK4jNCRQ/0XEOrEZIwENicfdvtgmMPAsYGVYxSqYWFOem
        5xYbFRjlpZbrFSfmFpfmpesl5+duYgQG57bDWv07GB8viT/EKMDBqMTDu8FjbpQQa2JZcWXu
        IUYJDmYlEd4I/XlRQrwpiZVVqUX58UWlOanFhxilOViUxHn5849FCgmkJ5akZqemFqQWwWSZ
        ODilGhj9p28xcfToZreo8r37oTcyW+/+2WcfpW6E1V649u1BTIMME8ddY9mm4wrWH+LrvxXx
        zc1flCK5RDF044OqOxfPyR47sD7tpvGZt2YHF5oucpfMWFWs7/8nZn9/wMF1ndf2/ZebrMWT
        KlXw73MJb3ic/NPvXadORolIHHz0Vc765rRla+K9/5oosRRnJBpqMRcVJwIAqeSxoEoCAAA=
X-CMS-MailID: 20180306144507epcas2p2bcff1b5d29b84d248fcb153e4af63c16
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20180306144507epcas2p2bcff1b5d29b84d248fcb153e4af63c16
X-RootMTR: 20180306144507epcas2p2bcff1b5d29b84d248fcb153e4af63c16
References: <1520347435-22970-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180306144507epcas2p2bcff1b5d29b84d248fcb153e4af63c16@epcas2p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

exynos_tmu.h is used only by exynos_tmu.c so there is no need
for a separate include file.

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 18 +++++++++++++++-
 drivers/thermal/samsung/exynos_tmu.h | 41 ------------------------------------
 2 files changed, 17 insertions(+), 42 deletions(-)
 delete mode 100644 drivers/thermal/samsung/exynos_tmu.h

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index ab5062b..d8b9c3e 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -34,8 +34,10 @@
 #include <linux/of_irq.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
+#include <linux/cpu_cooling.h>
+
+#include <dt-bindings/thermal/thermal_exynos.h>
 
-#include "exynos_tmu.h"
 #include "../thermal_core.h"
 
 /* Exynos generic registers */
@@ -173,6 +175,20 @@
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
diff --git a/drivers/thermal/samsung/exynos_tmu.h b/drivers/thermal/samsung/exynos_tmu.h
deleted file mode 100644
index 8f56f86..0000000
--- a/drivers/thermal/samsung/exynos_tmu.h
+++ /dev/null
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
-- 
1.9.1

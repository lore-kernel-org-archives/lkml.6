Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754348AbeDPKO3 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 06:14:29 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:61942 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753154AbeDPKOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 06:14:24 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180416101423epoutp018be26ba6b11470e25be929ff58e45578~l4wXYYCuO2855528555epoutp01s
X-AuditID: b6c32a48-8c1ff70000000ff2-f5-5ad4777ecb38
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
Subject: [PATCH 12/14] thermal: exynos: remove separate exynos_tmu.h header
 file
Date: Mon, 16 Apr 2018 12:12:03 +0200
Message-id: <1523873525-23718-13-git-send-email-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1523873525-23718-1-git-send-email-b.zolnierkie@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEIsWRmVeSWpSXmKPExsWy7bCmhW5d+ZUog+nrzSw2zljPajHvs6zF
        /CvXWC36H79mtjh/fgO7xeVdc9gsPvceYbSYcX4fk8WTh31sDpweO2fdZfdYvOclk8emVZ1s
        Hneu7WHz6NuyitHj8ya5ALYoLpuU1JzMstQifbsErowVD54yFcyRqPjdOYW9gXGhSBcjJ4eE
        gInE2sYrbCC2kMAORol/q+y6GLmA7O+MEu8utzLBFP3uesQCUbSBUeLNJFuIol+MEr9XdoMl
        2ASsJCa2r2IEsUUEtCROXNrOBFLELDCBSeLpq5lgK4QFgiROvnwKVsQioCqx9PVGMJtXwFPi
        1fZuVohtchInj00GszmB4k1rrrGBDJIQWMAmsXTeCnaIIheJvq9fGCFsYYlXx7dAxaUlnq0C
        GQrS0Mwo8W3HHmaIxARGiT3rhSBsa4nDxy+CbWAW4JPoOPwXqJkDKM4r0dEGVeIhce/9W6j3
        HSU29B1lh3h5DqPEzWO7WCYwSi1gZFjFKJZaUJybnlpsVGCiV5yYW1yal66XnJ+7iREcs1oe
        OxgPnPM5xCjAwajEw7vj7OUoIdbEsuLK3EOMEhzMSiK8yxKBQrwpiZVVqUX58UWlOanFhxil
        OViUxHkbfM9ECQmkJ5akZqemFqQWwWSZODilGhgzTDsjJ5w7KDjx2zyjLxMfzu5epMCS9WRD
        ltGV6+fee94J6l4Uv/Y0V9eWDQmN0zdrP14sY9n556XtxpXZ4afzT8Se+fv91lahwq8Brrkx
        vnJnOs+9+7LmxJSffdvdNNqld0j5T7h8j9HrXVeInrRbVS6rT9dn7zkz/plW6ouuCbyT6tY2
        JapaiaU4I9FQi7moOBEAwfKad9UCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNLMWRmVeSWpSXmKPExsVy+t9jQd268itRBo8esFlsnLGe1WLeZ1mL
        +VeusVr0P37NbHH+/AZ2i8u75rBZfO49wmgx4/w+JosnD/vYHDg9ds66y+6xeM9LJo9NqzrZ
        PO5c28Pm0bdlFaPH501yAWxRXDYpqTmZZalF+nYJXBkrHjxlKpgjUfG7cwp7A+NCkS5GTg4J
        AROJ312PWLoYuTiEBNYxSvzed4YJwvnFKNHUNo0FpIpNwEpiYvsqRhBbREBL4sSl7WBFzAIT
        mCSWrF3EDpIQFgiQeHtzDROIzSKgKrH09UawBl4BT4lX27tZIdbJSZw8NhnM5gSKN625xgZi
        Cwl4SDROvMo4gZFnASPDKkbJ1ILi3PTcYqMCo7zUcr3ixNzi0rx0veT83E2MwCDbdlirfwfj
        4yXxhxgFOBiVeHh3nL0cJcSaWFZcmXuIUYKDWUmEd1kiUIg3JbGyKrUoP76oNCe1+BCjNAeL
        kjgvf/6xSCGB9MSS1OzU1ILUIpgsEwenVANj9KlOj5S5C96errb6u+KGvfV9weLQ1uWqf4UU
        +m5e2KDofuzVYbbmjUIXLvEZSf+OedTgL7RoAX/2vZpDpya8eaG6aaWhHGe2dPnG2Lm9CXrH
        zH5c8xFZlXPQZZ3Sv9ebP72VbvhWte5vhO356B/P/GSbXj5a/zBc88SPuzWfL613DKrMieab
        rMRSnJFoqMVcVJwIAH6RN0YuAgAA
X-CMS-MailID: 20180416101422epcas2p34c80b64c6c762b98ae4fecfe6a4db4f8
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20180416101422epcas2p34c80b64c6c762b98ae4fecfe6a4db4f8
X-RootMTR: 20180416101422epcas2p34c80b64c6c762b98ae4fecfe6a4db4f8
References: <1523873525-23718-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180416101422epcas2p34c80b64c6c762b98ae4fecfe6a4db4f8@epcas2p3.samsung.com>
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
index 7975f33..197f267 100644
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

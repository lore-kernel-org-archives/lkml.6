Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754832AbeBOGD7 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 01:03:59 -0500
Received: from lelnx193.ext.ti.com ([198.47.27.77]:38648 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751776AbeBOGD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 01:03:56 -0500
From: Keerthy <j-keerthy@ti.com>
To: <daniel.lezcano@linaro.org>, <thierry.reding@gmail.com>,
        <tony@atomide.com>, <aaro.koskinen@iki.fi>
CC: <j-keerthy@ti.com>, <Claudiu.Beznea@microchip.com>,
        <narmstrong@baylibre.com>, <linux-pwm@vger.kernel.org>,
        <ladis@linux-mips.org>, <s-anna@ti.com>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <sebastian.reichel@collabora.co.uk>, <linux-omap@vger.kernel.org>,
        <robh+dt@kernel.org>, <t-kristo@ti.com>, <grygorii.strashko@ti.com>
Subject: [PATCH v11 03/10] arm: omap: Move dmtimer.h out of plat-omap
Date: Thu, 15 Feb 2018 11:31:44 +0530
Message-ID: <1518674511-26421-4-git-send-email-j-keerthy@ti.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1518674511-26421-1-git-send-email-j-keerthy@ti.com>
References: <1518674511-26421-1-git-send-email-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The header file is currently under plat-omap directory
under arch/omap. Move this out to an accessible place.

No Code changes done to the header file and renamed to timer-ti-dm.h.

Signed-off-by: Keerthy <j-keerthy@ti.com>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Tested-by: Ladislav Michl <ladis@linux-mips.org>
---
 arch/arm/mach-omap1/pm.c                                                | 2 +-
 arch/arm/mach-omap1/timer.c                                             | 2 +-
 arch/arm/mach-omap2/pdata-quirks.c                                      | 2 +-
 arch/arm/mach-omap2/timer.c                                             | 2 +-
 arch/arm/plat-omap/dmtimer.c                                            | 2 +-
 .../include/plat/dmtimer.h => include/clocksource/timer-ti-dm.h         | 0
 6 files changed, 5 insertions(+), 5 deletions(-)
 rename arch/arm/plat-omap/include/plat/dmtimer.h => include/clocksource/timer-ti-dm.h (100%)

diff --git a/arch/arm/mach-omap1/pm.c b/arch/arm/mach-omap1/pm.c
index f1135bf..3e1de14 100644
--- a/arch/arm/mach-omap1/pm.c
+++ b/arch/arm/mach-omap1/pm.c
@@ -55,7 +55,7 @@
 #include <mach/tc.h>
 #include <mach/mux.h>
 #include <linux/omap-dma.h>
-#include <plat/dmtimer.h>
+#include <clocksource/timer-ti-dm.h>
 
 #include <mach/irqs.h>
 
diff --git a/arch/arm/mach-omap1/timer.c b/arch/arm/mach-omap1/timer.c
index 8fb1ec6..4447210 100644
--- a/arch/arm/mach-omap1/timer.c
+++ b/arch/arm/mach-omap1/timer.c
@@ -27,7 +27,7 @@
 #include <linux/platform_device.h>
 #include <linux/platform_data/dmtimer-omap.h>
 
-#include <plat/dmtimer.h>
+#include <clocksource/timer-ti-dm.h>
 
 #include "soc.h"
 
diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
index 6b433fc..2455020 100644
--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -27,7 +27,7 @@
 #include <linux/platform_data/pwm_omap_dmtimer.h>
 #include <linux/platform_data/media/ir-rx51.h>
 #include <linux/platform_data/asoc-ti-mcbsp.h>
-#include <plat/dmtimer.h>
+#include <clocksource/timer-ti-dm.h>
 
 #include "common.h"
 #include "common-board-devices.h"
diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index d61fbd7..4fb4dc2 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -49,7 +49,7 @@
 #include "omap_hwmod.h"
 #include "omap_device.h"
 #include <plat/counter-32k.h>
-#include <plat/dmtimer.h>
+#include <clocksource/timer-ti-dm.h>
 #include "omap-pm.h"
 
 #include "soc.h"
diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 72565fc..1d6aff8 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -47,7 +47,7 @@
 #include <linux/platform_device.h>
 #include <linux/platform_data/dmtimer-omap.h>
 
-#include <plat/dmtimer.h>
+#include <clocksource/timer-ti-dm.h>
 
 static u32 omap_reserved_systimers;
 static LIST_HEAD(omap_timer_list);
diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h b/include/clocksource/timer-ti-dm.h
similarity index 100%
rename from arch/arm/plat-omap/include/plat/dmtimer.h
rename to include/clocksource/timer-ti-dm.h
-- 
1.9.1

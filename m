Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751765AbeBUXnk (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 18:43:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:33190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751413AbeBUXlH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 18:41:07 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80C142179F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
From: James Hogan <jhogan@kernel.org>
To: linux-metag@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, James Hogan <jhogan@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 06/13] clocksource: Remove metag generic timer driver
Date: Wed, 21 Feb 2018 23:38:18 +0000
Message-Id: <20180221233825.10024-7-jhogan@kernel.org>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180221233825.10024-1-jhogan@kernel.org>
References: <20180221233825.10024-1-jhogan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that arch/metag/ has been removed, remove the metag generic
per-thread timer driver. It is of no value without the architecture
code.

Signed-off-by: James Hogan <jhogan@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-metag@vger.kernel.org
---
 drivers/clocksource/Kconfig         |   5 --
 drivers/clocksource/Makefile        |   1 -
 drivers/clocksource/metag_generic.c | 161 ------------------------------------
 include/clocksource/metag_generic.h |  21 -----
 include/linux/cpuhotplug.h          |   1 -
 5 files changed, 189 deletions(-)
 delete mode 100644 drivers/clocksource/metag_generic.c
 delete mode 100644 include/clocksource/metag_generic.h

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index b3b4ed9b6874..f99dbc2f7ee4 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -391,11 +391,6 @@ config ATMEL_ST
 	help
 	  Support for the Atmel ST timer.
 
-config CLKSRC_METAG_GENERIC
-	def_bool y if METAG
-	help
-	  This option enables support for the Meta per-thread timers.
-
 config CLKSRC_EXYNOS_MCT
 	bool "Exynos multi core timer driver" if COMPILE_TEST
 	depends on ARM || ARM64
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index d6dec4489d66..a2d47e9ecf91 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -61,7 +61,6 @@ obj-$(CONFIG_ARM_ARCH_TIMER)		+= arm_arch_timer.o
 obj-$(CONFIG_ARM_GLOBAL_TIMER)		+= arm_global_timer.o
 obj-$(CONFIG_ARMV7M_SYSTICK)		+= armv7m_systick.o
 obj-$(CONFIG_ARM_TIMER_SP804)		+= timer-sp804.o
-obj-$(CONFIG_CLKSRC_METAG_GENERIC)	+= metag_generic.o
 obj-$(CONFIG_ARCH_HAS_TICK_BROADCAST)	+= dummy_timer.o
 obj-$(CONFIG_KEYSTONE_TIMER)		+= timer-keystone.o
 obj-$(CONFIG_INTEGRATOR_AP_TIMER)	+= timer-integrator-ap.o
diff --git a/drivers/clocksource/metag_generic.c b/drivers/clocksource/metag_generic.c
deleted file mode 100644
index 3e5fa2f62d5f..000000000000
diff --git a/include/clocksource/metag_generic.h b/include/clocksource/metag_generic.h
deleted file mode 100644
index ac17e7d06cfb..000000000000
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 5172ad0daa7c..a456be2f10c3 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -122,7 +122,6 @@ enum cpuhp_state {
 	CPUHP_AP_JCORE_TIMER_STARTING,
 	CPUHP_AP_EXYNOS4_MCT_TIMER_STARTING,
 	CPUHP_AP_ARM_TWD_STARTING,
-	CPUHP_AP_METAG_TIMER_STARTING,
 	CPUHP_AP_QCOM_TIMER_STARTING,
 	CPUHP_AP_ARMADA_TIMER_STARTING,
 	CPUHP_AP_MARCO_TIMER_STARTING,
-- 
2.13.6

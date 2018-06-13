Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 41176C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 11:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD28F208B3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 11:33:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CJWTW9VL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD28F208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935442AbeFMLd2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 07:33:28 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:38413 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935424AbeFMLdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 07:33:24 -0400
Received: by mail-pg0-f68.google.com with SMTP id c9-v6so1145099pgf.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 04:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=dlPlAQoN9NNMysgct5QnzMP8Q5ACUaR7klOM61JcA8E=;
        b=CJWTW9VL3JbQH/ipPdSBsgXI0FaOtKzHu4oK4amhxjSWJl9SmLw5LODr/Bo/H7oRB7
         bkgJeENX7brj2L2v6V/QEex/3Y+aaPz+O/GjkgZNfCNsgmPEV3UU7cE4Rpz2CBqFof3v
         h6Cq9wjhUZMafTf6Mt2fnfiKTtMGvc0FXGIWw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=dlPlAQoN9NNMysgct5QnzMP8Q5ACUaR7klOM61JcA8E=;
        b=TyN4jR+SFgDCBAv1Zh73JV+2DK6r5uFPhlmSHh2C/B7YjyzhgX4OXxqWCFiJxtyq1V
         gWeJmFCoQv0ufQ4VpWKI3vCDe4x/sGtzuC0MMHTt49kvwUPCt8ZYVOhWKnrJqJKC1VkH
         2GW8TogR8tTb7ny/bsqSF6FL9ome4Yo8lbl8dfbBcN8yEmwbM9MzJNtCUcApL4JFylKt
         jx44kKjjkAokXbwMoRCayLlTcu9XwkVSuhOwoVJgZcrgqFvbMqsA/riwSYNS8HP3L+gl
         F85+l2UArRVvg5fc2WYUrG6tEdpMTA4tzGo/W56BxlcqGIKVWbxYHqWk8ZU1n3FRdqNQ
         dWCg==
X-Gm-Message-State: APt69E1DjzxGe25FQxIarjGlN1DgYP4poSeq28GfAEGIDWb8znGcPnhr
        It2R5o49ZIPIO+Y0VVDo3pnfGw==
X-Google-Smtp-Source: ADUXVKIfSXzwRviQDZouC0BQqKDhcGk6mFUHz8j1ZWAL3UiAx2BIRuzsnuv6ykZaLrXdB1soc+Ph7A==
X-Received: by 2002:a62:e310:: with SMTP id g16-v6mr4593998pfh.25.1528889603725;
        Wed, 13 Jun 2018 04:33:23 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id h8-v6sm2745370pgq.35.2018.06.13.04.33.15
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Jun 2018 04:33:23 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     tglx@linutronix.de, john.stultz@linaro.org,
        daniel.lezcano@linaro.org, arnd@arndb.de, tony@atomide.com,
        aaro.koskinen@iki.fi, linux@armlinux.org.uk, mark.rutland@arm.com,
        marc.zyngier@arm.com
Cc:     baolin.wang@linaro.org, broonie@kernel.org,
        paulmck@linux.vnet.ibm.com, mlichvar@redhat.com,
        rdunlap@infradead.org, kstewart@linuxfoundation.org,
        gregkh@linuxfoundation.org, pombredanne@nexb.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com, heiko@sntech.de,
        linus.walleij@linaro.org, viresh.kumar@linaro.org,
        mingo@kernel.org, hpa@zytor.com, peterz@infradead.org,
        douly.fnst@cn.fujitsu.com, len.brown@intel.com,
        rajvi.jingar@intel.com, alexandre.belloni@bootlin.com,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: [PATCH 3/8] arm: time: Remove the persistent clock support for ARM architecture
Date:   Wed, 13 Jun 2018 19:32:30 +0800
Message-Id: <ec57a4f5d7ba300540b99236e6eef1b551b152dc.1528878545.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1528878545.git.baolin.wang@linaro.org>
References: <cover.1528878545.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1528878545.git.baolin.wang@linaro.org>
References: <cover.1528878545.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have introduced the persistent clock framework to support the OS time
compensating from persistent clock, and we will convert all drivers to
use common persistent clock framework instead of the persistent clock
support used only for the ARM architecture. So we can remove these code
with converting the Omap 32k counter and tegra20 timer.

Moreover there are no drivers will register read_boot_clock64(), so
remove it too.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 arch/arm/include/asm/mach/time.h    |    4 ----
 arch/arm/kernel/time.c              |   36 ----------------------------
 arch/arm/plat-omap/Kconfig          |    1 +
 arch/arm/plat-omap/counter_32k.c    |   44 ++++++-----------------------------
 drivers/clocksource/tegra20_timer.c |   12 +++++++---
 5 files changed, 17 insertions(+), 80 deletions(-)

diff --git a/arch/arm/include/asm/mach/time.h b/arch/arm/include/asm/mach/time.h
index 0f79e4d..3cbcafc 100644
--- a/arch/arm/include/asm/mach/time.h
+++ b/arch/arm/include/asm/mach/time.h
@@ -12,8 +12,4 @@
 
 extern void timer_tick(void);
 
-typedef void (*clock_access_fn)(struct timespec64 *);
-extern int register_persistent_clock(clock_access_fn read_boot,
-				     clock_access_fn read_persistent);
-
 #endif
diff --git a/arch/arm/kernel/time.c b/arch/arm/kernel/time.c
index cf2701c..713905c 100644
--- a/arch/arm/kernel/time.c
+++ b/arch/arm/kernel/time.c
@@ -76,42 +76,6 @@ void timer_tick(void)
 }
 #endif
 
-static void dummy_clock_access(struct timespec64 *ts)
-{
-	ts->tv_sec = 0;
-	ts->tv_nsec = 0;
-}
-
-static clock_access_fn __read_persistent_clock = dummy_clock_access;
-static clock_access_fn __read_boot_clock = dummy_clock_access;
-
-void read_persistent_clock64(struct timespec64 *ts)
-{
-	__read_persistent_clock(ts);
-}
-
-void read_boot_clock64(struct timespec64 *ts)
-{
-	__read_boot_clock(ts);
-}
-
-int __init register_persistent_clock(clock_access_fn read_boot,
-				     clock_access_fn read_persistent)
-{
-	/* Only allow the clockaccess functions to be registered once */
-	if (__read_persistent_clock == dummy_clock_access &&
-	    __read_boot_clock == dummy_clock_access) {
-		if (read_boot)
-			__read_boot_clock = read_boot;
-		if (read_persistent)
-			__read_persistent_clock = read_persistent;
-
-		return 0;
-	}
-
-	return -EINVAL;
-}
-
 void __init time_init(void)
 {
 	if (machine_desc->init_time) {
diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index c0a242c..073a80f 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 config ARCH_OMAP
+	select PERSISTENT_CLOCK
 	bool
 
 if ARCH_OMAP
diff --git a/arch/arm/plat-omap/counter_32k.c b/arch/arm/plat-omap/counter_32k.c
index 2438b96..5d52f7c 100644
--- a/arch/arm/plat-omap/counter_32k.c
+++ b/arch/arm/plat-omap/counter_32k.c
@@ -19,8 +19,7 @@
 #include <linux/io.h>
 #include <linux/clocksource.h>
 #include <linux/sched_clock.h>
-
-#include <asm/mach/time.h>
+#include <linux/persistent_clock.h>
 
 #include <plat/counter-32k.h>
 
@@ -44,33 +43,6 @@ static u64 notrace omap_32k_read_sched_clock(void)
 }
 
 /**
- * omap_read_persistent_clock64 -  Return time from a persistent clock.
- *
- * Reads the time from a source which isn't disabled during PM, the
- * 32k sync timer.  Convert the cycles elapsed since last read into
- * nsecs and adds to a monotonically increasing timespec64.
- */
-static struct timespec64 persistent_ts;
-static cycles_t cycles;
-static unsigned int persistent_mult, persistent_shift;
-
-static void omap_read_persistent_clock64(struct timespec64 *ts)
-{
-	unsigned long long nsecs;
-	cycles_t last_cycles;
-
-	last_cycles = cycles;
-	cycles = sync32k_cnt_reg ? readl_relaxed(sync32k_cnt_reg) : 0;
-
-	nsecs = clocksource_cyc2ns(cycles - last_cycles,
-					persistent_mult, persistent_shift);
-
-	timespec64_add_ns(&persistent_ts, nsecs);
-
-	*ts = persistent_ts;
-}
-
-/**
  * omap_init_clocksource_32k - setup and register counter 32k as a
  * kernel clocksource
  * @pbase: base addr of counter_32k module
@@ -95,13 +67,6 @@ int __init omap_init_clocksource_32k(void __iomem *vbase)
 	else
 		sync32k_cnt_reg = vbase + OMAP2_32KSYNCNT_CR_OFF_LOW;
 
-	/*
-	 * 120000 rough estimate from the calculations in
-	 * __clocksource_update_freq_scale.
-	 */
-	clocks_calc_mult_shift(&persistent_mult, &persistent_shift,
-			32768, NSEC_PER_SEC, 120000);
-
 	ret = clocksource_mmio_init(sync32k_cnt_reg, "32k_counter", 32768,
 				250, 32, clocksource_mmio_readl_up);
 	if (ret) {
@@ -110,7 +75,12 @@ int __init omap_init_clocksource_32k(void __iomem *vbase)
 	}
 
 	sched_clock_register(omap_32k_read_sched_clock, 32, 32768);
-	register_persistent_clock(NULL, omap_read_persistent_clock64);
+	/*
+	 * 120000 rough estimate from the calculations in
+	 * __clocksource_update_freq_scale.
+	 */
+	persistent_clock_init_and_register(omap_32k_read_sched_clock,
+					   CLOCKSOURCE_MASK(32), 32768, 120000);
 	pr_info("OMAP clocksource: 32k_counter at 32768 Hz\n");
 
 	return 0;
diff --git a/drivers/clocksource/tegra20_timer.c b/drivers/clocksource/tegra20_timer.c
index c337a81..97a34cb 100644
--- a/drivers/clocksource/tegra20_timer.c
+++ b/drivers/clocksource/tegra20_timer.c
@@ -124,7 +124,7 @@ static u64 tegra_rtc_read_ms(void)
 }
 
 /*
- * tegra_read_persistent_clock64 -  Return time from a persistent clock.
+ * read_persistent_clock64 -  Return time from a persistent clock.
  *
  * Reads the time from a source which isn't disabled during PM, the
  * 32k sync timer.  Convert the cycles elapsed since last read into
@@ -133,10 +133,16 @@ static u64 tegra_rtc_read_ms(void)
  * tegra_rtc driver could be executing to avoid race conditions
  * on the RTC shadow register
  */
-static void tegra_read_persistent_clock64(struct timespec64 *ts)
+void read_persistent_clock64(struct timespec64 *ts)
 {
 	u64 delta;
 
+	if (!rtc_base) {
+		ts->tv_sec = 0;
+		ts->tv_nsec = 0;
+		return;
+	}
+
 	last_persistent_ms = persistent_ms;
 	persistent_ms = tegra_rtc_read_ms();
 	delta = persistent_ms - last_persistent_ms;
@@ -259,6 +265,6 @@ static int __init tegra20_init_rtc(struct device_node *np)
 	else
 		clk_prepare_enable(clk);
 
-	return register_persistent_clock(NULL, tegra_read_persistent_clock64);
+	return 0;
 }
 TIMER_OF_DECLARE(tegra20_rtc, "nvidia,tegra20-rtc", tegra20_init_rtc);
-- 
1.7.9.5


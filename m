Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D19CBC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 13:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F8C4223DD
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 13:32:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eR0brWNV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F8C4223DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388394AbeKOXkH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 18:40:07 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36421 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388290AbeKOXkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 18:40:06 -0500
Received: by mail-lf1-f67.google.com with SMTP id h192so14141395lfg.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 05:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=o7M9G96s4mn6gVHofvS0Iq+dG/9ayDwkuUKUrD30CTM=;
        b=eR0brWNVkbTbmDX1Uss1C6555F3RWGVEXK2PRUbhUeGJzOZ8IlZmIbq8cH66PSEJN6
         AemtFqTTwI81Q3YbGLY5+aDS2YwNf1UL+9BpDWZ7bY0Hv1INwGBqfKEloikonPjY6mfu
         T4RTAGnCW/9EIt5bypacmzmf40zwcQgY5zX9U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=o7M9G96s4mn6gVHofvS0Iq+dG/9ayDwkuUKUrD30CTM=;
        b=qZIVWQpZdYGvswXmcld/fTeYgdSQZ3dO84nMbxZxC/P2edc476clsyERGAInl276SF
         +LNF3mgUwN40No3gi/TJi/3QU5/BA+lKli8x/bmVwE3kCwnMkwZSA45x/usR6LzvbxCX
         SwLxytlTjrdE+/GBko/2/CDQIogjtNDSFK+iwXP/oS+JhkMlF2dQcD/QPWjD00s/AQuQ
         OCPj0V2OCGpT/HBuSgm0DrbtpwrQ1n6YtoU+fC2TBH9Bs5jgcJnS+bC6l6AvrHL8EhKP
         9Fps0VytqX7NFGY157zooBjN7JUrYvjj6vnIE3ZPx1VcHjGvVIMYQqPojbED7py5BVek
         1agw==
X-Gm-Message-State: AGRZ1gJOOujb94dtmF326GHdoR0o0qw/m7oIroYxS23Z+UgUDIjhkNEJ
        0lYMUesCG0eTWsko/wBRHAHwBY3J33/KuQ==
X-Google-Smtp-Source: AJdET5dLNCV+1hWCBIRqnWrNWyLl5oVzGepT/9MyEGTO6jr16eOjV7SpsFmscxjNoRQ0rSwM6Ff1RA==
X-Received: by 2002:a19:4f0c:: with SMTP id d12mr3298185lfb.121.1542288731296;
        Thu, 15 Nov 2018 05:32:11 -0800 (PST)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id f76sm4291949lfl.74.2018.11.15.05.32.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Nov 2018 05:32:10 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     linux-kernel@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH 2/2] clocksource: Drop Ux500 custom SCHED_CLOCK
Date:   Thu, 15 Nov 2018 14:32:03 +0100
Message-Id: <20181115133203.28567-2-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181115133203.28567-1-linus.walleij@linaro.org>
References: <20181115133203.28567-1-linus.walleij@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The two drivers used for Ux500 sched_clock use two Kconfig
symbols to select which of the two gets used as sched_clock.

This isn't right: the workaround is trying to make sure that
the NONSTOP timer is used for sched_clock in order to keep
that clock ticking consistently over a suspend/resume
cycle. (Otherwise sched_clock simply stops during suspend
and continues after resume).

This will notably affect any timetstamped debug prints,
so that they show the absolute number of seconds since the
system was booted and does not loose wall-clock time during
suspend and resume as if time stood still.

The real way to fix this problem is to make sched_clock
take advantage of any NONSTOP clock source on the system
and adjust accordingly, not to try to work around this by
using a different sched_clock depending on what system
we are compiling for. This can solve the problem for
everyone instead of providing a local solution.

Cc: Baolin Wang <baolin.wang@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Any suggestions on how to proceed to make sched_clock
keep ticking using NONSTOP clocksource is welcome.
---
 drivers/clocksource/Kconfig               | 13 -------------
 drivers/clocksource/clksrc-dbx500-prcmu.c | 18 ------------------
 drivers/clocksource/nomadik-mtu.c         |  4 ----
 3 files changed, 35 deletions(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 55c77e44bb2d..64d5759ddf0e 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -163,12 +163,6 @@ config CLKSRC_NOMADIK_MTU
 	  to multiple interrupt generating programmable
 	  32-bit free running decrementing counters.
 
-config CLKSRC_NOMADIK_MTU_SCHED_CLOCK
-	bool
-	depends on CLKSRC_NOMADIK_MTU
-	help
-	  Use the Multi Timer Unit as the sched_clock.
-
 config CLKSRC_DBX500_PRCMU
 	bool "Clocksource PRCMU Timer" if COMPILE_TEST
 	depends on HAS_IOMEM
@@ -226,13 +220,6 @@ config INTEGRATOR_AP_TIMER
 	help
 	  Enables support for the Integrator-ap timer.
 
-config CLKSRC_DBX500_PRCMU_SCHED_CLOCK
-	bool "Clocksource PRCMU Timer sched_clock"
-	depends on (CLKSRC_DBX500_PRCMU && !CLKSRC_NOMADIK_MTU_SCHED_CLOCK)
-	default y
-	help
-	  Use the always on PRCMU Timer as sched_clock
-
 config CLKSRC_EFM32
 	bool "Clocksource for Energy Micro's EFM32 SoCs" if !ARCH_EFM32
 	depends on OF && ARM && (ARCH_EFM32 || COMPILE_TEST)
diff --git a/drivers/clocksource/clksrc-dbx500-prcmu.c b/drivers/clocksource/clksrc-dbx500-prcmu.c
index 4054539fe066..51d53c4e646f 100644
--- a/drivers/clocksource/clksrc-dbx500-prcmu.c
+++ b/drivers/clocksource/clksrc-dbx500-prcmu.c
@@ -15,7 +15,6 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/clockchips.h>
-#include <linux/sched_clock.h>
 
 #define RATE_32K		32768
 
@@ -26,8 +25,6 @@
 #define PRCMU_TIMER_DOWNCOUNT	0x4
 #define PRCMU_TIMER_MODE	0x8
 
-#define SCHED_CLOCK_MIN_WRAP 131072 /* 2^32 / 32768 */
-
 static void __iomem *clksrc_dbx500_timer_base;
 
 static u64 notrace clksrc_dbx500_prcmu_read(struct clocksource *cs)
@@ -52,18 +49,6 @@ static struct clocksource clocksource_dbx500_prcmu = {
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS | CLOCK_SOURCE_SUSPEND_NONSTOP,
 };
 
-#ifdef CONFIG_CLKSRC_DBX500_PRCMU_SCHED_CLOCK
-
-static u64 notrace dbx500_prcmu_sched_clock_read(void)
-{
-	if (unlikely(!clksrc_dbx500_timer_base))
-		return 0;
-
-	return clksrc_dbx500_prcmu_read(&clocksource_dbx500_prcmu);
-}
-
-#endif
-
 static int __init clksrc_dbx500_prcmu_init(struct device_node *node)
 {
 	clksrc_dbx500_timer_base = of_iomap(node, 0);
@@ -81,9 +66,6 @@ static int __init clksrc_dbx500_prcmu_init(struct device_node *node)
 		writel(TIMER_DOWNCOUNT_VAL,
 		       clksrc_dbx500_timer_base + PRCMU_TIMER_REF);
 	}
-#ifdef CONFIG_CLKSRC_DBX500_PRCMU_SCHED_CLOCK
-	sched_clock_register(dbx500_prcmu_sched_clock_read, 32, RATE_32K);
-#endif
 	return clocksource_register_hz(&clocksource_dbx500_prcmu, RATE_32K);
 }
 TIMER_OF_DECLARE(dbx500_prcmu, "stericsson,db8500-prcmu-timer-4",
diff --git a/drivers/clocksource/nomadik-mtu.c b/drivers/clocksource/nomadik-mtu.c
index 8e4ddb9420c6..19b336c9b417 100644
--- a/drivers/clocksource/nomadik-mtu.c
+++ b/drivers/clocksource/nomadik-mtu.c
@@ -69,7 +69,6 @@ static u32 clk_prescale;
 static u32 nmdk_cycle;		/* write-once */
 static struct delay_timer mtu_delay_timer;
 
-#ifdef CONFIG_CLKSRC_NOMADIK_MTU_SCHED_CLOCK
 /*
  * Override the global weak sched_clock symbol with this
  * local implementation which uses the clocksource to get some
@@ -82,7 +81,6 @@ static u64 notrace nomadik_read_sched_clock(void)
 
 	return -readl(mtu_base + MTU_VAL(0));
 }
-#endif
 
 static unsigned long nmdk_timer_read_current_timer(void)
 {
@@ -234,9 +232,7 @@ static int __init nmdk_timer_init(void __iomem *base, int irq,
 		return ret;
 	}
 
-#ifdef CONFIG_CLKSRC_NOMADIK_MTU_SCHED_CLOCK
 	sched_clock_register(nomadik_read_sched_clock, 32, rate);
-#endif
 
 	/* Timer 1 is used for events, register irq and clockevents */
 	setup_irq(irq, &nmdk_timer_irq);
-- 
2.17.2


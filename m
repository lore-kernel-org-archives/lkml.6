Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB025C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD2C52147A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548692491;
	bh=37Atml5kr5sCKKy2kOYCFqFN9G20jwjjGNLR4/3ZFjU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pzPDyVBQ3GBP8qLnd8n4/OL3v3IEetDsIqQ616ZNKCZ+4uA31ciB/cKBwqMgx3mPO
	 O59jZx0RaIZb9rqQ49iMeqGrOpoK+qiYWp2terMoiKBi1GsomGiqOY3r2SrD9JQ9jH
	 3JeEqWP42lpvWdJFTrQujGSg3RALaMOMqUhRvG5c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389029AbfA1QV3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:21:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:57242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388573AbfA1QV2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:21:28 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 312872147A;
        Mon, 28 Jan 2019 16:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548692487;
        bh=37Atml5kr5sCKKy2kOYCFqFN9G20jwjjGNLR4/3ZFjU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hS8hmKyD2UFPzbGuJ5OD1MU7BiaR0jNmMhh07XfGZk851b7wRfdunHyIwizd/AbZm
         AsrwiI4CNGx96tesltVU2FQVUYwp5apnJRDQmwFQOLLg1gkSKivIDrDcS7ppZHM6or
         xdS4kothTkQxn1Rb+9piAwYmjABkpC3o8HF+btd0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Lubomir Rintel <lkundrak@v3.sk>, Olof Johansson <olof@lixom.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 036/107] ARM: mmp/mmp2: dt: enable the clock
Date:   Mon, 28 Jan 2019 11:18:36 -0500
Message-Id: <20190128161947.57405-36-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128161947.57405-1-sashal@kernel.org>
References: <20190128161947.57405-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lubomir Rintel <lkundrak@v3.sk>

[ Upstream commit f36797ee43802b367e59f0f9a9805304a4ff0c98 ]

The device-tree booted MMP2 needs to enable the timer clock, otherwise
it would stop ticking when the boot finishes.

It can also use the clock rate from the clk, the non-DT boards need to
keep using the hardcoded rates.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Acked-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Olof Johansson <olof@lixom.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/mach-mmp/common.h |  2 +-
 arch/arm/mach-mmp/mmp2.c   |  2 +-
 arch/arm/mach-mmp/pxa168.c |  2 +-
 arch/arm/mach-mmp/time.c   | 32 ++++++++++++++++++++------------
 4 files changed, 23 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-mmp/common.h b/arch/arm/mach-mmp/common.h
index 7453a90c34bd..9ffc0e4a87bf 100644
--- a/arch/arm/mach-mmp/common.h
+++ b/arch/arm/mach-mmp/common.h
@@ -1,7 +1,7 @@
 #include <linux/reboot.h>
 #define ARRAY_AND_SIZE(x)	(x), ARRAY_SIZE(x)
 
-extern void timer_init(int irq);
+extern void timer_init(int irq, unsigned long rate);
 
 extern void __init mmp_map_io(void);
 extern void mmp_restart(enum reboot_mode, const char *);
diff --git a/arch/arm/mach-mmp/mmp2.c b/arch/arm/mach-mmp/mmp2.c
index afba5460cdaf..fb3e7e32c882 100644
--- a/arch/arm/mach-mmp/mmp2.c
+++ b/arch/arm/mach-mmp/mmp2.c
@@ -134,7 +134,7 @@ void __init mmp2_timer_init(void)
 	clk_rst = APBC_APBCLK | APBC_FNCLK | APBC_FNCLKSEL(1);
 	__raw_writel(clk_rst, APBC_TIMERS);
 
-	timer_init(IRQ_MMP2_TIMER1);
+	timer_init(IRQ_MMP2_TIMER1, 6500000);
 }
 
 /* on-chip devices */
diff --git a/arch/arm/mach-mmp/pxa168.c b/arch/arm/mach-mmp/pxa168.c
index 0f5f16fb8c66..77a358165a56 100644
--- a/arch/arm/mach-mmp/pxa168.c
+++ b/arch/arm/mach-mmp/pxa168.c
@@ -79,7 +79,7 @@ void __init pxa168_timer_init(void)
 	/* 3.25MHz, bus/functional clock enabled, release reset */
 	__raw_writel(TIMER_CLK_RST, APBC_TIMERS);
 
-	timer_init(IRQ_PXA168_TIMER1);
+	timer_init(IRQ_PXA168_TIMER1, 6500000);
 }
 
 void pxa168_clear_keypad_wakeup(void)
diff --git a/arch/arm/mach-mmp/time.c b/arch/arm/mach-mmp/time.c
index 3c2c92aaa0ae..5f849cb996c7 100644
--- a/arch/arm/mach-mmp/time.c
+++ b/arch/arm/mach-mmp/time.c
@@ -22,6 +22,7 @@
 #include <linux/kernel.h>
 #include <linux/interrupt.h>
 #include <linux/clockchips.h>
+#include <linux/clk.h>
 
 #include <linux/io.h>
 #include <linux/irq.h>
@@ -38,12 +39,6 @@
 #include "cputype.h"
 #include "clock.h"
 
-#ifdef CONFIG_CPU_MMP2
-#define MMP_CLOCK_FREQ		6500000
-#else
-#define MMP_CLOCK_FREQ		3250000
-#endif
-
 #define TIMERS_VIRT_BASE	TIMERS1_VIRT_BASE
 
 #define MAX_DELTA		(0xfffffffe)
@@ -189,19 +184,18 @@ static struct irqaction timer_irq = {
 	.dev_id		= &ckevt,
 };
 
-void __init timer_init(int irq)
+void __init timer_init(int irq, unsigned long rate)
 {
 	timer_config();
 
-	sched_clock_register(mmp_read_sched_clock, 32, MMP_CLOCK_FREQ);
+	sched_clock_register(mmp_read_sched_clock, 32, rate);
 
 	ckevt.cpumask = cpumask_of(0);
 
 	setup_irq(irq, &timer_irq);
 
-	clocksource_register_hz(&cksrc, MMP_CLOCK_FREQ);
-	clockevents_config_and_register(&ckevt, MMP_CLOCK_FREQ,
-					MIN_DELTA, MAX_DELTA);
+	clocksource_register_hz(&cksrc, rate);
+	clockevents_config_and_register(&ckevt, rate, MIN_DELTA, MAX_DELTA);
 }
 
 #ifdef CONFIG_OF
@@ -213,7 +207,9 @@ static const struct of_device_id mmp_timer_dt_ids[] = {
 void __init mmp_dt_init_timer(void)
 {
 	struct device_node *np;
+	struct clk *clk;
 	int irq, ret;
+	unsigned long rate;
 
 	np = of_find_matching_node(NULL, mmp_timer_dt_ids);
 	if (!np) {
@@ -221,6 +217,18 @@ void __init mmp_dt_init_timer(void)
 		goto out;
 	}
 
+	clk = of_clk_get(np, 0);
+	if (!IS_ERR(clk)) {
+		ret = clk_prepare_enable(clk);
+		if (ret)
+			goto out;
+		rate = clk_get_rate(clk) / 2;
+	} else if (cpu_is_pj4()) {
+		rate = 6500000;
+	} else {
+		rate = 3250000;
+	}
+
 	irq = irq_of_parse_and_map(np, 0);
 	if (!irq) {
 		ret = -EINVAL;
@@ -231,7 +239,7 @@ void __init mmp_dt_init_timer(void)
 		ret = -ENOMEM;
 		goto out;
 	}
-	timer_init(irq);
+	timer_init(irq, rate);
 	return;
 out:
 	pr_err("Failed to get timer from device tree with error:%d\n", ret);
-- 
2.19.1


Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F8CC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D75A12084A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548692691;
	bh=bCKzqDoi5xXat0eK0Qz+EnV6k1M7Q9l+gVPCC3ZIu7E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lkAMZReaZ5NmUDKpFns+wuxwz2oXWGLZZ3OSTueczrc96xnuoXl9cJhP/4sATiTsx
	 AVJeR0dUkvwW09GS+IUZiRdLKC/HgsSV4J15MzqZh5iiA4wSErkHuqX0x4YRVWc/Wr
	 TO5YPhwVG516H8L1/6l6cjCw/KqjHTXooXkqwqeQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389795AbfA1QYu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:24:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:33382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389285AbfA1QYq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:24:46 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48F722084A;
        Mon, 28 Jan 2019 16:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548692684;
        bh=bCKzqDoi5xXat0eK0Qz+EnV6k1M7Q9l+gVPCC3ZIu7E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H+RXuUbJcgaWQxl1HgMf/ayWX2BFYpme3lmfGZqbXa7bpfOi7X02UIQ7W9Ax+p1xL
         64c7RZ+b/I0y4V8rFiV9bwJz/sPU+oTNLGdJhajecWAni6ypJqsynLf1bsTtxZjISf
         VINP+AsXQMXjGCtMgirc55pQ9FCZubrrXl4ae7Eo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Lubomir Rintel <lkundrak@v3.sk>, Olof Johansson <olof@lixom.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 26/80] ARM: mmp/mmp2: dt: enable the clock
Date:   Mon, 28 Jan 2019 11:23:07 -0500
Message-Id: <20190128162401.58841-26-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128162401.58841-1-sashal@kernel.org>
References: <20190128162401.58841-1-sashal@kernel.org>
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
index cf445bae6d77..69c7eec6d1e0 100644
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
index a70b5530bd42..90a0d8114af2 100644
--- a/arch/arm/mach-mmp/mmp2.c
+++ b/arch/arm/mach-mmp/mmp2.c
@@ -133,7 +133,7 @@ void __init mmp2_timer_init(void)
 	clk_rst = APBC_APBCLK | APBC_FNCLK | APBC_FNCLKSEL(1);
 	__raw_writel(clk_rst, APBC_TIMERS);
 
-	timer_init(IRQ_MMP2_TIMER1);
+	timer_init(IRQ_MMP2_TIMER1, 6500000);
 }
 
 /* on-chip devices */
diff --git a/arch/arm/mach-mmp/pxa168.c b/arch/arm/mach-mmp/pxa168.c
index 144e997624c0..5a616db7f392 100644
--- a/arch/arm/mach-mmp/pxa168.c
+++ b/arch/arm/mach-mmp/pxa168.c
@@ -78,7 +78,7 @@ void __init pxa168_timer_init(void)
 	/* 3.25MHz, bus/functional clock enabled, release reset */
 	__raw_writel(TIMER_CLK_RST, APBC_TIMERS);
 
-	timer_init(IRQ_PXA168_TIMER1);
+	timer_init(IRQ_PXA168_TIMER1, 6500000);
 }
 
 void pxa168_clear_keypad_wakeup(void)
diff --git a/arch/arm/mach-mmp/time.c b/arch/arm/mach-mmp/time.c
index dbc697b2fda1..7e7520a9eddb 100644
--- a/arch/arm/mach-mmp/time.c
+++ b/arch/arm/mach-mmp/time.c
@@ -22,6 +22,7 @@
 #include <linux/kernel.h>
 #include <linux/interrupt.h>
 #include <linux/clockchips.h>
+#include <linux/clk.h>
 
 #include <linux/io.h>
 #include <linux/irq.h>
@@ -39,12 +40,6 @@
 
 #include "clock.h"
 
-#ifdef CONFIG_CPU_MMP2
-#define MMP_CLOCK_FREQ		6500000
-#else
-#define MMP_CLOCK_FREQ		3250000
-#endif
-
 #define TIMERS_VIRT_BASE	TIMERS1_VIRT_BASE
 
 #define MAX_DELTA		(0xfffffffe)
@@ -190,19 +185,18 @@ static struct irqaction timer_irq = {
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
@@ -214,7 +208,9 @@ static const struct of_device_id mmp_timer_dt_ids[] = {
 void __init mmp_dt_init_timer(void)
 {
 	struct device_node *np;
+	struct clk *clk;
 	int irq, ret;
+	unsigned long rate;
 
 	np = of_find_matching_node(NULL, mmp_timer_dt_ids);
 	if (!np) {
@@ -222,6 +218,18 @@ void __init mmp_dt_init_timer(void)
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
@@ -232,7 +240,7 @@ void __init mmp_dt_init_timer(void)
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


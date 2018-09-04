Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F96EC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 12:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3514520659
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 12:47:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="TMrrbJGo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3514520659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbeIDRMS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 13:12:18 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35851 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbeIDRMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 13:12:18 -0400
Received: by mail-pg1-f196.google.com with SMTP id d1-v6so1630147pgo.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 05:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jBpIWSgBkjREW9nerVWH2meQAGwlPcHIWyDg/ffT3BU=;
        b=TMrrbJGowI7/SEsKAUSIGyd+3aOr0CeokijFEo+SeP2Y2KyJlD9WQ8RZRpevCqB1sJ
         ebPRHO22NcTXiGQRhPAHZS9iBuIojJT00D6MYyVzXK76i/1acH/jF6cm89DYox+tbnMJ
         z0KKkCG5LQwjHMvk+AbYAthkEhwZWyVtFZ/GNC/Wbd11UutCyeJKAyot1wA+vxI1/niQ
         WSUDEVF9j49P6GdYg555eqUazwSXO7eZwZ0IPcaPrwXjJq5+Y/ynTCPJsme8XgVJLAXD
         l4KgOupVCUpMZri7Qlx8hpVJklaG6jlWQb6W5Z93BS01ADYnT3LniZJIwSrdUV48m9bH
         6y1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jBpIWSgBkjREW9nerVWH2meQAGwlPcHIWyDg/ffT3BU=;
        b=Rzhovwp7KdUtT7ZlzUNAxcgu0+f+rs8+4mU10+0vTxtk22IfHQRfGRSE3xcCd+2nEh
         2fD+VFnHI9EiYt+1pZnijgJhqGECphLpQO9IGUknIlziX9Rppda+lHsbr0399ZuF/zv+
         p/Xp7lbSxFqgvE4Vlfq6RPtUXOiUnIERwuQWd5ody0c92dxEWUn4M6luw4qE4NMFcN6u
         1mbjydhiC7Vcw1aM0MJ7ECcrXbNQH/ne95iCVRN80qtg9Ll3JGQeopL98otQGLXqEwN+
         rgCMhk2KcNFliba0Y/Ej9JHW4hAWnvRiG96XCil/bv3uDyMgAPFyoY2WjrPNsj2lB249
         Bbog==
X-Gm-Message-State: APzg51A06rKi7mN8g4PiC5gOnQtUymUWi6jw+JfiIPWG7lMn/nME3xrT
        1w+t4eQ4Ovvd0bVj6nx2pyqV/Q==
X-Google-Smtp-Source: ANB0VdY69vu2gKwZwL21yR1SXziYavShuQ0Y07oihHg1PAPhmi73dinn5wjeJCxxH44C8bnbMKmQwQ==
X-Received: by 2002:a65:6413:: with SMTP id a19-v6mr23166203pgv.359.1536065238154;
        Tue, 04 Sep 2018 05:47:18 -0700 (PDT)
Received: from anup-ubuntu64.wlan.qualcomm.com ([106.51.30.16])
        by smtp.googlemail.com with ESMTPSA id p11-v6sm31621773pfj.72.2018.09.04.05.47.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 05:47:17 -0700 (PDT)
From:   Anup Patel <anup@brainfault.org>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <anup@brainfault.org>
Subject: [RFC PATCH 5/5] clocksource: riscv_timer: Make timer interrupt as a per-CPU interrupt
Date:   Tue,  4 Sep 2018 18:15:14 +0530
Message-Id: <20180904124514.6290-6-anup@brainfault.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180904124514.6290-1-anup@brainfault.org>
References: <20180904124514.6290-1-anup@brainfault.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of directly calling RISC-V timer interrupt handler from
RISC-V local interrupt conntroller driver, this patch implements
RISC-V timer interrupt as a per-CPU interrupt using per-CPU APIs
of Linux IRQ subsystem.

Signed-off-by: Anup Patel <anup@brainfault.org>
---
 arch/riscv/include/asm/irq.h      |  2 -
 drivers/clocksource/riscv_timer.c | 76 +++++++++++++++++++++++++------
 drivers/irqchip/irq-riscv-intc.c  |  8 ----
 3 files changed, 62 insertions(+), 24 deletions(-)

diff --git a/arch/riscv/include/asm/irq.h b/arch/riscv/include/asm/irq.h
index fe503d71876a..7ff3751e7816 100644
--- a/arch/riscv/include/asm/irq.h
+++ b/arch/riscv/include/asm/irq.h
@@ -30,8 +30,6 @@
  */
 #define INTERRUPT_CAUSE_FLAG	(1UL << (__riscv_xlen - 1))
 
-void riscv_timer_interrupt(void);
-
 #include <asm-generic/irq.h>
 
 #endif /* _ASM_RISCV_IRQ_H */
diff --git a/drivers/clocksource/riscv_timer.c b/drivers/clocksource/riscv_timer.c
index 4e8b347e43e2..c7ac60a82754 100644
--- a/drivers/clocksource/riscv_timer.c
+++ b/drivers/clocksource/riscv_timer.c
@@ -3,11 +3,17 @@
  * Copyright (C) 2012 Regents of the University of California
  * Copyright (C) 2017 SiFive
  */
+#define pr_fmt(fmt) "riscv-timer: " fmt
 #include <linux/clocksource.h>
 #include <linux/clockchips.h>
 #include <linux/cpu.h>
 #include <linux/delay.h>
 #include <linux/irq.h>
+#include <linux/irqdomain.h>
+#include <linux/interrupt.h>
+#include <linux/of.h>
+#include <linux/of_irq.h>
+#include <linux/sched_clock.h>
 #include <asm/sbi.h>
 
 /*
@@ -31,6 +37,7 @@ static int riscv_clock_next_event(unsigned long delta,
 	return 0;
 }
 
+static unsigned int riscv_clock_event_irq;
 static DEFINE_PER_CPU(struct clock_event_device, riscv_clock_event) = {
 	.name			= "riscv_timer_clockevent",
 	.features		= CLOCK_EVT_FEAT_ONESHOT,
@@ -38,6 +45,11 @@ static DEFINE_PER_CPU(struct clock_event_device, riscv_clock_event) = {
 	.set_next_event		= riscv_clock_next_event,
 };
 
+static u64 riscv_sched_clock(void)
+{
+	return get_cycles64();
+}
+
 /*
  * It is guaranteed that all the timers across all the harts are synchronized
  * within one tick of each other, so while this could technically go
@@ -48,7 +60,7 @@ static unsigned long long riscv_clocksource_rdtime(struct clocksource *cs)
 	return get_cycles64();
 }
 
-static DEFINE_PER_CPU(struct clocksource, riscv_clocksource) = {
+static struct clocksource riscv_clocksource = {
 	.name		= "riscv_clocksource",
 	.rating		= 300,
 	.mask		= CLOCKSOURCE_MASK(BITS_PER_LONG),
@@ -61,45 +73,81 @@ static int riscv_timer_starting_cpu(unsigned int cpu)
 	struct clock_event_device *ce = per_cpu_ptr(&riscv_clock_event, cpu);
 
 	ce->cpumask = cpumask_of(cpu);
+	ce->irq = riscv_clock_event_irq;
 	clockevents_config_and_register(ce, riscv_timebase, 100, 0x7fffffff);
 
-	csr_set(sie, SIE_STIE);
+	enable_percpu_irq(riscv_clock_event_irq, IRQ_TYPE_NONE);
 	return 0;
 }
 
 static int riscv_timer_dying_cpu(unsigned int cpu)
 {
-	csr_clear(sie, SIE_STIE);
+	disable_percpu_irq(riscv_clock_event_irq);
 	return 0;
 }
 
-/* called directly from the low-level interrupt handler */
-void riscv_timer_interrupt(void)
+static irqreturn_t riscv_timer_interrupt(int irq, void *dev_id)
 {
 	struct clock_event_device *evdev = this_cpu_ptr(&riscv_clock_event);
 
 	csr_clear(sie, SIE_STIE);
 	evdev->event_handler(evdev);
+
+	return IRQ_HANDLED;
 }
 
 static int __init riscv_timer_init_dt(struct device_node *n)
 {
-	int cpu_id = riscv_of_processor_hart(n), error;
-	struct clocksource *cs;
-
-	if (cpu_id != smp_processor_id())
+	int error;
+	struct irq_domain *domain;
+	struct of_phandle_args oirq;
+
+	/*
+	 * Either we have one INTC DT node under each CPU DT node
+	 * or a single system wide INTC DT node. Irrespective to
+	 * number of INTC DT nodes, we only proceed if we are able
+	 * to find irq_domain of INTC.
+	 *
+	 * Once we have INTC irq_domain, we create mapping for timer
+	 * interrupt HWIRQ and request_percpu_irq() on it.
+	 */
+
+	if (riscv_clock_event_irq)
 		return 0;
 
-	cs = per_cpu_ptr(&riscv_clocksource, cpu_id);
-	clocksource_register_hz(cs, riscv_timebase);
+	oirq.np = n;
+	oirq.args_count = 1;
+	oirq.args[0] = INTERRUPT_CAUSE_TIMER;
+
+	domain = irq_find_host(oirq.np);
+	if (!domain)
+		return -ENODEV;
+
+	riscv_clock_event_irq = irq_create_of_mapping(&oirq);
+	if (!riscv_clock_event_irq)
+		return -ENODEV;
+
+	clocksource_register_hz(&riscv_clocksource, riscv_timebase);
+	sched_clock_register(riscv_sched_clock,
+			     BITS_PER_LONG, riscv_timebase);
+
+	error = request_percpu_irq(riscv_clock_event_irq,
+				   riscv_timer_interrupt,
+				   "riscv_timer", &riscv_clock_event);
+	if (error)
+		return error;
 
 	error = cpuhp_setup_state(CPUHP_AP_RISCV_TIMER_STARTING,
 			 "clockevents/riscv/timer:starting",
 			 riscv_timer_starting_cpu, riscv_timer_dying_cpu);
 	if (error)
-		pr_err("RISCV timer register failed [%d] for cpu = [%d]\n",
-		       error, cpu_id);
+		pr_err("RISCV timer register failed error %d\n", error);
+
+	pr_info("running at %lu.%02luMHz frequency\n",
+		(unsigned long)riscv_timebase / 1000000,
+		(unsigned long)(riscv_timebase / 10000) % 100);
+
 	return error;
 }
 
-TIMER_OF_DECLARE(riscv_timer, "riscv", riscv_timer_init_dt);
+TIMER_OF_DECLARE(riscv_timer, "riscv,cpu-intc", riscv_timer_init_dt);
diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv-intc.c
index c80502a1e12b..f40827a27227 100644
--- a/drivers/irqchip/irq-riscv-intc.c
+++ b/drivers/irqchip/irq-riscv-intc.c
@@ -22,20 +22,12 @@ static atomic_t intc_init = ATOMIC_INIT(0);
 
 static void riscv_intc_irq(struct pt_regs *regs)
 {
-	struct pt_regs *old_regs;
 	unsigned long cause = regs->scause & ~INTERRUPT_CAUSE_FLAG;
 
 	if (unlikely(cause >= BITS_PER_LONG))
 		panic("unexpected interrupt cause");
 
 	switch (cause) {
-	case INTERRUPT_CAUSE_TIMER:
-		old_regs = set_irq_regs(regs);
-		irq_enter();
-		riscv_timer_interrupt();
-		irq_exit();
-		set_irq_regs(old_regs);
-		break;
 #ifdef CONFIG_SMP
 	case INTERRUPT_CAUSE_SOFTWARE:
 		/*
-- 
2.17.1


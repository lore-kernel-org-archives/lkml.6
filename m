Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 323A6C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 21:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACD0122394
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 21:48:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="S9QHYZe2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACD0122394
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbeHJAPh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 20:15:37 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:44156 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727320AbeHJAPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 20:15:36 -0400
From:   Paul Cercueil <paul@crapouillou.net>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Lee Jones <lee.jones@linaro.org>,
        Mathieu Malaterre <malat@debian.org>,
        Ezequiel Garcia <ezequiel@collabora.co.uk>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-mips@linux-mips.org, linux-doc@vger.kernel.org,
        linux-clk@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v6 24/24] MIPS: jz4740: Drop obsolete code
Date:   Thu,  9 Aug 2018 23:48:41 +0200
Message-Id: <20180809214841.21566-1-paul@crapouillou.net>
In-Reply-To: <20180809214414.20905-1-paul@crapouillou.net>
References: <20180809214414.20905-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1533851328; bh=LPFh4r+HBRuZ/YXnvNJCatCnvMA8FjkGji5TkRLeZkc=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=S9QHYZe2/99xK98RghesFbFBWjdlbUHIVGBrdKZuPXtStYIBgIkGdk+gLPkn2lwPttKyhrDXuB1ofkMT40QUikl4MJSbhJ+FLuzEEV6a4OJqioFIS0UJbjFQH5vQ+EYHUmrM7u6WNc404SDonEiqF1AwNE09AEe7AN26xN4vK7M=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The old clocksource/timer platform code is now obsoleted by the newly
introduced ingenic-timer and ingenic-ost drivers.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 arch/mips/include/asm/mach-jz4740/platform.h |   1 -
 arch/mips/include/asm/mach-jz4740/timer.h    | 135 --------------------
 arch/mips/jz4740/Makefile                    |   3 +-
 arch/mips/jz4740/platform.c                  |   6 -
 arch/mips/jz4740/setup.c                     |   8 ++
 arch/mips/jz4740/time.c                      | 176 ---------------------------
 arch/mips/jz4740/timer.c                     |  51 --------
 7 files changed, 9 insertions(+), 371 deletions(-)
 delete mode 100644 arch/mips/include/asm/mach-jz4740/timer.h
 delete mode 100644 arch/mips/jz4740/time.c
 delete mode 100644 arch/mips/jz4740/timer.c

 v5: New patch

 v6: No change

diff --git a/arch/mips/include/asm/mach-jz4740/platform.h b/arch/mips/include/asm/mach-jz4740/platform.h
index c0c932ac72a7..cd464d956882 100644
--- a/arch/mips/include/asm/mach-jz4740/platform.h
+++ b/arch/mips/include/asm/mach-jz4740/platform.h
@@ -29,7 +29,6 @@ extern struct platform_device jz4740_i2s_device;
 extern struct platform_device jz4740_pcm_device;
 extern struct platform_device jz4740_codec_device;
 extern struct platform_device jz4740_adc_device;
-extern struct platform_device jz4740_pwm_device;
 extern struct platform_device jz4740_dma_device;
 
 #endif
diff --git a/arch/mips/include/asm/mach-jz4740/timer.h b/arch/mips/include/asm/mach-jz4740/timer.h
deleted file mode 100644
index 8750a1d04e22..000000000000
--- a/arch/mips/include/asm/mach-jz4740/timer.h
+++ /dev/null
@@ -1,135 +0,0 @@
-/*
- *  Copyright (C) 2010, Lars-Peter Clausen <lars@metafoo.de>
- *  JZ4740 platform timer support
- *
- *  This program is free software; you can redistribute it and/or modify it
- *  under  the terms of the GNU General	 Public License as published by the
- *  Free Software Foundation;  either version 2 of the License, or (at your
- *  option) any later version.
- *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- *
- */
-
-#ifndef __ASM_MACH_JZ4740_TIMER
-#define __ASM_MACH_JZ4740_TIMER
-
-#define JZ_REG_TIMER_STOP		0x0C
-#define JZ_REG_TIMER_STOP_SET		0x1C
-#define JZ_REG_TIMER_STOP_CLEAR		0x2C
-#define JZ_REG_TIMER_ENABLE		0x00
-#define JZ_REG_TIMER_ENABLE_SET		0x04
-#define JZ_REG_TIMER_ENABLE_CLEAR	0x08
-#define JZ_REG_TIMER_FLAG		0x10
-#define JZ_REG_TIMER_FLAG_SET		0x14
-#define JZ_REG_TIMER_FLAG_CLEAR		0x18
-#define JZ_REG_TIMER_MASK		0x20
-#define JZ_REG_TIMER_MASK_SET		0x24
-#define JZ_REG_TIMER_MASK_CLEAR		0x28
-
-#define JZ_REG_TIMER_DFR(x) (((x) * 0x10) + 0x30)
-#define JZ_REG_TIMER_DHR(x) (((x) * 0x10) + 0x34)
-#define JZ_REG_TIMER_CNT(x) (((x) * 0x10) + 0x38)
-#define JZ_REG_TIMER_CTRL(x) (((x) * 0x10) + 0x3C)
-
-#define JZ_TIMER_IRQ_HALF(x) BIT((x) + 0x10)
-#define JZ_TIMER_IRQ_FULL(x) BIT(x)
-
-#define JZ_TIMER_CTRL_PWM_ABBRUPT_SHUTDOWN	BIT(9)
-#define JZ_TIMER_CTRL_PWM_ACTIVE_LOW		BIT(8)
-#define JZ_TIMER_CTRL_PWM_ENABLE		BIT(7)
-#define JZ_TIMER_CTRL_PRESCALE_MASK		0x1c
-#define JZ_TIMER_CTRL_PRESCALE_OFFSET		0x3
-#define JZ_TIMER_CTRL_PRESCALE_1		(0 << 3)
-#define JZ_TIMER_CTRL_PRESCALE_4		(1 << 3)
-#define JZ_TIMER_CTRL_PRESCALE_16		(2 << 3)
-#define JZ_TIMER_CTRL_PRESCALE_64		(3 << 3)
-#define JZ_TIMER_CTRL_PRESCALE_256		(4 << 3)
-#define JZ_TIMER_CTRL_PRESCALE_1024		(5 << 3)
-
-#define JZ_TIMER_CTRL_PRESCALER(x) ((x) << JZ_TIMER_CTRL_PRESCALE_OFFSET)
-
-#define JZ_TIMER_CTRL_SRC_EXT		BIT(2)
-#define JZ_TIMER_CTRL_SRC_RTC		BIT(1)
-#define JZ_TIMER_CTRL_SRC_PCLK		BIT(0)
-
-extern void __iomem *jz4740_timer_base;
-void __init jz4740_timer_init(void);
-
-void jz4740_timer_enable_watchdog(void);
-void jz4740_timer_disable_watchdog(void);
-
-static inline void jz4740_timer_stop(unsigned int timer)
-{
-	writel(BIT(timer), jz4740_timer_base + JZ_REG_TIMER_STOP_SET);
-}
-
-static inline void jz4740_timer_start(unsigned int timer)
-{
-	writel(BIT(timer), jz4740_timer_base + JZ_REG_TIMER_STOP_CLEAR);
-}
-
-static inline bool jz4740_timer_is_enabled(unsigned int timer)
-{
-	return readb(jz4740_timer_base + JZ_REG_TIMER_ENABLE) & BIT(timer);
-}
-
-static inline void jz4740_timer_enable(unsigned int timer)
-{
-	writeb(BIT(timer), jz4740_timer_base + JZ_REG_TIMER_ENABLE_SET);
-}
-
-static inline void jz4740_timer_disable(unsigned int timer)
-{
-	writeb(BIT(timer), jz4740_timer_base + JZ_REG_TIMER_ENABLE_CLEAR);
-}
-
-static inline void jz4740_timer_set_period(unsigned int timer, uint16_t period)
-{
-	writew(period, jz4740_timer_base + JZ_REG_TIMER_DFR(timer));
-}
-
-static inline void jz4740_timer_set_duty(unsigned int timer, uint16_t duty)
-{
-	writew(duty, jz4740_timer_base + JZ_REG_TIMER_DHR(timer));
-}
-
-static inline void jz4740_timer_set_count(unsigned int timer, uint16_t count)
-{
-	writew(count, jz4740_timer_base + JZ_REG_TIMER_CNT(timer));
-}
-
-static inline uint16_t jz4740_timer_get_count(unsigned int timer)
-{
-	return readw(jz4740_timer_base + JZ_REG_TIMER_CNT(timer));
-}
-
-static inline void jz4740_timer_ack_full(unsigned int timer)
-{
-	writel(JZ_TIMER_IRQ_FULL(timer), jz4740_timer_base + JZ_REG_TIMER_FLAG_CLEAR);
-}
-
-static inline void jz4740_timer_irq_full_enable(unsigned int timer)
-{
-	writel(JZ_TIMER_IRQ_FULL(timer), jz4740_timer_base + JZ_REG_TIMER_FLAG_CLEAR);
-	writel(JZ_TIMER_IRQ_FULL(timer), jz4740_timer_base + JZ_REG_TIMER_MASK_CLEAR);
-}
-
-static inline void jz4740_timer_irq_full_disable(unsigned int timer)
-{
-	writel(JZ_TIMER_IRQ_FULL(timer), jz4740_timer_base + JZ_REG_TIMER_MASK_SET);
-}
-
-static inline void jz4740_timer_set_ctrl(unsigned int timer, uint16_t ctrl)
-{
-	writew(ctrl, jz4740_timer_base + JZ_REG_TIMER_CTRL(timer));
-}
-
-static inline uint16_t jz4740_timer_get_ctrl(unsigned int timer)
-{
-	return readw(jz4740_timer_base + JZ_REG_TIMER_CTRL(timer));
-}
-
-#endif
diff --git a/arch/mips/jz4740/Makefile b/arch/mips/jz4740/Makefile
index 88d6aa7d000b..72eb805028a4 100644
--- a/arch/mips/jz4740/Makefile
+++ b/arch/mips/jz4740/Makefile
@@ -5,8 +5,7 @@
 
 # Object file lists.
 
-obj-y += prom.o time.o reset.o setup.o \
-	platform.o timer.o
+obj-y += prom.o reset.o setup.o platform.o
 
 CFLAGS_setup.o = -I$(src)/../../../scripts/dtc/libfdt
 
diff --git a/arch/mips/jz4740/platform.c b/arch/mips/jz4740/platform.c
index cbc5f8e87230..af0ecaeb4931 100644
--- a/arch/mips/jz4740/platform.c
+++ b/arch/mips/jz4740/platform.c
@@ -233,12 +233,6 @@ struct platform_device jz4740_adc_device = {
 	.resource	= jz4740_adc_resources,
 };
 
-/* PWM */
-struct platform_device jz4740_pwm_device = {
-	.name = "jz4740-pwm",
-	.id   = -1,
-};
-
 /* DMA */
 static struct resource jz4740_dma_resources[] = {
 	{
diff --git a/arch/mips/jz4740/setup.c b/arch/mips/jz4740/setup.c
index afb40f8bce96..099e4164afff 100644
--- a/arch/mips/jz4740/setup.c
+++ b/arch/mips/jz4740/setup.c
@@ -14,6 +14,8 @@
  *
  */
 
+#include <linux/clk-provider.h>
+#include <linux/clocksource.h>
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/irqchip.h>
@@ -101,3 +103,9 @@ void __init arch_init_irq(void)
 {
 	irqchip_init();
 }
+
+void __init plat_time_init(void)
+{
+	of_clk_init(NULL);
+	timer_probe();
+}
diff --git a/arch/mips/jz4740/time.c b/arch/mips/jz4740/time.c
deleted file mode 100644
index 2ca9160f642a..000000000000
--- a/arch/mips/jz4740/time.c
+++ /dev/null
@@ -1,176 +0,0 @@
-/*
- *  Copyright (C) 2010, Lars-Peter Clausen <lars@metafoo.de>
- *  JZ4740 platform time support
- *
- *  This program is free software; you can redistribute it and/or modify it
- *  under  the terms of the GNU General	 Public License as published by the
- *  Free Software Foundation;  either version 2 of the License, or (at your
- *  option) any later version.
- *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- *
- */
-
-#include <linux/clk.h>
-#include <linux/clk-provider.h>
-#include <linux/interrupt.h>
-#include <linux/kernel.h>
-#include <linux/time.h>
-
-#include <linux/clockchips.h>
-#include <linux/sched_clock.h>
-
-#include <asm/mach-jz4740/clock.h>
-#include <asm/mach-jz4740/irq.h>
-#include <asm/mach-jz4740/timer.h>
-#include <asm/time.h>
-
-#include "clock.h"
-
-#define TIMER_CLOCKEVENT 0
-#define TIMER_CLOCKSOURCE 1
-
-static uint16_t jz4740_jiffies_per_tick;
-
-static u64 jz4740_clocksource_read(struct clocksource *cs)
-{
-	return jz4740_timer_get_count(TIMER_CLOCKSOURCE);
-}
-
-static struct clocksource jz4740_clocksource = {
-	.name = "jz4740-timer",
-	.rating = 200,
-	.read = jz4740_clocksource_read,
-	.mask = CLOCKSOURCE_MASK(16),
-	.flags = CLOCK_SOURCE_IS_CONTINUOUS,
-};
-
-static u64 notrace jz4740_read_sched_clock(void)
-{
-	return jz4740_timer_get_count(TIMER_CLOCKSOURCE);
-}
-
-static irqreturn_t jz4740_clockevent_irq(int irq, void *devid)
-{
-	struct clock_event_device *cd = devid;
-
-	jz4740_timer_ack_full(TIMER_CLOCKEVENT);
-
-	if (!clockevent_state_periodic(cd))
-		jz4740_timer_disable(TIMER_CLOCKEVENT);
-
-	cd->event_handler(cd);
-
-	return IRQ_HANDLED;
-}
-
-static int jz4740_clockevent_set_periodic(struct clock_event_device *evt)
-{
-	jz4740_timer_set_count(TIMER_CLOCKEVENT, 0);
-	jz4740_timer_set_period(TIMER_CLOCKEVENT, jz4740_jiffies_per_tick);
-	jz4740_timer_irq_full_enable(TIMER_CLOCKEVENT);
-	jz4740_timer_enable(TIMER_CLOCKEVENT);
-
-	return 0;
-}
-
-static int jz4740_clockevent_resume(struct clock_event_device *evt)
-{
-	jz4740_timer_irq_full_enable(TIMER_CLOCKEVENT);
-	jz4740_timer_enable(TIMER_CLOCKEVENT);
-
-	return 0;
-}
-
-static int jz4740_clockevent_shutdown(struct clock_event_device *evt)
-{
-	jz4740_timer_disable(TIMER_CLOCKEVENT);
-
-	return 0;
-}
-
-static int jz4740_clockevent_set_next(unsigned long evt,
-	struct clock_event_device *cd)
-{
-	jz4740_timer_set_count(TIMER_CLOCKEVENT, 0);
-	jz4740_timer_set_period(TIMER_CLOCKEVENT, evt);
-	jz4740_timer_enable(TIMER_CLOCKEVENT);
-
-	return 0;
-}
-
-static struct clock_event_device jz4740_clockevent = {
-	.name = "jz4740-timer",
-	.features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
-	.set_next_event = jz4740_clockevent_set_next,
-	.set_state_shutdown = jz4740_clockevent_shutdown,
-	.set_state_periodic = jz4740_clockevent_set_periodic,
-	.set_state_oneshot = jz4740_clockevent_shutdown,
-	.tick_resume = jz4740_clockevent_resume,
-	.rating = 200,
-#ifdef CONFIG_MACH_JZ4740
-	.irq = JZ4740_IRQ_TCU0,
-#endif
-#if defined(CONFIG_MACH_JZ4770) || defined(CONFIG_MACH_JZ4780)
-	.irq = JZ4780_IRQ_TCU2,
-#endif
-};
-
-static struct irqaction timer_irqaction = {
-	.handler	= jz4740_clockevent_irq,
-	.flags		= IRQF_PERCPU | IRQF_TIMER,
-	.name		= "jz4740-timerirq",
-	.dev_id		= &jz4740_clockevent,
-};
-
-void __init plat_time_init(void)
-{
-	int ret;
-	uint32_t clk_rate;
-	uint16_t ctrl;
-	struct clk *ext_clk;
-
-	of_clk_init(NULL);
-	jz4740_timer_init();
-
-	ext_clk = clk_get(NULL, "ext");
-	if (IS_ERR(ext_clk))
-		panic("unable to get ext clock");
-	clk_rate = clk_get_rate(ext_clk) >> 4;
-	clk_put(ext_clk);
-
-	jz4740_jiffies_per_tick = DIV_ROUND_CLOSEST(clk_rate, HZ);
-
-	clockevent_set_clock(&jz4740_clockevent, clk_rate);
-	jz4740_clockevent.min_delta_ns = clockevent_delta2ns(100, &jz4740_clockevent);
-	jz4740_clockevent.min_delta_ticks = 100;
-	jz4740_clockevent.max_delta_ns = clockevent_delta2ns(0xffff, &jz4740_clockevent);
-	jz4740_clockevent.max_delta_ticks = 0xffff;
-	jz4740_clockevent.cpumask = cpumask_of(0);
-
-	clockevents_register_device(&jz4740_clockevent);
-
-	ret = clocksource_register_hz(&jz4740_clocksource, clk_rate);
-
-	if (ret)
-		printk(KERN_ERR "Failed to register clocksource: %d\n", ret);
-
-	sched_clock_register(jz4740_read_sched_clock, 16, clk_rate);
-
-	setup_irq(jz4740_clockevent.irq, &timer_irqaction);
-
-	ctrl = JZ_TIMER_CTRL_PRESCALE_16 | JZ_TIMER_CTRL_SRC_EXT;
-
-	jz4740_timer_set_ctrl(TIMER_CLOCKEVENT, ctrl);
-	jz4740_timer_set_ctrl(TIMER_CLOCKSOURCE, ctrl);
-
-	jz4740_timer_set_period(TIMER_CLOCKEVENT, jz4740_jiffies_per_tick);
-	jz4740_timer_irq_full_enable(TIMER_CLOCKEVENT);
-
-	jz4740_timer_set_period(TIMER_CLOCKSOURCE, 0xffff);
-
-	jz4740_timer_enable(TIMER_CLOCKEVENT);
-	jz4740_timer_enable(TIMER_CLOCKSOURCE);
-}
diff --git a/arch/mips/jz4740/timer.c b/arch/mips/jz4740/timer.c
deleted file mode 100644
index 777877feef71..000000000000
--- a/arch/mips/jz4740/timer.c
+++ /dev/null
@@ -1,51 +0,0 @@
-/*
- *  Copyright (C) 2010, Lars-Peter Clausen <lars@metafoo.de>
- *  JZ4740 platform timer support
- *
- *  This program is free software; you can redistribute it and/or modify it
- *  under  the terms of the GNU General	 Public License as published by the
- *  Free Software Foundation;  either version 2 of the License, or (at your
- *  option) any later version.
- *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- *
- */
-
-#include <linux/export.h>
-#include <linux/io.h>
-#include <linux/init.h>
-#include <linux/kernel.h>
-
-#include <asm/mach-jz4740/base.h>
-#include <asm/mach-jz4740/timer.h>
-
-void __iomem *jz4740_timer_base;
-EXPORT_SYMBOL_GPL(jz4740_timer_base);
-
-void jz4740_timer_enable_watchdog(void)
-{
-	writel(BIT(16), jz4740_timer_base + JZ_REG_TIMER_STOP_CLEAR);
-}
-EXPORT_SYMBOL_GPL(jz4740_timer_enable_watchdog);
-
-void jz4740_timer_disable_watchdog(void)
-{
-	writel(BIT(16), jz4740_timer_base + JZ_REG_TIMER_STOP_SET);
-}
-EXPORT_SYMBOL_GPL(jz4740_timer_disable_watchdog);
-
-void __init jz4740_timer_init(void)
-{
-	jz4740_timer_base = ioremap(JZ4740_TCU_BASE_ADDR, 0x100);
-
-	if (!jz4740_timer_base)
-		panic("Failed to ioremap timer registers");
-
-	/* Disable all timer clocks except for those used as system timers */
-	writel(0x000100fc, jz4740_timer_base + JZ_REG_TIMER_STOP_SET);
-
-	/* Timer irqs are unmasked by default, mask them */
-	writel(0x00ff00ff, jz4740_timer_base + JZ_REG_TIMER_MASK_SET);
-}
-- 
2.11.0


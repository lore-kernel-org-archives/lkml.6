Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B2EC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5356220872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:21:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="uC6pgdPK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388792AbfAKRV5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 12:21:57 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35170 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732510AbfAKRVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 12:21:55 -0500
Received: by mail-wm1-f68.google.com with SMTP id t200so3141007wmt.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 09:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QOlmAzT9VkWHBuMKcdHlAtoH6zcSrRq2fAobwtYxMi4=;
        b=uC6pgdPKBS8FYKKHHmyPtBc1aH1jyYY1+Nu+gOtJFIdu503PyiJskdXfAHdAtV+qj9
         +KcNrX4FinszBYRnudC4LXtpOaZuM0TjQ9aqoB5M6Ns5DyECRnsmvEWLt8zhNISS5kah
         E29mzInzWElzgnn862DCEP6c/usmfmlfJ3R/7omuJ1pXwGBtfJUQ+2PiTGDKP+YejIIZ
         BF0ZYOyLlC40zlfRmJ0XS2CHeSoHRrHe+kX8JHzcMqHXIOeKgFvPQr+2RAD24DTc6HpU
         ZDrLYdNeJaymotUgA5m41X6q5vHbSHEM4vz+9ut07WPHSkTipCFxjnWlM7C9qZjtnW19
         mdng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QOlmAzT9VkWHBuMKcdHlAtoH6zcSrRq2fAobwtYxMi4=;
        b=nHiX7S6GkKU1DL+2VT6x4ArzHqBqEARYX5yd7upEVNZb4gW3qf6+wKnTGH+/wWcbqb
         GUEzBY5nNvxnU6z2V3NjuNBvPf9u1oPL9iTlwAyPgKVvnJqx9U7/ukPS2wzzwfTmWu76
         OsknajyNLeTjkwIp1KHjhi5JctUWRGfg4fZr8rs0iMInSYccLgWNTyVQcyYjrGpQ39Ud
         i6+aK8MEMU2x5NxxM46J1aJV6gUsqcdryGL5IM4FW5Wi8d7sD7g+Gd1kp/4UDQs8hBbs
         GXIbTE61qNtDhp+m/CI5VzRhzd4WIwqHaeuLbDZ8mP3cOfavyiYJry/X08J+47svmwpG
         QltQ==
X-Gm-Message-State: AJcUukdIiOIhanoUdnsMq+ec0NMWa2MP/mbkUrgJ2MUgZO2w5kcCVaCK
        lXMkTGAD6rphlIG8fxUzKHvdlQ==
X-Google-Smtp-Source: ALg8bN5shK6Q7cii91LOXXsN2kDWDOgE0CtGb7BnC7hPwceiD+ixRs1S9FaPqdxlykx7U8g1lXD1hw==
X-Received: by 2002:a1c:578e:: with SMTP id l136mr2996733wmb.124.1547227312474;
        Fri, 11 Jan 2019 09:21:52 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id o16sm78534408wrn.11.2019.01.11.09.21.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Jan 2019 09:21:51 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 02/17] clocksource: davinci-timer: new driver
Date:   Fri, 11 Jan 2019 18:21:19 +0100
Message-Id: <20190111172134.30147-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190111172134.30147-1-brgl@bgdev.pl>
References: <20190111172134.30147-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Currently the clocksource and clockevent support for davinci platforms
lives in mach-davinci. It hard-codes many things, used global variables,
implements functionalities unused by any platform and has code fragments
scattered across many (often unrelated) files.

Implement a new, modern and simplified timer driver and put it into
drivers/clocksource. We still need to support legacy board files so
export a config structure and a function that allows machine code to
register the timer.

We don't check the return values of regmap reads and writes since with
mmio it's only likely to fail due to programmer's errors.

We also don't bother freeing resources on errors in
davinci_timer_register() as the system won't boot without a timer anyway.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/clocksource/Kconfig         |   5 +
 drivers/clocksource/Makefile        |   1 +
 drivers/clocksource/timer-davinci.c | 415 ++++++++++++++++++++++++++++
 include/clocksource/timer-davinci.h |  35 +++
 4 files changed, 456 insertions(+)
 create mode 100644 drivers/clocksource/timer-davinci.c
 create mode 100644 include/clocksource/timer-davinci.h

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index a9e26f6a81a1..36d222c3fa4a 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -42,6 +42,11 @@ config BCM_KONA_TIMER
 	help
 	  Enables the support for the BCM Kona mobile timer driver.
 
+config DAVINCI_TIMER
+	bool "Texas Instruments DaVinci timer driver"
+	help
+	  Enables the support for the TI DaVinci timer driver.
+
 config DIGICOLOR_TIMER
 	bool "Digicolor timer driver" if COMPILE_TEST
 	select CLKSRC_MMIO
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index cdd210ff89ea..1be97aa7a699 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_SH_TIMER_TMU)	+= sh_tmu.o
 obj-$(CONFIG_EM_TIMER_STI)	+= em_sti.o
 obj-$(CONFIG_CLKBLD_I8253)	+= i8253.o
 obj-$(CONFIG_CLKSRC_MMIO)	+= mmio.o
+obj-$(CONFIG_DAVINCI_TIMER)	+= timer-davinci.o
 obj-$(CONFIG_DIGICOLOR_TIMER)	+= timer-digicolor.o
 obj-$(CONFIG_OMAP_DM_TIMER)	+= timer-ti-dm.o
 obj-$(CONFIG_DW_APB_TIMER)	+= dw_apb_timer.o
diff --git a/drivers/clocksource/timer-davinci.c b/drivers/clocksource/timer-davinci.c
new file mode 100644
index 000000000000..7282a1fda80f
--- /dev/null
+++ b/drivers/clocksource/timer-davinci.c
@@ -0,0 +1,415 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * TI DaVinci clocksource driver
+ *
+ * Copyright (C) 2019 Texas Instruments
+ * Author: Bartosz Golaszewski <bgolaszewski@baylibre.com>
+ * (with some parts adopted from code by Kevin Hilman <khilman@baylibre.com>)
+ */
+
+#include <linux/clk.h>
+#include <linux/clockchips.h>
+#include <linux/clocksource.h>
+#include <linux/err.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/regmap.h>
+#include <linux/sched_clock.h>
+
+#include <clocksource/timer-davinci.h>
+
+#define DAVINCI_TIMER_REG_TIM12			0x10
+#define DAVINCI_TIMER_REG_TIM34			0x14
+#define DAVINCI_TIMER_REG_PRD12			0x18
+#define DAVINCI_TIMER_REG_PRD34			0x1c
+#define DAVINCI_TIMER_REG_TCR			0x20
+#define DAVINCI_TIMER_REG_TGCR			0x24
+
+#define DAVINCI_TIMER_TIMMODE_MASK		0x0000000c
+#define DAVINCI_TIMER_RESET_MASK		0x00000003
+#define DAVINCI_TIMER_TIMMODE_32BIT_UNCHAINED	0x00000004
+#define DAVINCI_TIMER_UNRESET			0x00000003
+
+/* Shift depends on timer. */
+#define DAVINCI_TIMER_ENAMODE_MASK		0x03
+#define DAVINCI_TIMER_ENAMODE_DISABLED		0x00
+#define DAVINCI_TIMER_ENAMODE_ONESHOT		0x01
+#define DAVINCI_TIMER_ENAMODE_PERIODIC		0x02
+
+#define DAVINCI_TIMER_ENAMODE_SHIFT_TIM12	6
+#define DAVINCI_TIMER_ENAMODE_SHIFT_TIM34	22
+
+#define DAVINCI_TIMER_MIN_DELTA			0x01
+#define DAVINCI_TIMER_MAX_DELTA			0xfffffffe
+
+#define DAVINCI_TIMER_CLKSRC_BITS		32
+
+enum {
+	DAVINCI_TIMER_MODE_DISABLED = 0,
+	DAVINCI_TIMER_MODE_ONESHOT,
+	DAVINCI_TIMER_MODE_PERIODIC,
+};
+
+struct davinci_timer_data;
+
+typedef void (*davinci_timer_set_period_func)(struct davinci_timer_data *,
+					      unsigned int period);
+
+struct davinci_timer_regs {
+	unsigned int tim_off;
+	unsigned int prd_off;
+	unsigned int enamode_shift;
+};
+
+struct davinci_timer_data {
+	const struct davinci_timer_regs *regs;
+	unsigned int mode;
+	struct regmap *map;
+	davinci_timer_set_period_func set_period;
+	unsigned int cmp_off;
+};
+
+struct davinci_timer_clockevent {
+	struct clock_event_device dev;
+	unsigned int tick_rate;
+	struct davinci_timer_data timer;
+};
+
+struct davinci_timer_clocksource {
+	struct clocksource dev;
+	struct davinci_timer_data timer;
+};
+
+static const struct regmap_config davinci_timer_regmap_config = {
+	.name			= "timer-davinci",
+	.reg_bits		= 32,
+	.reg_stride		= 4,
+	.val_bits		= 32,
+	.fast_io		= true,
+};
+
+static const struct davinci_timer_regs davinci_timer_tim12_regs = {
+	.tim_off		= DAVINCI_TIMER_REG_TIM12,
+	.prd_off		= DAVINCI_TIMER_REG_PRD12,
+	.enamode_shift		= DAVINCI_TIMER_ENAMODE_SHIFT_TIM12,
+};
+
+static const struct davinci_timer_regs davinci_timer_tim34_regs = {
+	.tim_off		= DAVINCI_TIMER_REG_TIM34,
+	.prd_off		= DAVINCI_TIMER_REG_PRD34,
+	.enamode_shift		= DAVINCI_TIMER_ENAMODE_SHIFT_TIM34,
+};
+
+/* Must be global for davinci_timer_read_sched_clock(). */
+static struct davinci_timer_data *davinci_timer_clksrc_timer;
+
+static struct davinci_timer_clockevent *
+to_davinci_timer_clockevent(struct clock_event_device *clockevent)
+{
+	return container_of(clockevent, struct davinci_timer_clockevent, dev);
+}
+
+static struct davinci_timer_clocksource *
+to_davinci_timer_clocksource(struct clocksource *clocksource)
+{
+	return container_of(clocksource, struct davinci_timer_clocksource, dev);
+}
+
+static void davinci_timer_set_period(struct davinci_timer_data *timer,
+				     unsigned int period)
+{
+	timer->set_period(timer, period);
+}
+
+static void davinci_timer_set_period_std(struct davinci_timer_data *timer,
+					 unsigned int period)
+{
+	const struct davinci_timer_regs *regs = timer->regs;
+	unsigned int enamode;
+
+	regmap_read(timer->map, DAVINCI_TIMER_REG_TCR, &enamode);
+
+	regmap_update_bits(timer->map, DAVINCI_TIMER_REG_TCR,
+			DAVINCI_TIMER_ENAMODE_MASK << regs->enamode_shift,
+			DAVINCI_TIMER_ENAMODE_DISABLED << regs->enamode_shift);
+
+	regmap_write(timer->map, regs->tim_off, 0x0);
+	regmap_write(timer->map, regs->prd_off, period);
+
+	if (timer->mode == DAVINCI_TIMER_MODE_ONESHOT)
+		enamode = DAVINCI_TIMER_ENAMODE_ONESHOT;
+	else if (timer->mode == DAVINCI_TIMER_MODE_PERIODIC)
+		enamode = DAVINCI_TIMER_ENAMODE_PERIODIC;
+
+	regmap_update_bits(timer->map, DAVINCI_TIMER_REG_TCR,
+			   DAVINCI_TIMER_ENAMODE_MASK << regs->enamode_shift,
+			   enamode << regs->enamode_shift);
+}
+
+static void davinci_timer_set_period_cmp(struct davinci_timer_data *timer,
+					 unsigned int period)
+{
+	const struct davinci_timer_regs *regs = timer->regs;
+	unsigned int curr_time;
+
+	regmap_read(timer->map, regs->tim_off, &curr_time);
+	regmap_write(timer->map, timer->cmp_off, curr_time + period);
+}
+
+static irqreturn_t davinci_timer_irq_timer(int irq, void *data)
+{
+	struct davinci_timer_clockevent *clockevent = data;
+
+	clockevent->dev.event_handler(&clockevent->dev);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t davinci_timer_irq_freerun(int irq, void *data)
+{
+	return IRQ_HANDLED;
+}
+
+static u64 notrace davinci_timer_read_sched_clock(void)
+{
+	struct davinci_timer_data *timer;
+	unsigned int val;
+
+	timer = davinci_timer_clksrc_timer;
+	regmap_read(timer->map, timer->regs->tim_off, &val);
+
+	return val;
+}
+
+static u64 davinci_timer_read(struct clocksource *dev)
+{
+	struct davinci_timer_clocksource *clocksource;
+	const struct davinci_timer_regs *regs;
+	unsigned int val;
+
+	clocksource = to_davinci_timer_clocksource(dev);
+	regs = clocksource->timer.regs;
+
+	regmap_read(clocksource->timer.map, regs->tim_off, &val);
+
+	return val;
+}
+
+static int davinci_timer_set_next_event(unsigned long cycles,
+					struct clock_event_device *dev)
+{
+	struct davinci_timer_clockevent *clockevent;
+
+	clockevent = to_davinci_timer_clockevent(dev);
+	davinci_timer_set_period(&clockevent->timer, cycles);
+
+	return 0;
+}
+
+static int davinci_timer_set_state_shutdown(struct clock_event_device *dev)
+{
+	struct davinci_timer_clockevent *clockevent;
+
+	clockevent = to_davinci_timer_clockevent(dev);
+	clockevent->timer.mode = DAVINCI_TIMER_MODE_DISABLED;
+
+	return 0;
+}
+
+static int davinci_timer_set_state_periodic(struct clock_event_device *dev)
+{
+	struct davinci_timer_clockevent *clockevent;
+	unsigned int period;
+
+	clockevent = to_davinci_timer_clockevent(dev);
+	period = clockevent->tick_rate / HZ;
+
+	clockevent->timer.mode = DAVINCI_TIMER_MODE_PERIODIC;
+	davinci_timer_set_period(&clockevent->timer, period);
+
+	return 0;
+}
+
+static int davinci_timer_set_state_oneshot(struct clock_event_device *dev)
+{
+	struct davinci_timer_clockevent *clockevent;
+
+	clockevent = to_davinci_timer_clockevent(dev);
+	clockevent->timer.mode = DAVINCI_TIMER_MODE_ONESHOT;
+
+	return 0;
+}
+
+int __init davinci_timer_register(struct clk *clk,
+				  const struct davinci_timer_cfg *timer_cfg)
+{
+	struct davinci_timer_clocksource *clocksource;
+	struct davinci_timer_clockevent *clockevent;
+	struct regmap *map;
+	int rv, clkev_irq;
+	void *base;
+
+	rv = clk_prepare_enable(clk);
+	if (rv) {
+		pr_err("%s: Unable to prepare and enable the timer clock\n",
+		       __func__);
+		return rv;
+	}
+
+	base = ioremap(timer_cfg->reg.start, resource_size(&timer_cfg->reg));
+	if (!base) {
+		pr_err("%s: Unable to map the register range", __func__);
+		return -ENOMEM;
+	}
+
+	map = regmap_init_mmio(NULL, base, &davinci_timer_regmap_config);
+	if (IS_ERR(map)) {
+		pr_err("%s: Error initiating regmap\n", __func__);
+		return PTR_ERR(map);
+	}
+
+	/* Global timer init. */
+
+	/* Set clock to internal mode and disable it. */
+	regmap_write(map, DAVINCI_TIMER_REG_TCR, 0x0);
+	/* Reset both 32-bit timers, set no prescaler for timer 34. */
+	regmap_write(map, DAVINCI_TIMER_REG_TGCR, 0x0);
+	/* Set the timer to dual 32-bit unchained mode. */
+	regmap_update_bits(map, DAVINCI_TIMER_REG_TGCR,
+			   DAVINCI_TIMER_TIMMODE_MASK,
+			   DAVINCI_TIMER_TIMMODE_32BIT_UNCHAINED);
+	/* Unreset both 32-bit timers. */
+	regmap_update_bits(map, DAVINCI_TIMER_REG_TGCR,
+			   DAVINCI_TIMER_RESET_MASK, DAVINCI_TIMER_UNRESET);
+	/* Init both counters to zero. */
+	regmap_write(map, DAVINCI_TIMER_REG_TIM12, 0x0);
+	regmap_write(map, DAVINCI_TIMER_REG_TIM34, 0x0);
+
+	/* Setup clockevent. */
+
+	clockevent = kzalloc(sizeof(*clockevent), GFP_KERNEL);
+	if (!clockevent) {
+		pr_err("%s: Error allocating memory for clockevent data",
+		       __func__);
+		return -ENOMEM;
+	}
+
+	clockevent->dev.name = "timer0_0";
+	clockevent->dev.features = CLOCK_EVT_FEAT_ONESHOT;
+	clockevent->dev.set_next_event = davinci_timer_set_next_event;
+	clockevent->dev.set_state_shutdown = davinci_timer_set_state_shutdown;
+	clockevent->dev.set_state_periodic = davinci_timer_set_state_periodic;
+	clockevent->dev.set_state_oneshot = davinci_timer_set_state_oneshot;
+	clockevent->dev.cpumask = cpumask_of(0);
+	clockevent->tick_rate = clk_get_rate(clk);
+	clockevent->timer.mode = DAVINCI_TIMER_MODE_DISABLED;
+	clockevent->timer.map = map;
+	clockevent->timer.regs = &davinci_timer_tim12_regs;
+
+	if (timer_cfg->cmp.offset) {
+		clkev_irq = timer_cfg->cmp.irq.start;
+		clockevent->timer.cmp_off = timer_cfg->cmp.offset;
+		clockevent->timer.set_period = davinci_timer_set_period_cmp;
+	} else {
+		clkev_irq = timer_cfg->irq[DAVINCI_TIMER_TIM12_IRQ].start;
+		clockevent->dev.features |= CLOCK_EVT_FEAT_PERIODIC;
+		clockevent->timer.set_period = davinci_timer_set_period_std;
+	}
+
+	rv = request_irq(clkev_irq, davinci_timer_irq_timer,
+			 IRQF_TIMER, "clockevent", clockevent);
+	if (rv) {
+		pr_err("%s: Unable to request the clockevent interrupt\n",
+		       __func__);
+		return rv;
+	}
+
+	clockevents_config_and_register(&clockevent->dev,
+					clockevent->tick_rate,
+					DAVINCI_TIMER_MIN_DELTA,
+					DAVINCI_TIMER_MAX_DELTA);
+
+	/* Setup clocksource */
+
+	clocksource = kzalloc(sizeof(*clocksource), GFP_KERNEL);
+	if (!clocksource) {
+		pr_err("%s: Error allocating memory for clocksource data",
+		       __func__);
+		return -ENOMEM;
+	}
+
+	clocksource->dev.name = timer_cfg->cmp.offset ? "timer0_0" : "timer0_1";
+	clocksource->dev.rating = 300;
+	clocksource->dev.read = davinci_timer_read;
+	clocksource->dev.mask = CLOCKSOURCE_MASK(DAVINCI_TIMER_CLKSRC_BITS);
+	clocksource->dev.flags = CLOCK_SOURCE_IS_CONTINUOUS;
+	clocksource->timer.set_period = davinci_timer_set_period_std;
+	clocksource->timer.mode = DAVINCI_TIMER_MODE_PERIODIC;
+	clocksource->timer.map = map;
+	clocksource->timer.regs = &davinci_timer_tim34_regs;
+
+	rv = request_irq(timer_cfg->irq[DAVINCI_TIMER_TIM34_IRQ].start,
+			 davinci_timer_irq_freerun, IRQF_TIMER,
+			 "free-run counter", clocksource);
+	if (rv) {
+		pr_err("%s: Unable to request the clocksource interrupt\n",
+		       __func__);
+		return rv;
+	}
+
+	rv = clocksource_register_hz(&clocksource->dev, clockevent->tick_rate);
+	if (rv) {
+		pr_err("%s: Unable to register clocksource\n",
+		       __func__);
+		return rv;
+	}
+
+	davinci_timer_clksrc_timer = &clocksource->timer;
+
+	sched_clock_register(davinci_timer_read_sched_clock,
+			     DAVINCI_TIMER_CLKSRC_BITS,
+			     clockevent->tick_rate);
+
+	davinci_timer_set_period(&clockevent->timer,
+				 clockevent->tick_rate / HZ);
+	davinci_timer_set_period(&clocksource->timer, UINT_MAX);
+
+	return 0;
+}
+
+static int __init of_davinci_timer_register(struct device_node *np)
+{
+	struct davinci_timer_cfg timer_cfg = { };
+	struct clk *clk;
+	int rv;
+
+	rv = of_address_to_resource(np, 0, &timer_cfg.reg);
+	if (rv) {
+		pr_err("%s: Unable to get the register range for timer\n",
+		       __func__);
+		return rv;
+	}
+
+	rv = of_irq_to_resource_table(np, timer_cfg.irq,
+				      DAVINCI_TIMER_NUM_IRQS);
+	if (rv != DAVINCI_TIMER_NUM_IRQS) {
+		pr_err("%s: Unable to get the interrupts for timer\n",
+		       __func__);
+		return rv;
+	}
+
+	clk = of_clk_get(np, 0);
+	if (IS_ERR(clk)) {
+		pr_err("%s: Unable to get the timer clock\n", __func__);
+		return PTR_ERR(clk);
+	}
+
+	rv = davinci_timer_register(clk, &timer_cfg);
+	if (rv)
+		clk_put(clk);
+
+	return rv;
+}
+TIMER_OF_DECLARE(davinci_timer, "ti,da830-timer", of_davinci_timer_register);
diff --git a/include/clocksource/timer-davinci.h b/include/clocksource/timer-davinci.h
new file mode 100644
index 000000000000..77a98cbd040b
--- /dev/null
+++ b/include/clocksource/timer-davinci.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * TI DaVinci clocksource driver
+ *
+ * Copyright (C) 2019 Texas Instruments
+ * Author: Bartosz Golaszewski <bgolaszewski@baylibre.com>
+ */
+
+#ifndef __TIMER_DAVINCI_H__
+#define __TIMER_DAVINCI_H__
+
+#include <linux/clk.h>
+#include <linux/ioport.h>
+
+enum {
+	DAVINCI_TIMER_TIM12_IRQ = 0,
+	DAVINCI_TIMER_TIM34_IRQ,
+	DAVINCI_TIMER_NUM_IRQS,
+};
+
+struct davinci_timer_cmp_cfg {
+	struct resource irq;
+	unsigned int offset;
+};
+
+struct davinci_timer_cfg {
+	struct resource reg;
+	struct resource irq[DAVINCI_TIMER_NUM_IRQS];
+	struct davinci_timer_cmp_cfg cmp;
+};
+
+int __init davinci_timer_register(struct clk *clk,
+				  const struct davinci_timer_cfg *data);
+
+#endif /* __TIMER_DAVINCI_H__ */
-- 
2.19.1


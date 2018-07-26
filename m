Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE256C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 10:16:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8967420671
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 10:16:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="e05JtHyK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8967420671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729414AbeGZLce (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 07:32:34 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40326 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729031AbeGZLce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 07:32:34 -0400
Received: by mail-wr1-f66.google.com with SMTP id h15-v6so1137548wrs.7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 03:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NiwYSYcAfjtEfHOWA6PB1+uyUi635B3M3JtOW5fhzOc=;
        b=e05JtHyKjQ6MjW2fPHTYFEQd/XZF2GHXVXUXTUg7Z+2SiN/WIJ4+HPoB+8cNlhYi4Z
         n3KjEoIbFKxzjg/yMofz+2xZzosh+Il+RVwyftlApp41xH9iVVP2oYPd4sqWrAMqPEuB
         Z1biuCF2fK2VgVuexW03y6JMpNZ1oSiNjRX9w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NiwYSYcAfjtEfHOWA6PB1+uyUi635B3M3JtOW5fhzOc=;
        b=JcRnWduohhanm2ePAsjh3uSHjXxviQCu+lyJ5HIVYbD+cSsaqcIm4vMHkYgmrNN2Oz
         JYDaSrqvcRyGy9mMuptj+1zPXMf5sLoaRtjnwFLJ9Ni4l4QZPrRLUSeCKQBlbCE6jwYP
         DgGtaz6jq7o9985Kbm4xidMfz/Ny38VPIYP2f/sgR6Kdu6lXtxUXjyarjUSNvmYqtoaB
         eLAr3FLBZ7BG6FYWU/+ldHkSWusxFJnr+z+FW/y21aBnl/4bBvTb4MWxXOqXj5cDDMX6
         KMtQU91FhkVo1ZcaEbnD9PnctK7gIcreawNGdbtDYF/z3uf4/LHieFdcxX/OMge/UeJH
         76+Q==
X-Gm-Message-State: AOUpUlGKHN3WdQfboH7OD5WJJ76jz75kPyMXiY/hdO7g7FaWFe96MbX6
        WbBFG2p3nouwtwnacfPi10Ov9A==
X-Google-Smtp-Source: AAOMgpfNfrePTli1KwzNUF1gaMfYoa+pILN/HJ1jvP4AOt7wlkm0JDYzxkA0HyjP1AbhHY492mnWPg==
X-Received: by 2002:adf:9527:: with SMTP id 36-v6mr1025745wrs.99.1532600182651;
        Thu, 26 Jul 2018 03:16:22 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e35:879a:6cd0:35bd:fbdf:74b5:3f51])
        by smtp.gmail.com with ESMTPSA id f6-v6sm957303wrp.30.2018.07.26.03.16.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 26 Jul 2018 03:16:21 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de, mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, stanley.chu@mediatek.com,
        baolin.wang@linaro.org, Sudeep.Holla@arm.com,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support),
        linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support)
Subject: [PATCH 4/7] clocksource/drivers/timer-mediatek: Use specific prefix for GPT
Date:   Thu, 26 Jul 2018 12:15:27 +0200
Message-Id: <1532600131-28168-4-git-send-email-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1532600131-28168-1-git-send-email-daniel.lezcano@linaro.org>
References: <014f94f9-54d4-1ee0-aa89-67ca5d221989@free.fr>
 <1532600131-28168-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stanley Chu <stanley.chu@mediatek.com>

Use specific prefix to specify the name of supported
timer hardware: "General Purpose Timer (GPT)".

Signed-off-by: Stanley Chu <stanley.chu@mediatek.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-mediatek.c | 157 ++++++++++++++++++-----------------
 1 file changed, 80 insertions(+), 77 deletions(-)

diff --git a/drivers/clocksource/timer-mediatek.c b/drivers/clocksource/timer-mediatek.c
index f9b724f..e3657d2 100644
--- a/drivers/clocksource/timer-mediatek.c
+++ b/drivers/clocksource/timer-mediatek.c
@@ -29,32 +29,35 @@
 #include <linux/sched_clock.h>
 #include <linux/slab.h>
 
-#define GPT_IRQ_EN_REG		0x00
-#define GPT_IRQ_ENABLE(val)	BIT((val) - 1)
-#define GPT_IRQ_ACK_REG		0x08
-#define GPT_IRQ_ACK(val)	BIT((val) - 1)
-
-#define TIMER_CTRL_REG(val)	(0x10 * (val))
-#define TIMER_CTRL_OP(val)	(((val) & 0x3) << 4)
-#define TIMER_CTRL_OP_ONESHOT	(0)
-#define TIMER_CTRL_OP_REPEAT	(1)
-#define TIMER_CTRL_OP_FREERUN	(3)
-#define TIMER_CTRL_CLEAR	(2)
-#define TIMER_CTRL_ENABLE	(1)
-#define TIMER_CTRL_DISABLE	(0)
-
-#define TIMER_CLK_REG(val)	(0x04 + (0x10 * (val)))
-#define TIMER_CLK_SRC(val)	(((val) & 0x1) << 4)
-#define TIMER_CLK_SRC_SYS13M	(0)
-#define TIMER_CLK_SRC_RTC32K	(1)
-#define TIMER_CLK_DIV1		(0x0)
-#define TIMER_CLK_DIV2		(0x1)
-
-#define TIMER_CNT_REG(val)	(0x08 + (0x10 * (val)))
-#define TIMER_CMP_REG(val)	(0x0C + (0x10 * (val)))
-
-#define GPT_CLK_EVT	1
-#define GPT_CLK_SRC	2
+#define TIMER_CLK_EVT           (1)
+#define TIMER_CLK_SRC           (2)
+
+#define TIMER_SYNC_TICKS        (3)
+
+/* gpt */
+#define GPT_IRQ_EN_REG          0x00
+#define GPT_IRQ_ENABLE(val)     BIT((val) - 1)
+#define GPT_IRQ_ACK_REG	        0x08
+#define GPT_IRQ_ACK(val)        BIT((val) - 1)
+
+#define GPT_CTRL_REG(val)       (0x10 * (val))
+#define GPT_CTRL_OP(val)        (((val) & 0x3) << 4)
+#define GPT_CTRL_OP_ONESHOT     (0)
+#define GPT_CTRL_OP_REPEAT      (1)
+#define GPT_CTRL_OP_FREERUN     (3)
+#define GPT_CTRL_CLEAR          (2)
+#define GPT_CTRL_ENABLE         (1)
+#define GPT_CTRL_DISABLE        (0)
+
+#define GPT_CLK_REG(val)        (0x04 + (0x10 * (val)))
+#define GPT_CLK_SRC(val)        (((val) & 0x1) << 4)
+#define GPT_CLK_SRC_SYS13M      (0)
+#define GPT_CLK_SRC_RTC32K      (1)
+#define GPT_CLK_DIV1            (0x0)
+#define GPT_CLK_DIV2            (0x1)
+
+#define GPT_CNT_REG(val)        (0x08 + (0x10 * (val)))
+#define GPT_CMP_REG(val)        (0x0C + (0x10 * (val)))
 
 struct mtk_clock_event_device {
 	void __iomem *gpt_base;
@@ -64,7 +67,7 @@ struct mtk_clock_event_device {
 
 static void __iomem *gpt_sched_reg __read_mostly;
 
-static u64 notrace mtk_read_sched_clock(void)
+static u64 notrace mtk_gpt_read_sched_clock(void)
 {
 	return readl_relaxed(gpt_sched_reg);
 }
@@ -75,22 +78,22 @@ static inline struct mtk_clock_event_device *to_mtk_clk(
 	return container_of(c, struct mtk_clock_event_device, dev);
 }
 
-static void mtk_clkevt_time_stop(struct mtk_clock_event_device *evt, u8 timer)
+static void mtk_gpt_clkevt_time_stop(struct mtk_clock_event_device *evt, u8 timer)
 {
 	u32 val;
 
-	val = readl(evt->gpt_base + TIMER_CTRL_REG(timer));
-	writel(val & ~TIMER_CTRL_ENABLE, evt->gpt_base +
-			TIMER_CTRL_REG(timer));
+	val = readl(evt->gpt_base + GPT_CTRL_REG(timer));
+	writel(val & ~GPT_CTRL_ENABLE, evt->gpt_base +
+			GPT_CTRL_REG(timer));
 }
 
-static void mtk_clkevt_time_setup(struct mtk_clock_event_device *evt,
+static void mtk_gpt_clkevt_time_setup(struct mtk_clock_event_device *evt,
 				unsigned long delay, u8 timer)
 {
-	writel(delay, evt->gpt_base + TIMER_CMP_REG(timer));
+	writel(delay, evt->gpt_base + GPT_CMP_REG(timer));
 }
 
-static void mtk_clkevt_time_start(struct mtk_clock_event_device *evt,
+static void mtk_gpt_clkevt_time_start(struct mtk_clock_event_device *evt,
 		bool periodic, u8 timer)
 {
 	u32 val;
@@ -98,75 +101,75 @@ static void mtk_clkevt_time_start(struct mtk_clock_event_device *evt,
 	/* Acknowledge interrupt */
 	writel(GPT_IRQ_ACK(timer), evt->gpt_base + GPT_IRQ_ACK_REG);
 
-	val = readl(evt->gpt_base + TIMER_CTRL_REG(timer));
+	val = readl(evt->gpt_base + GPT_CTRL_REG(timer));
 
 	/* Clear 2 bit timer operation mode field */
-	val &= ~TIMER_CTRL_OP(0x3);
+	val &= ~GPT_CTRL_OP(0x3);
 
 	if (periodic)
-		val |= TIMER_CTRL_OP(TIMER_CTRL_OP_REPEAT);
+		val |= GPT_CTRL_OP(GPT_CTRL_OP_REPEAT);
 	else
-		val |= TIMER_CTRL_OP(TIMER_CTRL_OP_ONESHOT);
+		val |= GPT_CTRL_OP(GPT_CTRL_OP_ONESHOT);
 
-	writel(val | TIMER_CTRL_ENABLE | TIMER_CTRL_CLEAR,
-	       evt->gpt_base + TIMER_CTRL_REG(timer));
+	writel(val | GPT_CTRL_ENABLE | GPT_CTRL_CLEAR,
+	       evt->gpt_base + GPT_CTRL_REG(timer));
 }
 
-static int mtk_clkevt_shutdown(struct clock_event_device *clk)
+static int mtk_gpt_clkevt_shutdown(struct clock_event_device *clk)
 {
-	mtk_clkevt_time_stop(to_mtk_clk(clk), GPT_CLK_EVT);
+	mtk_gpt_clkevt_time_stop(to_mtk_clk(clk), TIMER_CLK_EVT);
 	return 0;
 }
 
-static int mtk_clkevt_set_periodic(struct clock_event_device *clk)
+static int mtk_gpt_clkevt_set_periodic(struct clock_event_device *clk)
 {
 	struct mtk_clock_event_device *evt = to_mtk_clk(clk);
 
-	mtk_clkevt_time_stop(evt, GPT_CLK_EVT);
-	mtk_clkevt_time_setup(evt, evt->ticks_per_jiffy, GPT_CLK_EVT);
-	mtk_clkevt_time_start(evt, true, GPT_CLK_EVT);
+	mtk_gpt_clkevt_time_stop(evt, TIMER_CLK_EVT);
+	mtk_gpt_clkevt_time_setup(evt, evt->ticks_per_jiffy, TIMER_CLK_EVT);
+	mtk_gpt_clkevt_time_start(evt, true, TIMER_CLK_EVT);
 	return 0;
 }
 
-static int mtk_clkevt_next_event(unsigned long event,
+static int mtk_gpt_clkevt_next_event(unsigned long event,
 				   struct clock_event_device *clk)
 {
 	struct mtk_clock_event_device *evt = to_mtk_clk(clk);
 
-	mtk_clkevt_time_stop(evt, GPT_CLK_EVT);
-	mtk_clkevt_time_setup(evt, event, GPT_CLK_EVT);
-	mtk_clkevt_time_start(evt, false, GPT_CLK_EVT);
+	mtk_gpt_clkevt_time_stop(evt, TIMER_CLK_EVT);
+	mtk_gpt_clkevt_time_setup(evt, event, TIMER_CLK_EVT);
+	mtk_gpt_clkevt_time_start(evt, false, TIMER_CLK_EVT);
 
 	return 0;
 }
 
-static irqreturn_t mtk_timer_interrupt(int irq, void *dev_id)
+static irqreturn_t mtk_gpt_interrupt(int irq, void *dev_id)
 {
 	struct mtk_clock_event_device *evt = dev_id;
 
 	/* Acknowledge timer0 irq */
-	writel(GPT_IRQ_ACK(GPT_CLK_EVT), evt->gpt_base + GPT_IRQ_ACK_REG);
+	writel(GPT_IRQ_ACK(TIMER_CLK_EVT), evt->gpt_base + GPT_IRQ_ACK_REG);
 	evt->dev.event_handler(&evt->dev);
 
 	return IRQ_HANDLED;
 }
 
 static void
-__init mtk_timer_setup(struct mtk_clock_event_device *evt, u8 timer, u8 option)
+__init mtk_gpt_setup(struct mtk_clock_event_device *evt, u8 timer, u8 option)
 {
-	writel(TIMER_CTRL_CLEAR | TIMER_CTRL_DISABLE,
-		evt->gpt_base + TIMER_CTRL_REG(timer));
+	writel(GPT_CTRL_CLEAR | GPT_CTRL_DISABLE,
+		evt->gpt_base + GPT_CTRL_REG(timer));
 
-	writel(TIMER_CLK_SRC(TIMER_CLK_SRC_SYS13M) | TIMER_CLK_DIV1,
-			evt->gpt_base + TIMER_CLK_REG(timer));
+	writel(GPT_CLK_SRC(GPT_CLK_SRC_SYS13M) | GPT_CLK_DIV1,
+			evt->gpt_base + GPT_CLK_REG(timer));
 
-	writel(0x0, evt->gpt_base + TIMER_CMP_REG(timer));
+	writel(0x0, evt->gpt_base + GPT_CMP_REG(timer));
 
-	writel(TIMER_CTRL_OP(option) | TIMER_CTRL_ENABLE,
-			evt->gpt_base + TIMER_CTRL_REG(timer));
+	writel(GPT_CTRL_OP(option) | GPT_CTRL_ENABLE,
+			evt->gpt_base + GPT_CTRL_REG(timer));
 }
 
-static void mtk_timer_enable_irq(struct mtk_clock_event_device *evt, u8 timer)
+static void mtk_gpt_enable_irq(struct mtk_clock_event_device *evt, u8 timer)
 {
 	u32 val;
 
@@ -181,7 +184,7 @@ static void mtk_timer_enable_irq(struct mtk_clock_event_device *evt, u8 timer)
 			evt->gpt_base + GPT_IRQ_EN_REG);
 }
 
-static int __init mtk_timer_init(struct device_node *node)
+static int __init mtk_gpt_init(struct device_node *node)
 {
 	struct mtk_clock_event_device *evt;
 	struct resource res;
@@ -195,14 +198,14 @@ static int __init mtk_timer_init(struct device_node *node)
 	evt->dev.name = "mtk_tick";
 	evt->dev.rating = 300;
 	evt->dev.features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
-	evt->dev.set_state_shutdown = mtk_clkevt_shutdown;
-	evt->dev.set_state_periodic = mtk_clkevt_set_periodic;
-	evt->dev.set_state_oneshot = mtk_clkevt_shutdown;
-	evt->dev.tick_resume = mtk_clkevt_shutdown;
-	evt->dev.set_next_event = mtk_clkevt_next_event;
+	evt->dev.set_state_shutdown = mtk_gpt_clkevt_shutdown;
+	evt->dev.set_state_periodic = mtk_gpt_clkevt_set_periodic;
+	evt->dev.set_state_oneshot = mtk_gpt_clkevt_shutdown;
+	evt->dev.tick_resume = mtk_gpt_clkevt_shutdown;
+	evt->dev.set_next_event = mtk_gpt_clkevt_next_event;
 	evt->dev.cpumask = cpu_possible_mask;
 
-	evt->gpt_base = of_io_request_and_map(node, 0, "mtk-timer");
+	evt->gpt_base = of_io_request_and_map(node, 0, "mtk-timer-gpt");
 	if (IS_ERR(evt->gpt_base)) {
 		pr_err("Can't get resource\n");
 		goto err_kzalloc;
@@ -226,7 +229,7 @@ static int __init mtk_timer_init(struct device_node *node)
 	}
 	rate = clk_get_rate(clk);
 
-	if (request_irq(evt->dev.irq, mtk_timer_interrupt,
+	if (request_irq(evt->dev.irq, mtk_gpt_interrupt,
 			IRQF_TIMER | IRQF_IRQPOLL, "mtk_timer", evt)) {
 		pr_err("failed to setup irq %d\n", evt->dev.irq);
 		goto err_clk_disable;
@@ -235,18 +238,18 @@ static int __init mtk_timer_init(struct device_node *node)
 	evt->ticks_per_jiffy = DIV_ROUND_UP(rate, HZ);
 
 	/* Configure clock source */
-	mtk_timer_setup(evt, GPT_CLK_SRC, TIMER_CTRL_OP_FREERUN);
-	clocksource_mmio_init(evt->gpt_base + TIMER_CNT_REG(GPT_CLK_SRC),
+	mtk_gpt_setup(evt, TIMER_CLK_SRC, GPT_CTRL_OP_FREERUN);
+	clocksource_mmio_init(evt->gpt_base + GPT_CNT_REG(TIMER_CLK_SRC),
 			node->name, rate, 300, 32, clocksource_mmio_readl_up);
-	gpt_sched_reg = evt->gpt_base + TIMER_CNT_REG(GPT_CLK_SRC);
-	sched_clock_register(mtk_read_sched_clock, 32, rate);
+	gpt_sched_reg = evt->gpt_base + GPT_CNT_REG(TIMER_CLK_SRC);
+	sched_clock_register(mtk_gpt_read_sched_clock, 32, rate);
 
 	/* Configure clock event */
-	mtk_timer_setup(evt, GPT_CLK_EVT, TIMER_CTRL_OP_REPEAT);
-	clockevents_config_and_register(&evt->dev, rate, 0x3,
+	mtk_gpt_setup(evt, TIMER_CLK_EVT, GPT_CTRL_OP_REPEAT);
+	clockevents_config_and_register(&evt->dev, rate, TIMER_SYNC_TICKS,
 					0xffffffff);
 
-	mtk_timer_enable_irq(evt, GPT_CLK_EVT);
+	mtk_gpt_enable_irq(evt, TIMER_CLK_EVT);
 
 	return 0;
 
@@ -265,4 +268,4 @@ static int __init mtk_timer_init(struct device_node *node)
 
 	return -EINVAL;
 }
-TIMER_OF_DECLARE(mtk_mt6577, "mediatek,mt6577-timer", mtk_timer_init);
+TIMER_OF_DECLARE(mtk_mt6577, "mediatek,mt6577-timer", mtk_gpt_init);
-- 
2.7.4


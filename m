Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C5CBC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 10:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3DBC2723E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 10:45:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3DBC2723E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965347AbeF1Kp4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 06:45:56 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:36079 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S932979AbeF1Kpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 06:45:53 -0400
X-UUID: a682bc97494443f0bdb13675cc35f0f5-20180628
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1647392995; Thu, 28 Jun 2018 18:45:50 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Thu, 28 Jun 2018 18:45:48 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Thu, 28 Jun 2018 18:45:48 +0800
From:   Stanley Chu <stanley.chu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>, Stanley Chu <stanley.chu@mediatek.com>
Subject: [PATCH v3 3/5] clocksource/drivers/timer-mediatek: Rename function prefix
Date:   Thu, 28 Jun 2018 18:45:42 +0800
Message-ID: <1530182744-10731-4-git-send-email-stanley.chu@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1530182744-10731-1-git-send-email-stanley.chu@mediatek.com>
References: <1530182744-10731-1-git-send-email-stanley.chu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add prefix to specify the name of supported timer hardware:
"General Purpose Timer (GPT)".

Signed-off-by: Stanley Chu <stanley.chu@mediatek.com>
---
 drivers/clocksource/timer-mediatek.c |   60 +++++++++++++++++-----------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/drivers/clocksource/timer-mediatek.c b/drivers/clocksource/timer-mediatek.c
index f9b724f..ff284f2 100644
--- a/drivers/clocksource/timer-mediatek.c
+++ b/drivers/clocksource/timer-mediatek.c
@@ -64,7 +64,7 @@ struct mtk_clock_event_device {
 
 static void __iomem *gpt_sched_reg __read_mostly;
 
-static u64 notrace mtk_read_sched_clock(void)
+static u64 notrace mtk_gpt_read_sched_clock(void)
 {
 	return readl_relaxed(gpt_sched_reg);
 }
@@ -75,7 +75,7 @@ static inline struct mtk_clock_event_device *to_mtk_clk(
 	return container_of(c, struct mtk_clock_event_device, dev);
 }
 
-static void mtk_clkevt_time_stop(struct mtk_clock_event_device *evt, u8 timer)
+static void mtk_gpt_clkevt_time_stop(struct mtk_clock_event_device *evt, u8 timer)
 {
 	u32 val;
 
@@ -84,13 +84,13 @@ static void mtk_clkevt_time_stop(struct mtk_clock_event_device *evt, u8 timer)
 			TIMER_CTRL_REG(timer));
 }
 
-static void mtk_clkevt_time_setup(struct mtk_clock_event_device *evt,
+static void mtk_gpt_clkevt_time_setup(struct mtk_clock_event_device *evt,
 				unsigned long delay, u8 timer)
 {
 	writel(delay, evt->gpt_base + TIMER_CMP_REG(timer));
 }
 
-static void mtk_clkevt_time_start(struct mtk_clock_event_device *evt,
+static void mtk_gpt_clkevt_time_start(struct mtk_clock_event_device *evt,
 		bool periodic, u8 timer)
 {
 	u32 val;
@@ -112,35 +112,35 @@ static void mtk_clkevt_time_start(struct mtk_clock_event_device *evt,
 	       evt->gpt_base + TIMER_CTRL_REG(timer));
 }
 
-static int mtk_clkevt_shutdown(struct clock_event_device *clk)
+static int mtk_gpt_clkevt_shutdown(struct clock_event_device *clk)
 {
-	mtk_clkevt_time_stop(to_mtk_clk(clk), GPT_CLK_EVT);
+	mtk_gpt_clkevt_time_stop(to_mtk_clk(clk), GPT_CLK_EVT);
 	return 0;
 }
 
-static int mtk_clkevt_set_periodic(struct clock_event_device *clk)
+static int mtk_gpt_clkevt_set_periodic(struct clock_event_device *clk)
 {
 	struct mtk_clock_event_device *evt = to_mtk_clk(clk);
 
-	mtk_clkevt_time_stop(evt, GPT_CLK_EVT);
-	mtk_clkevt_time_setup(evt, evt->ticks_per_jiffy, GPT_CLK_EVT);
-	mtk_clkevt_time_start(evt, true, GPT_CLK_EVT);
+	mtk_gpt_clkevt_time_stop(evt, GPT_CLK_EVT);
+	mtk_gpt_clkevt_time_setup(evt, evt->ticks_per_jiffy, GPT_CLK_EVT);
+	mtk_gpt_clkevt_time_start(evt, true, GPT_CLK_EVT);
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
+	mtk_gpt_clkevt_time_stop(evt, GPT_CLK_EVT);
+	mtk_gpt_clkevt_time_setup(evt, event, GPT_CLK_EVT);
+	mtk_gpt_clkevt_time_start(evt, false, GPT_CLK_EVT);
 
 	return 0;
 }
 
-static irqreturn_t mtk_timer_interrupt(int irq, void *dev_id)
+static irqreturn_t mtk_gpt_interrupt(int irq, void *dev_id)
 {
 	struct mtk_clock_event_device *evt = dev_id;
 
@@ -152,7 +152,7 @@ static irqreturn_t mtk_timer_interrupt(int irq, void *dev_id)
 }
 
 static void
-__init mtk_timer_setup(struct mtk_clock_event_device *evt, u8 timer, u8 option)
+__init mtk_gpt_setup(struct mtk_clock_event_device *evt, u8 timer, u8 option)
 {
 	writel(TIMER_CTRL_CLEAR | TIMER_CTRL_DISABLE,
 		evt->gpt_base + TIMER_CTRL_REG(timer));
@@ -166,7 +166,7 @@ __init mtk_timer_setup(struct mtk_clock_event_device *evt, u8 timer, u8 option)
 			evt->gpt_base + TIMER_CTRL_REG(timer));
 }
 
-static void mtk_timer_enable_irq(struct mtk_clock_event_device *evt, u8 timer)
+static void mtk_gpt_enable_irq(struct mtk_clock_event_device *evt, u8 timer)
 {
 	u32 val;
 
@@ -181,7 +181,7 @@ static void mtk_timer_enable_irq(struct mtk_clock_event_device *evt, u8 timer)
 			evt->gpt_base + GPT_IRQ_EN_REG);
 }
 
-static int __init mtk_timer_init(struct device_node *node)
+static int __init mtk_gpt_init(struct device_node *node)
 {
 	struct mtk_clock_event_device *evt;
 	struct resource res;
@@ -195,14 +195,14 @@ static int __init mtk_timer_init(struct device_node *node)
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
@@ -226,7 +226,7 @@ static int __init mtk_timer_init(struct device_node *node)
 	}
 	rate = clk_get_rate(clk);
 
-	if (request_irq(evt->dev.irq, mtk_timer_interrupt,
+	if (request_irq(evt->dev.irq, mtk_gpt_interrupt,
 			IRQF_TIMER | IRQF_IRQPOLL, "mtk_timer", evt)) {
 		pr_err("failed to setup irq %d\n", evt->dev.irq);
 		goto err_clk_disable;
@@ -235,18 +235,18 @@ static int __init mtk_timer_init(struct device_node *node)
 	evt->ticks_per_jiffy = DIV_ROUND_UP(rate, HZ);
 
 	/* Configure clock source */
-	mtk_timer_setup(evt, GPT_CLK_SRC, TIMER_CTRL_OP_FREERUN);
+	mtk_gpt_setup(evt, GPT_CLK_SRC, TIMER_CTRL_OP_FREERUN);
 	clocksource_mmio_init(evt->gpt_base + TIMER_CNT_REG(GPT_CLK_SRC),
 			node->name, rate, 300, 32, clocksource_mmio_readl_up);
 	gpt_sched_reg = evt->gpt_base + TIMER_CNT_REG(GPT_CLK_SRC);
-	sched_clock_register(mtk_read_sched_clock, 32, rate);
+	sched_clock_register(mtk_gpt_read_sched_clock, 32, rate);
 
 	/* Configure clock event */
-	mtk_timer_setup(evt, GPT_CLK_EVT, TIMER_CTRL_OP_REPEAT);
+	mtk_gpt_setup(evt, GPT_CLK_EVT, TIMER_CTRL_OP_REPEAT);
 	clockevents_config_and_register(&evt->dev, rate, 0x3,
 					0xffffffff);
 
-	mtk_timer_enable_irq(evt, GPT_CLK_EVT);
+	mtk_gpt_enable_irq(evt, GPT_CLK_EVT);
 
 	return 0;
 
@@ -265,4 +265,4 @@ static int __init mtk_timer_init(struct device_node *node)
 
 	return -EINVAL;
 }
-TIMER_OF_DECLARE(mtk_mt6577, "mediatek,mt6577-timer", mtk_timer_init);
+TIMER_OF_DECLARE(mtk_mt6577, "mediatek,mt6577-timer", mtk_gpt_init);
-- 
1.7.9.5


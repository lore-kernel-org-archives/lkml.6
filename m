Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 033F4C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 19:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C91A920651
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 19:15:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726914AbfANTPM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 14:15:12 -0500
Received: from mout.gmx.net ([212.227.17.21]:38791 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726728AbfANTPK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 14:15:10 -0500
Received: from longitude ([109.90.232.48]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LeiJ8-1h2EgU1QMA-00qTQn; Mon, 14
 Jan 2019 20:15:08 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-gpio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: [PATCH v2 2/2] gpio: hlwd: Implement edge trigger emulation
Date:   Mon, 14 Jan 2019 20:14:50 +0100
Message-Id: <20190114191450.11597-3-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190114191450.11597-1-j.neuschaefer@gmx.net>
References: <20190114191450.11597-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:mP8bCeC010qffF5qftc4yIN0iStt1NP0xDOUSSNG2lPoC9EV22X
 58Aj6+5Rl3GGZ0zd6jftZ2VKkgAWoesdzyDKzNG/uyXZgf1eRlMLfjfQqCZHYXpjSpLXUkl
 F0+eCgBgZwJ4UfODytQIrQ7lnZkokvkfJc8Bl5u66mDiQIzalvnRJ9CkKZ3iVtpip8DBJI9
 Xzf9U2ETvvKPu23NAPg2g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ojxmK40wKwk=:N9afsRF1zy4LDGPowC26Wo
 Pa2xWt4KkLLmJHuDoa06QV/OqgA/GBWkO3GfpHSVxI1T+B+3rqxQj9Xs3v2tzvX8tr6txcMqk
 5aMaIjCv91zdD6ylx2NAM/8hxA2tyxrsfRcXcmxGK51GVsQGKzWvwPF8vu8lqZZtoomSvLSan
 qyv9+/E52JxYG7ko06psteWn87haDYOjCGNIE8gxbngx3OXElPiYOTTbDjwoozhM7gLRXU2dU
 JR93wxOkPWF55D5nkpQqonaO0JKAM9EndVdINYaJMx+F+m3uyzBznHVskXofkVrl2s91D1AUk
 VRjOcaqkZFE6PGyuFQJHtt1dneAr5bIxJF2594F6BvG924CSUiFV9X6/OgWqIitLAx52cfZBm
 VKclQAfXyGAXGhBSKRJkfPTwCJz6ZKX6DNF3mhxERCrcMVvaVX/4ZzpMeVxmzGQNmSaLXv3GJ
 uIIlF6hcivQkaGUKBaiDhiE+AkziQ6EFGgdFRVmSuTHb1SzHFED9nAwmFtRWYeqwX5m+V7jTK
 e+3zT7rXtB2yT4WOoTV9RtG1ATE3VxLzgcONGpQDZUENzB68HnEqAR5xeRlaxvYC9NQSehu9b
 G6byhWEJcBrIbyoZot/DnFlnSmy8qsd4E2rXfZUImqeYaHLgu39Qynd7fxqslRR580xYS253L
 5dYiAUQuTCh3vjIdK9c7rGQc9VBeCp9b8/ezEUYKNlLHbhVHtI5hOull9ZReTsu3hHhuN9io8
 XWT1rzGjZVAuFMKHwS4DvrKlyMpO3SZ2yv0TUNKRt+fWymJQpQl2d6Ojb7zLjG8FFZu7z/ZW2
 9eUXNdVIIEeckkYHOD/6cYX1zdEDc3bmaZvbKAo4SGeSxD+xRNN4rVaSY6SqtHQlX63N9XrnA
 owJj/oFF5Fk4dFyOKX0ko/Z0epgKH+zpeprAo8QkblTlyMqZGHuVzpqx5hByE7etww86AfukN
 dtboGKO28nA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like the Spreadtrum EIC driver[1], this driver needs to emulate edge
triggered interrupts to support the generic gpio-keys driver.

[1]: https://www.spinics.net/lists/kernel/msg2764576.html

Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
---

v2:
- Changed register addresses to io{read,write}32be() instead of
  hlwd->gpioc.{read,write}_reg, as suggested by Linus Walleij.

v1: https://lore.kernel.org/lkml/20190113135844.13109-3-j.neuschaefer@gmx.net/
---
 drivers/gpio/gpio-hlwd.c | 56 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/drivers/gpio/gpio-hlwd.c b/drivers/gpio/gpio-hlwd.c
index 61983c115856..a7b17897356e 100644
--- a/drivers/gpio/gpio-hlwd.c
+++ b/drivers/gpio/gpio-hlwd.c
@@ -51,6 +51,8 @@ struct hlwd_gpio {
 	struct irq_chip irqc;
 	void __iomem *regs;
 	int irq;
+	u32 edge_emulation;
+	u32 rising_edge, falling_edge;
 };
 
 static void hlwd_gpio_irqhandler(struct irq_desc *desc)
@@ -61,10 +63,36 @@ static void hlwd_gpio_irqhandler(struct irq_desc *desc)
 	unsigned long flags;
 	unsigned long pending;
 	int hwirq;
+	u32 emulated_pending;
 
 	spin_lock_irqsave(&hlwd->gpioc.bgpio_lock, flags);
 	pending = ioread32be(hlwd->regs + HW_GPIOB_INTFLAG);
 	pending &= ioread32be(hlwd->regs + HW_GPIOB_INTMASK);
+
+	/* Treat interrupts due to edge trigger emulation separately */
+	emulated_pending = hlwd->edge_emulation & pending;
+	pending &= ~emulated_pending;
+	if (emulated_pending) {
+		u32 level, rising, falling;
+
+		level = ioread32be(hlwd->regs + HW_GPIOB_INTLVL);
+		rising = level & emulated_pending;
+		falling = ~level & emulated_pending;
+
+		/* Invert the levels */
+		iowrite32be(level ^ emulated_pending,
+			    hlwd->regs + HW_GPIOB_INTLVL);
+
+		/* Ack all emulated-edge interrupts */
+		iowrite32be(emulated_pending, hlwd->regs + HW_GPIOB_INTFLAG);
+
+		/* Signal interrupts only on the correct edge */
+		rising &= hlwd->rising_edge;
+		falling &= hlwd->falling_edge;
+
+		/* Mark emulated interrupts as pending */
+		pending |= rising | falling;
+	}
 	spin_unlock_irqrestore(&hlwd->gpioc.bgpio_lock, flags);
 
 	chained_irq_enter(chip, desc);
@@ -120,6 +148,27 @@ static void hlwd_gpio_irq_enable(struct irq_data *data)
 	hlwd_gpio_irq_unmask(data);
 }
 
+static void hlwd_gpio_irq_setup_emulation(struct hlwd_gpio *hlwd, int hwirq,
+					  unsigned int flow_type)
+{
+	u32 level, state;
+
+	/* Set the trigger level to the inactive level */
+	level = ioread32be(hlwd->regs + HW_GPIOB_INTLVL);
+	state = ioread32be(hlwd->regs + HW_GPIOB_IN) & BIT(hwirq);
+	level &= ~BIT(hwirq);
+	level |= state ^ BIT(hwirq);
+	iowrite32be(level, hlwd->regs + HW_GPIOB_INTLVL);
+
+	hlwd->edge_emulation |= BIT(hwirq);
+	hlwd->rising_edge &= ~BIT(hwirq);
+	hlwd->falling_edge &= ~BIT(hwirq);
+	if (flow_type & IRQ_TYPE_EDGE_RISING)
+		hlwd->rising_edge |= BIT(hwirq);
+	if (flow_type & IRQ_TYPE_EDGE_FALLING)
+		hlwd->falling_edge |= BIT(hwirq);
+}
+
 static int hlwd_gpio_irq_set_type(struct irq_data *data, unsigned int flow_type)
 {
 	struct hlwd_gpio *hlwd =
@@ -129,6 +178,8 @@ static int hlwd_gpio_irq_set_type(struct irq_data *data, unsigned int flow_type)
 
 	spin_lock_irqsave(&hlwd->gpioc.bgpio_lock, flags);
 
+	hlwd->edge_emulation &= ~BIT(data->hwirq);
+
 	switch (flow_type) {
 	case IRQ_TYPE_LEVEL_HIGH:
 		level = ioread32be(hlwd->regs + HW_GPIOB_INTLVL);
@@ -140,6 +191,11 @@ static int hlwd_gpio_irq_set_type(struct irq_data *data, unsigned int flow_type)
 		level &= ~BIT(data->hwirq);
 		iowrite32be(level, hlwd->regs + HW_GPIOB_INTLVL);
 		break;
+	case IRQ_TYPE_EDGE_RISING:
+	case IRQ_TYPE_EDGE_FALLING:
+	case IRQ_TYPE_EDGE_BOTH:
+		hlwd_gpio_irq_setup_emulation(hlwd, data->hwirq, flow_type);
+		break;
 	default:
 		spin_unlock_irqrestore(&hlwd->gpioc.bgpio_lock, flags);
 		return -EINVAL;
-- 
2.20.1


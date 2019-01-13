Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10BA7C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 14:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF87F206B7
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 14:00:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbfAMN75 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 08:59:57 -0500
Received: from mout.gmx.net ([212.227.15.18]:58127 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726592AbfAMN7z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 08:59:55 -0500
Received: from longitude ([109.90.232.48]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LjqLx-1hFYHI1BpB-00brUh; Sun, 13
 Jan 2019 14:59:53 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-gpio@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: [PATCH 2/2] gpio: hlwd: Implement edge trigger emulation
Date:   Sun, 13 Jan 2019 14:58:44 +0100
Message-Id: <20190113135844.13109-3-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190113135844.13109-1-j.neuschaefer@gmx.net>
References: <20190113135844.13109-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:1EhH58A94aX1Skvgwv/M6Q4NdPL3ZMkYIVE1ofZyM7LmYs378Ry
 XBb8O+/Vnirf0rkseaXW0tbeXjTB/RtQ6ExAk5IyM72nfFN9SqnnuJYONbI00Zin1f1Tg2K
 gRGPxZyJ93EFAgjgGWMJbQeipuJspMycVtsQlYlek0x+BSha3QpFYoHxv9fYtPdxnfRHIW9
 MK/OKQlkFWL48g79zAJVg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QcFX0cIxZUs=:VCe7UW4P1yCILk5AccNlKh
 xWua8MtIS5hkdaF6UYVt4rX6d7n1n2rfDQIry3k8m9SXOywe+sNyd7gAAeXeKziSpdD13HG7Y
 MDjrlc1QTudZnVFoKEfXgi2RpeoiYpWD/EyLETXdo5/f183q2lrwhUlNYGLDojJYIA+EsxjQu
 /L0xfuovJzQLYPD8vnb7vR5ayd1cS8qGQUQ0COFVFVFcYksrKviofvENuwBqVUHWR78TvfwOV
 X3IFrq3rC9elVE9Ljc9g8xPm7YnGV+dfFvMltG8Gk7Zops9ARs+mV4m2TULJmzYr+XyihAVb7
 ev6dTB6L/LWAdFS+RxgyLMq/re8ZiuuPo7ruF6E7cQbXjZs8We9cOBSEVv9ujNh8rSPoSJW/f
 q+vTm/gRURaHul4uapglFc0UF7DpRa0cnYzdf0wO0EKN3rQdiwladvXpyWbRMJUPBe71ZSDRh
 l5qO9aIFdpernspHwSpX5dopzKOy+vPu4ZqhbuRTAMz4T7hHnVczdqnsxiNsMI98+Z50WSKZG
 nx0InafHVoX11uCbEHvn4KUSJMbF+kbeFptAVAwU1yUxNf6rMEf8OzkOdtKTHGiWtrAQ943n6
 mDmRzJzRgiaJipewSqUsJta0y5qIPMEeXfs1oOjucXAmk6Gagoa+cAHFffcX1gN0oWPd8/giS
 H1YzAq1d/+C5DaS3hLCxiDyJaXyCeuVyKElSDUoguXgkNGXX9LGO27yKTuDFo5jKdt6PErLWX
 GhDMfGpL54bBbl64W7k3pq9tdonUgsepDRAeoyC9LBsvA706rKv1NkN8i8KnULz/O4ApErzM6
 uC6pjpiC6gu5LGlQj67tytO9x+sz6AqOuAMYQeYpZii99fCd2Ra1OzHBjUXgnQldZ2uFEhOiI
 cSUlOID/cQujU2lwu6WDMyzQ1YiQZJXaQgxPSliUakhL5+bArN6b4snlhWbzhq004CR4Dcndi
 QUfebhVZZig==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like the Spreadtrum EIC driver[1], this driver needs to emulate edge
triggered interrupts to support the generic gpio-keys driver.

[1]: https://www.spinics.net/lists/kernel/msg2764576.html

Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
---
 drivers/gpio/gpio-hlwd.c | 57 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/drivers/gpio/gpio-hlwd.c b/drivers/gpio/gpio-hlwd.c
index 9a93546f3d11..3d85e6a71b35 100644
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
@@ -61,10 +63,37 @@ static void hlwd_gpio_irqhandler(struct irq_desc *desc)
 	unsigned long flags;
 	unsigned long pending;
 	int hwirq;
+	u32 emulated_pending;
 
 	spin_lock_irqsave(&hlwd->gpioc.bgpio_lock, flags);
 	pending = hlwd->gpioc.read_reg(hlwd->regs + HW_GPIOB_INTFLAG);
 	pending &= hlwd->gpioc.read_reg(hlwd->regs + HW_GPIOB_INTMASK);
+
+	/* Treat interrupts due to edge trigger emulation separately */
+	emulated_pending = hlwd->edge_emulation & pending;
+	pending &= ~emulated_pending;
+	if (emulated_pending) {
+		u32 level, rising, falling;
+
+		level = hlwd->gpioc.read_reg(hlwd->regs + HW_GPIOB_INTLVL);
+		rising = level & emulated_pending;
+		falling = ~level & emulated_pending;
+
+		/* Invert the levels */
+		hlwd->gpioc.write_reg(hlwd->regs + HW_GPIOB_INTLVL,
+				level ^ emulated_pending);
+
+		/* Ack all emulated-edge interrupts */
+		hlwd->gpioc.write_reg(hlwd->regs + HW_GPIOB_INTFLAG,
+				emulated_pending);
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
@@ -120,6 +149,27 @@ static void hlwd_gpio_irq_enable(struct irq_data *data)
 	hlwd_gpio_irq_unmask(data);
 }
 
+static void hlwd_gpio_irq_setup_emulation(struct hlwd_gpio *hlwd, int hwirq,
+					  unsigned int flow_type)
+{
+	u32 level, state;
+
+	/* Set the trigger level to the inactive level */
+	level = hlwd->gpioc.read_reg(hlwd->regs + HW_GPIOB_INTLVL);
+	state = hlwd->gpioc.read_reg(hlwd->regs + HW_GPIOB_IN) & BIT(hwirq);
+	level &= ~BIT(hwirq);
+	level |= state ^ BIT(hwirq);
+	hlwd->gpioc.write_reg(hlwd->regs + HW_GPIOB_INTLVL, level);
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
@@ -129,6 +179,8 @@ static int hlwd_gpio_irq_set_type(struct irq_data *data, unsigned int flow_type)
 
 	spin_lock_irqsave(&hlwd->gpioc.bgpio_lock, flags);
 
+	hlwd->edge_emulation &= ~BIT(data->hwirq);
+
 	switch (flow_type) {
 	case IRQ_TYPE_LEVEL_HIGH:
 		level = hlwd->gpioc.read_reg(hlwd->regs + HW_GPIOB_INTLVL);
@@ -140,6 +192,11 @@ static int hlwd_gpio_irq_set_type(struct irq_data *data, unsigned int flow_type)
 		level &= ~BIT(data->hwirq);
 		hlwd->gpioc.write_reg(hlwd->regs + HW_GPIOB_INTLVL, level);
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


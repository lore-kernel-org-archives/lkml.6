Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB24C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 18:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC839214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 18:31:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LaIqiUIo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC839214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733220AbeKVFHW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 00:07:22 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35029 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733189AbeKVFHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 00:07:21 -0500
Received: by mail-wm1-f66.google.com with SMTP id c126so6746229wmh.0;
        Wed, 21 Nov 2018 10:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dFmNuuSAwAlTK4F/prHO9aooOqQzQOaScYXy9C90Ogw=;
        b=LaIqiUIoS8yH2mRrMH/5YWpxQzOVLp0jOfUpt1GlXxw2+aBBEOopa/BuZBrNkczjEe
         X5eanmCMTYE0yj4cz7T6dUK+RxCPIoNrrqXh6mWVjT9zLuqV+WljO5FpkhAI0AgbGBgM
         3f1mbLZZdcZBkCghDIqePCltd9OEiGIyaIzKnmko7ZNcL3ulzbHJMCo2GeGpYLs2axX9
         T6Zvq4RQXlR+BBlWRwamDa7birjuY3W7/0GSfpgk8x2EfazioZnrwB9FjHeVWc0F4dN4
         3o8n2KBZIDJkhOLJHFJ3HNfhJ1tDAufYpxnQAWoufrwdn2ZH7LyhBTBiZdcAN21qUTeW
         k0yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dFmNuuSAwAlTK4F/prHO9aooOqQzQOaScYXy9C90Ogw=;
        b=JjlmScVLp/mGougCVYswyHc0NJm7GtcQkRdX7P9PZZ9Nr3mJS+/SGKc/iHhJR0gZPV
         C1bFGajAhuB4gZvHQZN8/Ea1YuZ5h3Mquek9MAUZWCVtSnEpkggMEHi2CBhkYPzTLnAC
         aQFdA+MZ14UzPdiUfkM8QQrJzHbMVs6y7t/rV6iN8M9cddqkyphOBSV5zjQ6V11NXHfc
         OC03V9lmHeITHAEjxYeA/YFPmmSImsWjuyAlye1gH4MgGljkaJn5P2OT6I+bQGLqdmQK
         ga2mbcU+haVqEfGFv6cc21JvsSfi1SkAwDFb+D80WARgGKwGzxEhHuDY2H5rS0FmHdTF
         o/dA==
X-Gm-Message-State: AGRZ1gKZnb88aR8enqHbTl0hRGhQARv5Sot4QYhtJf/tVq5slpz42bJF
        lxLppeU9XveIjmgHn59DxY6p3TF3oSI=
X-Google-Smtp-Source: AJdET5frCXKK+bELArDEuMw3qoVnqLGXoMay6BDImFzwCnVFMEw8J8F6e80im5jkrSRY1Cf0Mmz4/Q==
X-Received: by 2002:a1c:b4c1:: with SMTP id d184-v6mr7290672wmf.143.1542825110639;
        Wed, 21 Nov 2018 10:31:50 -0800 (PST)
Received: from ThinkPad.home ([185.219.177.229])
        by smtp.gmail.com with ESMTPSA id e66-v6sm2568779wmf.40.2018.11.21.10.31.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 21 Nov 2018 10:31:49 -0800 (PST)
From:   Mesih Kilinc <mesihkilinc@gmail.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-sunxi@googlegroups.com
Cc:     Mesih Kilinc <mesihkilinc@gmail.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Russell King <linux@armlinux.org.uk>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Rob Herring <robh+dt@kernel.org>,
        Julian Calaby <julian.calaby@gmail.com>
Subject: [RFC PATCH v3 05/17] irqchip/sun4i: add support for suniv interrupt controller
Date:   Wed, 21 Nov 2018 21:30:38 +0300
Message-Id: <08b40429e46626f4caf8e4d2287b5c4d354e3b7f.1542824904.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1542824904.git.mesihkilinc@gmail.com>
References: <cover.1542824904.git.mesihkilinc@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new F-series SoCs (suniv) from Allwinner use an stripped version of
the interrupt controller in A10/A13

Add support for it in irq-sun4i driver.

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
---
 drivers/irqchip/irq-sun4i.c | 104 +++++++++++++++++++++++++++++++-------------
 1 file changed, 74 insertions(+), 30 deletions(-)

diff --git a/drivers/irqchip/irq-sun4i.c b/drivers/irqchip/irq-sun4i.c
index e3e5b91..7ca4a4d 100644
--- a/drivers/irqchip/irq-sun4i.c
+++ b/drivers/irqchip/irq-sun4i.c
@@ -28,11 +28,21 @@
 #define SUN4I_IRQ_NMI_CTRL_REG		0x0c
 #define SUN4I_IRQ_PENDING_REG(x)	(0x10 + 0x4 * x)
 #define SUN4I_IRQ_FIQ_PENDING_REG(x)	(0x20 + 0x4 * x)
-#define SUN4I_IRQ_ENABLE_REG(x)		(0x40 + 0x4 * x)
-#define SUN4I_IRQ_MASK_REG(x)		(0x50 + 0x4 * x)
+#define SUN4I_IRQ_ENABLE_REG(x)		(irq_ic_data->enable_req_offset + 0x4 * x)
+#define SUN4I_IRQ_MASK_REG(x)		(irq_ic_data->mask_req_offset + 0x4 * x)
+#define SUN4I_IRQ_ENABLE_REG_OFFSET	0x40
+#define SUN4I_IRQ_MASK_REG_OFFSET	0x50
+#define SUNIV_IRQ_ENABLE_REG_OFFSET	0x20
+#define SUNIV_IRQ_MASK_REG_OFFSET	0x30
+
+struct sunxi_irq_chip_data{
+	void __iomem *irq_base;
+	struct irq_domain *irq_domain;
+	u32 enable_req_offset;
+	u32 mask_req_offset;
+};
 
-static void __iomem *sun4i_irq_base;
-static struct irq_domain *sun4i_irq_domain;
+static struct sunxi_irq_chip_data *irq_ic_data;
 
 static void __exception_irq_entry sun4i_handle_irq(struct pt_regs *regs);
 
@@ -43,7 +53,7 @@ static void sun4i_irq_ack(struct irq_data *irqd)
 	if (irq != 0)
 		return; /* Only IRQ 0 / the ENMI needs to be acked */
 
-	writel(BIT(0), sun4i_irq_base + SUN4I_IRQ_PENDING_REG(0));
+	writel(BIT(0), irq_ic_data->irq_base + SUN4I_IRQ_PENDING_REG(0));
 }
 
 static void sun4i_irq_mask(struct irq_data *irqd)
@@ -53,9 +63,9 @@ static void sun4i_irq_mask(struct irq_data *irqd)
 	int reg = irq / 32;
 	u32 val;
 
-	val = readl(sun4i_irq_base + SUN4I_IRQ_ENABLE_REG(reg));
+	val = readl(irq_ic_data->irq_base + SUN4I_IRQ_ENABLE_REG(reg));
 	writel(val & ~(1 << irq_off),
-	       sun4i_irq_base + SUN4I_IRQ_ENABLE_REG(reg));
+	       irq_ic_data->irq_base + SUN4I_IRQ_ENABLE_REG(reg));
 }
 
 static void sun4i_irq_unmask(struct irq_data *irqd)
@@ -65,9 +75,9 @@ static void sun4i_irq_unmask(struct irq_data *irqd)
 	int reg = irq / 32;
 	u32 val;
 
-	val = readl(sun4i_irq_base + SUN4I_IRQ_ENABLE_REG(reg));
+	val = readl(irq_ic_data->irq_base + SUN4I_IRQ_ENABLE_REG(reg));
 	writel(val | (1 << irq_off),
-	       sun4i_irq_base + SUN4I_IRQ_ENABLE_REG(reg));
+	       irq_ic_data->irq_base + SUN4I_IRQ_ENABLE_REG(reg));
 }
 
 static struct irq_chip sun4i_irq_chip = {
@@ -95,42 +105,76 @@ static const struct irq_domain_ops sun4i_irq_ops = {
 static int __init sun4i_of_init(struct device_node *node,
 				struct device_node *parent)
 {
-	sun4i_irq_base = of_iomap(node, 0);
-	if (!sun4i_irq_base)
+	irq_ic_data->irq_base = of_iomap(node, 0);
+	if (!irq_ic_data->irq_base)
 		panic("%pOF: unable to map IC registers\n",
 			node);
 
 	/* Disable all interrupts */
-	writel(0, sun4i_irq_base + SUN4I_IRQ_ENABLE_REG(0));
-	writel(0, sun4i_irq_base + SUN4I_IRQ_ENABLE_REG(1));
-	writel(0, sun4i_irq_base + SUN4I_IRQ_ENABLE_REG(2));
+	writel(0, irq_ic_data->irq_base + SUN4I_IRQ_ENABLE_REG(0));
+	writel(0, irq_ic_data->irq_base + SUN4I_IRQ_ENABLE_REG(1));
+	writel(0, irq_ic_data->irq_base + SUN4I_IRQ_ENABLE_REG(2));
 
 	/* Unmask all the interrupts, ENABLE_REG(x) is used for masking */
-	writel(0, sun4i_irq_base + SUN4I_IRQ_MASK_REG(0));
-	writel(0, sun4i_irq_base + SUN4I_IRQ_MASK_REG(1));
-	writel(0, sun4i_irq_base + SUN4I_IRQ_MASK_REG(2));
+	writel(0, irq_ic_data->irq_base + SUN4I_IRQ_MASK_REG(0));
+	writel(0, irq_ic_data->irq_base + SUN4I_IRQ_MASK_REG(1));
+	writel(0, irq_ic_data->irq_base + SUN4I_IRQ_MASK_REG(2));
 
 	/* Clear all the pending interrupts */
-	writel(0xffffffff, sun4i_irq_base + SUN4I_IRQ_PENDING_REG(0));
-	writel(0xffffffff, sun4i_irq_base + SUN4I_IRQ_PENDING_REG(1));
-	writel(0xffffffff, sun4i_irq_base + SUN4I_IRQ_PENDING_REG(2));
+	writel(0xffffffff, irq_ic_data->irq_base + SUN4I_IRQ_PENDING_REG(0));
+	writel(0xffffffff, irq_ic_data->irq_base + SUN4I_IRQ_PENDING_REG(1));
+	writel(0xffffffff, irq_ic_data->irq_base + SUN4I_IRQ_PENDING_REG(2));
 
-	/* Enable protection mode */
-	writel(0x01, sun4i_irq_base + SUN4I_IRQ_PROTECTION_REG);
+	/* Enable protection mode (not available in suniv) */
+	if (of_device_is_compatible(node, "allwinner,sun4i-a10-ic"))
+		writel(0x01, irq_ic_data->irq_base + SUN4I_IRQ_PROTECTION_REG);
 
 	/* Configure the external interrupt source type */
-	writel(0x00, sun4i_irq_base + SUN4I_IRQ_NMI_CTRL_REG);
+	writel(0x00, irq_ic_data->irq_base + SUN4I_IRQ_NMI_CTRL_REG);
 
-	sun4i_irq_domain = irq_domain_add_linear(node, 3 * 32,
+	irq_ic_data->irq_domain = irq_domain_add_linear(node, 3 * 32,
 						 &sun4i_irq_ops, NULL);
-	if (!sun4i_irq_domain)
+	if (!irq_ic_data->irq_domain)
 		panic("%pOF: unable to create IRQ domain\n", node);
 
 	set_handle_irq(sun4i_handle_irq);
 
 	return 0;
 }
-IRQCHIP_DECLARE(allwinner_sun4i_ic, "allwinner,sun4i-a10-ic", sun4i_of_init);
+
+static int __init sun4i_ic_of_init(struct device_node *node,
+				   struct device_node *parent)
+{
+	irq_ic_data = kzalloc(sizeof(struct sunxi_irq_chip_data), GFP_KERNEL);
+	if (!irq_ic_data) {
+		pr_err("kzalloc failed!\n");
+		return -ENOMEM;
+	}
+
+	irq_ic_data->enable_req_offset = SUN4I_IRQ_ENABLE_REG_OFFSET;
+	irq_ic_data->mask_req_offset = SUN4I_IRQ_MASK_REG_OFFSET;
+
+	return sun4i_of_init(node, parent);
+}
+
+IRQCHIP_DECLARE(allwinner_sun4i_ic, "allwinner,sun4i-a10-ic", sun4i_ic_of_init);
+
+static int __init suniv_ic_of_init(struct device_node *node,
+				   struct device_node *parent)
+{
+	irq_ic_data = kzalloc(sizeof(struct sunxi_irq_chip_data), GFP_KERNEL);
+	if (!irq_ic_data) {
+		pr_err("kzalloc failed!\n");
+		return -ENOMEM;
+	}
+
+	irq_ic_data->enable_req_offset = SUNIV_IRQ_ENABLE_REG_OFFSET;
+	irq_ic_data->mask_req_offset = SUNIV_IRQ_MASK_REG_OFFSET;
+
+	return sun4i_of_init(node, parent);
+}
+
+IRQCHIP_DECLARE(allwinner_sunvi_ic, "allwinner,suniv-f1c100s-ic", suniv_ic_of_init);
 
 static void __exception_irq_entry sun4i_handle_irq(struct pt_regs *regs)
 {
@@ -146,13 +190,13 @@ static void __exception_irq_entry sun4i_handle_irq(struct pt_regs *regs)
 	 * the extra check in the common case of 1 hapening after having
 	 * read the vector-reg once.
 	 */
-	hwirq = readl(sun4i_irq_base + SUN4I_IRQ_VECTOR_REG) >> 2;
+	hwirq = readl(irq_ic_data->irq_base + SUN4I_IRQ_VECTOR_REG) >> 2;
 	if (hwirq == 0 &&
-		  !(readl(sun4i_irq_base + SUN4I_IRQ_PENDING_REG(0)) & BIT(0)))
+		  !(readl(irq_ic_data->irq_base + SUN4I_IRQ_PENDING_REG(0)) & BIT(0)))
 		return;
 
 	do {
-		handle_domain_irq(sun4i_irq_domain, hwirq, regs);
-		hwirq = readl(sun4i_irq_base + SUN4I_IRQ_VECTOR_REG) >> 2;
+		handle_domain_irq(irq_ic_data->irq_domain, hwirq, regs);
+		hwirq = readl(irq_ic_data->irq_base + SUN4I_IRQ_VECTOR_REG) >> 2;
 	} while (hwirq != 0);
 }
-- 
2.7.4


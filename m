Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A570C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 07:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CABE120867
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 07:43:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kkNyQurs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CABE120867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727571AbeKYSeZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 13:34:25 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35408 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727476AbeKYSeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 13:34:24 -0500
Received: by mail-wr1-f65.google.com with SMTP id 96so15807771wrb.2;
        Sat, 24 Nov 2018 23:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hx/73GujWi0OFIFKsuzy+Xaz7ZA2FpKuR20IY5T6rX4=;
        b=kkNyQurs/iUdYCDUFj0jycqaziHhZbXa/LZeFJNrOBVRS4/G93wIjNxnUUQdDo4XF7
         DgajGDc0fzmzwTPZMvYFPAZv+GJv6DT02rP0iTuS/O9hFpN6Byq/dYPw5Qt7+6a9uGD0
         LmME/r7y9ccjsBj1BoCjBUuCSI5Mq1cdTJ1TV74RWqm/SJgV6zRqvezVYahb2c4qwyll
         fT0le32EJp6GWAZph61+62CJap66rLNUP/GW2M68AsVXj1fDL5Pqc5/Pxstjv5kDS1kc
         KSACf5Q0b8ibX1drVsAc/DU3dg46QaGebIcRaqgQYd3ND3ZUWPR+uIM/yHzTyxlX5Qtn
         LNUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hx/73GujWi0OFIFKsuzy+Xaz7ZA2FpKuR20IY5T6rX4=;
        b=KlfgbqvAEaLbalTf9S2d9tVNLqQA67eWnoBQ0i8gqjE4w8wVTL44A10IDXUwXny4ko
         cX/0Br11RU95dbLohc/9Fx3+VMI+p1tuV9kbWCViU/gKkohzjYInITjlZhiVoRBpsb94
         F9XOku6W1Is9/BxoeDHxc1nS/S5uLu5ss+FWQD4VerysPpGORr7AuItXhdYOL3+znERr
         TMn9tvUBeI51Hba2ZAXEgfi1Gmkqh8cbATa/fK4+yxegWjR6js1m1S+3xCWVJ+fMAjGG
         BtI2mRElb1yjQXUTF4f14ZTMRfOTdGec1+5k8TfASKZal1HFNEq7DL/W75WcDcoqEaBA
         rzKA==
X-Gm-Message-State: AA+aEWbjDfuAVmRTI+YtPjyp+iRnYc0B4I2CC+Yt4SCs2mu4kOpp72wM
        os4VIUQJiyGV6xKYPTFPStGBAmaievQ=
X-Google-Smtp-Source: AFSGD/VMce/hBFbeXN+JEYQ0tTK3Ch0MvFIhxP4INDDgNsNyTgesOgxjeLjoj6rejFXYo8j/vIkuAA==
X-Received: by 2002:a5d:480d:: with SMTP id l13mr20892331wrq.175.1543131834123;
        Sat, 24 Nov 2018 23:43:54 -0800 (PST)
Received: from localhost.localdomain ([185.219.177.224])
        by smtp.gmail.com with ESMTPSA id 6-v6sm12296780wmg.19.2018.11.24.23.43.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 24 Nov 2018 23:43:53 -0800 (PST)
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
Subject: [RFC PATCH v4 05/17] irqchip/sun4i: Add a struct to hold global variables
Date:   Sun, 25 Nov 2018 10:43:08 +0300
Message-Id: <2904a51d360af76765eccfb3b963a867a06a14ee.1543131714.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1543131714.git.mesihkilinc@gmail.com>
References: <cover.1543131714.git.mesihkilinc@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to support different chips, IC specific data should be hold in
a struct. This patch moves irq_base and irq_domain global variables to
struct.

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
---
 drivers/irqchip/irq-sun4i.c | 64 +++++++++++++++++++++++++++------------------
 1 file changed, 38 insertions(+), 26 deletions(-)

diff --git a/drivers/irqchip/irq-sun4i.c b/drivers/irqchip/irq-sun4i.c
index e3e5b91..0c32506 100644
--- a/drivers/irqchip/irq-sun4i.c
+++ b/drivers/irqchip/irq-sun4i.c
@@ -31,8 +31,12 @@
 #define SUN4I_IRQ_ENABLE_REG(x)		(0x40 + 0x4 * x)
 #define SUN4I_IRQ_MASK_REG(x)		(0x50 + 0x4 * x)
 
-static void __iomem *sun4i_irq_base;
-static struct irq_domain *sun4i_irq_domain;
+struct sun4i_irq_chip_data {
+	void __iomem *irq_base;
+	struct irq_domain *irq_domain;
+};
+
+static struct sun4i_irq_chip_data *irq_ic_data;
 
 static void __exception_irq_entry sun4i_handle_irq(struct pt_regs *regs);
 
@@ -43,7 +47,7 @@ static void sun4i_irq_ack(struct irq_data *irqd)
 	if (irq != 0)
 		return; /* Only IRQ 0 / the ENMI needs to be acked */
 
-	writel(BIT(0), sun4i_irq_base + SUN4I_IRQ_PENDING_REG(0));
+	writel(BIT(0), irq_ic_data->irq_base + SUN4I_IRQ_PENDING_REG(0));
 }
 
 static void sun4i_irq_mask(struct irq_data *irqd)
@@ -53,9 +57,9 @@ static void sun4i_irq_mask(struct irq_data *irqd)
 	int reg = irq / 32;
 	u32 val;
 
-	val = readl(sun4i_irq_base + SUN4I_IRQ_ENABLE_REG(reg));
+	val = readl(irq_ic_data->irq_base + SUN4I_IRQ_ENABLE_REG(reg));
 	writel(val & ~(1 << irq_off),
-	       sun4i_irq_base + SUN4I_IRQ_ENABLE_REG(reg));
+	       irq_ic_data->irq_base + SUN4I_IRQ_ENABLE_REG(reg));
 }
 
 static void sun4i_irq_unmask(struct irq_data *irqd)
@@ -65,9 +69,9 @@ static void sun4i_irq_unmask(struct irq_data *irqd)
 	int reg = irq / 32;
 	u32 val;
 
-	val = readl(sun4i_irq_base + SUN4I_IRQ_ENABLE_REG(reg));
+	val = readl(irq_ic_data->irq_base + SUN4I_IRQ_ENABLE_REG(reg));
 	writel(val | (1 << irq_off),
-	       sun4i_irq_base + SUN4I_IRQ_ENABLE_REG(reg));
+	       irq_ic_data->irq_base + SUN4I_IRQ_ENABLE_REG(reg));
 }
 
 static struct irq_chip sun4i_irq_chip = {
@@ -95,35 +99,41 @@ static const struct irq_domain_ops sun4i_irq_ops = {
 static int __init sun4i_of_init(struct device_node *node,
 				struct device_node *parent)
 {
-	sun4i_irq_base = of_iomap(node, 0);
-	if (!sun4i_irq_base)
+	irq_ic_data = kzalloc(sizeof(struct sun4i_irq_chip_data), GFP_KERNEL);
+	if (!irq_ic_data) {
+		pr_err("kzalloc failed!\n");
+		return -ENOMEM;
+	}
+
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
 
 	/* Enable protection mode */
-	writel(0x01, sun4i_irq_base + SUN4I_IRQ_PROTECTION_REG);
+	writel(0x01, irq_ic_data->irq_base + SUN4I_IRQ_PROTECTION_REG);
 
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
@@ -146,13 +156,15 @@ static void __exception_irq_entry sun4i_handle_irq(struct pt_regs *regs)
 	 * the extra check in the common case of 1 hapening after having
 	 * read the vector-reg once.
 	 */
-	hwirq = readl(sun4i_irq_base + SUN4I_IRQ_VECTOR_REG) >> 2;
+	hwirq = readl(irq_ic_data->irq_base + SUN4I_IRQ_VECTOR_REG) >> 2;
 	if (hwirq == 0 &&
-		  !(readl(sun4i_irq_base + SUN4I_IRQ_PENDING_REG(0)) & BIT(0)))
+		  !(readl(irq_ic_data->irq_base + SUN4I_IRQ_PENDING_REG(0)) &
+			  BIT(0)))
 		return;
 
 	do {
-		handle_domain_irq(sun4i_irq_domain, hwirq, regs);
-		hwirq = readl(sun4i_irq_base + SUN4I_IRQ_VECTOR_REG) >> 2;
+		handle_domain_irq(irq_ic_data->irq_domain, hwirq, regs);
+		hwirq = readl(irq_ic_data->irq_base +
+				SUN4I_IRQ_VECTOR_REG) >> 2;
 	} while (hwirq != 0);
 }
-- 
2.7.4


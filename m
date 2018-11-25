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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28EFFC43610
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 07:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E54C120664
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 07:44:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VjEhgCNZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E54C120664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbeKYSe1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 13:34:27 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43342 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbeKYSe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 13:34:26 -0500
Received: by mail-wr1-f66.google.com with SMTP id r10so15763314wrs.10;
        Sat, 24 Nov 2018 23:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jEChEu3344BdHYPwyNpUg8OvRy/artJMWmV46zplrvk=;
        b=VjEhgCNZArW/zyQ4tbDkXJgwqMPxJ4ioXIFwwY6dqG8F0fMVxQrT+wk6T6z2NXfxPd
         aPQKKXbkVbmQOJiAP8oT7Qh+BzhTaDmjTp2eKTgDKQjPVozeP2NQ6BLvyitJnUBvudlx
         vQWF4Dp223M5B5o4pSZdgQuikopVvRDjcYRAEHKcgDucEQVYnp3Oi6kGPcer0Px7wURl
         rm4yoRGsHBeOLUPvasnAfktHb5ziyD5PudJw3kIBZJ0lA/f39/z8EZcMbebTDcDXSBM5
         e/dZJVZjR9c8/41qKKl5Sqjl4tNzk/P8wcyQpcSsyArvyk4n0XGgN6IVhBb8OExQnmIP
         qdsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jEChEu3344BdHYPwyNpUg8OvRy/artJMWmV46zplrvk=;
        b=Sy2PvwJw3KfovZGNMnpuKUFIBejZU/HhhRC9cbqB8nLbZ7wl/0jdbtBMzdxdOcXi7V
         VDJbJ3pwGYsXRCm7DC3BgqCuOYmTxQmC3P3P/HUbnAIAWQuNJoigJWddr/u92M2jUZg8
         Q4+HHqQoyDkNQKmqAAPU5cZJ5wrFbZynipTB73v3CqCtkIvbXzV7mK5o0L6Rc25EXwl1
         gakOgpOEesXAMcG8YJ5AjLEs3AyUQQZoEbNdyardPnIFPvwt+83Pjd2QcL7LYk0/7yjg
         96E/54OzsZgtNLPD0OTgh3CRBKs/3f392jN5fosh2IIfbzQDztfXl15ALZ63olNuqlLW
         Ta+w==
X-Gm-Message-State: AA+aEWasa0uvcajju1N+394atONl7ZqxMPx9tOlO3j4gTcbY/WW2NkI6
        rbM6/KPGU5WdNzpWj2WHmGoY474Zki4=
X-Google-Smtp-Source: AFSGD/VS/IymxqJCJFFznwYQc1Sw+M/bg2M9AGSUNkXhnRCoaKJbBXXop29qHjUQqTAwnV9m5I0fZA==
X-Received: by 2002:a5d:6684:: with SMTP id l4mr21290291wru.154.1543131835958;
        Sat, 24 Nov 2018 23:43:55 -0800 (PST)
Received: from localhost.localdomain ([185.219.177.224])
        by smtp.gmail.com with ESMTPSA id 6-v6sm12296780wmg.19.2018.11.24.23.43.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 24 Nov 2018 23:43:55 -0800 (PST)
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
Subject: [RFC PATCH v4 06/17] irqchip/sun4i: Move IC specific register offsets to struct
Date:   Sun, 25 Nov 2018 10:43:09 +0300
Message-Id: <0242923026be282e26fe9e50d9bb0ec3d5ae355f.1543131714.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1543131714.git.mesihkilinc@gmail.com>
References: <cover.1543131714.git.mesihkilinc@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch moves IC specific register offsets to sun4i_irq_chip_data
struct in order to support different chips.

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
---
 drivers/irqchip/irq-sun4i.c | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/drivers/irqchip/irq-sun4i.c b/drivers/irqchip/irq-sun4i.c
index 0c32506..507f4e3 100644
--- a/drivers/irqchip/irq-sun4i.c
+++ b/drivers/irqchip/irq-sun4i.c
@@ -28,12 +28,16 @@
 #define SUN4I_IRQ_NMI_CTRL_REG		0x0c
 #define SUN4I_IRQ_PENDING_REG(x)	(0x10 + 0x4 * x)
 #define SUN4I_IRQ_FIQ_PENDING_REG(x)	(0x20 + 0x4 * x)
-#define SUN4I_IRQ_ENABLE_REG(x)		(0x40 + 0x4 * x)
-#define SUN4I_IRQ_MASK_REG(x)		(0x50 + 0x4 * x)
+#define SUN4I_IRQ_ENABLE_REG(data, x)	((data)->enable_reg_offset + 0x4 * x)
+#define SUN4I_IRQ_MASK_REG(data, x)	((data)->mask_reg_offset + 0x4 * x)
+#define SUN4I_IRQ_ENABLE_REG_OFFSET	0x40
+#define SUN4I_IRQ_MASK_REG_OFFSET	0x50
 
 struct sun4i_irq_chip_data {
 	void __iomem *irq_base;
 	struct irq_domain *irq_domain;
+	u32 enable_reg_offset;
+	u32 mask_reg_offset;
 };
 
 static struct sun4i_irq_chip_data *irq_ic_data;
@@ -57,9 +61,10 @@ static void sun4i_irq_mask(struct irq_data *irqd)
 	int reg = irq / 32;
 	u32 val;
 
-	val = readl(irq_ic_data->irq_base + SUN4I_IRQ_ENABLE_REG(reg));
+	val = readl(irq_ic_data->irq_base +
+			SUN4I_IRQ_ENABLE_REG(irq_ic_data, reg));
 	writel(val & ~(1 << irq_off),
-	       irq_ic_data->irq_base + SUN4I_IRQ_ENABLE_REG(reg));
+	       irq_ic_data->irq_base + SUN4I_IRQ_ENABLE_REG(irq_ic_data, reg));
 }
 
 static void sun4i_irq_unmask(struct irq_data *irqd)
@@ -69,9 +74,10 @@ static void sun4i_irq_unmask(struct irq_data *irqd)
 	int reg = irq / 32;
 	u32 val;
 
-	val = readl(irq_ic_data->irq_base + SUN4I_IRQ_ENABLE_REG(reg));
+	val = readl(irq_ic_data->irq_base +
+			SUN4I_IRQ_ENABLE_REG(irq_ic_data, reg));
 	writel(val | (1 << irq_off),
-	       irq_ic_data->irq_base + SUN4I_IRQ_ENABLE_REG(reg));
+	       irq_ic_data->irq_base + SUN4I_IRQ_ENABLE_REG(irq_ic_data, reg));
 }
 
 static struct irq_chip sun4i_irq_chip = {
@@ -105,20 +111,23 @@ static int __init sun4i_of_init(struct device_node *node,
 		return -ENOMEM;
 	}
 
+	irq_ic_data->enable_reg_offset = SUN4I_IRQ_ENABLE_REG_OFFSET;
+	irq_ic_data->mask_reg_offset = SUN4I_IRQ_MASK_REG_OFFSET;
+
 	irq_ic_data->irq_base = of_iomap(node, 0);
 	if (!irq_ic_data->irq_base)
 		panic("%pOF: unable to map IC registers\n",
 			node);
 
 	/* Disable all interrupts */
-	writel(0, irq_ic_data->irq_base + SUN4I_IRQ_ENABLE_REG(0));
-	writel(0, irq_ic_data->irq_base + SUN4I_IRQ_ENABLE_REG(1));
-	writel(0, irq_ic_data->irq_base + SUN4I_IRQ_ENABLE_REG(2));
+	writel(0, irq_ic_data->irq_base + SUN4I_IRQ_ENABLE_REG(irq_ic_data, 0));
+	writel(0, irq_ic_data->irq_base + SUN4I_IRQ_ENABLE_REG(irq_ic_data, 1));
+	writel(0, irq_ic_data->irq_base + SUN4I_IRQ_ENABLE_REG(irq_ic_data, 2));
 
 	/* Unmask all the interrupts, ENABLE_REG(x) is used for masking */
-	writel(0, irq_ic_data->irq_base + SUN4I_IRQ_MASK_REG(0));
-	writel(0, irq_ic_data->irq_base + SUN4I_IRQ_MASK_REG(1));
-	writel(0, irq_ic_data->irq_base + SUN4I_IRQ_MASK_REG(2));
+	writel(0, irq_ic_data->irq_base + SUN4I_IRQ_MASK_REG(irq_ic_data, 0));
+	writel(0, irq_ic_data->irq_base + SUN4I_IRQ_MASK_REG(irq_ic_data, 1));
+	writel(0, irq_ic_data->irq_base + SUN4I_IRQ_MASK_REG(irq_ic_data, 2));
 
 	/* Clear all the pending interrupts */
 	writel(0xffffffff, irq_ic_data->irq_base + SUN4I_IRQ_PENDING_REG(0));
-- 
2.7.4


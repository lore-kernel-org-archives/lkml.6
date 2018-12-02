Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C2A5C04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 20:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAC4220851
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 20:24:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ip7YB2KP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAC4220851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725920AbeLBUY2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 15:24:28 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39832 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbeLBUY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 15:24:27 -0500
Received: by mail-wr1-f66.google.com with SMTP id t27so10059313wra.6;
        Sun, 02 Dec 2018 12:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6Tg/Nlf4DVosGXWUAPR1HKg7aUMJ7+jsissUOrruo7A=;
        b=ip7YB2KP/uFzP4hjDqvDTMMAqKjIV2+DA8xEXmeRnJLu9l8IFwiYOXK7vgwn5gFwtv
         YKWVzlWU+lu9LCEjGsHISnjUiAeOT3T101u+myvtj8x53lyXxizmHRcbagnntyIK0YAo
         qBGVOZMZC2MdsI5XAB9f5CrsJ2qCrWV18AFhkB2TnWSHxzoke2W/YkAi3BVU1NBUMTzQ
         +B5yQPQOozGmdE3hf6geB/zIWNF0LTZd0lwOTaD8O6NQlP7ux9jdHBhg/9BSiqZ+PMLK
         B8SMUL/ZjfAsg5eF2w15B1QgXCwpB5JAb2I0+cjtGHxa5Sno85koz5Sjz10Emt6Tqur2
         52QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6Tg/Nlf4DVosGXWUAPR1HKg7aUMJ7+jsissUOrruo7A=;
        b=AheCpegV6GxgLI0kMVgsIXP/ZDhit92OqQyepjGtAhRShM+zPGqIGRmY8E6SttOaam
         c7WS6A9/50Zd5DWhtyWzEkjiOwMDJjWGcgIK6LuHFjd/zkUtJbw7UhyFZPtUoiU0jp5z
         t0xKynVE/EeYPJ16flhu8ERrq3TTpRAKAoxeR6txnAUW1PUPSqwNK4G0IA3L1xJ5Gv8v
         kr4s7V6RebzMVhfsT8RCEfgSsPwp5vHgUa9oopwTkLN1Hvuv58nJ5ZLdWMAEtjewdKpO
         nnMU8zTlH4DdCBHFt3RDMWQC1LpoenVTOJdTArh9wAEtYiCb0TUHPEJNKaevhNQxtHt6
         twGQ==
X-Gm-Message-State: AA+aEWacyEdoOlvYsfSD8cbQW/FD+deT/DInl2qHBm+VqFrXO1AQ3GIJ
        A4EJoWu/yjdgfH4TYznaenprteE4kD4=
X-Google-Smtp-Source: AFSGD/UYA/ZwoZ4cE+mkzHvdE0aO2dQwEm7fduDyEzyRE4V5YN4GOBJWtdIx5rtePcpxa8cIJ1sDZg==
X-Received: by 2002:adf:b102:: with SMTP id l2mr11224233wra.296.1543782260969;
        Sun, 02 Dec 2018 12:24:20 -0800 (PST)
Received: from ThinkPad.home ([185.219.177.152])
        by smtp.gmail.com with ESMTPSA id l3sm14451510wma.44.2018.12.02.12.24.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 02 Dec 2018 12:24:20 -0800 (PST)
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
Subject: [PATCH v6 06/17] irqchip/sun4i: Move IC specific register offsets to struct
Date:   Sun,  2 Dec 2018 23:23:40 +0300
Message-Id: <f1dd4d8331163271cbb4742b33004282678b6ffc.1543781680.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1543781680.git.mesihkilinc@gmail.com>
References: <cover.1543781680.git.mesihkilinc@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch moves IC specific register offsets to sun4i_irq_chip_data
struct in order to support different chips.

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
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


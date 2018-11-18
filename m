Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBD02C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 14:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97D7D20869
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 14:18:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c48ly9tc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97D7D20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbeKSAiz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 19:38:55 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37213 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727551AbeKSAiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 19:38:54 -0500
Received: by mail-wr1-f66.google.com with SMTP id j10so15080637wru.4;
        Sun, 18 Nov 2018 06:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+vPiJ34sistKUFrl1dOh2ZO+lpuKceW8b1URIfA7u8g=;
        b=c48ly9tcTnkrb9ZH9XaCf6bJwzGg1xmusR/bMNnY1CTRJhume3qzRce9XZR27Z0CDV
         2r+4bRBcppclPfZ+JLjLE2hd7jdBJuAn7mXhYNyvgsuGmiLHjo20dgmukKOtQT9r6pzR
         lrZdWodmBj25QDD7OkjQHKNXasSM3pnbRsX+uZxHSqF9OV19cPkAxAkFSZsgtbOHWyBI
         m861MZ49VHYd8F9ADqlPpUglDdl2+EWMfsWLgc6hfi4uBbbfNrHL5WAuwjpXmVzE+xcu
         V6mk/rMhQbFSnsh0KzEl0Pdtgu3fmrCTYgDdMlYJaTW3kUW51kZqlyY7HReNUsy+jcsm
         R7uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+vPiJ34sistKUFrl1dOh2ZO+lpuKceW8b1URIfA7u8g=;
        b=juuB9KrLq6LRW5+LLwZ6Hsu5vOW8QD6hGIgjVOu5GZImjDGY2kzSnYIEXxwHVTNc8G
         /WR3zPAJgbGE3tP91xkp/i17FafxqiEEmDp4gEA/4+XnlHb5+BP7mY12lGmw9eBWb+NX
         kCeqUBFb7m/Vin8lH0YjOisdItwtl+ZAaBijlyDryDNO/oyu1USN1sZ7is7eRGm3OJlF
         ALSZopfcJ4DRulBBjNIJLlYwFZUL+o9gm9Yv2xO+CGxNZ1epB98su4fXIhYBsh3uryqF
         Csej3KBFJ+ofTgUaYScNu0AASun+gPRd+vrqP7EPB6DCU8VbfBQPjMeXar9LppKtEN/i
         +vYg==
X-Gm-Message-State: AA+aEWYvR8uw4zHgw7kbC9+5ANAR1oyp5nzgviGGS82g7F7fMUNhlQJD
        3fiJUjpmSOUgzJQXQUM/Jchus2wSymQ=
X-Google-Smtp-Source: AFSGD/UjRonJWKWq2e9jGAevO/xQJpyAnxZ6lIE8NgeLxpy69cSC06Wv7j3oFaPQ/KZ+aFrgFOIZbQ==
X-Received: by 2002:a5d:454f:: with SMTP id p15mr3431013wrr.39.1542550706269;
        Sun, 18 Nov 2018 06:18:26 -0800 (PST)
Received: from ThinkPad.home ([185.219.176.209])
        by smtp.gmail.com with ESMTPSA id d4sm29814412wrp.89.2018.11.18.06.18.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 18 Nov 2018 06:18:25 -0800 (PST)
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
Subject: [RFC PATCH v2 05/14] irqchip/sun4i: add support for suniv interrupt controller
Date:   Sun, 18 Nov 2018 17:17:04 +0300
Message-Id: <d693414b1693a9018956bcc589a9048e88fbc8f6.1542546735.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1542546735.git.mesihkilinc@gmail.com>
References: <cover.1542546735.git.mesihkilinc@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new F-series SoCs (suniv) from Allwinner use an stripped version of
the interrupt controller in A10/A13.

Add support for it in irq-sun4i driver.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
---
 drivers/irqchip/irq-sun4i.c | 47 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 42 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-sun4i.c b/drivers/irqchip/irq-sun4i.c
index e3e5b91..2abf662 100644
--- a/drivers/irqchip/irq-sun4i.c
+++ b/drivers/irqchip/irq-sun4i.c
@@ -23,13 +23,26 @@
 
 #include <asm/exception.h>
 
+enum sun4i_irq_type {
+	sun4i_ic,
+	suniv_ic
+};
+
+static enum sun4i_irq_type sun4i_irq_type;
+static int sun4i_irq_enable_reg_offset;
+static int sun4i_irq_mask_reg_offset;
+
 #define SUN4I_IRQ_VECTOR_REG		0x00
 #define SUN4I_IRQ_PROTECTION_REG	0x08
 #define SUN4I_IRQ_NMI_CTRL_REG		0x0c
 #define SUN4I_IRQ_PENDING_REG(x)	(0x10 + 0x4 * x)
 #define SUN4I_IRQ_FIQ_PENDING_REG(x)	(0x20 + 0x4 * x)
-#define SUN4I_IRQ_ENABLE_REG(x)		(0x40 + 0x4 * x)
-#define SUN4I_IRQ_MASK_REG(x)		(0x50 + 0x4 * x)
+#define SUN4I_IRQ_ENABLE_REG_OFFSET	0x40
+#define SUN4I_IRQ_MASK_REG_OFFSET	0x50
+#define SUNIV_IRQ_ENABLE_REG_OFFSET	0x20
+#define SUNIV_IRQ_MASK_REG_OFFSET	0x30
+#define SUN4I_IRQ_ENABLE_REG(x)		(sun4i_irq_enable_reg_offset + 0x4 * x)
+#define SUN4I_IRQ_MASK_REG(x)		(sun4i_irq_mask_reg_offset + 0x4 * x)
 
 static void __iomem *sun4i_irq_base;
 static struct irq_domain *sun4i_irq_domain;
@@ -115,8 +128,9 @@ static int __init sun4i_of_init(struct device_node *node,
 	writel(0xffffffff, sun4i_irq_base + SUN4I_IRQ_PENDING_REG(1));
 	writel(0xffffffff, sun4i_irq_base + SUN4I_IRQ_PENDING_REG(2));
 
-	/* Enable protection mode */
-	writel(0x01, sun4i_irq_base + SUN4I_IRQ_PROTECTION_REG);
+	/* Enable protection mode (not available in suniv) */
+	if (sun4i_irq_type == sun4i_ic)
+		writel(0x01, sun4i_irq_base + SUN4I_IRQ_PROTECTION_REG);
 
 	/* Configure the external interrupt source type */
 	writel(0x00, sun4i_irq_base + SUN4I_IRQ_NMI_CTRL_REG);
@@ -130,7 +144,30 @@ static int __init sun4i_of_init(struct device_node *node,
 
 	return 0;
 }
-IRQCHIP_DECLARE(allwinner_sun4i_ic, "allwinner,sun4i-a10-ic", sun4i_of_init);
+
+static int __init sun4i_ic_of_init(struct device_node *node,
+				   struct device_node *parent)
+{
+	sun4i_irq_type = sun4i_ic;
+	sun4i_irq_enable_reg_offset = SUN4I_IRQ_ENABLE_REG_OFFSET;
+	sun4i_irq_mask_reg_offset = SUN4I_IRQ_MASK_REG_OFFSET;
+	sun4i_of_init(node, parent);
+
+	return 0;
+}
+IRQCHIP_DECLARE(allwinner_sun4i_ic, "allwinner,sun4i-a10-ic", sun4i_ic_of_init);
+
+static int __init suniv_ic_of_init(struct device_node *node,
+				   struct device_node *parent)
+{
+	sun4i_irq_type = suniv_ic;
+	sun4i_irq_enable_reg_offset = SUNIV_IRQ_ENABLE_REG_OFFSET;
+	sun4i_irq_mask_reg_offset = SUNIV_IRQ_MASK_REG_OFFSET;
+	sun4i_of_init(node, parent);
+
+	return 0;
+}
+IRQCHIP_DECLARE(allwinner_suniv_ic, "allwinner,suniv-f1c100s-ic", suniv_ic_of_init);
 
 static void __exception_irq_entry sun4i_handle_irq(struct pt_regs *regs)
 {
-- 
2.7.4


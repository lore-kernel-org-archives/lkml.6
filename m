Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5935CC65BAE
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 20:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BB1920851
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 20:24:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L8v7t5zb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BB1920851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725936AbeLBUY3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 15:24:29 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53685 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbeLBUY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 15:24:28 -0500
Received: by mail-wm1-f68.google.com with SMTP id y1so3691535wmi.3;
        Sun, 02 Dec 2018 12:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=U5HquPP+e02dVOAMk7E3AUX6XcA/ii1Z/T8jnzUactc=;
        b=L8v7t5zbQqh3/DPYoJLHYE40hz4yqDp09mr0+ytfO+988shSCu9X7GkxbxVX0Fvdec
         IO6VkFhMbltF92r1jmInr2Cd+4dCc6zxZoMBfd1Z3rTzVdhZBI6Zsqu4gsmC2np5D4EQ
         dRBXjcmy0GoWomDyQlSzAZw8Hpu7xx2Nq5Q22UeEH/aJulByTagBEPWI2SKRXPKt0JNA
         UnjiJ8O6fvT+AN4CBEU44l8BiTiNCY8//BAs9eFepowwyfZQka5AfketwwXGcrewxz0j
         MfwYqf+VLOKqmgGZiuNpXIGPJv3gxocJp34ct4FujbpTHvBJvGV1Mv9SfK/xi8xeleLr
         tlKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=U5HquPP+e02dVOAMk7E3AUX6XcA/ii1Z/T8jnzUactc=;
        b=SMhhWvC3atd+EEzmGUn/pzWl+yK2pED2qO4GeRYqazuJ0ICx85mEckTDJX0YJeLpXa
         uHBPCL9cvkFXH76uX0BNhldYNzm8in6wDhzcEYjn6cgI7Bkj8Z42u9Jqkei2pIfxp78D
         zCbVZYdUB7GjMf5gYsmEczEkGu7s2LSIWKTLSFV4R471i2OzehR44zoF1A+vTY7m41Kj
         hRA3df0bJY9kMXIqBKlRUKDggUeLBBcYOXAbre/odstHS9A4Bn+K5Qz2XqzP0QxLmGNG
         3AagrRrLrnzqyV9irMIkdA12IsPZJ2lO8DW2eZFnwmraCZpnnTeifk1YRQndKJLhJehW
         +/+g==
X-Gm-Message-State: AA+aEWZpKAN+Lzs8icIhG6rG9iceCmZNFK8U5LCToL1TUCZltCI+L44e
        Vna1UPm6ac111gpW1EXV1yh/xoNim70=
X-Google-Smtp-Source: AFSGD/UFKK2jtp9cBl8PYI9aqb6iLHAmap/42TqW2mdTbBNEWU2kbvckHWh2BcLHDt88Mu+0GCuM6g==
X-Received: by 2002:a1c:c148:: with SMTP id r69mr5870493wmf.147.1543782262710;
        Sun, 02 Dec 2018 12:24:22 -0800 (PST)
Received: from ThinkPad.home ([185.219.177.152])
        by smtp.gmail.com with ESMTPSA id l3sm14451510wma.44.2018.12.02.12.24.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 02 Dec 2018 12:24:22 -0800 (PST)
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
Subject: [PATCH v6 07/17] irqchip/sun4i: Add support for Allwinner ARMv5 F1C100s
Date:   Sun,  2 Dec 2018 23:23:41 +0300
Message-Id: <5fe6eafae0bd8994dcdb5ea6b9255a64e6cdf02c.1543781680.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1543781680.git.mesihkilinc@gmail.com>
References: <cover.1543781680.git.mesihkilinc@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for suniv Allwinner ARMv5 F1C100s SoC which has
stripped version of interrupt controller that found in A10/A13.

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 drivers/irqchip/irq-sun4i.c | 47 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 37 insertions(+), 10 deletions(-)

diff --git a/drivers/irqchip/irq-sun4i.c b/drivers/irqchip/irq-sun4i.c
index 507f4e3..fb78d66 100644
--- a/drivers/irqchip/irq-sun4i.c
+++ b/drivers/irqchip/irq-sun4i.c
@@ -32,6 +32,8 @@
 #define SUN4I_IRQ_MASK_REG(data, x)	((data)->mask_reg_offset + 0x4 * x)
 #define SUN4I_IRQ_ENABLE_REG_OFFSET	0x40
 #define SUN4I_IRQ_MASK_REG_OFFSET	0x50
+#define SUNIV_IRQ_ENABLE_REG_OFFSET	0x20
+#define SUNIV_IRQ_MASK_REG_OFFSET	0x30
 
 struct sun4i_irq_chip_data {
 	void __iomem *irq_base;
@@ -105,15 +107,6 @@ static const struct irq_domain_ops sun4i_irq_ops = {
 static int __init sun4i_of_init(struct device_node *node,
 				struct device_node *parent)
 {
-	irq_ic_data = kzalloc(sizeof(struct sun4i_irq_chip_data), GFP_KERNEL);
-	if (!irq_ic_data) {
-		pr_err("kzalloc failed!\n");
-		return -ENOMEM;
-	}
-
-	irq_ic_data->enable_reg_offset = SUN4I_IRQ_ENABLE_REG_OFFSET;
-	irq_ic_data->mask_reg_offset = SUN4I_IRQ_MASK_REG_OFFSET;
-
 	irq_ic_data->irq_base = of_iomap(node, 0);
 	if (!irq_ic_data->irq_base)
 		panic("%pOF: unable to map IC registers\n",
@@ -149,7 +142,41 @@ static int __init sun4i_of_init(struct device_node *node,
 
 	return 0;
 }
-IRQCHIP_DECLARE(allwinner_sun4i_ic, "allwinner,sun4i-a10-ic", sun4i_of_init);
+
+static int __init sun4i_ic_of_init(struct device_node *node,
+				   struct device_node *parent)
+{
+	irq_ic_data = kzalloc(sizeof(struct sun4i_irq_chip_data), GFP_KERNEL);
+	if (!irq_ic_data) {
+		pr_err("kzalloc failed!\n");
+		return -ENOMEM;
+	}
+
+	irq_ic_data->enable_reg_offset = SUN4I_IRQ_ENABLE_REG_OFFSET;
+	irq_ic_data->mask_reg_offset = SUN4I_IRQ_MASK_REG_OFFSET;
+
+	return sun4i_of_init(node, parent);
+}
+
+IRQCHIP_DECLARE(allwinner_sun4i_ic, "allwinner,sun4i-a10-ic", sun4i_ic_of_init);
+
+static int __init suniv_ic_of_init(struct device_node *node,
+				   struct device_node *parent)
+{
+	irq_ic_data = kzalloc(sizeof(struct sun4i_irq_chip_data), GFP_KERNEL);
+	if (!irq_ic_data) {
+		pr_err("kzalloc failed!\n");
+		return -ENOMEM;
+	}
+
+	irq_ic_data->enable_reg_offset = SUNIV_IRQ_ENABLE_REG_OFFSET;
+	irq_ic_data->mask_reg_offset = SUNIV_IRQ_MASK_REG_OFFSET;
+
+	return sun4i_of_init(node, parent);
+}
+
+IRQCHIP_DECLARE(allwinner_sunvi_ic, "allwinner,suniv-f1c100s-ic",
+		suniv_ic_of_init);
 
 static void __exception_irq_entry sun4i_handle_irq(struct pt_regs *regs)
 {
-- 
2.7.4


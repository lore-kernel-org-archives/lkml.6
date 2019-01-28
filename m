Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE83C282CF
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5573B2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:29:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoho.com header.i=zhouyanjie@zoho.com header.b="f1yk6231"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbfA1P3R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:29:17 -0500
Received: from sender-pp-092.zoho.com ([135.84.80.237]:25432 "EHLO
        sender-pp-092.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726682AbfA1P3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:29:16 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1548688894; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=ebVthaQO/YpPCYME8EkD9qHyD1dLhDq07hnD/NJstRmXPD3Dbthvf0zULhkSAXE5dW6zAIIkxmWKYp19ig41gbUVa4t7pdQAEhshXvzd97wOZqPUQ6B03VJx57j2EYvp8Ihl500NCKYSVCujbwUo+dLP7Hwa6MCbzAGC3fHslhk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1548688894; h=Cc:Date:From:In-Reply-To:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=F/vfvPOl7aaGfBS9OEFOGwA8s6Wy8stG3T8xOq0RL2k=; 
        b=JzqCq2ABHA9qyY9YBZcGIyzkfXzYzvP4Ko+SSyG9Rzg4U9jIMv6h67FZrwd6lQZ8glEh4+gDw/8zUebWEskmAqxIevhAgdMwY3fO2t42ZJJkzc/kiUxUCyRoauNg5LzE3VQZsrlTwuNakHLtqrHGomAbPtRZS4IcrmO/VmgjNSo=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=zhouyanjie@zoho.com;
        dmarc=pass header.from=<zhouyanjie@zoho.com> header.from=<zhouyanjie@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id:in-reply-to:references; 
  b=J/1Yn1VDMfIAfRuLJHiszfbfaL+b3Zf2YmvDCZr1qvsfUI3cAI+v8gXEjYr+sOO2W8bAaocpJ1l/
    yu3GoTGotg7AguPkqFfdneOBRD/QT93oBTUs0n6Ioix+uXiv1fZB  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1548688894;
        s=default; d=zoho.com; i=zhouyanjie@zoho.com;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        l=5800; bh=F/vfvPOl7aaGfBS9OEFOGwA8s6Wy8stG3T8xOq0RL2k=;
        b=f1yk6231jqYYsZnkb/jg6qLyupMne43bgTo9bHkqgc0wZY3gPUE7ymIgs3eaAipb
        Dj3EzXwTBVhtMeHOTY6JSxM9PqzeLGKO6oURYmT6F1JlycN4e2zq9uhLbN9IPwGE0mO
        4qtfqfnjbZGcEpatqwLxm4GnYsT0Mk8qmNIdW8+s=
Received: from localhost.localdomain (171.221.112.7 [171.221.112.7]) by mx.zohomail.com
        with SMTPS id 1548688892042941.0531170337883; Mon, 28 Jan 2019 07:21:32 -0800 (PST)
From:   Zhou Yanjie <zhouyanjie@zoho.com>
To:     linus.walleij@linaro.org
Cc:     linux-mips@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, paul.burton@mips.com,
        paul@crapouillou.net, syq@debian.org, jiaxun.yang@flygoat.com,
        772753199@qq.com, Zhou Yanjie <zhouyanjie@cduestc.edu.cn>
Subject: [PATCH v2 3/3] Pinctrl: Ingenic: Unify the function name prefix to "ingenic_gpio_".
Date:   Mon, 28 Jan 2019 23:19:59 +0800
Message-Id: <1548688799-129840-4-git-send-email-zhouyanjie@zoho.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548688799-129840-1-git-send-email-zhouyanjie@zoho.com>
References: <1548410393-6981-1-git-send-email-zhouyanjie@zoho.com>
 <1548688799-129840-1-git-send-email-zhouyanjie@zoho.com>
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhou Yanjie <zhouyanjie@cduestc.edu.cn>

In the original code, some function names begin with "ingenic_gpio_",
and some with "gpio_ingenic_". For the sake of uniform style,
all of them are changed to the beginning of "ingenic_gpio_".

Signed-off-by: Zhou Yanjie <zhouyanjie@cduestc.edu.cn>
---
 drivers/pinctrl/pinctrl-ingenic.c | 46 +++++++++++++++++++--------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-ingenic.c b/drivers/pinctrl/pinctrl-ingenic.c
index 6501f35..2b3f7e4 100644
--- a/drivers/pinctrl/pinctrl-ingenic.c
+++ b/drivers/pinctrl/pinctrl-ingenic.c
@@ -715,7 +715,7 @@ static const struct ingenic_chip_info jz4780_chip_info = {
 	.pull_downs = jz4770_pull_downs,
 };
 
-static u32 gpio_ingenic_read_reg(struct ingenic_gpio_chip *jzgc, u8 reg)
+static u32 ingenic_gpio_read_reg(struct ingenic_gpio_chip *jzgc, u8 reg)
 {
 	unsigned int val;
 
@@ -724,7 +724,7 @@ static u32 gpio_ingenic_read_reg(struct ingenic_gpio_chip *jzgc, u8 reg)
 	return (u32) val;
 }
 
-static void gpio_ingenic_set_bit(struct ingenic_gpio_chip *jzgc,
+static void ingenic_gpio_set_bit(struct ingenic_gpio_chip *jzgc,
 		u8 reg, u8 offset, bool set)
 {
 	if (set)
@@ -738,7 +738,7 @@ static void gpio_ingenic_set_bit(struct ingenic_gpio_chip *jzgc,
 static inline bool ingenic_gpio_get_value(struct ingenic_gpio_chip *jzgc,
 					  u8 offset)
 {
-	unsigned int val = gpio_ingenic_read_reg(jzgc, GPIO_PIN);
+	unsigned int val = ingenic_gpio_read_reg(jzgc, GPIO_PIN);
 
 	return !!(val & BIT(offset));
 }
@@ -747,9 +747,9 @@ static void ingenic_gpio_set_value(struct ingenic_gpio_chip *jzgc,
 				   u8 offset, int value)
 {
 	if (jzgc->jzpc->version >= ID_JZ4770)
-		gpio_ingenic_set_bit(jzgc, JZ4770_GPIO_PAT0, offset, !!value);
+		ingenic_gpio_set_bit(jzgc, JZ4770_GPIO_PAT0, offset, !!value);
 	else
-		gpio_ingenic_set_bit(jzgc, JZ4740_GPIO_DATA, offset, !!value);
+		ingenic_gpio_set_bit(jzgc, JZ4740_GPIO_DATA, offset, !!value);
 }
 
 static void irq_set_type(struct ingenic_gpio_chip *jzgc,
@@ -767,21 +767,21 @@ static void irq_set_type(struct ingenic_gpio_chip *jzgc,
 
 	switch (type) {
 	case IRQ_TYPE_EDGE_RISING:
-		gpio_ingenic_set_bit(jzgc, reg2, offset, true);
-		gpio_ingenic_set_bit(jzgc, reg1, offset, true);
+		ingenic_gpio_set_bit(jzgc, reg2, offset, true);
+		ingenic_gpio_set_bit(jzgc, reg1, offset, true);
 		break;
 	case IRQ_TYPE_EDGE_FALLING:
-		gpio_ingenic_set_bit(jzgc, reg2, offset, false);
-		gpio_ingenic_set_bit(jzgc, reg1, offset, true);
+		ingenic_gpio_set_bit(jzgc, reg2, offset, false);
+		ingenic_gpio_set_bit(jzgc, reg1, offset, true);
 		break;
 	case IRQ_TYPE_LEVEL_HIGH:
-		gpio_ingenic_set_bit(jzgc, reg2, offset, true);
-		gpio_ingenic_set_bit(jzgc, reg1, offset, false);
+		ingenic_gpio_set_bit(jzgc, reg2, offset, true);
+		ingenic_gpio_set_bit(jzgc, reg1, offset, false);
 		break;
 	case IRQ_TYPE_LEVEL_LOW:
 	default:
-		gpio_ingenic_set_bit(jzgc, reg2, offset, false);
-		gpio_ingenic_set_bit(jzgc, reg1, offset, false);
+		ingenic_gpio_set_bit(jzgc, reg2, offset, false);
+		ingenic_gpio_set_bit(jzgc, reg1, offset, false);
 		break;
 	}
 }
@@ -791,7 +791,7 @@ static void ingenic_gpio_irq_mask(struct irq_data *irqd)
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(irqd);
 	struct ingenic_gpio_chip *jzgc = gpiochip_get_data(gc);
 
-	gpio_ingenic_set_bit(jzgc, GPIO_MSK, irqd->hwirq, true);
+	ingenic_gpio_set_bit(jzgc, GPIO_MSK, irqd->hwirq, true);
 }
 
 static void ingenic_gpio_irq_unmask(struct irq_data *irqd)
@@ -799,7 +799,7 @@ static void ingenic_gpio_irq_unmask(struct irq_data *irqd)
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(irqd);
 	struct ingenic_gpio_chip *jzgc = gpiochip_get_data(gc);
 
-	gpio_ingenic_set_bit(jzgc, GPIO_MSK, irqd->hwirq, false);
+	ingenic_gpio_set_bit(jzgc, GPIO_MSK, irqd->hwirq, false);
 }
 
 static void ingenic_gpio_irq_enable(struct irq_data *irqd)
@@ -809,9 +809,9 @@ static void ingenic_gpio_irq_enable(struct irq_data *irqd)
 	int irq = irqd->hwirq;
 
 	if (jzgc->jzpc->version >= ID_JZ4770)
-		gpio_ingenic_set_bit(jzgc, JZ4770_GPIO_INT, irq, true);
+		ingenic_gpio_set_bit(jzgc, JZ4770_GPIO_INT, irq, true);
 	else
-		gpio_ingenic_set_bit(jzgc, JZ4740_GPIO_SELECT, irq, true);
+		ingenic_gpio_set_bit(jzgc, JZ4740_GPIO_SELECT, irq, true);
 
 	ingenic_gpio_irq_unmask(irqd);
 }
@@ -825,9 +825,9 @@ static void ingenic_gpio_irq_disable(struct irq_data *irqd)
 	ingenic_gpio_irq_mask(irqd);
 
 	if (jzgc->jzpc->version >= ID_JZ4770)
-		gpio_ingenic_set_bit(jzgc, JZ4770_GPIO_INT, irq, false);
+		ingenic_gpio_set_bit(jzgc, JZ4770_GPIO_INT, irq, false);
 	else
-		gpio_ingenic_set_bit(jzgc, JZ4740_GPIO_SELECT, irq, false);
+		ingenic_gpio_set_bit(jzgc, JZ4740_GPIO_SELECT, irq, false);
 }
 
 static void ingenic_gpio_irq_ack(struct irq_data *irqd)
@@ -850,9 +850,9 @@ static void ingenic_gpio_irq_ack(struct irq_data *irqd)
 	}
 
 	if (jzgc->jzpc->version >= ID_JZ4770)
-		gpio_ingenic_set_bit(jzgc, JZ4770_GPIO_FLAG, irq, false);
+		ingenic_gpio_set_bit(jzgc, JZ4770_GPIO_FLAG, irq, false);
 	else
-		gpio_ingenic_set_bit(jzgc, JZ4740_GPIO_DATA, irq, true);
+		ingenic_gpio_set_bit(jzgc, JZ4740_GPIO_DATA, irq, true);
 }
 
 static int ingenic_gpio_irq_set_type(struct irq_data *irqd, unsigned int type)
@@ -907,9 +907,9 @@ static void ingenic_gpio_irq_handler(struct irq_desc *desc)
 	chained_irq_enter(irq_chip, desc);
 
 	if (jzgc->jzpc->version >= ID_JZ4770)
-		flag = gpio_ingenic_read_reg(jzgc, JZ4770_GPIO_FLAG);
+		flag = ingenic_gpio_read_reg(jzgc, JZ4770_GPIO_FLAG);
 	else
-		flag = gpio_ingenic_read_reg(jzgc, JZ4740_GPIO_FLAG);
+		flag = ingenic_gpio_read_reg(jzgc, JZ4740_GPIO_FLAG);
 
 	for_each_set_bit(i, &flag, 32)
 		generic_handle_irq(irq_linear_revmap(gc->irq.domain, i));
-- 
2.7.4



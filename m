Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B932FC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 14:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E8BA20870
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 14:15:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="rmSa0x51"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbfAWOPv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 09:15:51 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37630 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbfAWOPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 09:15:49 -0500
Received: by mail-wr1-f65.google.com with SMTP id s12so2641428wrt.4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 06:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u1cvKiJKGLS50bVRlMfC4FARes9V6DDs6i6g/M3Az2U=;
        b=rmSa0x51VYbRz8O9mIOaDkYOIvrbZX5kf4I2ybvzFOenjtXU2TBU+a1QGc+JTwLtZ7
         kIeubIhLf+AwpKuQWNORHAax7AeYXbkHCFR0jjn5Si/FBzs+prZKSAaD23y1W0oeBFgZ
         BdXsM9ft2M/UdhNpkeMXUZiR84mP2PnFOo5UK5XSPXZ79SOIu/y0bPR9n1ybRgLWsiiu
         mIhwj7CeAaL+Pp3brXqyNh+FFyfzyhTrTJjaZEg8bZl0salqSKIZ+t6jrXUSgN3u8GtV
         GvW2dUzi2q3i507wsX7zZP66gdb6UgwMmrAi53RPLxC82bb8/TzmA6cOi3WhA2FJHAJd
         E0ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u1cvKiJKGLS50bVRlMfC4FARes9V6DDs6i6g/M3Az2U=;
        b=YfCPnQjyq9OZYAjRgdBwjsuSQw4kKjgDEdQ4d8wmiqFFGUIUI13DJWqRqLUPQVsJo6
         rr6XFocFvvwK/d2V3cAYXjRbg702xlT+jC4TiTyQepKHugw+VHFw4Yh+fMP1PkluOo2z
         yULCDG49Pa+YpNPca4n0cwR3+/o5ElX7D4GD2J74TcwNSjKJNPxGocGf6HK2ogIXmwhM
         bcgj155ub5cNRFYNsRkRgr7OUbXNh9v+MWX8l7n96NL9Zo5Fl7Y8QT44m3Z/dxV5lVX4
         4Vr9GbHlF+Hzl99VksXtFMZrpjw8NGEW4J6xYmON4ym1bIwgQjz9tUPpAxvfb2sy1/j5
         EK2w==
X-Gm-Message-State: AJcUukcrWAk3nfpCVRjBCZ/IXOeZpYNXNp9NgwcikxZS7Ah4RuCD/CAR
        eUyIy+e50NwgKgynyI9V0iEakorED+4=
X-Google-Smtp-Source: ALg8bN6kwSpdDH8h4W3437pzNAYU6xRbAUMRU6hdIkRPsTV16Oo7mQNrmqZY4fR2hb6ER+UvxGJrgg==
X-Received: by 2002:a5d:664a:: with SMTP id f10mr2953315wrw.311.1548252947720;
        Wed, 23 Jan 2019 06:15:47 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id a8sm29072997wme.23.2019.01.23.06.15.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 06:15:47 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 2/9] irq/irq_sim: use irq domain
Date:   Wed, 23 Jan 2019 15:15:31 +0100
Message-Id: <20190123141538.29408-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190123141538.29408-1-brgl@bgdev.pl>
References: <20190123141538.29408-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Delegate the offset to virq number mapping to the provided framework
instead of handling it locally.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 include/linux/irq_sim.h |  6 +--
 kernel/irq/irq_sim.c    | 94 +++++++++++++++++++++++++++++------------
 2 files changed, 71 insertions(+), 29 deletions(-)

diff --git a/include/linux/irq_sim.h b/include/linux/irq_sim.h
index eda132c22b57..b96c2f752320 100644
--- a/include/linux/irq_sim.h
+++ b/include/linux/irq_sim.h
@@ -8,6 +8,7 @@
 
 #include <linux/irq.h>
 #include <linux/irq_work.h>
+#include <linux/irqdomain.h>
 #include <linux/device.h>
 
 /*
@@ -21,16 +22,15 @@ struct irq_sim_work_ctx {
 };
 
 struct irq_sim_irq_ctx {
-	int			irqnum;
 	bool			enabled;
 };
 
 struct irq_sim {
 	struct irq_chip		chip;
+	struct irq_domain	*domain;
 	struct irq_sim_work_ctx	work_ctx;
-	int			irq_base;
+	int			virq_base;
 	unsigned int		irq_count;
-	struct irq_sim_irq_ctx	*irqs;
 };
 
 int irq_sim_init(struct irq_sim *sim, unsigned int num_irqs);
diff --git a/kernel/irq/irq_sim.c b/kernel/irq/irq_sim.c
index b732e4e2e45b..2bcdbab1bc5a 100644
--- a/kernel/irq/irq_sim.c
+++ b/kernel/irq/irq_sim.c
@@ -44,6 +44,43 @@ static void irq_sim_handle_irq(struct irq_work *work)
 	}
 }
 
+static int irq_sim_domain_map(struct irq_domain *domain,
+			      unsigned int virq, irq_hw_number_t hw)
+{
+	struct irq_sim *sim = domain->host_data;
+	struct irq_sim_irq_ctx *ctx;
+
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	irq_set_chip(virq, &sim->chip);
+	irq_set_chip_data(virq, ctx);
+	irq_set_handler(virq, handle_simple_irq);
+	irq_modify_status(virq, IRQ_NOREQUEST | IRQ_NOAUTOEN, IRQ_NOPROBE);
+
+	return 0;
+}
+
+static void irq_sim_domain_free(struct irq_domain *domain,
+				unsigned int virq, unsigned int num_irqs)
+{
+	struct irq_sim_irq_ctx *ctx;
+	struct irq_data *irq;
+	int i;
+
+	for (i = 0; i < num_irqs; i++) {
+		irq = irq_domain_get_irq_data(domain, virq + i);
+		ctx = irq_data_get_irq_chip_data(irq);
+		kfree(ctx);
+	}
+}
+
+static const struct irq_domain_ops irq_sim_domain_ops = {
+	.map = irq_sim_domain_map,
+	.free = irq_sim_domain_free,
+};
+
 /**
  * irq_sim_init - Initialize the interrupt simulator: allocate a range of
  *                dummy interrupts.
@@ -56,16 +93,15 @@ static void irq_sim_handle_irq(struct irq_work *work)
  */
 int irq_sim_init(struct irq_sim *sim, unsigned int num_irqs)
 {
-	int i;
-
-	sim->irqs = kmalloc_array(num_irqs, sizeof(*sim->irqs), GFP_KERNEL);
-	if (!sim->irqs)
+	sim->virq_base = irq_alloc_descs(-1, 0, num_irqs, 0);
+	if (sim->virq_base < 0)
+		return sim->virq_base;
+
+	sim->domain = irq_domain_add_legacy(NULL, num_irqs, sim->virq_base,
+					    0, &irq_sim_domain_ops, sim);
+	if (!sim->domain) {
+		irq_free_descs(sim->virq_base, num_irqs);
 		return -ENOMEM;
-
-	sim->irq_base = irq_alloc_descs(-1, 0, num_irqs, 0);
-	if (sim->irq_base < 0) {
-		kfree(sim->irqs);
-		return sim->irq_base;
 	}
 
 	sim->chip.name = "irq_sim";
@@ -74,25 +110,15 @@ int irq_sim_init(struct irq_sim *sim, unsigned int num_irqs)
 
 	sim->work_ctx.pending = bitmap_zalloc(num_irqs, GFP_KERNEL);
 	if (!sim->work_ctx.pending) {
-		kfree(sim->irqs);
-		irq_free_descs(sim->irq_base, num_irqs);
+		irq_domain_remove(sim->domain);
+		irq_free_descs(sim->virq_base, num_irqs);
 		return -ENOMEM;
 	}
 
-	for (i = 0; i < num_irqs; i++) {
-		sim->irqs[i].irqnum = sim->irq_base + i;
-		sim->irqs[i].enabled = false;
-		irq_set_chip(sim->irq_base + i, &sim->chip);
-		irq_set_chip_data(sim->irq_base + i, &sim->irqs[i]);
-		irq_set_handler(sim->irq_base + i, &handle_simple_irq);
-		irq_modify_status(sim->irq_base + i,
-				  IRQ_NOREQUEST | IRQ_NOAUTOEN, IRQ_NOPROBE);
-	}
-
 	init_irq_work(&sim->work_ctx.work, irq_sim_handle_irq);
 	sim->irq_count = num_irqs;
 
-	return sim->irq_base;
+	return sim->virq_base;
 }
 EXPORT_SYMBOL_GPL(irq_sim_init);
 
@@ -106,8 +132,8 @@ void irq_sim_fini(struct irq_sim *sim)
 {
 	irq_work_sync(&sim->work_ctx.work);
 	bitmap_free(sim->work_ctx.pending);
-	irq_free_descs(sim->irq_base, sim->irq_count);
-	kfree(sim->irqs);
+	irq_domain_free_irqs(sim->virq_base, sim->irq_count);
+	irq_domain_remove(sim->domain);
 }
 EXPORT_SYMBOL_GPL(irq_sim_fini);
 
@@ -151,6 +177,20 @@ int devm_irq_sim_init(struct device *dev, struct irq_sim *sim,
 }
 EXPORT_SYMBOL_GPL(devm_irq_sim_init);
 
+static struct irq_sim_irq_ctx *
+irq_sim_get_ctx(struct irq_sim *sim, unsigned int offset)
+{
+	struct irq_sim_irq_ctx *ctx;
+	struct irq_data *irq;
+	int virq;
+
+	virq = irq_find_mapping(sim->domain, offset);
+	irq = irq_domain_get_irq_data(sim->domain, virq);
+	ctx = irq_data_get_irq_chip_data(irq);
+
+	return ctx;
+}
+
 /**
  * irq_sim_fire - Enqueue an interrupt.
  *
@@ -159,7 +199,9 @@ EXPORT_SYMBOL_GPL(devm_irq_sim_init);
  */
 void irq_sim_fire(struct irq_sim *sim, unsigned int offset)
 {
-	if (sim->irqs[offset].enabled) {
+	struct irq_sim_irq_ctx *ctx = irq_sim_get_ctx(sim, offset);
+
+	if (ctx->enabled) {
 		set_bit(offset, sim->work_ctx.pending);
 		irq_work_queue(&sim->work_ctx.work);
 	}
@@ -175,6 +217,6 @@ EXPORT_SYMBOL_GPL(irq_sim_fire);
  */
 int irq_sim_irqnum(struct irq_sim *sim, unsigned int offset)
 {
-	return sim->irqs[offset].irqnum;
+	return irq_find_mapping(sim->domain, offset);
 }
 EXPORT_SYMBOL_GPL(irq_sim_irqnum);
-- 
2.19.1


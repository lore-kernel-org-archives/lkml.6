Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B276FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 13:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76AB4222B6
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 13:43:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="B0Nug/r+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436752AbfBNNnC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 08:43:02 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54815 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390507AbfBNNm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 08:42:59 -0500
Received: by mail-wm1-f67.google.com with SMTP id a62so6341185wmh.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 05:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AQxFI5IaDScBSYM2QiGDnhYF78mzPrJfNlrHBt3eAfM=;
        b=B0Nug/r+Q1ktchEW3T1m9wUXpJgBTvAM02A+j0HJOfNKcIQcHy7eIKmbmKYrcM1vti
         QOmv7AQG+eP1s9itAN0yk72AFnTT3G2Ye4MMjF3GClwGhckvMMMAMfFhtuW3KdVc1PiZ
         9YcCiPBQKmQGbfdFR6UJdtOfeqmI6vCE0SVP8p5gPSElniElLTEpbobcoCI0iBrpmanV
         ckNWQ+BVvTdD/7pem4Fkzimesrtny/lUeKPdM7iXHAPGUUKN5GpbZxwx8cAmfXxQubE2
         +5GtaQDt+88i5a1qS0HAHlxGTmGwH9/DCWsXyqAPjprqF4AhKHbkuzsCpb/rS90sQmLX
         qMGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AQxFI5IaDScBSYM2QiGDnhYF78mzPrJfNlrHBt3eAfM=;
        b=uBr8XnthHhT2UQlSByu3zvXnI1c9SCxfctxEnQoVieOfT99DFmB33vGmtVhz7GDVLi
         ZZHrrSA/UQfkh0zVd29zyE/3hUHRdkc8SR40Nz8bNAAZp03VH0MW0XgndnBxkqnAtZua
         9HdKBueR+c0aUuA7WkqJkW+Ot4oldRUPhcF/Fyo91Ljt4jWbzNCSqnkqRI5GUuBwpTpo
         Ye7EtUhZP+asBll8zHgOCA3OWpiKeNMsGqK5JIEOJSmjDZ86tdI/IwxUUHOUXaMtB5RZ
         z5adq2NZ3hX7DSfic8BMbZ0pTKSdo5IrjkOLgevBC/XJMwDiQhcvyllLps2rk7UGaoqR
         JfCg==
X-Gm-Message-State: AHQUAuZ7B4ma8vnxYLZhSsme3JDMutc3vYbOaF05oHtiZleJIcv1+Nss
        6yxsMuWu2AvXMNZzxs2tImgtkQ==
X-Google-Smtp-Source: AHgI3IYAyCtoery/AKBJuvXqcbmB1685J/TSbgHq6YAUFUMbwGHyYEukArzL7PvcJIRkhV5Hv/bkCg==
X-Received: by 2002:a1c:e1c4:: with SMTP id y187mr2916795wmg.50.1550151777005;
        Thu, 14 Feb 2019 05:42:57 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id 62sm4963460wra.46.2019.02.14.05.42.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 05:42:56 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v4 1/7] irq/irq_sim: add a notifier chain
Date:   Thu, 14 Feb 2019 14:42:26 +0100
Message-Id: <20190214134232.3821-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190214134232.3821-1-brgl@bgdev.pl>
References: <20190214134232.3821-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Provide a helper allowing users to register a notifier block with
a simulator. For now the only event we're notifying about is a change
in type configuration.

This is required by the gpio-mockup module which wants to track the
state of GPIO lines and simulate rising and falling edge interrupts.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 include/linux/irq_sim.h | 22 ++++++++++++++++++----
 kernel/irq/irq_sim.c    | 40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+), 4 deletions(-)

diff --git a/include/linux/irq_sim.h b/include/linux/irq_sim.h
index 4500d453a63e..e076693d0af7 100644
--- a/include/linux/irq_sim.h
+++ b/include/linux/irq_sim.h
@@ -8,12 +8,21 @@
 
 #include <linux/irq_work.h>
 #include <linux/device.h>
+#include <linux/notifier.h>
 
 /*
  * Provides a framework for allocating simulated interrupts which can be
  * requested like normal irqs and enqueued from process context.
  */
 
+#define IRQ_SIM_TYPE_CHANGED	1
+
+/* Passed to notifier callbacks when type changes. */
+struct irq_sim_irq_type {
+	unsigned int		offset;
+	unsigned int		type;
+};
+
 struct irq_sim_work_ctx {
 	struct irq_work		work;
 	unsigned long		*pending;
@@ -22,13 +31,16 @@ struct irq_sim_work_ctx {
 struct irq_sim_irq_ctx {
 	int			irqnum;
 	bool			enabled;
+	struct irq_sim		*parent;
+	struct irq_sim_irq_type	type;
 };
 
 struct irq_sim {
-	struct irq_sim_work_ctx	work_ctx;
-	int			irq_base;
-	unsigned int		irq_count;
-	struct irq_sim_irq_ctx	*irqs;
+	struct irq_sim_work_ctx		work_ctx;
+	int				irq_base;
+	unsigned int			irq_count;
+	struct irq_sim_irq_ctx		*irqs;
+	struct atomic_notifier_head	notifier;
 };
 
 int irq_sim_init(struct irq_sim *sim, unsigned int num_irqs);
@@ -37,5 +49,7 @@ int devm_irq_sim_init(struct device *dev, struct irq_sim *sim,
 void irq_sim_fini(struct irq_sim *sim);
 void irq_sim_fire(struct irq_sim *sim, unsigned int offset);
 int irq_sim_irqnum(struct irq_sim *sim, unsigned int offset);
+int irq_sim_notifier_register(struct irq_sim *sim,
+			      struct notifier_block *nb);
 
 #endif /* _LINUX_IRQ_SIM_H */
diff --git a/kernel/irq/irq_sim.c b/kernel/irq/irq_sim.c
index 98a20e1594ce..a55641e78125 100644
--- a/kernel/irq/irq_sim.c
+++ b/kernel/irq/irq_sim.c
@@ -25,10 +25,34 @@ static void irq_sim_irqunmask(struct irq_data *data)
 	irq_ctx->enabled = true;
 }
 
+static int irq_sim_set_type(struct irq_data *data, unsigned int type)
+{
+	struct irq_sim_irq_ctx *irq_ctx = irq_data_get_irq_chip_data(data);
+	struct irq_sim *sim = irq_ctx->parent;
+	int rv;
+
+	/* Only support rising and falling edge types. */
+	if (type & ~IRQ_TYPE_EDGE_BOTH)
+		return -EINVAL;
+
+	irq_ctx->type.type = type;
+
+	rv = atomic_notifier_call_chain(&sim->notifier,
+					IRQ_SIM_TYPE_CHANGED,
+					&irq_ctx->type);
+	if (rv < 0) {
+		pr_err("%s: error calling the type notifier chain\n", __func__);
+		return rv;
+	}
+
+	return 0;
+}
+
 static struct irq_chip irq_sim_irqchip = {
 	.name		= "irq_sim",
 	.irq_mask	= irq_sim_irqmask,
 	.irq_unmask	= irq_sim_irqunmask,
+	.irq_set_type	= irq_sim_set_type,
 };
 
 static void irq_sim_handle_irq(struct irq_work *work)
@@ -83,7 +107,9 @@ int irq_sim_init(struct irq_sim *sim, unsigned int num_irqs)
 
 	for (i = 0; i < num_irqs; i++) {
 		sim->irqs[i].irqnum = sim->irq_base + i;
+		sim->irqs[i].parent = sim;
 		sim->irqs[i].enabled = false;
+		sim->irqs[i].type.offset = i;
 		irq_set_chip(sim->irq_base + i, &irq_sim_irqchip);
 		irq_set_chip_data(sim->irq_base + i, &sim->irqs[i]);
 		irq_set_handler(sim->irq_base + i, &handle_simple_irq);
@@ -91,6 +117,7 @@ int irq_sim_init(struct irq_sim *sim, unsigned int num_irqs)
 				  IRQ_NOREQUEST | IRQ_NOAUTOEN, IRQ_NOPROBE);
 	}
 
+	ATOMIC_INIT_NOTIFIER_HEAD(&sim->notifier);
 	init_irq_work(&sim->work_ctx.work, irq_sim_handle_irq);
 	sim->irq_count = num_irqs;
 
@@ -180,3 +207,16 @@ int irq_sim_irqnum(struct irq_sim *sim, unsigned int offset)
 	return sim->irqs[offset].irqnum;
 }
 EXPORT_SYMBOL_GPL(irq_sim_irqnum);
+
+/**
+ * irq_sim_notifier_register - Subscribe for interrupt simulator events.
+ *
+ * @sim:       The interrupt simulator object.
+ * @nb:        Notifier block.
+ */
+int irq_sim_notifier_register(struct irq_sim *sim,
+			      struct notifier_block *nb)
+{
+	return atomic_notifier_chain_register(&sim->notifier, nb);
+}
+EXPORT_SYMBOL_GPL(irq_sim_notifier_register);
-- 
2.20.1


Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1696C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 14:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 682572184B
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 14:16:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="saNW4+Am"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbfAWOPy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 09:15:54 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39788 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727058AbfAWOPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 09:15:52 -0500
Received: by mail-wm1-f66.google.com with SMTP id y8so2078993wmi.4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 06:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WQ66DLEKc/MG0DXybe6MWB+l9aGMWDp/DgE2ls7LES8=;
        b=saNW4+Amy3TnKB0zLgHSHhGJk6MQOZKunNRlGdRHPvYQVLby7qVAzz+IFyufQWJ7S+
         oe1VOSjHW8KPcopwEjmtQjij7NBFTjRSAZ74vyafdUbvV2/58FdDPfSjpbqUMi/CxPFf
         phgR1ykWQ0fd2GPlpU/Iv/Sim29IZ/sbf4EuMAdYYYtdG+vtUYyuu8aQieTk7x3bJZuX
         uEKmSrOc+Ldj+MNrJIevMM9d6P8Ioh9vzc2EHjtwg0Dh7xg6PC3inXktcGI3s4INfJuu
         yac1PhNbSBwEXGyan+ueeGbqZOvqxCYlRthk4n2zKBx0vnXhWrHQMKCQcjDcahATEnG5
         pNRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WQ66DLEKc/MG0DXybe6MWB+l9aGMWDp/DgE2ls7LES8=;
        b=jtbz+Dvm4bOC7NzrT+lQzXwCMMnbM5Vcw2zD3nxwFQ7ynWLKS151w3nJgH8DGWeEhd
         S2GcrlgAdjlquEXZRaSerA65Rk0udEG4hzjGk7YD3aA2QSPvIzEmLVtp06KXIkSRz3So
         1Y25hlyaGsZZn9n5tylptP7zrD5eFASoQ6HrV9MJXcdptMzSCesnZju1KULVG55AqUpI
         C0nSSkTQLz3Hb04klHYNo7MqWxQosGpaKNYZGRgIXXWaClmn1uE+ybkvN2QeZP0ZaT1V
         jrnVArrj3ajpOyedDCW6Aq/lqr4KOJRZFhGFY4wKK5bh8h1KVl6aITSbzPeqVozu4n1q
         Tlnw==
X-Gm-Message-State: AJcUukf+x2gzfROBghp6QLysO9ZJVygpx2D1p4Wa+Py6bQprfaxROZ1l
        77Xis9Naz0musterJvKArEFGXY9XKQc=
X-Google-Smtp-Source: ALg8bN4h2Oar7UWGtZl83vS4bpMJvuZCqmhytFUocnIlDAoCnH1Z7eOhCsq7/0hUPTQ959COxj9aZg==
X-Received: by 2002:a1c:9dc4:: with SMTP id g187mr2987014wme.152.1548252946644;
        Wed, 23 Jan 2019 06:15:46 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id a8sm29072997wme.23.2019.01.23.06.15.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 06:15:46 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 1/9] irq/irq_sim: don't share the irq_chip structure between simulators
Date:   Wed, 23 Jan 2019 15:15:30 +0100
Message-Id: <20190123141538.29408-2-brgl@bgdev.pl>
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

We want to support multiple instances of irq_sim. Make struct irq_chip
part of the irq_sim structure.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 include/linux/irq_sim.h |  2 ++
 kernel/irq/irq_sim.c    | 12 +++++-------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/irq_sim.h b/include/linux/irq_sim.h
index 4500d453a63e..eda132c22b57 100644
--- a/include/linux/irq_sim.h
+++ b/include/linux/irq_sim.h
@@ -6,6 +6,7 @@
 #ifndef _LINUX_IRQ_SIM_H
 #define _LINUX_IRQ_SIM_H
 
+#include <linux/irq.h>
 #include <linux/irq_work.h>
 #include <linux/device.h>
 
@@ -25,6 +26,7 @@ struct irq_sim_irq_ctx {
 };
 
 struct irq_sim {
+	struct irq_chip		chip;
 	struct irq_sim_work_ctx	work_ctx;
 	int			irq_base;
 	unsigned int		irq_count;
diff --git a/kernel/irq/irq_sim.c b/kernel/irq/irq_sim.c
index 98a20e1594ce..b732e4e2e45b 100644
--- a/kernel/irq/irq_sim.c
+++ b/kernel/irq/irq_sim.c
@@ -25,12 +25,6 @@ static void irq_sim_irqunmask(struct irq_data *data)
 	irq_ctx->enabled = true;
 }
 
-static struct irq_chip irq_sim_irqchip = {
-	.name		= "irq_sim",
-	.irq_mask	= irq_sim_irqmask,
-	.irq_unmask	= irq_sim_irqunmask,
-};
-
 static void irq_sim_handle_irq(struct irq_work *work)
 {
 	struct irq_sim_work_ctx *work_ctx;
@@ -74,6 +68,10 @@ int irq_sim_init(struct irq_sim *sim, unsigned int num_irqs)
 		return sim->irq_base;
 	}
 
+	sim->chip.name = "irq_sim";
+	sim->chip.irq_mask = irq_sim_irqmask;
+	sim->chip.irq_unmask = irq_sim_irqunmask;
+
 	sim->work_ctx.pending = bitmap_zalloc(num_irqs, GFP_KERNEL);
 	if (!sim->work_ctx.pending) {
 		kfree(sim->irqs);
@@ -84,7 +82,7 @@ int irq_sim_init(struct irq_sim *sim, unsigned int num_irqs)
 	for (i = 0; i < num_irqs; i++) {
 		sim->irqs[i].irqnum = sim->irq_base + i;
 		sim->irqs[i].enabled = false;
-		irq_set_chip(sim->irq_base + i, &irq_sim_irqchip);
+		irq_set_chip(sim->irq_base + i, &sim->chip);
 		irq_set_chip_data(sim->irq_base + i, &sim->irqs[i]);
 		irq_set_handler(sim->irq_base + i, &handle_simple_irq);
 		irq_modify_status(sim->irq_base + i,
-- 
2.19.1


Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E97C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 08:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DF8D214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 08:45:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="19J9WBAu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728224AbfA2IpM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 03:45:12 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45036 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727890AbfA2IoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 03:44:21 -0500
Received: by mail-wr1-f65.google.com with SMTP id z5so20987780wrt.11
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 00:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WQ66DLEKc/MG0DXybe6MWB+l9aGMWDp/DgE2ls7LES8=;
        b=19J9WBAujCPa7W+q9JrzLjm9Yhpyp2rgsVO/LGDMaJWej8bxfAE4VsiDijFnRGmJp/
         L5ZSePWmnW3NdTZzFURQcmu14xnZGv1D5z0J2/Cwj9TKIZliemYMhTGnnPykpRsI7Lyy
         BsoyZeWP9ZT9XMIPg6HKmKjbxuE5xDo613/Gy1zRQHiusUcoXQKLP0eZjd4Up3iQ8AiM
         7CMa9r/cKarVpsIlKWF8gSGTVJNVwMbFxJ44DHdsucwxvrsr276GqQElzzcQyQl+eSLA
         3tM8+YgsH2gqKvwfUdFwy1oib1nfKHjPbT8isuRUyBTwpuyzE/CPxlfwK7WDkZpjDFrj
         nppg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WQ66DLEKc/MG0DXybe6MWB+l9aGMWDp/DgE2ls7LES8=;
        b=Sj3aPedtUUYwvRqx6v96eYOBlrupGg4QjowpYzlZVc3N5Rk2Ej59XxgQ6YE+88VzE4
         SCnkbIoQn9FlTt/+1N/xBKUdzMepTWXBsafIe50AZLHcCMkykH4vb1gYOgfPrCAEYxoz
         8Ygc98eXVZpBy/X5qEIf31NpQgDn5yBBllL+hbq1VJO95Bp9OhAsNpQSxVsxI7q21Lbv
         /CYYQ6GR1Z8mAgEGFZOP1h/froy3S0hsmNWtQ4sYoogQNNORgL9c0iyAQ90dOHUXAOVp
         R3fmfTBscmsLw8PxFmOw09F4DsRCUzCrQTEk0QjfXPdaakYF+LPzeEcC/uoLCv4N5eSq
         B7aw==
X-Gm-Message-State: AJcUukeZfCY4Kn0qBQVV3inzohM7sBqkCFgawIN6gY5DRnzy2S5BxWBe
        +4wSZfXUikREMtVUvPkxmDp13Q==
X-Google-Smtp-Source: ALg8bN6LQVZ+Z6VoPZb55wXgNP87fbo7rwsmnQOKWUGWkpn/s7LqbHpDae77iy7BgvLKwqvz3t3o8A==
X-Received: by 2002:adf:a1d2:: with SMTP id v18mr23835506wrv.87.1548751459446;
        Tue, 29 Jan 2019 00:44:19 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id c1sm3979319wmb.14.2019.01.29.00.44.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 00:44:18 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 1/9] irq/irq_sim: don't share the irq_chip structure between simulators
Date:   Tue, 29 Jan 2019 09:44:03 +0100
Message-Id: <20190129084411.30495-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190129084411.30495-1-brgl@bgdev.pl>
References: <20190129084411.30495-1-brgl@bgdev.pl>
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


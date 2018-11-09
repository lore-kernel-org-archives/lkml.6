Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC008C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 17:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B95D20825
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 17:21:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="1PFnXvZ9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B95D20825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728553AbeKJDDH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 22:03:07 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38471 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727995AbeKJDDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 22:03:07 -0500
Received: by mail-wr1-f67.google.com with SMTP id e3-v6so2704354wrs.5
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 09:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ytS6uxOcV99jAW8dOhmzJXuNQTkloeOsNiy+jM2ANyI=;
        b=1PFnXvZ9XUZx3pfDZ5VdhqhNDqDP1spNnV4oiKbCVDEyqqmREOR9QkoCQRaIkLFUFu
         d9ju0RTop6XK5vFUu1PwUP9C09OCB/A+AgMZGLsWg/gLClaK9dXWKj9JsVMX85h9nITC
         00aa2VxLszWpk8Y38b8DrxQUN4DitFeA8wcCBl3/yiU/Vr35DefJy1WSlkGlSVubmUBB
         Wk4fEoWOMrWdwdcAcBG5afcicWxpCq7f2FytJ1rJ9IY0rZgmbo0aekk0496OX2YoGkEK
         oYDcQYZkWaRfvsRfyfZI3Bvh8UNb/7Zb3pABvLrNYWLAnxB2TF0/zssxHaE6W3U96T2y
         VzUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ytS6uxOcV99jAW8dOhmzJXuNQTkloeOsNiy+jM2ANyI=;
        b=CglmcXbxkMdyUPdMqo2Ykg1iOdAXtDcdtHZAkmfBrgD4xxYyiN7XuHYBmZhvzYd9cS
         mm2WDt7TeQZOt3/B8EJ25NJgF3BegrzPR9JJTrccyNxahKgMdcExGCWnF/TWLwAcAjg6
         UaJg7Ds9iyGXXwq1TIy/lzo6Y7ETr6Umgdvs8HRfbPq69AmmFnFZVg6XY9Y6BQuqCjfJ
         fnp0zakSlqI0NWMJ0a3vukUAbJiqq5/1WU3PTj9b14Jq5i1u7/SpKRbo7C5Nb9OhOq3I
         nQr4UAgMQ472GrhflmnwfJw3RC3BdZV7hHIlZRDqxgpfswHNcUS+j/mHNYr+l4P5BUXG
         2C7g==
X-Gm-Message-State: AGRZ1gLqCm8y5/b/4dh54ShNOVK6A1vBvgyjAVsthRM7kAtbQIiOX4rg
        h75UzXmaHunBYWMvPcMFdfFfK0zDMUc=
X-Google-Smtp-Source: AJdET5ckJCnHWsND2nGnK3xAmX9fa4+QjmNXLKd4/m/CeiTP9jCBRAnyH9MUjr5hv7a624GeHyA7Ug==
X-Received: by 2002:a5d:620b:: with SMTP id y11-v6mr8744379wru.105.1541784095016;
        Fri, 09 Nov 2018 09:21:35 -0800 (PST)
Received: from localhost.localdomain (lfbn-mar-1-609-89.w90-118.abo.wanadoo.fr. [90.118.185.89])
        by smtp.gmail.com with ESMTPSA id r3-v6sm2864699wmd.25.2018.11.09.09.21.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 09:21:34 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH] irq/irq_sim: store multiple interrupt offsets in a bitmap
Date:   Fri,  9 Nov 2018 18:21:32 +0100
Message-Id: <20181109172132.30939-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two threads can try to fire the irq_sim with different offsets and will
end up fighting for the irq_work asignment. Thomas Gleixner suggested a
solution based on a bitfield where we set a bit for every offset
associated with an interrupt that should be fired and then iterate over
all set bits in the interrupt handler.

This is a slightly modified solution using a bitmap so that we don't
impose a limit on the number of interrupts one can allocate with
irq_sim.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
---
 include/linux/irq_sim.h |  2 +-
 kernel/irq/irq_sim.c    | 23 +++++++++++++++++++++--
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/include/linux/irq_sim.h b/include/linux/irq_sim.h
index 630a57e55db6..4500d453a63e 100644
--- a/include/linux/irq_sim.h
+++ b/include/linux/irq_sim.h
@@ -16,7 +16,7 @@
 
 struct irq_sim_work_ctx {
 	struct irq_work		work;
-	int			irq;
+	unsigned long		*pending;
 };
 
 struct irq_sim_irq_ctx {
diff --git a/kernel/irq/irq_sim.c b/kernel/irq/irq_sim.c
index dd20d0d528d4..98a20e1594ce 100644
--- a/kernel/irq/irq_sim.c
+++ b/kernel/irq/irq_sim.c
@@ -34,9 +34,20 @@ static struct irq_chip irq_sim_irqchip = {
 static void irq_sim_handle_irq(struct irq_work *work)
 {
 	struct irq_sim_work_ctx *work_ctx;
+	unsigned int offset = 0;
+	struct irq_sim *sim;
+	int irqnum;
 
 	work_ctx = container_of(work, struct irq_sim_work_ctx, work);
-	handle_simple_irq(irq_to_desc(work_ctx->irq));
+	sim = container_of(work_ctx, struct irq_sim, work_ctx);
+
+	while (!bitmap_empty(work_ctx->pending, sim->irq_count)) {
+		offset = find_next_bit(work_ctx->pending,
+				       sim->irq_count, offset);
+		clear_bit(offset, work_ctx->pending);
+		irqnum = irq_sim_irqnum(sim, offset);
+		handle_simple_irq(irq_to_desc(irqnum));
+	}
 }
 
 /**
@@ -63,6 +74,13 @@ int irq_sim_init(struct irq_sim *sim, unsigned int num_irqs)
 		return sim->irq_base;
 	}
 
+	sim->work_ctx.pending = bitmap_zalloc(num_irqs, GFP_KERNEL);
+	if (!sim->work_ctx.pending) {
+		kfree(sim->irqs);
+		irq_free_descs(sim->irq_base, num_irqs);
+		return -ENOMEM;
+	}
+
 	for (i = 0; i < num_irqs; i++) {
 		sim->irqs[i].irqnum = sim->irq_base + i;
 		sim->irqs[i].enabled = false;
@@ -89,6 +107,7 @@ EXPORT_SYMBOL_GPL(irq_sim_init);
 void irq_sim_fini(struct irq_sim *sim)
 {
 	irq_work_sync(&sim->work_ctx.work);
+	bitmap_free(sim->work_ctx.pending);
 	irq_free_descs(sim->irq_base, sim->irq_count);
 	kfree(sim->irqs);
 }
@@ -143,7 +162,7 @@ EXPORT_SYMBOL_GPL(devm_irq_sim_init);
 void irq_sim_fire(struct irq_sim *sim, unsigned int offset)
 {
 	if (sim->irqs[offset].enabled) {
-		sim->work_ctx.irq = irq_sim_irqnum(sim, offset);
+		set_bit(offset, sim->work_ctx.pending);
 		irq_work_queue(&sim->work_ctx.work);
 	}
 }
-- 
2.19.1


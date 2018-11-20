Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8658EC4161D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 13:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6349B206B2
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 13:40:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="GMZx0Psq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6349B206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728505AbeKUAJ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 19:09:56 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50641 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbeKUAJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 19:09:55 -0500
Received: by mail-wm1-f66.google.com with SMTP id 125so2188303wmh.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 05:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I3XR93gU33hxYcwYMkEu/ryYmiKAEB02yg8F22DDwto=;
        b=GMZx0PsqkEiYLCW9AwCVQu/hz8O3A/81SJuuSeYRGx49vLLuiTHFfbTDqD6swynVo1
         JBCB9jS9DQDtQIFe8SObBZQaFt1fcMKw03B5ZEqNTKgcQxJxXCiF1PJLCqLzv/scAXGl
         Shc2U8lDosTnj/fxidWaSYVwSSm8krCrwkfuadXOseP0LSSandHVgusPsAMaQqSZK8eN
         q062yCii6XpOwFwyF1vNb8zZD9V8pAelHNoE5CNXShyU7cnwmuck4Mnh4DB3X6yJuCFt
         pMCtAMKHMDhjRY2MTkf/1fCvtuowGkMht5AP/LdtN44w0c521AQGfE2t733vB97vQyaV
         q7ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I3XR93gU33hxYcwYMkEu/ryYmiKAEB02yg8F22DDwto=;
        b=pOHgvzexlUWbHkofDhyrnXI0huF+tjFA+w6gykBhyg2WObz+A+ryzcHLFY0H8YRWOT
         3UhjrnEZIgbSDzp7CTLv66hsSU6M66dclJhdPExQjgu/fK83oJ21ApbldxSl+ne1Iner
         my4tTQFzdLOdN7+pERZQI0lIze8ohVJ/RfUv3lJS+d05NvwPvcRhOB8vMyHVOUjQ950f
         GrlJunfy2WRDQpYZqXZSQd+HicCf+nayDwEtf2B2BPrxacF+3cwN8EPW4Pq48ivEE8Ul
         dN7sDbjO2k4M5vWAkQOz//gjXQUKzXUhR1TKEgFsHEPisompCToJ68Tit9/g0ehvDAug
         ZTxQ==
X-Gm-Message-State: AGRZ1gIJZi1r/+r5cuvVHYvu5mIUGoxKh3QjLQtWy+jtMbnMTsxi/52u
        UajZOWyn8kS3dwoTAqcQO0ixMw==
X-Google-Smtp-Source: AFSGD/WRIcokyYwqsqYKLzG3DHlnk2/L1hyKiWCc1w5YjMFP6skX+tde5mepXm7hnMyXXqlE37uQYA==
X-Received: by 2002:a1c:5585:: with SMTP id j127-v6mr2070605wmb.127.1542721240793;
        Tue, 20 Nov 2018 05:40:40 -0800 (PST)
Received: from debian-brgl.home (lfbn-mar-1-609-89.w90-118.abo.wanadoo.fr. [90.118.185.89])
        by smtp.gmail.com with ESMTPSA id j129-v6sm36962901wmb.47.2018.11.20.05.40.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 05:40:40 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 1/2] irq/irq_sim: provide irq_sim_fire_edge()
Date:   Tue, 20 Nov 2018 14:40:31 +0100
Message-Id: <20181120134032.31645-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181120134032.31645-1-brgl@bgdev.pl>
References: <20181120134032.31645-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The irq_sim irqchip doesn't allow to configure the sensitivity so every
call to irq_sim_fire() fires a dummy interrupt. This used to not matter
for gpio-mockup (one of the irq_sim users) until commit fa38869b0161
("gpiolib: Don't support irq sharing for userspace") which made it
impossible for gpio-mockup to ignore certain events (e.g. only receive
notifications about rising edge events).

Introduce a specialized variant of irq_sim_fire() which takes another
argument called edge. allowing to specify the trigger type for the
dummy interrupt.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 include/linux/irq_sim.h |  2 ++
 kernel/irq/irq_sim.c    | 30 ++++++++++++++++++++++++++++--
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/include/linux/irq_sim.h b/include/linux/irq_sim.h
index 4500d453a63e..f55148e77792 100644
--- a/include/linux/irq_sim.h
+++ b/include/linux/irq_sim.h
@@ -22,6 +22,7 @@ struct irq_sim_work_ctx {
 struct irq_sim_irq_ctx {
 	int			irqnum;
 	bool			enabled;
+	int			edge;
 };
 
 struct irq_sim {
@@ -36,6 +37,7 @@ int devm_irq_sim_init(struct device *dev, struct irq_sim *sim,
 		      unsigned int num_irqs);
 void irq_sim_fini(struct irq_sim *sim);
 void irq_sim_fire(struct irq_sim *sim, unsigned int offset);
+void irq_sim_fire_edge(struct irq_sim *sim, unsigned int offset, int edge);
 int irq_sim_irqnum(struct irq_sim *sim, unsigned int offset);
 
 #endif /* _LINUX_IRQ_SIM_H */
diff --git a/kernel/irq/irq_sim.c b/kernel/irq/irq_sim.c
index 98a20e1594ce..a9330050f751 100644
--- a/kernel/irq/irq_sim.c
+++ b/kernel/irq/irq_sim.c
@@ -25,10 +25,20 @@ static void irq_sim_irqunmask(struct irq_data *data)
 	irq_ctx->enabled = true;
 }
 
+static int irq_sim_set_type(struct irq_data *data, unsigned int type)
+{
+	struct irq_sim_irq_ctx *irq_ctx = irq_data_get_irq_chip_data(data);
+
+	irq_ctx->edge = type & IRQ_TYPE_EDGE_BOTH;
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
@@ -161,12 +171,28 @@ EXPORT_SYMBOL_GPL(devm_irq_sim_init);
  */
 void irq_sim_fire(struct irq_sim *sim, unsigned int offset)
 {
-	if (sim->irqs[offset].enabled) {
+	/* Don't care about the edge. */
+	irq_sim_fire_edge(sim, offset, IRQ_TYPE_EDGE_BOTH);
+}
+EXPORT_SYMBOL_GPL(irq_sim_fire);
+
+/**
+ * irq_sim_fire_edge - Enqueue an interrupt, specify the edge.
+ *
+ * @sim:        The interrupt simulator object.
+ * @offset:     Offset of the simulated interrupt which should be fired.
+ * edge:        Edge of the interrupt (IRQ_TYPE_EDGE_RISING/FALLING).
+ */
+void irq_sim_fire_edge(struct irq_sim *sim, unsigned int offset, int edge)
+{
+	struct irq_sim_irq_ctx *irq = &sim->irqs[offset];
+
+	if (irq->enabled && (irq->edge & edge)) {
 		set_bit(offset, sim->work_ctx.pending);
 		irq_work_queue(&sim->work_ctx.work);
 	}
 }
-EXPORT_SYMBOL_GPL(irq_sim_fire);
+EXPORT_SYMBOL_GPL(irq_sim_fire_edge);
 
 /**
  * irq_sim_irqnum - Get the allocated number of a dummy interrupt.
-- 
2.19.1


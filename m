Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 566D4C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 14:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24ACC20870
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 14:16:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="U87ItS5a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbfAWOQg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 09:16:36 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:32808 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726995AbfAWOPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 09:15:50 -0500
Received: by mail-wr1-f65.google.com with SMTP id p7so2672567wru.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 06:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=phuvz1JRrnRqzpouEYay5SFWuk0hSkE+vMxZP22Ixuo=;
        b=U87ItS5afQ2NJJPquJR1Qsy6Eu3bpCXJ6IiL5592nf2nyvppRdz1wibZ8H8JybiySB
         AsQQUV1MU44mnFlQ/tb+gDc0KI6PijFbp5O31xgmvk+qcbiJ7R6PP67rJIpDRr0OhgLH
         uC95ymur/CD2kelBkzEC+n0aB8pWF0HzCeEGmWcOEXgdN9lBL5R3bgsODulemMjW3SYR
         TvlZgX0OIEMAd1oTrGIydU4FlPX0YCGf91y3SexKjUbpsr6Iyx/Qejme512gguzHkdE/
         0+Wim82BiT9BVcMVtsyJcA7j3BdxVI4OM7g3EhoowCRxuseW33BxZUUzFtwttFep09yv
         Z7GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=phuvz1JRrnRqzpouEYay5SFWuk0hSkE+vMxZP22Ixuo=;
        b=SxeSO/s0TKoUh5CrLsu91N2TE5UEnimHS/waCIDvJgIQWinjGxeLSuVdDiG5QuMe6n
         RKNfak7KVPZ50w38jobVe103zf+s1wz8VuTEvUe37yfry4u+zQpilgk+17EloGqDt2+W
         AHqoe5Cr13yDIfzqStmwo7KOhNk2Q+6or0s6sQIXUqLWP8dJQ+CtyTcmS8Df763Nz6S5
         zQgp8Bp09TFjL0hy7DQT6OrngN69DsiD/k3qP0KxU5J8AJvG0RiHXlBWz6j7kWtkhGPt
         De/7XHFMXPq173AwwIkJuSsT1BCh7pKmWw7zRa3xplKW1xkCNE+Il32IVriP8/W+fqwT
         MZfQ==
X-Gm-Message-State: AJcUukcH/a3EmQ+AKQTLl2HBeTELhEgEU92gpqbPbLi95HCaOLieDHgQ
        FqiWrBm4l7e4GyRcC4oc7TufPQ==
X-Google-Smtp-Source: ALg8bN7xlucqJUCuaZiyp44b+7+HpCE7qf8DC9M8BNfNOvc0WCs045/gqAt+0xO9gPunU3SCU/ZaEA==
X-Received: by 2002:adf:db01:: with SMTP id s1mr2918433wri.214.1548252948785;
        Wed, 23 Jan 2019 06:15:48 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id a8sm29072997wme.23.2019.01.23.06.15.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 06:15:48 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 3/9] irq/irq_sim: provide irq_sim_get_type()
Date:   Wed, 23 Jan 2019 15:15:32 +0100
Message-Id: <20190123141538.29408-4-brgl@bgdev.pl>
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

Provide a helper that allows users to retrieve the configured flow type
of dummy interrupts. That allows certain users to decide whether an irq
needs to be fired depending on its edge/level/... configuration.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 include/linux/irq_sim.h |  2 ++
 kernel/irq/irq_sim.c    | 25 +++++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/include/linux/irq_sim.h b/include/linux/irq_sim.h
index b96c2f752320..782dfc599632 100644
--- a/include/linux/irq_sim.h
+++ b/include/linux/irq_sim.h
@@ -23,6 +23,7 @@ struct irq_sim_work_ctx {
 
 struct irq_sim_irq_ctx {
 	bool			enabled;
+	unsigned int		type;
 };
 
 struct irq_sim {
@@ -39,5 +40,6 @@ int devm_irq_sim_init(struct device *dev, struct irq_sim *sim,
 void irq_sim_fini(struct irq_sim *sim);
 void irq_sim_fire(struct irq_sim *sim, unsigned int offset);
 int irq_sim_irqnum(struct irq_sim *sim, unsigned int offset);
+int irq_sim_get_type(struct irq_sim *sim, unsigned int offset);
 
 #endif /* _LINUX_IRQ_SIM_H */
diff --git a/kernel/irq/irq_sim.c b/kernel/irq/irq_sim.c
index 2bcdbab1bc5a..9168e7100559 100644
--- a/kernel/irq/irq_sim.c
+++ b/kernel/irq/irq_sim.c
@@ -25,6 +25,15 @@ static void irq_sim_irqunmask(struct irq_data *data)
 	irq_ctx->enabled = true;
 }
 
+static int irq_sim_set_type(struct irq_data *data, unsigned int type)
+{
+	struct irq_sim_irq_ctx *irq_ctx = irq_data_get_irq_chip_data(data);
+
+	irq_ctx->type = type;
+
+	return 0;
+}
+
 static void irq_sim_handle_irq(struct irq_work *work)
 {
 	struct irq_sim_work_ctx *work_ctx;
@@ -107,6 +116,7 @@ int irq_sim_init(struct irq_sim *sim, unsigned int num_irqs)
 	sim->chip.name = "irq_sim";
 	sim->chip.irq_mask = irq_sim_irqmask;
 	sim->chip.irq_unmask = irq_sim_irqunmask;
+	sim->chip.irq_set_type = irq_sim_set_type;
 
 	sim->work_ctx.pending = bitmap_zalloc(num_irqs, GFP_KERNEL);
 	if (!sim->work_ctx.pending) {
@@ -220,3 +230,18 @@ int irq_sim_irqnum(struct irq_sim *sim, unsigned int offset)
 	return irq_find_mapping(sim->domain, offset);
 }
 EXPORT_SYMBOL_GPL(irq_sim_irqnum);
+
+/**
+ * irq_sim_get_type - Get the configured flow type of a dummy interrupt.
+ *
+ * @sim:        The interrupt simulator object.
+ * @offset:     Offset of the simulated interrupt for which to retrieve
+ *              the type.
+ */
+int irq_sim_get_type(struct irq_sim *sim, unsigned int offset)
+{
+	struct irq_sim_irq_ctx *ctx = irq_sim_get_ctx(sim, offset);
+
+	return ctx->type;
+}
+EXPORT_SYMBOL_GPL(irq_sim_get_type);
-- 
2.19.1


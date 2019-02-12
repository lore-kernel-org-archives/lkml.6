Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC36C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A85E214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:16:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="x27Blpuz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729753AbfBLNQb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 08:16:31 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39631 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729448AbfBLNQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 08:16:28 -0500
Received: by mail-wm1-f67.google.com with SMTP id f16so2975283wmh.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 05:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pIpW7RFEY2GMQsR5y2sFKJ0v7v9X66ceV9i2CkIDbaw=;
        b=x27BlpuzZLErXtZWnI2PfiNqVl4JZXqBfY4f5NQULwcZ/4F3B9KC9tMl2FJSo1caAY
         ZCikvpgGhsBo/1uU5d5TxkSDThNNGOaRkvSMgogLpYe5cSManNhZFt1Tx19OLx2afCBv
         6z2SA1+8LFmvQhJV9rhwDRJ/gDQoVI3RRYMdpd9dMicT7/WQlStHQ0xqTO0FBojj//Pv
         41RxL4viQjA2sXjEuUqyPrbuwrG4p3O6dm3hYhWuvWM6nOu99Ka4gOCFKUboq1iKIGLD
         nFe9m6egnQaRzSFoJXzfvdStnH7gVSo5vfrrRlcR14aQDdMDahCs1elGlsxiAFDfRSfN
         1Zsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pIpW7RFEY2GMQsR5y2sFKJ0v7v9X66ceV9i2CkIDbaw=;
        b=gkd9dEo4j8wC21YBzKD5uyPMVCVy6E8jykRKW8+l9joeprIOqZ5IrXNwJ0TjPxvVkX
         61MLRHNC7dJ3uWeFOXSIXs7houQUoi16FZusdMrrmh0B8tpbgcednbMjArYboGTza2Nm
         ON6XP5FVp6mZ8qP7vz1H7IzFgf8dZ1031XufAqxsTQVaBadfxcE93H+DuEGZ9HY4G7Gl
         GQM5qCj+8PjHUrA558nK0Nka5L9LNAN9WW9x2Id3Y3ujMMf0kOQwDHxmCWtaDfIqjrla
         ORi0FIxqlZu8vZUHqtv68VI0C+z1hqCuW3vKaOrOdA+QC+LCB2AGeKhmB/nH14521GCm
         3F2g==
X-Gm-Message-State: AHQUAub1/Vs/MsgNSZKi4siOM73Zd4NoSqGTHeQ8r0hB7brsEoh1wR25
        LLKCeJd3DspjB4wjeA/swTCN4Q==
X-Google-Smtp-Source: AHgI3IY3YQTnS0SNXpkItW4onZRWckiuwkyiQqg6Wa5GLVRTyW7BudZ4qq5wM1HvqYf9PNHR7NXP0g==
X-Received: by 2002:a1c:f207:: with SMTP id s7mr2884154wmc.87.1549977386303;
        Tue, 12 Feb 2019 05:16:26 -0800 (PST)
Received: from localhost.localdomain (aputeaux-684-1-38-32.w90-86.abo.wanadoo.fr. [90.86.93.32])
        by smtp.gmail.com with ESMTPSA id p6sm5478517wre.63.2019.02.12.05.16.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 05:16:25 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 1/7] irq/irq_sim: provide irq_sim_get_type()
Date:   Tue, 12 Feb 2019 14:15:54 +0100
Message-Id: <20190212131600.18960-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212131600.18960-1-brgl@bgdev.pl>
References: <20190212131600.18960-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Provide a helper that allows users to retrieve the current irq type
of dummy interrupts.

Internally: store the type in the line context when the irq_set_type()
callback is called.

This is required by the gpio-mockup module which wants to track the
state of GPIO lines and simulate rising and falling edge interrupts.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 include/linux/irq_sim.h |  2 ++
 kernel/irq/irq_sim.c    | 23 +++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/include/linux/irq_sim.h b/include/linux/irq_sim.h
index 4500d453a63e..c73be0a2c15c 100644
--- a/include/linux/irq_sim.h
+++ b/include/linux/irq_sim.h
@@ -22,6 +22,7 @@ struct irq_sim_work_ctx {
 struct irq_sim_irq_ctx {
 	int			irqnum;
 	bool			enabled;
+	int			type;
 };
 
 struct irq_sim {
@@ -37,5 +38,6 @@ int devm_irq_sim_init(struct device *dev, struct irq_sim *sim,
 void irq_sim_fini(struct irq_sim *sim);
 void irq_sim_fire(struct irq_sim *sim, unsigned int offset);
 int irq_sim_irqnum(struct irq_sim *sim, unsigned int offset);
+unsigned int irq_sim_get_type(struct irq_sim *sim, unsigned int offset);
 
 #endif /* _LINUX_IRQ_SIM_H */
diff --git a/kernel/irq/irq_sim.c b/kernel/irq/irq_sim.c
index 98a20e1594ce..74561a0dca65 100644
--- a/kernel/irq/irq_sim.c
+++ b/kernel/irq/irq_sim.c
@@ -25,10 +25,20 @@ static void irq_sim_irqunmask(struct irq_data *data)
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
 static struct irq_chip irq_sim_irqchip = {
 	.name		= "irq_sim",
 	.irq_mask	= irq_sim_irqmask,
 	.irq_unmask	= irq_sim_irqunmask,
+	.irq_set_type	= irq_sim_set_type,
 };
 
 static void irq_sim_handle_irq(struct irq_work *work)
@@ -180,3 +190,16 @@ int irq_sim_irqnum(struct irq_sim *sim, unsigned int offset)
 	return sim->irqs[offset].irqnum;
 }
 EXPORT_SYMBOL_GPL(irq_sim_irqnum);
+
+/**
+ * irq_sim_get_type - Get the type configuration for a dummy interrupt.
+ *
+ * @sim:        The interrupt simulator object.
+ * @offset:     Offset of the simulated interrupt for which to retrieve
+ *              the type.
+ */
+unsigned int irq_sim_get_type(struct irq_sim *sim, unsigned int offset)
+{
+	return sim->irqs[offset].type;
+}
+EXPORT_SYMBOL_GPL(irq_sim_get_type);
-- 
2.20.1


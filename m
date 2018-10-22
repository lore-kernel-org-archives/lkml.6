Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64AECC7112C
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 12:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2150320652
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 12:03:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="vI4mEup0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2150320652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728764AbeJVUWM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 16:22:12 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34052 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728664AbeJVUWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 16:22:12 -0400
Received: by mail-pl1-f193.google.com with SMTP id f10-v6so1192461plr.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 05:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cklJIrGQO1v9yxxg7e/arLZA2lgKk/qgd+gAAteDwCs=;
        b=vI4mEup0AVsDH6t/6VpaZsZkVp3Zpv+LSIZivK2GEYN+mtCIkCqQfuwu+T907pT47N
         ljN3gvAy+6AnuofKquMjUdfW0+Y0pcTwVP54u/tWZhcw6QZBY9f3VMWbMH7mev3zXUxy
         mD3Y99mFaDIsuvducq9Wpawlz8RG94GMLQKNHxMO1UK/qUumNQOG1rx/F+Sn6RlIE0g/
         Abq5MfCN4P56oWTEd8ZOLLSAJAbeU+76CHQrY2WRb2ImvK24eI5kUV+THd1be3DrnqaN
         iUKFkp6nqv0lVzN3QjOpAzTelPJJGGkMOSl4/PICEm7ZoPWfFzl6aAmJZbzWfBHzMIOi
         y0xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cklJIrGQO1v9yxxg7e/arLZA2lgKk/qgd+gAAteDwCs=;
        b=ln9ylcN2xNEsIOjl90b0leCQWpDYIguQHGpRoZAQutxo1EG0WUKifdsgZahK0L7xPm
         yQkIcocX8GbNzzKjFhBcSjjbvMueLMlLQlDTf0vIg5xzsB82U+Feph8jKWyzCzTYLWXx
         27oYkG6jONR3iZPHgSCXR7JkrBSQt8ptD55bcyq3zDMTKmgN9x3FqrIkHpRMDoEqBZWJ
         Nb8xsKCMYgR/9hawZ7Q6DTskYfQtSYDs73P1UMW6Yp4Kabw+7LD0q3WoSYXWdOjSSBz6
         nsem6717GIu8Agnp7OqQCTqzScBYysuqbDHeGxC+6hE7fi2KpsI9QQ1ytDXCf/6ipkCm
         4EJQ==
X-Gm-Message-State: AGRZ1gJURCTmz4OgvhopwNc3M2S7gNt1z9KlRbgrkRWba4q/XikUR8iH
        6V0aNRc0Xc9puEVpegrxD0FL8w==
X-Google-Smtp-Source: AJdET5dIe4lwYNujouwXUxRcKh4fPvcM0GAbqkPaHYm/SxWJMAwmJ7cXUCjxKoKD5NctXJRZIh8mTw==
X-Received: by 2002:a17:902:748a:: with SMTP id h10-v6mr6869891pll.187.1540209835477;
        Mon, 22 Oct 2018 05:03:55 -0700 (PDT)
Received: from anup-ubuntu64.dlink.router ([106.51.30.16])
        by smtp.googlemail.com with ESMTPSA id n79-v6sm55443405pfk.19.2018.10.22.05.03.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Oct 2018 05:03:54 -0700 (PDT)
From:   Anup Patel <anup@brainfault.org>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <anup@brainfault.org>
Subject: [PATCH 3/4] irqchip: sifive-plic: Differentiate between PLIC handler and context
Date:   Mon, 22 Oct 2018 17:15:16 +0530
Message-Id: <20181022114517.22748-4-anup@brainfault.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181022114517.22748-1-anup@brainfault.org>
References: <20181022114517.22748-1-anup@brainfault.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We explicitly differentiate between PLIC handler and context because
PLIC context is for given mode of HART whereas PLIC handler is per-CPU
software construct meant to handling interrupts from a particular
PLIC context.

Signed-off-by: Anup Patel <anup@brainfault.org>
---
 drivers/irqchip/irq-sifive-plic.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index 869355d2a713..eb9e8aee1a1a 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -64,8 +64,8 @@ struct plic_handler {
 
 struct plic_hw {
 	u32			nr_irqs;
+	u32			nr_contexts;
 	u32			nr_handlers;
-	u32			nr_mapped;
 	void __iomem		*regs;
 	struct plic_handler	*handlers;
 	struct irq_domain	*irqdomain;
@@ -190,10 +190,10 @@ static int __init plic_init(struct device_node *node,
 	if (WARN_ON(!plic.nr_irqs))
 		goto out_iounmap;
 
-	plic.nr_handlers = of_irq_count(node);
-	if (WARN_ON(!plic.nr_handlers))
+	plic.nr_contexts = of_irq_count(node);
+	if (WARN_ON(!plic.nr_contexts))
 		goto out_iounmap;
-	if (WARN_ON(plic.nr_handlers < num_possible_cpus()))
+	if (WARN_ON(plic.nr_contexts < num_possible_cpus()))
 		goto out_iounmap;
 
 	error = -ENOMEM;
@@ -206,7 +206,7 @@ static int __init plic_init(struct device_node *node,
 	if (WARN_ON(!plic.irqdomain))
 		goto out_free_handlers;
 
-	for (i = 0; i < plic.nr_handlers; i++) {
+	for (i = 0; i < plic.nr_contexts; i++) {
 		struct of_phandle_args parent;
 		struct plic_handler *handler;
 		irq_hw_number_t hwirq;
@@ -229,6 +229,11 @@ static int __init plic_init(struct device_node *node,
 
 		cpu = riscv_hartid_to_cpuid(hartid);
 		handler = per_cpu_ptr(plic.handlers, cpu);
+		if (handler->present) {
+			pr_warn("handler not available for context %d.\n", i);
+			continue;
+		}
+
 		handler->present = true;
 		handler->hart_base =
 			plic.regs + CONTEXT_BASE + i * CONTEXT_PER_HART;
@@ -241,11 +246,11 @@ static int __init plic_init(struct device_node *node,
 		for (hwirq = 1; hwirq <= plic.nr_irqs; hwirq++)
 			plic_toggle(handler, hwirq, 0);
 
-		plic.nr_mapped++;
+		plic.nr_handlers++;
 	}
 
-	pr_info("mapped %d interrupts to %d (out of %d) handlers.\n",
-		plic.nr_irqs, plic.nr_mapped, plic.nr_handlers);
+	pr_info("mapped %d interrupts with %d handlers for %d contexts.\n",
+		plic.nr_irqs, plic.nr_handlers, plic.nr_contexts);
 	set_handle_irq(plic_handle_irq);
 	return 0;
 
-- 
2.17.1


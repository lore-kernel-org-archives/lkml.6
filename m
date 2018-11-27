Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC3EEC43610
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 10:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7559121104
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 10:03:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="AjMXe0LY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7559121104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730555AbeK0VBF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 16:01:05 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34808 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730542AbeK0VBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 16:01:04 -0500
Received: by mail-pf1-f195.google.com with SMTP id h3so8120709pfg.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 02:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3xSjc0ofOnBOqQBPEyDFqfqunP4/jYbjTPOvYEfpGXk=;
        b=AjMXe0LYwwn9qCrzRrnKMvqiElw6fVHyStytZTXMF3c2e772O1sl3SCTfXTfAWJzu3
         dOuKocKVqUdi48zlQJAxuGEoyASuczjj3jhayvZTg4a2Cs4XjPBeHIXa/pUMHYaQIZwK
         UiOFSx8PhRi9zU37/jUfOXuLktE8FWZqNQPedE/J+ML7m1RJI1zCAkDCJO+6MME1oih8
         Yapt2h7tURHqLrVrbBqELlvtXEo+9RA5+kkIDAAmxjQb8/KcTQ8+C4P7yzL0MbDej5U6
         oO2s8H8DK3Sfa8CcYvHvYBu5RE9ZVlNYGKPEPJQYuRw170Uh1T4LVNnGTIRadgGcmvU0
         CJbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3xSjc0ofOnBOqQBPEyDFqfqunP4/jYbjTPOvYEfpGXk=;
        b=TQ+2N69C+Rn/TMESpQs9Txv0XRxdB6MI0xXH6ZDB/630+rPdXsG6PI6aaKZbV0hU3X
         254N0+8o2WUeGzaKkhE1Pz3lztw0b9Qvj+7OupnTTkZnpA4H1uELKQyUZTI1fVFPD8Uh
         Ey92CMP6CaKB8YNr1tfYNyQA7H5q56kM2sYXwPs7YYABbd3FKLq09yYJlev2nY/m40pk
         O28ly90d7uu12mtEJGWVz6+JEKrD2GVPNjWaYC02tkxj5LlHzRs0Ggd0KqYTLsTUR2mc
         jbzy0ZBTJ9G8ZCKmutQ++vg9yY/DWI3RylrYLouDElLuRkLdqYJ4Ut8oLIYY/F4D7uur
         ahMQ==
X-Gm-Message-State: AA+aEWZuKyth52EwB+hzpSaF4EFVNrbXCZ0nxsJfg4qg45zNOQ+ZRBmE
        8McNplXvNynPvD4mCv0Suwnx+Gpcxmw=
X-Google-Smtp-Source: AFSGD/XjxfbH7D3RTxngLf37n9XcoAqdlBOw5Gulbp9b1apUNfZRKjXrXNtVu6/LAl87WwbdzzvV3Q==
X-Received: by 2002:a63:6150:: with SMTP id v77mr28002092pgb.266.1543313019860;
        Tue, 27 Nov 2018 02:03:39 -0800 (PST)
Received: from anup-ubuntu64.qualcomm.com ([49.207.48.241])
        by smtp.googlemail.com with ESMTPSA id t87sm9519590pfk.122.2018.11.27.02.03.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 02:03:39 -0800 (PST)
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
Subject: [PATCH v2 2/4] irqchip: sifive-plic: More flexible plic_irq_toggle()
Date:   Tue, 27 Nov 2018 15:33:15 +0530
Message-Id: <20181127100317.12809-3-anup@brainfault.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181127100317.12809-1-anup@brainfault.org>
References: <20181127100317.12809-1-anup@brainfault.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We make plic_irq_toggle() more generic so that we can enable/disable
hwirq for given cpumask. This generic plic_irq_toggle() will be
eventually used to implement set_affinity for PLIC driver.

Signed-off-by: Anup Patel <anup@brainfault.org>
---
 drivers/irqchip/irq-sifive-plic.c | 79 +++++++++++++++----------------
 1 file changed, 39 insertions(+), 40 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index 56fce648a901..95b4b92ca9b8 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -55,19 +55,26 @@
 #define     CONTEXT_THRESHOLD		0x00
 #define     CONTEXT_CLAIM		0x04
 
-static void __iomem *plic_regs;
-
 struct plic_handler {
 	bool			present;
-	int			ctxid;
 	void __iomem		*hart_base;
 	raw_spinlock_t		enable_lock;
 	void __iomem		*enable_base;
 };
+
 static DEFINE_PER_CPU(struct plic_handler, plic_handlers);
 
-static inline void plic_toggle(struct plic_handler *handler,
-				int hwirq, int enable)
+struct plic_hw {
+	u32			nr_irqs;
+	u32			nr_handlers;
+	u32			nr_mapped;
+	void __iomem		*regs;
+	struct irq_domain	*irqdomain;
+};
+
+static struct plic_hw plic;
+
+static void plic_toggle(struct plic_handler *handler, int hwirq, int enable)
 {
 	u32 __iomem *reg = handler->enable_base + (hwirq / 32);
 	u32 hwirq_mask = 1 << (hwirq % 32);
@@ -80,27 +87,23 @@ static inline void plic_toggle(struct plic_handler *handler,
 	raw_spin_unlock(&handler->enable_lock);
 }
 
-static inline void plic_irq_toggle(struct irq_data *d, int enable)
+static void plic_irq_toggle(const struct cpumask *mask, int hwirq, int enable)
 {
 	int cpu;
 
-	writel(enable, plic_regs + PRIORITY_BASE + d->hwirq * PRIORITY_PER_ID);
-	for_each_cpu(cpu, irq_data_get_affinity_mask(d)) {
-		struct plic_handler *handler = per_cpu_ptr(&plic_handlers, cpu);
-
-		if (handler->present)
-			plic_toggle(handler, d->hwirq, enable);
-	}
+	writel(enable, plic.regs + PRIORITY_BASE + hwirq * PRIORITY_PER_ID);
+	for_each_cpu(cpu, mask)
+		plic_toggle(per_cpu_ptr(&plic_handlers, cpu), hwirq, enable);
 }
 
 static void plic_irq_enable(struct irq_data *d)
 {
-	plic_irq_toggle(d, 1);
+	plic_irq_toggle(irq_data_get_affinity_mask(d), d->hwirq, 1);
 }
 
 static void plic_irq_disable(struct irq_data *d)
 {
-	plic_irq_toggle(d, 0);
+	plic_irq_toggle(irq_data_get_affinity_mask(d), d->hwirq, 0);
 }
 
 static struct irq_chip plic_chip = {
@@ -127,8 +130,6 @@ static const struct irq_domain_ops plic_irqdomain_ops = {
 	.xlate		= irq_domain_xlate_onecell,
 };
 
-static struct irq_domain *plic_irqdomain;
-
 /*
  * Handling an interrupt is a two-step process: first you claim the interrupt
  * by reading the claim register, then you complete the interrupt by writing
@@ -145,7 +146,7 @@ static void plic_handle_irq(struct pt_regs *regs)
 
 	csr_clear(sie, SIE_SEIE);
 	while ((hwirq = readl(claim))) {
-		int irq = irq_find_mapping(plic_irqdomain, hwirq);
+		int irq = irq_find_mapping(plic.irqdomain, hwirq);
 
 		if (unlikely(irq <= 0))
 			pr_warn_ratelimited("can't find mapping for hwirq %lu\n",
@@ -174,36 +175,34 @@ static int plic_find_hart_id(struct device_node *node)
 static int __init plic_init(struct device_node *node,
 		struct device_node *parent)
 {
-	int error = 0, nr_handlers, nr_mapped = 0, i;
-	u32 nr_irqs;
+	int error = 0, i;
 
-	if (plic_regs) {
+	if (plic.regs) {
 		pr_warn("PLIC already present.\n");
 		return -ENXIO;
 	}
 
-	plic_regs = of_iomap(node, 0);
-	if (WARN_ON(!plic_regs))
+	plic.regs = of_iomap(node, 0);
+	if (WARN_ON(!plic.regs))
 		return -EIO;
 
 	error = -EINVAL;
-	of_property_read_u32(node, "riscv,ndev", &nr_irqs);
-	if (WARN_ON(!nr_irqs))
+	of_property_read_u32(node, "riscv,ndev", &plic.nr_irqs);
+	if (WARN_ON(!plic.nr_irqs))
 		goto out_iounmap;
 
-	nr_handlers = of_irq_count(node);
-	if (WARN_ON(!nr_handlers))
+	plic.nr_handlers = of_irq_count(node);
+	if (WARN_ON(!plic.nr_handlers))
 		goto out_iounmap;
-	if (WARN_ON(nr_handlers < num_possible_cpus()))
+	if (WARN_ON(plic.nr_handlers < num_possible_cpus()))
 		goto out_iounmap;
 
-	error = -ENOMEM;
-	plic_irqdomain = irq_domain_add_linear(node, nr_irqs + 1,
-			&plic_irqdomain_ops, NULL);
-	if (WARN_ON(!plic_irqdomain))
+	plic.irqdomain = irq_domain_add_linear(node, plic.nr_irqs + 1,
+						&plic_irqdomain_ops, NULL);
+	if (WARN_ON(!plic.irqdomain))
 		goto out_iounmap;
 
-	for (i = 0; i < nr_handlers; i++) {
+	for (i = 0; i < plic.nr_handlers; i++) {
 		struct of_phandle_args parent;
 		struct plic_handler *handler;
 		irq_hw_number_t hwirq;
@@ -227,27 +226,27 @@ static int __init plic_init(struct device_node *node,
 		cpu = riscv_hartid_to_cpuid(hartid);
 		handler = per_cpu_ptr(&plic_handlers, cpu);
 		handler->present = true;
-		handler->ctxid = i;
 		handler->hart_base =
-			plic_regs + CONTEXT_BASE + i * CONTEXT_PER_HART;
+			plic.regs + CONTEXT_BASE + i * CONTEXT_PER_HART;
 		raw_spin_lock_init(&handler->enable_lock);
 		handler->enable_base =
-			plic_regs + ENABLE_BASE + i * ENABLE_PER_HART;
+			plic.regs + ENABLE_BASE + i * ENABLE_PER_HART;
 
 		/* priority must be > threshold to trigger an interrupt */
 		writel(0, handler->hart_base + CONTEXT_THRESHOLD);
-		for (hwirq = 1; hwirq <= nr_irqs; hwirq++)
+		for (hwirq = 1; hwirq <= plic.nr_irqs; hwirq++)
 			plic_toggle(handler, hwirq, 0);
-		nr_mapped++;
+
+		plic.nr_mapped++;
 	}
 
 	pr_info("mapped %d interrupts to %d (out of %d) handlers.\n",
-		nr_irqs, nr_mapped, nr_handlers);
+		plic.nr_irqs, plic.nr_mapped, plic.nr_handlers);
 	set_handle_irq(plic_handle_irq);
 	return 0;
 
 out_iounmap:
-	iounmap(plic_regs);
+	iounmap(plic.regs);
 	return error;
 }
 
-- 
2.17.1


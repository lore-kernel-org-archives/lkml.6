Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27894C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 12:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD51620853
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 12:03:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="dcoxU3XH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD51620853
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728649AbeJVUWI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 16:22:08 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33714 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727787AbeJVUWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 16:22:08 -0400
Received: by mail-pg1-f194.google.com with SMTP id z2-v6so2525509pgp.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 05:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=m2kB9oRJwBCt2qOMzhoxgD2s3i1oZTw9L/iH7YEEqpY=;
        b=dcoxU3XHMzEla+SQ4gVwSP2Rczu0rSLkL1uoFTtIbX7J1lGHzijYJV81eaac0okTDB
         XEaBKj3D31BT0fRmbZBcrfP2yqnS1Z2+7HZfznI3T85XJtkmOBqJoJsPFjdK9imwPjTX
         kcEacPCvanYJZx+TqXttw4gYbHUm71/vpVd5pKXQedjcXRHcLOZ5Ol91icFHJvlC9Qpt
         6Htkack4hldLgZlnFjgxMXc8xozExZp1BrvtutGNonjS0YfzEo1P5OVUc16U7tVpvt/7
         Vr+dfjjEAQmlOKA75eIzlPhnmDNgeBN/Q4v+CDmMSmfCk5uheMPhQcoHFc0R94Ux5khp
         AvRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=m2kB9oRJwBCt2qOMzhoxgD2s3i1oZTw9L/iH7YEEqpY=;
        b=SNeBmt1gh34uSGhGKdEtZKiN2CE//PhIXx0sDQYBDzfWAPB8msI219b29PYL4KaNgO
         ZOYuvFLy1EVWljERLxfXXoBbXZyEsk6lU4JmPvmvPNguEiV7VHmyN45gpc1lCFX0IkcE
         ly+c5LwUjqxyPJ6rmBFErAyvZN5i/h8hli9+hXI906oMFBmjdoO5a3TQtv5PoKhYZ8qA
         feEr83knwZ6XSzcv28jQq0JUawiiJuzyhB/jR0/VJGudAtF1yxB/KMdyu7AigHpJZrmU
         neldMwzTlyFmCJs3BzmRU4zBjqYUC6SRj+QuhkX1rzBieycBQZIh8NpgpYA2bxxCB9LK
         8NvQ==
X-Gm-Message-State: ABuFfoirk+JOI4xSCGTud3GoAITDX8QKAUhjQmTzmuPqdyw9RB6m6YYo
        dW3w8qF8m6mBDl6AcZosmFkJOg==
X-Google-Smtp-Source: ACcGV61kyk38bMliMjm9FbxGq8IqwAk3jczU4J4fAo0uLXTZ9EGHm5dRCVqlQYOtXVVBPPdI991/yw==
X-Received: by 2002:a63:41c2:: with SMTP id o185-v6mr41831916pga.11.1540209830617;
        Mon, 22 Oct 2018 05:03:50 -0700 (PDT)
Received: from anup-ubuntu64.dlink.router ([106.51.30.16])
        by smtp.googlemail.com with ESMTPSA id n79-v6sm55443405pfk.19.2018.10.22.05.03.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Oct 2018 05:03:49 -0700 (PDT)
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
Subject: [PATCH 2/4] irqchip: sifive-plic: More flexible plic_irq_toggle()
Date:   Mon, 22 Oct 2018 17:15:15 +0530
Message-Id: <20181022114517.22748-3-anup@brainfault.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181022114517.22748-1-anup@brainfault.org>
References: <20181022114517.22748-1-anup@brainfault.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We make plic_irq_toggle() more generic so that we can enable/disable
hwirq for given cpumask. This generic plic_irq_toggle() will be
eventually used to implement set_affinity for PLIC driver.

Signed-off-by: Anup Patel <anup@brainfault.org>
---
 drivers/irqchip/irq-sifive-plic.c | 89 ++++++++++++++++---------------
 1 file changed, 47 insertions(+), 42 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index f93ec83eaff4..869355d2a713 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -55,19 +55,25 @@
 #define CONTEXT_THRESHOLD		0x00
 #define CONTEXT_CLAIM			0x04
 
-static void __iomem *plic_regs;
-
 struct plic_handler {
 	bool			present;
-	int			ctxid;
 	void __iomem		*hart_base;
 	raw_spinlock_t		enable_lock;
 	void __iomem		*enable_base;
 };
-static DEFINE_PER_CPU(struct plic_handler, plic_handlers);
 
-static inline void plic_toggle(struct plic_handler *handler,
-				int hwirq, int enable)
+struct plic_hw {
+	u32			nr_irqs;
+	u32			nr_handlers;
+	u32			nr_mapped;
+	void __iomem		*regs;
+	struct plic_handler	*handlers;
+	struct irq_domain	*irqdomain;
+};
+
+static struct plic_hw plic;
+
+static void plic_toggle(struct plic_handler *handler, int hwirq, int enable)
 {
 	u32 __iomem *reg = handler->enable_base + (hwirq / 32);
 	u32 hwirq_mask = 1 << (hwirq % 32);
@@ -80,27 +86,23 @@ static inline void plic_toggle(struct plic_handler *handler,
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
+		plic_toggle(per_cpu_ptr(plic.handlers, cpu), hwirq, enable);
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
@@ -127,8 +129,6 @@ static const struct irq_domain_ops plic_irqdomain_ops = {
 	.xlate		= irq_domain_xlate_onecell,
 };
 
-static struct irq_domain *plic_irqdomain;
-
 /*
  * Handling an interrupt is a two-step process: first you claim the interrupt
  * by reading the claim register, then you complete the interrupt by writing
@@ -137,7 +137,7 @@ static struct irq_domain *plic_irqdomain;
  */
 static void plic_handle_irq(struct pt_regs *regs)
 {
-	struct plic_handler *handler = this_cpu_ptr(&plic_handlers);
+	struct plic_handler *handler = this_cpu_ptr(plic.handlers);
 	void __iomem *claim = handler->hart_base + CONTEXT_CLAIM;
 	irq_hw_number_t hwirq;
 
@@ -145,7 +145,7 @@ static void plic_handle_irq(struct pt_regs *regs)
 
 	csr_clear(sie, SIE_SEIE);
 	while ((hwirq = readl(claim))) {
-		int irq = irq_find_mapping(plic_irqdomain, hwirq);
+		int irq = irq_find_mapping(plic.irqdomain, hwirq);
 
 		if (unlikely(irq <= 0))
 			pr_warn_ratelimited("can't find mapping for hwirq %lu\n",
@@ -174,36 +174,39 @@ static int plic_find_hart_id(struct device_node *node)
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
 
 	error = -ENOMEM;
-	plic_irqdomain = irq_domain_add_linear(node, nr_irqs + 1,
-			&plic_irqdomain_ops, NULL);
-	if (WARN_ON(!plic_irqdomain))
+	plic.handlers = alloc_percpu(struct plic_handler);
+	if (!plic.handlers)
 		goto out_iounmap;
 
-	for (i = 0; i < nr_handlers; i++) {
+	plic.irqdomain = irq_domain_add_linear(node, plic.nr_irqs + 1,
+						&plic_irqdomain_ops, NULL);
+	if (WARN_ON(!plic.irqdomain))
+		goto out_free_handlers;
+
+	for (i = 0; i < plic.nr_handlers; i++) {
 		struct of_phandle_args parent;
 		struct plic_handler *handler;
 		irq_hw_number_t hwirq;
@@ -225,29 +228,31 @@ static int __init plic_init(struct device_node *node,
 		}
 
 		cpu = riscv_hartid_to_cpuid(hartid);
-		handler = per_cpu_ptr(&plic_handlers, cpu);
+		handler = per_cpu_ptr(plic.handlers, cpu);
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
 
+out_free_handlers:
+	free_percpu(plic.handlers);
 out_iounmap:
-	iounmap(plic_regs);
+	iounmap(plic.regs);
 	return error;
 }
 
-- 
2.17.1


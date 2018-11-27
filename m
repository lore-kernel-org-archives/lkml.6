Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E47AC04EBA
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 10:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0294320873
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 10:03:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="KCPo0TX6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0294320873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730567AbeK0VBI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 16:01:08 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38467 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730371AbeK0VBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 16:01:07 -0500
Received: by mail-pf1-f195.google.com with SMTP id q1so8115840pfi.5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 02:03:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=arjeBMdw9sCQtY7MdQAlVkfUbrvemGUsW01G3n51jWI=;
        b=KCPo0TX60Z45IB5BeS5G7Sm/miAkY91wN3wEOAgkNTzBD4uM3Dz8duXoAi1+x99lzD
         7159m3jNaF6GdMhdwLxYRww9baUAYmMBTLA42HOrmKQP3GAPWk+JH/btZBLEyaam5/z3
         d0wyISCHqiBRgOsdvEiiZO4YQructIsdP8vBOCHAL5YYMz7QAFYGC8w3S1p7EXw+khXF
         x5pDtU6mBmAg6Z7P1ouRX7NWkFeekZQJM4xQFKTyDnMmUuORUjTUiXdhNM8+/xLxggcl
         866cynbFqqvQQxWAwuOkYkay79h1TF8qUtaVU6JYI5niU8+lFfKNUoPFiPnnkw34+6QX
         t6VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=arjeBMdw9sCQtY7MdQAlVkfUbrvemGUsW01G3n51jWI=;
        b=OCbQBAXsweZ6km/ZAaDjT+0KMLiUJJfhA5Ek+34HD7DaA+JDMrmijuJwN3Z7bftwD4
         lzgNMfujqlb586DuqrO3r/362U86ztRQ60g926tyKLJ/kB06PnMrqTI6HAOx2J8vZ2uY
         C8sE2Ezn24+sSgBun2IGl1gTv53fwv40jRxnF8GrF2ZQXQwqXe1sI+T4VYHWbOQ2KQ/f
         0NBi/oC7Yi2UKceJRVJGMehXZgwwPKb/q8bcRIoV8pzvMCbTuKQxzzU0w1hPFxFK1+HG
         3BBq5DMmYG1laKtmHq8uLor+UFf4ol1LHIsmduVq5Lhi0iArxukzk+SjB7kdKIdtxy+B
         Nc7A==
X-Gm-Message-State: AA+aEWbUyVPLRqDa+5/MNyk5FXgvzUdG3QsJin7aFW31Z3DEVa3LdQ+M
        nlbCUBnA4SrzskLFCajuzDlfgA==
X-Google-Smtp-Source: AFSGD/XH92rpV5v0MJGRy132yya5Md/mor/XvAlG2mkFetuFuGQilUnsbhKmcr1D/Hy4lfPm7IQTRQ==
X-Received: by 2002:a63:334a:: with SMTP id z71mr28779865pgz.400.1543313024612;
        Tue, 27 Nov 2018 02:03:44 -0800 (PST)
Received: from anup-ubuntu64.qualcomm.com ([49.207.48.241])
        by smtp.googlemail.com with ESMTPSA id t87sm9519590pfk.122.2018.11.27.02.03.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 02:03:43 -0800 (PST)
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
Subject: [PATCH v2 3/4] irqchip: sifive-plic: Differentiate between PLIC handler and context
Date:   Tue, 27 Nov 2018 15:33:16 +0530
Message-Id: <20181127100317.12809-4-anup@brainfault.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181127100317.12809-1-anup@brainfault.org>
References: <20181127100317.12809-1-anup@brainfault.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We explicitly differentiate between PLIC handler and context because
PLIC context is for given mode of HART whereas PLIC handler is per-CPU
software construct meant for handling interrupts from a particular
PLIC context.

Signed-off-by: Anup Patel <anup@brainfault.org>
---
 drivers/irqchip/irq-sifive-plic.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index 95b4b92ca9b8..ffd4deaca057 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -66,8 +66,8 @@ static DEFINE_PER_CPU(struct plic_handler, plic_handlers);
 
 struct plic_hw {
 	u32			nr_irqs;
+	u32			nr_contexts;
 	u32			nr_handlers;
-	u32			nr_mapped;
 	void __iomem		*regs;
 	struct irq_domain	*irqdomain;
 };
@@ -191,10 +191,10 @@ static int __init plic_init(struct device_node *node,
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
 
 	plic.irqdomain = irq_domain_add_linear(node, plic.nr_irqs + 1,
@@ -202,7 +202,7 @@ static int __init plic_init(struct device_node *node,
 	if (WARN_ON(!plic.irqdomain))
 		goto out_iounmap;
 
-	for (i = 0; i < plic.nr_handlers; i++) {
+	for (i = 0; i < plic.nr_contexts; i++) {
 		struct of_phandle_args parent;
 		struct plic_handler *handler;
 		irq_hw_number_t hwirq;
@@ -225,6 +225,11 @@ static int __init plic_init(struct device_node *node,
 
 		cpu = riscv_hartid_to_cpuid(hartid);
 		handler = per_cpu_ptr(&plic_handlers, cpu);
+		if (handler->present) {
+			pr_warn("handler not available for context %d.\n", i);
+			continue;
+		}
+
 		handler->present = true;
 		handler->hart_base =
 			plic.regs + CONTEXT_BASE + i * CONTEXT_PER_HART;
@@ -237,11 +242,11 @@ static int __init plic_init(struct device_node *node,
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


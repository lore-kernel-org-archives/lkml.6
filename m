Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65803C43612
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 11:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34480218E2
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 11:19:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="WAe7HAbn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730815AbeL0LS7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 06:18:59 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41085 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728029AbeL0LS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 06:18:57 -0500
Received: by mail-pf1-f193.google.com with SMTP id b7so9038446pfi.8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Dec 2018 03:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zz52nPvPtFJqyPj2XZVPMynhhMIZtDAuu6S8fhVpQdc=;
        b=WAe7HAbnm+qv9cToQwe0w2BpEYSadHAV9NFIvbw2zg8l4wmOPVaprWswj9twekOMhq
         rYIQVAe4LelBXZ5O2RNolRB8KvZX3BLohqDYj2UfQPTjLuDST7tmQTAide8wpveB0izD
         SWCZ9ew+Y7dkuDeb/WlHVcq8KJ5Xbby4pHCoulMohyW13G83jCDC7bUfqk+X3cr20Qed
         0AMvDdm+wr99n1LEJaPzUVvcBK26yT7M4GLh0+Pe+DUEE589WVqpS9akf1+TLINjPWgo
         0yPINXpFjw7Rzg1V7vk0PXgZRVDaMElD8E0fX8HUN4PkJv54E353XIiodNrK/NUQ1kBI
         N0Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zz52nPvPtFJqyPj2XZVPMynhhMIZtDAuu6S8fhVpQdc=;
        b=YwFVG8E07b2hUFLZbXEf4ZxZavmJuL6AihfuzxI2jmSewJEhLnMGvmoHVMXCguTHMg
         XFaTeAUV3ZTzQDgJnCKttY6d8F2xHH/iOHVg8qQVpBUi7xGG1+SowDIgRfBAy6/rp278
         crtIy9gmZ7EAx+EpMzXlMwqVML5dmTR81uCy6UccRimfIRhBCHH4mA9Jni8H+FTh7RwC
         Pu31GiORcVcb5p64iYtZp130B8tuwFmKgsw1j1iSeTrQW282djCUafnJHnzbGwC7HbV0
         xUv4B+BhsIaInNe9ts4PABSOwN3O/vMkDP1dQAAhZAvAE3f8+HRQcMH7IzWVhbGl1K/g
         hGsw==
X-Gm-Message-State: AJcUukeOWI4F+L7gcsws9hHYMO1mWEzEGUMC5bz+m9kgmX7kX/zzKMoc
        yo3MpiM38wvDwzI6XMTd26ZivzEEPuY=
X-Google-Smtp-Source: AFSGD/X+LOHWk4aZSzbivi7mbj6HaStEZBpd4C2Oz2kwlxEufHrcAyEZmTI6ihSrnR2GfGep4DVgig==
X-Received: by 2002:a62:f247:: with SMTP id y7mr23817585pfl.25.1545909536994;
        Thu, 27 Dec 2018 03:18:56 -0800 (PST)
Received: from localhost.localdomain ([106.51.18.57])
        by smtp.gmail.com with ESMTPSA id u137sm66830105pfc.140.2018.12.27.03.18.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Dec 2018 03:18:56 -0800 (PST)
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
Subject: [PATCH v4 4/5] irqchip: sifive-plic: Differentiate between PLIC handler and context
Date:   Thu, 27 Dec 2018 16:48:20 +0530
Message-Id: <20181227111821.80908-5-anup@brainfault.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181227111821.80908-1-anup@brainfault.org>
References: <20181227111821.80908-1-anup@brainfault.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We explicitly differentiate between PLIC handler and context because
PLIC context is for given mode of HART whereas PLIC handler is per-CPU
software construct meant for handling interrupts from a particular
PLIC context.

To achieve this differentiation, we rename "nr_handlers" to "nr_contexts"
and "nr_mapped" to "nr_handlers" in plic_init().

Signed-off-by: Anup Patel <anup@brainfault.org>
---
 drivers/irqchip/irq-sifive-plic.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index b9a0bcefe426..24c906f4be93 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -177,7 +177,7 @@ static int plic_find_hart_id(struct device_node *node)
 static int __init plic_init(struct device_node *node,
 		struct device_node *parent)
 {
-	int error = 0, nr_handlers, nr_mapped = 0, i;
+	int error = 0, nr_contexts, nr_handlers = 0, i;
 	u32 nr_irqs;
 
 	if (plic_regs) {
@@ -194,10 +194,10 @@ static int __init plic_init(struct device_node *node,
 	if (WARN_ON(!nr_irqs))
 		goto out_iounmap;
 
-	nr_handlers = of_irq_count(node);
-	if (WARN_ON(!nr_handlers))
+	nr_contexts = of_irq_count(node);
+	if (WARN_ON(!nr_contexts))
 		goto out_iounmap;
-	if (WARN_ON(nr_handlers < num_possible_cpus()))
+	if (WARN_ON(nr_contexts < num_possible_cpus()))
 		goto out_iounmap;
 
 	error = -ENOMEM;
@@ -206,7 +206,7 @@ static int __init plic_init(struct device_node *node,
 	if (WARN_ON(!plic_irqdomain))
 		goto out_iounmap;
 
-	for (i = 0; i < nr_handlers; i++) {
+	for (i = 0; i < nr_contexts; i++) {
 		struct of_phandle_args parent;
 		struct plic_handler *handler;
 		irq_hw_number_t hwirq;
@@ -245,11 +245,11 @@ static int __init plic_init(struct device_node *node,
 		writel(0, handler->hart_base + CONTEXT_THRESHOLD);
 		for (hwirq = 1; hwirq <= nr_irqs; hwirq++)
 			plic_toggle(handler, hwirq, 0);
-		nr_mapped++;
+		nr_handlers++;
 	}
 
-	pr_info("mapped %d interrupts to %d (out of %d) handlers.\n",
-		nr_irqs, nr_mapped, nr_handlers);
+	pr_info("mapped %d interrupts with %d handlers for %d contexts.\n",
+		nr_irqs, nr_handlers, nr_contexts);
 	set_handle_irq(plic_handle_irq);
 	return 0;
 
-- 
2.17.1


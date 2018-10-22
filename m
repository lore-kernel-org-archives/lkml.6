Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD2E5C67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 12:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A42EB20652
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 12:03:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="rTyT29de"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A42EB20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728556AbeJVUWD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 16:22:03 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42508 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727787AbeJVUWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 16:22:03 -0400
Received: by mail-pl1-f193.google.com with SMTP id c8-v6so18961852plo.9
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 05:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TUe06IOQ52AzaiUZGqr/tV47sWpx1zaKoYXhtVZ9bkQ=;
        b=rTyT29de1bAw5zVn7PpcTaPZNMJiu+AuufRkdusojhJLqtsmR+Hg+6oJdw52BNHU/g
         /rlQQN09Rky0/o1GiaLde6EWFNXv6cJcMqN/HkdVhCNqD/qutw3kKgLeDNw2U7KubLcP
         AdBSKlq/n3tM+5uNiyp+hfdfBkAjwyXMleGvwiczLoP9OHwzeE5JtdwAiNCNgUG8KKFf
         DMiw7WXgW3DJyWU8lpgZFB9DYW0vz+22auPN4lRzESsrnoWnE3BxujMK4UG5SVpbbgGI
         H+eTQUsw337lanK5kr5Ar+NQKYRWK7JKuxrMfBtCftbY2Z0kIzCIKqVP/8pBJ4ksJGWY
         Pufg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TUe06IOQ52AzaiUZGqr/tV47sWpx1zaKoYXhtVZ9bkQ=;
        b=BF4CjJ16373dMxAgHQMO2MeoxMAYKd3GxvMwfKbOe72Ih8B9J3FiaVkHfrDan+M6s3
         b5M5yaWE+cR2yNf7FCczgXYG8HBz4GIQMoG7m6G+SgeEYoFp8fulnh5ZsYUszqpx1E/l
         xU0p5GqxWN6t30Kg1mG7HNRZXobhqS+/zhNBlaZzbaw2DKmj9qKS4PIsMYhU8q3wQgp7
         2+B+rmu+UwHQZj00g3dWYuQXF23k9qg9Pxs0NXMbYJ4kt5XAfXoq49i7Si27XZsgB031
         8pVDVpeFdMTTt69s+uAdb0P4DyI8QutqScCrUaccZ4KfyXkHMvMKRRma/8BiOQhHpC86
         ah3w==
X-Gm-Message-State: ABuFfohFyC+HH1XXyWT9jHWg3ZJJLRMwz1kWnyIFUBfF1XGa9GPnV6K7
        X2PYFoPkPzsv4KzWiHLcBmD6Kw==
X-Google-Smtp-Source: ACcGV602RD/0tC4EG1YO6gYLiNlB/sAxTWlLfdtPfMmlkFCs6gZhS1ahD0BsfzIbRVLxma+6wcWTJw==
X-Received: by 2002:a17:902:bc44:: with SMTP id t4-v6mr13502218plz.300.1540209825763;
        Mon, 22 Oct 2018 05:03:45 -0700 (PDT)
Received: from anup-ubuntu64.dlink.router ([106.51.30.16])
        by smtp.googlemail.com with ESMTPSA id n79-v6sm55443405pfk.19.2018.10.22.05.03.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Oct 2018 05:03:44 -0700 (PDT)
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
Subject: [PATCH 1/4] irqchip: sifive-plic: Pre-compute context hart base and enable base
Date:   Mon, 22 Oct 2018 17:15:14 +0530
Message-Id: <20181022114517.22748-2-anup@brainfault.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181022114517.22748-1-anup@brainfault.org>
References: <20181022114517.22748-1-anup@brainfault.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch does following optimizations:
1. Pre-compute hart base for each context handler
2. Pre-compute enable base for each context handler
3. Have enable lock for each context handler instead
of global plic_toggle_lock

Signed-off-by: Anup Patel <anup@brainfault.org>
---
 drivers/irqchip/irq-sifive-plic.c | 51 +++++++++++++------------------
 1 file changed, 22 insertions(+), 29 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index 357e9daf94ae..f93ec83eaff4 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -36,14 +36,14 @@
  * We always hardwire it to one in Linux.
  */
 #define PRIORITY_BASE			0
-#define     PRIORITY_PER_ID		4
+#define PRIORITY_PER_ID			4
 
 /*
  * Each hart context has a vector of interrupt enable bits associated with it.
  * There's one bit for each interrupt source.
  */
 #define ENABLE_BASE			0x2000
-#define     ENABLE_PER_HART		0x80
+#define ENABLE_PER_HART			0x80
 
 /*
  * Each hart context has a set of control registers associated with it.  Right
@@ -51,45 +51,33 @@
  * take an interrupt, and a register to claim interrupts.
  */
 #define CONTEXT_BASE			0x200000
-#define     CONTEXT_PER_HART		0x1000
-#define     CONTEXT_THRESHOLD		0x00
-#define     CONTEXT_CLAIM		0x04
+#define CONTEXT_PER_HART		0x1000
+#define CONTEXT_THRESHOLD		0x00
+#define CONTEXT_CLAIM			0x04
 
 static void __iomem *plic_regs;
 
 struct plic_handler {
 	bool			present;
 	int			ctxid;
+	void __iomem		*hart_base;
+	raw_spinlock_t		enable_lock;
+	void __iomem		*enable_base;
 };
 static DEFINE_PER_CPU(struct plic_handler, plic_handlers);
 
-static inline void __iomem *plic_hart_offset(int ctxid)
+static inline void plic_toggle(struct plic_handler *handler,
+				int hwirq, int enable)
 {
-	return plic_regs + CONTEXT_BASE + ctxid * CONTEXT_PER_HART;
-}
-
-static inline u32 __iomem *plic_enable_base(int ctxid)
-{
-	return plic_regs + ENABLE_BASE + ctxid * ENABLE_PER_HART;
-}
-
-/*
- * Protect mask operations on the registers given that we can't assume that
- * atomic memory operations work on them.
- */
-static DEFINE_RAW_SPINLOCK(plic_toggle_lock);
-
-static inline void plic_toggle(int ctxid, int hwirq, int enable)
-{
-	u32 __iomem *reg = plic_enable_base(ctxid) + (hwirq / 32);
+	u32 __iomem *reg = handler->enable_base + (hwirq / 32);
 	u32 hwirq_mask = 1 << (hwirq % 32);
 
-	raw_spin_lock(&plic_toggle_lock);
+	raw_spin_lock(&handler->enable_lock);
 	if (enable)
 		writel(readl(reg) | hwirq_mask, reg);
 	else
 		writel(readl(reg) & ~hwirq_mask, reg);
-	raw_spin_unlock(&plic_toggle_lock);
+	raw_spin_unlock(&handler->enable_lock);
 }
 
 static inline void plic_irq_toggle(struct irq_data *d, int enable)
@@ -101,7 +89,7 @@ static inline void plic_irq_toggle(struct irq_data *d, int enable)
 		struct plic_handler *handler = per_cpu_ptr(&plic_handlers, cpu);
 
 		if (handler->present)
-			plic_toggle(handler->ctxid, d->hwirq, enable);
+			plic_toggle(handler, d->hwirq, enable);
 	}
 }
 
@@ -150,7 +138,7 @@ static struct irq_domain *plic_irqdomain;
 static void plic_handle_irq(struct pt_regs *regs)
 {
 	struct plic_handler *handler = this_cpu_ptr(&plic_handlers);
-	void __iomem *claim = plic_hart_offset(handler->ctxid) + CONTEXT_CLAIM;
+	void __iomem *claim = handler->hart_base + CONTEXT_CLAIM;
 	irq_hw_number_t hwirq;
 
 	WARN_ON_ONCE(!handler->present);
@@ -240,11 +228,16 @@ static int __init plic_init(struct device_node *node,
 		handler = per_cpu_ptr(&plic_handlers, cpu);
 		handler->present = true;
 		handler->ctxid = i;
+		handler->hart_base =
+			plic_regs + CONTEXT_BASE + i * CONTEXT_PER_HART;
+		raw_spin_lock_init(&handler->enable_lock);
+		handler->enable_base =
+			plic_regs + ENABLE_BASE + i * ENABLE_PER_HART;
 
 		/* priority must be > threshold to trigger an interrupt */
-		writel(0, plic_hart_offset(i) + CONTEXT_THRESHOLD);
+		writel(0, handler->hart_base + CONTEXT_THRESHOLD);
 		for (hwirq = 1; hwirq <= nr_irqs; hwirq++)
-			plic_toggle(i, hwirq, 0);
+			plic_toggle(handler, hwirq, 0);
 		nr_mapped++;
 	}
 
-- 
2.17.1


Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C74DC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 12:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD85B2084E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 12:53:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="EdXk3o+6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729311AbfBLMxG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 07:53:06 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36004 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728546AbfBLMxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 07:53:06 -0500
Received: by mail-pl1-f195.google.com with SMTP id g9so1271470plo.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 04:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=O2ZupOs/WFdJwiPbINO+V0JVWJpBFSTcpyV82FP5qBM=;
        b=EdXk3o+6gdqZKzksNpcQPvKazI9T4E+YuALjwlEN4jqTM3nsgzi0G+ONOdProNnzGi
         MT+RIUATXqc4I7sVFHico//NN3pteF0wLMN90CiNOjMrm1AGeVmk1xNe8/7JOtb9AfFw
         y1T+//eYC349DP5llgisAvJZd0eCpJ3Pr6NQMpTk6856Oh4lsfgIvyqxNhFdvbvufPSA
         1MV1MEnrvMFRfCKqOXuGoImmWkzasQxGSePY9a2OXjNzpBo0XueN6Y2Ihppzom+SDLaN
         UWcPBY8MCmof+Ocj1UhznO2it7iw0Vmt9NBd8Dfr2O1B97W/HB3khVBs1GwhAUhxpxYn
         MTLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=O2ZupOs/WFdJwiPbINO+V0JVWJpBFSTcpyV82FP5qBM=;
        b=t0HO4rylGnMcmF8i1EafLjnjVnjoR3ms7LTp9p/5Uo1mgFYoyUwqHZ6HO5WHEpErjU
         soTHaQ/3L3L4pg/iLMcOctf5k9A3flVNAyq4F6EuYNSoq8HNgQbOeJW+CPwFPDB+MeT1
         hpEga7fyZd+6zHtBEQOfC6jpKfA3bik2IQsUkvOG2scHh9Zowdts7EVxDoQw6YPFPthy
         IeWYJ/p6ECHyT022Yb7UpyWjK+izDlI5PF4VOAiC5hkZ6jXHVp0ATDVuFT9YyoVShECJ
         Z8J15Xgk/nU6P/l5dDKwY2iNlhrpxtsHQBKf1IQ0LkFynTu8pnfEWAOKd8cBIf+3D9xa
         iZ/g==
X-Gm-Message-State: AHQUAuYiiQIaP8KutR2dH6znCkroGGEa/dUCPDu18A7ugWv7Nq7BxNR7
        0gg6taApntdWNM1zwq6R09o6GQ==
X-Google-Smtp-Source: AHgI3IbGqT57HdMf9TSaf9uzNQL4Nsb2en1MF+Af7z4R0Du5m7S1+OaE5P2A5Axwy8ck9gG8OVEDpA==
X-Received: by 2002:a17:902:6a4:: with SMTP id 33mr3831492plh.99.1549975985360;
        Tue, 12 Feb 2019 04:53:05 -0800 (PST)
Received: from localhost.localdomain ([49.207.48.205])
        by smtp.gmail.com with ESMTPSA id z67sm27894828pfd.188.2019.02.12.04.53.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 04:53:04 -0800 (PST)
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
Subject: [PATCH v6 1/4] irqchip: sifive-plic: Pre-compute context hart base and enable base
Date:   Tue, 12 Feb 2019 18:22:43 +0530
Message-Id: <20190212125246.69239-2-anup@brainfault.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190212125246.69239-1-anup@brainfault.org>
References: <20190212125246.69239-1-anup@brainfault.org>
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/irqchip/irq-sifive-plic.c | 47 ++++++++++++++-----------------
 1 file changed, 21 insertions(+), 26 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index 357e9daf94ae..c23a293a2aae 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -59,37 +59,28 @@ static void __iomem *plic_regs;
 
 struct plic_handler {
 	bool			present;
-	int			ctxid;
+	void __iomem		*hart_base;
+	/*
+	 * Protect mask operations on the registers given that we can't
+	 * assume atomic memory operations work on them.
+	 */
+	raw_spinlock_t		enable_lock;
+	void __iomem		*enable_base;
 };
 static DEFINE_PER_CPU(struct plic_handler, plic_handlers);
 
-static inline void __iomem *plic_hart_offset(int ctxid)
-{
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
+static inline void plic_toggle(struct plic_handler *handler,
+				int hwirq, int enable)
 {
-	u32 __iomem *reg = plic_enable_base(ctxid) + (hwirq / 32);
+	u32 __iomem *reg = handler->enable_base + (hwirq / 32) * sizeof(u32);
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
@@ -101,7 +92,7 @@ static inline void plic_irq_toggle(struct irq_data *d, int enable)
 		struct plic_handler *handler = per_cpu_ptr(&plic_handlers, cpu);
 
 		if (handler->present)
-			plic_toggle(handler->ctxid, d->hwirq, enable);
+			plic_toggle(handler, d->hwirq, enable);
 	}
 }
 
@@ -150,7 +141,7 @@ static struct irq_domain *plic_irqdomain;
 static void plic_handle_irq(struct pt_regs *regs)
 {
 	struct plic_handler *handler = this_cpu_ptr(&plic_handlers);
-	void __iomem *claim = plic_hart_offset(handler->ctxid) + CONTEXT_CLAIM;
+	void __iomem *claim = handler->hart_base + CONTEXT_CLAIM;
 	irq_hw_number_t hwirq;
 
 	WARN_ON_ONCE(!handler->present);
@@ -239,12 +230,16 @@ static int __init plic_init(struct device_node *node,
 		cpu = riscv_hartid_to_cpuid(hartid);
 		handler = per_cpu_ptr(&plic_handlers, cpu);
 		handler->present = true;
-		handler->ctxid = i;
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


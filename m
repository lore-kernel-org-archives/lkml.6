Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F090C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 264A720881
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:42:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="FD4eq5Gl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387607AbfAaNmc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 08:42:32 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40257 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387583AbfAaNjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 08:39:52 -0500
Received: by mail-wm1-f65.google.com with SMTP id f188so2567008wmf.5
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 05:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=igN5IoKzzGuypW/WHng8Q0d0kyUmZgcX+TCusVRQQ20=;
        b=FD4eq5Gl8rn+2Ho+toNgwkBbm/TucRqZYioCAgmKXiO7UUsz38dYCUH/imHOkm5wip
         8gpPrcHt25ZLVZTnNJPgvK7PBaCpmxyUPSfzRobmLjZZGakbDmEcPx5uzaJLIoJGsRBu
         8/kW5H4S2W2Y43PUrP62acbUygyUfUxJ/7LXxuLP4AK8XzTMYef5j7dyND6OsLEtKNja
         EWV8TqCciGS0RYC6Au/XjFSNhpuihWOQNuW1jSL7dvdwyfAuyCEBbRI/psnVLKE2pWe8
         KpaQb2ss3uYMTRWfZWfDOhXXCUtpm8snGo210JOjfwekGnHKArNaoa1m/hQGRFN19sNb
         Rg8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=igN5IoKzzGuypW/WHng8Q0d0kyUmZgcX+TCusVRQQ20=;
        b=MpNVsvwPj/uGXeg5I/zP+YSndwDzD+3DAvSRtlIougUdUfX2dSasGFohTUGyvjDLvx
         9DTBoMuaT20uuK5k5xauckqRs3R6tCzAw4Dg2tig7sS8jkv48sMiJf7zXWM4EM83Jhod
         e2io8D1v8bd/S6VeO94PIt94WTuZN5GkJwGyohVWuz6Y57EhRNZ6Oa+Gm7Wh154MZM3m
         ZPVWi525Fzo5d+pLJRiN0Y5uh5YNaVV5ULXtovtvsSL2qInTGWl/J1ZHMIXfZoEJcJiZ
         3JIr/HeMYMuLH8mQCaqEZVLcTn7Z+vnwGmJ59hTmgFspTHOomu9PocPdgoZ2RQxPp2O9
         USEw==
X-Gm-Message-State: AJcUukeFnjngoQzZ9PcZbDkDl/tF++ZErA+h8DszChEUIYWayUzmjmsb
        yN/t/+FL8Yy1X67Lp6m8vtCA0Q==
X-Google-Smtp-Source: ALg8bN7ip8V2DdRq2xPNVQi9ExZh3zHGlhWg/sL9jclMofTdkXoWeexjS67LXkNy4gbX0cZ7p2t0lw==
X-Received: by 2002:a1c:22c5:: with SMTP id i188mr29626344wmi.39.1548941990344;
        Thu, 31 Jan 2019 05:39:50 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id h10sm5479768wmf.44.2019.01.31.05.39.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 05:39:49 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 07/35] ARM: davinci: aintc: use irq domain
Date:   Thu, 31 Jan 2019 14:39:00 +0100
Message-Id: <20190131133928.17985-8-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190131133928.17985-1-brgl@bgdev.pl>
References: <20190131133928.17985-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We need to create an irq domain if we want to select SPARSE_IRQ. The
cp-intc driver already supports it, but aintc doesn't. Use the helpers
provided by the generic irq chip abstraction.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/irq.c | 38 ++++++++++++++++++++++++++-----------
 1 file changed, 27 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-davinci/irq.c b/arch/arm/mach-davinci/irq.c
index e539bc65d4ef..c874ea269411 100644
--- a/arch/arm/mach-davinci/irq.c
+++ b/arch/arm/mach-davinci/irq.c
@@ -23,6 +23,7 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/io.h>
+#include <linux/irqdomain.h>
 
 #include <mach/hardware.h>
 #include <mach/cputype.h>
@@ -43,6 +44,7 @@
 #define IRQ_INTPRI7_REG_OFFSET	0x004C
 
 static void __iomem *davinci_intc_base;
+static struct irq_domain *davinci_irq_domain;
 
 static inline void davinci_irq_writel(unsigned long value, int offset)
 {
@@ -55,17 +57,15 @@ static inline unsigned long davinci_irq_readl(int offset)
 }
 
 static __init void
-davinci_alloc_gc(void __iomem *base, unsigned int irq_start, unsigned int num)
+davinci_irq_setup_gc(void __iomem *base,
+		     unsigned int irq_start, unsigned int num)
 {
 	struct irq_chip_generic *gc;
 	struct irq_chip_type *ct;
 
-	gc = irq_alloc_generic_chip("AINTC", 1, irq_start, base, handle_edge_irq);
-	if (!gc) {
-		pr_err("%s: irq_alloc_generic_chip for IRQ %u failed\n",
-		       __func__, irq_start);
-		return;
-	}
+	gc = irq_get_domain_generic_chip(davinci_irq_domain, irq_start);
+	gc->reg_base = base;
+	gc->irq_base = irq_start;
 
 	ct = gc->chip_types;
 	ct->chip.irq_ack = irq_gc_ack_set_bit;
@@ -82,13 +82,11 @@ static asmlinkage void __exception_irq_entry
 davinci_handle_irq(struct pt_regs *regs)
 {
 	int irqnr = davinci_irq_readl(IRQ_IRQENTRY_OFFSET);
-	struct pt_regs *old_regs = set_irq_regs(regs);
 
 	irqnr >>= 2;
 	irqnr -= 1;
 
-	generic_handle_irq(irqnr);
-	set_irq_regs(old_regs);
+	handle_domain_irq(davinci_irq_domain, irqnr, regs);
 }
 
 /* ARM Interrupt Controller Initialization */
@@ -96,6 +94,7 @@ void __init davinci_irq_init(void)
 {
 	unsigned i, j;
 	const u8 *davinci_def_priorities = davinci_soc_info.intc_irq_prios;
+	int rv, irq_base;
 
 	davinci_intc_base = ioremap(davinci_soc_info.intc_base, SZ_4K);
 	if (WARN_ON(!davinci_intc_base))
@@ -131,8 +130,25 @@ void __init davinci_irq_init(void)
 		davinci_irq_writel(pri, i);
 	}
 
+	irq_base = irq_alloc_descs(-1, 0, davinci_soc_info.intc_irq_num, 0);
+	if (WARN_ON(irq_base < 0))
+		return;
+
+	davinci_irq_domain = irq_domain_add_legacy(NULL,
+					davinci_soc_info.intc_irq_num,
+					irq_base, 0, &irq_domain_simple_ops,
+					NULL);
+	if (WARN_ON(!davinci_irq_domain))
+		return;
+
+	rv = irq_alloc_domain_generic_chips(davinci_irq_domain, 32, 1,
+					    "AINTC", handle_edge_irq,
+					    IRQ_NOREQUEST | IRQ_NOPROBE, 0, 0);
+	if (WARN_ON(rv))
+		return;
+
 	for (i = 0, j = 0; i < davinci_soc_info.intc_irq_num; i += 32, j += 0x04)
-		davinci_alloc_gc(davinci_intc_base + j, i, 32);
+		davinci_irq_setup_gc(davinci_intc_base + j, irq_base + i, 32);
 
 	irq_set_handler(IRQ_TINT1_TINT34, handle_level_irq);
 	set_handle_irq(davinci_handle_irq);
-- 
2.20.1


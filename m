Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B269C282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C6AA20855
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:42:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="A0NtL2vS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729326AbfBLKmU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 05:42:20 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54515 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728904AbfBLKjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 05:39:02 -0500
Received: by mail-wm1-f67.google.com with SMTP id a62so2354613wmh.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 02:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M5s8LgF6tZAAsjgatoDHdRTjLQOzD7FAKkqTEC3Dngk=;
        b=A0NtL2vS5wtohyKbNTSOMNy0sgifAWQgV2Dg9ssQVSuLZf4wiugryhNOOvCwTHMjKp
         RVg1iD60li032kHoDtpd+XqBoqFyF48E3Yk1yWXzMqoo5PeWkmJeUsSWlGqR0hDCiTBq
         td8TMk0IYv1LOLq9UxZk4CC3slOhCqaiPiEMTtyfrocNUtAwoCVjdUImSXgEFVlsXY3/
         EGR+Uw6qh0IbFL9slIajbjzRtAOLLWvb1S2XcjCyBn9RK/6jVgeNnPwl+KC9/PVIVKKC
         Bz5cO+pLXW5fGcbGXmKkbBOt/s0qY7WM/a6elcGqpn2T6Rr1tbl845o+byXKbjcN6LY4
         Q9DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M5s8LgF6tZAAsjgatoDHdRTjLQOzD7FAKkqTEC3Dngk=;
        b=Tf90uzoX+yGbwpbTypVgu3k9ubgqF2AqvRMWZ4yvFai8w1xIgbGTdx0XbCXj9MotQe
         CrEEt2GiOBisTAf7P4VFMsu1u+sdJZRctDM3Tl+qv3Xyq3uMRY8oIvgKrAo9YZ/6C8cq
         Fi6ZUOqW/q8THlbl6agUTbJFnAJ6rFoeAQJYWOCofEFBSsg3tX7N3tlrHMpskHxS2Lj+
         0SD6pV2r38iQYIeDPsg87P25YAe10GeHUC69R3j0D3RoBdXizvMvDdP+N10G75wnT5BY
         wZqYJftJkuluWg15PMxM+h8FXdasvCK5pOXXnNHQnpiLIVmuiD2+eMBb5tIiwm0MEiwJ
         ZYIg==
X-Gm-Message-State: AHQUAuYXnesR4eUgdQNuw1jTWFTosRQlH/4SQfMX3AWHvLn4VJc/IVlf
        sK+SpTcqxcYWeiotQaVSnaAXfA==
X-Google-Smtp-Source: AHgI3IaqpkIONZ4SiszEyFIPK842IU+lcHNmOKaKwQVxiDPicCAxDjtQcDo99nPQ0fBDUI66agVtNg==
X-Received: by 2002:a7b:c302:: with SMTP id k2mr2327411wmj.71.1549967939690;
        Tue, 12 Feb 2019 02:38:59 -0800 (PST)
Received: from localhost.localdomain (aputeaux-684-1-38-32.w90-86.abo.wanadoo.fr. [90.86.93.32])
        by smtp.gmail.com with ESMTPSA id c14sm3708656wrn.12.2019.02.12.02.38.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 02:38:59 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 03/37] ARM: davinci: aintc: use irq domain
Date:   Tue, 12 Feb 2019 11:38:01 +0100
Message-Id: <20190212103835.7768-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212103835.7768-1-brgl@bgdev.pl>
References: <20190212103835.7768-1-brgl@bgdev.pl>
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
 arch/arm/mach-davinci/irq.c | 35 +++++++++++++++++++++++++++--------
 1 file changed, 27 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-davinci/irq.c b/arch/arm/mach-davinci/irq.c
index 952dc126c390..efba6dbdfd62 100644
--- a/arch/arm/mach-davinci/irq.c
+++ b/arch/arm/mach-davinci/irq.c
@@ -23,6 +23,7 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/io.h>
+#include <linux/irqdomain.h>
 
 #include <mach/hardware.h>
 #include <mach/cputype.h>
@@ -40,23 +41,23 @@
 #define IRQ_INTPRI0_REG_OFFSET	0x0030
 #define IRQ_INTPRI7_REG_OFFSET	0x004C
 
+static struct irq_domain *davinci_irq_domain;
+
 static inline void davinci_irq_writel(unsigned long value, int offset)
 {
 	__raw_writel(value, davinci_intc_base + offset);
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
@@ -74,6 +75,7 @@ void __init davinci_irq_init(void)
 {
 	unsigned i, j;
 	const u8 *davinci_def_priorities = davinci_soc_info.intc_irq_prios;
+	int ret, irq_base;
 
 	davinci_intc_type = DAVINCI_INTC_TYPE_AINTC;
 	davinci_intc_base = ioremap(davinci_soc_info.intc_base, SZ_4K);
@@ -110,8 +112,25 @@ void __init davinci_irq_init(void)
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
+	ret = irq_alloc_domain_generic_chips(davinci_irq_domain, 32, 1,
+					    "AINTC", handle_edge_irq,
+					    IRQ_NOREQUEST | IRQ_NOPROBE, 0, 0);
+	if (WARN_ON(ret))
+		return;
+
 	for (i = 0, j = 0; i < davinci_soc_info.intc_irq_num; i += 32, j += 0x04)
-		davinci_alloc_gc(davinci_intc_base + j, i, 32);
+		davinci_irq_setup_gc(davinci_intc_base + j, irq_base + i, 32);
 
 	irq_set_handler(IRQ_TINT1_TINT34, handle_level_irq);
 }
-- 
2.20.1


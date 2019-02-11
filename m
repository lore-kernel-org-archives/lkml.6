Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36FEEC282D7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 065AC20818
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="UJh8c6BY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbfBKM3X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 07:29:23 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33997 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727477AbfBKM0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 07:26:18 -0500
Received: by mail-wm1-f66.google.com with SMTP id y185so14458576wmd.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 04:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=trIQtIIzr10xL3xuZKgdBn1lKngoT5UlbTmlmF/bYWM=;
        b=UJh8c6BY0dh+zg3fyjX4z4AG+BCBRlHEMcGLyWpNNcFjVZ5v7bcHosXog7VsBecq/M
         s52bUQt06drTUYg+WR87ABYf1okWHv+Lape0Jl6CkapMpHEN87UD7qOhRCdexvF42VQS
         gO1K9Xs+K8HKb/pEYJNr1RNGTVnYcaqEmEN+B7+WKGRCCO31A6bGv2nZ+ack+USirZUH
         3tPXto+/hjdrm60xckVHxalRyhY+aIT2QW1HGqZ3J4K8SBthQvWpFFMgGKss+Z02Ft94
         funQsg5cFRhokPQkk0JL5ZZk/2wYh6xS5KYhDfjBK2VjSPmjy2duGGQ8ipgwSyHhGNt7
         Z87Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=trIQtIIzr10xL3xuZKgdBn1lKngoT5UlbTmlmF/bYWM=;
        b=dYSX1Z7QAvEE4KSeK+6n+vw+XayotqQbOtFQvidf6/jZrif8eFzDMA4brjFTxDTB3t
         EriIqtD+mMpYWqehWl5rBCXfzqLsIw4xW2p4Mt5YAWnsEKQDG3KTqcNbu4ZUsg2ii6mW
         zKblYGzJmLRo6vAiaUq9Pf/4fOuqc9B9dGZdxtDbXC1dXamnCYLTDW+Vh3an6kedzDTl
         X6QgvDDz3X6NxhcfeLHwOktgQcPfu1smDZaiyHAKkT1vCvGiD/qGYOfWIETgYjQvHvkX
         4spcu0TzsP3ow397TQ/lveUrmaiXWaOMa8A0u56FFomPS3YVOl2JfdH5G1HfTK9Vdf/H
         9BqA==
X-Gm-Message-State: AHQUAubfJPxy5+xBAXdgmbpmfOvHWV8XlTak4LXNWyYFQXLt6mEhPbSf
        uEBWStUjwC4ZqCJ6zp5kronqqQ==
X-Google-Smtp-Source: AHgI3IbEmzia0q3JCYR/8CsRl3bCJRBvTRU1gFNY5fIKTIZ24u43YUZmP+qXuiKuLuStNObZ4N9vxQ==
X-Received: by 2002:a1c:f70e:: with SMTP id v14mr8888458wmh.30.1549887976219;
        Mon, 11 Feb 2019 04:26:16 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id l20sm19494321wrb.93.2019.02.11.04.26.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 04:26:15 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [RESEND PATCH v2 02/33] ARM: davinci: aintc: use irq domain
Date:   Mon, 11 Feb 2019 13:25:35 +0100
Message-Id: <20190211122606.8662-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211122606.8662-1-brgl@bgdev.pl>
References: <20190211122606.8662-1-brgl@bgdev.pl>
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
index 952dc126c390..07d8ef8037e4 100644
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
+	int rv, irq_base;
 
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
 }
-- 
2.20.1


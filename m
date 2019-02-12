Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A756C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C302A20818
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:42:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="0MWNuPrR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729308AbfBLKmK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 05:42:10 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33598 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728845AbfBLKjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 05:39:02 -0500
Received: by mail-wm1-f65.google.com with SMTP id h22so1021063wmb.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 02:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=df3qkP+s4pHmsjjfLwGVeTFPUiObf49NFatD9Li9HD8=;
        b=0MWNuPrR5Twcb+oGFGUnoVyoi9rsTS8BV1P+8pd74G6TmMhM9c1qcTylVY/5DFEvwz
         CgEhJLME41qAB7ilHxx/z/kjPYA7e50tDGOBDIiLNhyRbgyI+qOflOA++gV33/Fmu7RZ
         usEltXZx9JF7DaWNvhHoCfnjOcZQ3eBFTjGUSu3EiflptWDQiIbJSNvyxffOn393dx8S
         qIe/6Vv3enpoh8zpMa1dZ0BZg1h+5V5QBS+n6cdQe8bKcwV1ljilvgGqvy1BheQhwrNz
         ePb0+iGE2V92f1KtbrvB88gGXlA948lIp5/Hh/sl3ALLH6WSFhOEXZn7gRuDVB1XHVyP
         w3lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=df3qkP+s4pHmsjjfLwGVeTFPUiObf49NFatD9Li9HD8=;
        b=B4WlfIBMEfHi1/ODfYZKfjQ2q6ugp9tC09dNa3kLP/FgWNRh/UZ/XQ+s4kklreJlc2
         YSyIjku3cvgGcbzN3Fr7pziDchofzKKjks6wuOgf+H4/4YE6HleLulbwWJsIva3eBmwP
         GQigwsqVlPbmYGC5tdCHLEJpKT81fbjoJZdx2u4KSoViiOxrjqbyBVH6IZGd2tbTJeoG
         TztdyCdExUJfwPotPLRANFVICZaBmOl0HaB1A7FYBYRsdZEdTloBfD0CFbp44+2OabMe
         nLJZ6HjfCTy+5GUY/mp7+tvyAfOtusKZMsdwxVVe0DyeWzeuvd//lXwYm9gLmlxQ3qT2
         EZtg==
X-Gm-Message-State: AHQUAubiGiIT+n64ma5zxzv6XLSQb8ZJkCqkcsJGri3jJmntF6l4wEid
        9ZC3mSIFCnyrafASITaIu7I9hw==
X-Google-Smtp-Source: AHgI3IarAs5SfERkKgF9zohRKbkPt8RsWObK/jJP5V3wWDQDiA3cmW+bZ9o6in0+okVg3dTSf6Bc2A==
X-Received: by 2002:a1c:e1c4:: with SMTP id y187mr2443767wmg.50.1549967940893;
        Tue, 12 Feb 2019 02:39:00 -0800 (PST)
Received: from localhost.localdomain (aputeaux-684-1-38-32.w90-86.abo.wanadoo.fr. [90.86.93.32])
        by smtp.gmail.com with ESMTPSA id c14sm3708656wrn.12.2019.02.12.02.38.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 02:39:00 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 04/37] ARM: davinci: select GENERIC_IRQ_MULTI_HANDLER
Date:   Tue, 12 Feb 2019 11:38:02 +0100
Message-Id: <20190212103835.7768-5-brgl@bgdev.pl>
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

In order to support SPARSE_IRQ we first need to make davinci use the
generic irq handler for ARM. Translate the legacy assembly to C and
put the irq handlers into their respective drivers (aintc and cp-intc).

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/Kconfig                              |  1 +
 arch/arm/mach-davinci/cp_intc.c               | 28 +++++++++++++
 .../mach-davinci/include/mach/entry-macro.S   | 39 -------------------
 arch/arm/mach-davinci/irq.c                   | 23 +++++++++++
 4 files changed, 52 insertions(+), 39 deletions(-)
 delete mode 100644 arch/arm/mach-davinci/include/mach/entry-macro.S

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 664e918e2624..f7770fdcad68 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -589,6 +589,7 @@ config ARCH_DAVINCI
 	select GENERIC_ALLOCATOR
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_IRQ_CHIP
+	select GENERIC_IRQ_MULTI_HANDLER
 	select GPIOLIB
 	select HAVE_IDE
 	select PM_GENERIC_DOMAINS if PM
diff --git a/arch/arm/mach-davinci/cp_intc.c b/arch/arm/mach-davinci/cp_intc.c
index 67805ca74ff8..4a372add8cf9 100644
--- a/arch/arm/mach-davinci/cp_intc.c
+++ b/arch/arm/mach-davinci/cp_intc.c
@@ -19,9 +19,13 @@
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 
+#include <asm/exception.h>
 #include <mach/common.h>
 #include "cp_intc.h"
 
+#define DAVINCI_CP_INTC_PRI_INDX_MASK		GENMASK(9, 0)
+#define DAVINCI_CP_INTC_GPIR_NONE		BIT(31)
+
 static inline unsigned int cp_intc_read(unsigned offset)
 {
 	return __raw_readl(davinci_intc_base + offset);
@@ -97,6 +101,28 @@ static struct irq_chip cp_intc_irq_chip = {
 
 static struct irq_domain *cp_intc_domain;
 
+static asmlinkage void __exception_irq_entry
+cp_intc_handle_irq(struct pt_regs *regs)
+{
+	int gpir, irqnr, none;
+
+	/*
+	 * The interrupt number is in first ten bits. The NONE field set to 1
+	 * indicates a spurious irq.
+	 */
+
+	gpir = cp_intc_read(CP_INTC_PRIO_IDX);
+	irqnr = gpir & DAVINCI_CP_INTC_PRI_INDX_MASK;
+	none = gpir & DAVINCI_CP_INTC_GPIR_NONE;
+
+	if (unlikely(none)) {
+		pr_err_once("%s: spurious irq!\n", __func__);
+		return;
+	}
+
+	handle_domain_irq(cp_intc_domain, irqnr, regs);
+}
+
 static int cp_intc_host_map(struct irq_domain *h, unsigned int virq,
 			  irq_hw_number_t hw)
 {
@@ -196,6 +222,8 @@ int __init cp_intc_of_init(struct device_node *node, struct device_node *parent)
 		return -EINVAL;
 	}
 
+	set_handle_irq(cp_intc_handle_irq);
+
 	/* Enable global interrupt */
 	cp_intc_write(1, CP_INTC_GLOBAL_ENABLE);
 
diff --git a/arch/arm/mach-davinci/include/mach/entry-macro.S b/arch/arm/mach-davinci/include/mach/entry-macro.S
deleted file mode 100644
index cf5f573eb5fd..000000000000
--- a/arch/arm/mach-davinci/include/mach/entry-macro.S
+++ /dev/null
@@ -1,39 +0,0 @@
-/*
- * Low-level IRQ helper macros for TI DaVinci-based platforms
- *
- * Author: Kevin Hilman, MontaVista Software, Inc. <source@mvista.com>
- *
- * 2007 (c) MontaVista Software, Inc. This file is licensed under
- * the terms of the GNU General Public License version 2. This program
- * is licensed "as is" without any warranty of any kind, whether express
- * or implied.
- */
-#include <mach/irqs.h>
-
-		.macro  get_irqnr_preamble, base, tmp
-		ldr \base, =davinci_intc_base
-		ldr \base, [\base]
-		.endm
-
-		.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
-#if defined(CONFIG_AINTC) && defined(CONFIG_CP_INTC)
-		ldr \tmp, =davinci_intc_type
-		ldr \tmp, [\tmp]
-		cmp \tmp, #DAVINCI_INTC_TYPE_CP_INTC
-		beq 1001f
-#endif
-#if defined(CONFIG_AINTC)
-		ldr \tmp, [\base, #0x14]
-		movs \tmp, \tmp, lsr #2
-		sub \irqnr, \tmp, #1
-		b 1002f
-#endif
-#if defined(CONFIG_CP_INTC)
-1001:		ldr \irqnr, [\base, #0x80] /* get irq number */
-		mov \tmp, \irqnr, lsr #31
-		and \irqnr, \irqnr, #0xff  /* irq is in bits 0-9 */
-		and \tmp, \tmp, #0x1
-		cmp \tmp, #0x1
-#endif
-1002:
-		.endm
diff --git a/arch/arm/mach-davinci/irq.c b/arch/arm/mach-davinci/irq.c
index efba6dbdfd62..363ca6d76cb0 100644
--- a/arch/arm/mach-davinci/irq.c
+++ b/arch/arm/mach-davinci/irq.c
@@ -29,11 +29,13 @@
 #include <mach/cputype.h>
 #include <mach/common.h>
 #include <asm/mach/irq.h>
+#include <asm/exception.h>
 
 #define FIQ_REG0_OFFSET		0x0000
 #define FIQ_REG1_OFFSET		0x0004
 #define IRQ_REG0_OFFSET		0x0008
 #define IRQ_REG1_OFFSET		0x000C
+#define IRQ_IRQENTRY_OFFSET	0x0014
 #define IRQ_ENT_REG0_OFFSET	0x0018
 #define IRQ_ENT_REG1_OFFSET	0x001C
 #define IRQ_INCTL_REG_OFFSET	0x0020
@@ -48,6 +50,11 @@ static inline void davinci_irq_writel(unsigned long value, int offset)
 	__raw_writel(value, davinci_intc_base + offset);
 }
 
+static inline unsigned long davinci_irq_readl(int offset)
+{
+	return readl_relaxed(davinci_intc_base + offset);
+}
+
 static __init void
 davinci_irq_setup_gc(void __iomem *base,
 		     unsigned int irq_start, unsigned int num)
@@ -70,6 +77,21 @@ davinci_irq_setup_gc(void __iomem *base,
 			       IRQ_NOREQUEST | IRQ_NOPROBE, 0);
 }
 
+static asmlinkage void __exception_irq_entry
+davinci_handle_irq(struct pt_regs *regs)
+{
+	int irqnr = davinci_irq_readl(IRQ_IRQENTRY_OFFSET);
+
+	/*
+	 * Use the formula for entry vector index generation from section
+	 * 8.3.3 of the manual.
+	 */
+	irqnr >>= 2;
+	irqnr -= 1;
+
+	handle_domain_irq(davinci_irq_domain, irqnr, regs);
+}
+
 /* ARM Interrupt Controller Initialization */
 void __init davinci_irq_init(void)
 {
@@ -133,4 +155,5 @@ void __init davinci_irq_init(void)
 		davinci_irq_setup_gc(davinci_intc_base + j, irq_base + i, 32);
 
 	irq_set_handler(IRQ_TINT1_TINT34, handle_level_irq);
+	set_handle_irq(davinci_handle_irq);
 }
-- 
2.20.1


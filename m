Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF8FC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 17:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6475824652
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 17:03:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Mk28X74Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6475824652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754729AbeFVRDx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 13:03:53 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:43447 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754462AbeFVRB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 13:01:59 -0400
Received: by mail-pf0-f194.google.com with SMTP id y8-v6so3491032pfm.10
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 10:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=subject:date:message-id:in-reply-to:references:cc:from:to;
        bh=ry/LfwLi/tYV4OOfEp0qv4lu5uRtthBo0ccjreY/0zs=;
        b=Mk28X74QdQzUf+QCR/5QizeytRH/g6oZ1sUJ9gGFnI+dUxuZXz2RUYL8B6NXcjdZJo
         EZExZZi47h8Z2KlouCS1AY6O1Wp9Nkr+owB4THW2DUBiBgPbFRG5uc1ZPNyO/JTStQZZ
         LL/zpLdqveKytGO4hoJEvdpBZBVG2lktKiqO7Z403S/8Kk+uPFhgnNLXgiM6VuiKJ81Z
         qbPujp1+srpGGRMh0hV1wl4QnTNoGrTCd9vUjs4MXZ6i2OTDIZv6LwuXf9kCKbTcytm9
         wf4/ipBMKut8LSDgsBU7qaYQn160IrzD9zJZctO8Oo4jX3OeBkXtIna6QSbX0uoMvxYQ
         41TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :cc:from:to;
        bh=ry/LfwLi/tYV4OOfEp0qv4lu5uRtthBo0ccjreY/0zs=;
        b=bG2yLWPqYFfDvZUYlPhF5YDAOfR56DQ4L5hZoi3hKWGm7Tbu4f0RodBqsYfun6A9zd
         m3PZ1GYr0Pe7vUhCPdpvBIUhHgc5zq7x8UH1QhnpxDstJIHJhUmBf851ngJeMdJ5Selk
         ZRl0kcIv+ZtGzBN+Tr2zLZYBfoFw44MTXnolFr+VxXwWfOK06REez7xzIDJIv8yv6z/R
         cP6CZDpCF0mt9wHiX3mx/n4mq2VnUXq8RmBAwFbcRdkKGVpk8nu8+T4zP3g35vfmTWSz
         t57n/G9q8Ma8yFIuCc4rRcVWyYG8qx5aDvU2bFyD1AUYBALZkVeLrxn7cYunD4Iir+zI
         RSGg==
X-Gm-Message-State: APt69E2FWtYV294KDvJM/0NiWV5jR8DkSZwetTb8Nek9zx1kmvEvU04I
        RKpZiq28xZMmoruTePwICV2JyQ==
X-Google-Smtp-Source: ADUXVKLkYRjtSH1KWICvH/V2Hl+5Kb1bIfrX01UObi+PJHcdFtf7X+aP+AFkbONN/L7N1SKpf9jfvg==
X-Received: by 2002:a63:b407:: with SMTP id s7-v6mr2198856pgf.334.1529686918909;
        Fri, 22 Jun 2018 10:01:58 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id 10-v6sm19144223pfs.111.2018.06.22.10.01.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jun 2018 10:01:58 -0700 (PDT)
Subject: [PATCH 2/5] arm: Convert to GENERIC_IRQ_MULTI_HANDLER
Date:   Fri, 22 Jun 2018 10:01:23 -0700
Message-Id: <20180622170126.6308-3-palmer@sifive.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180622170126.6308-1-palmer@sifive.com>
References: <20180621181756.12493-1-palmer@sifive.com>
 <20180622170126.6308-1-palmer@sifive.com>
Cc:     linux@armlinux.org.uk, catalin.marinas@arm.com,
        Will Deacon <will.deacon@arm.com>, jonas@southpole.se,
        stefan.kristiansson@saunalahti.fi, shorne@gmail.com,
        jason@lakedaemon.net, marc.zyngier@arm.com,
        Arnd Bergmann <arnd@arndb.de>, nicolas.pitre@linaro.org,
        vladimir.murzin@arm.com, keescook@chromium.org,
        jinb.park7@gmail.com, yamada.masahiro@socionext.com,
        alexandre.belloni@bootlin.com, Palmer Dabbelt <palmer@sifive.com>,
        pombredanne@nexb.com, Greg KH <gregkh@linuxfoundation.org>,
        kstewart@linuxfoundation.org, jhogan@kernel.org,
        mark.rutland@arm.com, ard.biesheuvel@linaro.org,
        james.morse@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, openrisc@lists.librecores.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     tglx@linutronix.de
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This converts the ARM port to use the recently added
GENERIC_IRQ_MULTI_HANDLER, which is essentially just a copy of ARM's
existhing MULTI_IRQ_HANDLER.  The only changes are:

* handle_arch_irq is now defined in a generic C file instead of an
  arm-specific assembly file.
* handle_arch_irq is now marked as __ro_after_init.

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 arch/arm/Kconfig                 | 19 +++++++------------
 arch/arm/include/asm/irq.h       |  5 -----
 arch/arm/include/asm/mach/arch.h |  2 +-
 arch/arm/kernel/entry-armv.S     | 10 ++--------
 arch/arm/kernel/irq.c            | 10 ----------
 arch/arm/kernel/setup.c          |  2 +-
 6 files changed, 11 insertions(+), 37 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 54eeb8d00bc6..b6be2b1be75d 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -337,8 +337,8 @@ config ARCH_MULTIPLATFORM
 	select TIMER_OF
 	select COMMON_CLK
 	select GENERIC_CLOCKEVENTS
+	select GENERIC_IRQ_MULTI_HANDLER
 	select MIGHT_HAVE_PCI
-	select MULTI_IRQ_HANDLER
 	select PCI_DOMAINS if PCI
 	select SPARSE_IRQ
 	select USE_OF
@@ -465,9 +465,9 @@ config ARCH_DOVE
 	bool "Marvell Dove"
 	select CPU_PJ4
 	select GENERIC_CLOCKEVENTS
+	select GENERIC_IRQ_MULTI_HANDLER
 	select GPIOLIB
 	select MIGHT_HAVE_PCI
-	select MULTI_IRQ_HANDLER
 	select MVEBU_MBUS
 	select PINCTRL
 	select PINCTRL_DOVE
@@ -512,8 +512,8 @@ config ARCH_LPC32XX
 	select COMMON_CLK
 	select CPU_ARM926T
 	select GENERIC_CLOCKEVENTS
+	select GENERIC_IRQ_MULTI_HANDLER
 	select GPIOLIB
-	select MULTI_IRQ_HANDLER
 	select SPARSE_IRQ
 	select USE_OF
 	help
@@ -532,11 +532,11 @@ config ARCH_PXA
 	select TIMER_OF
 	select CPU_XSCALE if !CPU_XSC3
 	select GENERIC_CLOCKEVENTS
+	select GENERIC_IRQ_MULTI_HANDLER
 	select GPIO_PXA
 	select GPIOLIB
 	select HAVE_IDE
 	select IRQ_DOMAIN
-	select MULTI_IRQ_HANDLER
 	select PLAT_PXA
 	select SPARSE_IRQ
 	help
@@ -572,11 +572,11 @@ config ARCH_SA1100
 	select CPU_FREQ
 	select CPU_SA1100
 	select GENERIC_CLOCKEVENTS
+	select GENERIC_IRQ_MULTI_HANDLER
 	select GPIOLIB
 	select HAVE_IDE
 	select IRQ_DOMAIN
 	select ISA
-	select MULTI_IRQ_HANDLER
 	select NEED_MACH_MEMORY_H
 	select SPARSE_IRQ
 	help
@@ -590,10 +590,10 @@ config ARCH_S3C24XX
 	select GENERIC_CLOCKEVENTS
 	select GPIO_SAMSUNG
 	select GPIOLIB
+	select GENERIC_IRQ_MULTI_HANDLER
 	select HAVE_S3C2410_I2C if I2C
 	select HAVE_S3C2410_WATCHDOG if WATCHDOG
 	select HAVE_S3C_RTC if RTC_CLASS
-	select MULTI_IRQ_HANDLER
 	select NEED_MACH_IO_H
 	select SAMSUNG_ATAGS
 	select USE_OF
@@ -627,10 +627,10 @@ config ARCH_OMAP1
 	select CLKSRC_MMIO
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_IRQ_CHIP
+	select GENERIC_IRQ_MULTI_HANDLER
 	select GPIOLIB
 	select HAVE_IDE
 	select IRQ_DOMAIN
-	select MULTI_IRQ_HANDLER
 	select NEED_MACH_IO_H if PCCARD
 	select NEED_MACH_MEMORY_H
 	select SPARSE_IRQ
@@ -921,11 +921,6 @@ config IWMMXT
 	  Enable support for iWMMXt context switching at run time if
 	  running on a CPU that supports it.
 
-config MULTI_IRQ_HANDLER
-	bool
-	help
-	  Allow each machine to specify it's own IRQ handler at run time.
-
 if !MMU
 source "arch/arm/Kconfig-nommu"
 endif
diff --git a/arch/arm/include/asm/irq.h b/arch/arm/include/asm/irq.h
index b6f319606e30..c883fcbe93b6 100644
--- a/arch/arm/include/asm/irq.h
+++ b/arch/arm/include/asm/irq.h
@@ -31,11 +31,6 @@ extern void asm_do_IRQ(unsigned int, struct pt_regs *);
 void handle_IRQ(unsigned int, struct pt_regs *);
 void init_IRQ(void);
 
-#ifdef CONFIG_MULTI_IRQ_HANDLER
-extern void (*handle_arch_irq)(struct pt_regs *);
-extern void set_handle_irq(void (*handle_irq)(struct pt_regs *));
-#endif
-
 #ifdef CONFIG_SMP
 extern void arch_trigger_cpumask_backtrace(const cpumask_t *mask,
 					   bool exclude_self);
diff --git a/arch/arm/include/asm/mach/arch.h b/arch/arm/include/asm/mach/arch.h
index 5c1ad11aa392..bb8851208e17 100644
--- a/arch/arm/include/asm/mach/arch.h
+++ b/arch/arm/include/asm/mach/arch.h
@@ -59,7 +59,7 @@ struct machine_desc {
 	void			(*init_time)(void);
 	void			(*init_machine)(void);
 	void			(*init_late)(void);
-#ifdef CONFIG_MULTI_IRQ_HANDLER
+#ifdef CONFIG_GENERIC_IRQ_MULTI_HANDLER
 	void			(*handle_irq)(struct pt_regs *);
 #endif
 	void			(*restart)(enum reboot_mode, const char *);
diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index 179a9f6bd1e3..e85a3af9ddeb 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -22,7 +22,7 @@
 #include <asm/glue-df.h>
 #include <asm/glue-pf.h>
 #include <asm/vfpmacros.h>
-#ifndef CONFIG_MULTI_IRQ_HANDLER
+#ifndef CONFIG_GENERIC_IRQ_MULTI_HANDLER
 #include <mach/entry-macro.S>
 #endif
 #include <asm/thread_notify.h>
@@ -39,7 +39,7 @@
  * Interrupt handling.
  */
 	.macro	irq_handler
-#ifdef CONFIG_MULTI_IRQ_HANDLER
+#ifdef CONFIG_GENERIC_IRQ_MULTI_HANDLER
 	ldr	r1, =handle_arch_irq
 	mov	r0, sp
 	badr	lr, 9997f
@@ -1226,9 +1226,3 @@ vector_addrexcptn:
 	.globl	cr_alignment
 cr_alignment:
 	.space	4
-
-#ifdef CONFIG_MULTI_IRQ_HANDLER
-	.globl	handle_arch_irq
-handle_arch_irq:
-	.space	4
-#endif
diff --git a/arch/arm/kernel/irq.c b/arch/arm/kernel/irq.c
index ece04a457486..9908dacf9229 100644
--- a/arch/arm/kernel/irq.c
+++ b/arch/arm/kernel/irq.c
@@ -102,16 +102,6 @@ void __init init_IRQ(void)
 	uniphier_cache_init();
 }
 
-#ifdef CONFIG_MULTI_IRQ_HANDLER
-void __init set_handle_irq(void (*handle_irq)(struct pt_regs *))
-{
-	if (handle_arch_irq)
-		return;
-
-	handle_arch_irq = handle_irq;
-}
-#endif
-
 #ifdef CONFIG_SPARSE_IRQ
 int __init arch_probe_nr_irqs(void)
 {
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 35ca494c028c..4c249cb261f3 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -1145,7 +1145,7 @@ void __init setup_arch(char **cmdline_p)
 
 	reserve_crashkernel();
 
-#ifdef CONFIG_MULTI_IRQ_HANDLER
+#ifdef CONFIG_GENERIC_IRQ_MULTI_HANDLER
 	handle_arch_irq = mdesc->handle_irq;
 #endif
 
-- 
2.16.4


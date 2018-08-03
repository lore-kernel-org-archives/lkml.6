Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D8EFC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 10:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF9AD2173F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 10:19:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF9AD2173F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732578AbeHCMP1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 08:15:27 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57601 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728122AbeHCMP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 08:15:26 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w73AJXu03848661
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 3 Aug 2018 03:19:33 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w73AJX2Q3848658;
        Fri, 3 Aug 2018 03:19:33 -0700
Date:   Fri, 3 Aug 2018 03:19:33 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Palmer Dabbelt <tipbot@zytor.com>
Message-ID: <tip-4c301f9b6a94bb383089bc847083e287e9bfc96e@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        arnd@arndb.de, mingo@kernel.org, hpa@zytor.com,
        will.deacon@arm.com, tglx@linutronix.de, palmer@sifive.com
Reply-To: tglx@linutronix.de, palmer@sifive.com, will.deacon@arm.com,
          hpa@zytor.com, mingo@kernel.org, arnd@arndb.de,
          gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
In-Reply-To: <20180622170126.6308-3-palmer@sifive.com>
References: <20180622170126.6308-3-palmer@sifive.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:irq/core] ARM: Convert to GENERIC_IRQ_MULTI_HANDLER
Git-Commit-ID: 4c301f9b6a94bb383089bc847083e287e9bfc96e
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  4c301f9b6a94bb383089bc847083e287e9bfc96e
Gitweb:     https://git.kernel.org/tip/4c301f9b6a94bb383089bc847083e287e9bfc96e
Author:     Palmer Dabbelt <palmer@sifive.com>
AuthorDate: Fri, 22 Jun 2018 10:01:23 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 3 Aug 2018 12:14:08 +0200

ARM: Convert to GENERIC_IRQ_MULTI_HANDLER

Converts the ARM interrupt code to use the recently added
GENERIC_IRQ_MULTI_HANDLER, which is essentially just a copy of ARM's
existhing MULTI_IRQ_HANDLER.  The only changes are:

* handle_arch_irq is now defined in a generic C file instead of an
  arm-specific assembly file.
 
* handle_arch_irq is now marked as __ro_after_init.

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: linux@armlinux.org.uk
Cc: catalin.marinas@arm.com
Cc: Will Deacon <will.deacon@arm.com>
Cc: jonas@southpole.se
Cc: stefan.kristiansson@saunalahti.fi
Cc: shorne@gmail.com
Cc: jason@lakedaemon.net
Cc: marc.zyngier@arm.com
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: nicolas.pitre@linaro.org
Cc: vladimir.murzin@arm.com
Cc: keescook@chromium.org
Cc: jinb.park7@gmail.com
Cc: yamada.masahiro@socionext.com
Cc: alexandre.belloni@bootlin.com
Cc: pombredanne@nexb.com
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: kstewart@linuxfoundation.org
Cc: jhogan@kernel.org
Cc: mark.rutland@arm.com
Cc: ard.biesheuvel@linaro.org
Cc: james.morse@arm.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: openrisc@lists.librecores.org
Link: https://lkml.kernel.org/r/20180622170126.6308-3-palmer@sifive.com

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
 

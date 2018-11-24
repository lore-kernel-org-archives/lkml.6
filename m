Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF71C43610
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 03:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B34C20824
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 03:11:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B34C20824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730373AbeKXN5z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 08:57:55 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:56624 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730155AbeKXN5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 08:57:54 -0500
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id 4E84728F6B; Fri, 23 Nov 2018 22:11:08 -0500 (EST)
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Philip Blundell <philb@gnu.org>,
        Joshua Thompson <funaho@jurai.org>
Cc:     Andreas Schwab <schwab@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Stephen N Chivers <schivers@csc.com.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kars de Jong <jongk@linux-m68k.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Message-Id: <49af3aa11c9020f3dc084597bca6508a4aca84c2.1543028943.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1543028943.git.fthain@telegraphics.com.au>
References: <cover.1543028943.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [RFC PATCH v3 04/14] m68k: Drop ARCH_USES_GETTIMEOFFSET
Date:   Sat, 24 Nov 2018 14:09:03 +1100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The functions that implement arch_gettimeoffset are re-used by
new clocksource drivers in subsequent patches.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/m68k/Kconfig           | 1 -
 arch/m68k/amiga/config.c    | 3 ---
 arch/m68k/atari/config.c    | 2 --
 arch/m68k/bvme6000/config.c | 2 --
 arch/m68k/hp300/config.c    | 1 -
 arch/m68k/hp300/time.h      | 1 -
 arch/m68k/mac/config.c      | 3 ---
 arch/m68k/mvme147/config.c  | 2 --
 arch/m68k/mvme16x/config.c  | 2 --
 9 files changed, 17 deletions(-)

diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index 070553791e97..cc62660a5760 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -19,7 +19,6 @@ config M68K
 	select GENERIC_STRNCPY_FROM_USER if MMU
 	select GENERIC_STRNLEN_USER if MMU
 	select ARCH_WANT_IPC_PARSE_VERSION
-	select ARCH_USES_GETTIMEOFFSET if MMU && !COLDFIRE
 	select HAVE_FUTEX_CMPXCHG if MMU && FUTEX
 	select HAVE_MOD_ARCH_SPECIFIC
 	select MODULES_USE_ELF_REL
diff --git a/arch/m68k/amiga/config.c b/arch/m68k/amiga/config.c
index 65f63a457130..d4976c1aa0cc 100644
--- a/arch/m68k/amiga/config.c
+++ b/arch/m68k/amiga/config.c
@@ -95,8 +95,6 @@ static char amiga_model_name[13] = "Amiga ";
 static void amiga_sched_init(irq_handler_t handler);
 static void amiga_get_model(char *model);
 static void amiga_get_hardware_list(struct seq_file *m);
-/* amiga specific timer functions */
-static u32 amiga_gettimeoffset(void);
 extern void amiga_mksound(unsigned int count, unsigned int ticks);
 static void amiga_reset(void);
 extern void amiga_init_sound(void);
@@ -386,7 +384,6 @@ void __init config_amiga(void)
 	mach_init_IRQ        = amiga_init_IRQ;
 	mach_get_model       = amiga_get_model;
 	mach_get_hardware_list = amiga_get_hardware_list;
-	arch_gettimeoffset   = amiga_gettimeoffset;
 
 	/*
 	 * default MAX_DMA=0xffffffff on all machines. If we don't do so, the SCSI
diff --git a/arch/m68k/atari/config.c b/arch/m68k/atari/config.c
index bd96702a1ad0..89e65be2655f 100644
--- a/arch/m68k/atari/config.c
+++ b/arch/m68k/atari/config.c
@@ -78,7 +78,6 @@ static void atari_heartbeat(int on);
 
 /* atari specific timer functions (in time.c) */
 extern void atari_sched_init(irq_handler_t);
-extern u32 atari_gettimeoffset(void);
 extern int atari_mste_hwclk (int, struct rtc_time *);
 extern int atari_tt_hwclk (int, struct rtc_time *);
 
@@ -205,7 +204,6 @@ void __init config_atari(void)
 	mach_init_IRQ        = atari_init_IRQ;
 	mach_get_model	 = atari_get_model;
 	mach_get_hardware_list = atari_get_hardware_list;
-	arch_gettimeoffset   = atari_gettimeoffset;
 	mach_reset           = atari_reset;
 	mach_max_dma_address = 0xffffff;
 #if IS_ENABLED(CONFIG_INPUT_M68K_BEEP)
diff --git a/arch/m68k/bvme6000/config.c b/arch/m68k/bvme6000/config.c
index 0e5efed4da86..c8b99d5516d1 100644
--- a/arch/m68k/bvme6000/config.c
+++ b/arch/m68k/bvme6000/config.c
@@ -39,7 +39,6 @@
 
 static void bvme6000_get_model(char *model);
 extern void bvme6000_sched_init(irq_handler_t handler);
-extern u32 bvme6000_gettimeoffset(void);
 extern int bvme6000_hwclk (int, struct rtc_time *);
 extern void bvme6000_reset (void);
 void bvme6000_set_vectors (void);
@@ -105,7 +104,6 @@ void __init config_bvme6000(void)
     mach_max_dma_address = 0xffffffff;
     mach_sched_init      = bvme6000_sched_init;
     mach_init_IRQ        = bvme6000_init_IRQ;
-    arch_gettimeoffset   = bvme6000_gettimeoffset;
     mach_hwclk           = bvme6000_hwclk;
     mach_reset		 = bvme6000_reset;
     mach_get_model       = bvme6000_get_model;
diff --git a/arch/m68k/hp300/config.c b/arch/m68k/hp300/config.c
index a19bcd23f80b..a161d44fd20b 100644
--- a/arch/m68k/hp300/config.c
+++ b/arch/m68k/hp300/config.c
@@ -254,7 +254,6 @@ void __init config_hp300(void)
 	mach_sched_init      = hp300_sched_init;
 	mach_init_IRQ        = hp300_init_IRQ;
 	mach_get_model       = hp300_get_model;
-	arch_gettimeoffset   = hp300_gettimeoffset;
 	mach_hwclk	     = hp300_hwclk;
 	mach_get_ss	     = hp300_get_ss;
 	mach_reset           = hp300_reset;
diff --git a/arch/m68k/hp300/time.h b/arch/m68k/hp300/time.h
index f5583ec4033d..1d77b55cc72a 100644
--- a/arch/m68k/hp300/time.h
+++ b/arch/m68k/hp300/time.h
@@ -1,2 +1 @@
 extern void hp300_sched_init(irq_handler_t vector);
-extern u32 hp300_gettimeoffset(void);
diff --git a/arch/m68k/mac/config.c b/arch/m68k/mac/config.c
index cd9317d53276..11be08f4f750 100644
--- a/arch/m68k/mac/config.c
+++ b/arch/m68k/mac/config.c
@@ -54,8 +54,6 @@ struct mac_booter_data mac_bi_data;
 /* The phys. video addr. - might be bogus on some machines */
 static unsigned long mac_orig_videoaddr;
 
-/* Mac specific timer functions */
-extern u32 mac_gettimeoffset(void);
 extern int mac_hwclk(int, struct rtc_time *);
 extern void iop_preinit(void);
 extern void iop_init(void);
@@ -155,7 +153,6 @@ void __init config_mac(void)
 	mach_sched_init = mac_sched_init;
 	mach_init_IRQ = mac_init_IRQ;
 	mach_get_model = mac_get_model;
-	arch_gettimeoffset = mac_gettimeoffset;
 	mach_hwclk = mac_hwclk;
 	mach_reset = mac_reset;
 	mach_halt = mac_poweroff;
diff --git a/arch/m68k/mvme147/config.c b/arch/m68k/mvme147/config.c
index 93c68d2b8e0e..4ef4faa5ed8b 100644
--- a/arch/m68k/mvme147/config.c
+++ b/arch/m68k/mvme147/config.c
@@ -38,7 +38,6 @@
 
 static void mvme147_get_model(char *model);
 extern void mvme147_sched_init(irq_handler_t handler);
-extern u32 mvme147_gettimeoffset(void);
 extern int mvme147_hwclk (int, struct rtc_time *);
 extern void mvme147_reset (void);
 
@@ -84,7 +83,6 @@ void __init config_mvme147(void)
 	mach_max_dma_address	= 0x01000000;
 	mach_sched_init		= mvme147_sched_init;
 	mach_init_IRQ		= mvme147_init_IRQ;
-	arch_gettimeoffset	= mvme147_gettimeoffset;
 	mach_hwclk		= mvme147_hwclk;
 	mach_reset		= mvme147_reset;
 	mach_get_model		= mvme147_get_model;
diff --git a/arch/m68k/mvme16x/config.c b/arch/m68k/mvme16x/config.c
index 5feb3ab484d0..3a3129e6f0bc 100644
--- a/arch/m68k/mvme16x/config.c
+++ b/arch/m68k/mvme16x/config.c
@@ -44,7 +44,6 @@ static MK48T08ptr_t volatile rtc = (MK48T08ptr_t)MVME_RTC_BASE;
 
 static void mvme16x_get_model(char *model);
 extern void mvme16x_sched_init(irq_handler_t handler);
-extern u32 mvme16x_gettimeoffset(void);
 extern int mvme16x_hwclk (int, struct rtc_time *);
 extern void mvme16x_reset (void);
 
@@ -272,7 +271,6 @@ void __init config_mvme16x(void)
     mach_max_dma_address = 0xffffffff;
     mach_sched_init      = mvme16x_sched_init;
     mach_init_IRQ        = mvme16x_init_IRQ;
-    arch_gettimeoffset   = mvme16x_gettimeoffset;
     mach_hwclk           = mvme16x_hwclk;
     mach_reset		 = mvme16x_reset;
     mach_get_model       = mvme16x_get_model;
-- 
2.18.1


Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E5BC04EBA
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 04:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CA46214DB
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 04:47:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CA46214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731241AbeKLOiY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 09:38:24 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:48650 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728008AbeKLOiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 09:38:24 -0500
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id D0773297E9; Sun, 11 Nov 2018 23:46:55 -0500 (EST)
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Stephen N Chivers <schivers@csc.com.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Philip Blundell <philb@gnu.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Joshua Thompson <funaho@jurai.org>
Message-Id: <74edaee07800f91eb416ab3e72c4670b8ef4bd4e.1541995959.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1541995959.git.fthain@telegraphics.com.au>
References: <cover.1541995959.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [RFC PATCH 06/13] m68k: Drop ARCH_USES_GETTIMEOFFSET
Date:   Mon, 12 Nov 2018 15:12:39 +1100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The functions that implement arch_gettimeoffset are re-used by
new clocksource drivers in subsequent patches.

Cc: Philip Blundell <philb@gnu.org>
Cc: Michael Schmitz <schmitzmic@gmail.com>
Cc: Joshua Thompson <funaho@jurai.org>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
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
index 5ec3687984a9..a575ad419b23 100644
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
index 0afdef10a5a4..3bd56bd04690 100644
--- a/arch/m68k/bvme6000/config.c
+++ b/arch/m68k/bvme6000/config.c
@@ -39,7 +39,6 @@
 
 static void bvme6000_get_model(char *model);
 extern void bvme6000_sched_init(irq_handler_t handler);
-extern u32 bvme6000_gettimeoffset(void);
 extern int bvme6000_hwclk (int, struct rtc_time *);
 extern void bvme6000_reset (void);
 void bvme6000_set_vectors (void);
@@ -110,7 +109,6 @@ void __init config_bvme6000(void)
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
index 2367c3792dc7..cecaaa100791 100644
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
@@ -150,7 +148,6 @@ void __init config_mac(void)
 	mach_sched_init = via_init_clock;
 	mach_init_IRQ = mac_init_IRQ;
 	mach_get_model = mac_get_model;
-	arch_gettimeoffset = mac_gettimeoffset;
 	mach_hwclk = mac_hwclk;
 	mach_reset = mac_reset;
 	mach_halt = mac_poweroff;
diff --git a/arch/m68k/mvme147/config.c b/arch/m68k/mvme147/config.c
index 8074940b0aa1..ff7141cf27d1 100644
--- a/arch/m68k/mvme147/config.c
+++ b/arch/m68k/mvme147/config.c
@@ -38,7 +38,6 @@
 
 static void mvme147_get_model(char *model);
 extern void mvme147_sched_init(irq_handler_t handler);
-extern u32 mvme147_gettimeoffset(void);
 extern int mvme147_hwclk (int, struct rtc_time *);
 extern void mvme147_reset (void);
 
@@ -89,7 +88,6 @@ void __init config_mvme147(void)
 	mach_max_dma_address	= 0x01000000;
 	mach_sched_init		= mvme147_sched_init;
 	mach_init_IRQ		= mvme147_init_IRQ;
-	arch_gettimeoffset	= mvme147_gettimeoffset;
 	mach_hwclk		= mvme147_hwclk;
 	mach_reset		= mvme147_reset;
 	mach_get_model		= mvme147_get_model;
diff --git a/arch/m68k/mvme16x/config.c b/arch/m68k/mvme16x/config.c
index d4aec717e688..f1ed52331df3 100644
--- a/arch/m68k/mvme16x/config.c
+++ b/arch/m68k/mvme16x/config.c
@@ -44,7 +44,6 @@ static MK48T08ptr_t volatile rtc = (MK48T08ptr_t)MVME_RTC_BASE;
 
 static void mvme16x_get_model(char *model);
 extern void mvme16x_sched_init(irq_handler_t handler);
-extern u32 mvme16x_gettimeoffset(void);
 extern int mvme16x_hwclk (int, struct rtc_time *);
 extern void mvme16x_reset (void);
 
@@ -277,7 +276,6 @@ void __init config_mvme16x(void)
     mach_max_dma_address = 0xffffffff;
     mach_sched_init      = mvme16x_sched_init;
     mach_init_IRQ        = mvme16x_init_IRQ;
-    arch_gettimeoffset   = mvme16x_gettimeoffset;
     mach_hwclk           = mvme16x_hwclk;
     mach_reset		 = mvme16x_reset;
     mach_get_model       = mvme16x_get_model;
-- 
2.18.1


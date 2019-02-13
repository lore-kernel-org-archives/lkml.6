Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0559BC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7759218D3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:41:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qausrpXD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393343AbfBMRlE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 12:41:04 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:40100 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393293AbfBMRkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 12:40:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=1Q0upoC+OmOW6oGoH2xrwnYpYPuezlE8nWllGlyGfP0=; b=qausrpXDA85KADBX2HVf6lZzsy
        u5KfCNBANr3Mv6xwz6VhP1lp4DC7xOXRG3zUZtVO7yLeyFkrRI4bq++uMImsUXuncOUkiOLLzUMBq
        pYYA3e1bjIHZfHyhAVH9I75UsSrcGI6/Ebkd1ABohfM4ZKzUTkOQ8owJ0jjHIZmJTljaR8ck2m85v
        zpBcYV2EFxfxmI5HXBtl9UQt6VWiVp58k2fJAnrMAMHctdWY/w3cJIMJTXDoJcFcKCwhKiUQaJkRF
        ifxpv5ivRgz+F9vSO3K23csGjAnZIzTBbjpnN32cfqFlaUEwqtrsEJ4fmjnMMPLAXAcZLcv5CEmi5
        YGn41cZg==;
Received: from 089144210182.atnat0019.highway.a1.net ([89.144.210.182] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtyWU-0008SZ-Gq; Wed, 13 Feb 2019 17:40:38 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-kbuild@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/11] lib: consolidate the GENERIC_CSUM symbol
Date:   Wed, 13 Feb 2019 18:40:03 +0100
Message-Id: <20190213174005.28785-10-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213174005.28785-1-hch@lst.de>
References: <20190213174005.28785-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add one definition to lib/Kconfig and let the architectures
select if it supported.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arc/Kconfig        | 4 +---
 arch/arm64/Kconfig      | 4 +---
 arch/csky/Kconfig       | 4 +---
 arch/h8300/Kconfig      | 4 +---
 arch/hexagon/Kconfig    | 4 +---
 arch/m68k/Kconfig       | 3 ---
 arch/microblaze/Kconfig | 4 +---
 arch/mips/Kconfig       | 5 +----
 arch/nds32/Kconfig      | 4 +---
 arch/nios2/Kconfig      | 4 +---
 arch/openrisc/Kconfig   | 6 +-----
 arch/powerpc/Kconfig    | 3 ---
 arch/riscv/Kconfig      | 4 +---
 arch/sh/Kconfig         | 5 +----
 arch/unicore32/Kconfig  | 3 ---
 lib/Kconfig             | 3 +++
 16 files changed, 15 insertions(+), 49 deletions(-)

diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index e965383c05d7..6476404b98b8 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -20,6 +20,7 @@ config ARC
 	select GENERIC_CALIBRATE_DELAY
 	select GENERIC_ATOMIC64 if !ISA_ARCV2 || !(ARC_HAS_LL64 && ARC_HAS_LLSC)
 	select GENERIC_CLOCKEVENTS
+	select GENERIC_CSUM
 	select GENERIC_FIND_FIRST_BIT
 	# for now, we don't need GENERIC_IRQ_PROBE, CONFIG_GENERIC_IRQ_CHIP
 	select GENERIC_IRQ_SHOW
@@ -59,9 +60,6 @@ config ARCH_HAS_CACHE_LINE_SIZE
 config SCHED_OMIT_FRAME_POINTER
 	def_bool y
 
-config GENERIC_CSUM
-	def_bool y
-
 config ARCH_DISCONTIGMEM_ENABLE
 	def_bool n
 
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 913b2ca7ec22..7cc3334aba29 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -91,6 +91,7 @@ config ARM64
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_CLOCKEVENTS_BROADCAST
 	select GENERIC_CPU_AUTOPROBE
+	select GENERIC_CSUM
 	select GENERIC_EARLY_IOREMAP
 	select GENERIC_IDLE_POLL_SETUP
 	select GENERIC_IRQ_MULTI_HANDLER
@@ -239,9 +240,6 @@ config ILLEGAL_POINTER_VALUE
 config GENERIC_HWEIGHT
 	def_bool y
 
-config GENERIC_CSUM
-        def_bool y
-
 config ZONE_DMA32
 	def_bool y
 
diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index 4085ba807e0c..c0a49cbd3df0 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -12,6 +12,7 @@ config CSKY
 	select HANDLE_DOMAIN_IRQ
 	select DW_APB_TIMER_OF
 	select GENERIC_CALIBRATE_DELAY
+	select GENERIC_CSUM
 	select GENERIC_LIB_ASHLDI3
 	select GENERIC_LIB_ASHRDI3
 	select GENERIC_LIB_LSHRDI3
@@ -83,9 +84,6 @@ config CPU_NO_USER_BKPT
 	  instruction exception.
 	  In kernel we parse the *regs->pc to determine whether to send SIGTRAP or not.
 
-config GENERIC_CSUM
-	def_bool y
-
 config GENERIC_HWEIGHT
 	def_bool y
 
diff --git a/arch/h8300/Kconfig b/arch/h8300/Kconfig
index ba33326e7c54..4f5a1efab822 100644
--- a/arch/h8300/Kconfig
+++ b/arch/h8300/Kconfig
@@ -9,6 +9,7 @@ config H8300
 	select GENERIC_CPU_DEVICES
 	select MODULES_USE_ELF_RELA
 	select GENERIC_CLOCKEVENTS
+	select GENERIC_CSUM
 	select CLKDEV_LOOKUP
 	select COMMON_CLK
 	select ARCH_WANT_FRAME_POINTERS
@@ -32,9 +33,6 @@ config GENERIC_HWEIGHT
 config NO_IOPORT_MAP
 	def_bool y
 
-config GENERIC_CSUM
-        def_bool y
-
 config HZ
 	int
 	default 100
diff --git a/arch/hexagon/Kconfig b/arch/hexagon/Kconfig
index 5eb4f48506b6..7a01f4c5a4f6 100644
--- a/arch/hexagon/Kconfig
+++ b/arch/hexagon/Kconfig
@@ -19,6 +19,7 @@ config HEXAGON
 	select HAVE_PERF_EVENTS
 	# GENERIC_ALLOCATOR is used by dma_alloc_coherent()
 	select GENERIC_ALLOCATOR
+	select GENERIC_CSUM
 	select GENERIC_IRQ_SHOW
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_TRACEHOOK
@@ -54,9 +55,6 @@ config EARLY_PRINTK
 config MMU
 	def_bool y
 
-config GENERIC_CSUM
-	def_bool y
-
 #
 # Use the generic interrupt handling code in kernel/irq/:
 #
diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index ed03da5430d9..1bf6abaea604 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -42,9 +42,6 @@ config GENERIC_HWEIGHT
 	bool
 	default y
 
-config GENERIC_CSUM
-	bool
-
 config TIME_LOW_RES
 	bool
 	default y
diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
index 65a44727a7a2..d8907d6f969c 100644
--- a/arch/microblaze/Kconfig
+++ b/arch/microblaze/Kconfig
@@ -16,6 +16,7 @@ config MICROBLAZE
 	select GENERIC_CALIBRATE_DELAY
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_CPU_DEVICES
+	select GENERIC_CSUM
 	select GENERIC_IDLE_POLL_SETUP
 	select GENERIC_IRQ_PROBE
 	select GENERIC_IRQ_SHOW
@@ -73,9 +74,6 @@ config ARCH_HAS_ILOG2_U64
 config GENERIC_HWEIGHT
 	def_bool y
 
-config GENERIC_CSUM
-	def_bool y
-
 source "arch/microblaze/Kconfig.platform"
 
 menu "Processor type and features"
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 530eaf950744..bd0c9be7e7cf 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -23,6 +23,7 @@ config MIPS
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_CMOS_UPDATE
 	select GENERIC_CPU_AUTOPROBE
+	select GENERIC_CSUM if !CPU_HAS_LOAD_STORE_LR
 	select GENERIC_IOMAP
 	select GENERIC_IRQ_PROBE
 	select GENERIC_IRQ_SHOW
@@ -1146,10 +1147,6 @@ config MIPS_MACHINE
 config NO_IOPORT_MAP
 	def_bool n
 
-config GENERIC_CSUM
-	bool
-	default y if !CPU_HAS_LOAD_STORE_LR
-
 config GENERIC_ISA_DMA
 	bool
 	select ZONE_DMA if GENERIC_ISA_DMA_SUPPORT_BROKEN=n
diff --git a/arch/nds32/Kconfig b/arch/nds32/Kconfig
index 38135bf98a6f..7b3a36705aa8 100644
--- a/arch/nds32/Kconfig
+++ b/arch/nds32/Kconfig
@@ -15,6 +15,7 @@ config NDS32
 	select GENERIC_CALIBRATE_DELAY
 	select GENERIC_CPU_DEVICES
 	select GENERIC_CLOCKEVENTS
+	select GENERIC_CSUM
 	select GENERIC_IRQ_CHIP
 	select GENERIC_IRQ_SHOW
 	select GENERIC_LIB_ASHLDI3
@@ -49,9 +50,6 @@ config NDS32
 	help
 	  Andes(nds32) Linux support.
 
-config GENERIC_CSUM
-        def_bool y
-
 config GENERIC_HWEIGHT
         def_bool y
 
diff --git a/arch/nios2/Kconfig b/arch/nios2/Kconfig
index 10320e023594..11ef63217ebe 100644
--- a/arch/nios2/Kconfig
+++ b/arch/nios2/Kconfig
@@ -9,6 +9,7 @@ config NIOS2
 	select GENERIC_CALIBRATE_DELAY
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_CPU_DEVICES
+	select GENERIC_CSUM
 	select GENERIC_IRQ_PROBE
 	select GENERIC_IRQ_SHOW
 	select GENERIC_STRNCPY_FROM_USER
@@ -26,9 +27,6 @@ config NIOS2
 	select CPU_NO_EFFICIENT_FFS
 	select ARCH_DISCARD_MEMBLOCK
 
-config GENERIC_CSUM
-	def_bool y
-
 config GENERIC_HWEIGHT
 	def_bool y
 
diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
index 6cb7632fa5b0..15d7df402c19 100644
--- a/arch/openrisc/Kconfig
+++ b/arch/openrisc/Kconfig
@@ -23,6 +23,7 @@ config OPENRISC
 	select GENERIC_ATOMIC64
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_CLOCKEVENTS_BROADCAST
+	select GENERIC_CSUM
 	select GENERIC_STRNCPY_FROM_USER
 	select GENERIC_STRNLEN_USER
 	select GENERIC_SMP_IDLE_THREAD
@@ -51,11 +52,6 @@ config GENERIC_HWEIGHT
 config NO_IOPORT_MAP
 	def_bool y
 
-# For now, use generic checksum functions
-#These can be reimplemented in assembly later if so inclined
-config GENERIC_CSUM
-        def_bool y
-
 menu "Processor type and features"
 
 choice
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 1684017fa496..a0e9207893c8 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -237,9 +237,6 @@ config PPC_BARRIER_NOSPEC
     default y
     depends on PPC_BOOK3S_64 || PPC_FSL_BOOK3E
 
-config GENERIC_CSUM
-	def_bool n
-
 config EARLY_PRINTK
 	bool
 	default y
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index c410ed896567..2b173a48bdbc 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -24,6 +24,7 @@ config RISCV
 	select GENERIC_CALIBRATE_DELAY
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_CPU_DEVICES
+	select GENERIC_CSUM
 	select GENERIC_IRQ_SHOW
 	select GENERIC_PCI_IOMAP
 	select GENERIC_SCHED_CLOCK
@@ -68,9 +69,6 @@ config PAGE_OFFSET
 	default 0xffffffff80000000 if 64BIT && MAXPHYSMEM_2GB
 	default 0xffffffe000000000 if 64BIT && MAXPHYSMEM_128GB
 
-config GENERIC_CSUM
-	def_bool y
-
 config GENERIC_HWEIGHT
 	def_bool y
 
diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 92d16cab61f3..3d0bd7fbe11a 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -85,6 +85,7 @@ config SUPERH32
 
 config SUPERH64
 	def_bool "$(ARCH)" = "sh64"
+	select GENERIC_CSUM
 	select HAVE_EXIT_THREAD
 	select KALLSYMS
 
@@ -93,10 +94,6 @@ config ARCH_DEFCONFIG
 	default "arch/sh/configs/shx3_defconfig" if SUPERH32
 	default "arch/sh/configs/cayman_defconfig" if SUPERH64
 
-config GENERIC_CSUM
-	def_bool y
-	depends on SUPERH64
-
 config GENERIC_HWEIGHT
 	def_bool y
 
diff --git a/arch/unicore32/Kconfig b/arch/unicore32/Kconfig
index 52b4d48e351a..9de1d983a99a 100644
--- a/arch/unicore32/Kconfig
+++ b/arch/unicore32/Kconfig
@@ -29,9 +29,6 @@ config UNICORE32
 	  designs licensed by PKUnity Ltd.
 	  Please see web page at <http://www.pkunity.com/>.
 
-config GENERIC_CSUM
-	def_bool y
-
 config NO_IOPORT_MAP
 	bool
 
diff --git a/lib/Kconfig b/lib/Kconfig
index a827d214d866..bd2e7e74c321 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -32,6 +32,9 @@ config HAVE_ARCH_BITREVERSE
 config RATIONAL
 	bool
 
+config GENERIC_CSUM
+	bool
+
 config GENERIC_STRNCPY_FROM_USER
 	bool
 
-- 
2.20.1


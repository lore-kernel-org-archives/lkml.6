Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98912C6778D
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E80D25EA6
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:48:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="p1XHOoA9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E80D25EA6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752678AbeGBOsG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 10:48:06 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50396 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752162AbeGBOrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 10:47:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=q1GRlGgHl/l16eTW33wl6SVsSI3SxeoZ/gMiZ/yebKI=; b=p1XHOoA9s0buC8G/BgTQKRpMa
        kkwb0D9csrNYN8Z0AYgXAO8Z8Jfx204dUZ8VafW0SBu9ln4C4rv1lC8eCJDAQWtP2VlTPh1nKG4oM
        Ib/edUrGhFO0XBj5R1mwMPZoRgHwcByMh8SAd02jpu0EXAuFkFx93j+kOmB7n/2y3Lf1zc3yKzScF
        950xs1AUwtkeY8r/jor0hpCVrni4FoXa7gzOMk8vb5+OAQayqBQH+EIpdHDojFlmVZ7K3fO2IH6gv
        U8Hr9XlWv2HaNtqN/pZ0xY2zb81vYmD8IlJ7dwQu53uTc4EXFo3kQUmSbZXwWJopECU2/BhIZuHh2
        gz55+wBqw==;
Received: from [208.118.102.130] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fa06k-0000Yi-AA; Mon, 02 Jul 2018 14:47:14 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] kconfig: include common Kconfig files from top-level Kconfig
Date:   Mon,  2 Jul 2018 08:47:07 -0600
Message-Id: <20180702144711.22111-2-hch@lst.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180702144711.22111-1-hch@lst.de>
References: <20180702144711.22111-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of duplicating the source statements in every architecture just
do it once in the toplevel Kconfig file.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 Kconfig                 | 22 ++++++++++++++++++++++
 arch/alpha/Kconfig      | 20 --------------------
 arch/arc/Kconfig        | 16 ----------------
 arch/arm/Kconfig        | 25 -------------------------
 arch/arm64/Kconfig      | 23 -----------------------
 arch/c6x/Kconfig        | 24 ------------------------
 arch/h8300/Kconfig      | 24 ------------------------
 arch/hexagon/Kconfig    | 16 ----------------
 arch/ia64/Kconfig       | 20 --------------------
 arch/m68k/Kconfig       | 24 ------------------------
 arch/microblaze/Kconfig | 24 ------------------------
 arch/mips/Kconfig       | 24 ------------------------
 arch/nds32/Kconfig      | 16 ----------------
 arch/nios2/Kconfig      | 24 ------------------------
 arch/openrisc/Kconfig   | 23 -----------------------
 arch/parisc/Kconfig     | 24 ------------------------
 arch/powerpc/Kconfig    | 19 -------------------
 arch/riscv/Kconfig      | 24 ------------------------
 arch/s390/Kconfig       | 24 ------------------------
 arch/sh/Kconfig         | 24 ------------------------
 arch/sparc/Kconfig      | 24 ------------------------
 arch/unicore32/Kconfig  | 24 ------------------------
 arch/x86/Kconfig        | 22 +---------------------
 arch/xtensa/Kconfig     | 25 -------------------------
 24 files changed, 23 insertions(+), 512 deletions(-)

diff --git a/Kconfig b/Kconfig
index a90d9f9e268b..5499b1273ba5 100644
--- a/Kconfig
+++ b/Kconfig
@@ -10,3 +10,25 @@ comment "Compiler: $(CC_VERSION_TEXT)"
 source "scripts/Kconfig.include"
 
 source "arch/$(SRCARCH)/Kconfig"
+
+source "init/Kconfig"
+
+source "kernel/Kconfig.freezer"
+
+menu "Executable file formats"
+source "fs/Kconfig.binfmt"
+endmenu
+
+source "mm/Kconfig"
+
+source "net/Kconfig"
+
+source "drivers/Kconfig"
+
+source "fs/Kconfig"
+
+source "security/Kconfig"
+
+source "crypto/Kconfig"
+
+source "lib/Kconfig"
diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
index 04a4a138ed13..50676152babd 100644
--- a/arch/alpha/Kconfig
+++ b/arch/alpha/Kconfig
@@ -74,9 +74,6 @@ config PGTABLE_LEVELS
 	int
 	default 3
 
-source "init/Kconfig"
-source "kernel/Kconfig.freezer"
-
 config AUDIT_ARCH
 	bool
 
@@ -573,8 +570,6 @@ config ARCH_DISCONTIGMEM_ENABLE
 	  or have huge holes in the physical address space for other reasons.
 	  See <file:Documentation/vm/numa.rst> for more.
 
-source "mm/Kconfig"
-
 config NUMA
 	bool "NUMA Support (EXPERIMENTAL)"
 	depends on DISCONTIGMEM && BROKEN
@@ -713,16 +708,8 @@ config SRM_ENV
 	  This driver is also available as a module and will be called
 	  srm_env then.
 
-source "fs/Kconfig.binfmt"
-
 endmenu
 
-source "net/Kconfig"
-
-source "drivers/Kconfig"
-
-source "fs/Kconfig"
-
 source "arch/alpha/Kconfig.debug"
 
 # DUMMY_CONSOLE may be defined in drivers/video/console/Kconfig
@@ -731,10 +718,3 @@ config DUMMY_CONSOLE
 	bool
 	depends on VGA_HOSE
 	default y
-
-source "security/Kconfig"
-
-source "crypto/Kconfig"
-
-source "lib/Kconfig"
-
diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index e81bcd271be7..d4a28c45c406 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -94,9 +94,6 @@ config HAVE_ARCH_TRANSPARENT_HUGEPAGE
 	def_bool y
 	depends on ARC_MMU_V4
 
-source "init/Kconfig"
-source "kernel/Kconfig.freezer"
-
 menu "ARC Architecture Configuration"
 
 menu "ARC Platform/SoC/Board"
@@ -550,22 +547,13 @@ config ARC_BUILTIN_DTB_NAME
 
 source "kernel/Kconfig.preempt"
 
-menu "Executable file formats"
-source "fs/Kconfig.binfmt"
-endmenu
-
 endmenu	 # "ARC Architecture Configuration"
 
-source "mm/Kconfig"
-
 config FORCE_MAX_ZONEORDER
 	int "Maximum zone order"
 	default "12" if ARC_HUGEPAGE_16M
 	default "11"
 
-source "net/Kconfig"
-source "drivers/Kconfig"
-
 menu "Bus Support"
 
 config PCI
@@ -586,9 +574,5 @@ source "drivers/pci/Kconfig"
 
 endmenu
 
-source "fs/Kconfig"
 source "arch/arc/Kconfig.debug"
-source "security/Kconfig"
-source "crypto/Kconfig"
-source "lib/Kconfig"
 source "kernel/power/Kconfig"
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 843edfd000be..37fd7565a928 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -298,10 +298,6 @@ config PGTABLE_LEVELS
 	default 3 if ARM_LPAE
 	default 2
 
-source "init/Kconfig"
-
-source "kernel/Kconfig.freezer"
-
 menu "System Type"
 
 config MMU
@@ -911,8 +907,6 @@ config PLAT_VERSATILE
 
 source "arch/arm/firmware/Kconfig"
 
-source arch/arm/mm/Kconfig
-
 config IWMMXT
 	bool "Enable iWMMXt support"
 	depends on CPU_XSCALE || CPU_XSC3 || CPU_MOHAWK || CPU_PJ4 || CPU_PJ4B
@@ -1721,8 +1715,6 @@ config ARM_MODULE_PLTS
 	  Disabling this is usually safe for small single-platform
 	  configurations. If unsure, say y.
 
-source "mm/Kconfig"
-
 config FORCE_MAX_ZONEORDER
 	int "Maximum zone order"
 	default "12" if SOC_AM33XX
@@ -2175,12 +2167,6 @@ config KERNEL_MODE_NEON
 
 endmenu
 
-menu "Userspace binary formats"
-
-source "fs/Kconfig.binfmt"
-
-endmenu
-
 menu "Power management options"
 
 source "kernel/power/Kconfig"
@@ -2201,23 +2187,12 @@ config ARCH_HIBERNATION_POSSIBLE
 
 endmenu
 
-source "net/Kconfig"
-
-source "drivers/Kconfig"
-
 source "drivers/firmware/Kconfig"
 
-source "fs/Kconfig"
-
 source "arch/arm/Kconfig.debug"
 
-source "security/Kconfig"
-
-source "crypto/Kconfig"
 if CRYPTO
 source "arch/arm/crypto/Kconfig"
 endif
 
-source "lib/Kconfig"
-
 source "arch/arm/kvm/Kconfig"
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 42c090cf0292..fabd797c8645 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -267,10 +267,6 @@ config ARCH_PROC_KCORE_TEXT
 config MULTI_IRQ_HANDLER
 	def_bool y
 
-source "init/Kconfig"
-
-source "kernel/Kconfig.freezer"
-
 source "arch/arm64/Kconfig.platforms"
 
 menu "Bus support"
@@ -791,8 +787,6 @@ config ARCH_WANT_HUGE_PMD_SHARE
 config ARCH_HAS_CACHE_LINE_SIZE
 	def_bool y
 
-source "mm/Kconfig"
-
 config SECCOMP
 	bool "Enable seccomp to safely compute untrusted bytecode"
 	---help---
@@ -1273,10 +1267,6 @@ config DMI
 
 endmenu
 
-menu "Userspace binary formats"
-
-source "fs/Kconfig.binfmt"
-
 config COMPAT
 	bool "Kernel support for 32-bit EL0"
 	depends on ARM64_4K_PAGES || EXPERT
@@ -1300,8 +1290,6 @@ config SYSVIPC_COMPAT
 	def_bool y
 	depends on COMPAT && SYSVIPC
 
-endmenu
-
 menu "Power management options"
 
 source "kernel/power/Kconfig"
@@ -1327,25 +1315,14 @@ source "drivers/cpufreq/Kconfig"
 
 endmenu
 
-source "net/Kconfig"
-
-source "drivers/Kconfig"
-
 source "drivers/firmware/Kconfig"
 
 source "drivers/acpi/Kconfig"
 
-source "fs/Kconfig"
-
 source "arch/arm64/kvm/Kconfig"
 
 source "arch/arm64/Kconfig.debug"
 
-source "security/Kconfig"
-
-source "crypto/Kconfig"
 if CRYPTO
 source "arch/arm64/crypto/Kconfig"
 endif
-
-source "lib/Kconfig"
diff --git a/arch/c6x/Kconfig b/arch/c6x/Kconfig
index bf59855628ac..441bbe089b96 100644
--- a/arch/c6x/Kconfig
+++ b/arch/c6x/Kconfig
@@ -53,12 +53,8 @@ config C6X_BIG_KERNEL
 
 	  If unsure, say N.
 
-source "init/Kconfig"
-
 # Use the generic interrupt handling code in kernel/irq/
 
-source "kernel/Kconfig.freezer"
-
 config CMDLINE_BOOL
 	bool "Default bootloader kernel arguments"
 
@@ -114,32 +110,12 @@ config KERNEL_RAM_BASE_ADDRESS
 	default 0xe0000000 if SOC_TMS320C6472
 	default 0x80000000
 
-source "mm/Kconfig"
-
 source "kernel/Kconfig.preempt"
 
 source "kernel/Kconfig.hz"
 
 endmenu
 
-menu "Executable file formats"
-
-source "fs/Kconfig.binfmt"
-
-endmenu
-
-source "net/Kconfig"
-
-source "drivers/Kconfig"
-
-source "fs/Kconfig"
-
-source "security/Kconfig"
-
-source "crypto/Kconfig"
-
-source "lib/Kconfig"
-
 menu "Kernel hacking"
 
 source "lib/Kconfig.debug"
diff --git a/arch/h8300/Kconfig b/arch/h8300/Kconfig
index 091d6d04b5e5..e23cd887f8f9 100644
--- a/arch/h8300/Kconfig
+++ b/arch/h8300/Kconfig
@@ -48,40 +48,16 @@ config NR_CPUS
 	int
 	default 1
 
-source "init/Kconfig"
-
-source "kernel/Kconfig.freezer"
-
 source "arch/h8300/Kconfig.cpu"
 
 menu "Kernel Features"
 
 source "kernel/Kconfig.preempt"
 
-source "mm/Kconfig"
-
-endmenu
-
-menu "Executable file formats"
-
-source "fs/Kconfig.binfmt"
-
 endmenu
 
-source "net/Kconfig"
-
-source "drivers/Kconfig"
-
-source "fs/Kconfig"
-
 menu "Kernel hacking"
 
 source "lib/Kconfig.debug"
 
 endmenu
-
-source "security/Kconfig"
-
-source "crypto/Kconfig"
-
-source "lib/Kconfig"
diff --git a/arch/hexagon/Kconfig b/arch/hexagon/Kconfig
index 37adb2003033..d2851f46a64b 100644
--- a/arch/hexagon/Kconfig
+++ b/arch/hexagon/Kconfig
@@ -146,26 +146,10 @@ config PAGE_SIZE_256KB
 
 endchoice
 
-source "mm/Kconfig"
-
 source "kernel/Kconfig.hz"
 
 endmenu
 
-source "init/Kconfig"
-source "kernel/Kconfig.freezer"
-source "drivers/Kconfig"
-source "fs/Kconfig"
-
-menu "Executable File Formats"
-source "fs/Kconfig.binfmt"
-endmenu
-
-source "net/Kconfig"
-source "security/Kconfig"
-source "crypto/Kconfig"
-source "lib/Kconfig"
-
 menu "Kernel hacking"
 source "lib/Kconfig.debug"
 endmenu
diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index ff861420b8f5..6015d66fa521 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -4,10 +4,6 @@ config PGTABLE_LEVELS
 	range 3 4 if !IA64_PAGE_SIZE_64KB
 	default 3
 
-source "init/Kconfig"
-
-source "kernel/Kconfig.freezer"
-
 menu "Processor type and features"
 
 config IA64
@@ -370,8 +366,6 @@ config FORCE_CPEI_RETARGET
 
 source "kernel/Kconfig.preempt"
 
-source "mm/Kconfig"
-
 config ARCH_SELECT_MEMORY_MODEL
 	def_bool y
 
@@ -532,8 +526,6 @@ config CRASH_DUMP
 
 source "drivers/firmware/Kconfig"
 
-source "fs/Kconfig.binfmt"
-
 endmenu
 
 menu "Power management and ACPI options"
@@ -574,10 +566,6 @@ endmenu
 
 endif
 
-source "net/Kconfig"
-
-source "drivers/Kconfig"
-
 source "arch/ia64/hp/sim/Kconfig"
 
 config MSPEC
@@ -589,12 +577,4 @@ config MSPEC
 	  operations support (formerly known as fetchop), say Y here,
 	  otherwise say N.
 
-source "fs/Kconfig"
-
 source "arch/ia64/Kconfig.debug"
-
-source "security/Kconfig"
-
-source "crypto/Kconfig"
-
-source "lib/Kconfig"
diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index 785612b576f7..f76fb7bb371f 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -75,10 +75,6 @@ config PGTABLE_LEVELS
 	default 2 if SUN3 || COLDFIRE
 	default 3
 
-source "init/Kconfig"
-
-source "kernel/Kconfig.freezer"
-
 config MMU
 	bool "MMU-based Paged Memory Management Support"
 	default y
@@ -137,14 +133,6 @@ if COLDFIRE
 source "kernel/Kconfig.preempt"
 endif
 
-source "mm/Kconfig"
-
-endmenu
-
-menu "Executable file formats"
-
-source "fs/Kconfig.binfmt"
-
 endmenu
 
 if !MMU
@@ -158,18 +146,6 @@ config PM
 endmenu
 endif
 
-source "net/Kconfig"
-
-source "drivers/Kconfig"
-
 source "arch/m68k/Kconfig.devices"
 
-source "fs/Kconfig"
-
 source "arch/m68k/Kconfig.debug"
-
-source "security/Kconfig"
-
-source "crypto/Kconfig"
-
-source "lib/Kconfig"
diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
index d14782100088..3a427ae82ede 100644
--- a/arch/microblaze/Kconfig
+++ b/arch/microblaze/Kconfig
@@ -85,10 +85,6 @@ config STACKTRACE_SUPPORT
 config LOCKDEP_SUPPORT
 	def_bool y
 
-source "init/Kconfig"
-
-source "kernel/Kconfig.freezer"
-
 source "arch/microblaze/Kconfig.platform"
 
 menu "Processor type and features"
@@ -268,14 +264,6 @@ config MICROBLAZE_64K_PAGES
 
 endchoice
 
-source "mm/Kconfig"
-
-endmenu
-
-menu "Executable file formats"
-
-source "fs/Kconfig.binfmt"
-
 endmenu
 
 menu "Bus Options"
@@ -300,16 +288,4 @@ source "drivers/pci/Kconfig"
 
 endmenu
 
-source "net/Kconfig"
-
-source "drivers/Kconfig"
-
-source "fs/Kconfig"
-
 source "arch/microblaze/Kconfig.debug"
-
-source "security/Kconfig"
-
-source "crypto/Kconfig"
-
-source "lib/Kconfig"
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 08c10c518f83..f586a3259f7f 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2641,8 +2641,6 @@ config HW_PERF_EVENTS
 	  Enable hardware performance counter support for perf events. If
 	  disabled, perf events will use software events only.
 
-source "mm/Kconfig"
-
 config SMP
 	bool "Multi-Processing support"
 	depends on SYS_SUPPORTS_SMP
@@ -2994,10 +2992,6 @@ config PGTABLE_LEVELS
 	default 3 if 64BIT && !PAGE_SIZE_64KB
 	default 2
 
-source "init/Kconfig"
-
-source "kernel/Kconfig.freezer"
-
 menu "Bus options (PCI, PCMCIA, EISA, ISA, TC)"
 
 config HW_HAS_EISA
@@ -3127,10 +3121,6 @@ source "drivers/rapidio/Kconfig"
 
 endmenu
 
-menu "Executable file formats"
-
-source "fs/Kconfig.binfmt"
-
 config TRAD_SIGNALS
 	bool
 
@@ -3176,8 +3166,6 @@ config BINFMT_ELF32
 	default y if MIPS32_O32 || MIPS32_N32
 	select ELFCORE
 
-endmenu
-
 menu "Power management options"
 
 config ARCH_HIBERNATION_POSSIBLE
@@ -3205,20 +3193,8 @@ source "drivers/cpuidle/Kconfig"
 
 endmenu
 
-source "net/Kconfig"
-
-source "drivers/Kconfig"
-
 source "drivers/firmware/Kconfig"
 
-source "fs/Kconfig"
-
 source "arch/mips/Kconfig.debug"
 
-source "security/Kconfig"
-
-source "crypto/Kconfig"
-
-source "lib/Kconfig"
-
 source "arch/mips/kvm/Kconfig"
diff --git a/arch/nds32/Kconfig b/arch/nds32/Kconfig
index 6aed974276d8..a9c6d25a14f0 100644
--- a/arch/nds32/Kconfig
+++ b/arch/nds32/Kconfig
@@ -71,8 +71,6 @@ config FIX_EARLYCON_MEM
 config PGTABLE_LEVELS
 	default 2
 
-source "init/Kconfig"
-
 menu "System Type"
 source "arch/nds32/Kconfig.cpu"
 config NR_CPUS
@@ -91,23 +89,9 @@ endmenu
 
 menu "Kernel Features"
 source "kernel/Kconfig.preempt"
-source "kernel/Kconfig.freezer"
-source "mm/Kconfig"
 source "kernel/Kconfig.hz"
 endmenu
 
-menu "Executable file formats"
-source "fs/Kconfig.binfmt"
-endmenu
-
-source "net/Kconfig"
-source "drivers/Kconfig"
-source "fs/Kconfig"
-
 menu "Kernel hacking"
 source "lib/Kconfig.debug"
 endmenu
-
-source "security/Kconfig"
-source "crypto/Kconfig"
-source "lib/Kconfig"
diff --git a/arch/nios2/Kconfig b/arch/nios2/Kconfig
index 3d4ec88f1db1..5e139f2e6b7b 100644
--- a/arch/nios2/Kconfig
+++ b/arch/nios2/Kconfig
@@ -47,18 +47,12 @@ config RWSEM_GENERIC_SPINLOCK
 config TRACE_IRQFLAGS_SUPPORT
 	def_bool n
 
-source "init/Kconfig"
-
 menu "Kernel features"
 
 source "kernel/Kconfig.preempt"
 
-source "kernel/Kconfig.freezer"
-
 source "kernel/Kconfig.hz"
 
-source "mm/Kconfig"
-
 config FORCE_MAX_ZONEORDER
 	int "Maximum zone order"
 	range 9 20
@@ -196,22 +190,4 @@ config NIOS2_IO_REGION_BASE
 
 endmenu
 
-menu "Executable file formats"
-
-source "fs/Kconfig.binfmt"
-
-endmenu
-
-source "net/Kconfig"
-
-source "drivers/Kconfig"
-
-source "fs/Kconfig"
-
 source "arch/nios2/Kconfig.debug"
-
-source "security/Kconfig"
-
-source "crypto/Kconfig"
-
-source "lib/Kconfig"
diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
index 9ecad05bfc73..eb9f503c8972 100644
--- a/arch/openrisc/Kconfig
+++ b/arch/openrisc/Kconfig
@@ -72,10 +72,6 @@ config LOCKDEP_SUPPORT
 config MULTI_IRQ_HANDLER
 	def_bool y
 
-source "init/Kconfig"
-
-source "kernel/Kconfig.freezer"
-
 menu "Processor type and features"
 
 choice
@@ -148,7 +144,6 @@ config SMP
 
 source kernel/Kconfig.hz
 source kernel/Kconfig.preempt
-source "mm/Kconfig"
 
 config OPENRISC_NO_SPR_SR_DSX
 	bool "use SPR_SR_DSX software emulation" if OR1K_1200
@@ -207,24 +202,6 @@ endmenu
 
 endmenu
 
-menu "Executable file formats"
-
-source "fs/Kconfig.binfmt"
-
-endmenu
-
-source "net/Kconfig"
-
-source "drivers/Kconfig"
-
-source "fs/Kconfig"
-
-source "security/Kconfig"
-
-source "crypto/Kconfig"
-
-source "lib/Kconfig"
-
 menu "Kernel hacking"
 
 source "lib/Kconfig.debug"
diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
index 17526bebcbd2..64b832a19bdf 100644
--- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -129,10 +129,6 @@ config PGTABLE_LEVELS
 config SYS_SUPPORTS_HUGETLBFS
 	def_bool y if PA20
 
-source "init/Kconfig"
-
-source "kernel/Kconfig.freezer"
-
 
 menu "Processor type and features"
 
@@ -329,7 +325,6 @@ config NODES_SHIFT
 
 source "kernel/Kconfig.preempt"
 source "kernel/Kconfig.hz"
-source "mm/Kconfig"
 
 config COMPAT
 	def_bool y
@@ -354,19 +349,6 @@ endmenu
 
 source "drivers/parisc/Kconfig"
 
-
-menu "Executable file formats"
-
-source "fs/Kconfig.binfmt"
-
-endmenu
-
-source "net/Kconfig"
-
-source "drivers/Kconfig"
-
-source "fs/Kconfig"
-
 source "arch/parisc/Kconfig.debug"
 
 config SECCOMP
@@ -384,9 +366,3 @@ config SECCOMP
 	  defined by each seccomp mode.
 
 	  If unsure, say Y. Only embedded should say N here.
-
-source "security/Kconfig"
-
-source "crypto/Kconfig"
-
-source "lib/Kconfig"
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 9f2b75fe2c2d..131132f161e5 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -383,10 +383,6 @@ config PGTABLE_LEVELS
 	default 3 if PPC_64K_PAGES && !PPC_BOOK3S_64
 	default 4
 
-source "init/Kconfig"
-
-source "kernel/Kconfig.freezer"
-
 source "arch/powerpc/sysdev/Kconfig"
 source "arch/powerpc/platforms/Kconfig"
 
@@ -398,7 +394,6 @@ config HIGHMEM
 
 source kernel/Kconfig.hz
 source kernel/Kconfig.preempt
-source "fs/Kconfig.binfmt"
 
 config HUGETLB_PAGE_SIZE_VARIABLE
 	bool
@@ -641,8 +636,6 @@ config ILLEGAL_POINTER_VALUE
 	default 0x5deadbeef0000000 if PPC64
 	default 0
 
-source "mm/Kconfig"
-
 config ARCH_MEMORY_PROBE
 	def_bool y
 	depends on MEMORY_HOTPLUG
@@ -1201,20 +1194,8 @@ endif
 config	ARCH_RANDOM
 	def_bool n
 
-source "net/Kconfig"
-
-source "drivers/Kconfig"
-
-source "fs/Kconfig"
-
-source "lib/Kconfig"
-
 source "arch/powerpc/Kconfig.debug"
 
-source "security/Kconfig"
-
-source "crypto/Kconfig"
-
 config PPC_LIB_RHEAP
 	bool
 
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index f12680c9b947..558ca3de0614 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -211,8 +211,6 @@ endmenu
 
 menu "Kernel type"
 
-source "mm/Kconfig"
-
 source "kernel/Kconfig.preempt"
 
 source "kernel/Kconfig.hz"
@@ -241,28 +239,12 @@ source "drivers/pci/Kconfig"
 
 endmenu
 
-source "init/Kconfig"
-
-source "kernel/Kconfig.freezer"
-
-menu "Executable file formats"
-
-source "fs/Kconfig.binfmt"
-
-endmenu
-
 menu "Power management options"
 
 source kernel/power/Kconfig
 
 endmenu
 
-source "net/Kconfig"
-
-source "drivers/Kconfig"
-
-source "fs/Kconfig"
-
 menu "Kernel hacking"
 
 config CMDLINE_BOOL
@@ -307,9 +289,3 @@ source "lib/Kconfig.debug"
 config CMDLINE_BOOL
 	bool
 endmenu
-
-source "security/Kconfig"
-
-source "crypto/Kconfig"
-
-source "lib/Kconfig"
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index baed39772c84..d35bbded1afd 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -183,10 +183,6 @@ config PGTABLE_LEVELS
 	int
 	default 5
 
-source "init/Kconfig"
-
-source "kernel/Kconfig.freezer"
-
 source "kernel/livepatch/Kconfig"
 
 menu "Processor type and features"
@@ -626,8 +622,6 @@ config FORCE_MAX_ZONEORDER
 	int
 	default "9"
 
-source "mm/Kconfig"
-
 config MAX_PHYSMEM_BITS
 	int "Maximum size of supported physical memory in bits (42-53)"
 	range 42 53
@@ -797,10 +791,6 @@ config CRASH_DUMP
 
 endmenu
 
-menu "Executable file formats / Emulations"
-
-source "fs/Kconfig.binfmt"
-
 config SECCOMP
 	def_bool y
 	prompt "Enable seccomp to safely compute untrusted bytecode"
@@ -818,8 +808,6 @@ config SECCOMP
 
 	  If unsure, say Y.
 
-endmenu
-
 menu "Power Management"
 
 config ARCH_HIBERNATION_POSSIBLE
@@ -829,30 +817,18 @@ source "kernel/power/Kconfig"
 
 endmenu
 
-source "net/Kconfig"
-
 config PCMCIA
 	def_bool n
 
 config CCW
 	def_bool y
 
-source "drivers/Kconfig"
-
 config HAVE_PNETID
 	tristate
 	default (SMC || CCWGROUP)
 
-source "fs/Kconfig"
-
 source "arch/s390/Kconfig.debug"
 
-source "security/Kconfig"
-
-source "crypto/Kconfig"
-
-source "lib/Kconfig"
-
 menu "Virtualization"
 
 config PFAULT
diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index dd4f3d3e644f..7ab7b148181b 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -168,10 +168,6 @@ config PGTABLE_LEVELS
 	default 3 if X2TLB
 	default 2
 
-source "init/Kconfig"
-
-source "kernel/Kconfig.freezer"
-
 menu "System type"
 
 #
@@ -553,8 +549,6 @@ endchoice
 
 endif
 
-source "arch/sh/mm/Kconfig"
- 
 source "arch/sh/Kconfig.cpu"
 
 source "arch/sh/boards/Kconfig"
@@ -882,12 +876,6 @@ source "drivers/pcmcia/Kconfig"
 
 endmenu
 
-menu "Executable file formats"
-
-source "fs/Kconfig.binfmt"
-
-endmenu
-
 menu "Power management options (EXPERIMENTAL)"
 
 source "kernel/power/Kconfig"
@@ -896,16 +884,4 @@ source "drivers/cpuidle/Kconfig"
 
 endmenu
 
-source "net/Kconfig"
-
-source "drivers/Kconfig"
-
-source "fs/Kconfig"
-
 source "arch/sh/Kconfig.debug"
-
-source "security/Kconfig"
-
-source "crypto/Kconfig"
-
-source "lib/Kconfig"
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 0f535debf802..8a1e44d2e112 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -155,10 +155,6 @@ config PGTABLE_LEVELS
 config ARCH_SUPPORTS_UPROBES
 	def_bool y if SPARC64
 
-source "init/Kconfig"
-
-source "kernel/Kconfig.freezer"
-
 menu "Processor type and features"
 
 config SMP
@@ -331,8 +327,6 @@ config FORCE_MAX_ZONEORDER
 	  This config option is actually maximum order plus one. For example,
 	  a value of 13 means that the largest free memory block is 2^12 pages.
 
-source "mm/Kconfig"
-
 if SPARC64
 source "kernel/power/Kconfig"
 endif
@@ -556,10 +550,6 @@ config SPARC64_PCI_MSI
 
 endmenu
 
-menu "Executable file formats"
-
-source "fs/Kconfig.binfmt"
-
 config COMPAT
 	bool
 	depends on SPARC64
@@ -574,20 +564,6 @@ config SYSVIPC_COMPAT
 	depends on COMPAT && SYSVIPC
 	default y
 
-endmenu
-
-source "net/Kconfig"
-
-source "drivers/Kconfig"
-
 source "drivers/sbus/char/Kconfig"
 
-source "fs/Kconfig"
-
 source "arch/sparc/Kconfig.debug"
-
-source "security/Kconfig"
-
-source "crypto/Kconfig"
-
-source "lib/Kconfig"
diff --git a/arch/unicore32/Kconfig b/arch/unicore32/Kconfig
index 03f991e44288..7fa7e61eb19f 100644
--- a/arch/unicore32/Kconfig
+++ b/arch/unicore32/Kconfig
@@ -63,10 +63,6 @@ config ARCH_MAY_HAVE_PC_FDC
 config ZONE_DMA
 	def_bool y
 
-source "init/Kconfig"
-
-source "kernel/Kconfig.freezer"
-
 menu "System Type"
 
 config MMU
@@ -143,8 +139,6 @@ source "kernel/Kconfig.preempt"
 
 source "kernel/Kconfig.hz"
 
-source "mm/Kconfig"
-
 config LEDS
 	def_bool y
 	depends on GPIOLIB
@@ -181,12 +175,6 @@ config CMDLINE_FORCE
 
 endmenu
 
-menu "Userspace binary formats"
-
-source "fs/Kconfig.binfmt"
-
-endmenu
-
 menu "Power management options"
 
 source "kernel/power/Kconfig"
@@ -201,8 +189,6 @@ config ARCH_HIBERNATION_POSSIBLE
 
 endmenu
 
-source "net/Kconfig"
-
 if ARCH_PUV3
 
 config PUV3_GPIO
@@ -237,14 +223,4 @@ endif
 
 endif
 
-source "drivers/Kconfig"
-
-source "fs/Kconfig"
-
 source "arch/unicore32/Kconfig.debug"
-
-source "security/Kconfig"
-
-source "crypto/Kconfig"
-
-source "lib/Kconfig"
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index f1dbb4ee19d7..6faefd1c9f13 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -345,8 +345,6 @@ config PGTABLE_LEVELS
 	default 3 if X86_PAE
 	default 2
 
-source "init/Kconfig"
-
 config CC_HAS_SANE_STACKPROTECTOR
 	bool
 	default $(success,$(srctree)/scripts/gcc-x86_64-has-stack-protector.sh $(CC)) if 64BIT
@@ -355,8 +353,6 @@ config CC_HAS_SANE_STACKPROTECTOR
 	   We have to make sure stack protector is unconditionally disabled if
 	   the compiler produces broken code.
 
-source "kernel/Kconfig.freezer"
-
 menu "Processor type and features"
 
 config ZONE_DMA
@@ -1638,8 +1634,6 @@ config ILLEGAL_POINTER_VALUE
        default 0 if X86_32
        default 0xdead000000000000 if X86_64
 
-source "mm/Kconfig"
-
 config X86_PMEM_LEGACY_DEVICE
 	bool
 
@@ -2865,9 +2859,7 @@ config X86_SYSFB
 endmenu
 
 
-menu "Executable file formats / Emulations"
-
-source "fs/Kconfig.binfmt"
+menu "Binary Emulations"
 
 config IA32_EMULATION
 	bool "IA32 Emulation"
@@ -2937,20 +2929,8 @@ config X86_DMA_REMAP
 config HAVE_GENERIC_GUP
 	def_bool y
 
-source "net/Kconfig"
-
-source "drivers/Kconfig"
-
 source "drivers/firmware/Kconfig"
 
-source "fs/Kconfig"
-
 source "arch/x86/Kconfig.debug"
 
-source "security/Kconfig"
-
-source "crypto/Kconfig"
-
 source "arch/x86/kvm/Kconfig"
-
-source "lib/Kconfig"
diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index d575e8701955..d8bac8be3a33 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -60,9 +60,6 @@ config HZ
 	int
 	default 100
 
-source "init/Kconfig"
-source "kernel/Kconfig.freezer"
-
 config LOCKDEP_SUPPORT
 	def_bool y
 
@@ -491,8 +488,6 @@ config SIMDISK1_FILENAME
 	  Another simulated disk in a host file for a buildroot-independent
 	  storage.
 
-source "mm/Kconfig"
-
 config FORCE_MAX_ZONEORDER
 	int "Maximum zone order"
 	default "11"
@@ -567,30 +562,10 @@ config XTFPGA_LCD_8BIT_ACCESS
 
 endmenu
 
-menu "Executable file formats"
-
-source "fs/Kconfig.binfmt"
-
-endmenu
-
 menu "Power management options"
 
 source "kernel/power/Kconfig"
 
 endmenu
 
-source "net/Kconfig"
-
-source "drivers/Kconfig"
-
-source "fs/Kconfig"
-
 source "arch/xtensa/Kconfig.debug"
-
-source "security/Kconfig"
-
-source "crypto/Kconfig"
-
-source "lib/Kconfig"
-
-
-- 
2.18.0


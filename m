Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 841C1C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 121B725EA6
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:48:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Abc6f6tD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 121B725EA6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752630AbeGBOsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 10:48:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50400 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752242AbeGBOrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 10:47:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=YUykmVfoqdXDkxkSKqYYWEFlH5Ts5LDTJN/vngfg4Tk=; b=Abc6f6tD2ywMP4j8uj9MftSAR
        5cEt/FrcV3AgQTpwXUs5opvEDDHMVm92FlghFxgR+l65nEv0v+bieOKUm9eeSFQmEu3Kr88IUBd28
        iRAZ2RgJ9QBn2JZHxfdKOGwsPPTE+acfgiVJdpT7jnzpjb8tWzZVptwJznWp9oHOZ2XIfvDT57moT
        MPvIMJUbWQtmYDM2/sYvUKxF9mXuYB7etHdSamYHoLTkihBmMCmMpO+AJLEZlfvh1yUq+1lKNnDWX
        HARYmOUrfYqNhPK2V+ZMIxoEWeH1bYG1f05kYPI/eYCgRzEzUntauazWiZRLfXqkLidZMTiEj4FQ2
        MenH3hMCg==;
Received: from [208.118.102.130] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fa06l-0000Yo-2T; Mon, 02 Jul 2018 14:47:15 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] Kconfig: consolidate the "Kernel hacking menu"
Date:   Mon,  2 Jul 2018 08:47:08 -0600
Message-Id: <20180702144711.22111-3-hch@lst.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180702144711.22111-1-hch@lst.de>
References: <20180702144711.22111-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the source of lib/Kconfig.debug and arch/$(ARCH)/Kconfig.debug to
the top-level Kconfig.  For two architectures that means moving their
arch-specific symbols in that menu into a new arch Kconfig.debug file,
and for a few more creating a dummy file so that we can include it
unconditionally.

Also move the actual 'Kernel hacking' menu to lib/Kconfig.debug, where
it belongs.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 Kconfig                       |  2 ++
 arch/alpha/Kconfig            |  2 --
 arch/alpha/Kconfig.debug      |  5 ----
 arch/arc/Kconfig              |  1 -
 arch/arc/Kconfig.debug        |  5 ----
 arch/arm/Kconfig              |  2 --
 arch/arm/Kconfig.debug        |  5 ----
 arch/arm64/Kconfig            |  2 --
 arch/arm64/Kconfig.debug      |  5 ----
 arch/c6x/Kconfig              | 15 ------------
 arch/c6x/Kconfig.debug        | 11 +++++++++
 arch/h8300/Kconfig            |  6 -----
 arch/h8300/Kconfig.debug      |  1 +
 arch/hexagon/Kconfig          |  4 ----
 arch/hexagon/Kconfig.debug    |  1 +
 arch/ia64/Kconfig             |  2 --
 arch/ia64/Kconfig.debug       |  5 ----
 arch/m68k/Kconfig             |  2 --
 arch/m68k/Kconfig.debug       |  5 ----
 arch/microblaze/Kconfig       |  2 --
 arch/microblaze/Kconfig.debug |  6 -----
 arch/mips/Kconfig             |  2 --
 arch/mips/Kconfig.debug       |  5 ----
 arch/nds32/Kconfig            |  4 ----
 arch/nds32/Kconfig.debug      |  1 +
 arch/nios2/Kconfig            |  2 --
 arch/nios2/Kconfig.debug      |  5 ----
 arch/openrisc/Kconfig         |  6 -----
 arch/openrisc/Kconfig.debug   |  1 +
 arch/parisc/Kconfig           |  2 --
 arch/parisc/Kconfig.debug     |  5 ----
 arch/powerpc/Kconfig          |  2 --
 arch/powerpc/Kconfig.debug    |  5 ----
 arch/riscv/Kconfig            | 45 -----------------------------------
 arch/riscv/Kconfig.debug      | 37 ++++++++++++++++++++++++++++
 arch/s390/Kconfig             |  2 --
 arch/s390/Kconfig.debug       |  5 ----
 arch/sh/Kconfig               |  2 --
 arch/sh/Kconfig.debug         |  5 ----
 arch/sparc/Kconfig            |  2 --
 arch/sparc/Kconfig.debug      |  5 ----
 arch/um/Kconfig.debug         |  5 ----
 arch/um/Kconfig.rest          | 18 --------------
 arch/unicore32/Kconfig        |  2 --
 arch/unicore32/Kconfig.debug  |  5 ----
 arch/x86/Kconfig              |  2 --
 arch/x86/Kconfig.debug        |  5 ----
 arch/xtensa/Kconfig           |  2 --
 arch/xtensa/Kconfig.debug     |  5 ----
 lib/Kconfig.debug             |  6 +++++
 50 files changed, 60 insertions(+), 222 deletions(-)
 create mode 100644 arch/c6x/Kconfig.debug
 create mode 100644 arch/h8300/Kconfig.debug
 create mode 100644 arch/hexagon/Kconfig.debug
 create mode 100644 arch/nds32/Kconfig.debug
 create mode 100644 arch/openrisc/Kconfig.debug
 create mode 100644 arch/riscv/Kconfig.debug

diff --git a/Kconfig b/Kconfig
index 5499b1273ba5..5f580c81d85d 100644
--- a/Kconfig
+++ b/Kconfig
@@ -32,3 +32,5 @@ source "security/Kconfig"
 source "crypto/Kconfig"
 
 source "lib/Kconfig"
+
+source "lib/Kconfig.debug"
diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
index 50676152babd..e4334f017f8e 100644
--- a/arch/alpha/Kconfig
+++ b/arch/alpha/Kconfig
@@ -710,8 +710,6 @@ config SRM_ENV
 
 endmenu
 
-source "arch/alpha/Kconfig.debug"
-
 # DUMMY_CONSOLE may be defined in drivers/video/console/Kconfig
 # but we also need it if VGA_HOSE is set
 config DUMMY_CONSOLE
diff --git a/arch/alpha/Kconfig.debug b/arch/alpha/Kconfig.debug
index 5e93dffb818a..b88c7b641d72 100644
--- a/arch/alpha/Kconfig.debug
+++ b/arch/alpha/Kconfig.debug
@@ -1,7 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-menu "Kernel hacking"
-
-source "lib/Kconfig.debug"
 
 config EARLY_PRINTK
 	bool
@@ -39,5 +36,3 @@ config MATHEMU
 	  This option is required for IEEE compliant floating point arithmetic
 	  on the Alpha. The only time you would ever not say Y is to say M in
 	  order to debug the code. Say Y unless you know what you are doing.
-
-endmenu
diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index d4a28c45c406..5aab069eba17 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -574,5 +574,4 @@ source "drivers/pci/Kconfig"
 
 endmenu
 
-source "arch/arc/Kconfig.debug"
 source "kernel/power/Kconfig"
diff --git a/arch/arc/Kconfig.debug b/arch/arc/Kconfig.debug
index 03da1a6b3072..45add86decd5 100644
--- a/arch/arc/Kconfig.debug
+++ b/arch/arc/Kconfig.debug
@@ -1,7 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-menu "Kernel hacking"
-
-source "lib/Kconfig.debug"
 
 config 16KSTACKS
 	bool "Use 16Kb for kernel stacks instead of 8Kb"
@@ -11,5 +8,3 @@ config 16KSTACKS
 	  This increases the resident kernel footprint and will cause less
 	  threads to run on the system and also increase the pressure
 	  on the VM subsystem for higher order allocations.
-
-endmenu
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 37fd7565a928..9e45e296e581 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -2189,8 +2189,6 @@ endmenu
 
 source "drivers/firmware/Kconfig"
 
-source "arch/arm/Kconfig.debug"
-
 if CRYPTO
 source "arch/arm/crypto/Kconfig"
 endif
diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 693f84392f1b..b48dc083d1b1 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -1,7 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-menu "Kernel hacking"
-
-source "lib/Kconfig.debug"
 
 config ARM_PTDUMP_CORE
 	def_bool n
@@ -1863,5 +1860,3 @@ config PID_IN_CONTEXTIDR
 	  are planning to use hardware trace tools with this kernel.
 
 source "drivers/hwtracing/coresight/Kconfig"
-
-endmenu
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index fabd797c8645..07d457ec417a 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1321,8 +1321,6 @@ source "drivers/acpi/Kconfig"
 
 source "arch/arm64/kvm/Kconfig"
 
-source "arch/arm64/Kconfig.debug"
-
 if CRYPTO
 source "arch/arm64/crypto/Kconfig"
 endif
diff --git a/arch/arm64/Kconfig.debug b/arch/arm64/Kconfig.debug
index cc6bd559af85..69c9170bdd24 100644
--- a/arch/arm64/Kconfig.debug
+++ b/arch/arm64/Kconfig.debug
@@ -1,6 +1,3 @@
-menu "Kernel hacking"
-
-source "lib/Kconfig.debug"
 
 config ARM64_PTDUMP_CORE
 	def_bool n
@@ -97,5 +94,3 @@ config ARM64_RELOC_TEST
 	tristate "Relocation testing module"
 
 source "drivers/hwtracing/coresight/Kconfig"
-
-endmenu
diff --git a/arch/c6x/Kconfig b/arch/c6x/Kconfig
index 441bbe089b96..904b3375331e 100644
--- a/arch/c6x/Kconfig
+++ b/arch/c6x/Kconfig
@@ -115,18 +115,3 @@ source "kernel/Kconfig.preempt"
 source "kernel/Kconfig.hz"
 
 endmenu
-
-menu "Kernel hacking"
-
-source "lib/Kconfig.debug"
-
-config ACCESS_CHECK
-	bool "Check the user pointer address"
-	default y
-	help
-	  Usually the pointer transfer from user space is checked to see if its
-	  address is in the kernel space.
-
-	  Say N here to disable that check to improve the performance.
-
-endmenu
diff --git a/arch/c6x/Kconfig.debug b/arch/c6x/Kconfig.debug
new file mode 100644
index 000000000000..49edf08813eb
--- /dev/null
+++ b/arch/c6x/Kconfig.debug
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0
+
+config ACCESS_CHECK
+	bool "Check the user pointer address"
+	default y
+	help
+	  Usually the pointer transfer from user space is checked to see if its
+	  address is in the kernel space.
+
+	  Say N here to disable that check to improve the performance.
+
diff --git a/arch/h8300/Kconfig b/arch/h8300/Kconfig
index e23cd887f8f9..c16e7cf732f7 100644
--- a/arch/h8300/Kconfig
+++ b/arch/h8300/Kconfig
@@ -55,9 +55,3 @@ menu "Kernel Features"
 source "kernel/Kconfig.preempt"
 
 endmenu
-
-menu "Kernel hacking"
-
-source "lib/Kconfig.debug"
-
-endmenu
diff --git a/arch/h8300/Kconfig.debug b/arch/h8300/Kconfig.debug
new file mode 100644
index 000000000000..22a162cd99e8
--- /dev/null
+++ b/arch/h8300/Kconfig.debug
@@ -0,0 +1 @@
+# dummy file, do not delete
diff --git a/arch/hexagon/Kconfig b/arch/hexagon/Kconfig
index d2851f46a64b..fcdb6d9fcecc 100644
--- a/arch/hexagon/Kconfig
+++ b/arch/hexagon/Kconfig
@@ -149,7 +149,3 @@ endchoice
 source "kernel/Kconfig.hz"
 
 endmenu
-
-menu "Kernel hacking"
-source "lib/Kconfig.debug"
-endmenu
diff --git a/arch/hexagon/Kconfig.debug b/arch/hexagon/Kconfig.debug
new file mode 100644
index 000000000000..22a162cd99e8
--- /dev/null
+++ b/arch/hexagon/Kconfig.debug
@@ -0,0 +1 @@
+# dummy file, do not delete
diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index 6015d66fa521..34a8d24cffea 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -576,5 +576,3 @@ config MSPEC
 	  If you have an ia64 and you want to enable memory special
 	  operations support (formerly known as fetchop), say Y here,
 	  otherwise say N.
-
-source "arch/ia64/Kconfig.debug"
diff --git a/arch/ia64/Kconfig.debug b/arch/ia64/Kconfig.debug
index 677c409425df..1371efc9b005 100644
--- a/arch/ia64/Kconfig.debug
+++ b/arch/ia64/Kconfig.debug
@@ -1,7 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-menu "Kernel hacking"
-
-source "lib/Kconfig.debug"
 
 choice
 	prompt "Physical memory granularity"
@@ -56,5 +53,3 @@ config IA64_DEBUG_IRQ
 	  Selecting this option turns on bug checking for the IA-64 irq_save
 	  and restore instructions.  It's useful for tracking down spinlock
 	  problems, but slow!  If you're unsure, select N.
-
-endmenu
diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index f76fb7bb371f..cf41ad45513f 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -147,5 +147,3 @@ endmenu
 endif
 
 source "arch/m68k/Kconfig.devices"
-
-source "arch/m68k/Kconfig.debug"
diff --git a/arch/m68k/Kconfig.debug b/arch/m68k/Kconfig.debug
index 04690b179a6e..f43643111eaf 100644
--- a/arch/m68k/Kconfig.debug
+++ b/arch/m68k/Kconfig.debug
@@ -1,7 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-menu "Kernel hacking"
-
-source "lib/Kconfig.debug"
 
 config BOOTPARAM
 	bool 'Compiled-in Kernel Boot Parameter'
@@ -51,5 +48,3 @@ config BDM_DISABLE
 	  Disable the ColdFire CPU's BDM signals.
 
 endif
-
-endmenu
diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
index 3a427ae82ede..ee7bb1002e27 100644
--- a/arch/microblaze/Kconfig
+++ b/arch/microblaze/Kconfig
@@ -287,5 +287,3 @@ config PCI_XILINX
 source "drivers/pci/Kconfig"
 
 endmenu
-
-source "arch/microblaze/Kconfig.debug"
diff --git a/arch/microblaze/Kconfig.debug b/arch/microblaze/Kconfig.debug
index 93a737c8d1a6..dc2e3c45e8a2 100644
--- a/arch/microblaze/Kconfig.debug
+++ b/arch/microblaze/Kconfig.debug
@@ -1,11 +1,5 @@
 # For a description of the syntax of this configuration file,
 # see Documentation/kbuild/kconfig-language.txt.
 
-menu "Kernel hacking"
-
 config TRACE_IRQFLAGS_SUPPORT
 	def_bool y
-
-source "lib/Kconfig.debug"
-
-endmenu
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index f586a3259f7f..ab02824c3976 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -3195,6 +3195,4 @@ endmenu
 
 source "drivers/firmware/Kconfig"
 
-source "arch/mips/Kconfig.debug"
-
 source "arch/mips/kvm/Kconfig"
diff --git a/arch/mips/Kconfig.debug b/arch/mips/Kconfig.debug
index 0749c3724543..0c86b2a2adfc 100644
--- a/arch/mips/Kconfig.debug
+++ b/arch/mips/Kconfig.debug
@@ -1,12 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0
-menu "Kernel hacking"
 
 config TRACE_IRQFLAGS_SUPPORT
 	bool
 	default y
 
-source "lib/Kconfig.debug"
-
 config EARLY_PRINTK
 	bool "Early printk" if EXPERT
 	depends on SYS_HAS_EARLY_PRINTK
@@ -155,5 +152,3 @@ config MIPS_CPS_NS16550_SHIFT
 	  adjacent ns16550 registers in the system.
 
 endif # MIPS_CPS_NS16550_BOOL
-
-endmenu
diff --git a/arch/nds32/Kconfig b/arch/nds32/Kconfig
index a9c6d25a14f0..c03d0e5a591b 100644
--- a/arch/nds32/Kconfig
+++ b/arch/nds32/Kconfig
@@ -91,7 +91,3 @@ menu "Kernel Features"
 source "kernel/Kconfig.preempt"
 source "kernel/Kconfig.hz"
 endmenu
-
-menu "Kernel hacking"
-source "lib/Kconfig.debug"
-endmenu
diff --git a/arch/nds32/Kconfig.debug b/arch/nds32/Kconfig.debug
new file mode 100644
index 000000000000..22a162cd99e8
--- /dev/null
+++ b/arch/nds32/Kconfig.debug
@@ -0,0 +1 @@
+# dummy file, do not delete
diff --git a/arch/nios2/Kconfig b/arch/nios2/Kconfig
index 5e139f2e6b7b..2c52ca71f4df 100644
--- a/arch/nios2/Kconfig
+++ b/arch/nios2/Kconfig
@@ -189,5 +189,3 @@ config NIOS2_IO_REGION_BASE
 	default "0xe0000000"
 
 endmenu
-
-source "arch/nios2/Kconfig.debug"
diff --git a/arch/nios2/Kconfig.debug b/arch/nios2/Kconfig.debug
index edfeef049a51..7a49f0d28d14 100644
--- a/arch/nios2/Kconfig.debug
+++ b/arch/nios2/Kconfig.debug
@@ -1,11 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
-menu "Kernel hacking"
 
 config TRACE_IRQFLAGS_SUPPORT
 	def_bool y
 
-source "lib/Kconfig.debug"
-
 config DEBUG_STACK_USAGE
 	bool "Enable stack utilization instrumentation"
 	depends on DEBUG_KERNEL
@@ -24,5 +21,3 @@ config EARLY_PRINTK
 	  This is useful for kernel debugging when your machine crashes very
 	  early before the console code is initialized.
 	  You should normally say N here, unless you want to debug such a crash.
-
-endmenu
diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
index eb9f503c8972..c52cecd94d62 100644
--- a/arch/openrisc/Kconfig
+++ b/arch/openrisc/Kconfig
@@ -201,9 +201,3 @@ config OPENRISC_ESR_EXCEPTION_BUG_CHECK
 endmenu
 
 endmenu
-
-menu "Kernel hacking"
-
-source "lib/Kconfig.debug"
-
-endmenu
diff --git a/arch/openrisc/Kconfig.debug b/arch/openrisc/Kconfig.debug
new file mode 100644
index 000000000000..22a162cd99e8
--- /dev/null
+++ b/arch/openrisc/Kconfig.debug
@@ -0,0 +1 @@
+# dummy file, do not delete
diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
index 64b832a19bdf..d1dd56ea297b 100644
--- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -349,8 +349,6 @@ endmenu
 
 source "drivers/parisc/Kconfig"
 
-source "arch/parisc/Kconfig.debug"
-
 config SECCOMP
 	def_bool y
 	prompt "Enable seccomp to safely compute untrusted bytecode"
diff --git a/arch/parisc/Kconfig.debug b/arch/parisc/Kconfig.debug
index fb3507f9b14a..1478ded0e247 100644
--- a/arch/parisc/Kconfig.debug
+++ b/arch/parisc/Kconfig.debug
@@ -1,9 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-menu "Kernel hacking"
-
-source "lib/Kconfig.debug"
 
 config TRACE_IRQFLAGS_SUPPORT
 	def_bool y
-
-endmenu
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 131132f161e5..c55e61302d57 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -1194,8 +1194,6 @@ endif
 config	ARCH_RANDOM
 	def_bool n
 
-source "arch/powerpc/Kconfig.debug"
-
 config PPC_LIB_RHEAP
 	bool
 
diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
index c45424c64e19..fd63cd914a74 100644
--- a/arch/powerpc/Kconfig.debug
+++ b/arch/powerpc/Kconfig.debug
@@ -1,7 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-menu "Kernel hacking"
-
-source "lib/Kconfig.debug"
 
 config PPC_DISABLE_WERROR
 	bool "Don't build arch/powerpc code with -Werror"
@@ -379,5 +376,3 @@ config PPC_FAST_ENDIAN_SWITCH
         depends on DEBUG_KERNEL && PPC_BOOK3S_64
         help
 	  If you're unsure what this is, say N.
-
-endmenu
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 558ca3de0614..19208cef5bde 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -244,48 +244,3 @@ menu "Power management options"
 source kernel/power/Kconfig
 
 endmenu
-
-menu "Kernel hacking"
-
-config CMDLINE_BOOL
-	bool "Built-in kernel command line"
-	help
-	  For most platforms, it is firmware or second stage bootloader
-	  that by default specifies the kernel command line options.
-	  However, it might be necessary or advantageous to either override
-	  the default kernel command line or add a few extra options to it.
-	  For such cases, this option allows hardcoding command line options
-	  directly into the kernel.
-
-	  For that, choose 'Y' here and fill in the extra boot parameters
-	  in CONFIG_CMDLINE.
-
-	  The built-in options will be concatenated to the default command
-	  line if CMDLINE_FORCE is set to 'N'. Otherwise, the default
-	  command line will be ignored and replaced by the built-in string.
-
-config CMDLINE
-	string "Built-in kernel command string"
-	depends on CMDLINE_BOOL
-	default ""
-	help
-	  Supply command-line options at build time by entering them here.
-
-config CMDLINE_FORCE
-	bool "Built-in command line overrides bootloader arguments"
-	depends on CMDLINE_BOOL
-	help
-	  Set this option to 'Y' to have the kernel ignore the bootloader
-	  or firmware command line.  Instead, the built-in command line
-	  will be used exclusively.
-
-	  If you don't know what to do here, say N.
-
-config EARLY_PRINTK
-	def_bool y
-
-source "lib/Kconfig.debug"
-
-config CMDLINE_BOOL
-	bool
-endmenu
diff --git a/arch/riscv/Kconfig.debug b/arch/riscv/Kconfig.debug
new file mode 100644
index 000000000000..3224ff6ecf6e
--- /dev/null
+++ b/arch/riscv/Kconfig.debug
@@ -0,0 +1,37 @@
+
+config CMDLINE_BOOL
+	bool "Built-in kernel command line"
+	help
+	  For most platforms, it is firmware or second stage bootloader
+	  that by default specifies the kernel command line options.
+	  However, it might be necessary or advantageous to either override
+	  the default kernel command line or add a few extra options to it.
+	  For such cases, this option allows hardcoding command line options
+	  directly into the kernel.
+
+	  For that, choose 'Y' here and fill in the extra boot parameters
+	  in CONFIG_CMDLINE.
+
+	  The built-in options will be concatenated to the default command
+	  line if CMDLINE_FORCE is set to 'N'. Otherwise, the default
+	  command line will be ignored and replaced by the built-in string.
+
+config CMDLINE
+	string "Built-in kernel command string"
+	depends on CMDLINE_BOOL
+	default ""
+	help
+	  Supply command-line options at build time by entering them here.
+
+config CMDLINE_FORCE
+	bool "Built-in command line overrides bootloader arguments"
+	depends on CMDLINE_BOOL
+	help
+	  Set this option to 'Y' to have the kernel ignore the bootloader
+	  or firmware command line.  Instead, the built-in command line
+	  will be used exclusively.
+
+	  If you don't know what to do here, say N.
+
+config EARLY_PRINTK
+	def_bool y
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index d35bbded1afd..6676f1868e61 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -827,8 +827,6 @@ config HAVE_PNETID
 	tristate
 	default (SMC || CCWGROUP)
 
-source "arch/s390/Kconfig.debug"
-
 menu "Virtualization"
 
 config PFAULT
diff --git a/arch/s390/Kconfig.debug b/arch/s390/Kconfig.debug
index 2cfdfbf8d320..190527560b2c 100644
--- a/arch/s390/Kconfig.debug
+++ b/arch/s390/Kconfig.debug
@@ -1,11 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
-menu "Kernel hacking"
 
 config TRACE_IRQFLAGS_SUPPORT
 	def_bool y
 
-source "lib/Kconfig.debug"
-
 config S390_PTDUMP
 	bool "Export kernel pagetable layout to userspace via debugfs"
 	depends on DEBUG_KERNEL
@@ -20,5 +17,3 @@ config S390_PTDUMP
 
 config EARLY_PRINTK
 	def_bool y
-
-endmenu
diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 7ab7b148181b..b665c54fdda6 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -883,5 +883,3 @@ source "kernel/power/Kconfig"
 source "drivers/cpuidle/Kconfig"
 
 endmenu
-
-source "arch/sh/Kconfig.debug"
diff --git a/arch/sh/Kconfig.debug b/arch/sh/Kconfig.debug
index d0767672640d..010b6c33bbba 100644
--- a/arch/sh/Kconfig.debug
+++ b/arch/sh/Kconfig.debug
@@ -1,11 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
-menu "Kernel hacking"
 
 config TRACE_IRQFLAGS_SUPPORT
 	def_bool y
 
-source "lib/Kconfig.debug"
-
 config SH_STANDARD_BIOS
 	bool "Use LinuxSH standard BIOS"
 	depends on SUPERH32
@@ -88,5 +85,3 @@ config MCOUNT
 	def_bool y
 	depends on SUPERH32
 	depends on STACK_DEBUG || FUNCTION_TRACER
-
-endmenu
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 8a1e44d2e112..622695e8fa44 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -565,5 +565,3 @@ config SYSVIPC_COMPAT
 	default y
 
 source "drivers/sbus/char/Kconfig"
-
-source "arch/sparc/Kconfig.debug"
diff --git a/arch/sparc/Kconfig.debug b/arch/sparc/Kconfig.debug
index 4aef29a11925..50a918d496c8 100644
--- a/arch/sparc/Kconfig.debug
+++ b/arch/sparc/Kconfig.debug
@@ -1,12 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0
-menu "Kernel hacking"
 
 config TRACE_IRQFLAGS_SUPPORT
 	bool
 	default y
 
-source "lib/Kconfig.debug"
-
 config DEBUG_DCFLUSH
 	bool "D-cache flush debugging"
 	depends on SPARC64 && DEBUG_KERNEL
@@ -21,5 +18,3 @@ config FRAME_POINTER
 	bool
 	depends on MCOUNT
 	default y
-
-endmenu
diff --git a/arch/um/Kconfig.debug b/arch/um/Kconfig.debug
index 967d3109689f..2014597605ea 100644
--- a/arch/um/Kconfig.debug
+++ b/arch/um/Kconfig.debug
@@ -1,7 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-menu "Kernel hacking"
-
-source "lib/Kconfig.debug"
 
 config GPROF
 	bool "Enable gprof support"
@@ -37,5 +34,3 @@ config EARLY_PRINTK
 
 	  This is useful for kernel debugging when your machine crashes very
 	  early before the console code is initialized.
-
-endmenu
diff --git a/arch/um/Kconfig.rest b/arch/um/Kconfig.rest
index 08327b9c0cbe..80eac4e3a056 100644
--- a/arch/um/Kconfig.rest
+++ b/arch/um/Kconfig.rest
@@ -1,22 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-source "init/Kconfig"
-
-source "kernel/Kconfig.freezer"
-
 source "arch/um/Kconfig.char"
 
-source "drivers/Kconfig"
-
-source "net/Kconfig"
-
 source "arch/um/Kconfig.net"
-
-source "fs/Kconfig"
-
-source "security/Kconfig"
-
-source "crypto/Kconfig"
-
-source "lib/Kconfig"
-
-source "arch/um/Kconfig.debug"
diff --git a/arch/unicore32/Kconfig b/arch/unicore32/Kconfig
index 7fa7e61eb19f..6bfaa4a910e1 100644
--- a/arch/unicore32/Kconfig
+++ b/arch/unicore32/Kconfig
@@ -222,5 +222,3 @@ endmenu
 endif
 
 endif
-
-source "arch/unicore32/Kconfig.debug"
diff --git a/arch/unicore32/Kconfig.debug b/arch/unicore32/Kconfig.debug
index de8dae3abc0a..ca0ff97657ef 100644
--- a/arch/unicore32/Kconfig.debug
+++ b/arch/unicore32/Kconfig.debug
@@ -1,7 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-menu "Kernel hacking"
-
-source "lib/Kconfig.debug"
 
 config EARLY_PRINTK
 	def_bool DEBUG_OCD
@@ -30,5 +27,3 @@ config DEBUG_OCD
 	help
 	  Say Y here if you want the debug print routines to direct their
 	  output to the UniCore On-Chip-Debugger channel using CP #1.
-
-endmenu
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 6faefd1c9f13..41d28b430fef 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2931,6 +2931,4 @@ config HAVE_GENERIC_GUP
 
 source "drivers/firmware/Kconfig"
 
-source "arch/x86/Kconfig.debug"
-
 source "arch/x86/kvm/Kconfig"
diff --git a/arch/x86/Kconfig.debug b/arch/x86/Kconfig.debug
index c6dd1d980081..7d68f0c7cfb1 100644
--- a/arch/x86/Kconfig.debug
+++ b/arch/x86/Kconfig.debug
@@ -1,11 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
-menu "Kernel hacking"
 
 config TRACE_IRQFLAGS_SUPPORT
 	def_bool y
 
-source "lib/Kconfig.debug"
-
 config EARLY_PRINTK_USB
 	bool
 
@@ -410,5 +407,3 @@ endchoice
 config FRAME_POINTER
 	depends on !UNWINDER_ORC && !UNWINDER_GUESS
 	bool
-
-endmenu
diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index d8bac8be3a33..aae0e1800be7 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -567,5 +567,3 @@ menu "Power management options"
 source "kernel/power/Kconfig"
 
 endmenu
-
-source "arch/xtensa/Kconfig.debug"
diff --git a/arch/xtensa/Kconfig.debug b/arch/xtensa/Kconfig.debug
index f64c14adadb3..39de98e20018 100644
--- a/arch/xtensa/Kconfig.debug
+++ b/arch/xtensa/Kconfig.debug
@@ -1,7 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-menu "Kernel hacking"
-
-source "lib/Kconfig.debug"
 
 config DEBUG_TLB_SANITY
 	bool "Debug TLB sanity"
@@ -34,5 +31,3 @@ config S32C1I_SELFTEST
 	  It is easy to make wrong hardware configuration, this test should catch it early.
 
 	  Say 'N' on stable hardware.
-
-endmenu
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 8838d1158d19..26d3ff7e3cf4 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1,3 +1,5 @@
+menu "Kernel hacking"
+
 menu "printk and dmesg options"
 
 config PRINTK_TIME
@@ -2034,3 +2036,7 @@ config IO_STRICT_DEVMEM
 	  if the driver using a given range cannot be disabled.
 
 	  If in doubt, say Y.
+
+source "arch/$(SRCARCH)/Kconfig.debug"
+
+endmenu # Kernel hacking
-- 
2.18.0


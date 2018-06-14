Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 63F81C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 10:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E354208E2
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 10:38:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="o8SuLLz+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E354208E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935837AbeFNKiH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 06:38:07 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:43053 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754857AbeFNKha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 06:37:30 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id w5EAaqEh008870;
        Thu, 14 Jun 2018 19:36:54 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com w5EAaqEh008870
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1528972615;
        bh=WjkSWmGFVz1Or8CjS2rLrHRKsrHtmrAAZDuotKOY0fQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o8SuLLz+dgablOl32p4xomx5KVlzGEHZHoo1h8/OMTwqVwNpmONo0myAelgUnMrrO
         dPd1fl3KRc4d/wJZczTGCA3xGnTgsgcemwUzrNkzseofeTvJDjX6pO/r13yLKsSUXe
         hr3wcO9aMXjiJsK2adlcL5MfizTTmKdMIhvkjmfuOIYq2w/tbaFfQ2xf4E/42m4+ay
         vmgnh5bDjILuNL2WzGN1tQ6/LSzFFMavkBSSqgohhpG3cl4wXUz7byh/nhHYjqJK2T
         Ww9sSfvnahk3coMTrUD8kYVCZjr46G6PhHoABrl77fXPuLMjiSCbcDVinNhBKexhcX
         A/vBA/JeBiIfg==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 3/3] Kbuild: rename HAVE_CC_STACKPROTECTOR config variable
Date:   Thu, 14 Jun 2018 19:36:45 +0900
Message-Id: <1528972605-24264-4-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528972605-24264-1-git-send-email-yamada.masahiro@socionext.com>
References: <1528972605-24264-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HAVE_CC_STACKPROTECTOR should be selected by architectures with
stack canary implementation.  It is not about the compiler support.

For the consistency with commit 050e9baa9dc9 ("Kbuild: rename
CC_STACKPROTECTOR[_STRONG] config variables"), remove 'CC_'
from the config symbol.

I moved the 'select' lines to keep the alphabetical sorting.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Documentation/features/debug/stackprotector/arch-support.txt | 2 +-
 arch/Kconfig                                                 | 4 ++--
 arch/arm/Kconfig                                             | 2 +-
 arch/arm64/Kconfig                                           | 2 +-
 arch/mips/Kconfig                                            | 2 +-
 arch/sh/Kconfig                                              | 2 +-
 arch/x86/Kconfig                                             | 2 +-
 arch/xtensa/Kconfig                                          | 2 +-
 8 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/features/debug/stackprotector/arch-support.txt b/Documentation/features/debug/stackprotector/arch-support.txt
index 74b89a9..954ac1c 100644
--- a/Documentation/features/debug/stackprotector/arch-support.txt
+++ b/Documentation/features/debug/stackprotector/arch-support.txt
@@ -1,6 +1,6 @@
 #
 # Feature name:          stackprotector
-#         Kconfig:       HAVE_CC_STACKPROTECTOR
+#         Kconfig:       HAVE_STACKPROTECTOR
 #         description:   arch supports compiler driven stack overflow protection
 #
     -----------------------
diff --git a/arch/Kconfig b/arch/Kconfig
index c302b3d..47b235d 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -549,7 +549,7 @@ config GCC_PLUGIN_RANDSTRUCT_PERFORMANCE
 	  in structures.  This reduces the performance hit of RANDSTRUCT
 	  at the cost of weakened randomization.
 
-config HAVE_CC_STACKPROTECTOR
+config HAVE_STACKPROTECTOR
 	bool
 	help
 	  An arch should select this symbol if:
@@ -560,7 +560,7 @@ config CC_HAS_STACKPROTECTOR_NONE
 
 config STACKPROTECTOR
 	bool "Stack Protector buffer overflow detection"
-	depends on HAVE_CC_STACKPROTECTOR
+	depends on HAVE_STACKPROTECTOR
 	depends on $(cc-option,-fstack-protector)
 	default y
 	help
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 2a78bde..0be4397 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -57,7 +57,6 @@ config ARM
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_ARM_SMCCC if CPU_V7
 	select HAVE_EBPF_JIT if !CPU_ENDIAN_BE32
-	select HAVE_CC_STACKPROTECTOR
 	select HAVE_CONTEXT_TRACKING
 	select HAVE_C_RECORDMCOUNT
 	select HAVE_DEBUG_KMEMLEAK
@@ -92,6 +91,7 @@ config ARM
 	select HAVE_RCU_TABLE_FREE if (SMP && ARM_LPAE)
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_RSEQ
+	select HAVE_STACKPROTECTOR
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_UID16
 	select HAVE_VIRT_CPU_ACCOUNTING_GEN
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 14f204c..42c090c 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -103,7 +103,6 @@ config ARM64
 	select HAVE_ARM_SMCCC
 	select HAVE_EBPF_JIT
 	select HAVE_C_RECORDMCOUNT
-	select HAVE_CC_STACKPROTECTOR
 	select HAVE_CMPXCHG_DOUBLE
 	select HAVE_CMPXCHG_LOCAL
 	select HAVE_CONTEXT_TRACKING
@@ -128,6 +127,7 @@ config ARM64
 	select HAVE_PERF_USER_STACK_DUMP
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_RCU_TABLE_FREE
+	select HAVE_STACKPROTECTOR
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_KPROBES
 	select HAVE_KRETPROBES
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index fe98e45..3f9deec 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -41,7 +41,6 @@ config MIPS
 	select HAVE_ARCH_TRANSPARENT_HUGEPAGE if CPU_SUPPORTS_HUGEPAGES && 64BIT
 	select HAVE_CBPF_JIT if (!64BIT && !CPU_MICROMIPS)
 	select HAVE_EBPF_JIT if (64BIT && !CPU_MICROMIPS)
-	select HAVE_CC_STACKPROTECTOR
 	select HAVE_CONTEXT_TRACKING
 	select HAVE_COPY_THREAD_TLS
 	select HAVE_C_RECORDMCOUNT
@@ -66,6 +65,7 @@ config MIPS
 	select HAVE_OPROFILE
 	select HAVE_PERF_EVENTS
 	select HAVE_REGS_AND_STACK_ACCESS_API
+	select HAVE_STACKPROTECTOR
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_VIRT_CPU_ACCOUNTING_GEN if 64BIT || !SMP
 	select IRQ_FORCED_THREADING
diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 4d61a08..4bedd1c 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -77,7 +77,7 @@ config SUPERH32
 	select PERF_EVENTS
 	select ARCH_HIBERNATION_POSSIBLE if MMU
 	select SPARSE_IRQ
-	select HAVE_CC_STACKPROTECTOR
+	select HAVE_STACKPROTECTOR
 
 config SUPERH64
 	def_bool "$(ARCH)" = "sh64"
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index d6c6ee6..f1dbb4e 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -130,7 +130,6 @@ config X86
 	select HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD if X86_64
 	select HAVE_ARCH_VMAP_STACK		if X86_64
 	select HAVE_ARCH_WITHIN_STACK_FRAMES
-	select HAVE_CC_STACKPROTECTOR		if CC_HAS_SANE_STACKPROTECTOR
 	select HAVE_CMPXCHG_DOUBLE
 	select HAVE_CMPXCHG_LOCAL
 	select HAVE_CONTEXT_TRACKING		if X86_64
@@ -182,6 +181,7 @@ config X86
 	select HAVE_RCU_TABLE_FREE
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_RELIABLE_STACKTRACE		if X86_64 && UNWINDER_FRAME_POINTER && STACK_VALIDATION
+	select HAVE_STACKPROTECTOR		if CC_HAS_SANE_STACKPROTECTOR
 	select HAVE_STACK_VALIDATION		if X86_64
 	select HAVE_RSEQ
 	select HAVE_SYSCALL_TRACEPOINTS
diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index 17df3322..d575e87 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -17,7 +17,6 @@ config XTENSA
 	select GENERIC_SCHED_CLOCK
 	select GENERIC_STRNCPY_FROM_USER if KASAN
 	select HAVE_ARCH_KASAN if MMU
-	select HAVE_CC_STACKPROTECTOR
 	select HAVE_DEBUG_KMEMLEAK
 	select HAVE_DMA_CONTIGUOUS
 	select HAVE_EXIT_THREAD
@@ -28,6 +27,7 @@ config XTENSA
 	select HAVE_MEMBLOCK
 	select HAVE_OPROFILE
 	select HAVE_PERF_EVENTS
+	select HAVE_STACKPROTECTOR
 	select IRQ_DOMAIN
 	select MODULES_USE_ELF_RELA
 	select NO_BOOTMEM
-- 
2.7.4


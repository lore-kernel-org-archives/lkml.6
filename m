Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE70C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E111920832
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:20:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E111920832
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbeK2BWH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 20:22:07 -0500
Received: from terminus.zytor.com ([198.137.202.136]:59095 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728031AbeK2BWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 20:22:06 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wASEItTI2320436
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 28 Nov 2018 06:18:55 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wASEItrQ2320433;
        Wed, 28 Nov 2018 06:18:55 -0800
Date:   Wed, 28 Nov 2018 06:18:55 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Zhenzhong Duan <tipbot@zytor.com>
Message-ID: <tip-4cd24de3a0980bf3100c9dcb08ef65ca7c31af48@git.kernel.org>
Cc:     dwmw@amazon.co.uk, luto@kernel.org, srinivas.eeda@oracle.com,
        linux-kernel@vger.kernel.org, zhenzhong.duan@oracle.com,
        yamada.masahiro@socionext.com, hpa@zytor.com,
        michal.lkml@markovi.net, konrad.wilk@oracle.com,
        peterz@infradead.org, tglx@linutronix.de, mingo@kernel.org,
        daniel@iogearbox.net, bp@suse.de
Reply-To: srinivas.eeda@oracle.com, linux-kernel@vger.kernel.org,
          dwmw@amazon.co.uk, luto@kernel.org, tglx@linutronix.de,
          peterz@infradead.org, mingo@kernel.org, daniel@iogearbox.net,
          bp@suse.de, zhenzhong.duan@oracle.com,
          yamada.masahiro@socionext.com, michal.lkml@markovi.net,
          hpa@zytor.com, konrad.wilk@oracle.com
In-Reply-To: <cca0cb20-f9e2-4094-840b-fb0f8810cd34@default>
References: <cca0cb20-f9e2-4094-840b-fb0f8810cd34@default>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/retpoline: Make CONFIG_RETPOLINE depend on
 compiler support
Git-Commit-ID: 4cd24de3a0980bf3100c9dcb08ef65ca7c31af48
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

Commit-ID:  4cd24de3a0980bf3100c9dcb08ef65ca7c31af48
Gitweb:     https://git.kernel.org/tip/4cd24de3a0980bf3100c9dcb08ef65ca7c31af48
Author:     Zhenzhong Duan <zhenzhong.duan@oracle.com>
AuthorDate: Fri, 2 Nov 2018 01:45:41 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 28 Nov 2018 11:57:03 +0100

x86/retpoline: Make CONFIG_RETPOLINE depend on compiler support

Since retpoline capable compilers are widely available, make
CONFIG_RETPOLINE hard depend on the compiler capability.

Break the build when CONFIG_RETPOLINE is enabled and the compiler does not
support it. Emit an error message in that case:

 "arch/x86/Makefile:226: *** You are building kernel with non-retpoline
  compiler, please update your compiler..  Stop."

[dwmw: Fail the build with non-retpoline compiler]

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Borislav Petkov <bp@suse.de>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Michal Marek <michal.lkml@markovi.net>
Cc: <srinivas.eeda@oracle.com>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/cca0cb20-f9e2-4094-840b-fb0f8810cd34@default


---
 arch/x86/Kconfig                     |  4 ----
 arch/x86/Makefile                    |  5 +++--
 arch/x86/include/asm/nospec-branch.h | 10 ++++++----
 arch/x86/kernel/cpu/bugs.c           |  2 +-
 scripts/Makefile.build               |  2 --
 5 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 9d734f3c8234..b5286ad2a982 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -444,10 +444,6 @@ config RETPOLINE
 	  branches. Requires a compiler with -mindirect-branch=thunk-extern
 	  support for full protection. The kernel may run slower.
 
-	  Without compiler support, at least indirect branches in assembler
-	  code are eliminated. Since this includes the syscall entry path,
-	  it is not entirely pointless.
-
 config INTEL_RDT
 	bool "Intel Resource Director Technology support"
 	depends on X86 && CPU_SUP_INTEL
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 88398fdf8129..f5d7f4134524 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -220,9 +220,10 @@ KBUILD_CFLAGS += -fno-asynchronous-unwind-tables
 
 # Avoid indirect branches in kernel to deal with Spectre
 ifdef CONFIG_RETPOLINE
-ifneq ($(RETPOLINE_CFLAGS),)
-  KBUILD_CFLAGS += $(RETPOLINE_CFLAGS) -DRETPOLINE
+ifeq ($(RETPOLINE_CFLAGS),)
+  $(error You are building kernel with non-retpoline compiler, please update your compiler.)
 endif
+  KBUILD_CFLAGS += $(RETPOLINE_CFLAGS)
 endif
 
 archscripts: scripts_basic
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 80dc14422495..8b09cbb2d52c 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -162,11 +162,12 @@
 	_ASM_PTR " 999b\n\t"					\
 	".popsection\n\t"
 
-#if defined(CONFIG_X86_64) && defined(RETPOLINE)
+#ifdef CONFIG_RETPOLINE
+#ifdef CONFIG_X86_64
 
 /*
- * Since the inline asm uses the %V modifier which is only in newer GCC,
- * the 64-bit one is dependent on RETPOLINE not CONFIG_RETPOLINE.
+ * Inline asm uses the %V modifier which is only in newer GCC
+ * which is ensured when CONFIG_RETPOLINE is defined.
  */
 # define CALL_NOSPEC						\
 	ANNOTATE_NOSPEC_ALTERNATIVE				\
@@ -181,7 +182,7 @@
 	X86_FEATURE_RETPOLINE_AMD)
 # define THUNK_TARGET(addr) [thunk_target] "r" (addr)
 
-#elif defined(CONFIG_X86_32) && defined(CONFIG_RETPOLINE)
+#else /* CONFIG_X86_32 */
 /*
  * For i386 we use the original ret-equivalent retpoline, because
  * otherwise we'll run out of registers. We don't care about CET
@@ -211,6 +212,7 @@
 	X86_FEATURE_RETPOLINE_AMD)
 
 # define THUNK_TARGET(addr) [thunk_target] "rm" (addr)
+#endif
 #else /* No retpoline for C / inline asm */
 # define CALL_NOSPEC "call *%[thunk_target]\n"
 # define THUNK_TARGET(addr) [thunk_target] "rm" (addr)
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index c37e66e493bf..d0108fb6e4dd 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -252,7 +252,7 @@ static void __init spec2_print_if_secure(const char *reason)
 
 static inline bool retp_compiler(void)
 {
-	return __is_defined(RETPOLINE);
+	return __is_defined(CONFIG_RETPOLINE);
 }
 
 static inline bool match_option(const char *arg, int arglen, const char *opt)
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index a8e7ba9f73e8..6a6be9f440cf 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -236,10 +236,8 @@ ifdef CONFIG_GCOV_KERNEL
 objtool_args += --no-unreachable
 endif
 ifdef CONFIG_RETPOLINE
-ifneq ($(RETPOLINE_CFLAGS),)
   objtool_args += --retpoline
 endif
-endif
 
 
 ifdef CONFIG_MODVERSIONS

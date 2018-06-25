Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D19C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 22:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97D2526215
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 22:42:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PSmVWwpU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97D2526215
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964874AbeFYWm0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 18:42:26 -0400
Received: from mail-vk0-f73.google.com ([209.85.213.73]:42977 "EHLO
        mail-vk0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934572AbeFYWmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 18:42:22 -0400
Received: by mail-vk0-f73.google.com with SMTP id g22-v6so2400656vke.9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 15:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=/5GEMgpBLPGWFkcOFJY1LD9yOkW4NWzAJyU8jeRJwgg=;
        b=PSmVWwpUEAmzaxcg5GQHFcz8LiHoM6qG5sgiomGHJEdq9dyHR0n9ipbvBatcJ9ttzz
         LMLiX+RDJsbD/Ac7chrV59sb/fD6ef2cB5iGvY2fZ+RE4wNZnhfTPO3RcM4P2VOCwnXc
         j7LK3WnLRcSL//dF75fJHsxLc6hqIoB+KwaKpBHIIvcIJl3EthuZTt/uCuC9XbXs7Sql
         kixrV+VGn7YPNqEenK+JLHw2XQ2xZFWkTlQneWZad7zzN9ZHMrGQE/sbV53ZghQkevQm
         t0vZa2Bc8pvhser8DW0zHr1s55zJqWXXfv7ztLHIMYmhlA+MjyHArVcOS/XOxNrM5fOR
         AxSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=/5GEMgpBLPGWFkcOFJY1LD9yOkW4NWzAJyU8jeRJwgg=;
        b=oz1MmnOH7rQEnaHFoktMIMMqGbWgG6K4ME2WT9cSLcxWPzqgNJDEclD6CwAOVVP3bq
         TSDPKhI+9ODB3V1MfkvQ58ocvnOhubbHYoR/x022eTfjFuMbwRR9ukM7bRcU/mq62Yuf
         N86/W/AdCHULh/evN3Vo96we6M+aR1nxjMdd9rTm5VleudbEAu4gaVf2Jrnvdu5CGScw
         hHE10uccUxFazONXd5Z234EvdDsr5gYgD5IawccvAKXCPQKR9g3QXTODorHZuYhG+nZT
         GDanfhWFw93ri+F968e4zZywMjbifdkyRr82zKqOJWDTl+4Pd0rNH6BPaUvucLRDa7Zi
         Kosg==
X-Gm-Message-State: APt69E3vyKVaW3l0jl7c8BTAgc2/EdzR0WWSjLNyrObeIyP7pQKGTr7a
        YNd4snCcnAOUkwTwdQHsVUBFUFP2BIS8dg==
X-Google-Smtp-Source: ADUXVKICsvCTvwgOAUuayFgWMU2OYbpWKTAExQ92PbijGBL0Hg97/ezUyQWu0/0GDuOlQw6UtsT6nJuiDKgTRg==
MIME-Version: 1.0
X-Received: by 2002:ab0:1a08:: with SMTP id a8-v6mr6149112uai.96.1529966541238;
 Mon, 25 Jun 2018 15:42:21 -0700 (PDT)
Date:   Mon, 25 Jun 2018 15:39:08 -0700
In-Reply-To: <20180625224014.134829-1-thgarnie@google.com>
Message-Id: <20180625224014.134829-21-thgarnie@google.com>
References: <20180625224014.134829-1-thgarnie@google.com>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
Subject: [PATCH v5 20/27] x86: Support global stack cookie
From:   Thomas Garnier <thgarnie@google.com>
To:     kernel-hardening@lists.openwall.com
Cc:     Thomas Garnier <thgarnie@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Rik van Riel <riel@redhat.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an off-by-default configuration option to use a global stack cookie
instead of the default TLS. This configuration option will only be used
with PIE binaries.

For kernel stack cookie, the compiler uses the mcmodel=kernel to switch
between the fs segment to gs segment. A PIE binary does not use
mcmodel=kernel because it can be relocated anywhere, therefore the
compiler will default to the fs segment register. This is fixed on the
latest version of gcc.

If the segment selector is available, it will be automatically added. If
the automatic configuration was selected, a warning is written and the
global variable stack cookie is used. If a specific stack mode was
selected (regular or strong) and the compiler does not support selecting
the segment register, an error is emitted.

Signed-off-by: Thomas Garnier <thgarnie@google.com>
---
 arch/x86/Kconfig                      | 12 ++++++++++++
 arch/x86/Makefile                     |  9 +++++++++
 arch/x86/entry/entry_32.S             |  3 ++-
 arch/x86/entry/entry_64.S             |  3 ++-
 arch/x86/include/asm/processor.h      |  3 ++-
 arch/x86/include/asm/stackprotector.h | 19 ++++++++++++++-----
 arch/x86/kernel/asm-offsets.c         |  3 ++-
 arch/x86/kernel/asm-offsets_32.c      |  3 ++-
 arch/x86/kernel/asm-offsets_64.c      |  3 ++-
 arch/x86/kernel/cpu/common.c          |  3 ++-
 arch/x86/kernel/head_32.S             |  3 ++-
 arch/x86/kernel/process.c             |  5 +++++
 12 files changed, 56 insertions(+), 13 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index c4d64b19acff..f49725df7109 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2212,6 +2212,18 @@ config RANDOMIZE_MEMORY_PHYSICAL_PADDING
 
 	   If unsure, leave at the default value.
 
+config X86_GLOBAL_STACKPROTECTOR
+	bool "Stack cookie using a global variable"
+	depends on CC_STACKPROTECTOR_AUTO
+	default n
+	---help---
+	   This option turns on the "stack-protector" GCC feature using a global
+	   variable instead of a segment register. It is useful when the
+	   compiler does not support custom segment registers when building a
+	   position independent (PIE) binary.
+
+	   If unsure, say N
+
 config HOTPLUG_CPU
 	bool "Support for hot-pluggable CPUs"
 	depends on SMP
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index a08e82856563..c2c221fd20d7 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -141,6 +141,15 @@ else
         KBUILD_CFLAGS += $(call cc-option,-funit-at-a-time)
 endif
 
+ifdef CONFIG_X86_GLOBAL_STACKPROTECTOR
+        ifeq ($(call cc-option, -mstack-protector-guard=global),)
+                $(error Cannot use CONFIG_X86_GLOBAL_STACKPROTECTOR: \
+                        -mstack-protector-guard=global not supported \
+                        by compiler)
+        endif
+        KBUILD_CFLAGS += -mstack-protector-guard=global
+endif
+
 ifdef CONFIG_X86_X32
 	x32_ld_ok := $(call try-run,\
 			/bin/echo -e '1: .quad 1b' | \
diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 2582881d19ce..4298307c4275 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -239,7 +239,8 @@ ENTRY(__switch_to_asm)
 	movl	%esp, TASK_threadsp(%eax)
 	movl	TASK_threadsp(%edx), %esp
 
-#ifdef CONFIG_STACKPROTECTOR
+#if defined(CONFIG_STACKPROTECTOR) && \
+	!defined(CONFIG_X86_GLOBAL_STACKPROTECTOR)
 	movl	TASK_stack_canary(%edx), %ebx
 	movl	%ebx, PER_CPU_VAR(stack_canary)+stack_canary_offset
 #endif
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 2afd2e2a86db..a603a0505706 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -357,7 +357,8 @@ ENTRY(__switch_to_asm)
 	movq	%rsp, TASK_threadsp(%rdi)
 	movq	TASK_threadsp(%rsi), %rsp
 
-#ifdef CONFIG_STACKPROTECTOR
+#if defined(CONFIG_STACKPROTECTOR) && \
+	!defined(CONFIG_X86_GLOBAL_STACKPROTECTOR)
 	movq	TASK_stack_canary(%rsi), %rbx
 	movq	%rbx, PER_CPU_VAR(irq_stack_union + stack_canary_offset)
 #endif
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 6ee253d279d9..a1979e15621f 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -414,7 +414,8 @@ extern asmlinkage void ignore_sysret(void);
 void save_fsgs_for_kvm(void);
 #endif
 #else	/* X86_64 */
-#ifdef CONFIG_STACKPROTECTOR
+#if defined(CONFIG_STACKPROTECTOR) && \
+	!defined(CONFIG_X86_GLOBAL_STACKPROTECTOR)
 /*
  * Make sure stack canary segment base is cached-aligned:
  *   "For Intel Atom processors, avoid non zero segment base address
diff --git a/arch/x86/include/asm/stackprotector.h b/arch/x86/include/asm/stackprotector.h
index 8ec97a62c245..4e120cf36782 100644
--- a/arch/x86/include/asm/stackprotector.h
+++ b/arch/x86/include/asm/stackprotector.h
@@ -52,6 +52,10 @@
 #define GDT_STACK_CANARY_INIT						\
 	[GDT_ENTRY_STACK_CANARY] = GDT_ENTRY_INIT(0x4090, 0, 0x18),
 
+#ifdef CONFIG_X86_GLOBAL_STACKPROTECTOR
+extern unsigned long __stack_chk_guard;
+#endif
+
 /*
  * Initialize the stackprotector canary value.
  *
@@ -63,7 +67,7 @@ static __always_inline void boot_init_stack_canary(void)
 	u64 canary;
 	u64 tsc;
 
-#ifdef CONFIG_X86_64
+#if defined(CONFIG_X86_64) && !defined(CONFIG_X86_GLOBAL_STACKPROTECTOR)
 	BUILD_BUG_ON(offsetof(union irq_stack_union, stack_canary) != 40);
 #endif
 	/*
@@ -77,17 +81,22 @@ static __always_inline void boot_init_stack_canary(void)
 	canary += tsc + (tsc << 32UL);
 	canary &= CANARY_MASK;
 
+#ifdef CONFIG_X86_GLOBAL_STACKPROTECTOR
+	if (__stack_chk_guard == 0)
+		__stack_chk_guard = canary ?: 1;
+#else /* !CONFIG_X86_GLOBAL_STACKPROTECTOR */
 	current->stack_canary = canary;
 #ifdef CONFIG_X86_64
 	this_cpu_write(irq_stack_union.stack_canary, canary);
-#else
+#else /* CONFIG_X86_32 */
 	this_cpu_write(stack_canary.canary, canary);
 #endif
+#endif
 }
 
 static inline void setup_stack_canary_segment(int cpu)
 {
-#ifdef CONFIG_X86_32
+#if defined(CONFIG_X86_32) && !defined(CONFIG_X86_GLOBAL_STACKPROTECTOR)
 	unsigned long canary = (unsigned long)&per_cpu(stack_canary, cpu);
 	struct desc_struct *gdt_table = get_cpu_gdt_rw(cpu);
 	struct desc_struct desc;
@@ -100,7 +109,7 @@ static inline void setup_stack_canary_segment(int cpu)
 
 static inline void load_stack_canary_segment(void)
 {
-#ifdef CONFIG_X86_32
+#if defined(CONFIG_X86_32) && !defined(CONFIG_X86_GLOBAL_STACKPROTECTOR)
 	asm("mov %0, %%gs" : : "r" (__KERNEL_STACK_CANARY) : "memory");
 #endif
 }
@@ -116,7 +125,7 @@ static inline void setup_stack_canary_segment(int cpu)
 
 static inline void load_stack_canary_segment(void)
 {
-#ifdef CONFIG_X86_32
+#if defined(CONFIG_X86_32) && !defined(CONFIG_X86_GLOBAL_STACKPROTECTOR)
 	asm volatile ("mov %0, %%gs" : : "r" (0));
 #endif
 }
diff --git a/arch/x86/kernel/asm-offsets.c b/arch/x86/kernel/asm-offsets.c
index dcb008c320fe..b303dc639d14 100644
--- a/arch/x86/kernel/asm-offsets.c
+++ b/arch/x86/kernel/asm-offsets.c
@@ -32,7 +32,8 @@
 void common(void) {
 	BLANK();
 	OFFSET(TASK_threadsp, task_struct, thread.sp);
-#ifdef CONFIG_STACKPROTECTOR
+#if defined(CONFIG_STACKPROTECTOR) && \
+	!defined(CONFIG_X86_GLOBAL_STACKPROTECTOR)
 	OFFSET(TASK_stack_canary, task_struct, stack_canary);
 #endif
 
diff --git a/arch/x86/kernel/asm-offsets_32.c b/arch/x86/kernel/asm-offsets_32.c
index a4a3be399f4b..efb92f261c63 100644
--- a/arch/x86/kernel/asm-offsets_32.c
+++ b/arch/x86/kernel/asm-offsets_32.c
@@ -50,7 +50,8 @@ void foo(void)
 	DEFINE(TSS_sysenter_sp0, offsetof(struct cpu_entry_area, tss.x86_tss.sp0) -
 	       offsetofend(struct cpu_entry_area, entry_stack_page.stack));
 
-#ifdef CONFIG_STACKPROTECTOR
+#if defined(CONFIG_STACKPROTECTOR) && \
+	!defined(CONFIG_X86_GLOBAL_STACKPROTECTOR)
 	BLANK();
 	OFFSET(stack_canary_offset, stack_canary, canary);
 #endif
diff --git a/arch/x86/kernel/asm-offsets_64.c b/arch/x86/kernel/asm-offsets_64.c
index b2dcd161f514..7809c50d9afd 100644
--- a/arch/x86/kernel/asm-offsets_64.c
+++ b/arch/x86/kernel/asm-offsets_64.c
@@ -69,7 +69,8 @@ int main(void)
 	OFFSET(TSS_sp1, tss_struct, x86_tss.sp1);
 	BLANK();
 
-#ifdef CONFIG_STACKPROTECTOR
+#if defined(CONFIG_STACKPROTECTOR) && \
+	!defined(CONFIG_X86_GLOBAL_STACKPROTECTOR)
 	DEFINE(stack_canary_offset, offsetof(union irq_stack_union, stack_canary));
 	BLANK();
 #endif
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index eb4cb3efd20e..3d6b99845231 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1602,7 +1602,8 @@ DEFINE_PER_CPU(unsigned long, cpu_current_top_of_stack) =
 	(unsigned long)&init_thread_union + THREAD_SIZE;
 EXPORT_PER_CPU_SYMBOL(cpu_current_top_of_stack);
 
-#ifdef CONFIG_STACKPROTECTOR
+#if defined(CONFIG_STACKPROTECTOR) && \
+	!defined(CONFIG_X86_GLOBAL_STACKPROTECTOR)
 DEFINE_PER_CPU_ALIGNED(struct stack_canary, stack_canary);
 #endif
 
diff --git a/arch/x86/kernel/head_32.S b/arch/x86/kernel/head_32.S
index abe6df15a8fb..37c1d2f2d858 100644
--- a/arch/x86/kernel/head_32.S
+++ b/arch/x86/kernel/head_32.S
@@ -375,7 +375,8 @@ ENDPROC(startup_32_smp)
  */
 __INIT
 setup_once:
-#ifdef CONFIG_STACKPROTECTOR
+#if defined(CONFIG_STACKPROTECTOR) && \
+	!defined(CONFIG_X86_GLOBAL_STACKPROTECTOR)
 	/*
 	 * Configure the stack canary. The linker can't handle this by
 	 * relocation.  Manually set base address in stack canary
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 30ca2d1a9231..ace68dbfedf5 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -87,6 +87,11 @@ EXPORT_PER_CPU_SYMBOL(cpu_tss_rw);
 DEFINE_PER_CPU(bool, __tss_limit_invalid);
 EXPORT_PER_CPU_SYMBOL_GPL(__tss_limit_invalid);
 
+#ifdef CONFIG_X86_GLOBAL_STACKPROTECTOR
+unsigned long __stack_chk_guard __read_mostly;
+EXPORT_SYMBOL(__stack_chk_guard);
+#endif
+
 /*
  * this gets called so that we can store lazy state into memory and copy the
  * current task into the new thread.
-- 
2.18.0.rc2.346.g013aa6912e-goog


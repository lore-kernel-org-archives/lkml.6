Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C12DCC43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66C4420846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:47:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nCJ2q0sL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66C4420846
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932554AbeFTRrh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 13:47:37 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38625 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754573AbeFTRkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 13:40:13 -0400
Received: by mail-wm0-f68.google.com with SMTP id 69-v6so985578wmf.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 10:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hm0660xCwTtY/FFORmspU4e/Kz+GgjyahZ9dlSmOfKY=;
        b=nCJ2q0sLjHMd6k/yQC3Q+wn3AGLdi5OTPzikNJUZgDaWo3wIJRfT4O1tgDGQePOGtq
         Aqp8yLYUYWbjbBpHLU2lC1isxyO0wv5RWxDDwXnzO9RP/mSQhe+nYbKSsX6I1AfU47+n
         kwx//NLDJF3NxaUK23Cqf10mXeine1UuOABiqoBWGlHsULwQ0r74z/kXsSxzfjxgOXK6
         aC69oZCT7HNpQP8c/FjHSt65IMRoXl62ztgEY/MM9bofHYDw+W2hVzimQSTDXgnUV3EC
         AIvDbWO6M1jyvdm19Z66HgNUXCHMeLW9elY7yx5OOgMXKcxlDVDnosO0cmyngXAKLBJb
         1HWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hm0660xCwTtY/FFORmspU4e/Kz+GgjyahZ9dlSmOfKY=;
        b=tUInxhnug68nFiViOKph/Rm6/fWsJof8QjhumjqmitBmv/3RgKFf4Usgzs89P+aH5D
         1AHAtx+6Wn/nDseF2YxJ/BuTP/vkThxDBqKlRCv53rfSJexWuucDM5INF9V7H8KHLfOO
         hF4ePA++5y2tlsH/niFOF8zXgHAJ/HnGTRHoBtyi29eg0W1VQyf/CKXgUlu7G5vRzIPP
         tpThvQhJoYRyJEZT7JWtGz7mz+7DmribQWgh+QPVdN0O+MAqTAVWZs+vUCFK8poc024u
         L9MyOcu16OEeuBCIduXNUMKx+u7XsUU1Bcr0kLDZj+jAGCXvT/Y+WOwZCXigsY1++cNv
         fW7A==
X-Gm-Message-State: APt69E2gLDXMsF866fZ+NpAGILfjK7sDVFCMmJITl3uDnOJomq0OA5Hn
        /f7WfNdZ3NGkVOkIK5fzUgL5LA==
X-Google-Smtp-Source: ADUXVKLcDJPoArUOXvpFmDz8Z9SBcQXrOkfwmNYJCoT1LxrLHUBX8/u7g1AoKUQzs36v6FK6J1+BEA==
X-Received: by 2002:a1c:5582:: with SMTP id j124-v6mr2549670wmb.153.1529516411470;
        Wed, 20 Jun 2018 10:40:11 -0700 (PDT)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:84be:a42a:826d:c530])
        by smtp.gmail.com with ESMTPSA id f18-v6sm4388598wro.1.2018.06.20.10.40.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jun 2018 10:40:10 -0700 (PDT)
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Dave Martin <dave.martin@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Ingo Molnar <mingo@kernel.org>,
        Paul Lawrence <paullawrence@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        kasan-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sparse@vger.kernel.org, linux-mm@kvack.org,
        linux-kbuild@vger.kernel.org
Cc:     Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Jann Horn <jannh@google.com>,
        Mark Brand <markbrand@google.com>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH v3 03/17] khwasan: add CONFIG_KASAN_GENERIC and CONFIG_KASAN_HW
Date:   Wed, 20 Jun 2018 19:39:49 +0200
Message-Id: <641ea2edfdc57d8ca30096699c47fd7360381287.1529515183.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
In-Reply-To: <cover.1529515183.git.andreyknvl@google.com>
References: <cover.1529515183.git.andreyknvl@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit splits the current CONFIG_KASAN config option into two:
1. CONFIG_KASAN_GENERIC, that enables the generic software-only KASAN
   version (the one that exists now);
2. CONFIG_KASAN_HW, that enables KHWASAN.

With CONFIG_KASAN_HW enabled, compiler options are changed to instrument
kernel files wiht -fsantize=hwaddress (except the ones for which
KASAN_SANITIZE := n is set).

Both CONFIG_KASAN_GENERIC and CONFIG_KASAN_HW support both
CONFIG_KASAN_INLINE and CONFIG_KASAN_OUTLINE instrumentation modes.

This commit also adds empty placeholder (for now) implementation of
KHWASAN specific hooks inserted by the compiler and adjusts common hooks
implementation to compile correctly with each of the config options.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 arch/arm64/Kconfig             |  1 +
 include/linux/compiler-clang.h |  5 ++-
 include/linux/compiler-gcc.h   |  4 ++
 include/linux/compiler.h       |  3 +-
 include/linux/kasan.h          | 16 +++++--
 lib/Kconfig.kasan              | 76 ++++++++++++++++++++++++++--------
 mm/kasan/Makefile              |  6 ++-
 mm/kasan/khwasan.c             | 75 +++++++++++++++++++++++++++++++++
 mm/slub.c                      |  2 +-
 scripts/Makefile.kasan         | 27 +++++++++++-
 10 files changed, 187 insertions(+), 28 deletions(-)
 create mode 100644 mm/kasan/khwasan.c

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 42c090cf0292..43d9de526d3a 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -92,6 +92,7 @@ config ARM64
 	select HAVE_ARCH_HUGE_VMAP
 	select HAVE_ARCH_JUMP_LABEL
 	select HAVE_ARCH_KASAN if !(ARM64_16K_PAGES && ARM64_VA_BITS_48)
+	select HAVE_ARCH_KASAN_HW if !(ARM64_16K_PAGES && ARM64_VA_BITS_48)
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_MMAP_RND_BITS
 	select HAVE_ARCH_MMAP_RND_COMPAT_BITS if COMPAT
diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
index 7087446c24c8..6ac1761ff102 100644
--- a/include/linux/compiler-clang.h
+++ b/include/linux/compiler-clang.h
@@ -21,13 +21,16 @@
 #define KASAN_ABI_VERSION 5
 
 /* emulate gcc's __SANITIZE_ADDRESS__ flag */
-#if __has_feature(address_sanitizer)
+#if __has_feature(address_sanitizer) || __has_feature(hwaddress_sanitizer)
 #define __SANITIZE_ADDRESS__
 #endif
 
 #undef __no_sanitize_address
 #define __no_sanitize_address __attribute__((no_sanitize("address")))
 
+#undef __no_sanitize_hwaddress
+#define __no_sanitize_hwaddress __attribute__((no_sanitize("hwaddress")))
+
 /* Clang doesn't have a way to turn it off per-function, yet. */
 #ifdef __noretpoline
 #undef __noretpoline
diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index f1a7492a5cc8..24ca815de84b 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -338,6 +338,10 @@
 #define __no_sanitize_address
 #endif
 
+#if !defined(__no_sanitize_hwaddress)
+#define __no_sanitize_hwaddress	/* gcc doesn't support KHWASAN */
+#endif
+
 /*
  * A trick to suppress uninitialized variable warning without generating any
  * code
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 42506e4d1f53..6439fdd46b4e 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -195,7 +195,8 @@ void __read_once_size(const volatile void *p, void *res, int size)
  * 	https://gcc.gnu.org/bugzilla/show_bug.cgi?id=67368
  * '__maybe_unused' allows us to avoid defined-but-not-used warnings.
  */
-# define __no_kasan_or_inline __no_sanitize_address __maybe_unused
+# define __no_kasan_or_inline __no_sanitize_address __no_sanitize_hwaddress \
+			      __maybe_unused
 #else
 # define __no_kasan_or_inline __always_inline
 #endif
diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index cbdc54543803..6608aa9b35ac 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -45,8 +45,6 @@ void kasan_free_pages(struct page *page, unsigned int order);
 
 void kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
 			slab_flags_t *flags);
-void kasan_cache_shrink(struct kmem_cache *cache);
-void kasan_cache_shutdown(struct kmem_cache *cache);
 
 void kasan_poison_slab(struct page *page);
 void kasan_unpoison_object_data(struct kmem_cache *cache, void *object);
@@ -94,8 +92,6 @@ static inline void kasan_free_pages(struct page *page, unsigned int order) {}
 static inline void kasan_cache_create(struct kmem_cache *cache,
 				      unsigned int *size,
 				      slab_flags_t *flags) {}
-static inline void kasan_cache_shrink(struct kmem_cache *cache) {}
-static inline void kasan_cache_shutdown(struct kmem_cache *cache) {}
 
 static inline void kasan_poison_slab(struct page *page) {}
 static inline void kasan_unpoison_object_data(struct kmem_cache *cache,
@@ -141,4 +137,16 @@ static inline size_t kasan_metadata_size(struct kmem_cache *cache) { return 0; }
 
 #endif /* CONFIG_KASAN */
 
+#ifdef CONFIG_KASAN_GENERIC
+
+void kasan_cache_shrink(struct kmem_cache *cache);
+void kasan_cache_shutdown(struct kmem_cache *cache);
+
+#else /* CONFIG_KASAN_GENERIC */
+
+static inline void kasan_cache_shrink(struct kmem_cache *cache) {}
+static inline void kasan_cache_shutdown(struct kmem_cache *cache) {}
+
+#endif /* CONFIG_KASAN_GENERIC */
+
 #endif /* LINUX_KASAN_H */
diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
index 3d35d062970d..baf2619b7ff4 100644
--- a/lib/Kconfig.kasan
+++ b/lib/Kconfig.kasan
@@ -1,33 +1,73 @@
 config HAVE_ARCH_KASAN
 	bool
 
+config HAVE_ARCH_KASAN_HW
+	bool
+
 if HAVE_ARCH_KASAN
 
 config KASAN
-	bool "KASan: runtime memory debugger"
+	bool "KASAN: runtime memory debugger"
+	help
+	  Enables KASAN (KernelAddressSANitizer) - runtime memory debugger,
+	  designed to find out-of-bounds accesses and use-after-free bugs.
+
+choice
+	prompt "KASAN mode"
+	depends on KASAN
+	default KASAN_GENERIC
+	help
+	  KASAN has two modes: KASAN (a classic version, similar to userspace
+	  ASan, enabled with CONFIG_KASAN_GENERIC) and KHWASAN (a version
+	  based on pointer tagging, only for arm64, similar to userspace
+	  HWASan, enabled with CONFIG_KASAN_HW).
+
+config KASAN_GENERIC
+	bool "KASAN: the generic mode"
 	depends on SLUB || (SLAB && !DEBUG_SLAB)
 	select CONSTRUCTORS
 	select STACKDEPOT
 	help
-	  Enables kernel address sanitizer - runtime memory debugger,
-	  designed to find out-of-bounds accesses and use-after-free bugs.
-	  This is strictly a debugging feature and it requires a gcc version
-	  of 4.9.2 or later. Detection of out of bounds accesses to stack or
-	  global variables requires gcc 5.0 or later.
-	  This feature consumes about 1/8 of available memory and brings about
-	  ~x3 performance slowdown.
+	  Enables the generic mode of KASAN.
+	  This is strictly a debugging feature and it requires a GCC version
+	  of 4.9.2 or later. Detection of out-of-bounds accesses to stack or
+	  global variables requires GCC 5.0 or later.
+	  This mode consumes about 1/8 of available memory at kernel start
+	  and introduces an overhead of ~x1.5 for the rest of the allocations.
+	  The performance slowdown is ~x3.
+	  For better error detection enable CONFIG_STACKTRACE.
+	  Currently CONFIG_KASAN_GENERIC doesn't work with CONFIG_DEBUG_SLAB
+	  (the resulting kernel does not boot).
+
+if HAVE_ARCH_KASAN_HW
+
+config KASAN_HW
+	bool "KHWASAN: the hardware assisted mode"
+	depends on SLUB || (SLAB && !DEBUG_SLAB)
+	select CONSTRUCTORS
+	select STACKDEPOT
+	help
+	  Enabled KHWASAN (KASAN mode based on pointer tagging).
+	  This mode requires Top Byte Ignore support by the CPU and therefore
+	  only supported for arm64.
+	  This feature requires clang revision 330044 or later.
+	  This mode consumes about 1/16 of available memory at kernel start
+	  and introduces an overhead of ~20% for the rest of the allocations.
 	  For better error detection enable CONFIG_STACKTRACE.
-	  Currently CONFIG_KASAN doesn't work with CONFIG_DEBUG_SLAB
+	  Currently CONFIG_KASAN_HW doesn't work with CONFIG_DEBUG_SLAB
 	  (the resulting kernel does not boot).
 
+endif
+
+endchoice
+
 config KASAN_EXTRA
-	bool "KAsan: extra checks"
-	depends on KASAN && DEBUG_KERNEL && !COMPILE_TEST
+	bool "KASAN: extra checks"
+	depends on KASAN_GENERIC && DEBUG_KERNEL && !COMPILE_TEST
 	help
-	  This enables further checks in the kernel address sanitizer, for now
-	  it only includes the address-use-after-scope check that can lead
-	  to excessive kernel stack usage, frame size warnings and longer
-	  compile time.
+	  This enables further checks in KASAN, for now it only includes the
+	  address-use-after-scope check that can lead to excessive kernel
+	  stack usage, frame size warnings and longer compile time.
 	  https://gcc.gnu.org/bugzilla/show_bug.cgi?id=81715 has more
 
 
@@ -52,16 +92,16 @@ config KASAN_INLINE
 	  memory accesses. This is faster than outline (in some workloads
 	  it gives about x2 boost over outline instrumentation), but
 	  make kernel's .text size much bigger.
-	  This requires a gcc version of 5.0 or later.
+	  For CONFIG_KASAN_GENERIC this requires GCC 5.0 or later.
 
 endchoice
 
 config TEST_KASAN
-	tristate "Module for testing kasan for bug detection"
+	tristate "Module for testing KASAN for bug detection"
 	depends on m && KASAN
 	help
 	  This is a test module doing various nasty things like
 	  out of bounds accesses, use after free. It is useful for testing
-	  kernel debugging features like kernel address sanitizer.
+	  kernel debugging features like KASAN.
 
 endif
diff --git a/mm/kasan/Makefile b/mm/kasan/Makefile
index a6df14bffb6b..14955add96d3 100644
--- a/mm/kasan/Makefile
+++ b/mm/kasan/Makefile
@@ -2,6 +2,7 @@
 KASAN_SANITIZE := n
 UBSAN_SANITIZE_common.o := n
 UBSAN_SANITIZE_kasan.o := n
+UBSAN_SANITIZE_khwasan.o := n
 KCOV_INSTRUMENT := n
 
 CFLAGS_REMOVE_kasan.o = -pg
@@ -10,5 +11,8 @@ CFLAGS_REMOVE_kasan.o = -pg
 
 CFLAGS_common.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector)
 CFLAGS_kasan.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector)
+CFLAGS_khwasan.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector)
 
-obj-y := common.o kasan.o report.o kasan_init.o quarantine.o
+obj-$(CONFIG_KASAN) := common.o kasan_init.o report.o
+obj-$(CONFIG_KASAN_GENERIC) += kasan.o quarantine.o
+obj-$(CONFIG_KASAN_HW) += khwasan.o
diff --git a/mm/kasan/khwasan.c b/mm/kasan/khwasan.c
new file mode 100644
index 000000000000..e2c3a7f7fd1f
--- /dev/null
+++ b/mm/kasan/khwasan.c
@@ -0,0 +1,75 @@
+/*
+ * This file contains core KHWASAN code.
+ *
+ * Copyright (c) 2018 Google, Inc.
+ * Author: Andrey Konovalov <andreyknvl@google.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+#define DISABLE_BRANCH_PROFILING
+
+#include <linux/export.h>
+#include <linux/interrupt.h>
+#include <linux/init.h>
+#include <linux/kasan.h>
+#include <linux/kernel.h>
+#include <linux/kmemleak.h>
+#include <linux/linkage.h>
+#include <linux/memblock.h>
+#include <linux/memory.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/printk.h>
+#include <linux/random.h>
+#include <linux/sched.h>
+#include <linux/sched/task_stack.h>
+#include <linux/slab.h>
+#include <linux/stacktrace.h>
+#include <linux/string.h>
+#include <linux/types.h>
+#include <linux/vmalloc.h>
+#include <linux/bug.h>
+
+#include "kasan.h"
+#include "../slab.h"
+
+void check_memory_region(unsigned long addr, size_t size, bool write,
+				unsigned long ret_ip)
+{
+}
+
+#define DEFINE_HWASAN_LOAD_STORE(size)					\
+	void __hwasan_load##size##_noabort(unsigned long addr)		\
+	{								\
+	}								\
+	EXPORT_SYMBOL(__hwasan_load##size##_noabort);			\
+	void __hwasan_store##size##_noabort(unsigned long addr)		\
+	{								\
+	}								\
+	EXPORT_SYMBOL(__hwasan_store##size##_noabort)
+
+DEFINE_HWASAN_LOAD_STORE(1);
+DEFINE_HWASAN_LOAD_STORE(2);
+DEFINE_HWASAN_LOAD_STORE(4);
+DEFINE_HWASAN_LOAD_STORE(8);
+DEFINE_HWASAN_LOAD_STORE(16);
+
+void __hwasan_loadN_noabort(unsigned long addr, unsigned long size)
+{
+}
+EXPORT_SYMBOL(__hwasan_loadN_noabort);
+
+void __hwasan_storeN_noabort(unsigned long addr, unsigned long size)
+{
+}
+EXPORT_SYMBOL(__hwasan_storeN_noabort);
+
+void __hwasan_tag_memory(unsigned long addr, u8 tag, unsigned long size)
+{
+}
+EXPORT_SYMBOL(__hwasan_tag_memory);
diff --git a/mm/slub.c b/mm/slub.c
index a60887938c19..5d1e1dee159b 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2956,7 +2956,7 @@ static __always_inline void slab_free(struct kmem_cache *s, struct page *page,
 		do_slab_free(s, page, head, tail, cnt, addr);
 }
 
-#ifdef CONFIG_KASAN
+#ifdef CONFIG_KASAN_GENERIC
 void ___cache_free(struct kmem_cache *cache, void *x, unsigned long addr)
 {
 	do_slab_free(cache, virt_to_head_page(x), x, NULL, 1, addr);
diff --git a/scripts/Makefile.kasan b/scripts/Makefile.kasan
index 69552a39951d..49c6e056c697 100644
--- a/scripts/Makefile.kasan
+++ b/scripts/Makefile.kasan
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-ifdef CONFIG_KASAN
+ifdef CONFIG_KASAN_GENERIC
 ifdef CONFIG_KASAN_INLINE
 	call_threshold := 10000
 else
@@ -42,6 +42,29 @@ ifdef CONFIG_KASAN_EXTRA
 CFLAGS_KASAN += $(call cc-option, -fsanitize-address-use-after-scope)
 endif
 
-CFLAGS_KASAN_NOSANITIZE := -fno-builtin
+endif
+
+ifdef CONFIG_KASAN_HW
+
+ifdef CONFIG_KASAN_INLINE
+    instrumentation_flags := -mllvm -hwasan-mapping-offset=$(KASAN_SHADOW_OFFSET)
+else
+    instrumentation_flags := -mllvm -hwasan-instrument-with-calls=1
+endif
 
+CFLAGS_KASAN := -fsanitize=kernel-hwaddress \
+		-mllvm -hwasan-instrument-stack=0 \
+		$(instrumentation_flags)
+
+ifeq ($(call cc-option, $(CFLAGS_KASAN) -Werror),)
+    ifneq ($(CONFIG_COMPILE_TEST),y)
+        $(warning Cannot use CONFIG_KASAN_HW: \
+            -fsanitize=hwaddress is not supported by compiler)
+    endif
+endif
+
+endif
+
+ifdef CONFIG_KASAN
+CFLAGS_KASAN_NOSANITIZE := -fno-builtin
 endif
-- 
2.18.0.rc1.244.gcf134e6275-goog


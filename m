Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74722C43334
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 11:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0209520862
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 11:35:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XLNRmErD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0209520862
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728492AbeH2PcF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 11:32:05 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:54086 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728254AbeH2PcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 11:32:04 -0400
Received: by mail-wm0-f67.google.com with SMTP id b19-v6so4941751wme.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 04:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mPC1QTpjYa89N9Ou1rQHacuwcgon7c20SdDkLma9mEs=;
        b=XLNRmErDpLBhaR+2xjmkMJHtERUQnkLkO5a+oCsPQ1I7lXn8wIGx3FGDTlLddI6eYx
         701O0+Pt/ak5lk0FQnK9L4oTduuUj8JuAcAaSuz8ecVONegRizmMRGR8xb5D74fgRbOL
         O6PsYBdlD1i7zVZUnttLhYJHdLYe5YeKHctqv9uV61PwRnfzPgwdtA/V/AMlAszGW9XZ
         wEj3pLpCppMawv6PS+UhcZ5khv98EnW+3230yvs0eKjitEbYzwIQ3jXpK6Gmih6VQZ9h
         yNDbjp82r8HlP4Xm5/zaBmEKFwdL9vsgRV+sZP4FQdGCm4+oOKb7bqvlWL7exjLFHpQg
         Wo2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mPC1QTpjYa89N9Ou1rQHacuwcgon7c20SdDkLma9mEs=;
        b=U/vHjkLN1HeAyziewfD40n2CD3nLbBmE7hkJj4u4RWKzUdZRBNEDUhYr/sWWAr4jhM
         GrsdzxW9M7/f85T7vY2zsKWcKEPw5GSh23X210rNud+i1to/+mSwZxj5wZfVqNzx9syz
         wTVKbOVSxj+WuGYWNWpohksWTbscTqZtX3dvx1P/WOYKR7yC8aiYRyj7TgzuYh22uNcL
         WdB1OD545zQ4Es82b2B/UeMy3fcVhcgwxFE4/9/jYntK8wsZlMHJxC7bqUWAdsCROV+5
         LozVpM7ZZYwsr0Vk+BcgC1Sr4FHhu6rhZzxyShQ0b8dsBuF8U3B36mVHXUISh2tJAmLA
         KitA==
X-Gm-Message-State: APzg51DuZZ07ot0UrUz9dxHYTrpBiYrNsCysAGGLa/c/X50+entazZkh
        wyuGfEKCSYExylFEglKoazOS6w==
X-Google-Smtp-Source: ANB0Vdba/9/+Z4oI1RcG6EqOmTDFZaDf2YDEDCpFqcujQZw+oxIp6JwGAneRxgMpTlHOu3D4L+IqMg==
X-Received: by 2002:a1c:2dc8:: with SMTP id t191-v6mr4162121wmt.94.1535542532431;
        Wed, 29 Aug 2018 04:35:32 -0700 (PDT)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:84be:a42a:826d:c530])
        by smtp.gmail.com with ESMTPSA id s10-v6sm7800454wmd.22.2018.08.29.04.35.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 04:35:31 -0700 (PDT)
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
        Vishwath Mohan <vishwath@google.com>,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH v6 03/18] khwasan: add CONFIG_KASAN_GENERIC and CONFIG_KASAN_HW
Date:   Wed, 29 Aug 2018 13:35:07 +0200
Message-Id: <868c9168481ff5103034ac1e37b830d28ed5f4ee.1535462971.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0-goog
In-Reply-To: <cover.1535462971.git.andreyknvl@google.com>
References: <cover.1535462971.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 include/linux/compiler-clang.h |  3 +-
 include/linux/compiler-gcc.h   |  4 ++
 include/linux/compiler.h       |  3 +-
 include/linux/kasan.h          | 16 +++++--
 lib/Kconfig.kasan              | 77 ++++++++++++++++++++++++++--------
 mm/kasan/Makefile              |  6 ++-
 mm/kasan/kasan.h               |  3 +-
 mm/kasan/khwasan.c             | 75 +++++++++++++++++++++++++++++++++
 mm/slub.c                      |  2 +-
 scripts/Makefile.kasan         | 27 +++++++++++-
 11 files changed, 188 insertions(+), 29 deletions(-)
 create mode 100644 mm/kasan/khwasan.c

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 29e75b47becd..991564148f54 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -105,6 +105,7 @@ config ARM64
 	select HAVE_ARCH_HUGE_VMAP
 	select HAVE_ARCH_JUMP_LABEL
 	select HAVE_ARCH_KASAN if !(ARM64_16K_PAGES && ARM64_VA_BITS_48)
+	select HAVE_ARCH_KASAN_HW if !(ARM64_16K_PAGES && ARM64_VA_BITS_48)
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_MMAP_RND_BITS
 	select HAVE_ARCH_MMAP_RND_COMPAT_BITS if COMPAT
diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
index b1ce500fe8b3..2c258a9d4c67 100644
--- a/include/linux/compiler-clang.h
+++ b/include/linux/compiler-clang.h
@@ -17,11 +17,12 @@
 #define KASAN_ABI_VERSION 5
 
 /* emulate gcc's __SANITIZE_ADDRESS__ flag */
-#if __has_feature(address_sanitizer)
+#if __has_feature(address_sanitizer) || __has_feature(hwaddress_sanitizer)
 #define __SANITIZE_ADDRESS__
 #endif
 
 #define __no_sanitize_address __attribute__((no_sanitize("address")))
+#define __no_sanitize_hwaddress __attribute__((no_sanitize("hwaddress")))
 
 /*
  * Not all versions of clang implement the the type-generic versions
diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index 763bbad1e258..a186b55c8c4c 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -227,6 +227,10 @@
 #define __no_sanitize_address
 #endif
 
+#if !defined(__no_sanitize_hwaddress)
+#define __no_sanitize_hwaddress	/* gcc doesn't support KHWASAN */
+#endif
+
 /*
  * Turn individual warnings and errors on and off locally, depending
  * on version.
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 681d866efb1e..3f2ba192d57d 100644
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
index 54d577ad2181..beb56a26fe9b 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -45,8 +45,6 @@ void kasan_free_pages(struct page *page, unsigned int order);
 
 void kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
 			slab_flags_t *flags);
-void kasan_cache_shrink(struct kmem_cache *cache);
-void kasan_cache_shutdown(struct kmem_cache *cache);
 
 void kasan_poison_slab(struct page *page);
 void kasan_unpoison_object_data(struct kmem_cache *cache, void *object);
@@ -97,8 +95,6 @@ static inline void kasan_free_pages(struct page *page, unsigned int order) {}
 static inline void kasan_cache_create(struct kmem_cache *cache,
 				      unsigned int *size,
 				      slab_flags_t *flags) {}
-static inline void kasan_cache_shrink(struct kmem_cache *cache) {}
-static inline void kasan_cache_shutdown(struct kmem_cache *cache) {}
 
 static inline void kasan_poison_slab(struct page *page) {}
 static inline void kasan_unpoison_object_data(struct kmem_cache *cache,
@@ -152,4 +148,16 @@ static inline size_t kasan_metadata_size(struct kmem_cache *cache) { return 0; }
 
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
index befb127507c0..5a22629f30e7 100644
--- a/lib/Kconfig.kasan
+++ b/lib/Kconfig.kasan
@@ -1,34 +1,75 @@
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
 	depends on (SLUB && SYSFS) || (SLAB && !DEBUG_SLAB)
 	select SLUB_DEBUG if SLUB
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
 	  For better error detection enable CONFIG_STACKTRACE.
-	  Currently CONFIG_KASAN doesn't work with CONFIG_DEBUG_SLAB
+	  Currently CONFIG_KASAN_GENERIC doesn't work with CONFIG_DEBUG_SLAB
 	  (the resulting kernel does not boot).
 
+if HAVE_ARCH_KASAN_HW
+
+config KASAN_HW
+	bool "KHWASAN: the hardware assisted mode"
+	depends on (SLUB && SYSFS) || (SLAB && !DEBUG_SLAB)
+	select SLUB_DEBUG if SLUB
+	select CONSTRUCTORS
+	select STACKDEPOT
+	help
+	  Enabled KHWASAN (KASAN mode based on pointer tagging).
+	  This mode requires Top Byte Ignore support by the CPU and therefore
+	  only supported for arm64.
+	  This feature requires clang revision 330044 or later.
+	  This mode consumes about 1/16 of available memory at kernel start
+	  and introduces an overhead of ~20% for the rest of the allocations.
+	  For better error detection enable CONFIG_STACKTRACE.
+	  Currently CONFIG_KASAN_HW doesn't work with CONFIG_DEBUG_SLAB
+	  (the resulting kernel does not boot).
+
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
 
 
@@ -53,16 +94,16 @@ config KASAN_INLINE
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
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index 659463800f10..19b950eaccff 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -114,7 +114,8 @@ void kasan_report(unsigned long addr, size_t size,
 		bool is_write, unsigned long ip);
 void kasan_report_invalid_free(void *object, unsigned long ip);
 
-#if defined(CONFIG_SLAB) || defined(CONFIG_SLUB)
+#if defined(CONFIG_KASAN_GENERIC) && \
+	(defined(CONFIG_SLAB) || defined(CONFIG_SLUB))
 void quarantine_put(struct kasan_free_meta *info, struct kmem_cache *cache);
 void quarantine_reduce(void);
 void quarantine_remove_cache(struct kmem_cache *cache);
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
index 30b9bf777bab..4206e1b616e7 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2955,7 +2955,7 @@ static __always_inline void slab_free(struct kmem_cache *s, struct page *page,
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
2.19.0.rc0.228.g281dcd1b4d0-goog


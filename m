Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43CFDC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 19:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3FCD2151B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 19:00:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q67/fJLv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3FCD2151B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731782AbeITAjV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 20:39:21 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38781 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387450AbeITAe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 20:34:27 -0400
Received: by mail-wr1-f68.google.com with SMTP id j8-v6so3141901wrw.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 11:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z1DpyEItVxsft4UDs0uoNYq6KT+yPmp62IEAxvoeP10=;
        b=q67/fJLvxhhQkbBrOp4X3P+0kzwrQ2ubg1Bb+e+UA0pox8eQcanTb2fipIV4iJNR2N
         V/L8OezRsDLE1yEOvLbx3pFGRDCbm3uTkkNEpcVwwVQW838BQ/QNVHumEwbt+isFWKe0
         gZt1AIZZRtLyyP2XVfFgxuZnX0gt/6W3NTz/HzE3Bc0tzsQxa5YwIe8lZmXtf1nTy/Dj
         7tYP8Ib7Xwj868q+moTqmCvrgnMDX/6qMgPCE8tnD29dnhzMZ0lnVzUOCYi/ihhcgPwu
         gfpZu/hrSSLjxGoeOsId1CYUadDuBxSmD59ehnXKBJWK9g1zyn4L2WVMhHKBpPsGe5U7
         VBGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z1DpyEItVxsft4UDs0uoNYq6KT+yPmp62IEAxvoeP10=;
        b=P5a8B1vdMmlBprhbh3lGdIsZjjHMuPU5BH4O0cYwPCOUrS7f+4osSJ5dZJSkhIde91
         Gewv5DsygSjLlPZxW96vIBIO08LTlF7/7lw11zmtWhbEm8IWe0bst6Vv0bgYzzdqvxmF
         /kd8awUjY/VYmTeeY6Z9V14SNAEFM5awfS6EtjeNkxa6XlF8rUEyVkkSFO8nbOP49jNx
         n0bfQfzThBxzVyTEjOn9umehBCuBtP8rANYXhSxy0JqB6IAk3sJdfq2t4SOM8GycNUJC
         RLqgRL4zA2wOSNnYvdYyHlT/AiwepoHjxN+1ixlYfXoPtGTVVS0O7B/bk5fEKuuIkERZ
         dIpg==
X-Gm-Message-State: ABuFfoi7nW/67GMk4UZ6qtieQZcF0nultTnv+uhBk1OEwrWGOeqr2tKv
        rJOeggMOc0aUvJv78RFi4qnf9Q==
X-Google-Smtp-Source: ACcGV617bqixM7ctYqPGVjF0qqFKJ3+6ZMrrndnZeattBF8UGMI788ETzzR2MMrk/noIGv/OTeaq3g==
X-Received: by 2002:adf:e30e:: with SMTP id b14-v6mr359767wrj.158.1537383310437;
        Wed, 19 Sep 2018 11:55:10 -0700 (PDT)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:84be:a42a:826d:c530])
        by smtp.gmail.com with ESMTPSA id b10-v6sm8510065wmc.28.2018.09.19.11.55.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Sep 2018 11:55:09 -0700 (PDT)
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
Subject: [PATCH v8 04/20] kasan: add CONFIG_KASAN_GENERIC and CONFIG_KASAN_SW_TAGS
Date:   Wed, 19 Sep 2018 20:54:43 +0200
Message-Id: <0445e177bfb261d02dae639deefdd1d8ec8aacc2.1537383101.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.19.0.397.gdd90340f6a-goog
In-Reply-To: <cover.1537383101.git.andreyknvl@google.com>
References: <cover.1537383101.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit splits the current CONFIG_KASAN config option into two:
1. CONFIG_KASAN_GENERIC, that enables the generic KASAN mode (the one
   that exists now);
2. CONFIG_KASAN_SW_TAGS, that enables the software tag-based KASAN mode.

The name CONFIG_KASAN_SW_TAGS is chosen as in the future we will have
another hardware tag-based KASAN mode, that will rely on hardware memory
tagging support in arm64.

With CONFIG_KASAN_SW_TAGS enabled, compiler options are changed to
instrument kernel files with -fsantize=kernel-hwaddress (except the ones
for which KASAN_SANITIZE := n is set).

Both CONFIG_KASAN_GENERIC and CONFIG_KASAN_SW_TAGS support both
CONFIG_KASAN_INLINE and CONFIG_KASAN_OUTLINE instrumentation modes.

This commit also adds empty placeholder (for now) implementation of
tag-based KASAN specific hooks inserted by the compiler and adjusts
common hooks implementation to compile correctly with each of the
config options.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 arch/arm64/Kconfig             |  1 +
 include/linux/compiler-clang.h |  5 +-
 include/linux/kasan.h          | 16 +++++--
 lib/Kconfig.kasan              | 87 +++++++++++++++++++++++++++-------
 mm/kasan/Makefile              |  6 ++-
 mm/kasan/generic.c             |  2 +-
 mm/kasan/kasan.h               |  3 +-
 mm/kasan/tags.c                | 75 +++++++++++++++++++++++++++++
 mm/slub.c                      |  2 +-
 scripts/Makefile.kasan         | 27 ++++++++++-
 10 files changed, 194 insertions(+), 30 deletions(-)
 create mode 100644 mm/kasan/tags.c

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 1b1a0e95c751..287c32241b68 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -105,6 +105,7 @@ config ARM64
 	select HAVE_ARCH_HUGE_VMAP
 	select HAVE_ARCH_JUMP_LABEL
 	select HAVE_ARCH_KASAN if !(ARM64_16K_PAGES && ARM64_VA_BITS_48)
+	select HAVE_ARCH_KASAN_SW_TAGS if !(ARM64_16K_PAGES && ARM64_VA_BITS_48)
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_MMAP_RND_BITS
 	select HAVE_ARCH_MMAP_RND_COMPAT_BITS if COMPAT
diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
index b1ce500fe8b3..89ebe58259ba 100644
--- a/include/linux/compiler-clang.h
+++ b/include/linux/compiler-clang.h
@@ -17,11 +17,12 @@
 #define KASAN_ABI_VERSION 5
 
 /* emulate gcc's __SANITIZE_ADDRESS__ flag */
-#if __has_feature(address_sanitizer)
+#if __has_feature(address_sanitizer) || __has_feature(hwaddress_sanitizer)
 #define __SANITIZE_ADDRESS__
 #endif
 
-#define __no_sanitize_address __attribute__((no_sanitize("address")))
+#define __no_sanitize_address	\
+	__attribute__((no_sanitize("address", "hwaddress")))
 
 /*
  * Not all versions of clang implement the the type-generic versions
diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 3b019db87892..f0c96f08f2f1 100644
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
@@ -155,4 +151,16 @@ static inline size_t kasan_metadata_size(struct kmem_cache *cache) { return 0; }
 
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
index befb127507c0..181dfa7f4885 100644
--- a/lib/Kconfig.kasan
+++ b/lib/Kconfig.kasan
@@ -1,35 +1,86 @@
 config HAVE_ARCH_KASAN
 	bool
 
+config HAVE_ARCH_KASAN_SW_TAGS
+	bool
+
 if HAVE_ARCH_KASAN
 
 config KASAN
-	bool "KASan: runtime memory debugger"
+	bool "KASAN: runtime memory debugger"
+	help
+	  Enables KASAN (KernelAddressSANitizer) - runtime memory debugger,
+	  designed to find out-of-bounds accesses and use-after-free bugs.
+	  See Documentation/dev-tools/kasan.rst for details.
+
+choice
+	prompt "KASAN mode"
+	depends on KASAN
+	default KASAN_GENERIC
+	help
+	  KASAN has two modes: generic KASAN (similar to userspace ASan,
+	  x86_64/arm64/xtensa, enabled with CONFIG_KASAN_GENERIC) and
+	  software tag-based KASAN (a version based on software memory
+	  tagging, arm64 only, similar to userspace HWASan, enabled with
+	  CONFIG_KASAN_SW_TAGS).
+	  Both generic and tag-based KASAN are strictly debugging features.
+
+config KASAN_GENERIC
+	bool "Generic mode"
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
+	  Enables generic KASAN mode.
+	  Supported in both GCC and Clang. With GCC it requires version 4.9.2
+	  or later for basic support and version 5.0 or later for detection of
+	  out-of-bounds accesses for stack and global variables and for inline
+	  instrumentation mode (CONFIG_KASAN_INLINE). With Clang it requires
+	  version 3.7.0 or later and it doesn't support detection of
+	  out-of-bounds accesses for global variables yet.
+	  This mode consumes about 1/8th of available memory at kernel start
+	  and introduces an overhead of ~x1.5 for the rest of the allocations.
+	  The performance slowdown is ~x3.
 	  For better error detection enable CONFIG_STACKTRACE.
-	  Currently CONFIG_KASAN doesn't work with CONFIG_DEBUG_SLAB
+	  Currently CONFIG_KASAN_GENERIC doesn't work with CONFIG_DEBUG_SLAB
 	  (the resulting kernel does not boot).
 
+if HAVE_ARCH_KASAN_SW_TAGS
+
+config KASAN_SW_TAGS
+	bool "Software tag-based mode"
+	depends on (SLUB && SYSFS) || (SLAB && !DEBUG_SLAB)
+	select SLUB_DEBUG if SLUB
+	select CONSTRUCTORS
+	select STACKDEPOT
+	help
+	  Enables software tag-based KASAN mode.
+	  This mode requires Top Byte Ignore support by the CPU and therefore
+	  is only supported for arm64.
+	  This mode requires Clang version 7.0.0 or later.
+	  This mode consumes about 1/16th of available memory at kernel start
+	  and introduces an overhead of ~20% for the rest of the allocations.
+	  This mode may potentially introduce problems relating to pointer
+	  casting and comparison, as it embeds tags into the top byte of each
+	  pointer.
+	  For better error detection enable CONFIG_STACKTRACE.
+	  Currently CONFIG_KASAN_SW_TAGS doesn't work with CONFIG_DEBUG_SLAB
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
+	  This enables further checks in generic KASAN, for now it only
+	  includes the address-use-after-scope check that can lead to
+	  excessive kernel stack usage, frame size warnings and longer
 	  compile time.
-	  https://gcc.gnu.org/bugzilla/show_bug.cgi?id=81715 has more
+	  See https://gcc.gnu.org/bugzilla/show_bug.cgi?id=81715
 
 
 choice
@@ -53,16 +104,16 @@ config KASAN_INLINE
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
index d643530b24aa..68ba1822f003 100644
--- a/mm/kasan/Makefile
+++ b/mm/kasan/Makefile
@@ -2,6 +2,7 @@
 KASAN_SANITIZE := n
 UBSAN_SANITIZE_common.o := n
 UBSAN_SANITIZE_generic.o := n
+UBSAN_SANITIZE_tags.o := n
 KCOV_INSTRUMENT := n
 
 CFLAGS_REMOVE_generic.o = -pg
@@ -10,5 +11,8 @@ CFLAGS_REMOVE_generic.o = -pg
 
 CFLAGS_common.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector)
 CFLAGS_generic.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector)
+CFLAGS_tags.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector)
 
-obj-y := common.o generic.o report.o init.o quarantine.o
+obj-$(CONFIG_KASAN) := common.o init.o report.o
+obj-$(CONFIG_KASAN_GENERIC) += generic.o quarantine.o
+obj-$(CONFIG_KASAN_SW_TAGS) += tags.o
diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
index 44ec228de0a2..b8de6d33c55c 100644
--- a/mm/kasan/generic.c
+++ b/mm/kasan/generic.c
@@ -1,5 +1,5 @@
 /*
- * This file contains core KASAN code.
+ * This file contains core generic KASAN code.
  *
  * Copyright (c) 2014 Samsung Electronics Co., Ltd.
  * Author: Andrey Ryabinin <ryabinin.a.a@gmail.com>
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
diff --git a/mm/kasan/tags.c b/mm/kasan/tags.c
new file mode 100644
index 000000000000..04194923c543
--- /dev/null
+++ b/mm/kasan/tags.c
@@ -0,0 +1,75 @@
+/*
+ * This file contains core tag-based KASAN code.
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
index b2172284d421..c4d5f4442ff1 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2954,7 +2954,7 @@ static __always_inline void slab_free(struct kmem_cache *s, struct page *page,
 		do_slab_free(s, page, head, tail, cnt, addr);
 }
 
-#ifdef CONFIG_KASAN
+#ifdef CONFIG_KASAN_GENERIC
 void ___cache_free(struct kmem_cache *cache, void *x, unsigned long addr)
 {
 	do_slab_free(cache, virt_to_head_page(x), x, NULL, 1, addr);
diff --git a/scripts/Makefile.kasan b/scripts/Makefile.kasan
index 69552a39951d..5bf3a808a282 100644
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
+ifdef CONFIG_KASAN_SW_TAGS
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
+        $(warning Cannot use CONFIG_KASAN_SW_TAGS: \
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
2.19.0.397.gdd90340f6a-goog


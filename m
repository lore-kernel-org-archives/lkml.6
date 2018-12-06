Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B0FC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAFCF208E7
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:26:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lYPWD4dz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAFCF208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729930AbeLFM0z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 07:26:55 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40363 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729609AbeLFMZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 07:25:07 -0500
Received: by mail-wr1-f65.google.com with SMTP id p4so287185wrt.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 04:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qsCjCKV+q57Vg4Qo+ex38n8fMkQGTNd9MzBlJ42c62w=;
        b=lYPWD4dzXCyGlWApicPbPWrOJcyzUAMrHRa9ML+WypDuXdVkzJ/cNmx3Tj3z5kn0X+
         wXsJE/+j+Upc/1yIDjCHMrh4af5GeudR6utpq6u2ci47XkTpdttHYOChrnJgRCp1Jes2
         estwO/nvoxmr4u9CJvAs4fwDMRhOR3SASD46MBoLNGjCKdYhlnqD4Qy52vO72QuyB+Fb
         jiSB4eJh3TYn8dAVPZx5dk/WDuwIDlyfcLXcTABmAqAcpqSsx3o3o9xSpKnO97j6yKsd
         ROuu+YVoBACV0QzThJXynS8N/eIMhCvtBaD5xvna4tCWj53zdpp907T0luqWbFsjQUj8
         NWdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qsCjCKV+q57Vg4Qo+ex38n8fMkQGTNd9MzBlJ42c62w=;
        b=nNhhA4u7tJqB7EfAiTqHPWfiaJ29NaGU9HqcwFcNnCF9zj2UCVBbKCoz7KlzaQU0yQ
         X+PiaHRMdnsq7QXMUGEpKY0wVQSD11zMuUgxox081fPBvPjcpKDzD+GzOasW7sOb2ZaN
         p5qu/x/85N9QJxK/U4AV2OdLvhpLW/9heR1jWPqj1IdYxPzTVbL+Wv2egiIbzVUW19Ww
         a1ppcqWi+kOyRNWKMD/qp3Z0FTa31qSSEKeR6N0SLwkV2mpNIK4i8eW/1r5hMkP3x1x5
         3opL8mfSU9ngYAUOkRVy4kRSzsg50NLzr1QhNMTZEtklcirFZy65FGzG56hHHbvliU5E
         afBQ==
X-Gm-Message-State: AA+aEWb9bcWAlCj4zvtH9ECCSC021nWfuB1et5x9xu8N5SBdMa4qm4st
        TvNhSa0AKJgLEK8io/xbVVsHUQ==
X-Google-Smtp-Source: AFSGD/XUku20Jyax7BJye38HG84DVpktJbYsI3QLS0+xkAhyhZ+Y+sA1HXilshs7C7kohJO9GetxgA==
X-Received: by 2002:adf:9591:: with SMTP id p17mr26240808wrp.224.1544099104494;
        Thu, 06 Dec 2018 04:25:04 -0800 (PST)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:3180:41f8:3010:ff61])
        by smtp.gmail.com with ESMTPSA id j8sm339988wrt.40.2018.12.06.04.25.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 04:25:03 -0800 (PST)
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
Subject: [PATCH v13 10/25] kasan: add tag related helper functions
Date:   Thu,  6 Dec 2018 13:24:28 +0100
Message-Id: <f6c6437bb8e143bc44f42c3c259c62e734be7935.1544099024.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.20.0.rc1.387.gf8505762e3-goog
In-Reply-To: <cover.1544099024.git.andreyknvl@google.com>
References: <cover.1544099024.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds a few helper functions, that are meant to be used to
work with tags embedded in the top byte of kernel pointers: to set, to
get or to reset the top byte.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 arch/arm64/include/asm/kasan.h  |  8 +++++--
 arch/arm64/include/asm/memory.h | 12 +++++++++++
 arch/arm64/mm/kasan_init.c      |  2 ++
 include/linux/kasan.h           | 13 ++++++++++++
 mm/kasan/kasan.h                | 31 +++++++++++++++++++++++++++
 mm/kasan/tags.c                 | 37 +++++++++++++++++++++++++++++++++
 6 files changed, 101 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/kasan.h b/arch/arm64/include/asm/kasan.h
index 8758bb008436..b52aacd2c526 100644
--- a/arch/arm64/include/asm/kasan.h
+++ b/arch/arm64/include/asm/kasan.h
@@ -4,12 +4,16 @@
 
 #ifndef __ASSEMBLY__
 
-#ifdef CONFIG_KASAN
-
 #include <linux/linkage.h>
 #include <asm/memory.h>
 #include <asm/pgtable-types.h>
 
+#define arch_kasan_set_tag(addr, tag)	__tag_set(addr, tag)
+#define arch_kasan_reset_tag(addr)	__tag_reset(addr)
+#define arch_kasan_get_tag(addr)	__tag_get(addr)
+
+#ifdef CONFIG_KASAN
+
 /*
  * KASAN_SHADOW_START: beginning of the kernel virtual addresses.
  * KASAN_SHADOW_END: KASAN_SHADOW_START + 1/N of kernel virtual addresses,
diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index e2c9857157f2..83c1366a1233 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -219,6 +219,18 @@ static inline unsigned long kaslr_offset(void)
 #define untagged_addr(addr)	\
 	((__typeof__(addr))sign_extend64((u64)(addr), 55))
 
+#ifdef CONFIG_KASAN_SW_TAGS
+#define __tag_shifted(tag)	((u64)(tag) << 56)
+#define __tag_set(addr, tag)	(__typeof__(addr))( \
+		((u64)(addr) & ~__tag_shifted(0xff)) | __tag_shifted(tag))
+#define __tag_reset(addr)	untagged_addr(addr)
+#define __tag_get(addr)		(__u8)((u64)(addr) >> 56)
+#else
+#define __tag_set(addr, tag)	(addr)
+#define __tag_reset(addr)	(addr)
+#define __tag_get(addr)		0
+#endif
+
 /*
  * Physical vs virtual RAM address space conversion.  These are
  * private definitions which should NOT be used outside memory.h
diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
index 7a4a0904cac8..1df536bdabcb 100644
--- a/arch/arm64/mm/kasan_init.c
+++ b/arch/arm64/mm/kasan_init.c
@@ -253,6 +253,8 @@ void __init kasan_init(void)
 	memset(kasan_early_shadow_page, KASAN_SHADOW_INIT, PAGE_SIZE);
 	cpu_replace_ttbr1(lm_alias(swapper_pg_dir));
 
+	kasan_init_tags();
+
 	/* At this point kasan is fully initialized. Enable error messages */
 	init_task.kasan_depth = 0;
 	pr_info("KernelAddressSanitizer initialized\n");
diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index c56af24bd3e7..a477ce2abdc9 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -169,6 +169,19 @@ static inline void kasan_cache_shutdown(struct kmem_cache *cache) {}
 
 #define KASAN_SHADOW_INIT 0xFF
 
+void kasan_init_tags(void);
+
+void *kasan_reset_tag(const void *addr);
+
+#else /* CONFIG_KASAN_SW_TAGS */
+
+static inline void kasan_init_tags(void) { }
+
+static inline void *kasan_reset_tag(const void *addr)
+{
+	return (void *)addr;
+}
+
 #endif /* CONFIG_KASAN_SW_TAGS */
 
 #endif /* LINUX_KASAN_H */
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index 19b950eaccff..b080b8d92812 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -8,6 +8,10 @@
 #define KASAN_SHADOW_SCALE_SIZE (1UL << KASAN_SHADOW_SCALE_SHIFT)
 #define KASAN_SHADOW_MASK       (KASAN_SHADOW_SCALE_SIZE - 1)
 
+#define KASAN_TAG_KERNEL	0xFF /* native kernel pointers tag */
+#define KASAN_TAG_INVALID	0xFE /* inaccessible memory tag */
+#define KASAN_TAG_MAX		0xFD /* maximum value for random tags */
+
 #define KASAN_FREE_PAGE         0xFF  /* page was freed */
 #define KASAN_PAGE_REDZONE      0xFE  /* redzone for kmalloc_large allocations */
 #define KASAN_KMALLOC_REDZONE   0xFC  /* redzone inside slub object */
@@ -126,6 +130,33 @@ static inline void quarantine_reduce(void) { }
 static inline void quarantine_remove_cache(struct kmem_cache *cache) { }
 #endif
 
+#ifdef CONFIG_KASAN_SW_TAGS
+
+u8 random_tag(void);
+
+#else
+
+static inline u8 random_tag(void)
+{
+	return 0;
+}
+
+#endif
+
+#ifndef arch_kasan_set_tag
+#define arch_kasan_set_tag(addr, tag)	((void *)(addr))
+#endif
+#ifndef arch_kasan_reset_tag
+#define arch_kasan_reset_tag(addr)	((void *)(addr))
+#endif
+#ifndef arch_kasan_get_tag
+#define arch_kasan_get_tag(addr)	0
+#endif
+
+#define set_tag(addr, tag)	((void *)arch_kasan_set_tag((addr), (tag)))
+#define reset_tag(addr)		((void *)arch_kasan_reset_tag(addr))
+#define get_tag(addr)		arch_kasan_get_tag(addr)
+
 /*
  * Exported functions for interfaces called from assembly or from generated
  * code. Declarations here to avoid warning about missing declarations.
diff --git a/mm/kasan/tags.c b/mm/kasan/tags.c
index 04194923c543..1c4e7ce2e6fe 100644
--- a/mm/kasan/tags.c
+++ b/mm/kasan/tags.c
@@ -38,6 +38,43 @@
 #include "kasan.h"
 #include "../slab.h"
 
+static DEFINE_PER_CPU(u32, prng_state);
+
+void kasan_init_tags(void)
+{
+	int cpu;
+
+	for_each_possible_cpu(cpu)
+		per_cpu(prng_state, cpu) = get_random_u32();
+}
+
+/*
+ * If a preemption happens between this_cpu_read and this_cpu_write, the only
+ * side effect is that we'll give a few allocated in different contexts objects
+ * the same tag. Since tag-based KASAN is meant to be used a probabilistic
+ * bug-detection debug feature, this doesn't have significant negative impact.
+ *
+ * Ideally the tags use strong randomness to prevent any attempts to predict
+ * them during explicit exploit attempts. But strong randomness is expensive,
+ * and we did an intentional trade-off to use a PRNG. This non-atomic RMW
+ * sequence has in fact positive effect, since interrupts that randomly skew
+ * PRNG at unpredictable points do only good.
+ */
+u8 random_tag(void)
+{
+	u32 state = this_cpu_read(prng_state);
+
+	state = 1664525 * state + 1013904223;
+	this_cpu_write(prng_state, state);
+
+	return (u8)(state % (KASAN_TAG_MAX + 1));
+}
+
+void *kasan_reset_tag(const void *addr)
+{
+	return reset_tag(addr);
+}
+
 void check_memory_region(unsigned long addr, size_t size, bool write,
 				unsigned long ret_ip)
 {
-- 
2.20.0.rc1.387.gf8505762e3-goog


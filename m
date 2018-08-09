Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE238C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 19:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 549EA21EFC
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 19:21:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EnnkaLIv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 549EA21EFC
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727584AbeHIVrn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 17:47:43 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35854 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727507AbeHIVrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 17:47:42 -0400
Received: by mail-wr1-f67.google.com with SMTP id h9-v6so6106525wro.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 12:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WHpyWH2OO79/ehEid9c5Gvksh3odR6UxWphsCaQZh0Y=;
        b=EnnkaLIvpvOXPWY4qbbfL97NRSRCEPQrQGRGJk1CiKYBlVUyEgVrJCj81PpbZrFBCW
         ZafZllqFghylqRXyVT9TAe8aVRUIO+Zf865PmZkBNJfltq3JIbqe/hMgoXIS1u0cx2Za
         M24l3hNUWZfkNAxZZAfL7DMFbHKCHxe+JLaliL67CyqTTXt8+z+dFVInZ1C9aybdHAgC
         IdT2fUXRMZZawWK5sNhCAMxmiRhjhppFgU9Pnisjhr3tYCqguc6iMmwJhdidUaEau+kH
         /9Y0jQTWIjNjkIJI6rPumClXXtDJlY5u+uQhcB4x2kYxfNTSFfNpxGlYR0bd2catV3cX
         SAEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WHpyWH2OO79/ehEid9c5Gvksh3odR6UxWphsCaQZh0Y=;
        b=Dj7A7OKkfu4RiYpMOzpZl3TOaiVTyJt+a9H7JTvoxo6cNEY4/LFD5wyWYVvGOAK1bF
         nh1aGVSHB6BndTf0C8rm1QA7JTVHouJDJ9z4MvKUtO5kj2hZj+DIPWjZ83AQCR9lGW63
         vHVLfKTdUDi1B1LXBY2E61LA1P/jEQVLGuyjamHY4KU6Wzt3Yu0IOcshBUG7r8bPv4Qu
         23Xn6J1xFlDvYX+c6XMl/eBeqeXY4Dgfc+mN0OluJJGyXP13neY4JUqJPgAhKgAAmu80
         3cdiTtBDNmWp7BlfOItu0HBlj0M8elLmeEt7cue9po/xUTLJ+gDR/pJTuvcN/pOa7ahw
         Rw0w==
X-Gm-Message-State: AOUpUlEYFL4Gpgh+0wCiK4mJB9WYPdpA+sry4CqtyUmWCuN0CELsjvh8
        mFHrquYDuA/hu2QEc2Edv7kzEQ==
X-Google-Smtp-Source: AA+uWPw5veD4jWu6nOuUR+3+zQNTsYjc+2qcmTqTMQnoEecnEvG8RzjHh6QiIZ3buwj7eXplOPFijg==
X-Received: by 2002:a5d:63c1:: with SMTP id c1-v6mr2331635wrw.106.1533842486470;
        Thu, 09 Aug 2018 12:21:26 -0700 (PDT)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:84be:a42a:826d:c530])
        by smtp.gmail.com with ESMTPSA id o14-v6sm14738797wmd.35.2018.08.09.12.21.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 12:21:25 -0700 (PDT)
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
Subject: [PATCH v5 07/18] khwasan: add tag related helper functions
Date:   Thu,  9 Aug 2018 21:20:59 +0200
Message-Id: <4a1aae15394409b0b37ca3b7bc2aef322f1f05a1.1533842385.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
In-Reply-To: <cover.1533842385.git.andreyknvl@google.com>
References: <cover.1533842385.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds a few helper functions, that are meant to be used to
work with tags embedded in the top byte of kernel pointers: to set, to
get or to reset (set to 0xff) the top byte.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 arch/arm64/mm/kasan_init.c |  2 ++
 include/linux/kasan.h      | 29 +++++++++++++++++
 mm/kasan/kasan.h           | 55 ++++++++++++++++++++++++++++++++
 mm/kasan/khwasan.c         | 65 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 151 insertions(+)

diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
index 7a31e8ccbad2..e7f37c0b7e14 100644
--- a/arch/arm64/mm/kasan_init.c
+++ b/arch/arm64/mm/kasan_init.c
@@ -250,6 +250,8 @@ void __init kasan_init(void)
 	memset(kasan_zero_page, KASAN_SHADOW_INIT, PAGE_SIZE);
 	cpu_replace_ttbr1(lm_alias(swapper_pg_dir));
 
+	khwasan_init();
+
 	/* At this point kasan is fully initialized. Enable error messages */
 	init_task.kasan_depth = 0;
 	pr_info("KernelAddressSanitizer initialized\n");
diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 336385baf926..174f762da968 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -155,6 +155,35 @@ static inline void kasan_cache_shutdown(struct kmem_cache *cache) {}
 
 #define KASAN_SHADOW_INIT 0xFF
 
+void khwasan_init(void);
+
+void *khwasan_reset_tag(const void *addr);
+
+void *khwasan_preset_slub_tag(struct kmem_cache *cache, const void *addr);
+void *khwasan_preset_slab_tag(struct kmem_cache *cache, unsigned int idx,
+					const void *addr);
+
+#else /* CONFIG_KASAN_HW */
+
+static inline void khwasan_init(void) { }
+
+static inline void *khwasan_reset_tag(const void *addr)
+{
+	return (void *)addr;
+}
+
+static inline void *khwasan_preset_slub_tag(struct kmem_cache *cache,
+						const void *addr)
+{
+	return (void *)addr;
+}
+
+static inline void *khwasan_preset_slab_tag(struct kmem_cache *cache,
+					unsigned int idx, const void *addr)
+{
+	return (void *)addr;
+}
+
 #endif /* CONFIG_KASAN_HW */
 
 #endif /* LINUX_KASAN_H */
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index 19b950eaccff..a7cc27d96608 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -8,6 +8,10 @@
 #define KASAN_SHADOW_SCALE_SIZE (1UL << KASAN_SHADOW_SCALE_SHIFT)
 #define KASAN_SHADOW_MASK       (KASAN_SHADOW_SCALE_SIZE - 1)
 
+#define KHWASAN_TAG_KERNEL	0xFF /* native kernel pointers tag */
+#define KHWASAN_TAG_INVALID	0xFE /* inaccessible memory tag */
+#define KHWASAN_TAG_MAX		0xFD /* maximum value for random tags */
+
 #define KASAN_FREE_PAGE         0xFF  /* page was freed */
 #define KASAN_PAGE_REDZONE      0xFE  /* redzone for kmalloc_large allocations */
 #define KASAN_KMALLOC_REDZONE   0xFC  /* redzone inside slub object */
@@ -126,6 +130,57 @@ static inline void quarantine_reduce(void) { }
 static inline void quarantine_remove_cache(struct kmem_cache *cache) { }
 #endif
 
+#ifdef CONFIG_KASAN_HW
+
+#define KHWASAN_TAG_SHIFT 56
+#define KHWASAN_TAG_MASK (0xFFUL << KHWASAN_TAG_SHIFT)
+
+u8 random_tag(void);
+
+static inline void *set_tag(const void *addr, u8 tag)
+{
+	u64 a = (u64)addr;
+
+	a &= ~KHWASAN_TAG_MASK;
+	a |= ((u64)tag << KHWASAN_TAG_SHIFT);
+
+	return (void *)a;
+}
+
+static inline u8 get_tag(const void *addr)
+{
+	return (u8)((u64)addr >> KHWASAN_TAG_SHIFT);
+}
+
+static inline void *reset_tag(const void *addr)
+{
+	return set_tag(addr, KHWASAN_TAG_KERNEL);
+}
+
+#else /* CONFIG_KASAN_HW */
+
+static inline u8 random_tag(void)
+{
+	return 0;
+}
+
+static inline void *set_tag(const void *addr, u8 tag)
+{
+	return (void *)addr;
+}
+
+static inline u8 get_tag(const void *addr)
+{
+	return 0;
+}
+
+static inline void *reset_tag(const void *addr)
+{
+	return (void *)addr;
+}
+
+#endif /* CONFIG_KASAN_HW */
+
 /*
  * Exported functions for interfaces called from assembly or from generated
  * code. Declarations here to avoid warning about missing declarations.
diff --git a/mm/kasan/khwasan.c b/mm/kasan/khwasan.c
index e2c3a7f7fd1f..9d91bf3c8246 100644
--- a/mm/kasan/khwasan.c
+++ b/mm/kasan/khwasan.c
@@ -38,6 +38,71 @@
 #include "kasan.h"
 #include "../slab.h"
 
+static DEFINE_PER_CPU(u32, prng_state);
+
+void khwasan_init(void)
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
+ * the same tag. Since KHWASAN is meant to be used a probabilistic bug-detection
+ * debug feature, this doesn’t have significant negative impact.
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
+	return (u8)(state % (KHWASAN_TAG_MAX + 1));
+}
+
+void *khwasan_reset_tag(const void *addr)
+{
+	return reset_tag(addr);
+}
+
+void *khwasan_preset_slub_tag(struct kmem_cache *cache, const void *addr)
+{
+	/*
+	 * Since it's desirable to only call object contructors ones during
+	 * slab allocation, we preassign tags to all such objects.
+	 * Also preassign tags for SLAB_TYPESAFE_BY_RCU slabs to avoid
+	 * use-after-free reports.
+	 */
+	if (cache->ctor || cache->flags & SLAB_TYPESAFE_BY_RCU)
+		return set_tag(addr, random_tag());
+	return (void *)addr;
+}
+
+void *khwasan_preset_slab_tag(struct kmem_cache *cache, unsigned int idx,
+				const void *addr)
+{
+	/*
+	 * See comment in khwasan_preset_slub_tag.
+	 * For SLAB allocator we can't preassign tags randomly since the
+	 * freelist is stored as an array of indexes instead of a linked
+	 * list. Assign tags based on objects indexes, so that objects that
+	 * are next to each other get different tags.
+	 */
+	if (cache->ctor || cache->flags & SLAB_TYPESAFE_BY_RCU)
+		return set_tag(addr, (u8)idx);
+	return (void *)addr;
+}
+
 void check_memory_region(unsigned long addr, size_t size, bool write,
 				unsigned long ret_ip)
 {
-- 
2.18.0.597.ga71716f1ad-goog


Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77705C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 11:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1562A20862
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 11:36:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V77xIUts"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1562A20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728762AbeH2PdU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 11:33:20 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:38190 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728442AbeH2PcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 11:32:10 -0400
Received: by mail-wm0-f66.google.com with SMTP id t25-v6so5153874wmi.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 04:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kb0anrSFrq4OO5HLjnBi1Wtd8/F9idg7tFDv1gOHdc4=;
        b=V77xIUts4G5R5xgxpZRlzf+b6PxUbpyYldPcR1vDedUxJCnCO1Cd7FjmZsRhUO5GK6
         DqSPZhRHZ24fg1dYh8PnaOSNZMErt53IHxij5lTJDzXliZRTTZg6ONDGkTsFT29mRK57
         1XMNNSGwspzUN55Y05uoa5Yd2K8bcaHFFqkFZFufVMI0yVygdcneSYIykpOHpW3hVuSo
         t6CB96Bg8wUZTsnJtcciwXjlaeD6HHL+bQ91OTSIWQNBdi2yclcFf3iSbu1yGChiIovQ
         J1HVI08VWA93LS3Z1IPZxaC2zKyBdBFK7g53WLalomO8XnP9SCMeu4wEPYIdpwdYBXUd
         1EzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kb0anrSFrq4OO5HLjnBi1Wtd8/F9idg7tFDv1gOHdc4=;
        b=eYhU/6lnTCnz7IDl1rrjUmzXuuYmWf8e7UbeHSCpuJq4zhAm3i2hLXmKodkyyW4jXo
         5PzNxXscN9dfS1d6KHl1HsZvO6XKE21c+Atw6x2vBD2ErlkR5CMr+Is2JxC2V1M4ebBp
         O40R5OeziRmqdcTygntO06FDfp18Cee2+AFplmgXsNUsMLAO7biZk0JGJBL8wP8K+osy
         ohmkVytn/I6XN2Wr815VatxCADWzEZOkpPcmRxXTbg+Uc1PDtYEXjAsx1IIdmrhCf4mR
         1jFHX9ULS69NFKqUDIzUWFnYAt5828UjbsB8721bMhcRM3mei+nvPozri26/Jwf2s+gN
         2fww==
X-Gm-Message-State: APzg51ArDEM2zZdYN5KyAc4e7I+Kcv7o/4sxAo12ef7H3JIhtW2NLXYM
        a7S3bStZxiq8p/RgBXZDvbImPQ==
X-Google-Smtp-Source: ANB0VdZAmbo5vWf2UbC1iC4mfzsIcGelknxtQTTEElaiO8Z6gaQQGbaRPFvyEa08sXABod5h77vz/Q==
X-Received: by 2002:a1c:adcc:: with SMTP id w195-v6mr4157719wme.41.1535542538782;
        Wed, 29 Aug 2018 04:35:38 -0700 (PDT)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:84be:a42a:826d:c530])
        by smtp.gmail.com with ESMTPSA id s10-v6sm7800454wmd.22.2018.08.29.04.35.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 04:35:38 -0700 (PDT)
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
Subject: [PATCH v6 07/18] khwasan: add tag related helper functions
Date:   Wed, 29 Aug 2018 13:35:11 +0200
Message-Id: <6cd298a90d02068969713f2fd440eae21227467b.1535462971.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0-goog
In-Reply-To: <cover.1535462971.git.andreyknvl@google.com>
References: <cover.1535462971.git.andreyknvl@google.com>
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
index 1c31bb089154..1f852244e739 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -166,6 +166,35 @@ static inline void kasan_cache_shutdown(struct kmem_cache *cache) {}
 
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
2.19.0.rc0.228.g281dcd1b4d0-goog


Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF8BEC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 13:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8246026B29
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 13:20:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HG/lRs+B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8246026B29
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935480AbeFZNUa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 09:20:30 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39045 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935412AbeFZNPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 09:15:43 -0400
Received: by mail-wm0-f68.google.com with SMTP id p11-v6so1789472wmc.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 06:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=d0nWZ+rdDycj8ZcGpcXHZ6Mt7ZJeTMJyiNbRRjCIKKw=;
        b=HG/lRs+BzcPtm1IVT2IVXkG2FaU4/qNYJHreY3GF0sPTFCDGNz2dMXAbxRxTh60rrM
         lYgQeZlnq4g4tbq/2Pb7e81kAo8L0wzUe8gGe0Y7XyC4eOToxEDgLvro/K08Jw5d+YNw
         TxSTP+hIkK7izWSldpVgv8m4HAyCMKgRv+BFw3nH9Xfty68R7puhNfJ2pFP5zG1Nr2AM
         s1KtWMdCdrIUv5LpzPhSLtDHVHpLvXsYv4IQU4glXwtmYXH+4uFzc66juUgLQMYWvJIs
         DYENUBy7zgCLxktSeCqvQ5j6wllfmJIofPi8ngftTeVfegK+6MTf54dNAUhqZoplKoKj
         R+Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=d0nWZ+rdDycj8ZcGpcXHZ6Mt7ZJeTMJyiNbRRjCIKKw=;
        b=aVNWNSU0Eu9y0zyS/nsP4gud315SZL6NkbaBRtNKUzFBYjIIL+D8jY2BwdHugpTf1g
         jbWZQ8q6RVXWTdebix1ZDjiTXZrwLT0wqMTmT/G7I4nCZyOFiHjUknSbmAXSD1OP2cJN
         730hVop+f3GTxBdIkNNAcMxtPNT9+DRdqDXIqQkS/MX/bfWFDFAJKFGuImmPkWWbO3It
         pJ+jvm06B/LFp7AJBpojQH0ui+Sm/vdmbIoU+19ozbqQj8h0qzCrvFI0iKtVkrVkSnxo
         y0wOmWvd69v3ONr4OILpwONJ9Z8XLYhE+gP82cPd+UQU0iwntoh54cSqbJN+DsN9+ruP
         SELQ==
X-Gm-Message-State: APt69E1b9zfmgmgTDuAEv9NDJl1ou5bqfk2FN3RIbDNazftVpdE2JnK7
        x+dZjhuOG+/m9nxZ6l7dAEtUpA==
X-Google-Smtp-Source: AAOMgpekLX86Zwdd9ztlWa3ibDTwlSnpcisR9N+S2hbuaOiRrzpi15ft95kVXz4Z4ahpydT2JpS/3A==
X-Received: by 2002:a1c:5585:: with SMTP id j127-v6mr1576632wmb.102.1530018941558;
        Tue, 26 Jun 2018 06:15:41 -0700 (PDT)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:84be:a42a:826d:c530])
        by smtp.gmail.com with ESMTPSA id w15-v6sm2162639wrn.25.2018.06.26.06.15.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 06:15:40 -0700 (PDT)
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
Subject: [PATCH v4 05/17] khwasan: initialize shadow to 0xff
Date:   Tue, 26 Jun 2018 15:15:15 +0200
Message-Id: <4f11b60d5ace61e1a07ad4962ee11dab4f4ee48e.1530018818.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
In-Reply-To: <cover.1530018818.git.andreyknvl@google.com>
References: <cover.1530018818.git.andreyknvl@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A KHWASAN shadow memory cell contains a memory tag, that corresponds to
the tag in the top byte of the pointer, that points to that memory. The
native top byte value of kernel pointers is 0xff, so with KHWASAN we
need to initialize shadow memory to 0xff. This commit does that.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 arch/arm64/mm/kasan_init.c | 16 ++++++++++++++--
 include/linux/kasan.h      |  8 ++++++++
 mm/kasan/common.c          |  3 ++-
 3 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
index 12145874c02b..7a31e8ccbad2 100644
--- a/arch/arm64/mm/kasan_init.c
+++ b/arch/arm64/mm/kasan_init.c
@@ -44,6 +44,15 @@ static phys_addr_t __init kasan_alloc_zeroed_page(int node)
 	return __pa(p);
 }
 
+static phys_addr_t __init kasan_alloc_raw_page(int node)
+{
+	void *p = memblock_virt_alloc_try_nid_raw(PAGE_SIZE, PAGE_SIZE,
+						  __pa(MAX_DMA_ADDRESS),
+						  MEMBLOCK_ALLOC_ACCESSIBLE,
+						  node);
+	return __pa(p);
+}
+
 static pte_t *__init kasan_pte_offset(pmd_t *pmdp, unsigned long addr, int node,
 				      bool early)
 {
@@ -89,7 +98,9 @@ static void __init kasan_pte_populate(pmd_t *pmdp, unsigned long addr,
 
 	do {
 		phys_addr_t page_phys = early ? __pa_symbol(kasan_zero_page)
-					      : kasan_alloc_zeroed_page(node);
+					      : kasan_alloc_raw_page(node);
+		if (!early)
+			memset(__va(page_phys), KASAN_SHADOW_INIT, PAGE_SIZE);
 		next = addr + PAGE_SIZE;
 		set_pte(ptep, pfn_pte(__phys_to_pfn(page_phys), PAGE_KERNEL));
 	} while (ptep++, addr = next, addr != end && pte_none(READ_ONCE(*ptep)));
@@ -139,6 +150,7 @@ asmlinkage void __init kasan_early_init(void)
 		KASAN_SHADOW_END - (1UL << (64 - KASAN_SHADOW_SCALE_SHIFT)));
 	BUILD_BUG_ON(!IS_ALIGNED(KASAN_SHADOW_START, PGDIR_SIZE));
 	BUILD_BUG_ON(!IS_ALIGNED(KASAN_SHADOW_END, PGDIR_SIZE));
+
 	kasan_pgd_populate(KASAN_SHADOW_START, KASAN_SHADOW_END, NUMA_NO_NODE,
 			   true);
 }
@@ -235,7 +247,7 @@ void __init kasan_init(void)
 		set_pte(&kasan_zero_pte[i],
 			pfn_pte(sym_to_pfn(kasan_zero_page), PAGE_KERNEL_RO));
 
-	memset(kasan_zero_page, 0, PAGE_SIZE);
+	memset(kasan_zero_page, KASAN_SHADOW_INIT, PAGE_SIZE);
 	cpu_replace_ttbr1(lm_alias(swapper_pg_dir));
 
 	/* At this point kasan is fully initialized. Enable error messages */
diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 6608aa9b35ac..336385baf926 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -139,6 +139,8 @@ static inline size_t kasan_metadata_size(struct kmem_cache *cache) { return 0; }
 
 #ifdef CONFIG_KASAN_GENERIC
 
+#define KASAN_SHADOW_INIT 0
+
 void kasan_cache_shrink(struct kmem_cache *cache);
 void kasan_cache_shutdown(struct kmem_cache *cache);
 
@@ -149,4 +151,10 @@ static inline void kasan_cache_shutdown(struct kmem_cache *cache) {}
 
 #endif /* CONFIG_KASAN_GENERIC */
 
+#ifdef CONFIG_KASAN_HW
+
+#define KASAN_SHADOW_INIT 0xFF
+
+#endif /* CONFIG_KASAN_HW */
+
 #endif /* LINUX_KASAN_H */
diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index e78ebeff1f4c..656baa8984c7 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -473,11 +473,12 @@ int kasan_module_alloc(void *addr, size_t size)
 
 	ret = __vmalloc_node_range(shadow_size, 1, shadow_start,
 			shadow_start + shadow_size,
-			GFP_KERNEL | __GFP_ZERO,
+			GFP_KERNEL,
 			PAGE_KERNEL, VM_NO_GUARD, NUMA_NO_NODE,
 			__builtin_return_address(0));
 
 	if (ret) {
+		__memset(ret, KASAN_SHADOW_INIT, shadow_size);
 		find_vm_area(addr)->flags |= VM_KASAN;
 		kmemleak_ignore(ret);
 		return 0;
-- 
2.18.0.rc2.346.g013aa6912e-goog


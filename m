Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 142F3ECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 18:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8A5D2151B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 18:55:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BJlkoTl7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8A5D2151B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387504AbeITAeb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 20:34:31 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33468 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387453AbeITAe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 20:34:29 -0400
Received: by mail-wr1-f66.google.com with SMTP id v90-v6so6898609wrc.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 11:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fbr13c4fj47e45ylSZzn54WLgirbXAILEytxVKinDw0=;
        b=BJlkoTl7DNX07411Z8gMKQZAU8fjdC7LckXv0Baa2hcOKewrzLnPGct4wlnFtiwPSz
         gnRmNQyCyQs5wm6hbL96VCPVFE37GVc9SXIClOxEVfSLRbFQfj7CfKtiTDwL/+Tlzg81
         5wMGVa7eUKqpKQDzqPS6LIFmZMI/xA8kv8oyOce1jcwf5fn1BkAwenslIrjY80wpJysP
         ApQsqjtBL5oCnnDlTH2gaUBTNj/wZFG92hM1RloiA53KGOo4Z3MSiuzvIDOZwpK5UG7E
         18n64L6jYKJpaoLfftbtKnlearmnt54T1LfojC+FU9GbBeJ0Rkxd2j8bY2gZPBaIzqFC
         ri3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fbr13c4fj47e45ylSZzn54WLgirbXAILEytxVKinDw0=;
        b=ISHMwSzv9ix3nghFRroItejcUp0TMBWN43iHk+LeFXyL9GfCYEANyiXsWYerL8JVuB
         Am71G/6VxS9Ya8H+TQcvrIvh5xO/31vYPMDgnq774NXnxaCt7FDXraJuXjzRYWGYZuXt
         2TJF98Npj8tY7IQ09LTL48plM+Qh2gCnsbPfSsR+InRZBfoz58uGSojuvpjCDhREWnZX
         PLNCTtxqahHOvHt3EpMeFrZPLKq9Zw+IgNfUz5gEvxANgbBwmB19xb6WLSNP8vh0ShXM
         3PYuzBnlPhQUvTsJ/pb1breFkswiBnMC/9bOqBC9NKT9QMRRDoAsuLByb2mJYOOGsVcp
         l+7w==
X-Gm-Message-State: APzg51ChlRSwzcQgYf2gn7XqmuU8elIgpQnClzcN3Ibc/t6pxy35xuCh
        pHahPLuDlJFwQrVyukeemMiEQw==
X-Google-Smtp-Source: ANB0Vda2ndFUzi6RYaDwQ1hahv/tKgAsCAZ9rE1TeNDSNIIlR3lhKDJe9CbUqZ8tKu6Nq3DfP9XRCw==
X-Received: by 2002:adf:a10c:: with SMTP id o12-v6mr3930268wro.169.1537383313499;
        Wed, 19 Sep 2018 11:55:13 -0700 (PDT)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:84be:a42a:826d:c530])
        by smtp.gmail.com with ESMTPSA id b10-v6sm8510065wmc.28.2018.09.19.11.55.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Sep 2018 11:55:12 -0700 (PDT)
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
Subject: [PATCH v8 06/20] kasan: initialize shadow to 0xff for tag-based mode
Date:   Wed, 19 Sep 2018 20:54:45 +0200
Message-Id: <8344a2ecd5b7335faa095a2da765f3ddc8d929a9.1537383101.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.19.0.397.gdd90340f6a-goog
In-Reply-To: <cover.1537383101.git.andreyknvl@google.com>
References: <cover.1537383101.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A tag-based KASAN shadow memory cell contains a memory tag, that
corresponds to the tag in the top byte of the pointer, that points to that
memory. The native top byte value of kernel pointers is 0xff, so with
tag-based KASAN we need to initialize shadow memory to 0xff.

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
index f0c96f08f2f1..e7162ca9d66b 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -153,6 +153,8 @@ static inline size_t kasan_metadata_size(struct kmem_cache *cache) { return 0; }
 
 #ifdef CONFIG_KASAN_GENERIC
 
+#define KASAN_SHADOW_INIT 0
+
 void kasan_cache_shrink(struct kmem_cache *cache);
 void kasan_cache_shutdown(struct kmem_cache *cache);
 
@@ -163,4 +165,10 @@ static inline void kasan_cache_shutdown(struct kmem_cache *cache) {}
 
 #endif /* CONFIG_KASAN_GENERIC */
 
+#ifdef CONFIG_KASAN_SW_TAGS
+
+#define KASAN_SHADOW_INIT 0xFF
+
+#endif /* CONFIG_KASAN_SW_TAGS */
+
 #endif /* LINUX_KASAN_H */
diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 5f68c93734ba..7134e75447ff 100644
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
2.19.0.397.gdd90340f6a-goog


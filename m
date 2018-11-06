Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE2FBC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 17:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71C0D20869
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 17:30:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vsfw56KN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71C0D20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389756AbeKGC5K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 21:57:10 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39920 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389727AbeKGC5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 21:57:09 -0500
Received: by mail-wm1-f66.google.com with SMTP id u13-v6so13003566wmc.4
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 09:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ce4N/nMYo7+RfxBkmlKo7hExteLUxNUpfT4nrnEM84A=;
        b=Vsfw56KNSA0j9i4jZTEMw40brJDN+L6Vk6DCkdODL+7mPErtmtlQkMDqok/+LxZTIA
         Fft8ZXVpiqCJCP8miE5QzIVVR0eJpPs/kLTUgPPTN8npCXvrIHnQywVjXmvpIh5HPIAe
         Wa7BMy38S7p9H8D/B9xnivP/Ilz8RTzDI0NFXnMY4KF1cUTUopybY81MTIEXSbkQ8k4b
         +E58TE1QbFn70oHBRkLa8Che+5cPhJvjnPLMHITMfgwQzHhRskF+aYV9mO2sNYi/cltS
         EV/yZHL9/gfcte5RkSa8/Haz7iYyw4HKPiuISIuf7vrZZhH59ApyKYhy7WYnKkpEF4Va
         9sRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ce4N/nMYo7+RfxBkmlKo7hExteLUxNUpfT4nrnEM84A=;
        b=VYZQS2hAeGG+D1Ap5zQ9QeGk/ZCr98M5WZIWa5C5Ub2NSz1uaFI9sV2CIR7jQGSUIh
         DSAX0Wo0hHLs7fZQdPNsj872tcmcyriMF2PeEkCRBd/1lfCg/NUyrMaE9dLytPLTYT7q
         SgZ98UeM/05FIwN/pAXuA3rKERIPvx7AYszRAnitoReziCg2OiADvBrr5ptB0Ecv+R2Q
         rJwePBfhR0ScsT9lyli1noDZl7MLtKJn5aLTEq23fGqbdjFBFMPo15ZnkbkMT751Hs55
         UAjEn7BS2D53zCqPuUBJmRuERXdWDE66jBPysphFdwaeHUYGvBZ8omYpuO9KMG4XEKOI
         Tyjg==
X-Gm-Message-State: AGRZ1gIeBBJtoXfP7VBkQLh/7nzkNBH2W28+mh/b8SoNViHQyM+ELYXp
        Fcbia8KUgtx2m/FYtA9iOmKV+A==
X-Google-Smtp-Source: AJdET5dN2RP29VYyaLlKwxLPMus2CsNsK+huRP1o94zV2LhR/oELAyawrtwYhu4G/QM2rYIsYijVRg==
X-Received: by 2002:a1c:d181:: with SMTP id i123-v6mr2789337wmg.124.1541525452833;
        Tue, 06 Nov 2018 09:30:52 -0800 (PST)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:84be:a42a:826d:c530])
        by smtp.gmail.com with ESMTPSA id z17-v6sm16328416wrm.65.2018.11.06.09.30.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Nov 2018 09:30:52 -0800 (PST)
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
Subject: [PATCH v10 07/22] kasan: initialize shadow to 0xff for tag-based mode
Date:   Tue,  6 Nov 2018 18:30:22 +0100
Message-Id: <9405f32797b52616cd0746bcea37df94e8e4256a.1541525354.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
In-Reply-To: <cover.1541525354.git.andreyknvl@google.com>
References: <cover.1541525354.git.andreyknvl@google.com>
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

Reviewed-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 arch/arm64/mm/kasan_init.c | 16 ++++++++++++++--
 include/linux/kasan.h      |  8 ++++++++
 mm/kasan/common.c          |  3 ++-
 3 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
index 63527e585aac..18ebc8994a7b 100644
--- a/arch/arm64/mm/kasan_init.c
+++ b/arch/arm64/mm/kasan_init.c
@@ -43,6 +43,15 @@ static phys_addr_t __init kasan_alloc_zeroed_page(int node)
 	return __pa(p);
 }
 
+static phys_addr_t __init kasan_alloc_raw_page(int node)
+{
+	void *p = memblock_alloc_try_nid_raw(PAGE_SIZE, PAGE_SIZE,
+						__pa(MAX_DMA_ADDRESS),
+						MEMBLOCK_ALLOC_ACCESSIBLE,
+						node);
+	return __pa(p);
+}
+
 static pte_t *__init kasan_pte_offset(pmd_t *pmdp, unsigned long addr, int node,
 				      bool early)
 {
@@ -88,7 +97,9 @@ static void __init kasan_pte_populate(pmd_t *pmdp, unsigned long addr,
 
 	do {
 		phys_addr_t page_phys = early ? __pa_symbol(kasan_zero_page)
-					      : kasan_alloc_zeroed_page(node);
+					      : kasan_alloc_raw_page(node);
+		if (!early)
+			memset(__va(page_phys), KASAN_SHADOW_INIT, PAGE_SIZE);
 		next = addr + PAGE_SIZE;
 		set_pte(ptep, pfn_pte(__phys_to_pfn(page_phys), PAGE_KERNEL));
 	} while (ptep++, addr = next, addr != end && pte_none(READ_ONCE(*ptep)));
@@ -138,6 +149,7 @@ asmlinkage void __init kasan_early_init(void)
 		KASAN_SHADOW_END - (1UL << (64 - KASAN_SHADOW_SCALE_SHIFT)));
 	BUILD_BUG_ON(!IS_ALIGNED(KASAN_SHADOW_START, PGDIR_SIZE));
 	BUILD_BUG_ON(!IS_ALIGNED(KASAN_SHADOW_END, PGDIR_SIZE));
+
 	kasan_pgd_populate(KASAN_SHADOW_START, KASAN_SHADOW_END, NUMA_NO_NODE,
 			   true);
 }
@@ -234,7 +246,7 @@ void __init kasan_init(void)
 		set_pte(&kasan_zero_pte[i],
 			pfn_pte(sym_to_pfn(kasan_zero_page), PAGE_KERNEL_RO));
 
-	memset(kasan_zero_page, 0, PAGE_SIZE);
+	memset(kasan_zero_page, KASAN_SHADOW_INIT, PAGE_SIZE);
 	cpu_replace_ttbr1(lm_alias(swapper_pg_dir));
 
 	/* At this point kasan is fully initialized. Enable error messages */
diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index b66fdf5ea7ab..7f6574c35c62 100644
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
2.19.1.930.g4563a0d9d0-goog


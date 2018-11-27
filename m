Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA70C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 16:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98FA6208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 16:56:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VN748Muj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98FA6208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731669AbeK1Dyi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 22:54:38 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46685 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731642AbeK1Dyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 22:54:36 -0500
Received: by mail-wr1-f68.google.com with SMTP id l9so23423778wrt.13
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 08:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fztBcLEiYbKA/LtOsORIwty9Qmu1JSfLSmyXKXMabPw=;
        b=VN748MujAw+DWU1wO0qdoor5iHxQuGuy1rSmsVaXIjPu+qp7t1gkSORsGaUi+0f2Z3
         aOXiZ5FMoUJXYwqkR1KMlJUvgIzVuATN/AkXP0OnHQ2oR7g4qW0RP0AYlMOcCN9wRapF
         FjHdh51W3QTBDzipTDU8Het6TyNhlLctUuCuQyxPK0Jh1vMbZhjKZkHuaBUByJ/stl4J
         YjnUrP1lc/GUlHkFl66SX1lfog0/MdcpT7+9kAdMzPPqRJpx87kcbyQZQqG7yoybRkhP
         u9It3Zkk6LuI74HWWSL5K7a+7Sj044hjHidCjblgFJ0TaqnsWHAWWzCGCBNfmL6bKRWa
         2Tfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fztBcLEiYbKA/LtOsORIwty9Qmu1JSfLSmyXKXMabPw=;
        b=GRAd/UumEBbzGGhcVf3jwtfca8wByo5H30mG+RGUQ88hcFsjTFpQINDtjiRAVqL5+P
         WFPOEBhNrd4vOYg1Vj4WCyq3/O7RpApjanTZSrEVFgxNgXl7cAcEO3UzHgxx47tSzPGX
         /4sHYwiUTGXEd4HOP6d68Kh40q4jhQnz5KpHlbwe5rHMpv0KMe8R+TJuFm7gMrgvnU+5
         IwBBDLgOVXSYt0rNVF1NXNx5oSPWp+fJm6k7rzNykACNT/4Wal9Wt29gZlS0am1wXhXo
         PdYc/OJSL0MdkMl8PUS81z5klYeNN6kWakqsaWaXnyoEr9gnIt2BtNjyRyBVZeUh9xvG
         7sdQ==
X-Gm-Message-State: AA+aEWZEtLh5NDEXweRcr5tux7nVjL3DQM1yHRnvUe5S1JJ8HVLPCFPP
        79x0JMHevUvDOpSNhmV9YPFakQ==
X-Google-Smtp-Source: AFSGD/XGiJkmlg1UCiFrlHGtGTEw55szXT2tYUWA/NiNoHyYu4oBhIyXGW2YjdMJaFRQhK/jKyCjyg==
X-Received: by 2002:adf:f703:: with SMTP id r3mr27665915wrp.93.1543337763264;
        Tue, 27 Nov 2018 08:56:03 -0800 (PST)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:3180:41f8:3010:ff61])
        by smtp.gmail.com with ESMTPSA id k73sm6383099wmd.36.2018.11.27.08.56.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 08:56:02 -0800 (PST)
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
Subject: [PATCH v12 08/25] kasan: initialize shadow to 0xff for tag-based mode
Date:   Tue, 27 Nov 2018 17:55:26 +0100
Message-Id: <9004fd16d56d8772775cf671a8fa66e54ed138dd.1543337629.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.20.0.rc0.387.gc7a69e6b6c-goog
In-Reply-To: <cover.1543337629.git.andreyknvl@google.com>
References: <cover.1543337629.git.andreyknvl@google.com>
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
 arch/arm64/mm/kasan_init.c | 15 +++++++++++++--
 include/linux/kasan.h      |  8 ++++++++
 mm/kasan/common.c          |  3 ++-
 3 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
index 4ebc19422931..7a4a0904cac8 100644
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
@@ -92,7 +101,9 @@ static void __init kasan_pte_populate(pmd_t *pmdp, unsigned long addr,
 	do {
 		phys_addr_t page_phys = early ?
 				__pa_symbol(kasan_early_shadow_page)
-					: kasan_alloc_zeroed_page(node);
+					: kasan_alloc_raw_page(node);
+		if (!early)
+			memset(__va(page_phys), KASAN_SHADOW_INIT, PAGE_SIZE);
 		next = addr + PAGE_SIZE;
 		set_pte(ptep, pfn_pte(__phys_to_pfn(page_phys), PAGE_KERNEL));
 	} while (ptep++, addr = next, addr != end && pte_none(READ_ONCE(*ptep)));
@@ -239,7 +250,7 @@ void __init kasan_init(void)
 			pfn_pte(sym_to_pfn(kasan_early_shadow_page),
 				PAGE_KERNEL_RO));
 
-	memset(kasan_early_shadow_page, 0, PAGE_SIZE);
+	memset(kasan_early_shadow_page, KASAN_SHADOW_INIT, PAGE_SIZE);
 	cpu_replace_ttbr1(lm_alias(swapper_pg_dir));
 
 	/* At this point kasan is fully initialized. Enable error messages */
diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index ec22d548d0d7..c56af24bd3e7 100644
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
2.20.0.rc0.387.gc7a69e6b6c-goog


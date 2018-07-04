Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 077F1C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 05:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A90572084A
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 05:52:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OBppGlvW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A90572084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933398AbeGDFwp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 01:52:45 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:38018 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932204AbeGDFwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 01:52:39 -0400
Received: by mail-pf0-f196.google.com with SMTP id j17-v6so2123681pfn.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 22:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=ArxOyo6y2ooTiTS+NhWk/y+UgObtaihypFiwhUx48FM=;
        b=OBppGlvWnlKOYZqvrZNfyZG/zRm7SjkLgxGyj0S7KTUueROqU8YRvduHD45sWNO8wa
         3CAAqqLXQsN2LStudxb2yPtQWdksS4hI32YbP5RU2tBX0wUQiJj2n/XFaV/rrZrpbmKZ
         c2jiD4VAdBt6423xyk6lRyOurSDr3m0kW+uTMU0dTHx4Osz2y5izg1lqdw5d+DboUjqV
         mJnED3qjwv5Bqe0jptDOvskOG1fw81H3bBDwF7mMnVpOn9UxPSQjkt5MeK6Aut8YTD5L
         Ykw6PG1mHfpRR/0WUxz94EWb211nqBOM/ChspsCIhoN9ib96ToQT2+R9Xj6yju0gd2f5
         Hd7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=ArxOyo6y2ooTiTS+NhWk/y+UgObtaihypFiwhUx48FM=;
        b=tFjOjgWdrka9vBNcyqZV/85BVg8UU0DINQoHDjQDZN19wD6ORa19NbrBKPsrnK80Uf
         Ac6br/4X2eCUpDPGXqzkIT9NyDZOBE2KkzcGijU9l+8cyS7TzzWVNAjDZqkscjXbrDsR
         jc2yrOzvXr6LaZS0HdgWdbOzSgDK91vdRbdZ3UH+YMJy2fs72++TF3mxk7UJEP7Kqjbo
         A6M1m59/UMtYAuShHq0Wf1npYVYabFb1yHpneRg+808uDa2oZNBadvFU7WNmmYN1XNLG
         uCY8arMH6JnIQzINck0kNywUnhjDwNsVvGpRumoLBmtTyHDyia4VzTVVhiZAeOJgqSfz
         wPlw==
X-Gm-Message-State: APt69E269cklevuCopk67ftzN3Y8HqrkCW2YHdy/LNL6W1UwM4GFCbMI
        v2JSD4ueQHXttJnFNMat9DY=
X-Google-Smtp-Source: AAOMgpdu4XU6IyyrfrqOtCIHUUcpJV2JFoWiX7eoHMm39pYA/4pznJwARMnjgSKOkmZ0bLnJ9DEPOA==
X-Received: by 2002:a65:5106:: with SMTP id f6-v6mr641221pgq.72.1530683558933;
        Tue, 03 Jul 2018 22:52:38 -0700 (PDT)
Received: from app09.andestech.com ([118.163.51.199])
        by smtp.gmail.com with ESMTPSA id b22-v6sm4257226pfi.144.2018.07.03.22.52.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jul 2018 22:52:38 -0700 (PDT)
From:   Greentime Hu <green.hu@gmail.com>
X-Google-Original-From: Greentime Hu <greentime@andestech.com>
To:     greentime@andestech.com, linux-kernel@vger.kernel.org,
        ren_guo@c-sky.com
Cc:     green.hu@gmail.com
Subject: [PATCH v2 3/3] nds32: To simplify the implementation of update_mmu_cache()
Date:   Wed,  4 Jul 2018 13:52:10 +0800
Message-Id: <bc9cb86e6514bed3d317208556d3cd48acff40e0.1530683430.git.greentime@andestech.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <f706abf188a82c9d961ed267a18ff5cb5e9aace9.1530683430.git.greentime@andestech.com>
References: <f706abf188a82c9d961ed267a18ff5cb5e9aace9.1530683430.git.greentime@andestech.com>
In-Reply-To: <f706abf188a82c9d961ed267a18ff5cb5e9aace9.1530683430.git.greentime@andestech.com>
References: <f706abf188a82c9d961ed267a18ff5cb5e9aace9.1530683430.git.greentime@andestech.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The checking code is done in kmap_atomic() so that we don't need to
check it in update_mmu_cache() again. There is no need to implement
it for cache aliasing or cache non-aliasing versions. We can just
implement one version for both.

Signed-off-by: Greentime Hu <greentime@andestech.com>
---
 arch/nds32/mm/cacheflush.c | 47 ++++++++--------------------------------------
 1 file changed, 8 insertions(+), 39 deletions(-)

diff --git a/arch/nds32/mm/cacheflush.c b/arch/nds32/mm/cacheflush.c
index 7fcaa4e6be78..254703653b6f 100644
--- a/arch/nds32/mm/cacheflush.c
+++ b/arch/nds32/mm/cacheflush.c
@@ -45,7 +45,7 @@ void flush_icache_user_range(struct vm_area_struct *vma, struct page *page,
 	flush_icache_range(kaddr, kaddr + len);
 	kunmap_atomic((void *)kaddr);
 }
-#ifndef CONFIG_CPU_CACHE_ALIASING
+
 void update_mmu_cache(struct vm_area_struct *vma, unsigned long addr,
 		      pte_t * pte)
 {
@@ -67,19 +67,15 @@ void update_mmu_cache(struct vm_area_struct *vma, unsigned long addr,
 
 	if ((test_and_clear_bit(PG_dcache_dirty, &page->flags)) ||
 	    (vma->vm_flags & VM_EXEC)) {
-
-		if (!PageHighMem(page)) {
-			cpu_cache_wbinval_page((unsigned long)
-					       page_address(page),
-					       vma->vm_flags & VM_EXEC);
-		} else {
-			unsigned long kaddr = (unsigned long)kmap_atomic(page);
-			cpu_cache_wbinval_page(kaddr, vma->vm_flags & VM_EXEC);
-			kunmap_atomic((void *)kaddr);
-		}
+		unsigned long kaddr;
+		local_irq_save(flags);
+		kaddr = (unsigned long)kmap_atomic(page);
+		cpu_cache_wbinval_page(kaddr, vma->vm_flags & VM_EXEC);
+		kunmap_atomic((void *)kaddr);
+		local_irq_restore(flags);
 	}
 }
-#else
+#ifdef CONFIG_CPU_CACHE_ALIASING
 extern pte_t va_present(struct mm_struct *mm, unsigned long addr);
 
 static inline unsigned long aliasing(unsigned long addr, unsigned long page)
@@ -349,31 +345,4 @@ void invalidate_kernel_vmap_range(void *addr, int size)
 	local_irq_restore(flags);
 }
 EXPORT_SYMBOL(invalidate_kernel_vmap_range);
-
-void update_mmu_cache(struct vm_area_struct *vma, unsigned long addr,
-		      pte_t * pte)
-{
-	struct page *page;
-	unsigned long flags;
-	unsigned long pfn = pte_pfn(*pte);
-
-	if (!pfn_valid(pfn))
-		return;
-
-	if (vma->vm_mm == current->active_mm) {
-		local_irq_save(flags);
-		__nds32__mtsr_dsb(addr, NDS32_SR_TLB_VPN);
-		__nds32__tlbop_rwr(*pte);
-		__nds32__isb();
-		local_irq_restore(flags);
-	}
-
-	page = pfn_to_page(pfn);
-	if (test_and_clear_bit(PG_dcache_dirty, &page->flags) ||
-	    (vma->vm_flags & VM_EXEC)) {
-		local_irq_save(flags);
-		cpu_dcache_wbinval_page((unsigned long)page_address(page));
-		local_irq_restore(flags);
-	}
-}
 #endif
-- 
2.16.2


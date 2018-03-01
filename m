Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3944332-1519939009-2-14006941395366720844
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES roda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519939008; b=tyajRNzEeBXyCTO6MtfWFdXmbNwi7aYbb3R0dRsfHt/YliO
    uCNw0fathAQhxL/5gKWvGsbM0dj7JipDK6VQZbLy+6pSQ9hnGuOaMTKMCVqLpGRj
    KY0z6VeN5otPRVT2hnhe0oet7Ud+g2Lm++L/3xNvLAfIAlbejV3483sUd5oqllFF
    /0QV5b8GDl8Pad+6N/j3iV7rhcjHUTOn4K0gyF8ho+s6s469vAeHOXvpMflFD8I4
    7JtX19IUe0JMwwWWHfuUYISJnTjwSHOvA4dJZPCphMO9GnSWVIhfmZpq2Tt8ClVO
    1w84OxucEuHpcWCHAALIEEo7+2+1+pqXrbkD0fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519939008;
    bh=2B9FRD4XE4b3rl+7lH1n/EjniD9QiMB3ys6iLYXxbKs=; b=Hs6gU/hTRmUv
    96XG28Hw3GDQfhFjtsRyKeScGe+U9+c2w786MH6T7Y6xpRDQHhTcDuR/v2YXKxjG
    yQREHvvC7U31cdqzKefB7qmLwG+g2+2yL6pxPSOt9YYxn1GNSu1PpGnnmpqpmNup
    csZ/gq03iFTv9Avm6I+GeMKStLuJ5/TIKBDZ7S0AjzWcNjDG0Sgw8PEEFE3yAaFT
    kuED7WKBdZucrLyZ9huFEz6AJkrSHiMBU37EIC4naF/07UXYE5w0h+cdwQq1ONAH
    +sebq7FRHTEt9a3cULqY14+gvn0zFxDt/YeFCLbKHG/JBbqpCXNS4iZB4dQ+RhDw
    1UFoe3Xm/w==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=ELak+XJS x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=ELak+XJS x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161272AbeCAVQA (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Mar 2018 16:16:00 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:49274 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1034175AbeCAVPc (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 1 Mar 2018 16:15:32 -0500
From: Matthew Wilcox <willy@infradead.org>
To: linux-mm@kvack.org
Cc: Matthew Wilcox <mawilcox@microsoft.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linux-kernel@vger.kernel.org,
        Fengguang Wu <fengguang.wu@intel.com>,
        linux-api@vger.kernel.org
Subject: [PATCH v4 4/4] mm: Mark pages in use for page tables
Date: Thu,  1 Mar 2018 13:15:23 -0800
Message-Id: <20180301211523.21104-5-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180301211523.21104-1-willy@infradead.org>
References: <20180301211523.21104-1-willy@infradead.org>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Matthew Wilcox <mawilcox@microsoft.com>

Define a new PageTable bit in the page_type and use it to mark pages in
use as page tables.  This can be helpful when debugging crashdumps or
analysing memory fragmentation.  Add a KPF flag to report these pages
to userspace and update page-types.c to interpret that flag.

Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
---
 arch/tile/mm/pgtable.c                 | 3 +++
 fs/proc/page.c                         | 2 ++
 include/linux/mm.h                     | 2 ++
 include/linux/page-flags.h             | 6 ++++++
 include/uapi/linux/kernel-page-flags.h | 1 +
 tools/vm/page-types.c                  | 1 +
 6 files changed, 15 insertions(+)

diff --git a/arch/tile/mm/pgtable.c b/arch/tile/mm/pgtable.c
index ec5576fd3a86..6dff12db335d 100644
--- a/arch/tile/mm/pgtable.c
+++ b/arch/tile/mm/pgtable.c
@@ -206,6 +206,7 @@ struct page *pgtable_alloc_one(struct mm_struct *mm, unsigned long address,
 	 */
 	for (i = 1; i < order; ++i) {
 		init_page_count(p+i);
+		__SetPageTable(p+i);
 		inc_zone_page_state(p+i, NR_PAGETABLE);
 	}
 
@@ -226,6 +227,7 @@ void pgtable_free(struct mm_struct *mm, struct page *p, int order)
 
 	for (i = 1; i < order; ++i) {
 		__free_page(p+i);
+		__ClearPageTable(p+i);
 		dec_zone_page_state(p+i, NR_PAGETABLE);
 	}
 }
@@ -240,6 +242,7 @@ void __pgtable_free_tlb(struct mmu_gather *tlb, struct page *pte,
 
 	for (i = 1; i < order; ++i) {
 		tlb_remove_page(tlb, pte + i);
+		__ClearPageTable(pte + i);
 		dec_zone_page_state(pte + i, NR_PAGETABLE);
 	}
 }
diff --git a/fs/proc/page.c b/fs/proc/page.c
index c9757af919a3..80275e7a963b 100644
--- a/fs/proc/page.c
+++ b/fs/proc/page.c
@@ -156,6 +156,8 @@ u64 stable_page_flags(struct page *page)
 		u |= 1 << KPF_BALLOON;
 	if (PageVmalloc(page))
 		u |= 1 << KPF_VMALLOC;
+	if (PageTable(page))
+		u |= 1 << KPF_PGTABLE;
 
 	if (page_is_idle(page))
 		u |= 1 << KPF_IDLE;
diff --git a/include/linux/mm.h b/include/linux/mm.h
index ad06d42adb1a..7a15042d6828 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1829,6 +1829,7 @@ static inline bool pgtable_page_ctor(struct page *page)
 {
 	if (!ptlock_init(page))
 		return false;
+	__SetPageTable(page);
 	inc_zone_page_state(page, NR_PAGETABLE);
 	return true;
 }
@@ -1836,6 +1837,7 @@ static inline bool pgtable_page_ctor(struct page *page)
 static inline void pgtable_page_dtor(struct page *page)
 {
 	pte_lock_deinit(page);
+	__ClearPageTable(page);
 	dec_zone_page_state(page, NR_PAGETABLE);
 }
 
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 8142ab716e90..ac6bab90849c 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -644,6 +644,7 @@ PAGEFLAG_FALSE(DoubleMap)
 #define PG_balloon	0x00000100
 #define PG_kmemcg	0x00000200
 #define PG_vmalloc	0x00000400
+#define PG_table	0x00000800
 
 #define PageType(page, flag)						\
 	((page->page_type & (PAGE_TYPE_BASE | flag)) == PAGE_TYPE_BASE)
@@ -687,6 +688,11 @@ PAGE_TYPE_OPS(Kmemcg, kmemcg)
  */
 PAGE_TYPE_OPS(Vmalloc, vmalloc)
 
+/*
+ * Marks pages in use as page tables.
+ */
+PAGE_TYPE_OPS(Table, table)
+
 extern bool is_free_buddy_page(struct page *page);
 
 __PAGEFLAG(Isolated, isolated, PF_ANY);
diff --git a/include/uapi/linux/kernel-page-flags.h b/include/uapi/linux/kernel-page-flags.h
index 5f1735ff05b3..3c51d8bf8b7b 100644
--- a/include/uapi/linux/kernel-page-flags.h
+++ b/include/uapi/linux/kernel-page-flags.h
@@ -36,5 +36,6 @@
 #define KPF_ZERO_PAGE		24
 #define KPF_IDLE		25
 #define KPF_VMALLOC		26
+#define KPF_PGTABLE		27
 
 #endif /* _UAPILINUX_KERNEL_PAGE_FLAGS_H */
diff --git a/tools/vm/page-types.c b/tools/vm/page-types.c
index 116f59eff5e2..bbb992694f05 100644
--- a/tools/vm/page-types.c
+++ b/tools/vm/page-types.c
@@ -132,6 +132,7 @@ static const char * const page_flag_names[] = {
 	[KPF_THP]		= "t:thp",
 	[KPF_BALLOON]		= "o:balloon",
 	[KPF_VMALLOC]		= "V:vmalloc",
+	[KPF_PGTABLE]		= "g:pgtable",
 	[KPF_ZERO_PAGE]		= "z:zero_page",
 	[KPF_IDLE]              = "i:idle_page",
 
-- 
2.16.1


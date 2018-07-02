Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32503C6778C
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 00:58:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF45222513
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 00:58:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bnkOe523"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF45222513
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932489AbeGBA6k (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 20:58:40 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:41423 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932302AbeGBA5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 20:57:44 -0400
Received: by mail-oi0-f67.google.com with SMTP id 21-v6so13344822oip.8;
        Sun, 01 Jul 2018 17:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xrHhG6wupTce06w2jTovo6whjXGsWkMEoGVU+tQ963k=;
        b=bnkOe523crq5yT2Mr5e3HPEHvRAfT8TQhTHETL+snag3bYB+WTFFgoqUovs0D3SVqb
         wSNUxdocRmBKG4LDvEE0V4SipkGm9mAK56ZG04xvZdWQbacXc+NjljvUElzUR4W2WQCd
         e+kMAQO/FUlPIy3oQ4eQCsM9N66FcdDvuVuwEA83f+hnKj12bX5vDeVUKWsXaELC6WWM
         zOWbtmo1AfGSLJh712u2chZwQ2fKu+i8D01SGIpwxyhf1sjC38tH+2cJ3JiRCWi2XZTR
         88/UKPxkGJoseGNTire/cytrLCDDGW6e5nKAKGtbuItaizjZ5bb7+J1Ks7ZI4a7H5h9i
         z+ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xrHhG6wupTce06w2jTovo6whjXGsWkMEoGVU+tQ963k=;
        b=tpb3C7VQcvlkjSl3GWFFeMg431kQV5IN09v8SfNYFXczrlJBTjsUNcUS8YJzRQFzKL
         TdxTX1G8dFZX4feUbX2WajDZtedRxKv8YG0qYa/kC37BbVRjm6i1nRxdipt0TA8qEZaB
         wZeD/HQ0VmE8YD6kAYEMJamxylHudrKRJxgQdkceYEJOe4jTG3VTsrbNaYHWB6kstr66
         pAsH/NzAo2E9MV2YDm6vUrHWMuj+YvSwoHCH1ouzVaHc9/qLn5CEFV+8UZm7MMjm/bzL
         Jkqu/1fhpJcMWIxqNva3hcB/Xj2lcw12tO1k1K0Bod6+kNnswOieW3VooSJvaFaeefmC
         LQhw==
X-Gm-Message-State: APt69E0CyhpLXQxY3gDKH629+w+LkVskGVnzJfHv3ROwUsT0LVxHntKV
        XLQKLy9/+mBphUm4Ykq179Y=
X-Google-Smtp-Source: AAOMgpdx6Cdkr5QNzxhSP71ieZDjrHqZbIL/KJB4tViCAaejUiCAWy0wMUsANxHq+UzZ5SMxNHtZbw==
X-Received: by 2002:aca:5a45:: with SMTP id o66-v6mr9271329oib.155.1530493063955;
        Sun, 01 Jul 2018 17:57:43 -0700 (PDT)
Received: from sandstorm.nvidia.com ([2600:1700:43b0:3120:feaa:14ff:fe9e:34cb])
        by smtp.gmail.com with ESMTPSA id v6-v6sm4111672oix.30.2018.07.01.17.57.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Jul 2018 17:57:43 -0700 (PDT)
From:   john.hubbard@gmail.com
X-Google-Original-From: jhubbard@nvidia.com
To:     Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>,
        Jan Kara <jack@suse.cz>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v2 5/6] mm: track gup pages with page->dma_pinned_* fields
Date:   Sun,  1 Jul 2018 17:56:53 -0700
Message-Id: <20180702005654.20369-6-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180702005654.20369-1-jhubbard@nvidia.com>
References: <20180702005654.20369-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Hubbard <jhubbard@nvidia.com>

This patch sets and restores the new page->dma_pinned_flags and
page->dma_pinned_count fields, but does not actually use them for
anything yet.

In order to use these fields at all, the page must be removed from
any LRU list that it's on. The patch also adds some precautions that
prevent the page from getting moved back onto an LRU, once it is
in this state.

This is in preparation to fix some problems that came up when using
devices (NICs, GPUs, for example) that set up direct access to a chunk
of system (CPU) memory, so that they can DMA to/from that memory.

CC: Matthew Wilcox <willy@infradead.org>
CC: Jan Kara <jack@suse.cz>
CC: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 include/linux/mm.h | 15 +++++++++++++
 mm/gup.c           | 56 ++++++++++++++++++++++++++++++++++++++++++++--
 mm/memcontrol.c    |  7 ++++++
 mm/swap.c          | 48 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 124 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 3094500f5cff..aeba3a13a2e3 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -895,6 +895,9 @@ static inline bool is_device_public_page(const struct page *page)
 }
 #endif /* CONFIG_DEV_PAGEMAP_OPS */
 
+void __put_page_for_pinned_dma(struct page *page);
+void __get_page_for_pinned_dma(struct page *page);
+
 static inline void get_page(struct page *page)
 {
 	page = compound_head(page);
@@ -904,12 +907,24 @@ static inline void get_page(struct page *page)
 	 */
 	VM_BUG_ON_PAGE(page_ref_count(page) <= 0, page);
 	page_ref_inc(page);
+
+	if (unlikely(PageDmaPinned(page)))
+		__get_page_for_pinned_dma(page);
 }
 
 static inline void put_page(struct page *page)
 {
 	page = compound_head(page);
 
+	/* Because the page->dma_pinned_* fields are unioned with
+	 * page->lru, there is no way to do classical refcount-style
+	 * decrement-and-test-for-zero. Instead, PageDmaPinned(page) must
+	 * be checked, in order to safely check if we are allowed to decrement
+	 * page->dma_pinned_count at all.
+	 */
+	if (unlikely(PageDmaPinned(page)))
+		__put_page_for_pinned_dma(page);
+
 	/*
 	 * For devmap managed pages we need to catch refcount transition from
 	 * 2 to 1, when refcount reach one it means the page is free and we
diff --git a/mm/gup.c b/mm/gup.c
index 73f0b3316fa7..e5c0104fd234 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -20,6 +20,51 @@
 
 #include "internal.h"
 
+static int pin_page_for_dma(struct page *page)
+{
+	int ret = 0;
+	struct zone *zone;
+
+	page = compound_head(page);
+	zone = page_zone(page);
+
+	spin_lock(zone_gup_lock(zone));
+
+	if (PageDmaPinned(page)) {
+		/* Page was not on an LRU list, because it was DMA-pinned. */
+		VM_BUG_ON_PAGE(PageLRU(page), page);
+
+		atomic_inc(&page->dma_pinned_count);
+		goto unlock_out;
+	}
+
+	/*
+	 * Note that page->dma_pinned_flags is unioned with page->lru.
+	 * Therefore, the rules are: checking if any of the
+	 * PAGE_DMA_PINNED_FLAGS bits are set may be done while page->lru
+	 * is in use. However, setting those flags requires that
+	 * the page is both locked, and also, removed from the LRU.
+	 */
+	ret = isolate_lru_page(page);
+
+	if (ret == 0) {
+		/* Avoid problems later, when freeing the page: */
+		ClearPageActive(page);
+		ClearPageUnevictable(page);
+
+		/* counteract isolate_lru_page's effects: */
+		put_page(page);
+
+		atomic_set(&page->dma_pinned_count, 1);
+		SetPageDmaPinned(page);
+	}
+
+unlock_out:
+	spin_unlock(zone_gup_lock(zone));
+
+	return ret;
+}
+
 static struct page *no_page_table(struct vm_area_struct *vma,
 		unsigned int flags)
 {
@@ -659,7 +704,7 @@ static long __get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
 		unsigned int gup_flags, struct page **pages,
 		struct vm_area_struct **vmas, int *nonblocking)
 {
-	long i = 0;
+	long i = 0, j;
 	int err = 0;
 	unsigned int page_mask;
 	struct vm_area_struct *vma = NULL;
@@ -764,6 +809,10 @@ static long __get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
 	} while (nr_pages);
 
 out:
+	if (pages)
+		for (j = 0; j < i; j++)
+			pin_page_for_dma(pages[j]);
+
 	return i ? i : err;
 }
 
@@ -1843,7 +1892,7 @@ int get_user_pages_fast(unsigned long start, int nr_pages, int write,
 			struct page **pages)
 {
 	unsigned long addr, len, end;
-	int nr = 0, ret = 0;
+	int nr = 0, ret = 0, i;
 
 	start &= PAGE_MASK;
 	addr = start;
@@ -1864,6 +1913,9 @@ int get_user_pages_fast(unsigned long start, int nr_pages, int write,
 		ret = nr;
 	}
 
+	for (i = 0; i < nr; i++)
+		pin_page_for_dma(pages[i]);
+
 	if (nr < nr_pages) {
 		/* Try to get the remaining pages with get_user_pages */
 		start += nr << PAGE_SHIFT;
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index e6f0d5ef320a..510d442647c2 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2062,6 +2062,11 @@ static void lock_page_lru(struct page *page, int *isolated)
 	if (PageLRU(page)) {
 		struct lruvec *lruvec;
 
+		/* LRU and PageDmaPinned are mutually exclusive: they use the
+		 * same fields in struct page, but for different purposes.
+		 */
+		VM_BUG_ON_PAGE(PageDmaPinned(page), page);
+
 		lruvec = mem_cgroup_page_lruvec(page, zone->zone_pgdat);
 		ClearPageLRU(page);
 		del_page_from_lru_list(page, lruvec, page_lru(page));
@@ -2079,6 +2084,8 @@ static void unlock_page_lru(struct page *page, int isolated)
 
 		lruvec = mem_cgroup_page_lruvec(page, zone->zone_pgdat);
 		VM_BUG_ON_PAGE(PageLRU(page), page);
+		VM_BUG_ON_PAGE(PageDmaPinned(page_tail), page);
+
 		SetPageLRU(page);
 		add_page_to_lru_list(page, lruvec, page_lru(page));
 	}
diff --git a/mm/swap.c b/mm/swap.c
index 26fc9b5f1b6c..09ba61300d06 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -52,6 +52,43 @@ static DEFINE_PER_CPU(struct pagevec, lru_lazyfree_pvecs);
 static DEFINE_PER_CPU(struct pagevec, activate_page_pvecs);
 #endif
 
+void __get_page_for_pinned_dma(struct page *page)
+{
+	struct zone *zone = page_zone(page);
+
+	spin_lock(zone_gup_lock(zone));
+
+	if (PageDmaPinned(page))
+		atomic_inc(&page->dma_pinned_count);
+
+	spin_unlock(zone_gup_lock(zone));
+}
+EXPORT_SYMBOL(__get_page_for_pinned_dma);
+
+void __put_page_for_pinned_dma(struct page *page)
+{
+	struct zone *zone = page_zone(page);
+
+	if (atomic_dec_and_test(&page->dma_pinned_count)) {
+		spin_lock(zone_gup_lock(zone));
+
+		VM_BUG_ON_PAGE(PageLRU(page), page);
+
+		/* Re-check while holding the lock, because
+		 * pin_page_for_dma() or get_page() may have snuck in right
+		 * after the atomic_dec_and_test, and raised the count
+		 * above zero again. If so, just leave the flag set. And
+		 * because the atomic_dec_and_test above already got the
+		 * accounting correct, no other action is required.
+		 */
+		if (atomic_read(&page->dma_pinned_count) == 0)
+			ClearPageDmaPinned(page);
+
+		spin_unlock(zone_gup_lock(zone));
+	}
+}
+EXPORT_SYMBOL(__put_page_for_pinned_dma);
+
 /*
  * This path almost never happens for VM activity - pages are normally
  * freed via pagevecs.  But it gets used by networking.
@@ -824,6 +861,11 @@ void lru_add_page_tail(struct page *page, struct page *page_tail,
 	VM_BUG_ON_PAGE(!PageHead(page), page);
 	VM_BUG_ON_PAGE(PageCompound(page_tail), page);
 	VM_BUG_ON_PAGE(PageLRU(page_tail), page);
+
+	/* LRU and PageDmaPinned are mutually exclusive: they use the
+	 * same fields in struct page, but for different purposes.
+	 */
+	VM_BUG_ON_PAGE(PageDmaPinned(page_tail), page);
 	VM_BUG_ON(NR_CPUS != 1 &&
 		  !spin_is_locked(&lruvec_pgdat(lruvec)->lru_lock));
 
@@ -863,6 +905,12 @@ static void __pagevec_lru_add_fn(struct page *page, struct lruvec *lruvec,
 
 	VM_BUG_ON_PAGE(PageLRU(page), page);
 
+	/* LRU and PageDmaPinned are mutually exclusive: they use the
+	 * same fields in struct page, but for different purposes.
+	 */
+	if (PageDmaPinned(page))
+		return;
+
 	SetPageLRU(page);
 	/*
 	 * Page becomes evictable in two ways:
-- 
2.18.0


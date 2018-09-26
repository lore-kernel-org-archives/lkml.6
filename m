Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 033DAC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 21:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98CAE20652
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 21:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="XwT1iJ14"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98CAE20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbeI0DX5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 23:23:57 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37317 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727169AbeI0DX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 23:23:56 -0400
Received: by mail-qt1-f193.google.com with SMTP id n6-v6so508496qtl.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 14:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ESNx+ZeXEpnsFX3NMmn2fGNCRcRxntWtJSga04sSIlA=;
        b=XwT1iJ14b0Y8zOY8wRLonfvQWFerAbtD/ma0JeyNfblznWcTzR6PMdo9Gxvn9vQ8Fo
         uJRpjsCeIPuBeJq5zpQr6RHFH6VBi0clsuwsqTKCsZbmEzxH15vrjtdd8uNMhsbvFzZf
         Hl8ArPBKxVjv2pIQKeQFmmkEU5eTC6L+jYdtM6fXnAMAHjQiSx39qKqFn+r0NaffcCgc
         PkTpgRAn0fmPpVCVO3ysC9zDbghlWIBiP7vkQyI7tP5/VAZp0Onh02N/aWIbPJXUVJND
         pTNKQcRXTFfCsy4cMFQUzmTIBL1Eekk3mAfbRQPKS/SRB2RZE8pGpEwD+vUVG8dtSp+h
         OvSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ESNx+ZeXEpnsFX3NMmn2fGNCRcRxntWtJSga04sSIlA=;
        b=fMmlzGJk1CLebZN3OBYOlVgA8xQtj9z8HGcRzvhQ+j2sZpQXubBxDBEnQQJnbMhhWo
         Iz6mKkKeYM1p6levB0+0kHz2POnddOW2YJeXifiGv1klQwxS7Es+j2WJjkJMJ/hKf3MW
         sTdLCE2HNj/DTB4hH0pZlzbV+/UsQTJoMdSa6hg5a208NRoWxXdvNfgdvzBxcs7a66lw
         +GFES0x0DPf6LXql+2D+kSe7wP6SUJqQXGSoUS0shE0BSVh845b/ibehxNJtl+gJ5Yft
         0klvvJ5Un+uQ7S7XLI57QyTQSeRFW4fbdBn4Su7Q/LDdx5EXp59VJnv3/9l8Bqxpvq6j
         5gJg==
X-Gm-Message-State: ABuFfoitwdFjQ/8wye73K0ewzHQ6mZNBhAXxvjS2A1KkhVOoDJ+itMuQ
        v5x0AHX+dHYR6OyhxP2e6lD+qw==
X-Google-Smtp-Source: ACcGV612awagRXq/MVl2xwKC547NGtGmnifm3iz1tSpVjUxR1GQEkPMPqVcQoudSYXdj3D6A8K2fHg==
X-Received: by 2002:a0c:9557:: with SMTP id m23-v6mr5789549qvm.138.1537996144815;
        Wed, 26 Sep 2018 14:09:04 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id x11-v6sm63930qtc.48.2018.09.26.14.09.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 14:09:03 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     kernel-team@fb.com, linux-kernel@vger.kernel.org,
        hannes@cmpxchg.org, tj@kernel.org, linux-fsdevel@vger.kernel.org,
        akpm@linux-foundation.org, riel@redhat.com, linux-mm@kvack.org,
        linux-btrfs@vger.kernel.org
Cc:     Johannes Weiner <jweiner@fb.com>
Subject: [PATCH 3/9] mm: clean up swapcache lookup and creation function names
Date:   Wed, 26 Sep 2018 17:08:50 -0400
Message-Id: <20180926210856.7895-4-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180926210856.7895-1-josef@toxicpanda.com>
References: <20180926210856.7895-1-josef@toxicpanda.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johannes Weiner <jweiner@fb.com>

__read_swap_cache_async() has a misleading name. All it does is look
up or create a page in swapcache; it doesn't initiate any IO.

The swapcache has many parallels to the page cache, and shares naming
schemes with it elsewhere. Analogous to the cache lookup and creation
API, rename __read_swap_cache_async() find_or_create_swap_cache() and
lookup_swap_cache() to find_swap_cache().

Signed-off-by: Johannes Weiner <jweiner@fb.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 include/linux/swap.h | 14 ++++++++------
 mm/memory.c          |  2 +-
 mm/shmem.c           |  2 +-
 mm/swap_state.c      | 43 ++++++++++++++++++++++---------------------
 mm/zswap.c           |  8 ++++----
 5 files changed, 36 insertions(+), 33 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 8e2c11e692ba..293a84c34448 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -412,15 +412,17 @@ extern void __delete_from_swap_cache(struct page *);
 extern void delete_from_swap_cache(struct page *);
 extern void free_page_and_swap_cache(struct page *);
 extern void free_pages_and_swap_cache(struct page **, int);
-extern struct page *lookup_swap_cache(swp_entry_t entry,
-				      struct vm_area_struct *vma,
-				      unsigned long addr);
+extern struct page *find_swap_cache(swp_entry_t entry,
+				    struct vm_area_struct *vma,
+				    unsigned long addr);
+extern struct page *find_or_create_swap_cache(swp_entry_t entry,
+					      gfp_t gfp_mask,
+					      struct vm_area_struct *vma,
+					      unsigned long addr,
+					      bool *created);
 extern struct page *read_swap_cache_async(swp_entry_t, gfp_t,
 			struct vm_area_struct *vma, unsigned long addr,
 			bool do_poll);
-extern struct page *__read_swap_cache_async(swp_entry_t, gfp_t,
-			struct vm_area_struct *vma, unsigned long addr,
-			bool *new_page_allocated);
 extern struct page *swap_cluster_readahead(swp_entry_t entry, gfp_t flag,
 				struct vm_fault *vmf);
 extern struct page *swapin_readahead(swp_entry_t entry, gfp_t flag,
diff --git a/mm/memory.c b/mm/memory.c
index 433075f722ea..6f8abde84986 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2935,7 +2935,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 
 
 	delayacct_set_flag(DELAYACCT_PF_SWAPIN);
-	page = lookup_swap_cache(entry, vma, vmf->address);
+	page = find_swap_cache(entry, vma, vmf->address);
 	swapcache = page;
 
 	if (!page) {
diff --git a/mm/shmem.c b/mm/shmem.c
index 0376c124b043..9854903ae92f 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1679,7 +1679,7 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
 
 	if (swap.val) {
 		/* Look it up and read it in.. */
-		page = lookup_swap_cache(swap, NULL, 0);
+		page = find_swap_cache(swap, NULL, 0);
 		if (!page) {
 			/* Or update major stats only when swapin succeeds?? */
 			if (fault_type) {
diff --git a/mm/swap_state.c b/mm/swap_state.c
index ecee9c6c4cc1..bae758e19f7a 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -330,8 +330,8 @@ static inline bool swap_use_vma_readahead(void)
  * lock getting page table operations atomic even if we drop the page
  * lock before returning.
  */
-struct page *lookup_swap_cache(swp_entry_t entry, struct vm_area_struct *vma,
-			       unsigned long addr)
+struct page *find_swap_cache(swp_entry_t entry, struct vm_area_struct *vma,
+			     unsigned long addr)
 {
 	struct page *page;
 
@@ -374,19 +374,20 @@ struct page *lookup_swap_cache(swp_entry_t entry, struct vm_area_struct *vma,
 	return page;
 }
 
-struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
+struct page *find_or_create_swap_cache(swp_entry_t entry, gfp_t gfp_mask,
 			struct vm_area_struct *vma, unsigned long addr,
-			bool *new_page_allocated)
+			bool *created)
 {
 	struct page *found_page, *new_page = NULL;
 	struct address_space *swapper_space = swap_address_space(entry);
 	int err;
-	*new_page_allocated = false;
+
+	*created = false;
 
 	do {
 		/*
 		 * First check the swap cache.  Since this is normally
-		 * called after lookup_swap_cache() failed, re-calling
+		 * called after find_swap_cache() failed, re-calling
 		 * that would confuse statistics.
 		 */
 		found_page = find_get_page(swapper_space, swp_offset(entry));
@@ -449,7 +450,7 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 			 * Initiate read into locked page and return.
 			 */
 			lru_cache_add_anon(new_page);
-			*new_page_allocated = true;
+			*created = true;
 			return new_page;
 		}
 		radix_tree_preload_end();
@@ -475,14 +476,14 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 struct page *read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 		struct vm_area_struct *vma, unsigned long addr, bool do_poll)
 {
-	bool page_was_allocated;
-	struct page *retpage = __read_swap_cache_async(entry, gfp_mask,
-			vma, addr, &page_was_allocated);
+	struct page *page;
+	bool created;
 
-	if (page_was_allocated)
-		swap_readpage(retpage, do_poll);
+	page = find_or_create_swap_cache(entry, gfp_mask, vma, addr, &created);
+	if (created)
+		swap_readpage(page, do_poll);
 
-	return retpage;
+	return page;
 }
 
 static unsigned int __swapin_nr_pages(unsigned long prev_offset,
@@ -573,7 +574,7 @@ struct page *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
 	unsigned long mask;
 	struct swap_info_struct *si = swp_swap_info(entry);
 	struct blk_plug plug;
-	bool do_poll = true, page_allocated;
+	bool do_poll = true, created;
 	struct vm_area_struct *vma = vmf->vma;
 	unsigned long addr = vmf->address;
 
@@ -593,12 +594,12 @@ struct page *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
 	blk_start_plug(&plug);
 	for (offset = start_offset; offset <= end_offset ; offset++) {
 		/* Ok, do the async read-ahead now */
-		page = __read_swap_cache_async(
+		page = find_or_create_swap_cache(
 			swp_entry(swp_type(entry), offset),
-			gfp_mask, vma, addr, &page_allocated);
+			gfp_mask, vma, addr, &created);
 		if (!page)
 			continue;
-		if (page_allocated) {
+		if (created) {
 			swap_readpage(page, false);
 			if (offset != entry_offset) {
 				SetPageReadahead(page);
@@ -738,7 +739,7 @@ static struct page *swap_vma_readahead(swp_entry_t fentry, gfp_t gfp_mask,
 	pte_t *pte, pentry;
 	swp_entry_t entry;
 	unsigned int i;
-	bool page_allocated;
+	bool created;
 	struct vma_swap_readahead ra_info = {0,};
 
 	swap_ra_info(vmf, &ra_info);
@@ -756,11 +757,11 @@ static struct page *swap_vma_readahead(swp_entry_t fentry, gfp_t gfp_mask,
 		entry = pte_to_swp_entry(pentry);
 		if (unlikely(non_swap_entry(entry)))
 			continue;
-		page = __read_swap_cache_async(entry, gfp_mask, vma,
-					       vmf->address, &page_allocated);
+		page = find_or_create_swap_cache(entry, gfp_mask, vma,
+					 vmf->address, &created);
 		if (!page)
 			continue;
-		if (page_allocated) {
+		if (created) {
 			swap_readpage(page, false);
 			if (i != ra_info.offset) {
 				SetPageReadahead(page);
diff --git a/mm/zswap.c b/mm/zswap.c
index cd91fd9d96b8..6f05faa75766 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -823,11 +823,11 @@ enum zswap_get_swap_ret {
 static int zswap_get_swap_cache_page(swp_entry_t entry,
 				struct page **retpage)
 {
-	bool page_was_allocated;
+	bool created;
 
-	*retpage = __read_swap_cache_async(entry, GFP_KERNEL,
-			NULL, 0, &page_was_allocated);
-	if (page_was_allocated)
+	*retpage = find_or_create_swap_cache(entry, GFP_KERNEL,
+					     NULL, 0, &created);
+	if (created)
 		return ZSWAP_SWAPCACHE_NEW;
 	if (!*retpage)
 		return ZSWAP_SWAPCACHE_FAIL;
-- 
2.14.3


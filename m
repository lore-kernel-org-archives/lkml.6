Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78158C43610
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 20:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AD2C22419
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 20:45:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BGfilIJ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AD2C22419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730484AbeKMGkT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 01:40:19 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36933 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbeKMGkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 01:40:18 -0500
Received: by mail-wr1-f66.google.com with SMTP id o15-v6so10845117wrv.4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 12:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rApJVEPwyWmLeN9sPsL8W3mNu9y6hq+KbBDo97+XCGU=;
        b=BGfilIJ37Thh79NeKQ7YiD9e4CP1X2kVO2OwzzPWp8Nynk8HwjTQ4ry9xLf83waMMy
         RoNMk9x3tlcQ1Svi/dKvpSsZhJm8H4PjoXCeNieD4ZHHqN39pbdYv9LThUEpxNxyZptT
         Q0mDRzMdNJ7iNgttkpqDybNeNox8nzh3ilE0SUfz6i9fHDLC4flyDOpfu0I0g9G+1U2c
         AnI9/2Wnm83huFESQSZlbsT5fHOLBE4vnvrtXfkwaLd4MYMSMCIcyJ9CRTxI+frCosRS
         lo/bHD0MZW0P9ftc2VwrthZOFGVGw2oqHk7KSiTgz8UOExNt5ndfcLK07cTZxN/E9HY2
         kifA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rApJVEPwyWmLeN9sPsL8W3mNu9y6hq+KbBDo97+XCGU=;
        b=NeNds+kD83APRLBnUyir3CikE4pEd9MUjdnv/SqqVt7h1cXCCOJTrliRkmn59N5wYP
         +WJwR5bvf7hK0W4F6qd4FeblFPITIMF+I7GI5xYLVqb+39BaNbzTiF0bvDb0DUr64OhN
         DEScuNj2UMwG1cSiLwdXjaOZhbqdcNe6C3eo7bnNpjz76d4k0S5Abx83x4Vm/cvkLvgh
         jhuFx9ewY5p/TyrFcKD03yMZgLrrE7So3GsutRGHOeH4PaskCpDpPDS+/eK2/LSrrE1S
         wiB/49eyDWb+CA1qt7P2Jpb3rPEbRbVmI3/qJ+G8jefCpK9NcnHVmhhC9J9eu0BOrNT0
         KVKw==
X-Gm-Message-State: AGRZ1gKuO/KGHMuO57umW2nPXuya3M0O1JMiBTTzgTKP13P5BNGh0o/+
        xNoCNrrnenz7I/krOi+Yy3idOhzjww8=
X-Google-Smtp-Source: AJdET5c7XQbUopJYbv9oN7VDJFICARtgu57dp9RV+QQcVKMr+KpNNvE6Lgy+vXutzYnXset8VTBvSw==
X-Received: by 2002:a5d:53cd:: with SMTP id a13-v6mr2305656wrw.71.1542055522296;
        Mon, 12 Nov 2018 12:45:22 -0800 (PST)
Received: from localhost ([95.239.98.134])
        by smtp.gmail.com with ESMTPSA id s1sm1631885wro.9.2018.11.12.12.45.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 12:45:21 -0800 (PST)
From:   Cristian Sicilia <sicilia.cristian@gmail.com>
To:     Gao Xiang <gaoxiang25@huawei.com>, Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-erofs@lists.ozlabs.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Cristian Sicilia <sicilia.cristian@gmail.com>
Subject: [PATCH 1/3] staging: erofs: unzip_vle.c: Replace comparison to NULL.
Date:   Mon, 12 Nov 2018 21:43:57 +0100
Message-Id: <1542055439-24444-2-git-send-email-sicilia.cristian@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542055439-24444-1-git-send-email-sicilia.cristian@gmail.com>
References: <1542055439-24444-1-git-send-email-sicilia.cristian@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace equal to NULL with logic unary operator,
and removing not equal to NULL comparison.

Signed-off-by: Cristian Sicilia <sicilia.cristian@gmail.com>
---
 drivers/staging/erofs/unzip_vle.c | 86 +++++++++++++++++++--------------------
 1 file changed, 43 insertions(+), 43 deletions(-)

diff --git a/drivers/staging/erofs/unzip_vle.c b/drivers/staging/erofs/unzip_vle.c
index 79d3ba6..1ffeeaa 100644
--- a/drivers/staging/erofs/unzip_vle.c
+++ b/drivers/staging/erofs/unzip_vle.c
@@ -20,8 +20,8 @@ static struct kmem_cache *z_erofs_workgroup_cachep __read_mostly;
 
 void z_erofs_exit_zip_subsystem(void)
 {
-	BUG_ON(z_erofs_workqueue == NULL);
-	BUG_ON(z_erofs_workgroup_cachep == NULL);
+	BUG_ON(!z_erofs_workqueue);
+	BUG_ON(!z_erofs_workgroup_cachep);
 
 	destroy_workqueue(z_erofs_workqueue);
 	kmem_cache_destroy(z_erofs_workgroup_cachep);
@@ -39,7 +39,7 @@ static inline int init_unzip_workqueue(void)
 		WQ_UNBOUND | WQ_HIGHPRI | WQ_CPU_INTENSIVE,
 		onlinecpus + onlinecpus / 4);
 
-	return z_erofs_workqueue != NULL ? 0 : -ENOMEM;
+	return z_erofs_workqueue ? 0 : -ENOMEM;
 }
 
 int __init z_erofs_init_zip_subsystem(void)
@@ -49,7 +49,7 @@ int __init z_erofs_init_zip_subsystem(void)
 		Z_EROFS_WORKGROUP_SIZE, 0,
 		SLAB_RECLAIM_ACCOUNT, NULL);
 
-	if (z_erofs_workgroup_cachep != NULL) {
+	if (z_erofs_workgroup_cachep) {
 		if (!init_unzip_workqueue())
 			return 0;
 
@@ -112,21 +112,21 @@ static bool grab_managed_cache_pages(struct address_space *mapping,
 	for (i = 0; i < clusterblks; ++i) {
 		struct page *page, *found;
 
-		if (READ_ONCE(compressed_pages[i]) != NULL)
+		if (READ_ONCE(compressed_pages[i]))
 			continue;
 
 		page = found = find_get_page(mapping, start + i);
-		if (found == NULL) {
+		if (!found) {
 			noio = false;
 			if (!reserve_allocation)
 				continue;
 			page = EROFS_UNALLOCATED_CACHED_PAGE;
 		}
 
-		if (NULL == cmpxchg(compressed_pages + i, NULL, page))
+		if (!cmpxchg(compressed_pages + i, NULL, page))
 			continue;
 
-		if (found != NULL)
+		if (found)
 			put_page(found);
 	}
 	return noio;
@@ -149,7 +149,7 @@ int erofs_try_to_free_all_cached_pages(struct erofs_sb_info *sbi,
 	for (i = 0; i < clusterpages; ++i) {
 		struct page *page = grp->compressed_pages[i];
 
-		if (page == NULL || page->mapping != mapping)
+		if (!page || page->mapping != mapping)
 			continue;
 
 		/* block other users from reclaiming or migrating the page */
@@ -210,7 +210,7 @@ static inline bool try_to_reuse_as_compressed_page(
 {
 	while (b->compressed_deficit) {
 		--b->compressed_deficit;
-		if (NULL == cmpxchg(b->compressed_pages++, NULL, page))
+		if (!cmpxchg(b->compressed_pages++, NULL, page))
 			return true;
 	}
 
@@ -293,7 +293,7 @@ z_erofs_vle_work_lookup(const struct z_erofs_vle_work_finder *f)
 	struct z_erofs_vle_work *work;
 
 	egrp = erofs_find_workgroup(f->sb, f->idx, &tag);
-	if (egrp == NULL) {
+	if (!egrp) {
 		*f->grp_ret = NULL;
 		return NULL;
 	}
@@ -366,11 +366,11 @@ z_erofs_vle_work_register(const struct z_erofs_vle_work_finder *f,
 	struct z_erofs_vle_work *work;
 
 	/* if multiref is disabled, grp should never be nullptr */
-	BUG_ON(grp != NULL);
+	BUG_ON(grp);
 
 	/* no available workgroup, let's allocate one */
 	grp = kmem_cache_zalloc(z_erofs_workgroup_cachep, GFP_NOFS);
-	if (unlikely(grp == NULL))
+	if (unlikely(!grp))
 		return ERR_PTR(-ENOMEM);
 
 	grp->obj.index = f->idx;
@@ -431,7 +431,7 @@ static int z_erofs_vle_work_iter_begin(struct z_erofs_vle_work_builder *builder,
 	};
 	struct z_erofs_vle_work *work;
 
-	DBG_BUGON(builder->work != NULL);
+	DBG_BUGON(builder->work);
 
 	/* must be Z_EROFS_WORK_TAIL or the next chained work */
 	DBG_BUGON(*owned_head == Z_EROFS_VLE_WORKGRP_NIL);
@@ -441,7 +441,7 @@ static int z_erofs_vle_work_iter_begin(struct z_erofs_vle_work_builder *builder,
 
 repeat:
 	work = z_erofs_vle_work_lookup(&finder);
-	if (work != NULL) {
+	if (work) {
 		unsigned int orig_llen;
 
 		/* increase workgroup `llen' if needed */
@@ -519,7 +519,7 @@ z_erofs_vle_work_iter_end(struct z_erofs_vle_work_builder *builder)
 {
 	struct z_erofs_vle_work *work = builder->work;
 
-	if (work == NULL)
+	if (!work)
 		return false;
 
 	z_erofs_pagevec_ctor_exit(&builder->vector, false);
@@ -542,7 +542,7 @@ static inline struct page *__stagingpage_alloc(struct list_head *pagepool,
 {
 	struct page *page = erofs_allocpage(pagepool, gfp);
 
-	if (unlikely(page == NULL))
+	if (unlikely(!page))
 		return NULL;
 
 	page->mapping = Z_EROFS_MAPPING_STAGING;
@@ -740,10 +740,10 @@ static inline void z_erofs_vle_read_endio(struct bio *bio)
 		bool cachemngd = false;
 
 		DBG_BUGON(PageUptodate(page));
-		BUG_ON(page->mapping == NULL);
+		BUG_ON(!page->mapping);
 
 #ifdef EROFS_FS_HAS_MANAGED_CACHE
-		if (unlikely(mngda == NULL && !z_erofs_is_stagingpage(page))) {
+		if (unlikely(!mngda && !z_erofs_is_stagingpage(page))) {
 			struct inode *const inode = page->mapping->host;
 			struct super_block *const sb = inode->i_sb;
 
@@ -814,7 +814,7 @@ static int z_erofs_vle_unzip(struct super_block *sb,
 			sizeof(struct page *), GFP_KERNEL);
 
 		/* fallback to global pagemap for the lowmem scenario */
-		if (unlikely(pages == NULL)) {
+		if (unlikely(!pages)) {
 			if (nr_pages > Z_EROFS_VLE_VMAP_GLOBAL_PAGES)
 				goto repeat;
 			else {
@@ -836,8 +836,8 @@ static int z_erofs_vle_unzip(struct super_block *sb,
 		page = z_erofs_pagevec_ctor_dequeue(&ctor, &page_type);
 
 		/* all pages in pagevec ought to be valid */
-		DBG_BUGON(page == NULL);
-		DBG_BUGON(page->mapping == NULL);
+		DBG_BUGON(!page);
+		DBG_BUGON(!page->mapping);
 
 		if (z_erofs_gather_if_stagingpage(page_pool, page))
 			continue;
@@ -848,7 +848,7 @@ static int z_erofs_vle_unzip(struct super_block *sb,
 			pagenr = z_erofs_onlinepage_index(page);
 
 		BUG_ON(pagenr >= nr_pages);
-		BUG_ON(pages[pagenr] != NULL);
+		BUG_ON(pages[pagenr]);
 
 		pages[pagenr] = page;
 	}
@@ -865,8 +865,8 @@ static int z_erofs_vle_unzip(struct super_block *sb,
 		page = compressed_pages[i];
 
 		/* all compressed pages ought to be valid */
-		DBG_BUGON(page == NULL);
-		DBG_BUGON(page->mapping == NULL);
+		DBG_BUGON(!page);
+		DBG_BUGON(!page->mapping);
 
 		if (z_erofs_is_stagingpage(page))
 			continue;
@@ -882,7 +882,7 @@ static int z_erofs_vle_unzip(struct super_block *sb,
 		pagenr = z_erofs_onlinepage_index(page);
 
 		BUG_ON(pagenr >= nr_pages);
-		BUG_ON(pages[pagenr] != NULL);
+		BUG_ON(pages[pagenr]);
 		++sparsemem_pages;
 		pages[pagenr] = page;
 
@@ -915,7 +915,7 @@ static int z_erofs_vle_unzip(struct super_block *sb,
 	}
 
 	for (i = 0; i < nr_pages; ++i) {
-		if (pages[i] != NULL)
+		if (pages[i])
 			continue;
 
 		pages[i] = __stagingpage_alloc(page_pool, GFP_NOFS);
@@ -932,7 +932,7 @@ static int z_erofs_vle_unzip(struct super_block *sb,
 out:
 	for (i = 0; i < nr_pages; ++i) {
 		page = pages[i];
-		DBG_BUGON(page->mapping == NULL);
+		DBG_BUGON(!page->mapping);
 
 		/* recycle all individual staging pages */
 		if (z_erofs_gather_if_stagingpage(page_pool, page))
@@ -1021,20 +1021,20 @@ prepare_io_handler(struct super_block *sb,
 
 	if (!background) {
 		/* waitqueue available for foreground io */
-		BUG_ON(io == NULL);
+		BUG_ON(!io);
 
 		init_waitqueue_head(&io->u.wait);
 		atomic_set(&io->pending_bios, 0);
 		goto out;
 	}
 
-	if (io != NULL)
+	if (io)
 		BUG();
 	else {
 		/* allocate extra io descriptor for background io */
 		iosb = kvzalloc(sizeof(struct z_erofs_vle_unzip_io_sb),
 			GFP_KERNEL | __GFP_NOFAIL);
-		BUG_ON(iosb == NULL);
+		BUG_ON(!iosb);
 
 		io = &iosb->io;
 	}
@@ -1154,7 +1154,7 @@ static bool z_erofs_vle_submit_all(struct super_block *sb,
 		if (page == EROFS_UNALLOCATED_CACHED_PAGE) {
 			cachemngd = true;
 			goto do_allocpage;
-		} else if (page != NULL) {
+		} else if (page) {
 			if (page->mapping != mngda)
 				BUG_ON(PageUptodate(page));
 			else if (recover_managed_page(grp, page)) {
@@ -1166,7 +1166,7 @@ static bool z_erofs_vle_submit_all(struct super_block *sb,
 		} else {
 do_allocpage:
 #else
-		if (page != NULL)
+		if (page)
 			BUG_ON(PageUptodate(page));
 		else {
 #endif
@@ -1185,13 +1185,13 @@ static bool z_erofs_vle_submit_all(struct super_block *sb,
 			}
 		}
 
-		if (bio != NULL && force_submit) {
+		if (bio && force_submit) {
 submit_bio_retry:
 			__submit_bio(bio, REQ_OP_READ, 0);
 			bio = NULL;
 		}
 
-		if (bio == NULL) {
+		if (!bio) {
 			bio = erofs_grab_bio(sb, first_index + i,
 				BIO_MAX_PAGES, z_erofs_vle_read_endio, true);
 			bio->bi_private = tagptr_cast_ptr(bi_private);
@@ -1220,12 +1220,12 @@ static bool z_erofs_vle_submit_all(struct super_block *sb,
 				Z_EROFS_VLE_WORKGRP_TAIL_CLOSED :
 				owned_head;
 
-			if (lstgrp_io == NULL)
+			if (!lstgrp_io)
 				ios[1]->head = iogrp_next;
 			else
 				WRITE_ONCE(lstgrp_io->next, iogrp_next);
 
-			if (lstgrp_noio == NULL)
+			if (!lstgrp_noio)
 				ios[0]->head = grp;
 			else
 				WRITE_ONCE(lstgrp_noio->next, grp);
@@ -1235,13 +1235,13 @@ static bool z_erofs_vle_submit_all(struct super_block *sb,
 #endif
 	} while (owned_head != Z_EROFS_VLE_WORKGRP_TAIL);
 
-	if (bio != NULL)
+	if (bio)
 		__submit_bio(bio, REQ_OP_READ, 0);
 
 #ifndef EROFS_FS_HAS_MANAGED_CACHE
 	BUG_ON(!nr_bios);
 #else
-	if (lstgrp_noio != NULL)
+	if (lstgrp_noio)
 		WRITE_ONCE(lstgrp_noio->next, Z_EROFS_VLE_WORKGRP_TAIL_CLOSED);
 
 	if (!force_fg && !nr_bios) {
@@ -1300,7 +1300,7 @@ static int z_erofs_vle_normalaccess_readpage(struct file *file,
 
 	z_erofs_submit_and_unzip(&f, &pagepool, true);
 out:
-	if (f.m_iter.mpage != NULL)
+	if (f.m_iter.mpage)
 		put_page(f.m_iter.mpage);
 
 	/* clean up the remaining free pages */
@@ -1344,7 +1344,7 @@ static int z_erofs_vle_normalaccess_readpages(struct file *filp,
 		head = page;
 	}
 
-	while (head != NULL) {
+	while (head) {
 		struct page *page = head;
 		int err;
 
@@ -1366,7 +1366,7 @@ static int z_erofs_vle_normalaccess_readpages(struct file *filp,
 
 	z_erofs_submit_and_unzip(&f, &pagepool, sync);
 
-	if (f.m_iter.mpage != NULL)
+	if (f.m_iter.mpage)
 		put_page(f.m_iter.mpage);
 
 	/* clean up the remaining free pages */
@@ -1561,7 +1561,7 @@ int z_erofs_map_blocks_iter(struct inode *inode,
 	mblk = vle_extent_blkaddr(inode, lcn);
 
 	if (!mpage || mpage->index != mblk) {
-		if (mpage != NULL)
+		if (mpage)
 			put_page(mpage);
 
 		mpage = erofs_get_meta_page(ctx.sb, mblk, false);
-- 
2.7.4


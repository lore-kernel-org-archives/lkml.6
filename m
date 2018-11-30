Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A27CC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 19:58:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0797920868
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 19:58:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="RDqpS5N7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0797920868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbeLAHIm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 02:08:42 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:38487 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbeLAHIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 02:08:41 -0500
Received: by mail-yb1-f195.google.com with SMTP id u103-v6so2707137ybi.5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 11:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=tfQKrc5MaRoWXLgCC8cvo0W1La7ADJ1hTk4hFrcxJ2w=;
        b=RDqpS5N7sRdUqzfJbuUQ3cP6FZpSxwXrU7nIdtgeLwAMDypJ/AuyKBAVURaYyIpF+W
         TUH2qDG4sSw5CnfzSAptkUg9lt+KdZAK+fgbTlSAWUmnsUi4y6VWMS5jZtZQKr39Njv/
         F8ZwAG81ZhZYKh7m/tVeTdOki3HtqStKzcvGDk0owKjUXs3fTpd2tJ9Rs0BrFOp8rDTv
         IpC12b7mnQMbZP4XGeqQMEzrvS3ty0nrYovoxKqVkHGcEbLTCAAlHOUg1vvZMXmuLnA3
         0ld3tOkRZh1iEo4DOXmJFJ2K3rCYGyhbIjrDMvgb3ZrdwLjwfYfU25tiozmcObmmIpqM
         ezSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=tfQKrc5MaRoWXLgCC8cvo0W1La7ADJ1hTk4hFrcxJ2w=;
        b=jlIXnEK2ijy7j6fvcdnvjtwLSrtf6spi+SeInkvil4AWNi0CzbzWlQ/iv5XzDxYvON
         C44wVGJYoUJay7sgls3TeMgQ3DiZSlnrpqxJzcraGn+0LdlPCgz42A9QsvR1SF33GP73
         wiX5YxrWmlU8VyVY8DjN9IosVi3dkK6J2L7aKOsd8ElOTJz08QwMr0Jt9AGGdftHOmi5
         KNzY0EeVHXr6y+l+U76n1F9jWoxsKN8ZcWELwr/lm3exUMpeykyDWpqOYDa9UOtxuPc5
         DhWc1bfpaWG+Yoi8RTJo1TnWt+5Y6aT6c0AjF5qn66csJUwDAdqMaeppBsdXJ4LNjmIb
         dGww==
X-Gm-Message-State: AA+aEWa5EM+kb/frCMy0AICT5LFaAivvq0X9bXvOIMxxbKy2QGIppQUV
        6Aff2AiOYwjrzBPWzSzyfoh4EQ==
X-Google-Smtp-Source: AFSGD/XWgCRVHDSF9Pe7/FTfBQjuZIj2paksVvKyVRtCwfnLtusXiVGu/hAx627t9t+3WpViWhH6Xw==
X-Received: by 2002:a25:bb4c:: with SMTP id b12-v6mr6648882ybk.45.1543607897615;
        Fri, 30 Nov 2018 11:58:17 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id e194sm2151940ywa.85.2018.11.30.11.58.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Nov 2018 11:58:16 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     kernel-team@fb.com, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, tj@kernel.org, david@fromorbit.com,
        akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, riel@redhat.com, jack@suse.cz
Subject: [PATCH 2/4] filemap: kill page_cache_read usage in filemap_fault
Date:   Fri, 30 Nov 2018 14:58:10 -0500
Message-Id: <20181130195812.19536-3-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20181130195812.19536-1-josef@toxicpanda.com>
References: <20181130195812.19536-1-josef@toxicpanda.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we do not have a page at filemap_fault time we'll do this weird
forced page_cache_read thing to populate the page, and then drop it
again and loop around and find it.  This makes for 2 ways we can read a
page in filemap_fault, and it's not really needed.  Instead add a
FGP_FOR_MMAP flag so that pagecache_get_page() will return a unlocked
page that's in pagecache.  Then use the normal page locking and readpage
logic already in filemap_fault.  This simplifies the no page in page
cache case significantly.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 include/linux/pagemap.h |  1 +
 mm/filemap.c            | 73 ++++++++++---------------------------------------
 2 files changed, 16 insertions(+), 58 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 226f96f0dee0..b13c2442281f 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -252,6 +252,7 @@ pgoff_t page_cache_prev_miss(struct address_space *mapping,
 #define FGP_WRITE		0x00000008
 #define FGP_NOFS		0x00000010
 #define FGP_NOWAIT		0x00000020
+#define FGP_FOR_MMAP		0x00000040
 
 struct page *pagecache_get_page(struct address_space *mapping, pgoff_t offset,
 		int fgp_flags, gfp_t cache_gfp_mask);
diff --git a/mm/filemap.c b/mm/filemap.c
index 81adec8ee02c..f068712c2525 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1503,6 +1503,9 @@ EXPORT_SYMBOL(find_lock_entry);
  *   @gfp_mask and added to the page cache and the VM's LRU
  *   list. The page is returned locked and with an increased
  *   refcount. Otherwise, NULL is returned.
+ * - FGP_FOR_MMAP: Similar to FGP_CREAT, only it unlocks the page after it has
+ *   added it to pagecache, as the mmap code expects to do it's own special
+ *   locking dance.
  *
  * If FGP_LOCK or FGP_CREAT are specified then the function may sleep even
  * if the GFP flags specified for FGP_CREAT are atomic.
@@ -1555,7 +1558,7 @@ struct page *pagecache_get_page(struct address_space *mapping, pgoff_t offset,
 		if (!page)
 			return NULL;
 
-		if (WARN_ON_ONCE(!(fgp_flags & FGP_LOCK)))
+		if (WARN_ON_ONCE(!(fgp_flags & (FGP_LOCK | FGP_FOR_MMAP))))
 			fgp_flags |= FGP_LOCK;
 
 		/* Init accessed so avoid atomic mark_page_accessed later */
@@ -1569,6 +1572,13 @@ struct page *pagecache_get_page(struct address_space *mapping, pgoff_t offset,
 			if (err == -EEXIST)
 				goto repeat;
 		}
+
+		/*
+		 * add_to_page_cache_lru lock's the page, and for mmap we expect
+		 * a unlocked page.
+		 */
+		if (fgp_flags & FGP_FOR_MMAP)
+			unlock_page(page);
 	}
 
 	return page;
@@ -2293,39 +2303,6 @@ generic_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 EXPORT_SYMBOL(generic_file_read_iter);
 
 #ifdef CONFIG_MMU
-/**
- * page_cache_read - adds requested page to the page cache if not already there
- * @file:	file to read
- * @offset:	page index
- * @gfp_mask:	memory allocation flags
- *
- * This adds the requested page to the page cache if it isn't already there,
- * and schedules an I/O to read in its contents from disk.
- */
-static int page_cache_read(struct file *file, pgoff_t offset, gfp_t gfp_mask)
-{
-	struct address_space *mapping = file->f_mapping;
-	struct page *page;
-	int ret;
-
-	do {
-		page = __page_cache_alloc(gfp_mask);
-		if (!page)
-			return -ENOMEM;
-
-		ret = add_to_page_cache_lru(page, mapping, offset, gfp_mask);
-		if (ret == 0)
-			ret = mapping->a_ops->readpage(file, page);
-		else if (ret == -EEXIST)
-			ret = 0; /* losing race to add is OK */
-
-		put_page(page);
-
-	} while (ret == AOP_TRUNCATED_PAGE);
-
-	return ret;
-}
-
 #define MMAP_LOTSAMISS  (100)
 
 /*
@@ -2449,9 +2426,11 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 		count_memcg_event_mm(vmf->vma->vm_mm, PGMAJFAULT);
 		ret = VM_FAULT_MAJOR;
 retry_find:
-		page = find_get_page(mapping, offset);
+		page = pagecache_get_page(mapping, offset,
+					  FGP_CREAT|FGP_FOR_MMAP,
+					  vmf->gfp_mask);
 		if (!page)
-			goto no_cached_page;
+			return vmf_error(-ENOMEM);
 	}
 
 	if (!lock_page_or_retry(page, vmf->vma->vm_mm, vmf->flags)) {
@@ -2488,28 +2467,6 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 	vmf->page = page;
 	return ret | VM_FAULT_LOCKED;
 
-no_cached_page:
-	/*
-	 * We're only likely to ever get here if MADV_RANDOM is in
-	 * effect.
-	 */
-	error = page_cache_read(file, offset, vmf->gfp_mask);
-
-	/*
-	 * The page we want has now been added to the page cache.
-	 * In the unlikely event that someone removed it in the
-	 * meantime, we'll just come back here and read it again.
-	 */
-	if (error >= 0)
-		goto retry_find;
-
-	/*
-	 * An error return from page_cache_read can result if the
-	 * system is low on memory, or a problem occurs while trying
-	 * to schedule I/O.
-	 */
-	return vmf_error(error);
-
 page_not_uptodate:
 	/*
 	 * Umm, take care of errors if the page isn't up-to-date.
-- 
2.14.3


Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E456C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F10932086D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:38:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="dElFjUL6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F10932086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726929AbeLKRiL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 12:38:11 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:37383 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbeLKRiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 12:38:09 -0500
Received: by mail-yw1-f65.google.com with SMTP id h193so5774719ywc.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 09:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=im1lOdR1gtAkoa5Y+U3jnYHZp+MThsPseW0SoznaozY=;
        b=dElFjUL6mOWqvfIN7pdHq7KvdZA/TSnmClfaII8u1KnK8lIDouqSSwhJtv6wLAYSOd
         psu68HLy6vx5qGKAD+FNvOYuyesDwSpolLB537QXJbQKwvHpmTSfPxGxd0ie62LyOsCC
         bPhbIN2J9w1tFmkIljNhcJjwG/uftGhyT+LsISUVoDJigICYVwZH01j2GhAcX3rRW/Fm
         BIPFOk7G8nUUpHBATObKMzuKipM1jsmXCHQ5TF0C9pJEvQx2gIY3Gqdswaq0leQD6qA0
         8s28SZADVdA4PAF0Vhn5vnPOdVA1ssWBoS8ZuKiY4rCAGueaUKtckTaNkxe0Zf1QiBXO
         /hCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=im1lOdR1gtAkoa5Y+U3jnYHZp+MThsPseW0SoznaozY=;
        b=RZYDDcGk79TxfXgbmiGmAFLmCOqatsa4ABDlZVlpk4yHpG3RWjeDwjrRvhGAnp/+tC
         HBSa3Pgx56hLHTDr2TWYvCq9H3OyJSDkRfB36KoZbqy2NJNlh+e0EUPVs1T8Udw+nSSt
         utm5l8/MrEXAtyOXLHCu0oPLzv2VJ2OJ2hVQHKK7AEBtrHX6SBB9rI5PvjBjtBKuIvrN
         k5QfUjlzGiV20ReL758/Yi1/FoAYXayXS+HHOhmpV9KgTFtk8T9zAddjWHHfC3R2AZGq
         zkAY9slKd8mGprov3wMRsO33o5AFbrWPm9Y0/EyVW9Q3M2dL6GEmBSIDzAQXo8uoN2Hb
         7lYA==
X-Gm-Message-State: AA+aEWa2j9jeyGGQk6QqsHrOy4OKdsHcreaRanlVquchsBPVwWV9H9WZ
        9M0GsuNrCmPlLTwc7kDKB7xG7Q==
X-Google-Smtp-Source: AFSGD/UWgQfH/IFA1ziDeQtpo/Az3ijAiizbIBHDC5CCjFtCTgcbOB9TMHT4hPOe6zI/ZWoFy+YT2g==
X-Received: by 2002:a81:56d7:: with SMTP id k206mr17467616ywb.167.1544549887505;
        Tue, 11 Dec 2018 09:38:07 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id v9sm9126070ywh.2.2018.12.11.09.38.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 09:38:06 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     kernel-team@fb.com, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, tj@kernel.org, david@fromorbit.com,
        akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, riel@redhat.com, jack@suse.cz
Subject: [PATCH 1/3] filemap: kill page_cache_read usage in filemap_fault
Date:   Tue, 11 Dec 2018 12:37:59 -0500
Message-Id: <20181211173801.29535-2-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20181211173801.29535-1-josef@toxicpanda.com>
References: <20181211173801.29535-1-josef@toxicpanda.com>
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

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Jan Kara <jack@suse.cz>
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
index 81adec8ee02c..03bce38d8f2b 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1503,6 +1503,9 @@ EXPORT_SYMBOL(find_lock_entry);
  *   @gfp_mask and added to the page cache and the VM's LRU
  *   list. The page is returned locked and with an increased
  *   refcount. Otherwise, NULL is returned.
+ * - FGP_FOR_MMAP: Similar to FGP_CREAT, only we want to allow the caller to do
+ *   its own locking dance if the page is already in cache, or unlock the page
+ *   before returning if we had to add the page to pagecache.
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


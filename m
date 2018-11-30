Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 006F8C64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 19:58:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4B732082F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 19:58:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="pGqfh1b/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4B732082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbeLAHIp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 02:08:45 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:38727 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727018AbeLAHIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 02:08:43 -0500
Received: by mail-yw1-f67.google.com with SMTP id i20so2777031ywc.5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 11:58:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=nUZutRNzquUqiT8YQe9ytPV/656PUstfyd8NxlX/hPI=;
        b=pGqfh1b/nsbK/ZbCXMPcYm87vbT8EJixts8PxW5qh/PS62xI0lfhXgstg/SfXmcgKx
         QL8eZ/eIwVWknS6P3BhLvtDQdWszrYyJ1QwEt94N/dKXdv2geai/8blz0IKRlaedV9a3
         kTTXnVh6UVcSBASSiHhFEJ/XCNZ0i9pc8m87rH/W68Yqp/GhcX/uyHvsmhBMlQeJ+IMm
         nJzEv1nMrwT8VbQFp6GqCt4JSUMGfTDEbIdakFPs2kJcdTQfrMWq4lURis0hDKJXfhnq
         Te6J3KoAQ4jU9tgqDrcyIcSSHxaSDvRoVHvuDbyQj8YPy/lq7/kuL8g4zlM4OIEmaQWV
         BZQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=nUZutRNzquUqiT8YQe9ytPV/656PUstfyd8NxlX/hPI=;
        b=n4bULaYOo5bqv9uUuINKPjerb9kSBIsdlr7hLwF3MnafWqyNXTwWszZIx9Dn4XI5DO
         skhjLzgLKU+3Zpp+N0RgcwofPuuym/7gJtbNgmFsFnCNPOzWw+brcXYi4nbbwkqHxBFH
         88aqnDCotYW7ADid2OiZ9CYBa0OuwbzAHP/6Qv5a5whGqcINzlg7UJKPgcCkThGzpOJm
         dMyuPiJYG3tRiEsulKjYbTmGgC2io6xWSiPTuE9RB1CZQkKK9gzjyGMQYH7C6OWuZnfT
         WzzohLiBV8a2icIz/VgHWsrnBDEh+wwRTzZPDFYKHy3msdJhh2Lb0psO2w/mu46z/8SU
         dkYw==
X-Gm-Message-State: AA+aEWbUOSlfNnukOAN6W6vWk/DueBfYfkKx1odIUWEDWg8f7RxfPF2G
        YQiI0H0YDYC/s4z/O23UiLEg8g==
X-Google-Smtp-Source: AFSGD/UTW3BkBMXkE9PGFk0hChnQLXXRjoCPzae6goRhgMpcuc2F0LFE+t5itICdCj2HY6SpfuWGxg==
X-Received: by 2002:a81:3402:: with SMTP id b2mr7025741ywa.12.1543607899303;
        Fri, 30 Nov 2018 11:58:19 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id p201sm2705356ywe.45.2018.11.30.11.58.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Nov 2018 11:58:18 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     kernel-team@fb.com, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, tj@kernel.org, david@fromorbit.com,
        akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, riel@redhat.com, jack@suse.cz
Subject: [PATCH 3/4] filemap: drop the mmap_sem for all blocking operations
Date:   Fri, 30 Nov 2018 14:58:11 -0500
Message-Id: <20181130195812.19536-4-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20181130195812.19536-1-josef@toxicpanda.com>
References: <20181130195812.19536-1-josef@toxicpanda.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we only drop the mmap_sem if there is contention on the page
lock.  The idea is that we issue readahead and then go to lock the page
while it is under IO and we want to not hold the mmap_sem during the IO.

The problem with this is the assumption that the readahead does
anything.  In the case that the box is under extreme memory or IO
pressure we may end up not reading anything at all for readahead, which
means we will end up reading in the page under the mmap_sem.

Instead rework filemap fault path to drop the mmap sem at any point that
we may do IO or block for an extended period of time.  This includes
while issuing readahead, locking the page, or needing to call ->readpage
because readahead did not occur.  Then once we have a fully uptodate
page we can return with VM_FAULT_RETRY and come back again to find our
nicely in-cache page that was gotten outside of the mmap_sem.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 mm/filemap.c | 113 ++++++++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 93 insertions(+), 20 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index f068712c2525..5e76b24b2a0f 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2304,28 +2304,44 @@ EXPORT_SYMBOL(generic_file_read_iter);
 
 #ifdef CONFIG_MMU
 #define MMAP_LOTSAMISS  (100)
+static struct file *maybe_unlock_mmap_for_io(struct file *fpin,
+					     struct vm_area_struct *vma,
+					     int flags)
+{
+	if (fpin)
+		return fpin;
+	if ((flags & (FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_RETRY_NOWAIT)) ==
+	    FAULT_FLAG_ALLOW_RETRY) {
+		fpin = get_file(vma->vm_file);
+		up_read(&vma->vm_mm->mmap_sem);
+	}
+	return fpin;
+}
 
 /*
  * Synchronous readahead happens when we don't even find
  * a page in the page cache at all.
  */
-static void do_sync_mmap_readahead(struct vm_area_struct *vma,
-				   struct file_ra_state *ra,
-				   struct file *file,
-				   pgoff_t offset)
+static struct file *do_sync_mmap_readahead(struct vm_area_struct *vma,
+					   struct file_ra_state *ra,
+					   struct file *file,
+					   pgoff_t offset,
+					   int flags)
 {
 	struct address_space *mapping = file->f_mapping;
+	struct file *fpin = NULL;
 
 	/* If we don't want any read-ahead, don't bother */
 	if (vma->vm_flags & VM_RAND_READ)
-		return;
+		return fpin;
 	if (!ra->ra_pages)
-		return;
+		return fpin;
 
 	if (vma->vm_flags & VM_SEQ_READ) {
+		fpin = maybe_unlock_mmap_for_io(fpin, vma, flags);
 		page_cache_sync_readahead(mapping, ra, file, offset,
 					  ra->ra_pages);
-		return;
+		return fpin;
 	}
 
 	/* Avoid banging the cache line if not needed */
@@ -2337,37 +2353,43 @@ static void do_sync_mmap_readahead(struct vm_area_struct *vma,
 	 * stop bothering with read-ahead. It will only hurt.
 	 */
 	if (ra->mmap_miss > MMAP_LOTSAMISS)
-		return;
+		return fpin;
 
 	/*
 	 * mmap read-around
 	 */
+	fpin = maybe_unlock_mmap_for_io(fpin, vma, flags);
 	ra->start = max_t(long, 0, offset - ra->ra_pages / 2);
 	ra->size = ra->ra_pages;
 	ra->async_size = ra->ra_pages / 4;
 	ra_submit(ra, mapping, file);
+	return fpin;
 }
 
 /*
  * Asynchronous readahead happens when we find the page and PG_readahead,
  * so we want to possibly extend the readahead further..
  */
-static void do_async_mmap_readahead(struct vm_area_struct *vma,
-				    struct file_ra_state *ra,
-				    struct file *file,
-				    struct page *page,
-				    pgoff_t offset)
+static struct file *do_async_mmap_readahead(struct vm_area_struct *vma,
+					    struct file_ra_state *ra,
+					    struct file *file,
+					    struct page *page,
+					    pgoff_t offset, int flags)
 {
 	struct address_space *mapping = file->f_mapping;
+	struct file *fpin = NULL;
 
 	/* If we don't want any read-ahead, don't bother */
 	if (vma->vm_flags & VM_RAND_READ)
-		return;
+		return fpin;
 	if (ra->mmap_miss > 0)
 		ra->mmap_miss--;
-	if (PageReadahead(page))
+	if (PageReadahead(page)) {
+		fpin = maybe_unlock_mmap_for_io(fpin, vma, flags);
 		page_cache_async_readahead(mapping, ra, file,
 					   page, offset, ra->ra_pages);
+	}
+	return fpin;
 }
 
 /**
@@ -2397,6 +2419,7 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 {
 	int error;
 	struct file *file = vmf->vma->vm_file;
+	struct file *fpin = NULL;
 	struct address_space *mapping = file->f_mapping;
 	struct file_ra_state *ra = &file->f_ra;
 	struct inode *inode = mapping->host;
@@ -2418,10 +2441,12 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 		 * We found the page, so try async readahead before
 		 * waiting for the lock.
 		 */
-		do_async_mmap_readahead(vmf->vma, ra, file, page, offset);
+		fpin = do_async_mmap_readahead(vmf->vma, ra, file, page, offset,
+					       vmf->flags);
 	} else if (!page) {
 		/* No page in the page cache at all */
-		do_sync_mmap_readahead(vmf->vma, ra, file, offset);
+		fpin = do_sync_mmap_readahead(vmf->vma, ra, file, offset,
+					      vmf->flags);
 		count_vm_event(PGMAJFAULT);
 		count_memcg_event_mm(vmf->vma->vm_mm, PGMAJFAULT);
 		ret = VM_FAULT_MAJOR;
@@ -2433,9 +2458,32 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 			return vmf_error(-ENOMEM);
 	}
 
-	if (!lock_page_or_retry(page, vmf->vma->vm_mm, vmf->flags)) {
-		put_page(page);
-		return ret | VM_FAULT_RETRY;
+	/*
+	 * We are open-coding lock_page_or_retry here because we want to do the
+	 * readpage if necessary while the mmap_sem is dropped.  If there
+	 * happens to be a lock on the page but it wasn't being faulted in we'd
+	 * come back around without ALLOW_RETRY set and then have to do the IO
+	 * under the mmap_sem, which would be a bummer.
+	 */
+	if (!trylock_page(page)) {
+		fpin = maybe_unlock_mmap_for_io(fpin, vmf->vma, vmf->flags);
+		if (vmf->flags & FAULT_FLAG_RETRY_NOWAIT)
+			goto out_retry;
+		if (vmf->flags & FAULT_FLAG_KILLABLE) {
+			if (__lock_page_killable(page)) {
+				/*
+				 * If we don't have the right flags for
+				 * maybe_unlock_mmap_for_io to do it's thing we
+				 * still need to drop the sem and return
+				 * VM_FAULT_RETRY so the upper layer checks the
+				 * signal and takes the appropriate action.
+				 */
+				if (!fpin)
+					up_read(&vmf->vma->vm_mm->mmap_sem);
+				goto out_retry;
+			}
+		} else
+			__lock_page(page);
 	}
 
 	/* Did it get truncated? */
@@ -2453,6 +2501,16 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 	if (unlikely(!PageUptodate(page)))
 		goto page_not_uptodate;
 
+	/*
+	 * We've made it this far and we had to drop our mmap_sem, now is the
+	 * time to return to the upper layer and have it re-find the vma and
+	 * redo the fault.
+	 */
+	if (fpin) {
+		unlock_page(page);
+		goto out_retry;
+	}
+
 	/*
 	 * Found the page and have a reference on it.
 	 * We must recheck i_size under page lock.
@@ -2475,12 +2533,15 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 	 * and we need to check for errors.
 	 */
 	ClearPageError(page);
+	fpin = maybe_unlock_mmap_for_io(fpin, vmf->vma, vmf->flags);
 	error = mapping->a_ops->readpage(file, page);
 	if (!error) {
 		wait_on_page_locked(page);
 		if (!PageUptodate(page))
 			error = -EIO;
 	}
+	if (fpin)
+		goto out_retry;
 	put_page(page);
 
 	if (!error || error == AOP_TRUNCATED_PAGE)
@@ -2489,6 +2550,18 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 	/* Things didn't work out. Return zero to tell the mm layer so. */
 	shrink_readahead_size_eio(file, ra);
 	return VM_FAULT_SIGBUS;
+
+out_retry:
+	/*
+	 * We dropped the mmap_sem, we need to return to the fault handler to
+	 * re-find the vma and come back and find our hopefully still populated
+	 * page.
+	 */
+	if (page)
+		put_page(page);
+	if (fpin)
+		fput(fpin);
+	return ret | VM_FAULT_RETRY;
 }
 EXPORT_SYMBOL(filemap_fault);
 
-- 
2.14.3


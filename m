Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11818C64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 19:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEAF82145D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 19:58:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="qE17nE2J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEAF82145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbeLAHIp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 02:08:45 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:42956 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727040AbeLAHIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 02:08:44 -0500
Received: by mail-yb1-f193.google.com with SMTP id s8so545643ybe.9
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 11:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=ZiSWalXRo2lAHNoxFcnCBmYqM80BUgBK6TZ//qlBoW0=;
        b=qE17nE2Jo3x4abm13SJxAAIFGmnZyoF8C/6nu8aRpvS4rDGOAT+NB7nFb5qR/q9r0W
         wyEq3cqlr+cDklN/eobicAnmyPZ5O00B6CLcEWwkMfbaQv2f1e/zarf+qIW/wPERWt9z
         QGzxh3p+tv3y8zML5KreAJ0J0fdK1gQiiTp1jNjrMW9vgTdx5CDjGysHbm7NtzHtqj2z
         G48SlfhBIGMBXljirIlfet56WObqccekan4prBch/7ywFpwIc9gEWxYUBnEKPj4xUmnP
         p7oYI1XwYAfhLaNWOYg0r74CjigClE0qUNLmKqCBjSEdRHgY4p9ac7AqgtmRfyHOfhUM
         7DqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=ZiSWalXRo2lAHNoxFcnCBmYqM80BUgBK6TZ//qlBoW0=;
        b=EMNKU4LZlTOcLDkWsiLDVXZUrnYkO86YRlKw4KAs3LpECLqwMU9Qb+O+qEkeYctzEd
         UwJY7Aj7l2bcpKUMtS5MPKTfGl/JN82Z8JaPIfSZej49q9oi8pVgCe7XvWiqQDPthtdq
         h6NikmdYgFnYGIx2thQ/5sWpADWraS96CuQetqED0kEvvD3wToY58faw3w1tfGEsz7Ub
         EjmUWHlLeP6/9ic4z6BM9aChLLRMNy/SnTloDEYlYfl4yk+RTpe1dI/lkFs2U3lc992H
         yLv9X9Kt+RzariQLYs6B+bhSAj45jqsCDmjVIKhjp38EtlHEsvwNx8i7s80wzq3hgtkR
         cd3w==
X-Gm-Message-State: AA+aEWYjdH2QcNt/pKEn6tQE2L6von/qkOhEUGXgoWr574IKoMP6N9lg
        utO1O7YNK6lWoL07Pdi2y+EZpw==
X-Google-Smtp-Source: AFSGD/WUySeblOm5lO6iEZroC7YfnS5osaYyKXSy7/i64tvWyXdByqa0y4VKPk5GYCaEeI3VijK3IQ==
X-Received: by 2002:a5b:b09:: with SMTP id z9-v6mr6591976ybp.483.1543607900825;
        Fri, 30 Nov 2018 11:58:20 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id z74sm3209536ywz.51.2018.11.30.11.58.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Nov 2018 11:58:20 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     kernel-team@fb.com, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, tj@kernel.org, david@fromorbit.com,
        akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, riel@redhat.com, jack@suse.cz
Subject: [PATCH 4/4] mm: use the cached page for filemap_fault
Date:   Fri, 30 Nov 2018 14:58:12 -0500
Message-Id: <20181130195812.19536-5-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20181130195812.19536-1-josef@toxicpanda.com>
References: <20181130195812.19536-1-josef@toxicpanda.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we drop the mmap_sem we have to redo the vma lookup which requires
redoing the fault handler.  Chances are we will just come back to the
same page, so save this page in our vmf->cached_page and reuse it in the
next loop through the fault handler.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 mm/filemap.c | 45 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 43 insertions(+), 2 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 5e76b24b2a0f..d4385b704e04 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2392,6 +2392,35 @@ static struct file *do_async_mmap_readahead(struct vm_area_struct *vma,
 	return fpin;
 }
 
+static int vmf_has_cached_page(struct vm_fault *vmf, struct page **page)
+{
+	struct page *cached_page = vmf->cached_page;
+	struct mm_struct *mm = vmf->vma->vm_mm;
+	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
+	pgoff_t offset = vmf->pgoff;
+
+	if (!cached_page)
+		return 0;
+
+	if (vmf->flags & FAULT_FLAG_KILLABLE) {
+		int ret = lock_page_killable(cached_page);
+		if (ret) {
+			up_read(&mm->mmap_sem);
+			return ret;
+		}
+	} else
+		lock_page(cached_page);
+	vmf->cached_page = NULL;
+	if (cached_page->mapping == mapping &&
+	    cached_page->index == offset) {
+		*page = cached_page;
+	} else {
+		unlock_page(cached_page);
+		put_page(cached_page);
+	}
+	return 0;
+}
+
 /**
  * filemap_fault - read in file data for page fault handling
  * @vmf:	struct vm_fault containing details of the fault
@@ -2425,13 +2454,24 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 	struct inode *inode = mapping->host;
 	pgoff_t offset = vmf->pgoff;
 	pgoff_t max_off;
-	struct page *page;
+	struct page *page = NULL;
 	vm_fault_t ret = 0;
 
 	max_off = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
 	if (unlikely(offset >= max_off))
 		return VM_FAULT_SIGBUS;
 
+	/*
+	 * We may have read in the page already and have a page from an earlier
+	 * loop.  If so we need to see if this page is still valid, and if not
+	 * do the whole dance over again.
+	 */
+	error = vmf_has_cached_page(vmf, &page);
+	if (error)
+		goto out_retry;
+	if (page)
+		goto have_cached_page;
+
 	/*
 	 * Do we have something in the page cache already?
 	 */
@@ -2492,6 +2532,7 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 		put_page(page);
 		goto retry_find;
 	}
+have_cached_page:
 	VM_BUG_ON_PAGE(page->index != offset, page);
 
 	/*
@@ -2558,7 +2599,7 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 	 * page.
 	 */
 	if (page)
-		put_page(page);
+		vmf->cached_page = page;
 	if (fpin)
 		fput(fpin);
 	return ret | VM_FAULT_RETRY;
-- 
2.14.3


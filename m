Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7553C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E1F12086D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:38:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="onkGNEpE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E1F12086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbeLKRiY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 12:38:24 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:41453 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726864AbeLKRiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 12:38:10 -0500
Received: by mail-yw1-f68.google.com with SMTP id f65so5768067ywc.8
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 09:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=6+vkcIGN+YamTKpLFC2eJaZY1L81O/2cuEfVUcvimSs=;
        b=onkGNEpEitvIeZ44/RIcuW782ouZN+AIDExGya0oL4/MMxV/w9XB86uQL5NP8YT3Uh
         Ldt9XIc+hhNKBWSRlYXdXI/xf/dA0+YR11iXs9YVxvs0CAFtb7h1PK8GVdKs0avLVv4f
         XuIo7BsuQO9iinP2mFVQm6jBbdUi+jcVXfSbPz6XkpP0z9tKdi9uBlIGfX3HTkN3qAQ9
         ewSm38NfjZyTBLQhZT4diQ/BZOEyCi73uu5QRkYSA+10SCWr/TxJRu1zrKNDLhZtnWS7
         QJ5APV9ViQ29QhQ7oYaeWLlefesxlE6NFjt9fqmZVh1FAT1/kdIOoSz18J6jw0B5lvW8
         q+Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=6+vkcIGN+YamTKpLFC2eJaZY1L81O/2cuEfVUcvimSs=;
        b=N6B3r/c8PXFvZC3WNkb0VMaahLcprOTURwwlMVGaWfHTwlpdWPaistqm1OEMHFbgyl
         /kXujSnFBrHMBjI6p98IluiuSEjh6dIic185KXPC/M4fpo7Jmj6P/mw3q5TKh4f2R1kX
         UOFMI9ITOkALw7VDBu/fuf9qj0gUeH35FfiTWpbzDk6sDoJDh4thD9WN7xYVRR8V9H0v
         AgcaJmJfrULyJ18kzvYIiQCv1XO425TZfy1qL65CpmJZlBFfReKDoCSm2j8zMuSEnpx7
         TXvebIpGL8QIdwZij/P4JuqsUxr2UX2WLfgK57yF54+h2zeFrj1bmDOVsDmmYIZ/TgJ1
         bX4A==
X-Gm-Message-State: AA+aEWYsRHrlD7wgfFC2VRhASySMV7KgDnESVUrAgm0SjGvr5yMum8of
        mG5WIq2eOgONYmrQC48CCpNEEQ==
X-Google-Smtp-Source: AFSGD/XccZVEgPPADPt/cOfRZXy8NZ7T8tBSjBCA67NDe3BpbKl19fBn7azKUeq90W3w2fh4vaR7SQ==
X-Received: by 2002:a81:33c4:: with SMTP id z187mr17904067ywz.294.1544549889022;
        Tue, 11 Dec 2018 09:38:09 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id m67sm4619269ywb.54.2018.12.11.09.38.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 09:38:08 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     kernel-team@fb.com, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, tj@kernel.org, david@fromorbit.com,
        akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, riel@redhat.com, jack@suse.cz
Subject: [PATCH 2/3] filemap: pass vm_fault to the mmap ra helpers
Date:   Tue, 11 Dec 2018 12:38:00 -0500
Message-Id: <20181211173801.29535-3-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20181211173801.29535-1-josef@toxicpanda.com>
References: <20181211173801.29535-1-josef@toxicpanda.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All of the arguments to these functions come from the vmf, and the
following patches are going to add more arguments.  Cut down on the
amount of arguments passed by simply passing in the vmf to these two
helpers.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 mm/filemap.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 03bce38d8f2b..8fc45f24b201 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2309,20 +2309,20 @@ EXPORT_SYMBOL(generic_file_read_iter);
  * Synchronous readahead happens when we don't even find
  * a page in the page cache at all.
  */
-static void do_sync_mmap_readahead(struct vm_area_struct *vma,
-				   struct file_ra_state *ra,
-				   struct file *file,
-				   pgoff_t offset)
+static void do_sync_mmap_readahead(struct vm_fault *vmf)
 {
+	struct file *file = vmf->vma->vm_file;
+	struct file_ra_state *ra = &file->f_ra;
 	struct address_space *mapping = file->f_mapping;
+	pgoff_t offset = vmf->pgoff;
 
 	/* If we don't want any read-ahead, don't bother */
-	if (vma->vm_flags & VM_RAND_READ)
+	if (vmf->vma->vm_flags & VM_RAND_READ)
 		return;
 	if (!ra->ra_pages)
 		return;
 
-	if (vma->vm_flags & VM_SEQ_READ) {
+	if (vmf->vma->vm_flags & VM_SEQ_READ) {
 		page_cache_sync_readahead(mapping, ra, file, offset,
 					  ra->ra_pages);
 		return;
@@ -2352,16 +2352,16 @@ static void do_sync_mmap_readahead(struct vm_area_struct *vma,
  * Asynchronous readahead happens when we find the page and PG_readahead,
  * so we want to possibly extend the readahead further..
  */
-static void do_async_mmap_readahead(struct vm_area_struct *vma,
-				    struct file_ra_state *ra,
-				    struct file *file,
-				    struct page *page,
-				    pgoff_t offset)
+static void do_async_mmap_readahead(struct vm_fault *vmf,
+				    struct page *page)
 {
+	struct file *file = vmf->vma->vm_file;
+	struct file_ra_state *ra = &file->f_ra;
 	struct address_space *mapping = file->f_mapping;
+	pgoff_t offset = vmf->pgoff;
 
 	/* If we don't want any read-ahead, don't bother */
-	if (vma->vm_flags & VM_RAND_READ)
+	if (vmf->vma->vm_flags & VM_RAND_READ)
 		return;
 	if (ra->mmap_miss > 0)
 		ra->mmap_miss--;
@@ -2418,10 +2418,10 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 		 * We found the page, so try async readahead before
 		 * waiting for the lock.
 		 */
-		do_async_mmap_readahead(vmf->vma, ra, file, page, offset);
+		do_async_mmap_readahead(vmf, page);
 	} else if (!page) {
 		/* No page in the page cache at all */
-		do_sync_mmap_readahead(vmf->vma, ra, file, offset);
+		do_sync_mmap_readahead(vmf);
 		count_vm_event(PGMAJFAULT);
 		count_memcg_event_mm(vmf->vma->vm_mm, PGMAJFAULT);
 		ret = VM_FAULT_MAJOR;
-- 
2.14.3


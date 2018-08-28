Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6460C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 19:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 615472087E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 19:22:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EV1jkv0I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 615472087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbeH1XPx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 19:15:53 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33763 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbeH1XPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 19:15:53 -0400
Received: by mail-pf1-f196.google.com with SMTP id d4-v6so1166501pfn.0;
        Tue, 28 Aug 2018 12:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=tMdwG7FJ+l5cva83K4fS0hRTNcr1Hap1oieDk6DpdyU=;
        b=EV1jkv0I7LLd31hjLdwlkg9nIMr0TiVyEMAlf6TbnYSzGP9k4SHB5TvVXfWTrBGc+9
         2fndePS5cmsJ8asPSnbA3GAVoUu2wdYXmY2gGMYpT5Tq63dtVAeJB91BH4wDmbGXBZgt
         wVuMPZXRi7CsP1Uzl4ZI1oRBW0HsTlGEYPsklrBKNL90fB+iLeCXLAWWXB2NMjN4zzEP
         8Mv0ajdOSelO8/a2jtJexRnW0Lt2e+ozHEEsktvO9NbAa+tY6OmpfmZNDa4PMxRsYKAM
         9980ljUaNPaTiky6Gby8bFqLFcfaUF8VNVYAWCXhiUqdspFwel/82WxY9U3KczyTOGCD
         yVjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=tMdwG7FJ+l5cva83K4fS0hRTNcr1Hap1oieDk6DpdyU=;
        b=JocVP87pFX0aOj8LXEcsAtBXo3fgLhLFTbHXhalreJK50CUP5UWPwDcImjbknKIRF4
         y81hxJoPBD+mBxs3UlfEac8/S6xmb0l7CxkGhWg1c+sSJ6sqsibbKtsUBLg8stuwEVSE
         1A6xe4zMadEo6ZnPR+uzBUSHJNHOmYLYe9EiAnYHrMOREpuzlYRAbDtoZGbi8jsrXQgI
         QfX22H+DZphvcmut69zoyKdHR2DOGNKsACJRn2yEABcVS3BDEJfLWzqkrUKT7q2Hea6P
         7s1NJFC+LZTKtABnGgaQqSdwc/Rh6ET8zA+NZqrD/A3fywqE/OIAeVNq0OCLOZzLOXY2
         dSdQ==
X-Gm-Message-State: APzg51CsJFeStSz2Xv5RatrkefvF9QbLrPmYCt88NM89ooR4HdvbpBLB
        07qOYclfmSeswcQFMgXR/8dopIsz
X-Google-Smtp-Source: ANB0VdY1rcuMUt80fziHEf33xQupVJlaPAzQC7yBRNnICuVay9T6M7C3R1V7UEbsAf+KA7OQYWlZcA==
X-Received: by 2002:a63:ce12:: with SMTP id y18-v6mr2799832pgf.144.1535484167759;
        Tue, 28 Aug 2018 12:22:47 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC ([2405:204:560d:9e3:a1d1:bce6:673e:c4b3])
        by smtp.gmail.com with ESMTPSA id 16-v6sm3444804pfo.164.2018.08.28.12.22.40
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 28 Aug 2018 12:22:46 -0700 (PDT)
Date:   Wed, 29 Aug 2018 00:55:28 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     willy@infradead.org, viro@zeniv.linux.org.uk, tytso@mit.edu,
        adilger.kernel@dilger.ca, konishi.ryusuke@lab.ntt.co.jp,
        darrick.wong@oracle.com, axboe@kernel.dk, ebiggers@google.com,
        tglx@linutronix.de, gregkh@linuxfoundation.org,
        kemi.wang@intel.com, akpm@linux-foundation.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-nilfs@vger.kernel.org
Subject: [PATCH] fs: Convert return type int to vm_fault_t
Message-ID: <20180828192528.GA24453@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return type for fault handlers  in ext4 and nilfs are
changed to use vm_fault_t.

Return type of block_page_mkwrite() is changed from
int to vm_fault_t. The function signature of
block_page_mkwrite() is changed to add one new parameter
int *err. This will provide a way for caller functions
to get error number along with VM_FAULT return value and
use it further.

Return type of block_page_mkwrite_return() is also changed
to use new vm_fault_t type.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 fs/buffer.c                 | 20 +++++++++++---------
 fs/ext4/ext4.h              |  4 ++--
 fs/ext4/inode.c             | 34 ++++++++++++++++++----------------
 fs/nilfs2/file.c            | 16 ++++++++++------
 include/linux/buffer_head.h |  7 ++++---
 5 files changed, 45 insertions(+), 36 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index ebf78ab..aacfc73 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2487,21 +2487,21 @@ int block_commit_write(struct page *page, unsigned from, unsigned to)
  * Direct callers of this function should protect against filesystem freezing
  * using sb_start_pagefault() - sb_end_pagefault() functions.
  */
-int block_page_mkwrite(struct vm_area_struct *vma, struct vm_fault *vmf,
-			 get_block_t get_block)
+vm_fault_t block_page_mkwrite(struct vm_area_struct *vma, struct vm_fault *vmf,
+			 get_block_t get_block, int *err)
 {
 	struct page *page = vmf->page;
 	struct inode *inode = file_inode(vma->vm_file);
 	unsigned long end;
 	loff_t size;
-	int ret;
+	int err1;
 
 	lock_page(page);
 	size = i_size_read(inode);
 	if ((page->mapping != inode->i_mapping) ||
 	    (page_offset(page) > size)) {
 		/* We overload EFAULT to mean page got truncated */
-		ret = -EFAULT;
+		err1 = -EFAULT;
 		goto out_unlock;
 	}
 
@@ -2511,18 +2511,20 @@ int block_page_mkwrite(struct vm_area_struct *vma, struct vm_fault *vmf,
 	else
 		end = PAGE_SIZE;
 
-	ret = __block_write_begin(page, 0, end, get_block);
-	if (!ret)
-		ret = block_commit_write(page, 0, end);
+	err1 = __block_write_begin(page, 0, end, get_block);
+	if (!err1)
+		err1 = block_commit_write(page, 0, end);
 
-	if (unlikely(ret < 0))
+	if (unlikely(err1 < 0))
 		goto out_unlock;
+	*err = err1;
 	set_page_dirty(page);
 	wait_for_stable_page(page);
 	return 0;
 out_unlock:
 	unlock_page(page);
-	return ret;
+	*err = err1;
+	return block_page_mkwrite_return(err1);
 }
 EXPORT_SYMBOL(block_page_mkwrite);
 
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 0f0edd1..8506b14 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2469,8 +2469,8 @@ int do_journal_get_write_access(handle_t *handle,
 extern int ext4_chunk_trans_blocks(struct inode *, int nrblocks);
 extern int ext4_zero_partial_blocks(handle_t *handle, struct inode *inode,
 			     loff_t lstart, loff_t lend);
-extern int ext4_page_mkwrite(struct vm_fault *vmf);
-extern int ext4_filemap_fault(struct vm_fault *vmf);
+extern vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf);
+extern vm_fault_t ext4_filemap_fault(struct vm_fault *vmf);
 extern qsize_t *ext4_get_reserved_space(struct inode *inode);
 extern int ext4_get_projid(struct inode *inode, kprojid_t *projid);
 extern void ext4_da_update_reserve_space(struct inode *inode,
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 82adee7..1062a8e 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -6151,39 +6151,40 @@ static int ext4_bh_unmapped(handle_t *handle, struct buffer_head *bh)
 	return !buffer_mapped(bh);
 }
 
-int ext4_page_mkwrite(struct vm_fault *vmf)
+vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	struct page *page = vmf->page;
 	loff_t size;
 	unsigned long len;
-	int ret;
+	vm_fault_t ret;
 	struct file *file = vma->vm_file;
 	struct inode *inode = file_inode(file);
 	struct address_space *mapping = inode->i_mapping;
 	handle_t *handle;
 	get_block_t *get_block;
-	int retries = 0;
+	int retries = 0, err;
 
 	sb_start_pagefault(inode->i_sb);
 	file_update_time(vma->vm_file);
 
 	down_read(&EXT4_I(inode)->i_mmap_sem);
 
-	ret = ext4_convert_inline_data(inode);
-	if (ret)
+	err = ext4_convert_inline_data(inode);
+	if (err)
 		goto out_ret;
 
+	err = 0;
 	/* Delalloc case is easy... */
 	if (test_opt(inode->i_sb, DELALLOC) &&
 	    !ext4_should_journal_data(inode) &&
 	    !ext4_nonda_switch(inode->i_sb)) {
 		do {
 			ret = block_page_mkwrite(vma, vmf,
-						   ext4_da_get_block_prep);
-		} while (ret == -ENOSPC &&
+					ext4_da_get_block_prep, &err);
+		} while (err == -ENOSPC &&
 		       ext4_should_retry_alloc(inode->i_sb, &retries));
-		goto out_ret;
+		goto out;
 	}
 
 	lock_page(page);
@@ -6226,36 +6227,37 @@ int ext4_page_mkwrite(struct vm_fault *vmf)
 		ret = VM_FAULT_SIGBUS;
 		goto out;
 	}
-	ret = block_page_mkwrite(vma, vmf, get_block);
+	err = 0;
+	ret = block_page_mkwrite(vma, vmf, get_block, &err);
 	if (!ret && ext4_should_journal_data(inode)) {
 		if (ext4_walk_page_buffers(handle, page_buffers(page), 0,
 			  PAGE_SIZE, NULL, do_journal_get_write_access)) {
 			unlock_page(page);
-			ret = VM_FAULT_SIGBUS;
 			ext4_journal_stop(handle);
 			goto out;
 		}
 		ext4_set_inode_state(inode, EXT4_STATE_JDATA);
 	}
 	ext4_journal_stop(handle);
-	if (ret == -ENOSPC && ext4_should_retry_alloc(inode->i_sb, &retries))
+	if (err == -ENOSPC &&
+		ext4_should_retry_alloc(inode->i_sb, &retries))
 		goto retry_alloc;
 out_ret:
-	ret = block_page_mkwrite_return(ret);
+	ret = block_page_mkwrite_return(err);
 out:
 	up_read(&EXT4_I(inode)->i_mmap_sem);
 	sb_end_pagefault(inode->i_sb);
 	return ret;
 }
 
-int ext4_filemap_fault(struct vm_fault *vmf)
+vm_fault_t ext4_filemap_fault(struct vm_fault *vmf)
 {
 	struct inode *inode = file_inode(vmf->vma->vm_file);
-	int err;
+	vm_fault_t ret;
 
 	down_read(&EXT4_I(inode)->i_mmap_sem);
-	err = filemap_fault(vmf);
+	ret = filemap_fault(vmf);
 	up_read(&EXT4_I(inode)->i_mmap_sem);
 
-	return err;
+	return ret;
 }
diff --git a/fs/nilfs2/file.c b/fs/nilfs2/file.c
index 7da0fac..58d2a81 100644
--- a/fs/nilfs2/file.c
+++ b/fs/nilfs2/file.c
@@ -57,7 +57,8 @@ static vm_fault_t nilfs_page_mkwrite(struct vm_fault *vmf)
 	struct page *page = vmf->page;
 	struct inode *inode = file_inode(vma->vm_file);
 	struct nilfs_transaction_info ti;
-	int ret = 0;
+	vm_fault_t ret = VM_FAULT_LOCKED;
+	int err = 0;
 
 	if (unlikely(nilfs_near_disk_full(inode->i_sb->s_fs_info)))
 		return VM_FAULT_SIGBUS; /* -ENOSPC */
@@ -67,7 +68,7 @@ static vm_fault_t nilfs_page_mkwrite(struct vm_fault *vmf)
 	if (page->mapping != inode->i_mapping ||
 	    page_offset(page) >= i_size_read(inode) || !PageUptodate(page)) {
 		unlock_page(page);
-		ret = -EFAULT;	/* make the VM retry the fault */
+		ret = VM_FAULT_NOPAGE;	/* make the VM retry the fault */
 		goto out;
 	}
 
@@ -99,13 +100,16 @@ static vm_fault_t nilfs_page_mkwrite(struct vm_fault *vmf)
 	/*
 	 * fill hole blocks
 	 */
-	ret = nilfs_transaction_begin(inode->i_sb, &ti, 1);
+	err = nilfs_transaction_begin(inode->i_sb, &ti, 1);
 	/* never returns -ENOMEM, but may return -ENOSPC */
-	if (unlikely(ret))
+	if (unlikely(err)) {
+		ret = block_page_mkwrite_return(err);
 		goto out;
+	}
 
+	err = 0;
 	file_update_time(vma->vm_file);
-	ret = block_page_mkwrite(vma, vmf, nilfs_get_block);
+	ret = block_page_mkwrite(vma, vmf, nilfs_get_block, &err);
 	if (ret) {
 		nilfs_transaction_abort(inode->i_sb);
 		goto out;
@@ -117,7 +121,7 @@ static vm_fault_t nilfs_page_mkwrite(struct vm_fault *vmf)
 	wait_for_stable_page(page);
  out:
 	sb_end_pagefault(inode->i_sb);
-	return block_page_mkwrite_return(ret);
+	return ret;
 }
 
 static const struct vm_operations_struct nilfs_file_vm_ops = {
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 96225a7..e212b13 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -14,6 +14,7 @@
 #include <linux/pagemap.h>
 #include <linux/wait.h>
 #include <linux/atomic.h>
+#include <linux/mm_types.h>
 
 #ifdef CONFIG_BLOCK
 
@@ -239,10 +240,10 @@ int cont_write_begin(struct file *, struct address_space *, loff_t,
 			get_block_t *, loff_t *);
 int generic_cont_expand_simple(struct inode *inode, loff_t size);
 int block_commit_write(struct page *page, unsigned from, unsigned to);
-int block_page_mkwrite(struct vm_area_struct *vma, struct vm_fault *vmf,
-				get_block_t get_block);
+vm_fault_t block_page_mkwrite(struct vm_area_struct *vma, struct vm_fault *vmf,
+				get_block_t get_block, int *err);
 /* Convert errno to return value from ->page_mkwrite() call */
-static inline int block_page_mkwrite_return(int err)
+static inline vm_fault_t block_page_mkwrite_return(int err)
 {
 	if (err == 0)
 		return VM_FAULT_LOCKED;
-- 
1.9.1


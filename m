Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 249E2C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81F0B20870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:43:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vax72UFD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81F0B20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbeIJUhs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 16:37:48 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46556 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727411AbeIJUhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 16:37:47 -0400
Received: by mail-pl1-f193.google.com with SMTP id t19-v6so9919367ply.13;
        Mon, 10 Sep 2018 08:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=7gP8YF+dbgA/0oN1jSONB2qrkpYUBb4pOOPGQkcHWFQ=;
        b=Vax72UFDo+SMtm8eadlSU3esrBPu8iJ9vEM9c/dj/FvAAIMII7NxXy8+N0779cG1ZL
         lTG0bL9HNCfDuiS8TMvouDnuSZXiL7t1cl91Pl1i0p716lyv1FWfFVrMqopxP5iq2YA/
         QsQAgvtOp9cUh1q5CN6hLjsdUbGEqzn2n+b/V/Ls5lssRhFeW/GpQf3y6myKbvjOZSIj
         FzllUsz4elEI2axoBOgCbPwChfQIITuoeo4YSii2fdTlDoiJV/8Ol/NFT1dMKhb4bki0
         Vw9PZhPjmucZSxuNfHXWIuTSVnO9ps8B/j1LXp9qbHfLqkLVvPmN6ZWmWSdwsAiN9LjS
         vPGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=7gP8YF+dbgA/0oN1jSONB2qrkpYUBb4pOOPGQkcHWFQ=;
        b=sRg95YhOBTCrDQiUYgIBw4l97l1iTrBWjOdCcIjqUd+vtUBKUpDBe5A4J71y3fnt0G
         BURpq+/Z02RlUxgGxK69xjbpUGPzt+uQPxsEw1vR+PwCR6CvS1inY+wfbvY8l8/3j4p9
         opfN1uhxxgAthV6bJZBIYfjRyz1PDLlhKAfDjUKvAtuWAua0sQWjpWOJ0E4hmEV66N5a
         0B6VclYgO72y+XOxqVYDqP+2oLf5yJavSajnA0SZojE+v8KG5KLRF5puuyB4lhozKEMi
         qvN05eTVsopp6X3IgLdydnRqMDtvdW+BJwbYaSp64NGJMX9Q+G5egWOJVwKvoevc98GL
         stFQ==
X-Gm-Message-State: APzg51BlSNAAgIaLH6LAy6F25QyEWfRJNJefR2aL4fno5NH+kEzvIRRm
        93zGOBKd6nnnqSQY4js92kDG7K9o
X-Google-Smtp-Source: ANB0VdZnbWXJmhFXFofqCrDYAQhFGC/22jatG+I3ou/i27IpzJSs7ywzlrVW/nhaJmNowgEc1TE69A==
X-Received: by 2002:a17:902:a9ca:: with SMTP id b10-v6mr22220180plr.198.1536594186233;
        Mon, 10 Sep 2018 08:43:06 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC ([49.205.216.47])
        by smtp.gmail.com with ESMTPSA id t14-v6sm18045015pgu.0.2018.09.10.08.43.04
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 10 Sep 2018 08:43:04 -0700 (PDT)
Date:   Mon, 10 Sep 2018 21:16:12 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, darrick.wong@oracle.com,
        axboe@kernel.dk, nborisov@suse.com, ak@linux.intel.com,
        viro@zeniv.linux.org.uk, kemi.wang@intel.com, willy@infradead.org,
        gregkh@linuxfoundation.org, ebiggers@google.com
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fs/ext4: Convert fault handler to use vm_fault_t type
Message-ID: <20180910154611.GA20252@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return type of ext4_page_mkwrite and ext4_filemap_fault are
changed to use vm_fault_t type.

With this patch all the callers of block_page_mkwrite_return()
are changed to handle vm_fault_t. So converting the return type
of block_page_mkwrite_return() to vm_fault_t.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 fs/ext4/ext4.h              |  4 ++--
 fs/ext4/inode.c             | 29 +++++++++++++++--------------
 include/linux/buffer_head.h |  2 +-
 3 files changed, 18 insertions(+), 17 deletions(-)

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
index d0dd585..7c1723b 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -6151,13 +6151,14 @@ static int ext4_bh_unmapped(handle_t *handle, struct buffer_head *bh)
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
+	int err;
+	vm_fault_t ret;
 	struct file *file = vma->vm_file;
 	struct inode *inode = file_inode(file);
 	struct address_space *mapping = inode->i_mapping;
@@ -6170,8 +6171,8 @@ int ext4_page_mkwrite(struct vm_fault *vmf)
 
 	down_read(&EXT4_I(inode)->i_mmap_sem);
 
-	ret = ext4_convert_inline_data(inode);
-	if (ret)
+	err = ext4_convert_inline_data(inode);
+	if (err)
 		goto out_ret;
 
 	/* Delalloc case is easy... */
@@ -6179,9 +6180,9 @@ int ext4_page_mkwrite(struct vm_fault *vmf)
 	    !ext4_should_journal_data(inode) &&
 	    !ext4_nonda_switch(inode->i_sb)) {
 		do {
-			ret = block_page_mkwrite(vma, vmf,
+			err = block_page_mkwrite(vma, vmf,
 						   ext4_da_get_block_prep);
-		} while (ret == -ENOSPC &&
+		} while (err == -ENOSPC &&
 		       ext4_should_retry_alloc(inode->i_sb, &retries));
 		goto out_ret;
 	}
@@ -6226,8 +6227,8 @@ int ext4_page_mkwrite(struct vm_fault *vmf)
 		ret = VM_FAULT_SIGBUS;
 		goto out;
 	}
-	ret = block_page_mkwrite(vma, vmf, get_block);
-	if (!ret && ext4_should_journal_data(inode)) {
+	err = block_page_mkwrite(vma, vmf, get_block);
+	if (!err && ext4_should_journal_data(inode)) {
 		if (ext4_walk_page_buffers(handle, page_buffers(page), 0,
 			  PAGE_SIZE, NULL, do_journal_get_write_access)) {
 			unlock_page(page);
@@ -6238,24 +6239,24 @@ int ext4_page_mkwrite(struct vm_fault *vmf)
 		ext4_set_inode_state(inode, EXT4_STATE_JDATA);
 	}
 	ext4_journal_stop(handle);
-	if (ret == -ENOSPC && ext4_should_retry_alloc(inode->i_sb, &retries))
+	if (err == -ENOSPC && ext4_should_retry_alloc(inode->i_sb, &retries))
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
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 96225a7..7b73ef7 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -242,7 +242,7 @@ int cont_write_begin(struct file *, struct address_space *, loff_t,
 int block_page_mkwrite(struct vm_area_struct *vma, struct vm_fault *vmf,
 				get_block_t get_block);
 /* Convert errno to return value from ->page_mkwrite() call */
-static inline int block_page_mkwrite_return(int err)
+static inline vm_fault_t block_page_mkwrite_return(int err)
 {
 	if (err == 0)
 		return VM_FAULT_LOCKED;
-- 
1.9.1


Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB1AFD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 14:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA23120870
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 14:59:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q0v0Ntoz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA23120870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731783AbeG3QeY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 12:34:24 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39537 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727119AbeG3QeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 12:34:23 -0400
Received: by mail-pf1-f195.google.com with SMTP id j8-v6so4651732pff.6;
        Mon, 30 Jul 2018 07:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Zo2IcPN+YDyX615MW/9rPyYaNzvi5cxf3kzJtY5lUgM=;
        b=Q0v0NtozO+5aZLchbMn8BjDeX4dGlRYKpPJw/HgqKZCYQIEgqUi+tU3YjDv7ALwXh3
         UquM+rDYUjyq18bLA6eAwkwXvR4CqhGyArLi6kpg58wCaA9pBRd8vJtaXOsT2+qgq8rO
         Q3dsWSiOWN9BQ0bn//iupuuYaQQ6cSVzw9lU4TcW2ww5vl1MMicz8T1MiWmG+rqD37YC
         cSC+WgFnooIegXmBC4Cs18H3IJ5iHE4JqCvV8n/Be066+hRvv6EhIjB4emIsojt60IN+
         vWRNHz/mReNxCeMbiLJZpDVwnnI9wC+F0E6IqMHBPrcnBfOMKUMMNInvrH2uDt3JSFHn
         9eVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Zo2IcPN+YDyX615MW/9rPyYaNzvi5cxf3kzJtY5lUgM=;
        b=CO3TvoNUKTFypqyYX3fTIoZ7LZjt8ezbXQFbQG8sINtlUVtEicjC7TBSZLtgcqffvE
         15dSc23tJmHdMQlx/PmeY4vZVG6t4tIlTePdEyGlpX25m+ncjA7IMtdAGWZUXtVD64U9
         +pT//XhD9cI4+ZHQVLSkTlj8BBLpvJCw+Xs4GpMwrJVbdQoHkXCsNjQ58wNLiID/AtL/
         oItx9Umef/ud7a+GFLAuuWQBr/kKUGPnmUD5+W/MB75GabWFUkQhCfwCSpsu14Kmxv8b
         R+wMFL6rvGpaFhMm/0G+naLpuJxh4j1xdwwYiPORFjrS0ekhfdAzWIfzMCwNzJIsNTx2
         Dz7Q==
X-Gm-Message-State: AOUpUlHg10sZtel3BW/XJAwvFu5BiSdeKsHPnTPHHZv+bRAy0oBq4tCH
        zowp9rtI8iYfcCtLNNVctA4=
X-Google-Smtp-Source: AAOMgpdcedJkkiIlOjozBl3Yv4qaYXjK2EpTeq85lOKmS1veG6Ftfq572FcDLX6uWRr7+BLLW0Z4gw==
X-Received: by 2002:a63:e40d:: with SMTP id a13-v6mr7946037pgi.289.1532962740722;
        Mon, 30 Jul 2018 07:59:00 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC ([2405:204:5404:362:7122:cc54:b987:a840])
        by smtp.gmail.com with ESMTPSA id f67-v6sm20257954pfe.75.2018.07.30.07.58.58
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 30 Jul 2018 07:58:59 -0700 (PDT)
Date:   Mon, 30 Jul 2018 20:31:42 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     viro@zeniv.linux.org.uk, konishi.ryusuke@lab.ntt.co.jp,
        axboe@kernel.dk, darrick.wong@oracle.com, ebiggers@google.com,
        kstewart@linuxfoundation.org, gregkh@linuxfoundation.org,
        kemi.wang@intel.com, willy@infradead.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nilfs@vger.kernel.org, sabyasachi.linux@gmail.com,
        brajeswar.linux@gmail.com
Subject: [PATCH v2] fs/buffer: Convert return type int to vm_fault_t
Message-ID: <20180730150142.GA8414@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return type of block_page_mkwrite() is converted to
vm_fault_t type. The caller of block_page_mkwrite
inside fs/nilfs2 nilfs_page_mkwrite converted accordingly.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
v2: Address Jens's comment. Remove ret variable
    from block_page_mkwrite().

 fs/buffer.c                 | 16 ++++++++--------
 fs/nilfs2/file.c            | 13 ++++++++-----
 include/linux/buffer_head.h |  2 +-
 3 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index cabc045..aeed99f 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2444,21 +2444,21 @@ int block_commit_write(struct page *page, unsigned from, unsigned to)
  * Direct callers of this function should protect against filesystem freezing
  * using sb_start_pagefault() - sb_end_pagefault() functions.
  */
-int block_page_mkwrite(struct vm_area_struct *vma, struct vm_fault *vmf,
+vm_fault_t block_page_mkwrite(struct vm_area_struct *vma, struct vm_fault *vmf,
 			 get_block_t get_block)
 {
 	struct page *page = vmf->page;
 	struct inode *inode = file_inode(vma->vm_file);
 	unsigned long end;
 	loff_t size;
-	int ret;
+	int err;
 
 	lock_page(page);
 	size = i_size_read(inode);
 	if ((page->mapping != inode->i_mapping) ||
 	    (page_offset(page) > size)) {
 		/* We overload EFAULT to mean page got truncated */
-		ret = -EFAULT;
+		err = -EFAULT;
 		goto out_unlock;
 	}
 
@@ -2468,18 +2468,18 @@ int block_page_mkwrite(struct vm_area_struct *vma, struct vm_fault *vmf,
 	else
 		end = PAGE_SIZE;
 
-	ret = __block_write_begin(page, 0, end, get_block);
-	if (!ret)
-		ret = block_commit_write(page, 0, end);
+	err = __block_write_begin(page, 0, end, get_block);
+	if (!err)
+		err = block_commit_write(page, 0, end);
 
-	if (unlikely(ret < 0))
+	if (unlikely(err < 0))
 		goto out_unlock;
 	set_page_dirty(page);
 	wait_for_stable_page(page);
 	return 0;
 out_unlock:
 	unlock_page(page);
-	return ret;
+	return block_page_mkwrite_return(err);
 }
 EXPORT_SYMBOL(block_page_mkwrite);
 
diff --git a/fs/nilfs2/file.c b/fs/nilfs2/file.c
index c5fa3de..da2759e 100644
--- a/fs/nilfs2/file.c
+++ b/fs/nilfs2/file.c
@@ -57,7 +57,8 @@ static int nilfs_page_mkwrite(struct vm_fault *vmf)
 	struct page *page = vmf->page;
 	struct inode *inode = file_inode(vma->vm_file);
 	struct nilfs_transaction_info ti;
-	int ret = 0;
+	vm_fault_t ret = VM_FAULT_LOCKED;
+	int err = 0;
 
 	if (unlikely(nilfs_near_disk_full(inode->i_sb->s_fs_info)))
 		return VM_FAULT_SIGBUS; /* -ENOSPC */
@@ -67,7 +68,7 @@ static int nilfs_page_mkwrite(struct vm_fault *vmf)
 	if (page->mapping != inode->i_mapping ||
 	    page_offset(page) >= i_size_read(inode) || !PageUptodate(page)) {
 		unlock_page(page);
-		ret = -EFAULT;	/* make the VM retry the fault */
+		ret = VM_FAULT_NOPAGE;	/* make the VM retry the fault */
 		goto out;
 	}
 
@@ -99,10 +100,12 @@ static int nilfs_page_mkwrite(struct vm_fault *vmf)
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
 
 	file_update_time(vma->vm_file);
 	ret = block_page_mkwrite(vma, vmf, nilfs_get_block);
@@ -117,7 +120,7 @@ static int nilfs_page_mkwrite(struct vm_fault *vmf)
 	wait_for_stable_page(page);
  out:
 	sb_end_pagefault(inode->i_sb);
-	return block_page_mkwrite_return(ret);
+	return ret;
 }
 
 static const struct vm_operations_struct nilfs_file_vm_ops = {
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index ed7a81b..7184c6e 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -240,7 +240,7 @@ int cont_write_begin(struct file *, struct address_space *, loff_t,
 			get_block_t *, loff_t *);
 int generic_cont_expand_simple(struct inode *inode, loff_t size);
 int block_commit_write(struct page *page, unsigned from, unsigned to);
-int block_page_mkwrite(struct vm_area_struct *vma, struct vm_fault *vmf,
+vm_fault_t block_page_mkwrite(struct vm_area_struct *vma, struct vm_fault *vmf,
 				get_block_t get_block);
 /* Convert errno to return value from ->page_mkwrite() call */
 static inline vm_fault_t block_page_mkwrite_return(int err)
-- 
1.9.1


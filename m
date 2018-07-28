Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 739DFC28CF6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 09:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 145C820842
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 09:48:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z9PQiE6b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 145C820842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728607AbeG1LNy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 07:13:54 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:41310 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbeG1LNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 07:13:53 -0400
Received: by mail-pl0-f67.google.com with SMTP id w8-v6so3347814ply.8;
        Sat, 28 Jul 2018 02:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=XZwsbqvIXcWGxsD/wZB8qM9H6P76TGOmlFDJZdFUmPA=;
        b=Z9PQiE6bxi9SFf0gu/y211OS0w6Grt/Yb/62tWhD/tzW1U1MTlt2YGgm00DHJc90eq
         IMRwvC/4yvIypNCCF2UJeXt6wtbER08DYXEpejJmV5HBQTe5CxGQNzWOx6ssCDEO6CuJ
         cDIXvaGgDgTi3AgB7kFQGpuW5AYahkfQ3S8fyEtiPxHTxBYXHHtpaUl1ay2p6Gg7zYnJ
         HTY8vNDhokIRNeMSKJwpWBx57zIYFfE8msrYNFgNyEuZc0jpl3+AQWBfk512BakKxlgu
         QB6bUdOl2mDfe3ksKNKHCgRID5jx+lLiZtlih5Aan82/t38gVPuDAj7oAvliEg7tzrWD
         XE9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=XZwsbqvIXcWGxsD/wZB8qM9H6P76TGOmlFDJZdFUmPA=;
        b=ifeiIY/7gbK1KrKcTYEwcbGKdzEzY1R1DcIbSOD6VNJwiweXZiv6qpCajKL9KXBeUi
         pTX7lXQk9xZiga98QGSHYRFrVdojxD9FSuJfLZ2LPAVrKjVO17ujV1CdRCXW5dbXyIX0
         zTHVw5kOV6xXqizitbSm/fa0WrPGwXnqDZJjGNU96B+ESOZ307tpcCGc47V6qqQ4nOv0
         23L6t6CcvCX7dlZbvwu4wWhQY/Y/7NvSZOxsqWZtrVG3Y1sXe5a6jcBXOgStXAh1Uf28
         mqPazK/ERCaKpxrswZFroeQkEpAvGx0RsRZqFrEkx8st4zZYHNlUIrNKKb/1U+ZHFoM/
         393g==
X-Gm-Message-State: AOUpUlG8juMVgUUtYCqd7k6CqunvbO6dC1hAvWIHZr+1e3YtL4VGrHap
        970OPN4XdM3QH2FLA7dLUAw=
X-Google-Smtp-Source: AAOMgpcKhfP2ylw9PjHywT5QTTyF05X+R8QvemsxNVzDh4DW7PlAJyUVcTj6D8OiHYEnx4VkaPANBw==
X-Received: by 2002:a17:902:4c88:: with SMTP id b8-v6mr8831452ple.285.1532771279715;
        Sat, 28 Jul 2018 02:47:59 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC ([183.82.18.16])
        by smtp.gmail.com with ESMTPSA id h10-v6sm13411336pfj.78.2018.07.28.02.47.57
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 28 Jul 2018 02:47:58 -0700 (PDT)
Date:   Sat, 28 Jul 2018 15:20:43 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     willy@infradead.org, viro@zeniv.linux.org.uk,
        konishi.ryusuke@lab.ntt.co.jp, axboe@kernel.dk,
        darrick.wong@oracle.com, dchinner@redhat.com, pombredanne@nexb.com,
        ebiggers@google.com, gregkh@linuxfoundation.org,
        kemi.wang@intel.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nilfs@vger.kernel.org, sabyasachi.linux@gmail.com,
        brajeswar.linux@gmail.com
Subject: [PATCH] fs/buffer: Convert return type int to vm_fault_t
Message-ID: <20180728095043.GA24085@jordon-HP-15-Notebook-PC>
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
 fs/buffer.c                 | 16 +++++++++-------
 fs/nilfs2/file.c            | 13 ++++++++-----
 include/linux/buffer_head.h |  2 +-
 3 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index be31e28..463aa27 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2456,21 +2456,22 @@ int block_commit_write(struct page *page, unsigned from, unsigned to)
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
+	vm_fault_t ret;
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
 
@@ -2480,17 +2481,18 @@ int block_page_mkwrite(struct vm_area_struct *vma, struct vm_fault *vmf,
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
+	ret = block_page_mkwrite_return(err);
 	return ret;
 }
 EXPORT_SYMBOL(block_page_mkwrite);
diff --git a/fs/nilfs2/file.c b/fs/nilfs2/file.c
index 7da0fac..3733883 100644
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
 
@@ -99,10 +100,12 @@ static vm_fault_t nilfs_page_mkwrite(struct vm_fault *vmf)
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
@@ -117,7 +120,7 @@ static vm_fault_t nilfs_page_mkwrite(struct vm_fault *vmf)
 	wait_for_stable_page(page);
  out:
 	sb_end_pagefault(inode->i_sb);
-	return block_page_mkwrite_return(ret);
+	return ret;
 }
 
 static const struct vm_operations_struct nilfs_file_vm_ops = {
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 96225a7..1aeeb54 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -239,7 +239,7 @@ int cont_write_begin(struct file *, struct address_space *, loff_t,
 			get_block_t *, loff_t *);
 int generic_cont_expand_simple(struct inode *inode, loff_t size);
 int block_commit_write(struct page *page, unsigned from, unsigned to);
-int block_page_mkwrite(struct vm_area_struct *vma, struct vm_fault *vmf,
+vm_fault_t block_page_mkwrite(struct vm_area_struct *vma, struct vm_fault *vmf,
 				get_block_t get_block);
 /* Convert errno to return value from ->page_mkwrite() call */
 static inline int block_page_mkwrite_return(int err)
-- 
1.9.1


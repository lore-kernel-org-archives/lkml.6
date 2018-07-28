Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AFCCC28CF6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 08:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C403B20862
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 08:47:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JF7vsgXU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C403B20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbeG1KNB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 06:13:01 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:40763 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726350AbeG1KNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 06:13:01 -0400
Received: by mail-pl0-f67.google.com with SMTP id s17-v6so3313465plp.7;
        Sat, 28 Jul 2018 01:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=6XgNZxJbWNplz2vkrh62ps9sV+WXW4YEPTowuMEwvsA=;
        b=JF7vsgXUUCMnJZIQnXL+KbUWtNiyRPgObxrFbLN6ta51P96hgWEun2fKNKfsc0cvEH
         Uz26F5EYi5WZnqIRNOn5iBi6idioZqVjiyK2oKFnYSJJUxWRJt3U90koqVSKTHOaLDC3
         WWrYJ92jqgfq560nT/iY5fXM4rXOyGDKwVL4Z4TpKEF6gFJbiUSh6gadnA4z36g4isL6
         KKq8R6D0VsuyoO220+YCoTnccyNA9GKFEJs0pTjx3gv2PktJGXrAdQS0NpeWFuymXqhJ
         X0GsLvlMtvMV+SE0WuwjwMccgt2rQKDVsaIHv4d5M/dnCYbV+TYr7DzQdxJ8g11bwbS/
         Eu0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=6XgNZxJbWNplz2vkrh62ps9sV+WXW4YEPTowuMEwvsA=;
        b=qnba+fnHit0btWOR/uAC+aX/CrF0+VRPsZXn+U1P1Jpkw2GRUm72mBES2MeEUT9iNx
         5XUdkHNU4Siy7LsYTKUfkBi6B4cAuQfdrWWXfKYXHNYNt0ADB3sw2YgWYYp9ZCb35NDb
         1hRLu2Y8ImNy5WK20BsiJl57dmcENs9UQSsjhq9HppDyuDfNkpShges8y80cPkQkzg24
         Vj1pJNH/YOAGobwNsomTliKI+qVkIkcw5jwt4ClbZvxT0PQx2unx09cmz5V0da73r9+y
         2+tDoa+b/UgHbyA0MSUpTL/b8FQd39bY9cswHBtx/1liYj6kz3XSJPTPbH6lDvDO4B5W
         Bcdg==
X-Gm-Message-State: AOUpUlFyPjVsAZ6sU8eB0Xk/P0NIKEwCadXy/Fz3I24tXgerzStzTVub
        3RwP3OSv+JkDgvEEhf+s5Bp/4AbI
X-Google-Smtp-Source: AAOMgpe/lL1C3kLaW80jW69XCWXfpU5Ttl3Ui0gMToslY+j2njlU/JFaijbTHNumHXqSg2oiBpTpWA==
X-Received: by 2002:a17:902:4a0c:: with SMTP id w12-v6mr9052371pld.289.1532767636701;
        Sat, 28 Jul 2018 01:47:16 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC ([183.82.18.16])
        by smtp.gmail.com with ESMTPSA id u13-v6sm10280237pfg.79.2018.07.28.01.47.14
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 28 Jul 2018 01:47:15 -0700 (PDT)
Date:   Sat, 28 Jul 2018 14:20:00 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     willy@infradead.org, tytso@mit.edu, adilger.kernel@dilger.ca,
        darrick.wong@oracle.com, axboe@kernel.dk, agruenba@redhat.com,
        ebiggers@google.com, gregkh@linuxfoundation.org,
        kemi.wang@intel.com
Cc:     sabyasachi.linux@gmail.com, brajeswar.linux@gmail.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ext4: Convert int to vm_fault_t type
Message-ID: <20180728085000.GA9136@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use new return type vm_fault_t for ext4_page_mkwrite
handler and block_page_mkwrite_return.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 fs/ext4/ext4.h              |  2 +-
 fs/ext4/inode.c             | 20 ++++++++++----------
 include/linux/buffer_head.h |  3 ++-
 3 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index aec0010..1183773 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2469,7 +2469,7 @@ int do_journal_get_write_access(handle_t *handle,
 extern int ext4_chunk_trans_blocks(struct inode *, int nrblocks);
 extern int ext4_zero_partial_blocks(handle_t *handle, struct inode *inode,
 			     loff_t lstart, loff_t lend);
-extern int ext4_page_mkwrite(struct vm_fault *vmf);
+extern vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf);
 extern vm_fault_t ext4_filemap_fault(struct vm_fault *vmf);
 extern qsize_t *ext4_get_reserved_space(struct inode *inode);
 extern int ext4_get_projid(struct inode *inode, kprojid_t *projid);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 03ac322..b491fdb 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -6108,27 +6108,27 @@ static int ext4_bh_unmapped(handle_t *handle, struct buffer_head *bh)
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
 
 	/* Delalloc case is easy... */
@@ -6138,9 +6138,9 @@ int ext4_page_mkwrite(struct vm_fault *vmf)
 		do {
 			ret = block_page_mkwrite(vma, vmf,
 						   ext4_da_get_block_prep);
-		} while (ret == -ENOSPC &&
+		} while (ret == VM_FAULT_SIGBUS &&
 		       ext4_should_retry_alloc(inode->i_sb, &retries));
-		goto out_ret;
+		goto out;
 	}
 
 	lock_page(page);
@@ -6188,17 +6188,17 @@ int ext4_page_mkwrite(struct vm_fault *vmf)
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
+	if (ret == VM_FAULT_SIGBUS &&
+		ext4_should_retry_alloc(inode->i_sb, &retries))
 		goto retry_alloc;
 out_ret:
-	ret = block_page_mkwrite_return(ret);
+	ret = block_page_mkwrite_return(err);
 out:
 	up_read(&EXT4_I(inode)->i_mmap_sem);
 	sb_end_pagefault(inode->i_sb);
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 96225a7..ed7a81b 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -14,6 +14,7 @@
 #include <linux/pagemap.h>
 #include <linux/wait.h>
 #include <linux/atomic.h>
+#include <linux/mm_types.h>
 
 #ifdef CONFIG_BLOCK
 
@@ -242,7 +243,7 @@ int cont_write_begin(struct file *, struct address_space *, loff_t,
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


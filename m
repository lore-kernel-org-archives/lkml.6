Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 721F3ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 20:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F0E02147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 20:11:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=omnibond-com.20150623.gappssmtp.com header.i=@omnibond-com.20150623.gappssmtp.com header.b="fzeXrAXA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F0E02147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728680AbeIRBkQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 21:40:16 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:34472 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728649AbeIRBkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 21:40:16 -0400
Received: by mail-qt0-f196.google.com with SMTP id m13-v6so16591543qth.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 13:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LxtoxIjIAMDKbfFqSQMGskMeq1HAM3895QYkJcilY7E=;
        b=fzeXrAXA+i3Q/GivJMvxQZe/yvJSAiiX0S15B1EKGE++Ei//XkC4LRg8asVo/E69iV
         nCHIwN/ErMCKwiBahZ1ah7O3j2ECQOrRijE0bJto/MsmGsoQNAkS09sfvyo+zDPXdhp+
         8+arOfeIyZvAUy8Udxt5P7qs4c4Pr6JOc1G+Wcsun+3RwpWtge/zMSohEH0DxwiU5qUU
         yewCspSCTRdoY27ynu/jcj+c8Z03Kyq5L7AKu075NTKkU8gZ3Ws7nxnA9M9YXpKAZmZY
         2XoFGTEkdsYVaGBNq+8yivlE0ZWhu6VCY+4NopMpW57XJnCJq9N5LQ5WgCvocWPKgIkn
         4yfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LxtoxIjIAMDKbfFqSQMGskMeq1HAM3895QYkJcilY7E=;
        b=R+fBvyGfoqPMCtMBApuTKHofk/h5LtNSEotIIydphZPOxfxyZBRqdcBT2wnWHFlu0i
         nc3mqH6ktMg3/j6dlMRl9EyVinVj7P4d6ez6gQTbIVctHPiJf6MRAKzgcHlWRjCb0/mm
         ZfaR9AT62yY89SB3xmB+1shOtncDx2WVmHbbaFvyBRAPd7L1jkwlT0DqFrxG9UmCWb5s
         T0mm5qeln/myQAefr6sVNaZ/SRhJDQBVo1N0IonawM3Ktb0NDC6abgAafQuSWrS7wjme
         lkHSzgf574eE2GasKIFb5TxaVCef3O7CQGsadtFIAvxjwOqpqkc8Z+e9OQ+JXxsf3XOg
         D8IA==
X-Gm-Message-State: APzg51Co2/YJtl/JJoRz70fh8iDnMHi3JSZNvrD30ufk2YfdXuRM0Gmj
        ln4qfh0UatCk4+6L9Nkm5PnyfMan25r5h6jf
X-Google-Smtp-Source: ANB0VdbAINmgj9b0j4sredMEdv0235z0rUO4mr/7IxmY/c0/Yi6iKbNtKVcfYBZUQfJttod9dcC41w==
X-Received: by 2002:ac8:179c:: with SMTP id o28-v6mr18850400qtj.98.1537215083604;
        Mon, 17 Sep 2018 13:11:23 -0700 (PDT)
Received: from ip-172-31-22-34.ec2.internal (ec2-18-215-252-133.compute-1.amazonaws.com. [18.215.252.133])
        by smtp.gmail.com with ESMTPSA id n8-v6sm11053480qtk.38.2018.09.17.13.11.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Sep 2018 13:11:22 -0700 (PDT)
From:   Martin Brandenburg <martin@omnibond.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        devel@lists.orangefs.org
Cc:     Martin Brandenburg <martin@omnibond.com>
Subject: [PATCH 12/17] orangefs: implement writepage
Date:   Mon, 17 Sep 2018 20:10:49 +0000
Message-Id: <20180917201054.3530-13-martin@omnibond.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917201054.3530-1-martin@omnibond.com>
References: <20180917201054.3530-1-martin@omnibond.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now orangefs_inode_getattr fills from cache if an inode has dirty pages.

also if attr_valid and dirty pages and !flags, we spin on inode writeback
before returning if pages still dirty after: should it be other way

Signed-off-by: Martin Brandenburg <martin@omnibond.com>
---
 fs/orangefs/file.c           | 77 +++++++-----------------------------
 fs/orangefs/inode.c          | 59 ++++++++++++++++++++++++---
 fs/orangefs/orangefs-utils.c | 12 +++++-
 3 files changed, 78 insertions(+), 70 deletions(-)

diff --git a/fs/orangefs/file.c b/fs/orangefs/file.c
index 4bc06c310e02..ba580a5c6fd2 100644
--- a/fs/orangefs/file.c
+++ b/fs/orangefs/file.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * (C) 2001 Clemson University and The University of Chicago
+ * Copyright 2018 Omnibond Systems, L.L.C.
  *
  * See COPYING in top-level directory.
  */
@@ -348,65 +349,11 @@ static ssize_t orangefs_file_read_iter(struct kiocb *iocb,
 	return generic_file_read_iter(iocb, iter);
 }
 
-static ssize_t orangefs_file_write_iter(struct kiocb *iocb, struct iov_iter *iter)
+static ssize_t orangefs_file_write_iter(struct kiocb *iocb,
+    struct iov_iter *iter)
 {
-	struct file *file = iocb->ki_filp;
-	loff_t pos;
-	ssize_t rc;
-
-	BUG_ON(iocb->private);
-
-	truncate_inode_pages(file->f_mapping, 0);
-
-	gossip_debug(GOSSIP_FILE_DEBUG, "orangefs_file_write_iter\n");
-
-	inode_lock(file->f_mapping->host);
-
-	/* Make sure generic_write_checks sees an up to date inode size. */
-	if (file->f_flags & O_APPEND) {
-		rc = orangefs_inode_getattr(file->f_mapping->host,
-		    ORANGEFS_GETATTR_SIZE);
-		if (rc == -ESTALE)
-			rc = -EIO;
-		if (rc) {
-			gossip_err("%s: orangefs_inode_getattr failed, "
-			    "rc:%zd:.\n", __func__, rc);
-			goto out;
-		}
-	}
-
-	rc = generic_write_checks(iocb, iter);
-
-	if (rc <= 0) {
-		gossip_err("%s: generic_write_checks failed, rc:%zd:.\n",
-			   __func__, rc);
-		goto out;
-	}
-
-	/*
-	 * if we are appending, generic_write_checks would have updated
-	 * pos to the end of the file, so we will wait till now to set
-	 * pos...
-	 */
-	pos = iocb->ki_pos;
-
-	rc = do_readv_writev(ORANGEFS_IO_WRITE,
-			     file,
-			     &pos,
-			     iter);
-	if (rc < 0) {
-		gossip_err("%s: do_readv_writev failed, rc:%zd:.\n",
-			   __func__, rc);
-		goto out;
-	}
-
-	iocb->ki_pos = pos;
 	orangefs_stats.writes++;
-
-out:
-
-	inode_unlock(file->f_mapping->host);
-	return rc;
+	return generic_file_write_iter(iocb, iter);
 }
 
 /*
@@ -501,9 +448,6 @@ static int orangefs_file_mmap(struct file *file, struct vm_area_struct *vma)
 			(char *)file->f_path.dentry->d_name.name :
 			(char *)"Unknown"));
 
-	if ((vma->vm_flags & VM_SHARED) && (vma->vm_flags & VM_MAYWRITE))
-		return -EINVAL;
-
 	/* set the sequential readahead hint */
 	vma->vm_flags |= VM_SEQ_READ;
 	vma->vm_flags &= ~VM_RAND_READ;
@@ -543,8 +487,6 @@ static int orangefs_file_release(struct inode *inode, struct file *file)
 			gossip_debug(GOSSIP_INODE_DEBUG,
 			    "flush_racache finished\n");
 		}
-		truncate_inode_pages(file_inode(file)->i_mapping,
-				     0);
 	}
 	return 0;
 }
@@ -562,6 +504,11 @@ static int orangefs_fsync(struct file *file,
 		ORANGEFS_I(file_inode(file));
 	struct orangefs_kernel_op_s *new_op = NULL;
 
+	ret = filemap_write_and_wait_range(file_inode(file)->i_mapping,
+	    start, end);
+	if (ret)
+		return ret;
+
 	new_op = op_alloc(ORANGEFS_VFS_OP_FSYNC);
 	if (!new_op)
 		return -ENOMEM;
@@ -643,6 +590,11 @@ static int orangefs_lock(struct file *filp, int cmd, struct file_lock *fl)
 	return rc;
 }
 
+int orangefs_flush(struct file *file, fl_owner_t id)
+{
+	return vfs_fsync(file, 0);
+}
+
 /** ORANGEFS implementation of VFS file operations */
 const struct file_operations orangefs_file_operations = {
 	.llseek		= orangefs_file_llseek,
@@ -652,6 +604,7 @@ const struct file_operations orangefs_file_operations = {
 	.unlocked_ioctl	= orangefs_ioctl,
 	.mmap		= orangefs_file_mmap,
 	.open		= generic_file_open,
+	.flush		= orangefs_flush,
 	.release	= orangefs_file_release,
 	.fsync		= orangefs_fsync,
 };
diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index 826054b979cc..5832104cab6a 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -15,6 +15,44 @@
 #include "orangefs-kernel.h"
 #include "orangefs-bufmap.h"
 
+static int orangefs_writepage(struct page *page, struct writeback_control *wbc)
+{
+	struct inode *inode = page->mapping->host;
+	struct iov_iter iter;
+	struct bio_vec bv;
+	size_t len, wlen;
+	ssize_t ret;
+	loff_t off;
+
+	set_page_writeback(page);
+
+	off = page_offset(page);
+	len = i_size_read(inode);
+	if (off + PAGE_SIZE > len)
+		wlen = len - off;
+	else
+		wlen = PAGE_SIZE;
+
+	bv.bv_page = page;
+	bv.bv_len = wlen;
+	bv.bv_offset = 0;
+	if (wlen == 0)
+		dump_stack();
+	iov_iter_bvec(&iter, ITER_BVEC | WRITE, &bv, 1, wlen);
+
+	ret = wait_for_direct_io(ORANGEFS_IO_WRITE, inode, &off, &iter, wlen,
+	    len);
+	if (ret < 0) {
+		SetPageError(page);
+		mapping_set_error(page->mapping, ret);
+	} else {
+		ret = 0;
+	}
+	end_page_writeback(page);
+	unlock_page(page);
+	return ret;
+}
+
 static int orangefs_readpage(struct file *file, struct page *page)
 {
 	struct inode *inode = page->mapping->host;
@@ -48,6 +86,15 @@ static int orangefs_readpage(struct file *file, struct page *page)
 	return ret;
 }
 
+int orangefs_write_end(struct file *file, struct address_space *mapping,
+    loff_t pos, unsigned len, unsigned copied, struct page *page, void *fsdata)
+{
+	int r;
+	r = simple_write_end(file, mapping, pos, len, copied, page, fsdata);
+	mark_inode_dirty_sync(file_inode(file));
+	return r;
+}
+
 static void orangefs_invalidatepage(struct page *page,
 				 unsigned int offset,
 				 unsigned int length)
@@ -77,17 +124,17 @@ static ssize_t orangefs_direct_IO(struct kiocb *iocb,
 {
 	struct file *file = iocb->ki_filp;
 	loff_t pos = *(&iocb->ki_pos);
-	/*
-	 * This cannot happen until write_iter becomes
-	 * generic_file_write_iter.
-	 */
-	BUG_ON(iov_iter_rw(iter) != READ);
-	return do_readv_writev(ORANGEFS_IO_READ, file, &pos, iter);
+	return do_readv_writev(iov_iter_rw(iter) == WRITE ?
+	    ORANGEFS_IO_WRITE : ORANGEFS_IO_READ, file, &pos, iter);
 }
 
 /** ORANGEFS2 implementation of address space operations */
 static const struct address_space_operations orangefs_address_operations = {
+	.writepage = orangefs_writepage,
 	.readpage = orangefs_readpage,
+	.set_page_dirty = __set_page_dirty_nobuffers,
+	.write_begin = simple_write_begin,
+	.write_end = orangefs_write_end,
 	.invalidatepage = orangefs_invalidatepage,
 	.releasepage = orangefs_releasepage,
 	.direct_IO = orangefs_direct_IO,
diff --git a/fs/orangefs/orangefs-utils.c b/fs/orangefs/orangefs-utils.c
index 9221c4a3398e..902ebd1599e1 100644
--- a/fs/orangefs/orangefs-utils.c
+++ b/fs/orangefs/orangefs-utils.c
@@ -247,12 +247,16 @@ int orangefs_inode_getattr(struct inode *inode, int flags)
 	spin_lock(&inode->i_lock);
 	/* Must have all the attributes in the mask and be within cache time. */
 	if ((!flags && time_before(jiffies, orangefs_inode->getattr_time)) ||
-	    orangefs_inode->attr_valid) {
+	    orangefs_inode->attr_valid || inode->i_state & I_DIRTY_PAGES) {
 		if (orangefs_inode->attr_valid) {
 			spin_unlock(&inode->i_lock);
 			write_inode_now(inode, 1);
 			goto again;
 		}
+		if (inode->i_state & I_DIRTY_PAGES) {
+			spin_unlock(&inode->i_lock);
+			return 0;
+		}
 		spin_unlock(&inode->i_lock);
 		return 0;
 	}
@@ -281,12 +285,16 @@ int orangefs_inode_getattr(struct inode *inode, int flags)
 	spin_lock(&inode->i_lock);
 	/* Must have all the attributes in the mask and be within cache time. */
 	if ((!flags && time_before(jiffies, orangefs_inode->getattr_time)) ||
-	    orangefs_inode->attr_valid) {
+	    orangefs_inode->attr_valid || inode->i_state & I_DIRTY_PAGES) {
 		if (orangefs_inode->attr_valid) {
 			spin_unlock(&inode->i_lock);
 			write_inode_now(inode, 1);
 			goto again2;
 		}
+		if (inode->i_state & I_DIRTY_PAGES) {
+			spin_unlock(&inode->i_lock);
+			return 0;
+		}
 		gossip_debug(GOSSIP_UTILS_DEBUG, "%s: in cache or dirty\n",
 		    __func__);
 		ret = 0;
-- 
2.19.0


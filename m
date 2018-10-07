Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE4FC6787E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 23:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E53472087D
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 23:29:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=omnibond-com.20150623.gappssmtp.com header.i=@omnibond-com.20150623.gappssmtp.com header.b="TnGRw1PC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E53472087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728548AbeJHGiB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 02:38:01 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35620 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727087AbeJHGhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 02:37:02 -0400
Received: by mail-qt1-f195.google.com with SMTP id v19-v6so19296893qtg.2
        for <linux-kernel@vger.kernel.org>; Sun, 07 Oct 2018 16:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qoA7p70DREEGHDGYkqmqpCGl6/L2/Ybk6ecH83aW6UM=;
        b=TnGRw1PC+RYDMgUJevYIyxMxeIsVgk5UDDalaeYOKKuKBB4P0zAyD2HQkfM5qH//jL
         WkkdGY18xqHWpBPjgizHqaf1uSRtyyCKRSJiCoJYOV/2SXMTxyoiyjjuQCvRjXj/BYKz
         yl3bXgmIcfhQSm9d3GfCsmip+QgO8Lg8azqfwuXd8t0R797mQC2ZNuHgzZPXCXQBHH4Y
         5KaZu6eHd6MvHz26vRA5HaOSrUv+7nxCksB2lHgMm380fTsqpJt6l4oEBifuxLzkNRxX
         0R9gPwvkethGA4yXM/EwAd9pXfwlBqPtOwVGtMYd6qJYVG3Ku7wUHfGN7OkW51OX49Jn
         TdwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qoA7p70DREEGHDGYkqmqpCGl6/L2/Ybk6ecH83aW6UM=;
        b=bqgnuS48M5H2wy4XxG6zny9/LfgbLZK8P5yWw/VAt44p92KFlpQhjZWS5HEaiDNnvN
         zrqKqzVMMg86JHUAn25Mo3lql3lqBiMpyuRZz6Bvy/Z+iTaoxyNw468JPN2cOqubCMf1
         MqRmn8lzkjNa2KRD8w2QqEL7hitiJDRgJ+8DEAKuLK1y9AxsbleW023+h3hRT/L6Maew
         jAsFCdzLA7BDIVTuU9eSXcsDF8jUEjRRgdpBGbFlFea+VO5M48SMJ6TlvyzhtgcnHaWp
         uH8ht+XU859VPv9DwkLG2IeKCIQITo3O5orjqCblg2i+HJaASJuE/QfaglJVpNaULSQd
         kaug==
X-Gm-Message-State: ABuFfojSTnM62rMpZt/fbYh6vkpOohBJeHnxKgaP/EMdux19+p09qlIG
        e/QBrMmiK73OWl+vNijHr4sRPw==
X-Google-Smtp-Source: ACcGV61nILXKpXex+Xq3BSgF5wKlLOt7dvhPALfWv6IBBzOxT534rDFDkFCGF4lUlp97u0yfaQ18DA==
X-Received: by 2002:a0c:f091:: with SMTP id g17-v6mr17325369qvk.55.1538954888785;
        Sun, 07 Oct 2018 16:28:08 -0700 (PDT)
Received: from ip-172-31-22-34.ec2.internal (ec2-35-153-175-159.compute-1.amazonaws.com. [35.153.175.159])
        by smtp.gmail.com with ESMTPSA id x38-v6sm6793915qtc.39.2018.10.07.16.28.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 07 Oct 2018 16:28:07 -0700 (PDT)
From:   Martin Brandenburg <martin@omnibond.com>
To:     devel@lists.orangefs.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, hubcap@omnibond.com
Cc:     Martin Brandenburg <martin@omnibond.com>
Subject: [PATCH 11/19] orangefs: migrate to generic_file_read_iter
Date:   Sun,  7 Oct 2018 23:27:28 +0000
Message-Id: <20181007232736.3780-12-martin@omnibond.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181007232736.3780-1-martin@omnibond.com>
References: <20181007232736.3780-1-martin@omnibond.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove orangefs_inode_read.  It was used by readpage.  Calling
wait_for_direct_io directly serves the purpose just as well.  There is
now no check of the bufmap size in the readpage path.  There are already
other places the bufmap size is assumed to be greater than PAGE_SIZE.

Important to call truncate_inode_pages now in the write path so a
subsequent read sees the new data.

Signed-off-by: Martin Brandenburg <martin@omnibond.com>
---
 fs/orangefs/file.c            | 68 ++++-------------------------------
 fs/orangefs/inode.c           | 63 ++++++++++++--------------------
 fs/orangefs/orangefs-kernel.h | 13 ++++---
 3 files changed, 38 insertions(+), 106 deletions(-)

diff --git a/fs/orangefs/file.c b/fs/orangefs/file.c
index aec17635a50f..4bc06c310e02 100644
--- a/fs/orangefs/file.c
+++ b/fs/orangefs/file.c
@@ -44,7 +44,7 @@ static int flush_racache(struct inode *inode)
 /*
  * Post and wait for the I/O upcall to finish
  */
-static ssize_t wait_for_direct_io(enum ORANGEFS_io_type type, struct inode *inode,
+ssize_t wait_for_direct_io(enum ORANGEFS_io_type type, struct inode *inode,
 		loff_t *offset, struct iov_iter *iter,
 		size_t total_size, loff_t readahead_size)
 {
@@ -240,7 +240,7 @@ static ssize_t wait_for_direct_io(enum ORANGEFS_io_type type, struct inode *inod
  * augmented/extended metadata attached to the file.
  * Note: File extended attributes override any mount options.
  */
-static ssize_t do_readv_writev(enum ORANGEFS_io_type type, struct file *file,
+ssize_t do_readv_writev(enum ORANGEFS_io_type type, struct file *file,
 		loff_t *offset, struct iov_iter *iter)
 {
 	struct inode *inode = file->f_mapping->host;
@@ -341,67 +341,11 @@ static ssize_t do_readv_writev(enum ORANGEFS_io_type type, struct file *file,
 	return ret;
 }
 
-/*
- * Read data from a specified offset in a file (referenced by inode).
- * Data may be placed either in a user or kernel buffer.
- */
-ssize_t orangefs_inode_read(struct inode *inode,
-			    struct iov_iter *iter,
-			    loff_t *offset,
-			    loff_t readahead_size)
+static ssize_t orangefs_file_read_iter(struct kiocb *iocb,
+    struct iov_iter *iter)
 {
-	struct orangefs_inode_s *orangefs_inode = ORANGEFS_I(inode);
-	size_t count = iov_iter_count(iter);
-	size_t bufmap_size;
-	ssize_t ret = -EINVAL;
-
 	orangefs_stats.reads++;
-
-	bufmap_size = orangefs_bufmap_size_query();
-	if (count > bufmap_size) {
-		gossip_debug(GOSSIP_FILE_DEBUG,
-			     "%s: count is too large (%zd/%zd)!\n",
-			     __func__, count, bufmap_size);
-		return -EINVAL;
-	}
-
-	gossip_debug(GOSSIP_FILE_DEBUG,
-		     "%s(%pU) %zd@%llu\n",
-		     __func__,
-		     &orangefs_inode->refn.khandle,
-		     count,
-		     llu(*offset));
-
-	ret = wait_for_direct_io(ORANGEFS_IO_READ, inode, offset, iter,
-			count, readahead_size);
-	if (ret > 0)
-		*offset += ret;
-
-	gossip_debug(GOSSIP_FILE_DEBUG,
-		     "%s(%pU): Value(%zd) returned.\n",
-		     __func__,
-		     &orangefs_inode->refn.khandle,
-		     ret);
-
-	return ret;
-}
-
-static ssize_t orangefs_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
-{
-	struct file *file = iocb->ki_filp;
-	loff_t pos = iocb->ki_pos;
-	ssize_t rc = 0;
-
-	BUG_ON(iocb->private);
-
-	gossip_debug(GOSSIP_FILE_DEBUG, "orangefs_file_read_iter\n");
-
-	orangefs_stats.reads++;
-
-	rc = do_readv_writev(ORANGEFS_IO_READ, file, &pos, iter);
-	iocb->ki_pos = pos;
-
-	return rc;
+	return generic_file_read_iter(iocb, iter);
 }
 
 static ssize_t orangefs_file_write_iter(struct kiocb *iocb, struct iov_iter *iter)
@@ -412,6 +356,8 @@ static ssize_t orangefs_file_write_iter(struct kiocb *iocb, struct iov_iter *ite
 
 	BUG_ON(iocb->private);
 
+	truncate_inode_pages(file->f_mapping, 0);
+
 	gossip_debug(GOSSIP_FILE_DEBUG, "orangefs_file_write_iter\n");
 
 	inode_lock(file->f_mapping->host);
diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index 1ef000b69e06..826054b979cc 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -17,37 +17,25 @@
 
 static int orangefs_readpage(struct file *file, struct page *page)
 {
-	int ret;
-	int max_block;
-	ssize_t bytes_read = 0;
 	struct inode *inode = page->mapping->host;
-	const __u32 blocksize = PAGE_SIZE;
-	const __u32 blockbits = PAGE_SHIFT;
-	struct iov_iter to;
-	struct bio_vec bv = {.bv_page = page, .bv_len = PAGE_SIZE};
-
-	iov_iter_bvec(&to, ITER_BVEC | READ, &bv, 1, PAGE_SIZE);
-
-	gossip_debug(GOSSIP_INODE_DEBUG,
-		    "orangefs_readpage called with page %p\n",
-		     page);
-
-	max_block = ((inode->i_size / blocksize) + 1);
-
-	if (page->index < max_block) {
-		loff_t blockptr_offset = (((loff_t) page->index) << blockbits);
-
-		bytes_read = orangefs_inode_read(inode,
-						 &to,
-						 &blockptr_offset,
-						 inode->i_size);
-	}
+	struct iov_iter iter;
+	struct bio_vec bv;
+	ssize_t ret;
+	loff_t off;
+
+	off = page_offset(page);
+	bv.bv_page = page;
+	bv.bv_len = PAGE_SIZE;
+	bv.bv_offset = 0;
+	iov_iter_bvec(&iter, ITER_BVEC | READ, &bv, 1, PAGE_SIZE);
+
+	ret = wait_for_direct_io(ORANGEFS_IO_READ, inode, &off, &iter,
+	    PAGE_SIZE, inode->i_size);
 	/* this will only zero remaining unread portions of the page data */
-	iov_iter_zero(~0U, &to);
+	iov_iter_zero(~0U, &iter);
 	/* takes care of potential aliasing */
 	flush_dcache_page(page);
-	if (bytes_read < 0) {
-		ret = bytes_read;
+	if (ret < 0) {
 		SetPageError(page);
 	} else {
 		SetPageUptodate(page);
@@ -84,22 +72,17 @@ static int orangefs_releasepage(struct page *page, gfp_t foo)
 	return 0;
 }
 
-/*
- * Having a direct_IO entry point in the address_space_operations
- * struct causes the kernel to allows us to use O_DIRECT on
- * open. Nothing will ever call this thing, but in the future we
- * will need to be able to use O_DIRECT on open in order to support
- * AIO. Modeled after NFS, they do this too.
- */
-
 static ssize_t orangefs_direct_IO(struct kiocb *iocb,
 				  struct iov_iter *iter)
 {
-	gossip_debug(GOSSIP_INODE_DEBUG,
-		     "orangefs_direct_IO: %pD\n",
-		     iocb->ki_filp);
-
-	return -EINVAL;
+	struct file *file = iocb->ki_filp;
+	loff_t pos = *(&iocb->ki_pos);
+	/*
+	 * This cannot happen until write_iter becomes
+	 * generic_file_write_iter.
+	 */
+	BUG_ON(iov_iter_rw(iter) != READ);
+	return do_readv_writev(ORANGEFS_IO_READ, file, &pos, iter);
 }
 
 /** ORANGEFS2 implementation of address space operations */
diff --git a/fs/orangefs/orangefs-kernel.h b/fs/orangefs/orangefs-kernel.h
index cdb08e51a4b1..e128500e33b4 100644
--- a/fs/orangefs/orangefs-kernel.h
+++ b/fs/orangefs/orangefs-kernel.h
@@ -368,11 +368,6 @@ ssize_t orangefs_listxattr(struct dentry *dentry, char *buffer, size_t size);
 struct inode *orangefs_iget(struct super_block *sb,
 			 struct orangefs_object_kref *ref);
 
-ssize_t orangefs_inode_read(struct inode *inode,
-			    struct iov_iter *iter,
-			    loff_t *offset,
-			    loff_t readahead_size);
-
 /*
  * defined in devorangefs-req.c
  */
@@ -383,6 +378,14 @@ void orangefs_dev_cleanup(void);
 int is_daemon_in_service(void);
 bool __is_daemon_in_service(void);
 
+/*
+ * defined in file.c
+ */
+ssize_t wait_for_direct_io(enum ORANGEFS_io_type, struct inode *, loff_t *,
+    struct iov_iter *, size_t, loff_t);
+ssize_t do_readv_writev(enum ORANGEFS_io_type, struct file *, loff_t *,
+    struct iov_iter *);
+
 /*
  * defined in orangefs-utils.c
  */
-- 
2.19.0


Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 438EFECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 20:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D83522147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 20:13:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=omnibond-com.20150623.gappssmtp.com header.i=@omnibond-com.20150623.gappssmtp.com header.b="rRlaDqZx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D83522147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728932AbeIRBl4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 21:41:56 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:39904 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728451AbeIRBkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 21:40:06 -0400
Received: by mail-qt0-f193.google.com with SMTP id o15-v6so16553689qtk.6
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 13:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f9oe7ij/IvvInB2O1ipmh18QKXWzU0FTba2SS/ej+tE=;
        b=rRlaDqZx65GQ+c+0auiCKfcoo6x7/GlCdJjjygHgn5eM/2BMd2j+4ocEjVOO/4sTFZ
         glulncr+DBylLwvx4MBEWBV8VseNsHdyv3ztr2Qs5gKDltvZqaAsghH0mSifaWDXRSYL
         16WuRehrlFNiwkLTIrplazS2reM0Goyt05E5cU9g6/d+0oystzyG5O/xgqtwT1XdlUzo
         2wgQ2x19XH8Tn9N8lV/9pN0g/pTFJWu0cb8WmQKxe2A2+6RsN1IuZp+yl8q87gmd3pvM
         MGE0BWj6gc5dbd/iZ1MSHrOd2ov43lxSgpZ3I4GBtPZFk14+6gRYXqPE4/62vglyOUBu
         u3VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f9oe7ij/IvvInB2O1ipmh18QKXWzU0FTba2SS/ej+tE=;
        b=SbNZmP+TE3Z4yR8KLQL0IG+eURKzhhwef0XUZVWwVmtcWwas01A8gLciMOOR6ZjtRm
         2bx4S1HRz72Did7VG2FVHRoNaWFTaRdk7tijUflgchGhWX0eXic9NWMYKcWTJHN5zrRS
         x7dS5zwhVOR8WHGFG53HHfvhOVXXS07C3OIzpnxs8cqbhmkP2vTW/k0u/3cmRxhlQ6Or
         xitHb3BTX+LBYXU6AOlzvptqYMRsCRL2mJN/wE+XoWm19s9Hwhq2uoAY9oqkV+jk/AND
         L8gllsoWDbf997LU+apPn69qhnlpiRNChJmd9LeEJL3KeYJs0q2+wl2qLJIvaxYRuTg3
         BGAg==
X-Gm-Message-State: APzg51CXBnUUcZeI0kdjU/2bIGp53sDqIMBhJJXWGkzQmL3jq3Wpz63I
        Aq9bG5pD45nSN00pVhVo0pk2rbV/uMAge1qm
X-Google-Smtp-Source: ANB0VdYoD5JXPRVGvnWki10oRC8bpjzfOdIIMHeWhzkFxQVyf4YCnn9QPefhfF3tQ6pvrlsPwCWsGA==
X-Received: by 2002:ac8:167a:: with SMTP id x55-v6mr18702962qtk.67.1537215074345;
        Mon, 17 Sep 2018 13:11:14 -0700 (PDT)
Received: from ip-172-31-22-34.ec2.internal (ec2-18-215-252-133.compute-1.amazonaws.com. [18.215.252.133])
        by smtp.gmail.com with ESMTPSA id n8-v6sm11053480qtk.38.2018.09.17.13.11.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Sep 2018 13:11:13 -0700 (PDT)
From:   Martin Brandenburg <martin@omnibond.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        devel@lists.orangefs.org
Cc:     Martin Brandenburg <martin@omnibond.com>
Subject: [PATCH 03/17] orangefs: simply orangefs_inode_getattr interface
Date:   Mon, 17 Sep 2018 20:10:40 +0000
Message-Id: <20180917201054.3530-4-martin@omnibond.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917201054.3530-1-martin@omnibond.com>
References: <20180917201054.3530-1-martin@omnibond.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need to store the received mask.  It is either STATX_BASIC_STATS or
STATX_BASIC_STATS & ~STATX_SIZE.  If STATX_SIZE is requested, the cache
is bypassed anyway, so the cached mask is unnecessary to decide whether
to do a real getattr.

This is a change.  Previously a getattr would want size and use the
cached size.  All of the in-kernel callers that wanted size did not want
a cached size.  Now a getattr cannot use the cached size if it wants
size at all.

Signed-off-by: Martin Brandenburg <martin@omnibond.com>
---
 fs/orangefs/file.c            | 17 ++++++++---------
 fs/orangefs/inode.c           | 11 ++++++-----
 fs/orangefs/orangefs-kernel.h |  7 ++++---
 fs/orangefs/orangefs-utils.c  | 31 ++++++++++---------------------
 4 files changed, 28 insertions(+), 38 deletions(-)

diff --git a/fs/orangefs/file.c b/fs/orangefs/file.c
index a5a2fe76568f..3ab6e5126899 100644
--- a/fs/orangefs/file.c
+++ b/fs/orangefs/file.c
@@ -424,8 +424,8 @@ static ssize_t orangefs_file_write_iter(struct kiocb *iocb, struct iov_iter *ite
 
 	/* Make sure generic_write_checks sees an up to date inode size. */
 	if (file->f_flags & O_APPEND) {
-		rc = orangefs_inode_getattr(file->f_mapping->host, 0, 1,
-		    STATX_SIZE);
+		rc = orangefs_inode_getattr(file->f_mapping->host,
+		    ORANGEFS_GETATTR_SIZE);
 		if (rc == -ESTALE)
 			rc = -EIO;
 		if (rc) {
@@ -532,14 +532,13 @@ static vm_fault_t orangefs_fault(struct vm_fault *vmf)
 {
 	struct file *file = vmf->vma->vm_file;
 	int ret;
-
-	ret = orangefs_inode_getattr(file->f_mapping->host, 0, 1,
-	    STATX_SIZE);
+	ret = orangefs_inode_getattr(file->f_mapping->host,
+	    ORANGEFS_GETATTR_SIZE);
 	if (ret == -ESTALE)
 		ret = -EIO;
 	if (ret) {
-		gossip_err("%s: orangefs_inode_getattr failed, ret:%d:.\n",
-				__func__, ret);
+		gossip_err("%s: orangefs_inode_getattr failed, "
+		    "ret:%d:.\n", __func__, ret);
 		return VM_FAULT_SIGBUS;
 	}
 	return filemap_fault(vmf);
@@ -660,8 +659,8 @@ static loff_t orangefs_file_llseek(struct file *file, loff_t offset, int origin)
 		 * NOTE: We are only interested in file size here,
 		 * so we set mask accordingly.
 		 */
-		ret = orangefs_inode_getattr(file->f_mapping->host, 0, 1,
-		    STATX_SIZE);
+		ret = orangefs_inode_getattr(file->f_mapping->host,
+		    ORANGEFS_GETATTR_SIZE);
 		if (ret == -ESTALE)
 			ret = -EIO;
 		if (ret) {
diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index 2f1a5f36a103..067fd7111103 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -162,7 +162,7 @@ static int orangefs_setattr_size(struct inode *inode, struct iattr *iattr)
 		     iattr->ia_size);
 
 	/* Ensure that we have a up to date size, so we know if it changed. */
-	ret = orangefs_inode_getattr(inode, 0, 1, STATX_SIZE);
+	ret = orangefs_inode_getattr(inode, ORANGEFS_GETATTR_SIZE);
 	if (ret == -ESTALE)
 		ret = -EIO;
 	if (ret) {
@@ -256,7 +256,8 @@ int orangefs_getattr(const struct path *path, struct kstat *stat,
 		     "orangefs_getattr: called on %pd\n",
 		     path->dentry);
 
-	ret = orangefs_inode_getattr(inode, 0, 0, request_mask);
+	ret = orangefs_inode_getattr(inode,
+	    request_mask & STATX_SIZE ? ORANGEFS_GETATTR_SIZE : 0);
 	if (ret == 0) {
 		generic_fillattr(inode, stat);
 
@@ -287,7 +288,7 @@ int orangefs_permission(struct inode *inode, int mask)
 	gossip_debug(GOSSIP_INODE_DEBUG, "%s: refreshing\n", __func__);
 
 	/* Make sure the permission (and other common attrs) are up to date. */
-	ret = orangefs_inode_getattr(inode, 0, 0, STATX_MODE);
+	ret = orangefs_inode_getattr(inode, 0);
 	if (ret < 0)
 		return ret;
 
@@ -409,7 +410,7 @@ struct inode *orangefs_iget(struct super_block *sb,
 	if (!inode || !(inode->i_state & I_NEW))
 		return inode;
 
-	error = orangefs_inode_getattr(inode, 1, 1, STATX_ALL);
+	error = orangefs_inode_getattr(inode, ORANGEFS_GETATTR_NEW);
 	if (error) {
 		iget_failed(inode);
 		return ERR_PTR(error);
@@ -454,7 +455,7 @@ struct inode *orangefs_new_inode(struct super_block *sb, struct inode *dir,
 	orangefs_set_inode(inode, ref);
 	inode->i_ino = hash;	/* needed for stat etc */
 
-	error = orangefs_inode_getattr(inode, 1, 1, STATX_ALL);
+	error = orangefs_inode_getattr(inode, ORANGEFS_GETATTR_NEW);
 	if (error)
 		goto out_iput;
 
diff --git a/fs/orangefs/orangefs-kernel.h b/fs/orangefs/orangefs-kernel.h
index 0c76b8899fd1..6b21ec59738c 100644
--- a/fs/orangefs/orangefs-kernel.h
+++ b/fs/orangefs/orangefs-kernel.h
@@ -192,7 +192,6 @@ struct orangefs_inode_s {
 	sector_t last_failed_block_index_read;
 
 	unsigned long getattr_time;
-	u32 getattr_mask;
 
 	DECLARE_HASHTABLE(xattr_cache, 4);
 };
@@ -396,8 +395,10 @@ int orangefs_inode_setxattr(struct inode *inode,
 			 size_t size,
 			 int flags);
 
-int orangefs_inode_getattr(struct inode *inode, int new, int bypass,
-    u32 request_mask);
+#define ORANGEFS_GETATTR_NEW 1
+#define ORANGEFS_GETATTR_SIZE 2
+
+int orangefs_inode_getattr(struct inode *, int);
 
 int orangefs_inode_check_changed(struct inode *inode);
 
diff --git a/fs/orangefs/orangefs-utils.c b/fs/orangefs/orangefs-utils.c
index 804c8a261e4b..76f18a3494c7 100644
--- a/fs/orangefs/orangefs-utils.c
+++ b/fs/orangefs/orangefs-utils.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * (C) 2001 Clemson University and The University of Chicago
+ * Copyright 2018 Omnibond Systems, L.L.C.
  *
  * See COPYING in top-level directory.
  */
@@ -272,8 +273,7 @@ static int orangefs_inode_is_stale(struct inode *inode,
 	return 0;
 }
 
-int orangefs_inode_getattr(struct inode *inode, int new, int bypass,
-    u32 request_mask)
+int orangefs_inode_getattr(struct inode *inode, int flags)
 {
 	struct orangefs_inode_s *orangefs_inode = ORANGEFS_I(inode);
 	struct orangefs_kernel_op_s *new_op;
@@ -283,16 +283,9 @@ int orangefs_inode_getattr(struct inode *inode, int new, int bypass,
 	gossip_debug(GOSSIP_UTILS_DEBUG, "%s: called on inode %pU\n", __func__,
 	    get_khandle_from_ino(inode));
 
-	if (!new && !bypass) {
-		/*
-		 * Must have all the attributes in the mask and be within cache
-		 * time.
-		 */
-		if ((request_mask & orangefs_inode->getattr_mask) ==
-		    request_mask &&
-		    time_before(jiffies, orangefs_inode->getattr_time))
-			return 0;
-	}
+	/* Must have all the attributes in the mask and be within cache time. */
+	if (!flags && time_before(jiffies, orangefs_inode->getattr_time))
+		return 0;
 
 	new_op = op_alloc(ORANGEFS_VFS_OP_GETATTR);
 	if (!new_op)
@@ -302,7 +295,7 @@ int orangefs_inode_getattr(struct inode *inode, int new, int bypass,
 	 * Size is the hardest attribute to get.  The incremental cost of any
 	 * other attribute is essentially zero.
 	 */
-	if (request_mask & STATX_SIZE || new)
+	if (flags)
 		new_op->upcall.req.getattr.mask = ORANGEFS_ATTR_SYS_ALL_NOHINT;
 	else
 		new_op->upcall.req.getattr.mask =
@@ -313,7 +306,7 @@ int orangefs_inode_getattr(struct inode *inode, int new, int bypass,
 	if (ret != 0)
 		goto out;
 
-	if (!new) {
+	if (!(flags & ORANGEFS_GETATTR_NEW)) {
 		ret = orangefs_inode_is_stale(inode,
 		    &new_op->downcall.resp.getattr.attributes,
 		    new_op->downcall.resp.getattr.link_target);
@@ -329,7 +322,7 @@ int orangefs_inode_getattr(struct inode *inode, int new, int bypass,
 	case S_IFREG:
 		inode->i_flags = orangefs_inode_flags(&new_op->
 		    downcall.resp.getattr.attributes);
-		if (request_mask & STATX_SIZE || new) {
+		if (flags) {
 			inode_size = (loff_t)new_op->
 			    downcall.resp.getattr.attributes.size;
 			inode->i_size = inode_size;
@@ -343,7 +336,7 @@ int orangefs_inode_getattr(struct inode *inode, int new, int bypass,
 		}
 		break;
 	case S_IFDIR:
-		if (request_mask & STATX_SIZE || new) {
+		if (flags) {
 			inode->i_size = PAGE_SIZE;
 			spin_lock(&inode->i_lock);
 			inode_set_bytes(inode, inode->i_size);
@@ -352,7 +345,7 @@ int orangefs_inode_getattr(struct inode *inode, int new, int bypass,
 		set_nlink(inode, 1);
 		break;
 	case S_IFLNK:
-		if (new) {
+		if (flags & ORANGEFS_GETATTR_NEW) {
 			inode->i_size = (loff_t)strlen(new_op->
 			    downcall.resp.getattr.link_target);
 			ret = strscpy(orangefs_inode->link_target,
@@ -393,10 +386,6 @@ int orangefs_inode_getattr(struct inode *inode, int new, int bypass,
 
 	orangefs_inode->getattr_time = jiffies +
 	    orangefs_getattr_timeout_msecs*HZ/1000;
-	if (request_mask & STATX_SIZE || new)
-		orangefs_inode->getattr_mask = STATX_BASIC_STATS;
-	else
-		orangefs_inode->getattr_mask = STATX_BASIC_STATS & ~STATX_SIZE;
 	ret = 0;
 out:
 	op_release(new_op);
-- 
2.19.0


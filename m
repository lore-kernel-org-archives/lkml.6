Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71791ECDE46
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 20:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2945020868
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 20:20:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=philpotter-co-uk.20150623.gappssmtp.com header.i=@philpotter-co-uk.20150623.gappssmtp.com header.b="nmOCSLyY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2945020868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=philpotter.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729100AbeJXEpE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 00:45:04 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53764 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727667AbeJXEpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 00:45:03 -0400
Received: by mail-wm1-f66.google.com with SMTP id f8-v6so692127wmc.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 13:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=jSWvX4QxrsoC+ZiESoxasWdqpZ9hWx9gFFsef9JZrNg=;
        b=nmOCSLyY/o648Zx1j6VahFWJsTKRtVgwiKM6YiDRixuYevAjr6y84Y5V6M2TxMMhku
         RUJvawazuUOV11ZO8bTvmHMpzqkq3L+kFG3dXLxomNtxwwOR8hUBZWwd45TKCT4AgA2j
         LDw9GiMTVvrxzWhhGvIq7Or7icdmuH5MTAXYipZ7RJGMXWDAmqexd3X2nSn7cBLK3sig
         gAOOHGIs4Tza1uOKfn0cSMy+DgI9cY1AOy1s++zqFIsxcaNIanShGM+xwXU3JzMaYXOC
         Aa+J29/IfWv9G3LyW9WsdGZdHCQUdgzqpgIWky3eUF/AMlNak7iusxNvfsnYRSfp4Cmj
         iRTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=jSWvX4QxrsoC+ZiESoxasWdqpZ9hWx9gFFsef9JZrNg=;
        b=mdb+HYxf95xlbinTlXzhhc37h9ykgkwrQI7mXxAIZQ00b7fhCd+qf8gPc3cRtP9Chy
         CJHnpmKyoxQE6ov9tA78L2J2SFQ0qUBbBD/VjsYirtghMpWm/erKk7IBPZM8dP6tP58c
         2iDYvpkyPU9Gd9TBFfo0TT+fwJzJ/7obSR7GnI3KkMva4ruEg7JUWa7h+XCt8bSQcHKd
         RjRdjKbpjGtnAcoKZld7Jx47mflBZFNHxI/60OmTR6m7qtgUNCT92V7qF846GCqJAsMr
         TO1Zzk4MsFMDNJVS9P4QSBu0hN0OKrt8aGMirOdj4zupDwjk29qJQ/hskPF1jy+/AV+9
         3XGA==
X-Gm-Message-State: ABuFfoiJZtO5+N74PVB58W/jcF3ovb30FeK8egwayPsNivCPeIJ9moQr
        +ChqsvQ/0oxG+Y/otXR3pTaLEw==
X-Google-Smtp-Source: ACcGV62CkJWOfwMoq/Yj3fPlZ1mbZRYVCy0z6ZabJ6ipvTg/3HYXNyK1K1Teh01kuPkZDojRx5jh+w==
X-Received: by 2002:a1c:9f41:: with SMTP id i62-v6mr23061793wme.53.1540326005409;
        Tue, 23 Oct 2018 13:20:05 -0700 (PDT)
Received: from pathfinder (62-64-249-96.dynamic.dsl.as9105.com. [62.64.249.96])
        by smtp.gmail.com with ESMTPSA id z185-v6sm4373951wmz.47.2018.10.23.13.20.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Oct 2018 13:20:04 -0700 (PDT)
Date:   Tue, 23 Oct 2018 21:20:04 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     linux-nilfs@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, amir73il@gmail.com,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org
Subject: [RFC][PATCH v2 09/10] nilfs2: use common file type conversion
Message-ID: <20181023202004.GA15745@pathfinder>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Deduplicate the nilfs2 file type conversion implementation.

Original patch by Amir Goldstein.

v2:
- Compile-time checks added by Phillip Potter to make
  sure the NILFS_FT_x enum values stay same as FT_x values

v1:
- Initial implementation

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 fs/nilfs2/dir.c                    | 54 +++++++++++-------------------
 include/uapi/linux/nilfs2_ondisk.h |  1 +
 2 files changed, 20 insertions(+), 35 deletions(-)

diff --git a/fs/nilfs2/dir.c b/fs/nilfs2/dir.c
index 81394e22d0a0..168238278d24 100644
--- a/fs/nilfs2/dir.c
+++ b/fs/nilfs2/dir.c
@@ -229,35 +229,25 @@ static struct nilfs_dir_entry *nilfs_next_entry(struct nilfs_dir_entry *p)
 					  nilfs_rec_len_from_disk(p->rec_len));
 }
 
-static unsigned char
-nilfs_filetype_table[NILFS_FT_MAX] = {
-	[NILFS_FT_UNKNOWN]	= DT_UNKNOWN,
-	[NILFS_FT_REG_FILE]	= DT_REG,
-	[NILFS_FT_DIR]		= DT_DIR,
-	[NILFS_FT_CHRDEV]	= DT_CHR,
-	[NILFS_FT_BLKDEV]	= DT_BLK,
-	[NILFS_FT_FIFO]		= DT_FIFO,
-	[NILFS_FT_SOCK]		= DT_SOCK,
-	[NILFS_FT_SYMLINK]	= DT_LNK,
-};
-
-#define S_SHIFT 12
-static unsigned char
-nilfs_type_by_mode[S_IFMT >> S_SHIFT] = {
-	[S_IFREG >> S_SHIFT]	= NILFS_FT_REG_FILE,
-	[S_IFDIR >> S_SHIFT]	= NILFS_FT_DIR,
-	[S_IFCHR >> S_SHIFT]	= NILFS_FT_CHRDEV,
-	[S_IFBLK >> S_SHIFT]	= NILFS_FT_BLKDEV,
-	[S_IFIFO >> S_SHIFT]	= NILFS_FT_FIFO,
-	[S_IFSOCK >> S_SHIFT]	= NILFS_FT_SOCK,
-	[S_IFLNK >> S_SHIFT]	= NILFS_FT_SYMLINK,
-};
-
 static void nilfs_set_de_type(struct nilfs_dir_entry *de, struct inode *inode)
 {
-	umode_t mode = inode->i_mode;
-
-	de->file_type = nilfs_type_by_mode[(mode & S_IFMT)>>S_SHIFT];
+	/*
+	 * compile-time asserts that generic FT_x types
+	 * still match NILFS_FT_x types - no need to list
+	 * in other functions as well as build will
+	 * fail either way
+	 */
+	BUILD_BUG_ON(NILFS_FT_UNKNOWN != FT_UNKNOWN);
+	BUILD_BUG_ON(NILFS_FT_REG_FILE != FT_REG_FILE);
+	BUILD_BUG_ON(NILFS_FT_DIR != FT_DIR);
+	BUILD_BUG_ON(NILFS_FT_CHRDEV != FT_CHRDEV);
+	BUILD_BUG_ON(NILFS_FT_BLKDEV != FT_BLKDEV);
+	BUILD_BUG_ON(NILFS_FT_FIFO != FT_FIFO);
+	BUILD_BUG_ON(NILFS_FT_SOCK != FT_SOCK);
+	BUILD_BUG_ON(NILFS_FT_SYMLINK != FT_SYMLINK);
+	BUILD_BUG_ON(NILFS_FT_MAX != FT_MAX);
+
+	de->file_type = fs_umode_to_ftype(inode->i_mode);
 }
 
 static int nilfs_readdir(struct file *file, struct dir_context *ctx)
@@ -293,15 +283,9 @@ static int nilfs_readdir(struct file *file, struct dir_context *ctx)
 				return -EIO;
 			}
 			if (de->inode) {
-				unsigned char t;
-
-				if (de->file_type < NILFS_FT_MAX)
-					t = nilfs_filetype_table[de->file_type];
-				else
-					t = DT_UNKNOWN;
-
 				if (!dir_emit(ctx, de->name, de->name_len,
-						le64_to_cpu(de->inode), t)) {
+						le64_to_cpu(de->inode),
+						fs_dtype(de->file_type))) {
 					nilfs_put_page(page);
 					return 0;
 				}
diff --git a/include/uapi/linux/nilfs2_ondisk.h b/include/uapi/linux/nilfs2_ondisk.h
index a7e66ab11d1d..90362b1957f1 100644
--- a/include/uapi/linux/nilfs2_ondisk.h
+++ b/include/uapi/linux/nilfs2_ondisk.h
@@ -309,6 +309,7 @@ struct nilfs_dir_entry {
 /*
  * NILFS directory file types.  Only the low 3 bits are used.  The
  * other bits are reserved for now.
+ * Values should match common file type values in file_type.h.
  */
 enum {
 	NILFS_FT_UNKNOWN,
-- 
2.17.2


Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B2DC7112C
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 20:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6040220813
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 20:20:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=philpotter-co-uk.20150623.gappssmtp.com header.i=@philpotter-co-uk.20150623.gappssmtp.com header.b="qee9r6V/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6040220813
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=philpotter.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729035AbeJXEpA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 00:45:00 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35322 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728946AbeJXEo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 00:44:59 -0400
Received: by mail-wm1-f67.google.com with SMTP id w186-v6so3116058wmf.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 13:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=JftqL+okrKcXPO7UtivHdzpGqZmRsOYm/0Ei3vm9z68=;
        b=qee9r6V/5gl2gOpRgL/ZHnnDH2EdJqBaKpVL+D9n/OU5RWd2KOLdHYmjA69IpNtf2A
         awrBTUmQHYVXHySJS1USAcBPw/sYpRlnhvqWVi8fdgDGPGFedRFhktg2txc7Fzl+dNz5
         6anSY5Ghr4Ju0Xk0Mt/Cg/z0ypwV2z6WK4m+cZD9TKQMFdGfxo72wHY+hbCJHghU83iw
         gY1dvpfzMS36J9hQmnVtXNIOLnCtqirzO/X0IxEWLo7djkmkkV86nNBnjGIyrbikgVEj
         XxOKt8IzWLlV8MbD6/n8+/1UNS4obVmgT/4O2hyIosLMr/75+R5s/8QOL3IUD1u8dsBC
         /cDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=JftqL+okrKcXPO7UtivHdzpGqZmRsOYm/0Ei3vm9z68=;
        b=kWGiEMI/gvplcE1nEnO0aeziPhOYHLfD+z/0pbqoYQJbVFA3Uvv51dz83c/jpr7nIG
         HwUUrJzhh6dyAbkRJbVv9XL2L3gdVx/+ZacqiC35ZakXMGR6lLWHfZeEBwBhdHR8f0y4
         3nETychGz/iHLWlqKelo1qjTXwsqfFK+oj1BTsyIMu2ERl49fknsOH7VC0vaSPhWPT00
         npExlf4lFf37xDqMlKxCnpY0ZPo01BjgNsP64AprxOCeClj9OjUgjUVzWcmwxncvQiNG
         6urh7EZp5V6tBzvxhJXtgzr2LpMn3gl9zuFjeHZll2D4bWubJ40QMC126X0D/lxpHRup
         /HEA==
X-Gm-Message-State: ABuFfojNalZFku9GBvIpRIUzFhtasKlyPVRzzBiejRVg0M1cmFYeVBg+
        4J/B1mUkZ+VuRpD4uRIFiiaxgQ==
X-Google-Smtp-Source: ACcGV61PN2RjenVxMBBP51NVI5/8WWcvrDaqcLFt5NesZFBqHsx2P8YiaI9WYjPxU7SfJucptj2pow==
X-Received: by 2002:a1c:6655:: with SMTP id a82-v6mr22673396wmc.10.1540326001598;
        Tue, 23 Oct 2018 13:20:01 -0700 (PDT)
Received: from pathfinder (62-64-249-96.dynamic.dsl.as9105.com. [62.64.249.96])
        by smtp.gmail.com with ESMTPSA id m2-v6sm2524761wrj.80.2018.10.23.13.20.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Oct 2018 13:20:00 -0700 (PDT)
Date:   Tue, 23 Oct 2018 21:20:00 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     tytso@mit.edu
Cc:     linux-kernel@vger.kernel.org, amir73il@gmail.com,
        viro@zeniv.linux.org.uk, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC][PATCH v2 06/10] ext4: use common file type conversion
Message-ID: <20181023202000.GA15724@pathfinder>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Deduplicate the ext4 file type conversion implementation.

Original patch by Amir Goldstein.

v2:
- Rebased against Linux 4.19 by Phillip Potter
- This version does not replace the EXT4_FT_x defines from
  fs/ext4/ext4.h, as these values are now used in compile-time
  checks added by Phillip Potter to make sure they remain the
  same as FT_x values

v1:
- Initial implementation

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 fs/ext4/ext4.h | 35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index caff935fbeb8..4cb77a2cacdf 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2361,16 +2361,13 @@ static inline void ext4_update_dx_flag(struct inode *inode)
 	if (!ext4_has_feature_dir_index(inode->i_sb))
 		ext4_clear_inode_flag(inode, EXT4_INODE_INDEX);
 }
-static const unsigned char ext4_filetype_table[] = {
-	DT_UNKNOWN, DT_REG, DT_DIR, DT_CHR, DT_BLK, DT_FIFO, DT_SOCK, DT_LNK
-};
 
 static inline  unsigned char get_dtype(struct super_block *sb, int filetype)
 {
-	if (!ext4_has_feature_filetype(sb) || filetype >= EXT4_FT_MAX)
+	if (!ext4_has_feature_filetype(sb))
 		return DT_UNKNOWN;
 
-	return ext4_filetype_table[filetype];
+	return fs_dtype(filetype);
 }
 extern int ext4_check_all_de(struct inode *dir, struct buffer_head *bh,
 			     void *buf, int buf_size);
@@ -3055,22 +3052,28 @@ extern void initialize_dirent_tail(struct ext4_dir_entry_tail *t,
 extern int ext4_handle_dirty_dirent_node(handle_t *handle,
 					 struct inode *inode,
 					 struct buffer_head *bh);
-#define S_SHIFT 12
-static const unsigned char ext4_type_by_mode[(S_IFMT >> S_SHIFT) + 1] = {
-	[S_IFREG >> S_SHIFT]	= EXT4_FT_REG_FILE,
-	[S_IFDIR >> S_SHIFT]	= EXT4_FT_DIR,
-	[S_IFCHR >> S_SHIFT]	= EXT4_FT_CHRDEV,
-	[S_IFBLK >> S_SHIFT]	= EXT4_FT_BLKDEV,
-	[S_IFIFO >> S_SHIFT]	= EXT4_FT_FIFO,
-	[S_IFSOCK >> S_SHIFT]	= EXT4_FT_SOCK,
-	[S_IFLNK >> S_SHIFT]	= EXT4_FT_SYMLINK,
-};
 
 static inline void ext4_set_de_type(struct super_block *sb,
 				struct ext4_dir_entry_2 *de,
 				umode_t mode) {
+	/*
+	 * compile-time asserts that generic FT_x types
+	 * still match EXT4_FT_x types - no need to list
+	 * for other functions as well as build will
+	 * fail either way
+	 */
+	BUILD_BUG_ON(EXT4_FT_UNKNOWN != FT_UNKNOWN);
+	BUILD_BUG_ON(EXT4_FT_REG_FILE != FT_REG_FILE);
+	BUILD_BUG_ON(EXT4_FT_DIR != FT_DIR);
+	BUILD_BUG_ON(EXT4_FT_CHRDEV != FT_CHRDEV);
+	BUILD_BUG_ON(EXT4_FT_BLKDEV != FT_BLKDEV);
+	BUILD_BUG_ON(EXT4_FT_FIFO != FT_FIFO);
+	BUILD_BUG_ON(EXT4_FT_SOCK != FT_SOCK);
+	BUILD_BUG_ON(EXT4_FT_SYMLINK != FT_SYMLINK);
+	BUILD_BUG_ON(EXT4_FT_MAX != FT_MAX);
+
 	if (ext4_has_feature_filetype(sb))
-		de->file_type = ext4_type_by_mode[(mode & S_IFMT)>>S_SHIFT];
+		de->file_type = fs_umode_to_ftype(mode);
 }
 
 /* readpages.c */
-- 
2.17.2


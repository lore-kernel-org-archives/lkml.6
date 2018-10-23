Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E0F6C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 21:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22A7420813
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 21:20:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=philpotter-co-uk.20150623.gappssmtp.com header.i=@philpotter-co-uk.20150623.gappssmtp.com header.b="JvAjZcNs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22A7420813
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=philpotter.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728687AbeJXFpR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 01:45:17 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:32773 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbeJXFpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 01:45:16 -0400
Received: by mail-wm1-f67.google.com with SMTP id y140-v6so12509615wmd.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 14:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=jdd0D8AR1ApPlV0fOV572ah65ZvPkOSB5huK6z0QU0s=;
        b=JvAjZcNskoH3MGQFq7KxqX9Pb8V6RmE+HtvftWEDoKNjwvz82fLr9353EYRp/L4o8o
         J4Y3m+S5uPfy9Nre7t6IatK3AYQkf5n+iXH+bNB6t21R5Ufwi8QIcXpAL7u1p/ZuH13Q
         1p/GGEhZ4hcZsN4fSpeZMcxCudTz5zM43RWo4S0FENC7HX+9h1QFjVXqmV2FuTJzFnOb
         01bVQ9mgsL5MI65Mz4iQkGnonCRGUPASc4aTBFunqifFk8cO33n6YB6h4QoItdeydw2I
         Uc+gNbqw2R4AkKvEHpI5UXd6hQJDl8KabcWlC9fR/o68GpTMhFSNcfRpPKtwa+hOO8V3
         wtsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=jdd0D8AR1ApPlV0fOV572ah65ZvPkOSB5huK6z0QU0s=;
        b=ELAdsWQrH3ZQCCMO6yBkBgRA79J6Y+a0bM5fVi25ERawwZklaC4OanXT09yySLAsQs
         HeI0Xx/IwbthvszTvG9h0YxdHlKtI9de9zS9mQASumc8IFRfH///+3Ctc7wCs8Zbhh/b
         oYFk5a2eDm7djVgQD6bNJsxWbtzs0OUhNpNrapx7OPZIks/qN5iG41qJQkjV8gIyDETf
         i0/yreYKBOT/phS5wrDM0Z7160mUG3SyAhV/F6PQUNsBSwBD8dcy29tD6umVsyc6U4Rw
         5ijYheVmZR5hXblqRQ6JSeVUIMuCCzPAtpglYS9DVRWR5Mws7Hj01rasm+jQKldP6q6V
         T8Jg==
X-Gm-Message-State: ABuFfojsK6XRnzl3jrB2vi6AfI5I/2W9iK+xfb5nOCGI+i7EMp+fHZmB
        Rnm6l0wfKXprVIrr5hYxlDuVyQ==
X-Google-Smtp-Source: ACcGV61CSsReMTCgd9mQqZT8G2UL5SJew8gHMCNWF30VFc1w141A+XHmS7ZlVd4nKvCa6QHbyD6oDQ==
X-Received: by 2002:a1c:5e49:: with SMTP id s70-v6mr21544193wmb.131.1540329606955;
        Tue, 23 Oct 2018 14:20:06 -0700 (PDT)
Received: from pathfinder (62-64-249-96.dynamic.dsl.as9105.com. [62.64.249.96])
        by smtp.gmail.com with ESMTPSA id x8-v6sm5000735wrd.54.2018.10.23.14.20.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Oct 2018 14:20:06 -0700 (PDT)
Date:   Tue, 23 Oct 2018 22:20:05 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     jack@suse.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        amir73il@gmail.com, viro@zeniv.linux.org.uk,
        linux-ext4@vger.kernel.org
Subject: [RFC][PATCH v2 04/10] ext2: use common file type conversion
Message-ID: <20181023212005.GA16631@pathfinder>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Deduplicate the ext2 file type conversion implementation.

Original patch by Amir Goldstein.

v2:
- Rebased against Linux 4.19 by Phillip Potter
- This version does not remove EXT2_FT_x enum from fs/ext2/ext2.h,
  as these values are now used in compile-time checks added by
  Phillip Potter to make sure they remain the same as FT_x values

v1:
- Initial implementation

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 fs/ext2/dir.c | 51 ++++++++++++++++++++++-----------------------------
 1 file changed, 22 insertions(+), 29 deletions(-)

diff --git a/fs/ext2/dir.c b/fs/ext2/dir.c
index 3b8114def693..420d4b9e8980 100644
--- a/fs/ext2/dir.c
+++ b/fs/ext2/dir.c
@@ -252,33 +252,10 @@ ext2_validate_entry(char *base, unsigned offset, unsigned mask)
 	return (char *)p - base;
 }
 
-static unsigned char ext2_filetype_table[EXT2_FT_MAX] = {
-	[EXT2_FT_UNKNOWN]	= DT_UNKNOWN,
-	[EXT2_FT_REG_FILE]	= DT_REG,
-	[EXT2_FT_DIR]		= DT_DIR,
-	[EXT2_FT_CHRDEV]	= DT_CHR,
-	[EXT2_FT_BLKDEV]	= DT_BLK,
-	[EXT2_FT_FIFO]		= DT_FIFO,
-	[EXT2_FT_SOCK]		= DT_SOCK,
-	[EXT2_FT_SYMLINK]	= DT_LNK,
-};
-
-#define S_SHIFT 12
-static unsigned char ext2_type_by_mode[S_IFMT >> S_SHIFT] = {
-	[S_IFREG >> S_SHIFT]	= EXT2_FT_REG_FILE,
-	[S_IFDIR >> S_SHIFT]	= EXT2_FT_DIR,
-	[S_IFCHR >> S_SHIFT]	= EXT2_FT_CHRDEV,
-	[S_IFBLK >> S_SHIFT]	= EXT2_FT_BLKDEV,
-	[S_IFIFO >> S_SHIFT]	= EXT2_FT_FIFO,
-	[S_IFSOCK >> S_SHIFT]	= EXT2_FT_SOCK,
-	[S_IFLNK >> S_SHIFT]	= EXT2_FT_SYMLINK,
-};
-
 static inline void ext2_set_de_type(ext2_dirent *de, struct inode *inode)
 {
-	umode_t mode = inode->i_mode;
 	if (EXT2_HAS_INCOMPAT_FEATURE(inode->i_sb, EXT2_FEATURE_INCOMPAT_FILETYPE))
-		de->file_type = ext2_type_by_mode[(mode & S_IFMT)>>S_SHIFT];
+		de->file_type = fs_umode_to_ftype(inode->i_mode);
 	else
 		de->file_type = 0;
 }
@@ -293,14 +270,14 @@ ext2_readdir(struct file *file, struct dir_context *ctx)
 	unsigned long n = pos >> PAGE_SHIFT;
 	unsigned long npages = dir_pages(inode);
 	unsigned chunk_mask = ~(ext2_chunk_size(inode)-1);
-	unsigned char *types = NULL;
 	bool need_revalidate = !inode_eq_iversion(inode, file->f_version);
+	bool has_filetype;
 
 	if (pos > inode->i_size - EXT2_DIR_REC_LEN(1))
 		return 0;
 
-	if (EXT2_HAS_INCOMPAT_FEATURE(sb, EXT2_FEATURE_INCOMPAT_FILETYPE))
-		types = ext2_filetype_table;
+	has_filetype =
+		EXT2_HAS_INCOMPAT_FEATURE(sb, EXT2_FEATURE_INCOMPAT_FILETYPE);
 
 	for ( ; n < npages; n++, offset = 0) {
 		char *kaddr, *limit;
@@ -335,8 +312,24 @@ ext2_readdir(struct file *file, struct dir_context *ctx)
 			if (de->inode) {
 				unsigned char d_type = DT_UNKNOWN;
 
-				if (types && de->file_type < EXT2_FT_MAX)
-					d_type = types[de->file_type];
+				/*
+				 * compile-time asserts that generic FT_x types
+				 * still match EXT2_FT_x types - no need to list
+				 * for other functions as well as build will
+				 * fail either way
+				 */
+				BUILD_BUG_ON(EXT2_FT_UNKNOWN != FT_UNKNOWN);
+				BUILD_BUG_ON(EXT2_FT_REG_FILE != FT_REG_FILE);
+				BUILD_BUG_ON(EXT2_FT_DIR != FT_DIR);
+				BUILD_BUG_ON(EXT2_FT_CHRDEV != FT_CHRDEV);
+				BUILD_BUG_ON(EXT2_FT_BLKDEV != FT_BLKDEV);
+				BUILD_BUG_ON(EXT2_FT_FIFO != FT_FIFO);
+				BUILD_BUG_ON(EXT2_FT_SOCK != FT_SOCK);
+				BUILD_BUG_ON(EXT2_FT_SYMLINK != FT_SYMLINK);
+				BUILD_BUG_ON(EXT2_FT_MAX != FT_MAX);
+
+				if (has_filetype)
+					d_type = fs_dtype(de->file_type);
 
 				if (!dir_emit(ctx, de->name, de->name_len,
 						le32_to_cpu(de->inode),
-- 
2.17.2


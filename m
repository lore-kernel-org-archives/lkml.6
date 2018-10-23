Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC2EECDE47
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 20:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 724E020830
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 20:20:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=philpotter-co-uk.20150623.gappssmtp.com header.i=@philpotter-co-uk.20150623.gappssmtp.com header.b="f15T7iMM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 724E020830
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=philpotter.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729114AbeJXEpQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 00:45:16 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38277 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728992AbeJXEpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 00:45:00 -0400
Received: by mail-wr1-f68.google.com with SMTP id d10-v6so3104067wrs.5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 13:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=A/jiG96sg0/Qi5Ypt2KE8HkbyupaifGhdu3oPA0BQsI=;
        b=f15T7iMME5asxnV69hCKOrgoXtdxbOS5TxcXhdynPgkC590ZoMFAFdolJvKwvQJYO8
         ccLS4fSC5LJbzrvYSAV+xiQHwKcCWmEcxMBK9B5df0JgVshC/uTyxrh9f8Q0bXtvwc6y
         +AdIOlhVbM9RM7qmgmY5wOFUotmngIiJb3yd6MrwxrG8SuUcMOUsQCBQiGTQu/MV3M+M
         jogvsCxoWbeIiYFMPsxY0FlwX3H3Zds50EFeAd/YF+aDOgDiNh64kW+cTmMjxsqlNPBX
         DEiHcRHqxG8+/sDw2FBS3TN7JlB3z8PuKF1GjTocl5tL51Yv0y3pFf27Bo2++VOKPwVh
         Q/RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=A/jiG96sg0/Qi5Ypt2KE8HkbyupaifGhdu3oPA0BQsI=;
        b=KgmsUFwXQcu9unVfIpkqje8ugYnAL2VyFJNYjtVOTRjktK9mihcAeqJoaEkhfD/dRL
         h/T60A6WdCupsh+fQBur5uPL+eJCxvd1bqvjSh5dLQrmWRvm5nnhy2OUMVvLgcfqh2hC
         iDEHQTFpUkcuu72UytvgtORAh/bB0WrgcMLdwC6QBu87jJzKVBvDoiMXlyYE1XJZXwLR
         8Yn5E+49iWv6Jdn18/mZsN97LjX+nMBADzwAhfeTc3w4EUKc3r7zgK4eZSYzAs0v6AIP
         78FcZCk4zHkCeXdaaVpRAOe0I/OtaZAy0kDj5KBjTFgjpjVLfjJri09oqjzuuQXTqMKs
         CxJA==
X-Gm-Message-State: AGRZ1gK7vCxytbxi4hDPzw1nrDsLAiyhGhtVs4kZgjvpCxamVGPWmnnZ
        D2nMsTLa41XNb1fnIvx50+c67w==
X-Google-Smtp-Source: AJdET5dWs1WpKf4w89OuTfD4liCVVN6bkdEFfQpJJzulV9iYjGoUNeFQXN9+XdyP5O61h6eZ0GQZmA==
X-Received: by 2002:a5d:6a47:: with SMTP id t7-v6mr7612669wrw.78.1540326002875;
        Tue, 23 Oct 2018 13:20:02 -0700 (PDT)
Received: from pathfinder (62-64-249-96.dynamic.dsl.as9105.com. [62.64.249.96])
        by smtp.gmail.com with ESMTPSA id e196-v6sm4687560wmf.43.2018.10.23.13.20.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Oct 2018 13:20:02 -0700 (PDT)
Date:   Tue, 23 Oct 2018 21:20:01 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     mark@fasheh.com
Cc:     linux-kernel@vger.kernel.org, amir73il@gmail.com,
        viro@zeniv.linux.org.uk, jlbec@evilplan.org,
        linux-fsdevel@vger.kernel.org, ocfs2-devel@oss.oracle.com
Subject: [RFC][PATCH v2 07/10] ocfs2: use common file type conversion
Message-ID: <20181023202001.GA15731@pathfinder>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Deduplicate the ocfs2 file type conversion implementation.

Original patch by Amir Goldstein.

v2:
- This version does not replace the OCFS2_FT_x defines from
  fs/ocfs2/ocfs2_fs.h, as these values are now used in compile-time
  checks added by Phillip Potter to make sure they remain the
  same as FT_x values

v1:
- Initial implementation

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 fs/ocfs2/dir.c      | 32 ++++++++++++++++++--------------
 fs/ocfs2/ocfs2_fs.h | 13 +------------
 2 files changed, 19 insertions(+), 26 deletions(-)

diff --git a/fs/ocfs2/dir.c b/fs/ocfs2/dir.c
index b048d4fa3959..8a628633cb5c 100644
--- a/fs/ocfs2/dir.c
+++ b/fs/ocfs2/dir.c
@@ -69,10 +69,6 @@
 #define NAMEI_RA_BLOCKS  4
 #define NAMEI_RA_SIZE        (NAMEI_RA_CHUNKS * NAMEI_RA_BLOCKS)
 
-static unsigned char ocfs2_filetype_table[] = {
-	DT_UNKNOWN, DT_REG, DT_DIR, DT_CHR, DT_BLK, DT_FIFO, DT_SOCK, DT_LNK
-};
-
 static int ocfs2_do_extend_dir(struct super_block *sb,
 			       handle_t *handle,
 			       struct inode *dir,
@@ -1803,13 +1799,25 @@ static int ocfs2_dir_foreach_blk_id(struct inode *inode,
 		}
 		offset += le16_to_cpu(de->rec_len);
 		if (le64_to_cpu(de->inode)) {
-			unsigned char d_type = DT_UNKNOWN;
-
-			if (de->file_type < OCFS2_FT_MAX)
-				d_type = ocfs2_filetype_table[de->file_type];
+			/*
+			 * compile-time asserts that generic FT_x types
+			 * still match OCFS2_FT_x types - no need to list
+			 * in other functions as well as build will
+			 * fail either way
+			 */
+			BUILD_BUG_ON(OCFS2_FT_UNKNOWN != FT_UNKNOWN);
+			BUILD_BUG_ON(OCFS2_FT_REG_FILE != FT_REG_FILE);
+			BUILD_BUG_ON(OCFS2_FT_DIR != FT_DIR);
+			BUILD_BUG_ON(OCFS2_FT_CHRDEV != FT_CHRDEV);
+			BUILD_BUG_ON(OCFS2_FT_BLKDEV != FT_BLKDEV);
+			BUILD_BUG_ON(OCFS2_FT_FIFO != FT_FIFO);
+			BUILD_BUG_ON(OCFS2_FT_SOCK != FT_SOCK);
+			BUILD_BUG_ON(OCFS2_FT_SYMLINK != FT_SYMLINK);
+			BUILD_BUG_ON(OCFS2_FT_MAX != FT_MAX);
 
 			if (!dir_emit(ctx, de->name, de->name_len,
-				      le64_to_cpu(de->inode), d_type))
+				      le64_to_cpu(de->inode),
+				      fs_dtype(de->file_type)))
 				goto out;
 		}
 		ctx->pos += le16_to_cpu(de->rec_len);
@@ -1901,14 +1909,10 @@ static int ocfs2_dir_foreach_blk_el(struct inode *inode,
 				continue;
 			}
 			if (le64_to_cpu(de->inode)) {
-				unsigned char d_type = DT_UNKNOWN;
-
-				if (de->file_type < OCFS2_FT_MAX)
-					d_type = ocfs2_filetype_table[de->file_type];
 				if (!dir_emit(ctx, de->name,
 						de->name_len,
 						le64_to_cpu(de->inode),
-						d_type)) {
+						fs_dtype(de->file_type))) {
 					brelse(bh);
 					return 0;
 				}
diff --git a/fs/ocfs2/ocfs2_fs.h b/fs/ocfs2/ocfs2_fs.h
index 7071ad0dec90..a08e2622ace7 100644
--- a/fs/ocfs2/ocfs2_fs.h
+++ b/fs/ocfs2/ocfs2_fs.h
@@ -424,17 +424,6 @@ static struct ocfs2_system_inode_info ocfs2_system_inodes[NUM_SYSTEM_INODES] = {
 #define	OCFS2_LINKS_HI_SHIFT	16
 #define	OCFS2_DX_ENTRIES_MAX	(0xffffffffU)
 
-#define S_SHIFT			12
-static unsigned char ocfs2_type_by_mode[S_IFMT >> S_SHIFT] = {
-	[S_IFREG >> S_SHIFT]  = OCFS2_FT_REG_FILE,
-	[S_IFDIR >> S_SHIFT]  = OCFS2_FT_DIR,
-	[S_IFCHR >> S_SHIFT]  = OCFS2_FT_CHRDEV,
-	[S_IFBLK >> S_SHIFT]  = OCFS2_FT_BLKDEV,
-	[S_IFIFO >> S_SHIFT]  = OCFS2_FT_FIFO,
-	[S_IFSOCK >> S_SHIFT] = OCFS2_FT_SOCK,
-	[S_IFLNK >> S_SHIFT]  = OCFS2_FT_SYMLINK,
-};
-
 
 /*
  * Convenience casts
@@ -1629,7 +1618,7 @@ static inline int ocfs2_sprintf_system_inode_name(char *buf, int len,
 static inline void ocfs2_set_de_type(struct ocfs2_dir_entry *de,
 				    umode_t mode)
 {
-	de->file_type = ocfs2_type_by_mode[(mode & S_IFMT)>>S_SHIFT];
+	de->file_type = fs_umode_to_ftype(mode);
 }
 
 static inline int ocfs2_gd_is_discontig(struct ocfs2_group_desc *gd)
-- 
2.17.2


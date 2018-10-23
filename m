Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 606C1C67863
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 20:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2544D2081B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 20:20:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=philpotter-co-uk.20150623.gappssmtp.com header.i=@philpotter-co-uk.20150623.gappssmtp.com header.b="zglv6r9I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2544D2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=philpotter.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728989AbeJXEo7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 00:44:59 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40964 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728903AbeJXEo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 00:44:58 -0400
Received: by mail-wr1-f67.google.com with SMTP id q7-v6so3084569wrr.8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 13:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=izaZWa7XxJQGYb95ad5VL7uwpGF17o/DYcFIrwT2VP8=;
        b=zglv6r9IswmrApGQqYnwRA+44e3nOPrKcEsnAhjpdVjLacMCNeZjlodqMw0yt/VnRF
         T117GzZthiUDQnQ5a8nPRbxOcfSeGvJ6UtYbURGp2y9rIQy7bmr48pKl7qaAzajqVbsC
         5Yshuq8L2C8dg8lDs780BiE63fDEnhIf6vt5K1aNAi7rAv4jgOSeMkTFWe/jWixjlP9l
         wz7bwboHm9UrrIOc0iFHZvStZOHKKoKiqknudYmvbHEh0D/BiwdaqbEyBTV+jRS3vhXS
         hWbSXuC9rhpGNQTcMObG1CqI3i/ke/AvCkaVbqhmSCZ4BEz18s8faB/gOSEUSqewg5MD
         N7Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=izaZWa7XxJQGYb95ad5VL7uwpGF17o/DYcFIrwT2VP8=;
        b=UORe2P0CSb+j5VmIQwgsegJAW12kbRddQGr39zuSn6DVSBDI0KVQslNyZMkqo+1idT
         VtSqKawF+aGDFEBMlF7saQ0lz1mW6nGjN37rUWTwVLtBRBYJiQYSGhCSN/dQxAAaem0U
         6c4NoH8G0fsYgKaMnyELnOMn95HdY0buEFxv7CAbFsTORuujn8TDIrpvHh+RUWDdqnah
         kYaNm1oXxKR3+pQEYzU7O38uuxqyl0dEnGZkWnZyKYc7trnOgXd9CqJiuGahFCXVVZFD
         9L7tjEHVsBstzFbdc4B965ir40UEqLAN8fs7hGToDp1+bmp6r3Z/Rusat/K94mag5bXH
         gWGw==
X-Gm-Message-State: AGRZ1gI2Q8LpFAS7LlAEXBnNhu1JHQ04gsNoc9r/6WxfB0UtvwlPAoR1
        nwAb9X9jjyOJfft11Crdy9nKBg==
X-Google-Smtp-Source: AJdET5cyGmE3+Yp/Vsz7efD7YbSBa6tJnFGxnd7SvN9ann3a6ffItfqV1EXNuJFzPI7pqwugMzd98w==
X-Received: by 2002:adf:e485:: with SMTP id i5-v6mr12282364wrm.145.1540326000253;
        Tue, 23 Oct 2018 13:20:00 -0700 (PDT)
Received: from pathfinder (62-64-249-96.dynamic.dsl.as9105.com. [62.64.249.96])
        by smtp.gmail.com with ESMTPSA id 193-v6sm3667414wmj.21.2018.10.23.13.19.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Oct 2018 13:19:59 -0700 (PDT)
Date:   Tue, 23 Oct 2018 21:19:59 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     ooo@electrozaur.com
Cc:     linux-kernel@vger.kernel.org, amir73il@gmail.com,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org
Subject: [RFC][PATCH v2 05/10] exofs: use common file type conversion
Message-ID: <20181023201959.GA15715@pathfinder>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Deduplicate the exofs file type conversion implementation.

Original patch by Amir Goldstein.

v2:
- This version does not remove EXOFS_FT_x enum from fs/exofs/common.h,
  as these values are now used in compile-time checks added by
  Phillip Potter to make sure they remain the same as FT_x values

v1:
- Initial implementation

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 fs/exofs/dir.c | 49 ++++++++++++++++++-------------------------------
 1 file changed, 18 insertions(+), 31 deletions(-)

diff --git a/fs/exofs/dir.c b/fs/exofs/dir.c
index f0138674c1ed..2e3161ca9014 100644
--- a/fs/exofs/dir.c
+++ b/fs/exofs/dir.c
@@ -204,33 +204,10 @@ exofs_validate_entry(char *base, unsigned offset, unsigned mask)
 	return (char *)p - base;
 }
 
-static unsigned char exofs_filetype_table[EXOFS_FT_MAX] = {
-	[EXOFS_FT_UNKNOWN]	= DT_UNKNOWN,
-	[EXOFS_FT_REG_FILE]	= DT_REG,
-	[EXOFS_FT_DIR]		= DT_DIR,
-	[EXOFS_FT_CHRDEV]	= DT_CHR,
-	[EXOFS_FT_BLKDEV]	= DT_BLK,
-	[EXOFS_FT_FIFO]		= DT_FIFO,
-	[EXOFS_FT_SOCK]		= DT_SOCK,
-	[EXOFS_FT_SYMLINK]	= DT_LNK,
-};
-
-#define S_SHIFT 12
-static unsigned char exofs_type_by_mode[S_IFMT >> S_SHIFT] = {
-	[S_IFREG >> S_SHIFT]	= EXOFS_FT_REG_FILE,
-	[S_IFDIR >> S_SHIFT]	= EXOFS_FT_DIR,
-	[S_IFCHR >> S_SHIFT]	= EXOFS_FT_CHRDEV,
-	[S_IFBLK >> S_SHIFT]	= EXOFS_FT_BLKDEV,
-	[S_IFIFO >> S_SHIFT]	= EXOFS_FT_FIFO,
-	[S_IFSOCK >> S_SHIFT]	= EXOFS_FT_SOCK,
-	[S_IFLNK >> S_SHIFT]	= EXOFS_FT_SYMLINK,
-};
-
 static inline
 void exofs_set_de_type(struct exofs_dir_entry *de, struct inode *inode)
 {
-	umode_t mode = inode->i_mode;
-	de->file_type = exofs_type_by_mode[(mode & S_IFMT) >> S_SHIFT];
+	de->file_type = fs_umode_to_ftype(inode->i_mode);
 }
 
 static int
@@ -279,17 +256,27 @@ exofs_readdir(struct file *file, struct dir_context *ctx)
 				exofs_put_page(page);
 				return -EIO;
 			}
-			if (de->inode_no) {
-				unsigned char t;
 
-				if (de->file_type < EXOFS_FT_MAX)
-					t = exofs_filetype_table[de->file_type];
-				else
-					t = DT_UNKNOWN;
+			/*
+			 * compile-time asserts that generic FT_x types
+			 * still match EXOFS_FT_x types - no need to list
+			 * for other functions as well as build will
+			 * fail either way
+			 */
+			BUILD_BUG_ON(EXOFS_FT_UNKNOWN != FT_UNKNOWN);
+			BUILD_BUG_ON(EXOFS_FT_REG_FILE != FT_REG_FILE);
+			BUILD_BUG_ON(EXOFS_FT_DIR != FT_DIR);
+			BUILD_BUG_ON(EXOFS_FT_CHRDEV != FT_CHRDEV);
+			BUILD_BUG_ON(EXOFS_FT_BLKDEV != FT_BLKDEV);
+			BUILD_BUG_ON(EXOFS_FT_FIFO != FT_FIFO);
+			BUILD_BUG_ON(EXOFS_FT_SOCK != FT_SOCK);
+			BUILD_BUG_ON(EXOFS_FT_SYMLINK != FT_SYMLINK);
+			BUILD_BUG_ON(EXOFS_FT_MAX != FT_MAX);
 
+			if (de->inode_no) {
 				if (!dir_emit(ctx, de->name, de->name_len,
 						le64_to_cpu(de->inode_no),
-						t)) {
+						fs_dtype(de->file_type))) {
 					exofs_put_page(page);
 					return 0;
 				}
-- 
2.17.2


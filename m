Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E95ECDE44
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 20:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E017A20838
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 20:20:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=philpotter-co-uk.20150623.gappssmtp.com header.i=@philpotter-co-uk.20150623.gappssmtp.com header.b="17hMlnfj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E017A20838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=philpotter.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729079AbeJXEpD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 00:45:03 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37347 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728894AbeJXEpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 00:45:02 -0400
Received: by mail-wm1-f67.google.com with SMTP id x19-v6so3107969wmc.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 13:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=PVWfVWT4ECCVj7C6DbvMBrAHgWzq8LcG4MQkwdUjwlc=;
        b=17hMlnfjRpw42xR239fooG/+xzC3NgK29J0arw2o7K0mzF/W15Urybq7+o7IqlrlEs
         TWmiIuZJgrnD15/lyMVH3mVHjcq3jSrVggz6RiiiBI6JDa6AgOqtfraUsgfWiriqmh15
         Zh/NMylSHg9hWxHNrQwULjlYjcwKng/elpWiV/fzPJolQcsSa7UOQiAqaUxzK18JBbJl
         sasR2fDA89fqkibbxSoptHyivFe5sgwLRFheKSAhSF4hm5iaUIoCjurKIRndZTQSw23U
         jU3iKUqBJBPdvmJApkGxAuHQI4doPOKw2izW67TQ+SovG7qYxI56hNOr3h/r/kTOFX8I
         Gpow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=PVWfVWT4ECCVj7C6DbvMBrAHgWzq8LcG4MQkwdUjwlc=;
        b=heFzf27d3u9XesklDcj/FurZDEsEyi+O0rIDywwKmBIBqobOMFq4+i4ZMRqXgbRvSU
         ggaW5XW0/RKvce3bfTkhJRWm/BJ90swd2VhGTWFDT81zgd7F3OlM28T/pnurnpsNzPcu
         bs791/xXurpTYnoRPJp3PbEN6PLUUOzQ/HeE7NUK8A9isV1tXduG/dCEhsRib4hgr8hs
         fsxf9MwMkcyvx+2e9Dgz/gMzDyLNtcZ5Cw3FHD9vDQPeqvFQYFCzsE0loO4TOYF+56lj
         WAzv9T3f/W1lIieaAb2Xd3vLLWqAj3WqIJLAK+3nVQq8RklM1I2u35BzkqPinsM2moDT
         YGSQ==
X-Gm-Message-State: AGRZ1gI+xtfuufAu6b7uO0R8tY+Mtj5AaOcOmLyNFeMX5vGu8UkhwCaa
        1UzpnWzpEOa3/RfHCKbRKZOxmw==
X-Google-Smtp-Source: AJdET5fTyA/urAjwIn8tQLPylnlOoJmqQ8aDexaHQXU1M0ALqvcNSPWrgRfW3Ohj8s7pbhL7ivTjuw==
X-Received: by 2002:a1c:454:: with SMTP id 81-v6mr3335135wme.148.1540326004113;
        Tue, 23 Oct 2018 13:20:04 -0700 (PDT)
Received: from pathfinder (62-64-249-96.dynamic.dsl.as9105.com. [62.64.249.96])
        by smtp.gmail.com with ESMTPSA id a84-v6sm2529120wmf.46.2018.10.23.13.20.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Oct 2018 13:20:03 -0700 (PDT)
Date:   Tue, 23 Oct 2018 21:20:02 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     jaegeuk@kernel.org
Cc:     linux-kernel@vger.kernel.org, amir73il@gmail.com,
        viro@zeniv.linux.org.uk, yuchao0@huawei.com,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org
Subject: [RFC][PATCH v2 08/10] f2fs: use common file type conversion
Message-ID: <20181023202002.GA15738@pathfinder>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Deduplicate the f2fs file type conversion implementation.

Original patch by Amir Goldstein.

v2:
- Rebased against Linux 4.19 by Phillip Potter
- Compile-time checks added by Phillip Potter to make
  sure the F2FS_FT_x enum values stay same as FT_x values

v1:
- Initial implementation

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 fs/f2fs/dir.c           | 43 +++++++++++++++++------------------------
 fs/f2fs/inline.c        |  2 +-
 include/linux/f2fs_fs.h |  8 +++++---
 3 files changed, 24 insertions(+), 29 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index ecc3a4e2be96..dcb503da0d86 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -39,37 +39,30 @@ static unsigned int bucket_blocks(unsigned int level)
 		return 4;
 }
 
-static unsigned char f2fs_filetype_table[F2FS_FT_MAX] = {
-	[F2FS_FT_UNKNOWN]	= DT_UNKNOWN,
-	[F2FS_FT_REG_FILE]	= DT_REG,
-	[F2FS_FT_DIR]		= DT_DIR,
-	[F2FS_FT_CHRDEV]	= DT_CHR,
-	[F2FS_FT_BLKDEV]	= DT_BLK,
-	[F2FS_FT_FIFO]		= DT_FIFO,
-	[F2FS_FT_SOCK]		= DT_SOCK,
-	[F2FS_FT_SYMLINK]	= DT_LNK,
-};
-
-static unsigned char f2fs_type_by_mode[S_IFMT >> S_SHIFT] = {
-	[S_IFREG >> S_SHIFT]	= F2FS_FT_REG_FILE,
-	[S_IFDIR >> S_SHIFT]	= F2FS_FT_DIR,
-	[S_IFCHR >> S_SHIFT]	= F2FS_FT_CHRDEV,
-	[S_IFBLK >> S_SHIFT]	= F2FS_FT_BLKDEV,
-	[S_IFIFO >> S_SHIFT]	= F2FS_FT_FIFO,
-	[S_IFSOCK >> S_SHIFT]	= F2FS_FT_SOCK,
-	[S_IFLNK >> S_SHIFT]	= F2FS_FT_SYMLINK,
-};
-
 static void set_de_type(struct f2fs_dir_entry *de, umode_t mode)
 {
-	de->file_type = f2fs_type_by_mode[(mode & S_IFMT) >> S_SHIFT];
+	/*
+	 * compile-time asserts that generic FT_x types
+	 * still match F2FS_FT_x types - no need to list
+	 * in other functions as well as build will
+	 * fail either way
+	 */
+	BUILD_BUG_ON(F2FS_FT_UNKNOWN != FT_UNKNOWN);
+	BUILD_BUG_ON(F2FS_FT_REG_FILE != FT_REG_FILE);
+	BUILD_BUG_ON(F2FS_FT_DIR != FT_DIR);
+	BUILD_BUG_ON(F2FS_FT_CHRDEV != FT_CHRDEV);
+	BUILD_BUG_ON(F2FS_FT_BLKDEV != FT_BLKDEV);
+	BUILD_BUG_ON(F2FS_FT_FIFO != FT_FIFO);
+	BUILD_BUG_ON(F2FS_FT_SOCK != FT_SOCK);
+	BUILD_BUG_ON(F2FS_FT_SYMLINK != FT_SYMLINK);
+	BUILD_BUG_ON(F2FS_FT_MAX != FT_MAX);
+
+	de->file_type = fs_umode_to_ftype(mode);
 }
 
 unsigned char f2fs_get_de_type(struct f2fs_dir_entry *de)
 {
-	if (de->file_type < F2FS_FT_MAX)
-		return f2fs_filetype_table[de->file_type];
-	return DT_UNKNOWN;
+	return fs_dtype(de->file_type);
 }
 
 static unsigned long dir_block_index(unsigned int level,
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 115dc219344b..d47448904f66 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -460,7 +460,7 @@ static int f2fs_add_inline_entries(struct inode *dir, void *inline_dentry)
 		new_name.len = le16_to_cpu(de->name_len);
 
 		ino = le32_to_cpu(de->ino);
-		fake_mode = f2fs_get_de_type(de) << S_SHIFT;
+		fake_mode = f2fs_get_de_type(de) << S_DT_SHIFT;
 
 		err = f2fs_add_regular_entry(dir, &new_name, NULL, NULL,
 							ino, fake_mode);
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index f70f8ac9c4f4..fb8ad4d87132 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -524,7 +524,11 @@ struct f2fs_dentry_block {
 	__u8 filename[NR_DENTRY_IN_BLOCK][F2FS_SLOT_LEN];
 } __packed;
 
-/* file types used in inode_info->flags */
+/*
+ * file types used in inode_info->flags
+ *
+ * Values should match common file type values in file_type.h.
+ */
 enum {
 	F2FS_FT_UNKNOWN,
 	F2FS_FT_REG_FILE,
@@ -537,8 +541,6 @@ enum {
 	F2FS_FT_MAX
 };
 
-#define S_SHIFT 12
-
 #define	F2FS_DEF_PROJID		0	/* default project ID */
 
 #endif  /* _LINUX_F2FS_FS_H */
-- 
2.17.2


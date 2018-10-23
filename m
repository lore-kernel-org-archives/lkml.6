Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8695C67863
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 20:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8401920671
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 20:20:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=philpotter-co-uk.20150623.gappssmtp.com header.i=@philpotter-co-uk.20150623.gappssmtp.com header.b="e4dT16Ig"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8401920671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=philpotter.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728865AbeJXEoz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 00:44:55 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45540 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725952AbeJXEoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 00:44:54 -0400
Received: by mail-wr1-f66.google.com with SMTP id f17-v6so3077761wrs.12
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 13:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=nDydAwn/UZb4Pwj2ONeyYMKZc2ToE5Dpnz+lDSZ7MsE=;
        b=e4dT16IgiroexzLHbLKHYGkoTCMgYQNzYN/eS9nJM2tpQLJWJFGEotdPPnwrdmQGzS
         UBy10xLwgLcDjT+oMrWC3PQFpV3V0/1UGaKNBsZrZtB19eJMW4mT7Kjyq27ClxtaW4za
         0v3gsmnaACXDywlRsqsBnLGgmhzzlW914Gy1S711gYdAZil7YKvY3tswlBctdOXOFsFv
         kyrOCoPS4njjK6BZj+9JnI7ErGoprk0xgYjnEZhHPwfpq8qZknhaX8H/03QP+yKICJLz
         SmqFL07br5LkSw9DKPnfxU03K9w3SOVErtX+jAjMVCX9msrJsR/Gd7483sDUIf+e1OKf
         gYiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=nDydAwn/UZb4Pwj2ONeyYMKZc2ToE5Dpnz+lDSZ7MsE=;
        b=n+ZUE7krQGY0AdVqrGrmNGWXY8MX48RkR0VS69qnUYqN6XytO7zCtmij0X8TR1YaHE
         SaYCYzf7rmamD3XSLA0364mXSyyom2aJ+2L23JzU7PeO2ilW0pQkQ3Sp/bXYCV8UgCKK
         3q32fwW/M7AgEofWefT9wrNzWO5FG36My8/aMcbcqHEftAUfLQZOn+dKAHN/aJPea3dL
         Mwhz81aYTUDfWQPNBNzPqFXP1A8lQNYEOhHnDmqtf0GFNkPxWBa7gA8PECrFJ3h8xT5a
         I/NM6K4L4AzKZiDNaPUInxRvm9hjx+VCwatnuILXJrL2NkTjHdFkK2RpbuhEu46K9b/8
         ZX1g==
X-Gm-Message-State: ABuFfohZQkn4XZwxZ5catCH76vMpTB9jtmEPo8jcp4B9kp4jvRhn2IKA
        dFIbcP9OihGP3PNo5AIosbV8ow==
X-Google-Smtp-Source: ACcGV61p2gpyZANJ7Spa2LSnOmgcSm+ljN1rEWDVGsI3lFiFYozm71+HZhtuTdzUK5DMenWv+zQ++g==
X-Received: by 2002:a05:6000:8e:: with SMTP id m14mr25227752wrx.302.1540325995064;
        Tue, 23 Oct 2018 13:19:55 -0700 (PDT)
Received: from pathfinder (62-64-249-96.dynamic.dsl.as9105.com. [62.64.249.96])
        by smtp.gmail.com with ESMTPSA id u13-v6sm1677796wrn.11.2018.10.23.13.19.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Oct 2018 13:19:54 -0700 (PDT)
Date:   Tue, 23 Oct 2018 21:19:53 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     viro@zeniv.linux.org.uk
Cc:     linux-kernel@vger.kernel.org, amir73il@gmail.com,
        linux-fsdevel@vger.kernel.org
Subject: [RFC][PATCH v3 01/10] fs: common implementation of file type
Message-ID: <20181023201953.GA15687@pathfinder>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many file systems use a copy&paste implementation
of dirent to on-disk file type conversions.

Create a common implementation to be used by file systems
with some useful conversion helpers to reduce open coded
file type conversions in file system code.

Original patch written by Amir Goldstein.

v3:
- Rebased against Linux 4.19 by Phillip Potter
- Added SPDX tag to new include/linux/file_type.h
- Added include/linux/file_type.h to MAINTAINERS

v2:
- s/DT_MASK/S_DT_MASK to fix redefinition in drivers/scsi/qla2xxx/qla_def.h
- Explicit initialization of fs_dtype_by_ftype[] using [FT_*] = DT_*

v1:
- Initial implementation

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 MAINTAINERS               |   1 +
 include/linux/file_type.h | 108 ++++++++++++++++++++++++++++++++++++++
 include/linux/fs.h        |  17 +-----
 3 files changed, 110 insertions(+), 16 deletions(-)
 create mode 100644 include/linux/file_type.h

diff --git a/MAINTAINERS b/MAINTAINERS
index b2f710eee67a..8e5b029886e6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5689,6 +5689,7 @@ L:	linux-fsdevel@vger.kernel.org
 S:	Maintained
 F:	fs/*
 F:	include/linux/fs.h
+F:	include/linux/file_type.h
 F:	include/uapi/linux/fs.h
 
 FINTEK F75375S HARDWARE MONITOR AND FAN CONTROLLER DRIVER
diff --git a/include/linux/file_type.h b/include/linux/file_type.h
new file mode 100644
index 000000000000..f015c41ca90c
--- /dev/null
+++ b/include/linux/file_type.h
@@ -0,0 +1,108 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_FILE_TYPE_H
+#define _LINUX_FILE_TYPE_H
+
+/*
+ * This is a common implementation of dirent to fs on-disk
+ * file type conversion.  Although the fs on-disk bits are
+ * specific to every file system, in practice, many file systems
+ * use the exact same on-disk format to describe the lower 3
+ * file type bits that represent the 7 POSIX file types.
+ * All those file systems can use this generic code for the
+ * conversions:
+ *  i_mode -> fs on-disk file type (ftype)
+ *  fs on-disk file type (ftype) -> dirent file type (dtype)
+ *  i_mode -> dirent file type (dtype)
+ */
+
+/*
+ * struct dirent file types
+ * exposed to user via getdents(2), readdir(3)
+ *
+ * These match bits 12..15 of stat.st_mode
+ * (ie "(i_mode >> 12) & 15").
+ */
+#define S_DT_SHIFT	12
+#define S_DT(mode)	(((mode) & S_IFMT) >> S_DT_SHIFT)
+#define S_DT_MASK	(S_IFMT >> S_DT_SHIFT)
+
+#define DT_UNKNOWN	0
+#define DT_FIFO		S_DT(S_IFIFO) /* 1 */
+#define DT_CHR		S_DT(S_IFCHR) /* 2 */
+#define DT_DIR		S_DT(S_IFDIR) /* 4 */
+#define DT_BLK		S_DT(S_IFBLK) /* 6 */
+#define DT_REG		S_DT(S_IFREG) /* 8 */
+#define DT_LNK		S_DT(S_IFLNK) /* 10 */
+#define DT_SOCK		S_DT(S_IFSOCK) /* 12 */
+#define DT_WHT		14
+
+#define DT_MAX		(S_DT_MASK + 1) /* 16 */
+
+/*
+ * fs on-disk file types.
+ * Only the low 3 bits are used for the POSIX file types.
+ * Other bits are reserved for fs private use.
+ *
+ * Note that no fs currently stores the whiteout type on-disk,
+ * so whiteout dirents are exposed to user as DT_CHR.
+ */
+#define FT_UNKNOWN	0
+#define FT_REG_FILE	1
+#define FT_DIR		2
+#define FT_CHRDEV	3
+#define FT_BLKDEV	4
+#define FT_FIFO		5
+#define FT_SOCK		6
+#define FT_SYMLINK	7
+
+#define FT_MAX		8
+
+/*
+ * fs on-disk file type to dirent file type conversion
+ */
+static unsigned char fs_dtype_by_ftype[FT_MAX] = {
+	[FT_UNKNOWN]	= DT_UNKNOWN,
+	[FT_REG_FILE]	= DT_REG,
+	[FT_DIR]	= DT_DIR,
+	[FT_CHRDEV]	= DT_CHR,
+	[FT_BLKDEV]	= DT_BLK,
+	[FT_FIFO]	= DT_FIFO,
+	[FT_SOCK]	= DT_SOCK,
+	[FT_SYMLINK]	= DT_LNK
+};
+
+static inline unsigned char fs_dtype(int filetype)
+{
+	if (filetype >= FT_MAX)
+		return DT_UNKNOWN;
+
+	return fs_dtype_by_ftype[filetype];
+}
+
+/*
+ * dirent file type to fs on-disk file type conversion
+ * Values not initialized explicitly are FT_UNKNOWN (0).
+ */
+static unsigned char fs_ftype_by_dtype[DT_MAX] = {
+	[DT_REG]	= FT_REG_FILE,
+	[DT_DIR]	= FT_DIR,
+	[DT_LNK]	= FT_SYMLINK,
+	[DT_CHR]	= FT_CHRDEV,
+	[DT_BLK]	= FT_BLKDEV,
+	[DT_FIFO]	= FT_FIFO,
+	[DT_SOCK]	= FT_SOCK,
+};
+
+/* st_mode to fs on-disk file type conversion */
+static inline unsigned char fs_umode_to_ftype(umode_t mode)
+{
+	return fs_ftype_by_dtype[S_DT(mode)];
+}
+
+/* st_mode to dirent file type conversion */
+static inline unsigned char fs_umode_to_dtype(umode_t mode)
+{
+	return fs_dtype(fs_umode_to_ftype(mode));
+}
+
+#endif
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 897eae8faee1..b42f04acf06e 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -37,6 +37,7 @@
 #include <linux/uuid.h>
 #include <linux/errseq.h>
 #include <linux/ioprio.h>
+#include <linux/file_type.h>
 
 #include <asm/byteorder.h>
 #include <uapi/linux/fs.h>
@@ -1663,22 +1664,6 @@ int fiemap_fill_next_extent(struct fiemap_extent_info *info, u64 logical,
 			    u64 phys, u64 len, u32 flags);
 int fiemap_check_flags(struct fiemap_extent_info *fieinfo, u32 fs_flags);
 
-/*
- * File types
- *
- * NOTE! These match bits 12..15 of stat.st_mode
- * (ie "(i_mode >> 12) & 15").
- */
-#define DT_UNKNOWN	0
-#define DT_FIFO		1
-#define DT_CHR		2
-#define DT_DIR		4
-#define DT_BLK		6
-#define DT_REG		8
-#define DT_LNK		10
-#define DT_SOCK		12
-#define DT_WHT		14
-
 /*
  * This is the "filldir" function type, used by readdir() to let
  * the kernel specify what kind of dirent layout it wants to have.
-- 
2.17.2


Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F8CC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 09:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61416218D9
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 09:15:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ecy3kGL7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728534AbfAYJPG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 04:15:06 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43851 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728306AbfAYJPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 04:15:04 -0500
Received: by mail-pl1-f196.google.com with SMTP id gn14so4279650plb.10;
        Fri, 25 Jan 2019 01:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=pODceGxaaflkk+zKrn4TnmA3hfVdAwW+juGJT6xenms=;
        b=Ecy3kGL73fQpiO/Kdn7bSUAu9bK4puagVSFk1LaQGheHzgT9Ep8iGohN4hQUNB9KWr
         xugM+0FrQ/qZwW6ItV2qiYt8aHIo7KGaVUJeL3HODu10vYsLqchqi7/3pupGD2styVxi
         c2Z4HDjb0Msj730gjYN2jotAiUO+n0ZosSHvEiAq+lW2hB9ZBAwgk4IUEsQBr1gOcrK2
         j7V4/bDoAt5baE1HN046NxI3fDK1ildqDbOuhEytnNkzGevgFCO1mNMQvbC01x/f3/b4
         P4QCA4byxegAPqw5LKsv+RsV92jDQ/YbFQioue7ZJgFUWDa3rKV1fqjdqemKP6AVHSD3
         SfiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=pODceGxaaflkk+zKrn4TnmA3hfVdAwW+juGJT6xenms=;
        b=H5wCal+IWREDsmkn0xnYWm4+LiLiT1mNp7wRCU8AGK0uyxLMCBaBCLdmbXtJoSXMcA
         iYNG8KVoqxZrvpEoU+zpDv8a81pU/zXWEpyj7Jj/B2CgrtTYmg5+KYvvq7tQXrSzvCRQ
         W4h3VYMW2QmZIIyTfWpH6LVses4L0UXqdfOn8Q4InvJWOdMTzXJMFuH74wmZ18OhSpTT
         sDM+uUHC+nnGWjOtZkFu9lTUL/wcKB1rpSWGaxkvPGXxOStIAMZegULl7iGuzVuHT04w
         19qzCm9o7qlYHH4nfq3eeRWCbhfty2xlSRg/5OkYdvrTDXPfkL0GwEHORXWKFoCKGz2Y
         4jmQ==
X-Gm-Message-State: AJcUukez1gwhI3oD/v3doLNFY0g8Yr8fK/vT4sr5v3HXmdP239Zibp/G
        rbXhABo9vWbNMVbi2w1Fqeg=
X-Google-Smtp-Source: ALg8bN48fqBW6RiuNkDVhyYtV/W3LAgsYYRthJgEKRcShQPyHapfhK3UQY+21mXyHqvxUFvgpGQYfg==
X-Received: by 2002:a17:902:2c03:: with SMTP id m3mr10530924plb.125.1548407703816;
        Fri, 25 Jan 2019 01:15:03 -0800 (PST)
Received: from localhost ([43.224.245.181])
        by smtp.gmail.com with ESMTPSA id u29sm62851316pgn.23.2019.01.25.01.15.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 Jan 2019 01:15:03 -0800 (PST)
From:   Geliang Tang <geliangtang@gmail.com>
To:     Phillip Lougher <phillip@squashfs.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Coly Li <colyli@suse.de>
Cc:     Geliang Tang <geliangtang@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/2] squashfs: Add posix acl support
Date:   Fri, 25 Jan 2019 17:14:49 +0800
Message-Id: <d6cbe74944ad1a6be21cc74b99b30d18cba140c5.1548406694.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1548406694.git.geliangtang@gmail.com>
References: <cover.1548406694.git.geliangtang@gmail.com>
In-Reply-To: <cover.1548406694.git.geliangtang@gmail.com>
References: <cover.1548406694.git.geliangtang@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add posix acl (Access Control Lists) support for squashfs, which is
marked as a todo item in squashfs documentation.  This patch implements
a squashfs_get_acl function to read the file's acl information from its
xattr lists.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
Changes in v5:
  - add SPDX lines.
---
 Documentation/filesystems/squashfs.txt |  2 -
 fs/squashfs/Kconfig                    | 11 +++++
 fs/squashfs/Makefile                   |  1 +
 fs/squashfs/acl.c                      | 56 ++++++++++++++++++++++++++
 fs/squashfs/acl.h                      | 18 +++++++++
 fs/squashfs/inode.c                    |  4 +-
 fs/squashfs/namei.c                    |  6 ++-
 fs/squashfs/squashfs_fs.h              | 12 +++---
 fs/squashfs/super.c                    |  3 ++
 fs/squashfs/symlink.c                  |  6 ++-
 fs/squashfs/xattr.c                    | 31 +++++++++++++-
 fs/squashfs/xattr.h                    |  8 ++++
 12 files changed, 145 insertions(+), 13 deletions(-)
 create mode 100644 fs/squashfs/acl.c
 create mode 100644 fs/squashfs/acl.h

diff --git a/Documentation/filesystems/squashfs.txt b/Documentation/filesystems/squashfs.txt
index e5274f84dc56..539fad6b4db0 100644
--- a/Documentation/filesystems/squashfs.txt
+++ b/Documentation/filesystems/squashfs.txt
@@ -235,8 +235,6 @@ list using a second xattr id lookup table.
 4.1 Todo list
 -------------
 
-Implement ACL support.
-
 4.2 Squashfs internal cache
 ---------------------------
 
diff --git a/fs/squashfs/Kconfig b/fs/squashfs/Kconfig
index 1adb3346b9d6..f9587bcf9dd9 100644
--- a/fs/squashfs/Kconfig
+++ b/fs/squashfs/Kconfig
@@ -107,6 +107,17 @@ config SQUASHFS_XATTR
 
 	  If unsure, say N.
 
+config SQUASHFS_POSIX_ACL
+	bool "Squashfs POSIX ACL support"
+	depends on SQUASHFS_XATTR
+	select FS_POSIX_ACL
+	help
+	  Saying Y here includes support for Access Control Lists (acls).
+	  Acls are used to define more fine-grained discretionary access
+	  rights for files and directories (see the acl(5) manual page).
+
+	  If unsure, say N.
+
 config SQUASHFS_ZLIB
 	bool "Include support for ZLIB compressed file systems"
 	depends on SQUASHFS
diff --git a/fs/squashfs/Makefile b/fs/squashfs/Makefile
index 7bd9b8b856d0..73bc1c8a8df6 100644
--- a/fs/squashfs/Makefile
+++ b/fs/squashfs/Makefile
@@ -12,6 +12,7 @@ squashfs-$(CONFIG_SQUASHFS_DECOMP_SINGLE) += decompressor_single.o
 squashfs-$(CONFIG_SQUASHFS_DECOMP_MULTI) += decompressor_multi.o
 squashfs-$(CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU) += decompressor_multi_percpu.o
 squashfs-$(CONFIG_SQUASHFS_XATTR) += xattr.o xattr_id.o
+squashfs-$(CONFIG_SQUASHFS_POSIX_ACL) += acl.o
 squashfs-$(CONFIG_SQUASHFS_LZ4) += lz4_wrapper.o
 squashfs-$(CONFIG_SQUASHFS_LZO) += lzo_wrapper.o
 squashfs-$(CONFIG_SQUASHFS_XZ) += xz_wrapper.o
diff --git a/fs/squashfs/acl.c b/fs/squashfs/acl.c
new file mode 100644
index 000000000000..f9719ed30dad
--- /dev/null
+++ b/fs/squashfs/acl.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Squashfs - a compressed read only filesystem for Linux
+ *
+ * Copyright (c) 2019
+ * Geliang Tang <geliangtang@gmail.com>
+ *
+ * acl.c
+ */
+
+#include <linux/init.h>
+#include <linux/fs.h>
+#include <linux/slab.h>
+#include "squashfs_fs.h"
+#include "xattr.h"
+#include "acl.h"
+
+struct posix_acl *squashfs_get_acl(struct inode *inode, int type)
+{
+	int name_index;
+	char *name;
+	struct posix_acl *acl = NULL;
+	char *value = NULL;
+	int ret;
+
+	switch (type) {
+	case ACL_TYPE_ACCESS:
+		name_index = SQUASHFS_XATTR_POSIX_ACL_ACCESS;
+		name = XATTR_POSIX_ACL_ACCESS;
+		break;
+	case ACL_TYPE_DEFAULT:
+		name_index = SQUASHFS_XATTR_POSIX_ACL_DEFAULT;
+		name = XATTR_POSIX_ACL_DEFAULT;
+		break;
+	default:
+		BUG();
+	}
+
+	ret = squashfs_xattr_get(inode, name_index, name, NULL, 0);
+	if (ret > 0) {
+		value = kmalloc(ret, GFP_KERNEL);
+		if (!value)
+			return ERR_PTR(-ENOMEM);
+		ret = squashfs_xattr_get(inode, name_index, name, value, ret);
+	}
+	if (ret > 0)
+		acl = posix_acl_from_xattr(&init_user_ns, value, ret);
+	else if (ret == -ENODATA || ret == -ENOSYS)
+		acl = NULL;
+	else
+		acl = ERR_PTR(ret);
+
+	kfree(value);
+
+	return acl;
+}
diff --git a/fs/squashfs/acl.h b/fs/squashfs/acl.h
new file mode 100644
index 000000000000..e7806c5fbc44
--- /dev/null
+++ b/fs/squashfs/acl.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Squashfs - a compressed read only filesystem for Linux
+ *
+ * Copyright (c) 2019
+ * Geliang Tang <geliangtang@gmail.com>
+ *
+ * acl.h
+ */
+
+#include <linux/fs.h>
+#include <linux/posix_acl_xattr.h>
+
+#ifdef CONFIG_SQUASHFS_POSIX_ACL
+extern struct posix_acl *squashfs_get_acl(struct inode *inode, int type);
+#else
+#define squashfs_get_acl	NULL
+#endif
diff --git a/fs/squashfs/inode.c b/fs/squashfs/inode.c
index e9793b1e49a5..2035a1acffd7 100644
--- a/fs/squashfs/inode.c
+++ b/fs/squashfs/inode.c
@@ -48,6 +48,7 @@
 #include "squashfs_fs_i.h"
 #include "squashfs.h"
 #include "xattr.h"
+#include "acl.h"
 
 /*
  * Initialise VFS inode with the base inode information common to all
@@ -425,6 +426,7 @@ int squashfs_read_inode(struct inode *inode, long long ino)
 
 
 const struct inode_operations squashfs_inode_ops = {
-	.listxattr = squashfs_listxattr
+	.listxattr	= squashfs_listxattr,
+	.get_acl	= squashfs_get_acl
 };
 
diff --git a/fs/squashfs/namei.c b/fs/squashfs/namei.c
index 40c10d9974c9..33ad74780040 100644
--- a/fs/squashfs/namei.c
+++ b/fs/squashfs/namei.c
@@ -64,6 +64,7 @@
 #include "squashfs_fs_i.h"
 #include "squashfs.h"
 #include "xattr.h"
+#include "acl.h"
 
 /*
  * Lookup name in the directory index, returning the location of the metadata
@@ -246,6 +247,7 @@ static struct dentry *squashfs_lookup(struct inode *dir, struct dentry *dentry,
 
 
 const struct inode_operations squashfs_dir_inode_ops = {
-	.lookup = squashfs_lookup,
-	.listxattr = squashfs_listxattr
+	.lookup		= squashfs_lookup,
+	.listxattr	= squashfs_listxattr,
+	.get_acl	= squashfs_get_acl
 };
diff --git a/fs/squashfs/squashfs_fs.h b/fs/squashfs/squashfs_fs.h
index 4e6853f084d0..38972490bf5e 100644
--- a/fs/squashfs/squashfs_fs.h
+++ b/fs/squashfs/squashfs_fs.h
@@ -107,11 +107,13 @@
 #define SQUASHFS_MAX_DIR_TYPE		7
 
 /* Xattr types */
-#define SQUASHFS_XATTR_USER             0
-#define SQUASHFS_XATTR_TRUSTED          1
-#define SQUASHFS_XATTR_SECURITY         2
-#define SQUASHFS_XATTR_VALUE_OOL        256
-#define SQUASHFS_XATTR_PREFIX_MASK      0xff
+#define SQUASHFS_XATTR_USER			0
+#define SQUASHFS_XATTR_POSIX_ACL_ACCESS		1
+#define SQUASHFS_XATTR_POSIX_ACL_DEFAULT	2
+#define SQUASHFS_XATTR_TRUSTED			3
+#define SQUASHFS_XATTR_SECURITY			4
+#define SQUASHFS_XATTR_VALUE_OOL		256
+#define SQUASHFS_XATTR_PREFIX_MASK		0xff
 
 /* Flag whether block is compressed or uncompressed, bit is set if block is
  * uncompressed */
diff --git a/fs/squashfs/super.c b/fs/squashfs/super.c
index 40e657386fa5..71f7645a39a9 100644
--- a/fs/squashfs/super.c
+++ b/fs/squashfs/super.c
@@ -197,6 +197,9 @@ static int squashfs_fill_super(struct super_block *sb, void *data, int silent)
 
 	sb->s_maxbytes = MAX_LFS_FILESIZE;
 	sb->s_flags |= SB_RDONLY;
+#ifdef CONFIG_SQUASHFS_POSIX_ACL
+	sb->s_flags |= SB_POSIXACL;
+#endif
 	sb->s_op = &squashfs_super_ops;
 
 	err = -ENOMEM;
diff --git a/fs/squashfs/symlink.c b/fs/squashfs/symlink.c
index befeba0fa70a..a7f30d890905 100644
--- a/fs/squashfs/symlink.c
+++ b/fs/squashfs/symlink.c
@@ -42,6 +42,7 @@
 #include "squashfs_fs_i.h"
 #include "squashfs.h"
 #include "xattr.h"
+#include "acl.h"
 
 static int squashfs_symlink_readpage(struct file *file, struct page *page)
 {
@@ -118,7 +119,8 @@ const struct address_space_operations squashfs_symlink_aops = {
 };
 
 const struct inode_operations squashfs_symlink_inode_ops = {
-	.get_link = page_get_link,
-	.listxattr = squashfs_listxattr
+	.get_link	= page_get_link,
+	.listxattr	= squashfs_listxattr,
+	.get_acl	= squashfs_get_acl
 };
 
diff --git a/fs/squashfs/xattr.c b/fs/squashfs/xattr.c
index 1548b3784548..e65440cf1acf 100644
--- a/fs/squashfs/xattr.c
+++ b/fs/squashfs/xattr.c
@@ -33,6 +33,7 @@
 #include "squashfs_fs_sb.h"
 #include "squashfs_fs_i.h"
 #include "squashfs.h"
+#include "acl.h"
 
 static const struct xattr_handler *squashfs_xattr_handler(int);
 
@@ -115,7 +116,7 @@ ssize_t squashfs_listxattr(struct dentry *d, char *buffer,
 }
 
 
-static int squashfs_xattr_get(struct inode *inode, int name_index,
+int squashfs_xattr_get(struct inode *inode, int name_index,
 	const char *name, void *buffer, size_t buffer_size)
 {
 	struct super_block *sb = inode->i_sb;
@@ -232,6 +233,24 @@ static const struct xattr_handler squashfs_xattr_user_handler = {
 	.get	= squashfs_xattr_handler_get
 };
 
+/*
+ * ACL access namespace support
+ */
+static const struct xattr_handler squashfs_xattr_acl_access_handler = {
+	.prefix	= XATTR_SYSTEM_PREFIX,
+	.flags	= SQUASHFS_XATTR_POSIX_ACL_ACCESS,
+	.get	= squashfs_xattr_handler_get
+};
+
+/*
+ * ACL default namespace support
+ */
+static const struct xattr_handler squashfs_xattr_acl_default_handler = {
+	.prefix	= XATTR_SYSTEM_PREFIX,
+	.flags	= SQUASHFS_XATTR_POSIX_ACL_DEFAULT,
+	.get	= squashfs_xattr_handler_get
+};
+
 /*
  * Trusted namespace support
  */
@@ -265,6 +284,12 @@ static const struct xattr_handler *squashfs_xattr_handler(int type)
 	switch (type & SQUASHFS_XATTR_PREFIX_MASK) {
 	case SQUASHFS_XATTR_USER:
 		return &squashfs_xattr_user_handler;
+#ifdef CONFIG_SQUASHFS_POSIX_ACL
+	case SQUASHFS_XATTR_POSIX_ACL_ACCESS:
+		return &squashfs_xattr_acl_access_handler;
+	case SQUASHFS_XATTR_POSIX_ACL_DEFAULT:
+		return &squashfs_xattr_acl_default_handler;
+#endif
 	case SQUASHFS_XATTR_TRUSTED:
 		return &squashfs_xattr_trusted_handler;
 	case SQUASHFS_XATTR_SECURITY:
@@ -277,6 +302,10 @@ static const struct xattr_handler *squashfs_xattr_handler(int type)
 
 const struct xattr_handler *squashfs_xattr_handlers[] = {
 	&squashfs_xattr_user_handler,
+#ifdef CONFIG_SQUASHFS_POSIX_ACL
+	&squashfs_xattr_acl_access_handler,
+	&squashfs_xattr_acl_default_handler,
+#endif
 	&squashfs_xattr_trusted_handler,
 	&squashfs_xattr_security_handler,
 	NULL
diff --git a/fs/squashfs/xattr.h b/fs/squashfs/xattr.h
index afe70f815e3d..ac08650c08cc 100644
--- a/fs/squashfs/xattr.h
+++ b/fs/squashfs/xattr.h
@@ -26,6 +26,8 @@ extern __le64 *squashfs_read_xattr_id_table(struct super_block *, u64,
 		u64 *, int *);
 extern int squashfs_xattr_lookup(struct super_block *, unsigned int, int *,
 		unsigned int *, unsigned long long *);
+extern int squashfs_xattr_get(struct inode *inode, int name_index,
+	const char *name, void *buffer, size_t buffer_size);
 #else
 static inline __le64 *squashfs_read_xattr_id_table(struct super_block *sb,
 		u64 start, u64 *xattr_table_start, int *xattr_ids)
@@ -41,6 +43,12 @@ static inline int squashfs_xattr_lookup(struct super_block *sb,
 {
 	return 0;
 }
+
+static int squashfs_xattr_get(struct inode *inode, int name_index,
+	const char *name, void *buffer, size_t buffer_size)
+{
+	return 0;
+}
 #define squashfs_listxattr NULL
 #define squashfs_xattr_handlers NULL
 #endif
-- 
2.17.1


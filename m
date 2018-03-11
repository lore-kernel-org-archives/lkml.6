Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932388AbeCKK6D (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 06:58:03 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:54518 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932261AbeCKK4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 06:56:54 -0400
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: linux-kernel@vger.kernel.org, luto@kernel.org,
        torvalds@linux-foundation.org, mingo@kernel.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org
Cc: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        user-mode-linux-devel@lists.sourceforge.net
Subject: [RFC PATCH 25/35] hostfs: rename do_rmdir() to hostfs_do_rmdir()
Date: Sun, 11 Mar 2018 11:55:47 +0100
Message-Id: <20180311105557.20807-26-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180311105557.20807-1-linux@dominikbrodowski.net>
References: <20180311105557.20807-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

do_rmdir() is used in the VFS layer at fs/namei.c, so use a different
name in hostfs.

CC: Jeff Dike <jdike@addtoit.com>
CC: Richard Weinberger <richard@nod.at>
CC: user-mode-linux-devel@lists.sourceforge.net
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 fs/hostfs/hostfs.h      | 2 +-
 fs/hostfs/hostfs_kern.c | 2 +-
 fs/hostfs/hostfs_user.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/hostfs/hostfs.h b/fs/hostfs/hostfs.h
index ffaec2e7526c..cb8374af08a6 100644
--- a/fs/hostfs/hostfs.h
+++ b/fs/hostfs/hostfs.h
@@ -84,7 +84,7 @@ extern int set_attr(const char *file, struct hostfs_iattr *attrs, int fd);
 extern int make_symlink(const char *from, const char *to);
 extern int unlink_file(const char *file);
 extern int do_mkdir(const char *file, int mode);
-extern int do_rmdir(const char *file);
+extern int hostfs_do_rmdir(const char *file);
 extern int do_mknod(const char *file, int mode, unsigned int major,
 		    unsigned int minor);
 extern int link_file(const char *from, const char *to);
diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index c148e7f4f451..3cd85eb5bbb1 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -706,7 +706,7 @@ static int hostfs_rmdir(struct inode *ino, struct dentry *dentry)
 
 	if ((file = dentry_name(dentry)) == NULL)
 		return -ENOMEM;
-	err = do_rmdir(file);
+	err = hostfs_do_rmdir(file);
 	__putname(file);
 	return err;
 }
diff --git a/fs/hostfs/hostfs_user.c b/fs/hostfs/hostfs_user.c
index 9c1e0f019880..5ecc4706172b 100644
--- a/fs/hostfs/hostfs_user.c
+++ b/fs/hostfs/hostfs_user.c
@@ -304,7 +304,7 @@ int do_mkdir(const char *file, int mode)
 	return 0;
 }
 
-int do_rmdir(const char *file)
+int hostfs_do_rmdir(const char *file)
 {
 	int err;
 
-- 
2.16.2

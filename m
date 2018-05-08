Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932916AbeEHSGW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 14:06:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:54267 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932841AbeEHSGT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 14:06:19 -0400
From: Mark Fasheh <mfasheh@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Mark Fasheh <mfasheh@suse.de>
Subject: [PATCH 63/76] fs/ramfs: Use inode_sb() helper instead of inode->i_sb
Date: Tue,  8 May 2018 11:04:23 -0700
Message-Id: <20180508180436.716-64-mfasheh@suse.de>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180508180436.716-1-mfasheh@suse.de>
References: <20180508180436.716-1-mfasheh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mark Fasheh <mfasheh@suse.de>
---
 fs/ramfs/inode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ramfs/inode.c b/fs/ramfs/inode.c
index 11201b2d06b9..57b78ae51ed1 100644
--- a/fs/ramfs/inode.c
+++ b/fs/ramfs/inode.c
@@ -101,7 +101,7 @@ struct inode *ramfs_get_inode(struct super_block *sb,
 static int
 ramfs_mknod(struct inode *dir, struct dentry *dentry, umode_t mode, dev_t dev)
 {
-	struct inode * inode = ramfs_get_inode(dir->i_sb, dir, mode, dev);
+	struct inode * inode = ramfs_get_inode(inode_sb(dir), dir, mode, dev);
 	int error = -ENOSPC;
 
 	if (inode) {
@@ -131,7 +131,7 @@ static int ramfs_symlink(struct inode * dir, struct dentry *dentry, const char *
 	struct inode *inode;
 	int error = -ENOSPC;
 
-	inode = ramfs_get_inode(dir->i_sb, dir, S_IFLNK|S_IRWXUGO, 0);
+	inode = ramfs_get_inode(inode_sb(dir), dir, S_IFLNK|S_IRWXUGO, 0);
 	if (inode) {
 		int l = strlen(symname)+1;
 		error = page_symlink(inode, symname, l);
-- 
2.15.1

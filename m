Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755669AbeEHSFs (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 14:05:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:54053 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755223AbeEHSFp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 14:05:45 -0400
From: Mark Fasheh <mfasheh@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Mark Fasheh <mfasheh@suse.de>
Subject: [PATCH 39/76] fs/hostfs: Use inode_sb() helper instead of inode->i_sb
Date: Tue,  8 May 2018 11:03:59 -0700
Message-Id: <20180508180436.716-40-mfasheh@suse.de>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180508180436.716-1-mfasheh@suse.de>
References: <20180508180436.716-1-mfasheh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mark Fasheh <mfasheh@suse.de>
---
 fs/hostfs/hostfs_kern.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index c148e7f4f451..b99d08b7ef34 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -570,7 +570,7 @@ static int hostfs_create(struct inode *dir, struct dentry *dentry, umode_t mode,
 	char *name;
 	int error, fd;
 
-	inode = hostfs_iget(dir->i_sb);
+	inode = hostfs_iget(inode_sb(dir));
 	if (IS_ERR(inode)) {
 		error = PTR_ERR(inode);
 		goto out;
@@ -609,7 +609,7 @@ static struct dentry *hostfs_lookup(struct inode *ino, struct dentry *dentry,
 	char *name;
 	int err;
 
-	inode = hostfs_iget(ino->i_sb);
+	inode = hostfs_iget(inode_sb(ino));
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
 		goto out;
@@ -717,7 +717,7 @@ static int hostfs_mknod(struct inode *dir, struct dentry *dentry, umode_t mode,
 	char *name;
 	int err;
 
-	inode = hostfs_iget(dir->i_sb);
+	inode = hostfs_iget(inode_sb(dir));
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
 		goto out;
-- 
2.15.1

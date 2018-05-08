Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755834AbeEHSGO (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 14:06:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:54164 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755805AbeEHSGJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 14:06:09 -0400
From: Mark Fasheh <mfasheh@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Mark Fasheh <mfasheh@suse.de>
Subject: [PATCH 56/76] fs/openpromfs: Use inode_sb() helper instead of inode->i_sb
Date: Tue,  8 May 2018 11:04:16 -0700
Message-Id: <20180508180436.716-57-mfasheh@suse.de>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180508180436.716-1-mfasheh@suse.de>
References: <20180508180436.716-1-mfasheh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mark Fasheh <mfasheh@suse.de>
---
 fs/openpromfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/openpromfs/inode.c b/fs/openpromfs/inode.c
index 2200662a9bf1..d1c59e6252c5 100644
--- a/fs/openpromfs/inode.c
+++ b/fs/openpromfs/inode.c
@@ -229,7 +229,7 @@ static struct dentry *openpromfs_lookup(struct inode *dir, struct dentry *dentry
 	return ERR_PTR(-ENOENT);
 
 found:
-	inode = openprom_iget(dir->i_sb, ino);
+	inode = openprom_iget(inode_sb(dir), ino);
 	mutex_unlock(&op_mutex);
 	if (IS_ERR(inode))
 		return ERR_CAST(inode);
-- 
2.15.1

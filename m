Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756428AbeEHSkR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 14:40:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:53840 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755186AbeEHSE6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 14:04:58 -0400
From: Mark Fasheh <mfasheh@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Mark Fasheh <mfasheh@suse.de>
Subject: [PATCH 06/76] ipc: Use inode_sb() helper instead of inode->i_sb
Date: Tue,  8 May 2018 11:03:26 -0700
Message-Id: <20180508180436.716-7-mfasheh@suse.de>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180508180436.716-1-mfasheh@suse.de>
References: <20180508180436.716-1-mfasheh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mark Fasheh <mfasheh@suse.de>
---
 ipc/mqueue.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index a808f29d4c5a..ac65b309c393 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -106,7 +106,7 @@ static inline struct mqueue_inode_info *MQUEUE_I(struct inode *inode)
  */
 static inline struct ipc_namespace *__get_ns_from_inode(struct inode *inode)
 {
-	return get_ipc_ns(inode->i_sb->s_fs_info);
+	return get_ipc_ns(inode_sb(inode)->s_fs_info);
 }
 
 static struct ipc_namespace *get_ns_from_inode(struct inode *inode)
@@ -456,7 +456,7 @@ static int mqueue_create_attr(struct dentry *dentry, umode_t mode, void *arg)
 	ipc_ns->mq_queues_count++;
 	spin_unlock(&mq_lock);
 
-	inode = mqueue_get_inode(dir->i_sb, ipc_ns, mode, attr);
+	inode = mqueue_get_inode(inode_sb(dir), ipc_ns, mode, attr);
 	if (IS_ERR(inode)) {
 		error = PTR_ERR(inode);
 		spin_lock(&mq_lock);
-- 
2.15.1

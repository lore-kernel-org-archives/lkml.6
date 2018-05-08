Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756124AbeEHSdh (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 14:33:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:53874 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932367AbeEHSFZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 14:05:25 -0400
From: Mark Fasheh <mfasheh@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Mark Fasheh <mfasheh@suse.de>
Subject: [PATCH 26/76] fs/efivarfs: Use inode_sb() helper instead of inode->i_sb
Date: Tue,  8 May 2018 11:03:46 -0700
Message-Id: <20180508180436.716-27-mfasheh@suse.de>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180508180436.716-1-mfasheh@suse.de>
References: <20180508180436.716-1-mfasheh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mark Fasheh <mfasheh@suse.de>
---
 fs/efivarfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/efivarfs/inode.c b/fs/efivarfs/inode.c
index 71fccccf317e..5e0de72476bf 100644
--- a/fs/efivarfs/inode.c
+++ b/fs/efivarfs/inode.c
@@ -92,7 +92,7 @@ static int efivarfs_create(struct inode *dir, struct dentry *dentry,
 					 dentry->d_name.name, namelen))
 		is_removable = true;
 
-	inode = efivarfs_get_inode(dir->i_sb, dir, mode, 0, is_removable);
+	inode = efivarfs_get_inode(inode_sb(dir), dir, mode, 0, is_removable);
 	if (!inode) {
 		err = -ENOMEM;
 		goto out;
-- 
2.15.1

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932656AbeEHSFh (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 14:05:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:53949 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932463AbeEHSFa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 14:05:30 -0400
From: Mark Fasheh <mfasheh@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Mark Fasheh <mfasheh@suse.de>
Subject: [PATCH 29/76] fs/exportfs: Use inode_sb() helper instead of inode->i_sb
Date: Tue,  8 May 2018 11:03:49 -0700
Message-Id: <20180508180436.716-30-mfasheh@suse.de>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180508180436.716-1-mfasheh@suse.de>
References: <20180508180436.716-1-mfasheh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mark Fasheh <mfasheh@suse.de>
---
 fs/exportfs/expfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/exportfs/expfs.c b/fs/exportfs/expfs.c
index 329a5d103846..d0ce48374bda 100644
--- a/fs/exportfs/expfs.c
+++ b/fs/exportfs/expfs.c
@@ -383,7 +383,7 @@ static int export_encode_fh(struct inode *inode, struct fid *fid,
 int exportfs_encode_inode_fh(struct inode *inode, struct fid *fid,
 			     int *max_len, struct inode *parent)
 {
-	const struct export_operations *nop = inode->i_sb->s_export_op;
+	const struct export_operations *nop = inode_sb(inode)->s_export_op;
 
 	if (nop && nop->encode_fh)
 		return nop->encode_fh(inode, fid->raw, max_len, parent);
-- 
2.15.1

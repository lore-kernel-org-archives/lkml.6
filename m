Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932360AbeEHSFY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 14:05:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:53941 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755617AbeEHSFU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 14:05:20 -0400
From: Mark Fasheh <mfasheh@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Mark Fasheh <mfasheh@suse.de>
Subject: [PATCH 22/76] fs/configfs: Use inode_sb() helper instead of inode->i_sb
Date: Tue,  8 May 2018 11:03:42 -0700
Message-Id: <20180508180436.716-23-mfasheh@suse.de>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180508180436.716-1-mfasheh@suse.de>
References: <20180508180436.716-1-mfasheh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mark Fasheh <mfasheh@suse.de>
---
 fs/configfs/inode.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/configfs/inode.c b/fs/configfs/inode.c
index ad718e5e37bb..4f28a7445336 100644
--- a/fs/configfs/inode.c
+++ b/fs/configfs/inode.c
@@ -91,13 +91,13 @@ int configfs_setattr(struct dentry * dentry, struct iattr * iattr)
 		sd_iattr->ia_gid = iattr->ia_gid;
 	if (ia_valid & ATTR_ATIME)
 		sd_iattr->ia_atime = timespec_trunc(iattr->ia_atime,
-						inode->i_sb->s_time_gran);
+						inode_sb(inode)->s_time_gran);
 	if (ia_valid & ATTR_MTIME)
 		sd_iattr->ia_mtime = timespec_trunc(iattr->ia_mtime,
-						inode->i_sb->s_time_gran);
+						inode_sb(inode)->s_time_gran);
 	if (ia_valid & ATTR_CTIME)
 		sd_iattr->ia_ctime = timespec_trunc(iattr->ia_ctime,
-						inode->i_sb->s_time_gran);
+						inode_sb(inode)->s_time_gran);
 	if (ia_valid & ATTR_MODE) {
 		umode_t mode = iattr->ia_mode;
 
-- 
2.15.1

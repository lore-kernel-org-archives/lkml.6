Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751772AbeDEKvZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 06:51:25 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:45767 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751097AbeDEKvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 06:51:22 -0400
X-Google-Smtp-Source: AIpwx4/HbpK/ytXcCJbBzorpTnENtTagXMVhzdMHqdKgarzHGQXZi1O5pBVLRe2t1o+otmTBid8J7A==
From: Christian Brauner <christian.brauner@ubuntu.com>
To: torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        ebiederm@xmission.com, linux-kernel@vger.kernel.org
Cc: Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 2/3 RESEND] devpts: use follow_up_bind() helper
Date: Thu,  5 Apr 2018 12:51:02 +0200
Message-Id: <20180405105103.21572-3-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180405105103.21572-1-christian.brauner@ubuntu.com>
References: <20180405105103.21572-1-christian.brauner@ubuntu.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 fs/devpts/inode.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/devpts/inode.c b/fs/devpts/inode.c
index e072e955ce33..5e516846074e 100644
--- a/fs/devpts/inode.c
+++ b/fs/devpts/inode.c
@@ -181,9 +181,7 @@ struct vfsmount *devpts_mntget(struct file *filp, struct pts_fs_info *fsi)
 	/* Walk upward while the start point is a bind mount of
 	 * a single file.
 	 */
-	while (path.mnt->mnt_root == path.dentry)
-		if (follow_up(&path) == 0)
-			break;
+	follow_up_bind(&path);
 
 	/* devpts_ptmx_path() finds a devpts fs or returns an error. */
 	if ((path.mnt->mnt_sb->s_magic != DEVPTS_SUPER_MAGIC) ||
-- 
2.15.1

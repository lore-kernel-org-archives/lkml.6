Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932990AbeCMMSN (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 08:18:13 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:39023 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932904AbeCMMSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 08:18:09 -0400
X-Google-Smtp-Source: AG47ELv/NesV5APlA4SZvi/0X4osd8vUPFbemJe/Bc5ZIpCvyLYdaRk4DO3dy3MuCoEPOCiqRBPtBQ==
From: Christian Brauner <christian.brauner@ubuntu.com>
To: viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        ebiederm@xmission.com, torvalds@linux-foundation.org
Cc: containers@lists.linux-foundation.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 3/4 v5] devpts: comment devpts_mntget()
Date: Tue, 13 Mar 2018 13:17:12 +0100
Message-Id: <20180313121713.32551-4-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180313121713.32551-1-christian.brauner@ubuntu.com>
References: <20180313121713.32551-1-christian.brauner@ubuntu.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
ChangeLog v4->v5:
* patch added
ChangeLog v3->v4:
* patch not present
ChangeLog v2->v3:
* patch not present
ChangeLog v1->v2:
* patch not present
ChangeLog v0->v1:
* patch not present
---
 fs/devpts/inode.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/fs/devpts/inode.c b/fs/devpts/inode.c
index 542364bf923e..e072e955ce33 100644
--- a/fs/devpts/inode.c
+++ b/fs/devpts/inode.c
@@ -152,6 +152,24 @@ static int devpts_ptmx_path(struct path *path)
 	return 0;
 }
 
+/*
+ * Try to find a suitable devpts filesystem. We support the following
+ * scenarios:
+ * - The ptmx device node is located in the same directory as the devpts
+ *   mount where the pts device nodes are located.
+ *   This is e.g. the case when calling open on the /dev/pts/ptmx device
+ *   node when the devpts filesystem is mounted at /dev/pts.
+ * - The ptmx device node is located outside the devpts filesystem mount
+ *   where the pts device nodes are located. For example, the ptmx device
+ *   is a symlink, separate device node, or bind-mount.
+ *   A supported scenario is bind-mounting /dev/pts/ptmx to /dev/ptmx and
+ *   then calling open on /dev/ptmx. In this case a suitable pts
+ *   subdirectory can be found in the common parent directory /dev of the
+ *   devpts mount and the ptmx bind-mount, after resolving the /dev/ptmx
+ *   bind-mount.
+ *   If no suitable pts subdirectory can be found this function will fail.
+ *   This is e.g. the case when bind-mounting /dev/pts/ptmx to /ptmx.
+ */
 struct vfsmount *devpts_mntget(struct file *filp, struct pts_fs_info *fsi)
 {
 	struct path path;
-- 
2.15.1

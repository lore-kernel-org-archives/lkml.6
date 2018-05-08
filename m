Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755802AbeEHSGI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 14:06:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:54151 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755762AbeEHSGE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 14:06:04 -0400
From: Mark Fasheh <mfasheh@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Mark Fasheh <mfasheh@suse.de>
Subject: [PATCH 52/76] fs/notify: Use inode_sb() helper instead of inode->i_sb
Date: Tue,  8 May 2018 11:04:12 -0700
Message-Id: <20180508180436.716-53-mfasheh@suse.de>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180508180436.716-1-mfasheh@suse.de>
References: <20180508180436.716-1-mfasheh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mark Fasheh <mfasheh@suse.de>
---
 fs/notify/fdinfo.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/notify/fdinfo.c b/fs/notify/fdinfo.c
index d478629c728b..857df5ce27ac 100644
--- a/fs/notify/fdinfo.c
+++ b/fs/notify/fdinfo.c
@@ -91,7 +91,8 @@ static void inotify_fdinfo(struct seq_file *m, struct fsnotify_mark *mark)
 		 */
 		u32 mask = mark->mask & IN_ALL_EVENTS;
 		seq_printf(m, "inotify wd:%x ino:%lx sdev:%x mask:%x ignored_mask:%x ",
-			   inode_mark->wd, inode->i_ino, inode->i_sb->s_dev,
+			   inode_mark->wd, inode->i_ino,
+			   inode_sb(inode)->s_dev,
 			   mask, mark->ignored_mask);
 		show_mark_fhandle(m, inode);
 		seq_putc(m, '\n');
@@ -121,7 +122,7 @@ static void fanotify_fdinfo(struct seq_file *m, struct fsnotify_mark *mark)
 		if (!inode)
 			return;
 		seq_printf(m, "fanotify ino:%lx sdev:%x mflags:%x mask:%x ignored_mask:%x ",
-			   inode->i_ino, inode->i_sb->s_dev,
+			   inode->i_ino, inode_sb(inode)->s_dev,
 			   mflags, mark->mask, mark->ignored_mask);
 		show_mark_fhandle(m, inode);
 		seq_putc(m, '\n');
-- 
2.15.1

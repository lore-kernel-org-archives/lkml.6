Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752722AbeB1OBa (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 09:01:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:39354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752679AbeB1OB2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 09:01:28 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5194921771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=chao@kernel.org
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: fix to restore whint_mode in ->remount_fs
Date: Wed, 28 Feb 2018 22:01:20 +0800
Message-Id: <20180228140120.8758-1-chao@kernel.org>
X-Mailer: git-send-email 2.14.1.145.gb3622a4ee
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

If we fail in ->remount_fs, it needs to restore old whint_mode as other
mount options.

Fixes: e25afe01822f ("f2fs: support passing down write hints given by users to block layer")
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 89abe4087e66..8a93f78efca2 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1512,6 +1512,7 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 		sbi->s_qf_names[i] = s_qf_names[i];
 	}
 #endif
+	sbi->whint_mode = old_whint_mode;
 	sbi->mount_opt = org_mount_opt;
 	sbi->active_logs = active_logs;
 	sb->s_flags = old_sb_flags;
-- 
2.14.1.145.gb3622a4ee

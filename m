Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752021AbeDBMWg (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 08:22:36 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:56519 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751239AbeDBMWf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 08:22:35 -0400
From: Yunlong Song <yunlong.song@huawei.com>
To: <jaegeuk@kernel.org>, <chao@kernel.org>, <yuchao0@huawei.com>,
        <yunlong.song@icloud.com>, <yunlong.song@huawei.com>
CC: <miaoxie@huawei.com>, <bintian.wang@huawei.com>,
        <shengyong1@huawei.com>, <heyunlei@huawei.com>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] f2fs: make assignment of t->dentry_bitmap more readable
Date: Mon, 2 Apr 2018 20:22:20 +0800
Message-ID: <1522671740-92824-1-git-send-email-yunlong.song@huawei.com>
X-Mailer: git-send-email 1.8.5.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.113.189.234]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In make_dentry_ptr_block, it is confused with "&" for t->dentry_bitmap
but without "&" for t->dentry, so delete "&" to make code more readable.

Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
---
 fs/f2fs/f2fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 191ee57..474b9e9 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -471,7 +471,7 @@ static inline void make_dentry_ptr_block(struct inode *inode,
 	d->inode = inode;
 	d->max = NR_DENTRY_IN_BLOCK;
 	d->nr_bitmap = SIZE_OF_DENTRY_BITMAP;
-	d->bitmap = &t->dentry_bitmap;
+	d->bitmap = t->dentry_bitmap;
 	d->dentry = t->dentry;
 	d->filename = t->filename;
 }
-- 
1.8.5.2

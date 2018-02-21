Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755124AbeBUSNr (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 13:13:47 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:60684 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752268AbeBUSNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 13:13:46 -0500
From: Colin King <colin.king@canonical.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] f2fs: remove redundant initialization of pointer 'p'
Date: Wed, 21 Feb 2018 18:13:40 +0000
Message-Id: <20180221181340.7596-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Pointer p is initialized with a value that is never read and is later
re-assigned a new value, hence the initialization is redundant and can
be removed.

Cleans up clang warning:
fs/f2fs/extent_cache.c:463:19: warning: Value stored to 'p' during
its initialization is never read

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/f2fs/extent_cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index ff2352a0ed15..956b2744386b 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -460,7 +460,7 @@ static struct extent_node *__insert_extent_tree(struct inode *inode,
 				struct rb_node *insert_parent)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-	struct rb_node **p = &et->root.rb_node;
+	struct rb_node **p;
 	struct rb_node *parent = NULL;
 	struct extent_node *en = NULL;
 
-- 
2.15.1

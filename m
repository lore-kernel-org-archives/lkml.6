Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751419AbeDWGCI (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 02:02:08 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:45878 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750852AbeDWGCG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 02:02:06 -0400
From: Chao Yu <yuchao0@huawei.com>
To: <jaegeuk@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] fsck.f2fs: fix to avoid accessing invalid memory address
Date: Mon, 23 Apr 2018 14:01:45 +0800
Message-ID: <20180423060145.50324-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.15.0.55.gc2ece9dc4de6
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds to check return value of calloc in write_superblock().

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fsck/mount.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fsck/mount.c b/fsck/mount.c
index 7e936dc056e5..badbe639742e 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -2155,6 +2155,7 @@ void write_superblock(struct f2fs_super_block *new_sb)
 	u_int8_t *buf;
 
 	buf = calloc(BLOCK_SZ, 1);
+	ASSERT(buf);
 
 	memcpy(buf + F2FS_SUPER_OFFSET, new_sb, sizeof(*new_sb));
 	for (index = 0; index < 2; index++) {
-- 
2.15.0.55.gc2ece9dc4de6

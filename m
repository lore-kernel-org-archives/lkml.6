Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752688AbeEOLAl (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 07:00:41 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7668 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752305AbeEOLAk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 07:00:40 -0400
From: Chao Yu <yuchao0@huawei.com>
To: <jaegeuk@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: fix to initialize min_mtime with ULLONG_MAX
Date: Tue, 15 May 2018 18:59:55 +0800
Message-ID: <20180515105955.66699-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.17.0.391.g1f1cddd558b5
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since sit_i.min_mtime's type is unsigned long long, so we should
initialize it with max value of the type ULLONG_MAX instead of
LLONG_MAX.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/segment.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 100fb6454527..bc93c9efbbd2 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3828,7 +3828,7 @@ static void init_min_max_mtime(struct f2fs_sb_info *sbi)
 
 	down_write(&sit_i->sentry_lock);
 
-	sit_i->min_mtime = LLONG_MAX;
+	sit_i->min_mtime = ULLONG_MAX;
 
 	for (segno = 0; segno < MAIN_SEGS(sbi); segno += sbi->segs_per_sec) {
 		unsigned int i;
-- 
2.17.0.391.g1f1cddd558b5

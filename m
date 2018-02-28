Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752162AbeB1JEP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 04:04:15 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:5681 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751675AbeB1JEN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 04:04:13 -0500
From: Chao Yu <yuchao0@huawei.com>
To: <jaegeuk@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/2] mkfs.f2fs: treat db's data as hot one
Date: Wed, 28 Feb 2018 17:03:44 +0800
Message-ID: <20180228090344.33741-2-yuchao0@huawei.com>
X-Mailer: git-send-email 2.15.0.55.gc2ece9dc4de6
In-Reply-To: <20180228090344.33741-1-yuchao0@huawei.com>
References: <20180228090344.33741-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DB files like .db, .db-journal, .db-wal, .db-shm are very active, this
patch adds db file type to hot file extension list by default.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 mkfs/f2fs_format.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index 3fc2f05437dd..f4a1b08789c1 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -69,6 +69,7 @@ const char *media_ext_lists[] = {
 };
 
 const char *hot_ext_lists[] = {
+	"db",
 	NULL
 };
 
-- 
2.15.0.55.gc2ece9dc4de6

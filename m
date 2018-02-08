Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752249AbeBHMeI (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 07:34:08 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:4775 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752212AbeBHMeE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 07:34:04 -0500
From: Yunlong Song <yunlong.song@huawei.com>
To: <jaegeuk@kernel.org>, <chao@kernel.org>, <yuchao0@huawei.com>,
        <yunlong.song@icloud.com>, <yunlong.song@huawei.com>
CC: <miaoxie@huawei.com>, <bintian.wang@huawei.com>,
        <shengyong1@huawei.com>, <heyunlei@huawei.com>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] f2fs: set_code_data in move_data_block
Date: Thu, 8 Feb 2018 20:33:37 +0800
Message-ID: <1518093217-123705-1-git-send-email-yunlong.song@huawei.com>
X-Mailer: git-send-email 1.8.5.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.107.193.250]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
---
 fs/f2fs/gc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index b9d93fd..2095630 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -692,6 +692,7 @@ static void move_data_block(struct inode *inode, block_t bidx,
 	fio.op = REQ_OP_WRITE;
 	fio.op_flags = REQ_SYNC;
 	fio.new_blkaddr = newaddr;
+	set_cold_data(fio.page);
 	err = f2fs_submit_page_write(&fio);
 	if (err) {
 		if (PageWriteback(fio.encrypted_page))
-- 
1.8.5.2

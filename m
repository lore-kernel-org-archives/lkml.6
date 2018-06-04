Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753641AbeFDPWo (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 11:22:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:50158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752772AbeFDPWn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 11:22:43 -0400
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/2] f2fs: don't change wbc->sync_mode
Date: Mon,  4 Jun 2018 23:20:35 +0800
Message-Id: <20180604152036.23764-1-chao@kernel.org>
X-Mailer: git-send-email 2.16.2.17.g38e79b1fd
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

We should never falsify wbc->sync_mode passed from mm, otherwise
mm can trigger writeback with wrong IO priority.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/node.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 513f03d823b6..64ad5466887f 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1741,7 +1741,6 @@ static int f2fs_write_node_pages(struct address_space *mapping,
 	trace_f2fs_writepages(mapping->host, wbc, NODE);
 
 	diff = nr_pages_to_write(sbi, NODE, wbc);
-	wbc->sync_mode = WB_SYNC_NONE;
 	blk_start_plug(&plug);
 	f2fs_sync_node_pages(sbi, wbc, true, FS_NODE_IO);
 	blk_finish_plug(&plug);
-- 
2.16.2.17.g38e79b1fd

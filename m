Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752326AbeDSEGP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 00:06:15 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:12064 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750953AbeDSEGN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 00:06:13 -0400
From: Jiang Biao <jiang.biao2@zte.com.cn>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        tj@kernel.org, jiang.biao2@zte.com.cn, zhong.weidong@zte.com.cn,
        wen.yang99@zte.com.cn
Subject: [PATCH 1/2] blkcg: small fix on comment in blkcg_init_queue
Date: Thu, 19 Apr 2018 12:04:26 +0800
Message-Id: <1524110666-106945-1-git-send-email-jiang.biao2@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-04-19 12:06:10,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-04-19 12:05:51,
        Serialize complete at 2018-04-19 12:05:51
X-MAIL: mse01.zte.com.cn w3J463Zk048390
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The comment before blkg_create() in blkcg_init_queue() was moved
from blkcg_activate_policy() by commit ec13b1d6f0a0457312e615, but
it does not suit for the new context.

Signed-off-by: Jiang Biao <jiang.biao2@zte.com.cn>
Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
CC: Tejun Heo <tj@kernel.org>
CC: Jens Axboe <axboe@kernel.dk>
---
 block/blk-cgroup.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 2b7f8d0..07e3359 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1134,11 +1134,7 @@ int blkcg_init_queue(struct request_queue *q)
 
 	preloaded = !radix_tree_preload(GFP_KERNEL);
 
-	/*
-	 * Make sure the root blkg exists and count the existing blkgs.  As
-	 * @q is bypassing at this point, blkg_lookup_create() can't be
-	 * used.  Open code insertion.
-	 */
+	/* Make sure the root blkg exists. */
 	rcu_read_lock();
 	spin_lock_irq(q->queue_lock);
 	blkg = blkg_create(&blkcg_root, q, new_blkg);
-- 
2.7.4

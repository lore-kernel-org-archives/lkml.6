Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58602C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 15:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 094CD2084A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 15:47:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PCkwRRAx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 094CD2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbeH1Tjx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 15:39:53 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43926 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726951AbeH1Tjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 15:39:53 -0400
Received: by mail-pg1-f193.google.com with SMTP id v66-v6so922652pgb.10;
        Tue, 28 Aug 2018 08:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=YY83VgXVwS1eRe2IpRz7Y7IcSfnxFgsVxg54JIrT804=;
        b=PCkwRRAxlmWiOAVGQBGqR1rMrD5j9ZqeTWMY1w56K4WMAVb41cCnh6kYaBZdDBczeB
         /bL2++sJ+V78/YGQYHwkgt7yPpE/eKTJzjgOzIFDlrrYmLKTlQg7YFLSCJ4tnuAqC/Jy
         8jKAWYc5blvXz043NueOZsz2Cjv4b2H1EGdUxao31hPE4vRmPwHYYIbI5+LqSc0FfA46
         Rk95EplaPTChArtuQPLOiHSEF72JzdDC8vLkb2TSNOeXRffeRauV/DIZ8VprVFiLlTIG
         ce0zYzfI5u3dlvJj7vdDEqPTSLKIXojErKQWUhJVbEEjKB4T3D2Bn4YP8T8jKyv04lTh
         99lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YY83VgXVwS1eRe2IpRz7Y7IcSfnxFgsVxg54JIrT804=;
        b=ONczyv7eD64Z/ZjF+kLtY8IiQljVYfaAnF9lfoKjEmi+7Xbz04CHemOTxX7/DNwrO7
         pwUgoTDhpTFtzFFzO591DXao1OsN9CvlgqAq6vuFsUFrBateXbyVgE03dC5LdYxnH8Gh
         WAYfn5F3pM37Y9Gp415tXJf3ci7MRjpYxcdsIjUxsA7UDyxzSipnesTlOjz1XyAjLWCg
         lKKRBQRCbLpBID7lSV4Erpefh9BFNHWJRhFKgB59arYYfHoYrz3CsQkJPAq7ASXXtH+5
         +G4jb/tVv1aJ5hldQX67OIuvupGvYLcdRGuhSG4gvhF3r5EzfQnHWfgV+ZECcDSgwTM0
         A7HA==
X-Gm-Message-State: APzg51DU1RFDp3ePPZ5jwvb0AsfeceA1KNWVwpBlf1gAM5ci315Qzzuq
        Q0ndfFfpAsipqJm7LSlyUx0=
X-Google-Smtp-Source: ANB0VdYSLKFKFaV1QxzHwDc4Dq8KurQg2n4A3/LEhwmUfZ09gHKSS+hHOwguiQ8ynfTTm5Ra5NcRDw==
X-Received: by 2002:a63:7a45:: with SMTP id j5-v6mr2006815pgn.363.1535471257209;
        Tue, 28 Aug 2018 08:47:37 -0700 (PDT)
Received: from localhost.localdomain ([58.173.153.121])
        by smtp.googlemail.com with ESMTPSA id h85-v6sm2676424pfk.71.2018.08.28.08.47.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 08:47:36 -0700 (PDT)
From:   Ian W MORRISON <ianwmorrison@gmail.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kashyap.desai@broadcom.com, loberman@redhat.com, osandov@fb.com,
        hch@lst.de, bart.vanassche@wdc.com, hare@suse.de,
        ming.lei@redhat.com, ianwmorrison@gmail.com
Subject: [PATCH] Revert "blk-mq: issue directly if hw queue isn't busy in case of 'none'"
Date:   Wed, 29 Aug 2018 01:47:27 +1000
Message-Id: <20180828154727.3589-1-ianwmorrison@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel oops when booting on Bay and Cherry Trail devices
such as Intel Compute Stick. Bisected as:

commit 6ce3dd6eec11 ("blk-mq: issue directly if hw queue isn't busy in case of 'none'")

This patch reverts the above commit.

Signed-off-by: Ian W MORRISON <ianwmorrison@gmail.com>
---
 block/blk-mq-sched.c | 13 +------------
 block/blk-mq.c       | 27 +--------------------------
 block/blk-mq.h       |  2 --
 3 files changed, 2 insertions(+), 40 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 29bfe8017a2d..3204c39cb39f 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -405,19 +405,8 @@ void blk_mq_sched_insert_requests(struct request_queue *q,
 
 	if (e && e->type->ops.mq.insert_requests)
 		e->type->ops.mq.insert_requests(hctx, list, false);
-	else {
-		/*
-		 * try to issue requests directly if the hw queue isn't
-		 * busy in case of 'none' scheduler, and this way may save
-		 * us one extra enqueue & dequeue to sw queue.
-		 */
-		if (!hctx->dispatch_busy && !e && !run_queue_async) {
-			blk_mq_try_issue_list_directly(hctx, list);
-			if (list_empty(list))
-				return;
-		}
+	else
 		blk_mq_insert_requests(hctx, ctx, list);
-	}
 
 	blk_mq_run_hw_queue(hctx, run_queue_async);
 }
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 85a1c1a59c72..09e4611d330d 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1693,16 +1693,13 @@ static blk_status_t __blk_mq_issue_directly(struct blk_mq_hw_ctx *hctx,
 	ret = q->mq_ops->queue_rq(hctx, &bd);
 	switch (ret) {
 	case BLK_STS_OK:
-		blk_mq_update_dispatch_busy(hctx, false);
 		*cookie = new_cookie;
 		break;
 	case BLK_STS_RESOURCE:
 	case BLK_STS_DEV_RESOURCE:
-		blk_mq_update_dispatch_busy(hctx, true);
 		__blk_mq_requeue_request(rq);
 		break;
 	default:
-		blk_mq_update_dispatch_busy(hctx, false);
 		*cookie = BLK_QC_T_NONE;
 		break;
 	}
@@ -1785,27 +1782,6 @@ blk_status_t blk_mq_request_issue_directly(struct request *rq)
 	return ret;
 }
 
-void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
-		struct list_head *list)
-{
-	while (!list_empty(list)) {
-		blk_status_t ret;
-		struct request *rq = list_first_entry(list, struct request,
-				queuelist);
-
-		list_del_init(&rq->queuelist);
-		ret = blk_mq_request_issue_directly(rq);
-		if (ret != BLK_STS_OK) {
-			if (ret == BLK_STS_RESOURCE ||
-					ret == BLK_STS_DEV_RESOURCE) {
-				list_add(&rq->queuelist, list);
-				break;
-			}
-			blk_mq_end_request(rq, ret);
-		}
-	}
-}
-
 static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 {
 	const int is_sync = op_is_sync(bio->bi_opf);
@@ -1906,8 +1882,7 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 			blk_mq_try_issue_directly(data.hctx, same_queue_rq,
 					&cookie);
 		}
-	} else if ((q->nr_hw_queues > 1 && is_sync) || (!q->elevator &&
-			!data.hctx->dispatch_busy)) {
+	} else if (q->nr_hw_queues > 1 && is_sync) {
 		blk_mq_put_ctx(data.ctx);
 		blk_mq_bio_to_request(rq, bio);
 		blk_mq_try_issue_directly(data.hctx, rq, &cookie);
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 9497b47e2526..bc2b24735ed4 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -64,8 +64,6 @@ void blk_mq_insert_requests(struct blk_mq_hw_ctx *hctx, struct blk_mq_ctx *ctx,
 
 /* Used by blk_insert_cloned_request() to issue request directly */
 blk_status_t blk_mq_request_issue_directly(struct request *rq);
-void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
-				    struct list_head *list);
 
 /*
  * CPU -> queue mappings
-- 
2.17.1


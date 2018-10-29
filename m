Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22CEBC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 16:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFE9F20657
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 16:39:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Dr/WvqsD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFE9F20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728136AbeJ3B1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 21:27:08 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:40458 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728012AbeJ3B1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 21:27:06 -0400
Received: by mail-it1-f193.google.com with SMTP id i191-v6so10174242iti.5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 09:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fb0X3O/E/9T8J1C6SoUrkl44F/lVWoM3/BiHGQqatJw=;
        b=Dr/WvqsDe4prXI3xbC+Nav/VrVMySw+xGxDEHttOprLECOE+mQ/z7G1iBAQttO0YIx
         2BYuEGGl5ONSQCjof3IueTI0cJUhUJUde/2ttFgXlEnuTEB0zRv/3wxSGayLRLx1MgMZ
         Oo1RM/cjoKB7I2trz27JGGvEblPoa6yIEWcXckIrYNQOECEMz9ObwWjJcppQdtbi4dSJ
         lZTa+km8Z8f10kEmH7Dizt2J/bSdKjeTQrQjbQA/QOxCsX6TQLM/ZanofrN07dfZUrha
         AVQ3acVQOnnK++h318jwVzEF6MBfjBWrDTkDt+ykjJl7TkDRg/9KVAi8Xv1z543N/t8J
         Bp0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fb0X3O/E/9T8J1C6SoUrkl44F/lVWoM3/BiHGQqatJw=;
        b=RkvumezEdJiX+e5ixSQmwEWRRnPAMIgFg54H2Uw/AMHIcNh+pYl84tVyfz74wcHUX+
         1m19r2jFLrVyYAr2yU5J352COu4VwKRt0K+zy+NjAmeLjWy6VX5sZn7HrsCaMPhIH+G5
         2rL3OiYEFGWYNhvsyOuP1W4pFbKY0OM3rBdr262K9Jne3NBA6/P+SD3UzDzQw9sWX3el
         dwKACsZIuXdi5PJ3yLn0lcOEWnqavGMYFLCTSNfV7PzVh/4x6S5PYyhBYRXBT/KmJHf9
         9Mp0ikrJ3UiVGcWMUF5HIjiivAiNFEhnFNutfpFsXRJbg4otHThJKoLVQigYrotRMMdk
         wIyQ==
X-Gm-Message-State: AGRZ1gKQ3lgZlKCyA0etj6aoN5xo6ZDisFfdpmDWtbT3ZddiyYwjrCvI
        Fwe5yD3C03hZDL/hrjSvaugWlw==
X-Google-Smtp-Source: AJdET5dol1JlA+W/SgeBOkRXCGtqnXIcJID0gqbW+4yNWwVSdYPlsRPE4zQRTRE1VrxPSlfkgWb9cQ==
X-Received: by 2002:a24:21d5:: with SMTP id e204-v6mr10430754ita.127.1540831064266;
        Mon, 29 Oct 2018 09:37:44 -0700 (PDT)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id q15-v6sm3367019itc.38.2018.10.29.09.37.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 09:37:43 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 01/14] blk-mq: kill q->mq_map
Date:   Mon, 29 Oct 2018 10:37:25 -0600
Message-Id: <20181029163738.10172-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181029163738.10172-1-axboe@kernel.dk>
References: <20181029163738.10172-1-axboe@kernel.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's just a pointer to set->mq_map, use that instead.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq.c         | 13 ++++---------
 block/blk-mq.h         |  4 +++-
 include/linux/blkdev.h |  2 --
 3 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 21e4147c4810..22d5beaab5a0 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2321,7 +2321,7 @@ static void blk_mq_map_swqueue(struct request_queue *q)
 	 * If the cpu isn't present, the cpu is mapped to first hctx.
 	 */
 	for_each_possible_cpu(i) {
-		hctx_idx = q->mq_map[i];
+		hctx_idx = set->mq_map[i];
 		/* unmapped hw queue can be remapped after CPU topo changed */
 		if (!set->tags[hctx_idx] &&
 		    !__blk_mq_alloc_rq_map(set, hctx_idx)) {
@@ -2331,7 +2331,7 @@ static void blk_mq_map_swqueue(struct request_queue *q)
 			 * case, remap the current ctx to hctx[0] which
 			 * is guaranteed to always have tags allocated
 			 */
-			q->mq_map[i] = 0;
+			set->mq_map[i] = 0;
 		}
 
 		ctx = per_cpu_ptr(q->queue_ctx, i);
@@ -2429,8 +2429,6 @@ static void blk_mq_del_queue_tag_set(struct request_queue *q)
 static void blk_mq_add_queue_tag_set(struct blk_mq_tag_set *set,
 				     struct request_queue *q)
 {
-	q->tag_set = set;
-
 	mutex_lock(&set->tag_list_lock);
 
 	/*
@@ -2467,8 +2465,6 @@ void blk_mq_release(struct request_queue *q)
 		kobject_put(&hctx->kobj);
 	}
 
-	q->mq_map = NULL;
-
 	kfree(q->queue_hw_ctx);
 
 	/*
@@ -2588,7 +2584,7 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
 		int node;
 		struct blk_mq_hw_ctx *hctx;
 
-		node = blk_mq_hw_queue_to_node(q->mq_map, i);
+		node = blk_mq_hw_queue_to_node(set->mq_map, i);
 		/*
 		 * If the hw queue has been mapped to another numa node,
 		 * we need to realloc the hctx. If allocation fails, fallback
@@ -2665,8 +2661,6 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	if (!q->queue_hw_ctx)
 		goto err_percpu;
 
-	q->mq_map = set->mq_map;
-
 	blk_mq_realloc_hw_ctxs(set, q);
 	if (!q->nr_hw_queues)
 		goto err_hctxs;
@@ -2675,6 +2669,7 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	blk_queue_rq_timeout(q, set->timeout ? set->timeout : 30 * HZ);
 
 	q->nr_queues = nr_cpu_ids;
+	q->tag_set = set;
 
 	q->queue_flags |= QUEUE_FLAG_MQ_DEFAULT;
 
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 9497b47e2526..9536be06d022 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -75,7 +75,9 @@ extern int blk_mq_hw_queue_to_node(unsigned int *map, unsigned int);
 static inline struct blk_mq_hw_ctx *blk_mq_map_queue(struct request_queue *q,
 		int cpu)
 {
-	return q->queue_hw_ctx[q->mq_map[cpu]];
+	struct blk_mq_tag_set *set = q->tag_set;
+
+	return q->queue_hw_ctx[set->mq_map[cpu]];
 }
 
 /*
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index c675e2b5af62..4223ae2d2198 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -412,8 +412,6 @@ struct request_queue {
 
 	const struct blk_mq_ops	*mq_ops;
 
-	unsigned int		*mq_map;
-
 	/* sw queues */
 	struct blk_mq_ctx __percpu	*queue_ctx;
 	unsigned int		nr_queues;
-- 
2.17.1


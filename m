Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0988EECDE44
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 18:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD81C2081B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 18:33:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="wAOiowO/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD81C2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728278AbeJaD1w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 23:27:52 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:50850 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728244AbeJaD1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 23:27:52 -0400
Received: by mail-it1-f195.google.com with SMTP id k206-v6so14965346ite.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 11:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0pIeDFtEGtTWIpejvN1KlR+jipBFPqHKlbzzMp8RAQY=;
        b=wAOiowO/mVCgKdHWTOtZUTsYPXWoATSFFw+/LNkkogVvlewLcGOEWq0shwvXMoMTpE
         ckQy0rbhdUohZl8Tk8iD4HoukVnA7HIngPW+Sy2102zYCXNHiOqx1L13R1QMxSvq+Adh
         OVz+69aOLw4qH/Qh4D2bE9HBUaayZxfRIRzEk/YetvgT+FDFiujCCh9HDDKq2pDMTUvj
         hH6KACH6I83vsM5tO8tmzXCqF0ksepVae/MdeIm2kjrRr6lNsaHKPZn4spw6rLgH2iH0
         j2aVNv4L5RCPDwQd8smE3xE2nh++zOjfJ7pMvG+Qpy7TuJz/5NmNxJ6xmsQKIvlG++db
         sNig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0pIeDFtEGtTWIpejvN1KlR+jipBFPqHKlbzzMp8RAQY=;
        b=YJbtIkYiWGlAfRTAdFZM0l7js8yeRDJg0zKs6uc+wSbEYTNcMSjvZMyA6K0Ok8MweA
         BLAJ5BaVjvAoXYRA58grLBsAgcZQyJQ0TEAs2aqbDdZt7BWyR8eGFGPDdcdzty6Jgyr0
         BPhWiOumyLrvvO02zvwLJ2sOIYIA4qIXuonf/c2LeQtB2QVyyi4/J3VyVeGcypWxrNI8
         ilkRcpDsRj0N1F0QQvBnk4H2LKDM1aWqmlw+NgYLwoeI8tl8wbKWtZPxtY7nZULKQRet
         GU6KVrpc/rsbZfcKe7LkyObisl8j6fP/urnn++nVV9DKiFnsWL0YJV62PpfchpOJC1Hg
         WyKA==
X-Gm-Message-State: AGRZ1gKdbx2fWYufQTR0K66OcjNYBO3uDhW0HRWFEl661jxBNsg4KwP/
        rf6RhahNbZTPnOXCwY0fnjQ1Cw==
X-Google-Smtp-Source: AJdET5db2SrmMseFyQke7yKO2N3elXXI+IwJbhgyXv8e2+Il9RgMUvA2+kJwkUhi5rrRQ0/v/rz4rg==
X-Received: by 2002:a02:a914:: with SMTP id n20-v6mr12774jam.90.1540924396163;
        Tue, 30 Oct 2018 11:33:16 -0700 (PDT)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id o20-v6sm4895739itc.34.2018.10.30.11.33.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 11:33:14 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 10/16] blk-mq: cleanup and improve list insertion
Date:   Tue, 30 Oct 2018 12:32:46 -0600
Message-Id: <20181030183252.17857-11-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181030183252.17857-1-axboe@kernel.dk>
References: <20181030183252.17857-1-axboe@kernel.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's somewhat strange to have a list insertion function that
relies on the fact that the caller has mapped things correctly.
Pass in the hardware queue directly for insertion, which makes
for a much cleaner interface and implementation.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq-sched.c |  8 +-------
 block/blk-mq-sched.h |  2 +-
 block/blk-mq.c       | 25 ++++++++++++++-----------
 3 files changed, 16 insertions(+), 19 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 8bc1f37acca2..6e7375246e2f 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -396,17 +396,11 @@ void blk_mq_sched_insert_request(struct request *rq, bool at_head,
 		blk_mq_run_hw_queue(hctx, async);
 }
 
-void blk_mq_sched_insert_requests(struct request_queue *q,
+void blk_mq_sched_insert_requests(struct blk_mq_hw_ctx *hctx,
 				  struct blk_mq_ctx *ctx,
 				  struct list_head *list, bool run_queue_async)
 {
-	struct blk_mq_hw_ctx *hctx;
 	struct elevator_queue *e;
-	struct request *rq;
-
-	/* For list inserts, requests better be on the same hw queue */
-	rq = list_first_entry(list, struct request, queuelist);
-	hctx = rq->mq_hctx;
 
 	e = hctx->queue->elevator;
 	if (e && e->type->ops.mq.insert_requests)
diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
index 8a9544203173..ffd7b5989d63 100644
--- a/block/blk-mq-sched.h
+++ b/block/blk-mq-sched.h
@@ -19,7 +19,7 @@ void blk_mq_sched_restart(struct blk_mq_hw_ctx *hctx);
 
 void blk_mq_sched_insert_request(struct request *rq, bool at_head,
 				 bool run_queue, bool async);
-void blk_mq_sched_insert_requests(struct request_queue *q,
+void blk_mq_sched_insert_requests(struct blk_mq_hw_ctx *hctx,
 				  struct blk_mq_ctx *ctx,
 				  struct list_head *list, bool run_queue_async);
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index b86d725958d3..51b8166959b9 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1623,11 +1623,12 @@ static int plug_ctx_cmp(void *priv, struct list_head *a, struct list_head *b)
 
 void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
 {
+	struct blk_mq_hw_ctx *this_hctx;
 	struct blk_mq_ctx *this_ctx;
 	struct request_queue *this_q;
 	struct request *rq;
 	LIST_HEAD(list);
-	LIST_HEAD(ctx_list);
+	LIST_HEAD(rq_list);
 	unsigned int depth;
 
 	list_splice_init(&plug->mq_list, &list);
@@ -1635,6 +1636,7 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
 	list_sort(NULL, &list, plug_ctx_cmp);
 
 	this_q = NULL;
+	this_hctx = NULL;
 	this_ctx = NULL;
 	depth = 0;
 
@@ -1642,30 +1644,31 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
 		rq = list_entry_rq(list.next);
 		list_del_init(&rq->queuelist);
 		BUG_ON(!rq->q);
-		if (rq->mq_ctx != this_ctx) {
-			if (this_ctx) {
+		if (rq->mq_hctx != this_hctx || rq->mq_ctx != this_ctx) {
+			if (this_hctx) {
 				trace_block_unplug(this_q, depth, !from_schedule);
-				blk_mq_sched_insert_requests(this_q, this_ctx,
-								&ctx_list,
+				blk_mq_sched_insert_requests(this_hctx, this_ctx,
+								&rq_list,
 								from_schedule);
 			}
 
-			this_ctx = rq->mq_ctx;
 			this_q = rq->q;
+			this_ctx = rq->mq_ctx;
+			this_hctx = rq->mq_hctx;
 			depth = 0;
 		}
 
 		depth++;
-		list_add_tail(&rq->queuelist, &ctx_list);
+		list_add_tail(&rq->queuelist, &rq_list);
 	}
 
 	/*
-	 * If 'this_ctx' is set, we know we have entries to complete
-	 * on 'ctx_list'. Do those.
+	 * If 'this_hctx' is set, we know we have entries to complete
+	 * on 'rq_list'. Do those.
 	 */
-	if (this_ctx) {
+	if (this_hctx) {
 		trace_block_unplug(this_q, depth, !from_schedule);
-		blk_mq_sched_insert_requests(this_q, this_ctx, &ctx_list,
+		blk_mq_sched_insert_requests(this_hctx, this_ctx, &rq_list,
 						from_schedule);
 	}
 }
-- 
2.17.1


Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC39FC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 16:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A468E20870
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 16:38:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Yd47KbAp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A468E20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728312AbeJ3B1Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 21:27:24 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:34141 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728292AbeJ3B1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 21:27:23 -0400
Received: by mail-it1-f196.google.com with SMTP id e81-v6so10684037itc.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 09:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+Ubma7dzFX73Hbh4PnPWob3RQ4KFeUeAMfxQdKC8go8=;
        b=Yd47KbApQEd/1cn4fhtp/9aMGY4JyemCI0tK+Q3VU6uBVkHWnexp8wnOthKXO+1d1j
         9pMn/MKd2iXdtc8P4Vw6EWw+pO1ml0OCkCkNGhCYZCldTvBu+6Sy16wC6SvFIjD2Kso9
         VKnBp1DJyZXRbgOiqfxitizZnxYZWZPMfNkb6eTRg0KT+FcIABMzMyt3FjRCOuLEXT/p
         fXzRL/Wu3kLTZLY/7Is9jLBlMWbhNCb/DgcqLstVvPOZkVwlTGB4ZTj45WRUBd88/4y1
         1VxqnBj49AAzg7DO0BZfYlFfC0YtmUyApqDGNOllLHUbjQm0gwGXVNJ9SKYM3DCbD3Vd
         fjNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+Ubma7dzFX73Hbh4PnPWob3RQ4KFeUeAMfxQdKC8go8=;
        b=N6G3m7GnW9fjNA5f12xLbyPFT390e21pNM79PLANrDvmsbdgwbnjtinlSvcZ91nAo7
         spXRXtliESYn7IL6ygh40JnE3ktHLWns7B2vmcMrIFMdt0z48kWocXV8nelEB0+Yb8Uc
         UOSqe94BbIvItfQhPot17Q50ccSja12T46P3lcx0cuXciIeHCzuzU3oMbgMBpeb8vzeX
         5TYrgk36vLuGz4Bt0EvMyaHGdwS6PTI8i6zhT13S8wGUYL3aS74bPKv2ewE5auSMqmA4
         KMHrj0/dn5VYQd60RayneS1QAEDLee7H/srGBERPMmx4oIbPSy9rMqpDaQDtsj62uL39
         iULg==
X-Gm-Message-State: AGRZ1gJ/vlBlXHdG/dD6qNrOn49G9O16j7c6uyJTmnoR/sa3X2fvdENG
        F1UwAvI6Xk5bLjgmEt/CHboSwQ==
X-Google-Smtp-Source: AJdET5dAOXg1i6IzXCnAtCwU9nkIkH03E0vPTE6obve10Xk/y4S1tX8YKXzwn1TwKyIhxmv8FvMk7A==
X-Received: by 2002:a02:9f85:: with SMTP id a5-v6mr3533728jam.2.1540831081595;
        Mon, 29 Oct 2018 09:38:01 -0700 (PDT)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id q15-v6sm3367019itc.38.2018.10.29.09.37.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 09:38:00 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 09/14] blk-mq: ensure that plug lists don't straddle hardware queues
Date:   Mon, 29 Oct 2018 10:37:33 -0600
Message-Id: <20181029163738.10172-10-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181029163738.10172-1-axboe@kernel.dk>
References: <20181029163738.10172-1-axboe@kernel.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we insert per hardware queue, we have to ensure that every
request on the plug list being inserted belongs to the same
hardware queue.

Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 60a951c4934c..52b07188b39a 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1621,6 +1621,27 @@ static int plug_ctx_cmp(void *priv, struct list_head *a, struct list_head *b)
 		  blk_rq_pos(rqa) < blk_rq_pos(rqb)));
 }
 
+/*
+ * Need to ensure that the hardware queue matches, so we don't submit
+ * a list of requests that end up on different hardware queues.
+ */
+static bool ctx_match(struct request *req, struct blk_mq_ctx *ctx,
+		      unsigned int flags)
+{
+	if (req->mq_ctx != ctx)
+		return false;
+
+	/*
+	 * If we just have one map, then we know the hctx will match
+	 * if the ctx matches
+	 */
+	if (req->q->tag_set->nr_maps == 1)
+		return true;
+
+	return blk_mq_map_queue(req->q, req->cmd_flags, ctx->cpu) ==
+		blk_mq_map_queue(req->q, flags, ctx->cpu);
+}
+
 void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
 {
 	struct blk_mq_ctx *this_ctx;
@@ -1628,7 +1649,7 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
 	struct request *rq;
 	LIST_HEAD(list);
 	LIST_HEAD(ctx_list);
-	unsigned int depth;
+	unsigned int depth, this_flags;
 
 	list_splice_init(&plug->mq_list, &list);
 
@@ -1636,13 +1657,14 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
 
 	this_q = NULL;
 	this_ctx = NULL;
+	this_flags = 0;
 	depth = 0;
 
 	while (!list_empty(&list)) {
 		rq = list_entry_rq(list.next);
 		list_del_init(&rq->queuelist);
 		BUG_ON(!rq->q);
-		if (rq->mq_ctx != this_ctx) {
+		if (!ctx_match(rq, this_ctx, this_flags)) {
 			if (this_ctx) {
 				trace_block_unplug(this_q, depth, !from_schedule);
 				blk_mq_sched_insert_requests(this_q, this_ctx,
@@ -1650,6 +1672,7 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
 								from_schedule);
 			}
 
+			this_flags = rq->cmd_flags;
 			this_ctx = rq->mq_ctx;
 			this_q = rq->q;
 			depth = 0;
-- 
2.17.1


Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 274C5C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 18:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD77220823
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 18:33:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="L6UjNA4J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD77220823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbeJaD1z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 23:27:55 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:54069 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728244AbeJaD1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 23:27:54 -0400
Received: by mail-it1-f194.google.com with SMTP id f16-v6so7408561ita.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 11:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lH0eWuHHiCANq4BSpJWvv00qJJn3hhUC9L40R4M73kg=;
        b=L6UjNA4JF31+E+Ock5f0VSU5X3Dk0iICBqga3Tx3kV+eKs7FPIeIuGNFXw5aHPW9tC
         TVwvcWPavhVJ2QbIQ+h5OpAXYxad1lIJbebfSSkaXCV2yyHCZzReBM8nWjaiJzQcN/xl
         aqEbmoe/1XkpU2PKUl/6KmogXOQdlzebab6HO4MHtl3NbJpFBJexnJ4ZoXyG40z7Spd5
         2U2vluq64peFNvQocy7lBQS5LfYRfG2YkjAgg1ZL72D3avVYuMbCpND8myxsk5BVd+6k
         P/CDe734E92S1g7S1KJzdMEPkQhiVi4IzwalJwgw57If4l2SBGaX9ZK5jjZSJAR8kuEM
         NO2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lH0eWuHHiCANq4BSpJWvv00qJJn3hhUC9L40R4M73kg=;
        b=AwFEfw6zMNJL+fnofEbeyoW4qNgKQmeGq6gq0I5653gisIqpcpGfYWptLoTyS9vEg/
         3JCGu1DSS7HzKLY62lpjoWUHORK/PJ8Gfcpc6iPaB0Olp/V05HSqqtQw8DMvYGO0ZCHJ
         ThQRrT0der/D+BF0tzxVsUm25U5+N7u18h5OwW0IOBij9mMHvuWpdCbeGVtqIjXNWIj5
         OCZshjWYA1tQkbXxtyG3YVyjKI/0LMCCj7/VjLTiJLPUEf7D4iQ5desHNR8JRdNbzm03
         ZjedJn2T900ZvUsZIqgAjt4fU22GQOkpZmp0MrEjHASiLrEChSyEq7P6N0xxKTD432nZ
         HeFg==
X-Gm-Message-State: AGRZ1gKNktuJ7iLRFtRQJIcPCdbbmYTaB7MR6v3sNBso8oskPZwdvq5v
        /K7mfJIXic9otVmcUGItAaRBIfxspC8=
X-Google-Smtp-Source: AJdET5fJmAz/Erkrun47XTQOD03fsZT2RF6veLieGBkVH7Q2awM3QXsS60ET2WTEo3MiOaT1qQf9IQ==
X-Received: by 2002:a24:1706:: with SMTP id 6-v6mr30592ith.16.1540924397941;
        Tue, 30 Oct 2018 11:33:17 -0700 (PDT)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id o20-v6sm4895739itc.34.2018.10.30.11.33.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 11:33:16 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 11/16] blk-mq: improve plug list sorting
Date:   Tue, 30 Oct 2018 12:32:47 -0600
Message-Id: <20181030183252.17857-12-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181030183252.17857-1-axboe@kernel.dk>
References: <20181030183252.17857-1-axboe@kernel.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we only look at the software queue, but with support
for multiple maps, we should also look at the hardware queue.
This is important since we'll flush out the request list if
either the software queue or hardware queue don't match.

This sorts by software queue first, then hardware queue if
that differs. Finally we sort by request location like before.
This minimizes the flush points per plug list.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 51b8166959b9..5a34c9374dc7 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1611,14 +1611,21 @@ void blk_mq_insert_requests(struct blk_mq_hw_ctx *hctx, struct blk_mq_ctx *ctx,
 	spin_unlock(&ctx->lock);
 }
 
-static int plug_ctx_cmp(void *priv, struct list_head *a, struct list_head *b)
+static int plug_rq_cmp(void *priv, struct list_head *a, struct list_head *b)
 {
 	struct request *rqa = container_of(a, struct request, queuelist);
 	struct request *rqb = container_of(b, struct request, queuelist);
 
-	return !(rqa->mq_ctx < rqb->mq_ctx ||
-		 (rqa->mq_ctx == rqb->mq_ctx &&
-		  blk_rq_pos(rqa) < blk_rq_pos(rqb)));
+	if (rqa->mq_ctx < rqb->mq_ctx)
+		return -1;
+	else if (rqa->mq_ctx > rqb->mq_ctx)
+		return 1;
+	else if (rqa->mq_hctx < rqb->mq_hctx)
+		return -1;
+	else if (rqa->mq_hctx > rqb->mq_hctx)
+		return 1;
+
+	return blk_rq_pos(rqa) > blk_rq_pos(rqb);
 }
 
 void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
@@ -1633,7 +1640,7 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
 
 	list_splice_init(&plug->mq_list, &list);
 
-	list_sort(NULL, &list, plug_ctx_cmp);
+	list_sort(NULL, &list, plug_rq_cmp);
 
 	this_q = NULL;
 	this_hctx = NULL;
-- 
2.17.1


Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19172C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 19:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4EE725D63
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 19:11:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="ZXgcI8WX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4EE725D63
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966339AbeF0TLe (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 15:11:34 -0400
Received: from mail-qt0-f175.google.com ([209.85.216.175]:39685 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966222AbeF0TKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 15:10:00 -0400
Received: by mail-qt0-f175.google.com with SMTP id b20-v6so2006742qtp.6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 12:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4sjBaATrdVpUH2y/if0LRnwspa7VVD1JJv3hKyhv66U=;
        b=ZXgcI8WXqgvT4DifAydQZhVj9xoTQivBSf3eChTtBlkKc1y9q6AlaEQ1JGogZGMo33
         TfNzdx4hZt96vtZECY8XnCmYGw6gCMZrTo1lxHLb/eCsnp0oOHpv4WGpH0Hm1tTfWqIk
         Ngl7nEIqtB64MCT1mklvELvqiP3meSfuMzi2pSF4K8npfC3M3OwmT6pKkqwe7FgiPMeL
         /HsW6BE7pkIdPzUFc+cs1ytvX54o22Govl6XYCqZQ0WkXhUxiJn3RNacDnsIGoOPyjGs
         ftJUHitiQD836a0fVOL9AVLFcpWVqIjalErVrgdHrnsM8ViU7nvLB4y3BD5QjlYDl8aa
         /Fvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4sjBaATrdVpUH2y/if0LRnwspa7VVD1JJv3hKyhv66U=;
        b=cyVIBdv72ampzLAIdqeyFnAZRHwXuJCwmJ/kjlS2d1AoBrYjp+PEBIAMMb/1zpjq8B
         UFe0WoFxsJKYXg7Q0RH44LbDauFhDUHzOlOX141gGyGJl6G/mM/Z+HHZ+ICjzXlFPx87
         G6a8C+xQDW0DbbCS6/1TXWJS/dcv7YQlsh8qXm0UOHvGvKSieN54U4SYmG0QF/NyFatA
         VSdjqAcm0hYL/dCMR5tMvETQk+bgVrzKd1JYHRAIuvh5nBsywHA7TbtJ0PV6Hg3Q7u2B
         L6AEqWcGbQi0nEtfBQie16MFV82eAPQEK9zOrgj4MpNetdI2R3djFfMm/fIIU8IC9C0D
         R69Q==
X-Gm-Message-State: APt69E0dK1aJwJdcfUhAq2vNYEh90OpO5jdlgJqFjBuRSdZ/JfsHVFLX
        KHeSgJeyN19OM4kiAuXvIKr9+g==
X-Google-Smtp-Source: AAOMgpc8MC0jip9lW2se7bVgLJH9xNBt+8AWQpliEtdJJbHvMFkc6OowYB4uXfkQFw3x//3Tpa9f6w==
X-Received: by 2002:ac8:13cd:: with SMTP id i13-v6mr6621112qtj.374.1530126599750;
        Wed, 27 Jun 2018 12:09:59 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id a11-v6sm1184835qta.47.2018.06.27.12.09.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Jun 2018 12:09:59 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org, kernel-team@fb.com,
        akpm@linux-foundation.org, hannes@cmpxchg.org, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Josef Bacik <jbacik@fb.com>
Subject: [PATCH 11/14] rq-qos: introduce dio_bio callback
Date:   Wed, 27 Jun 2018 15:09:37 -0400
Message-Id: <20180627190940.4696-12-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180627190940.4696-1-josef@toxicpanda.com>
References: <20180627190940.4696-1-josef@toxicpanda.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josef Bacik <jbacik@fb.com>

wbt cares only about request completion time, but controllers may need
information that is on the bio itself, so add a done_bio callback for
rq-qos so things like blk-iolatency can use it to have the bio when it
completes.

Signed-off-by: Josef Bacik <jbacik@fb.com>
---
 block/bio.c        |  4 ++++
 block/blk-rq-qos.c | 10 ++++++++++
 block/blk-rq-qos.h |  2 ++
 3 files changed, 16 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index c77fe1b4caa8..99809b73a400 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -32,6 +32,7 @@
 
 #include <trace/events/block.h>
 #include "blk.h"
+#include "blk-rq-qos.h"
 
 /*
  * Test patch to inline a certain number of bi_io_vec's inside the bio
@@ -1781,6 +1782,9 @@ void bio_endio(struct bio *bio)
 	if (WARN_ONCE(bio->bi_next, "driver left bi_next not NULL"))
 		bio->bi_next = NULL;
 
+	if (bio->bi_disk)
+		rq_qos_done_bio(bio->bi_disk->queue, bio);
+
 	/*
 	 * Need to have a real endio function for chained bios, otherwise
 	 * various corner cases will break (like stacking block devices that
diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
index b7b02e04f64f..5134b24482f6 100644
--- a/block/blk-rq-qos.c
+++ b/block/blk-rq-qos.c
@@ -88,6 +88,16 @@ void rq_qos_track(struct request_queue *q, struct request *rq, struct bio *bio)
 	}
 }
 
+void rq_qos_done_bio(struct request_queue *q, struct bio *bio)
+{
+	struct rq_qos *rqos;
+
+	for(rqos = q->rq_qos; rqos; rqos = rqos->next) {
+		if (rqos->ops->done_bio)
+			rqos->ops->done_bio(rqos, bio);
+	}
+}
+
 /*
  * Return true, if we can't increase the depth further by scaling
  */
diff --git a/block/blk-rq-qos.h b/block/blk-rq-qos.h
index a6d13b8ce0dc..d5e2f68fe41e 100644
--- a/block/blk-rq-qos.h
+++ b/block/blk-rq-qos.h
@@ -30,6 +30,7 @@ struct rq_qos_ops {
 	void (*issue)(struct rq_qos *, struct request *);
 	void (*requeue)(struct rq_qos *, struct request *);
 	void (*done)(struct rq_qos *, struct request *);
+	void (*done_bio)(struct rq_qos *, struct bio *);
 	void (*cleanup)(struct rq_qos *, struct bio *);
 	void (*exit)(struct rq_qos *);
 };
@@ -101,6 +102,7 @@ void rq_qos_cleanup(struct request_queue *, struct bio *);
 void rq_qos_done(struct request_queue *, struct request *);
 void rq_qos_issue(struct request_queue *, struct request *);
 void rq_qos_requeue(struct request_queue *, struct request *);
+void rq_qos_done_bio(struct request_queue *q, struct bio *bio);
 void rq_qos_throttle(struct request_queue *, struct bio *, spinlock_t *);
 void rq_qos_track(struct request_queue *q, struct request *, struct bio *);
 void rq_qos_exit(struct request_queue *);
-- 
2.14.3


Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D8AC6778C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 19:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B3F227D58
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 19:28:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="J1N/1QNP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B3F227D58
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935905AbeF2T1U (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 15:27:20 -0400
Received: from mail-qt0-f175.google.com ([209.85.216.175]:46566 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935944AbeF2T0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 15:26:01 -0400
Received: by mail-qt0-f175.google.com with SMTP id h5-v6so8813366qtm.13
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 12:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4sjBaATrdVpUH2y/if0LRnwspa7VVD1JJv3hKyhv66U=;
        b=J1N/1QNPElwibaqQxiNkJo3a8MKMRelPbcfO3dFHoAy3Q8rcZz4FXRSgMk878+cHg2
         pVyeDedJemDSZsPNWczt9FE7uf3/Zl8Q9zPySXFc9cj80HxAzg5wLthNIs+DQGYdyVyN
         bqcxHwJBQyKRdC4uw/xOswyzhidN7RStQgQI1NARu0hAlSIca9QeECoc0879WIxUXXhJ
         iUbLyYi8JStsqCk3WYHIQG14ljkKaZeiOZRU6IsHdUe5ddyGmlE1n6jjHiEsSGoMm2R7
         w63CMhPOUkKsys2P2HQ6W45tHxHjV4vzs3jTaRQoCulbQRQtTuKJRPrTHZN0xyI5n3PF
         jZUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4sjBaATrdVpUH2y/if0LRnwspa7VVD1JJv3hKyhv66U=;
        b=LqpXMEPPK0i+8toPNHe2wtAHpMVp5+jYZDUGmdUR18LEDAA1hckEtfEH/XZGmtKCPV
         B5Ll72JesLWus+ITlsC2OT5+eV5ple186f5ej5H6Esna1S/V84YzgInGfyFMv2BGZ2DB
         MJRmDrgQkaUMnNRzw8UEDzGBqGZGmFhRS/toT7l5qWKBEzOBMI4XLEmLCuAKaIw99GhG
         TXfYUpxaMUM/gyNfAhQAp2RavlmH8bFowF7/4LRFzEu2sGsF+kTtdXtYiOM20j5RiJWk
         YhqMVePx1hFHCpowgKl+t70FujtRiZQcElcPIvEvBzuPzd5ZJS2utN1rC/XRLlL1ydoE
         nERQ==
X-Gm-Message-State: APt69E1fVTefMfOl7vd7F96R57yCshqhZgzzhHE3xIoaN0/5A4hxo1Ys
        2nN6QpIr6226bEdHwGVgGUTgag==
X-Google-Smtp-Source: AAOMgpeGCPdu8V6ntYjZxLTTl/iW8I22viDm8kO6UBueS33Bbkk4JBdJlKZQciNi9D88SoEGghvyuQ==
X-Received: by 2002:ac8:2888:: with SMTP id i8-v6mr15011668qti.275.1530300360496;
        Fri, 29 Jun 2018 12:26:00 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id w46-v6sm8178441qtw.55.2018.06.29.12.25.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Jun 2018 12:25:59 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     axboe@kernel.dk, kernel-team@fb.com, linux-block@vger.kernel.org,
        akpm@linux-foundation.org, hannes@cmpxchg.org, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Josef Bacik <jbacik@fb.com>
Subject: [PATCH 11/14] rq-qos: introduce dio_bio callback
Date:   Fri, 29 Jun 2018 15:25:39 -0400
Message-Id: <20180629192542.26649-12-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180629192542.26649-1-josef@toxicpanda.com>
References: <20180629192542.26649-1-josef@toxicpanda.com>
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


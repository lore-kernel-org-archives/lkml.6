Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3534CC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFDFC208E4
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:17:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="pq/OeWdh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFDFC208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933482AbeGCPRM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 11:17:12 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:42349 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934052AbeGCPPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 11:15:25 -0400
Received: by mail-qk0-f196.google.com with SMTP id u62-v6so1172352qkf.9
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 08:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rK+g+n++4fj1IWgn3YY+eDm5aFRppdp3RZ5KsDgMXmQ=;
        b=pq/OeWdht0SZnVaQKzKb89+YHeqPE9j7aHlU02mM8IfiZebQpZrMdXwKLin4NdRfGs
         vbFr3JVcyhKLV89cwv9xCmnmmKCY7m4P5Vmz27UUtlX0KdbDSzhNuZkgBvdQaH2TgJ5Z
         sF43uzxEHLALG0ch7WCB0OrHrHjYiKgBXm+1osCnlXD5HvUjwi9C/63EMJK0NRI/jwrT
         3DwzeeW6L5941lAohydgXiLU8rp8KcmkDDNQ2jqX2XZK60zrFpcfVmZo6q0TzViIqkU1
         5HpQ9+i3q4PbtNkcs4LXR8kbbIuB7ZKVZeNFiz/FKAhkiQCVcGjjYsmxhPIw1XAcs2xC
         bG9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rK+g+n++4fj1IWgn3YY+eDm5aFRppdp3RZ5KsDgMXmQ=;
        b=fEcOkaDxOTP4TUtseKBPLYmeoa5GZbSv3YHL5vNLAiAo7yOQoiMlhL1+GyT+lSu50L
         h5K9BxiwDnmId7XwKem7A9GmN2+Y1+nVlfpZijhGcvRW8ghBxtLvoxSxNbWacu9iTDZh
         9Btk9zRfJguMTNbjuD2YQWBrJ2rJVLVtPLhU1IAtb2F2H9UgQrb6GXp/wSd40mYMlfZj
         MEfTKf28FAdwi2H6pWSkUrvqdJoxS5OrVtUoINGzaPMlDH8VO6+Tb621lQpTf6jZ0ln6
         2b2VJDCU+p1oZuIEWmj9gygTeq+a+L6bCwWXWUzTXLWLjq3LP/rAGZW3UvBGEdnqYuqu
         iZpw==
X-Gm-Message-State: APt69E219x2NrMudR4TpUsBMhMOm1kCDxqca4IhwSMhiMM/DaW0cIxGW
        a5QAKaTaOtEp3wjRgUXBNg83Rg==
X-Google-Smtp-Source: AAOMgpdlvnU+a4my6xXGhhITtuQAQH/QXzLDJFIBWmXQTrYy7hF8BCTD998ibeiLcYZx/pPRvgde9A==
X-Received: by 2002:a37:9605:: with SMTP id y5-v6mr25232445qkd.236.1530630924302;
        Tue, 03 Jul 2018 08:15:24 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id e63-v6sm905225qkj.62.2018.07.03.08.15.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 08:15:23 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     axboe@kernel.dk, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, hannes@cmpxchg.org, tj@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        kernel-team@fb.com
Cc:     Josef Bacik <jbacik@fb.com>
Subject: [PATCH 11/14] rq-qos: introduce dio_bio callback
Date:   Tue,  3 Jul 2018 11:15:00 -0400
Message-Id: <20180703151503.2549-12-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180703151503.2549-1-josef@toxicpanda.com>
References: <20180703151503.2549-1-josef@toxicpanda.com>
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
index e09f3626ab5b..5df998515adc 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -32,6 +32,7 @@
 
 #include <trace/events/block.h>
 #include "blk.h"
+#include "blk-rq-qos.h"
 
 /*
  * Test patch to inline a certain number of bi_io_vec's inside the bio
@@ -1808,6 +1809,9 @@ void bio_endio(struct bio *bio)
 	if (!bio_integrity_endio(bio))
 		return;
 
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


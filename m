Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D124C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 029AD25C36
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:13:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="eEJJkiaT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 029AD25C36
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934898AbeFYPNL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 11:13:11 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:33001 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934842AbeFYPND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 11:13:03 -0400
Received: by mail-qk0-f193.google.com with SMTP id c131-v6so7681902qkb.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 08:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oqEXHFPy/UD/4NNoUiVbo/dXSAkuFuYpl2PiuLJXLwU=;
        b=eEJJkiaT832SNliN6La5QUQz7qH4SrfqAyYpXSRTwDuuVLenQu/LbO6S1OyFjVDMvW
         KL6qvs3Hezqdej0MHXNt8KSZaMupdIQ2VotI4eey4JgrrexnHR247a8aywl17PQuQBsJ
         6b6px1TIvvr1+lbQnGWUORF8YYtQMQ6C+VyyXytnfHFUIMNfcGzUiU5cBmD+zYcqvmbs
         yNsfu/BNlQEOaHl4jE6VOWpnJ9RO7MEwzVw1uLiIN93ffbqR1+W13RcsHFSqQtNzcVTE
         yio/ONXRegyWr3xBZpHHd1JBPsro0akazFgqrv/4k4Mppo+HukeTwVGvhP33WVswIwHt
         KnlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oqEXHFPy/UD/4NNoUiVbo/dXSAkuFuYpl2PiuLJXLwU=;
        b=rJ7Ic7u4EVT9qIlDtbBWBSgd9zVOn9stb3/Zn9GHHFL2VVRLzkI/bBIUoyAXWi4EzG
         BzbfcMCzQhmwoQ61Ca6OmoRzW/MW7zNngnUcE7FKY8INOL7U2QGQE6HondOSFa0KXDw6
         TYQZNNocWJE6ND2vast47WWNVn+2UlOiENdxAUILtOY0i8Ts7++52Ht8R136PO7L+if+
         K3pebr5bSLzYokPxJZP4USvuVONJ3dVQjQ6h7Lt9hx1ODV22rDRc1Ys0B7OZPFrOf0GE
         cngD576IcoCoYVWQC9y5JDQVZTqFKhGz+/wRiLjqJamyR/vtKwZYCjj5E4F3/HzPamoD
         +cIA==
X-Gm-Message-State: APt69E3xNDTBHJP3XUb1KtosNnxKBksGjUvLvZGo41hT09EtKPAsYtC0
        szNnRTqQJ/5lkWYKLGmG+rUWCA==
X-Google-Smtp-Source: ADUXVKL9KkLW3C4cvewMqvnP2upqLaXXDc00tulNLwx5B6IPU4B5Y7g68OVBCZ7iWe9KwEkWhGSdcQ==
X-Received: by 2002:a37:670c:: with SMTP id b12-v6mr10670332qkc.108.1529939582267;
        Mon, 25 Jun 2018 08:13:02 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id 27-v6sm8085887qtz.74.2018.06.25.08.13.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Jun 2018 08:13:01 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org, kernel-team@fb.com,
        akpm@linux-foundation.org, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, tj@kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     Josef Bacik <jbacik@fb.com>
Subject: [PATCH 11/15] rq-qos: introduce dio_bio callback
Date:   Mon, 25 Jun 2018 11:12:39 -0400
Message-Id: <20180625151243.2132-12-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180625151243.2132-1-josef@toxicpanda.com>
References: <20180625151243.2132-1-josef@toxicpanda.com>
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
index 501253676dd8..3874e6ad09f0 100644
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
@@ -86,6 +87,7 @@ void rq_qos_cleanup(struct request_queue *, struct bio *);
 void rq_qos_done(struct request_queue *, struct request *);
 void rq_qos_issue(struct request_queue *, struct request *);
 void rq_qos_requeue(struct request_queue *, struct request *);
+void rq_qos_done_bio(struct request_queue *q, struct bio *bio);
 void rq_qos_throttle(struct request_queue *, struct bio *, spinlock_t *);
 void rq_qos_track(struct request_queue *q, struct request *, struct bio *);
 void rq_qos_exit(struct request_queue *);
-- 
2.14.3


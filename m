Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E144ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0459320882
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:23:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="T9VQZi1X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0459320882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbeINTiJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 15:38:09 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35364 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728199AbeINTiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 15:38:07 -0400
Received: by mail-wm1-f66.google.com with SMTP id o18-v6so2142570wmc.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 07:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=M+kKZwDAbPtAP7Qkjv5tvIc/0u48iTxGHE2Zfoo1e6E=;
        b=T9VQZi1XlVk9k/P+MMtiy3GtXFT9jG4xtC0/Js2nTqEmmRdIAwUlx2gMBwVJqGFANH
         +XtZdbYYhV6NAR1EPEgPlTzI7dDsolyJOZPDoGAa9nBBbM0djwr3VGeSJudEVBQ2iH2I
         pAc0HGNEiZ/yst5qeay6jskTiZxS7qMh3O1K0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=M+kKZwDAbPtAP7Qkjv5tvIc/0u48iTxGHE2Zfoo1e6E=;
        b=Bz5CzfQy4b1GuAMeom/nmym16n06ePlW0CMuFVJtUSC2DassSkz9FMd/4Dz6gAyXF2
         798TqGMtbxOHigc3+ZFJv1fC45I9YKX6YlTSFwM3wZM/GlevXwbHdJEu7+FBSEzEWQCu
         ILWICglboMllZ9+43+w+V6s7bhVN/RWTc9DE7V8sArUyqTk3+WyIcm6XcsVTpV7JKsZA
         p/BYzyntgkRbgdhx+HzQHnGw5bBYR5LcZATxL+9Hc0nvv3n9bc9iK+rcCEziLEtaEySs
         k/VYj4+Ld72dWE6u+BHHX499NbwE0KN3IZGvmSp12HBXxoVsPFf4uOx1jTMswYv5Pbn0
         XkIg==
X-Gm-Message-State: APzg51Cs7kDxznt1yiVkhYlUiqVrDWgPS7ptw+sk1iSQlYvoV2IodK2A
        QQ3FdXl43b18d0J6vR9pjcnJAg==
X-Google-Smtp-Source: ANB0Vdb2roS9vO2NnQduviZfwfeiGvCgLauMSgta6qZiF+WYb8jivgMQZBztG+rBV1UKoWSo3lQT2w==
X-Received: by 2002:a1c:3712:: with SMTP id e18-v6mr2608332wma.84.1536935001094;
        Fri, 14 Sep 2018 07:23:21 -0700 (PDT)
Received: from wifi-122_dhcprange-84.wifi.unimo.it (wifi-122_dhcprange-84.wifi.unimo.it. [155.185.122.84])
        by smtp.gmail.com with ESMTPSA id k35-v6sm17084888wrc.14.2018.09.14.07.23.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 07:23:20 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        broonie@kernel.org, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name, Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX/IMPROVEMENT 2/3] block, bfq: inject other-queue I/O into seeky idle queues on NCQ flash
Date:   Fri, 14 Sep 2018 16:23:08 +0200
Message-Id: <20180914142309.6789-3-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180914142309.6789-1-paolo.valente@linaro.org>
References: <20180914142309.6789-1-paolo.valente@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Achilles' heel of BFQ is its failing to reach a high throughput
with sync random I/O on flash storage with internal queueing, in case
the processes doing I/O have differentiated weights.

The cause of this failure is as follows. If at least two processes do
sync I/O, and have a different weight from each other, then BFQ plugs
I/O dispatching every time one of these processes, while it is being
served, remains temporarily without pending I/O requests. This
plugging is necessary to guarantee that every process enjoys a
bandwidth proportional to its weight; but it empties the internal
queue(s) of the drive. And this kills throughput with random I/O. So,
if some processes have differentiated weights and do both sync and
random I/O, the end result is a throughput collapse.

This commit tries to counter this problem by injecting the service of
other processes, in a controlled way, while the process in service
happens to have no I/O. This injection is performed only if the medium
is non rotational and performs internal queueing, and the process in
service does random I/O (service injection might be beneficial for
sequential I/O too, we'll work on that).

As an example of the benefits of this commit, on a PLEXTOR PX-256M5S
SSD, and with five processes having differentiated weights and doing
sync random 4KB I/O, this commit makes the throughput with bfq grow by
400%, from 25 to 100MB/s. This higher throughput is 10MB/s lower than
that reached with none. As some less random I/O is added to the mix,
the throughput becomes equal to or higher than that with none.

This commit is a very first attempt to recover throughput without
losing control, and certainly has many limitations. One is, e.g., that
the processes whose service is injected are not chosen so as to
distribute the extra bandwidth they receive in accordance to their
weights. Thus there might be loss of weighted fairness in some
cases. Anyway, this loss concerns extra service, which would not have
been received at all without this commit. Other limitations and issues
will probably show up with usage.

Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 68 ++++++++++++++++++++++++++++++++++++++++++++++++-----
 block/bfq-iosched.h | 26 ++++++++++++++++++++
 2 files changed, 88 insertions(+), 6 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 653100fb719e..d94838bcc135 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -3182,6 +3182,13 @@ static unsigned long bfq_bfqq_softrt_next_start(struct bfq_data *bfqd,
 		    jiffies + nsecs_to_jiffies(bfqq->bfqd->bfq_slice_idle) + 4);
 }
 
+static bool bfq_bfqq_injectable(struct bfq_queue *bfqq)
+{
+	return BFQQ_SEEKY(bfqq) && bfqq->wr_coeff == 1 &&
+		blk_queue_nonrot(bfqq->bfqd->queue) &&
+		bfqq->bfqd->hw_tag;
+}
+
 /**
  * bfq_bfqq_expire - expire a queue.
  * @bfqd: device owning the queue.
@@ -3291,6 +3298,8 @@ void bfq_bfqq_expire(struct bfq_data *bfqd,
 	if (ref == 1) /* bfqq is gone, no more actions on it */
 		return;
 
+	bfqq->injected_service = 0;
+
 	/* mark bfqq as waiting a request only if a bic still points to it */
 	if (!bfq_bfqq_busy(bfqq) &&
 	    reason != BFQQE_BUDGET_TIMEOUT &&
@@ -3629,6 +3638,30 @@ static bool bfq_bfqq_must_idle(struct bfq_queue *bfqq)
 	return RB_EMPTY_ROOT(&bfqq->sort_list) && bfq_better_to_idle(bfqq);
 }
 
+static struct bfq_queue *bfq_choose_bfqq_for_injection(struct bfq_data *bfqd)
+{
+	struct bfq_queue *bfqq;
+
+	/*
+	 * A linear search; but, with a high probability, very few
+	 * steps are needed to find a candidate queue, i.e., a queue
+	 * with enough budget left for its next request. In fact:
+	 * - BFQ dynamically updates the budget of every queue so as
+	 *   to accommodate the expected backlog of the queue;
+	 * - if a queue gets all its requests dispatched as injected
+	 *   service, then the queue is removed from the active list
+	 *   (and re-added only if it gets new requests, but with
+	 *   enough budget for its new backlog).
+	 */
+	list_for_each_entry(bfqq, &bfqd->active_list, bfqq_list)
+		if (!RB_EMPTY_ROOT(&bfqq->sort_list) &&
+		    bfq_serv_to_charge(bfqq->next_rq, bfqq) <=
+		    bfq_bfqq_budget_left(bfqq))
+			return bfqq;
+
+	return NULL;
+}
+
 /*
  * Select a queue for service.  If we have a current queue in service,
  * check whether to continue servicing it, or retrieve and set a new one.
@@ -3710,10 +3743,19 @@ static struct bfq_queue *bfq_select_queue(struct bfq_data *bfqd)
 	 * No requests pending. However, if the in-service queue is idling
 	 * for a new request, or has requests waiting for a completion and
 	 * may idle after their completion, then keep it anyway.
+	 *
+	 * Yet, to boost throughput, inject service from other queues if
+	 * possible.
 	 */
 	if (bfq_bfqq_wait_request(bfqq) ||
 	    (bfqq->dispatched != 0 && bfq_better_to_idle(bfqq))) {
-		bfqq = NULL;
+		if (bfq_bfqq_injectable(bfqq) &&
+		    bfqq->injected_service * bfqq->inject_coeff <
+		    bfqq->entity.service * 10)
+			bfqq = bfq_choose_bfqq_for_injection(bfqd);
+		else
+			bfqq = NULL;
+
 		goto keep_queue;
 	}
 
@@ -3803,6 +3845,14 @@ static struct request *bfq_dispatch_rq_from_bfqq(struct bfq_data *bfqd,
 
 	bfq_dispatch_remove(bfqd->queue, rq);
 
+	if (bfqq != bfqd->in_service_queue) {
+		if (likely(bfqd->in_service_queue))
+			bfqd->in_service_queue->injected_service +=
+				bfq_serv_to_charge(rq, bfqq);
+
+		goto return_rq;
+	}
+
 	/*
 	 * If weight raising has to terminate for bfqq, then next
 	 * function causes an immediate update of bfqq's weight,
@@ -3821,13 +3871,12 @@ static struct request *bfq_dispatch_rq_from_bfqq(struct bfq_data *bfqd,
 	 * belongs to CLASS_IDLE and other queues are waiting for
 	 * service.
 	 */
-	if (bfqd->busy_queues > 1 && bfq_class_idle(bfqq))
-		goto expire;
-
-	return rq;
+	if (!(bfqd->busy_queues > 1 && bfq_class_idle(bfqq)))
+		goto return_rq;
 
-expire:
 	bfq_bfqq_expire(bfqd, bfqq, false, BFQQE_BUDGET_EXHAUSTED);
+
+return_rq:
 	return rq;
 }
 
@@ -4232,6 +4281,13 @@ static void bfq_init_bfqq(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 			bfq_mark_bfqq_has_short_ttime(bfqq);
 		bfq_mark_bfqq_sync(bfqq);
 		bfq_mark_bfqq_just_created(bfqq);
+		/*
+		 * Aggressively inject a lot of service: up to 90%.
+		 * This coefficient remains constant during bfqq life,
+		 * but this behavior might be changed, after enough
+		 * testing and tuning.
+		 */
+		bfqq->inject_coeff = 1;
 	} else
 		bfq_clear_bfqq_sync(bfqq);
 
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index a8a2e5aca4d4..37d627afdc2e 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -351,6 +351,32 @@ struct bfq_queue {
 	unsigned long split_time; /* time of last split */
 
 	unsigned long first_IO_time; /* time of first I/O for this queue */
+
+	/* max service rate measured so far */
+	u32 max_service_rate;
+	/*
+	 * Ratio between the service received by bfqq while it is in
+	 * service, and the cumulative service (of requests of other
+	 * queues) that may be injected while bfqq is empty but still
+	 * in service. To increase precision, the coefficient is
+	 * measured in tenths of unit. Here are some example of (1)
+	 * ratios, (2) resulting percentages of service injected
+	 * w.r.t. to the total service dispatched while bfqq is in
+	 * service, and (3) corresponding values of the coefficient:
+	 * 1 (50%) -> 10
+	 * 2 (33%) -> 20
+	 * 10 (9%) -> 100
+	 * 9.9 (9%) -> 99
+	 * 1.5 (40%) -> 15
+	 * 0.5 (66%) -> 5
+	 * 0.1 (90%) -> 1
+	 *
+	 * So, if the coefficient is lower than 10, then
+	 * injected service is more than bfqq service.
+	 */
+	unsigned int inject_coeff;
+	/* amount of service injected in current service slot */
+	unsigned int injected_service;
 };
 
 /**
-- 
2.16.1


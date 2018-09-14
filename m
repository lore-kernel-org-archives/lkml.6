Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B0AFC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14866206B5
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:23:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YNVrodgC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14866206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728257AbeINTiI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 15:38:08 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40689 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728236AbeINTiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 15:38:08 -0400
Received: by mail-wm1-f68.google.com with SMTP id 207-v6so2122901wme.5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 07:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NDz4sLfCSE+TqlBABM2X5T0yTWgA3O/WCAY/iJ5XldA=;
        b=YNVrodgCbk9Qq5HogJG1AhAKMGOgsPkDX58PZ3nUiWAS19J+GLmr3eM3hbVzJEl1Nn
         iM2s6VmpVn4WiFQuLfYRHP2pMDq8+L3ybI0QLjIYffvVskXBxpPjNaBX3+q4bXdcnVLY
         Du/pd6y5PG7r0qZeYTHjwoZW0jagutAO8C3+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NDz4sLfCSE+TqlBABM2X5T0yTWgA3O/WCAY/iJ5XldA=;
        b=s5pmOJ1dkf0Zgp05Eqjj5svVmDlVA25Kf3aao00IlTgC59DLxDFVWOttz+L6bskU2e
         wWlRM/f9fAvknpWflXJoDpBHI4OlWFSd6SaXlUTafJlaA1cSzPpyekioDWh/AZyD+c3p
         r/p4J5bkXuMQdDFrAWgRue5cIoyywCApRzwCpY8It7z6yxnFoCZHIUaRJRy8OKszIsrF
         HlKxUS7V1h3MLTEUJI3CYxjcxZu1oS77ZIpvMzR5Mu85VwN/bGtSHGt+F8L9SLVBsV5z
         4U+WZdyd4Y9o6FaWgwX6BUMLg+JFZ45XmWzyjVtpPFzBDkCdWAfQSgfeZpS1iBf9df0v
         YiyQ==
X-Gm-Message-State: APzg51Di5Jd9oNsmn2k5al3bLqSnEXf1U9RYok9Cyn+1jmyfBHjIO6NQ
        2L0jsW06ua/t5t8Aye/61NXXkaQ2T1w=
X-Google-Smtp-Source: ANB0VdatT45JAM/5KjiNdu4KqJYvNk2u5kJbIkXjMdxryqHtWweyDmfxtS+Ji2yPHF7/9ddQxCFC+Q==
X-Received: by 2002:a1c:c14:: with SMTP id 20-v6mr2618562wmm.117.1536935002644;
        Fri, 14 Sep 2018 07:23:22 -0700 (PDT)
Received: from wifi-122_dhcprange-84.wifi.unimo.it (wifi-122_dhcprange-84.wifi.unimo.it. [155.185.122.84])
        by smtp.gmail.com with ESMTPSA id k35-v6sm17084888wrc.14.2018.09.14.07.23.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 07:23:21 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        broonie@kernel.org, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name, Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX/IMPROVEMENT 3/3] blok, bfq: do not plug I/O if all queues are weight-raised
Date:   Fri, 14 Sep 2018 16:23:09 +0200
Message-Id: <20180914142309.6789-4-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180914142309.6789-1-paolo.valente@linaro.org>
References: <20180914142309.6789-1-paolo.valente@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To reduce latency for interactive and soft real-time applications, bfq
privileges the bfq_queues containing the I/O of these
applications. These privileged queues, referred-to as weight-raised
queues, get a much higher share of the device throughput
w.r.t. non-privileged queues. To preserve this higher share, the I/O
of any non-weight-raised queue must be plugged whenever a sync
weight-raised queue, while being served, remains temporarily empty. To
attain this goal, bfq simply plugs any I/O (from any queue), if a sync
weight-raised queue remains empty while in service.

Unfortunately, this plugging typically lowers throughput with random
I/O, on devices with internal queueing (because it reduces the filling
level of the internal queues of the device).

This commit addresses this issue by restricting the cases where
plugging is performed: if a sync weight-raised queue remains empty
while in service, then I/O plugging is performed only if some of the
active bfq_queues are *not* weight-raised (which is actually the only
circumstance where plugging is needed to preserve the higher share of
the throughput of weight-raised queues). This restriction proved able
to boost throughput in really many use cases needing only maximum
throughput.

Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index d94838bcc135..c0b1db3afb81 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -3580,7 +3580,12 @@ static bool bfq_better_to_idle(struct bfq_queue *bfqq)
 	 * whether bfqq is being weight-raised, because
 	 * bfq_symmetric_scenario() does not take into account also
 	 * weight-raised queues (see comments on
-	 * bfq_weights_tree_add()).
+	 * bfq_weights_tree_add()). In particular, if bfqq is being
+	 * weight-raised, it is important to idle only if there are
+	 * other, non-weight-raised queues that may steal throughput
+	 * to bfqq. Actually, we should be even more precise, and
+	 * differentiate between interactive weight raising and
+	 * soft real-time weight raising.
 	 *
 	 * As a side note, it is worth considering that the above
 	 * device-idling countermeasures may however fail in the
@@ -3592,7 +3597,8 @@ static bool bfq_better_to_idle(struct bfq_queue *bfqq)
 	 * to let requests be served in the desired order until all
 	 * the requests already queued in the device have been served.
 	 */
-	asymmetric_scenario = bfqq->wr_coeff > 1 ||
+	asymmetric_scenario = (bfqq->wr_coeff > 1 &&
+			       bfqd->wr_busy_queues < bfqd->busy_queues) ||
 		!bfq_symmetric_scenario(bfqd);
 
 	/*
-- 
2.16.1


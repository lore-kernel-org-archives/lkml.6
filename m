Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 164C7C32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 03:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC9E42081D
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 03:51:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bOiBGxpT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC9E42081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729113AbeKDNEr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 08:04:47 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37288 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729000AbeKDNEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 08:04:47 -0500
Received: by mail-pf1-f196.google.com with SMTP id u13-v6so2810743pfm.4
        for <linux-kernel@vger.kernel.org>; Sat, 03 Nov 2018 20:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=WyXt3/RSV27qxDb1bu2HqD4MnOWv0qQF0psRZ70CdJ8=;
        b=bOiBGxpTj7Fm7RtK/vhAEtjMiR8HGjHW9Kl9Q2/CAoYGueBgcQM06oF2eVfDOzGFgT
         amayOO0Cc2ROSckbhaTbqUz9EbARAva7A7/fwlfNOvFDbicOyFAhVoxka9H7BxW3oUZb
         8G0N8ucGkcztOgSwsn0VbNvJBZY1SDW3DK4qaixWJJTuZG454RihC9diZxAXMibYHUfd
         gzA1iFM3Aqz5mdtjLpgwgASN24UFnSH7yAHlazk58KeIAbqEnwIm9qThCpTw8fLc3TKT
         IaGwKsIO4UbrHcXcM07tj0lSmMUX1vs55mpdHnkJ+wWAFswpQx3GN+vjaBaMPnm0TVNk
         S1zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WyXt3/RSV27qxDb1bu2HqD4MnOWv0qQF0psRZ70CdJ8=;
        b=h5eO17VxhrjwuzWEELDkr+oLeiTkUylP8DspFydk8x5dzWXJewQUOQ9Hto8XGSh6NY
         FgR9j6i5mIq2kX8BMn8id1SjDB9MnM57TsYk/uKTA8K0wJaQp19s+aEZD6QGcmJtGngW
         zsFdOogUZ+rxNH+6NWjSWUE/O3iKHSU0Mw/sYQtK11RmuHRmOMD3xbfM79lCnjF7ZC6Q
         Z90lEHSPnbgFYMUcRfh0l5E+jtm+ghdzFtEWfE1caPBKbzj8fV4yivqy4ek2S5vgUGQO
         4KMFN33I5S5LSfKq3JiZl/t8ys89bXEFLDJCXTaKEK69o+iJ97BrsenaK9YsyBkrJpWU
         T13A==
X-Gm-Message-State: AGRZ1gIVwqdVgS7ZeKHNRKF57fbmoQ1xn+ntMtNJKXZ3Uec7nOjB8w4j
        c0gquV25U+f8GaUAecn7xeIf9BY9/84=
X-Google-Smtp-Source: AJdET5e+jj7q7qMcbN/VZvS8m2BOiDZQ8BKcB5kP4/jBDiZCnAbi8xtS1ruZMivRKqD3TXP4TH1qUw==
X-Received: by 2002:a62:5210:: with SMTP id g16-v6mr17405568pfb.256.1541303481098;
        Sat, 03 Nov 2018 20:51:21 -0700 (PDT)
Received: from localhost.localdomain ([104.238.150.158])
        by smtp.gmail.com with ESMTPSA id u190-v6sm98398074pgu.3.2018.11.03.20.51.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Nov 2018 20:51:20 -0700 (PDT)
From:   Muchun Song <smuchun@gmail.com>
To:     mingo@kernel.org, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2] sched/core: Remove unnecessary check for next_task in push_{rt,dl}_task()
Date:   Sun,  4 Nov 2018 11:51:01 +0800
Message-Id: <20181104035101.21805-1-smuchun@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In push_{rt,dl}_task(), we call pick_next_pushable{_dl}_task() to
pick next_task before the check. If next_task and rq->curr are equal,
which will trigger BUG_ON() in pick_next_pushable{_dl}_task(). See
the following code in pick_next_pushable{_dl}_task().

  static struct task_struct *pick_next_pushable{_dl}_task(struct rq *rq)
  {
	BUG_ON(task_current(rq, p));
  }

The task_current() will check if task p and rq->curr are equal.
So, we can remove the unnecessary check in push_{rt,dl}_task().

Signed-off-by: Muchun Song <smuchun@gmail.com>
---
Changes in v2:
  -also remove unnecessary check in deadline.c
  -update commit message
---
 kernel/sched/deadline.c | 5 -----
 kernel/sched/rt.c       | 5 -----
 2 files changed, 10 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 470ba6b464fe..4b0189627318 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2042,11 +2042,6 @@ static int push_dl_task(struct rq *rq)
 		return 0;
 
 retry:
-	if (unlikely(next_task == rq->curr)) {
-		WARN_ON(1);
-		return 0;
-	}
-
 	/*
 	 * If next_task preempts rq->curr, and rq->curr
 	 * can move away, it makes sense to just reschedule
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 481bb7aa25c5..ec097edea9ca 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1813,11 +1813,6 @@ static int push_rt_task(struct rq *rq)
 		return 0;
 
 retry:
-	if (unlikely(next_task == rq->curr)) {
-		WARN_ON(1);
-		return 0;
-	}
-
 	/*
 	 * It's possible that the next_task slipped in of
 	 * higher priority than current. If that's the case
-- 
2.17.1


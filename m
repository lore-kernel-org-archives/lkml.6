Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E9B3C67790
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 00:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7BF320671
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 00:24:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o8Z8WNTd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7BF320671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389283AbeG1Bsv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 21:48:51 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:46957 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388735AbeG1Bsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 21:48:51 -0400
Received: by mail-pl0-f65.google.com with SMTP id t17-v6so2954954ply.13
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 17:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=IvsC6PIBsmEaE4mlDdp6wGYswjjP4f05wewW0lYb8Dw=;
        b=o8Z8WNTd5pvEU4nYnC/U6P7zeh/AF9rpV8QTwwb7vO3xGkWZPEiALUeTCI4KNkcfrI
         YnVv3g6wQApZ0tnqsCQrnSJpcxUwdSrLZaeQ3l/HZwK2xRlsHg2Uz3Wz/x/3WwPzsKBi
         V0Z+ED2YPUnue7FCbNibiPsYt5gY7kjkWyf9VOXNfF3vxgSDC/MRn/D60zIr5zi2fInO
         F2SOHCtAynZVUILKeUwrCacf6tn5qR62Uj0p+K7vtMugXWf1LxnOwPTNrd5pqbzVNpDh
         RBWBNCSq3STKhzWVEfD/vAVbWDyfMB3vgeRrFsKL/JIdCc/SsAsLJEHmxjvfRRbWF+zi
         NjFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IvsC6PIBsmEaE4mlDdp6wGYswjjP4f05wewW0lYb8Dw=;
        b=N3FQSiyzFPM88+fJ0Si0NY+bjVaFkiPauGBi6C1X8/TZES8BvPU3QK/6Xyyqnar8sy
         lkl30a++WtxYRug4C4OEh+TNyUq/VrbYbfE+wfGMPiaPWY8439wYeO5cbP6vCe3P6bi7
         HSZGSI9GwMGfiWIwZ5xMgEjy622J/1kP+Y7rB0HQQDbDNo1cuvM390JF4YxFpfRFoUvN
         Ivdz6y9V82jNx9//Ql+9O+1qK231TTiuJz5jxHn2CwJThVR6W5zZFALlOFyl2cuGr3kA
         MvgfnvHWicTIrEAICl+Fo+kgwKQwLgCCzCa7bfp4DkhEjtSwWv2TcqyCup0KR542JEi+
         NmHw==
X-Gm-Message-State: AOUpUlHP6IPNpHpDdiQljB1IabJv1s1D35cKv8DJI0LE4mzHI0M6uNCA
        e8CV/mdXJ/trXYcnKZ6v9R2rdBWh
X-Google-Smtp-Source: AAOMgpePZAFQP+5k/G5JQG1f/vMpglhBHykpoIWmuE/QC7dBUl2IwVvrOZfYJUYZmdsHT9e0qru1vA==
X-Received: by 2002:a17:902:243:: with SMTP id 61-v6mr7761921plc.301.1532737472089;
        Fri, 27 Jul 2018 17:24:32 -0700 (PDT)
Received: from tw-172-25-29-199.office.twttr.net ([8.25.197.27])
        by smtp.gmail.com with ESMTPSA id a134-v6sm7284118pfa.158.2018.07.27.17.24.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Jul 2018 17:24:31 -0700 (PDT)
From:   Cong Wang <xiyou.wangcong@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Cong Wang <xiyou.wangcong@gmail.com>,
        Xunlei Pang <xlpang@linux.alibaba.com>,
        Ben Segall <bsegall@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] sched/fair: sync expires_seq in distribute_cfs_runtime()
Date:   Fri, 27 Jul 2018 17:24:09 -0700
Message-Id: <20180728002409.5781-1-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each time we sync cfs_rq->runtime_expires with cfs_b->runtime_expires,
we should sync its ->expires_seq too. However it is missing
for distribute_cfs_runtime(), especially the slack timer call path.

Fixes: 512ac999d275 ("sched/fair: Fix bandwidth timer clock drift condition")
Cc: Xunlei Pang <xlpang@linux.alibaba.com>
Cc: Ben Segall <bsegall@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
---
 kernel/sched/fair.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2f0a0be4d344..910c50db3d74 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4857,7 +4857,7 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 }
 
 static u64 distribute_cfs_runtime(struct cfs_bandwidth *cfs_b,
-		u64 remaining, u64 expires)
+		u64 remaining, u64 expires, int expires_seq)
 {
 	struct cfs_rq *cfs_rq;
 	u64 runtime;
@@ -4880,6 +4880,7 @@ static u64 distribute_cfs_runtime(struct cfs_bandwidth *cfs_b,
 
 		cfs_rq->runtime_remaining += runtime;
 		cfs_rq->runtime_expires = expires;
+		cfs_rq->expires_seq = expires_seq;
 
 		/* we check whether we're throttled above */
 		if (cfs_rq->runtime_remaining > 0)
@@ -4905,7 +4906,7 @@ static u64 distribute_cfs_runtime(struct cfs_bandwidth *cfs_b,
 static int do_sched_cfs_period_timer(struct cfs_bandwidth *cfs_b, int overrun)
 {
 	u64 runtime, runtime_expires;
-	int throttled;
+	int throttled, expires_seq;
 
 	/* no need to continue the timer with no bandwidth constraint */
 	if (cfs_b->quota == RUNTIME_INF)
@@ -4933,6 +4934,7 @@ static int do_sched_cfs_period_timer(struct cfs_bandwidth *cfs_b, int overrun)
 	cfs_b->nr_throttled += overrun;
 
 	runtime_expires = cfs_b->runtime_expires;
+	expires_seq = cfs_b->expires_seq;
 
 	/*
 	 * This check is repeated as we are holding onto the new bandwidth while
@@ -4946,7 +4948,7 @@ static int do_sched_cfs_period_timer(struct cfs_bandwidth *cfs_b, int overrun)
 		raw_spin_unlock(&cfs_b->lock);
 		/* we can't nest cfs_b->lock while distributing bandwidth */
 		runtime = distribute_cfs_runtime(cfs_b, runtime,
-						 runtime_expires);
+						 runtime_expires, expires_seq);
 		raw_spin_lock(&cfs_b->lock);
 
 		throttled = !list_empty(&cfs_b->throttled_cfs_rq);
@@ -5055,6 +5057,7 @@ static __always_inline void return_cfs_rq_runtime(struct cfs_rq *cfs_rq)
 static void do_sched_cfs_slack_timer(struct cfs_bandwidth *cfs_b)
 {
 	u64 runtime = 0, slice = sched_cfs_bandwidth_slice();
+	int expires_seq;
 	u64 expires;
 
 	/* confirm we're still not at a refresh boundary */
@@ -5068,12 +5071,13 @@ static void do_sched_cfs_slack_timer(struct cfs_bandwidth *cfs_b)
 		runtime = cfs_b->runtime;
 
 	expires = cfs_b->runtime_expires;
+	expires_seq = cfs_b->expires_seq;
 	raw_spin_unlock(&cfs_b->lock);
 
 	if (!runtime)
 		return;
 
-	runtime = distribute_cfs_runtime(cfs_b, runtime, expires);
+	runtime = distribute_cfs_runtime(cfs_b, runtime, expires, expires_seq);
 
 	raw_spin_lock(&cfs_b->lock);
 	if (expires == cfs_b->runtime_expires)
-- 
2.14.4


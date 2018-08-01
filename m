Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A03CBC46463
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 15:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5516120894
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 15:17:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="YMeIfO7c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5516120894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389833AbeHARDq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 13:03:46 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:35075 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389806AbeHARDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 13:03:45 -0400
Received: by mail-qt0-f193.google.com with SMTP id a5-v6so20262699qtp.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 08:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EOH4yuXU61UFUoCxssnGS0E9pmyAjCBzpOCJhmVNCYY=;
        b=YMeIfO7cHaOPiMpMbEL3NOKawxOjbeGFP0k9cxcW/u73CdC8UdEjGti+n/J1hepbbL
         zC9EPQ6M3PsLnBBXu7zrA5qGMcnCgHgagLN5jzI9+SmcImMJ961PzYjpSy45FkXX0JZw
         0eAz+TM8bpe3OY27wnif6jAJ8/W4uBGXYf3fvtSHMoZ0RqTjQt589ELUAgAfzwQ2ojr+
         jkjjPbmQoZ9q0yzFS9xHB+gBuD9Lvz9GjaGpD1GL9Bvs1M/hMOlWdjgmBnGYs5V2O6SN
         YNN1XzVzvzPZx98pl+pkHX8yqqelvVMDJ+ZoYPpNA5PyWTg8YW5QcvjCMws1CkX9fo8r
         xyPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EOH4yuXU61UFUoCxssnGS0E9pmyAjCBzpOCJhmVNCYY=;
        b=ceFvA2yJjoiVpamNEfZJPSZaUf/5OdpaCIGSSZC8Is03SLCTMm/vWfeE57a5xRR+o6
         N3pp8BBXnNeYqaykSMAqt9bm6twYxUH/j/DNDbHOmbMK3Nke665/K4yBTut1pJNoaTMG
         UQxNwLyW9BKXsza7jYQpqYKzJkSMfVU3IFaewCsIUjkBAYORVCuNf/2dE8CJknhXMswD
         JPn3emKMhr3ro0HtqEaZqCBi+RMJF3o3im3FvQqW8GRGw/KRqVyAQ7Sn9VAbxnyIKEr/
         4eOcdf4Wmq8/FtRSsipuKVnuoF5oe12ZhMthcjwCwu8vKQLiCV3Rf66jalpwfjqfiVbs
         DeTg==
X-Gm-Message-State: AOUpUlHdMkIjD8h0ShivMZ88QEfoTzj94VsKLQHqyfhc7YYgdLDS+N6V
        frTwVbLtn1sEWe34mKofnlU9jc4227k=
X-Google-Smtp-Source: AAOMgpeUwxxVwE79rZ0AeguIBPrw6fa3hN35INPzAmkwgRZJ3nR0gQGHLrKgRnEqqtyC2D7jwYOOgA==
X-Received: by 2002:a0c:f8ce:: with SMTP id h14-v6mr23582982qvo.163.1533136654208;
        Wed, 01 Aug 2018 08:17:34 -0700 (PDT)
Received: from localhost (216.49.36.201.res-cmts.bus.ptd.net. [216.49.36.201])
        by smtp.gmail.com with ESMTPSA id k38-v6sm13787746qtc.45.2018.08.01.08.17.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 Aug 2018 08:17:33 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Tejun Heo <tj@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
        Daniel Drake <drake@endlessm.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Christopher Lameter <cl@linux.com>,
        Mike Galbraith <efault@gmx.de>,
        Shakeel Butt <shakeelb@google.com>,
        Peter Enderborg <peter.enderborg@sony.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 7/9] sched: introduce this_rq_lock_irq()
Date:   Wed,  1 Aug 2018 11:19:56 -0400
Message-Id: <20180801151958.32590-8-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801151958.32590-1-hannes@cmpxchg.org>
References: <20180801151958.32590-1-hannes@cmpxchg.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

do_sched_yield() disables IRQs, looks up this_rq() and locks it. The
next patch is adding another site with the same pattern, so provide a
convenience function for it.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 kernel/sched/core.c  |  4 +---
 kernel/sched/sched.h | 12 ++++++++++++
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 211890edf37e..9586a8141f16 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4960,9 +4960,7 @@ static void do_sched_yield(void)
 	struct rq_flags rf;
 	struct rq *rq;
 
-	local_irq_disable();
-	rq = this_rq();
-	rq_lock(rq, &rf);
+	rq = this_rq_lock_irq(&rf);
 
 	schedstat_inc(rq->yld_count);
 	current->sched_class->yield_task(rq);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index b8f038497240..bc798c7cb4d4 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1119,6 +1119,18 @@ rq_unlock(struct rq *rq, struct rq_flags *rf)
 	raw_spin_unlock(&rq->lock);
 }
 
+static inline struct rq *
+this_rq_lock_irq(struct rq_flags *rf)
+	__acquires(rq->lock)
+{
+	struct rq *rq;
+
+	local_irq_disable();
+	rq = this_rq();
+	rq_lock(rq, rf);
+	return rq;
+}
+
 #ifdef CONFIG_NUMA
 enum numa_topology_type {
 	NUMA_DIRECT,
-- 
2.18.0


Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A64D6C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 17:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6051620897
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 17:23:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="i3VAVTEl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6051620897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727707AbeH1VQN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 17:16:13 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:34548 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727636AbeH1VQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 17:16:12 -0400
Received: by mail-yw1-f66.google.com with SMTP id y134-v6so892920ywg.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 10:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/su2Xrr3lQDX5ALOohq5KkDM3OQAwHC1+exX8OmH6ME=;
        b=i3VAVTElMSCvpvFUYOOStTltjA1/oebEvqEJgK2PA6DvRgVyiCOVmImPqaMHV76+HV
         VddU83sXNka2uP8uLhNarc3C2lzzvrReI+SbDrvTyIXsP1XFvdHCxca7/vPI1SBidGlY
         buQn7ZBYitfoffhdVUWFbLr+vurVJdCSRIuSjGWsRt7YkzUPvXNnKxEuNrJs5pgfggwY
         RrZ91V0TriiZsSKvcbz+7lBp8vJzlG7ATC8Hzb9YU5vFngGZvk7zApkQC2o8nIfrmqQF
         qtOwuR2A4xmDAYtk1lC721AXu4fK7f3FTCAYfodsCKjMhevrxlO/tVrioleIU4YRkO5d
         Luaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/su2Xrr3lQDX5ALOohq5KkDM3OQAwHC1+exX8OmH6ME=;
        b=TTM8Kpds844M/f/6N9lJFgVGBtfg7kYH4hR4o7d0NEQwu8s6o6bIVavZxZmg1ATFSB
         GqBu7Hy/JJIVJL20wAzB+IIoPDHqKy9NAcuuMUBt9ZPjB0ZFCi7WfSzUI4nF1gxfOreH
         MVKxXcgeW4qZeKhB73sqGzh+8mmmtvwxoUO4g3XINguHlVOoDTFWVKMpalz2bGKveFNc
         DAuW0roxMy+V3TxOoq07w49JS3ThZhlXbZ9Q9vujp8uwoIEWqU3xtSPdqql3aocK7xti
         zTIK1LzWrixhuHR8e4Mwcu+FtQxJtUBXUISWP7f2V/MxvJFVh13xeb1ndgWGgBaljEVD
         RJYg==
X-Gm-Message-State: APzg51CVdmjbBP/D3PXfneAVt38WbNEbkFgSj8AR2xamCoTCRHJZFVPo
        uhtU14Z6afRtxswikCoyzlZIQQ==
X-Google-Smtp-Source: ANB0VdaGjhMHk/LoP9pxQ6zI+Ft2mph2e+kpmYnlC4jhUEnSZgoxYDjXfwKiawkL0MCpid9hWpZuYA==
X-Received: by 2002:a0d:cb88:: with SMTP id n130-v6mr1380569ywd.243.1535477013307;
        Tue, 28 Aug 2018 10:23:33 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::1:de86])
        by smtp.gmail.com with ESMTPSA id r3-v6sm675063ywr.80.2018.08.28.10.23.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Aug 2018 10:23:32 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Tejun Heo <tj@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
        Daniel Drake <drake@endlessm.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Christopher Lameter <cl@linux.com>,
        Peter Enderborg <peter.enderborg@sony.com>,
        Shakeel Butt <shakeelb@google.com>,
        Mike Galbraith <efault@gmx.de>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 7/9] sched: introduce this_rq_lock_irq()
Date:   Tue, 28 Aug 2018 13:22:56 -0400
Message-Id: <20180828172258.3185-8-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180828172258.3185-1-hannes@cmpxchg.org>
References: <20180828172258.3185-1-hannes@cmpxchg.org>
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
index fe365c9a08e9..61059e671fc6 100644
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
index eb9b1326906c..83db5de1464c 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1126,6 +1126,18 @@ rq_unlock(struct rq *rq, struct rq_flags *rf)
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


Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A4CC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 15:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3287020894
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 15:17:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="nU6nW8aD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3287020894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389775AbeHARDd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 13:03:33 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:37377 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389762AbeHARDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 13:03:32 -0400
Received: by mail-qt0-f193.google.com with SMTP id n6-v6so20281732qtl.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 08:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yu9UdCtaoT51hJzI6OxnWMzNlhzbw5nOYEshpoGdmog=;
        b=nU6nW8aDdAj9ucMbCPQn1mbv/ysQnX3z6H7LWSDwFF1stR3Qyduqrk//UnYBPInyTF
         iPsLNFLpy0A63l3pkYzxk3ygw11H6zUd8UQHocl75N/IuftWxi21WVJvIJkLdi4PjNL+
         cjwW7VDtq+y/njFgGDt0R2d0qw5rxP5lkUy7bFNkDuffOoYMJQGHqoIqnIKDP69un0rX
         sc7RaGWd4qpIjYNt1eachJPf48l5IO21txIkRAsorLweu+NuOtRvNfK/RpV9L0dSrG9V
         kawmB9mzco0i5athlAaWMOsR7nPiu0/wNpmcdjNrDzTkRRIZz3YBq3YE6rCA335/dDEc
         +pOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yu9UdCtaoT51hJzI6OxnWMzNlhzbw5nOYEshpoGdmog=;
        b=Mm+KUGNioRAeAgJMa4TtFVENocOtN+DE8CNdRQKPr1rtB7NMdK9Co8i0mLE47+lVCR
         /AMnW+wJPeIIq72d9uJuh9HNabAD0gxfhNWT8/6AiGODuiATFC7q7oDYClHTxFOdmp0c
         vstNJA7oKAfzwgthGLCqfG2Ff/ZD1SKSsKkl9cxj7FRyJAgjcoMiB9UjGSjz+iag/Bfo
         avIN00Pb643zLw3r0/9Dhs39ICo5kP8ImF1wUzt3PstSw7Qd79tZqx9nFB5eW/R3JDhY
         /SCAiqbUHYUmRkQo0hHjSd2IOvL2XrNgfjE5LDtkZ/jlRMjPhUOGp/s87MBcPMN0ZG9k
         D5JA==
X-Gm-Message-State: AOUpUlEBsbrN+D5RGJ9HXWxvfW5v94lw3peVJwd2RyzZkOfIeEFp7DHP
        wTylR2A/ScsHBsOHDv442S0rJw==
X-Google-Smtp-Source: AAOMgpdpiO1+5dTenI5rkqN6KooOzzXG9pjb8bbE8lJDgK0SL3xf6THg406jAEBXkRDzv/S1D8Y9Yg==
X-Received: by 2002:a0c:b888:: with SMTP id y8-v6mr23729437qvf.203.1533136640724;
        Wed, 01 Aug 2018 08:17:20 -0700 (PDT)
Received: from localhost (216.49.36.201.res-cmts.bus.ptd.net. [216.49.36.201])
        by smtp.gmail.com with ESMTPSA id c93-v6sm17611210qkh.90.2018.08.01.08.17.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 Aug 2018 08:17:19 -0700 (PDT)
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
Subject: [PATCH 3/9] delayacct: track delays from thrashing cache pages
Date:   Wed,  1 Aug 2018 11:19:52 -0400
Message-Id: <20180801151958.32590-4-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801151958.32590-1-hannes@cmpxchg.org>
References: <20180801151958.32590-1-hannes@cmpxchg.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delay accounting already measures the time a task spends in direct
reclaim and waiting for swapin, but in low memory situations tasks
spend can spend a significant amount of their time waiting on
thrashing page cache. This isn't tracked right now.

To know the full impact of memory contention on an individual task,
measure the delay when waiting for a recently evicted active cache
page to read back into memory.

Also update tools/accounting/getdelays.c:

     [hannes@computer accounting]$ sudo ./getdelays -d -p 1
     print delayacct stats ON
     PID     1

     CPU             count     real total  virtual total    delay total  delay average
                     50318      745000000      847346785      400533713          0.008ms
     IO              count    delay total  delay average
                       435      122601218              0ms
     SWAP            count    delay total  delay average
                         0              0              0ms
     RECLAIM         count    delay total  delay average
                         0              0              0ms
     THRASHING       count    delay total  delay average
                        19       12621439              0ms

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 include/linux/delayacct.h      | 23 +++++++++++++++++++++++
 include/uapi/linux/taskstats.h |  6 +++++-
 kernel/delayacct.c             | 15 +++++++++++++++
 mm/filemap.c                   | 11 +++++++++++
 tools/accounting/getdelays.c   |  8 +++++++-
 5 files changed, 61 insertions(+), 2 deletions(-)

diff --git a/include/linux/delayacct.h b/include/linux/delayacct.h
index 5e335b6203f4..d3e75b3ba487 100644
--- a/include/linux/delayacct.h
+++ b/include/linux/delayacct.h
@@ -57,7 +57,12 @@ struct task_delay_info {
 
 	u64 freepages_start;
 	u64 freepages_delay;	/* wait for memory reclaim */
+
+	u64 thrashing_start;
+	u64 thrashing_delay;	/* wait for thrashing page */
+
 	u32 freepages_count;	/* total count of memory reclaim */
+	u32 thrashing_count;	/* total count of thrash waits */
 };
 #endif
 
@@ -76,6 +81,8 @@ extern int __delayacct_add_tsk(struct taskstats *, struct task_struct *);
 extern __u64 __delayacct_blkio_ticks(struct task_struct *);
 extern void __delayacct_freepages_start(void);
 extern void __delayacct_freepages_end(void);
+extern void __delayacct_thrashing_start(void);
+extern void __delayacct_thrashing_end(void);
 
 static inline int delayacct_is_task_waiting_on_io(struct task_struct *p)
 {
@@ -156,6 +163,18 @@ static inline void delayacct_freepages_end(void)
 		__delayacct_freepages_end();
 }
 
+static inline void delayacct_thrashing_start(void)
+{
+	if (current->delays)
+		__delayacct_thrashing_start();
+}
+
+static inline void delayacct_thrashing_end(void)
+{
+	if (current->delays)
+		__delayacct_thrashing_end();
+}
+
 #else
 static inline void delayacct_set_flag(int flag)
 {}
@@ -182,6 +201,10 @@ static inline void delayacct_freepages_start(void)
 {}
 static inline void delayacct_freepages_end(void)
 {}
+static inline void delayacct_thrashing_start(void)
+{}
+static inline void delayacct_thrashing_end(void)
+{}
 
 #endif /* CONFIG_TASK_DELAY_ACCT */
 
diff --git a/include/uapi/linux/taskstats.h b/include/uapi/linux/taskstats.h
index b7aa7bb2349f..5e8ca16a9079 100644
--- a/include/uapi/linux/taskstats.h
+++ b/include/uapi/linux/taskstats.h
@@ -34,7 +34,7 @@
  */
 
 
-#define TASKSTATS_VERSION	8
+#define TASKSTATS_VERSION	9
 #define TS_COMM_LEN		32	/* should be >= TASK_COMM_LEN
 					 * in linux/sched.h */
 
@@ -164,6 +164,10 @@ struct taskstats {
 	/* Delay waiting for memory reclaim */
 	__u64	freepages_count;
 	__u64	freepages_delay_total;
+
+	/* Delay waiting for thrashing page */
+	__u64	thrashing_count;
+	__u64	thrashing_delay_total;
 };
 
 
diff --git a/kernel/delayacct.c b/kernel/delayacct.c
index e2764d767f18..02ba745c448d 100644
--- a/kernel/delayacct.c
+++ b/kernel/delayacct.c
@@ -134,9 +134,12 @@ int __delayacct_add_tsk(struct taskstats *d, struct task_struct *tsk)
 	d->swapin_delay_total = (tmp < d->swapin_delay_total) ? 0 : tmp;
 	tmp = d->freepages_delay_total + tsk->delays->freepages_delay;
 	d->freepages_delay_total = (tmp < d->freepages_delay_total) ? 0 : tmp;
+	tmp = d->thrashing_delay_total + tsk->delays->thrashing_delay;
+	d->thrashing_delay_total = (tmp < d->thrashing_delay_total) ? 0 : tmp;
 	d->blkio_count += tsk->delays->blkio_count;
 	d->swapin_count += tsk->delays->swapin_count;
 	d->freepages_count += tsk->delays->freepages_count;
+	d->thrashing_count += tsk->delays->thrashing_count;
 	spin_unlock_irqrestore(&tsk->delays->lock, flags);
 
 	return 0;
@@ -168,3 +171,15 @@ void __delayacct_freepages_end(void)
 		&current->delays->freepages_count);
 }
 
+void __delayacct_thrashing_start(void)
+{
+	current->delays->thrashing_start = ktime_get_ns();
+}
+
+void __delayacct_thrashing_end(void)
+{
+	delayacct_end(&current->delays->lock,
+		      &current->delays->thrashing_start,
+		      &current->delays->thrashing_delay,
+		      &current->delays->thrashing_count);
+}
diff --git a/mm/filemap.c b/mm/filemap.c
index bd36b7226cf4..e49961e13dd9 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -36,6 +36,7 @@
 #include <linux/cleancache.h>
 #include <linux/shmem_fs.h>
 #include <linux/rmap.h>
+#include <linux/delayacct.h>
 #include "internal.h"
 
 #define CREATE_TRACE_POINTS
@@ -1073,8 +1074,15 @@ static inline int wait_on_page_bit_common(wait_queue_head_t *q,
 {
 	struct wait_page_queue wait_page;
 	wait_queue_entry_t *wait = &wait_page.wait;
+	bool thrashing = false;
 	int ret = 0;
 
+	if (bit_nr == PG_locked && !PageSwapBacked(page) &&
+	    !PageUptodate(page) && PageWorkingset(page)) {
+		delayacct_thrashing_start();
+		thrashing = true;
+	}
+
 	init_wait(wait);
 	wait->flags = lock ? WQ_FLAG_EXCLUSIVE : 0;
 	wait->func = wake_page_function;
@@ -1113,6 +1121,9 @@ static inline int wait_on_page_bit_common(wait_queue_head_t *q,
 
 	finish_wait(q, wait);
 
+	if (thrashing)
+		delayacct_thrashing_end();
+
 	/*
 	 * A signal could leave PageWaiters set. Clearing it here if
 	 * !waitqueue_active would be possible (by open-coding finish_wait),
diff --git a/tools/accounting/getdelays.c b/tools/accounting/getdelays.c
index 9f420d98b5fb..8cb504d30384 100644
--- a/tools/accounting/getdelays.c
+++ b/tools/accounting/getdelays.c
@@ -203,6 +203,8 @@ static void print_delayacct(struct taskstats *t)
 	       "SWAP  %15s%15s%15s\n"
 	       "      %15llu%15llu%15llums\n"
 	       "RECLAIM  %12s%15s%15s\n"
+	       "      %15llu%15llu%15llums\n"
+	       "THRASHING%12s%15s%15s\n"
 	       "      %15llu%15llu%15llums\n",
 	       "count", "real total", "virtual total",
 	       "delay total", "delay average",
@@ -222,7 +224,11 @@ static void print_delayacct(struct taskstats *t)
 	       "count", "delay total", "delay average",
 	       (unsigned long long)t->freepages_count,
 	       (unsigned long long)t->freepages_delay_total,
-	       average_ms(t->freepages_delay_total, t->freepages_count));
+	       average_ms(t->freepages_delay_total, t->freepages_count),
+	       "count", "delay total", "delay average",
+	       (unsigned long long)t->thrashing_count,
+	       (unsigned long long)t->thrashing_delay_total,
+	       average_ms(t->thrashing_delay_total, t->thrashing_count));
 }
 
 static void task_context_switch_counts(struct taskstats *t)
-- 
2.18.0


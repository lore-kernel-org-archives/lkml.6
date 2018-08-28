Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 359D8C43334
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 17:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE2E820897
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 17:23:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="rv6b+n5M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE2E820897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbeH1VQH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 17:16:07 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:41977 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727518AbeH1VQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 17:16:05 -0400
Received: by mail-yb0-f194.google.com with SMTP id z3-v6so894391ybm.8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 10:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rYqRJD/Nn/mjyDEIlHij4Nq2ZQJyQDLbJcRnxwRjma8=;
        b=rv6b+n5M5/s6153mcQJP8vb8uQTvc0ZkerEzMVY/d84AUjep2LMXmRZe1FWs1qjyXF
         s0y0Ha0UgpGEJTASxmj542o50DJGU1z1eH3au+YA4fExeolwZJJ5hJBuH4Tau6DKmtxx
         SB/JZUuFL9anXIHerqONyisv6lsGmSnn8vJfn9deTIyTgidwM+3hGJm/z0JA81qWhsLf
         4dQgA3HjMEuD/3l6gkLH4TFX8U1/eJUq+MNxqI91DS/OI9iF6jUKjBz/OpVN5l1ziDrn
         Kfirj7wk4y8q/udRMCGkLXNyJgUVZKh3tY/O/DLXkJkib73qxfeUKXRcAxGoSLAH2RbV
         hRgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rYqRJD/Nn/mjyDEIlHij4Nq2ZQJyQDLbJcRnxwRjma8=;
        b=V3q36fbXv1tgUH+HU62cGSqHT2c/viwM96U9A6gXaiZSxWLk77xfZ8Eu4iwJUf8MRw
         TJHn3X6RUyomRzb0nqpmHMhHHe+kkiJPgyJbZAEP/tGs2o1wyIC6oWNSmecmBoId7PpV
         61eWtmWC0MqfQyN1PVuD9sCOK1HpOBm9LZZ7pMtOsnuoE1/RjnYsZ92T14H7dgvJWOgV
         xXQlTMkhfqS45AT+oxbD06V+yj6DVcCFYCyeSjTNIwh/fcQdgL1BCVE9stcHCSTJZTiM
         yV3cawicDDDME0wSyykR7MBGlwYXrBrsN/p2mmODdTTLOoxoVig4MYkDXCs7HphfWYvH
         vf+g==
X-Gm-Message-State: APzg51Dhnu22PrQe2TmBlOV0POBvhbILBHOL9qFD0fhLJCe25GC5+e0W
        gywsYm6R3QpTjJD34g/NNw+pfg==
X-Google-Smtp-Source: ANB0VdYcmdWXjf09BCqTnjZc3KIcNh2/avH9YSJ2USJIxkxAPyEpIv0mY9KySK7FjbOWOTftW3VZAQ==
X-Received: by 2002:a25:103:: with SMTP id 3-v6mr1411840ybb.421.1535477005285;
        Tue, 28 Aug 2018 10:23:25 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::1:de86])
        by smtp.gmail.com with ESMTPSA id c126-v6sm1609448ywa.104.2018.08.28.10.23.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Aug 2018 10:23:24 -0700 (PDT)
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
Subject: [PATCH 3/9] delayacct: track delays from thrashing cache pages
Date:   Tue, 28 Aug 2018 13:22:52 -0400
Message-Id: <20180828172258.3185-4-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180828172258.3185-1-hannes@cmpxchg.org>
References: <20180828172258.3185-1-hannes@cmpxchg.org>
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
index 31c865d1842e..577d1b25fccd 100644
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
index ca8ac2824f0b..2a12b988c717 100644
--- a/kernel/delayacct.c
+++ b/kernel/delayacct.c
@@ -135,9 +135,12 @@ int __delayacct_add_tsk(struct taskstats *d, struct task_struct *tsk)
 	d->swapin_delay_total = (tmp < d->swapin_delay_total) ? 0 : tmp;
 	tmp = d->freepages_delay_total + tsk->delays->freepages_delay;
 	d->freepages_delay_total = (tmp < d->freepages_delay_total) ? 0 : tmp;
+	tmp = d->thrashing_delay_total + tsk->delays->thrashing_delay;
+	d->thrashing_delay_total = (tmp < d->thrashing_delay_total) ? 0 : tmp;
 	d->blkio_count += tsk->delays->blkio_count;
 	d->swapin_count += tsk->delays->swapin_count;
 	d->freepages_count += tsk->delays->freepages_count;
+	d->thrashing_count += tsk->delays->thrashing_count;
 	raw_spin_unlock_irqrestore(&tsk->delays->lock, flags);
 
 	return 0;
@@ -169,3 +172,15 @@ void __delayacct_freepages_end(void)
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
index 5e53424d9097..ca895ebe43ac 100644
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


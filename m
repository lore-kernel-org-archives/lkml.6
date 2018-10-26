Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 747C0C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 13:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21CA220848
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 13:18:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="svAoY/lu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21CA220848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbeJZVzI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 17:55:08 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43738 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbeJZVzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 17:55:07 -0400
Received: by mail-pl1-f196.google.com with SMTP id 30-v6so496165plb.10
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 06:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=R+S1HqQnXrQ1Wg+E1hCPeLJPIo1F/O1viXRvuP0KVmo=;
        b=svAoY/luXqTry0287uOco0L6fOVmY2dudSa+cE21G12/QGGQl5pgkbiPi56J0u2r0T
         HgJ4h9MelQzfPQEChtRayM/v5iKSKaGqK6qnZROHpGQwaWzc2DOolR5zrOsuDs4uKNVP
         FP41X3thx7IaU/2HaJSpod0KtMoXHRkBNylIU2sl0TNXzdMOE80VeyKbx/MXfD7wMALs
         LxDIUzHyyqWZdmzZlh96zdjE64MGzKpMEzsvlStvZHK3OAyK27c3Ex1xbv0qvynBwi5o
         ENUnt3mjQ/8QmwqAm5IzOA4c/kVHieJZ7+/Yv56/ZkvwbMmgwFRoWP5W6KpaWS21y+++
         +CeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=R+S1HqQnXrQ1Wg+E1hCPeLJPIo1F/O1viXRvuP0KVmo=;
        b=ooyDfeGuH4RC2k8b5LqSD1tdbie2ZppDoYNUTW3rIIOqFdW2H1wJiruP0zVrjwgHIh
         zF0BSTNS21RSxf8eVgfUNegShRPI1p1AsuCOo7LrVrbGJvUr/oQAuE8fNtNu4iirzG0w
         lo+hT0AgW593rkK3R5APb9P31xTF1hOLUIwtTiEzq+N+KYouxm+pUi2yexmuM5flJMQi
         FiTlfbKVyIY81yNyBOUiI76O4wkTzGOWsIuZB2NdClzTb595ccyJX5Zf9bNZqouRQC2v
         PL4irqPIhXW3h5rdYxyxM2JFFo+IjPnssATkogQyjgdmzHE+g90cSgPAcu0v8PibmwHH
         uUAQ==
X-Gm-Message-State: AGRZ1gKYdptUKzJb7FJjd06gijb/679tVPJLG7o8jOsJcxjqi1saZbU3
        kODv3MyspSqG0zFyOGjkBzQ=
X-Google-Smtp-Source: AJdET5f8QYgY93AgBFwETHfN7Ijz4G2Uk2lCjZZUgoCZWiZhdMspQzU+R6C8o6+CfEHstvp2T6OZjA==
X-Received: by 2002:a17:902:a50e:: with SMTP id s14-v6mr3522082plq.78.1540559883453;
        Fri, 26 Oct 2018 06:18:03 -0700 (PDT)
Received: from localhost.localdomain ([104.238.150.158])
        by smtp.gmail.com with ESMTPSA id e2-v6sm12935561pgv.25.2018.10.26.06.17.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 06:18:02 -0700 (PDT)
From:   Muchun Song <smuchun@gmail.com>
To:     mingo@kernel.org, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] sched/core: Introduce set_next_task() helper for better code readability
Date:   Fri, 26 Oct 2018 21:17:43 +0800
Message-Id: <20181026131743.21786-1-smuchun@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we pick the next task, we will do the following for the task:
  1) p->se.exec_start = rq_clock_task(rq);
  2) dequeue_pushable(_dl)_task(rq, p);

When we call set_curr_task(), we also need to do the same thing
above. In rt.c, the code at 1) is in the _pick_next_task_rt()
and the code at 2) is in the pick_next_task_rt(). If we put two
operations in one function, maybe better. So, we introduce a new
function set_next_task(), which is responsible for doing the above.

By introducing the function we can get rid of calling the
dequeue_pushable(_dl)_task() directly(We can call set_next_task())
in pick_next_task() and have better code readability and reuse.
In set_curr_task_rt(), we also can call set_next_task().

Do this things such that we end up with:

  static struct task_struct *pick_next_task(struct rq *rq,
  					    struct task_struct *prev,
  					    struct rq_flags *rf)
  {
  	/* do something else ... */

  	put_prev_task(rq, prev);

  	/* pick next task p */

  	set_next_task(rq, p);

  	/* do something else ... */
  }

put_prev_task() can match set_next_task(), which can make the
code more readable.

Signed-off-by: Muchun Song <smuchun@gmail.com>
---
 kernel/sched/deadline.c | 19 ++++++++++---------
 kernel/sched/rt.c       | 24 +++++++++++-------------
 2 files changed, 21 insertions(+), 22 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 91e4202b0634..470ba6b464fe 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1695,6 +1695,14 @@ static void start_hrtick_dl(struct rq *rq, struct task_struct *p)
 }
 #endif
 
+static inline void set_next_task(struct rq *rq, struct task_struct *p)
+{
+	p->se.exec_start = rq_clock_task(rq);
+
+	/* You can't push away the running task */
+	dequeue_pushable_dl_task(rq, p);
+}
+
 static struct sched_dl_entity *pick_next_dl_entity(struct rq *rq,
 						   struct dl_rq *dl_rq)
 {
@@ -1750,10 +1758,8 @@ pick_next_task_dl(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	BUG_ON(!dl_se);
 
 	p = dl_task_of(dl_se);
-	p->se.exec_start = rq_clock_task(rq);
 
-	/* Running task will never be pushed. */
-       dequeue_pushable_dl_task(rq, p);
+	set_next_task(rq, p);
 
 	if (hrtick_enabled(rq))
 		start_hrtick_dl(rq, p);
@@ -1808,12 +1814,7 @@ static void task_fork_dl(struct task_struct *p)
 
 static void set_curr_task_dl(struct rq *rq)
 {
-	struct task_struct *p = rq->curr;
-
-	p->se.exec_start = rq_clock_task(rq);
-
-	/* You can't push away the running task */
-	dequeue_pushable_dl_task(rq, p);
+	set_next_task(rq, rq->curr);
 }
 
 #ifdef CONFIG_SMP
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 2e2955a8cf8f..5dee426a9f24 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1498,6 +1498,14 @@ static void check_preempt_curr_rt(struct rq *rq, struct task_struct *p, int flag
 #endif
 }
 
+static inline void set_next_task(struct rq *rq, struct task_struct *p)
+{
+	p->se.exec_start = rq_clock_task(rq);
+
+	/* The running task is never eligible for pushing */
+	dequeue_pushable_task(rq, p);
+}
+
 static struct sched_rt_entity *pick_next_rt_entity(struct rq *rq,
 						   struct rt_rq *rt_rq)
 {
@@ -1518,7 +1526,6 @@ static struct sched_rt_entity *pick_next_rt_entity(struct rq *rq,
 static struct task_struct *_pick_next_task_rt(struct rq *rq)
 {
 	struct sched_rt_entity *rt_se;
-	struct task_struct *p;
 	struct rt_rq *rt_rq  = &rq->rt;
 
 	do {
@@ -1527,10 +1534,7 @@ static struct task_struct *_pick_next_task_rt(struct rq *rq)
 		rt_rq = group_rt_rq(rt_se);
 	} while (rt_rq);
 
-	p = rt_task_of(rt_se);
-	p->se.exec_start = rq_clock_task(rq);
-
-	return p;
+	return rt_task_of(rt_se);
 }
 
 static struct task_struct *
@@ -1573,8 +1577,7 @@ pick_next_task_rt(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 
 	p = _pick_next_task_rt(rq);
 
-	/* The running task is never eligible for pushing */
-	dequeue_pushable_task(rq, p);
+	set_next_task(rq, p);
 
 	rt_queue_push_tasks(rq);
 
@@ -2355,12 +2358,7 @@ static void task_tick_rt(struct rq *rq, struct task_struct *p, int queued)
 
 static void set_curr_task_rt(struct rq *rq)
 {
-	struct task_struct *p = rq->curr;
-
-	p->se.exec_start = rq_clock_task(rq);
-
-	/* The running task is never eligible for pushing */
-	dequeue_pushable_task(rq, p);
+	set_next_task(rq, rq->curr);
 }
 
 static unsigned int get_rr_interval_rt(struct rq *rq, struct task_struct *task)
-- 
2.17.1


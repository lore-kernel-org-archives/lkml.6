Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 331D7C0044C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 10:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E45D720883
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 10:07:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=austad-us.20150623.gappssmtp.com header.i=@austad-us.20150623.gappssmtp.com header.b="L/PaauLg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E45D720883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=austad.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbeKITrt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 14:47:49 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42976 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727702AbeKITrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 14:47:48 -0500
Received: by mail-lf1-f68.google.com with SMTP id q6-v6so898714lfh.9
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 02:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=austad-us.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NzUpbpt5uUD/V2avclLhcnVn21lHeoeOctiQEWsrDJo=;
        b=L/PaauLgJE4hHzlxaajSK/VD2JBSREI8zN/rEuW0H5ihYOZSPrFaXqi93q4JjB59HY
         ylzqJcjfuXPiznfPplCAUsV+ClB25BllSIC2uP/xdr4vflWHbKhkwj1t1TZbjJZ3A6Wi
         cgoZAg703NXAE6o6PDuQTUOeMi4+cBmYkHCPqS0oGFujm2wIThot71PO1mNbBFaonHGo
         XG9rZrAr6nXwA9Z9ZfDuo8RMIA6oYr3WAk0QnZqHv31+T49yyHLLHoH21+7kG/vyw4TC
         L78a03JJ2CnDoHVw2lhGEuRh9dtQFLtfu7/XxX0RDFYBVJVAyoVemXPsP48ZnRcCfASZ
         kIFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NzUpbpt5uUD/V2avclLhcnVn21lHeoeOctiQEWsrDJo=;
        b=QANyxI4GOoyp9mshzVhvxcharyG8sX08ShG1lxQyS6TOEsTzO9ilP2pDXUDzzQnrdQ
         lo7aWEkPhZJ+6w5bFlF7xXqrsZKNx+Kqz666G62SVN8doOBMqMpYfL0FQ9O2llUC5LkF
         iv+ftF21IT7ptOYXj5pRok5PxAVOEwWunoXd5unBznTnw3iScixEkH61XTuEiQAJC1rj
         zD4gCJxGdlFOGQV/utGLRqXrSNHE1oQ8PbH+kiMVBRUzo6v1305nYvwn0Bi7V+KCGto3
         SXO649onU66cB5OOyxmp56vBog0VzQuFrk8ZD9+XCER6SWCWTdlGDgYacoqpPmh4h2by
         fAWg==
X-Gm-Message-State: AGRZ1gKQWL1ruJJBSf3qLni8UYcFZtLX75NyQm4SpPdsWBp1jDwS91NB
        RxQxi48pglN7KPk3fGKDUlPuBQfAbCDtOeqv
X-Google-Smtp-Source: AJdET5fg5yX76pgAyGFGepfY+fnRDaSB+Zdqd6CsmqUC2wEA96kk4o3PiDmrbi+L1UwyU8nd7dUBnA==
X-Received: by 2002:a19:3b9c:: with SMTP id d28mr5252866lfl.30.1541758073268;
        Fri, 09 Nov 2018 02:07:53 -0800 (PST)
Received: from sisyphus.home.austad.us (11.92-220-88.customer.lyse.net. [92.220.88.11])
        by smtp.gmail.com with ESMTPSA id u65sm1265576lff.54.2018.11.09.02.07.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 09 Nov 2018 02:07:52 -0800 (PST)
From:   Henrik Austad <henrik@austad.us>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Henrik Austad <haustad@cisco.com>,
        Peter Zijlstra <peterz@infradead.org>, juri.lelli@arm.com,
        bigeasy@linutronix.de, xlpang@redhat.com, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jdesfossez@efficios.com,
        dvhart@infradead.org, bristot@redhat.com,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 01/17] futex: Cleanup variable names for futex_top_waiter()
Date:   Fri,  9 Nov 2018 11:07:29 +0100
Message-Id: <1541758065-10952-2-git-send-email-henrik@austad.us>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541758065-10952-1-git-send-email-henrik@austad.us>
References: <1541758065-10952-1-git-send-email-henrik@austad.us>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

commit 499f5aca2cdd5e958b27e2655e7e7f82524f46b1 uptream.

futex_top_waiter() returns the top-waiter on the pi_mutex. Assinging
this to a variable 'match' totally obscures the code.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: juri.lelli@arm.com
Cc: bigeasy@linutronix.de
Cc: xlpang@redhat.com
Cc: rostedt@goodmis.org
Cc: mathieu.desnoyers@efficios.com
Cc: jdesfossez@efficios.com
Cc: dvhart@infradead.org
Cc: bristot@redhat.com
Link: http://lkml.kernel.org/r/20170322104151.554710645@infradead.org
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Henrik Austad <haustad@cisco.com>
---
 kernel/futex.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index a26d217..bb87324 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -1116,14 +1116,14 @@ static int attach_to_pi_owner(u32 uval, union futex_key *key,
 static int lookup_pi_state(u32 uval, struct futex_hash_bucket *hb,
 			   union futex_key *key, struct futex_pi_state **ps)
 {
-	struct futex_q *match = futex_top_waiter(hb, key);
+	struct futex_q *top_waiter = futex_top_waiter(hb, key);
 
 	/*
 	 * If there is a waiter on that futex, validate it and
 	 * attach to the pi_state when the validation succeeds.
 	 */
-	if (match)
-		return attach_to_pi_state(uval, match->pi_state, ps);
+	if (top_waiter)
+		return attach_to_pi_state(uval, top_waiter->pi_state, ps);
 
 	/*
 	 * We are the first waiter - try to look up the owner based on
@@ -1170,7 +1170,7 @@ static int futex_lock_pi_atomic(u32 __user *uaddr, struct futex_hash_bucket *hb,
 				struct task_struct *task, int set_waiters)
 {
 	u32 uval, newval, vpid = task_pid_vnr(task);
-	struct futex_q *match;
+	struct futex_q *top_waiter;
 	int ret;
 
 	/*
@@ -1196,9 +1196,9 @@ static int futex_lock_pi_atomic(u32 __user *uaddr, struct futex_hash_bucket *hb,
 	 * Lookup existing state first. If it exists, try to attach to
 	 * its pi_state.
 	 */
-	match = futex_top_waiter(hb, key);
-	if (match)
-		return attach_to_pi_state(uval, match->pi_state, ps);
+	top_waiter = futex_top_waiter(hb, key);
+	if (top_waiter)
+		return attach_to_pi_state(uval, top_waiter->pi_state, ps);
 
 	/*
 	 * No waiter and user TID is 0. We are here because the
@@ -1288,11 +1288,11 @@ static void mark_wake_futex(struct wake_q_head *wake_q, struct futex_q *q)
 	q->lock_ptr = NULL;
 }
 
-static int wake_futex_pi(u32 __user *uaddr, u32 uval, struct futex_q *this,
+static int wake_futex_pi(u32 __user *uaddr, u32 uval, struct futex_q *top_waiter,
 			 struct futex_hash_bucket *hb)
 {
 	struct task_struct *new_owner;
-	struct futex_pi_state *pi_state = this->pi_state;
+	struct futex_pi_state *pi_state = top_waiter->pi_state;
 	u32 uninitialized_var(curval), newval;
 	WAKE_Q(wake_q);
 	bool deboost;
@@ -1313,11 +1313,11 @@ static int wake_futex_pi(u32 __user *uaddr, u32 uval, struct futex_q *this,
 
 	/*
 	 * It is possible that the next waiter (the one that brought
-	 * this owner to the kernel) timed out and is no longer
+	 * top_waiter owner to the kernel) timed out and is no longer
 	 * waiting on the lock.
 	 */
 	if (!new_owner)
-		new_owner = this->task;
+		new_owner = top_waiter->task;
 
 	/*
 	 * We pass it to the next owner. The WAITERS bit is always
@@ -2639,7 +2639,7 @@ static int futex_unlock_pi(u32 __user *uaddr, unsigned int flags)
 	u32 uninitialized_var(curval), uval, vpid = task_pid_vnr(current);
 	union futex_key key = FUTEX_KEY_INIT;
 	struct futex_hash_bucket *hb;
-	struct futex_q *match;
+	struct futex_q *top_waiter;
 	int ret;
 
 retry:
@@ -2663,9 +2663,9 @@ retry:
 	 * all and we at least want to know if user space fiddled
 	 * with the futex value instead of blindly unlocking.
 	 */
-	match = futex_top_waiter(hb, &key);
-	if (match) {
-		ret = wake_futex_pi(uaddr, uval, match, hb);
+	top_waiter = futex_top_waiter(hb, &key);
+	if (top_waiter) {
+		ret = wake_futex_pi(uaddr, uval, top_waiter, hb);
 		/*
 		 * In case of success wake_futex_pi dropped the hash
 		 * bucket lock.
-- 
2.7.4


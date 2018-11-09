Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1395CC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 10:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6E0C20840
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 10:08:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=austad-us.20150623.gappssmtp.com header.i=@austad-us.20150623.gappssmtp.com header.b="NW3nRPkR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6E0C20840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=austad.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbeKITsB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 14:48:01 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41496 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728161AbeKITr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 14:47:58 -0500
Received: by mail-lj1-f194.google.com with SMTP id z80-v6so1091206ljb.8
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 02:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=austad-us.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tv7acVUEo4rKciCVBEpY1ORnv58bUw3RANmrX4luI34=;
        b=NW3nRPkRsXOrGfpu8yVhX9Jw4IYH0LlfPEX4tVETUc9WmciqhaktdDO9j3Yu7uPPVG
         aSQUsnUDf7SQjLle7YbpqHZkZjFh7js92D72iTRdYiZH3DuHDN4WTRTjlv8WoYMEuVM3
         PJtpIvGoMiTQhA97TVEIBdmYhegRyxFGczXsjq0MdQV9wgSIhyzcjJxujldMfElbIZuv
         aAfTh7LzklCHL9IRKk2PP8HdKf/bDuGW97jK5GUQ2lt4qCSq0YsoKxVG+PNlYqj3nIHo
         eRxJhOvXlJidBAD2xZ6zCIOCrOSuJtZRnWjwO4qmFbMwbj3wAs8DFaenuAN+k5VpRDVq
         vNcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tv7acVUEo4rKciCVBEpY1ORnv58bUw3RANmrX4luI34=;
        b=dolEZ5+l1/ohdaHOvlxvloFNcL1ZLZHg5+P9/lqnd8Lg4aoyeDg0xEAjPqhBTudQaM
         wAgTmNwrl2bH/1+p3qp6tZXUJQ8+OON4fuFsWsJak4ERVP1Rcvv20jUCf5KX7+hXfXzr
         XR6zTavYshLvBx9YrmkNAGFFxPTR5PcDgE8s/OPNkZs2cHdr2KfrVMLe6I2w+9pRfENr
         6yiciDgTDE78GIa1RRFOghiJ7AiWbcx7HuWta3y+Glz+2fbSOpVH20HDhZ+/gey4W5dM
         y9fFNrYxqYILEzxR1hqmBKqRo39D5yJAdU97EooBnGvHl+mWJwBiDuQt3oTqMFfx3N3C
         TirQ==
X-Gm-Message-State: AGRZ1gJmi5sBvxvPpewzwqO86a1VGOSxpYcncqJDl31yWrgT2Dknb69o
        IwxulKVVcUOHyeI5asL8wfC7NYmX66xgrANZ
X-Google-Smtp-Source: AJdET5c9bIwIzvJkkp+I6gqyRFETm44PrAcC9OzRaIMow2ZiUr/lNON05RENol/41luunmBkiDxIyQ==
X-Received: by 2002:a2e:8045:: with SMTP id p5-v6mr5061333ljg.87.1541758082944;
        Fri, 09 Nov 2018 02:08:02 -0800 (PST)
Received: from sisyphus.home.austad.us (11.92-220-88.customer.lyse.net. [92.220.88.11])
        by smtp.gmail.com with ESMTPSA id u65sm1265576lff.54.2018.11.09.02.08.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 09 Nov 2018 02:08:02 -0800 (PST)
From:   Henrik Austad <henrik@austad.us>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Henrik Austad <haustad@cisco.com>,
        Peter Zijlstra <peterz@infradead.org>, juri.lelli@arm.com,
        bigeasy@linutronix.de, xlpang@redhat.com, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jdesfossez@efficios.com,
        dvhart@infradead.org, bristot@redhat.com,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 08/17] futex: Rework inconsistent rt_mutex/futex_q state
Date:   Fri,  9 Nov 2018 11:07:36 +0100
Message-Id: <1541758065-10952-9-git-send-email-henrik@austad.us>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541758065-10952-1-git-send-email-henrik@austad.us>
References: <1541758065-10952-1-git-send-email-henrik@austad.us>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

commit 73d786bd043ebc855f349c81ea805f6b11cbf2aa upstream.

There is a weird state in the futex_unlock_pi() path when it interleaves
with a concurrent futex_lock_pi() at the point where it drops hb->lock.

In this case, it can happen that the rt_mutex wait_list and the futex_q
disagree on pending waiters, in particular rt_mutex will find no pending
waiters where futex_q thinks there are. In this case the rt_mutex unlock
code cannot assign an owner.

The futex side fixup code has to cleanup the inconsistencies with quite a
bunch of interesting corner cases.

Simplify all this by changing wake_futex_pi() to return -EAGAIN when this
situation occurs. This then gives the futex_lock_pi() code the opportunity
to continue and the retried futex_unlock_pi() will now observe a coherent
state.

The only problem is that this breaks RT timeliness guarantees. That
is, consider the following scenario:

  T1 and T2 are both pinned to CPU0. prio(T2) > prio(T1)

    CPU0

    T1
      lock_pi()
      queue_me()  <- Waiter is visible

    preemption

    T2
      unlock_pi()
	loops with -EAGAIN forever

Which is undesirable for PI primitives. Future patches will rectify
this.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: juri.lelli@arm.com
Cc: bigeasy@linutronix.de
Cc: xlpang@redhat.com
Cc: rostedt@goodmis.org
Cc: mathieu.desnoyers@efficios.com
Cc: jdesfossez@efficios.com
Cc: dvhart@infradead.org
Cc: bristot@redhat.com
Link: http://lkml.kernel.org/r/20170322104151.850383690@infradead.org
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Henrik Austad <haustad@cisco.com>
---
 kernel/futex.c | 50 ++++++++++++++------------------------------------
 1 file changed, 14 insertions(+), 36 deletions(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index 9d7d462..91acb65 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -1398,12 +1398,19 @@ static int wake_futex_pi(u32 __user *uaddr, u32 uval, struct futex_q *top_waiter
 	new_owner = rt_mutex_next_owner(&pi_state->pi_mutex);
 
 	/*
-	 * It is possible that the next waiter (the one that brought
-	 * top_waiter owner to the kernel) timed out and is no longer
-	 * waiting on the lock.
+	 * When we interleave with futex_lock_pi() where it does
+	 * rt_mutex_timed_futex_lock(), we might observe @this futex_q waiter,
+	 * but the rt_mutex's wait_list can be empty (either still, or again,
+	 * depending on which side we land).
+	 *
+	 * When this happens, give up our locks and try again, giving the
+	 * futex_lock_pi() instance time to complete, either by waiting on the
+	 * rtmutex or removing itself from the futex queue.
 	 */
-	if (!new_owner)
-		new_owner = top_waiter->task;
+	if (!new_owner) {
+		raw_spin_unlock_irq(&pi_state->pi_mutex.wait_lock);
+		return -EAGAIN;
+	}
 
 	/*
 	 * We pass it to the next owner. The WAITERS bit is always
@@ -2342,7 +2349,6 @@ static long futex_wait_restart(struct restart_block *restart);
  */
 static int fixup_owner(u32 __user *uaddr, struct futex_q *q, int locked)
 {
-	struct task_struct *owner;
 	int ret = 0;
 
 	if (locked) {
@@ -2356,43 +2362,15 @@ static int fixup_owner(u32 __user *uaddr, struct futex_q *q, int locked)
 	}
 
 	/*
-	 * Catch the rare case, where the lock was released when we were on the
-	 * way back before we locked the hash bucket.
-	 */
-	if (q->pi_state->owner == current) {
-		/*
-		 * Try to get the rt_mutex now. This might fail as some other
-		 * task acquired the rt_mutex after we removed ourself from the
-		 * rt_mutex waiters list.
-		 */
-		if (rt_mutex_futex_trylock(&q->pi_state->pi_mutex)) {
-			locked = 1;
-			goto out;
-		}
-
-		/*
-		 * pi_state is incorrect, some other task did a lock steal and
-		 * we returned due to timeout or signal without taking the
-		 * rt_mutex. Too late.
-		 */
-		raw_spin_lock_irq(&q->pi_state->pi_mutex.wait_lock);
-		owner = rt_mutex_owner(&q->pi_state->pi_mutex);
-		if (!owner)
-			owner = rt_mutex_next_owner(&q->pi_state->pi_mutex);
-		raw_spin_unlock_irq(&q->pi_state->pi_mutex.wait_lock);
-		ret = fixup_pi_state_owner(uaddr, q, owner);
-		goto out;
-	}
-
-	/*
 	 * Paranoia check. If we did not take the lock, then we should not be
 	 * the owner of the rt_mutex.
 	 */
-	if (rt_mutex_owner(&q->pi_state->pi_mutex) == current)
+	if (rt_mutex_owner(&q->pi_state->pi_mutex) == current) {
 		printk(KERN_ERR "fixup_owner: ret = %d pi-mutex: %p "
 				"pi-state %p\n", ret,
 				q->pi_state->pi_mutex.owner,
 				q->pi_state->owner);
+	}
 
 out:
 	return ret ? ret : locked;
-- 
2.7.4


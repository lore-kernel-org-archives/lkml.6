Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8027C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 00:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56C282174B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 00:29:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="O3Q43lm1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56C282174B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=android.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731081AbeHNDNy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 23:13:54 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44347 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730178AbeHNDNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 23:13:54 -0400
Received: by mail-pf1-f194.google.com with SMTP id k21-v6so8412861pff.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 17:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2OO14lwqoc4McfzUj1Payzd2TjB/L1x/XYYQ9yi3FXQ=;
        b=O3Q43lm1U2RYTL8Ulb2mFVKGkthhfJSSa90X+sTchCA59aoiD9d8NQNfdudgIoqk0/
         8mHz/Y0dejxn9joRTRvsvDr4nxaUktIDzW/l8KByQG9e+kzH2DK0HstSmpNPKXBA8Acy
         Cep2vPE6hkidMgPXVHg9GsITPwZ+YuvkyI/B/b6t2NNpimnm7cw2kIvAhDo0Ix/EmDVD
         2G7Zk6eRAx3M9NXrIWk3E3mG/m6xMhiW4JYfGV5lluYCacAi0gDrKw71Lc9P5C2G91Dr
         Ahr/gjmz6oscmxp+TReq37IBdrK5eybi5cILoa9aChD/Gdyyf1O+3IKnMPoPL/gg6z+x
         kxfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2OO14lwqoc4McfzUj1Payzd2TjB/L1x/XYYQ9yi3FXQ=;
        b=sQu04Sdwwtzeh+JInFwufFfIJ4V37P5d+7Zur4ROoaeLsNIgLgaXs9bU+KXd0sFD2h
         Vz1KHXEXkkWUAKGdbR0m3shPBy4sikYndUbUO774xwNQFDzfT/p+TAl9Pr7GETtPwSrY
         zNNivPFGan66GZgx4+fYt0KUBqYAWnUpZ01VU8AlL6+4Wx2W6XyHVhAb+OjREDT4BrKd
         eAC0AV8X2IXLwqBwNv2v2DYEm4IYCCtOzdkDlmLHtL/5fwNuYwrvUoOjwJ6RYPuaYdYH
         Fzd+MPPF5BFqFlazHnN3GxyjwJmhMR09OE1P6LDTeLpLjZpjFk9z6HSgBOn+k0cMUmr8
         VtdA==
X-Gm-Message-State: AOUpUlHucCZmiJ+Jdh4kIlRbq7IobKlzL3CvVatNCeqBdsPNRfuOap53
        nsE4peWZsdvxGiNgw+KmVbrLH0x3xCknvg==
X-Google-Smtp-Source: AA+uWPxCsfjAbEVFzwRvChMHTFAzBnumueUIA5e+KlH9U/9yTwkVPmXWaaTi2gcLmqKRpRdcPE2uIA==
X-Received: by 2002:a63:714a:: with SMTP id b10-v6mr18356606pgn.73.1534206555525;
        Mon, 13 Aug 2018 17:29:15 -0700 (PDT)
Received: from sherryy.mtv.corp.google.com ([2620:0:1000:1410:cb60:7ce4:78f:ebbc])
        by smtp.gmail.com with ESMTPSA id i1-v6sm25472914pgj.38.2018.08.13.17.29.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 17:29:14 -0700 (PDT)
From:   Sherry Yang <sherryy@android.com>
To:     linux-kernel@vger.kernel.org
Cc:     tkjos@google.com, maco@google.com,
        Sherry Yang <sherryy@android.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        devel@driverdev.osuosl.org (open list:ANDROID DRIVERS)
Subject: [PATCH] android: binder: no outgoing transaction when thread todo has transaction
Date:   Mon, 13 Aug 2018 17:28:53 -0700
Message-Id: <20180814002853.53690-1-sherryy@android.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a process dies, failed reply is sent to the sender of any transaction
queued on a dead thread's todo list. The sender asserts that the
received failed reply corresponds to the head of the transaction stack.
This assert can fail if the dead thread is allowed to send outgoing
transactions when there is already a transaction on its todo list,
because this new transaction can end up on the transaction stack of the
original sender. The following steps illustrate how this assertion can
fail.

1. Thread1 sends txn19 to Thread2
   (T1->transaction_stack=txn19, T2->todo+=txn19)
2. Without processing todo list, Thread2 sends txn20 to Thread1
   (T1->todo+=txn20, T2->transaction_stack=txn20)
3. T1 processes txn20 on its todo list
   (T1->transaction_stack=txn20->txn19, T1->todo=<empty>)
4. T2 dies, T2->todo cleanup attempts to send failed reply for txn19, but
   T1->transaction_stack points to txn20 -- assertion failes

Step 2. is the incorrect behavior. When there is a transaction on a
thread's todo list, this thread should not be able to send any outgoing
synchronous transactions. Only the head of the todo list needs to be
checked because only threads that are waiting for proc work can directly
receive work from another thread, and no work is allowed to be queued
on such a thread without waking up the thread. This patch also enforces
that a thread is not waiting for proc work when a work is directly
enqueued to its todo list.

Acked-by: Arve Hjønnevåg <arve@android.com>
Signed-off-by: Sherry Yang <sherryy@android.com>
---
 drivers/android/binder.c | 44 +++++++++++++++++++++++++++++-----------
 1 file changed, 32 insertions(+), 12 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index d58763b6b009..f2081934eb8b 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -822,6 +822,7 @@ static void
 binder_enqueue_deferred_thread_work_ilocked(struct binder_thread *thread,
 					    struct binder_work *work)
 {
+	WARN_ON(!list_empty(&thread->waiting_thread_node));
 	binder_enqueue_work_ilocked(work, &thread->todo);
 }
 
@@ -839,6 +840,7 @@ static void
 binder_enqueue_thread_work_ilocked(struct binder_thread *thread,
 				   struct binder_work *work)
 {
+	WARN_ON(!list_empty(&thread->waiting_thread_node));
 	binder_enqueue_work_ilocked(work, &thread->todo);
 	thread->process_todo = true;
 }
@@ -1270,19 +1272,12 @@ static int binder_inc_node_nilocked(struct binder_node *node, int strong,
 		} else
 			node->local_strong_refs++;
 		if (!node->has_strong_ref && target_list) {
+			struct binder_thread *thread = container_of(target_list,
+						    struct binder_thread, todo);
 			binder_dequeue_work_ilocked(&node->work);
-			/*
-			 * Note: this function is the only place where we queue
-			 * directly to a thread->todo without using the
-			 * corresponding binder_enqueue_thread_work() helper
-			 * functions; in this case it's ok to not set the
-			 * process_todo flag, since we know this node work will
-			 * always be followed by other work that starts queue
-			 * processing: in case of synchronous transactions, a
-			 * BR_REPLY or BR_ERROR; in case of oneway
-			 * transactions, a BR_TRANSACTION_COMPLETE.
-			 */
-			binder_enqueue_work_ilocked(&node->work, target_list);
+			BUG_ON(&thread->todo != target_list);
+			binder_enqueue_deferred_thread_work_ilocked(thread,
+								   &node->work);
 		}
 	} else {
 		if (!internal)
@@ -2723,6 +2718,7 @@ static void binder_transaction(struct binder_proc *proc,
 {
 	int ret;
 	struct binder_transaction *t;
+	struct binder_work *w;
 	struct binder_work *tcomplete;
 	binder_size_t *offp, *off_end, *off_start;
 	binder_size_t off_min;
@@ -2864,6 +2860,29 @@ static void binder_transaction(struct binder_proc *proc,
 			goto err_invalid_target_handle;
 		}
 		binder_inner_proc_lock(proc);
+
+		w = list_first_entry_or_null(&thread->todo,
+					     struct binder_work, entry);
+		if (!(tr->flags & TF_ONE_WAY) && w &&
+		    w->type == BINDER_WORK_TRANSACTION) {
+			/*
+			 * Do not allow new outgoing transaction from a
+			 * thread that has a transaction at the head of
+			 * its todo list. Only need to check the head
+			 * because binder_select_thread_ilocked picks a
+			 * thread from proc->waiting_threads to enqueue
+			 * the transaction, and nothing is queued to the
+			 * todo list while the thread is on waiting_threads.
+			 */
+			binder_user_error("%d:%d new transaction not allowed when there is a transaction on thread todo\n",
+					  proc->pid, thread->pid);
+			binder_inner_proc_unlock(proc);
+			return_error = BR_FAILED_REPLY;
+			return_error_param = -EPROTO;
+			return_error_line = __LINE__;
+			goto err_bad_todo_list;
+		}
+
 		if (!(tr->flags & TF_ONE_WAY) && thread->transaction_stack) {
 			struct binder_transaction *tmp;
 
@@ -3247,6 +3266,7 @@ static void binder_transaction(struct binder_proc *proc,
 	kfree(t);
 	binder_stats_deleted(BINDER_STAT_TRANSACTION);
 err_alloc_t_failed:
+err_bad_todo_list:
 err_bad_call_stack:
 err_empty_call_stack:
 err_dead_binder:
-- 
2.18.0.597.ga71716f1ad-goog


Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B81AC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 20:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E94362082F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 20:26:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="PzR+66SG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E94362082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=android.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726003AbeLCU0I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 15:26:08 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37755 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbeLCU0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 15:26:08 -0500
Received: by mail-pl1-f195.google.com with SMTP id b5so7047892plr.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 12:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x1XY4BjWxxiH8rvheHX9G+gMIGFbmNlTPOSK/soDkFk=;
        b=PzR+66SGsYkW7zECxtAlN67QRmKw9sBXnsUKZCMHWsDPbOYJjERTwazRrxbIFQc5Fb
         yL5B3EW/c2dzfrIVNCf/jBlotKyzKmKkeguI+kUW62KOBz/mWuxz03WKSvEMR9BKDARO
         qxbgT6OSohUbnEMIQ4yLRps8E49Lsr40Dnrhc1OsMiccZr612lKRgjggTxAt18Dl++/Q
         /IP+/l2Vd6GNd2scLsSUelXK6Ko4BkLCAl1qE3c0/G07SehH5c4KWyS11X7/u0LJlQLZ
         3HXZKps9BPizUHcpPuZTtBqguUctvNAWAhngSOYAPVKUOsqCl5lFrevdq2imScmRm/h2
         eiag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x1XY4BjWxxiH8rvheHX9G+gMIGFbmNlTPOSK/soDkFk=;
        b=s7sXQuhSji+0+ZH8dtEfaO+mpb5vIh9gQ90PMC+q6ddgI2tI7UIfBLvwT1z3bi06bL
         UWkSO1wIOIODVJQOc0aeLnhCLcN7eQBpzwJbBJXht0b9bQ+I5GUMpRj095/WAbm8OIvC
         4mzaWPgfzk5uzzq86KcTBmdQYN2PH5KeGtXtfPF41Dg/eV/vjY6zHh3JWfMPK3BCIGCo
         ES3SrrX4vn8IBAQJjwdCwJ1UT0S7eEJWtzIVLgV51zcdNohLm0a/73cpkb4jd4HjMqF7
         N1BxTZ6QT/73a1NdisTYgqLXcSVwyQZgR/KacsSaBrgWs/rMZuqzs26aDcUHRkUv6HA1
         nrVQ==
X-Gm-Message-State: AA+aEWblyW9pecR5MOXZ4E9GNaCFpMhLdBQT6HYxvNM8KwNHM6SkIFtb
        HvaUxDe8sUJVGFw/FIIo22Fn/r4dmS4QTw==
X-Google-Smtp-Source: AFSGD/U+d1uBkQYXgX5VEO56zZMwhwzNwuuj8+y7Q1PP16c39+cTSYnK3s+8DP2C1OMoTrCf2imsKQ==
X-Received: by 2002:a17:902:bd92:: with SMTP id q18mr17457504pls.167.1543868766214;
        Mon, 03 Dec 2018 12:26:06 -0800 (PST)
Received: from ava-linux2.mtv.corp.google.com ([2620:0:1000:1601:6cc0:d41d:b970:fd7])
        by smtp.googlemail.com with ESMTPSA id q7sm16562725pgp.40.2018.12.03.12.26.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 12:26:05 -0800 (PST)
From:   Todd Kjos <tkjos@android.com>
X-Google-Original-From: Todd Kjos <tkjos@google.com>
To:     tkjos@google.com, gregkh@linuxfoundation.org, arve@android.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        maco@google.com, joel@joelfernandes.org
Cc:     kernel-team@android.com
Subject: [PATCH] binder: fix sparse warnings on locking context
Date:   Mon,  3 Dec 2018 12:24:54 -0800
Message-Id: <20181203202457.228972-1-tkjos@google.com>
X-Mailer: git-send-email 2.20.0.rc1.387.gf8505762e3-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add __acquire()/__release() annnotations to fix warnings
in sparse context checking

There is one case where the warning was due to a lack of
a "default:" case in a switch statement where a lock was
being released in each of the cases, so the default
case was added.

Signed-off-by: Todd Kjos <tkjos@google.com>
---
 drivers/android/binder.c       | 43 +++++++++++++++++++++++++++++++++-
 drivers/android/binder_alloc.c |  1 +
 2 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 9f1000d2a40c7..9f2059d24ae2d 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -660,6 +660,7 @@ struct binder_transaction {
 #define binder_proc_lock(proc) _binder_proc_lock(proc, __LINE__)
 static void
 _binder_proc_lock(struct binder_proc *proc, int line)
+	__acquires(&proc->outer_lock)
 {
 	binder_debug(BINDER_DEBUG_SPINLOCKS,
 		     "%s: line=%d\n", __func__, line);
@@ -675,6 +676,7 @@ _binder_proc_lock(struct binder_proc *proc, int line)
 #define binder_proc_unlock(_proc) _binder_proc_unlock(_proc, __LINE__)
 static void
 _binder_proc_unlock(struct binder_proc *proc, int line)
+	__releases(&proc->outer_lock)
 {
 	binder_debug(BINDER_DEBUG_SPINLOCKS,
 		     "%s: line=%d\n", __func__, line);
@@ -690,6 +692,7 @@ _binder_proc_unlock(struct binder_proc *proc, int line)
 #define binder_inner_proc_lock(proc) _binder_inner_proc_lock(proc, __LINE__)
 static void
 _binder_inner_proc_lock(struct binder_proc *proc, int line)
+	__acquires(&proc->inner_lock)
 {
 	binder_debug(BINDER_DEBUG_SPINLOCKS,
 		     "%s: line=%d\n", __func__, line);
@@ -705,6 +708,7 @@ _binder_inner_proc_lock(struct binder_proc *proc, int line)
 #define binder_inner_proc_unlock(proc) _binder_inner_proc_unlock(proc, __LINE__)
 static void
 _binder_inner_proc_unlock(struct binder_proc *proc, int line)
+	__releases(&proc->inner_lock)
 {
 	binder_debug(BINDER_DEBUG_SPINLOCKS,
 		     "%s: line=%d\n", __func__, line);
@@ -720,6 +724,7 @@ _binder_inner_proc_unlock(struct binder_proc *proc, int line)
 #define binder_node_lock(node) _binder_node_lock(node, __LINE__)
 static void
 _binder_node_lock(struct binder_node *node, int line)
+	__acquires(&node->lock)
 {
 	binder_debug(BINDER_DEBUG_SPINLOCKS,
 		     "%s: line=%d\n", __func__, line);
@@ -735,6 +740,7 @@ _binder_node_lock(struct binder_node *node, int line)
 #define binder_node_unlock(node) _binder_node_unlock(node, __LINE__)
 static void
 _binder_node_unlock(struct binder_node *node, int line)
+	__releases(&node->lock)
 {
 	binder_debug(BINDER_DEBUG_SPINLOCKS,
 		     "%s: line=%d\n", __func__, line);
@@ -751,12 +757,16 @@ _binder_node_unlock(struct binder_node *node, int line)
 #define binder_node_inner_lock(node) _binder_node_inner_lock(node, __LINE__)
 static void
 _binder_node_inner_lock(struct binder_node *node, int line)
+	__acquires(&node->lock) __acquires(&node->proc->inner_lock)
 {
 	binder_debug(BINDER_DEBUG_SPINLOCKS,
 		     "%s: line=%d\n", __func__, line);
 	spin_lock(&node->lock);
 	if (node->proc)
 		binder_inner_proc_lock(node->proc);
+	else
+		/* annotation for sparse */
+		__acquire(&node->proc->inner_lock);
 }
 
 /**
@@ -768,6 +778,7 @@ _binder_node_inner_lock(struct binder_node *node, int line)
 #define binder_node_inner_unlock(node) _binder_node_inner_unlock(node, __LINE__)
 static void
 _binder_node_inner_unlock(struct binder_node *node, int line)
+	__releases(&node->lock) __releases(&node->proc->inner_lock)
 {
 	struct binder_proc *proc = node->proc;
 
@@ -775,6 +786,9 @@ _binder_node_inner_unlock(struct binder_node *node, int line)
 		     "%s: line=%d\n", __func__, line);
 	if (proc)
 		binder_inner_proc_unlock(proc);
+	else
+		/* annotation for sparse */
+		__release(&node->proc->inner_lock);
 	spin_unlock(&node->lock);
 }
 
@@ -1384,10 +1398,14 @@ static void binder_dec_node_tmpref(struct binder_node *node)
 	binder_node_inner_lock(node);
 	if (!node->proc)
 		spin_lock(&binder_dead_nodes_lock);
+	else
+		__acquire(&binder_dead_nodes_lock);
 	node->tmp_refs--;
 	BUG_ON(node->tmp_refs < 0);
 	if (!node->proc)
 		spin_unlock(&binder_dead_nodes_lock);
+	else
+		__release(&binder_dead_nodes_lock);
 	/*
 	 * Call binder_dec_node() to check if all refcounts are 0
 	 * and cleanup is needed. Calling with strong=0 and internal=1
@@ -1890,18 +1908,22 @@ static struct binder_thread *binder_get_txn_from(
  */
 static struct binder_thread *binder_get_txn_from_and_acq_inner(
 		struct binder_transaction *t)
+	__acquires(&t->from->proc->inner_lock)
 {
 	struct binder_thread *from;
 
 	from = binder_get_txn_from(t);
-	if (!from)
+	if (!from) {
+		__acquire(&from->proc->inner_lock);
 		return NULL;
+	}
 	binder_inner_proc_lock(from->proc);
 	if (t->from) {
 		BUG_ON(from != t->from);
 		return from;
 	}
 	binder_inner_proc_unlock(from->proc);
+	__acquire(&from->proc->inner_lock);
 	binder_thread_dec_tmpref(from);
 	return NULL;
 }
@@ -1973,6 +1995,8 @@ static void binder_send_failed_reply(struct binder_transaction *t,
 			binder_thread_dec_tmpref(target_thread);
 			binder_free_transaction(t);
 			return;
+		} else {
+			__release(&target_thread->proc->inner_lock);
 		}
 		next = t->from_parent;
 
@@ -2394,11 +2418,15 @@ static int binder_translate_handle(struct flat_binder_object *fp,
 		fp->cookie = node->cookie;
 		if (node->proc)
 			binder_inner_proc_lock(node->proc);
+		else
+			__acquire(&node->proc->inner_lock);
 		binder_inc_node_nilocked(node,
 					 fp->hdr.type == BINDER_TYPE_BINDER,
 					 0, NULL);
 		if (node->proc)
 			binder_inner_proc_unlock(node->proc);
+		else
+			__release(&node->proc->inner_lock);
 		trace_binder_transaction_ref_to_node(t, node, &src_rdata);
 		binder_debug(BINDER_DEBUG_TRANSACTION,
 			     "        ref %d desc %d -> node %d u%016llx\n",
@@ -2762,6 +2790,8 @@ static void binder_transaction(struct binder_proc *proc,
 		binder_set_nice(in_reply_to->saved_priority);
 		target_thread = binder_get_txn_from_and_acq_inner(in_reply_to);
 		if (target_thread == NULL) {
+			/* annotation for sparse */
+			__release(&target_thread->proc->inner_lock);
 			return_error = BR_DEAD_REPLY;
 			return_error_line = __LINE__;
 			goto err_dead_binder;
@@ -4164,6 +4194,11 @@ static int binder_thread_read(struct binder_proc *proc,
 			if (cmd == BR_DEAD_BINDER)
 				goto done; /* DEAD_BINDER notifications can cause transactions */
 		} break;
+		default:
+			binder_inner_proc_unlock(proc);
+			pr_err("%d:%d: bad work type %d\n",
+			       proc->pid, thread->pid, w->type);
+			break;
 		}
 
 		if (!t)
@@ -4467,6 +4502,8 @@ static int binder_thread_release(struct binder_proc *proc,
 		spin_lock(&t->lock);
 		if (t->to_thread == thread)
 			send_reply = t;
+	} else {
+		__acquire(&t->lock);
 	}
 	thread->is_dead = true;
 
@@ -4495,7 +4532,11 @@ static int binder_thread_release(struct binder_proc *proc,
 		spin_unlock(&last_t->lock);
 		if (t)
 			spin_lock(&t->lock);
+		else
+			__acquire(&t->lock);
 	}
+	/* annotation for sparse, lock not acquired in last iteration above */
+	__release(&t->lock);
 
 	/*
 	 * If this thread used poll, make sure we remove the waitqueue
diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index 030c98f35cca7..022cd80e80cc3 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -939,6 +939,7 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
 				       struct list_lru_one *lru,
 				       spinlock_t *lock,
 				       void *cb_arg)
+	__must_hold(lock)
 {
 	struct mm_struct *mm = NULL;
 	struct binder_lru_page *page = container_of(item,
-- 
2.20.0.rc1.387.gf8505762e3-goog


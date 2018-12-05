Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 163E5C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5ED520989
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:19:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="I1mAY4ss"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5ED520989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=android.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728783AbeLEXTl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 18:19:41 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46803 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727701AbeLEXTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 18:19:41 -0500
Received: by mail-pf1-f194.google.com with SMTP id c73so10744333pfe.13
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 15:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=86wJMNNfzXDB0IqNns8ZctG73JaAKYWTCz8xpT/XRVI=;
        b=I1mAY4ssVBCGw+vSFs6wyzxi9tY05rGf3dKd+W6ZwGWtgSWHHKxFjzPalulGEfHnPf
         G04il8vyLxwjGD3+35K++OTTrHtoBjx9Kkjxq2AhmeNVxT08KG/YShljmHrF0wx7f9o9
         DpWuIkdAcktfmKxG/dkr1qdfGhSjFthhHrE7vMbwcIxMNPRny7kCfg0kd65ZdhyqDzfq
         2w+f9XXRqrcaSCdnkWaQsCFA7s8BoRyE/Ljz8u4pGtZJ4WGO0MTpB8yn8yO6GQbkSVe4
         osIUO2XkpFjDv0PjJWzkzzhoyQ1Bly6rgsoTsC1CyvH27/t/h06j2kOPei7qs8NNwC0Y
         80xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=86wJMNNfzXDB0IqNns8ZctG73JaAKYWTCz8xpT/XRVI=;
        b=T279YhJxsvWKEs+bMXZA4TrreMXqQeGvKhJslCaztNSjZwpl2QhREEdHjRMC69iRgB
         aENpJnrhiTTqXyxgmlR3h6eXqOdHPjlbbHohO7ZfbxgO9c2NkohvUekoI/dpRcZZMjgh
         RZBkzxjHdqWrk0Ggr70N3igTiFVDUOmdpJmx7+gJg9O6NR9NxQ9vMkiPMlL7CW7reUy3
         irQIfLWMQyZbHDozqmFLHYmkoSsffKk+Y3M/nehM4/lYBabW6p1bPCUkIpSi+iXHsijH
         ABgPju9XLkxAHMSEfhCk0zOPGEOmRl1IHtCvXqnSbyJjFROiBUpPpH6iIEMaoT3P+uWJ
         LIYQ==
X-Gm-Message-State: AA+aEWajqB1qwcJN1qxGId9r+7u5/0gosye70bSUoUVHDjjgUVS75k+/
        aWzHNa3cITNkCpJjS8S8sCCWiw==
X-Google-Smtp-Source: AFSGD/UbLLxjyC8YACZw/ggrkKjvCB1/nB84ZHL1H4AwzBchMEL5NbTFC80+HYSMf/KfrMaCBo3nFg==
X-Received: by 2002:a63:5455:: with SMTP id e21mr22333962pgm.316.1544051979838;
        Wed, 05 Dec 2018 15:19:39 -0800 (PST)
Received: from ava-linux2.mtv.corp.google.com ([2620:0:1000:1601:6cc0:d41d:b970:fd7])
        by smtp.googlemail.com with ESMTPSA id p7sm51442338pfj.72.2018.12.05.15.19.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 15:19:39 -0800 (PST)
From:   Todd Kjos <tkjos@android.com>
X-Google-Original-From: Todd Kjos <tkjos@google.com>
To:     tkjos@google.com, gregkh@linuxfoundation.org, arve@android.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        maco@google.com, joel@joelfernandes.org
Cc:     kernel-team@android.com
Subject: [PATCH v2 1/3] binder: fix sparse warnings on locking context
Date:   Wed,  5 Dec 2018 15:19:24 -0800
Message-Id: <20181205231926.45928-1-tkjos@google.com>
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
v2: no change, just resubmitted as #1 of 3 patches instead of by itself

 drivers/android/binder.c       | 43 +++++++++++++++++++++++++++++++++-
 drivers/android/binder_alloc.c |  1 +
 2 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index d6979cf7b2dad..172c207fbf99d 100644
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


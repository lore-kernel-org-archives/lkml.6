Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18147C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 11:53:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE33721532
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 11:53:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=colorfullife-com.20150623.gappssmtp.com header.i=@colorfullife-com.20150623.gappssmtp.com header.b="znmqngaO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE33721532
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=colorfullife.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934355AbeGDLxM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 07:53:12 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:39250 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933296AbeGDLxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 07:53:10 -0400
Received: by mail-wm0-f65.google.com with SMTP id p11-v6so5408807wmc.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 04:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=9mTlfal83Wq8MpslFM07Wgvp4f2ysPWQwO7DpnaHJKA=;
        b=znmqngaOCG2K+BFM3DyMXa74pyfXmXGCxBO4CYaxHFyjhwH5dQtqtDHo0Wd08qI+B0
         Yvvn0YAS2MkAvRKeH+6Tz9BIq+WkTuph+G74ErA/LA7q3y7nVHbI3jqHuMDRaXPDpWSv
         mTTZaQIeY127tUmTTGfQ37C22MQme4B3gRKixH/steqyCvxnkLSzRNyDtlWsri3Zm5Vv
         yXDfigodJLTu3TcQpdWN7p8I1DjE6eRBAQc+Mn6LJ3wBqUt0tdMcuIr0FXUJoo+somsY
         I4+mOc2Kruzt/zeyGU7ruUgAF1/g7xkwyNx7bo8VyzgrakQ7iLB0A4O74Y+jP6XLJx6R
         KaxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9mTlfal83Wq8MpslFM07Wgvp4f2ysPWQwO7DpnaHJKA=;
        b=rh7qAUL5ID05+tgy9g90L+Hi/CUxwm4RC9O2LMt/nPkTtyCxa6+4OFYKa3+1iFLFcM
         JJBNj0vfGLCtxcLHG/KlWOcO6RiN+O5oOHg6rfNS9niRBgKBe7qDI+0gO1B0VEBO6J3C
         AE6IK3SiCHmHu9L+HzA3fg8vC64ZfZjW11KV31J31ARY/mek6Z7ZTvVFia9BG+nwItJi
         HEg+E+erFaF5KGOcd518xhjmAhkEHb9AiHZyrqbISKifEjR/vklIHYaikq0BuvOjoqCo
         XhrlkTYkzmXkw48NqArIqAdJSJQZelJiThwNdLtWIdhw0d/WKj0x10BEogXFbbVlBuy9
         uPOQ==
X-Gm-Message-State: APt69E222VgD4wvhNcX585K3e/3vi6lkG2+Zhv87QaEvBtiFNypIgs1Y
        IUlJnfeYPpYinmrFTgD7zmK23ueI
X-Google-Smtp-Source: AAOMgpfl8M5rAVUjjSbtw+sAw5wSpnGykN9C0whs2IDhRfNzvTWlaM4ToSXGo1aedKTsKPzbrSgXaQ==
X-Received: by 2002:a1c:38c2:: with SMTP id f185-v6mr1398235wma.148.1530705189286;
        Wed, 04 Jul 2018 04:53:09 -0700 (PDT)
Received: from localhost.localdomain (p200300D993C3350004CADE66801158EF.dip0.t-ipconnect.de. [2003:d9:93c3:3500:4ca:de66:8011:58ef])
        by smtp.googlemail.com with ESMTPSA id r2-v6sm6496935wmb.39.2018.07.04.04.53.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Jul 2018 04:53:08 -0700 (PDT)
From:   Manfred Spraul <manfred@colorfullife.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>, paulmck@linux.vnet.ibm.com
Cc:     1vier1@web.de, Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Manfred Spraul <manfred@colorfullife.com>
Subject: [RFC] ipc: refcounting / use after free?
Date:   Wed,  4 Jul 2018 13:53:05 +0200
Message-Id: <20180704115305.2583-1-manfred@colorfullife.com>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ipc code uses the equivalent of

	rcu_read_lock();
	kfree_rcu(a, rcu);
	if (a->deleted) {
		rcu_read_unlock();
		return FAILURE;
	}
	<...>

Is this safe, or is dereferencing "a" after having called call_rcu()
a use-after-free?

According to rcupdate.h, the kfree is only deferred until the
other CPUs exit their critical sections:

include/linux/rcupdate.h:
> * Similarly, if call_rcu() is invoked
> * on one CPU while other CPUs are within RCU read-side critical
> * sections, invocation of the corresponding RCU callback is deferred
> * until after the all the other CPUs exit their critical sections.

<The patch is for review, not fully tested>
---
 ipc/msg.c  | 11 ++++++++---
 ipc/sem.c  | 42 ++++++++++++++++++++++++++++++------------
 ipc/util.c | 35 ++++++++++++++++++++++++++++++++---
 ipc/util.h | 18 ++++++++++++++++--
 4 files changed, 86 insertions(+), 20 deletions(-)

diff --git a/ipc/msg.c b/ipc/msg.c
index 3b6545302598..724000c15296 100644
--- a/ipc/msg.c
+++ b/ipc/msg.c
@@ -805,7 +805,7 @@ static long do_msgsnd(int msqid, long mtype, void __user *mtext,
 	msq = msq_obtain_object_check(ns, msqid);
 	if (IS_ERR(msq)) {
 		err = PTR_ERR(msq);
-		goto out_unlock1;
+		goto out_unlock2;
 	}
 
 	ipc_lock_object(&msq->q_perm);
@@ -851,8 +851,12 @@ static long do_msgsnd(int msqid, long mtype, void __user *mtext,
 		rcu_read_lock();
 		ipc_lock_object(&msq->q_perm);
 
-		ipc_rcu_putref(&msq->q_perm, msg_rcu_free);
 		/* raced with RMID? */
+		if (!__ipc_rcu_putref(&msq->q_perm)) {
+			ipc_unlock_object(&msq->q_perm);
+			call_rcu(&msq->q_perm.rcu, msg_rcu_free);
+			goto out_unlock1;
+		}
 		if (!ipc_valid_object(&msq->q_perm)) {
 			err = -EIDRM;
 			goto out_unlock0;
@@ -883,8 +887,9 @@ static long do_msgsnd(int msqid, long mtype, void __user *mtext,
 
 out_unlock0:
 	ipc_unlock_object(&msq->q_perm);
-	wake_up_q(&wake_q);
 out_unlock1:
+	wake_up_q(&wake_q);
+out_unlock2:
 	rcu_read_unlock();
 	if (msg != NULL)
 		free_msg(msg);
diff --git a/ipc/sem.c b/ipc/sem.c
index 5af1943ad782..c269fae05b24 100644
--- a/ipc/sem.c
+++ b/ipc/sem.c
@@ -475,10 +475,16 @@ static inline struct sem_array *sem_obtain_object_check(struct ipc_namespace *ns
 	return container_of(ipcp, struct sem_array, sem_perm);
 }
 
-static inline void sem_lock_and_putref(struct sem_array *sma)
+static int __must_check sem_lock_and_putref(struct sem_array *sma)
 {
 	sem_lock(sma, NULL, -1);
-	ipc_rcu_putref(&sma->sem_perm, sem_rcu_free);
+
+	if (!__ipc_rcu_putref(&sma->sem_perm)) {
+		sem_unlock(sma, -1);
+		call_rcu(&sma->sem_perm.rcu, sem_rcu_free);
+		return 0;
+	}
+	return 1;
 }
 
 static inline void sem_rmid(struct ipc_namespace *ns, struct sem_array *s)
@@ -1434,7 +1440,10 @@ static int semctl_main(struct ipc_namespace *ns, int semid, int semnum,
 			}
 
 			rcu_read_lock();
-			sem_lock_and_putref(sma);
+			if (!sem_lock_and_putref(sma)) {
+				goto out_rcu_wakeup;
+			}
+
 			if (!ipc_valid_object(&sma->sem_perm)) {
 				err = -EIDRM;
 				goto out_unlock;
@@ -1483,7 +1492,11 @@ static int semctl_main(struct ipc_namespace *ns, int semid, int semnum,
 			}
 		}
 		rcu_read_lock();
-		sem_lock_and_putref(sma);
+		if (!sem_lock_and_putref(sma)) {
+			err = -EIDRM;
+			goto out_rcu_wakeup;
+		}
+
 		if (!ipc_valid_object(&sma->sem_perm)) {
 			err = -EIDRM;
 			goto out_unlock;
@@ -1898,14 +1911,12 @@ static struct sem_undo *find_alloc_undo(struct ipc_namespace *ns, int semid)
 
 	/* step 3: Acquire the lock on semaphore array */
 	rcu_read_lock();
-	sem_lock_and_putref(sma);
-	if (!ipc_valid_object(&sma->sem_perm)) {
-		sem_unlock(sma, -1);
-		rcu_read_unlock();
-		kfree(new);
-		un = ERR_PTR(-EIDRM);
-		goto out;
-	}
+	if (!sem_lock_and_putref(sma))
+		goto out_EIDRM_free;
+
+	if (!ipc_valid_object(&sma->sem_perm))
+		goto out_EIDRM_unlock;
+
 	spin_lock(&ulp->lock);
 
 	/*
@@ -1931,6 +1942,13 @@ static struct sem_undo *find_alloc_undo(struct ipc_namespace *ns, int semid)
 	sem_unlock(sma, -1);
 out:
 	return un;
+
+out_EIDRM_unlock:
+	sem_unlock(sma, -1);
+out_EIDRM_free:
+	rcu_read_unlock();
+	kfree(new);
+	return ERR_PTR(-EIDRM);
 }
 
 static long do_semtimedop(int semid, struct sembuf __user *tsops,
diff --git a/ipc/util.c b/ipc/util.c
index 4e81182fa0ac..ba7f96fc8a61 100644
--- a/ipc/util.c
+++ b/ipc/util.c
@@ -462,18 +462,47 @@ void ipc_set_key_private(struct ipc_ids *ids, struct kern_ipc_perm *ipcp)
 	ipcp->key = IPC_PRIVATE;
 }
 
-int ipc_rcu_getref(struct kern_ipc_perm *ptr)
+int __must_check ipc_rcu_getref(struct kern_ipc_perm *ptr)
 {
 	return refcount_inc_not_zero(&ptr->refcount);
 }
 
-void ipc_rcu_putref(struct kern_ipc_perm *ptr,
+/**
+ * __ipc_rcu_putref - reduce reference count of an ipc object.
+ * @ptr: ipc object
+ *
+ * The function reduces the reference count of an ipc object by 1.
+ * If the reference count drops to 0, then the function returns 0.
+ * If this happens, then the caller is responsible for triggering
+ * call_rcu() to free the ipc object.
+ */
+int __must_check __ipc_rcu_putref(struct kern_ipc_perm *ptr)
+{
+	if (!refcount_dec_and_test(&ptr->refcount))
+		return 1;
+	return 0;
+}
+
+/**
+ * ipc_rcu_putref - reduce reference count of an ipc object.
+ * @ptr: ipc object
+ * @func: cleanup function to call when the reference is reduced to 0.
+ *
+ * The function reduces the reference count of an ipc object by 1.
+ * If the count drops to 0, then a call_rcu is triggered to free the ipc
+ * object.
+ *
+ * If the reference count drops to 0, then the function returns 0.
+ * If this happens, then the caller must not dereference ptr.
+ */
+int ipc_rcu_putref(struct kern_ipc_perm *ptr,
 			void (*func)(struct rcu_head *head))
 {
 	if (!refcount_dec_and_test(&ptr->refcount))
-		return;
+		return 1;
 
 	call_rcu(&ptr->rcu, func);
+	return 0;
 }
 
 /**
diff --git a/ipc/util.h b/ipc/util.h
index 0aba3230d007..fbd55aeee933 100644
--- a/ipc/util.h
+++ b/ipc/util.h
@@ -134,12 +134,26 @@ static inline int ipc_get_maxid(struct ipc_ids *ids)
  * Objects are reference counted, they start with reference count 1.
  * getref increases the refcount, the putref call that reduces the recount
  * to 0 schedules the rcu destruction. Caller must guarantee locking.
+ * As the reference count is reduced without holding any lock, this means
+ * that the caller must use ipc_valid_object() after acquiring ipc_lock_xx().
  *
  * refcount is initialized by ipc_addid(), before that point call_rcu()
  * must be used.
+ *
+ * Most callers must check the return codes:
+ * - ipc_rcu_getref() fails if the reference count is already 0.
+ * - ipc_rcu_putref() calls call_rcu() if the reference count drops to 0,
+ *	dereferencing the ipc object if the function returns 0 is a
+ *	use-after-free.
+ * - with __ipc_rcu_putref(), the caller is responible for call_rcu().
+ *	This function is intended to be used if dereferencing must be done,
+ *	e.g. to drop a lock.
+ * ipc_rcu_putref does not use __must_check, because error paths or the
+ * IPC_RMID codepaths can safely ignore the return code.
  */
-int ipc_rcu_getref(struct kern_ipc_perm *ptr);
-void ipc_rcu_putref(struct kern_ipc_perm *ptr,
+int __must_check ipc_rcu_getref(struct kern_ipc_perm *ptr);
+int __must_check __ipc_rcu_putref(struct kern_ipc_perm *ptr);
+int ipc_rcu_putref(struct kern_ipc_perm *ptr,
 			void (*func)(struct rcu_head *head));
 
 struct kern_ipc_perm *ipc_lock(struct ipc_ids *, int);
-- 
2.14.4


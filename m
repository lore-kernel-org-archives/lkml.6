Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1376423-1526531769-2-4364453810984536681
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, RCVD_IN_DNSWL_HI -5,
  LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526531769; b=hLH1dl+1YBKqJyRhjvX1aaRYMfbgxE7ZvliGpyBjLwCrkoK0Nu
    EUm8+caeeIIx+N0FLISLV/Kb686YDcKX+o2nQe9kg/CpP/NCneX/d/StkSSprVyX
    mvhPlNS8yCmS7S+wNZrZQQOBOWcR8qW6/3kgcaEORgqikH6pc7JmaJmqV53sQeJ/
    wRpewnuZs/n2aHdaJan9w7HeXQLAR1PMcFqGfnlpPxA8xVQ9Z4vZ7dOeY1OAqDCq
    lwzDhwVYTLW7XR9Iccgl4yQdxAHSjK6DhST4Uqexk+2EneX2LeFChvji/RRFx+6s
    +RlhlDu9+dq9SlVOUmHELMG+dWFcNVonjWAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1526531769; bh=
    W/jJQvz3xm+YAL6x0hDVIiNtUYDOcGZ+tIef0gR/Nu0=; b=kyYvoVJirR/DHvL6
    v3ivW6CuwqDbL3/NJchxJoZcB9m0OxOshbltAyIOn5QnDabVOx8EqGeRuvAckPK8
    AkRvHo77zFXvQXdc0HXzZ8fQqDP3QYww04dmiR8Kcm3ZGISwS4vr9jo/sASjPUNU
    7A8ORNBHIjkYb2r0B9dFvgRqdaduRv+UWIMF5D5kcdt973lI3vogqwMZw0FLHItn
    9O0F0f7r/Sa1Cpdm9mnKc2r6AjQ7cskib4JKDe3f99Fv8mI+5KfV4sPqqdaV10lC
    pdCHTettHGnzJef1yG/3Fbn6T7zLWRwR1SXXNlAgWjWrm4JU1U4CAodxzX/mi0Lf
    z+7pOA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=Yza0bKhS x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=trndUv0X;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=Yza0bKhS x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=trndUv0X;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHFqnrAU7mu4/KtG4OAjN3QvKu4htW+pckm3ZuWta9FXqhOf3OH15pbDUbeli/er2gI+cXmteNWMgdYnugOvh57Eywn1e1ANBqjLnxPpmrnRrILvKBMt
    JvsUgH7fW9J5er0V/wi5ya5lJuobBDlbFOisMahDBWj+zNRoVbhhhw5wHa7HAAYM/mNUy9k/IK1g9L41+bsYAvTcTSCj/fPLF+v1znvSCl3qLZ/KvA2v7Jxn
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=xqWC_Br6kY4A:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=tr-Z5VeMX48rR7tTHnMA:9 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750933AbeEQEf4 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 17 May 2018 00:35:56 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:44991 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751671AbeEQEfF (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 17 May 2018 00:35:05 -0400
X-Google-Smtp-Source: AB8JxZpUxoTmWUKeRmLPGSkWByLpOkNgclzGR47COU5jytEAc3ctyVFgZ9vHovY0A6/5b8zQu5u3Vw==
From: Tejun Heo <tj@kernel.org>
To: torvalds@linux-foundation.org, jiangshanlai@gmail.com,
        akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        kernel-team@fb.com, csmall@enc.com.au, Tejun Heo <tj@kernel.org>
Subject: [PATCH 3/6] workqueue: Make worker_attach/detach_pool() update worker->pool
Date: Wed, 16 May 2018 21:34:45 -0700
Message-Id: <20180517043448.3152269-4-tj@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180517043448.3152269-1-tj@kernel.org>
References: <20180517043448.3152269-1-tj@kernel.org>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

For historical reasons, the worker attach/detach functions don't
currently manage worker->pool and the callers are manually and
inconsistently updating it.

This patch moves worker->pool updates into the worker attach/detach
functions.  This makes worker->pool consistent and clearly defines how
worker->pool updates are synchronized.

This will help later workqueue visibility improvements by allowing
safe access to workqueue information from worker->task.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/workqueue.c          | 16 ++++++++--------
 kernel/workqueue_internal.h |  2 +-
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 91fe0a6..2fde50f 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1741,6 +1741,7 @@ static void worker_attach_to_pool(struct worker *worker,
 		worker->flags |= WORKER_UNBOUND;
 
 	list_add_tail(&worker->node, &pool->workers);
+	worker->pool = pool;
 
 	mutex_unlock(&wq_pool_attach_mutex);
 }
@@ -1748,19 +1749,21 @@ static void worker_attach_to_pool(struct worker *worker,
 /**
  * worker_detach_from_pool() - detach a worker from its pool
  * @worker: worker which is attached to its pool
- * @pool: the pool @worker is attached to
  *
  * Undo the attaching which had been done in worker_attach_to_pool().  The
  * caller worker shouldn't access to the pool after detached except it has
  * other reference to the pool.
  */
-static void worker_detach_from_pool(struct worker *worker,
-				    struct worker_pool *pool)
+static void worker_detach_from_pool(struct worker *worker)
 {
+	struct worker_pool *pool = worker->pool;
 	struct completion *detach_completion = NULL;
 
 	mutex_lock(&wq_pool_attach_mutex);
+
 	list_del(&worker->node);
+	worker->pool = NULL;
+
 	if (list_empty(&pool->workers))
 		detach_completion = pool->detach_completion;
 	mutex_unlock(&wq_pool_attach_mutex);
@@ -1799,7 +1802,6 @@ static struct worker *create_worker(struct worker_pool *pool)
 	if (!worker)
 		goto fail;
 
-	worker->pool = pool;
 	worker->id = id;
 
 	if (pool->cpu >= 0)
@@ -2236,7 +2238,7 @@ static int worker_thread(void *__worker)
 
 		set_task_comm(worker->task, "kworker/dying");
 		ida_simple_remove(&pool->worker_ida, worker->id);
-		worker_detach_from_pool(worker, pool);
+		worker_detach_from_pool(worker);
 		kfree(worker);
 		return 0;
 	}
@@ -2367,7 +2369,6 @@ static int rescuer_thread(void *__rescuer)
 		worker_attach_to_pool(rescuer, pool);
 
 		spin_lock_irq(&pool->lock);
-		rescuer->pool = pool;
 
 		/*
 		 * Slurp in all works issued via this workqueue and
@@ -2417,10 +2418,9 @@ static int rescuer_thread(void *__rescuer)
 		if (need_more_worker(pool))
 			wake_up_worker(pool);
 
-		rescuer->pool = NULL;
 		spin_unlock_irq(&pool->lock);
 
-		worker_detach_from_pool(rescuer, pool);
+		worker_detach_from_pool(rescuer);
 
 		spin_lock_irq(&wq_mayday_lock);
 	}
diff --git a/kernel/workqueue_internal.h b/kernel/workqueue_internal.h
index d390d1b..4a182e0 100644
--- a/kernel/workqueue_internal.h
+++ b/kernel/workqueue_internal.h
@@ -37,7 +37,7 @@ struct worker {
 	/* 64 bytes boundary on 64bit, 32 on 32bit */
 
 	struct task_struct	*task;		/* I: worker task */
-	struct worker_pool	*pool;		/* I: the associated pool */
+	struct worker_pool	*pool;		/* A: the associated pool */
 						/* L: for rescuers */
 	struct list_head	node;		/* A: anchored at pool->workers */
 						/* A: runs through worker->node */
-- 
2.9.5


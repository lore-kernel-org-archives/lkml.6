Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1427043-1526531785-2-15956671106018122642
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
    1526531784; b=SqvMEnq2xfE1h8wEw81AFt9PkZIUjWGqCdRy842+RL5w6NQKQh
    uXec7sJrPWncK20OEMP+udNePI1K9udyc1OZ30cXHrBc8w6ee3QtAjHh8i5FnWFf
    lduvGpfE2DrbP4VBD7KoYIyvsbALY6hgamLyzSdtwIyVuMgcrcK7QgWX+yL7DNqd
    r0iQfmdUUrgpjVimvBRfjW8iJoJ8LSHhFLm2RSRuqUxU87mpw6MHnnAoVxQmRIpl
    ThuZfjU2SK5XP2PkSGM91dLRRF0feSpVkhtAT7xAvC0kJDOVMYpyswJesinZUopt
    TRp2KAaMNghwwMCwZaot1lVm/X7M13S/SIOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1526531784; bh=
    hNVU+ZZIGeJ+3yRyLxfZ3oXSV9PQYx7h+3BW66H9ZMs=; b=RsARn8HMKWGPPVXO
    XUuG/8NQgTRXhlXYUzsPXRRLBhcCEQDqE282WT8gXaxWbMwN36gl7v9V8ZW+2Aaq
    BY1njTGhLOFycBJlmvGpoPT0CgAQj00+fHwOccdWQD35KdmdthDn1V5OCTnG2spJ
    xLlkzgQ5izGwdb0BJpq4bXw/JddZem6lYKMd+gkGsBP+XP5L7u2iVoOPMPjPIZ1C
    y9BR+AS1w7yMnY5bbajyhsq+FW76IrLHYR39C7t1lEoalklfIQjMkBl+IxSS6+hr
    nzLFPwQ69LNJHZfqpnke+GyYRYtajZa9jX+BV3aSwNQYchtQSAnxvVNQQMGf9m5f
    utq2iw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=Kxjs/fmd x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=d5yqBmpe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=Kxjs/fmd x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=d5yqBmpe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEazqa3ert6m2sH8tsgjGhzFJ0Cav5YZ8L9qCucHsjiOMSYUZtqT7UK8Fg0ihJopD/74b0G6AE4ep8B/M9TqQ93w07tRg1jP+uYfR+Sg9lYhJbZw0Lpi
    0BOF7qbSkOqftVWioyn34iW5I72ufgptMV2ZJyjgNaCgkYGsLEW6qCEdJ6DZtg26ulKS6ekg4VbtMD9yjmID32fLORwRZBD0sPId4Ib+0hVBpdUsLKFZvKEU
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=xqWC_Br6kY4A:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=kWfNqJnFkcjbtjyxTZEA:9 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752026AbeEQEgL (ORCPT <rfc822;greg@kroah.com>);
        Thu, 17 May 2018 00:36:11 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:33699 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751649AbeEQEfC (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 17 May 2018 00:35:02 -0400
X-Google-Smtp-Source: AB8JxZqcc5buAjd5jqpkL0FbXKkXSvJiEXuf3hj6zuL/jyudW03ULaNucQT7Xg6wKlvFWum+ievcvg==
From: Tejun Heo <tj@kernel.org>
To: torvalds@linux-foundation.org, jiangshanlai@gmail.com,
        akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        kernel-team@fb.com, csmall@enc.com.au, Tejun Heo <tj@kernel.org>
Subject: [PATCH 2/6] workqueue: Replace pool->attach_mutex with global wq_pool_attach_mutex
Date: Wed, 16 May 2018 21:34:44 -0700
Message-Id: <20180517043448.3152269-3-tj@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180517043448.3152269-1-tj@kernel.org>
References: <20180517043448.3152269-1-tj@kernel.org>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

To improve workqueue visibility, we want to be able to access
workqueue information from worker tasks.  The per-pool attach mutex
makes that difficult because there's no way of stabilizing task ->
worker pool association without knowing the pool first.

Worker attach/detach is a slow path and there's no need for different
pools to be able to perform them concurrently.  This patch replaces
the per-pool attach_mutex with global wq_pool_attach_mutex to prepare
for visibility improvement changes.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/workqueue.c | 41 ++++++++++++++++++++---------------------
 1 file changed, 20 insertions(+), 21 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index ca7959b..91fe0a6 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -66,7 +66,7 @@ enum {
 	 * be executing on any CPU.  The pool behaves as an unbound one.
 	 *
 	 * Note that DISASSOCIATED should be flipped only while holding
-	 * attach_mutex to avoid changing binding state while
+	 * wq_pool_attach_mutex to avoid changing binding state while
 	 * worker_attach_to_pool() is in progress.
 	 */
 	POOL_MANAGER_ACTIVE	= 1 << 0,	/* being managed */
@@ -123,7 +123,7 @@ enum {
  *    cpu or grabbing pool->lock is enough for read access.  If
  *    POOL_DISASSOCIATED is set, it's identical to L.
  *
- * A: pool->attach_mutex protected.
+ * A: wq_pool_attach_mutex protected.
  *
  * PL: wq_pool_mutex protected.
  *
@@ -166,7 +166,6 @@ struct worker_pool {
 						/* L: hash of busy workers */
 
 	struct worker		*manager;	/* L: purely informational */
-	struct mutex		attach_mutex;	/* attach/detach exclusion */
 	struct list_head	workers;	/* A: attached workers */
 	struct completion	*detach_completion; /* all workers detached */
 
@@ -297,6 +296,7 @@ static bool wq_numa_enabled;		/* unbound NUMA affinity enabled */
 static struct workqueue_attrs *wq_update_unbound_numa_attrs_buf;
 
 static DEFINE_MUTEX(wq_pool_mutex);	/* protects pools and workqueues list */
+static DEFINE_MUTEX(wq_pool_attach_mutex); /* protects worker attach/detach */
 static DEFINE_SPINLOCK(wq_mayday_lock);	/* protects wq->maydays list */
 static DECLARE_WAIT_QUEUE_HEAD(wq_manager_wait); /* wait for manager to go away */
 
@@ -399,14 +399,14 @@ static void workqueue_sysfs_unregister(struct workqueue_struct *wq);
  * @worker: iteration cursor
  * @pool: worker_pool to iterate workers of
  *
- * This must be called with @pool->attach_mutex.
+ * This must be called with wq_pool_attach_mutex.
  *
  * The if/else clause exists only for the lockdep assertion and can be
  * ignored.
  */
 #define for_each_pool_worker(worker, pool)				\
 	list_for_each_entry((worker), &(pool)->workers, node)		\
-		if (({ lockdep_assert_held(&pool->attach_mutex); false; })) { } \
+		if (({ lockdep_assert_held(&wq_pool_attach_mutex); false; })) { } \
 		else
 
 /**
@@ -1724,7 +1724,7 @@ static struct worker *alloc_worker(int node)
 static void worker_attach_to_pool(struct worker *worker,
 				   struct worker_pool *pool)
 {
-	mutex_lock(&pool->attach_mutex);
+	mutex_lock(&wq_pool_attach_mutex);
 
 	/*
 	 * set_cpus_allowed_ptr() will fail if the cpumask doesn't have any
@@ -1733,16 +1733,16 @@ static void worker_attach_to_pool(struct worker *worker,
 	set_cpus_allowed_ptr(worker->task, pool->attrs->cpumask);
 
 	/*
-	 * The pool->attach_mutex ensures %POOL_DISASSOCIATED remains
-	 * stable across this function.  See the comments above the
-	 * flag definition for details.
+	 * The wq_pool_attach_mutex ensures %POOL_DISASSOCIATED remains
+	 * stable across this function.  See the comments above the flag
+	 * definition for details.
 	 */
 	if (pool->flags & POOL_DISASSOCIATED)
 		worker->flags |= WORKER_UNBOUND;
 
 	list_add_tail(&worker->node, &pool->workers);
 
-	mutex_unlock(&pool->attach_mutex);
+	mutex_unlock(&wq_pool_attach_mutex);
 }
 
 /**
@@ -1759,11 +1759,11 @@ static void worker_detach_from_pool(struct worker *worker,
 {
 	struct completion *detach_completion = NULL;
 
-	mutex_lock(&pool->attach_mutex);
+	mutex_lock(&wq_pool_attach_mutex);
 	list_del(&worker->node);
 	if (list_empty(&pool->workers))
 		detach_completion = pool->detach_completion;
-	mutex_unlock(&pool->attach_mutex);
+	mutex_unlock(&wq_pool_attach_mutex);
 
 	/* clear leftover flags without pool->lock after it is detached */
 	worker->flags &= ~(WORKER_UNBOUND | WORKER_REBOUND);
@@ -3271,7 +3271,6 @@ static int init_worker_pool(struct worker_pool *pool)
 
 	timer_setup(&pool->mayday_timer, pool_mayday_timeout, 0);
 
-	mutex_init(&pool->attach_mutex);
 	INIT_LIST_HEAD(&pool->workers);
 
 	ida_init(&pool->worker_ida);
@@ -3354,10 +3353,10 @@ static void put_unbound_pool(struct worker_pool *pool)
 	WARN_ON(pool->nr_workers || pool->nr_idle);
 	spin_unlock_irq(&pool->lock);
 
-	mutex_lock(&pool->attach_mutex);
+	mutex_lock(&wq_pool_attach_mutex);
 	if (!list_empty(&pool->workers))
 		pool->detach_completion = &detach_completion;
-	mutex_unlock(&pool->attach_mutex);
+	mutex_unlock(&wq_pool_attach_mutex);
 
 	if (pool->detach_completion)
 		wait_for_completion(pool->detach_completion);
@@ -4600,7 +4599,7 @@ static void unbind_workers(int cpu)
 	struct worker *worker;
 
 	for_each_cpu_worker_pool(pool, cpu) {
-		mutex_lock(&pool->attach_mutex);
+		mutex_lock(&wq_pool_attach_mutex);
 		spin_lock_irq(&pool->lock);
 
 		/*
@@ -4616,7 +4615,7 @@ static void unbind_workers(int cpu)
 		pool->flags |= POOL_DISASSOCIATED;
 
 		spin_unlock_irq(&pool->lock);
-		mutex_unlock(&pool->attach_mutex);
+		mutex_unlock(&wq_pool_attach_mutex);
 
 		/*
 		 * Call schedule() so that we cross rq->lock and thus can
@@ -4657,7 +4656,7 @@ static void rebind_workers(struct worker_pool *pool)
 {
 	struct worker *worker;
 
-	lockdep_assert_held(&pool->attach_mutex);
+	lockdep_assert_held(&wq_pool_attach_mutex);
 
 	/*
 	 * Restore CPU affinity of all workers.  As all idle workers should
@@ -4727,7 +4726,7 @@ static void restore_unbound_workers_cpumask(struct worker_pool *pool, int cpu)
 	static cpumask_t cpumask;
 	struct worker *worker;
 
-	lockdep_assert_held(&pool->attach_mutex);
+	lockdep_assert_held(&wq_pool_attach_mutex);
 
 	/* is @cpu allowed for @pool? */
 	if (!cpumask_test_cpu(cpu, pool->attrs->cpumask))
@@ -4762,14 +4761,14 @@ int workqueue_online_cpu(unsigned int cpu)
 	mutex_lock(&wq_pool_mutex);
 
 	for_each_pool(pool, pi) {
-		mutex_lock(&pool->attach_mutex);
+		mutex_lock(&wq_pool_attach_mutex);
 
 		if (pool->cpu == cpu)
 			rebind_workers(pool);
 		else if (pool->cpu < 0)
 			restore_unbound_workers_cpumask(pool, cpu);
 
-		mutex_unlock(&pool->attach_mutex);
+		mutex_unlock(&wq_pool_attach_mutex);
 	}
 
 	/* update NUMA affinity of unbound workqueues */
-- 
2.9.5


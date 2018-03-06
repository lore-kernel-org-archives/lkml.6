Return-Path: <SRS0=gsCl=F4=gmail.com=htejun@kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-891914-1520357761-2-16802037786012209585
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01,
  LANGUAGES enfr, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='198.145.29.99', Host='mail.kernel.org', Country='US', FromHeader='org',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: SRS0=gsCl=F4=gmail.com=htejun@kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520357760; b=EOqEavttqvW2cDXZraPCsSRw20zM8kJ3MXSe26aj5omRG1I
    LbmnjdJKi6/WmPlZRogQnUseYwz6ISCA5Pxg9ACHVlTU6tqLebNxpvhOxOkK4hZH
    21DbRKw+vaZaXf2XwcGvaWiGRu2c/SqNqwQgorJEuSkVYorDPkL0uOIbU9SD8+wo
    Jhi3HBbnvQlH2eX4jpT7iqrYubCN2PvFb17Hx7rxoYnDU0ERn4707w8FBR7bytlX
    YozOLJXEwkY2V4t+AnrW1BGD9k9kQnD43acRSPUHpQbx3HGQQ+abN/v7KP0UNQPd
    kRE+gHIVB4LhjZaHA+hEeopDli4Dbzg6QQ+J7kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=sender:from:to:cc:subject:date:message-id
    :in-reply-to:references; s=arctest; t=1520357760; bh=YyBmo4kInCj
    52a9l6TvxOFqF/cRoHG/Cke3iQ6kgzvI=; b=NNqVogjD+R1KEZs6TlcPdQ1xQW5
    yzHsrS1e3wJszx10M17iT7IjJSWuwMNnEkM1tgAbte0ov/ROjTwFS0Smgv9itKEW
    vdSEiCvVXQ687vyWKaSFzhBJz6ux4NyYyxzee4N61MF3i0yBidHJ6aS7ELEb+Vk0
    wgxrkWT6LlaGhK3siyBkwlBM15FrhagtjAsEEJwNf2qsg33dBdf2dNFdHywnRSWR
    64lAnc7kiqcCTwSTYMOZz6x0a7p4DYPtjSsy2AWwnnOE4w4EmC/RsvjqS8NBiONV
    jrL3GaxOndVm/KSkiUDCechfz4U8Cn8E3rGac2zHNugjWH9XO8s9+N2ggjQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=O+EjZV1T x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom=SRS0=gsCl=F4=gmail.com=htejun@kernel.org smtp.helo=mail.kernel.org;
    x-aligned-from=domain_pass;
    x-category=clean score=0 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=N64hqeEd;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=O+EjZV1T x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom=SRS0=gsCl=F4=gmail.com=htejun@kernel.org smtp.helo=mail.kernel.org;
    x-aligned-from=domain_pass;
    x-category=clean score=0 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=N64hqeEd;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: security@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC93C20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=htejun@gmail.com
X-Google-Smtp-Source: AG47ELsSUJQcurjEmGgSkNKPOVGNtN5b2QuNr2nibg9LgAsUWQWkCJ6xkl32kMrHbf565eOCOy8scQ==
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: torvalds@linux-foundation.org,
	jannh@google.com,
	paulmck@linux.vnet.ibm.com,
	bcrl@kvack.org,
	viro@zeniv.linux.org.uk,
	kent.overstreet@gmail.com
Cc: security@kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@fb.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 7/7] RCU, workqueue: Implement rcu_work
Date: Tue,  6 Mar 2018 09:33:16 -0800
Message-Id: <20180306173316.3088458-7-tj@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180306173316.3088458-1-tj@kernel.org>
References: <20180306172657.3060270-1-tj@kernel.org>
 <20180306173316.3088458-1-tj@kernel.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

There are cases where RCU callback needs to be bounced to a sleepable
context.  This is currently done by the RCU callback queueing a work
item, which can be cumbersome to write and confusing to read.

This patch introduces rcu_work, a workqueue work variant which gets
executed after a RCU grace period, and converts the open coded
bouncing in fs/aio and kernel/cgroup.

v2: Use rcu_barrier() instead of synchronize_rcu() to wait for
    completion of previously queued rcu callback as per Paul.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
---
 fs/aio.c                    | 21 +++++-------------
 include/linux/cgroup-defs.h |  2 +-
 include/linux/workqueue.h   | 38 +++++++++++++++++++++++++++++++
 kernel/cgroup/cgroup.c      | 21 ++++++------------
 kernel/workqueue.c          | 54 +++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 106 insertions(+), 30 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 6bcd3fb..88d7927 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -115,8 +115,7 @@ struct kioctx {
 	struct page		**ring_pages;
 	long			nr_pages;
 
-	struct rcu_head		free_rcu;
-	struct work_struct	free_work;	/* see free_ioctx() */
+	struct rcu_work		free_rwork;	/* see free_ioctx() */
 
 	/*
 	 * signals when all in-flight requests are done
@@ -592,13 +591,12 @@ static int kiocb_cancel(struct aio_kiocb *kiocb)
 /*
  * free_ioctx() should be RCU delayed to synchronize against the RCU
  * protected lookup_ioctx() and also needs process context to call
- * aio_free_ring(), so the double bouncing through kioctx->free_rcu and
- * ->free_work.
+ * aio_free_ring().  Use rcu_work.
  */
 static void free_ioctx(struct work_struct *work)
 {
-	struct kioctx *ctx = container_of(work, struct kioctx, free_work);
-
+	struct kioctx *ctx = container_of(to_rcu_work(work), struct kioctx,
+					  free_rwork);
 	pr_debug("freeing %p\n", ctx);
 
 	aio_free_ring(ctx);
@@ -608,14 +606,6 @@ static void free_ioctx(struct work_struct *work)
 	kmem_cache_free(kioctx_cachep, ctx);
 }
 
-static void free_ioctx_rcufn(struct rcu_head *head)
-{
-	struct kioctx *ctx = container_of(head, struct kioctx, free_rcu);
-
-	INIT_WORK(&ctx->free_work, free_ioctx);
-	schedule_work(&ctx->free_work);
-}
-
 static void free_ioctx_reqs(struct percpu_ref *ref)
 {
 	struct kioctx *ctx = container_of(ref, struct kioctx, reqs);
@@ -625,7 +615,8 @@ static void free_ioctx_reqs(struct percpu_ref *ref)
 		complete(&ctx->rq_wait->comp);
 
 	/* Synchronize against RCU protected table->table[] dereferences */
-	call_rcu(&ctx->free_rcu, free_ioctx_rcufn);
+	INIT_RCU_WORK(&ctx->free_rwork, free_ioctx);
+	queue_rcu_work(system_wq, &ctx->free_rwork);
 }
 
 /*
diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 9f242b8..92d7640 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -151,8 +151,8 @@ struct cgroup_subsys_state {
 	atomic_t online_cnt;
 
 	/* percpu_ref killing and RCU release */
-	struct rcu_head rcu_head;
 	struct work_struct destroy_work;
+	struct rcu_work destroy_rwork;
 
 	/*
 	 * PI: the parent css.	Placed here for cache proximity to following
diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index bc0cda1..b39f3a4 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -13,6 +13,7 @@
 #include <linux/threads.h>
 #include <linux/atomic.h>
 #include <linux/cpumask.h>
+#include <linux/rcupdate.h>
 
 struct workqueue_struct;
 
@@ -120,6 +121,15 @@ struct delayed_work {
 	int cpu;
 };
 
+struct rcu_work {
+	struct work_struct work;
+	struct rcu_head rcu;
+
+	/* target workqueue and CPU ->rcu uses to queue ->work */
+	struct workqueue_struct *wq;
+	int cpu;
+};
+
 /**
  * struct workqueue_attrs - A struct for workqueue attributes.
  *
@@ -151,6 +161,11 @@ static inline struct delayed_work *to_delayed_work(struct work_struct *work)
 	return container_of(work, struct delayed_work, work);
 }
 
+static inline struct rcu_work *to_rcu_work(struct work_struct *work)
+{
+	return container_of(work, struct rcu_work, work);
+}
+
 struct execute_work {
 	struct work_struct work;
 };
@@ -266,6 +281,12 @@ static inline unsigned int work_static(struct work_struct *work) { return 0; }
 #define INIT_DEFERRABLE_WORK_ONSTACK(_work, _func)			\
 	__INIT_DELAYED_WORK_ONSTACK(_work, _func, TIMER_DEFERRABLE)
 
+#define INIT_RCU_WORK(_work, _func)					\
+	INIT_WORK(&(_work)->work, (_func))
+
+#define INIT_RCU_WORK_ONSTACK(_work, _func)				\
+	INIT_WORK_ONSTACK(&(_work)->work, (_func))
+
 /**
  * work_pending - Find out whether a work item is currently pending
  * @work: The work item in question
@@ -447,6 +468,8 @@ extern bool queue_delayed_work_on(int cpu, struct workqueue_struct *wq,
 			struct delayed_work *work, unsigned long delay);
 extern bool mod_delayed_work_on(int cpu, struct workqueue_struct *wq,
 			struct delayed_work *dwork, unsigned long delay);
+extern bool queue_rcu_work_on(int cpu, struct workqueue_struct *wq,
+			struct rcu_work *rwork);
 
 extern void flush_workqueue(struct workqueue_struct *wq);
 extern void drain_workqueue(struct workqueue_struct *wq);
@@ -463,6 +486,8 @@ extern bool flush_delayed_work(struct delayed_work *dwork);
 extern bool cancel_delayed_work(struct delayed_work *dwork);
 extern bool cancel_delayed_work_sync(struct delayed_work *dwork);
 
+extern bool flush_rcu_work(struct rcu_work *rwork);
+
 extern void workqueue_set_max_active(struct workqueue_struct *wq,
 				     int max_active);
 extern struct work_struct *current_work(void);
@@ -520,6 +545,19 @@ static inline bool mod_delayed_work(struct workqueue_struct *wq,
 }
 
 /**
+ * queue_rcu_work - queue work on a workqueue after a RCU grace period
+ * @wq: workqueue to use
+ * @rwork: RCU work to queue
+ *
+ * Equivalent to queue_rcu_work_on() but tries to use the local CPU.
+ */
+static inline bool queue_rcu_work(struct workqueue_struct *wq,
+				  struct rcu_work *rwork)
+{
+	return queue_rcu_work_on(WORK_CPU_UNBOUND, wq, rwork);
+}
+
+/**
  * schedule_work_on - put work task on a specific cpu
  * @cpu: cpu to put the work task on
  * @work: job to be done
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 8cda3bc..4c5d4ca0 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -4514,10 +4514,10 @@ static struct cftype cgroup_base_files[] = {
  * and thus involve punting to css->destroy_work adding two additional
  * steps to the already complex sequence.
  */
-static void css_free_work_fn(struct work_struct *work)
+static void css_free_rwork_fn(struct work_struct *work)
 {
-	struct cgroup_subsys_state *css =
-		container_of(work, struct cgroup_subsys_state, destroy_work);
+	struct cgroup_subsys_state *css = container_of(to_rcu_work(work),
+				struct cgroup_subsys_state, destroy_rwork);
 	struct cgroup_subsys *ss = css->ss;
 	struct cgroup *cgrp = css->cgroup;
 
@@ -4563,15 +4563,6 @@ static void css_free_work_fn(struct work_struct *work)
 	}
 }
 
-static void css_free_rcu_fn(struct rcu_head *rcu_head)
-{
-	struct cgroup_subsys_state *css =
-		container_of(rcu_head, struct cgroup_subsys_state, rcu_head);
-
-	INIT_WORK(&css->destroy_work, css_free_work_fn);
-	queue_work(cgroup_destroy_wq, &css->destroy_work);
-}
-
 static void css_release_work_fn(struct work_struct *work)
 {
 	struct cgroup_subsys_state *css =
@@ -4621,7 +4612,8 @@ static void css_release_work_fn(struct work_struct *work)
 
 	mutex_unlock(&cgroup_mutex);
 
-	call_rcu(&css->rcu_head, css_free_rcu_fn);
+	INIT_RCU_WORK(&css->destroy_rwork, css_free_rwork_fn);
+	queue_rcu_work(cgroup_destroy_wq, &css->destroy_rwork);
 }
 
 static void css_release(struct percpu_ref *ref)
@@ -4755,7 +4747,8 @@ static struct cgroup_subsys_state *css_create(struct cgroup *cgrp,
 err_list_del:
 	list_del_rcu(&css->sibling);
 err_free_css:
-	call_rcu(&css->rcu_head, css_free_rcu_fn);
+	INIT_RCU_WORK(&css->destroy_rwork, css_free_rwork_fn);
+	queue_rcu_work(cgroup_destroy_wq, &css->destroy_rwork);
 	return ERR_PTR(err);
 }
 
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index bb9a519..e26c2f4 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1604,6 +1604,40 @@ bool mod_delayed_work_on(int cpu, struct workqueue_struct *wq,
 }
 EXPORT_SYMBOL_GPL(mod_delayed_work_on);
 
+static void rcu_work_rcufn(struct rcu_head *rcu)
+{
+	struct rcu_work *rwork = container_of(rcu, struct rcu_work, rcu);
+
+	/* read the comment in __queue_work() */
+	local_irq_disable();
+	__queue_work(rwork->cpu, rwork->wq, &rwork->work);
+	local_irq_enable();
+}
+
+/**
+ * queue_rcu_work_on - queue work on specific CPU after a RCU grace period
+ * @cpu: CPU number to execute work on
+ * @wq: workqueue to use
+ * @rwork: work to queue
+ *
+ * Return: %false if @work was already on a queue, %true otherwise.
+ */
+bool queue_rcu_work_on(int cpu, struct workqueue_struct *wq,
+		       struct rcu_work *rwork)
+{
+	struct work_struct *work = &rwork->work;
+
+	if (!test_and_set_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(work))) {
+		rwork->wq = wq;
+		rwork->cpu = cpu;
+		call_rcu(&rwork->rcu, rcu_work_rcufn);
+		return true;
+	}
+
+	return false;
+}
+EXPORT_SYMBOL(queue_rcu_work_on);
+
 /**
  * worker_enter_idle - enter idle state
  * @worker: worker which is entering idle state
@@ -3001,6 +3035,26 @@ bool flush_delayed_work(struct delayed_work *dwork)
 }
 EXPORT_SYMBOL(flush_delayed_work);
 
+/**
+ * flush_rcu_work - wait for a rwork to finish executing the last queueing
+ * @rwork: the rcu work to flush
+ *
+ * Return:
+ * %true if flush_rcu_work() waited for the work to finish execution,
+ * %false if it was already idle.
+ */
+bool flush_rcu_work(struct rcu_work *rwork)
+{
+	if (test_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(&rwork->work))) {
+		rcu_barrier();
+		flush_work(&rwork->work);
+		return true;
+	} else {
+		return flush_work(&rwork->work);
+	}
+}
+EXPORT_SYMBOL(flush_rcu_work);
+
 static bool __cancel_work(struct work_struct *work, bool is_dwork)
 {
 	unsigned long flags;
-- 
2.9.5

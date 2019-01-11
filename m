Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 760FAC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 21:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BFDD21841
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 21:20:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725803AbfAKVUq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 16:20:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:35630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725308AbfAKVUp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 16:20:45 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D90AF21783;
        Fri, 11 Jan 2019 21:20:42 +0000 (UTC)
Date:   Fri, 11 Jan 2019 16:20:41 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [ANNOUNCE] 4.14.87-rt50
Message-ID: <20190111162041.7b1b1bde@gandalf.local.home>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Dear RT Folks,

I'm pleased to announce the 4.14.87-rt50 stable release.

Note, I added: 

  drm/i915: skip DRM_I915_LOW_LEVEL_TRACEPOINTS with NOTRACE

 since -rc1.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.14-rt
  Head SHA1: 84da59e78fdd19601c8cd209c192075c2a7dc6fd


Or to build 4.14.87-rt50 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v4.x/linux-4.14.tar.xz

  http://www.kernel.org/pub/linux/kernel/v4.x/patch-4.14.87.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.14/patch-4.14.87-rt50.patch.xz



You can also build from 4.14.87-rt49 by applying the incremental patch:

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.14/incr/patch-4.14.87-rt49-rt50.patch.xz



Enjoy,

-- Steve


Changes from v4.14.87-rt49:

---

Clark Williams (1):
      mm/kasan: make quarantine_lock a raw_spinlock_t

He Zhe (1):
      kmemleak: Turn kmemleak_lock to raw spinlock on RT

Julia Cartwright (1):
      kthread: convert worker lock to raw spinlock

Kurt Kanzenbach (1):
      tty: serial: pl011: explicitly initialize the flags variable

Lukas Wunner (1):
      pinctrl: bcm2835: Use raw spinlock for RT compatibility

Sebastian Andrzej Siewior (8):
      work-simple: drop a shit statement in SWORK_EVENT_PENDING
      sched/migrate_disable: Add export_symbol_gpl for __migrate_disabled
      rcu: make RCU_BOOST default on RT without EXPERT
      x86/fpu: Disable preemption around local_bh_disable()
      hrtimer: move state change before hrtimer_cancel in do_nanosleep()
      drm/i915: disable tracing on -RT
      x86/mm/pat: disable preemption __split_large_page() after spin_lock()
      drm/i915: skip DRM_I915_LOW_LEVEL_TRACEPOINTS with NOTRACE

Steven Rostedt (VMware) (1):
      Linux 4.14.87-rt50

----
 arch/x86/kernel/fpu/signal.c          |  2 ++
 arch/x86/mm/pageattr.c                |  8 +++++++
 drivers/gpu/drm/i915/i915_trace.h     |  6 ++++-
 drivers/pinctrl/bcm/pinctrl-bcm2835.c | 16 ++++++-------
 drivers/tty/serial/amba-pl011.c       |  2 +-
 include/linux/kthread.h               |  2 +-
 kernel/kthread.c                      | 42 +++++++++++++++++------------------
 kernel/rcu/Kconfig                    |  4 ++--
 kernel/sched/core.c                   |  1 +
 kernel/sched/swork.c                  |  2 +-
 kernel/time/hrtimer.c                 |  2 +-
 localversion-rt                       |  2 +-
 mm/kasan/quarantine.c                 | 18 +++++++--------
 mm/kmemleak.c                         | 20 ++++++++---------
 14 files changed, 71 insertions(+), 56 deletions(-)
---------------------------
diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index d99a8ee9e185..5e0274a94133 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -344,10 +344,12 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
 			sanitize_restored_xstate(tsk, &env, xfeatures, fx_only);
 		}
 
+		preempt_disable();
 		local_bh_disable();
 		fpu->initialized = 1;
 		fpu__restore(fpu);
 		local_bh_enable();
+		preempt_enable();
 
 		return err;
 	} else {
diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
index 835620ab435f..57a04ef6fe47 100644
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -661,12 +661,18 @@ __split_large_page(struct cpa_data *cpa, pte_t *kpte, unsigned long address,
 	pgprot_t ref_prot;
 
 	spin_lock(&pgd_lock);
+	/*
+	 * Keep preemption disabled after __flush_tlb_all() which expects not be
+	 * preempted during the flush of the local TLB.
+	 */
+	preempt_disable();
 	/*
 	 * Check for races, another CPU might have split this page
 	 * up for us already:
 	 */
 	tmp = _lookup_address_cpa(cpa, address, &level);
 	if (tmp != kpte) {
+		preempt_enable();
 		spin_unlock(&pgd_lock);
 		return 1;
 	}
@@ -696,6 +702,7 @@ __split_large_page(struct cpa_data *cpa, pte_t *kpte, unsigned long address,
 		break;
 
 	default:
+		preempt_enable();
 		spin_unlock(&pgd_lock);
 		return 1;
 	}
@@ -743,6 +750,7 @@ __split_large_page(struct cpa_data *cpa, pte_t *kpte, unsigned long address,
 	 * going on.
 	 */
 	__flush_tlb_all();
+	preempt_enable();
 	spin_unlock(&pgd_lock);
 
 	return 0;
diff --git a/drivers/gpu/drm/i915/i915_trace.h b/drivers/gpu/drm/i915/i915_trace.h
index ef72da74b87f..a8a349d6d0fa 100644
--- a/drivers/gpu/drm/i915/i915_trace.h
+++ b/drivers/gpu/drm/i915/i915_trace.h
@@ -2,6 +2,10 @@
 #if !defined(_I915_TRACE_H_) || defined(TRACE_HEADER_MULTI_READ)
 #define _I915_TRACE_H_
 
+#ifdef CONFIG_PREEMPT_RT_BASE
+#define NOTRACE
+#endif
+
 #include <linux/stringify.h>
 #include <linux/types.h>
 #include <linux/tracepoint.h>
@@ -703,7 +707,7 @@ DEFINE_EVENT(i915_gem_request, i915_gem_request_add,
 	    TP_ARGS(req)
 );
 
-#if defined(CONFIG_DRM_I915_LOW_LEVEL_TRACEPOINTS)
+#if defined(CONFIG_DRM_I915_LOW_LEVEL_TRACEPOINTS) && !defined(NOTRACE)
 DEFINE_EVENT(i915_gem_request, i915_gem_request_submit,
 	     TP_PROTO(struct drm_i915_gem_request *req),
 	     TP_ARGS(req)
diff --git a/drivers/pinctrl/bcm/pinctrl-bcm2835.c b/drivers/pinctrl/bcm/pinctrl-bcm2835.c
index ff782445dfb7..e72bf2502eca 100644
--- a/drivers/pinctrl/bcm/pinctrl-bcm2835.c
+++ b/drivers/pinctrl/bcm/pinctrl-bcm2835.c
@@ -92,7 +92,7 @@ struct bcm2835_pinctrl {
 	struct gpio_chip gpio_chip;
 	struct pinctrl_gpio_range gpio_range;
 
-	spinlock_t irq_lock[BCM2835_NUM_BANKS];
+	raw_spinlock_t irq_lock[BCM2835_NUM_BANKS];
 };
 
 /* pins are just named GPIO0..GPIO53 */
@@ -471,10 +471,10 @@ static void bcm2835_gpio_irq_enable(struct irq_data *data)
 	unsigned bank = GPIO_REG_OFFSET(gpio);
 	unsigned long flags;
 
-	spin_lock_irqsave(&pc->irq_lock[bank], flags);
+	raw_spin_lock_irqsave(&pc->irq_lock[bank], flags);
 	set_bit(offset, &pc->enabled_irq_map[bank]);
 	bcm2835_gpio_irq_config(pc, gpio, true);
-	spin_unlock_irqrestore(&pc->irq_lock[bank], flags);
+	raw_spin_unlock_irqrestore(&pc->irq_lock[bank], flags);
 }
 
 static void bcm2835_gpio_irq_disable(struct irq_data *data)
@@ -486,12 +486,12 @@ static void bcm2835_gpio_irq_disable(struct irq_data *data)
 	unsigned bank = GPIO_REG_OFFSET(gpio);
 	unsigned long flags;
 
-	spin_lock_irqsave(&pc->irq_lock[bank], flags);
+	raw_spin_lock_irqsave(&pc->irq_lock[bank], flags);
 	bcm2835_gpio_irq_config(pc, gpio, false);
 	/* Clear events that were latched prior to clearing event sources */
 	bcm2835_gpio_set_bit(pc, GPEDS0, gpio);
 	clear_bit(offset, &pc->enabled_irq_map[bank]);
-	spin_unlock_irqrestore(&pc->irq_lock[bank], flags);
+	raw_spin_unlock_irqrestore(&pc->irq_lock[bank], flags);
 }
 
 static int __bcm2835_gpio_irq_set_type_disabled(struct bcm2835_pinctrl *pc,
@@ -594,7 +594,7 @@ static int bcm2835_gpio_irq_set_type(struct irq_data *data, unsigned int type)
 	unsigned long flags;
 	int ret;
 
-	spin_lock_irqsave(&pc->irq_lock[bank], flags);
+	raw_spin_lock_irqsave(&pc->irq_lock[bank], flags);
 
 	if (test_bit(offset, &pc->enabled_irq_map[bank]))
 		ret = __bcm2835_gpio_irq_set_type_enabled(pc, gpio, type);
@@ -606,7 +606,7 @@ static int bcm2835_gpio_irq_set_type(struct irq_data *data, unsigned int type)
 	else
 		irq_set_handler_locked(data, handle_level_irq);
 
-	spin_unlock_irqrestore(&pc->irq_lock[bank], flags);
+	raw_spin_unlock_irqrestore(&pc->irq_lock[bank], flags);
 
 	return ret;
 }
@@ -1021,7 +1021,7 @@ static int bcm2835_pinctrl_probe(struct platform_device *pdev)
 		for_each_set_bit(offset, &events, 32)
 			bcm2835_gpio_wr(pc, GPEDS0 + i * 4, BIT(offset));
 
-		spin_lock_init(&pc->irq_lock[i]);
+		raw_spin_lock_init(&pc->irq_lock[i]);
 	}
 
 	err = gpiochip_add_data(&pc->gpio_chip, pc);
diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 81d6b15fb80a..9379db8aec9a 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2231,7 +2231,7 @@ pl011_console_write(struct console *co, const char *s, unsigned int count)
 {
 	struct uart_amba_port *uap = amba_ports[co->index];
 	unsigned int old_cr = 0, new_cr;
-	unsigned long flags;
+	unsigned long flags = 0;
 	int locked = 1;
 
 	clk_enable(uap->clk);
diff --git a/include/linux/kthread.h b/include/linux/kthread.h
index 4e26609c77d4..4e0449df82c3 100644
--- a/include/linux/kthread.h
+++ b/include/linux/kthread.h
@@ -84,7 +84,7 @@ enum {
 
 struct kthread_worker {
 	unsigned int		flags;
-	spinlock_t		lock;
+	raw_spinlock_t		lock;
 	struct list_head	work_list;
 	struct list_head	delayed_work_list;
 	struct task_struct	*task;
diff --git a/kernel/kthread.c b/kernel/kthread.c
index 4e6d85b63201..430fd79cd3fe 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -579,7 +579,7 @@ void __kthread_init_worker(struct kthread_worker *worker,
 				struct lock_class_key *key)
 {
 	memset(worker, 0, sizeof(struct kthread_worker));
-	spin_lock_init(&worker->lock);
+	raw_spin_lock_init(&worker->lock);
 	lockdep_set_class_and_name(&worker->lock, key, name);
 	INIT_LIST_HEAD(&worker->work_list);
 	INIT_LIST_HEAD(&worker->delayed_work_list);
@@ -621,21 +621,21 @@ int kthread_worker_fn(void *worker_ptr)
 
 	if (kthread_should_stop()) {
 		__set_current_state(TASK_RUNNING);
-		spin_lock_irq(&worker->lock);
+		raw_spin_lock_irq(&worker->lock);
 		worker->task = NULL;
-		spin_unlock_irq(&worker->lock);
+		raw_spin_unlock_irq(&worker->lock);
 		return 0;
 	}
 
 	work = NULL;
-	spin_lock_irq(&worker->lock);
+	raw_spin_lock_irq(&worker->lock);
 	if (!list_empty(&worker->work_list)) {
 		work = list_first_entry(&worker->work_list,
 					struct kthread_work, node);
 		list_del_init(&work->node);
 	}
 	worker->current_work = work;
-	spin_unlock_irq(&worker->lock);
+	raw_spin_unlock_irq(&worker->lock);
 
 	if (work) {
 		__set_current_state(TASK_RUNNING);
@@ -792,12 +792,12 @@ bool kthread_queue_work(struct kthread_worker *worker,
 	bool ret = false;
 	unsigned long flags;
 
-	spin_lock_irqsave(&worker->lock, flags);
+	raw_spin_lock_irqsave(&worker->lock, flags);
 	if (!queuing_blocked(worker, work)) {
 		kthread_insert_work(worker, work, &worker->work_list);
 		ret = true;
 	}
-	spin_unlock_irqrestore(&worker->lock, flags);
+	raw_spin_unlock_irqrestore(&worker->lock, flags);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(kthread_queue_work);
@@ -824,7 +824,7 @@ void kthread_delayed_work_timer_fn(unsigned long __data)
 	if (WARN_ON_ONCE(!worker))
 		return;
 
-	spin_lock(&worker->lock);
+	raw_spin_lock(&worker->lock);
 	/* Work must not be used with >1 worker, see kthread_queue_work(). */
 	WARN_ON_ONCE(work->worker != worker);
 
@@ -833,7 +833,7 @@ void kthread_delayed_work_timer_fn(unsigned long __data)
 	list_del_init(&work->node);
 	kthread_insert_work(worker, work, &worker->work_list);
 
-	spin_unlock(&worker->lock);
+	raw_spin_unlock(&worker->lock);
 }
 EXPORT_SYMBOL(kthread_delayed_work_timer_fn);
 
@@ -890,14 +890,14 @@ bool kthread_queue_delayed_work(struct kthread_worker *worker,
 	unsigned long flags;
 	bool ret = false;
 
-	spin_lock_irqsave(&worker->lock, flags);
+	raw_spin_lock_irqsave(&worker->lock, flags);
 
 	if (!queuing_blocked(worker, work)) {
 		__kthread_queue_delayed_work(worker, dwork, delay);
 		ret = true;
 	}
 
-	spin_unlock_irqrestore(&worker->lock, flags);
+	raw_spin_unlock_irqrestore(&worker->lock, flags);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(kthread_queue_delayed_work);
@@ -933,7 +933,7 @@ void kthread_flush_work(struct kthread_work *work)
 	if (!worker)
 		return;
 
-	spin_lock_irq(&worker->lock);
+	raw_spin_lock_irq(&worker->lock);
 	/* Work must not be used with >1 worker, see kthread_queue_work(). */
 	WARN_ON_ONCE(work->worker != worker);
 
@@ -945,7 +945,7 @@ void kthread_flush_work(struct kthread_work *work)
 	else
 		noop = true;
 
-	spin_unlock_irq(&worker->lock);
+	raw_spin_unlock_irq(&worker->lock);
 
 	if (!noop)
 		wait_for_completion(&fwork.done);
@@ -978,9 +978,9 @@ static bool __kthread_cancel_work(struct kthread_work *work, bool is_dwork,
 		 * any queuing is blocked by setting the canceling counter.
 		 */
 		work->canceling++;
-		spin_unlock_irqrestore(&worker->lock, *flags);
+		raw_spin_unlock_irqrestore(&worker->lock, *flags);
 		del_timer_sync(&dwork->timer);
-		spin_lock_irqsave(&worker->lock, *flags);
+		raw_spin_lock_irqsave(&worker->lock, *flags);
 		work->canceling--;
 	}
 
@@ -1027,7 +1027,7 @@ bool kthread_mod_delayed_work(struct kthread_worker *worker,
 	unsigned long flags;
 	int ret = false;
 
-	spin_lock_irqsave(&worker->lock, flags);
+	raw_spin_lock_irqsave(&worker->lock, flags);
 
 	/* Do not bother with canceling when never queued. */
 	if (!work->worker)
@@ -1044,7 +1044,7 @@ bool kthread_mod_delayed_work(struct kthread_worker *worker,
 fast_queue:
 	__kthread_queue_delayed_work(worker, dwork, delay);
 out:
-	spin_unlock_irqrestore(&worker->lock, flags);
+	raw_spin_unlock_irqrestore(&worker->lock, flags);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(kthread_mod_delayed_work);
@@ -1058,7 +1058,7 @@ static bool __kthread_cancel_work_sync(struct kthread_work *work, bool is_dwork)
 	if (!worker)
 		goto out;
 
-	spin_lock_irqsave(&worker->lock, flags);
+	raw_spin_lock_irqsave(&worker->lock, flags);
 	/* Work must not be used with >1 worker, see kthread_queue_work(). */
 	WARN_ON_ONCE(work->worker != worker);
 
@@ -1072,13 +1072,13 @@ static bool __kthread_cancel_work_sync(struct kthread_work *work, bool is_dwork)
 	 * In the meantime, block any queuing by setting the canceling counter.
 	 */
 	work->canceling++;
-	spin_unlock_irqrestore(&worker->lock, flags);
+	raw_spin_unlock_irqrestore(&worker->lock, flags);
 	kthread_flush_work(work);
-	spin_lock_irqsave(&worker->lock, flags);
+	raw_spin_lock_irqsave(&worker->lock, flags);
 	work->canceling--;
 
 out_fast:
-	spin_unlock_irqrestore(&worker->lock, flags);
+	raw_spin_unlock_irqrestore(&worker->lock, flags);
 out:
 	return ret;
 }
diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index 0be2c96fb640..a243a78ff38c 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -36,7 +36,7 @@ config TINY_RCU
 
 config RCU_EXPERT
 	bool "Make expert-level adjustments to RCU configuration"
-	default y if PREEMPT_RT_FULL
+	default n
 	help
 	  This option needs to be enabled if you wish to make
 	  expert-level adjustments to RCU configuration.  By default,
@@ -190,7 +190,7 @@ config RCU_FAST_NO_HZ
 
 config RCU_BOOST
 	bool "Enable RCU priority boosting"
-	depends on RT_MUTEXES && PREEMPT_RCU && RCU_EXPERT
+	depends on (RT_MUTEXES && PREEMPT_RCU && RCU_EXPERT) || PREEMPT_RT_FULL
 	default y if PREEMPT_RT_FULL
 	help
 	  This option boosts the priority of preempted RCU readers that
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 6ce950f24a7f..7c960cf07e7b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1112,6 +1112,7 @@ int __migrate_disabled(struct task_struct *p)
 {
 	return p->migrate_disable;
 }
+EXPORT_SYMBOL_GPL(__migrate_disabled);
 #endif
 
 static void __do_set_cpus_allowed_tail(struct task_struct *p,
diff --git a/kernel/sched/swork.c b/kernel/sched/swork.c
index 1950f40ca725..5559c22f664c 100644
--- a/kernel/sched/swork.c
+++ b/kernel/sched/swork.c
@@ -12,7 +12,7 @@
 #include <linux/spinlock.h>
 #include <linux/export.h>
 
-#define SWORK_EVENT_PENDING     (1 << 0)
+#define SWORK_EVENT_PENDING     1
 
 static DEFINE_MUTEX(worker_mutex);
 static struct sworker *glob_worker;
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index b59e009087a9..c8d806126381 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1753,12 +1753,12 @@ static int __sched do_nanosleep(struct hrtimer_sleeper *t, enum hrtimer_mode mod
 		if (likely(t->task))
 			freezable_schedule();
 
+		__set_current_state(TASK_RUNNING);
 		hrtimer_cancel(&t->timer);
 		mode = HRTIMER_MODE_ABS;
 
 	} while (t->task && !signal_pending(current));
 
-	__set_current_state(TASK_RUNNING);
 
 	if (!t->task)
 		return 0;
diff --git a/localversion-rt b/localversion-rt
index 4b7dca68a5b4..42c384668389 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt49
+-rt50
diff --git a/mm/kasan/quarantine.c b/mm/kasan/quarantine.c
index 3a8ddf8baf7d..b209dbaefde8 100644
--- a/mm/kasan/quarantine.c
+++ b/mm/kasan/quarantine.c
@@ -103,7 +103,7 @@ static int quarantine_head;
 static int quarantine_tail;
 /* Total size of all objects in global_quarantine across all batches. */
 static unsigned long quarantine_size;
-static DEFINE_SPINLOCK(quarantine_lock);
+static DEFINE_RAW_SPINLOCK(quarantine_lock);
 DEFINE_STATIC_SRCU(remove_cache_srcu);
 
 /* Maximum size of the global queue. */
@@ -190,7 +190,7 @@ void quarantine_put(struct kasan_free_meta *info, struct kmem_cache *cache)
 	if (unlikely(q->bytes > QUARANTINE_PERCPU_SIZE)) {
 		qlist_move_all(q, &temp);
 
-		spin_lock(&quarantine_lock);
+		raw_spin_lock(&quarantine_lock);
 		WRITE_ONCE(quarantine_size, quarantine_size + temp.bytes);
 		qlist_move_all(&temp, &global_quarantine[quarantine_tail]);
 		if (global_quarantine[quarantine_tail].bytes >=
@@ -203,7 +203,7 @@ void quarantine_put(struct kasan_free_meta *info, struct kmem_cache *cache)
 			if (new_tail != quarantine_head)
 				quarantine_tail = new_tail;
 		}
-		spin_unlock(&quarantine_lock);
+		raw_spin_unlock(&quarantine_lock);
 	}
 
 	local_irq_restore(flags);
@@ -230,7 +230,7 @@ void quarantine_reduce(void)
 	 * expected case).
 	 */
 	srcu_idx = srcu_read_lock(&remove_cache_srcu);
-	spin_lock_irqsave(&quarantine_lock, flags);
+	raw_spin_lock_irqsave(&quarantine_lock, flags);
 
 	/*
 	 * Update quarantine size in case of hotplug. Allocate a fraction of
@@ -254,7 +254,7 @@ void quarantine_reduce(void)
 			quarantine_head = 0;
 	}
 
-	spin_unlock_irqrestore(&quarantine_lock, flags);
+	raw_spin_unlock_irqrestore(&quarantine_lock, flags);
 
 	qlist_free_all(&to_free, NULL);
 	srcu_read_unlock(&remove_cache_srcu, srcu_idx);
@@ -310,17 +310,17 @@ void quarantine_remove_cache(struct kmem_cache *cache)
 	 */
 	on_each_cpu(per_cpu_remove_cache, cache, 1);
 
-	spin_lock_irqsave(&quarantine_lock, flags);
+	raw_spin_lock_irqsave(&quarantine_lock, flags);
 	for (i = 0; i < QUARANTINE_BATCHES; i++) {
 		if (qlist_empty(&global_quarantine[i]))
 			continue;
 		qlist_move_cache(&global_quarantine[i], &to_free, cache);
 		/* Scanning whole quarantine can take a while. */
-		spin_unlock_irqrestore(&quarantine_lock, flags);
+		raw_spin_unlock_irqrestore(&quarantine_lock, flags);
 		cond_resched();
-		spin_lock_irqsave(&quarantine_lock, flags);
+		raw_spin_lock_irqsave(&quarantine_lock, flags);
 	}
-	spin_unlock_irqrestore(&quarantine_lock, flags);
+	raw_spin_unlock_irqrestore(&quarantine_lock, flags);
 
 	qlist_free_all(&to_free, cache);
 
diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index d9e0be2a8189..98876d2f17b5 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -26,7 +26,7 @@
  *
  * The following locks and mutexes are used by kmemleak:
  *
- * - kmemleak_lock (rwlock): protects the object_list modifications and
+ * - kmemleak_lock (raw spinlock): protects the object_list modifications and
  *   accesses to the object_tree_root. The object_list is the main list
  *   holding the metadata (struct kmemleak_object) for the allocated memory
  *   blocks. The object_tree_root is a red black tree used to look-up
@@ -198,7 +198,7 @@ static LIST_HEAD(gray_list);
 /* search tree for object boundaries */
 static struct rb_root object_tree_root = RB_ROOT;
 /* rw_lock protecting the access to object_list and object_tree_root */
-static DEFINE_RWLOCK(kmemleak_lock);
+static DEFINE_RAW_SPINLOCK(kmemleak_lock);
 
 /* allocation caches for kmemleak internal data */
 static struct kmem_cache *object_cache;
@@ -492,9 +492,9 @@ static struct kmemleak_object *find_and_get_object(unsigned long ptr, int alias)
 	struct kmemleak_object *object;
 
 	rcu_read_lock();
-	read_lock_irqsave(&kmemleak_lock, flags);
+	raw_spin_lock_irqsave(&kmemleak_lock, flags);
 	object = lookup_object(ptr, alias);
-	read_unlock_irqrestore(&kmemleak_lock, flags);
+	raw_spin_unlock_irqrestore(&kmemleak_lock, flags);
 
 	/* check whether the object is still available */
 	if (object && !get_object(object))
@@ -514,13 +514,13 @@ static struct kmemleak_object *find_and_remove_object(unsigned long ptr, int ali
 	unsigned long flags;
 	struct kmemleak_object *object;
 
-	write_lock_irqsave(&kmemleak_lock, flags);
+	raw_spin_lock_irqsave(&kmemleak_lock, flags);
 	object = lookup_object(ptr, alias);
 	if (object) {
 		rb_erase(&object->rb_node, &object_tree_root);
 		list_del_rcu(&object->object_list);
 	}
-	write_unlock_irqrestore(&kmemleak_lock, flags);
+	raw_spin_unlock_irqrestore(&kmemleak_lock, flags);
 
 	return object;
 }
@@ -594,7 +594,7 @@ static struct kmemleak_object *create_object(unsigned long ptr, size_t size,
 	/* kernel backtrace */
 	object->trace_len = __save_stack_trace(object->trace);
 
-	write_lock_irqsave(&kmemleak_lock, flags);
+	raw_spin_lock_irqsave(&kmemleak_lock, flags);
 
 	min_addr = min(min_addr, ptr);
 	max_addr = max(max_addr, ptr + size);
@@ -625,7 +625,7 @@ static struct kmemleak_object *create_object(unsigned long ptr, size_t size,
 
 	list_add_tail_rcu(&object->object_list, &object_list);
 out:
-	write_unlock_irqrestore(&kmemleak_lock, flags);
+	raw_spin_unlock_irqrestore(&kmemleak_lock, flags);
 	return object;
 }
 
@@ -1301,7 +1301,7 @@ static void scan_block(void *_start, void *_end,
 	unsigned long *end = _end - (BYTES_PER_POINTER - 1);
 	unsigned long flags;
 
-	read_lock_irqsave(&kmemleak_lock, flags);
+	raw_spin_lock_irqsave(&kmemleak_lock, flags);
 	for (ptr = start; ptr < end; ptr++) {
 		struct kmemleak_object *object;
 		unsigned long pointer;
@@ -1358,7 +1358,7 @@ static void scan_block(void *_start, void *_end,
 			spin_unlock(&object->lock);
 		}
 	}
-	read_unlock_irqrestore(&kmemleak_lock, flags);
+	raw_spin_unlock_irqrestore(&kmemleak_lock, flags);
 }
 
 /*

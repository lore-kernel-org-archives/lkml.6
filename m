Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBCA9C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 19:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C73621738
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 19:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547061410;
	bh=Iay99IRdm5RRuQ/wkTgH6zWukAxx9sRkd6mj/wuCZTU=;
	h=Subject:From:To:Cc:Date:List-ID:From;
	b=Ms1vKfs6wjiNmG3joBcTmUQ80/VO0sWrm+by1Zg7z6OGoGpJYXODqZ0aEPomvN3jd
	 evOE1eHiyaxKQYduVNF+ncUf8rvHaawidDitTUP+IeImQz3vRMCLb5OpUgnRR9nB1X
	 UvNEPJLowUtbA1xHo7hlea9vy1wExkM7eXYWJhx4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728174AbfAITQu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 14:16:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:59220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726469AbfAITQt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 14:16:49 -0500
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C35A20685;
        Wed,  9 Jan 2019 19:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547061407;
        bh=Iay99IRdm5RRuQ/wkTgH6zWukAxx9sRkd6mj/wuCZTU=;
        h=Subject:From:To:Cc:Date:From;
        b=JcNOBjoGyFoN3EHTlIHv4ufk9c/a47VVzwSw6xAmoNc+c+I+DFGVktjw0iahxS9yI
         Gmw0SoLGdi7Fgz56CT1Dl96G0mAeBgHhkH5MJikZiSu0QpkoJxCUOH9yyFseJAyBU8
         rivJxYiQOwkjxI7vScrewnyq0dHnoz6sMJxKARE8=
Message-ID: <1547061406.6258.4.camel@kernel.org>
Subject: [ANNOUNCE] 3.18.129-rt111
From:   Tom Zanussi <zanussi@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        Julia Cartwright <julia@ni.com>
Date:   Wed, 09 Jan 2019 13:16:46 -0600
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT Folks!

I'm pleased to announce the 3.18.129-rt111 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v3.18-rt
  Head SHA1: abae91683efc5c482d2fbbad07010decde532360

Or to build 3.18.129-rt111 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v3.x/linux-3.18.tar.xz

  http://www.kernel.org/pub/linux/kernel/v3.x/patch-3.18.129.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.18/patch-3.18.129-rt111.patch.xz


You can also build from 3.18.129-rt110 by applying the incremental patch:

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.18/incr/patch-3.18.129-rt110-rt111.patch.xz

Enjoy!
   
   Tom

Changes from v3.18.129-rt110:
---
Daniel Bristot de Oliveira (1):
      sched/core: Avoid __schedule() being called twice in a row

Kurt Kanzenbach (1):
      tty: serial: pl011: explicitly initialize the flags variable

Lukas Wunner (1):
      pinctrl: bcm2835: Use raw spinlock for RT compatibility

Sebastian Andrzej Siewior (5):
      efi: Allow efi=runtime
      efi: Disable runtime services on RT
      crypto: cryptd - add a lock instead preempt_disable/local_bh_disable
      work-simple: drop a shit statement in SWORK_EVENT_PENDING
      drm/i915: disable tracing on -RT

Tom Zanussi (1):
      Linux 3.18.129-rt111

---
 crypto/cryptd.c                   | 18 ++++++++----------
 drivers/firmware/efi/efi.c        |  5 ++++-
 drivers/gpu/drm/i915/i915_trace.h |  4 ++++
 drivers/pinctrl/pinctrl-bcm2835.c | 16 ++++++++--------
 drivers/tty/serial/amba-pl011.c   |  2 +-
 kernel/sched/core.c               |  9 +++++++--
 kernel/sched/work-simple.c        |  2 +-
 localversion-rt                   |  2 +-
 8 files changed, 34 insertions(+), 24 deletions(-)
---
diff --git a/crypto/cryptd.c b/crypto/cryptd.c
index 828ead458c09..ec32d9bf4651 100644
--- a/crypto/cryptd.c
+++ b/crypto/cryptd.c
@@ -36,6 +36,7 @@
 struct cryptd_cpu_queue {
 	struct crypto_queue queue;
 	struct work_struct work;
+	spinlock_t qlock;
 };
 
 struct cryptd_queue {
@@ -97,6 +98,7 @@ static int cryptd_init_queue(struct cryptd_queue *queue,
 		cpu_queue = per_cpu_ptr(queue->cpu_queue, cpu);
 		crypto_init_queue(&cpu_queue->queue, max_cpu_qlen);
 		INIT_WORK(&cpu_queue->work, cryptd_queue_worker);
+		spin_lock_init(&cpu_queue->qlock);
 	}
 	return 0;
 }
@@ -119,11 +121,12 @@ static int cryptd_enqueue_request(struct cryptd_queue *queue,
 	int cpu, err;
 	struct cryptd_cpu_queue *cpu_queue;
 
-	cpu = get_cpu();
-	cpu_queue = this_cpu_ptr(queue->cpu_queue);
+	cpu_queue = raw_cpu_ptr(queue->cpu_queue);
+	spin_lock_bh(&cpu_queue->qlock);
+	cpu = smp_processor_id();
 	err = crypto_enqueue_request(&cpu_queue->queue, request);
 	queue_work_on(cpu, kcrypto_wq, &cpu_queue->work);
-	put_cpu();
+	spin_unlock_bh(&cpu_queue->qlock);
 
 	return err;
 }
@@ -139,16 +142,11 @@ static void cryptd_queue_worker(struct work_struct *work)
 	cpu_queue = container_of(work, struct cryptd_cpu_queue, work);
 	/*
 	 * Only handle one request at a time to avoid hogging crypto workqueue.
-	 * preempt_disable/enable is used to prevent being preempted by
-	 * cryptd_enqueue_request(). local_bh_disable/enable is used to prevent
-	 * cryptd_enqueue_request() being accessed from software interrupts.
 	 */
-	local_bh_disable();
-	preempt_disable();
+	spin_lock_bh(&cpu_queue->qlock);
 	backlog = crypto_get_backlog(&cpu_queue->queue);
 	req = crypto_dequeue_request(&cpu_queue->queue);
-	preempt_enable();
-	local_bh_enable();
+	spin_unlock_bh(&cpu_queue->qlock);
 
 	if (!req)
 		return;
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 297066df6946..f2be407247e5 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -41,7 +41,7 @@ struct efi __read_mostly efi = {
 };
 EXPORT_SYMBOL(efi);
 
-static bool disable_runtime;
+static bool disable_runtime = IS_ENABLED(CONFIG_PREEMPT_RT_BASE);
 static int __init setup_noefi(char *arg)
 {
 	disable_runtime = true;
@@ -59,6 +59,9 @@ static int __init parse_efi_cmdline(char *str)
 	if (parse_option_str(str, "noruntime"))
 		disable_runtime = true;
 
+	if (parse_option_str(str, "runtime"))
+		disable_runtime = false;
+
 	return 0;
 }
 early_param("efi", parse_efi_cmdline);
diff --git a/drivers/gpu/drm/i915/i915_trace.h b/drivers/gpu/drm/i915/i915_trace.h
index f5aa0067755a..3b37567b76c8 100644
--- a/drivers/gpu/drm/i915/i915_trace.h
+++ b/drivers/gpu/drm/i915/i915_trace.h
@@ -1,6 +1,10 @@
 #if !defined(_I915_TRACE_H_) || defined(TRACE_HEADER_MULTI_READ)
 #define _I915_TRACE_H_
 
+#ifdef CONFIG_PREEMPT_RT_BASE
+#define NOTRACE
+#endif
+
 #include <linux/stringify.h>
 #include <linux/types.h>
 #include <linux/tracepoint.h>
diff --git a/drivers/pinctrl/pinctrl-bcm2835.c b/drivers/pinctrl/pinctrl-bcm2835.c
index eabba02f71f9..9a975a12b8e3 100644
--- a/drivers/pinctrl/pinctrl-bcm2835.c
+++ b/drivers/pinctrl/pinctrl-bcm2835.c
@@ -106,7 +106,7 @@ struct bcm2835_pinctrl {
 	struct pinctrl_gpio_range gpio_range;
 
 	struct bcm2835_gpio_irqdata irq_data[BCM2835_NUM_BANKS];
-	spinlock_t irq_lock[BCM2835_NUM_BANKS];
+	raw_spinlock_t irq_lock[BCM2835_NUM_BANKS];
 };
 
 static struct lock_class_key gpio_lock_class;
@@ -465,10 +465,10 @@ static void bcm2835_gpio_irq_enable(struct irq_data *data)
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
@@ -479,10 +479,10 @@ static void bcm2835_gpio_irq_disable(struct irq_data *data)
 	unsigned bank = GPIO_REG_OFFSET(gpio);
 	unsigned long flags;
 
-	spin_lock_irqsave(&pc->irq_lock[bank], flags);
+	raw_spin_lock_irqsave(&pc->irq_lock[bank], flags);
 	bcm2835_gpio_irq_config(pc, gpio, false);
 	clear_bit(offset, &pc->enabled_irq_map[bank]);
-	spin_unlock_irqrestore(&pc->irq_lock[bank], flags);
+	raw_spin_unlock_irqrestore(&pc->irq_lock[bank], flags);
 }
 
 static int __bcm2835_gpio_irq_set_type_disabled(struct bcm2835_pinctrl *pc,
@@ -584,14 +584,14 @@ static int bcm2835_gpio_irq_set_type(struct irq_data *data, unsigned int type)
 	unsigned long flags;
 	int ret;
 
-	spin_lock_irqsave(&pc->irq_lock[bank], flags);
+	raw_spin_lock_irqsave(&pc->irq_lock[bank], flags);
 
 	if (test_bit(offset, &pc->enabled_irq_map[bank]))
 		ret = __bcm2835_gpio_irq_set_type_enabled(pc, gpio, type);
 	else
 		ret = __bcm2835_gpio_irq_set_type_disabled(pc, gpio, type);
 
-	spin_unlock_irqrestore(&pc->irq_lock[bank], flags);
+	raw_spin_unlock_irqrestore(&pc->irq_lock[bank], flags);
 
 	return ret;
 }
@@ -1004,7 +1004,7 @@ static int bcm2835_pinctrl_probe(struct platform_device *pdev)
 		pc->irq[i] = irq_of_parse_and_map(np, i);
 		pc->irq_data[i].pc = pc;
 		pc->irq_data[i].bank = i;
-		spin_lock_init(&pc->irq_lock[i]);
+		raw_spin_lock_init(&pc->irq_lock[i]);
 
 		len = strlen(dev_name(pc->dev)) + 16;
 		name = devm_kzalloc(pc->dev, len, GFP_KERNEL);
diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 5ef2c62bb904..dede68aa679e 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1930,7 +1930,7 @@ pl011_console_write(struct console *co, const char *s, unsigned int count)
 {
 	struct uart_amba_port *uap = amba_ports[co->index];
 	unsigned int status, old_cr, new_cr;
-	unsigned long flags;
+	unsigned long flags = 0;
 	int locked = 1;
 
 	clk_enable(uap->clk);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d5534f439b4a..500c319fcfc5 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3114,10 +3114,15 @@ static inline void sched_submit_work(struct task_struct *tsk)
 	/*
 	 * If a worker went to sleep, notify and ask workqueue whether
 	 * it wants to wake up a task to maintain concurrency.
+	 * As this function is called inside the schedule() context,
+	 * we disable preemption to avoid it calling schedule() again
+	 * in the possible wakeup of a kworker.
 	 */
-	if (tsk->flags & PF_WQ_WORKER)
+	if (tsk->flags & PF_WQ_WORKER) {
+		preempt_disable();
 		wq_worker_sleeping(tsk);
-
+		preempt_enable_no_resched();
+	}
 
 	if (tsk_is_pi_blocked(tsk))
 		return;
diff --git a/kernel/sched/work-simple.c b/kernel/sched/work-simple.c
index c996f755dba6..4284dd37aebe 100644
--- a/kernel/sched/work-simple.c
+++ b/kernel/sched/work-simple.c
@@ -11,7 +11,7 @@
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 
-#define SWORK_EVENT_PENDING     (1 << 0)
+#define SWORK_EVENT_PENDING     1
 
 static DEFINE_MUTEX(worker_mutex);
 static struct sworker *glob_worker;
diff --git a/localversion-rt b/localversion-rt
index b3e668a8fb94..9969a4b69fad 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt110
+-rt111

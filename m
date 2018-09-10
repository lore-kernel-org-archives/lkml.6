Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3BBFC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 21:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17D5D20866
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 21:48:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17D5D20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbeIKCoj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 22:44:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:37580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726217AbeIKCoj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 22:44:39 -0400
Received: from vmware.local.home (unknown [208.91.3.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2E3020865;
        Mon, 10 Sep 2018 21:48:33 +0000 (UTC)
Date:   Mon, 10 Sep 2018 17:48:30 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com
Subject: [ANNOUNCE] 4.14.63-rt41
Message-ID: <20180910174830.68263da3@vmware.local.home>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Dear RT Folks,

I'm pleased to announce the 4.14.63-rt41 stable release.


You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.14-rt
  Head SHA1: 6ec5ce3dc682aea62bddef8365160819dbb0ca55


Or to build 4.14.63-rt41 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v4.x/linux-4.14.tar.xz

  http://www.kernel.org/pub/linux/kernel/v4.x/patch-4.14.63.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.14/patch-4.14.63-rt41.patch.xz



You can also build from 4.14.63-rt40 by applying the incremental patch:

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.14/incr/patch-4.14.63-rt40-rt41.patch.xz



Enjoy,

-- Steve


Changes from v4.14.63-rt40:

---

Anna-Maria Gleixner (1):
      Revert "timer: delay waking softirqs from the jiffy tick"

Daniel Bristot de Oliveira (1):
      sched/core: Avoid __schedule() being called twice in a row

Julia Cartwright (3):
      locallock: provide {get,put}_locked_ptr() variants
      squashfs: make use of local lock in multi_cpu decompressor
      seqlock: provide the same ordering semantics as mainline

Marc Zyngier (1):
      irqchip/gic-v3-its: Move pending table allocation to init time

Mike Galbraith (3):
      sched/fair: Fix CFS bandwidth control lockdep DEADLOCK report
      crypto: scompress - serialize RT percpu scratch buffer access with a local lock
      sched: Allow pinned user tasks to be awakened to the CPU they pinned

Sebastian Andrzej Siewior (12):
      PM / suspend: Prevent might sleep splats (updated)
      PM / wakeup: Make events_lock a RAW_SPINLOCK
      PM / s2idle: Make s2idle_wait_head swait based
      Revert "x86: UV: raw_spinlock conversion"
      irqchip/gic-v3-its: Make its_lock a raw_spin_lock_t
      sched/migrate_disable: fallback to preempt_disable() instead barrier()
      irqchip/gic-v3-its: Move ITS' ->pend_page allocation into an early CPU up hook
      efi: Allow efi=runtime
      efi: Disable runtime services on RT
      crypto: cryptd - add a lock instead preempt_disable/local_bh_disable
      Revert "arm64/xen: Make XEN depend on !RT"
      Drivers: hv: vmbus: include header for get_irq_regs()

Steven Rostedt (VMware) (2):
      Revert "softirq: keep the 'softirq pending' check RT-only"
      Linux 4.14.63-rt41

Thomas Gleixner (1):
      x86/ioapic: Don't let setaffinity unmask threaded EOI interrupt too early

----
 arch/arm64/Kconfig                      |  2 +-
 arch/x86/include/asm/uv/uv_bau.h        | 14 +++----
 arch/x86/kernel/apic/io_apic.c          | 26 +++++++------
 arch/x86/platform/uv/tlb_uv.c           | 26 ++++++-------
 arch/x86/platform/uv/uv_time.c          | 20 ++++------
 crypto/cryptd.c                         | 19 +++++-----
 crypto/scompress.c                      |  6 ++-
 drivers/base/power/wakeup.c             | 18 ++++-----
 drivers/firmware/efi/efi.c              |  5 ++-
 drivers/hv/hyperv_vmbus.h               |  1 +
 drivers/irqchip/irq-gic-v3-its.c        | 67 ++++++++++++++++++++++-----------
 fs/squashfs/decompressor_multi_percpu.c | 16 ++++++--
 include/linux/irqchip/arm-gic-v3.h      |  1 +
 include/linux/locallock.h               | 10 +++++
 include/linux/preempt.h                 |  6 +--
 include/linux/sched.h                   |  4 +-
 include/linux/seqlock.h                 |  1 +
 kernel/power/suspend.c                  |  9 +++--
 kernel/sched/core.c                     | 34 +++++++++--------
 kernel/sched/debug.c                    |  2 +-
 kernel/sched/fair.c                     |  4 +-
 kernel/softirq.c                        |  7 +---
 kernel/time/tick-common.c               |  2 +
 kernel/time/timer.c                     |  2 +-
 localversion-rt                         |  2 +-
 25 files changed, 176 insertions(+), 128 deletions(-)
---------------------------
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 6ccd878c32c2..ebc261c8620b 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -792,7 +792,7 @@ config XEN_DOM0
 
 config XEN
 	bool "Xen guest support on ARM64"
-	depends on ARM64 && OF && !PREEMPT_RT_FULL
+	depends on ARM64 && OF
 	select SWIOTLB_XEN
 	select PARAVIRT
 	help
diff --git a/arch/x86/include/asm/uv/uv_bau.h b/arch/x86/include/asm/uv/uv_bau.h
index 2ac6e347bdc5..7cac79802ad2 100644
--- a/arch/x86/include/asm/uv/uv_bau.h
+++ b/arch/x86/include/asm/uv/uv_bau.h
@@ -643,9 +643,9 @@ struct bau_control {
 	cycles_t		send_message;
 	cycles_t		period_end;
 	cycles_t		period_time;
-	raw_spinlock_t		uvhub_lock;
-	raw_spinlock_t		queue_lock;
-	raw_spinlock_t		disable_lock;
+	spinlock_t		uvhub_lock;
+	spinlock_t		queue_lock;
+	spinlock_t		disable_lock;
 	/* tunables */
 	int			max_concurr;
 	int			max_concurr_const;
@@ -847,15 +847,15 @@ static inline int atom_asr(short i, struct atomic_short *v)
  * to be lowered below the current 'v'.  atomic_add_unless can only stop
  * on equal.
  */
-static inline int atomic_inc_unless_ge(raw_spinlock_t *lock, atomic_t *v, int u)
+static inline int atomic_inc_unless_ge(spinlock_t *lock, atomic_t *v, int u)
 {
-	raw_spin_lock(lock);
+	spin_lock(lock);
 	if (atomic_read(v) >= u) {
-		raw_spin_unlock(lock);
+		spin_unlock(lock);
 		return 0;
 	}
 	atomic_inc(v);
-	raw_spin_unlock(lock);
+	spin_unlock(lock);
 	return 1;
 }
 
diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 5832a9d657f2..c9af5afebc4a 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -1688,20 +1688,20 @@ static bool io_apic_level_ack_pending(struct mp_chip_data *data)
 	return false;
 }
 
-static inline bool ioapic_irqd_mask(struct irq_data *data)
+static inline bool ioapic_prepare_move(struct irq_data *data)
 {
 	/* If we are moving the irq we need to mask it */
-	if (unlikely(irqd_is_setaffinity_pending(data) &&
-		     !irqd_irq_inprogress(data))) {
-		mask_ioapic_irq(data);
+	if (unlikely(irqd_is_setaffinity_pending(data))) {
+		if (!irqd_irq_masked(data))
+			mask_ioapic_irq(data);
 		return true;
 	}
 	return false;
 }
 
-static inline void ioapic_irqd_unmask(struct irq_data *data, bool masked)
+static inline void ioapic_finish_move(struct irq_data *data, bool moveit)
 {
-	if (unlikely(masked)) {
+	if (unlikely(moveit)) {
 		/* Only migrate the irq if the ack has been received.
 		 *
 		 * On rare occasions the broadcast level triggered ack gets
@@ -1730,15 +1730,17 @@ static inline void ioapic_irqd_unmask(struct irq_data *data, bool masked)
 		 */
 		if (!io_apic_level_ack_pending(data->chip_data))
 			irq_move_masked_irq(data);
-		unmask_ioapic_irq(data);
+		/* If the irq is masked in the core, leave it */
+		if (!irqd_irq_masked(data))
+			unmask_ioapic_irq(data);
 	}
 }
 #else
-static inline bool ioapic_irqd_mask(struct irq_data *data)
+static inline bool ioapic_prepare_move(struct irq_data *data)
 {
 	return false;
 }
-static inline void ioapic_irqd_unmask(struct irq_data *data, bool masked)
+static inline void ioapic_finish_move(struct irq_data *data, bool moveit)
 {
 }
 #endif
@@ -1747,11 +1749,11 @@ static void ioapic_ack_level(struct irq_data *irq_data)
 {
 	struct irq_cfg *cfg = irqd_cfg(irq_data);
 	unsigned long v;
-	bool masked;
+	bool moveit;
 	int i;
 
 	irq_complete_move(cfg);
-	masked = ioapic_irqd_mask(irq_data);
+	moveit = ioapic_prepare_move(irq_data);
 
 	/*
 	 * It appears there is an erratum which affects at least version 0x11
@@ -1806,7 +1808,7 @@ static void ioapic_ack_level(struct irq_data *irq_data)
 		eoi_ioapic_pin(cfg->vector, irq_data->chip_data);
 	}
 
-	ioapic_irqd_unmask(irq_data, masked);
+	ioapic_finish_move(irq_data, moveit);
 }
 
 static void ioapic_ir_ack_level(struct irq_data *irq_data)
diff --git a/arch/x86/platform/uv/tlb_uv.c b/arch/x86/platform/uv/tlb_uv.c
index 5607611df740..34f9a9ce6236 100644
--- a/arch/x86/platform/uv/tlb_uv.c
+++ b/arch/x86/platform/uv/tlb_uv.c
@@ -740,9 +740,9 @@ static void destination_plugged(struct bau_desc *bau_desc,
 
 		quiesce_local_uvhub(hmaster);
 
-		raw_spin_lock(&hmaster->queue_lock);
+		spin_lock(&hmaster->queue_lock);
 		reset_with_ipi(&bau_desc->distribution, bcp);
-		raw_spin_unlock(&hmaster->queue_lock);
+		spin_unlock(&hmaster->queue_lock);
 
 		end_uvhub_quiesce(hmaster);
 
@@ -762,9 +762,9 @@ static void destination_timeout(struct bau_desc *bau_desc,
 
 		quiesce_local_uvhub(hmaster);
 
-		raw_spin_lock(&hmaster->queue_lock);
+		spin_lock(&hmaster->queue_lock);
 		reset_with_ipi(&bau_desc->distribution, bcp);
-		raw_spin_unlock(&hmaster->queue_lock);
+		spin_unlock(&hmaster->queue_lock);
 
 		end_uvhub_quiesce(hmaster);
 
@@ -785,7 +785,7 @@ static void disable_for_period(struct bau_control *bcp, struct ptc_stats *stat)
 	cycles_t tm1;
 
 	hmaster = bcp->uvhub_master;
-	raw_spin_lock(&hmaster->disable_lock);
+	spin_lock(&hmaster->disable_lock);
 	if (!bcp->baudisabled) {
 		stat->s_bau_disabled++;
 		tm1 = get_cycles();
@@ -798,7 +798,7 @@ static void disable_for_period(struct bau_control *bcp, struct ptc_stats *stat)
 			}
 		}
 	}
-	raw_spin_unlock(&hmaster->disable_lock);
+	spin_unlock(&hmaster->disable_lock);
 }
 
 static void count_max_concurr(int stat, struct bau_control *bcp,
@@ -861,7 +861,7 @@ static void record_send_stats(cycles_t time1, cycles_t time2,
  */
 static void uv1_throttle(struct bau_control *hmaster, struct ptc_stats *stat)
 {
-	raw_spinlock_t *lock = &hmaster->uvhub_lock;
+	spinlock_t *lock = &hmaster->uvhub_lock;
 	atomic_t *v;
 
 	v = &hmaster->active_descriptor_count;
@@ -995,7 +995,7 @@ static int check_enable(struct bau_control *bcp, struct ptc_stats *stat)
 	struct bau_control *hmaster;
 
 	hmaster = bcp->uvhub_master;
-	raw_spin_lock(&hmaster->disable_lock);
+	spin_lock(&hmaster->disable_lock);
 	if (bcp->baudisabled && (get_cycles() >= bcp->set_bau_on_time)) {
 		stat->s_bau_reenabled++;
 		for_each_present_cpu(tcpu) {
@@ -1007,10 +1007,10 @@ static int check_enable(struct bau_control *bcp, struct ptc_stats *stat)
 				tbcp->period_giveups = 0;
 			}
 		}
-		raw_spin_unlock(&hmaster->disable_lock);
+		spin_unlock(&hmaster->disable_lock);
 		return 0;
 	}
-	raw_spin_unlock(&hmaster->disable_lock);
+	spin_unlock(&hmaster->disable_lock);
 	return -1;
 }
 
@@ -1942,9 +1942,9 @@ static void __init init_per_cpu_tunables(void)
 		bcp->cong_reps			= congested_reps;
 		bcp->disabled_period		= sec_2_cycles(disabled_period);
 		bcp->giveup_limit		= giveup_limit;
-		raw_spin_lock_init(&bcp->queue_lock);
-		raw_spin_lock_init(&bcp->uvhub_lock);
-		raw_spin_lock_init(&bcp->disable_lock);
+		spin_lock_init(&bcp->queue_lock);
+		spin_lock_init(&bcp->uvhub_lock);
+		spin_lock_init(&bcp->disable_lock);
 	}
 }
 
diff --git a/arch/x86/platform/uv/uv_time.c b/arch/x86/platform/uv/uv_time.c
index badf377efc21..b082d71b08ee 100644
--- a/arch/x86/platform/uv/uv_time.c
+++ b/arch/x86/platform/uv/uv_time.c
@@ -57,7 +57,7 @@ static DEFINE_PER_CPU(struct clock_event_device, cpu_ced);
 
 /* There is one of these allocated per node */
 struct uv_rtc_timer_head {
-	raw_spinlock_t	lock;
+	spinlock_t	lock;
 	/* next cpu waiting for timer, local node relative: */
 	int		next_cpu;
 	/* number of cpus on this node: */
@@ -177,7 +177,7 @@ static __init int uv_rtc_allocate_timers(void)
 				uv_rtc_deallocate_timers();
 				return -ENOMEM;
 			}
-			raw_spin_lock_init(&head->lock);
+			spin_lock_init(&head->lock);
 			head->ncpus = uv_blade_nr_possible_cpus(bid);
 			head->next_cpu = -1;
 			blade_info[bid] = head;
@@ -231,7 +231,7 @@ static int uv_rtc_set_timer(int cpu, u64 expires)
 	unsigned long flags;
 	int next_cpu;
 
-	raw_spin_lock_irqsave(&head->lock, flags);
+	spin_lock_irqsave(&head->lock, flags);
 
 	next_cpu = head->next_cpu;
 	*t = expires;
@@ -243,12 +243,12 @@ static int uv_rtc_set_timer(int cpu, u64 expires)
 		if (uv_setup_intr(cpu, expires)) {
 			*t = ULLONG_MAX;
 			uv_rtc_find_next_timer(head, pnode);
-			raw_spin_unlock_irqrestore(&head->lock, flags);
+			spin_unlock_irqrestore(&head->lock, flags);
 			return -ETIME;
 		}
 	}
 
-	raw_spin_unlock_irqrestore(&head->lock, flags);
+	spin_unlock_irqrestore(&head->lock, flags);
 	return 0;
 }
 
@@ -267,7 +267,7 @@ static int uv_rtc_unset_timer(int cpu, int force)
 	unsigned long flags;
 	int rc = 0;
 
-	raw_spin_lock_irqsave(&head->lock, flags);
+	spin_lock_irqsave(&head->lock, flags);
 
 	if ((head->next_cpu == bcpu && uv_read_rtc(NULL) >= *t) || force)
 		rc = 1;
@@ -279,7 +279,7 @@ static int uv_rtc_unset_timer(int cpu, int force)
 			uv_rtc_find_next_timer(head, pnode);
 	}
 
-	raw_spin_unlock_irqrestore(&head->lock, flags);
+	spin_unlock_irqrestore(&head->lock, flags);
 
 	return rc;
 }
@@ -299,17 +299,13 @@ static int uv_rtc_unset_timer(int cpu, int force)
 static u64 uv_read_rtc(struct clocksource *cs)
 {
 	unsigned long offset;
-	u64 cycles;
 
-	preempt_disable();
 	if (uv_get_min_hub_revision_id() == 1)
 		offset = 0;
 	else
 		offset = (uv_blade_processor_id() * L1_CACHE_BYTES) % PAGE_SIZE;
 
-	cycles = (u64)uv_read_local_mmr(UVH_RTC | offset);
-	preempt_enable();
-	return cycles;
+	return (u64)uv_read_local_mmr(UVH_RTC | offset);
 }
 
 /*
diff --git a/crypto/cryptd.c b/crypto/cryptd.c
index 248f6ba41688..54b7985c8caa 100644
--- a/crypto/cryptd.c
+++ b/crypto/cryptd.c
@@ -37,6 +37,7 @@
 struct cryptd_cpu_queue {
 	struct crypto_queue queue;
 	struct work_struct work;
+	spinlock_t qlock;
 };
 
 struct cryptd_queue {
@@ -115,6 +116,7 @@ static int cryptd_init_queue(struct cryptd_queue *queue,
 		cpu_queue = per_cpu_ptr(queue->cpu_queue, cpu);
 		crypto_init_queue(&cpu_queue->queue, max_cpu_qlen);
 		INIT_WORK(&cpu_queue->work, cryptd_queue_worker);
+		spin_lock_init(&cpu_queue->qlock);
 	}
 	return 0;
 }
@@ -139,8 +141,10 @@ static int cryptd_enqueue_request(struct cryptd_queue *queue,
 	atomic_t *refcnt;
 	bool may_backlog;
 
-	cpu = get_cpu();
-	cpu_queue = this_cpu_ptr(queue->cpu_queue);
+	cpu_queue = raw_cpu_ptr(queue->cpu_queue);
+	spin_lock_bh(&cpu_queue->qlock);
+	cpu = smp_processor_id();
+
 	err = crypto_enqueue_request(&cpu_queue->queue, request);
 
 	refcnt = crypto_tfm_ctx(request->tfm);
@@ -157,7 +161,7 @@ static int cryptd_enqueue_request(struct cryptd_queue *queue,
 	atomic_inc(refcnt);
 
 out_put_cpu:
-	put_cpu();
+	spin_unlock_bh(&cpu_queue->qlock);
 
 	return err;
 }
@@ -173,16 +177,11 @@ static void cryptd_queue_worker(struct work_struct *work)
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
diff --git a/crypto/scompress.c b/crypto/scompress.c
index 2075e2c4e7df..c6b4e265c6bf 100644
--- a/crypto/scompress.c
+++ b/crypto/scompress.c
@@ -24,6 +24,7 @@
 #include <linux/cryptouser.h>
 #include <net/netlink.h>
 #include <linux/scatterlist.h>
+#include <linux/locallock.h>
 #include <crypto/scatterwalk.h>
 #include <crypto/internal/acompress.h>
 #include <crypto/internal/scompress.h>
@@ -34,6 +35,7 @@ static void * __percpu *scomp_src_scratches;
 static void * __percpu *scomp_dst_scratches;
 static int scomp_scratch_users;
 static DEFINE_MUTEX(scomp_lock);
+static DEFINE_LOCAL_IRQ_LOCK(scomp_scratches_lock);
 
 #ifdef CONFIG_NET
 static int crypto_scomp_report(struct sk_buff *skb, struct crypto_alg *alg)
@@ -193,7 +195,7 @@ static int scomp_acomp_comp_decomp(struct acomp_req *req, int dir)
 	void **tfm_ctx = acomp_tfm_ctx(tfm);
 	struct crypto_scomp *scomp = *tfm_ctx;
 	void **ctx = acomp_request_ctx(req);
-	const int cpu = get_cpu();
+	const int cpu = local_lock_cpu(scomp_scratches_lock);
 	u8 *scratch_src = *per_cpu_ptr(scomp_src_scratches, cpu);
 	u8 *scratch_dst = *per_cpu_ptr(scomp_dst_scratches, cpu);
 	int ret;
@@ -228,7 +230,7 @@ static int scomp_acomp_comp_decomp(struct acomp_req *req, int dir)
 					 1);
 	}
 out:
-	put_cpu();
+	local_unlock_cpu(scomp_scratches_lock);
 	return ret;
 }
 
diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index cdd6f256da59..2269d379c92f 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -52,7 +52,7 @@ static void split_counters(unsigned int *cnt, unsigned int *inpr)
 /* A preserved old value of the events counter. */
 static unsigned int saved_count;
 
-static DEFINE_SPINLOCK(events_lock);
+static DEFINE_RAW_SPINLOCK(events_lock);
 
 static void pm_wakeup_timer_fn(unsigned long data);
 
@@ -180,9 +180,9 @@ void wakeup_source_add(struct wakeup_source *ws)
 	ws->active = false;
 	ws->last_time = ktime_get();
 
-	spin_lock_irqsave(&events_lock, flags);
+	raw_spin_lock_irqsave(&events_lock, flags);
 	list_add_rcu(&ws->entry, &wakeup_sources);
-	spin_unlock_irqrestore(&events_lock, flags);
+	raw_spin_unlock_irqrestore(&events_lock, flags);
 }
 EXPORT_SYMBOL_GPL(wakeup_source_add);
 
@@ -197,9 +197,9 @@ void wakeup_source_remove(struct wakeup_source *ws)
 	if (WARN_ON(!ws))
 		return;
 
-	spin_lock_irqsave(&events_lock, flags);
+	raw_spin_lock_irqsave(&events_lock, flags);
 	list_del_rcu(&ws->entry);
-	spin_unlock_irqrestore(&events_lock, flags);
+	raw_spin_unlock_irqrestore(&events_lock, flags);
 	synchronize_srcu(&wakeup_srcu);
 }
 EXPORT_SYMBOL_GPL(wakeup_source_remove);
@@ -844,7 +844,7 @@ bool pm_wakeup_pending(void)
 	unsigned long flags;
 	bool ret = false;
 
-	spin_lock_irqsave(&events_lock, flags);
+	raw_spin_lock_irqsave(&events_lock, flags);
 	if (events_check_enabled) {
 		unsigned int cnt, inpr;
 
@@ -852,7 +852,7 @@ bool pm_wakeup_pending(void)
 		ret = (cnt != saved_count || inpr > 0);
 		events_check_enabled = !ret;
 	}
-	spin_unlock_irqrestore(&events_lock, flags);
+	raw_spin_unlock_irqrestore(&events_lock, flags);
 
 	if (ret) {
 		pr_info("PM: Wakeup pending, aborting suspend\n");
@@ -941,13 +941,13 @@ bool pm_save_wakeup_count(unsigned int count)
 	unsigned long flags;
 
 	events_check_enabled = false;
-	spin_lock_irqsave(&events_lock, flags);
+	raw_spin_lock_irqsave(&events_lock, flags);
 	split_counters(&cnt, &inpr);
 	if (cnt == count && inpr == 0) {
 		saved_count = count;
 		events_check_enabled = true;
 	}
-	spin_unlock_irqrestore(&events_lock, flags);
+	raw_spin_unlock_irqrestore(&events_lock, flags);
 	return events_check_enabled;
 }
 
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index c3eefa126e3b..47093745a53c 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -74,7 +74,7 @@ static unsigned long *efi_tables[] = {
 	&efi.mem_attr_table,
 };
 
-static bool disable_runtime;
+static bool disable_runtime = IS_ENABLED(CONFIG_PREEMPT_RT_BASE);
 static int __init setup_noefi(char *arg)
 {
 	disable_runtime = true;
@@ -100,6 +100,9 @@ static int __init parse_efi_cmdline(char *str)
 	if (parse_option_str(str, "noruntime"))
 		disable_runtime = true;
 
+	if (parse_option_str(str, "runtime"))
+		disable_runtime = false;
+
 	return 0;
 }
 early_param("efi", parse_efi_cmdline);
diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index 49569f8fe038..a3608cd52805 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -30,6 +30,7 @@
 #include <linux/atomic.h>
 #include <linux/hyperv.h>
 #include <linux/interrupt.h>
+#include <linux/irq.h>
 
 /*
  * Timeout for services such as KVP and fcopy.
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 2ea39a83737f..a3e23d0fc4af 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -148,7 +148,7 @@ static struct {
 } vpe_proxy;
 
 static LIST_HEAD(its_nodes);
-static DEFINE_SPINLOCK(its_lock);
+static DEFINE_RAW_SPINLOCK(its_lock);
 static struct rdists *gic_rdists;
 static struct irq_domain *its_parent;
 
@@ -165,6 +165,7 @@ static DEFINE_RAW_SPINLOCK(vmovp_lock);
 static DEFINE_IDA(its_vpeid_ida);
 
 #define gic_data_rdist()		(raw_cpu_ptr(gic_rdists->rdist))
+#define gic_data_rdist_cpu(cpu)		(per_cpu_ptr(gic_rdists->rdist, cpu))
 #define gic_data_rdist_rd_base()	(gic_data_rdist()->rd_base)
 #define gic_data_rdist_vlpi_base()	(gic_data_rdist_rd_base() + SZ_128K)
 
@@ -1432,7 +1433,7 @@ static void its_free_prop_table(struct page *prop_page)
 		   get_order(LPI_PROPBASE_SZ));
 }
 
-static int __init its_alloc_lpi_tables(void)
+static int __init its_alloc_lpi_prop_table(void)
 {
 	phys_addr_t paddr;
 
@@ -1758,30 +1759,47 @@ static void its_free_pending_table(struct page *pt)
 		   get_order(max_t(u32, LPI_PENDBASE_SZ, SZ_64K)));
 }
 
-static void its_cpu_init_lpis(void)
+static int __init allocate_lpi_tables(void)
 {
-	void __iomem *rbase = gic_data_rdist_rd_base();
-	struct page *pend_page;
-	u64 val, tmp;
+	int err, cpu;
 
-	/* If we didn't allocate the pending table yet, do it now */
-	pend_page = gic_data_rdist()->pend_page;
-	if (!pend_page) {
-		phys_addr_t paddr;
+	err = its_alloc_lpi_prop_table();
+	if (err)
+		return err;
+
+	/*
+	 * We allocate all the pending tables anyway, as we may have a
+	 * mix of RDs that have had LPIs enabled, and some that
+	 * don't. We'll free the unused ones as each CPU comes online.
+	 */
+	for_each_possible_cpu(cpu) {
+		struct page *pend_page;
 
 		pend_page = its_allocate_pending_table(GFP_NOWAIT);
 		if (!pend_page) {
-			pr_err("Failed to allocate PENDBASE for CPU%d\n",
-			       smp_processor_id());
-			return;
+			pr_err("Failed to allocate PENDBASE for CPU%d\n", cpu);
+			return -ENOMEM;
 		}
 
-		paddr = page_to_phys(pend_page);
-		pr_info("CPU%d: using LPI pending table @%pa\n",
-			smp_processor_id(), &paddr);
-		gic_data_rdist()->pend_page = pend_page;
+		gic_data_rdist_cpu(cpu)->pend_page = pend_page;
 	}
 
+	return 0;
+}
+
+static void its_cpu_init_lpis(void)
+{
+	void __iomem *rbase = gic_data_rdist_rd_base();
+	struct page *pend_page;
+	phys_addr_t paddr;
+	u64 val, tmp;
+
+	if (gic_data_rdist()->lpi_enabled)
+		return;
+
+	pend_page = gic_data_rdist()->pend_page;
+	paddr = page_to_phys(pend_page);
+
 	/* Disable LPIs */
 	val = readl_relaxed(rbase + GICR_CTLR);
 	val &= ~GICR_CTLR_ENABLE_LPIS;
@@ -1843,6 +1861,10 @@ static void its_cpu_init_lpis(void)
 
 	/* Make sure the GIC has seen the above */
 	dsb(sy);
+	gic_data_rdist()->lpi_enabled = true;
+	pr_info("GICv3: CPU%d: using LPI pending table @%pa\n",
+		smp_processor_id(),
+		&paddr);
 }
 
 static void its_cpu_init_collection(void)
@@ -1850,7 +1872,7 @@ static void its_cpu_init_collection(void)
 	struct its_node *its;
 	int cpu;
 
-	spin_lock(&its_lock);
+	raw_spin_lock(&its_lock);
 	cpu = smp_processor_id();
 
 	list_for_each_entry(its, &its_nodes, entry) {
@@ -1892,7 +1914,7 @@ static void its_cpu_init_collection(void)
 		its_send_invall(its, &its->collections[cpu]);
 	}
 
-	spin_unlock(&its_lock);
+	raw_spin_unlock(&its_lock);
 }
 
 static struct its_device *its_find_device(struct its_node *its, u32 dev_id)
@@ -3041,9 +3063,9 @@ static int __init its_probe_one(struct resource *res,
 	if (err)
 		goto out_free_tables;
 
-	spin_lock(&its_lock);
+	raw_spin_lock(&its_lock);
 	list_add(&its->entry, &its_nodes);
-	spin_unlock(&its_lock);
+	raw_spin_unlock(&its_lock);
 
 	return 0;
 
@@ -3278,7 +3300,8 @@ int __init its_init(struct fwnode_handle *handle, struct rdists *rdists,
 	}
 
 	gic_rdists = rdists;
-	err = its_alloc_lpi_tables();
+
+	err = allocate_lpi_tables();
 	if (err)
 		return err;
 
diff --git a/fs/squashfs/decompressor_multi_percpu.c b/fs/squashfs/decompressor_multi_percpu.c
index 23a9c28ad8ea..6a73c4fa88e7 100644
--- a/fs/squashfs/decompressor_multi_percpu.c
+++ b/fs/squashfs/decompressor_multi_percpu.c
@@ -10,6 +10,7 @@
 #include <linux/slab.h>
 #include <linux/percpu.h>
 #include <linux/buffer_head.h>
+#include <linux/locallock.h>
 
 #include "squashfs_fs.h"
 #include "squashfs_fs_sb.h"
@@ -25,6 +26,8 @@ struct squashfs_stream {
 	void		*stream;
 };
 
+static DEFINE_LOCAL_IRQ_LOCK(stream_lock);
+
 void *squashfs_decompressor_create(struct squashfs_sb_info *msblk,
 						void *comp_opts)
 {
@@ -79,10 +82,15 @@ int squashfs_decompress(struct squashfs_sb_info *msblk, struct buffer_head **bh,
 {
 	struct squashfs_stream __percpu *percpu =
 			(struct squashfs_stream __percpu *) msblk->stream;
-	struct squashfs_stream *stream = get_cpu_ptr(percpu);
-	int res = msblk->decompressor->decompress(msblk, stream->stream, bh, b,
-		offset, length, output);
-	put_cpu_ptr(stream);
+	struct squashfs_stream *stream;
+	int res;
+
+	stream = get_locked_ptr(stream_lock, percpu);
+
+	res = msblk->decompressor->decompress(msblk, stream->stream, bh, b,
+			offset, length, output);
+
+	put_locked_ptr(stream_lock, stream);
 
 	if (res < 0)
 		ERROR("%s decompression failed, data probably corrupt\n",
diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index bacb499c512c..688f2565294c 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -568,6 +568,7 @@ struct rdists {
 		void __iomem	*rd_base;
 		struct page	*pend_page;
 		phys_addr_t	phys_base;
+		bool		lpi_enabled;
 	} __percpu		*rdist;
 	struct page		*prop_page;
 	int			id_bits;
diff --git a/include/linux/locallock.h b/include/linux/locallock.h
index d658c2552601..921eab83cd34 100644
--- a/include/linux/locallock.h
+++ b/include/linux/locallock.h
@@ -222,6 +222,14 @@ static inline int __local_unlock_irqrestore(struct local_irq_lock *lv,
 
 #define put_locked_var(lvar, var)	local_unlock(lvar);
 
+#define get_locked_ptr(lvar, var)					\
+	({								\
+		local_lock(lvar);					\
+		this_cpu_ptr(var);					\
+	})
+
+#define put_locked_ptr(lvar, var)	local_unlock(lvar);
+
 #define local_lock_cpu(lvar)						\
 	({								\
 		local_lock(lvar);					\
@@ -262,6 +270,8 @@ static inline void local_irq_lock_init(int lvar) { }
 
 #define get_locked_var(lvar, var)		get_cpu_var(var)
 #define put_locked_var(lvar, var)		put_cpu_var(var)
+#define get_locked_ptr(lvar, var)		get_cpu_ptr(var)
+#define put_locked_ptr(lvar, var)		put_cpu_ptr(var)
 
 #define local_lock_cpu(lvar)			get_cpu()
 #define local_unlock_cpu(lvar)			put_cpu()
diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index 0591df500e9d..6728662a81e8 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -224,7 +224,7 @@ do { \
 
 #define preemptible()	(preempt_count() == 0 && !irqs_disabled())
 
-#ifdef CONFIG_SMP
+#if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT_RT_BASE)
 
 extern void migrate_disable(void);
 extern void migrate_enable(void);
@@ -241,8 +241,8 @@ static inline int __migrate_disabled(struct task_struct *p)
 }
 
 #else
-#define migrate_disable()		barrier()
-#define migrate_enable()		barrier()
+#define migrate_disable()		preempt_disable()
+#define migrate_enable()		preempt_enable()
 static inline int __migrate_disabled(struct task_struct *p)
 {
 	return 0;
diff --git a/include/linux/sched.h b/include/linux/sched.h
index c26b5ff005ab..a6ffb552be01 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -626,7 +626,7 @@ struct task_struct {
 	int				nr_cpus_allowed;
 	const cpumask_t			*cpus_ptr;
 	cpumask_t			cpus_mask;
-#if defined(CONFIG_PREEMPT_COUNT) && defined(CONFIG_SMP)
+#if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT_RT_BASE)
 	int				migrate_disable;
 	int				migrate_disable_update;
 	int				pinned_on_cpu;
@@ -635,8 +635,8 @@ struct task_struct {
 # endif
 
 #elif !defined(CONFIG_SMP) && defined(CONFIG_PREEMPT_RT_BASE)
-	int				migrate_disable;
 # ifdef CONFIG_SCHED_DEBUG
+	int				migrate_disable;
 	int				migrate_disable_atomic;
 # endif
 #endif
diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index a59751276b94..107079a2d7ed 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -462,6 +462,7 @@ static inline unsigned read_seqbegin(seqlock_t *sl)
 		spin_unlock_wait(&sl->lock);
 		goto repeat;
 	}
+	smp_rmb();
 	return ret;
 }
 #endif
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 999236413460..b89605fe0e88 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -27,6 +27,7 @@
 #include <linux/export.h>
 #include <linux/suspend.h>
 #include <linux/syscore_ops.h>
+#include <linux/swait.h>
 #include <linux/ftrace.h>
 #include <trace/events/power.h>
 #include <linux/compiler.h>
@@ -57,7 +58,7 @@ EXPORT_SYMBOL_GPL(pm_suspend_global_flags);
 
 static const struct platform_suspend_ops *suspend_ops;
 static const struct platform_s2idle_ops *s2idle_ops;
-static DECLARE_WAIT_QUEUE_HEAD(s2idle_wait_head);
+static DECLARE_SWAIT_QUEUE_HEAD(s2idle_wait_head);
 
 enum s2idle_states __read_mostly s2idle_state;
 static DEFINE_RAW_SPINLOCK(s2idle_lock);
@@ -91,8 +92,8 @@ static void s2idle_enter(void)
 	/* Push all the CPUs into the idle loop. */
 	wake_up_all_idle_cpus();
 	/* Make the current CPU wait so it can enter the idle loop too. */
-	wait_event(s2idle_wait_head,
-		   s2idle_state == S2IDLE_STATE_WAKE);
+	swait_event(s2idle_wait_head,
+		    s2idle_state == S2IDLE_STATE_WAKE);
 
 	cpuidle_pause();
 	put_online_cpus();
@@ -159,7 +160,7 @@ void s2idle_wake(void)
 	raw_spin_lock_irqsave(&s2idle_lock, flags);
 	if (s2idle_state > S2IDLE_STATE_NONE) {
 		s2idle_state = S2IDLE_STATE_WAKE;
-		wake_up(&s2idle_wait_head);
+		swake_up(&s2idle_wait_head);
 	}
 	raw_spin_unlock_irqrestore(&s2idle_lock, flags);
 }
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e7817c6c44d2..6e6bd5262f23 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -980,7 +980,7 @@ static inline bool is_cpu_allowed(struct task_struct *p, int cpu)
 	if (!cpumask_test_cpu(cpu, p->cpus_ptr))
 		return false;
 
-	if (is_per_cpu_kthread(p))
+	if (is_per_cpu_kthread(p) || __migrate_disabled(p))
 		return cpu_online(cpu);
 
 	return cpu_active(cpu);
@@ -1107,7 +1107,7 @@ void set_cpus_allowed_common(struct task_struct *p, const struct cpumask *new_ma
 	p->nr_cpus_allowed = cpumask_weight(new_mask);
 }
 
-#if defined(CONFIG_PREEMPT_COUNT) && defined(CONFIG_SMP)
+#if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT_RT_BASE)
 int __migrate_disabled(struct task_struct *p)
 {
 	return p->migrate_disable;
@@ -1146,7 +1146,7 @@ static void __do_set_cpus_allowed_tail(struct task_struct *p,
 
 void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask)
 {
-#if defined(CONFIG_PREEMPT_COUNT) && defined(CONFIG_SMP)
+#if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT_RT_BASE)
 	if (__migrate_disabled(p)) {
 		lockdep_assert_held(&p->pi_lock);
 
@@ -1219,7 +1219,7 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
 	if (cpumask_test_cpu(task_cpu(p), new_mask) || __migrate_disabled(p))
 		goto out;
 
-#if defined(CONFIG_PREEMPT_COUNT) && defined(CONFIG_SMP)
+#if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT_RT_BASE)
 	if (__migrate_disabled(p)) {
 		p->migrate_disable_update = 1;
 		goto out;
@@ -3482,10 +3482,15 @@ static inline void sched_submit_work(struct task_struct *tsk)
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
@@ -6897,7 +6902,7 @@ const u32 sched_prio_to_wmult[40] = {
  /*  15 */ 119304647, 148102320, 186737708, 238609294, 286331153,
 };
 
-#if defined(CONFIG_PREEMPT_COUNT) && defined(CONFIG_SMP)
+#if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT_RT_BASE)
 
 static inline void
 update_nr_migratory(struct task_struct *p, long delta)
@@ -7048,45 +7053,44 @@ EXPORT_SYMBOL(migrate_enable);
 #elif !defined(CONFIG_SMP) && defined(CONFIG_PREEMPT_RT_BASE)
 void migrate_disable(void)
 {
+#ifdef CONFIG_SCHED_DEBUG
 	struct task_struct *p = current;
 
 	if (in_atomic() || irqs_disabled()) {
-#ifdef CONFIG_SCHED_DEBUG
 		p->migrate_disable_atomic++;
-#endif
 		return;
 	}
-#ifdef CONFIG_SCHED_DEBUG
+
 	if (unlikely(p->migrate_disable_atomic)) {
 		tracing_off();
 		WARN_ON_ONCE(1);
 	}
-#endif
 
 	p->migrate_disable++;
+#endif
+	barrier();
 }
 EXPORT_SYMBOL(migrate_disable);
 
 void migrate_enable(void)
 {
+#ifdef CONFIG_SCHED_DEBUG
 	struct task_struct *p = current;
 
 	if (in_atomic() || irqs_disabled()) {
-#ifdef CONFIG_SCHED_DEBUG
 		p->migrate_disable_atomic--;
-#endif
 		return;
 	}
 
-#ifdef CONFIG_SCHED_DEBUG
 	if (unlikely(p->migrate_disable_atomic)) {
 		tracing_off();
 		WARN_ON_ONCE(1);
 	}
-#endif
 
 	WARN_ON_ONCE(p->migrate_disable <= 0);
 	p->migrate_disable--;
+#endif
+	barrier();
 }
 EXPORT_SYMBOL(migrate_enable);
 #endif
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 3108da1ee253..b5b43861c2b6 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -1017,7 +1017,7 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
 		P(dl.runtime);
 		P(dl.deadline);
 	}
-#if defined(CONFIG_PREEMPT_COUNT) && defined(CONFIG_SMP)
+#if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT_RT_BASE)
 	P(migrate_disable);
 #endif
 	P(nr_cpus_allowed);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 36ef77839be4..51ecea4f5d16 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4684,9 +4684,9 @@ void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
 	cfs_b->period = ns_to_ktime(default_cfs_period());
 
 	INIT_LIST_HEAD(&cfs_b->throttled_cfs_rq);
-	hrtimer_init(&cfs_b->period_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED);
+	hrtimer_init(&cfs_b->period_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED_HARD);
 	cfs_b->period_timer.function = sched_cfs_period_timer;
-	hrtimer_init(&cfs_b->slack_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	hrtimer_init(&cfs_b->slack_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
 	cfs_b->slack_timer.function = sched_cfs_slack_timer;
 }
 
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 996b03fb8c53..ec801952785a 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -842,13 +842,8 @@ static inline void tick_irq_exit(void)
 	int cpu = smp_processor_id();
 
 	/* Make sure that timer wheel updates are propagated */
-#ifdef CONFIG_PREEMPT_RT_BASE
 	if ((idle_cpu(cpu) || tick_nohz_full_cpu(cpu)) &&
-	    !need_resched() && !local_softirq_pending())
-#else
-	if ((idle_cpu(cpu) && !need_resched()) || tick_nohz_full_cpu(cpu))
-#endif
-	{
+	    !need_resched() && !local_softirq_pending()) {
 		if (!in_irq())
 			tick_nohz_irq_exit();
 	}
diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
index 7f5a26c3a8ee..7a87a4488a5e 100644
--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -492,6 +492,7 @@ void tick_freeze(void)
 	if (tick_freeze_depth == num_online_cpus()) {
 		trace_suspend_resume(TPS("timekeeping_freeze"),
 				     smp_processor_id(), true);
+		system_state = SYSTEM_SUSPEND;
 		timekeeping_suspend();
 	} else {
 		tick_suspend_local();
@@ -515,6 +516,7 @@ void tick_unfreeze(void)
 
 	if (tick_freeze_depth == num_online_cpus()) {
 		timekeeping_resume();
+		system_state = SYSTEM_RUNNING;
 		trace_suspend_resume(TPS("timekeeping_freeze"),
 				     smp_processor_id(), false);
 	} else {
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index ff1d60d4c0cc..f57106c6e786 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1635,13 +1635,13 @@ void update_process_times(int user_tick)
 
 	/* Note: this timer irq context must be accounted for as well. */
 	account_process_tick(p, user_tick);
-	scheduler_tick();
 	run_local_timers();
 	rcu_check_callbacks(user_tick);
 #if defined(CONFIG_IRQ_WORK)
 	if (in_irq())
 		irq_work_tick();
 #endif
+	scheduler_tick();
 	if (IS_ENABLED(CONFIG_POSIX_TIMERS))
 		run_posix_cpu_timers(p);
 }
diff --git a/localversion-rt b/localversion-rt
index 2af6c89aee6d..629e0b4384b8 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt40
+-rt41

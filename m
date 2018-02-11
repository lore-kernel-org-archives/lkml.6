Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1468877-1518325061-2-18198898170520177469
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518325060; b=qPtHRamxRIlLLcdMck8y8pSWg4XcQpgnaHmLzezQWHig5e2
    MkNQjmSJk5VdJuGGGbJp/YvHjwJn6XknnKl5qYkm11zSewDOvlXqfF/aYMvenolM
    spMH9u3fEGkJgJ6JMglOHOKQuv9DILDqHhFm3FSap9eT9S14vep/SgZw4MZI3yOJ
    XrNOsHNi6GO9Gl7A9pmgFVKHcpheibX+wrxhLOJvW4nK6NhMud87rvl76nuBX3S+
    g6+QPfxCus+ztQoaPid0AzzlomBMFuOgyaS+dcp0YaIb/cqyoEeKsLYypm421Oom
    7w5lokTUMSjoZDD3hFfkhOnPBy7Mk5eoPWtL5Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518325060; bh=whkElfWWg9Xy9YLz6vk
    FPgtxnf7mkepFvj8cpoa0whU=; b=S1O0x5qqbPzJ3XAde5FwUhLzFEXkX5luPR5
    Qx31/zUh78rITbNKnhw6RhofqhrhL4TPwHhE9KcvJe+WxnjMunArNZEwwR9JTBRp
    abA+oMP3DqkWzZc4HeYKfVT/CMsVUh9ht50W9TWDi94A6kdbRWNxoi3BQPKoqqV6
    rsTc0U+gOkJaDwir+juk3z3nVLrUIPMUics4lHXCPVa6HaEDWvFJxx/dvuecl2Bu
    H5txCz+fknOchXM2nlLdkgGa9g8h3n/ujE/z6vML2xVNJxzMLblzanT9ZaBReOEl
    NJGkFgaibVz62+JLbUXxorn7Lc+3GtJvWCMjrXHAFnwKBaJPUbg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753614AbeBKEz6 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Feb 2018 23:55:58 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41707 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752795AbeBKEd5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:33:57 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Marcelo Tosatti" <mtosatti@redhat.com>,
        "Paolo Bonzini" <pbonzini@redhat.com>,
        "Peter Zijlstra" <peterz@infradead.org>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.978484144@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 129/136] x86: pvclock: Really remove the sched
 notifier for cross-cpu migrations
In-Reply-To: <lsq.1518323469.348919605@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.54-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Paolo Bonzini <pbonzini@redhat.com>

commit 73459e2a1ada09a68c02cc5b73f3116fc8194b3d upstream.

This reverts commits 0a4e6be9ca17c54817cf814b4b5aa60478c6df27
and 80f7fdb1c7f0f9266421f823964fd1962681f6ce.

The task migration notifier was originally introduced in order to support
the pvclock vsyscall with non-synchronized TSC, but KVM only supports it
with synchronized TSC.  Hence, on KVM the race condition is only needed
due to a bad implementation on the host side, and even then it's so rare
that it's mostly theoretical.

As far as KVM is concerned it's possible to fix the host, avoiding the
additional complexity in the vDSO and the (re)introduction of the task
migration notifier.

Xen, on the other hand, hasn't yet implemented vsyscall support at
all, so we do not care about its plans for non-synchronized TSC.

Reported-by: Peter Zijlstra <peterz@infradead.org>
Suggested-by: Marcelo Tosatti <mtosatti@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/include/asm/pvclock.h |  1 -
 arch/x86/kernel/pvclock.c      | 44 ------------------------------------------
 arch/x86/vdso/vclock_gettime.c | 34 ++++++++++++++------------------
 include/linux/sched.h          |  8 --------
 kernel/sched/core.c            | 15 --------------
 5 files changed, 15 insertions(+), 87 deletions(-)

--- a/arch/x86/include/asm/pvclock.h
+++ b/arch/x86/include/asm/pvclock.h
@@ -95,7 +95,6 @@ unsigned __pvclock_read_cycles(const str
 
 struct pvclock_vsyscall_time_info {
 	struct pvclock_vcpu_time_info pvti;
-	u32 migrate_count;
 } __attribute__((__aligned__(SMP_CACHE_BYTES)));
 
 #define PVTI_SIZE sizeof(struct pvclock_vsyscall_time_info)
--- a/arch/x86/kernel/pvclock.c
+++ b/arch/x86/kernel/pvclock.c
@@ -141,46 +141,7 @@ void pvclock_read_wallclock(struct pvclo
 	set_normalized_timespec(ts, now.tv_sec, now.tv_nsec);
 }
 
-static struct pvclock_vsyscall_time_info *pvclock_vdso_info;
-
-static struct pvclock_vsyscall_time_info *
-pvclock_get_vsyscall_user_time_info(int cpu)
-{
-	if (!pvclock_vdso_info) {
-		BUG();
-		return NULL;
-	}
-
-	return &pvclock_vdso_info[cpu];
-}
-
-struct pvclock_vcpu_time_info *pvclock_get_vsyscall_time_info(int cpu)
-{
-	return &pvclock_get_vsyscall_user_time_info(cpu)->pvti;
-}
-
 #ifdef CONFIG_X86_64
-static int pvclock_task_migrate(struct notifier_block *nb, unsigned long l,
-			        void *v)
-{
-	struct task_migration_notifier *mn = v;
-	struct pvclock_vsyscall_time_info *pvti;
-
-	pvti = pvclock_get_vsyscall_user_time_info(mn->from_cpu);
-
-	/* this is NULL when pvclock vsyscall is not initialized */
-	if (unlikely(pvti == NULL))
-		return NOTIFY_DONE;
-
-	pvti->migrate_count++;
-
-	return NOTIFY_DONE;
-}
-
-static struct notifier_block pvclock_migrate = {
-	.notifier_call = pvclock_task_migrate,
-};
-
 /*
  * Initialize the generic pvclock vsyscall state.  This will allocate
  * a/some page(s) for the per-vcpu pvclock information, set up a
@@ -194,17 +155,12 @@ int __init pvclock_init_vsyscall(struct
 
 	WARN_ON (size != PVCLOCK_VSYSCALL_NR_PAGES*PAGE_SIZE);
 
-	pvclock_vdso_info = i;
-
 	for (idx = 0; idx <= (PVCLOCK_FIXMAP_END-PVCLOCK_FIXMAP_BEGIN); idx++) {
 		__set_fixmap(PVCLOCK_FIXMAP_BEGIN + idx,
 			     __pa(i) + (idx*PAGE_SIZE),
 			     PAGE_KERNEL_VVAR);
 	}
 
-
-	register_task_migration_notifier(&pvclock_migrate);
-
 	return 0;
 }
 #endif
--- a/arch/x86/vdso/vclock_gettime.c
+++ b/arch/x86/vdso/vclock_gettime.c
@@ -82,15 +82,18 @@ static notrace cycle_t vread_pvclock(int
 	cycle_t ret;
 	u64 last;
 	u32 version;
-	u32 migrate_count;
 	u8 flags;
 	unsigned cpu, cpu1;
 
 
 	/*
-	 * When looping to get a consistent (time-info, tsc) pair, we
-	 * also need to deal with the possibility we can switch vcpus,
-	 * so make sure we always re-fetch time-info for the current vcpu.
+	 * Note: hypervisor must guarantee that:
+	 * 1. cpu ID number maps 1:1 to per-CPU pvclock time info.
+	 * 2. that per-CPU pvclock time info is updated if the
+	 *    underlying CPU changes.
+	 * 3. that version is increased whenever underlying CPU
+	 *    changes.
+	 *
 	 */
 	do {
 		cpu = __getcpu() & VGETCPU_CPU_MASK;
@@ -99,27 +102,20 @@ static notrace cycle_t vread_pvclock(int
 		 * __getcpu() calls (Gleb).
 		 */
 
-		/* Make sure migrate_count will change if we leave the VCPU. */
-		do {
-			pvti = get_pvti(cpu);
-			migrate_count = pvti->migrate_count;
-
-			cpu1 = cpu;
-			cpu = __getcpu() & VGETCPU_CPU_MASK;
-		} while (unlikely(cpu != cpu1));
+		pvti = get_pvti(cpu);
 
 		version = __pvclock_read_cycles(&pvti->pvti, &ret, &flags);
 
 		/*
 		 * Test we're still on the cpu as well as the version.
-		 * - We must read TSC of pvti's VCPU.
-		 * - KVM doesn't follow the versioning protocol, so data could
-		 *   change before version if we left the VCPU.
+		 * We could have been migrated just after the first
+		 * vgetcpu but before fetching the version, so we
+		 * wouldn't notice a version change.
 		 */
-		smp_rmb();
-	} while (unlikely((pvti->pvti.version & 1) ||
-			  pvti->pvti.version != version ||
-			  pvti->migrate_count != migrate_count));
+		cpu1 = __getcpu() & VGETCPU_CPU_MASK;
+	} while (unlikely(cpu != cpu1 ||
+			  (pvti->pvti.version & 1) ||
+			  pvti->pvti.version != version));
 
 	if (unlikely(!(flags & PVCLOCK_TSC_STABLE_BIT)))
 		*mode = VCLOCK_NONE;
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -174,14 +174,6 @@ extern unsigned long this_cpu_load(void)
 extern void calc_global_load(unsigned long ticks);
 extern void update_cpu_load_nohz(void);
 
-/* Notifier for when a task gets migrated to a new CPU */
-struct task_migration_notifier {
-	struct task_struct *task;
-	int from_cpu;
-	int to_cpu;
-};
-extern void register_task_migration_notifier(struct notifier_block *n);
-
 extern unsigned long get_parent_ip(unsigned long addr);
 
 extern void dump_cpu_task(int cpu);
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1041,13 +1041,6 @@ void check_preempt_curr(struct rq *rq, s
 		rq->skip_clock_update = 1;
 }
 
-static ATOMIC_NOTIFIER_HEAD(task_migration_notifier);
-
-void register_task_migration_notifier(struct notifier_block *n)
-{
-	atomic_notifier_chain_register(&task_migration_notifier, n);
-}
-
 #ifdef CONFIG_SMP
 void set_task_cpu(struct task_struct *p, unsigned int new_cpu)
 {
@@ -1078,18 +1071,10 @@ void set_task_cpu(struct task_struct *p,
 	trace_sched_migrate_task(p, new_cpu);
 
 	if (task_cpu(p) != new_cpu) {
-		struct task_migration_notifier tmn;
-
 		if (p->sched_class->migrate_task_rq)
 			p->sched_class->migrate_task_rq(p, new_cpu);
 		p->se.nr_migrations++;
 		perf_sw_event_sched(PERF_COUNT_SW_CPU_MIGRATIONS, 1, 0);
-
-		tmn.task = p;
-		tmn.from_cpu = task_cpu(p);
-		tmn.to_cpu = new_cpu;
-
-		atomic_notifier_call_chain(&task_migration_notifier, 0, &tmn);
 	}
 
 	__set_task_cpu(p, new_cpu);

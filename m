Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754436AbeDAUmh (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 16:42:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43090 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754404AbeDAUmf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 16:42:35 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 23/45] C++: Don't do "extern asmlinkage"
From: David Howells <dhowells@redhat.com>
To: linux-kernel@vger.kernel.org
Date: Sun, 01 Apr 2018 21:42:33 +0100
Message-ID: <152261535374.30503.17167565394146100518.stgit@warthog.procyon.org.uk>
In-Reply-To: <152261521484.30503.16131389653845029164.stgit@warthog.procyon.org.uk>
References: <152261521484.30503.16131389653845029164.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't do "extern asmlinkage" as asmlinkage is defined to include extern
"C".

Signed-off-by: David Howells <dhowells@redhat.com>
---

 arch/x86/include/asm/hw_irq.h        |   38 +++++++++++++++++-----------------
 arch/x86/include/asm/processor.h     |    2 +-
 arch/x86/include/asm/special_insns.h |    2 +-
 include/linux/compat.h               |    2 +-
 include/linux/lockdep.h              |    2 +-
 include/linux/printk.h               |    4 ++--
 include/linux/sched/task.h           |    2 +-
 include/linux/start_kernel.h         |    2 +-
 8 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/arch/x86/include/asm/hw_irq.h b/arch/x86/include/asm/hw_irq.h
index 2851077b6051..21cb1299170a 100644
--- a/arch/x86/include/asm/hw_irq.h
+++ b/arch/x86/include/asm/hw_irq.h
@@ -29,25 +29,25 @@
 #include <asm/sections.h>
 
 /* Interrupt handlers registered during init_IRQ */
-extern asmlinkage void apic_timer_interrupt(void);
-extern asmlinkage void x86_platform_ipi(void);
-extern asmlinkage void kvm_posted_intr_ipi(void);
-extern asmlinkage void kvm_posted_intr_wakeup_ipi(void);
-extern asmlinkage void kvm_posted_intr_nested_ipi(void);
-extern asmlinkage void error_interrupt(void);
-extern asmlinkage void irq_work_interrupt(void);
-
-extern asmlinkage void spurious_interrupt(void);
-extern asmlinkage void thermal_interrupt(void);
-extern asmlinkage void reschedule_interrupt(void);
-
-extern asmlinkage void irq_move_cleanup_interrupt(void);
-extern asmlinkage void reboot_interrupt(void);
-extern asmlinkage void threshold_interrupt(void);
-extern asmlinkage void deferred_error_interrupt(void);
-
-extern asmlinkage void call_function_interrupt(void);
-extern asmlinkage void call_function_single_interrupt(void);
+asmlinkage void apic_timer_interrupt(void);
+asmlinkage void x86_platform_ipi(void);
+asmlinkage void kvm_posted_intr_ipi(void);
+asmlinkage void kvm_posted_intr_wakeup_ipi(void);
+asmlinkage void kvm_posted_intr_nested_ipi(void);
+asmlinkage void error_interrupt(void);
+asmlinkage void irq_work_interrupt(void);
+
+asmlinkage void spurious_interrupt(void);
+asmlinkage void thermal_interrupt(void);
+asmlinkage void reschedule_interrupt(void);
+
+asmlinkage void irq_move_cleanup_interrupt(void);
+asmlinkage void reboot_interrupt(void);
+asmlinkage void threshold_interrupt(void);
+asmlinkage void deferred_error_interrupt(void);
+
+asmlinkage void call_function_interrupt(void);
+asmlinkage void call_function_single_interrupt(void);
 
 #ifdef	CONFIG_X86_LOCAL_APIC
 struct irq_data;
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index b0ccd4847a58..606dbae01d5b 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -409,7 +409,7 @@ DECLARE_INIT_PER_CPU(irq_stack_union);
 
 DECLARE_PER_CPU(char *, irq_stack_ptr);
 DECLARE_PER_CPU(unsigned int, irq_count);
-extern asmlinkage void ignore_sysret(void);
+asmlinkage void ignore_sysret(void);
 #else	/* X86_64 */
 #ifdef CONFIG_CC_STACKPROTECTOR
 /*
diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index 317fc59b512c..6eb481e1bb27 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -134,7 +134,7 @@ static inline void native_wbinvd(void)
 	asm volatile("wbinvd": : :"memory");
 }
 
-extern asmlinkage void native_load_gs_index(unsigned);
+asmlinkage void native_load_gs_index(unsigned);
 
 static inline unsigned long __read_cr4(void)
 {
diff --git a/include/linux/compat.h b/include/linux/compat.h
index 16c3027074a2..218a993abdb1 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -305,7 +305,7 @@ extern int put_compat_rusage(const struct rusage *,
 
 struct compat_siginfo;
 
-extern asmlinkage long compat_sys_waitid(int, compat_pid_t,
+asmlinkage long compat_sys_waitid(int, compat_pid_t,
 		struct compat_siginfo __user *, int,
 		struct compat_rusage __user *);
 
diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 6fc77d4dbdcd..0b0c244b4cdc 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -270,7 +270,7 @@ extern void lockdep_info(void);
 extern void lockdep_reset(void);
 extern void lockdep_reset_lock(struct lockdep_map *lock);
 extern void lockdep_free_key_range(void *start, unsigned long size);
-extern asmlinkage void lockdep_sys_exit(void);
+asmlinkage void lockdep_sys_exit(void);
 
 extern void lockdep_off(void);
 extern void lockdep_on(void);
diff --git a/include/linux/printk.h b/include/linux/printk.h
index e9b603ee9953..5b87db57e367 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -138,7 +138,7 @@ struct va_format {
 })
 
 #ifdef CONFIG_EARLY_PRINTK
-extern asmlinkage __printf(1, 2)
+asmlinkage __printf(1, 2)
 void early_printk(const char *fmt, ...);
 #else
 static inline __printf(1, 2) __cold
@@ -279,7 +279,7 @@ static inline void printk_safe_flush_on_panic(void)
 
 extern int kptr_restrict;
 
-extern asmlinkage void dump_stack(void) __cold;
+asmlinkage void dump_stack(void) __cold;
 
 #ifndef pr_fmt
 #define pr_fmt(fmt) fmt
diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index 5be31eb7b266..26131c2aa8ce 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -29,7 +29,7 @@ extern struct task_struct init_task;
 extern int lockdep_tasklist_lock_is_held(void);
 #endif /* #ifdef CONFIG_PROVE_RCU */
 
-extern asmlinkage void schedule_tail(struct task_struct *prev);
+asmlinkage void schedule_tail(struct task_struct *prev);
 extern void init_idle(struct task_struct *idle, int cpu);
 
 extern int sched_fork(unsigned long clone_flags, struct task_struct *p);
diff --git a/include/linux/start_kernel.h b/include/linux/start_kernel.h
index 4b268d86a784..d752fb744822 100644
--- a/include/linux/start_kernel.h
+++ b/include/linux/start_kernel.h
@@ -8,6 +8,6 @@
 /* Define the prototype for start_kernel here, rather than cluttering
    up something else. */
 
-extern asmlinkage void __init start_kernel(void);
+asmlinkage void __init start_kernel(void);
 
 #endif /* _LINUX_START_KERNEL_H */

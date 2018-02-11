Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1468877-1518325433-2-3175077236743347832
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enrosk.us-ascii,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518325432; b=qvGSC7Ck9Zdw8EY0r7dcVyGl9ZLs+LAlxO1pmU7KsDpQZgI
    u469LKk/To1gvD0JacQKmL+I2QbhaUMhwnQQ8SnK+JAJL61jK+7VzDcqx7bGPna3
    kXXwAHnW7/4Z4rnu5gXo6KBs/8fvgLKmzpw+4ueOvMfkuIt7nR1HysgaUBMFenKz
    HfMHgGrp+Aa56uIz32oamf6rGUs54M14ioGznnItufEztqMNa8SKYwaRX/5lcqNl
    EQLVFWhpDUuZViqhAVgPumSWQkHCpQSEuTwUsbbYz6mzFeSA+UTk4QzWB8Zvog5x
    cS3H7nnHlYXzD/ZqIGYIEQey8/oYeW3bQBJmCKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518325432; bh=uwFvSGilbw9lL59JTta
    XNxB23UR9Y5HvogsqGgARTfM=; b=rIFtWq67Z8wdTSr7LcdglXpG0GEPuKLaeUm
    khr3s6W7CRcrO83vUJHM+IROfSFneT0uzJcv0d+8PpXAOJVsFnnUE7wgLWwOT4Ug
    SlBDhmmDbSvQ/KZ1v5DpARVdY4VDc1zQiZdyNXIIsfwR7KtiEToxi4rta2BxUdJw
    Xnh6JWB71wQjFqQ3syqtV6xBKpcjdYo1oVJ2YvgejX7z9OSAzhGxyz4/9nkQR2pl
    gCzN6FosSybqQBGMoMzEwXeqtkqsd5OSJyZGJUK3goNTiYqwe6TD2ub0LJjEeqT9
    im+oRxGaRNF+hUX5xMLMWE01hMP20bqmBTrTO576MGYULoaJrkA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752217AbeBKFDf (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Feb 2018 00:03:35 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41595 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752734AbeBKEdp (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:33:45 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Rusty Russell" <rusty@rustcorp.com.au>,
        "Peter Zijlstra" <a.p.zijlstra@chello.nl>,
        "Paul McKenney" <paul.mckenney@us.ibm.com>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Ingo Molnar" <mingo@kernel.org>,
        "Suresh Siddha" <suresh.b.siddha@intel.com>
Date: Sun, 11 Feb 2018 04:20:06 +0000
Message-ID: <lsq.1518322806.497329753@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 29/79] x86/smp: Don't ever patch back to UP if we
 unplug cpus
In-Reply-To: <lsq.1518322802.943358572@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.99-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Rusty Russell <rusty@rustcorp.com.au>

commit 816afe4ff98ee10b1d30fd66361be132a0a5cee6 upstream.

We still patch SMP instructions to UP variants if we boot with a
single CPU, but not at any other time.  In particular, not if we
unplug CPUs to return to a single cpu.

Paul McKenney points out:

 mean offline overhead is 6251/48=130.2 milliseconds.

 If I remove the alternatives_smp_switch() from the offline
 path [...] the mean offline overhead is 550/42=13.1 milliseconds

Basically, we're never going to get those 120ms back, and the
code is pretty messy.

We get rid of:

 1) The "smp-alt-once" boot option. It's actually "smp-alt-boot", the
    documentation is wrong. It's now the default.

 2) The skip_smp_alternatives flag used by suspend.

 3) arch_disable_nonboot_cpus_begin() and arch_disable_nonboot_cpus_end()
    which were only used to set this one flag.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
Cc: Paul McKenney <paul.mckenney@us.ibm.com>
Cc: Suresh Siddha <suresh.b.siddha@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Link: http://lkml.kernel.org/r/87vcgwwive.fsf@rustcorp.com.au
Signed-off-by: Ingo Molnar <mingo@kernel.org>
[bwh: Backported to 3.2: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 Documentation/kernel-parameters.txt |   3 -
 arch/x86/include/asm/alternative.h  |   4 +-
 arch/x86/kernel/alternative.c       | 107 +++++++++---------------------------
 arch/x86/kernel/smpboot.c           |  20 +------
 arch/x86/xen/smp.c                  |   6 +-
 kernel/cpu.c                        |  11 ----
 6 files changed, 32 insertions(+), 119 deletions(-)

--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -2440,9 +2440,6 @@ bytes respectively. Such letter suffixes
 	smart2=		[HW]
 			Format: <io1>[,<io2>[,...,<io8>]]
 
-	smp-alt-once	[X86-32,SMP] On a hotplug CPU system, only
-			attempt to substitute SMP alternatives once at boot.
-
 	smsc-ircc2.nopnp	[HW] Don't use PNP to discover SMC devices
 	smsc-ircc2.ircc_cfg=	[HW] Device configuration I/O port
 	smsc-ircc2.ircc_sir=	[HW] SIR base I/O port
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -61,7 +61,7 @@ extern void alternatives_smp_module_add(
 					void *locks, void *locks_end,
 					void *text, void *text_end);
 extern void alternatives_smp_module_del(struct module *mod);
-extern void alternatives_smp_switch(int smp);
+extern void alternatives_enable_smp(void);
 extern int alternatives_text_reserved(void *start, void *end);
 extern bool skip_smp_alternatives;
 #else
@@ -69,7 +69,7 @@ static inline void alternatives_smp_modu
 					       void *locks, void *locks_end,
 					       void *text, void *text_end) {}
 static inline void alternatives_smp_module_del(struct module *mod) {}
-static inline void alternatives_smp_switch(int smp) {}
+static inline void alternatives_enable_smp(void) {}
 static inline int alternatives_text_reserved(void *start, void *end)
 {
 	return 0;
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -21,19 +21,6 @@
 
 #define MAX_PATCH_LEN (255-1)
 
-#ifdef CONFIG_HOTPLUG_CPU
-static int smp_alt_once;
-
-static int __init bootonly(char *str)
-{
-	smp_alt_once = 1;
-	return 1;
-}
-__setup("smp-alt-boot", bootonly);
-#else
-#define smp_alt_once 1
-#endif
-
 static int __initdata_or_module debug_alternative;
 
 static int __init debug_alt(char *str)
@@ -438,9 +425,6 @@ static void alternatives_smp_unlock(cons
 {
 	const s32 *poff;
 
-	if (noreplace_smp)
-		return;
-
 	mutex_lock(&text_mutex);
 	for (poff = start; poff < end; poff++) {
 		u8 *ptr = (u8 *)poff + *poff;
@@ -471,7 +455,7 @@ struct smp_alt_module {
 };
 static LIST_HEAD(smp_alt_modules);
 static DEFINE_MUTEX(smp_alt);
-static int smp_mode = 1;	/* protected by smp_alt */
+static bool uniproc_patched = false;	/* protected by smp_alt */
 
 void __init_or_module alternatives_smp_module_add(struct module *mod,
 						  char *name,
@@ -480,19 +464,18 @@ void __init_or_module alternatives_smp_m
 {
 	struct smp_alt_module *smp;
 
-	if (noreplace_smp)
-		return;
+	mutex_lock(&smp_alt);
+	if (!uniproc_patched)
+		goto unlock;
 
-	if (smp_alt_once) {
-		if (boot_cpu_has(X86_FEATURE_UP))
-			alternatives_smp_unlock(locks, locks_end,
-						text, text_end);
-		return;
-	}
+	if (num_possible_cpus() == 1)
+		/* Don't bother remembering, we'll never have to undo it. */
+		goto smp_unlock;
 
 	smp = kzalloc(sizeof(*smp), GFP_KERNEL);
 	if (NULL == smp)
-		return; /* we'll run the (safe but slow) SMP code then ... */
+		/* we'll run the (safe but slow) SMP code then ... */
+		goto unlock;
 
 	smp->mod	= mod;
 	smp->name	= name;
@@ -504,11 +487,10 @@ void __init_or_module alternatives_smp_m
 		smp->locks, smp->locks_end,
 		smp->text, smp->text_end, smp->name);
 
-	mutex_lock(&smp_alt);
 	list_add_tail(&smp->next, &smp_alt_modules);
-	if (boot_cpu_has(X86_FEATURE_UP))
-		alternatives_smp_unlock(smp->locks, smp->locks_end,
-					smp->text, smp->text_end);
+smp_unlock:
+	alternatives_smp_unlock(locks, locks_end, text, text_end);
+unlock:
 	mutex_unlock(&smp_alt);
 }
 
@@ -516,24 +498,18 @@ void __init_or_module alternatives_smp_m
 {
 	struct smp_alt_module *item;
 
-	if (smp_alt_once || noreplace_smp)
-		return;
-
 	mutex_lock(&smp_alt);
 	list_for_each_entry(item, &smp_alt_modules, next) {
 		if (mod != item->mod)
 			continue;
 		list_del(&item->next);
-		mutex_unlock(&smp_alt);
-		DPRINTK("%s\n", item->name);
 		kfree(item);
-		return;
+		break;
 	}
 	mutex_unlock(&smp_alt);
 }
 
-bool skip_smp_alternatives;
-void alternatives_smp_switch(int smp)
+void alternatives_enable_smp(void)
 {
 	struct smp_alt_module *mod;
 
@@ -548,34 +524,21 @@ void alternatives_smp_switch(int smp)
 	printk("lockdep: fixing up alternatives.\n");
 #endif
 
-	if (noreplace_smp || smp_alt_once || skip_smp_alternatives)
-		return;
-	BUG_ON(!smp && (num_online_cpus() > 1));
+	/* Why bother if there are no other CPUs? */
+	BUG_ON(num_possible_cpus() == 1);
 
 	mutex_lock(&smp_alt);
 
-	/*
-	 * Avoid unnecessary switches because it forces JIT based VMs to
-	 * throw away all cached translations, which can be quite costly.
-	 */
-	if (smp == smp_mode) {
-		/* nothing */
-	} else if (smp) {
+	if (uniproc_patched) {
 		printk(KERN_INFO "SMP alternatives: switching to SMP code\n");
+		BUG_ON(num_online_cpus() != 1);
 		clear_cpu_cap(&boot_cpu_data, X86_FEATURE_UP);
 		clear_cpu_cap(&cpu_data(0), X86_FEATURE_UP);
 		list_for_each_entry(mod, &smp_alt_modules, next)
 			alternatives_smp_lock(mod->locks, mod->locks_end,
 					      mod->text, mod->text_end);
-	} else {
-		printk(KERN_INFO "SMP alternatives: switching to UP code\n");
-		set_cpu_cap(&boot_cpu_data, X86_FEATURE_UP);
-		set_cpu_cap(&cpu_data(0), X86_FEATURE_UP);
-		list_for_each_entry(mod, &smp_alt_modules, next)
-			alternatives_smp_unlock(mod->locks, mod->locks_end,
-						mod->text, mod->text_end);
+		uniproc_patched = false;
 	}
-	smp_mode = smp;
 	mutex_unlock(&smp_alt);
 }
 
@@ -652,40 +615,22 @@ void __init alternative_instructions(voi
 
 	apply_alternatives(__alt_instructions, __alt_instructions_end);
 
-	/* switch to patch-once-at-boottime-only mode and free the
-	 * tables in case we know the number of CPUs will never ever
-	 * change */
-#ifdef CONFIG_HOTPLUG_CPU
-	if (num_possible_cpus() < 2)
-		smp_alt_once = 1;
-#endif
-
 #ifdef CONFIG_SMP
-	if (smp_alt_once) {
-		if (1 == num_possible_cpus()) {
-			printk(KERN_INFO "SMP alternatives: switching to UP code\n");
-			set_cpu_cap(&boot_cpu_data, X86_FEATURE_UP);
-			set_cpu_cap(&cpu_data(0), X86_FEATURE_UP);
-
-			alternatives_smp_unlock(__smp_locks, __smp_locks_end,
-						_text, _etext);
-		}
-	} else {
+	/* Patch to UP if other cpus not imminent. */
+	if (!noreplace_smp && (num_present_cpus() == 1 || setup_max_cpus <= 1)) {
+		uniproc_patched = true;
 		alternatives_smp_module_add(NULL, "core kernel",
 					    __smp_locks, __smp_locks_end,
 					    _text, _etext);
-
-		/* Only switch to UP mode if we don't immediately boot others */
-		if (num_present_cpus() == 1 || setup_max_cpus <= 1)
-			alternatives_smp_switch(0);
 	}
-#endif
- 	apply_paravirt(__parainstructions, __parainstructions_end);
 
-	if (smp_alt_once)
+	if (!uniproc_patched || num_possible_cpus() == 1)
 		free_init_pages("SMP alternatives",
 				(unsigned long)__smp_locks,
 				(unsigned long)__smp_locks_end);
+#endif
+
+	apply_paravirt(__parainstructions, __parainstructions_end);
 
 	restart_nmi();
 }
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -689,7 +689,8 @@ static int __cpuinit do_boot_cpu(int api
 
 	INIT_WORK_ONSTACK(&c_idle.work, do_fork_idle);
 
-	alternatives_smp_switch(1);
+	/* Just in case we booted with a single CPU. */
+	alternatives_enable_smp();
 
 	c_idle.idle = get_idle_for_cpu(cpu);
 
@@ -1109,20 +1110,6 @@ out:
 	preempt_enable();
 }
 
-void arch_disable_nonboot_cpus_begin(void)
-{
-	/*
-	 * Avoid the smp alternatives switch during the disable_nonboot_cpus().
-	 * In the suspend path, we will be back in the SMP mode shortly anyways.
-	 */
-	skip_smp_alternatives = true;
-}
-
-void arch_disable_nonboot_cpus_end(void)
-{
-	skip_smp_alternatives = false;
-}
-
 void arch_enable_nonboot_cpus_begin(void)
 {
 	set_mtrr_aps_delayed_init();
@@ -1321,9 +1308,6 @@ void native_cpu_die(unsigned int cpu)
 		if (per_cpu(cpu_state, cpu) == CPU_DEAD) {
 			if (system_state == SYSTEM_RUNNING)
 				pr_info("CPU %u is now offline\n", cpu);
-
-			if (1 == num_online_cpus())
-				alternatives_smp_switch(0);
 			return;
 		}
 		msleep(100);
--- a/arch/x86/xen/smp.c
+++ b/arch/x86/xen/smp.c
@@ -368,7 +368,8 @@ static int __cpuinit xen_cpu_up(unsigned
 		return rc;
 
 	if (num_online_cpus() == 1)
-		alternatives_smp_switch(1);
+		/* Just in case we booted with a single CPU. */
+		alternatives_enable_smp();
 
 	rc = xen_smp_intr_init(cpu);
 	if (rc)
@@ -414,9 +415,6 @@ static void xen_cpu_die(unsigned int cpu
 	unbind_from_irqhandler(per_cpu(xen_callfuncsingle_irq, cpu), NULL);
 	xen_uninit_lock_cpu(cpu);
 	xen_teardown_timer(cpu);
-
-	if (num_online_cpus() == 1)
-		alternatives_smp_switch(0);
 }
 
 static void __cpuinit xen_play_dead(void) /* used only with HOTPLUG_CPU */
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -406,14 +406,6 @@ out:
 #ifdef CONFIG_PM_SLEEP_SMP
 static cpumask_var_t frozen_cpus;
 
-void __weak arch_disable_nonboot_cpus_begin(void)
-{
-}
-
-void __weak arch_disable_nonboot_cpus_end(void)
-{
-}
-
 int disable_nonboot_cpus(void)
 {
 	int cpu, first_cpu, error = 0;
@@ -425,7 +417,6 @@ int disable_nonboot_cpus(void)
 	 * with the userspace trying to use the CPU hotplug at the same time
 	 */
 	cpumask_clear(frozen_cpus);
-	arch_disable_nonboot_cpus_begin();
 
 	printk("Disabling non-boot CPUs ...\n");
 	for_each_online_cpu(cpu) {
@@ -441,8 +432,6 @@ int disable_nonboot_cpus(void)
 		}
 	}
 
-	arch_disable_nonboot_cpus_end();
-
 	if (!error) {
 		BUG_ON(num_online_cpus() > 1);
 		/* Make sure the CPUs won't be enabled by someone else */

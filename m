Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF088C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 12:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C69D20C0A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 12:29:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C69D20C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbeJITqT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 15:46:19 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60737 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbeJITqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 15:46:19 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w99CSQjx1035303
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 9 Oct 2018 05:28:26 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w99CSPY31035300;
        Tue, 9 Oct 2018 05:28:25 -0700
Date:   Tue, 9 Oct 2018 05:28:25 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Yi Sun <tipbot@zytor.com>
Message-ID: <tip-3a025de64bf89c84a79909069e3c24ad9e710d27@git.kernel.org>
Cc:     kys@microsoft.com, yi.y.sun@linux.intel.com,
        sthemmin@microsoft.com, linux-kernel@vger.kernel.org,
        haiyangz@microsoft.com, Michael.H.Kelley@microsoft.com,
        mingo@kernel.org, jgross@suse.com, hpa@zytor.com,
        tglx@linutronix.de
Reply-To: Michael.H.Kelley@microsoft.com, mingo@kernel.org, hpa@zytor.com,
          jgross@suse.com, tglx@linutronix.de, yi.y.sun@linux.intel.com,
          kys@microsoft.com, linux-kernel@vger.kernel.org,
          sthemmin@microsoft.com, haiyangz@microsoft.com
In-Reply-To: <1538987374-51217-3-git-send-email-yi.y.sun@linux.intel.com>
References: <1538987374-51217-3-git-send-email-yi.y.sun@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/paravirt] x86/hyperv: Enable PV qspinlock for Hyper-V
Git-Commit-ID: 3a025de64bf89c84a79909069e3c24ad9e710d27
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  3a025de64bf89c84a79909069e3c24ad9e710d27
Gitweb:     https://git.kernel.org/tip/3a025de64bf89c84a79909069e3c24ad9e710d27
Author:     Yi Sun <yi.y.sun@linux.intel.com>
AuthorDate: Mon, 8 Oct 2018 16:29:34 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 9 Oct 2018 14:21:39 +0200

x86/hyperv: Enable PV qspinlock for Hyper-V

Implement the required wait and kick callbacks to support PV spinlocks in
Hyper-V guests.

[ tglx: Document the requirement for disabling interrupts in the wait()
  	callback. Remove goto and unnecessary includes. Add prototype
	for hv_vcpu_is_preempted(). Adapted to pending paravirt changes. ]

Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Juergen Gross <jgross@suse.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: Michael Kelley (EOSG) <Michael.H.Kelley@microsoft.com>
Cc: chao.p.peng@intel.com
Cc: chao.gao@intel.com
Cc: isaku.yamahata@intel.com
Cc: tianyu.lan@microsoft.com
Link: https://lkml.kernel.org/r/1538987374-51217-3-git-send-email-yi.y.sun@linux.intel.com
---
 Documentation/admin-guide/kernel-parameters.txt |  5 ++
 arch/x86/hyperv/Makefile                        |  4 ++
 arch/x86/hyperv/hv_spinlock.c                   | 88 +++++++++++++++++++++++++
 arch/x86/include/asm/mshyperv.h                 |  2 +
 arch/x86/kernel/cpu/mshyperv.c                  | 14 ++++
 5 files changed, 113 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 9871e649ffef..4cdf6a673592 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1385,6 +1385,11 @@
 	hvc_iucv_allow=	[S390]	Comma-separated list of z/VM user IDs.
 				If specified, z/VM IUCV HVC accepts connections
 				from listed z/VM user IDs only.
+
+	hv_nopvspin	[X86,HYPER_V] Disables the paravirt spinlock optimizations
+				      which allow the hypervisor to 'idle' the
+				      guest on lock contention.
+
 	keep_bootcon	[KNL]
 			Do not unregister boot console at start. This is only
 			useful for debugging when something happens in the window
diff --git a/arch/x86/hyperv/Makefile b/arch/x86/hyperv/Makefile
index b21ee65c4101..1c11f9420a82 100644
--- a/arch/x86/hyperv/Makefile
+++ b/arch/x86/hyperv/Makefile
@@ -1,2 +1,6 @@
 obj-y			:= hv_init.o mmu.o nested.o
 obj-$(CONFIG_X86_64)	+= hv_apic.o
+
+ifdef CONFIG_X86_64
+obj-$(CONFIG_PARAVIRT_SPINLOCKS)	+= hv_spinlock.o
+endif
diff --git a/arch/x86/hyperv/hv_spinlock.c b/arch/x86/hyperv/hv_spinlock.c
new file mode 100644
index 000000000000..a861b0456b1a
--- /dev/null
+++ b/arch/x86/hyperv/hv_spinlock.c
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Hyper-V specific spinlock code.
+ *
+ * Copyright (C) 2018, Intel, Inc.
+ *
+ * Author : Yi Sun <yi.y.sun@intel.com>
+ */
+
+#define pr_fmt(fmt) "Hyper-V: " fmt
+
+#include <linux/spinlock.h>
+
+#include <asm/mshyperv.h>
+#include <asm/paravirt.h>
+#include <asm/apic.h>
+
+static bool __initdata hv_pvspin = true;
+
+static void hv_qlock_kick(int cpu)
+{
+	apic->send_IPI(cpu, X86_PLATFORM_IPI_VECTOR);
+}
+
+static void hv_qlock_wait(u8 *byte, u8 val)
+{
+	unsigned long msr_val;
+	unsigned long flags;
+
+	if (in_nmi())
+		return;
+
+	/*
+	 * Reading HV_X64_MSR_GUEST_IDLE MSR tells the hypervisor that the
+	 * vCPU can be put into 'idle' state. This 'idle' state is
+	 * terminated by an IPI, usually from hv_qlock_kick(), even if
+	 * interrupts are disabled on the vCPU.
+	 *
+	 * To prevent a race against the unlock path it is required to
+	 * disable interrupts before accessing the HV_X64_MSR_GUEST_IDLE
+	 * MSR. Otherwise, if the IPI from hv_qlock_kick() arrives between
+	 * the lock value check and the rdmsrl() then the vCPU might be put
+	 * into 'idle' state by the hypervisor and kept in that state for
+	 * an unspecified amount of time.
+	 */
+	local_irq_save(flags);
+	/*
+	 * Only issue the rdmsrl() when the lock state has not changed.
+	 */
+	if (READ_ONCE(*byte) == val)
+		rdmsrl(HV_X64_MSR_GUEST_IDLE, msr_val);
+	local_irq_restore(flags);
+}
+
+/*
+ * Hyper-V does not support this so far.
+ */
+bool hv_vcpu_is_preempted(int vcpu)
+{
+	return false;
+}
+PV_CALLEE_SAVE_REGS_THUNK(hv_vcpu_is_preempted);
+
+void __init hv_init_spinlocks(void)
+{
+	if (!hv_pvspin || !apic ||
+	    !(ms_hyperv.hints & HV_X64_CLUSTER_IPI_RECOMMENDED) ||
+	    !(ms_hyperv.features & HV_X64_MSR_GUEST_IDLE_AVAILABLE)) {
+		pr_info("PV spinlocks disabled\n");
+		return;
+	}
+	pr_info("PV spinlocks enabled\n");
+
+	__pv_init_lock_hash();
+	pv_ops.lock.queued_spin_lock_slowpath = __pv_queued_spin_lock_slowpath;
+	pv_ops.lock.queued_spin_unlock = PV_CALLEE_SAVE(__pv_queued_spin_unlock);
+	pv_ops.lock.wait = hv_qlock_wait;
+	pv_ops.lock.kick = hv_qlock_kick;
+	pv_ops.lock.vcpu_is_preempted = PV_CALLEE_SAVE(hv_vcpu_is_preempted);
+}
+
+static __init int hv_parse_nopvspin(char *arg)
+{
+	hv_pvspin = false;
+	return 0;
+}
+early_param("hv_nopvspin", hv_parse_nopvspin);
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index f37704497d8f..0d6271cce198 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -351,6 +351,8 @@ int hyperv_flush_guest_mapping(u64 as);
 
 #ifdef CONFIG_X86_64
 void hv_apic_init(void);
+void __init hv_init_spinlocks(void);
+bool hv_vcpu_is_preempted(int vcpu);
 #else
 static inline void hv_apic_init(void) {}
 #endif
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index ad12733f6058..1c72f3819eb1 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -199,6 +199,16 @@ static unsigned long hv_get_tsc_khz(void)
 	return freq / 1000;
 }
 
+#if defined(CONFIG_SMP) && IS_ENABLED(CONFIG_HYPERV)
+static void __init hv_smp_prepare_boot_cpu(void)
+{
+	native_smp_prepare_boot_cpu();
+#if defined(CONFIG_X86_64) && defined(CONFIG_PARAVIRT_SPINLOCKS)
+	hv_init_spinlocks();
+#endif
+}
+#endif
+
 static void __init ms_hyperv_init_platform(void)
 {
 	int hv_host_info_eax;
@@ -303,6 +313,10 @@ static void __init ms_hyperv_init_platform(void)
 	if (ms_hyperv.misc_features & HV_STIMER_DIRECT_MODE_AVAILABLE)
 		alloc_intr_gate(HYPERV_STIMER0_VECTOR,
 				hv_stimer0_callback_vector);
+
+# ifdef CONFIG_SMP
+	smp_ops.smp_prepare_boot_cpu = hv_smp_prepare_boot_cpu;
+# endif
 #endif
 }
 

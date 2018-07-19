Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD2DDECDFB8
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 22:23:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 583F320671
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 22:23:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 583F320671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731178AbeGSXIi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 19:08:38 -0400
Received: from terminus.zytor.com ([198.137.202.136]:53387 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730961AbeGSXIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 19:08:38 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6JMN69Z2437057
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 19 Jul 2018 15:23:06 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6JMN5Dx2437054;
        Thu, 19 Jul 2018 15:23:05 -0700
Date:   Thu, 19 Jul 2018 15:23:05 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-7a5ddc8fe0ea9518cd7fb6a929cac7d864c6f300@git.kernel.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, hpa@zytor.com, tglx@linutronix.de,
        pasha.tatashin@oracle.com
Reply-To: pbonzini@redhat.com, linux-kernel@vger.kernel.org,
          mingo@kernel.org, hpa@zytor.com, tglx@linutronix.de,
          pasha.tatashin@oracle.com
In-Reply-To: <20180719205545.16512-4-pasha.tatashin@oracle.com>
References: <20180719205545.16512-4-pasha.tatashin@oracle.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/timers] x86/kvmclock: Decrapify kvm_register_clock()
Git-Commit-ID: 7a5ddc8fe0ea9518cd7fb6a929cac7d864c6f300
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

Commit-ID:  7a5ddc8fe0ea9518cd7fb6a929cac7d864c6f300
Gitweb:     https://git.kernel.org/tip/7a5ddc8fe0ea9518cd7fb6a929cac7d864c6f300
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Thu, 19 Jul 2018 16:55:22 -0400
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 20 Jul 2018 00:02:36 +0200

x86/kvmclock: Decrapify kvm_register_clock()

The return value is pointless because the wrmsr cannot fail if
KVM_FEATURE_CLOCKSOURCE or KVM_FEATURE_CLOCKSOURCE2 are set.

kvm_register_clock() is only called locally so wants to be static.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Cc: steven.sistare@oracle.com
Cc: daniel.m.jordan@oracle.com
Cc: linux@armlinux.org.uk
Cc: schwidefsky@de.ibm.com
Cc: heiko.carstens@de.ibm.com
Cc: john.stultz@linaro.org
Cc: sboyd@codeaurora.org
Cc: hpa@zytor.com
Cc: douly.fnst@cn.fujitsu.com
Cc: peterz@infradead.org
Cc: prarit@redhat.com
Cc: feng.tang@intel.com
Cc: pmladek@suse.com
Cc: gnomes@lxorguk.ukuu.org.uk
Cc: linux-s390@vger.kernel.org
Cc: boris.ostrovsky@oracle.com
Cc: jgross@suse.com
Link: https://lkml.kernel.org/r/20180719205545.16512-4-pasha.tatashin@oracle.com

---
 arch/x86/include/asm/kvm_para.h |  1 -
 arch/x86/kernel/kvmclock.c      | 33 ++++++++++-----------------------
 2 files changed, 10 insertions(+), 24 deletions(-)

diff --git a/arch/x86/include/asm/kvm_para.h b/arch/x86/include/asm/kvm_para.h
index 3aea2658323a..4c723632c036 100644
--- a/arch/x86/include/asm/kvm_para.h
+++ b/arch/x86/include/asm/kvm_para.h
@@ -7,7 +7,6 @@
 #include <uapi/asm/kvm_para.h>
 
 extern void kvmclock_init(void);
-extern int kvm_register_clock(char *txt);
 
 #ifdef CONFIG_KVM_GUEST
 bool kvm_check_and_clear_guest_paused(void);
diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index a995d7d7164c..f0a0aef5e9fa 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -187,23 +187,19 @@ struct clocksource kvm_clock = {
 };
 EXPORT_SYMBOL_GPL(kvm_clock);
 
-int kvm_register_clock(char *txt)
+static void kvm_register_clock(char *txt)
 {
-	int cpu = smp_processor_id();
-	int low, high, ret;
 	struct pvclock_vcpu_time_info *src;
+	int cpu = smp_processor_id();
+	u64 pa;
 
 	if (!hv_clock)
-		return 0;
+		return;
 
 	src = &hv_clock[cpu].pvti;
-	low = (int)slow_virt_to_phys(src) | 1;
-	high = ((u64)slow_virt_to_phys(src) >> 32);
-	ret = native_write_msr_safe(msr_kvm_system_time, low, high);
-	printk(KERN_INFO "kvm-clock: cpu %d, msr %x:%x, %s\n",
-	       cpu, high, low, txt);
-
-	return ret;
+	pa = slow_virt_to_phys(src) | 0x01ULL;
+	wrmsrl(msr_kvm_system_time, pa);
+	pr_info("kvm-clock: cpu %d, msr %llx, %s\n", cpu, pa, txt);
 }
 
 static void kvm_save_sched_clock_state(void)
@@ -218,11 +214,7 @@ static void kvm_restore_sched_clock_state(void)
 #ifdef CONFIG_X86_LOCAL_APIC
 static void kvm_setup_secondary_clock(void)
 {
-	/*
-	 * Now that the first cpu already had this clocksource initialized,
-	 * we shouldn't fail.
-	 */
-	WARN_ON(kvm_register_clock("secondary cpu clock"));
+	kvm_register_clock("secondary cpu clock");
 }
 #endif
 
@@ -265,16 +257,11 @@ void __init kvmclock_init(void)
 	} else if (!(kvmclock && kvm_para_has_feature(KVM_FEATURE_CLOCKSOURCE)))
 		return;
 
-	hv_clock = (struct pvclock_vsyscall_time_info *)hv_clock_mem;
-
-	if (kvm_register_clock("primary cpu clock")) {
-		hv_clock = NULL;
-		return;
-	}
-
 	printk(KERN_INFO "kvm-clock: Using msrs %x and %x",
 		msr_kvm_system_time, msr_kvm_wall_clock);
 
+	hv_clock = (struct pvclock_vsyscall_time_info *)hv_clock_mem;
+	kvm_register_clock("primary cpu clock");
 	pvclock_set_pvti_cpu0_va(hv_clock);
 
 	if (kvm_para_has_feature(KVM_FEATURE_CLOCKSOURCE_STABLE_BIT))

Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E0BECDFB8
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 22:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C532920661
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 22:23:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C532920661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731095AbeGSXID (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 19:08:03 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34581 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730383AbeGSXID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 19:08:03 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6JMMUsk2437027
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 19 Jul 2018 15:22:30 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6JMMUka2437022;
        Thu, 19 Jul 2018 15:22:30 -0700
Date:   Thu, 19 Jul 2018 15:22:30 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-7ef363a39514ed8a6f2333fbae1875ac0953715a@git.kernel.org>
Cc:     tglx@linutronix.de, hpa@zytor.com, linux-kernel@vger.kernel.org,
        pasha.tatashin@oracle.com, mingo@kernel.org, pbonzini@redhat.com
Reply-To: tglx@linutronix.de, pbonzini@redhat.com,
          pasha.tatashin@oracle.com, mingo@kernel.org, hpa@zytor.com,
          linux-kernel@vger.kernel.org
In-Reply-To: <20180719205545.16512-3-pasha.tatashin@oracle.com>
References: <20180719205545.16512-3-pasha.tatashin@oracle.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/timers] x86/kvmclock: Remove page size requirement from
 wall_clock
Git-Commit-ID: 7ef363a39514ed8a6f2333fbae1875ac0953715a
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

Commit-ID:  7ef363a39514ed8a6f2333fbae1875ac0953715a
Gitweb:     https://git.kernel.org/tip/7ef363a39514ed8a6f2333fbae1875ac0953715a
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Thu, 19 Jul 2018 16:55:21 -0400
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 20 Jul 2018 00:02:36 +0200

x86/kvmclock: Remove page size requirement from wall_clock

There is no requirement for wall_clock data to be page aligned or page
sized.

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
Link: https://lkml.kernel.org/r/20180719205545.16512-3-pasha.tatashin@oracle.com

---
 arch/x86/kernel/kvmclock.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 1f6ac5aaa904..a995d7d7164c 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -46,14 +46,12 @@ early_param("no-kvmclock", parse_no_kvmclock);
 
 /* Aligned to page sizes to match whats mapped via vsyscalls to userspace */
 #define HV_CLOCK_SIZE	(sizeof(struct pvclock_vsyscall_time_info) * NR_CPUS)
-#define WALL_CLOCK_SIZE	(sizeof(struct pvclock_wall_clock))
 
 static u8 hv_clock_mem[PAGE_ALIGN(HV_CLOCK_SIZE)] __aligned(PAGE_SIZE);
-static u8 wall_clock_mem[PAGE_ALIGN(WALL_CLOCK_SIZE)] __aligned(PAGE_SIZE);
 
 /* The hypervisor will put information about time periodically here */
 static struct pvclock_vsyscall_time_info *hv_clock;
-static struct pvclock_wall_clock *wall_clock;
+static struct pvclock_wall_clock wall_clock;
 
 /*
  * The wallclock is the time of day when we booted. Since then, some time may
@@ -66,15 +64,15 @@ static void kvm_get_wallclock(struct timespec64 *now)
 	int low, high;
 	int cpu;
 
-	low = (int)slow_virt_to_phys(wall_clock);
-	high = ((u64)slow_virt_to_phys(wall_clock) >> 32);
+	low = (int)slow_virt_to_phys(&wall_clock);
+	high = ((u64)slow_virt_to_phys(&wall_clock) >> 32);
 
 	native_write_msr(msr_kvm_wall_clock, low, high);
 
 	cpu = get_cpu();
 
 	vcpu_time = &hv_clock[cpu].pvti;
-	pvclock_read_wallclock(wall_clock, vcpu_time, now);
+	pvclock_read_wallclock(&wall_clock, vcpu_time, now);
 
 	put_cpu();
 }
@@ -267,12 +265,10 @@ void __init kvmclock_init(void)
 	} else if (!(kvmclock && kvm_para_has_feature(KVM_FEATURE_CLOCKSOURCE)))
 		return;
 
-	wall_clock = (struct pvclock_wall_clock *)wall_clock_mem;
 	hv_clock = (struct pvclock_vsyscall_time_info *)hv_clock_mem;
 
 	if (kvm_register_clock("primary cpu clock")) {
 		hv_clock = NULL;
-		wall_clock = NULL;
 		return;
 	}
 

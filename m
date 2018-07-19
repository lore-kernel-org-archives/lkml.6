Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56889ECDFB8
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 22:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1032220671
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 22:24:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1032220671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731232AbeGSXJm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 19:09:42 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40795 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727523AbeGSXJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 19:09:42 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6JMOASF2438720
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 19 Jul 2018 15:24:10 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6JMOAkl2438717;
        Thu, 19 Jul 2018 15:24:10 -0700
Date:   Thu, 19 Jul 2018 15:24:10 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-42f8df935efefba51d0c5321b1325436523e3377@git.kernel.org>
Cc:     pasha.tatashin@oracle.com, pbonzini@redhat.com, mingo@kernel.org,
        tglx@linutronix.de, hpa@zytor.com, linux-kernel@vger.kernel.org
Reply-To: pasha.tatashin@oracle.com, pbonzini@redhat.com, mingo@kernel.org,
          hpa@zytor.com, tglx@linutronix.de, linux-kernel@vger.kernel.org
In-Reply-To: <20180719205545.16512-6-pasha.tatashin@oracle.com>
References: <20180719205545.16512-6-pasha.tatashin@oracle.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/timers] x86/kvmclock: Mark variables __initdata and
 __ro_after_init
Git-Commit-ID: 42f8df935efefba51d0c5321b1325436523e3377
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

Commit-ID:  42f8df935efefba51d0c5321b1325436523e3377
Gitweb:     https://git.kernel.org/tip/42f8df935efefba51d0c5321b1325436523e3377
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Thu, 19 Jul 2018 16:55:24 -0400
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 20 Jul 2018 00:02:37 +0200

x86/kvmclock: Mark variables __initdata and __ro_after_init

The kvmclock parameter is init data and the other variables are not
modified after init.

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
Link: https://lkml.kernel.org/r/20180719205545.16512-6-pasha.tatashin@oracle.com

---
 arch/x86/kernel/kvmclock.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 4afb03e49a4f..78aec160f5e0 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -32,10 +32,10 @@
 #include <asm/reboot.h>
 #include <asm/kvmclock.h>
 
-static int kvmclock __ro_after_init = 1;
-static int msr_kvm_system_time = MSR_KVM_SYSTEM_TIME;
-static int msr_kvm_wall_clock = MSR_KVM_WALL_CLOCK;
-static u64 kvm_sched_clock_offset;
+static int kvmclock __initdata = 1;
+static int msr_kvm_system_time __ro_after_init = MSR_KVM_SYSTEM_TIME;
+static int msr_kvm_wall_clock __ro_after_init = MSR_KVM_WALL_CLOCK;
+static u64 kvm_sched_clock_offset __ro_after_init;
 
 static int __init parse_no_kvmclock(char *arg)
 {
@@ -50,7 +50,7 @@ early_param("no-kvmclock", parse_no_kvmclock);
 static u8 hv_clock_mem[PAGE_ALIGN(HV_CLOCK_SIZE)] __aligned(PAGE_SIZE);
 
 /* The hypervisor will put information about time periodically here */
-static struct pvclock_vsyscall_time_info *hv_clock;
+static struct pvclock_vsyscall_time_info *hv_clock __ro_after_init;
 static struct pvclock_wall_clock wall_clock;
 
 /*

Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 187FBECDFB8
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 22:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD0E720671
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 22:28:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD0E720671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731446AbeGSXN2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 19:13:28 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43521 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727772AbeGSXN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 19:13:28 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6JMSD972439185
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 19 Jul 2018 15:28:13 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6JMSD2R2439182;
        Thu, 19 Jul 2018 15:28:13 -0700
Date:   Thu, 19 Jul 2018 15:28:13 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Pavel Tatashin <tipbot@zytor.com>
Message-ID: <tip-38669ba205d178d2d38bfd194a196d65a44d5af2@git.kernel.org>
Cc:     hpa@zytor.com, pasha.tatashin@oracle.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de
Reply-To: hpa@zytor.com, pasha.tatashin@oracle.com,
          linux-kernel@vger.kernel.org, mingo@kernel.org,
          tglx@linutronix.de
In-Reply-To: <20180719205545.16512-14-pasha.tatashin@oracle.com>
References: <20180719205545.16512-14-pasha.tatashin@oracle.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/timers] x86/xen/time: Output xen sched_clock time from 0
Git-Commit-ID: 38669ba205d178d2d38bfd194a196d65a44d5af2
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

Commit-ID:  38669ba205d178d2d38bfd194a196d65a44d5af2
Gitweb:     https://git.kernel.org/tip/38669ba205d178d2d38bfd194a196d65a44d5af2
Author:     Pavel Tatashin <pasha.tatashin@oracle.com>
AuthorDate: Thu, 19 Jul 2018 16:55:32 -0400
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 20 Jul 2018 00:02:40 +0200

x86/xen/time: Output xen sched_clock time from 0

It is expected for sched_clock() to output data from 0, when system boots.

Add an offset xen_sched_clock_offset (similarly how it is done in other
hypervisors i.e. kvm_sched_clock_offset) to count sched_clock() from 0,
when time is first initialized.

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
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
Cc: pbonzini@redhat.com
Link: https://lkml.kernel.org/r/20180719205545.16512-14-pasha.tatashin@oracle.com

---
 arch/x86/xen/time.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/x86/xen/time.c b/arch/x86/xen/time.c
index 53bb7a8d10b5..c84f1e039d84 100644
--- a/arch/x86/xen/time.c
+++ b/arch/x86/xen/time.c
@@ -31,6 +31,8 @@
 /* Xen may fire a timer up to this many ns early */
 #define TIMER_SLOP	100000
 
+static u64 xen_sched_clock_offset __read_mostly;
+
 /* Get the TSC speed from Xen */
 static unsigned long xen_tsc_khz(void)
 {
@@ -57,6 +59,11 @@ static u64 xen_clocksource_get_cycles(struct clocksource *cs)
 	return xen_clocksource_read();
 }
 
+static u64 xen_sched_clock(void)
+{
+	return xen_clocksource_read() - xen_sched_clock_offset;
+}
+
 static void xen_read_wallclock(struct timespec64 *ts)
 {
 	struct shared_info *s = HYPERVISOR_shared_info;
@@ -367,7 +374,7 @@ void xen_timer_resume(void)
 }
 
 static const struct pv_time_ops xen_time_ops __initconst = {
-	.sched_clock = xen_clocksource_read,
+	.sched_clock = xen_sched_clock,
 	.steal_clock = xen_steal_clock,
 };
 
@@ -505,6 +512,7 @@ static void __init xen_time_init(void)
 
 void __init xen_init_time_ops(void)
 {
+	xen_sched_clock_offset = xen_clocksource_read();
 	pv_time_ops = xen_time_ops;
 
 	x86_init.timers.timer_init = xen_time_init;
@@ -546,6 +554,7 @@ void __init xen_hvm_init_time_ops(void)
 		return;
 	}
 
+	xen_sched_clock_offset = xen_clocksource_read();
 	pv_time_ops = xen_time_ops;
 	x86_init.timers.setup_percpu_clockev = xen_time_init;
 	x86_cpuinit.setup_percpu_clockev = xen_hvm_setup_cpu_clockevents;

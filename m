Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F7DC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 03:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6881214C6
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 03:12:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbeLRDMm convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 22:12:42 -0500
Received: from mga11.intel.com ([192.55.52.93]:35562 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726301AbeLRDMm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 22:12:42 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Dec 2018 19:12:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,367,1539673200"; 
   d="scan'208";a="101472031"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
  by orsmga006.jf.intel.com with ESMTP; 17 Dec 2018 19:12:40 -0800
Received: from fmsmsx155.amr.corp.intel.com (10.18.116.71) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 17 Dec 2018 19:12:40 -0800
Received: from shsmsx152.ccr.corp.intel.com (10.239.6.52) by
 FMSMSX155.amr.corp.intel.com (10.18.116.71) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 17 Dec 2018 19:12:40 -0800
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.203]) by
 SHSMSX152.ccr.corp.intel.com ([169.254.6.222]) with mapi id 14.03.0415.000;
 Tue, 18 Dec 2018 11:12:38 +0800
From:   "He, Bo" <bo.he@intel.com>
To:     "Zhang, Jun" <jun.zhang@intel.com>,
        "paulmck@linux.ibm.com" <paulmck@linux.ibm.com>
CC:     Steven Rostedt <rostedt@goodmis.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "josh@joshtriplett.org" <josh@joshtriplett.org>,
        "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
        "jiangshanlai@gmail.com" <jiangshanlai@gmail.com>,
        "Xiao, Jin" <jin.xiao@intel.com>,
        "Zhang, Yanmin" <yanmin.zhang@intel.com>,
        "Bai, Jie A" <jie.a.bai@intel.com>,
        "Sun, Yi J" <yi.j.sun@intel.com>,
        "Chang, Junxiao" <junxiao.chang@intel.com>,
        "Mei, Paul" <paul.mei@intel.com>
Subject: RE: rcu_preempt caused oom
Thread-Topic: rcu_preempt caused oom
Thread-Index: AdSHvQIr70OYynHSTxKgLAvVXX+0Zv//yKOAgAAWeAD//li4UIADPhuAgAAJSYD//3lRYIAAoJ4A//tcRfABJU8zAP/+T9Nw//xa4AD/91m7QP/uoBSA/9vB3nD/t3F+AP9tcGAw/tr6woD9snCZgPtjpC6Q9sakFQDtjQLogNsYI6iwtjC+vgDsYEklwNjA58YAsYF15gDjAkI/QMYE+T8AjAlMjtCYExULALAllyhg4EugVwDAlgeBUIEsZYUAglfLUqCEsA8sgIlflLnwkr+CPgClfvyHgMr46ANQlfI+RYCr4rt+ANfFPMEQr4p1nbA=
Date:   Tue, 18 Dec 2018 03:12:37 +0000
Message-ID: <CD6925E8781EFD4D8E11882D20FC406D52A1A706@SHSMSX104.ccr.corp.intel.com>
References: <88DC34334CA3444C85D647DBFA962C2735AD5F9E@SHSMSX104.ccr.corp.intel.com>
 <20181213044020.GA19765@linux.ibm.com>
 <CD6925E8781EFD4D8E11882D20FC406D52A197EC@SHSMSX104.ccr.corp.intel.com>
 <20181213181136.GL4170@linux.ibm.com>
 <CD6925E8781EFD4D8E11882D20FC406D52A198C7@SHSMSX104.ccr.corp.intel.com>
 <20181214021527.GR4170@linux.ibm.com>
 <CD6925E8781EFD4D8E11882D20FC406D52A19939@SHSMSX104.ccr.corp.intel.com>
 <20181214051011.GS4170@linux.ibm.com> <20181214053841.GA16100@linux.ibm.com>
 <CD6925E8781EFD4D8E11882D20FC406D52A1A280@SHSMSX104.ccr.corp.intel.com>
 <20181217042623.GF4170@linux.ibm.com>
 <CD6925E8781EFD4D8E11882D20FC406D52A1A634@SHSMSX104.ccr.corp.intel.com>
 <88DC34334CA3444C85D647DBFA962C2735AD64A0@SHSMSX104.ccr.corp.intel.com>
In-Reply-To: <88DC34334CA3444C85D647DBFA962C2735AD64A0@SHSMSX104.ccr.corp.intel.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZGIwNzU2ZTYtN2UxNy00ZDliLWFkNDEtZmE3OWIwZjA1ZDM5IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiejNmbkYzTFI4amJWRzJsUnBFYmFDUTNPZ1dkclI2R0lJdFZENzZtQ0tnUk5RMHlTTE5hQldFdElZMDhOSlZVYyJ9
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

check with jun:
the scenario is more like:
										                  @@@rcu_start_this_gp@@@ start after ___swait_event before schedule
rcu_gp_kthread--> swait_event_idle_exclusive--> __swait_event_idle--> ___swait_event--------->schedule
											    @@@ rcu_gp_kthread_wake skip wakeup in rcu_gp_kthread

then rcu_gp_kthread will sleep and can't wake up.

Jun's patch can workaround it, what's your ideas?


-----Original Message-----
From: Zhang, Jun 
Sent: Tuesday, December 18, 2018 10:47 AM
To: He, Bo <bo.he@intel.com>; paulmck@linux.ibm.com
Cc: Steven Rostedt <rostedt@goodmis.org>; linux-kernel@vger.kernel.org; josh@joshtriplett.org; mathieu.desnoyers@efficios.com; jiangshanlai@gmail.com; Xiao, Jin <jin.xiao@intel.com>; Zhang, Yanmin <yanmin.zhang@intel.com>; Bai, Jie A <jie.a.bai@intel.com>; Sun, Yi J <yi.j.sun@intel.com>; Chang, Junxiao <junxiao.chang@intel.com>; Mei, Paul <paul.mei@intel.com>
Subject: RE: rcu_preempt caused oom

Hello, paul

In softirq context, and current is rcu_preempt-10,  rcu_gp_kthread_wake don't wakeup rcu_preempt.
Maybe next patch could fix it. Please help review.

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c index 0b760c1..98f5b40 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1697,7 +1697,7 @@ static bool rcu_future_gp_cleanup(struct rcu_state *rsp, struct rcu_node *rnp)
  */
 static void rcu_gp_kthread_wake(struct rcu_state *rsp)  {
-       if (current == rsp->gp_kthread ||
+       if (((current == rsp->gp_kthread) && !in_softirq()) ||
            !READ_ONCE(rsp->gp_flags) ||
            !rsp->gp_kthread)
                return;

[44932.311439, 0][     rcu_preempt]      rcu_preempt-10    [001] .n.. 44929.401037: rcu_grace_period: rcu_preempt 19063548 reqwait
......
[44932.311517, 0][     rcu_preempt]      rcu_preempt-10    [001] d.s2 44929.402234: rcu_future_grace_period: rcu_preempt 19063548 19063552 0 0 3 Startleaf
[44932.311536, 0][     rcu_preempt]      rcu_preempt-10    [001] d.s2 44929.402237: rcu_future_grace_period: rcu_preempt 19063548 19063552 0 0 3 Startedroot


-----Original Message-----
From: He, Bo
Sent: Tuesday, December 18, 2018 07:16
To: paulmck@linux.ibm.com
Cc: Zhang, Jun <jun.zhang@intel.com>; Steven Rostedt <rostedt@goodmis.org>; linux-kernel@vger.kernel.org; josh@joshtriplett.org; mathieu.desnoyers@efficios.com; jiangshanlai@gmail.com; Xiao, Jin <jin.xiao@intel.com>; Zhang, Yanmin <yanmin.zhang@intel.com>; Bai, Jie A <jie.a.bai@intel.com>; Sun, Yi J <yi.j.sun@intel.com>; Chang, Junxiao <junxiao.chang@intel.com>; Mei, Paul <paul.mei@intel.com>
Subject: RE: rcu_preempt caused oom

Thanks for your comments, the issue could be panic with the change if (ret == 1). Here enclosed are the logs.

-----Original Message-----
From: Paul E. McKenney <paulmck@linux.ibm.com>
Sent: Monday, December 17, 2018 12:26 PM
To: He, Bo <bo.he@intel.com>
Cc: Zhang, Jun <jun.zhang@intel.com>; Steven Rostedt <rostedt@goodmis.org>; linux-kernel@vger.kernel.org; josh@joshtriplett.org; mathieu.desnoyers@efficios.com; jiangshanlai@gmail.com; Xiao, Jin <jin.xiao@intel.com>; Zhang, Yanmin <yanmin.zhang@intel.com>; Bai, Jie A <jie.a.bai@intel.com>; Sun, Yi J <yi.j.sun@intel.com>; Chang, Junxiao <junxiao.chang@intel.com>; Mei, Paul <paul.mei@intel.com>
Subject: Re: rcu_preempt caused oom

On Mon, Dec 17, 2018 at 03:15:42AM +0000, He, Bo wrote:
> for double confirm the issue is not reproduce after 90 hours, we tried only add the enclosed patch on the easy reproduced build, the issue is not reproduced after 63 hours in the whole weekend on 16 boards.
> so current conclusion is the debug patch has extreme  effect on the rcu issue.

This is not a surprise.  (Please see the end of this email for a replacement patch that won't suppress the bug.)

To see why this is not a surprise, let's take a closer look at your patch, in light of the comment header for wait_event_idle_timeout_exclusive():

 * Returns:
 * 0 if the @condition evaluated to %false after the @timeout elapsed,
 * 1 if the @condition evaluated to %true after the @timeout elapsed,
 * or the remaining jiffies (at least 1) if the @condition evaluated
 * to %true before the @timeout elapsed.

The situation we are seeing is that the RCU_GP_FLAG_INIT is set, but the rcu_preempt task does not wake up.  This would correspond to the second case above, that is, a return value of 1.  Looking now at your patch, with comments interspersed below:

------------------------------------------------------------------------

From e8b583aa685b3b4f304f72398a80461bba09389c Mon Sep 17 00:00:00 2001
From: "he, bo" <bo.he@intel.com>
Date: Sun, 9 Dec 2018 18:11:33 +0800
Subject: [PATCH] rcu: detect the preempt_rcu hang for triage jing's board

Change-Id: I2ffceec2ae4847867753609e45c99afc66956003
Tracked-On:
Signed-off-by: he, bo <bo.he@intel.com>
---
 kernel/rcu/tree.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c index 78c0cf2..d6de363 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2192,8 +2192,13 @@ static int __noreturn rcu_gp_kthread(void *arg)
 	int ret;
 	struct rcu_state *rsp = arg;
 	struct rcu_node *rnp = rcu_get_root(rsp);
+	pid_t rcu_preempt_pid;
 
 	rcu_bind_gp_kthread();
+	if(!strcmp(rsp->name, "rcu_preempt")) {
+		rcu_preempt_pid = rsp->gp_kthread->pid;
+	}
+
 	for (;;) {
 
 		/* Handle grace-period start. */
@@ -2202,8 +2207,19 @@ static int __noreturn rcu_gp_kthread(void *arg)
 					       READ_ONCE(rsp->gp_seq),
 					       TPS("reqwait"));
 			rsp->gp_state = RCU_GP_WAIT_GPS;
-			swait_event_idle_exclusive(rsp->gp_wq, READ_ONCE(rsp->gp_flags) &
-						     RCU_GP_FLAG_INIT);
+			if (current->pid != rcu_preempt_pid) {
+				swait_event_idle_exclusive(rsp->gp_wq, READ_ONCE(rsp->gp_flags) &
+						RCU_GP_FLAG_INIT);
+			} else {
+				ret = swait_event_idle_timeout_exclusive(rsp->gp_wq, READ_ONCE(rsp->gp_flags) &
+						RCU_GP_FLAG_INIT, 2*HZ);
+
+				if(!ret) {

We get here if ret==0.  Therefore, the above "if" statement needs to instead be "if (ret == 1) {".

In addition, in order to get event traces dumped, we also need:

					rcu_ftrace_dump(DUMP_ALL);

+					show_rcu_gp_kthreads();
+					panic("hung_task: blocked in rcu_gp_kthread init");
+				}
+			}
+
 			rsp->gp_state = RCU_GP_DONE_GPS;
 			/* Locking provides needed memory barrier. */
 			if (rcu_gp_init(rsp))
--
2.7.4

------------------------------------------------------------------------

So, again, please change the "if(!ret) {" to "if (ret == 1) {", and please add "rcu_ftrace_dump(DUMP_ALL);" right after this "if" statement, as shown above.

With that change, I bet that you will again see failures.

> Compared with the swait_event_idle_timeout_exclusive will do 3 times to check the condition, while swait_event_idle_ exclusive will do 2 times check the condition.
> 
> so today I will do another experiment, only change as below:
> -			swait_event_idle_exclusive(rsp->gp_wq, READ_ONCE(rsp->gp_flags) &
> -						     RCU_GP_FLAG_INIT);
> +			ret = swait_event_idle_timeout_exclusive(rsp->gp_wq, READ_ONCE(rsp->gp_flags) &
> +					RCU_GP_FLAG_INIT, MAX_SCHEDULE_TIMEOUT);
> +
> 
> Can you get some clues from the experiment?

Again, please instead make the changes that I called out above, with the replacement for your patch 0001 shown below.

							Thanx, Paul

PS.  I have been testing for quite some time, but am still unable
     to reproduce this.  So we must depend on you to reproduce it.

------------------------------------------------------------------------

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c index 0b760c1369f7..86152af1a580 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2153,8 +2153,13 @@ static int __noreturn rcu_gp_kthread(void *arg)
 	int ret;
 	struct rcu_state *rsp = arg;
 	struct rcu_node *rnp = rcu_get_root(rsp);
+	pid_t rcu_preempt_pid;
 
 	rcu_bind_gp_kthread();
+	if(!strcmp(rsp->name, "rcu_preempt")) {
+		rcu_preempt_pid = rsp->gp_kthread->pid;
+	}
+
 	for (;;) {
 
 		/* Handle grace-period start. */
@@ -2163,8 +2168,20 @@ static int __noreturn rcu_gp_kthread(void *arg)
 					       READ_ONCE(rsp->gp_seq),
 					       TPS("reqwait"));
 			rsp->gp_state = RCU_GP_WAIT_GPS;
-			swait_event_idle_exclusive(rsp->gp_wq, READ_ONCE(rsp->gp_flags) &
-						     RCU_GP_FLAG_INIT);
+			if (current->pid != rcu_preempt_pid) {
+				swait_event_idle_exclusive(rsp->gp_wq, READ_ONCE(rsp->gp_flags) &
+						RCU_GP_FLAG_INIT);
+			} else {
+				ret = swait_event_idle_timeout_exclusive(rsp->gp_wq, READ_ONCE(rsp->gp_flags) &
+						RCU_GP_FLAG_INIT, 2*HZ);
+
+				if (ret == 1) {
+					rcu_ftrace_dump(DUMP_ALL);
+					show_rcu_gp_kthreads();
+					panic("hung_task: blocked in rcu_gp_kthread init");
+				}
+			}
+
 			rsp->gp_state = RCU_GP_DONE_GPS;
 			/* Locking provides needed memory barrier. */
 			if (rcu_gp_init(rsp))


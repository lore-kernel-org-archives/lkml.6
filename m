Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A6A4C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 17:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38ACD2070D
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 17:03:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732472AbfACRDx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 12:03:53 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47860 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730870AbfACRDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 12:03:52 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x03GwlQS085140
        for <linux-kernel@vger.kernel.org>; Thu, 3 Jan 2019 12:03:51 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2psn3tc91y-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 12:03:51 -0500
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 3 Jan 2019 17:03:49 -0000
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 3 Jan 2019 17:03:47 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x03H3kQ119333308
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 3 Jan 2019 17:03:46 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 68E1BB205F;
        Thu,  3 Jan 2019 17:03:46 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 37782B2065;
        Thu,  3 Jan 2019 17:03:46 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.153.1])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  3 Jan 2019 17:03:45 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 7AA3316C5FC5; Thu,  3 Jan 2019 09:04:05 -0800 (PST)
Date:   Thu, 3 Jan 2019 09:04:05 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Junchang Wang <junchangwang@gmail.com>
Cc:     dave@stgolabs.net, josh@joshtriplett.org, corbet@lwn.net,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] RCU/torture.txt: remove section MODULE PARAMETERS
Reply-To: paulmck@linux.ibm.com
References: <1546525491-5724-1-git-send-email-junchangwang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1546525491-5724-1-git-send-email-junchangwang@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19010317-0040-0000-0000-000004AC19BD
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010338; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000272; SDB=6.01141214; UDB=6.00593882; IPR=6.00921439;
 MB=3.00024955; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-03 17:03:49
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19010317-0041-0000-0000-000008B719C2
Message-Id: <20190103170405.GF4170@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-03_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901030150
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 03, 2019 at 10:24:51PM +0800, Junchang Wang wrote:
> The supported module parameters are detailed in both RCU/torture.txt and 
> admin-guide/kernel-parameters.txt, and the latter is actively maintained.
> So this patch removes section MODULE PARAMETERS in torture.txt and
> adds a reference to the information in kernel-parameters.txt.
> 
> Signed-off-by: Junchang Wang <junchangwang@gmail.com>

Queued and pushed, thank you!

I made some small updates, first capitalizing the word following the
colon (":") in the subject line and second adding a search string
for Documentation/admin-guide/kernel-parameters.txt.  Please see below
and please let me know if I messed anything up.

							Thanx, Paul

------------------------------------------------------------------------

commit 150c2476dd32126505dc26f644fa8eb643630d9c
Author: Junchang Wang <junchangwang@gmail.com>
Date:   Thu Jan 3 22:24:51 2019 +0800

    RCU/torture.txt: Remove section MODULE PARAMETERS
    
    The supported module parameters are detailed in both RCU/torture.txt and
    admin-guide/kernel-parameters.txt, and the latter is actively maintained.
    So this patch removes section MODULE PARAMETERS in torture.txt and
    adds a reference to the information in kernel-parameters.txt.
    
    Signed-off-by: Junchang Wang <junchangwang@gmail.com>
    Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
    [ paulmck: Add search string. ]

diff --git a/Documentation/RCU/torture.txt b/Documentation/RCU/torture.txt
index 55918b54808b..a41a0384d20c 100644
--- a/Documentation/RCU/torture.txt
+++ b/Documentation/RCU/torture.txt
@@ -10,173 +10,8 @@ status messages via printk(), which can be examined via the dmesg
 command (perhaps grepping for "torture").  The test is started
 when the module is loaded, and stops when the module is unloaded.
 
-
-MODULE PARAMETERS
-
-This module has the following parameters:
-
-fqs_duration	Duration (in microseconds) of artificially induced bursts
-		of force_quiescent_state() invocations.  In RCU
-		implementations having force_quiescent_state(), these
-		bursts help force races between forcing a given grace
-		period and that grace period ending on its own.
-
-fqs_holdoff	Holdoff time (in microseconds) between consecutive calls
-		to force_quiescent_state() within a burst.
-
-fqs_stutter	Wait time (in seconds) between consecutive bursts
-		of calls to force_quiescent_state().
-
-gp_normal	Make the fake writers use normal synchronous grace-period
-		primitives.
-
-gp_exp		Make the fake writers use expedited synchronous grace-period
-		primitives.  If both gp_normal and gp_exp are set, or
-		if neither gp_normal nor gp_exp are set, then randomly
-		choose the primitive so that about 50% are normal and
-		50% expedited.  By default, neither are set, which
-		gives best overall test coverage.
-
-irqreader	Says to invoke RCU readers from irq level.  This is currently
-		done via timers.  Defaults to "1" for variants of RCU that
-		permit this.  (Or, more accurately, variants of RCU that do
-		-not- permit this know to ignore this variable.)
-
-n_barrier_cbs	If this is nonzero, RCU barrier testing will be conducted,
-		in which case n_barrier_cbs specifies the number of
-		RCU callbacks (and corresponding kthreads) to use for
-		this testing.  The value cannot be negative.  If you
-		specify this to be non-zero when torture_type indicates a
-		synchronous RCU implementation (one for which a member of
-		the synchronize_rcu() rather than the call_rcu() family is
-		used -- see the documentation for torture_type below), an
-		error will be reported and no testing will be carried out.
-
-nfakewriters	This is the number of RCU fake writer threads to run.  Fake
-		writer threads repeatedly use the synchronous "wait for
-		current readers" function of the interface selected by
-		torture_type, with a delay between calls to allow for various
-		different numbers of writers running in parallel.
-		nfakewriters defaults to 4, which provides enough parallelism
-		to trigger special cases caused by multiple writers, such as
-		the synchronize_srcu() early return optimization.
-
-nreaders	This is the number of RCU reading threads supported.
-		The default is twice the number of CPUs.  Why twice?
-		To properly exercise RCU implementations with preemptible
-		read-side critical sections.
-
-onoff_interval
-		The number of seconds between each attempt to execute a
-		randomly selected CPU-hotplug operation.  Defaults to
-		zero, which disables CPU hotplugging.  In HOTPLUG_CPU=n
-		kernels, rcutorture will silently refuse to do any
-		CPU-hotplug operations regardless of what value is
-		specified for onoff_interval.
-
-onoff_holdoff	The number of seconds to wait until starting CPU-hotplug
-		operations.  This would normally only be used when
-		rcutorture was built into the kernel and started
-		automatically at boot time, in which case it is useful
-		in order to avoid confusing boot-time code with CPUs
-		coming and going.
-
-shuffle_interval
-		The number of seconds to keep the test threads affinitied
-		to a particular subset of the CPUs, defaults to 3 seconds.
-		Used in conjunction with test_no_idle_hz.
-
-shutdown_secs	The number of seconds to run the test before terminating
-		the test and powering off the system.  The default is
-		zero, which disables test termination and system shutdown.
-		This capability is useful for automated testing.
-
-stall_cpu	The number of seconds that a CPU should be stalled while
-		within both an rcu_read_lock() and a preempt_disable().
-		This stall happens only once per rcutorture run.
-		If you need multiple stalls, use modprobe and rmmod to
-		repeatedly run rcutorture.  The default for stall_cpu
-		is zero, which prevents rcutorture from stalling a CPU.
-
-		Note that attempts to rmmod rcutorture while the stall
-		is ongoing will hang, so be careful what value you
-		choose for this module parameter!  In addition, too-large
-		values for stall_cpu might well induce failures and
-		warnings in other parts of the kernel.  You have been
-		warned!
-
-stall_cpu_holdoff
-		The number of seconds to wait after rcutorture starts
-		before stalling a CPU.  Defaults to 10 seconds.
-
-stat_interval	The number of seconds between output of torture
-		statistics (via printk()).  Regardless of the interval,
-		statistics are printed when the module is unloaded.
-		Setting the interval to zero causes the statistics to
-		be printed -only- when the module is unloaded, and this
-		is the default.
-
-stutter		The length of time to run the test before pausing for this
-		same period of time.  Defaults to "stutter=5", so as
-		to run and pause for (roughly) five-second intervals.
-		Specifying "stutter=0" causes the test to run continuously
-		without pausing, which is the old default behavior.
-
-test_boost	Whether or not to test the ability of RCU to do priority
-		boosting.  Defaults to "test_boost=1", which performs
-		RCU priority-inversion testing only if the selected
-		RCU implementation supports priority boosting.  Specifying
-		"test_boost=0" never performs RCU priority-inversion
-		testing.  Specifying "test_boost=2" performs RCU
-		priority-inversion testing even if the selected RCU
-		implementation does not support RCU priority boosting,
-		which can be used to test rcutorture's ability to
-		carry out RCU priority-inversion testing.
-
-test_boost_interval
-		The number of seconds in an RCU priority-inversion test
-		cycle.	Defaults to "test_boost_interval=7".  It is
-		usually wise for this value to be relatively prime to
-		the value selected for "stutter".
-
-test_boost_duration
-		The number of seconds to do RCU priority-inversion testing
-		within any given "test_boost_interval".  Defaults to
-		"test_boost_duration=4".
-
-test_no_idle_hz	Whether or not to test the ability of RCU to operate in
-		a kernel that disables the scheduling-clock interrupt to
-		idle CPUs.  Boolean parameter, "1" to test, "0" otherwise.
-		Defaults to omitting this test.
-
-torture_type	The type of RCU to test, with string values as follows:
-
-		"rcu":  rcu_read_lock(), rcu_read_unlock() and call_rcu(),
-			along with expedited, synchronous, and polling
-			variants.
-
-		"rcu_bh": rcu_read_lock_bh(), rcu_read_unlock_bh(), and
-			call_rcu_bh(), along with expedited and synchronous
-			variants.
-
-		"rcu_busted": This tests an intentionally incorrect version
-			of RCU in order to help test rcutorture itself.
-
-		"srcu": srcu_read_lock(), srcu_read_unlock() and
-			call_srcu(), along with expedited and
-			synchronous variants.
-
-		"sched": preempt_disable(), preempt_enable(), and
-			call_rcu_sched(), along with expedited,
-			synchronous, and polling variants.
-
-		"tasks": voluntary context switch and call_rcu_tasks(),
-			along with expedited and synchronous variants.
-
-		Defaults to "rcu".
-
-verbose		Enable debug printk()s.  Default is disabled.
-
+Module parameters are prefixed by "rcutorture." in
+Documentation/admin-guide/kernel-parameters.txt.
 
 OUTPUT
 


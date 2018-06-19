Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A64C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 01:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B1AF2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 01:06:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B1AF2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937165AbeFSBGN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 21:06:13 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55194 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S937125AbeFSBGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 21:06:11 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5J14n2k071759
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 21:06:11 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jpng8vu9d-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 21:06:10 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 18 Jun 2018 21:06:10 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 18 Jun 2018 21:06:05 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5J164EJ19267860
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 19 Jun 2018 01:06:04 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 73312B2065;
        Mon, 18 Jun 2018 21:05:54 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3D423B2066;
        Mon, 18 Jun 2018 21:05:54 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.187.236])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 18 Jun 2018 21:05:54 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id E5FF516C6B5C; Mon, 18 Jun 2018 18:08:03 -0700 (PDT)
Date:   Mon, 18 Jun 2018 18:08:03 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     kernel test robot <xiaolong.ye@intel.com>,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        mingo@redhat.com, Steven Rostedt <rostedt@goodmis.org>,
        tglx@linutronix.de, lkp@01.org
Subject: Re: [lkp-robot] [rcutorture]  46e26223e3:
 WARNING:at_kernel/rcu/rcutorture.c:#rcu_torture_stats_print
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180610234544.150933-2-joel@joelfernandes.org>
 <20180613065711.GZ16472@yexl-desktop>
 <20180613072948.GA142000@joelaf.mtv.corp.google.com>
 <20180618165646.GA3593@linux.vnet.ibm.com>
 <20180618222647.GA156172@joelaf.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180618222647.GA156172@joelaf.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18061901-0068-0000-0000-0000030AF065
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009217; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000265; SDB=6.01049004; UDB=6.00537468; IPR=6.00827977;
 MB=3.00021729; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-19 01:06:08
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18061901-0069-0000-0000-000044BB7C82
Message-Id: <20180619010803.GC3593@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-18_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806190011
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 03:26:47PM -0700, Joel Fernandes wrote:
> On Mon, Jun 18, 2018 at 09:56:46AM -0700, Paul E. McKenney wrote:
> > > The reason for the rcutorture test failure could be that the default
> > > kthread_prio for the system's RCU threads is set to 1 (unless overridden by
> > > rcutree.kthread_prio) which is also equal to the priority of the rcutorture's
> > > boost threads. Due to this the rcutorture test could starve the RCU threads
> > > as well and defeat the boosting mechanism. I was able to solve a similar
> > > issue by just passing rcutree.kthread_prio of 50 on the kernel command line.
> > > 
> > > Paul, would it be ok if we changed the default kthread_prio to something > 1
> > > so that rcutorture can test properly without needing to pass any extra
> > > rcutree.* parameters?
> > > 
> > > so something like this in kernel/rcu/tree.c ?
> > > 
> > > static int kthread_prio = IS_ENABLED(CONFIG_RCU_BOOST) ? 2 : 0;
> > 
> > Would it be possible to also condition this on rcutorture being built
> > in?  Or are they doing modprobes for rcutorture?
> 
> They seem to be doing built-in rcutorture tests. But I believe the same
> problem would occur even if you used modules? I believe the fact that
> rcutorture is a module or built-in wouldn't matter to the underlying issue
> which is the RCU subsystems's threads are at too low of a priority
> (rcutree.kthread_prio = 1).

Understood...

> If you agree with changing the default priority, I have included a patch
> below for rcu/dev.

The problem is that without rcutorture, rcutree.kthread_prio=1 is a
legitimate choice, and changing the default globally could be breaking
someone.  So it would be far better to up the priority only during known
rcutorture testing.

							Thanx, Paul

> thanks,
> 
>  - Joel
> 
> ---8<-----------------------
> 
> >From b0f4111ef1abd1c481c269fadb3535c83ab43c93 Mon Sep 17 00:00:00 2001
> From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> Date: Mon, 18 Jun 2018 15:13:10 -0700
> Subject: [PATCH] rcu: Change default RCU kthread priority to 2
> 
> The current RT priority of 1 for RCU kthreads makes rcutorture's boost test
> fail on systems where rcutree.kthread_prio isn't passed.
> 
> The rcutorture boost kthreads have the same priority as well (RT priority of
> 1). Due to this, the rcutorture kthreads starve the RCU subsystem's kthreads
> and causes rcutorture failures. This patch changes the priority of the RCU
> subsystem's threads to a default RT priority of 2 so that rcutorture's
> threads get preempted by them. Verified that the boost tests will pass with
> this change.
> 
> Reported-by: Xiaolong Ye (via lkp-robot) <xiaolong.ye@intel.com>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  kernel/rcu/tree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index deb2508be923..920c39e3f871 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -171,7 +171,7 @@ static void rcu_report_exp_rdp(struct rcu_state *rsp,
>  static void sync_sched_exp_online_cleanup(int cpu);
> 
>  /* rcuc/rcub kthread realtime priority */
> -static int kthread_prio = IS_ENABLED(CONFIG_RCU_BOOST) ? 1 : 0;
> +static int kthread_prio = IS_ENABLED(CONFIG_RCU_BOOST) ? 2 : 0;
>  module_param(kthread_prio, int, 0644);
> 
>  /* Delay in jiffies for grace-period initialization delays, debug only. */
> -- 
> 2.18.0.rc1.244.gcf134e6275-goog
> 


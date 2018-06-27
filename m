Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 179D0C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 14:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB02525F9D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 14:23:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB02525F9D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934545AbeF0OXb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 10:23:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42964 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932907AbeF0OXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 10:23:30 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5REJwm1080915
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 10:23:29 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jva6fetgc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 10:23:29 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 27 Jun 2018 10:23:28 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 27 Jun 2018 10:23:24 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5RENN491835302
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 27 Jun 2018 14:23:23 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C863BB206E;
        Wed, 27 Jun 2018 10:23:15 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9F92DB2078;
        Wed, 27 Jun 2018 10:23:15 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 27 Jun 2018 10:23:15 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 0461E16CA20F; Wed, 27 Jun 2018 07:25:29 -0700 (PDT)
Date:   Wed, 27 Jun 2018 07:25:29 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: sched/core warning triggers on rcu torture test
Reply-To: paulmck@linux.vnet.ibm.com
References: <alpine.DEB.2.21.1806261709001.19188@somnus>
 <20180626163255.GG2458@hirez.programming.kicks-ass.net>
 <20180626174826.GB3593@linux.vnet.ibm.com>
 <20180627104014.GB10102@lerouge>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180627104014.GB10102@lerouge>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18062714-0060-0000-0000-00000283456D
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009263; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01053093; UDB=6.00539924; IPR=6.00831017;
 MB=3.00021878; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-27 14:23:26
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062714-0061-0000-0000-00004598040F
Message-Id: <20180627142529.GU3593@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-27_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806270158
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 12:40:15PM +0200, Frederic Weisbecker wrote:
> On Tue, Jun 26, 2018 at 10:48:26AM -0700, Paul E. McKenney wrote:
> > On Tue, Jun 26, 2018 at 06:32:55PM +0200, Peter Zijlstra wrote:
> > > On Tue, Jun 26, 2018 at 06:16:04PM +0200, Anna-Maria Gleixner wrote:
> > > > Hi,
> > > > 
> > > > during rcu torture tests (TREE04 and TREE07) I noticed, that a
> > > > WARN_ON_ONCE() in sched core triggers on a recent 4.18-rc2 based
> > > > kernel (6f0d349d922b ("Merge
> > > > git://git.kernel.org/pub/scm/linux/kernel/git/davem/net")) as well as
> > > > on a 4.17.3.
> > 
> > First, I am very glad that I am not the only one running rcutorture!  ;-)
> > 
> > > > I'm running the tests on a machine with 144 cores:
> > > > 
> > > >   tools/testing/selftests/rcutorture/bin/kvm.sh --cpus 144 --duration 120 --configs "9*TREE07"
> > > >   tools/testing/selftests/rcutorture/bin/kvm.sh --cpus 144 --duration 120 --configs "18*TREE04"
> > > > 
> > > > 
> > > > The warning was introduced by commit d84b31313ef8 ("sched/isolation:
> > > > Offload residual 1Hz scheduler tick").
> > > > 
> > > > 
> > > > Output looks similar for all tests I did (this one is the output of
> > > > the 4.18-rc2 based kernel):
> > > > 
> > > > WARNING: CPU: 11 PID: 906 at kernel/sched/core.c:3138 sched_tick_remote+0xb6/0xc0
> > > 
> > > That's nohz_full stuff, is that a normal part of rcutorture? In any
> > > case, is the one housekeeping CPU getting seriously overloaded or
> > > something?
> > 
> > Yes, nohz_full is a normal part for rcutorture because RCU has to deal
> > differently with userspace execution in the nohz_full case.
> > 
> > I do see this splat (at least when I don't comment it out), but I
> > do share my system with others, so I could easily be overloading the
> > housekeeping vCPUs due to hypervisor preemption.  I was intending to
> > dig into this one once I got done consolidating RCU-bh, RCU-preempt,
> > and RCU-sched at Linus's behest.
> > 
> > On overloading the housekeeping CPU without outside load, let's look at
> > TREE04 and TREE07 separately.
> > 
> > TREE04 uses eight CPUs, and seven of them ("nohz_full=1-7") are nohz_full
> > CPUs, and rcutorture doesn't generate all that large of a callback load.
> > It looks like all 144 CPUs are used in this case (18*8), though RCU
> > enforces idle periods in order to test idle/non-idle transitions.
> > But was there anything else running on the machine at the time?
> > 
> > TREE07 uses 16 CPUs, and eight of them ("nohz_full=2-9") are nohz_full
> > CPUs.  Again, it looks like all 144 CPUs are used (9*8).
> > 
> > I sometimes see this on TASKS03 as well, which uses two CPUs, and one of
> > them ("nohz_full=1") is a nohz_full CPU.
> > 
> > If your system is otherwise idle, would it make sense to trace context
> > switches on CPU 0 to see what it is up to?  And to do an ftrace_dump()
> > and turn tracing off when the warning triggers as well?
> 
> Yeah you guys reported me this warning a few times ago. I didn't manage to reproduce
> it because I fought and failed with a high NR_CPUS machine. But apparently 8 CPUs
> are enough. Let me try that with TREE04.

Looking forward to hearing what you find!

							Thanx, Paul


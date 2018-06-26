Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA9CEC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DD7026D00
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:46:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DD7026D00
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754648AbeFZRqa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 13:46:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60858 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751043AbeFZRq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 13:46:26 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5QHhsoR094027
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 13:46:26 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2juqcprg0a-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 13:46:25 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 26 Jun 2018 13:46:24 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 26 Jun 2018 13:46:22 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5QHkLqv9699742
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Jun 2018 17:46:21 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 23080B2071;
        Tue, 26 Jun 2018 13:46:15 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 02773B2066;
        Tue, 26 Jun 2018 13:46:14 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 26 Jun 2018 13:46:14 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id DA8DD16C2467; Tue, 26 Jun 2018 10:48:26 -0700 (PDT)
Date:   Tue, 26 Jun 2018 10:48:26 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Anna-Maria Gleixner <anna-maria@linutronix.de>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: sched/core warning triggers on rcu torture test
Reply-To: paulmck@linux.vnet.ibm.com
References: <alpine.DEB.2.21.1806261709001.19188@somnus>
 <20180626163255.GG2458@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180626163255.GG2458@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18062617-0072-0000-0000-00000374CBB1
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009259; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01052681; UDB=6.00539676; IPR=6.00830605;
 MB=3.00021865; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-26 17:46:24
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062617-0073-0000-0000-0000487E88A4
Message-Id: <20180626174826.GB3593@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-26_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=974 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806260200
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 06:32:55PM +0200, Peter Zijlstra wrote:
> On Tue, Jun 26, 2018 at 06:16:04PM +0200, Anna-Maria Gleixner wrote:
> > Hi,
> > 
> > during rcu torture tests (TREE04 and TREE07) I noticed, that a
> > WARN_ON_ONCE() in sched core triggers on a recent 4.18-rc2 based
> > kernel (6f0d349d922b ("Merge
> > git://git.kernel.org/pub/scm/linux/kernel/git/davem/net")) as well as
> > on a 4.17.3.

First, I am very glad that I am not the only one running rcutorture!  ;-)

> > I'm running the tests on a machine with 144 cores:
> > 
> >   tools/testing/selftests/rcutorture/bin/kvm.sh --cpus 144 --duration 120 --configs "9*TREE07"
> >   tools/testing/selftests/rcutorture/bin/kvm.sh --cpus 144 --duration 120 --configs "18*TREE04"
> > 
> > 
> > The warning was introduced by commit d84b31313ef8 ("sched/isolation:
> > Offload residual 1Hz scheduler tick").
> > 
> > 
> > Output looks similar for all tests I did (this one is the output of
> > the 4.18-rc2 based kernel):
> > 
> > WARNING: CPU: 11 PID: 906 at kernel/sched/core.c:3138 sched_tick_remote+0xb6/0xc0
> 
> That's nohz_full stuff, is that a normal part of rcutorture? In any
> case, is the one housekeeping CPU getting seriously overloaded or
> something?

Yes, nohz_full is a normal part for rcutorture because RCU has to deal
differently with userspace execution in the nohz_full case.

I do see this splat (at least when I don't comment it out), but I
do share my system with others, so I could easily be overloading the
housekeeping vCPUs due to hypervisor preemption.  I was intending to
dig into this one once I got done consolidating RCU-bh, RCU-preempt,
and RCU-sched at Linus's behest.

On overloading the housekeeping CPU without outside load, let's look at
TREE04 and TREE07 separately.

TREE04 uses eight CPUs, and seven of them ("nohz_full=1-7") are nohz_full
CPUs, and rcutorture doesn't generate all that large of a callback load.
It looks like all 144 CPUs are used in this case (18*8), though RCU
enforces idle periods in order to test idle/non-idle transitions.
But was there anything else running on the machine at the time?

TREE07 uses 16 CPUs, and eight of them ("nohz_full=2-9") are nohz_full
CPUs.  Again, it looks like all 144 CPUs are used (9*8).

I sometimes see this on TASKS03 as well, which uses two CPUs, and one of
them ("nohz_full=1") is a nohz_full CPU.

If your system is otherwise idle, would it make sense to trace context
switches on CPU 0 to see what it is up to?  And to do an ftrace_dump()
and turn tracing off when the warning triggers as well?

							Thanx, Paul


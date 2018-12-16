Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1600C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 18:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 773522086C
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 18:51:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730774AbeLPSvj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 13:51:39 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60334 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730593AbeLPSvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 13:51:39 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wBGImwGM054698
        for <linux-kernel@vger.kernel.org>; Sun, 16 Dec 2018 13:51:38 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pdfman2pj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 16 Dec 2018 13:51:38 -0500
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Sun, 16 Dec 2018 18:51:35 -0000
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 16 Dec 2018 18:51:29 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wBGIpS2T21692458
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 16 Dec 2018 18:51:28 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9BA53B2065;
        Sun, 16 Dec 2018 18:51:28 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 62DF6B2064;
        Sun, 16 Dec 2018 18:51:28 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.153.1])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sun, 16 Dec 2018 18:51:28 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 71C5916C0FD2; Sun, 16 Dec 2018 10:51:30 -0800 (PST)
Date:   Sun, 16 Dec 2018 10:51:30 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     David Goldblatt <davidtgoldblatt@gmail.com>,
        mathieu.desnoyers@efficios.com,
        Florian Weimer <fweimer@redhat.com>, triegel@redhat.com,
        libc-alpha@sourceware.org, andrea.parri@amarulasolutions.com,
        will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com, dlustig@nvidia.com,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Linux: Implement membarrier function
Reply-To: paulmck@linux.ibm.com
References: <20181214184344.GW4170@linux.ibm.com>
 <Pine.LNX.4.44L0.1812141404450.1570-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1812141404450.1570-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18121618-0052-0000-0000-000003683A04
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010237; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000271; SDB=6.01132725; UDB=6.00588778; IPR=6.00912856;
 MB=3.00024712; MTD=3.00000008; XFM=3.00000015; UTC=2018-12-16 18:51:34
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18121618-0053-0000-0000-00005F213DF4
Message-Id: <20181216185130.GB4170@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-16_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=401 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812160176
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 04:39:34PM -0500, Alan Stern wrote:
> On Fri, 14 Dec 2018, Paul E. McKenney wrote:
> 
> > I would say that sys_membarrier() has zero-sized read-side critical
> > sections, either comprising a single instruction (as is the case for
> > synchronize_sched(), actually), preempt-disable regions of code
> > (which are irrelevant to userspace execution), or the spaces between
> > consecutive pairs of instructions (as is the case for the newer
> > IPI-based implementation).
> > 
> > The model picks the single-instruction option, and I haven't yet found
> > a problem with this -- which is no surprise given that, as you say,
> > an actual implementation makes this same choice.
> 
> I believe that for RCU tests the LKMM gives the same results for
> length-zero critical sections interspersed between all the instructions
> and length-one critical sections surrounding all instructions (except
> synchronize_rcu).  But the proof is tricky and I haven't checked it
> carefully.

That assertion is completely consistent with my implementation experience,
give or take the usual caveats about idle and offline execution.

> > > > The other thing that took some time to get used to is the possibility
> > > > of long delays during sys_membarrier() execution, allowing significant
> > > > execution and reordering between different CPUs' IPIs.  This was key
> > > > to my understanding of the six-process example, and probably needs to
> > > > be clearly called out, including in an example or two.
> > > 
> > > In all the examples I'm aware of, no more than one of the IPIs
> > > generated by each sys_membarrier call really matters.  (Of course,
> > > there's no way to know in advance which one it will be, so you have to
> > > send an IPI to every CPU.)  The execution delays and reordering
> > > between different CPUs' IPIs don't appear to be significant.
> > 
> > Well, there are litmus tests that are allowed in which the allowed
> > execution is more easily explained in terms of delays between different
> > CPUs' IPIs, so it seems worth keeping track of.
> > 
> > There might be a litmus test that can tell the difference between
> > simultaneous and non-simultaneous IPIs, but I cannot immediately think of
> > one that matters.  Might be a failure of imagination on my part, though.
> 
> 	P0	P1	P2
> 	Wc=1	[mb01]	Rb=1
> 	memb	Wa=1	Rc=0
> 	Ra=0	Wb=1	[mb02]
> 
> The IPIs have to appear in the positions shown, which means they cannot
> be simultaneous.  The test is allowed because P2's reads can be
> reordered.

OK, so "simultaneous" IPIs could be emulated in a real implementation by
having sys_membarrier() send each IPI (but not wait for a response), then
execute a full memory barrier and set a shared variable.  Each IPI handler
would spin waiting for the shared variable to be set, then execute a full
memory barrier and atomically increment yet another shared variable and
return from interrupt.  When that other shared variable's value reached
the number of IPIs sent, the sys_membarrier() would execute its final
(already existing) full memory barrier and return.  Horribly expensive
and definitely not recommended, but eminently doable.

The difference between current sys_membarrier() and the "simultaneous"
variant described above is similar to the difference between
non-multicopy-atomic and multicopy-atomic memory ordering.  So, after
thinking it through, my guess is that pretty much any litmus test that
can discern between multicopy-atomic and  non-multicopy-atomic should
be transformable into something that can distinguish between the current
and the "simultaneous" sys_membarrier() implementation.

Seem reasonable?

Or alternatively, may I please apply your Signed-off-by to your earlier
sys_membarrier() patch so that I can queue it?  I will probably also
change smp_memb() to membarrier() or some such.  Again, within the
Linux kernel, membarrier() can be emulated with smp_call_function()
invoking a handler that does smp_mb().

							Thanx, Paul


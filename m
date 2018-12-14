Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB90C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 18:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4D77206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 18:43:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730628AbeLNSnz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 13:43:55 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45960 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730410AbeLNSnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 13:43:55 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wBEIY0uC011281
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 13:43:52 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pcftmx6wc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 13:43:51 -0500
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Fri, 14 Dec 2018 18:43:50 -0000
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 14 Dec 2018 18:43:45 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wBEIhigj8847390
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 14 Dec 2018 18:43:44 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B43CEB2065;
        Fri, 14 Dec 2018 18:43:44 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 85BB0B205F;
        Fri, 14 Dec 2018 18:43:44 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.153.1])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 14 Dec 2018 18:43:44 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id A3C6E16C2C26; Fri, 14 Dec 2018 10:43:44 -0800 (PST)
Date:   Fri, 14 Dec 2018 10:43:44 -0800
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
References: <20181214002043.GP4170@linux.ibm.com>
 <Pine.LNX.4.44L0.1812141013070.1570-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1812141013070.1570-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18121418-0052-0000-0000-00000367665F
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010225; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000271; SDB=6.01131762; UDB=6.00588201; IPR=6.00911893;
 MB=3.00024692; MTD=3.00000008; XFM=3.00000015; UTC=2018-12-14 18:43:49
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18121418-0053-0000-0000-00005F1BBC80
Message-Id: <20181214184344.GW4170@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-14_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=936 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812140159
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 10:31:51AM -0500, Alan Stern wrote:
> On Thu, 13 Dec 2018, Paul E. McKenney wrote:
> 
> > > > I guess that I still haven't gotten over being a bit surprised that the
> > > > RCU counting rule also applies to sys_membarrier().  ;-)
> > > 
> > > Why not?  They are both synchronization mechanisms with heavy-weight
> > > write sides and light-weight read sides, and most importantly, they
> > > provide the same Guarantee.
> > 
> > True, but I do feel the need to poke at it.
> > 
> > The zero-size sys_membarrier() read-side critical sections do make
> > things act a bit differently, for example, interchanging the accesses
> > in an RCU read-side critical section has no effect, while doing so in
> > a sys_membarrier() reader can cause the result to be allowed.  One key
> > point is that everything before the end of a read-side critical section
> > of any type is ordered before any later grace period of that same type,
> > and vice versa.
> > 
> > This is why reordering accesses matters for sys_membarrier() readers but
> > not for RCU and SRCU readers -- in the case of RCU and SRCU readers,
> > the accesses are inside the read-side critical section, while for
> > sys_membarrier() readers, the read-side critical sections don't have
> > an inside.  So yes, ordering also matters in the case of SRCU and
> > RCU readers for accesses outside of the read-side critical sections.
> > The reason sys_membarrier() seems surprising to me isn't because it is
> > any different in theoretical structure, but rather because the practice
> > is to put RCU and SRCU read-side accesses inside a read-side critical
> > sections, which is impossible for sys_membarrier().
> 
> RCU and sys_membarrier are more similar than you might think at first.  
> For one thing, if there were primitives for blocking and unblocking
> reception of IPIs, those primitives would delimit critical sections for
> sys_membarrier.  (Maybe such things do exist; I wouldn't know.)

Within the kernel of course local_irq_disable() and friends.  In
userspace, there have been proposals to make the IPI handler interact
with rseq or equivalent, which would have a roughly similar effect.

> For another, the way we model RCU isn't fully accurate for the Linux
> kernel, as you know.  Since individual instructions cannot be
> preempted, each instruction is a tiny read-side critical section.
> Thus, litmus tests like this one:
> 
> 	P0			P1
> 	Wa=1			Wb=1
> 	synchronize_rcu()	Ra=0
> 	Rb=0
> 
> actually are forbidden in the kernel (provided P1 isn't part of the
> idle loop!), even though the LKMM allows them.  However, it wouldn't
> be forbidden if the accesses in P1 were swapped -- just like with
> sys_membarrier.

And that P1 isn't executing on a CPU that RCU believes to be offline,
but yes.

But this is an implementation choice, and SRCU makes a different choice,
which would allow the litmus test shown above.  And it would be good to
keep this freedom for the implementation, in other words, this difference
is a good thing, so let's please keep it.  ;-)

> Put these two observations together and you see that sys_membarrier is
> almost exactly the same as RCU without explicit read-side critical
> sections. Perhaps this isn't surprising, given that the initial
> implementation of sys_membarrier() was pretty much the same as
> synchronize_rcu().

Heh!  The initial implementation in the Linux kernel was exactly
synchronize_sched().  ;-)

I would say that sys_membarrier() has zero-sized read-side critical
sections, either comprising a single instruction (as is the case for
synchronize_sched(), actually), preempt-disable regions of code
(which are irrelevant to userspace execution), or the spaces between
consecutive pairs of instructions (as is the case for the newer
IPI-based implementation).

The model picks the single-instruction option, and I haven't yet found
a problem with this -- which is no surprise given that, as you say,
an actual implementation makes this same choice.

> > The other thing that took some time to get used to is the possibility
> > of long delays during sys_membarrier() execution, allowing significant
> > execution and reordering between different CPUs' IPIs.  This was key
> > to my understanding of the six-process example, and probably needs to
> > be clearly called out, including in an example or two.
> 
> In all the examples I'm aware of, no more than one of the IPIs
> generated by each sys_membarrier call really matters.  (Of course,
> there's no way to know in advance which one it will be, so you have to
> send an IPI to every CPU.)  The execution delays and reordering
> between different CPUs' IPIs don't appear to be significant.

Well, there are litmus tests that are allowed in which the allowed
execution is more easily explained in terms of delays between different
CPUs' IPIs, so it seems worth keeping track of.

There might be a litmus test that can tell the difference between
simultaneous and non-simultaneous IPIs, but I cannot immediately think of
one that matters.  Might be a failure of imagination on my part, though.

> > The interleaving restrictions are straightforward for me, but the
> > fixed-time approach does have some interesting cross-talk potential
> > between sys_membarrier() and RCU read-side critical sections whose
> > accesses have been reversed.  I don't believe that it is possible to
> > leverage this "order the other guy's read-side critical sections" effect
> > in the general case, but I could be missing something.
> 
> I regard the fixed-time approach as nothing more than a heuristic
> aid.  It's not an accurate explaination of what's really going on.

Agreed, albeit a useful heuristic aid in scripts generating litmus tests.

							Thanx, Paul

> > If you are claiming that I am worrying unnecessarily, you are probably
> > right.  But if I didn't worry unnecessarily, RCU wouldn't work at all!  ;-)
> 
> Alan
> 


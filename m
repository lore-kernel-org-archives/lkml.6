Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ED51C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 19:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0891720870
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 19:08:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0891720870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbeLKTIM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 14:08:12 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41786 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726329AbeLKTIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 14:08:11 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wBBJ5K9w054235
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 14:08:09 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2paj7r2d0y-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 14:08:09 -0500
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 11 Dec 2018 19:08:08 -0000
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 11 Dec 2018 19:08:02 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wBBJ81jU19791898
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 11 Dec 2018 19:08:01 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 465E1B2065;
        Tue, 11 Dec 2018 19:08:01 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0BC45B2067;
        Tue, 11 Dec 2018 19:08:00 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.38])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 11 Dec 2018 19:08:00 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 2F95F16C21CA; Tue, 11 Dec 2018 11:08:01 -0800 (PST)
Date:   Tue, 11 Dec 2018 11:08:01 -0800
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
References: <20181210182516.GV4170@linux.ibm.com>
 <Pine.LNX.4.44L0.1812111115020.1538-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1812111115020.1538-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18121119-0052-0000-0000-000003658C59
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010214; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01130330; UDB=6.00587343; IPR=6.00910463;
 MB=3.00024656; MTD=3.00000008; XFM=3.00000015; UTC=2018-12-11 19:08:06
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18121119-0053-0000-0000-00005F1191FE
Message-Id: <20181211190801.GO4170@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-11_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812110169
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 11:21:15AM -0500, Alan Stern wrote:
> On Mon, 10 Dec 2018, Paul E. McKenney wrote:
> 
> > On Mon, Dec 10, 2018 at 11:22:31AM -0500, Alan Stern wrote:
> > > On Thu, 6 Dec 2018, Paul E. McKenney wrote:
> > > 
> > > > Hello, David,
> > > > 
> > > > I took a crack at extending LKMM to accommodate what I think would
> > > > support what you have in your paper.  Please see the very end of this
> > > > email for a patch against the "dev" branch of my -rcu tree.
> > > > 
> > > > This gives the expected result for the following three litmus tests,
> > > > but is probably deficient or otherwise misguided in other ways.  I have
> > > > added the LKMM maintainers on CC for their amusement.  ;-)
> > > > 
> > > > Thoughts?
> > > 
> > > Since sys_membarrier() provides a heavyweight barrier comparable to 
> > > synchronize_rcu(), the memory model should treat the two in the same 
> > > way.  That's what this patch does.
> > > 
> > > The corresponding critical section would be any region of code bounded
> > > by compiler barriers.  Since the LKMM doesn't currently handle plain
> > > accesses, the effect is the same as if a compiler barrier were present
> > > between each pair of instructions.  Basically, each instruction acts as
> > > its own critical section.  Therefore the patch below defines memb-rscsi
> > > as the trivial identity relation.  When plain accesses and compiler 
> > > barriers are added to the memory model, a different definition will be 
> > > needed.
> > > 
> > > This gives the correct results for the three C-Goldblat-memb-* litmus 
> > > tests in Paul's email.
> > 
> > Yow!!!
> > 
> > My first reaction was that this cannot possibly be correct because
> > sys_membarrier(), which is probably what we should call it, does not
> > wait for anything.  But your formulation has the corresponding readers
> > being "id", which as you say above is just a single event.
> > 
> > But what makes this work for the following litmus test?
> > 
> > ------------------------------------------------------------------------
> > 
> > C membrcu
> > 
> > {
> > }
> > 
> > P0(intptr_t *x0, intptr_t *x1)
> > {
> > 	WRITE_ONCE(*x0, 2);
> > 	smp_memb();
> > 	intptr_t r2 = READ_ONCE(*x1);
> > }
> > 
> > 
> > P1(intptr_t *x1, intptr_t *x2)
> > {
> > 	WRITE_ONCE(*x1, 2);
> > 	smp_memb();
> > 	intptr_t r2 = READ_ONCE(*x2);
> > }
> > 
> > 
> > P2(intptr_t *x2, intptr_t *x3)
> > {
> > 	WRITE_ONCE(*x2, 2);
> > 	smp_memb();
> > 	intptr_t r2 = READ_ONCE(*x3);
> > }
> > 
> > 
> > P3(intptr_t *x3, intptr_t *x4)
> > {
> > 	rcu_read_lock();
> > 	WRITE_ONCE(*x3, 2);
> > 	intptr_t r2 = READ_ONCE(*x4);
> > 	rcu_read_unlock();
> > }
> > 
> > 
> > P4(intptr_t *x4, intptr_t *x5)
> > {
> > 	rcu_read_lock();
> > 	WRITE_ONCE(*x4, 2);
> > 	intptr_t r2 = READ_ONCE(*x5);
> > 	rcu_read_unlock();
> > }
> > 
> > 
> > P5(intptr_t *x0, intptr_t *x5)
> > {
> > 	rcu_read_lock();
> > 	WRITE_ONCE(*x5, 2);
> > 	intptr_t r2 = READ_ONCE(*x0);
> > 	rcu_read_unlock();
> > }
> > 
> > exists
> > (5:r2=0 /\ 0:r2=0 /\ 1:r2=0 /\ 2:r2=0 /\ 3:r2=0 /\ 4:r2=0)
> > 
> > ------------------------------------------------------------------------
> > 
> > For this, herd gives "Never".  Of course, if I reverse the write and
> > read in any of P3(), P4(), or P5(), I get "Sometimes", which does make
> > sense.  But what is preserving the order between P3() and P4() and
> > between P4() and P5()?  I am not immediately seeing how the analogy
> > with RCU carries over to this case.
> 
> That isn't how it works.  Nothing preserves the orders you mentioned.
> It's more like: the order between P1 and P4 is preserved, as is the
> order between P0 and P5.  You'll see below...
> 
> (I readily agree that this result is not simple or obvious.  It took me
> quite a while to formulate the following analysis.)

For whatever it is worth, David Goldblatt agrees with you to at
least some extent.  I have sent him an inquiry.  ;-)

> To begin with, since there aren't any synchronize_rcu calls in the
> test, the rcu_read_lock and rcu_read_unlock calls do nothing.  They
> can be eliminated.

Agreed.  I was just being lazy.

> Also, I find the variable names "x0" - "x5" to be a little hard to
> work with.  If you don't mind, I'll replace them with "a" - "f".

Easy enough to translate, so have at it!

> Now, a little digression on how sys_membarrier works.  It starts by
> executing a full memory barrier.  Then it injects memory barriers into
> the instruction streams of all the other CPUs and waits for them all
> to complete.  Then it executes an ending memory barrier.
> 
> These barriers are ordered as described.  Therefore we have
> 
> 	mb0s < mb05 < mb0e,
> 	mb1s < mb14 < mb1e,  and
> 	mb2s < mb23 < mb2e,
> 
> where mb0s is the starting barrier of the sys_memb call on P0, mb05 is
> the barrier that it injects into P5, mb0e is the ending barrier of the
> call, and similarly for the other sys_memb calls.  The '<' signs mean
> that the thing on their left finishes before the thing on their right
> does.
> 
> Rewriting the litmus test in these terms gives:
> 
>         P0      P1      P2      P3      P4      P5
>         Wa=2    Wb=2    Wc=2    [mb23]  [mb14]  [mb05]
>         mb0s    mb1s    mb2s    Wd=2    We=2    Wf=2
>         mb0e    mb1e    mb2e    Re=0    Rf=0    Ra=0
>         Rb=0    Rc=0    Rd=0
> 
> Here the brackets in "[mb23]", "[mb14]", and "[mb05]" mean that the
> positions of these barriers in their respective threads' program
> orderings is undetermined; they need not come at the top as shown.
> 
> (Also, in case David is unfamiliar with it, the "Wa=2" notation is
> shorthand for "Write 2 to a" and "Rb=0" is short for "Read 0 from b".)
> 
> Finally, here are a few facts which may be well known and obvious, but
> I'll state them anyway:
> 
> 	A CPU cannot reorder instructions across a memory barrier.
> 	If x is po-after a barrier then x executes after the barrier
> 	is finished.
> 
> 	If a store is po-before a barrier then the store propagates
> 	to every CPU before the barrier finishes.
> 
> 	If a store propagates to some CPU before a load on that CPU
> 	reads from the same location, then the load will obtain the
> 	value from that store or a co-later store.  This implies that
> 	if a load obtains a value co-earlier than some store then the
> 	load must have executed before the store propagated to the
> 	load's CPU.
> 
> The proof consists of three main stages, each requiring three steps.
> Using the facts that b - f are all read as 0, I'll show that P1
> executes Rc before P3 executes Re, then that P0 executes Rb before P4
> executes Rf, and lastly that P5's Ra must obtain 2, not 0.  This will
> demonstrate that the litmus test is not allowed.
> 
> 1.	Suppose that mb23 ends up coming po-later than Wd in P3.
> 	Then we would have:
> 
> 		Wd propagates to P2 < mb23 < mb2e < Rd,
> 
> 	and so Rd would obtain 2, not 0.  Hence mb23 must come
> 	po-before Wd (as shown in the listing):  mb23 < Wd.
> 
> 2.	Since mb23 therefore occurs po-before Re and instructions
> 	cannot be reordered across barriers,  mb23 < Re.
> 
> 3.	Since Rc obtains 0, we must have:
> 
> 		Rc < Wc propagates to P1 < mb2s < mb23 < Re.
> 
> 	Thus Rc < Re.
> 
> 4.	Suppose that mb14 ends up coming po-later than We in P4.
> 	Then we would have:
> 
> 		We propagates to P3 < mb14 < mb1e < Rc < Re,
> 
> 	and so Re would obtain 2, not 0.  Hence mb14 must come
> 	po-before We (as shown in the listing):  mb14 < We.
> 
> 5.	Since mb14 therefore occurs po-before Rf and instructions
> 	cannot be reordered across barriers,  mb14 < Rf.
> 
> 6.	Since Rb obtains 0, we must have:
> 
> 		Rb < Wb propagates to P0 < mb1s < mb14 < Rf.
> 
> 	Thus Rb < Rf.
> 
> 7.	Suppose that mb05 ends up coming po-later than Wf in P5.
> 	Then we would have:
> 
> 		Wf propagates to P4 < mb05 < mb0e < Rb < Rf,
> 
> 	and so Rf would obtain 2, not 0.  Hence mb05 must come
> 	po-before Wf (as shown in the listing):  mb05 < Wf.
> 
> 8.	Since mb05 therefore occurs po-before Ra and instructions
> 	cannot be reordered across barriers,  mb05 < Ra.
> 
> 9.	Now we have:
> 
> 		Wa propagates to P5 < mb0s < mb05 < Ra,
> 
> 	and so Ra must obtain 2, not 0.  QED.

Like this, then, with maximal reordering of P3-P5's reads?

         P0      P1      P2      P3      P4      P5
         Wa=2
         mb0s
                                                 [mb05]
         mb0e                                    Ra=0
         Rb=0    Wb=2
                 mb1s
                                         [mb14]
                 mb1e                    Rf=0
                 Rc=0    Wc=2                    Wf=2
                         mb2s
                                 [mb23]
                         mb2e    Re=0
                         Rd=0            We=2
                                 Wd=2

But don't the sys_membarrier() calls affect everyone, especially given
the shared-variable communication?  If so, why wouldn't this more strict
variant hold?

         P0      P1      P2      P3      P4      P5
         Wa=2
         mb0s
                                 [mb05]  [mb05]  [mb05]
         mb0e
         Rb=0    Wb=2
                 mb1s
                                 [mb14]  [mb14]  [mb14]
                 mb1e
                 Rc=0    Wc=2
                         mb2s
                                 [mb23]  [mb23]  [mb23]
                         mb2e    Re=0    Rf=0    Ra=0
                         Rd=0            We=2    Wf=2
                                 Wd=2

In which case, wouldn't this cycle be forbidden even if it had only one
sys_membarrier() call?

Ah, but the IPIs are not necessarily synchronized across the CPUs,
so that the following could happen:

         P0      P1      P2      P3      P4      P5
         Wa=2
         mb0s
                                 [mb05]  [mb05]  [mb05]
         mb0e                                    Ra=0
         Rb=0    Wb=2
                 mb1s
                                 [mb14]  [mb14]
                                         Rf=0
                                                 Wf=2
                                                 [mb14]
                 mb1e
                 Rc=0    Wc=2
                         mb2s
                                 [mb23]
                                 Re=0
                                         We=2
                                         [mb23]  [mb23]
                         mb2e
                         Rd=0
                                 Wd=2

I guess in light of this post in 2001, I really don't have an excuse,
do I?  ;-)

	https://lists.gt.net/linux/kernel/223555

Or am I still missing something here?

							Thanx, Paul


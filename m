Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id VzvCBD/8GFtoDgAAmS7hNA
	; Thu, 07 Jun 2018 09:41:36 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id A5A52607F7; Thu,  7 Jun 2018 09:41:36 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 13A29601C3;
	Thu,  7 Jun 2018 09:41:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 13A29601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753571AbeFGJle (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 05:41:34 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42368 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753075AbeFGJlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 05:41:31 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w579cwUa107463
        for <linux-kernel@vger.kernel.org>; Thu, 7 Jun 2018 05:41:31 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jf1wv14j3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 05:41:31 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 7 Jun 2018 05:41:29 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 7 Jun 2018 05:41:25 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w579fOwq1507672
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 7 Jun 2018 09:41:24 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4D2B1B2074;
        Thu,  7 Jun 2018 06:42:55 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 179F7B206B;
        Thu,  7 Jun 2018 06:42:55 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.189.65])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  7 Jun 2018 06:42:55 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 28A7816C2402; Thu,  7 Jun 2018 02:43:14 -0700 (PDT)
Date: Thu, 7 Jun 2018 02:43:14 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Roman Pen <roman.penyaev@profitbricks.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        andrea.parri@amarulasolutions.com,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nick Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: LKMM litmus test for Roman Penyaev's rcu-rr
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180530183826.GI7063@linux.vnet.ibm.com>
 <Pine.LNX.4.44L0.1805301449350.1502-100000@iolanthe.rowland.org>
 <CAJrWOzBMB-6e1pKms4L216k=TN_Lr52_gWxj-ny8yitgf+K5gg@mail.gmail.com>
 <20180606190710.GY3593@linux.vnet.ibm.com>
 <CA+55aFwZTAp3wZYGSJR1kPkc=QhPNMdEEPttsM4REcWPPDH9Bw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFwZTAp3wZYGSJR1kPkc=QhPNMdEEPttsM4REcWPPDH9Bw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18060709-0064-0000-0000-000003179322
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009139; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000265; SDB=6.01043027; UDB=6.00534142; IPR=6.00822157;
 MB=3.00021491; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-07 09:41:29
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18060709-0065-0000-0000-000039830D2D
Message-Id: <20180607094314.GF3593@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-07_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806070115
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 06, 2018 at 12:23:33PM -0700, Linus Torvalds wrote:
> On Wed, Jun 6, 2018 at 12:05 PM Paul E. McKenney
> <paulmck@linux.vnet.ibm.com> wrote:
> >
> > 3.      Introduce a new marking/attribute in the .def file that indicates
> >         whether an access is volatile or implies a compiler barrier.
> >         This might allow herd to be more selective about control dependencies,
> >         for example, extending them past the end of "if" statements
> >         containing compiler barriers.
> >
> >         One tricky aspect of this approach is working out what the
> >         compiler can do to the "if" statement.  We definitely do not
> >         want to put the complexity of all possible compilers into herd!
> 
> This _smells_ like the right thing to do.
> 
> Aren't the litmus-tests effectively always going to be using READ_ONCE
> etc volatile accesses anyway?

Yes, right now LKMM handles only volatile (READ_ONCE and WRITE_ONCE)
or stronger.

> Most of what the LKMM litmus tests test for is things with side effects, no?
> 
> And honestly, that is exactly the kind of litmus test behavior we
> *want* our memory model to have, in that any CPU designer (or compiler
> designer) that uses our LKMM litmus tests should very much be aware of
> the fact that we expect a conditional->store memory ordering to be a
> ordering.
> 
> We have real code that depends on it, so I think LKMM should expose
> those ordering requirements.

Good point.  And I did manage to advocate for control dependencies at an
academic conference earlier this week without the need for a bodyguard,
so perhaps things are improving.  ;-)

> I'm also perfectly happy with no markings at all: all memory accesses
> are "voiatile" as fat as C is concerned, and cannot be moved around by
> the compiler at all - and all that LKMM tests is memory _ordering_,
> not "compiler can do X".

We are considering adding unmarked accesses, for example, accesses
protected by locks.  One possible litmus test (not yet supported!)
might look like this:

	C Z6.0+pooncelock+pooncelock+pombonce

	{}

	P0(int *x, int *y, spinlock_t *mylock)
	{
		spin_lock(mylock);
		WRITE_ONCE(*x, 1);
		y = 1;
		spin_unlock(mylock);
	}

	P1(int *y, int *z, spinlock_t *mylock)
	{
		int r0;

		spin_lock(mylock);
		r0 = y;
		WRITE_ONCE(*z, 1);
		spin_unlock(mylock);
	}

	P2(int *x, int *z)
	{
		int r1;

		WRITE_ONCE(*z, 2);
		smp_mb();
		r1 = READ_ONCE(x);
	}

	exists (1:r0=1 /\ z=2 /\ 2:r1=0)

Because y is only ever accessed under a lock, the compiler cannot do
anything to mess it up.  In this particular case, the compiler would
have a hard time messing up the other accesses, aside from extremely
unfriendly measures such as load/store tearing, but we have seen
Linux-kernel examples where the compiler could very reasonably repeat
and fuse loads and stores and so on.

Thoughts?

> Because I think your option 1. is absolutely against everything we
> want to happen:
> 
> > 1.      Status quo.  This works reasonably well, but we have already
> >         seen that your scenario makes it ask for more synchronization
> >         than necessary.
> 
> We absolutely do *not* want CPU designers etc thinking that we'll add
> insane synchronization.
> 
> We were already burned by insane bad CPU design once in the form of
> the garbage that alpha desigers gave us.
> 
> I am personally not at all interested in seeing our memory ordering
> rules be "nice". They should be as tight as possible, and *not* allow
> any crazy shit that some insane person can come up with. No more
> "dependent reads out of ordetr" garbage, and no more "store done
> before the condition it depends on" garbage.
> 
> A CPU designer (or a C++ memory ordering person) who tries to sneak
> shit like that past us should be shunned, and not taken seriously.

Given that I am writing this in a C++ Standards Committee meeting,
I do like the call for sanity.

> And our memory ordering rules should be very explicit about it, so
> that people don't even _try_ to do insane things.
> 
> I want any memory ordering litmus tests to say "we depend on this, so
> as a CPU designer don't mess it up, because then we won't run on the
> resulting crap".
> 
> I'm not in the least interested in the LKMM litmus tests being an
> excuse for unnecessarily weak memory ordering. That's the *opposite*
> of what I would want any litmus tests to do.
> 
> If people are looking to use them that way, then I'm going to remove
> them, because such litmus tests are not in the best interest of the
> kernel.
> 
> Future CPU designs need to be *saner*, not perpetuate the kind of
> garbage insanity we have seen so far.

OK, I think we all agree that we need to move away from status quo.
The workaround buys us some time, but the need to move is undisputed.
(If someone does dispute it, this would be a great time for them to make
their concerns known!)

I will take a hard look at option #3, and see if there any hidden gotchas.

							Thanx, Paul

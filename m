Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-811159-1527950587-2-5499475932907125230
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527950587; b=Y34mVv5qiSm0ZWXwgcQ07KL+CSQ/tcdc4lZy4rG7fJOlMXuNhx
    ANt3m+6KWVLb4UxpReWUmgbHantIj8lchzeS+75R2dUcdMY9d/+prtI8PEs0ccFA
    q+n+JVEpNeNK4mlpu7HaBIaOxRQmxFeXhPl1pO9QsCrae4V5gVeZo3ZTtqX8uhj6
    Bu0lG8bBCkm2AiBwGpNqbBwXeDiXFQcIm5gMfVSyTwNSUuDkRRIfO9ve8Zl7EdEu
    aVcemdS6IcVD/ASioa42lfBymNEzCBveLilAGGUmuhE2qBql7ll37M2pdGcgq4Dz
    Q6W8Z0DJULjo34bxhmTAp0H1X9GzQCzGfAgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:reply-to
    :references:mime-version:content-type:in-reply-to:message-id
    :sender:list-id; s=fm2; t=1527950587; bh=IJXMuCgyg5KZvhmmSqC7ZYE
    jzdfNAqeaIyANDTMG7QI=; b=DTOQaiKZlgGkZc35ty8QNKvoFec2pen1SXHvc8+
    yXWXSvkKjnRFjueNAQPv+ohJcchnqdBf4ieShzrtMGHEqX/0OF7TwkrxU7J/AAA9
    RGaySDuxAHAFcVkHw3icOIPsmIk8gUlxC3qSfoEy7r20H2N5eRtaVaiEOnuh2HAA
    1XVPOwZOWh6yUqzgjbzkUvLVZqMotcG/f1wJjCir/OzpDqpTJjc2LbBaoUzIVs6A
    LjIZ/mqBQG0hsYYHLUK5TWQJvFHD6NfAJYN6ZvqagXjMRB5olULQdilBTVrPmGLE
    NrNGj6/n2iqCXlSUsQX88aGafibL0B7oixZnWCG86JvV3WQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none)
    header.from=linux.vnet.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linux.vnet.ibm.com header.result=pass
    header_org.domain=ibm.com header_org.result=pass
    header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none)
      header.from=linux.vnet.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linux.vnet.ibm.com header.result=pass
      header_org.domain=ibm.com header_org.result=pass
      header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKvu2a+lomYMvd9KOaDoend71PqfV2K0sd743l+3eJP07ofVw8/BOwx8zk3AXXUcY8ZojRQAsQrEY+/NhPiKfyCjQ6MhygF4QVwk6PrIUlPJYQQraF1+
    Y+M7Kaf6oMaYiCStUaUN7QDJ8bq4ify1hxkYEcn65BGdcNfIZGhAxk/6vqFD0L59yFO0sAhtkVN8YYFqFSb3LQWqgkYn6MqfkTqqeRMAlOUAEIVCcmBUZQ56
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=7mUfYlMuFuIA:10
    a=RYmspbwmoq8_d6KlZ84A:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751342AbeFBOnD (ORCPT <rfc822;linux@kroah.com>);
        Sat, 2 Jun 2018 10:43:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58102 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751194AbeFBOnB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 2 Jun 2018 10:43:01 -0400
Date: Sat, 2 Jun 2018 07:44:40 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
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
        Ingo Molnar <mingo@kernel.org>,
        Roman Pen <roman.penyaev@profitbricks.com>
Subject: Re: LKMM litmus test for Roman Penyaev's rcu-rr
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180530231441.GO7063@linux.vnet.ibm.com>
 <Pine.LNX.4.44L0.1805311008460.1607-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1805311008460.1607-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18060214-0060-0000-0000-000002765FCB
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009115; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000265; SDB=6.01041257; UDB=6.00533081; IPR=6.00820386;
 MB=3.00021427; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-02 14:42:58
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18060214-0061-0000-0000-000045507660
Message-Id: <20180602144440.GI3593@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-02_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806020174
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 31, 2018 at 10:27:33AM -0400, Alan Stern wrote:
> On Wed, 30 May 2018, Paul E. McKenney wrote:
> 
> > On Wed, May 30, 2018 at 05:01:01PM -0500, Linus Torvalds wrote:
> > > On Wed, May 30, 2018 at 2:08 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> > > >
> > > > Indeed.  The very first line Linus quoted in his first reply to me
> > > > (elided above) was:
> > > >
> > > >         Putting this into herd would be extremely difficult, if not impossible,
> > > >         because it involves analyzing code that was not executed.
> > > >
> > > > It should be clear from this that I was talking about herd.  Not gcc or
> > > > real hardware.
> > > 
> > > So what does herd actually work on? The source code or the executable,
> > > or a trace?
> > 
> > The source code, that is, the source code of the litmus test.
> > There are definitions for the various Linux operations, partly within
> > the herd tool and partly in the linux.def file in tools/memory-model.
> > The problem we are having is nailing down control dependencies and
> > compiler optimizations.  The bit about limiting control dependencies
> > through the end of "if" statement itself works well in a great many cases,
> > but this clearly is not one of them.
> > 
> > > I found the herd paper, but I'm on the road helping my daughter in
> > > college move, and I don't have the background to skim the paper
> > > quickly and come up with the obvious answer, so I'l just ask.
> > 
> > It is not a short learning curve.
> > 
> > > Because I really think that from our memory model standpoint, we
> > > really do have the rule that
> > > 
> > >    load -> cond -> store
> > > 
> > > is ordered - even if the store address and store data is in no way
> > > dependent on the load. The only thing that matters is that there's a
> > > conditional that is dependent on the load in between the load and the
> > > store.
> 
> This is true for all the architectures supported by the Linux kernel.  
> However, in the future it might not always hold.  I can imagine that
> CPU designers would want to include an optimization that checks a
> conditional branch to see if it skips over only the following
> instruction (and the following instruction can't affect the flow of
> control); in that situation, they might decide there doesn't need to be
> a control dependency to future stores.  Such an optimization would not
> violate the C11 memory model.
> 
> Of course, this is purely theoretical.  And if anybody does decide to
> try doing that, the memory-model people might scream at them so hard
> they change their minds.  :-)
> 
> ...
> 
> > > But I don't know what level 'herd' works on. If it doesn't see
> > > compiler barriers (eg our own "barrier()" macro that literally is just
> > > that), only sees the generated code, then it really has no other
> > > information than what he compiler _happened_ to do - it doesn't know
> > > if the compiler did the store after the conditional because it *had*
> > > to do so, or whether it was just a random instruction scheduling
> > > decision.
> > 
> > The 'herd' tool works on litmus-test source, and has almost no idea of
> > what compilers get up to.  In this particular case, it would be better
> > off being even more ignorant of what compilers get up to.  ;-)
> 
> In more detail, herd analyzes the source code and constructs a set of
> all possible candidate executions.  herd then checks each execution to
> see if it violates the rules of the memory model as expressed in the
> .bell and .cat files.  If any of the non-violating executions satisfies
> the litmus test's final "exists" condition, herd reports that the test
> is allowed.
> 
> The point here is that when herd checks any one particular execution, 
> it pays attention _only_ to the statements which are part of that 
> execution.  Statements belonging to an untaken "if" branch are ignored 
> completely.  That's why I think it would be difficult to make herd do 
> exactly what we want in this case.

One crude but effective workaround is to replicate the code following the
"if" statement into both legs of the "if" statement.  This has the effect
of extending the control dependency to cover all of the code that used to
follow the "if" statement, leveraging herd's current limited knowledge of
compiler optimization.  This workaround would of course be hopeless for
general Linux-kernel code, but should be at least semi-acceptable for the
very small snippets of code that can be accommodated within litmus tests.

Please see the litmus test shown below, which uses this workaround,
allowing the smp_store_release() to be downgraded to WRITE_ONCE().

Given this workaround, crude though it might be, I believe that we can
take a more measured approach to identifying a longer-term solution.

Thoughts?

							Thanx, Paul
					
			
	
------------------------------------------------------------------------

C C-RomanPenyaev-list-rcu-rr-WA

(*
 * The same as C-RomanPenyaev-list-rcu-rr.litmus, but working around herd's
 * having just the wrong level of understanding of compiler optimizations
 * for that particular litmus test.  The trick is to replicate the code
 * following the "if" statement into both legs of that "if" statement.
 *)

{
	int *z=1; (* List: v->w->x->y->z. Noncircular, but long enough. *)
	int *y=z;
	int *x=y;
	int *w=x;
	int *v=w; (* List head is v. *)
	int *c=w; (* Cache, emulating ppcpu_con. *)
}

P0(int *c, int *v, int *w, int *x, int *y)
{
	rcu_assign_pointer(*w, y); /* Remove x from list. */
	synchronize_rcu();
	r1 = READ_ONCE(*c);
	if (r1 == x) {
		WRITE_ONCE(*c, 0); /* Invalidate cache. */
		synchronize_rcu();
		WRITE_ONCE(*x, 0);  /* Emulate kfree(x). */
	} else {
		WRITE_ONCE(*x, 0);  /* Emulate kfree(x). */
	}
}

P1(int *c, int *v)
{
	rcu_read_lock();
	r1 = READ_ONCE(*c); /* Pick up cache. */
	if (r1 == 0) {
		r1 = READ_ONCE(*v); /* Cache empty, start from head. */
	}
	r2 = rcu_dereference(*r1); /* Advance to next element. */
	smp_store_release(c, r2); /* Update cache. */
	rcu_read_unlock();

	/* And repeat. */
	rcu_read_lock();
	r3 = READ_ONCE(*c);
	if (r3 == 0) {
		r3 = READ_ONCE(*v);
	}
	r4 = rcu_dereference(*r3);
	smp_store_release(c, r4);
	rcu_read_unlock();
}

locations [0:r1; 1:r1; 1:r3; c; v; w; x; y]
exists (1:r1=0 \/ 1:r2=0 \/ 1:r3=0 \/ 1:r4=0) (* Better not be freed!!! *)

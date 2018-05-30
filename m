Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-379996-1527721990-2-6710963750403610383
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527721989; b=OSlO7AhcX+05N7xLB6xYijYiOk1QSS1II89z5CoCyBj8jni4Zt
    JHC/gpk04xj7IUDH6wIzrG9sHbNpxF7Fq+595o016O24sXCvS/RYJjDQ8CIL9q8N
    sCr3Qun5tlGOGzJBWCm+Vqw6BCH1PhpprSLvFzPqrUfl9Td+xdngOrt/YZWhYums
    Y5dVA/wo1dYkKaDqgNlVCmcRF/sXIM+RQtd6vyFtnGoAv08ixf6vb7lSak/EACLP
    1+3/OfAoP+VGdKCPE2akqGZ/MYajJuwgEzfNTpS5L+Kf4GLUZ40ASQj0TAdWchfJ
    JiGt2cqfzR/9UoCMMbVa0dgf8U4PbcMGLNGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:reply-to
    :references:mime-version:content-type:in-reply-to:message-id
    :sender:list-id; s=fm2; t=1527721989; bh=tCrMyUcBSTpT335l/3NhnEF
    QVcEV+nOQdSCcTiFpktQ=; b=TDraOp9piRCDQ1G3v0utCpVSBhDv7rekuU624zh
    raUqsueHLpemIFrnL2tY9/7FGJAgxg2G7AvZTXRv8kkGrZ/3gFAOcruZ1qxNLTLK
    4CzzYPunaPR7onzJTfTPdlafTO2bZQYubKDkqVOV/ZcISD6BDvIVUjUHYTUwsSWE
    XT3sf5o6ARH8GZCk6cCGUkIhQ6gWXGRtGFBCXroR10Q1wqLzuMYXhPeaiBmQ0g90
    aYoF6obLMuflwJDfxXI9VJH1QtmtjQ0II0Qr5FTYr8+tRrijqHjCzPNQlccmDVKp
    dmWppxn5zUZaapur+ITJQQSsghXnMpR3y9NIBLjgHPyBczg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfPkbCq6HTF6SEeuLVENPCff3I0YJDOWIKjU9JzhdH9o9ppTT4CojOOAIvY6vcDxl46Gp8U+nX9Fayw9PvFL8R8V1rqrphgSfUNrllgoMyEkyz0F6Qeio
    T7Sd2sfrE7GeiVCPKP/fWe7YEEAfMMbZbpuMri2vPU+os1s7N4Vq8U+0A6S+WEvTamMmNcFQZ6FFUrLsG9ypPMs9hd+CEoI3PCRwtEDDikvCI0+4xw+ZE1HL
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=ZmWs40n30RjOo87KSFoA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932625AbeE3XNF (ORCPT <rfc822;linux@kroah.com>);
        Wed, 30 May 2018 19:13:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43228 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753734AbeE3XNE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 30 May 2018 19:13:04 -0400
Date: Wed, 30 May 2018 16:14:41 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alan Stern <stern@rowland.harvard.edu>,
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
References: <20180530183826.GI7063@linux.vnet.ibm.com>
 <Pine.LNX.4.44L0.1805301449350.1502-100000@iolanthe.rowland.org>
 <CA+55aFxXgECHW+Pekiuvt1htsDfML2ximrLrmr99xewGYpmEng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFxXgECHW+Pekiuvt1htsDfML2ximrLrmr99xewGYpmEng@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18053023-0040-0000-0000-000004371C2E
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009099; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000264; SDB=6.01040030; UDB=6.00530820; IPR=6.00819163;
 MB=3.00021384; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-30 23:13:02
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18053023-0041-0000-0000-0000083D4256
Message-Id: <20180530231441.GO7063@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-30_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1805300242
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 30, 2018 at 05:01:01PM -0500, Linus Torvalds wrote:
> On Wed, May 30, 2018 at 2:08 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > Indeed.  The very first line Linus quoted in his first reply to me
> > (elided above) was:
> >
> >         Putting this into herd would be extremely difficult, if not impossible,
> >         because it involves analyzing code that was not executed.
> >
> > It should be clear from this that I was talking about herd.  Not gcc or
> > real hardware.
> 
> So what does herd actually work on? The source code or the executable,
> or a trace?

The source code, that is, the source code of the litmus test.
There are definitions for the various Linux operations, partly within
the herd tool and partly in the linux.def file in tools/memory-model.
The problem we are having is nailing down control dependencies and
compiler optimizations.  The bit about limiting control dependencies
through the end of "if" statement itself works well in a great many cases,
but this clearly is not one of them.

> I found the herd paper, but I'm on the road helping my daughter in
> college move, and I don't have the background to skim the paper
> quickly and come up with the obvious answer, so I'l just ask.

It is not a short learning curve.

> Because I really think that from our memory model standpoint, we
> really do have the rule that
> 
>    load -> cond -> store
> 
> is ordered - even if the store address and store data is in no way
> dependent on the load. The only thing that matters is that there's a
> conditional that is dependent on the load in between the load and the
> store.
> 
> Note that this is *independent* of how you get to the store. It
> doesn't matter  if it's a fallthrough conditional jump or  a taken
> conditional jump, or whether  there is a joining.
> 
> The only thing that *does* matter is whether the conditional can be
> turned into a "select" statement. If the conditional can be turned
> into a data dependency, then the ordering goes away. That is why it
> was relevant whether "C" contained a barrier or not (it doesn't even
> have to be a *memory* barrier, it just has to be a barrier for code
> generation).

Another situation is something like this:

	r1 = READ_ONCE(x);
	if (r1)
		r2 = r1 * 3 - 1;
	else
		r2 = 42;
	WRITE_ONCE(y, 5);
	do_something(r2);

Because there are no compiler barriers or volatile accesses in either
the "then" clause or the "else" clause, the compiler is within its
rights to do this:

	r1 = READ_ONCE(x);
	WRITE_ONCE(y, 5);
	if (r1)
		r2 = r1 * 3 - 1;
	else
		r2 = 42;
	do_something(r2);

Then weakly ordered CPUs can reorder the READ_ONCE() and WRITE_ONCE().
The compiler of course cannot because they are both volatile accesses.

> Note that the "C doesn't even have to have a memory barrier" is
> important, because the orderin from load->cond->store doesn't actually
> have anything to do with any memory ordering imposed by C, it's much
> more fundamental than that.

If there were volatiles or compiler barriers in the "then" or "else"
clauses, or if the store itself was there (and there weren't identical
stores in both), then agreed, the compiler cannot do much, nor can
the hardware.

> > Preserving the order of volatile accesses isn't sufficient.  The
> > compiler is still allowed to translate
> >
> >         r1 = READ_ONCE(x);
> >         if (r1) {
> >                 ...
> >         }
> >         WRITE_ONCE(y, r2);
> >
> > into something resembling
> >
> >         r1 = READ_ONCE(x);
> >         WRITE_ONCE(y, r2);
> >         if (r1) {
> >                 ...
> >         }
> 
> Correct.
> 
> What matter is that the code in C (now called "..." above ;^) has a
> build-time barrier that means that the compiler cannot do that.
> 
> That barrier can be pretty much anything. The important part is
> literally that there's a guarantee that the write cannot  be migrated
> below the conditional.
> 
> But I don't know what level 'herd' works on. If it doesn't see
> compiler barriers (eg our own "barrier()" macro that literally is just
> that), only sees the generated code, then it really has no other
> information than what he compiler _happened_ to do - it doesn't know
> if the compiler did the store after the conditional because it *had*
> to do so, or whether it was just a random instruction scheduling
> decision.

The 'herd' tool works on litmus-test source, and has almost no idea of
what compilers get up to.  In this particular case, it would be better
off being even more ignorant of what compilers get up to.  ;-)

							Thanx, Paul

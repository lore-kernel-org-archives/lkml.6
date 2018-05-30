Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-75673-1527705414-2-2513668180395977861
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527705414; b=EzaK5q+NzZADT9LObMS1kxB2dKqaTtS0FCm87iroCOkdNQF+xQ
    MvKYhmqpACbmnor1FlpxZIHHNVAUuCwCcJxRYAwaoxzT5Bel9arQgT9vT9TtO2MR
    LBQ1A3In36TXbD57A95Ev41S4j71/dlNsQVSvF5QIy1XeEQtzzWX0TsPro8eLmiN
    wqhh4WjFmN2SHyj+gJ9iu96RmILU52HT+YuWhKaA1Kpp4NV15KhL/+M6ZjmmZf2v
    6IzuSiP8/TFPLRmLUY52vW3vv0p1GpSPoH2taLCInqvkMFsVxALO+DEVq1lXFAYI
    pROjMsQpvFIbOm1j29wnz1A3Y1E3UjnGrXfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:reply-to
    :references:mime-version:content-type:in-reply-to:message-id
    :sender:list-id; s=fm2; t=1527705414; bh=ukbKA/oLEYEUhoUyAF8Q7k/
    SlAIFUSXPh8JP9CDcZyU=; b=MKzrJT40hA9E0VVpuBwl8Bsie2EHhRQ0J62L0Lj
    VwMcTNIlAF/kOlcZw1h8I8UWABsdHjen/hR12YW87Gdz//Um6EhFU+WiFnPiO9xA
    3AULmEdHLEI2GIzqh+igDDl6AqHDtn92p7kYCmYk+w0mhjceTtbvNsP2CXkJYSxL
    SliCnr2KvYTkKG2j57lX1hsRcoYbUqAnxFipMwFbsX+dRYjB7Ezl32JICUpaWBcD
    LDheBtm5hjUqDjG6kMJOY2ApMcDjH5eEs50isZqNxD/0QNyVvUzx1wexdt8Yka4v
    xNi+1aEAd7xIzg3OViWFhK17u8LkQy79n4f1w7HdZULwkjA==
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
X-CM-Envelope: MS4wfLzQ6nfqpD2xMsrsHFfUpW+mawfwc73fHJ+6KyboVyDWwPbvCWPMc0/Hmx9yYenog42I27n0UhLEl2fGwnlT3fwQ62BctwbuHTcKMa5eGKXZyrEwSx6K
    xza5eDNlrTt5UPTMCLNdiSzP/DMEFF1GzYRcAY9atKW9b1vysrz783lwxZlf47yecmVDOBrdrve529hXY/Um8MeUKXwJmoujDir7/AAoa/7jsCbaZ33UWiBt
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=JBBDX4nLzeJZZAHxPoQA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753556AbeE3Sgv (ORCPT <rfc822;linux@kroah.com>);
        Wed, 30 May 2018 14:36:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33912 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750752AbeE3Sgu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 30 May 2018 14:36:50 -0400
Date: Wed, 30 May 2018 11:38:26 -0700
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
References: <CA+55aFzYca7EBTEbhJMoJcGspVGhmty243WQR_w7Eykmw9HX9w@mail.gmail.com>
 <Pine.LNX.4.44L0.1805301009340.1502-100000@iolanthe.rowland.org>
 <CA+55aFy2SqVr3XggBS6_N+EUZMABa0xwpme5BW4qmLQ1h6J3pQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFy2SqVr3XggBS6_N+EUZMABa0xwpme5BW4qmLQ1h6J3pQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18053018-2213-0000-0000-000002B041A5
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009099; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000264; SDB=6.01039938; UDB=6.00532201; IPR=6.00819071;
 MB=3.00021380; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-30 18:36:47
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18053018-2214-0000-0000-00005A4D29B1
Message-Id: <20180530183826.GI7063@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-30_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1805300197
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 30, 2018 at 09:59:28AM -0500, Linus Torvalds wrote:
> On Wed, May 30, 2018 at 9:29 AM Alan Stern <stern@rowland.harvard.edu>
> wrote:
> 
> > >
> > > Can't we simplify the whole sequence as basically
> > >
> > >      A
> > >      if (!B)
> > >          D
> > >
> > > for that "not B" case, and just think about that. IOW, let's ignore the
> > > whole "not executed" code.
> 
> > Your listing is slightly misleading.
> 
> No. You're confused.
> 
> You're confused because you're conflating two *entirely* different things.
> 
> You're conflating the static source code with the dynamic execution. They
> are NOT THE SAME.

I am going to go out on a limb and assert that Linus is talking about
what gcc and hardware do, while Alan is talking about what the tool and
memory model do.  In a perfect world, these would be the same, but it
appears that the world might not be perfect just now.

My current guess is that we need to change the memory-model tool.  If
that is the case, here are some possible resolutions:

1.	Make herd's C-language control dependencies work the same as its
	assembly language, so that they extend beyond the end of the
	"if" statement.  I believe that this would make Roman's case
	work, but it could claim that other situations are safe that
	are actually problematic due to compiler optimizations.

	The fact that the model currently handles only READ_ONCE()
	and WRITE_ONCE() and not unmarked reads and writes make this
	option more attractive than it otherwise be, compilers not
	being allowed to reorder volatile accesses, but we are likely
	to introduce unmarked accesses sometime in the future.

2.	Like #1 above, but only if something in one of the "if"'s
	branches would prevent the compiler from reordering
	(smp_mb(), synchronize_rcu(), value-returning non-relaxed
	RMW atomic, ...).  Easy for me to say, but I am guessing
	that much violence would be needed to the tooling to make
	this work.  ;-)

If I understand Alan correctly, there is not an obvious way to make
this change within the confines of the memory model's .bell and .cat
files.

						Thanx, Paul

>    It really should be:
> 
> >          A
> >          if (!B)
> >                  ; // NOP
> >          D
> 
> No it really really shouldn't.
> 
> There are two completely different situations:
> 
> (1) there is the source code:
> 
>      A
>      if (B)
>           C
>      D
> 
> where  C contains a barrier, and B depends on A and is not statically
> determinable.
> 
> In the source code, 'D' looks unconditional BUT IT DAMN WELL IS NOT.
> 
> It's not unconditional - it's just done in both conditions! That's a big
> big difference.
> 
> > In other words, D should be beyond the end of the "if" statement, not
> > inside one of the branches.
> 
> You're just completely confused.
> 
> What you are stating makes no sense at all.
> 
> Seriously, your reading of the code is entirely monsenscal, and seems to be
> about syntax, not about semantics. Which is crazy.
> 
> Lookie here, you can change the syntactic model of that code to just be
> 
>      A
>      if (B)
>          C
>          D
>      else
>          D
> 
> and that code obviously has the EXACT SAME SEMANTICS.
> 
> So if you get hung up on trivial syntactic issues, you are by definition
> confused, and your tool is garbage. You're doing memory ordering analysis,
> not syntax parsing, for chrissake!
> 
> >   At run time, of course, it doesn't matter;
> > CPUs don't try to detect where the two branches of an "if" recombine.
> > (Leaving aside issues like implementing an "if" as a move-conditional.)
> 
> You cannot do it as a move-conditional, since that code generation would
> have been buggy shit, exactly because of C. But that's a code generation
> issue, not a run-time decision.
> 
> So at run-time, the code ends up being
> 
>      A
>      if (!B)
>          D
> 
> and D cannot be written before A has been read, because B depends on A, and
> you cannot expose specutive writes before the preconditions have been
> evaluated.
> 
> > Remember, the original code was:
> 
> >          A
> >          if (!B)
> >                  C
> >          D
> 
> > So the execution of D is _not_ conditional, and it doesn't depend on A
> > or B.  (Again, CPUs don't make this distinction, but compilers do.)
> 
> Again, the above is nothing but confused bullshit.
> 
> D depends on B, which depends on A.
> 
> Really. Really really.
> 
> Anybody - or any tool - that doesn't see that is fundamentally wrong, and
> has been confused by syntax.
> 
> A *compiler* will very much also make that distinction. If it doesn't make
> that distinction, it's not a compiler, it's a buggy piece of shit.
> 
> Because semantics matter.
> 
> Think about it.
> 
>                   Linus
> 

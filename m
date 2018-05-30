Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-136696-1527707327-2-2158636106709168845
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: 
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527707327; b=LyPiR/9/OTMu+fMqtBWzlrl9CwrhrXWVW52zJQzzSywCnw+cca
    /eyc1GkKTxhb929DPKwIn6YObDzJBFzax08jUps4AbJFn+waSuotwJ2w8842xi/b
    UMdGTyVmlT/E4QRisiQjre7n6a/C6Rbw2fg0aMvB2yE6N3xWqzIvH/8Ui9Wg1/oK
    ekOk7ErWfM2bP6UaypzqXrJOjP+TSXwekirW7kRyri7+4GD0HE1AtY2k/BPYNmvh
    MJIPreeBr76Lk5cLnw0EOOOprJN12cDz8+2OgJY6i6mPAgeqvMQvlV9ubpPm8JCN
    BhS1L54B3uVA3iP1PdVehuaqr/DztmMpSw4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:in-reply-to
    :message-id:mime-version:content-type:sender:list-id; s=fm2; t=
    1527707327; bh=y0kRBntxbBlE4TWDnnmoeDZfp4XYeL9WlLpTbA+vBWI=; b=h
    4drNqjaR/gNoxbII7Ofkn9pdokFXmqeUb4gFrZlTJl9Yir0QpL4lSIHdG82NAPUT
    OnYJ5bMZOSWAiPDP3SFEC9jWF6qCWfWtoOeSkyDf9Bsh9htUXYXQKWjoaLcuid0e
    iMEzexM659TzW3KeMTeXQYLHBSBD6iVC+Zwt9WSiWeJ+EiHV6+TqPgWz0NDKouJD
    HeHHwgZBGEHn4hovuKYXkIdFcJO4lh52LylCbghxJn5Dzcg4m0v1gcAGn+sqRjVU
    TmbxEcYz80JjjqvcyfXwSP3oTS+FBTEM2mOmgKyWobOMGqNRyfYujyB9iHTV5hVP
    yNUG0SSrcK6no+mguYZhg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=rowland.harvard.edu;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=rowland.harvard.edu header.result=pass
    header_org.domain=harvard.edu header_org.result=pass
    header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=rowland.harvard.edu;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=rowland.harvard.edu header.result=pass
      header_org.domain=harvard.edu header_org.result=pass
      header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHw4qq2qJSsnvkWh+vA2VjfsaHMbDY1tLY9xDM8kltR8Nw0t7vzm2FtpRfA5a2fjhfmuxosyfF788oOU+PUs9JqiW/wd7iQY4LYoCPAT1YFwo9IcRuuL
    J4lcGlvPFCwLkL8ZMzuIzZ0EgWID9bZG98aNJmmcpiCuqUWUodgp0704zEQQmNoSarmMAQr/yW4HkSbH+nVmCkKfGCyGi53shbGAfbHvfO5LMImbEhim0B3R
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=8yLmP2qYcVxg-_p5-RkA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932111AbeE3TIo (ORCPT <rfc822;linux@kroah.com>);
        Wed, 30 May 2018 15:08:44 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:37246 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S932112AbeE3TIo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 30 May 2018 15:08:44 -0400
Date: Wed, 30 May 2018 15:08:43 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        <andrea.parri@amarulasolutions.com>,
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
In-Reply-To: <20180530183826.GI7063@linux.vnet.ibm.com>
Message-ID: <Pine.LNX.4.44L0.1805301449350.1502-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 30 May 2018, Paul E. McKenney wrote:

> On Wed, May 30, 2018 at 09:59:28AM -0500, Linus Torvalds wrote:
> > On Wed, May 30, 2018 at 9:29 AM Alan Stern <stern@rowland.harvard.edu>
> > wrote:
> > 
> > > >
> > > > Can't we simplify the whole sequence as basically
> > > >
> > > >      A
> > > >      if (!B)
> > > >          D
> > > >
> > > > for that "not B" case, and just think about that. IOW, let's ignore the
> > > > whole "not executed" code.
> > 
> > > Your listing is slightly misleading.
> > 
> > No. You're confused.
> > 
> > You're confused because you're conflating two *entirely* different things.
> > 
> > You're conflating the static source code with the dynamic execution. They
> > are NOT THE SAME.
> 
> I am going to go out on a limb and assert that Linus is talking about
> what gcc and hardware do, while Alan is talking about what the tool and
> memory model do.

Indeed.  The very first line Linus quoted in his first reply to me
(elided above) was:

	Putting this into herd would be extremely difficult, if not impossible,
	because it involves analyzing code that was not executed.

It should be clear from this that I was talking about herd.  Not gcc or
real hardware.

(After rereading his message a few times, I'm not sure exactly what 
Linus was talking about...)

>  In a perfect world, these would be the same, but it
> appears that the world might not be perfect just now.
> 
> My current guess is that we need to change the memory-model tool.  If
> that is the case, here are some possible resolutions:
> 
> 1.	Make herd's C-language control dependencies work the same as its
> 	assembly language, so that they extend beyond the end of the
> 	"if" statement.  I believe that this would make Roman's case
> 	work, but it could claim that other situations are safe that
> 	are actually problematic due to compiler optimizations.
> 
> 	The fact that the model currently handles only READ_ONCE()
> 	and WRITE_ONCE() and not unmarked reads and writes make this
> 	option more attractive than it otherwise be, compilers not
> 	being allowed to reorder volatile accesses, but we are likely
> 	to introduce unmarked accesses sometime in the future.

Preserving the order of volatile accesses isn't sufficient.  The
compiler is still allowed to translate

	r1 = READ_ONCE(x);
	if (r1) {
		...
	}
	WRITE_ONCE(y, r2);

into something resembling

	r1 = READ_ONCE(x);
	WRITE_ONCE(y, r2);
	if (r1) {
		...
	}

(provided the "..." part doesn't contain any volatile accesses,
barriers, or anything affecting r2), which would destroy any run-time
control dependency.  The CPU could then execute the write before the
read.

> 2.	Like #1 above, but only if something in one of the "if"'s
> 	branches would prevent the compiler from reordering
> 	(smp_mb(), synchronize_rcu(), value-returning non-relaxed
> 	RMW atomic, ...).  Easy for me to say, but I am guessing
> 	that much violence would be needed to the tooling to make
> 	this work.  ;-)

This would be my preference.  But I'm afraid it isn't practical at the 
moment.

> If I understand Alan correctly, there is not an obvious way to make
> this change within the confines of the memory model's .bell and .cat
> files.

No way at all.  It would require significant changes to herd's internal 
workings and its external interface -- my original point.

Alan

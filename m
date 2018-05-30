Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-247915-1527712139-2-12603397202803680548
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: 
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527712139; b=Vt3nm1myYPMRSSOuz3nZp389iyWbbYCdDKrnIY8Zf+SpDIvxFZ
    GSsa8sC29Sbly41hU5gTFmsfUD0gL7LdNxrWJ7yEVdFjZ0y8DFAZE7wwlXDRIOW1
    t3AjRlTO+dx46S33sraKthhnlwB/gyMePFxILdTfmxsOFu8lZQup7kaJd9wSOLhg
    6qXT/Ljmgcobv8dL/pRFs/UmGLLYIAavfV12Ne20pLpt/6JEho+aQLqEaGDGRW5L
    +ilsKGm+nQRpIpATqAwvL4N0r37gyMJs6YbJRupbSZ8q/j3GNqFa3G0TJ5xHcnXC
    0qB54XhxUFzUa0SwpU8LTUVl1nxqN7Cn2lnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:in-reply-to
    :message-id:mime-version:content-type:sender:list-id; s=fm2; t=
    1527712139; bh=MxcE4INeTZaJy2HUG96LjClTDlzVAmLdSjOIfvHuCq8=; b=f
    4+hkXnllJjBS8g6ojzXGonP9ID3seP+2d6Sk+Na0ZXhLJxdlXDhInhNb+1NMt0HC
    iMOkG2b8sieBnJoK5jcQnmVMWgdzMSBWIrimYPm6uniTJXMG0A6Y4d0YlAX9xsx1
    hLCM5Fu7wMSrPaSIDY6+JNk1lKQEmOL/gqXNtgfCNCyF8sjLW/NEfxYEQe1WcGP0
    xq05KuBaamnULfa5/EpkHR+MPHXBvAYkrrrIP8rGq8dxQdc+8muGY/dxIOx2ANhV
    9rqg2Lm94sQJ2+eXqvUIYJNKDJsQrp1Sw4NNq6/J/0GdU8IQ/se4JaHyC7msJJ1s
    4VMWMLoYPVVTxF1JjIQFw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx3.messagingengine.com;
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
X-CM-Envelope: MS4wfF7+L45cxklLZq7UVETy1iihR6AbRRZFFmq5PWbk+RBH5YlRGZQFSQmgZcHjXRU3bK/sXjN6axdJSkRuxFzbVF9P6QQkcjNbaBpDCqqcMRcntN9tSWAQ
    uU9B+63CYlIcvDmrieTh3OHhVJfOY4aoj0QRxzgIXGyJ5PUqNr4IT07FnwKXnUHqaPaWHLqMBsAMBtX9AdKuJ3tw9nxJfjK1QEQV6Rv8V7RYkEBObqAngtb+
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=4L_DpbUA7MYTkEFw78YA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932206AbeE3U25 (ORCPT <rfc822;linux@kroah.com>);
        Wed, 30 May 2018 16:28:57 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:37458 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1753556AbeE3U25 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 30 May 2018 16:28:57 -0400
Date: Wed, 30 May 2018 16:28:56 -0400 (EDT)
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
In-Reply-To: <20180530194554.GM7063@linux.vnet.ibm.com>
Message-ID: <Pine.LNX.4.44L0.1805301620020.1502-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 30 May 2018, Paul E. McKenney wrote:

> > > My current guess is that we need to change the memory-model tool.  If
> > > that is the case, here are some possible resolutions:
> > > 
> > > 1.	Make herd's C-language control dependencies work the same as its
> > > 	assembly language, so that they extend beyond the end of the
> > > 	"if" statement.  I believe that this would make Roman's case
> > > 	work, but it could claim that other situations are safe that
> > > 	are actually problematic due to compiler optimizations.
> > > 
> > > 	The fact that the model currently handles only READ_ONCE()
> > > 	and WRITE_ONCE() and not unmarked reads and writes make this
> > > 	option more attractive than it otherwise be, compilers not
> > > 	being allowed to reorder volatile accesses, but we are likely
> > > 	to introduce unmarked accesses sometime in the future.
> > 
> > Preserving the order of volatile accesses isn't sufficient.  The
> > compiler is still allowed to translate
> > 
> > 	r1 = READ_ONCE(x);
> > 	if (r1) {
> > 		...
> > 	}
> > 	WRITE_ONCE(y, r2);
> > 
> > into something resembling
> > 
> > 	r1 = READ_ONCE(x);
> > 	WRITE_ONCE(y, r2);
> > 	if (r1) {
> > 		...
> > 	}
> > 
> > (provided the "..." part doesn't contain any volatile accesses,
> > barriers, or anything affecting r2), which would destroy any run-time
> > control dependency.  The CPU could then execute the write before the
> > read.
> 
> True, but almost all current litmus tests do have at least one volatile
> access in their "if" statements.  I am guessing that this has the same
> memory-model tooling issues as #2 below, but I am as usual happy to be
> proven wrong.  ;-)

It shouldn't be all that bad.  The dependencies are generated by herd,
meaning that the code would have to be changed to make control
dependencies extend beyond the ends of "if" statements.  I don't think
the necessary changes would be tremendously big, especially since the
LISA front end already behaves this way.

> > > 2.	Like #1 above, but only if something in one of the "if"'s
> > > 	branches would prevent the compiler from reordering
> > > 	(smp_mb(), synchronize_rcu(), value-returning non-relaxed
> > > 	RMW atomic, ...).  Easy for me to say, but I am guessing
> > > 	that much violence would be needed to the tooling to make
> > > 	this work.  ;-)
> > 
> > This would be my preference.  But I'm afraid it isn't practical at the 
> > moment.
> 
> I bet that some combination of scripting and smallish modifications to
> tooling could make it happen in reasonably short term.  Might be more
> difficult to make something more future-proof, though, agreed.

I have no idea what sort of scripting/smallish modifications could do 
the job.  You could ask Luc, if you're not afraid of giving him an 
aneurysm.  :-)

> > > If I understand Alan correctly, there is not an obvious way to make
> > > this change within the confines of the memory model's .bell and .cat
> > > files.
> > 
> > No way at all.  It would require significant changes to herd's internal 
> > workings and its external interface -- my original point.
> 
> I was afraid of that.  ;-)
> 
> Though truth be told, I was expecting an issue like this to crop up
> sooner rather than later, so I was actually getting a bit nervous
> about the fact that it had not yet shown itself...

The fact is, herd was never meant to act like a compiler.  Some 
disagreements are inevitable.

Alan

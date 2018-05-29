Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2618787-1527625007-2-15288624864001465838
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527625007; b=PlTAiRmpin1NWPAacjXdxnufFWilmQJXVU6noDFlEStsacUWhF
    DHzaz1ChOgBOo63JMPmpsqeEtR2J+1uCGU65gKgcf2CkJIg/moo4y0e/c5NFGfLb
    qU+myB5oK2Hqmplcx63BsQG6qEps9dvurPys2mjsG/ylGA3TlxXxqQB777jyjHH8
    G8Z4Pt7dNK+JDLaDl4HTO+eZJ0UAv8A0oy+Q/kKSW6eIwYfUFaEyc5/xcPWn77R1
    1l1ORp1dQm0n1XmxDUTPCqjVub+P5+XCLO1SESF9PoR9ED33KbxjjRw2au/fLSpp
    nAv2vVNrNZg6idqYqzFcooDd0nJ6O5zd0b1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1527625007; bh=pNtvNhOPpD5XrckiJseQJ7X5ksI7WY
    kN8cpMetI2SrY=; b=c20NE3dhbVi5lFw6+N3bjiw4HBJS8mjwdg5/mVvU8DOB17
    adMesvC9JT1blOYbUbnmbf9KnYbWnZNc/hVlneBktcscQNLc+wzs3CG5ukQG1rUg
    9Js7UeW5do+/2oGzvmpN1jCtkJ3FR/AAJU9HqYVMcyk9kW4ljgjaPZ9GoyXe53Rx
    0jAFe5q2TDoUrSWs64LD2dIxUQdQteHnkAsawRLz7VzWCrkTc/LwfpH5g9UmVXHD
    g05nYAchU5rHIAV1Q4ZE7ryGKRJa8MIL74wEEr/ZoT4bszWA9fMmlTYLCV/ImzbN
    4VvCL8Ol+AKSXsIHcjIJMcCm9jgWknFLP1mCTzQw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=arm.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=arm.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfD/M8RirFZl0QEXO9gr7QwjbSQU+xhRsXkwWxzz/sCJbCOK6S17F9zb3c3sLYVJ9g6n1cw5kqZJjBgoWNDjOHp2T9sUuorRPhTB1lng/bu6j1pselHl7
    OBrD/6fZ2YPYZaYZR4/EtnMHSFeEBc42fSaGh3spF44McsIJevtwwHZYt/nrjRWXr7uPXfopT88m1lucTqQetfvwjT1s9Rm3JV3YUA/JGpEz7U1Ey3YusFjT
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=VnNF1IyMAAAA:8 a=B9yYOL9k-iUm9KP2FWoA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966511AbeE2UQp (ORCPT <rfc822;linux@kroah.com>);
        Tue, 29 May 2018 16:16:45 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:47220 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966179AbeE2UQo (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 29 May 2018 16:16:44 -0400
Date: Tue, 29 May 2018 21:17:13 +0100
From: Will Deacon <will.deacon@arm.com>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        stern@rowland.harvard.edu, andrea.parri@amarulasolutions.com,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, mingo@kernel.org
Subject: Re: [PATCH RFC tools/memory-model] Add litmus-test naming scheme
Message-ID: <20180529201713.GD591@arm.com>
References: <20180525191020.GA5914@linux.vnet.ibm.com>
 <20180529093050.GB6533@arm.com>
 <20180529121107.GF3803@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180529121107.GF3803@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 29, 2018 at 05:11:07AM -0700, Paul E. McKenney wrote:
> On Tue, May 29, 2018 at 10:30:50AM +0100, Will Deacon wrote:
> > Hi Paul,
> > 
> > On Fri, May 25, 2018 at 12:10:20PM -0700, Paul E. McKenney wrote:
> > > This commit documents the scheme used to generate the names for the
> > > litmus tests.
> > > 
> > > Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > > ---
> > >  README |  136 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
> > >  1 file changed, 135 insertions(+), 1 deletion(-)
> > 
> > Whilst I think documentation like this is extremely important for users,
> > this feels like it's documenting how to drive parts of diy and I'm not
> > convinced that it belongs in the kernel source tree as long as the projects
> > remain separate.
> > 
> > Why not contribute this to the herdtools7 documentation, then just reference
> > that from here? That would also be helpful for other people interested in
> > memory models, but perhaps not interested in Linux (assuming such people
> > exist ;).
> 
> We would still need at least a pointer from the Linux kernel to that
> documentation, but I am happy either way.  We probably need examples of
> the common cases, but probably not a full exposition of all the available
> herd7 edges.

Completely agreed.

> Should this be in the herdtools7 documentation, or as added detail
> from a variation on the "diyone7 -bell linux-kernel.bell -show edges"
> command?  If the latter, I suppose that the ones coming from the .bell
> file might simply be labelled as such.

Many of the edges aren't specific to the Linux kernel, so I think they
should be part of the diyone7 documentation. We could then describe only
the additional edges added by the kernel memory model (e.g. "Once") in
the kernel documentation.

Will

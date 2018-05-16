Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-654-1526461304-2-17520730988947443960
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526461304; b=eFdYi3nNJP1Dr1haKqusBR5Czy3oJwDPygluwUmTm9whBSayL1
    BxY1A9ZPaasp40aJKFOh7arb38XXW2u3aemdw983apoKOJHvvb7K1CHlTo6EqjSt
    fXzQl71lC0tlgEiVBKFWOfpraVbJwO1UptaAbzG+BSU1vfUF2p+55nAyS0PYoc2L
    brfqo7NCKyuXwvbCd4+CkMU7fEkhRSLwpjRFxpos/Tj/hNJaYKSN0my0bJYvzZaa
    s9pAVIhgAIv6i+is0pFI1jOX7ZBC+oU3Pr7e0eOgibvJ2RGKsujswlDTM/GVkuhz
    yNkZ5WHubUY7ZY/xhf0Y4cIcRp83PYyREbfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526461304; bh=Ob4X8sDrxsHJiRogS/FMBGGVBYztB1
    B+cY934SRKVUY=; b=AAYtPp1q+QjcfpMAYr9qpOdz1Oi/FhuGy8F1a/S4z44CD1
    Va8bcxbWW+oFSRiPmUMyuNxokKmagOG2priGpSGYSAwNROgLPPf6A2Jw8yJtlcdF
    oYoN4P0aiKJXXGN3cSfzxpNcy+nRF7EO64+rmM2oale1tb4J6XzwjQX//iS4kZ48
    xyhIkW2KGIjJSF0TJAw1p2qPzIvQ8A1fOoesgGLaIcSXfNALgbGQIIX1v8KuagYr
    78m9IZ5B5/huTDzNgbGTuoacfRmq/0rG3KHNBsQNXDjj8kAqfcAEl2akMzl9lUgC
    PXNO2Sea5CGkAVSpMA2ws8f35M5vVHFgGSTS4v9g==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=arm.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=arm.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHQZrB17zcZls14COHUbTQYeDGnzDf9LsYsbUHtS9q/TGf3Wf9PlDHcw1eDX16k8nP9JfBY7qZodVq61BX2mg6CXEsSDPoeDVPNtbN+FzsvslNUvKH+g
    fIMxXk99YYVeZrTDFJvIeCi2JeASnR1aF6vgQv/488S0+wjU2Sz79cmiP2/ctEbtOKs5zilrHoCpWj6C+YPsEkdOSlUgobtGx1iL/fVl4dNcF3Y/lrH9bemw
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=cYgkMOTSg73UZA7HPeQA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751976AbeEPJBl (ORCPT <rfc822;linux@kroah.com>);
        Wed, 16 May 2018 05:01:41 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:44344 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751664AbeEPJBh (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 May 2018 05:01:37 -0400
Date: Wed, 16 May 2018 10:01:32 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: marc.zyngier@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, linux@dominikbrodowski.net,
        james.morse@arm.com, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 06/18] arm64: move sve_user_{enable, disable} to
 <asm/fpsimd.h>
Message-ID: <20180516090121.GQ7753@e103592.cambridge.arm.com>
References: <20180514094640.27569-1-mark.rutland@arm.com>
 <20180514094640.27569-7-mark.rutland@arm.com>
 <20180514110649.GC7753@e103592.cambridge.arm.com>
 <20180515103936.v5ytofdq3qqtsomn@lakrids.cambridge.arm.com>
 <20180515121921.GN7753@e103592.cambridge.arm.com>
 <20180515163352.sl7sfaswv4hsktl7@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180515163352.sl7sfaswv4hsktl7@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 15, 2018 at 05:33:52PM +0100, Mark Rutland wrote:
> On Tue, May 15, 2018 at 01:19:26PM +0100, Dave Martin wrote:
> > On Tue, May 15, 2018 at 11:39:36AM +0100, Mark Rutland wrote:
> > > On Mon, May 14, 2018 at 12:06:50PM +0100, Dave Martin wrote:
> > > > On Mon, May 14, 2018 at 10:46:28AM +0100, Mark Rutland wrote:

[...]

> > > > > @@ -107,6 +119,9 @@ static inline int sve_get_current_vl(void)
> > > > >  	return -EINVAL;
> > > > >  }
> > > > >  
> > > > > +static inline void sve_user_disable(void) { }
> > > > > +static inline void sve_user_enable(void) { }
> > > > > +
> > > > 
> > > > Alternatively, just move the full definitions outside the #ifdef
> > > > CONFIG_ARM64_SVE.
> > > 
> > > Can do, though I was trying to keep the exsting pattern with empty
> > > inlines for the !CONFIG_ARM64_SVE case.
> > 
> > There isn't really a pattern.  I tried to avoid dummy versions where
> > there's no real reason to have them.  I don't _think_ they're really
> > needed here, unless I missed something.  Did you get build failures
> > without them?
> 
> I need *some* definition so that sve_user_reset() in the syscall path
> can compile without ifdeferry. 
> 
> In sve_user_reset() I first check system_supports_sve(), which checks
> IS_ENABLED(CONFIG_ARM64_SVE), so the call should be optimised away when
> !CONFIG_ARM64_SVE, but I need a prototype regardless.

What I envisaged is that you move the real definitions outside the
#ifdef so that they're defined unconditionally, and get rid of the
dummies.

Having a dummy definition of sve_user_enable() really feels like it's
papering over something.  How could it be appropriate to call this in a
non-SVE enabled system?  You _do_ guard the call to this already, so
hiding the real function body for CONFIG_ARM64_SVE=n doesn't appear to
achieve anything.  Maybe I missed something somewhere.

A dummy sve_user_disable() is a bit more reasonable though, but we want
this to be a nop on non-SVE hardware even if CONFIG_ARM64_SVE=y.

What about moving the system_supports_sve() check inside
sve_user_disable()?

[...]

> > > Earlier I'd put BUILD_BUG() in the body for the !CONFIG_ARM64_SVE case,
> > > to catch that kind of thing -- I could restore that.
> > 
> > IIUC:
> > 
> > 	if (0) {
> > 		BUILD_BUG_ON(1);
> > 	}
> > 
> > can still fire, in which case it's futile checking for CONFIG_ARM64_SVE
> > in most of the SVE support code.
> 
> We already rely on BUILD_BUG() not firing in paths that can be trivially
> optimized away. e.g. in the cmpxchg code.

Fair enough.  I had been unsure on this point.

If you want to put a BUILD_BUG_ON(!IS_ENABLED(CONFIG_ARM64_SVE)) in
sve_user_enable() and build with CONFIG_ARM64_SVE=n to check it works,
then I'd be fine with that.

This doesn't capture the runtime part of the condition, but it's better
than nothing.

[...]

> > > > > diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
> > > > > index 088940387a4d..79a81c7d85c6 100644
> > > > > --- a/arch/arm64/kernel/fpsimd.c
> > > > > +++ b/arch/arm64/kernel/fpsimd.c
> > > > > @@ -159,7 +159,6 @@ static void sve_free(struct task_struct *task)
> > > > >  	__sve_free(task);
> > > > >  }
> > > > >  
> > > > > -
> > > > 
> > > > Hmmm, Ack.  Check for conflicts with the KVM FPSIMD rework [1] (though
> > > > trivial).
> > > 
> > > I'll assume that Ack stands regardless. :)
> > 
> > Actually, I was just commenting on the deleted blank line... 
> 
> Ah. I've restored that now.

I meant Ack to the deletion.  It looks like the blank line was
spuriously introduced in the first place.  But it doesn't hugely matter
either way.

Cheers
---Dave

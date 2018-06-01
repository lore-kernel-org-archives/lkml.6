Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3104510-1527848970-2-16317435507377878667
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527848970; b=NgLBnr2UM5Q/c1GCOcjGZmyPua3CTYq1fRemaTM2C9xaUPU0M+
    dAKd0zrm2ULLkOxiC820uyAU1XFiDfp8Zkn4si5ATo6hzWNOZuqpWZylKK9jgk1e
    oLyxt4pGQIA0xM/kTjIDJ9jnv72tz6aJ2SrVshQqaId5tuN+/w/4t2EuZ5iIbQPm
    fB/+6lPCYkg9XFqu5cOu2/pAH4sVReG0TGu9tfORk6eRc9XDYzTV87dxnNgsBRi4
    TxDQqMdMM6sBOx1Yb7Rw9vLLuVogsxQIjcC2lJ3BkmMmOmYKac4TkrOwfTGQwlmH
    sjl+7o6YGMDe0NSlj7PAzMwb1Q3BB4dwUQrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1527848970; bh=hP0OSpltMzcOrN/DMkwaZUAMsoEOJI
    GVJp+WKKX2xqY=; b=XdUtW86ENPQjIXYbUVVWPlzd41YxrirTa9/qBBoIu7n1mb
    6SjXi7YgSLU0p6Z9Vws0HTO3orzHR8F99dWRyyBcacrmuwkBXs95H5Acz9fWGmFH
    b/0/LXIE6n+S83PUf2nGVyxkTpAcjD8WLaw6hpfu/t4KiNHSPg1KDPaQZy+wXV6I
    7pWVBIi6dCmntrDr6KLRvhkBErjIxetw7Su7UnVEYNLF7U6COOe4582k4LECI6xT
    ftyOujfTkEMrEQoZQS/MhDlz8rvTIhihSvlO9N+2R1X3jnX4E42sKwWUEmULCgB+
    +tKOIya5cJTDZ3E6bH5GNIgW0DMkXzN5Y1WC7hIg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
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
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=arm.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOoMhXBO83LeFi2EWOMqpD5RS7kM40VWUGND/JzZ8JuusdJ1aTtHDGGVmjaAgV2TRlsRff/ok36QdktLM1/DmBtXqwznfrmgLf8IZTjH9/jMdw7X+Rm8
    ob8tuK1NVljzHjL7MxDMfdDaOTH4H1DCIbU6M3LyyorgG6U0KxyniI5K9PL9DrqGZy/ACuRqiwr4jZEIwqjYYCf3MQ40J8mV3u3bHVgcu1cKseM3Y9Gd5toe
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=7mUfYlMuFuIA:10
    a=KOczDeS6YmYjXnzdzYQA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751346AbeFAK30 (ORCPT <rfc822;linux@kroah.com>);
        Fri, 1 Jun 2018 06:29:26 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49618 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751293AbeFAK3Z (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Jun 2018 06:29:25 -0400
Date: Fri, 1 Jun 2018 11:29:13 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Dave Martin <Dave.Martin@arm.com>
Cc: marc.zyngier@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, linux@dominikbrodowski.net,
        james.morse@arm.com, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 06/18] arm64: move sve_user_{enable, disable} to
 <asm/fpsimd.h>
Message-ID: <20180601102913.ougz2vshzzttvuaj@lakrids.cambridge.arm.com>
References: <20180514094640.27569-1-mark.rutland@arm.com>
 <20180514094640.27569-7-mark.rutland@arm.com>
 <20180514110649.GC7753@e103592.cambridge.arm.com>
 <20180515103936.v5ytofdq3qqtsomn@lakrids.cambridge.arm.com>
 <20180515121921.GN7753@e103592.cambridge.arm.com>
 <20180515163352.sl7sfaswv4hsktl7@lakrids.cambridge.arm.com>
 <20180516090121.GQ7753@e103592.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180516090121.GQ7753@e103592.cambridge.arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 16, 2018 at 10:01:32AM +0100, Dave Martin wrote:
> On Tue, May 15, 2018 at 05:33:52PM +0100, Mark Rutland wrote:
> > On Tue, May 15, 2018 at 01:19:26PM +0100, Dave Martin wrote:
> > > On Tue, May 15, 2018 at 11:39:36AM +0100, Mark Rutland wrote:
> > > > Earlier I'd put BUILD_BUG() in the body for the !CONFIG_ARM64_SVE case,
> > > > to catch that kind of thing -- I could restore that.
> > > 
> > > IIUC:
> > > 
> > > 	if (0) {
> > > 		BUILD_BUG_ON(1);
> > > 	}
> > > 
> > > can still fire, in which case it's futile checking for CONFIG_ARM64_SVE
> > > in most of the SVE support code.
> > 
> > We already rely on BUILD_BUG() not firing in paths that can be trivially
> > optimized away. e.g. in the cmpxchg code.
> 
> Fair enough.  I had been unsure on this point.
> 
> If you want to put a BUILD_BUG_ON(!IS_ENABLED(CONFIG_ARM64_SVE)) in
> sve_user_enable() and build with CONFIG_ARM64_SVE=n to check it works,
> then I'd be fine with that.
> 
> This doesn't capture the runtime part of the condition, but it's better
> than nothing.

For the moment, I've kept the stubs, but placed a BUILD_BUG() in each,
as per the above rationale. 

We generally do that rather than than BUILD_BUG_ON(!IS_ENABLED(...)) in
a common definition, and it's more in keeping with the other stubs in
<asm/fpsimd.h>.

> > > > > > diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
> > > > > > index 088940387a4d..79a81c7d85c6 100644
> > > > > > --- a/arch/arm64/kernel/fpsimd.c
> > > > > > +++ b/arch/arm64/kernel/fpsimd.c
> > > > > > @@ -159,7 +159,6 @@ static void sve_free(struct task_struct *task)
> > > > > >  	__sve_free(task);
> > > > > >  }
> > > > > >  
> > > > > > -
> > > > > 
> > > > > Hmmm, Ack.  Check for conflicts with the KVM FPSIMD rework [1] (though
> > > > > trivial).
> > > > 
> > > > I'll assume that Ack stands regardless. :)
> > > 
> > > Actually, I was just commenting on the deleted blank line... 
> > 
> > Ah. I've restored that now.
> 
> I meant Ack to the deletion.  It looks like the blank line was
> spuriously introduced in the first place.  But it doesn't hugely matter
> either way.

Ok. I've dropped that for now to minimize the potential for conflicts,
but we can clean this up later.

Thanks,
Mark.

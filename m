Return-Path: <linux-efi-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-402196-1526281437-2-13775945699062387436
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-efi-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526281436; b=LW5UAvnRpU7Q6Xmy0u6pAu2hQKPvLZ1SgicCPyFc1sxz1T0zRz
    g2Tk86rj0vt9RpUSFKxtmJ2NlmsstAh2sCyMXUkhknjWBW58xPwYkmSKdV1Izm3E
    VYfbxRru4R/1DPNmn/4z0Pya/90tWKG2Fmsoc1IY7EwYOIIcg9oToSyuqrPeFY10
    aqWUQkpYpYk2YMr120AT5XOjLH+tkxU+syX4+a+LuM7JaIoxEEjHLB4qjmchbEV1
    Sie7gl2oILxoL7BHFvIDj/EgmaEpRAZbiUDJ+GS39BmFFdUn+zUsAOPm+scaScih
    0BSWfSbaNJkEsIkcFKBimSU9lNFO3BmclMdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526281436; bh=UqAiAajbXRnaeLtiaj6EkywhWDTiw2
    EgOx0IeeJutt8=; b=WI9dFrRQ487znDsaUbSh9IRuo8RemDd7DiYM3Wfm9ROQ9I
    RtfbsKbFmdQkgUNMNUq/HLOnME0YicAK8Rmda2slBN014Fdtku0wPlRCa75OOjlr
    v8IjUecDcU2hQZySZEP4WnPp8BdDGFpg1nf6nhIohTWpDU/d1pOLbi75f8zCc36a
    y9OazVsbRkBvmtLLZSJcoi1pu9JTs2lwnGWtieE6uKqEj4qqGiQZUEJgQHE3feN2
    fHeDmkM59Ak2GaPf1GftlAgKctZUgFR334u9/Iyfo7iwsHBJhQ/9St/8U38fbEBo
    6lK/y36GjDTNarvdURzEaAzrlnXHnbhRaF5pE9KQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=vNc9rvPq x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-efi-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=qdtxTm0t;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=vNc9rvPq x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-efi-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=qdtxTm0t;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNQZZYousmXiNcCTn8659q2j4GedjAORVz3qwDUDZpn5XUhNGqGUmMHo0rfFI+1JNODus82Bc/4L11/IvKnM87g0ZbBifF9ldlv6AU1NTbEsEpLiYTJC
    faH+N6RFGtA6H7hmLvD3dHNPPahcbVkVgr+LwD8SM/T6mTVXHXTNg3LYIRKEtHIuD7gfwFNORLff0tsmtQMCGP5tnYZNm29PICcKITeYSVarIGsI7Pecu1Gf
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=KKAkSRfTAAAA:8 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=6-PvOLV5e6nJ4qZjO3sA:9
    a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10 a=cvBusfyB2V15izCimMoJ:22
    a=AjGcO6oz07-iQ99wixmX:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754132AbeENHAS (ORCPT <rfc822;linux@kroah.com>);
        Mon, 14 May 2018 03:00:18 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:41381 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754118AbeENHAO (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 14 May 2018 03:00:14 -0400
X-Google-Smtp-Source: AB8JxZp4cOTwuHB9wG1hp0klo2gvzsnWqq0kfsoR45Fmux+U9vxJCVeO4AOYL/kKvPT2nbzwh7CUuQ==
Date: Mon, 14 May 2018 09:00:10 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: linux-efi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 17/17] efi/libstub/arm64: handle randomized TEXT_OFFSET
Message-ID: <20180514070010.GF16596@gmail.com>
References: <20180504060003.19618-1-ard.biesheuvel@linaro.org>
 <20180504060003.19618-18-ard.biesheuvel@linaro.org>
 <20180514064701.GC16596@gmail.com>
 <CAKv+Gu9nud17L+FhMwbTb9AaVd0+qRgqXU1_c4K+GCH-=uhpxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu9nud17L+FhMwbTb9AaVd0+qRgqXU1_c4K+GCH-=uhpxQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-efi-owner@vger.kernel.org
X-Mailing-List: linux-efi@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


* Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:

> On 14 May 2018 at 08:47, Ingo Molnar <mingo@kernel.org> wrote:
> >
> > * Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> >
> >> From: Mark Rutland <mark.rutland@arm.com>
> >>
> >> When CONFIG_RANDOMIZE_TEXT_OFFSET is selected, TEXT_OFFSET is an
> >> arbitrary multiple of PAGE_SIZE in the interval [0, 2MB).
> >>
> >> The EFI stub does not account for the potential misalignment of
> >> TEXT_OFFSET relative to EFI_KIMG_ALIGN, and produces a randomized
> >> physical offset which is always a round multiple of EFI_KIMG_ALIGN.
> >> This may result in statically allocated objects whose alignment exceeds
> >> PAGE_SIZE to appear misaligned in memory. This has been observed to
> >> result in spurious stack overflow reports and failure to make use of
> >> the IRQ stacks, and theoretically could result in a number of other
> >> issues.
> >>
> >> We can OR in the low bits of TEXT_OFFSET to ensure that we have the
> >> necessary offset (and hence preserve the misalignment of TEXT_OFFSET
> >> relative to EFI_KIMG_ALIGN), so let's do that.
> >>
> >> Fixes: 6f26b3671184c36d ("arm64: kaslr: increase randomization granularity")
> >> Cc: <stable@vger.kernel.org> # v4.7+
> >> Reported-by: Kim Phillips <kim.phillips@arm.com>
> >> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> >> Tested-by: Kim Phillips <kim.phillips@arm.com>
> >> [ardb: clarify commit log]
> >> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >> ---
> >>  drivers/firmware/efi/libstub/arm64-stub.c | 7 +++++++
> >>  1 file changed, 7 insertions(+)
> >>
> >> diff --git a/drivers/firmware/efi/libstub/arm64-stub.c b/drivers/firmware/efi/libstub/arm64-stub.c
> >> index b9bd827caa22..541b82fdc8a2 100644
> >> --- a/drivers/firmware/efi/libstub/arm64-stub.c
> >> +++ b/drivers/firmware/efi/libstub/arm64-stub.c
> >> @@ -97,6 +97,13 @@ efi_status_t handle_kernel_image(efi_system_table_t *sys_table_arg,
> >>               u32 offset = !IS_ENABLED(CONFIG_DEBUG_ALIGN_RODATA) ?
> >>                            (phys_seed >> 32) & mask : TEXT_OFFSET;
> >>
> >> +             /*
> >> +              * With CONFIG_RANDOMIZE_TEXT_OFFSET, TEXT_OFFSET may not be a
> >> +              * multiple of EFI_KIMG_ALIGN, and we must ensure that we apply
> >> +              * the offset below EFI_KIMG_ALIGN.
> >> +              */
> >
> > When referring to config variables in comments and changelogs I'd suggest a bit
> > more verbosity:
> >
> >   s/CONFIG_RANDOMIZE_TEXT_OFFSET
> >    /CONFIG_RANDOMIZE_TEXT_OFFSET=y
> >
> > ... because at first I thought (based on the name) that
> > CONFIG_RANDOMIZE_TEXT_OFFSET is an actual integer offset value - while it's a
> > bool. The =y makes the bool nature obvious.
> >
> > ( Similarly, when negated the canonical way to refer to it is
> >   !CONFIG_RANDOMIZE_TEXT_OFFSET. )
> >
> 
> Fair enough.
> 
> >> +             offset |= (TEXT_OFFSET % EFI_KIMG_ALIGN);
> >
> > The parentheses are not needed here I think.
> >
> 
> Nope.
> 
> Will you fix this up when applying? Or should I resend?

Since this was at the tail with no dependencies I'll skip this for now I think - 
mind sending the refreshed version in the next batch?

Thanks,

	Ingo

Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A23C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 13:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EAA720896
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 13:12:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lFO8uR9l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EAA720896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387406AbeKMXKz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 18:10:55 -0500
Received: from mail-it1-f171.google.com ([209.85.166.171]:50403 "EHLO
        mail-it1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732728AbeKMXKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 18:10:55 -0500
Received: by mail-it1-f171.google.com with SMTP id k206-v6so18041027ite.0;
        Tue, 13 Nov 2018 05:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FxHN1BCyIqL+rH0W/1DZPXu9spJ6755fsGV1Ip/qEjA=;
        b=lFO8uR9lCA+q1n/lJLGiu0d2cbMwtD9iFEM8E2MluZ8J00Tyt9x2zugAebxy7xMn+O
         nWO0LMYkIM2Wh38gum4v1PrCWPEVUh+L7bvwtXIoKPFHuT5lAMrdiotkTlQ8YRTRj1va
         o4Am0AU8mfEiCaIEgdwEHQqOoKByOUkl+mSEex7Od2dFnXbn1ZcyzmPdmvPg8Kbw505G
         b/EFFlav6lRfmuh+l5tQOtT0PAuDvgB2x0U8k7yjaNLjo9xWJCyfeQEWMQrBTuTJzfUF
         h8X+YaTqpEG/KwkY+5JQ4oXywwSvFAoqpoiJwnMp19VLjAyXFu+vclrW4hwQffd+lRe6
         sSZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FxHN1BCyIqL+rH0W/1DZPXu9spJ6755fsGV1Ip/qEjA=;
        b=B4FvoyBo8W6H0aPC8raC9evKrCzw1Zj63frwEdQuLaIY17bGjDj2nqjmxLFYrOjH+U
         YDXHBFn0sfVJWQTS8uqm2FuxhEoKnzHQBV1dxeGqv8zJv8wViYhNZFeY+ys6seH12fE7
         IdxN4/vbGHguonX6336SVeRBId3ENxEWUOdVT3YrC6+zBSMslsn1GAsEuNXicOOpCXWA
         5JaVlt61SXpFNs/XG5r1MK6hiuiYxC513Fuv/W+mi7R8eXgDvGo4oesCEKx7kvrxuvqc
         52/fjmOsDlv3KhldUAp9J6ssnw8VRfrLYpk6pLWtdn5MoNDpU9h8sidnJk0MdbRDqqGy
         b+Qw==
X-Gm-Message-State: AGRZ1gL8ToSHY5mdqvj8aawKjc8h/Pf5WYptQ1vHQFp+RLN6sxtILztM
        +0YlquW6osStVSTUN+wWc6PI34skmcJYPQQjlrc+SQ==
X-Google-Smtp-Source: AJdET5dkesNWr4r3NIq1wnUxKrE7uY3rrNXB+ihermU5on8LD7Uv9bUK9Be4YRVFxhkZEwIGLVb7XcOCmUElcblVdMQ=
X-Received: by 2002:a24:38b:: with SMTP id e133-v6mr3758467ite.104.1542114769062;
 Tue, 13 Nov 2018 05:12:49 -0800 (PST)
MIME-Version: 1.0
References: <20180927224609.19515-1-robdclark@gmail.com> <20181029191000.GD16739@arm.com>
 <CAF6AEGtgC0V6ii2=p2HGmqvHFKNJhaOLi8873SGPDsrg70xGRg@mail.gmail.com> <20181113063225.GA3109@brain-police>
In-Reply-To: <20181113063225.GA3109@brain-police>
From:   Rob Clark <robdclark@gmail.com>
Date:   Tue, 13 Nov 2018 08:12:35 -0500
Message-ID: <CAF6AEGuV2zh97iq+TgkRw0bK3VNSxJieD1N2KMW3N28h07M+0w@mail.gmail.com>
Subject: Re: [PATCH] iommu: arm-smmu: Set SCTLR.HUPCF bit
To:     Will Deacon <will.deacon@arm.com>
Cc:     "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <joro@8bytes.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2018 at 1:32 AM Will Deacon <will.deacon@arm.com> wrote:
>
> On Fri, Nov 09, 2018 at 01:01:55PM -0500, Rob Clark wrote:
> > On Mon, Oct 29, 2018 at 3:09 PM Will Deacon <will.deacon@arm.com> wrote:
> > > On Thu, Sep 27, 2018 at 06:46:07PM -0400, Rob Clark wrote:
> > > > We seem to need to set either this or CFCFG (stall), otherwise gpu
> > > > faults trigger problems with other in-flight transactions from the
> > > > GPU causing CP errors, etc.
> > > >
> > > > In the ARM SMMU spec, the 'Hit under previous context fault' bit is
> > > > described as:
> > > >
> > > >  '0' - Stall or terminate subsequent transactions in the presence
> > > >        of an outstanding context fault
> > > >  '1' - Process all subsequent transactions independently of any
> > > >        outstanding context fault.
> > > >
> > > > Since we don't enable CFCFG (stall) the behavior of terminating
> > > > other transactions makes sense.  And is probably not what we want
> > > > (and definately not what we want for GPU).
> > > >
> > > > Signed-off-by: Rob Clark <robdclark@gmail.com>
> > > > ---
> > > > So I hit this issue a long time back on 820 (msm8996) and at the
> > > > time I solved it with a patch that enabled CFCFG.  And it resurfaced
> > > > more recently on sdm845.  But at the time CFCFG was rejected, iirc
> > > > because of concern that it would cause problems on other non-qcom
> > > > arm smmu implementations.  And I think I forgot to send this version
> > > > of the solution.
> > > >
> > > > If enabling HUPCF is anticipated to cause problems on other ARM
> > > > SMMU implementations, I think I can come up with a variant of this
> > > > patch which conditionally enables it for snapdragon.
> > > >
> > > > Either way, I'd really like to get some variant of this fix merged
> > > > (and probably it would be a good idea for stable kernel branches
> > > > too), since current behaviour with the GPU means faults turn into
> > > > a fantastic cascade of fail.
> > >
> > > Can you describe how this fantastic cascade of fail improves with this
> > > patch, please? If you're getting context faults then something has already
> > > gone horribly wrong, so I'm trying to work out how this improves things.
> > >
> >
> > There are plenty of cases where getting iommu faults with a GPU is
> > "normal", or at least not something the kernel or even GL driver can
> > control.
>
> Such as? All the mainline driver does is print a diagnostic and clear the
> fault, which doesn't seem generally useful.

it is useful to debug the fault ;-)

Although eventually we'll want to be able to do more than that, like
have the fault trigger bringing in pages of a mmap'd file and that
sort of thing.

> > With this patch, you still get the iommu fault, but it doesn't cause
> > the gpu to crash.  But without it, other memory accesses in flight
> > while the fault occurs, like the GPU command-processor reading further
> > ahead in the cmdstream to setup next draw, would return zero's,
> > causing the GPU to crash or get into a bad state.
>
> I get that part, but I don't understand why we're seeing faults in the first
> place and I worry that this patch is just the tip of the iceberg. It's also
> not clear that processing subsequent transactions is always the right thing
> to do in a world where we actually want to report (and handle) synchronous
> faults from devices.

Sure, it is a bug.. but it can be an application bug that is not
something the userspace GL driver or kernel could do anything about.
We shouldn't let this kill the GPU.  If the application didn't have
this much control, we wouldn't need an IOMMU in the first place[1].
With opencl compute, the userspace controlled shader has full blown
pointers to GPU memory.

And even in cases where it is a userspace GL driver bug, having some
robustness to not completely kill the GPU makes debugging much easier.
Something I do a lot when bringing up support for a new generation of
GPU.

I'm having a hard time understanding your objection to this.
Returning zero's for non-faulting transactions is a *really bad idea*.

BR,
-R


[1] yes, vc4 did without an IOMMU.. but it also had to do some fairly
complex shader analysis in the kernel, and it was restricted to gles2
feature set, so no real flow control, and no memory access beyond
texture fetch.

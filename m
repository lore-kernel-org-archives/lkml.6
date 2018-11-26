Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C28CBC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 20:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72975208E7
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 20:56:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e7lB3hUU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72975208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727284AbeK0HwO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 02:52:14 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:56304 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727105AbeK0HwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 02:52:14 -0500
Received: by mail-it1-f195.google.com with SMTP id o19so30598251itg.5;
        Mon, 26 Nov 2018 12:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vlo6ByVMVqdO50IfdiZ9PKec1ERKKwejQK+K+Ptqaw0=;
        b=e7lB3hUUHaGc0tjgqjpphaFwZwLD1sfteBojzQ5aM7Xpcsl6mlCDwnQW7T1p3QgbGt
         dxS0vjmpEUYBAUATHazN/OGE2B3pf+MEix+i4LWCkYxXqG1oqGjA6jbS9DE4uGn8G6FM
         baiFSsJ4QfBdpeSI0zWTy+hLILgIUdljDWsIEqErpWPk1nSAa7mNaitow4a/24vULKQC
         PPjA3xaVd83NNSvCNfRej4iDON55eH7VIQqt1wLlk5KJb0LwrPFeMet8Qzmo0QAxjolk
         C2O1uUP1WfV3cgljkm/YKvNldrTUWyHsMDQ5QuexO8oJB5cbd/DBgnHS/MlaKog5Z7tx
         RbhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vlo6ByVMVqdO50IfdiZ9PKec1ERKKwejQK+K+Ptqaw0=;
        b=PE41HAaDtYmwiIYbQWNuyeaelagWDUdcTUfxvOl7CXYA6nDLBHUUCvIv9sCqho/pb2
         vGexMRAQ/YWQ7jrAwPjpSixu4Z7kzG7OUGyvXHh4JhYZcqWSY/cifCg4fd83NXcoqM8I
         t3PK7gYx5BA9ufDPWhtuaJ1blxxgb5a7GVyo6WJ/8t/NR5gCnVxWWTyKW4sbamHTSpAv
         Rg2DbT8sRdZSOEXV3jWHvLdy+RJSCtuNgZx4DdFls/TIh3poikzKz/gfsQGwF2pbFglD
         q7M2D6J+KcGUOT+2SL1SFQefDh9TTtRuwrWzRLaf3mZc8PK4Guz2W+IYhMHS23Jgb9cc
         H0VQ==
X-Gm-Message-State: AA+aEWapg7xsyWDk1GIAjuejEMR+Fzj+PYD9xcYkXIwUMKrfTP7yR3l9
        xWYE04ZGtm1VGKuQb2IT+GmGneLOVwfjWvMtcAmLkA==
X-Google-Smtp-Source: AFSGD/VpKUobTbjhR/mscZd2N849w019AHhtoFF833WMxG0hvSsCfI/4sKlxQkUonmsXpVi4Ud89z75w2VjfIB9dprE=
X-Received: by 2002:a02:242b:: with SMTP id f43mr4536608jaa.144.1543265811307;
 Mon, 26 Nov 2018 12:56:51 -0800 (PST)
MIME-Version: 1.0
References: <20180927224609.19515-1-robdclark@gmail.com> <20181029191000.GD16739@arm.com>
 <CAF6AEGtgC0V6ii2=p2HGmqvHFKNJhaOLi8873SGPDsrg70xGRg@mail.gmail.com>
 <20181113063225.GA3109@brain-police> <CAF6AEGuV2zh97iq+TgkRw0bK3VNSxJieD1N2KMW3N28h07M+0w@mail.gmail.com>
 <20181126193147.GB534@arm.com>
In-Reply-To: <20181126193147.GB534@arm.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Mon, 26 Nov 2018 15:56:38 -0500
Message-ID: <CAF6AEGuQ1vqzf4vDbOXvRdiYC9oBmmfAGa=FrBctR64NffwtzA@mail.gmail.com>
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

On Mon, Nov 26, 2018 at 2:31 PM Will Deacon <will.deacon@arm.com> wrote:
>
> Hi Rob,
>
> On Tue, Nov 13, 2018 at 08:12:35AM -0500, Rob Clark wrote:
> > On Tue, Nov 13, 2018 at 1:32 AM Will Deacon <will.deacon@arm.com> wrote:
> > > On Fri, Nov 09, 2018 at 01:01:55PM -0500, Rob Clark wrote:
> > > > On Mon, Oct 29, 2018 at 3:09 PM Will Deacon <will.deacon@arm.com> wrote:
> > > > > On Thu, Sep 27, 2018 at 06:46:07PM -0400, Rob Clark wrote:
> > > > > > We seem to need to set either this or CFCFG (stall), otherwise gpu
> > > > > > faults trigger problems with other in-flight transactions from the
> > > > > > GPU causing CP errors, etc.
> > > > > >
> > > > > > In the ARM SMMU spec, the 'Hit under previous context fault' bit is
> > > > > > described as:
> > > > > >
> > > > > >  '0' - Stall or terminate subsequent transactions in the presence
> > > > > >        of an outstanding context fault
> > > > > >  '1' - Process all subsequent transactions independently of any
> > > > > >        outstanding context fault.
> > > > > >
> > > > > > Since we don't enable CFCFG (stall) the behavior of terminating
> > > > > > other transactions makes sense.  And is probably not what we want
> > > > > > (and definately not what we want for GPU).
> > > > > >
> > > > > > Signed-off-by: Rob Clark <robdclark@gmail.com>
> > > > > > ---
> > > > > > So I hit this issue a long time back on 820 (msm8996) and at the
> > > > > > time I solved it with a patch that enabled CFCFG.  And it resurfaced
> > > > > > more recently on sdm845.  But at the time CFCFG was rejected, iirc
> > > > > > because of concern that it would cause problems on other non-qcom
> > > > > > arm smmu implementations.  And I think I forgot to send this version
> > > > > > of the solution.
> > > > > >
> > > > > > If enabling HUPCF is anticipated to cause problems on other ARM
> > > > > > SMMU implementations, I think I can come up with a variant of this
> > > > > > patch which conditionally enables it for snapdragon.
> > > > > >
> > > > > > Either way, I'd really like to get some variant of this fix merged
> > > > > > (and probably it would be a good idea for stable kernel branches
> > > > > > too), since current behaviour with the GPU means faults turn into
> > > > > > a fantastic cascade of fail.
> > > > >
> > > > > Can you describe how this fantastic cascade of fail improves with this
> > > > > patch, please? If you're getting context faults then something has already
> > > > > gone horribly wrong, so I'm trying to work out how this improves things.
> > > > >
> > > >
> > > > There are plenty of cases where getting iommu faults with a GPU is
> > > > "normal", or at least not something the kernel or even GL driver can
> > > > control.
> > >
> > > Such as? All the mainline driver does is print a diagnostic and clear the
> > > fault, which doesn't seem generally useful.
> >
> > it is useful to debug the fault ;-)
> >
> > Although eventually we'll want to be able to do more than that, like
> > have the fault trigger bringing in pages of a mmap'd file and that
> > sort of thing.
>
> Right, and feels very strange to me if we have this bit set because it
> means that your fault is no longer synchronous and therefore diverges
> from the fault model that you get from the CPU, where you certainly
> wouldn't expect stores appearing in the program after a faulting load to
> be visible in memory. However, thinking harder about it, I suppose we're
> already in a situation where the translations are handled out of order
> in the absence of barriers, so maybe it's not the end of the world.

I guess I wouldn't have expected synchronous without CFCFG=1

> Could you dump the FSR value that you see in the fault handler, please?
> From my reading of the architecture spec, as long as clear all of the
> fault bits in the irq handler, then your machine shouldn't die like it
> does with HUPCFG=CFCFG=0..

I expect it dies before the irq handler returns..

possibly the behavior of terminated translations returning zero's
might be some detail of qcom's implementation (or how the gpu reacts
to terminated memory transactions, etc), rather than something the
spec expects/specifies.

I'll try and get you a dump of FSR in next couple days.. (need to
switch kernels and write up some test code to trigger faults)

BR,
-R

>
> > > > With this patch, you still get the iommu fault, but it doesn't cause
> > > > the gpu to crash.  But without it, other memory accesses in flight
> > > > while the fault occurs, like the GPU command-processor reading further
> > > > ahead in the cmdstream to setup next draw, would return zero's,
> > > > causing the GPU to crash or get into a bad state.
> > >
> > > I get that part, but I don't understand why we're seeing faults in the first
> > > place and I worry that this patch is just the tip of the iceberg. It's also
> > > not clear that processing subsequent transactions is always the right thing
> > > to do in a world where we actually want to report (and handle) synchronous
> > > faults from devices.
> >
> > Sure, it is a bug.. but it can be an application bug that is not
> > something the userspace GL driver or kernel could do anything about.
> > We shouldn't let this kill the GPU.  If the application didn't have
> > this much control, we wouldn't need an IOMMU in the first place[1].
> > With opencl compute, the userspace controlled shader has full blown
> > pointers to GPU memory.
> >
> > And even in cases where it is a userspace GL driver bug, having some
> > robustness to not completely kill the GPU makes debugging much easier.
> > Something I do a lot when bringing up support for a new generation of
> > GPU.
> >
> > I'm having a hard time understanding your objection to this.
> > Returning zero's for non-faulting transactions is a *really bad idea*.
>
> Wait -- who said anything about returning zeroes? Where does that behaviour
> appear in the architecture?
>
> Will

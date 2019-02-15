Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7283C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 22:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0036222D9
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 22:37:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dvVJ5osn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391900AbfBOWh4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 17:37:56 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:53839 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390411AbfBOWhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 17:37:55 -0500
Received: by mail-it1-f194.google.com with SMTP id x131so26711908itc.3;
        Fri, 15 Feb 2019 14:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uBrEda264CqNMTYOMGS0nexpjUH9Pl0ktn0oy73iTQQ=;
        b=dvVJ5osnYZfeHX+vNv5He+jERnpxxiU8cBaBi/EvYPQJPjvdhotw33wZ8LpwvflWEV
         AzGfo5Du+5xxb2rfFJR7JvbOwkD9hfePdm3U4mhGK/7O/OdtRjxkoZtuXdxJe8wNuorH
         +Drrvo9p7HtG8fT1xOcwRbOb9xpWJjpUthpDax4T7IMLDLqOdAWbB1iSb2detZszkXQY
         +DhukMk6uz6G4IsRIEiesDLa/kxw2d5XCRne2cuOHwMF298ParMoQo/flFsLFDXKmQLD
         SURDhyWkIGb4XCOPWLMsZr/UO1M1I5Z/il7jBDt4CsDKjoepqzadPMzGMyAhyPFa2RYn
         kwNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uBrEda264CqNMTYOMGS0nexpjUH9Pl0ktn0oy73iTQQ=;
        b=unPqIQGVH/d2b5/rrOV2uFT+u4uu5zmD732UakZbEIupfljWL33PB7wloSal5PNGZO
         6F+0WnWxXWslmCfk4JJAVkpTmYaHT1lIXt3wgzORHU38cE/smBeN9fwiej8vrBos/u8R
         JQknEaU9o66b3BfzlHNNZa8e+IR3cMt9rBudVeCBjY5IXb4g7YfAvINycNhxo9VzTHTW
         xDmx8TFYLiSVmFLzfx4sdZb7Kprh3v/VX70ScU/s3FeUfdxk6BHMI51pwnh3K5hyr0bK
         sOBCyGXeJbHDCcAt9l2+BrPPWvrBySIVaW+s/3S/V7GqRgEtKgyX6Pl78xc5mDVmHSqS
         kcQw==
X-Gm-Message-State: AHQUAubjgS8OuEOe1VS4z51a7r7RwGae2vtMfyvSq6ibJ1VnJRXY9fzJ
        ddPjRC3cTQ2zHsIo5Qx4ns7t80bgY6XwBe4wh9pprA==
X-Google-Smtp-Source: AHgI3IahV4OmPcigrKpWwYcnR6p27RifYaIvff/zCE0UzwetuDR1lgFSs4MRjksglvfENytNw9F/oBWqbGbDHB/qteM=
X-Received: by 2002:a24:d06:: with SMTP id 6mr6982863itx.104.1550270274657;
 Fri, 15 Feb 2019 14:37:54 -0800 (PST)
MIME-Version: 1.0
References: <20190214204433.155715-1-dianders@chromium.org>
 <4238ceb7-d286-9ef9-39b6-b2e0571f2981@arm.com> <CAD=FV=WeBD0bqxWPZcV1dz5Sdn47Ap=FZU3Y+YPbxsVCQEUcLQ@mail.gmail.com>
In-Reply-To: <CAD=FV=WeBD0bqxWPZcV1dz5Sdn47Ap=FZU3Y+YPbxsVCQEUcLQ@mail.gmail.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Fri, 15 Feb 2019 17:37:41 -0500
Message-ID: <CAF6AEGsGc8g--3W_xpR8VUt778WR19v_HOemhd7Jv=f4QBqVgw@mail.gmail.com>
Subject: Re: [PATCH] iommu/arm-smmu: Allow disabling bypass via kernel config
To:     Doug Anderson <dianders@chromium.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Evan Green <evgreen@chromium.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 7:40 PM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Thu, Feb 14, 2019 at 1:32 PM Robin Murphy <robin.murphy@arm.com> wrote:
> >
> > Hi Doug,
> >
> > On 2019-02-14 8:44 pm, Douglas Anderson wrote:
> > > Right now the only way to disable the iommu bypass for the ARM SMMU is
> > > with the kernel command line parameter 'arm-smmu.disable_bypass'.
> > >
> > > In general kernel command line parameters make sense for things that
> > > someone would like to tweak without rebuilding the kernel or for very
> > > basic communication between the bootloader and the kernel, but are
> > > awkward for other things.  Specifically:
> > > * Human parsing of the kernel command line can be difficult since it's
> > >    just a big runon space separated line of text.
> > > * If every bit of the system was configured via the kernel command
> > >    line the kernel command line would get very large and even more
> > >    unwieldly.
> > > * Typically there are not easy ways in build systems to adjust the
> > >    kernel command line for config-like options.
> > >
> > > Let's introduce a new config option that allows us to disable the
> > > iommu bypass without affecting the existing default nor the existing
> > > ability to adjust the configuration via kernel command line.
> >
> > I say let's just flip the default - for a while now it's been one of
> > those "oh yeah, we should probably do that" things that gets instantly
> > forgotten again, so some 3rd-party demand is plenty to convince me :)
> >
> > There are few reasons to allow unmatched stream bypass, and even fewer
> > good ones, so I'd be happy to shift the command-line burden over to the
> > esoteric cases at this point, and consider the config option in future
> > if anyone from that camp pops up and screams hard enough.
>
> Sure, I can submit that patch if we want.  I presume I'll get lots of
> screaming but I'm used to that.  ;-)
>
> ...specifically I found that when I turned on "disably bypass" on my
> board (sdm845-cheza, which is not yet upstream) that a bunch of things
> that used to work broke.  That's a good thing because all the things
> that broke need to be fixed properly (by adding the IOMMUs) but
> presumably my board is not special in relying on the old insecure
> behavior.

So one niggly bit, beyond the drivers that aren't but should be using
iommu, is the case where bootloader lights up the display.  We
actually still have a lot of work to do for this (in that clk and
genpd drivers need to be aware of handover, in addition to just
iommu)..  But I'd rather not make a hard problem harder just yet.

(it gets worse, afaict so far on the windows-arm laptops since in that
case uefi/edk is actually taking the iommu out of bypass and things go
badly when arm-smmu disables clks after probe..)

But I might recommend making the default a kconfig option for now, so
in the distro kernel case, where display driver is a kernel module,
you aren't making a hard problem harder.  For cases where bootloader
isn't enabling display, things are much easier, and I think we could
switch the default sooner.  But I fear for cases where bootloader is
enabling display it is a much harder problem :-(

BR,
-R


>
> I'm about to head on vacation for a week so I'm not sure I'll get to
> re-post before then.  If not I'll post this sometime after I get back
> unless someone beats me to it.
>
> -Doug
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu

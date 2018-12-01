Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB5CC04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 11:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8556620867
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 11:47:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hXxDtn0j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8556620867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbeLAW7T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 17:59:19 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:34581 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbeLAW7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 17:59:19 -0500
Received: by mail-it1-f193.google.com with SMTP id x124so4134836itd.1;
        Sat, 01 Dec 2018 03:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZVxizAUAqPWabFWIIbXwvH6JBd3ex0rWVrZqELRnNrc=;
        b=hXxDtn0j8PQH/DHY8sIPjg6G5wzgLP5f2O5IzxrID8rkzOntkOYdYJ9UnWGaC2WkI+
         +NNQz9gpB4U5pydyoseLPa7pQs+69qWVMGTclgayjL6CzoZo9Qdu0CxlBvBr+m/OYB+V
         nN4aT8iz24n6PSk3YXQuFvyeWbdY8etBPiFkBagJQ7WXIWIJEB877WopNK00ZcX3A31T
         vf3QW5Lfm1EIZTKrGyJlR7YayUCkxO4hbBQ2YNhjrQng4xx6cee5Xvz5Em5yGFMCioOk
         VnXiQCftH9vWKXHxohr27gXoUcdQs+Iwho7/BddlvUDxy23MspjiIOwl9e5XwKsEcnuk
         t01Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZVxizAUAqPWabFWIIbXwvH6JBd3ex0rWVrZqELRnNrc=;
        b=GyWp+ZEYS4/IqcQvlj8mLFkd3zi9xrE965blmo6Cm/KaIBEgNtlO35DMcpF0lIwnyt
         6GiWRn6JWtmpnHhi1OfxWBAm+rPSYUabYf+8I4GWCiAsAoVk1FqvsdJ4M4NZTnwlm1Co
         30je4RK6vaezArSf/avTRcM5v0Mj04r+Dz6JWBf2d1pQGSGCssgqKUiBLhA9XRALQWid
         0aGGfRWxVUZnC9WrvRikBEQPIijVF3qR/ug544N1iy0lycKz1psSN3k9omdsu/D1tpXD
         EDtqAo6wIFpba84FSej/D1zs+UVNyt1wdm0Xe35lGbjJU54f8n9h1hlZDOOXDV7eMFGM
         VU6Q==
X-Gm-Message-State: AA+aEWYp5/8xwkrerwSRP3+ZakEJKAn7B1Ip4/gyz+7UhpuIk4qUhPNQ
        +KGYQFzboEWbi4t5qx4js6lVOussHJMpOoDuL1s=
X-Google-Smtp-Source: AFSGD/Ut9Tt+tHDE4+IZSYwQ4i14KNlyGsxNFRK3sDGfT4y5MUBbx+XXxWZiooDo0yLITjjI3EleiPysp2m8xHH48vY=
X-Received: by 2002:a24:d84:: with SMTP id 126-v6mr2049147itx.163.1543664816950;
 Sat, 01 Dec 2018 03:46:56 -0800 (PST)
MIME-Version: 1.0
References: <20181129140315.28476-1-vivek.gautam@codeaurora.org>
 <20181129141429.GA22638@lst.de> <CAF6AEGvsFbXGkC+=4oq1xXnoC2EVX2J0k-GqShefcek1=uw4Lw@mail.gmail.com>
 <CAF6AEGu65Vvzpy6K7eF+Kk4YdYBPEKFX5ct8GxG0pw-KNwM5eA@mail.gmail.com>
 <20181129155418.GB26537@lst.de> <CAF6AEGufdp5jRtUZ_+VRQg3ZXH36hNHvbWZQeJDArp8N5SZ3Lg@mail.gmail.com>
 <20181129194029.GE17663@jcrouse-lnx.qualcomm.com> <CAAFQd5D139pNx9aEpO8745R4kfVYCBDyqyJNR_HDDXvKt7NZjw@mail.gmail.com>
 <06747338-b0fb-eef6-634a-0641e81ed3c1@arm.com> <CAAFQd5CEXZU5x+Fi5kRHZFfBwPkUbpo=-UBTARiaAoLqV-tMww@mail.gmail.com>
 <CAAFQd5DMgGDPcK=4DktfC7T9O0MrU1VBqJqR+6VYpOh_DdEXUg@mail.gmail.com>
In-Reply-To: <CAAFQd5DMgGDPcK=4DktfC7T9O0MrU1VBqJqR+6VYpOh_DdEXUg@mail.gmail.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Sat, 1 Dec 2018 06:46:44 -0500
Message-ID: <CAF6AEGujyP78PjOMwTmdHcJKpsrgmRGage=pFniad98peMBrDw@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] drm: msm: Replace dma_map_sg with dma_sync_sg*
To:     Tomasz Figa <tfiga@chromium.org>
Cc:     hch@lst.de, Robin Murphy <robin.murphy@arm.com>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        Archit Taneja <architt@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Sean Paul <seanpaul@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 9:05 PM Tomasz Figa <tfiga@chromium.org> wrote:
>
> On Thu, Nov 29, 2018 at 4:23 PM Tomasz Figa <tfiga@chromium.org> wrote:
> >
> > On Thu, Nov 29, 2018 at 12:03 PM Robin Murphy <robin.murphy@arm.com> wrote:
> > >
> > > On 29/11/2018 19:57, Tomasz Figa wrote:
> > > > On Thu, Nov 29, 2018 at 11:40 AM Jordan Crouse <jcrouse@codeaurora.org> wrote:
> > > >>
> > > >> On Thu, Nov 29, 2018 at 01:48:15PM -0500, Rob Clark wrote:
> > > >>> On Thu, Nov 29, 2018 at 10:54 AM Christoph Hellwig <hch@lst.de> wrote:
> > > >>>>
> > > >>>> On Thu, Nov 29, 2018 at 09:42:50AM -0500, Rob Clark wrote:
> > > >>>>> Maybe the thing we need to do is just implement a blacklist of
> > > >>>>> compatible strings for devices which should skip the automatic
> > > >>>>> iommu/dma hookup.  Maybe a bit ugly, but it would also solve a problem
> > > >>>>> preventing us from enabling per-process pagetables for a5xx (where we
> > > >>>>> need to control the domain/context-bank that is allocated by the dma
> > > >>>>> api).
> > > >>>>
> > > >>>> You can detach from the dma map attachment using arm_iommu_detach_device,
> > > >>>> which a few drm drivers do, but I don't think this is the problem.
> > > >>>
> > > >>> I think even with detach, we wouldn't end up with the context-bank
> > > >>> that the gpu firmware was hard-coded to expect, and so it would
> > > >>> overwrite the incorrect page table address register.  (I could be
> > > >>> mis-remembering that, Jordan spent more time looking at that.  But it
> > > >>> was something along those lines.)
> > > >>
> > > >> Right - basically the DMA domain steals context bank 0 and the GPU is hard coded
> > > >> to use that context bank for pagetable switching.
> > > >>
> > > >> I believe the Tegra guys also had a similar problem with a hard coded context
> > > >> bank.
> > >
> > > AIUI, they don't need a specific hardware context, they just need to
> > > know which one they're actually using, which the domain abstraction hides.
> > >
> > > > Wait, if we detach the GPU/display struct device from the default
> > > > domain and attach it to a newly allocated domain, wouldn't the newly
> > > > allocated domain use the context bank we need? Note that we're already
> > >
> > > The arm-smmu driver doesn't, but there's no fundamental reason it
> > > couldn't. That should just need code to refcount domain users and
> > > release hardware contexts for domains with no devices currently attached.
> > >
> > > Robin.
> > >
> > > > doing that, except that we're doing it behind the back of the DMA
> > > > mapping subsystem, so that it keeps using the IOMMU version of the DMA
> > > > ops for the device and doing any mapping operations on the default
> > > > domain. If we ask the DMA mapping to detach, wouldn't it essentially
> > > > solve the problem?
> >
> > Thanks Robin.
> >
> > Still, my point is that the MSM DRM driver attaches the GPU struct
> > device to a new domain it allocates using iommu_domain_alloc() and it
> > seems to work fine, so I believe it's not the problem we're looking
> > into with this patch.
>
> Could we just make the MSM DRM call arch_teardown_dma_ops() and then
> arch_setup_dma_ops() with the `iommu` argument set to NULL and be done
> with it?

I don't think those are exported to modules?

I have actually a simpler patch, that adds a small blacklist to check
in of_dma_configure() before calling arch_setup_dma_ops(), which can
replace this patch.  It also solves the problem of dma api allocating
the context bank that he gpu wants to use for context-switching, and
should be a simple thing to backport to stable branches.

I was just spending some time trying to figure out what changed
recently to start causing dma_map_sg() to opps on boot for us, so I
could write a more detailed commit msg.

BR,
-R

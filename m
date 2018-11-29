Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13BCDC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 09:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0F0C20868
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 09:43:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="EeclLJjE";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QGO4ht3O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0F0C20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbeK2UsY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 15:48:24 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:54492 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbeK2UsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 15:48:24 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4462660B26; Thu, 29 Nov 2018 09:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543484618;
        bh=wGkReiexBdkdhi11R7G+hz5+EY9Tgpx9wbosTVukN5k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EeclLJjEw6L2Md3fAPElVzJ0oQ2ubn1S5DWED4LAiY0vXH7ziXATg/NX7TJctnF+3
         sGphfuOICkNE1+lT4L+SsdrOLtrtMvX9yUTrCxEhcy7mTXe54N4LH2yaJ3XDkX4MUV
         2nu7LS6qK4mkPWFVLGY5YlBlClLL/RSUbIDIs2BI=
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 75B84602FE;
        Thu, 29 Nov 2018 09:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543484617;
        bh=wGkReiexBdkdhi11R7G+hz5+EY9Tgpx9wbosTVukN5k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QGO4ht3OfNCeyFg2xKl4QiSjnourFtze0jAg2tEMXHwXPr1CUAuuiGfBA0oIjYAl/
         m6kDGFzWv9AnxGj6pVg+TJuW4+BmEbq4Ur1+e9l3p3v4LB+H+qnFd3aNeSszYWP6df
         DYIybFVdZN/oWXgvuh/rOXBhKa3H0vayKHuBk0d4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 75B84602FE
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Received: by mail-qt1-f174.google.com with SMTP id e5so1202446qtr.12;
        Thu, 29 Nov 2018 01:43:37 -0800 (PST)
X-Gm-Message-State: AA+aEWbfRbgepDW/DWVBHSxusydpx076ACVxnytFxG67Ok7C9pbbxCt4
        ELI2bw13vpkpdfadTAqN1zu/LPzn4iCI3dhWIZE=
X-Google-Smtp-Source: AFSGD/WjsmwS6jl9BuApqgcfsJcoPLsHL7uvORpevfjihGA5ugTXfyKtqFfAEBKQfGnBm9Bpcoy4oQUwQegoVklEfy4=
X-Received: by 2002:aed:3746:: with SMTP id i64mr609626qtb.307.1543484616736;
 Thu, 29 Nov 2018 01:43:36 -0800 (PST)
MIME-Version: 1.0
References: <20181126213710.3084-1-vivek.gautam@codeaurora.org> <CAAFQd5Agy-hHsPPweMq-EvpgvnUrSFyG-KTm6HfmL=ac738xFw@mail.gmail.com>
In-Reply-To: <CAAFQd5Agy-hHsPPweMq-EvpgvnUrSFyG-KTm6HfmL=ac738xFw@mail.gmail.com>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Date:   Thu, 29 Nov 2018 15:13:25 +0530
X-Gmail-Original-Message-ID: <CAFp+6iGNw7tjFLf-i7KM3agqgJPhsWGK2Ga=wAEU+_EfCJO1Cw@mail.gmail.com>
Message-ID: <CAFp+6iGNw7tjFLf-i7KM3agqgJPhsWGK2Ga=wAEU+_EfCJO1Cw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] drm: msm: Replace dma_map_sg with dma_sync_sg*
To:     Tomasz Figa <tfiga@chromium.org>
Cc:     David Airlie <airlied@linux.ie>, Rob Clark <robdclark@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Sean Paul <seanpaul@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomasz,

On Wed, Nov 28, 2018 at 8:39 AM Tomasz Figa <tfiga@chromium.org> wrote:
>
> Hi Vivek,
>
> On Tue, Nov 27, 2018 at 6:37 AM Vivek Gautam
> <vivek.gautam@codeaurora.org> wrote:
> >
> > dma_map_sg() expects a DMA domain. However, the drm devices
> > have been traditionally using unmanaged iommu domain which
> > is non-dma type. Using dma mapping APIs with that domain is bad.
> >
> > Replace dma_map_sg() calls with dma_sync_sg_for_device{|cpu}()
> > to do the cache maintenance.
> >
> > Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> > Suggested-by: Tomasz Figa <tfiga@chromium.org>
> > Cc: Rob Clark <robdclark@gmail.com>
> > Cc: Jordan Crouse <jcrouse@codeaurora.org>
> > Cc: Sean Paul <seanpaul@chromium.org>
> > ---
> >
> > Changes since v1:
> >  - Addressed Jordan's and Tomasz's comments for
> >    - moving sg dma addresses preparation out of the coditional
> >      check to the main path so we do it irrespective of whether
> >      the buffer is cached or uncached.
> >    - Enhance the comment to explain this dma addresses prepartion.
> >
>
> Thanks for the patch. Some comments inline.
>
> >  drivers/gpu/drm/msm/msm_gem.c | 31 ++++++++++++++++++++++---------
> >  1 file changed, 22 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
> > index 00c795ced02c..1811ac23a31c 100644
> > --- a/drivers/gpu/drm/msm/msm_gem.c
> > +++ b/drivers/gpu/drm/msm/msm_gem.c
> > @@ -81,6 +81,8 @@ static struct page **get_pages(struct drm_gem_object *obj)
> >                 struct drm_device *dev = obj->dev;
> >                 struct page **p;
> >                 int npages = obj->size >> PAGE_SHIFT;
> > +               struct scatterlist *s;
> > +               int i;
> >
> >                 if (use_pages(obj))
> >                         p = drm_gem_get_pages(obj);
> > @@ -104,12 +106,21 @@ static struct page **get_pages(struct drm_gem_object *obj)
> >                         return ptr;
> >                 }
> >
> > -               /* For non-cached buffers, ensure the new pages are clean
> > +               /*
> > +                * dma_sync_sg_*() flush the physical pages, so point
> > +                * sg->dma_address to the physical ones for the right behavior.
>
> The two halves of the sequence don't really relate to each other. An
> sglist has the `page` field for the purpose of pointing to physical
> pages. The `dma_address` field is for DMA addresses, which are not
> equivalent to physical addresses. I'd rewrite it like this;

I guess I was lenient in using the physical pages and dma address words.

>
> /*
>  * Some implementations of the DMA mapping ops expect
>  * physical addresses of the pages to be stored as DMA
>  * addresses of the sglist entries. To work around it,
>  * set them here explicitly.
>  */

Will update as suggested.

> > +                */
> > +               for_each_sg(msm_obj->sgt->sgl, s, msm_obj->sgt->nents, i)
> > +                       sg_dma_address(s) = sg_phys(s);
> > +
> > +               /*
> > +                * For non-cached buffers, ensure the new pages are clean
> >                  * because display controller, GPU, etc. are not coherent:
> >                  */
> > -               if (msm_obj->flags & (MSM_BO_WC|MSM_BO_UNCACHED))
> > -                       dma_map_sg(dev->dev, msm_obj->sgt->sgl,
> > -                                       msm_obj->sgt->nents, DMA_BIDIRECTIONAL);
> > +               if (msm_obj->flags & (MSM_BO_WC | MSM_BO_UNCACHED))
> > +                       dma_sync_sg_for_device(dev->dev, msm_obj->sgt->sgl,
> > +                                              msm_obj->sgt->nents,
> > +                                              DMA_TO_DEVICE);
>
> Why changing from DMA_BIDIRECTIONAL?

Yea, I went back and checked that we wanted to do this for both.
Will keep DMA_BIDIRECTIONAL intact.

>
> >         }
> >
> >         return msm_obj->pages;
> > @@ -133,14 +144,16 @@ static void put_pages(struct drm_gem_object *obj)
> >
> >         if (msm_obj->pages) {
> >                 if (msm_obj->sgt) {
> > -                       /* For non-cached buffers, ensure the new
> > +                       /*
> > +                        * For non-cached buffers, ensure the new
> >                          * pages are clean because display controller,
> >                          * GPU, etc. are not coherent:
> >                          */
> > -                       if (msm_obj->flags & (MSM_BO_WC|MSM_BO_UNCACHED))
> > -                               dma_unmap_sg(obj->dev->dev, msm_obj->sgt->sgl,
> > -                                            msm_obj->sgt->nents,
> > -                                            DMA_BIDIRECTIONAL);
> > +                       if (msm_obj->flags & (MSM_BO_WC | MSM_BO_UNCACHED))
> > +                               dma_sync_sg_for_cpu(obj->dev->dev,
> > +                                                   msm_obj->sgt->sgl,
> > +                                                   msm_obj->sgt->nents,
> > +                                                   DMA_FROM_DEVICE);
>
> Ditto.

Sure, will change this as well.

Thanks & Regards
Vivek

>
> Best regards,
> Tomasz



--
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

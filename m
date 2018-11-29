Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39F75C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0285820673
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:44:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="LNmgepoN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0285820673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388004AbeK3Btk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:49:40 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:43913 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387910AbeK3Bti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:49:38 -0500
Received: by mail-io1-f66.google.com with SMTP id g8so1730869iop.10
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 06:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xtP/0UQTRbEGOB413kDSGEnCVvA72PfoDC03K2Vf8hc=;
        b=LNmgepoNtkIqJ4emeW2Ee30TrKufeP64dVRIkTcBmc1aG6vC/eX5omP3q8ZLLwMsuQ
         8prre5DuDbWmT+FQC4H1GGg5KOdvFFrzAWPLjtoLYeV0hPZgZHqjfosFN8Dtur2v7wnA
         IDZQMS13TNrfshODKb/zvPUuTnHZtxRC2Mmd4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xtP/0UQTRbEGOB413kDSGEnCVvA72PfoDC03K2Vf8hc=;
        b=JImfJuVfJssphoTcI6Aizn9OKZh31E9V/DX5lF3Zu4V1Nc+PW6RpKeYLYZ8/8T+4AR
         FQcMJ1L58xxbkXhsF/d78a/mw4IMTHz15dfUUIN1FfsTOpDmQ6ncTJd8jEVaYq2oS+7G
         uXahLbE7+X5VyVC0PtXlogeG0kstz+TUDi7HLHuoN2Py3BhJ/RoHAwdc1tHyqek6pmzx
         Q8HTE1UU8rKl8WfSE3k04u6JpenGzlDNSYQE1u6oMtL3TjMF9l9PyFe0CuP4LWkv/xc1
         WhPcmipGO+IqZ/18oOpkFN/++afZRFAUz1NKuLVqllzooEX1TksSVRWu6CeS/UgsPwg8
         WGTw==
X-Gm-Message-State: AA+aEWa1kBSpbONZtrUJJ0DtLtY8YteFJDCa3osveByzoUJeRFYxWbAZ
        ey+2qQJDXpUW8l0RqbHyaViRXHfcZVA0pMmib+qvcg==
X-Google-Smtp-Source: AFSGD/VLG1mIzRbyHq4FR9izecMVvcnpv6Kv4tfDeIEdiTzAM3mGsSpsOZhwKkt3mvITpABuGY5+nyK0zsKrJOvKd0s=
X-Received: by 2002:a5d:959a:: with SMTP id a26mr1432213ioo.278.1543502642608;
 Thu, 29 Nov 2018 06:44:02 -0800 (PST)
MIME-Version: 1.0
References: <20181129140315.28476-1-vivek.gautam@codeaurora.org>
 <20181129141429.GA22638@lst.de> <CAF6AEGvsFbXGkC+=4oq1xXnoC2EVX2J0k-GqShefcek1=uw4Lw@mail.gmail.com>
In-Reply-To: <CAF6AEGvsFbXGkC+=4oq1xXnoC2EVX2J0k-GqShefcek1=uw4Lw@mail.gmail.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Thu, 29 Nov 2018 15:43:50 +0100
Message-ID: <CAKMK7uHOKtX2a12itSA0sDg=b77F+0vnLAdEvc_aNGRJTh85=Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] drm: msm: Replace dma_map_sg with dma_sync_sg*
To:     "Clark, Rob" <robdclark@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, Dave Airlie <airlied@linux.ie>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Sean Paul <seanpaul@chromium.org>, vivek.gautam@codeaurora.org,
        freedreno <freedreno@lists.freedesktop.org>,
        Robin Murphy <robin.murphy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 3:26 PM Rob Clark <robdclark@gmail.com> wrote:
>
> On Thu, Nov 29, 2018 at 9:14 AM Christoph Hellwig <hch@lst.de> wrote:
> >
> > On Thu, Nov 29, 2018 at 07:33:15PM +0530, Vivek Gautam wrote:
> > > dma_map_sg() expects a DMA domain. However, the drm devices
> > > have been traditionally using unmanaged iommu domain which
> > > is non-dma type. Using dma mapping APIs with that domain is bad.
> > >
> > > Replace dma_map_sg() calls with dma_sync_sg_for_device{|cpu}()
> > > to do the cache maintenance.
> >
> > As I told you before:  hell no.  If you spent the slightest amount of
> > actually trying to understand what you are doing here you'd know this
> > can't work.  Just turn on dma debugging and this will blow up in your
> > face.
>
> you can tone it down..  we weren't the ones who created the dma/iommu
> mess, we are just trying to find a way to work around it
>
> > Either you use the DMA API properly, that is you use it to map and
> > to sync, or you don't use it at all.  Mix and match between iommu
> > APIs and DMA APIs is simply not possible.
>
> I'd *love* nothing more to not use the dma api.. but on arm there is
> no other way to do cache maint.

Yeah we had patches to add manual cache management code to drm, so we
don't have to abuse the dma streaming api anymore. Got shouted down.
Abusing the dma streaming api also gets shouted down. It's a gpu, any
idea of these drivers actually being platform independent is out of
the window from the start anyway, so we're ok with tying this to
platforms.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch

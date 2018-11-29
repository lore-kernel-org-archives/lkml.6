Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A964BC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 686EB20863
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:09:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Oh275gsx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 686EB20863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730382AbeK3EPW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 23:15:22 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:44268 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728444AbeK3EPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 23:15:22 -0500
Received: by mail-io1-f66.google.com with SMTP id r200so2143212iod.11
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 09:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mX3m/T7ZX+mlVgtePqOj42Qe2cGFFbsZREFTxdeAi1o=;
        b=Oh275gsxoxffS1JgnRR6gNrfXnng7aLPXN0YpHc8HTxpBdiJWFIcvZxqCJ8gIhnVxZ
         /o8CuDrbyJGY31B1ootx0SFxGRY0srPTWiaRbDCuJboQNTHBb61qHafYkEykujSFK38B
         THKnXZNqz5B+6+9toZy/sFxKv3B26Dd+KIlEM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mX3m/T7ZX+mlVgtePqOj42Qe2cGFFbsZREFTxdeAi1o=;
        b=pemAuLMT6xGo571As4urWm32YtY4DXVOqfwGCuHw1k6xJiuuYwmScqlnAwlMDYTp/p
         wV+iBf8KtT+FpuQB8Xbr7+NLB8MVhKQnDDn7buM5993n1YOCdlfA1VoHH/zyqARqwmbz
         t1i7yGlASftJ0776vW2QqZ3u6+YKm58BmPFJRulrZP0ZHFqPpw8bIDnewJsnGPuVLtai
         UYIAKZR0OE9duPMiaXw/v0cfiaiUSdEuWROlhUB5WOj7LEPfAzx0kmda+9N53Dz/9Iej
         Fz0Ul1wtqnnlHydxse5oRbarKj5J2+XoxJRICEkNEyNc7WYPuFLdGrR47zk7u8Bo2XeC
         qYmg==
X-Gm-Message-State: AA+aEWY7ccPvcxk0+vuFy8HmO3vRngoYaoFXNeEx0oF9CWWt4rSaTwak
        Ue/YNYGof13/DWZDN80+lRx9B4VYsU4O1R2AKidMeg==
X-Google-Smtp-Source: AFSGD/VrXWkdTnD42gk1y3QQ64qC/Hm/yisMPc74MrONr+ki1tQNNzQQHlH2+nUuwvSzJnIZitSJmEPIfVPj3+M6CYM=
X-Received: by 2002:a6b:4001:: with SMTP id k1mr2057711ioa.34.1543511357463;
 Thu, 29 Nov 2018 09:09:17 -0800 (PST)
MIME-Version: 1.0
References: <20181129140315.28476-1-vivek.gautam@codeaurora.org>
 <20181129141429.GA22638@lst.de> <CAF6AEGvsFbXGkC+=4oq1xXnoC2EVX2J0k-GqShefcek1=uw4Lw@mail.gmail.com>
 <CAKMK7uHOKtX2a12itSA0sDg=b77F+0vnLAdEvc_aNGRJTh85=Q@mail.gmail.com>
 <20181129155758.GC26537@lst.de> <20181129162807.GL21184@phenom.ffwll.local> <20181129165715.GA27786@lst.de>
In-Reply-To: <20181129165715.GA27786@lst.de>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Thu, 29 Nov 2018 18:09:05 +0100
Message-ID: <CAKMK7uECLeTbEjG6=unWZSKakpiYkmBVbCEKKY2xv=vVjF-pBQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] drm: msm: Replace dma_map_sg with dma_sync_sg*
To:     Christoph Hellwig <hch@lst.de>
Cc:     "Clark, Rob" <robdclark@gmail.com>, Dave Airlie <airlied@linux.ie>,
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

On Thu, Nov 29, 2018 at 5:57 PM Christoph Hellwig <hch@lst.de> wrote:
> On Thu, Nov 29, 2018 at 05:28:07PM +0100, Daniel Vetter wrote:
> > Just spend a bit of time reading through the implementations already
> > merged. Is the struct device *dev parameter actually needed anywhere?
> > dma-api definitely needs it, because we need that to pick the right iommu.
> > But for cache management from what I've seen the target device doesn't
> > matter, all the target specific stuff will be handled by the iommu.
>
> It looks like only mips every uses the dev argument, and even there
> the function it passes dev to ignores it.  So it could probably be removed.
>
> >
> > Dropping the dev parameter would make this a perfect fit for coherency
> > management of buffers used by multiple devices. Right now there's all
> > kinds of nasty tricks for that use cases needed to avoid redundant
> > flushes.
>
> Note that one thing I'd like to avoid is exposing these funtions directly
> to drivers, as that will get us into all kinds of abuses.

What kind of abuse do you expect? It could very well be that gpu folks
call that "standard use case" ... At least on x86 with the i915 driver
we pretty much rely on architectural guarantees for how cache flushes
work very much. Down to userspace doing the cache flushing for
mappings the kernel has set up.

> So I'd much prefer if we could have iommu APIs wrapping these that are
> specific to actual uses cases that we understand well.
>
> As for the buffer sharing: at least for the DMA API side I want to
> move the current buffer sharing users away from dma_alloc_coherent
> (and coherent dma_alloc_attrs users) and the remapping done in there
> required for non-coherent architectures.  Instead I'd like to allocate
> plain old pages, and then just dma map them for each device separately,
> with DMA_ATTR_SKIP_CPU_SYNC passed for all but the first user to map
> or last user to unmap.  On the iommu side it could probably work
> similar.

I think this is what's often done. Except then there's also the issue
of how to get at the cma allocator if your device needs something
contiguous. There's a lot of that still going on in graphics/media.
-Daniel

> I have done some preliminary work on this, and want to get it into this
> merge window, but there is a few other bits I need to sort out first.
>
> > -Daniel
> > --
> > Daniel Vetter
> > Software Engineer, Intel Corporation
> > http://blog.ffwll.ch
> ---end quoted text---
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch

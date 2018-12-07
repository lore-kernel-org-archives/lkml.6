Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 815C7C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 14:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 462D720837
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 14:29:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VHa/vt64"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 462D720837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbeLGO36 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 09:29:58 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:50394 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbeLGO35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 09:29:57 -0500
Received: by mail-it1-f194.google.com with SMTP id z7so7133131iti.0;
        Fri, 07 Dec 2018 06:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6v3WjYJG9mYjcC6A9EOj/Qpf1QJj0f27HhwHUQ5HsQc=;
        b=VHa/vt64XnETUvGd3nvP+bfX/+V0NM8FJiCmEOttH8DBNM/FRvsAct2WyCbqeTNo4y
         LeZjtLfEcBKOIHEr0Q477fWKu1XHfcm7GCRkgOn/FXNLsR3yNATPp870/AJAUXxgTpb2
         2UTMqDS9g00dhlp1UZLTlojCcAQz7hLeNre9i+hDOfuPpuOTmmHtY6bSq3gyyGW8F4B/
         1hXyaXI6+JxLtfMzMNyI1RzYEUPon1nArUE7kdhLAveEMf/ARLzKfVjqmCxouZGPhDji
         a9oXJ3hnDSwtwkJLdmM9pCfsxAWb0DMowWNDlUMem+vBLayM0uVEnv3UuteBvuGL/q6Y
         +Nrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6v3WjYJG9mYjcC6A9EOj/Qpf1QJj0f27HhwHUQ5HsQc=;
        b=sjqepA8x+TG4bXk6F57YyUQ6NWYW4bJz/kXPkvBUI347vjZxK8PiGkbiwKVWyng/L7
         QK3XQKHSuFYQFiw98Ln10b0ev6c5YNROM898lRdq/ZlIQEK6J/GvbkaobIZYctBfOouF
         leIXRdRwOjietHGDP4iphAq7UmrrglrHxzNjdZ3oPnYPKWWGUal3sQSy3bdzjdpukqBv
         koOyjVlPLEWavozNHgobD9HrH6ZpeVSkVONmJ15NUytmrAeTl2HxPcBn4BLteASXiPNj
         e6Kei1/lGdLey75TEgPs2QqxJc1HODFIJTjIwTyIsGDSLxAX3wdeUpSm55RE08qgUka/
         hDcQ==
X-Gm-Message-State: AA+aEWYiOKq+uvduwpBI40Om1xqa9lK+2ODXaGUzoB1bfbRIVBtOduRy
        Jx758+zPlMlJXvnZaKnrniNToET6p9xH4CUB3Z0=
X-Google-Smtp-Source: AFSGD/XfRIBqixgjQwy83jx2sTFYQ/b5gddMhO8vy5ixj1ndRHHymH6cL3d1SIC6RJyZFDKCvL2o58egeKXIxcsm4Lw=
X-Received: by 2002:a24:3dd5:: with SMTP id n204mr2423765itn.104.1544192995402;
 Fri, 07 Dec 2018 06:29:55 -0800 (PST)
MIME-Version: 1.0
References: <20181129140315.28476-1-vivek.gautam@codeaurora.org>
 <20181129141429.GA22638@lst.de> <CAF6AEGvsFbXGkC+=4oq1xXnoC2EVX2J0k-GqShefcek1=uw4Lw@mail.gmail.com>
 <CAKMK7uHOKtX2a12itSA0sDg=b77F+0vnLAdEvc_aNGRJTh85=Q@mail.gmail.com>
 <20181129155758.GC26537@lst.de> <20181129162807.GL21184@phenom.ffwll.local>
 <20181129165715.GA27786@lst.de> <CAKMK7uECLeTbEjG6=unWZSKakpiYkmBVbCEKKY2xv=vVjF-pBQ@mail.gmail.com>
 <20181129183334.GB30281@lst.de> <20181130094604.GV21184@phenom.ffwll.local> <20181207013841.GA4530@lst.de>
In-Reply-To: <20181207013841.GA4530@lst.de>
From:   Rob Clark <robdclark@gmail.com>
Date:   Fri, 7 Dec 2018 09:29:42 -0500
Message-ID: <CAF6AEGut7Ly3SNNHez9JTC31ORDKVS57054FshpXFM-bMygFtg@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] drm: msm: Replace dma_map_sg with dma_sync_sg*
To:     hch@lst.de
Cc:     David Airlie <airlied@linux.ie>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Sean Paul <seanpaul@chromium.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        Robin Murphy <robin.murphy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 6, 2018 at 8:38 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Fri, Nov 30, 2018 at 10:46:04AM +0100, Daniel Vetter wrote:
> > > Being able to dip into CMA and maybe iommu coalescing if we want to
> > > get fancy is indeed the only reason for this API.  If we just wanted
> > > to map pages we could already do that now with just a little bit
> > > of boilerplate code (and quite a few drivers do - just adding this
> > > new API will remove tons of code).
> >
> > Sounds like the future is very bright indeed \o/
>
> So, I spent some time with this and instead of a new API I think
> it makes sure we have DMA_ATTR_NON_CONSISTENT consistently available
> and with well defined semantics, that is virt_to_page on the return
> value works, it is contiguos and we can use dma_sync_single_for_cpu
> and dma_sync_single_for_device for ownership tranfers.
>
> Can you graphics folks check if this:
>
>     http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dma-noncoherent-allocator
>
> is something to work with?  Especially to get rid of the horrible
> dma_get_sgtable hacks?

I'm not sure I really have strong opinion about this.  For some of the
display-only SoC drm drivers which use the CMA helpers, it might be
useful.

For the drm drivers for real GPUs, we aren't really using the dma api
to allocate in the first place.  (And the direction is towards more
support for userptr allocations)

BR,
-R

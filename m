Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB35EC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 17:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E1192081B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 17:23:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SCvzvdVO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730381AbfBFRX1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 12:23:27 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35441 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727467AbfBFRX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 12:23:27 -0500
Received: by mail-ed1-f67.google.com with SMTP id b17so2411413eds.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 09:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JvcKwIWlny3ttJZ1xLAWt497mnvC18dJy450P90yM2w=;
        b=SCvzvdVOhvlAy67voL7FYAvyuejhJl4vSCGdpxJlOMsY+8wabGiSJZA1uUaEPZSzJz
         6TsIIgrJRKv/aNHU8vW8J4FSe1X/Xw6iDZGBqG5c9rNEd3BJoQQdQNmcLBMKscJmUJ7b
         4Z10Md+g3Fr53D5TOrI3G/vYYXS+OP3EFKsm48qVNtslHNlAiWabEvqagd43sg8AF2q3
         L+kGfJBklnwUrC2dsnIJdEFK79ARloXzeMalaaUpT1yxSYeZtxYpLj6STdegY+D3w6wa
         0AbFdVPqaCQaS+PpizEmsAudri2P7nzy7+k9j/2bfYw1FnGwmkdaoZAXYxcVWAk7nYqB
         TLZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JvcKwIWlny3ttJZ1xLAWt497mnvC18dJy450P90yM2w=;
        b=bCX+WmXJoh+2FXHOi76xZk2SbjPiyPuR/+fTlhSUc/qGVXawyHdLkpfeto3qZqkida
         my8jbWHw/TWkP4JiYNn99pFV3gPrljHwL8/fnx/B0UX6viCG14A9sNIMtqwNUZ7vY53u
         VUfSdpicE52nilZg09Zl6lvK8aDSegcc35pnR5UPpMmDQqG/naJ1TDcv7J2VUxOoFrFu
         VgO8eqbJeFyrHmRyuPl5IZqUWHtvLCDMB6/oMR8GnGkiz5qbBqcKWX96yQOeetui03Ij
         8jwe81YIJi7QWl/w2He8G8gOcmnWMnXv1RoPqmRZEyypKT8Zz100sXprvMhu2Yli+NnZ
         uOoA==
X-Gm-Message-State: AHQUAuaPNYYv89jzEaIBdJrNV3NS5Sfu8CcitJanVzMxVzMwxeFzfmdJ
        56fvNQDOqOe/2iK60nVNyGMburHrBw3qpz+cYmI4Ew==
X-Google-Smtp-Source: AHgI3IZ2bjGbksxVz6NccXNkBWqH4dgXoKknycBdJ4EIDM0+e5f+SVWZ2Q00jPjLBtxS5vmnti5hpj28QUnju70CS7U=
X-Received: by 2002:a17:906:b38a:: with SMTP id o10mr3789264ejz.217.1549473804836;
 Wed, 06 Feb 2019 09:23:24 -0800 (PST)
MIME-Version: 1.0
References: <20190124120658.30288-1-ard.biesheuvel@linaro.org>
 <3cca35a9-c71c-a100-b29d-31ba0d1d10b1@amd.com> <CAKv+Gu9OG3O4+4F2nioaQ-3U-1kwRBr5KVj-1gD1ZEsUx_Ud5A@mail.gmail.com>
 <CADnq5_PETD6umm9Df7OZ9BdaV5MZutmhN+HTAnVkcRLg5=TNWw@mail.gmail.com>
 <CAKv+Gu-Yk1iEe+cF30ee7R+hcrke9XH9MdTeERA2P-0s2QpaLw@mail.gmail.com>
 <961e758d-b0a0-8f6c-a8fa-c3047e058706@gmail.com> <CAKv+Gu_faPAf+0NBTNM03EUH4-_0vWbPfDQneshps5vbaU4R_Q@mail.gmail.com>
In-Reply-To: <CAKv+Gu_faPAf+0NBTNM03EUH4-_0vWbPfDQneshps5vbaU4R_Q@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 6 Feb 2019 17:23:13 +0000
Message-ID: <CAKv+Gu-4=1r8X8BUvRjcTwgxj=sZpZLyY3ABBZyzh-RsSm1eXg@mail.gmail.com>
Subject: Re: [PATCH] drm: enable uncached DMA optimization for ARM and arm64
To:     "Koenig, Christian" <christian.koenig@amd.com>
Cc:     Alex Deucher <alexdeucher@gmail.com>,
        "Daenzer, Michel" <Michel.Daenzer@amd.com>,
        Carsten Haitzler <Carsten.Haitzler@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "Zhang, Jerry" <Jerry.Zhang@amd.com>,
        Christoph Hellwig <hch@infradead.org>,
        David Airlie <airlied@linux.ie>,
        "Huang, Ray" <Ray.Huang@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Will Deacon <will.deacon@arm.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        Sean Paul <sean@poorly.run>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Robin Murphy <robin.murphy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Jan 2019 at 11:35, Ard Biesheuvel <ard.biesheuvel@linaro.org> wr=
ote:
>
> On Fri, 25 Jan 2019 at 12:30, Christian K=C3=B6nig
> <ckoenig.leichtzumerken@gmail.com> wrote:
> >
> > Am 25.01.19 um 09:43 schrieb Ard Biesheuvel:
> > > On Thu, 24 Jan 2019 at 15:01, Alex Deucher <alexdeucher@gmail.com> wr=
ote:
> > >> On Thu, Jan 24, 2019 at 9:00 AM Ard Biesheuvel
> > >> <ard.biesheuvel@linaro.org> wrote:
> > >>> On Thu, 24 Jan 2019 at 13:31, Koenig, Christian
> > >>> <Christian.Koenig@amd.com> wrote:
> > >>>> Am 24.01.19 um 13:06 schrieb Ard Biesheuvel:
> > >>>>> The DRM driver stack is designed to work with cache coherent devi=
ces
> > >>>>> only, but permits an optimization to be enabled in some cases, wh=
ere
> > >>>>> for some buffers, both the CPU and the GPU use uncached mappings,
> > >>>>> removing the need for DMA snooping and allocation in the CPU cach=
es.
> > >>>>>
> > >>>>> The use of uncached GPU mappings relies on the correct implementa=
tion
> > >>>>> of the PCIe NoSnoop TLP attribute by the platform, otherwise the =
GPU
> > >>>>> will use cached mappings nonetheless. On x86 platforms, this does=
 not
> > >>>>> seem to matter, as uncached CPU mappings will snoop the caches in=
 any
> > >>>>> case. However, on ARM and arm64, enabling this optimization on a
> > >>>>> platform where NoSnoop is ignored results in loss of coherency, w=
hich
> > >>>>> breaks correct operation of the device. Since we have no way of
> > >>>>> detecting whether NoSnoop works or not, just disable this
> > >>>>> optimization entirely for ARM and arm64.
> > >>>>>
> > >>>>> Cc: Christian Koenig <christian.koenig@amd.com>
> > >>>>> Cc: Alex Deucher <alexander.deucher@amd.com>
> > >>>>> Cc: David Zhou <David1.Zhou@amd.com>
> > >>>>> Cc: Huang Rui <ray.huang@amd.com>
> > >>>>> Cc: Junwei Zhang <Jerry.Zhang@amd.com>
> > >>>>> Cc: Michel Daenzer <michel.daenzer@amd.com>
> > >>>>> Cc: David Airlie <airlied@linux.ie>
> > >>>>> Cc: Daniel Vetter <daniel@ffwll.ch>
> > >>>>> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > >>>>> Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> > >>>>> Cc: Sean Paul <sean@poorly.run>
> > >>>>> Cc: Michael Ellerman <mpe@ellerman.id.au>
> > >>>>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > >>>>> Cc: Will Deacon <will.deacon@arm.com>
> > >>>>> Cc: Christoph Hellwig <hch@infradead.org>
> > >>>>> Cc: Robin Murphy <robin.murphy@arm.com>
> > >>>>> Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
> > >>>>> Cc: dri-devel <dri-devel@lists.freedesktop.org>
> > >>>>> Reported-by: Carsten Haitzler <Carsten.Haitzler@arm.com>
> > >>>>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > >>>> The subject line should probably read "disable uncached...".
> > >>>>
> > >>> Ugh, of course ...
> > >>>
> > >>>> With that fixed the patch is Reviewed-by: Christian K=C3=B6nig
> > >>>> <christian.koenig@amd.com>.
> > >>>>
> > >> Same:
> > >> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> > >>
> > > Thanks all
> > >
> > > Should I resend the patch with the subject corrected?
> >
> > I will update the subject line and push it upstream through
> > drm-misc-next if nobody objects.
> >
>
> Wonderful, thanks.

Hi Christian,

Are you still planning to merge this for v5.1?

Thanks,
Ard.

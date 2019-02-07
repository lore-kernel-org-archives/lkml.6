Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ECF4C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 15:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F039D20863
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 15:33:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pRtYtlJg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbfBGPdx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 10:33:53 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52412 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbfBGPdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 10:33:52 -0500
Received: by mail-wm1-f66.google.com with SMTP id m1so301554wml.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 07:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NtuwhjcSa9WVQeIYC9YHkLkUJWc3nvD6vkG9KV6JWdY=;
        b=pRtYtlJgtzYwAmX0OMJSPoXh1rSAMRchSEO52oFCMher2tyZO7fEQ8Dnaf/XY64gT9
         Oxfd12yOrNyFC4LKNqi+VljU4XtPdWVqI560CPpyhXV2PfK23yBAdUJpL0QTLQxGuLUy
         2y5+VDdZ8cmtc/ZOgxNXtypsZ0hEkWo5NzRE0/VUe3tiuAbYStRW5vnyXAXscbKI+iBl
         14zoKXHWWyc4db/xBQKmchFivYoGAm5KxAwpZusoLqFW0usotQI8uGL/uT+/aT7nkgil
         bzp9gwbyZpZ8zNorFcjDwo9psu39He2ZFwi2N8sniGALFYPsm/HnLniiZvuB3Fz6gTpq
         eO+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NtuwhjcSa9WVQeIYC9YHkLkUJWc3nvD6vkG9KV6JWdY=;
        b=eGzc1j5gHLspTLDL/szfJ6HIwarnzp0D9fV3J+/zCkfdh61JNFeWxdK1JhuLQ19leZ
         fmuGqky8/vugOPCrorY9cRFqtRopY4FAYeRFlYdW+DMrcD6LZ6Aenq2ZUT7LHJjzWy90
         agvYXIWpePR/rA2KsTZFTgf5ytsYSZTwCEEwwdFvOdBCgWwpwPzzEuan4WwEe9jpXnDz
         u18DYwRgPlfzfQhIUULNLOYVsbrQmemobElmAN2Meh0YK1wziVmLu8uoUMkbVphnWejj
         qKmVXFR2b+wLHPfxukDd7GOnBmkJQmgKR6Bpy9Iiqo62Gx7q5kicamxN6VegvTRVZmz/
         e7eg==
X-Gm-Message-State: AHQUAuaTrGxF+G7DCPPaW9joKKUKFyDju57wH7HVAV0kWlgnoJWXS6td
        v0RHTpx/+6VPjwqn0GbNET1LjYkeyCwQrjmvook=
X-Google-Smtp-Source: AHgI3IYV6uDpkiX/nqZkwTgLnsJSdxh6XdGYoFmQESC1hqUJhvkNLrxL3/tA7F52i0Pw0MWyEQNx5QoimoF0bW1LOac=
X-Received: by 2002:a1c:9e4a:: with SMTP id h71mr8129497wme.82.1549553629575;
 Thu, 07 Feb 2019 07:33:49 -0800 (PST)
MIME-Version: 1.0
References: <20190124120658.30288-1-ard.biesheuvel@linaro.org>
 <3cca35a9-c71c-a100-b29d-31ba0d1d10b1@amd.com> <CAKv+Gu9OG3O4+4F2nioaQ-3U-1kwRBr5KVj-1gD1ZEsUx_Ud5A@mail.gmail.com>
 <CADnq5_PETD6umm9Df7OZ9BdaV5MZutmhN+HTAnVkcRLg5=TNWw@mail.gmail.com>
 <CAKv+Gu-Yk1iEe+cF30ee7R+hcrke9XH9MdTeERA2P-0s2QpaLw@mail.gmail.com>
 <961e758d-b0a0-8f6c-a8fa-c3047e058706@gmail.com> <CAKv+Gu_faPAf+0NBTNM03EUH4-_0vWbPfDQneshps5vbaU4R_Q@mail.gmail.com>
 <CAKv+Gu-4=1r8X8BUvRjcTwgxj=sZpZLyY3ABBZyzh-RsSm1eXg@mail.gmail.com>
 <f6bdd647-722b-8145-92d4-3f6c52f8a74c@gmail.com> <CAKv+Gu8oCAcnoo6=UikRGJQHW63JmY21y1qZteaNmh_F7HnOEQ@mail.gmail.com>
In-Reply-To: <CAKv+Gu8oCAcnoo6=UikRGJQHW63JmY21y1qZteaNmh_F7HnOEQ@mail.gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 7 Feb 2019 10:33:37 -0500
Message-ID: <CADnq5_NnY2Ktw0sLGnp7x3kc6NpwPnznHUzRK=5X2n6p1843Yg@mail.gmail.com>
Subject: Re: [PATCH] drm: enable uncached DMA optimization for ARM and arm64
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     "Koenig, Christian" <christian.koenig@amd.com>,
        Will Deacon <will.deacon@arm.com>,
        Carsten Haitzler <Carsten.Haitzler@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        David Airlie <airlied@linux.ie>,
        "Daenzer, Michel" <Michel.Daenzer@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Zhang, Jerry" <Jerry.Zhang@amd.com>,
        "Huang, Ray" <Ray.Huang@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
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

On Thu, Feb 7, 2019 at 10:20 AM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
>
> On Wed, 6 Feb 2019 at 19:38, Christian K=C3=B6nig
> <ckoenig.leichtzumerken@gmail.com> wrote:
> >
> > Am 06.02.19 um 18:23 schrieb Ard Biesheuvel:
> > > On Fri, 25 Jan 2019 at 11:35, Ard Biesheuvel <ard.biesheuvel@linaro.o=
rg> wrote:
> > >> On Fri, 25 Jan 2019 at 12:30, Christian K=C3=B6nig
> > >> <ckoenig.leichtzumerken@gmail.com> wrote:
> > >>> Am 25.01.19 um 09:43 schrieb Ard Biesheuvel:
> > >>>> On Thu, 24 Jan 2019 at 15:01, Alex Deucher <alexdeucher@gmail.com>=
 wrote:
> > >>>>> On Thu, Jan 24, 2019 at 9:00 AM Ard Biesheuvel
> > >>>>> <ard.biesheuvel@linaro.org> wrote:
> > >>>>>> On Thu, 24 Jan 2019 at 13:31, Koenig, Christian
> > >>>>>> <Christian.Koenig@amd.com> wrote:
> > >>>>>>> Am 24.01.19 um 13:06 schrieb Ard Biesheuvel:
> > >>>>>>>> The DRM driver stack is designed to work with cache coherent d=
evices
> > >>>>>>>> only, but permits an optimization to be enabled in some cases,=
 where
> > >>>>>>>> for some buffers, both the CPU and the GPU use uncached mappin=
gs,
> > >>>>>>>> removing the need for DMA snooping and allocation in the CPU c=
aches.
> > >>>>>>>>
> > >>>>>>>> The use of uncached GPU mappings relies on the correct impleme=
ntation
> > >>>>>>>> of the PCIe NoSnoop TLP attribute by the platform, otherwise t=
he GPU
> > >>>>>>>> will use cached mappings nonetheless. On x86 platforms, this d=
oes not
> > >>>>>>>> seem to matter, as uncached CPU mappings will snoop the caches=
 in any
> > >>>>>>>> case. However, on ARM and arm64, enabling this optimization on=
 a
> > >>>>>>>> platform where NoSnoop is ignored results in loss of coherency=
, which
> > >>>>>>>> breaks correct operation of the device. Since we have no way o=
f
> > >>>>>>>> detecting whether NoSnoop works or not, just disable this
> > >>>>>>>> optimization entirely for ARM and arm64.
> > >>>>>>>>
> > >>>>>>>> Cc: Christian Koenig <christian.koenig@amd.com>
> > >>>>>>>> Cc: Alex Deucher <alexander.deucher@amd.com>
> > >>>>>>>> Cc: David Zhou <David1.Zhou@amd.com>
> > >>>>>>>> Cc: Huang Rui <ray.huang@amd.com>
> > >>>>>>>> Cc: Junwei Zhang <Jerry.Zhang@amd.com>
> > >>>>>>>> Cc: Michel Daenzer <michel.daenzer@amd.com>
> > >>>>>>>> Cc: David Airlie <airlied@linux.ie>
> > >>>>>>>> Cc: Daniel Vetter <daniel@ffwll.ch>
> > >>>>>>>> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > >>>>>>>> Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> > >>>>>>>> Cc: Sean Paul <sean@poorly.run>
> > >>>>>>>> Cc: Michael Ellerman <mpe@ellerman.id.au>
> > >>>>>>>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > >>>>>>>> Cc: Will Deacon <will.deacon@arm.com>
> > >>>>>>>> Cc: Christoph Hellwig <hch@infradead.org>
> > >>>>>>>> Cc: Robin Murphy <robin.murphy@arm.com>
> > >>>>>>>> Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
> > >>>>>>>> Cc: dri-devel <dri-devel@lists.freedesktop.org>
> > >>>>>>>> Reported-by: Carsten Haitzler <Carsten.Haitzler@arm.com>
> > >>>>>>>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > >>>>>>> The subject line should probably read "disable uncached...".
> > >>>>>>>
> > >>>>>> Ugh, of course ...
> > >>>>>>
> > >>>>>>> With that fixed the patch is Reviewed-by: Christian K=C3=B6nig
> > >>>>>>> <christian.koenig@amd.com>.
> > >>>>>>>
> > >>>>> Same:
> > >>>>> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> > >>>>>
> > >>>> Thanks all
> > >>>>
> > >>>> Should I resend the patch with the subject corrected?
> > >>> I will update the subject line and push it upstream through
> > >>> drm-misc-next if nobody objects.
> > >>>
> > >> Wonderful, thanks.
> > > Hi Christian,
> > >
> > > Are you still planning to merge this for v5.1?
> >
> > My bad, only pushed this to our internal branch, but forgot out
> > drm-misc-next.
> >
> > Fixed now, thanks for the reminder.
> >
>
> Thanks,
>
> Does anyone mind if I propose this patch for backporting to v4.19 or
> earlier once it gets merged for v5.1?

Go for it.  I was going to suggest that this should probably go to stable.

Alex

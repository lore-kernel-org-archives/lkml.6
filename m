Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8264CC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 16:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45DBE2175B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 16:01:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m0bZv4kP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbfBGQBk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 11:01:40 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:51612 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbfBGQBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 11:01:40 -0500
Received: by mail-it1-f194.google.com with SMTP id w18so943487ite.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 08:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hjrkLDzbw59klMBWTcg66mkyzILll1t5jSDgHKiAU20=;
        b=m0bZv4kPOj47D9JHiEJ2ntQTsppLxm2MnJCmL6ke+PVDfiuj6Lhkntz8vAFTP52acS
         qfNNoxCjbn+yfKDNkwdhK/0NPI/t4VhRkwaFQGBsp8Rh/IyN9KxjJTW2Buq2EPkcHxSr
         1nc1wj0M8u/ZqzcdNKzkd3Hva+zRJPdDNx76zkV76v0SzI6POZa2Xgo1eJ/ZOJxTvPKY
         FJuUnnja6OuV2Rzi7qL5Wnav5PZ77WRUuK5aRtY+GF4ysOSVikGTrKFa7dnIAeMP2B2X
         SAiv1DdQ/iSc2wYlx7UeRoVsWEkHGAVMo8GzsDV6g6Ksrz8I3muL50r8j1JhNisusKHd
         TYrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hjrkLDzbw59klMBWTcg66mkyzILll1t5jSDgHKiAU20=;
        b=DTDAlFj1vivBtcNNjF7MaQORqjkKq65Jd1vHOXBkOKNFVpCalC/jUlSd+Jv75bDwXw
         mUSD/zMD8o4j3tNaEovd5j8sYb7AOMMslpzREq2LFNEa7d850MKAadcRTkHalIo1LQa9
         bFXbseNbSadVhA6BdK/peLSSllfLvcUEJDOSDBvubp0I/5OidZ1cSSi6vOqkI3u+vCNE
         JOowR+HFBBkLCdsKdPHnw9pstGwwFW+smNJQAop4QhXLHXj7HrADgQihmBEjvm8e6BMH
         ZR5v+s+mUBYDawgUHswXYOCjP7tgfIeUJRDCHfMCe0Nz3F8cM/D6xBuFTlsQjX1tTrkp
         Mguw==
X-Gm-Message-State: AHQUAuYvHaY0iuZ2EPOmEksxuuc4K2KcNpJVyxzF+lG5TN+cnT5QOeyZ
        v6RWA0DhViNEk9qfVXU5etiXSqeCLM9CaguRXGdLag==
X-Google-Smtp-Source: AHgI3IaUiQacOJtk0xlnnQ5OR0YTYWZENiYJE5CdRWYiueuFdGanCsW3J27+9Tqsxku7T3nFrJx1oQj2HZ6LVhbBBU8=
X-Received: by 2002:a05:660c:4b:: with SMTP id p11mr5920881itk.71.1549555298620;
 Thu, 07 Feb 2019 08:01:38 -0800 (PST)
MIME-Version: 1.0
References: <20190124120658.30288-1-ard.biesheuvel@linaro.org>
 <3cca35a9-c71c-a100-b29d-31ba0d1d10b1@amd.com> <CAKv+Gu9OG3O4+4F2nioaQ-3U-1kwRBr5KVj-1gD1ZEsUx_Ud5A@mail.gmail.com>
 <CADnq5_PETD6umm9Df7OZ9BdaV5MZutmhN+HTAnVkcRLg5=TNWw@mail.gmail.com>
 <CAKv+Gu-Yk1iEe+cF30ee7R+hcrke9XH9MdTeERA2P-0s2QpaLw@mail.gmail.com>
 <961e758d-b0a0-8f6c-a8fa-c3047e058706@gmail.com> <CAKv+Gu_faPAf+0NBTNM03EUH4-_0vWbPfDQneshps5vbaU4R_Q@mail.gmail.com>
 <CAKv+Gu-4=1r8X8BUvRjcTwgxj=sZpZLyY3ABBZyzh-RsSm1eXg@mail.gmail.com>
 <f6bdd647-722b-8145-92d4-3f6c52f8a74c@gmail.com> <CAKv+Gu8oCAcnoo6=UikRGJQHW63JmY21y1qZteaNmh_F7HnOEQ@mail.gmail.com>
 <CADnq5_NnY2Ktw0sLGnp7x3kc6NpwPnznHUzRK=5X2n6p1843Yg@mail.gmail.com>
In-Reply-To: <CADnq5_NnY2Ktw0sLGnp7x3kc6NpwPnznHUzRK=5X2n6p1843Yg@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 7 Feb 2019 17:01:26 +0100
Message-ID: <CAKv+Gu8Db0Mox6DDpejzmma1By8LBBEv7uhcaXR3wyoty=xKEQ@mail.gmail.com>
Subject: Re: [PATCH] drm: enable uncached DMA optimization for ARM and arm64
To:     Alex Deucher <alexdeucher@gmail.com>
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

On Thu, 7 Feb 2019 at 16:33, Alex Deucher <alexdeucher@gmail.com> wrote:
>
> On Thu, Feb 7, 2019 at 10:20 AM Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
> >
> > On Wed, 6 Feb 2019 at 19:38, Christian K=C3=B6nig
> > <ckoenig.leichtzumerken@gmail.com> wrote:
> > >
> > > Am 06.02.19 um 18:23 schrieb Ard Biesheuvel:
> > > > On Fri, 25 Jan 2019 at 11:35, Ard Biesheuvel <ard.biesheuvel@linaro=
.org> wrote:
> > > >> On Fri, 25 Jan 2019 at 12:30, Christian K=C3=B6nig
> > > >> <ckoenig.leichtzumerken@gmail.com> wrote:
> > > >>> Am 25.01.19 um 09:43 schrieb Ard Biesheuvel:
> > > >>>> On Thu, 24 Jan 2019 at 15:01, Alex Deucher <alexdeucher@gmail.co=
m> wrote:
> > > >>>>> On Thu, Jan 24, 2019 at 9:00 AM Ard Biesheuvel
> > > >>>>> <ard.biesheuvel@linaro.org> wrote:
> > > >>>>>> On Thu, 24 Jan 2019 at 13:31, Koenig, Christian
> > > >>>>>> <Christian.Koenig@amd.com> wrote:
> > > >>>>>>> Am 24.01.19 um 13:06 schrieb Ard Biesheuvel:
> > > >>>>>>>> The DRM driver stack is designed to work with cache coherent=
 devices
> > > >>>>>>>> only, but permits an optimization to be enabled in some case=
s, where
> > > >>>>>>>> for some buffers, both the CPU and the GPU use uncached mapp=
ings,
> > > >>>>>>>> removing the need for DMA snooping and allocation in the CPU=
 caches.
> > > >>>>>>>>
> > > >>>>>>>> The use of uncached GPU mappings relies on the correct imple=
mentation
> > > >>>>>>>> of the PCIe NoSnoop TLP attribute by the platform, otherwise=
 the GPU
> > > >>>>>>>> will use cached mappings nonetheless. On x86 platforms, this=
 does not
> > > >>>>>>>> seem to matter, as uncached CPU mappings will snoop the cach=
es in any
> > > >>>>>>>> case. However, on ARM and arm64, enabling this optimization =
on a
> > > >>>>>>>> platform where NoSnoop is ignored results in loss of coheren=
cy, which
> > > >>>>>>>> breaks correct operation of the device. Since we have no way=
 of
> > > >>>>>>>> detecting whether NoSnoop works or not, just disable this
> > > >>>>>>>> optimization entirely for ARM and arm64.
> > > >>>>>>>>
> > > >>>>>>>> Cc: Christian Koenig <christian.koenig@amd.com>
> > > >>>>>>>> Cc: Alex Deucher <alexander.deucher@amd.com>
> > > >>>>>>>> Cc: David Zhou <David1.Zhou@amd.com>
> > > >>>>>>>> Cc: Huang Rui <ray.huang@amd.com>
> > > >>>>>>>> Cc: Junwei Zhang <Jerry.Zhang@amd.com>
> > > >>>>>>>> Cc: Michel Daenzer <michel.daenzer@amd.com>
> > > >>>>>>>> Cc: David Airlie <airlied@linux.ie>
> > > >>>>>>>> Cc: Daniel Vetter <daniel@ffwll.ch>
> > > >>>>>>>> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > > >>>>>>>> Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> > > >>>>>>>> Cc: Sean Paul <sean@poorly.run>
> > > >>>>>>>> Cc: Michael Ellerman <mpe@ellerman.id.au>
> > > >>>>>>>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > > >>>>>>>> Cc: Will Deacon <will.deacon@arm.com>
> > > >>>>>>>> Cc: Christoph Hellwig <hch@infradead.org>
> > > >>>>>>>> Cc: Robin Murphy <robin.murphy@arm.com>
> > > >>>>>>>> Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
> > > >>>>>>>> Cc: dri-devel <dri-devel@lists.freedesktop.org>
> > > >>>>>>>> Reported-by: Carsten Haitzler <Carsten.Haitzler@arm.com>
> > > >>>>>>>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > > >>>>>>> The subject line should probably read "disable uncached...".
> > > >>>>>>>
> > > >>>>>> Ugh, of course ...
> > > >>>>>>
> > > >>>>>>> With that fixed the patch is Reviewed-by: Christian K=C3=B6ni=
g
> > > >>>>>>> <christian.koenig@amd.com>.
> > > >>>>>>>
> > > >>>>> Same:
> > > >>>>> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> > > >>>>>
> > > >>>> Thanks all
> > > >>>>
> > > >>>> Should I resend the patch with the subject corrected?
> > > >>> I will update the subject line and push it upstream through
> > > >>> drm-misc-next if nobody objects.
> > > >>>
> > > >> Wonderful, thanks.
> > > > Hi Christian,
> > > >
> > > > Are you still planning to merge this for v5.1?
> > >
> > > My bad, only pushed this to our internal branch, but forgot out
> > > drm-misc-next.
> > >
> > > Fixed now, thanks for the reminder.
> > >
> >
> > Thanks,
> >
> > Does anyone mind if I propose this patch for backporting to v4.19 or
> > earlier once it gets merged for v5.1?
>
> Go for it.  I was going to suggest that this should probably go to stable=
.
>

Excellent. Note that I actually prefer sending it manually rather than
let Greg or Sasha pick it up automatically, given that they are
usually a bit trigger happy, i.e., patches tend to get backported
before anyone has had a chance to actually check that it doesn't break
anything in mainline.

In other words, please don't add a cc -stable or fixes tag. I will
track it myself instead.

Thanks,
Ard.

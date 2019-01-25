Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02AE5C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 11:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6FF2218E2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 11:35:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="emJ9u6a1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbfAYLf1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 06:35:27 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:34606 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbfAYLf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 06:35:27 -0500
Received: by mail-io1-f67.google.com with SMTP id b16so7506464ior.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 03:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nn+Y4BDli85gEwW52CB+Hh6jofOIMP62VBfWfG1RY9g=;
        b=emJ9u6a13A1rLyU0WB9Ua7welEclT08Ok0zJAa5ovpuR4OGeA9w+klGPXVUpRilk9e
         jIYOle+39wjrJ2PJ37FRtNBb4IAy0USytvFjJiCApRje4XXsXePBbR6Q1pRIIPH/pHbB
         5110GDt00gVgX9gBRsSdpZvNKYp7owFOJLGl4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nn+Y4BDli85gEwW52CB+Hh6jofOIMP62VBfWfG1RY9g=;
        b=HG3h9bnPMdzVOu0mVUxN2VA4bKI8HoSIUA2gzXWA4VIYpj/qwBVNxOEj/ucxrZ3NTT
         WiPaJXtKQquxfTd3LuHE3wOuSS2zltcOdRhp9vgYjdpeHqJoch/XE3blIRJN/mdpJ81d
         kdRMjamwo47/glAuvQOsoXeC6YJeC7bf1vjOQ9gbdm6dQUefauZO2VzIKYv7nC8HccOR
         jIDfNIRbIKEnuoTIs+AhBCFTyEE4Ocngb72DE0BdDZmbMlt/gWCpTAbIvbxRCnyNcRMN
         0T3xuPwHIeqbIiMXVqkQRx8segkE6rJi/CLdIV57zTnxHbLqK7A41fzkWUQZO5AkULAQ
         i1uA==
X-Gm-Message-State: AHQUAuaoK2MLORwU3ZH13jxhU32TFHBFcksQKHEmpoBOvuHyp8W8y26T
        p6wqmej1f4Rdwdq7aljd3QvQ5HfS5Xav545jxOAffA==
X-Google-Smtp-Source: AHgI3Ib+V2u0DO8sOa15l5eCPhPHyg4MewLUuHkReHfAD0iekOXM/4Ieh7vAEhRmhhOhuWx+50qj/HgOV/EBV8dGotU=
X-Received: by 2002:a5e:c206:: with SMTP id v6mr1776787iop.60.1548416126221;
 Fri, 25 Jan 2019 03:35:26 -0800 (PST)
MIME-Version: 1.0
References: <20190124120658.30288-1-ard.biesheuvel@linaro.org>
 <3cca35a9-c71c-a100-b29d-31ba0d1d10b1@amd.com> <CAKv+Gu9OG3O4+4F2nioaQ-3U-1kwRBr5KVj-1gD1ZEsUx_Ud5A@mail.gmail.com>
 <CADnq5_PETD6umm9Df7OZ9BdaV5MZutmhN+HTAnVkcRLg5=TNWw@mail.gmail.com>
 <CAKv+Gu-Yk1iEe+cF30ee7R+hcrke9XH9MdTeERA2P-0s2QpaLw@mail.gmail.com> <961e758d-b0a0-8f6c-a8fa-c3047e058706@gmail.com>
In-Reply-To: <961e758d-b0a0-8f6c-a8fa-c3047e058706@gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 25 Jan 2019 12:35:15 +0100
Message-ID: <CAKv+Gu_faPAf+0NBTNM03EUH4-_0vWbPfDQneshps5vbaU4R_Q@mail.gmail.com>
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

On Fri, 25 Jan 2019 at 12:30, Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Am 25.01.19 um 09:43 schrieb Ard Biesheuvel:
> > On Thu, 24 Jan 2019 at 15:01, Alex Deucher <alexdeucher@gmail.com> wrot=
e:
> >> On Thu, Jan 24, 2019 at 9:00 AM Ard Biesheuvel
> >> <ard.biesheuvel@linaro.org> wrote:
> >>> On Thu, 24 Jan 2019 at 13:31, Koenig, Christian
> >>> <Christian.Koenig@amd.com> wrote:
> >>>> Am 24.01.19 um 13:06 schrieb Ard Biesheuvel:
> >>>>> The DRM driver stack is designed to work with cache coherent device=
s
> >>>>> only, but permits an optimization to be enabled in some cases, wher=
e
> >>>>> for some buffers, both the CPU and the GPU use uncached mappings,
> >>>>> removing the need for DMA snooping and allocation in the CPU caches=
.
> >>>>>
> >>>>> The use of uncached GPU mappings relies on the correct implementati=
on
> >>>>> of the PCIe NoSnoop TLP attribute by the platform, otherwise the GP=
U
> >>>>> will use cached mappings nonetheless. On x86 platforms, this does n=
ot
> >>>>> seem to matter, as uncached CPU mappings will snoop the caches in a=
ny
> >>>>> case. However, on ARM and arm64, enabling this optimization on a
> >>>>> platform where NoSnoop is ignored results in loss of coherency, whi=
ch
> >>>>> breaks correct operation of the device. Since we have no way of
> >>>>> detecting whether NoSnoop works or not, just disable this
> >>>>> optimization entirely for ARM and arm64.
> >>>>>
> >>>>> Cc: Christian Koenig <christian.koenig@amd.com>
> >>>>> Cc: Alex Deucher <alexander.deucher@amd.com>
> >>>>> Cc: David Zhou <David1.Zhou@amd.com>
> >>>>> Cc: Huang Rui <ray.huang@amd.com>
> >>>>> Cc: Junwei Zhang <Jerry.Zhang@amd.com>
> >>>>> Cc: Michel Daenzer <michel.daenzer@amd.com>
> >>>>> Cc: David Airlie <airlied@linux.ie>
> >>>>> Cc: Daniel Vetter <daniel@ffwll.ch>
> >>>>> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> >>>>> Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> >>>>> Cc: Sean Paul <sean@poorly.run>
> >>>>> Cc: Michael Ellerman <mpe@ellerman.id.au>
> >>>>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> >>>>> Cc: Will Deacon <will.deacon@arm.com>
> >>>>> Cc: Christoph Hellwig <hch@infradead.org>
> >>>>> Cc: Robin Murphy <robin.murphy@arm.com>
> >>>>> Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
> >>>>> Cc: dri-devel <dri-devel@lists.freedesktop.org>
> >>>>> Reported-by: Carsten Haitzler <Carsten.Haitzler@arm.com>
> >>>>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >>>> The subject line should probably read "disable uncached...".
> >>>>
> >>> Ugh, of course ...
> >>>
> >>>> With that fixed the patch is Reviewed-by: Christian K=C3=B6nig
> >>>> <christian.koenig@amd.com>.
> >>>>
> >> Same:
> >> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> >>
> > Thanks all
> >
> > Should I resend the patch with the subject corrected?
>
> I will update the subject line and push it upstream through
> drm-misc-next if nobody objects.
>

Wonderful, thanks.

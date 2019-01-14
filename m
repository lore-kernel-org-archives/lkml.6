Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51130C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 17:32:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1578A206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 17:32:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xn6tQliK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbfANRcX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 12:32:23 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:34878 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbfANRcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 12:32:22 -0500
Received: by mail-it1-f196.google.com with SMTP id p197so570265itp.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 09:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Lon8tNsCczXJvWjqQHnVoBIEeu+cAbP+MjUAFfIh39c=;
        b=Xn6tQliKGKTyiMW4S56/4bxP0k2GoScUhCKx8uOAaFbqv/e3dP+mYUy8+00SeHNelA
         8sYHbpdVpe8dwb7n0See/lvuudkLCRP26HCJoKM8jmUrbZqc/D1VNeLjxXoRUg4Dlrk0
         RhIPUhbGyiOXF5IAv2V7IPfGV50mTdX4U0pU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Lon8tNsCczXJvWjqQHnVoBIEeu+cAbP+MjUAFfIh39c=;
        b=PF9fJAjyFSkqb2eoFD2HRdP4bBkTNC5hSK86bq0R7VCARYKPeTrDDtH0ZDLS7RA5fZ
         i0vw4EHZruRSngMckn6zXqk0nGqV5yfTZDWEURjxDhSzyTKgNJnS+8z+au8NyEqOb/pj
         4Jy0PGIvr6XekUMiFY3OJvuB+fxC/TjBeLqIi+HzIlgpo+lJwZsPb3ac1+lYWP8IfF6e
         NLOc95XZPhjEXZ9685LStrTo9mwc7nMTbgJ+QhuPyNb6aWo9U47xN6AMFIrUG80tMsl2
         oGsglv0YSxFg4EKt/A4vyt08Pe0Pyr7N/MVcveR1FXyxJS2T3Sl9FEmyDbJnwRIfQms3
         4DQg==
X-Gm-Message-State: AJcUukfr30McZAyKzwsAedMMMM3PE/4fVBcdxWBc0NJ/CS3ATxJ7/tyV
        feoqf4AujjfKloumBsn7Fp5afEjglx6YHvN2SucTlw==
X-Google-Smtp-Source: ALg8bN7LwnhGxjH0IjV02t7n03vg1554jRMyag91Inu77Un7OXoFtC7ntX9sZdZKhima7d8TsTD06wbnH0LXv0NEj5w=
X-Received: by 2002:a05:660c:4b:: with SMTP id p11mr143075itk.71.1547487141179;
 Mon, 14 Jan 2019 09:32:21 -0800 (PST)
MIME-Version: 1.0
References: <20190110072841.3283-1-ard.biesheuvel@linaro.org>
 <5d8135de-80fe-9c0e-2206-ecb809f64cdb@daenzer.net> <CAKv+Gu_X-DH6GZ0k8RYuL18rxTwBpb5=Qp9VCZfn_kh+9b3Zkg@mail.gmail.com>
 <55facfb9-92af-86b8-40e9-d63b887b5592@amd.com>
In-Reply-To: <55facfb9-92af-86b8-40e9-d63b887b5592@amd.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 14 Jan 2019 18:32:10 +0100
Message-ID: <CAKv+Gu_JyO2KNtdN1-_TcoL_kqs0yswdwBrpAXA6-jyWuDrj+g@mail.gmail.com>
Subject: Re: [RFC PATCH] drm/ttm: force cached mappings for system RAM on ARM
To:     "Koenig, Christian" <Christian.Koenig@amd.com>
Cc:     =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Carsten Haitzler <Carsten.Haitzler@arm.com>,
        David Airlie <airlied@linux.ie>,
        Will Deacon <will.deacon@arm.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "Huang, Ray" <Ray.Huang@amd.com>,
        "Zhang, Jerry" <Jerry.Zhang@amd.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        =?UTF-8?Q?Bernhard_Rosenkr=C3=A4nzer?= 
        <Bernhard.Rosenkranzer@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jan 2019 at 12:38, Koenig, Christian
<Christian.Koenig@amd.com> wrote:
>
> Am 14.01.19 um 11:53 schrieb Ard Biesheuvel:
> > On Thu, 10 Jan 2019 at 10:34, Michel D=C3=A4nzer <michel@daenzer.net> w=
rote:
> >> On 2019-01-10 8:28 a.m., Ard Biesheuvel wrote:
> >>> ARM systems do not permit the use of anything other than cached
> >>> mappings for system memory, since that memory may be mapped in the
> >>> linear region as well, and the architecture does not permit aliases
> >>> with mismatched attributes.
> >>>
> >>> So short-circuit the evaluation in ttm_io_prot() if the flags include
> >>> TTM_PL_SYSTEM when running on ARM or arm64, and just return cached
> >>> attributes immediately.
> >>>
> >>> This fixes the radeon and amdgpu [TBC] drivers when running on arm64.
> >>> Without this change, amdgpu does not start at all, and radeon only
> >>> produces corrupt display output.
> >>>
> >>> Cc: Christian Koenig <christian.koenig@amd.com>
> >>> Cc: Huang Rui <ray.huang@amd.com>
> >>> Cc: Junwei Zhang <Jerry.Zhang@amd.com>
> >>> Cc: David Airlie <airlied@linux.ie>
> >>> Reported-by: Carsten Haitzler <Carsten.Haitzler@arm.com>
> >>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >>> ---
> >>>   drivers/gpu/drm/ttm/ttm_bo_util.c | 5 +++++
> >>>   1 file changed, 5 insertions(+)
> >>>
> >>> diff --git a/drivers/gpu/drm/ttm/ttm_bo_util.c b/drivers/gpu/drm/ttm/=
ttm_bo_util.c
> >>> index 046a6dda690a..0c1eef5f7ae3 100644
> >>> --- a/drivers/gpu/drm/ttm/ttm_bo_util.c
> >>> +++ b/drivers/gpu/drm/ttm/ttm_bo_util.c
> >>> @@ -530,6 +530,11 @@ pgprot_t ttm_io_prot(uint32_t caching_flags, pgp=
rot_t tmp)
> >>>        if (caching_flags & TTM_PL_FLAG_CACHED)
> >>>                return tmp;
> >>>
> >>> +#if defined(__arm__) || defined(__aarch64__)
> >>> +     /* ARM only permits cached mappings of system memory */
> >>> +     if (caching_flags & TTM_PL_SYSTEM)
> >>> +             return tmp;
> >>> +#endif
> >>>   #if defined(__i386__) || defined(__x86_64__)
> >>>        if (caching_flags & TTM_PL_FLAG_WC)
> >>>                tmp =3D pgprot_writecombine(tmp);
> >>>
> >> Apart from Christian's concerns, I think this is the wrong place for
> >> this, because other TTM / driver code will still consider the memory
> >> uncacheable. E.g. the amdgpu driver will program the GPU to treat the
> >> memory as uncacheable, so it won't participate in cache coherency
> >> protocol for it, which is unlikely to work as expected in general if t=
he
> >> CPU treats the memory as cacheable.
> >>
> > Will and I have spent some time digging into this, so allow me to
> > share some preliminary findings while we carry on and try to fix this
> > properly.
> >
> > - The patch above is flawed, i.e., it doesn't do what it intends to
> > since it uses TTM_PL_SYSTEM instead of TTM_PL_FLAG_SYSTEM. Apologies
> > for that.
> > - The existence of a linear region mapping with mismatched attributes
> > is likely not the culprit here. (We do something similar with
> > non-cache coherent DMA in other places).
>
> This is still rather problematic.
>
> The issue is that we often don't create a vmap for a page, but rather
> access the page directly using the linear mapping.
>
> So we would use the wrong access type here.
>

Yes. But how are these accesses done? Are they wrapped in a kmap()?

> > - The reason remapping the CPU side as cacheable does work (which I
> > did test) is because the GPU's uncacheable accesses (which I assume
> > are made using the NoSnoop PCIe transaction attribute) are actually
> > emitted as cacheable in some cases.
> >    . On my AMD Seattle, with or without SMMU (which is stage 2 only), I
> > must use cacheable accesses from the CPU side or things are broken.
> > This might be a h/w flaw, though.
> >    . On systems with stage 1+2 SMMUs, the driver uses stage 1
> > translations which always override the memory attributes to cacheable
> > for DMA coherent devices. This is what is affecting the Cavium
> > ThunderX2 (although it appears the attributes emitted by the RC may be
> > incorrect as well.)
> >
> > The latter issue is a shortcoming in the SMMU driver that we have to
> > fix, i.e., it should take care not to modify the incoming attributes
> > of DMA coherent PCIe devices for NoSnoop to be able to work.
> >
> > So in summary, the mismatch appears to be between the CPU accessing
> > the vmap region with non-cacheable attributes and the GPU accessing
> > the same memory with cacheable attributes, resulting in a loss of
> > coherency and lots of visible corruption.
>
> Actually it is the other way around. The CPU thinks some data is in the
> cache and the GPU only updates the system memory version because the
> snoop flag is not set.
>

That doesn't seem to be what is happening. As far as we can tell from
our experiments, all inbound transactions are always cacheable, and so
the only way to make things work is to ensure that the CPU uses the
same attributes.

> > To be able to debug this further, could you elaborate a bit on
> > - How does the hardware emit those uncached/wc inbound accesses? Do
> > they rely on NoSnoop?
>
> The GPU has a separate page walker in the MC and the page tables there
> have a bits saying if the access should go to the PCIe bus and if yes if
> the snoop bit should be set.
>
> > - Christian pointed out that some accesses must be uncached even when
> > not using WC. What kind of accesses are those? And do they access
> > system RAM?
>
> On some hardware generations we have a buggy engine which fails to
> forward the snoop bit and because of this the system memory page used by
> this engine must be uncached. But this only applies if you use ROCm in a
> specific configuration.
>

OK. I don't know what that means tbh. Does this apply to both radeon and am=
dgpu?

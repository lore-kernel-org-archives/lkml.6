Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EABFC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 16:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11BCF2085A
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 16:53:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qwp4sV2g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbfAWQxE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 11:53:04 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:36216 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbfAWQxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 11:53:03 -0500
Received: by mail-it1-f193.google.com with SMTP id c9so116122itj.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 08:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L1JadXm3gI7vuj3pOPP2vToMpxP3v/bmNdWI/GD7ZDE=;
        b=Qwp4sV2gW5k+CC/kpgsYJlEbT40wZztTQ9qcpOCl5sO/nk7LcmaZbe6Mm8TbFTZCIp
         OKhb0hTr32ResG4wdV09rJv4PX1fU+8pDLF1VoveHqup0Hn9183nHwT2/XNNnEcaEoX7
         pur30OvUFe1oqjAp01ayEA1NeQ1d3ROkLAC5M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L1JadXm3gI7vuj3pOPP2vToMpxP3v/bmNdWI/GD7ZDE=;
        b=Ow7nr/GlLupFdYaEzlyQ1VPbQVIbv0XRArDTVC7l2GNusq1mfBQBKNL+nWiTBWZEIL
         9SGixbZzPSZYZYZDUuBIsDSRCsTF9Wv6jCalluJKAiXSnLNrghr6UFGfhXmKNW4y4maX
         eO5xOKhYqGuC/sBOZnWX+lS22UnI4smSyZ+86Xw3CKGs1dCQm9nUz8P8nhw3dvw3+2aP
         SDOpkXmOY4EmvqSvl1HYIq1TvIJ/ZBMYq7qZB09X3fDCsZ2AhM55CAbGvCyp9Bg95o+P
         Y/RcHX9Nxtnn/aYXtLUrX9PAGxwUfRh2dtg3axWr12bGt/nn6s8ZrrrxQ+tufxRC2N5W
         p0Ag==
X-Gm-Message-State: AJcUukcvVVX6Vb6EGIfwjrNTfxaKuI2cncak1WiJfD8SQz4Wq+dTSlPi
        B3hTRB2CC3bReDlLvZy0bpHV47/TAW6V+M12pHU/Xg==
X-Google-Smtp-Source: ALg8bN43cqtnAk758IT2QWYIax59jaGfRHK8IMhmhPmNy5zjVaCzT94TMb7R+eZnHZconZW2Xup6sVPuaNFlkmBe6NE=
X-Received: by 2002:a24:710:: with SMTP id f16mr1797362itf.121.1548262382384;
 Wed, 23 Jan 2019 08:53:02 -0800 (PST)
MIME-Version: 1.0
References: <ccc775d3-3053-ab79-dac8-4feb28e8e690@daenzer.net>
 <CAKv+Gu-9VKL5RjScbKss4YfH1Cb8WbXmzU_0UsStnoXJcML7Rg@mail.gmail.com>
 <850b6aee-0040-c333-b125-45211c18ada5@daenzer.net> <CAKv+Gu99zHqcQtj6TiOXAr3Qa6WWhKem+DHVA_mAQ0-Bc0Vbqw@mail.gmail.com>
 <047667fd-17be-1c37-5d2a-26768cfd6ab8@daenzer.net> <CAKv+Gu_VBd8agHASc5RS0eCgyXP64Lt_i4yPuBjKwGQ+5Lpd5Q@mail.gmail.com>
 <CADnq5_O1uxCrSksfF127AZTfbmdukxmqGdh2Ee0zM6CqgG_Mhg@mail.gmail.com>
 <CAKv+Gu-4uYh_HD_5Ry_L80Nf5zpRhT4oJYhhG5_8g3gSzBs2tg@mail.gmail.com>
 <20190123071521.GB20526@infradead.org> <CAKv+Gu8+77uZHJ6ZYjGNcKQL8C3cT5Ree+TcTVmkQXAHV-ADyg@mail.gmail.com>
 <20190123164428.GA9367@infradead.org>
In-Reply-To: <20190123164428.GA9367@infradead.org>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 23 Jan 2019 17:52:50 +0100
Message-ID: <CAKv+Gu-9vEKu8mG-o+-4M1ZcgZmTTJVfEdNS9R27AFX8P5sqyQ@mail.gmail.com>
Subject: Re: [RFC PATCH] drm: disable WC optimization for cache coherent
 devices on non-x86
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Alex Deucher <alexdeucher@gmail.com>,
        =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Will Deacon <will.deacon@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>, Huang Rui <ray.huang@amd.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Junwei Zhang <Jerry.Zhang@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sean Paul <sean@poorly.run>,
        Christian Koenig <christian.koenig@amd.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jan 2019 at 17:44, Christoph Hellwig <hch@infradead.org> wrote:
>
> I think we just want a driver-local check for those combinations
> where we know this hack actually works, which really just seems
> to be x86-64 with PAT. Something like the patch below, but maybe with
> even more strong warnings to not do something like this elsewhere:
>

I agree that your patch seems like the right way to ensure that the WC
optimization hack is only used where we know it works.

But my concern is that it seems likely that non-cache coherent
implementations are relying on this hack as well. There must be a
reason that this hack is only disabled for PowerPC platforms if they
are cache coherent, for instance, and I suspect that that reason is
that the hack is the only thing ensuring that the CPU mapping
attributes match the device ones used for these buffers (the vmap()ed
ones), whereas the rings and other consistent data structures are
using the DMA API as intended, and thus getting uncached attributes in
the correct way.

Given that the same concern applies to ARM (and arm64 to some extent),
I'd be cautious to disable this optimization entirely, and this is why
I ended up disabling it only for cache coherent devices.




> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 728e15e5d68a..5fe657f20232 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -456,33 +456,16 @@ static int amdgpu_bo_do_create(struct amdgpu_device *adev,
>
>         bo->flags = bp->flags;
>
> -#ifdef CONFIG_X86_32
> -       /* XXX: Write-combined CPU mappings of GTT seem broken on 32-bit
> -        * See https://bugs.freedesktop.org/show_bug.cgi?id=84627
> -        */
> -       bo->flags &= ~AMDGPU_GEM_CREATE_CPU_GTT_USWC;
> -#elif defined(CONFIG_X86) && !defined(CONFIG_X86_PAT)
> -       /* Don't try to enable write-combining when it can't work, or things
> -        * may be slow
> -        * See https://bugs.freedesktop.org/show_bug.cgi?id=88758
> -        */
> -
> -#ifndef CONFIG_COMPILE_TEST
> -#warning Please enable CONFIG_MTRR and CONFIG_X86_PAT for better performance \
> -        thanks to write-combining
> -#endif
> -
> -       if (bo->flags & AMDGPU_GEM_CREATE_CPU_GTT_USWC)
> -               DRM_INFO_ONCE("Please enable CONFIG_MTRR and CONFIG_X86_PAT for "
> -                             "better performance thanks to write-combining\n");
> -       bo->flags &= ~AMDGPU_GEM_CREATE_CPU_GTT_USWC;
> -#else
> -       /* For architectures that don't support WC memory,
> -        * mask out the WC flag from the BO
> +       /*
> +        * Don't try to enable write-combined CPU mappings unless we 100%
> +        * positively know it works, otherwise there may be dragons.
> +        *
> +        * See:
> +        *  - https://bugs.freedesktop.org/show_bug.cgi?id=88758
> +        *  - https://bugs.freedesktop.org/show_bug.cgi?id=84627
>          */
> -       if (!drm_arch_can_wc_memory())
> +       if (!(IS_ENABLED(CONFIG_X86_64) && IS_ENABLED(CONFIG_X86_PAT)))
>                 bo->flags &= ~AMDGPU_GEM_CREATE_CPU_GTT_USWC;
> -#endif
>
>         bo->tbo.bdev = &adev->mman.bdev;
>         amdgpu_bo_placement_from_domain(bo, bp->domain);
> diff --git a/drivers/gpu/drm/radeon/radeon_object.c b/drivers/gpu/drm/radeon/radeon_object.c
> index 833e909706a9..c1fb5ad4ab9a 100644
> --- a/drivers/gpu/drm/radeon/radeon_object.c
> +++ b/drivers/gpu/drm/radeon/radeon_object.c
> @@ -226,32 +226,17 @@ int radeon_bo_create(struct radeon_device *rdev,
>         if (rdev->family >= CHIP_RV610 && rdev->family <= CHIP_RV635)
>                 bo->flags &= ~(RADEON_GEM_GTT_WC | RADEON_GEM_GTT_UC);
>
> -#ifdef CONFIG_X86_32
> -       /* XXX: Write-combined CPU mappings of GTT seem broken on 32-bit
> -        * See https://bugs.freedesktop.org/show_bug.cgi?id=84627
> -        */
> -       bo->flags &= ~(RADEON_GEM_GTT_WC | RADEON_GEM_GTT_UC);
> -#elif defined(CONFIG_X86) && !defined(CONFIG_X86_PAT)
> -       /* Don't try to enable write-combining when it can't work, or things
> -        * may be slow
> -        * See https://bugs.freedesktop.org/show_bug.cgi?id=88758
> -        */
> -#ifndef CONFIG_COMPILE_TEST
> -#warning Please enable CONFIG_MTRR and CONFIG_X86_PAT for better performance \
> -        thanks to write-combining
> -#endif
>
> -       if (bo->flags & RADEON_GEM_GTT_WC)
> -               DRM_INFO_ONCE("Please enable CONFIG_MTRR and CONFIG_X86_PAT for "
> -                             "better performance thanks to write-combining\n");
> -       bo->flags &= ~(RADEON_GEM_GTT_WC | RADEON_GEM_GTT_UC);
> -#else
> -       /* For architectures that don't support WC memory,
> -        * mask out the WC flag from the BO
> +       /*
> +        * Don't try to enable write-combined CPU mappings unless we 100%
> +        * positively know it works, otherwise there may be dragons.
> +        *
> +        * See:
> +        *  - https://bugs.freedesktop.org/show_bug.cgi?id=88758
> +        *  - https://bugs.freedesktop.org/show_bug.cgi?id=84627
>          */
> -       if (!drm_arch_can_wc_memory())
> -               bo->flags &= ~RADEON_GEM_GTT_WC;
> -#endif
> +       if (!(IS_ENABLED(CONFIG_X86_64) && IS_ENABLED(CONFIG_X86_PAT)))
> +               bo->flags &= ~(RADEON_GEM_GTT_WC | RADEON_GEM_GTT_UC);
>
>         radeon_ttm_placement_from_domain(bo, domain);
>         /* Kernel allocation are uninterruptible */
> diff --git a/include/drm/drm_cache.h b/include/drm/drm_cache.h
> index bfe1639df02d..6c3960f4c477 100644
> --- a/include/drm/drm_cache.h
> +++ b/include/drm/drm_cache.h
> @@ -40,16 +40,4 @@ void drm_clflush_sg(struct sg_table *st);
>  void drm_clflush_virt_range(void *addr, unsigned long length);
>  u64 drm_get_max_iomem(void);
>
> -
> -static inline bool drm_arch_can_wc_memory(void)
> -{
> -#if defined(CONFIG_PPC) && !defined(CONFIG_NOT_COHERENT_CACHE)
> -       return false;
> -#elif defined(CONFIG_MIPS) && defined(CONFIG_CPU_LOONGSON3)
> -       return false;
> -#else
> -       return true;
> -#endif
> -}
> -
>  #endif
>

Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF746C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 17:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1A832070B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 17:42:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rbZu4RT6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729211AbfAHRmo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 12:42:44 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:56093 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729078AbfAHRmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 12:42:43 -0500
Received: by mail-it1-f193.google.com with SMTP id m62so7442444ith.5;
        Tue, 08 Jan 2019 09:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FJFJLzEmDnhzByD673x2uqYZMLhAbYtaXgQLo4XgHIA=;
        b=rbZu4RT6EEtum2p7jv4E9rT1Crw2K8NygS8B3iYHIGdOlxsDMp3l7aZ21TNwdwUV1q
         EFD8blj/Fh0yOy9pdiVO184yiQRV8RYCmfe6XSxkE7l8RdctKSVhbYeXRsVsJTfsH/Re
         xavwDIbDZuGJYjCmzrEGus89Idi5NcdIQtEBLuyWWtPeKUyosgkDaBIw6dKrXea4xqMl
         FBv4wQtejXy+V6jtmJq11tZu4XlBZs3Tn5VWRCxAuUbUQ5QchKxdiwQtXE74vGyuByPz
         h9ycrZjmeCCF0nz+ZIsblE+SwqFUgp7IGmEPUklQTPzOdhJDSjDXzQCidUKR8JuiYSy3
         ojGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FJFJLzEmDnhzByD673x2uqYZMLhAbYtaXgQLo4XgHIA=;
        b=L4RIR+ZBnm2L+gTfeqRFyyACrCDvjxqJrywHFRD55fAOZTnKatYRyiIjKdo9ulPJO7
         jZ4DnC57NKJNIfJCgsQw/nUz2i93xdWKlzEH9gNFQijxsLpG385HulPec0hkMH7T3axU
         anNI26Cv8zltpNdTGj7G2r77gge3w2eLU4F6I9ctqBNModLyWZIYxLFvgHdorZBtRvXb
         PFjKwHxa7xrPlpBh1ZHoS1rXLM5grs0/OU0cVLjR3W6tFJ+wDHwQoVAadLfvDYwI7cZG
         AI+prsC3nsK98XhPUs9MhxssOAdR1sRnJa6ml9mF+2ca5sA3ZJ2BJQpROtSpWoWrZ6Pz
         O/xw==
X-Gm-Message-State: AJcUukfaBZEtor7ymTUM9P82sZfsmjAa3V1va/0dAMhU6aZPoZtwY4ub
        H2JXnuTP5bRIDzkx0uYUhHMlTcN8jhoZTxskRto=
X-Google-Smtp-Source: ALg8bN4qjtc57dYSlkTQiwYRmsUWTZ4HHUcw2w6/01GBIibQ45+XFPqJ4iibewxsjg3+Hhs1O3HsB+UAyKs6eQSeFQQ=
X-Received: by 2002:a02:242b:: with SMTP id f43mr1688505jaa.144.1546969361405;
 Tue, 08 Jan 2019 09:42:41 -0800 (PST)
MIME-Version: 1.0
References: <20180813212351.2555757-1-arnd@arndb.de> <20180813212351.2555757-2-arnd@arndb.de>
 <VI1PR0402MB2800858E1E94968F584E6CE8E08A0@VI1PR0402MB2800.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR0402MB2800858E1E94968F584E6CE8E08A0@VI1PR0402MB2800.eurprd04.prod.outlook.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Tue, 8 Jan 2019 12:42:16 -0500
Message-ID: <CAF6AEGsUkhmKKYKPzYxfL1UYoC6nFLTR-7bYi9PaDc3XD9_pbQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/msm/gpu: fix building without debugfs
To:     Ioana Ciornei <ioana.ciornei@nxp.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, David Airlie <airlied@linux.ie>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "freedreno@lists.freedesktop.org" <freedreno@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 8, 2019 at 9:16 AM Ioana Ciornei <ioana.ciornei@nxp.com> wrote:
>
>
> > Subject: [PATCH 2/2] drm/msm/gpu: fix building without debugfs
> >
> > When debugfs is disabled, but coredump is turned on, the adreno driver fails to
> > build:
> >
> > drivers/gpu/drm/msm/adreno/a3xx_gpu.c:460:4: error: 'struct msm_gpu_funcs'
> > has no member named 'show'
> >    .show = adreno_show,
> >     ^~~~
> > drivers/gpu/drm/msm/adreno/a3xx_gpu.c:460:11: note: (near initialization for
> > 'funcs.base')
> > drivers/gpu/drm/msm/adreno/a3xx_gpu.c:460:11: error: initialization of 'void
> > (*)(struct msm_gpu *, struct msm_gem_submit *, struct msm_file_private *)'
> > from incompatible pointer type 'void (*)(struct msm_gpu *, struct
> > msm_gpu_state *, struct drm_printer *)' [-Werror=incompatible-pointer-types]
> > drivers/gpu/drm/msm/adreno/a3xx_gpu.c:460:11: note: (near initialization for
> > 'funcs.base.submit')
> > drivers/gpu/drm/msm/adreno/a4xx_gpu.c:546:4: error: 'struct msm_gpu_funcs'
> > has no member named 'show'
> > drivers/gpu/drm/msm/adreno/a5xx_gpu.c:1460:4: error: 'struct
> > msm_gpu_funcs' has no member named 'show'
> > drivers/gpu/drm/msm/adreno/a6xx_gpu.c:769:4: error: 'struct msm_gpu_funcs'
> > has no member named 'show'
> > drivers/gpu/drm/msm/msm_gpu.c: In function 'msm_gpu_devcoredump_read':
> > drivers/gpu/drm/msm/msm_gpu.c:289:12: error: 'const struct msm_gpu_funcs'
> > has no member named 'show'
> >
> > Adjust the #ifdef to make it build again.
>
> Was this patch picked up by someone? I am asking this since the compile error can be still seen in 5.0-rc1.

Hmm, looks like I overlooked this thinking it was a resend of an
earlier patch from Arnd with (nearly) the same subject line.

Maybe we can pick this up via drm-misc?  I've pushed to msm-next
should fix should show up in linux-next in the near future.

BR,
-R


>
> Ioana
>
> >
> > Fixes: c0fec7f562ec ("drm/msm/gpu: Capture the GPU state on a GPU hang")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> > Not sure if this does the right thing, but it does fix the build regression
> > ---
> >  drivers/gpu/drm/msm/msm_gpu.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/msm/msm_gpu.h
> > b/drivers/gpu/drm/msm/msm_gpu.h
> > index 9122ee6e55e4..1fe93920fb25 100644
> > --- a/drivers/gpu/drm/msm/msm_gpu.h
> > +++ b/drivers/gpu/drm/msm/msm_gpu.h
> > @@ -63,7 +63,7 @@ struct msm_gpu_funcs {
> >       struct msm_ringbuffer *(*active_ring)(struct msm_gpu *gpu);
> >       void (*recover)(struct msm_gpu *gpu);
> >       void (*destroy)(struct msm_gpu *gpu);
> > -#ifdef CONFIG_DEBUG_FS
> > +#if defined(CONFIG_DEBUG_FS) || defined(CONFIG_DEV_COREDUMP)
> >       /* show GPU status in debugfs: */
> >       void (*show)(struct msm_gpu *gpu, struct msm_gpu_state *state,
> >                       struct drm_printer *p);
> > --
> > 2.18.0
>

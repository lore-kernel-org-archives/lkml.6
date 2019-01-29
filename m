Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C792FC282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 978C12175B
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:04:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EawR4lIq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729174AbfA2PEo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 10:04:44 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:42564 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728725AbfA2PE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 10:04:27 -0500
Received: by mail-io1-f67.google.com with SMTP id x6so16527977ioa.9;
        Tue, 29 Jan 2019 07:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0aXrJigyDlShLfSBm/v2B3Hvkx25o7/m3GEw38Vzw6s=;
        b=EawR4lIqlH3mZT0JrM1FGXts0nzWNxcEBL1CD/EEPhxp26bPLn9rJxj9JRorTGbUVF
         4BTiMMrIHLrCp3rcjkDjcuKqzMiDPYrrBfa3VWA3hqza57voOVcbSS2k/IWZqC57g8kX
         Wk58qeGI8Xa3odbHQDWmh3EyJ4poJ/eR/eRx8sjbtDScbNFSxC0puVhgfhAx3oq7pwNP
         Co3l05yIJoLM49QMhVtprv1jZrrJGiyEHnaW3Z9LBuTHmZtvA+IHDkDY61dgG1NaGTea
         +i+AFc+odjkZ9Y67ZyHQ9yNDAh1t3cVD+0IDRBnAv6sLxzC5hRlL3bd2Jnyl5Lvu7An3
         ih4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0aXrJigyDlShLfSBm/v2B3Hvkx25o7/m3GEw38Vzw6s=;
        b=rxcO0/ZKzwNggXjt3brhr8UuDuOXN8ksTJXtIc01V92FOR2HG5Wozets6aERCArEji
         xFN6d1fi1Xtoc5fZxitZ4aJ9Q/yolCJhbeUTiOXps4EYFCTMXvLq0mrswxgqI3/Mm3oj
         YaMabzR5mHEKHdlZUKqqiXEs7UO3z45Wf65CT9EWGWHehxkcB78VgkmRpBrqz6bSyzvu
         NEM0od+De3kXTDNm1u/Vrio5+Hnra7TSIv1YPxlwbuJ/L2ytlqj0mNijk3WV74uPGv8G
         0GxozHbgm9IrVv8l7FrDSzj5D1LhxfeQk9XDZDHTv7xSF/9IM6sxQyL/R3XGVjvz8oK1
         g63g==
X-Gm-Message-State: AJcUuke3YufjKVlq0uD3/4nODUqdlCmYdgXXKsOTgRiGtm0ArI0ehlnD
        4+W6DKpqMznRMFBcrjaHz5Yxzy2hLBEUGUVKeF8=
X-Google-Smtp-Source: ALg8bN6QO8/AQxzHaANKoSFxFJ9TaomGQyoYslc3/GAhWBpnsxABJqCw0BJ4J19qBBcAJzIGoP3QF3RTcRLSjjxVoRg=
X-Received: by 2002:a6b:f814:: with SMTP id o20mr15127399ioh.129.1548774266412;
 Tue, 29 Jan 2019 07:04:26 -0800 (PST)
MIME-Version: 1.0
References: <20190115154620.17964-1-rasmus.villemoes@prevas.dk> <f2656698-a4ca-06c7-2d1c-8719f5ed8ebc@prevas.se>
In-Reply-To: <f2656698-a4ca-06c7-2d1c-8719f5ed8ebc@prevas.se>
From:   Rob Clark <robdclark@gmail.com>
Date:   Tue, 29 Jan 2019 10:04:12 -0500
Message-ID: <CAF6AEGurnY0RY7RmVbM2hdk=uXoo0OEEYA5CR7zZzmoNcyx_wA@mail.gmail.com>
Subject: Re: [PATCH] drm/msm: fix building with DEBUG_FS=n
To:     Rasmus Villemoes <Rasmus.Villemoes@prevas.se>
Cc:     Jordan Crouse <jcrouse@codeaurora.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This should be fixed by c878a628e0c483ec36fa70f4590e4a58e34a6e49

BR,
-R

On Tue, Jan 29, 2019 at 3:29 AM Rasmus Villemoes
<Rasmus.Villemoes@prevas.se> wrote:
>
> ping
>
> On 15/01/2019 16.46, Rasmus Villemoes wrote:
> > With CONFIG_DEV_COREDUMP=3Dy and CONFIG_DEBUG_FS=3Dn, building fails:
> >
> > drivers/gpu/drm/msm/adreno/a2xx_gpu.c:428:4: error: =E2=80=98struct msm=
_gpu_funcs=E2=80=99 has no member named =E2=80=98show=E2=80=99
> >    .show =3D adreno_show,
> >     ^~~~
> > drivers/gpu/drm/msm/adreno/a2xx_gpu.c:428:11: error: initialization fro=
m incompatible pointer type [-Werror=3Dincompatible-pointer-types]
> >    .show =3D adreno_show,
> >            ^~~~~~~~~~~
> > drivers/gpu/drm/msm/adreno/a2xx_gpu.c:428:11: note: (near initializatio=
n for =E2=80=98funcs.base.gpu_busy=E2=80=99)
> > cc1: some warnings being treated as errors
> >
> > Fixes: c0fec7f562ec7 (drm/msm/gpu: Capture the GPU state on a GPU hang)
> > Cc: stable@vger.kernel.org # v4.19+
> > Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> > ---
> >  drivers/gpu/drm/msm/msm_gpu.h | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gp=
u.h
> > index efb49bb64191..4cb41db7f9e8 100644
> > --- a/drivers/gpu/drm/msm/msm_gpu.h
> > +++ b/drivers/gpu/drm/msm/msm_gpu.h
> > @@ -63,10 +63,12 @@ struct msm_gpu_funcs {
> >       struct msm_ringbuffer *(*active_ring)(struct msm_gpu *gpu);
> >       void (*recover)(struct msm_gpu *gpu);
> >       void (*destroy)(struct msm_gpu *gpu);
> > -#ifdef CONFIG_DEBUG_FS
> > -     /* show GPU status in debugfs: */
> > +#if defined(CONFIG_DEBUG_FS) || defined(CONFIG_DEV_COREDUMP)
> > +     /* show GPU status in debugfs or device coredump: */
> >       void (*show)(struct msm_gpu *gpu, struct msm_gpu_state *state,
> >                       struct drm_printer *p);
> > +#endif
> > +#ifdef CONFIG_DEBUG_FS
> >       /* for generation specific debugfs: */
> >       int (*debugfs_init)(struct msm_gpu *gpu, struct drm_minor *minor)=
;
> >  #endif
> >
>

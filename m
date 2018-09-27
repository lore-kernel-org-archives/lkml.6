Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94EB8C004D5
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 13:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37030215EB
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 13:17:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HPYVs4AP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37030215EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbeI0Tf1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 15:35:27 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:46402 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727199AbeI0Tf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 15:35:27 -0400
Received: by mail-oi1-f194.google.com with SMTP id k64-v6so2054617oia.13
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 06:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xLa/QeQNShWFOzFP7uriCsF9h6Vx3/9DwBaMCGFvdSY=;
        b=HPYVs4APb+PNX1CW2IWkNDGP/gvlfNdQ2Zr8cRSCUcO6/pWxiyWyNqlVLo4R9BmnxD
         4a1GUBEO9k0F41uEsQCHCYcXKFHXd4bba84h0Vfwa3nKXLY+imVDE7ZwiaTdX6k2+h/q
         awoxI/l0PpEvSpLXmAZyyIoqcClO5316eOFNs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xLa/QeQNShWFOzFP7uriCsF9h6Vx3/9DwBaMCGFvdSY=;
        b=qQGR4p01B0QkReZbg8bz/lZ0keBEM7+00LpsivfXYMVtl1YgZx7w7bKd0UBG8nAguv
         N9kp/NJrhXcgsngBn1OUpJxeNDthTMwZRHjVYzFR4S7/LTiM+QJqE7kSZfyWbKexGCTo
         nmMderWFx4Hf+HxosTXRMkeI8KtKaJi8h19UkgDNbFwNHdSL73dvFcybOqErLEKkPz6N
         GuKHU90SGvc0U6bnuRzDmKdKz0F+LYvh3CztKI9beJSc9P900+I6GL1HEQXnUKFm1LeR
         XVwx+u1cWc7j6772W12a9HQuPPxqr4/aRtoqjuLlaLlFr6KoTVa3hjyBbkPQ1AksjvAi
         DEPA==
X-Gm-Message-State: ABuFfoi0Gd5qJRb2fwuSb6hNRg6eiFeqXkYbZc+7OjOM0fjEQGnH2Bb7
        kuADnJE2hArv5/GsZrnM4hKlZys4AF7WeNUG1KgWUQ==
X-Google-Smtp-Source: ACcGV61EAjysqk6IIaPMhmJxtllIt06SUbU8HRO63Nz6TPtLa7R+IMukOjwj9w/X5z4TdMwvNtLMmaaI3qVzBbjRA8U=
X-Received: by 2002:aca:601:: with SMTP id 1-v6mr3326464oig.358.1538054232742;
 Thu, 27 Sep 2018 06:17:12 -0700 (PDT)
MIME-Version: 1.0
References: <7441c31c-7427-da4e-c877-6d58b5bd869f@st.com> <c1148671-4df1-3815-bd62-75541873bad6@st.com>
 <dc2d8602-7a89-6926-2b2d-4aa069076fde@st.com>
In-Reply-To: <dc2d8602-7a89-6926-2b2d-4aa069076fde@st.com>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Thu, 27 Sep 2018 15:17:01 +0200
Message-ID: <CA+M3ks5Xc56k7TrX5B8w9js1WZgvMQgpQAJT+jWkZr-46wvh6Q@mail.gmail.com>
Subject: Re: [PATCH] drm: stm: implement get_scanout_position function
To:     Yannick Fertre <yannick.fertre@st.com>
Cc:     Philippe Cornu <philippe.cornu@st.com>,
        Benjamin GAIGNARD <benjamin.gaignard@st.com>,
        David Airlie <airlied@linux.ie>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le jeu. 27 sept. 2018 =C3=A0 13:32, Yannick FERTRE <yannick.fertre@st.com> =
a =C3=A9crit :
>
> Reviewed-by: Yannick Fertr=C3=A9 <yannick.fertre@st.com>
> Tested-by: Yannick Fertr=C3=A9 <yannick.fertre@st.com>

Applied on drm-misc-next,
Thanks,
Benjamin

>
> On 09/27/2018 10:15 AM, Yannick FERTRE wrote:
> > Reviewed-by/tested-by: yannick.fertre@st.com
> >
> > -------- Forwarded Message --------
> > Subject: [PATCH] drm: stm: implement get_scanout_position function
> > Date: Fri, 29 Jun 2018 15:01:40 +0200
> > From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> > To: yannick.fertre@st.com, philippe.cornu@st.com, airlied@linux.ie
> > CC: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
> > Benjamin Gaignard <benjamin.gaignard@linaro.org>, Benjamin Gaignard
> > <benjamin.gaignard@st.com>
> >
> > Hardware allow to read the position in scanout buffer so
> > we can use this information to make wait of vblank more accurate.
> >
> > Active area bounds (start, end, total height) have already been
> > computed and written in ltdc registers, read them and get the
> > current line position to compute vpos value.
> >
> > Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> > ---
> >   drivers/gpu/drm/stm/drv.c  |  2 ++
> >   drivers/gpu/drm/stm/ltdc.c | 45
> > +++++++++++++++++++++++++++++++++++++++++++++
> >   drivers/gpu/drm/stm/ltdc.h |  5 +++++
> >   3 files changed, 52 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/stm/drv.c b/drivers/gpu/drm/stm/drv.c
> > index 8698e08313e1..ac53383350e3 100644
> > --- a/drivers/gpu/drm/stm/drv.c
> > +++ b/drivers/gpu/drm/stm/drv.c
> > @@ -72,6 +72,8 @@ static struct drm_driver drv_driver =3D {
> >       .gem_prime_vmap =3D drm_gem_cma_prime_vmap,
> >       .gem_prime_vunmap =3D drm_gem_cma_prime_vunmap,
> >       .gem_prime_mmap =3D drm_gem_cma_prime_mmap,
> > +    .get_scanout_position =3D ltdc_crtc_scanoutpos,
> > +    .get_vblank_timestamp =3D drm_calc_vbltimestamp_from_scanoutpos,
> >   };
> >    static int drv_load(struct drm_device *ddev)
> > diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
> > index d997a6014d6c..05b714673042 100644
> > --- a/drivers/gpu/drm/stm/ltdc.c
> > +++ b/drivers/gpu/drm/stm/ltdc.c
> > @@ -148,6 +148,8 @@
> >   #define IER_TERRIE    BIT(2)        /* Transfer ERRor Interrupt
> > Enable */
> >   #define IER_RRIE    BIT(3)        /* Register Reload Interrupt
> > enable */
> >   +#define CPSR_CYPOS    GENMASK(15, 0)    /* Current Y position */
> > +
> >   #define ISR_LIF        BIT(0)        /* Line Interrupt Flag */
> >   #define ISR_FUIF    BIT(1)        /* Fifo Underrun Interrupt Flag */
> >   #define ISR_TERRIF    BIT(2)        /* Transfer ERRor Interrupt Flag =
*/
> > @@ -622,6 +624,49 @@ static void ltdc_crtc_disable_vblank(struct
> > drm_crtc *crtc)
> >       reg_clear(ldev->regs, LTDC_IER, IER_LIE);
> >   }
> >   +bool ltdc_crtc_scanoutpos(struct drm_device *ddev, unsigned int pipe=
,
> > +              bool in_vblank_irq, int *vpos, int *hpos,
> > +              ktime_t *stime, ktime_t *etime,
> > +              const struct drm_display_mode *mode)
> > +{
> > +    struct ltdc_device *ldev =3D ddev->dev_private;
> > +    int line, vactive_start, vactive_end, vtotal;
> > +
> > +    if (stime)
> > +        *stime =3D ktime_get();
> > +
> > +    /* The active area starts after vsync + front porch and ends
> > +     * at vsync + front porc + display size.
> > +     * The total height also include back porch.
> > +     * We have 3 possible cases to handle:
> > +     * - line < vactive_start: vpos =3D line - vactive_start and will =
be
> > +     * negative
> > +     * - vactive_start < line < vactive_end: vpos =3D line - vactive_s=
tart
> > +     * and will be positive
> > +     * - line > vactive_end: vpos =3D line - vtotal - vactive_start
> > +     * and will negative
> > +     *
> > +     * Computation for the two first cases are identical so we can
> > +     * simplify the code and only test if line > vactive_end
> > +     */
> > +    line =3D reg_read(ldev->regs, LTDC_CPSR) & CPSR_CYPOS;
> > +    vactive_start =3D reg_read(ldev->regs, LTDC_BPCR) & BPCR_AVBP;
> > +    vactive_end =3D reg_read(ldev->regs, LTDC_AWCR) & AWCR_AAH;
> > +    vtotal =3D reg_read(ldev->regs, LTDC_TWCR) & TWCR_TOTALH;
> > +
> > +    if (line > vactive_end)
> > +        *vpos =3D line - vtotal - vactive_start;
> > +    else
> > +        *vpos =3D line - vactive_start;
> > +
> > +    *hpos =3D 0;
> > +
> > +    if (etime)
> > +        *etime =3D ktime_get();
> > +
> > +    return true;
> > +}
> > +
> >   static const struct drm_crtc_funcs ltdc_crtc_funcs =3D {
> >       .destroy =3D drm_crtc_cleanup,
> >       .set_config =3D drm_atomic_helper_set_config,
> > diff --git a/drivers/gpu/drm/stm/ltdc.h b/drivers/gpu/drm/stm/ltdc.h
> > index 1e16d6afb0d2..b8c5cc41e17a 100644
> > --- a/drivers/gpu/drm/stm/ltdc.h
> > +++ b/drivers/gpu/drm/stm/ltdc.h
> > @@ -37,6 +37,11 @@ struct ltdc_device {
> >       struct fps_info plane_fpsi[LTDC_MAX_LAYER];
> >   };
> >   +bool ltdc_crtc_scanoutpos(struct drm_device *dev, unsigned int pipe,
> > +              bool in_vblank_irq, int *vpos, int *hpos,
> > +              ktime_t *stime, ktime_t *etime,
> > +              const struct drm_display_mode *mode);
> > +
> >   int ltdc_load(struct drm_device *ddev);
> >   void ltdc_unload(struct drm_device *ddev);
> >   -- 2.15.0
> >
>
> --
> Yannick Fertr=C3=A9 | TINA: 166 7152 | Tel: +33 244027152 | Mobile: +33 6=
20600270
> Microcontrollers and Digital ICs Group | Microcontrolleurs Division
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

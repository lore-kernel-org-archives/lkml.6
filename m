Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22827C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 12:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C1FD20839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 12:22:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="E7F/Ukvi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C1FD20839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbeLLMWk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 07:22:40 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39391 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbeLLMWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 07:22:39 -0500
Received: by mail-wm1-f67.google.com with SMTP id f81so5703867wmd.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 04:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6n1b3W6v8On8RcT3Da+D1SKbLIuuvBwoV0lCsE4MWJk=;
        b=E7F/Ukvi9OOBDC0WfO7R7wfKvbGURkJQ6f0fYKFe6OA67WpT59NToDDBZFv2CiqxMq
         DZtUSaPDrRiBr48QIK4C8X4HR/UdGAoSVOxOJLL3eVthB73RY86+Eyp0R5YOe5P7cI9/
         r5f22WOC88Vn3OH4HX4/SXW7RRGRRfkio2rWrwvKSbl99qbeHs2JKAQdiW5b2SzONfNK
         gikKA4AHxpvCKXQrwiXMq/fotXYTQXgrmOodQUj1iAZYsVI0Ddly5TKoxsfRONz+eS2k
         HJI8kYyrWIW4MWyV6ajh99zfgaqSDdvug8T34QTfAsD7QqPA1Ys/puowS3wITRCMWfKD
         vyXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6n1b3W6v8On8RcT3Da+D1SKbLIuuvBwoV0lCsE4MWJk=;
        b=cG4BDbW5tEVLhK7KTxwVOD1OMb6df4whz71Rnd4Mwp15jEgwdRC54FdPJCFIcYayCz
         4BH5gXQadxgMA0qd+6RfyeAE4mr9Zc4cTa07nAVoQ+Ls/P+ElzDR4kM6jM1g59ZZD+Rc
         leC4m3u8SAvpOjFTMEw8TIO+o8FFYXautO/hAsLTPIt8EEshhZ8b7g/K4UjzZyoAGamh
         GYJ/G5uUySpPKeDMOOnrhgMaRqierDonHdbPAmrDjJwtOoo1QkuO3DRJ15Y+sdVoVtV3
         TNjkXiR4JlGgkDn4AERb0ydoJW0Fub+uVffVXZPBIoERQ7doBHK15s45gUcF0QGyq2W1
         XFiQ==
X-Gm-Message-State: AA+aEWZdLuXBlVGOkToUZPF8gPiOlLunZHmVufHaHtSnkEs21iKSYCkN
        TdZ0fQtecgjl67CaSQ813JvQKiC1qjeQr/5fgpcN2UJ6f9oSZQ==
X-Google-Smtp-Source: AFSGD/WKZ9FXS3qZbzeoM87Jax+StOCXWTGTL0mE5wYAVVaoKI+z4Twgf2mXnj02Vbc7Bp5cXoLsWBOiTwIQqQwt9nY=
X-Received: by 2002:a1c:9e4a:: with SMTP id h71mr6437867wme.82.1544617358147;
 Wed, 12 Dec 2018 04:22:38 -0800 (PST)
MIME-Version: 1.0
References: <20181210092853.13050-1-mjourdan@baylibre.com> <c5138091-d801-8b2a-85ab-d815f0508933@baylibre.com>
In-Reply-To: <c5138091-d801-8b2a-85ab-d815f0508933@baylibre.com>
From:   Maxime Jourdan <mjourdan@baylibre.com>
Date:   Wed, 12 Dec 2018 13:22:27 +0100
Message-ID: <CAMO6nay4+8Y_O2iTWJ041Bt0+3VUuOQj0WEN3Pyf6L80vuxHTA@mail.gmail.com>
Subject: Re: [PATCH RESEND] drm/meson: remove firmware framebuffers
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,
On Wed, Dec 12, 2018 at 10:55 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Hi Maxime,
>
> On 10/12/2018 10:28, Maxime Jourdan wrote:
> > In case we are using simplefb or another conflicting framebuffer, make
> > the call to drm_fb_helper_remove_conflicting_framebuffers()
> >
> > Signed-off-by: Maxime Jourdan <mjourdan@baylibre.com>
> > ---
> >  drivers/gpu/drm/meson/meson_drv.c | 20 ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/meson_drv.c
> > index d3443125e661..afbb3d707d15 100644
> > --- a/drivers/gpu/drm/meson/meson_drv.c
> > +++ b/drivers/gpu/drm/meson/meson_drv.c
> > @@ -159,6 +159,23 @@ static void meson_vpu_init(struct meson_drm *priv)
> >       writel_relaxed(0x20000, priv->io_base + _REG(VPU_WRARB_MODE_L2C1));
> >  }
> >
> > +static void meson_remove_framebuffers(void)
> > +{
> > +     struct apertures_struct *ap;
> > +
> > +     ap = alloc_apertures(1);
> > +     if (!ap)
> > +             return;
> > +
> > +     /* The framebuffer can be located anywhere in RAM */
> > +     ap->ranges[0].base = 0;
> > +     ap->ranges[0].size = ~0;
> > +
> > +     drm_fb_helper_remove_conflicting_framebuffers(ap, "meson-drm-fb",
> > +                                                   false);
>
> I always wondered, where does the "meson-drm-fb" comes from ???
>
> Neil
>

This name ultimately ends up in a printk and has no functional impact.
See drivers/video/fbdev/core/fbmem.c:1613 :

printk(KERN_INFO "fb%d: switching to %s from %s\n", i, name,
registered_fb[i]->fix.id);

I just picked one that was similar to the names of other drm drivers
calling drm_fb_helper_remove_conflicting_framebuffers().

Maxime

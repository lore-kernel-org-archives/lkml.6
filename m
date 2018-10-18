Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11FF1C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 09:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A39A621477
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 09:18:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="LpO1P/Px"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A39A621477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727747AbeJRRSY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 13:18:24 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42634 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727378AbeJRRSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 13:18:24 -0400
Received: by mail-qk1-f195.google.com with SMTP id u20-v6so3733174qkk.9
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 02:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TLbYImLsevlXesScTdbd4jvs2WIG10VtI5yfzIfuy2I=;
        b=LpO1P/Pxkzy0+WpBmGdccicuKpxTAJ95BCdbatqngQrqpwAn1RBWIQ6h2PuvAi6yWg
         OBnIkg66wdQPi5zSVlDSFmj8k2TGbfosKWnjMxvk4OIoya+WiK0skSF4g5DqveDuUryp
         DTz0j/E4/rd9VelVwS67a1i/fbSFCyJYKvFTc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TLbYImLsevlXesScTdbd4jvs2WIG10VtI5yfzIfuy2I=;
        b=WSVizCpP2gN7nwREWADTekvK/GJQrQ2pzSO86rePsmcQuig77doHTy65BP6ZSMAnPQ
         ZCp4dcHpX2J/43MFmMdNGGxbH8+8CV96HLs2JG7LPkC/RTMRCUVwN3Xg5vI18AgVAb2e
         riMCjgTnPARaPgGylExmhA8eA9F1X/QysiowcGBGP/VhQQUL9adpM9VNijYJprR8r6RT
         IM8mcfFsfCHnlI8WuVBQTBXGpUCwbi/Bm+hwjCfVChhWmZvcm+Aj5Vy/u8PPhAq+2jVt
         2ckJ6ylCa81K0D2O5qRvGkeP0rUuSXomu2/JcScvvemtLSkDJIIefDSNOobM9fsFfwm+
         p4Wg==
X-Gm-Message-State: ABuFfoiCavVvJ8q98JVr4LExzd0YnDlhfc6hQa4Y7vfdNqM63E8KdWMt
        4tJYaGFzpf1NncBX2oNNvNNJpM0j2jMo0+8DhH0uvrG2
X-Google-Smtp-Source: ACcGV63Ka7sjVXO0CMNqNfAHhNyTtrDoLVP0AgET2a5cJX2YyfEMyq/ebAkHWE+s9tyYxdnXPdBMkUMC31SOWvZjY74=
X-Received: by 2002:a37:c24b:: with SMTP id j11-v6mr27236448qkm.270.1539854297641;
 Thu, 18 Oct 2018 02:18:17 -0700 (PDT)
MIME-Version: 1.0
References: <20181018073327.64942-1-icenowy@aosc.io> <20181018073327.64942-10-icenowy@aosc.io>
 <4168274.Gmp9JTCfJR@avalon>
In-Reply-To: <4168274.Gmp9JTCfJR@avalon>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Thu, 18 Oct 2018 11:18:06 +0200
Message-ID: <CAKMK7uFp2c=wqzPi096MTRB6Cdfacerkp6dM=fEqCAr99PQG9w@mail.gmail.com>
Subject: Re: [PATCH 9/9] [DO NOT MERGE] drm/sun4i: rgb: Add 5% tolerance to
 dot clock frequency check
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Icenowy Zheng <icenowy@aosc.io>, devicetree@vger.kernel.org,
        Dave Airlie <airlied@linux.ie>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 10:55 AM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Icenowy,
>
> Thank you for the patch.
>
> On Thursday, 18 October 2018 10:33:27 EEST Icenowy Zheng wrote:
> > From: Chen-Yu Tsai <wens@csie.org>
> >
> > The panels shipped with Allwinner devices are very "generic", i.e.
> > they do not have model numbers or reliable sources of information
> > for the timings (that we know of) other than the fex files shipped
> > on them. The dot clock frequency provided in the fex files have all
> > been rounded to the nearest MHz, as that is the unit used in them.
> >
> > We were using the simple panel "urt,umsh-8596md-t" as a substitute
> > for the A13 Q8 tablets in the absence of a specific model for what
> > may be many different but otherwise timing compatible panels. This
> > was usable without any visual artifacts or side effects, until the
> > dot clock rate check was added in commit bb43d40d7c83 ("drm/sun4i:
> > rgb: Validate the clock rate").
> >
> > The reason this check fails is because the dotclock frequency for
> > this model is 33.26 MHz, which is not achievable with our dot clock
> > hardware, and the rate returned by clk_round_rate deviates slightly,
> > causing the driver to reject the display mode.
> >
> > The LCD panels have some tolerance on the dot clock frequency, even
> > if it's not specified in their datasheets.
> >
> > This patch adds a 5% tolerence to the dot clock check.
>
> Why do you think this shouldn't be merged ?

It pisses of a lot of people who really insist upon accurate timing. I
think a better fix would be to have a dotclock range in drm_panel, and
some magic to figure out which one of these we can actually do. Then
tell userspace that this is the mode is should request. That way
userspace knows what the actual dotclock/refresh rate is, and the
panel still works.
-Daniel

>
> > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> > ---
> >  drivers/gpu/drm/sun4i/sun4i_rgb.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/sun4i/sun4i_rgb.c
> > b/drivers/gpu/drm/sun4i/sun4i_rgb.c index bf068da6b12e..23bdc449eacc 100644
> > --- a/drivers/gpu/drm/sun4i/sun4i_rgb.c
> > +++ b/drivers/gpu/drm/sun4i/sun4i_rgb.c
> > @@ -92,13 +92,14 @@ static enum drm_mode_status sun4i_rgb_mode_valid(struct
> > drm_encoder *crtc,
> >
> >       DRM_DEBUG_DRIVER("Vertical parameters OK\n");
> >
> > +     /* Check against a 5% tolerance for the dot clock */
> >       tcon->dclk_min_div = 6;
> >       tcon->dclk_max_div = 127;
> >       rounded_rate = clk_round_rate(tcon->dclk, rate);
> > -     if (rounded_rate < rate)
> > +     if (rounded_rate < rate * 19 / 20 )
> >               return MODE_CLOCK_LOW;
> >
> > -     if (rounded_rate > rate)
> > +     if (rounded_rate > rate * 21 / 20)
> >               return MODE_CLOCK_HIGH;
> >
> >       DRM_DEBUG_DRIVER("Clock rate OK\n");
>
> --
> Regards,
>
> Laurent Pinchart
>
>
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch

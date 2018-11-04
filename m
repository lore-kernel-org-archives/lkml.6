Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF4C3C32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 16:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76E182082D
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 16:45:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="gtXjNw+y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76E182082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728898AbeKECBA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 21:01:00 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:36940 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728858AbeKECA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 21:00:59 -0500
Received: by mail-io1-f66.google.com with SMTP id k17-v6so4795340ioc.4
        for <linux-kernel@vger.kernel.org>; Sun, 04 Nov 2018 08:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MZ1WKKOvOXrRKKi2w6xb8PaQgnGLMyfQWjlVAcGOCgk=;
        b=gtXjNw+ySqXnWvNqateD2Jojpe7cOXcukO/ZsalC/vTdHiq3dZHN1mGNbNzdBAPp+7
         95BezmkPM1uCGWGf3VktgnRb76bKFTgHB6a/i7EEnsjb7dgxMDgClYjX7JcMRRogZ7eb
         jQ/rigA9kudClxn5giqyB5sRpEx0DC72t0GQA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MZ1WKKOvOXrRKKi2w6xb8PaQgnGLMyfQWjlVAcGOCgk=;
        b=I8u6F58n3Cgzm+L6oAvVK6hFiPvAfxLHlp0nGilfV0bUhosykUHufIvR/WhIjmYWqk
         LF/inBA06QvF4MRNOJlIwCZOqqkkOK2Af+CnBbARBimCPKoCv0sXPS7YDQRbTm4zFOC0
         /nA7QFBRHw7Ka4WsQ94ibJGsU8BE+9cWUBDYpgewwPgMR8x60ESHTYtJXS3pq4Qt76xJ
         VgNtyL6yCLuyfkF22q/RdD5fB4jwiRp+vu/oRU3YyGISOuBcCPFDUN6Hda+r+YfUM2nt
         qEDAQnbX4dTQLAZAeSrLtyN7m6pgacl3d7PAhOFtiJPyzQHvTO7r6X0rOOBax5zLgNct
         VpkQ==
X-Gm-Message-State: AGRZ1gJ/CRDRxyyHEMB8lmL/AQSNmBqeh0BCG+rUxaz5CLafNF/clv+u
        ljB9ZXpc/9kzdUDlzFAN9XHMXyE5luv0UewSmTCgFw==
X-Google-Smtp-Source: AJdET5e9a5SboyATLdPwWpDHWyk2u9PvCMGDRYT27rDx5FTOeRrOHLdMDyLf1CqH5TBG5qoKPu2l8BlmK9qqhWIy/PQ=
X-Received: by 2002:a6b:3e57:: with SMTP id l84-v6mr15712261ioa.252.1541349924833;
 Sun, 04 Nov 2018 08:45:24 -0800 (PST)
MIME-Version: 1.0
References: <20181103100900.30313-1-jagan@amarulasolutions.com>
 <20181103100900.30313-2-jagan@amarulasolutions.com> <8365df14-3397-b395-48eb-3070da3b65fc@orpaltech.com>
In-Reply-To: <8365df14-3397-b395-48eb-3070da3b65fc@orpaltech.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Sun, 4 Nov 2018 22:15:12 +0530
Message-ID: <CAMty3ZBGR9bgoN2cidcFMhCTinOcGP11332CgCvi_UhvQBOQjw@mail.gmail.com>
Subject: Re: [PATCH 01/10] drm/sun4i: sun6i_mipi_dsi: Compute burst mode loop
 N1 instruction delay
To:     Sergey Suloev <ssuloev@orpaltech.com>
Cc:     Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        TL Lim <tllim@pine64.org>, linux-sunxi@googlegroups.com,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 3, 2018 at 8:53 PM Sergey Suloev <ssuloev@orpaltech.com> wrote:
>
> Hi, Jagan,
>
> On 11/3/18 1:08 PM, Jagan Teki wrote:
> > Loop N1 instruction delay for burst mode lcd panel are
> > computed as per BSP code.
> >
> > Reference code is available in BSP
> > (in drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)
> > dsi_dev[sel]->dsi_inst_loop_num.bits.loop_n1=
> > (panel->lcd_ht-panel->lcd_x)*(150)/(panel->lcd_dclk_freq*8) - 50;
> > => (((mode->htotal - mode->hdisplay) * 150) / ((mode->clock / 1000) * 8)) - 50;
> >
> > So use the similar computation for loop N1 delay.
> >
> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > ---
> >   drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 9 ++++++++-
> >   1 file changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > index 86430efd9054..da152c21ec62 100644
> > --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > @@ -394,7 +394,14 @@ static void sun6i_dsi_setup_burst(struct sun6i_dsi *dsi,
> >   static void sun6i_dsi_setup_inst_loop(struct sun6i_dsi *dsi,
> >                                     struct drm_display_mode *mode)
> >   {
> > -     u16 delay = 50 - 1;
> > +     struct mipi_dsi_device *device = dsi->device;
> > +     u16 delay;
> > +
> > +     if (device->mode_flags == MIPI_DSI_MODE_VIDEO_BURST)
> > +             delay = (((mode->htotal - mode->hdisplay) * 150) /
> > +                     ((mode->clock / 1000) * 8)) - 50;
> > +     else
> > +             delay = 50 - 1;
> >
> >       regmap_write(dsi->regs, SUN6I_DSI_INST_LOOP_NUM_REG(0),
> >                    SUN6I_DSI_INST_LOOP_NUM_N0(50 - 1) |
>
>
> is this patch series comes in addition to the previous MIPI DSI series
> or in its stead?

Yes, all changes were added on top of previous MIPI DSI series(ie what
I mentioned in cover-letter) since it require clock patches from
previous version.

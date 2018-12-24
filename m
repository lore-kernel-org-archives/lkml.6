Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 111C6C64E75
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 15:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D028421871
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 15:28:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="SkxsVMh2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725816AbeLXP2B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 10:28:01 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:40649 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbeLXP2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 10:28:01 -0500
Received: by mail-it1-f194.google.com with SMTP id h193so15561781ita.5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 07:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o8tFLUInbXHibbCYw7eDlsLhwmt/Wjuw9trTBiCH0us=;
        b=SkxsVMh2n0xaPgUae+EG2EPNwW2ZaMW5ulQze3TDyehvL360dWxdg+NT2TVoZwSsqE
         rNcKiRkKJZYeM3ymFzwgD5786lzl7ijniL3/NAl2W+7MmBSwMF4l85pHREdFfXhIc1vu
         7RJ2Eb9kpBdce1ajD5iWzwsZoJ5WSTxIzfpyk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o8tFLUInbXHibbCYw7eDlsLhwmt/Wjuw9trTBiCH0us=;
        b=jptaZnbJOOk4M2hliHTJAswFFUIapmMv/Z5ybMXSm2efxio8wtJUCqosiDPO4l38Uw
         Gy44XjcefycQuY+H6hyHYeyaPeDZXLQ7G8c4cX40N/4myaI3uKmlnjeZTy+5//JAVvag
         eAgpcMBOutXVIdWag87EhrGGOCer7A3IjU2PW4gHIZ9BQkNUP1gaafPNwRVWJ14S9h+y
         J4gR9DF3wWs0I71u3WqoLfKXb1vr5ploF4AIV19FJ3vUrZKEbkhuDCosEqZmpOzr2rcX
         0kXPu+MWvvbeyMwbV+SdKOuStEs+F2aTrQUqdeXdi6PPx8bYUtINnS7CjMJhFIIOaG8n
         y1MA==
X-Gm-Message-State: AA+aEWYHxfnxMh+JwxB9ve4zftI5oSnwjB5ZMEvClBv2H//ZtgJwhFDm
        if/g8GwvLf13xaxvXVHiMpsbvX8t8qyu0jkBrbO4Cg==
X-Google-Smtp-Source: AFSGD/WO3CnPpXDVvviza+jO+lm2xfrOpdhPRJD2vY90UqIGUSBspwdwDs2S3DEvSVR9umJh3hGAo1J99AcemiDjly0=
X-Received: by 2002:a02:104a:: with SMTP id 71mr8065981jay.103.1545665280114;
 Mon, 24 Dec 2018 07:28:00 -0800 (PST)
MIME-Version: 1.0
References: <20181220125438.11700-1-jagan@amarulasolutions.com>
 <20181220125438.11700-3-jagan@amarulasolutions.com> <20181221130025.lbvw7yvy74brf3jn@flea>
In-Reply-To: <20181221130025.lbvw7yvy74brf3jn@flea>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Mon, 24 Dec 2018 20:57:48 +0530
Message-ID: <CAMty3ZCG5cF3tP2mid5xyS=yhtxkY+TOcGkwRkv+vrZt1=0iQg@mail.gmail.com>
Subject: Re: [PATCH v5 2/6] media: sun6i: Add mod_rate quirk
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Yong Deng <yong.deng@magewell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-media <linux-media@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-amarula@amarulasolutions.com,
        Michael Trimarchi <michael@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 6:30 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Thu, Dec 20, 2018 at 06:24:34PM +0530, Jagan Teki wrote:
> > Unfortunately default CSI_SCLK rate cannot work properly to
> > drive the connected sensor interface, particularly on few
> > Allwinner SoC's like A64.
> >
> > So, add mod_rate quirk via driver data so-that the respective
> > SoC's which require to alter the default mod clock rate can assign
> > the operating clock rate.
> >
> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > ---
> >  .../platform/sunxi/sun6i-csi/sun6i_csi.c      | 34 +++++++++++++++----
> >  1 file changed, 28 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> > index ee882b66a5ea..fe002beae09c 100644
> > --- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> > +++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> > @@ -15,6 +15,7 @@
> >  #include <linux/ioctl.h>
> >  #include <linux/module.h>
> >  #include <linux/of.h>
> > +#include <linux/of_device.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/pm_runtime.h>
> >  #include <linux/regmap.h>
> > @@ -28,8 +29,13 @@
> >
> >  #define MODULE_NAME  "sun6i-csi"
> >
> > +struct sun6i_csi_variant {
> > +     unsigned long                   mod_rate;
> > +};
> > +
> >  struct sun6i_csi_dev {
> >       struct sun6i_csi                csi;
> > +     const struct sun6i_csi_variant  *variant;
> >       struct device                   *dev;
> >
> >       struct regmap                   *regmap;
> > @@ -822,33 +828,43 @@ static int sun6i_csi_resource_request(struct sun6i_csi_dev *sdev,
> >               return PTR_ERR(sdev->clk_mod);
> >       }
> >
> > +     if (sdev->variant->mod_rate)
> > +             clk_set_rate_exclusive(sdev->clk_mod, sdev->variant->mod_rate);
> > +
>
> It still doesn't make any sense to do it in the probe function...

I'm not sure we discussed about the context wrt probe, we discussed
about exclusive put clock. Since clocks were enabling in set_power and
clock rate can be set during probe in single time instead of setting
it in set_power for every power enablement. anything wrong with that.

>
> We discussed this in the previous iteration already.
>
> What we didn't discuss is the variant function that you introduce,
> while the previous approach was enough.

We discussed about clk_rate_exclusive_put, and that even handle it in
.remove right? so I have variant to handle it in sun6i_csi_remove.

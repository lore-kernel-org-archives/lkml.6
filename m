Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE79BC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 17:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B3142156B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 17:46:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="IhfmQYfm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B3142156B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbeI1AFZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 20:05:25 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:46927 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727320AbeI1AFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 20:05:24 -0400
Received: by mail-io1-f67.google.com with SMTP id y12-v6so2479544ioj.13
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 10:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OBWRnqY8VjCI4bodmPyr9voKbRjCxPSITWLW6TzZFjE=;
        b=IhfmQYfmvdRDId02yUyGnqIaAnCt1sBulgYElSaKRhRYQgDg+Ye91OHGoZEQQ2XFYi
         boHK8awyjMNr2qhHUg+zeit4mJ8Lx1fgqhbqzpc0zihbE9gOzKXGrEXCxLQ3bp45Yjpx
         QB+H57C+D5kgQHH++lgHToii/CLOn5UakInmM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OBWRnqY8VjCI4bodmPyr9voKbRjCxPSITWLW6TzZFjE=;
        b=pbeBgYDBQykt2OSKle2G3UhuaVQrgJ+LiX14LmZszZBNgRH9hBUajfWTrY6CGSw+j8
         ROmlBVbuf6Jz2yTDrOEwFwsYHMem3rkeY557F+UcK2Tt7JMTYBpSmvMQAg69ZhRAZ6n5
         ZAvnR/EpQ8MPReGlKJLGvPrZaqnU4gb5c+xhzytvuXypK1ervdyldogk6idRXEJN2EkY
         3HB47zEmjwONquKHRGq8mFabhkh0iBMlWPGsmblI3h0yem9WifEKUE25af5V54YlmTmP
         ig7wkx5SZtwkBMRM6cDH+/VnR0ChIuqHwnxRaoQvM9ZohhQ0m+2rDoWe5P+e1wD/FUHX
         ukDw==
X-Gm-Message-State: ABuFfogrD/OSnVZg0bylx/k/EOgsW+O7qvuv/RZw+kI95Z+ghnybUy/x
        AEfFarfqMVn8NLnII57ldxmLLlS03bPUA+47ZOo9Qg==
X-Google-Smtp-Source: ACcGV60m6SJPSNB8YVbB9s0eAwtjTqAWq3wdH0AnV95wqttR+LrVl9EB7mpo5DcHh+rayCs2m57CLKSUWfuUf2K5C8g=
X-Received: by 2002:a6b:b383:: with SMTP id c125-v6mr9775129iof.267.1538070361145;
 Thu, 27 Sep 2018 10:46:01 -0700 (PDT)
MIME-Version: 1.0
References: <20180927114850.24565-1-jagan@amarulasolutions.com>
 <20180927114850.24565-8-jagan@amarulasolutions.com> <20180927165853.dpluekbqzat663q7@flea>
In-Reply-To: <20180927165853.dpluekbqzat663q7@flea>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Thu, 27 Sep 2018 23:15:50 +0530
Message-ID: <CAMty3ZDUxqokipNqnn6c618pebdVBWc8Pfzaz+4+SYqR42Yerg@mail.gmail.com>
Subject: Re: [PATCH 07/12] drm/sun4i: sun6i_mipi_dsi: Fix TCON DRQ set bits
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 10:28 PM Maxime Ripard
<maxime.ripard@bootlin.com> wrote:
>
> On Thu, Sep 27, 2018 at 05:18:45PM +0530, Jagan Teki wrote:
> > TCON DRQ set bits for non-burst DSI mode can computed via
> > horizontal front porch instead of front porch + sync timings.
> >
> > Since there no documentation for TCON_DRQ_REG(0x7c) register
> > this change is taken as reference from BPI-M64-bsp.
>
> Detailing more what the issue is would be great.
>
> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > ---
> >  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > index 599284971ab6..9918fdb990ff 100644
> > --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > @@ -367,9 +367,9 @@ static void sun6i_dsi_setup_burst(struct sun6i_dsi *dsi,
> >       struct mipi_dsi_device *device = dsi->device;
> >       u32 val = 0;
>
> The computation here is in the A64 driver:
>
> if ((panel->lcd_ht - panel->lcd_x - panel->lcd_hbp) < 21) {
>         dsi_dev[sel]->dsi_tcon_drq.bits.drq_mode = 0;
> } else {
>         dsi_dev[sel]->dsi_tcon_drq.bits.drq_set =
>                 (panel->lcd_ht-panel->lcd_x-panel->lcd_hbp-20) *
>                 dsi_pixel_bits[panel->lcd_dsi_format]/(8*4);
> }
>
> It is testing that the sync + front porch is smaller than 21, and
> otherwise sets the drq.
>
> > -     if ((mode->hsync_end - mode->hdisplay) > 20) {
>
> My code here is testing that the difference between hsync_end and
> hdisplay is superior to 20, and sets the DRQ if true. The condition is
> reversed, but otherwise, that difference is the front porch plus the
> sync length.

True, I understand this, but does drq setting here is specific to SoC?
I thought of finding DRQ in A31 BSP but I couldn't find the code. do
you have bsp somewhere in github?

>
> > +     if ((mode->hsync_start - mode->hdisplay) > 20) {
>
> However, you are testing for just the front porch, unlike what your
> commit log is saying, and unlike what allwinner's code is saying. So
> this deserves some explanation.

but A64 is doing this, do you think it's completely A64 specific or
testing panel with front porch drq?

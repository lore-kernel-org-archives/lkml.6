Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B16C43612
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 04:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EDBC20854
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 04:32:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="icT2g4/x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728940AbfAQEcZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 23:32:25 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:52662 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbfAQEcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 23:32:25 -0500
Received: by mail-it1-f194.google.com with SMTP id g76so6821833itg.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 20:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZsXVNpKQnBsqi29ZepEVp6DR5CyMftcA0Ev/oOZ4p1w=;
        b=icT2g4/xCFD2rxhgpNkTzA1/5epdYT2eWAu16wZUYgvVWUim43FdhaXM1H624HLBW9
         PlRray4VBEJzNVyIhdMaN1ifE1bfF+C9STa9q/gtP5rmyEc69KNWn7Ggm1TJv7mYwQ/p
         uWCTMZqzvbhqBOg6hUWKJLVUv4zNlBn8aQYRg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZsXVNpKQnBsqi29ZepEVp6DR5CyMftcA0Ev/oOZ4p1w=;
        b=QfsyU6Ka2iEhjvBtDrDSxdmOGM8yfUykbBejf9jQ/1w26jazbtz79qRNIhYjTmYnIv
         NVKiSRgZmdKAhZs4iBBKpKYJaj8o2b8V6AUIDJzx0xJM/ODKZACCiv6nVQXMKAiJqCJd
         yGXEpunJ0KsEvj/rhS3Jqku1IzGpzNCBdht35tUtc2DkXlKtr4KxyEKxMQHxZa1qliIL
         6o3+qYLO668IvPnPdMQBOkwVi+wtGNpPIRKNePH2baOKELd2kOavdXtTKPJJ0W7ahrjs
         5IgpR8TkjbKm5J8AnAt2nbgqXF5YFX8QwhmqN8RJPPobnXhYUdsDDICiS7wBvgQw3rlY
         k64A==
X-Gm-Message-State: AJcUukfKBgLokqxS8KnXAAV4CrI8lrOXrbAOvOp/GTJ4NdoWPJs0lsz8
        h1PGKAP9mv+UmMpt/LNiHOXue60qsHqys9WWt/eOBA==
X-Google-Smtp-Source: ALg8bN4LBtuMuYJRxuoCtj4jcK7NzTzmR+sGnRZ9nhO7G+cF4g+YnIOnYs5VCmYuNtc/4wVQIzLztNs1T/ySnduLvIA=
X-Received: by 2002:a02:104a:: with SMTP id 71mr6639151jay.103.1547699543763;
 Wed, 16 Jan 2019 20:32:23 -0800 (PST)
MIME-Version: 1.0
References: <20181210161729.29720-1-jagan@amarulasolutions.com>
 <20181210161729.29720-8-jagan@amarulasolutions.com> <20181211164900.wfmkmbrbj3nmlb3h@flea>
 <CAMty3ZB5F5jD9iJT1soXSA5HtQOf5W9rKO9nCdGFUfVo0hpO4Q@mail.gmail.com>
 <20190107141158.zaimizk4rlqa6xli@flea> <CAMty3ZBb8byOwh=_W83Ta0Dse1qkoqccOeaBEY9oHPaxDxe9QA@mail.gmail.com>
 <20190108085829.clianbtjovu3oieq@flea> <CAMty3ZC9OQtwT-iH=S1LhHsBPc_jFKGAnCYYeR9nuKuDWSKLQw@mail.gmail.com>
 <20190112164319.whr7gwvl4oux5svz@flea> <CAMty3ZD8X9KmHjUtAo-+Y83a2j8NF3DjM9Yr3LPMxOvQ8kOV7g@mail.gmail.com>
 <20190116191756.ajzzaga43srk77dk@flea>
In-Reply-To: <20190116191756.ajzzaga43srk77dk@flea>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Thu, 17 Jan 2019 10:02:12 +0530
Message-ID: <CAMty3ZCw8itG=nizA5E218HT5kg=-xDzLmShF51vRh4ENYKuBA@mail.gmail.com>
Subject: Re: [PATCH v5 07/17] drm/sun4i: sun6i_mipi_dsi: Refactor vertical
 video start delay
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-amarula@amarulasolutions.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 12:48 AM Maxime Ripard
<maxime.ripard@bootlin.com> wrote:
>
> On Sun, Jan 13, 2019 at 01:07:41AM +0530, Jagan Teki wrote:
> > > > > > > Again, I cannot help you without the datasheet for the panels you're
> > > > > > > trying to submit.
> > > > > >
> > > > > > The panel bound with Sitronix ST7701 IC
> > > > > > http://www.startek-lcd.com/res/starteklcd/pdres/201705/20170512144242904.pdf
> > > > >
> > > > > It's the controller, not the panel
> > > >
> > > > As I said before, the datasheet of that panel doesn't have any
> > > > information except electrical characteristics and used IC which is
> > > > ST7701.
> > > >
> > > > I have one more panel, which is from Bananapi, S070WV20-CT16 ICN621
> > > > please find the attachment for the same.
> > > >
> > > > Here is some more details of the same.
> > > >
> > > > https://github.com/yesnoandor/x300/blob/master/kernel/arch/arm/boot/dts/erobbing/x300/x300.dtsi#L81
> > > > https://github.com/wxzed/Raspberry_5MIPI_Display/blob/master/I2C_Slave/USER/main.c#L15
> > > >
> > > > https://github.com/eliot-shao/qcom/blob/master/icn6211_cxn0102/kernel/drivers/video/msm/mdss/mdss_i2c_interface.c#L152
> > > > matches timings for
> > > > https://github.com/eliot-shao/qcom/blob/master/icn6211_cxn0102/kernel/arch/arm/boot/dts/qcom/dsi-mipi-2-rgb_1280p_video.dtsi#L20
> > > >
> > > > https://github.com/zestroly/micromat/blob/master/test/raspberry/ICN6211.cpp#L169
> > >
> > > Where did you get the timings from then?
> >
> > You mean drm_mode timings, the same panel with RGB available in
> > panel-simple[1], and dsi driver in Mailing list[2] and actual DSI
> > sequence commands from BSP[3]
> >
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/gpu/drm/panel/panel-simple.c?id=7ad8b41cd8f5c2842646d01cdd576663caee04a7
> > [2] https://patchwork.kernel.org/patch/10680331/
> > [3] https://github.com/BPI-SINOVOIP/BPI-M64-bsp/blob/master/linux-sunxi/drivers/video/sunxi/disp2/disp/lcd/S070WV20_MIPI_RGB.c
>
> So you had no reliable source for the timings then? How do you know if
> all your patches that are timing related are right then?

I don't understand your point, or may be I confused with many links
that I attached in previous mail.

1. Patch for same panel timings are already in Mainline that was
tested on one of the board. [1]
2. Driver from AW, released bsp from BPI-M64-bsp [3]

Do you think the above two points are not valid sources?

Jagan.

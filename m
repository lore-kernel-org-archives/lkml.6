Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 563E1C43444
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 19:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20504206B7
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 19:37:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="WBDmlh3h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbfALThz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 14:37:55 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:55812 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbfALThy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 14:37:54 -0500
Received: by mail-it1-f196.google.com with SMTP id m62so7820988ith.5
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jan 2019 11:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a6/AqKf7RXx3dwwLOQZboz4+JYU15WvU1kVkeMx3CDw=;
        b=WBDmlh3h3j7VByEvZVcA00hP29C6knFitu3zCvNlVJlXZXGPRIF5lcEyEvURzqxRFr
         +SAE2KF3sbwyKAM9vPy+v5QVBFunfatrMaDw8klDlSxw70e3XUaDbhDd4i+2l7ID0Aqk
         kxEPd/N31Mjo+2XRWDa9AElVEmsKayZ2WSF+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a6/AqKf7RXx3dwwLOQZboz4+JYU15WvU1kVkeMx3CDw=;
        b=hrwmHPFRQAHrfsVrTvESV/qxPGQi8+DShRtEPuOVMfOZgFzKWqcxTGI4io1eiz5z94
         6p4WHHGYCR1/IperqlVdN+R+8MMB/xCEICW9/tX5RyZrOIff5pBMKteegWsej8gT925j
         8e3Une2rEZwVsWvNmUgs1XHKwVQox1GNsTnc2qvbYYqQJskWJGFml9ciTbDcw8Zf4Lxc
         56KMIDQhijF3JrEEu0mgN8dUXTX2I6Xd8W9FIL/QIgcNR0YX5IA2cyka6eEWabgq6+Cx
         2UX0mqFwt6cAufpSx36w/aAyeCwvWjfHyy10u1FHo2pi240k2lLQXveukIkplcVSGyYd
         2YUw==
X-Gm-Message-State: AJcUukcLcXiUePFf5g65LOzVJmfoPVWA269nPlnNUOKRCbcKjURoVD9j
        Cxu60aagFfgxFyeBGXZHc79udsTTFb1MEgnTxhNicg==
X-Google-Smtp-Source: ALg8bN7byJ2iItPlPW9oT100lh7hB/k1KH7tnIIheF+01qyV8D+zhleB1+RwH4qgGq91xzcm0oD/iowOqOKzzyfqS8M=
X-Received: by 2002:a24:10cb:: with SMTP id 194mr4708337ity.173.1547321873531;
 Sat, 12 Jan 2019 11:37:53 -0800 (PST)
MIME-Version: 1.0
References: <20181210161729.29720-1-jagan@amarulasolutions.com>
 <20181210161729.29720-8-jagan@amarulasolutions.com> <20181211164900.wfmkmbrbj3nmlb3h@flea>
 <CAMty3ZB5F5jD9iJT1soXSA5HtQOf5W9rKO9nCdGFUfVo0hpO4Q@mail.gmail.com>
 <20190107141158.zaimizk4rlqa6xli@flea> <CAMty3ZBb8byOwh=_W83Ta0Dse1qkoqccOeaBEY9oHPaxDxe9QA@mail.gmail.com>
 <20190108085829.clianbtjovu3oieq@flea> <CAMty3ZC9OQtwT-iH=S1LhHsBPc_jFKGAnCYYeR9nuKuDWSKLQw@mail.gmail.com>
 <20190112164319.whr7gwvl4oux5svz@flea>
In-Reply-To: <20190112164319.whr7gwvl4oux5svz@flea>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Sun, 13 Jan 2019 01:07:41 +0530
Message-ID: <CAMty3ZD8X9KmHjUtAo-+Y83a2j8NF3DjM9Yr3LPMxOvQ8kOV7g@mail.gmail.com>
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

On Sat, Jan 12, 2019 at 10:13 PM Maxime Ripard
<maxime.ripard@bootlin.com> wrote:
>
> On Wed, Jan 09, 2019 at 06:57:57PM +0530, Jagan Teki wrote:
> > On Tue, Jan 8, 2019 at 2:28 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > >
> > > On Mon, Jan 07, 2019 at 08:48:21PM +0530, Jagan Teki wrote:
> > > > On Mon, Jan 7, 2019 at 7:42 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > > > >
> > > > > On Fri, Dec 21, 2018 at 02:26:11AM +0530, Jagan Teki wrote:
> > > > > > On Tue, Dec 11, 2018 at 10:19 PM Maxime Ripard
> > > > > > <maxime.ripard@bootlin.com> wrote:
> > > > > > >
> > > > > > > On Mon, Dec 10, 2018 at 09:47:19PM +0530, Jagan Teki wrote:
> > > > > > > > Video start delay can be computed by subtracting total vertical
> > > > > > > > timing with front porch timing and with adding 1 delay line for TCON.
> > > > > > > >
> > > > > > > > BSP code form BPI-M64-bsp is computing video start delay as
> > > > > > > > (from linux-sunxi/
> > > > > > > > drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)
> > > > > > > >
> > > > > > > > u32 vfp = panel->lcd_vt - panel->lcd_y - panel->lcd_vbp;
> > > > > > > > => (panel->lcd_vt) - panel->lcd_y - (panel->lcd_vbp)
> > > > > > > > => (timmings->ver_front_porch + panel->lcd_vbp + panel->lcd_y)
> > > > > > > >    - panel->lcd_y - (panel->lcd_vbp)
> > > > > > > > => timmings->ver_front_porch + panel->lcd_vbp + panel->lcd_y
> > > > > > > >                            - panel->lcd_y - panel->lcd_vbp
> > > > > > > > => timmings->ver_front_porch
> > > > > > > >
> > > > > > > > So, update the start delay computation accordingly.
> > > > > > > >
> > > > > > > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > > > > >
> > > > > > > Even though it's a bit better now on my A33 board and I don't have the
> > > > > > > white stripes on the bottom of the display, there's still some
> > > > > > > flickering with your patches applied.
> > > > > > >
> > > > > > > Bisecting it seems to point at that patch, but reverting it doesn't
> > > > > > > make the issue go away, so it's not really clear which one exactly is
> > > > > > > at fault.
> > > > > >
> > > > > > Is reverting this patch, work fine or not?
> > > > >
> > > > > As I was saying, it doesn't.
> > > > >
> > > > > > This patch is trying to make use of front porch instead of existing
> > > > > > back porch to compute the delay. Since we revert the VBP fix patch[1]
> > > > > > to assume VBP as VFP value look like your setup would also require to
> > > > > > revert this change. But as per BSP or drm_mode details all of my
> > > > > > displays even work with and w/o reverting these two.
> > > > >
> > > > > Again, I cannot help you without the datasheet for the panels you're
> > > > > trying to submit.
> > > >
> > > > The panel bound with Sitronix ST7701 IC
> > > > http://www.startek-lcd.com/res/starteklcd/pdres/201705/20170512144242904.pdf
> > >
> > > It's the controller, not the panel
> >
> > As I said before, the datasheet of that panel doesn't have any
> > information except electrical characteristics and used IC which is
> > ST7701.
> >
> > I have one more panel, which is from Bananapi, S070WV20-CT16 ICN621
> > please find the attachment for the same.
> >
> > Here is some more details of the same.
> >
> > https://github.com/yesnoandor/x300/blob/master/kernel/arch/arm/boot/dts/erobbing/x300/x300.dtsi#L81
> > https://github.com/wxzed/Raspberry_5MIPI_Display/blob/master/I2C_Slave/USER/main.c#L15
> >
> > https://github.com/eliot-shao/qcom/blob/master/icn6211_cxn0102/kernel/drivers/video/msm/mdss/mdss_i2c_interface.c#L152
> > matches timings for
> > https://github.com/eliot-shao/qcom/blob/master/icn6211_cxn0102/kernel/arch/arm/boot/dts/qcom/dsi-mipi-2-rgb_1280p_video.dtsi#L20
> >
> > https://github.com/zestroly/micromat/blob/master/test/raspberry/ICN6211.cpp#L169
>
> Where did you get the timings from then?

You mean drm_mode timings, the same panel with RGB available in
panel-simple[1], and dsi driver in Mailing list[2] and actual DSI
sequence commands from BSP[3]

[1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/gpu/drm/panel/panel-simple.c?id=7ad8b41cd8f5c2842646d01cdd576663caee04a7
[2] https://patchwork.kernel.org/patch/10680331/
[3] https://github.com/BPI-SINOVOIP/BPI-M64-bsp/blob/master/linux-sunxi/drivers/video/sunxi/disp2/disp/lcd/S070WV20_MIPI_RGB.c

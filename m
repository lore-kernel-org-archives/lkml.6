Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E249C04EBA
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 11:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41AC02086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 11:04:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="GqRWFHvo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41AC02086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731015AbeK0WCW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 17:02:22 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:46377 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729361AbeK0WCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 17:02:21 -0500
Received: by mail-io1-f67.google.com with SMTP id v10so10972211ios.13
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 03:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+OluvinTkxBd6efBhqFBdlf/J00hDCF/s7aWnqnG3hk=;
        b=GqRWFHvoykVnegDZ5aV42cc7jEhE6UlyETky+USkVSXSpe51ObB9TOr8IF5gIEI8ma
         FMOJILDY+4Ls8CYxt6pNQ0nuJVUcM3NA6dd5WLODROwBjVgpx2BUoTIVjjcWfXWz9s8z
         6Pa1HkyjOg9huv9R2veOQsRtEOqz9bfIZAKGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+OluvinTkxBd6efBhqFBdlf/J00hDCF/s7aWnqnG3hk=;
        b=U/hgVvIDWLoOc4PDZw3CXOWSe0VECG9h9Tg1gumBq/vElEOAz9mV6v7zqkQWebusjh
         yQDgiK+jbvYiOmRKJr2h2O+p04zoyT+NAmq9Q5sHnfZBrNcupgjuD/Cul+XSfjgdEA9I
         c697vEVYBedeHw6ibQEaxAlDohzXbhKfJiUL8V82av4SP+aOzHu8R2dmtT2pZD3r2N9b
         YvEY0FpCWQfvnpkfpxu6voT/e2dXAp8ZuYqGiwjuwlv7LrrFy1MXF84m0gM3us+Ugg/0
         8t8dEnVxUtWSoya0eKez0Ude3bhrgxUxQ4W86iVDniITESfD77kusQGU5GrHP1EGL7cp
         CyAQ==
X-Gm-Message-State: AA+aEWZgu5SW5UUY2OmUC2Xe+tHDoVB4P3xbHERooV9Dw3zRV3dDUiYE
        QkvKZMLQF/fANAUEWwnj7p5U6lWd1mV5tCKWXPLfdQ==
X-Google-Smtp-Source: AFSGD/V2+F6u6etUCY8GvPIvZwxK6L+YkRbvMcKP4Fu184czccyJZibYCrey7holT0Qd2fyxBaMmkGGWUm5LUzwo9q0=
X-Received: by 2002:a6b:e50d:: with SMTP id y13mr22855148ioc.114.1543316688219;
 Tue, 27 Nov 2018 03:04:48 -0800 (PST)
MIME-Version: 1.0
References: <20181113111633.20189-1-jagan@amarulasolutions.com>
 <20181113111633.20189-9-jagan@amarulasolutions.com> <20181115095551.uctdkfmuwlnzhjnn@flea>
 <CAMty3ZAEHiovm6OF6JvJVQR4aqpG1Q3ML5YqxJkF2ntwRkUO=A@mail.gmail.com>
 <20181120155715.andrjp5kg6ugcv72@flea> <CAMty3ZCUOJmvekupOwh281g5HaazTpBbukWQY2Pv2OYypAwciw@mail.gmail.com>
 <20181127102450.b65jzhrdpxn5rxmk@flea>
In-Reply-To: <20181127102450.b65jzhrdpxn5rxmk@flea>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Tue, 27 Nov 2018 16:34:35 +0530
Message-ID: <CAMty3ZDTvn4VF_oOvEi2jCw9Rw5WPd1LQT3SZ5X1K0fJAFg2cQ@mail.gmail.com>
Subject: Re: [linux-sunxi] Re: [PATCH v4 08/26] drm/sun4i: sun6i_mipi_dsi: Fix
 VBP size calculation
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
        linux-sunxi@googlegroups.com, linux-amarula@amarulasolutions.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 3:55 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Tue, Nov 20, 2018 at 09:55:42PM +0530, Jagan Teki wrote:
> > On Tue, Nov 20, 2018 at 9:27 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > >
> > > On Thu, Nov 15, 2018 at 11:19:53PM +0530, Jagan Teki wrote:
> > > > On Thu, Nov 15, 2018 at 3:26 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > > > >
> > > > > Hi,
> > > > >
> > > > > On Tue, Nov 13, 2018 at 04:46:15PM +0530, Jagan Teki wrote:
> > > > > > The horizontal and vertical back porch calculation in BSP
> > > > > > code is simply following the Linux drm comment diagram, in
> > > > > > include/drm/drm_modes.h which is
> > > > > >
> > > > > > [hv]back porch = [hv]total - [hv]sync_end
> > > > > >
> > > > > > BSP code form BPI-M64-bsp is calculating vertical back porch as
> > > > > > (from linux-sunxi/drivers/video/sunxi/disp2/disp/de/disp_lcd.c)
> > > > > >
> > > > > > timmings->ver_sync_time= panel_info->lcd_vspw;
> > > > > > timmings->ver_back_porch= panel_info->lcd_vbp-panel_info->lcd_vspw;
> > > > > >
> > > > > > vbp = panel->lcd_vbp;
> > > > > > vspw = panel->lcd_vspw;
> > > > > > dsi_dev[sel]->dsi_basic_size0.bits.vbp = vbp-vspw;
> > > > > > dsi_dev[sel]->dsi_basic_size0.bits.vbp = panel->lcd_vbp - panel->lcd_vspw;
> > > > > > =>  timmings->ver_back_porch + panel_info->lcd_vspw - panel_info->lcd_vspw
> > > > > > =>  timmings->ver_back_porch
> > > > > > =>  mode->vtotal - mode->end
> > > > > >
> > > > > > Which evatually same as mode->vtotal - mode->vsync_end so update the
> > > > > > same in SUN6I_DSI_BASIC_SIZE0_VBP
> > > > > >
> > > > > > On the information note, existing SUN6I_DSI_BASIC_SIZE0_VSA is proper
> > > > > > value.
> > > > > >
> > > > > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > > >
> > > > > I've tested your changes on my A33 board, and this commit will break
> > > > > it.
> > > > >
> > > > > It creates vblank timeouts, and visual artifacts at the bottom of the
> > > > > display.
> > > >
> > > > Strange, VBP is earlier gives front porch which is anyway wrong.
> > > >
> > > > >
> > > > > Later commits seem to fix the issue, but will create some blanking on
> > > > > the upper third of the display.
> > > > >
> > > > > Since the documentation is quite sparse, and a MIPI-DSI analyzer is
> > > > > way too expensive, I'd really like to have at least what each of these
> > > > > commits are actually fixing, and what symptoms each of these were
> > > > > causing, and not just "the BSP does it".
> > > >
> > > > W/o this 2-lane panel is breaking, same vblank timeout and visual
> > > > artifacts at the bottom of the panel. though the commits may reference
> > > > BSP, I have at-least tested on 3 different panels for us to prove its
> > > > working.
> > > >
> > > > > Having some datasheet for the panels you had working would help too.
> > > >
> > > > Unfortunately datasheet doesn't have any required information what we
> > > > actually looking for.
> > >
> > > Not even the timings? How did you get that information then?
> >
> > datasheet has timing values, but this changes need controller
> > information about VBP register that I don't have. But again existing
> > VBP is not back porch for real, it's front porch.
>
> Yet, this breaks the existing setup. So again:

Was it with 4-lane or 2-lane panel? can you test it with 2-lane panel?
I can see the issue on 2-lane but the 4-lane working fine with this
patch even.

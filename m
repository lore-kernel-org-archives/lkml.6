Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC87C6783C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A243620672
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:07:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="qZrqOe9i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A243620672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbeLJQHh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 11:07:37 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43778 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbeLJQHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 11:07:37 -0500
Received: by mail-ot1-f68.google.com with SMTP id a11so10882119otr.10
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 08:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=706PBGmkV48/HcbLMZWflsnZr+TVd3yuVsGo/4DR1f8=;
        b=qZrqOe9iym2AL2GkjgW8rRNrL6Lh3xM6Y2S2PhEd30uLK31ZdzOhVYJYW3ZDkrnkJk
         EHNotu5j1Gc4gjAAtwOffzQoV7ShVWggmFvlsydstPAOWrcVFbgFmYiyhgHnB+EBzmkb
         6C5PuH1RS0zu+74H6lG6eYz/k/yYrw7+EHZw0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=706PBGmkV48/HcbLMZWflsnZr+TVd3yuVsGo/4DR1f8=;
        b=HijPUohlwWF6ooeZ3UhHHGcnwNqxqKgoam5gySFGNsOsgGGVtOb6AHv63tTO8tFfRZ
         qVjOdm/pCksHR3HKLR9UIiTejwk3fZy99X+brVlbAHbjiTsFK9eZfOJzhAuVzC5zMg0I
         TqaUUI1qeLidZea8W/JLxSzSrB4z3J7UIk6ujk0Mj5daDl5Sqpy/2cfbos9Upo8HlnYO
         AZ52FSmsfj1Y2FyO3uNbk9SzbPDjpXHidhW+Pbvh6MslxHc0VAaVRV3rGg+hepOYqYbr
         T5rmOlhEpald+JawhqGnloCBOlzK96ExwwYSVSqdkqQOqNOnzoI/AGj+JvN4MLrPY8PO
         2RDQ==
X-Gm-Message-State: AA+aEWZxzcEo4o5MYJfa0s8P4mGXEWE/E81Lnr5xkFz550nxxcjktwnc
        LliPt/XGeITbD552L+Q3C1UJCZ+I8CNaEy2N2/emHw==
X-Google-Smtp-Source: AFSGD/V1iqxAWyhgJZlBWmb/eoW6+lrCG3VgAy2gxGkP+QDXODZCCN243GoIeyy0Wj/G1FzHNc0cpRqgubPfto/ZsPg=
X-Received: by 2002:a9d:4682:: with SMTP id z2mr8780542ote.104.1544458055714;
 Mon, 10 Dec 2018 08:07:35 -0800 (PST)
MIME-Version: 1.0
References: <20181113111633.20189-1-jagan@amarulasolutions.com>
 <20181113111633.20189-9-jagan@amarulasolutions.com> <20181115095551.uctdkfmuwlnzhjnn@flea>
 <CAMty3ZAEHiovm6OF6JvJVQR4aqpG1Q3ML5YqxJkF2ntwRkUO=A@mail.gmail.com>
 <20181120155715.andrjp5kg6ugcv72@flea> <CAMty3ZCUOJmvekupOwh281g5HaazTpBbukWQY2Pv2OYypAwciw@mail.gmail.com>
 <20181127102450.b65jzhrdpxn5rxmk@flea> <CAMty3ZDTvn4VF_oOvEi2jCw9Rw5WPd1LQT3SZ5X1K0fJAFg2cQ@mail.gmail.com>
 <20181207132136.oa4nzpczytzxhl2d@flea>
In-Reply-To: <20181207132136.oa4nzpczytzxhl2d@flea>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Mon, 10 Dec 2018 21:37:23 +0530
Message-ID: <CAMty3ZB4uSxMETSrGbod54N++rimTmv1jNnCPKCy0PRa2e9WFw@mail.gmail.com>
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
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-amarula@amarulasolutions.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 7, 2018 at 6:51 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Tue, Nov 27, 2018 at 04:34:35PM +0530, Jagan Teki wrote:
> > On Tue, Nov 27, 2018 at 3:55 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > >
> > > On Tue, Nov 20, 2018 at 09:55:42PM +0530, Jagan Teki wrote:
> > > > On Tue, Nov 20, 2018 at 9:27 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > > > >
> > > > > On Thu, Nov 15, 2018 at 11:19:53PM +0530, Jagan Teki wrote:
> > > > > > On Thu, Nov 15, 2018 at 3:26 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > > > > > >
> > > > > > > Hi,
> > > > > > >
> > > > > > > On Tue, Nov 13, 2018 at 04:46:15PM +0530, Jagan Teki wrote:
> > > > > > > > The horizontal and vertical back porch calculation in BSP
> > > > > > > > code is simply following the Linux drm comment diagram, in
> > > > > > > > include/drm/drm_modes.h which is
> > > > > > > >
> > > > > > > > [hv]back porch = [hv]total - [hv]sync_end
> > > > > > > >
> > > > > > > > BSP code form BPI-M64-bsp is calculating vertical back porch as
> > > > > > > > (from linux-sunxi/drivers/video/sunxi/disp2/disp/de/disp_lcd.c)
> > > > > > > >
> > > > > > > > timmings->ver_sync_time= panel_info->lcd_vspw;
> > > > > > > > timmings->ver_back_porch= panel_info->lcd_vbp-panel_info->lcd_vspw;
> > > > > > > >
> > > > > > > > vbp = panel->lcd_vbp;
> > > > > > > > vspw = panel->lcd_vspw;
> > > > > > > > dsi_dev[sel]->dsi_basic_size0.bits.vbp = vbp-vspw;
> > > > > > > > dsi_dev[sel]->dsi_basic_size0.bits.vbp = panel->lcd_vbp - panel->lcd_vspw;
> > > > > > > > =>  timmings->ver_back_porch + panel_info->lcd_vspw - panel_info->lcd_vspw
> > > > > > > > =>  timmings->ver_back_porch
> > > > > > > > =>  mode->vtotal - mode->end
> > > > > > > >
> > > > > > > > Which evatually same as mode->vtotal - mode->vsync_end so update the
> > > > > > > > same in SUN6I_DSI_BASIC_SIZE0_VBP
> > > > > > > >
> > > > > > > > On the information note, existing SUN6I_DSI_BASIC_SIZE0_VSA is proper
> > > > > > > > value.
> > > > > > > >
> > > > > > > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > > > > >
> > > > > > > I've tested your changes on my A33 board, and this commit will break
> > > > > > > it.
> > > > > > >
> > > > > > > It creates vblank timeouts, and visual artifacts at the bottom of the
> > > > > > > display.
> > > > > >
> > > > > > Strange, VBP is earlier gives front porch which is anyway wrong.
> > > > > >
> > > > > > >
> > > > > > > Later commits seem to fix the issue, but will create some blanking on
> > > > > > > the upper third of the display.
> > > > > > >
> > > > > > > Since the documentation is quite sparse, and a MIPI-DSI analyzer is
> > > > > > > way too expensive, I'd really like to have at least what each of these
> > > > > > > commits are actually fixing, and what symptoms each of these were
> > > > > > > causing, and not just "the BSP does it".
> > > > > >
> > > > > > W/o this 2-lane panel is breaking, same vblank timeout and visual
> > > > > > artifacts at the bottom of the panel. though the commits may reference
> > > > > > BSP, I have at-least tested on 3 different panels for us to prove its
> > > > > > working.
> > > > > >
> > > > > > > Having some datasheet for the panels you had working would help too.
> > > > > >
> > > > > > Unfortunately datasheet doesn't have any required information what we
> > > > > > actually looking for.
> > > > >
> > > > > Not even the timings? How did you get that information then?
> > > >
> > > > datasheet has timing values, but this changes need controller
> > > > information about VBP register that I don't have. But again existing
> > > > VBP is not back porch for real, it's front porch.
> > >
> > > Yet, this breaks the existing setup. So again:
> >
> > Was it with 4-lane or 2-lane panel? can you test it with 2-lane panel?
> > I can see the issue on 2-lane but the 4-lane working fine with this
> > patch even.
>
> It's a 4 lane display.

Thanks, look like my panel timings seems reverse b/w BP and FP. It
work irrespective of this change after proper update.

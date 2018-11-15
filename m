Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60626C43610
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 17:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 294CF21780
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 17:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="mGSg0o5a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 294CF21780
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388686AbeKPD6y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 22:58:54 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:50700 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388329AbeKPD6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 22:58:54 -0500
Received: by mail-it1-f195.google.com with SMTP id k206-v6so30665328ite.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 09:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lzVf+6UowpPA9Enjuej5OPcuMEiQrM4vJQfW6U0CiU4=;
        b=mGSg0o5aQMIhhzY0VxyLE3f/+E+Nd8rvUUuD0Qg8BI34+4chnQFNB8H3k4cpMKAsc6
         zlXi0SG0Pg+YcZ/azKZT0+c007D5F9jPuEtE1nhYhCdRlm+etRY08Kii/+UCGOHhEq3/
         ft6Nx5vbk9rofCTUlnVi/ATvDuqO5EnZ99+5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lzVf+6UowpPA9Enjuej5OPcuMEiQrM4vJQfW6U0CiU4=;
        b=NGvahuLSuXEqIHK7d+PkxmwTBilGYxAu7joX+jA+YRWb9VnB62cdcxp1iGOxLwledp
         4s88UA++03Ysrgy036IOrXGvl8XN4aaw4O9Jxg4bw5uSfzRdghV6vmf+TpelyPmAFldV
         odUedjNIU1/Uh+ShzrZyntISQ84o9wq5ONTIB3Y7FSdpacm8WTivCf5JF9X0U+f5MY/0
         bNtjZwUyFbUiQy45X+n9tJIFnpaNSrqV5V/wtZL31G6vko93a6BzQWO9q01SzMczFoEQ
         D82Dqbpk24N5VF+jfKLfhaeXmb4gyesDhHSJ9kOeoIejNHb+LDU3E5y1e/TkRJrgUStw
         C6ew==
X-Gm-Message-State: AGRZ1gJopuHaxSZl1gm9IqBAAIQRG2evCBr4dUZ+rHXRc+lMRyL1qSCp
        HeIYVYl63J1H5aFixQvjukpJEEjeDxnxC6nfM7kP3Q==
X-Google-Smtp-Source: AJdET5cSlq6XyW86fAADkApH1dqU4qeMgUIsKox0mC02DlJLz2KDC9sn/zAzUB75Ls8+gQwtVGWCKUdk+pqRv6ITojE=
X-Received: by 2002:a05:660c:ac1:: with SMTP id k1mr6983496itl.173.1542304205538;
 Thu, 15 Nov 2018 09:50:05 -0800 (PST)
MIME-Version: 1.0
References: <20181113111633.20189-1-jagan@amarulasolutions.com>
 <20181113111633.20189-9-jagan@amarulasolutions.com> <20181115095551.uctdkfmuwlnzhjnn@flea>
In-Reply-To: <20181115095551.uctdkfmuwlnzhjnn@flea>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Thu, 15 Nov 2018 23:19:53 +0530
Message-ID: <CAMty3ZAEHiovm6OF6JvJVQR4aqpG1Q3ML5YqxJkF2ntwRkUO=A@mail.gmail.com>
Subject: Re: [PATCH v4 08/26] drm/sun4i: sun6i_mipi_dsi: Fix VBP size calculation
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

On Thu, Nov 15, 2018 at 3:26 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> Hi,
>
> On Tue, Nov 13, 2018 at 04:46:15PM +0530, Jagan Teki wrote:
> > The horizontal and vertical back porch calculation in BSP
> > code is simply following the Linux drm comment diagram, in
> > include/drm/drm_modes.h which is
> >
> > [hv]back porch = [hv]total - [hv]sync_end
> >
> > BSP code form BPI-M64-bsp is calculating vertical back porch as
> > (from linux-sunxi/drivers/video/sunxi/disp2/disp/de/disp_lcd.c)
> >
> > timmings->ver_sync_time= panel_info->lcd_vspw;
> > timmings->ver_back_porch= panel_info->lcd_vbp-panel_info->lcd_vspw;
> >
> > vbp = panel->lcd_vbp;
> > vspw = panel->lcd_vspw;
> > dsi_dev[sel]->dsi_basic_size0.bits.vbp = vbp-vspw;
> > dsi_dev[sel]->dsi_basic_size0.bits.vbp = panel->lcd_vbp - panel->lcd_vspw;
> > =>  timmings->ver_back_porch + panel_info->lcd_vspw - panel_info->lcd_vspw
> > =>  timmings->ver_back_porch
> > =>  mode->vtotal - mode->end
> >
> > Which evatually same as mode->vtotal - mode->vsync_end so update the
> > same in SUN6I_DSI_BASIC_SIZE0_VBP
> >
> > On the information note, existing SUN6I_DSI_BASIC_SIZE0_VSA is proper
> > value.
> >
> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
>
> I've tested your changes on my A33 board, and this commit will break
> it.
>
> It creates vblank timeouts, and visual artifacts at the bottom of the
> display.

Strange, VBP is earlier gives front porch which is anyway wrong.

>
> Later commits seem to fix the issue, but will create some blanking on
> the upper third of the display.
>
> Since the documentation is quite sparse, and a MIPI-DSI analyzer is
> way too expensive, I'd really like to have at least what each of these
> commits are actually fixing, and what symptoms each of these were
> causing, and not just "the BSP does it".

W/o this 2-lane panel is breaking, same vblank timeout and visual
artifacts at the bottom of the panel. though the commits may reference
BSP, I have at-least tested on 3 different panels for us to prove its
working.

>
> Having some datasheet for the panels you had working would help too.

Unfortunately datasheet doesn't have any required information what we
actually looking for.

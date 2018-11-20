Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B0A0C41536
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:25:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AAD1206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:25:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Rgcc9pYn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AAD1206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729851AbeKUCzw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 21:55:52 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:35000 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728384AbeKUCzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 21:55:52 -0500
Received: by mail-it1-f196.google.com with SMTP id v11so4453993itj.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 08:25:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fk4EEjIrrf8xUv7sP/UR7/oZ3RraEnGj9VOA8OqaJWw=;
        b=Rgcc9pYnFZP/SzS6EKcfIs0y51pVcviGdcDicMIwbGj/s5RU9UZpjHubtyio6mtGiL
         jejRWIcmjVncW4co+PC6ZFZYLArO+cX/I1aO4Co3M5qIbxDfskAnEmnx80u8+AmF0C28
         cDfOzdYLhdVxV/IXjjoGLGcCbghzD5Z7v46Bs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fk4EEjIrrf8xUv7sP/UR7/oZ3RraEnGj9VOA8OqaJWw=;
        b=NIsSRQ/b7C9UQCMKD3RPqJEryS2QJ9smFihdWif9KnDYbN9oIrakrF4O//JrpWo13C
         aXTvYgmZmHdhoy2Yljnc1iPKtvfr5YAqOqs5CjbyaJnk40XtjkNkGCt2h4erhZChq8ew
         2G1v5MOVH+WLVeZqztHZkOFd/sfWoQRfXVsjqoG23+9FArguecgLSRzAnpPbOkSThv6d
         Et1jXvXIOQQ5El8H1+dOQFwx/befXzLXsKW8+EzZgLnYX59w3+/Ths91pPSGuYvvRB/5
         EtpsPXLYaTzer703QlEFeeYEEC7S4rTa1MO5yPMkMV3IwhyxjzwhQEB79eEEd+Hie7eN
         qZFg==
X-Gm-Message-State: AA+aEWYM1mI5p4E3AdTYQjexrllIKOKkTP69bZZJ0Ank03FuMLBiW+3p
        nQrQpSlbyOOueLNfiGLyNqJ9TCBwPmdVB3wlE4auUA==
X-Google-Smtp-Source: AFSGD/U3NU/9KihC8YvJR7BAqODRxqCgrTuRerOfVESYRacO68Fmnz76RkdhyrcslDqUDh7sQN1gbDxb/2+M2oyCFgA=
X-Received: by 2002:a02:6242:: with SMTP id d63-v6mr2179584jac.103.1542731153662;
 Tue, 20 Nov 2018 08:25:53 -0800 (PST)
MIME-Version: 1.0
References: <20181113111633.20189-1-jagan@amarulasolutions.com>
 <20181113111633.20189-9-jagan@amarulasolutions.com> <20181115095551.uctdkfmuwlnzhjnn@flea>
 <CAMty3ZAEHiovm6OF6JvJVQR4aqpG1Q3ML5YqxJkF2ntwRkUO=A@mail.gmail.com> <20181120155715.andrjp5kg6ugcv72@flea>
In-Reply-To: <20181120155715.andrjp5kg6ugcv72@flea>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Tue, 20 Nov 2018 21:55:42 +0530
Message-ID: <CAMty3ZCUOJmvekupOwh281g5HaazTpBbukWQY2Pv2OYypAwciw@mail.gmail.com>
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

On Tue, Nov 20, 2018 at 9:27 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Thu, Nov 15, 2018 at 11:19:53PM +0530, Jagan Teki wrote:
> > On Thu, Nov 15, 2018 at 3:26 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > >
> > > Hi,
> > >
> > > On Tue, Nov 13, 2018 at 04:46:15PM +0530, Jagan Teki wrote:
> > > > The horizontal and vertical back porch calculation in BSP
> > > > code is simply following the Linux drm comment diagram, in
> > > > include/drm/drm_modes.h which is
> > > >
> > > > [hv]back porch = [hv]total - [hv]sync_end
> > > >
> > > > BSP code form BPI-M64-bsp is calculating vertical back porch as
> > > > (from linux-sunxi/drivers/video/sunxi/disp2/disp/de/disp_lcd.c)
> > > >
> > > > timmings->ver_sync_time= panel_info->lcd_vspw;
> > > > timmings->ver_back_porch= panel_info->lcd_vbp-panel_info->lcd_vspw;
> > > >
> > > > vbp = panel->lcd_vbp;
> > > > vspw = panel->lcd_vspw;
> > > > dsi_dev[sel]->dsi_basic_size0.bits.vbp = vbp-vspw;
> > > > dsi_dev[sel]->dsi_basic_size0.bits.vbp = panel->lcd_vbp - panel->lcd_vspw;
> > > > =>  timmings->ver_back_porch + panel_info->lcd_vspw - panel_info->lcd_vspw
> > > > =>  timmings->ver_back_porch
> > > > =>  mode->vtotal - mode->end
> > > >
> > > > Which evatually same as mode->vtotal - mode->vsync_end so update the
> > > > same in SUN6I_DSI_BASIC_SIZE0_VBP
> > > >
> > > > On the information note, existing SUN6I_DSI_BASIC_SIZE0_VSA is proper
> > > > value.
> > > >
> > > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > >
> > > I've tested your changes on my A33 board, and this commit will break
> > > it.
> > >
> > > It creates vblank timeouts, and visual artifacts at the bottom of the
> > > display.
> >
> > Strange, VBP is earlier gives front porch which is anyway wrong.
> >
> > >
> > > Later commits seem to fix the issue, but will create some blanking on
> > > the upper third of the display.
> > >
> > > Since the documentation is quite sparse, and a MIPI-DSI analyzer is
> > > way too expensive, I'd really like to have at least what each of these
> > > commits are actually fixing, and what symptoms each of these were
> > > causing, and not just "the BSP does it".
> >
> > W/o this 2-lane panel is breaking, same vblank timeout and visual
> > artifacts at the bottom of the panel. though the commits may reference
> > BSP, I have at-least tested on 3 different panels for us to prove its
> > working.
> >
> > > Having some datasheet for the panels you had working would help too.
> >
> > Unfortunately datasheet doesn't have any required information what we
> > actually looking for.
>
> Not even the timings? How did you get that information then?

datasheet has timing values, but this changes need controller
information about VBP register that I don't have. But again existing
VBP is not back porch for real, it's front porch.

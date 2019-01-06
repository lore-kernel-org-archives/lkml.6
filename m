Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D462CC43612
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 16:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1F322085A
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 16:29:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="qbyRdDrk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbfAFQ3Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 11:29:16 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:37623 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbfAFQ3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 11:29:16 -0500
Received: by mail-it1-f193.google.com with SMTP id b5so7282699iti.2
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jan 2019 08:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TKV0p0WiCpw6qO3c5kAhJMQNLPjT6ksNPdJwxNKMSuU=;
        b=qbyRdDrkrL8+wVP5kRFOrUd9GpbW6hfXwP3sikDl34Khjh8tn/NthFLOgIJkf+c4XS
         IdSQRufwXswLwN1MhuYnS8NuNrk7XI+8YnCuDzj+2oqTqLgIN2OiDyIyybqEjAydga/O
         8Z7V6o7tCpGvczj6oTFoH486mngVLnuAFE+Cg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TKV0p0WiCpw6qO3c5kAhJMQNLPjT6ksNPdJwxNKMSuU=;
        b=LudglFb1w0BrxgjNMtQuXdSYqygdsa/WI/hBtxy7f1mboTdPgah/cgr7CREjKycM8k
         8pt6i89Z0sHV2Cet2qLwKr8oxe3gY+alLdUjhCrri4s2D97GfP7Kab8rRW61jnss1303
         gSl9ArZJDuIK7w28w2puI4iXskisF+WIbnilVXtXblvb2ImjGQDSQAGjibmH6iwkvIt6
         6i4xBPL7TX0tFiqEub41T9zj/PNdn93O9uX/Q7OXsePD/z7dd9Swfjq198PhJlAu8dTA
         gI2l1oKb6xNmn9eQJF87ExtC7ej/ecB3oIZnMOmVIToB5rLRY24hbwk6r8OFPRANC5v0
         IDeg==
X-Gm-Message-State: AA+aEWa5b2z9UdZSnLtVTP7oOBWg7PMAbphJd8S6/XVaaUeTNyhlIm12
        0SeZmI/Vwj5gO47f5wA9Yme5rhTE5pdBiv2DyEcsW77X
X-Google-Smtp-Source: AFSGD/WO5KHvO8i5w4GQv2nQLGDMRwvYHfOS1klhTp/EzwMcl0Fka+F7cdD3WrsGhP7qljdVyDj0e2L0MRGYfdjDjtw=
X-Received: by 2002:a02:104a:: with SMTP id 71mr36368412jay.103.1546792155191;
 Sun, 06 Jan 2019 08:29:15 -0800 (PST)
MIME-Version: 1.0
References: <20181210161729.29720-1-jagan@amarulasolutions.com>
 <20181210161729.29720-8-jagan@amarulasolutions.com> <20181211164900.wfmkmbrbj3nmlb3h@flea>
 <CAMty3ZB5F5jD9iJT1soXSA5HtQOf5W9rKO9nCdGFUfVo0hpO4Q@mail.gmail.com>
In-Reply-To: <CAMty3ZB5F5jD9iJT1soXSA5HtQOf5W9rKO9nCdGFUfVo0hpO4Q@mail.gmail.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Sun, 6 Jan 2019 21:59:04 +0530
Message-ID: <CAMty3ZC_FqQUjTik_3+bUbk7pfy=KtxXac9AKBJH4g2cSnPF0g@mail.gmail.com>
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

On Fri, Dec 21, 2018 at 2:26 AM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> On Tue, Dec 11, 2018 at 10:19 PM Maxime Ripard
> <maxime.ripard@bootlin.com> wrote:
> >
> > On Mon, Dec 10, 2018 at 09:47:19PM +0530, Jagan Teki wrote:
> > > Video start delay can be computed by subtracting total vertical
> > > timing with front porch timing and with adding 1 delay line for TCON.
> > >
> > > BSP code form BPI-M64-bsp is computing video start delay as
> > > (from linux-sunxi/
> > > drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)
> > >
> > > u32 vfp = panel->lcd_vt - panel->lcd_y - panel->lcd_vbp;
> > > => (panel->lcd_vt) - panel->lcd_y - (panel->lcd_vbp)
> > > => (timmings->ver_front_porch + panel->lcd_vbp + panel->lcd_y)
> > >    - panel->lcd_y - (panel->lcd_vbp)
> > > => timmings->ver_front_porch + panel->lcd_vbp + panel->lcd_y
> > >                            - panel->lcd_y - panel->lcd_vbp
> > > => timmings->ver_front_porch
> > >
> > > So, update the start delay computation accordingly.
> > >
> > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> >
> > Even though it's a bit better now on my A33 board and I don't have the
> > white stripes on the bottom of the display, there's still some
> > flickering with your patches applied.
> >
> > Bisecting it seems to point at that patch, but reverting it doesn't
> > make the issue go away, so it's not really clear which one exactly is
> > at fault.
>
> Is reverting this patch, work fine or not?
>
> This patch is trying to make use of front porch instead of existing
> back porch to compute the delay. Since we revert the VBP fix patch[1]
> to assume VBP as VFP value look like your setup would also require to
> revert this change. But as per BSP or drm_mode details all of my
> displays even work with and w/o reverting these two.
>
> I'm thinking your display should work in the same behavior since the
> dsi controller making this route.

Any further comments on this?

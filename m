Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D1A9C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 19:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E16820811
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 19:43:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Sb05uGfb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E16820811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727204AbeLLTny (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 14:43:54 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:33908 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbeLLTny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 14:43:54 -0500
Received: by mail-it1-f195.google.com with SMTP id x124so14462596itd.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 11:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4O6JG1fVoPe87+m+7CKj+JrKSi1kqsDwdZDPItQ/pA0=;
        b=Sb05uGfbdr7z4FnGnb4D/kUUmIfzmo3odrVflDV1XVuhnZJPmNva5KvEQwonoUjaiB
         cwUNLq26JgT+KV7RJnvSOp0BHkRj5uFypzqd8Bt49rWLi+riB8+/okVk7ia6P+BsLNoF
         Y7Zxygg5zGL82coTqYvBobiDl6bdxOyA72YTI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4O6JG1fVoPe87+m+7CKj+JrKSi1kqsDwdZDPItQ/pA0=;
        b=lGqPwlHjGSV3GOFwhweSee2nU3o2QvjmE+EWL6APUYjmdOgIErU7/CM1wX4xpDZlIe
         Raja7zEJquQs9q/AgNLskAjGqNRrWRs2SbaKKPzhqAUhzccCxv9TP83JzhSFvHrxvHhL
         N1tUyZ6J+LPqE0Mh+YHA8cGNK+Qj0mFj8crKv1M7QSWm6dAyRjSG40TQiSuJcOOSZmk1
         8Yt9BOllZ7jN0HXjTUm8HuVNQZA6aHDl2AA2jlzxOQxVkpjIA8iI2cQDCImk6/yUjzGa
         5eYq1zqrJzQZN4UQ0Uxn9ufYFgb/lpq339QC/DTnYYW/FX26uktTlkPq0++DLtw3MVWE
         bE8g==
X-Gm-Message-State: AA+aEWY85Fou6196YJqqzXmIei/pqSvZFIXRqFwpQuQavdFMV9aDpDpA
        nq5t3FyB/bNPWx1hjNgmKkiaCGclamBuNy2q9Ioouw==
X-Google-Smtp-Source: AFSGD/WW7e7ICAd+v20UL5gdUicwYrot3Fa4beMJiVhdcY5ooGvbDA8745sOnShAYWDncU9ioD1jjIVU7VpW9Xhq5ps=
X-Received: by 2002:a24:4f07:: with SMTP id c7mr7161579itb.107.1544643833171;
 Wed, 12 Dec 2018 11:43:53 -0800 (PST)
MIME-Version: 1.0
References: <20181210161729.29720-1-jagan@amarulasolutions.com>
 <20181210161729.29720-8-jagan@amarulasolutions.com> <20181211164900.wfmkmbrbj3nmlb3h@flea>
 <CAMty3ZBzOyAGwgOZwArbvnqtcvwMkJrqwGQ-q7+XFX-BVs34RQ@mail.gmail.com>
In-Reply-To: <CAMty3ZBzOyAGwgOZwArbvnqtcvwMkJrqwGQ-q7+XFX-BVs34RQ@mail.gmail.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Thu, 13 Dec 2018 01:13:40 +0530
Message-ID: <CAMty3ZAKAOypCFNnoKNvgoZurS4+q1PLRjT_aA-zXh+h5MygvA@mail.gmail.com>
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

Hi Maxime,

On Tue, Dec 11, 2018 at 10:30 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
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
> >
> > So, just like I asked in your v4, twice,
> >
> > http://lists.infradead.org/pipermail/linux-arm-kernel/2018-November/615339.html
>
> I don't know how can I comment here. Not quite clearly understand your
> setup, because I have verified 3 different panels from different
> vendors one with 2-lane, another with 4-lane and one with video format
> and another one is burstmode format. I even verified with the clock
> rate and register details.
>
> Please suggest me, what can look further on this.

From the BSP point-of-view I couldn't find have any difference in
start_delay computation between A64, and A33[1]. In fact the driver
initialization code is same, here is A64 dsi driver[2].

1) The only difference that I observe is dsi_gen_wr in BSP [3], the
A33 is right shifting message tx length to 0, 8 for first and next
packet where as A64 did the same by adding +1 before.  Please try to
check that If your panel is using long write.  and
2) Also every dsi transaction in A33 occupy some delay code in
dsi_gen_wr[4], please check the same. and
3) Also If possible please check your panel timings or initialization
sequence, because I don't have any panel with A33.
4) other than these I have didn't notice any differences atleast from
my knowledge, Please suggest me where can I look further.

[1] https://github.com/BPI-SINOVOIP/BPI-M2M-bsp/blob/master/linux-sunxi/drivers/video/sunxi/disp/de/lowlevel_sun8iw5/de_dsi.c#L813
[2] https://github.com/BPI-SINOVOIP/BPI-M64-bsp/blob/master/linux-sunxi/drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c
[3] https://github.com/BPI-SINOVOIP/BPI-M2M-bsp/blob/master/linux-sunxi/drivers/video/sunxi/disp/de/lowlevel_sun8iw5/de_dsi.c#L402
[4] https://github.com/BPI-SINOVOIP/BPI-M2M-bsp/blob/master/linux-sunxi/drivers/video/sunxi/disp/de/lowlevel_sun8iw5/de_dsi.c#L378

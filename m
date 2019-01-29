Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B855BC282D0
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C5E521473
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:31:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Rs0akdsm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728513AbfA2Rbp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 12:31:45 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:44174 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727492AbfA2Rbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 12:31:44 -0500
Received: by mail-io1-f68.google.com with SMTP id r200so16959592iod.11
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 09:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bZh0qe15JVYEhdxehVf2IVz+a7AcDGhW0+jvnJqPk1M=;
        b=Rs0akdsmCMlEPTq9WHuH9kawCWMxee51GSzmmGmU8FOmCVbDxXNWzqQ4/lvjJ4UgM3
         9X+tFjCjaUTsp/4QhemzdFHHc08nRBAKIBHB1pPRaAuvqh/IMxcQ528J7DMaAoXwM8hR
         I2cr0BixknbZGOGPp+Z1sm8mre+8o4DaWo4xY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bZh0qe15JVYEhdxehVf2IVz+a7AcDGhW0+jvnJqPk1M=;
        b=MTSg7yutAfKNvRVA4g+0IV1wEiJh59SRUxB32HWD2Sn+4pC96sFueP7MmnXluRvNEC
         130Q2pGLsWFrEeBj5GKchAWO1eg6RRl32gAKzzWYJsNxfP9EzOLO/CF7pvxmkHBUmNtk
         vMRLXVcYwk8xRh42t5KhdIaszwm09pDyc8GQyH81TODXBn/9yH4eBDXorGnIzoWbESt3
         S5M0i6nScrL6VA0YadWZlbNCVP9iBB4L9JdTHdFMSq9A5Y4YYSBdJWscfd8q1fCsRk8b
         YK5CrKU6eM8J17Zu7B22aLD3ARUbiG53sXJr9sK41AKv5qWG6e4f6Lg2zxTWiOol62Fk
         KKuw==
X-Gm-Message-State: AHQUAuYtZbaU7FGCpkVzzBlAvSxV09A/5uD/AOIHDoUvhgyFiBo6citK
        rAd82FG01bpPTLhUWPtsE6dSnoQ4Qu4qEmXOmm+auw==
X-Google-Smtp-Source: AHgI3Ib6SZoISxrxWS5TsELBm2UfiVTshEipN4cOitSRdbmF6PAKVZDU+9CpAudCOkW2jLTPXxyLRJUpoZ+hjj+k3yE=
X-Received: by 2002:a6b:7a0a:: with SMTP id h10mr2413852iom.114.1548783103321;
 Tue, 29 Jan 2019 09:31:43 -0800 (PST)
MIME-Version: 1.0
References: <20190124195900.22620-1-jagan@amarulasolutions.com>
 <20190124195900.22620-12-jagan@amarulasolutions.com> <20190125212433.ni2jg3wvpyjazlxf@flea>
 <CAMty3ZAsH2iZ+JEqTE3D58aXfGuhMSg9YoO56ZhhOeE4c4yQHQ@mail.gmail.com> <20190129151348.mh27btttsqcmeban@flea>
In-Reply-To: <20190129151348.mh27btttsqcmeban@flea>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Tue, 29 Jan 2019 23:01:31 +0530
Message-ID: <CAMty3ZAjAoti8Zu80c=OyCA+u-jtQnkidsKSNz_c2OaRswqc3w@mail.gmail.com>
Subject: Re: [PATCH v6 11/22] clk: sunxi-ng: a64: Add minimum rate for PLL_MIPI
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Chen-Yu Tsai <wens@csie.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-amarula@amarulasolutions.com,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 8:43 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Mon, Jan 28, 2019 at 03:06:10PM +0530, Jagan Teki wrote:
> > On Sat, Jan 26, 2019 at 2:54 AM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > >
> > > On Fri, Jan 25, 2019 at 01:28:49AM +0530, Jagan Teki wrote:
> > > > Minimum PLL used for MIPI is 500MHz, as per manual, but
> > > > lowering the min rate by 300MHz can result proper working
> > > > nkms divider with the help of desired dclock rate from
> > > > panel driver.
> > > >
> > > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > > Acked-by: Stephen Boyd <sboyd@kernel.org>
> > >
> > > Going 200MHz below the minimum doesn't seem really reasonable. What
> > > is the issue that you are trying to fix here?
> > >
> > > It looks like it's picking bad dividers, but if that's the case, this
> > > isn't the proper fix.
> >
> > As I stated in earlier patches, the whole idea is pick the desired
> > dclk divider based dclk rate. So the dotclock, sun4i_dclk_round_rate
> > is unable to get the proper dclk divider at the end, so it eventually
> > picking up wrong divider value and fired vblank timeout.
> >
> > So, we come-up with optimal and working min_rate 300MHz in pll-mipi to
> > get the desired clock something like below.
> > [    2.415773] [drm] No driver support for vblank timestamp query.
> > [    2.424116] sun4i_dclk_round_rate: min_div = 4 max_div = 127, rate = 55000000
> > [    2.424172] ideal = 220000000, rounded = 0
> > [    2.424176] ideal = 275000000, rounded = 0
> > [    2.424194] ccu_nkm_round_rate: rate = 330000000
> > [    2.424197] ideal = 330000000, rounded = 330000000
> > [    2.424201] sun4i_dclk_round_rate: div = 6 rate = 55000000
> > [    2.424205] sun4i_dclk_round_rate: min_div = 4 max_div = 127, rate = 55000000
> > [    2.424209] ideal = 220000000, rounded = 0
> > [    2.424213] ideal = 275000000, rounded = 0
> > [    2.424230] ccu_nkm_round_rate: rate = 330000000
> > [    2.424233] ideal = 330000000, rounded = 330000000
> > [    2.424236] sun4i_dclk_round_rate: div = 6 rate = 55000000
> > [    2.424253] ccu_nkm_round_rate: rate = 330000000
> > [    2.424270] ccu_nkm_round_rate: rate = 330000000
> > [    2.424278] sun4i_dclk_recalc_rate: val = 1, rate = 330000000
> > [    2.424281] sun4i_dclk_recalc_rate: val = 1, rate = 330000000
> > [    2.424306] ccu_nkm_set_rate: rate = 330000000, parent_rate = 297000000
> > [    2.424309] ccu_nkm_set_rate: _nkm.n = 5
> > [    2.424311] ccu_nkm_set_rate: _nkm.k = 2
> > [    2.424313] ccu_nkm_set_rate: _nkm.m = 9
> > [    2.424661] sun4i_dclk_set_rate div 6
> > [    2.424668] sun4i_dclk_recalc_rate: val = 6, rate = 55000000
> >
> > But look like this wouldn't valid for all other dclock rates, say BPI
> > panel has 30MHz clock that would failed with this logic.
> >
> > On the other side Allwinner BSP calculating dclk divider based on the
> > SoC's. for A33 [1] it is fixed dclk divider of 4 and for A64 is is
> > calculated based on the bpp/lanes.
>
> It looks like the A64 has the same divider of 4:
> https://github.com/BPI-SINOVOIP/BPI-M64-bsp/blob/master/linux-sunxi/drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c#L12
>
> I think you're confusing it with the ratio between the pixel clock and
> the dotclock, called dsi_div:
> https://github.com/BPI-SINOVOIP/BPI-M64-bsp/blob/master/linux-sunxi/drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/disp_al.c#L198

Ahh.. I thought this initially but as far as DSI clock computation is
concern, the L12 tcon_div is local variable which is used for edge0
computation in burst mode and not for the dsi clock computation. Since
the BSP is unable to get the tcon_div during edge0 computation, they
defined it locally I think.

You can see the lcd_clk_config() code [2], where we can see DSI clock
computation using dsi_div value.

Here is dump after the in Line 792 which is after computation[3]
[   10.800737] lcd_clk_config: dsi_div = 6, tcon_div = 4, lcd_div = 1
[   10.800743] lcd_clk_config: lcd_dclk_freq = 55, dclk_rate = 55000000
[   10.800749] lcd_clk_config: lcd_rate = 330000000, pll_rate = 330000000

The above dump the lcd_rate 330MHz is computed with panel clock, 55MHz
into dsi_div 6. So this can be our actual divider values dclk_min_div,
dclk_max_div in sun4i_dclk_round_rate (from
drivers/gpu/drm/sun4i/sun4i_dotclock.c)

We can even confirm this from Mainline code:
[    1.866128] sun4i_dclk_round_rate: min_div = 6 max_div = 6, rate = 55000000
[    1.873112] round_rate, parent = 330000000
[    1.877351] round_rate, rate = 330000000
[    1.881338] ideal = 330000000, rounded = 330000000, div = 6
[    1.887232] sun4i_dclk_round_rate: div = 6 rate = 55000000
[    1.887239] sun4i_dclk_round_rate: min_div = 6 max_div = 6, rate = 55000000
[    1.887243] round_rate, parent = 330000000
[    1.887259] round_rate, rate = 330000000
[    1.887264] ideal = 330000000, rounded = 330000000, div = 6
[    1.887267] sun4i_dclk_round_rate: div = 6 rate = 55000000
[    1.887270] round_rate, parent = 330000000
[    1.887286] round_rate, rate = 330000000
[    1.887292] round_rate, parent = 330000000
[    1.887307] round_rate, rate = 330000000
[    1.887320] sun4i_dclk_recalc_rate: val = 1, rate = 330000000
[    1.887324] sun4i_dclk_recalc_rate: val = 1, rate = 330000000
[    1.887350] rate = 330000000
[    1.887353] parent_rate = 297000000
[    1.887355] reg = 0x80c00000
[    1.887359] _nkm.n = 5, nkm->n.offset = 0x1, nkm->n.shift = 8
[    1.887362] _nkm.k = 2, nkm->k.offset = 0x1, nkm->k.shift = 4
[    1.887365] _nkm.m = 9, nkm->m.offset = 0x1, nkm->m.shift = 0
[    1.887712] sun4i_dclk_set_rate div 6
[    1.887720] sun4i_dclk_recalc_rate: val = 6, rate = 55000000

So, the dsi_div from AW BSP is our dclk_mini_div(and dclk_max_div) and
that can be computed as format/lanes in A64.

Hope this explaining clears the diff, let me know if I miss anything.

[2] https://github.com/BPI-SINOVOIP/BPI-M64-bsp/blob/master/linux-sunxi/drivers/video/sunxi/disp2/disp/de/disp_lcd.c#L781
[3] https://github.com/BPI-SINOVOIP/BPI-M64-bsp/blob/master/linux-sunxi/drivers/video/sunxi/disp2/disp/de/disp_lcd.c#L792

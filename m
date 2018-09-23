Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B5AC433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 19:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F5C920989
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 19:29:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F5C920989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbeIXB2O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 21:28:14 -0400
Received: from mailoutvs26.siol.net ([185.57.226.217]:59976 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726437AbeIXB2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 21:28:14 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id B83595212F6;
        Sun, 23 Sep 2018 21:29:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta11.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta11.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id foB23Ch5Y_WU; Sun, 23 Sep 2018 21:29:57 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 58824521256;
        Sun, 23 Sep 2018 21:29:57 +0200 (CEST)
Received: from jernej-laptop.localnet (cpe1-8-82.cable.triera.net [213.161.8.82])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPA id 89C385211EF;
        Sun, 23 Sep 2018 21:29:55 +0200 (CEST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Subject: Re: [PATCH 21/27] drm/sun4i: Add support for H6 HDMI PHY
Date:   Sun, 23 Sep 2018 21:29:33 +0200
Message-ID: <3593541.d8rxrvbqPe@jernej-laptop>
In-Reply-To: <CAGb2v66RqR3pGh+1_rnvMQ4LJaSkKmky9D36tdxQS7cyJb6GYA@mail.gmail.com>
References: <20180902072643.4917-1-jernej.skrabec@siol.net> <20180902072643.4917-22-jernej.skrabec@siol.net> <CAGb2v66RqR3pGh+1_rnvMQ4LJaSkKmky9D36tdxQS7cyJb6GYA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne sobota, 22. september 2018 ob 17:55:35 CEST je Chen-Yu Tsai napisal(a):
> On Sun, Sep 2, 2018 at 3:28 PM Jernej Skrabec <jernej.skrabec@siol.net> 
wrote:
> > H6 has Synopsys DWC HDMI 2.0 TX PHY.
> > 
> > mpll settings were calculated from specifications of similar Synopsys
> > HDMI PHY found in i.MX6. Other PHY settings were derived from BSP PHY
> > driver code.
> > 
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > ---
> > 
> >  drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c | 137 +++++++++++++++++++++++++
> >  1 file changed, 137 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
> > b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c index ee2bf61cd4d2..2f5499bd35ec
> > 100644
> > --- a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
> > +++ b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
> > @@ -14,6 +14,122 @@
> > 
> >   */
> >  
> >  #define I2C_ADDR       0x69
> > 
> > +static const struct dw_hdmi_mpll_config sun50i_h6_mpll_cfg[] = {
> 
> How did you choose the pixel clock points for this table? The values
> sort of match up with the BSP.

I used this script:
https://chromium.googlesource.com/chromiumos/platform/drm-tests/+/master/
rk3288_hdmitables.py

I forgot already how I came to conclusion that there are identical register 
settings. After all, imx6 manual describes DWC HDMI PHY and it seems that 
settings are identical for DWC HDMI PHY contained in imx6, rk3288 and h6.

Check out that script, it has some explanation how values are calculated.

Part of the reason why I didn't use original settings is that it is pain to 
convert BSP PHY settings table to this form. Not all frequencies have settings 
for 8, 10 and 12 bit depth.

> 
> > +       {
> > +               30666000, {
> > +                       { 0x00b3, 0x0000 },
> > +                       { 0x2153, 0x0000 },
> > +                       { 0x40f3, 0x0000 },
> > +               },
> > +       },  {
> > +               36800000, {
> > +                       { 0x00b3, 0x0000 },
> > +                       { 0x2153, 0x0000 },
> > +                       { 0x40a2, 0x0001 },
> > +               },
> > +       },  {
> > +               46000000, {
> > +                       { 0x00b3, 0x0000 },
> > +                       { 0x2142, 0x0001 },
> > +                       { 0x40a2, 0x0001 },
> > +               },
> > +       },  {
> > +               61333000, {
> > +                       { 0x0072, 0x0001 },
> > +                       { 0x2142, 0x0001 },
> > +                       { 0x40a2, 0x0001 },
> > +               },
> > +       },  {
> > +               73600000, {
> > +                       { 0x0072, 0x0001 },
> > +                       { 0x2142, 0x0001 },
> > +                       { 0x4061, 0x0002 },
> > +               },
> > +       },  {
> > +               92000000, {
> > +                       { 0x0072, 0x0001 },
> > +                       { 0x2145, 0x0002 },
> > +                       { 0x4061, 0x0002 },
> > +               },
> > +       },  {
> > +               122666000, {
> > +                       { 0x0051, 0x0002 },
> > +                       { 0x2145, 0x0002 },
> > +                       { 0x4061, 0x0002 },
> > +               },
> > +       },  {
> > +               147200000, {
> > +                       { 0x0051, 0x0002 },
> > +                       { 0x2145, 0x0002 },
> > +                       { 0x4064, 0x0003 },
> > +               },
> > +       },  {
> > +               184000000, {
> > +                       { 0x0051, 0x0002 },
> > +                       { 0x214c, 0x0003 },
> > +                       { 0x4064, 0x0003 },
> > +               },
> > +       },  {
> > +               226666000, {
> > +                       { 0x0040, 0x0003 },
> > +                       { 0x214c, 0x0003 },
> > +                       { 0x4064, 0x0003 },
> > +               },
> > +       },  {
> > +               272000000, {
> > +                       { 0x0040, 0x0003 },
> > +                       { 0x214c, 0x0003 },
> > +                       { 0x5a64, 0x0003 },
> > +               },
> > +       },  {
> > +               340000000, {
> > +                       { 0x0040, 0x0003 },
> > +                       { 0x3b4c, 0x0003 },
> > +                       { 0x5a64, 0x0003 },
> > +               },
> > +       },  {
> > +               600000000, {
> 
> 594000000 is the proper clock rate.
> 
> > +                       { 0x1a40, 0x0003 },
> > +                       { 0x3b4c, 0x0003 },
> > +                       { 0x5a64, 0x0003 },
> > +               },
> > +       }, {
> > +               ~0UL, {
> > +                       { 0x0000, 0x0000 },
> > +                       { 0x0000, 0x0000 },
> > +                       { 0x0000, 0x0000 },
> > +               },
> > +       }
> > +};
> > +
> > +static const struct dw_hdmi_curr_ctrl sun50i_h6_cur_ctr[] = {
> 
> The BSP sometimes uses different settings depending on the pixel repetition.
> Any ideas about this? I assume it's because the TMDS clock changes as a
> result of pixel repetition, as is the same with different bit depths.

No, no idea. As I said before, I went easy way out using script mentioned 
before.

> > +       /* pixelclk    bpp8    bpp10   bpp12 */
> > +       { 25175000,  { 0x0000, 0x0000, 0x0000 }, },
> > +       { 27000000,  { 0x0012, 0x0000, 0x0000 }, },
> > +       { 59400000,  { 0x0008, 0x0008, 0x0008 }, },
> > +       { 72000000,  { 0x0008, 0x0008, 0x001b }, },
> > +       { 74250000,  { 0x0013, 0x0013, 0x0013 }, },
> > +       { 90000000,  { 0x0008, 0x001a, 0x001b }, },
> > +       { 118800000, { 0x001b, 0x001a, 0x001b }, },
> > +       { 144000000, { 0x001b, 0x001a, 0x0034 }, },
> > +       { 180000000, { 0x001b, 0x0033, 0x0034 }, },
> > +       { 216000000, { 0x0036, 0x0033, 0x0034 }, },
> > +       { 237600000, { 0x0036, 0x0033, 0x001b }, },
> > +       { 288000000, { 0x0036, 0x001b, 0x001b }, },
> > +       { 297000000, { 0x0019, 0x001b, 0x0019 }, },
> > +       { 330000000, { 0x0036, 0x001b, 0x001b }, },
> > +       { 600000000, { 0x003f, 0x001b, 0x001b }, },
> > +       { ~0UL,      { 0x0000, 0x0000, 0x0000 }, }
> > +};
> > +
> > +static const struct dw_hdmi_phy_config sun50i_h6_phy_config[] = {
> > +       /*pixelclk   symbol   term   vlev*/
> 
> I see a slightly different setting for 27000000, and this frequency
> below 74250000
> only, and even different for all three bit depths (not listed here). So:
> 
>     { 25175000,  0x8009, 0x0004, 0x0232 },
>     { 27000000,  0x8009, 0x0007, 0x02b0 },
> 
> And,
> 
> > +       { 74250000,  0x8009, 0x0004, 0x0232},
> > +       { 148500000, 0x8029, 0x0004, 0x0273},
> 
> These two don't match what I see in the BSP. BTW, which table did you use?
> phy301 or phy303? The code seems to indicate that model 301 is the one.
> 

yes, BSP uses 301.

Best regards,
Jernej

> > +       { 600000000, 0x8039, 0x0004, 0x014a},
> 
> 594000000 is the proper pixel clock you're after.
> 
> > +       { ~0UL,      0x0000, 0x0000, 0x0000}
> > +};
> > +
> > 
> >  static int sun8i_hdmi_phy_config_a83t(struct dw_hdmi *hdmi,
> >  
> >                                       struct sun8i_hdmi_phy *phy,
> >                                       unsigned int clk_rate)
> > 
> > @@ -290,6 +406,16 @@ static void sun8i_hdmi_phy_unlock(struct
> > sun8i_hdmi_phy *phy)> 
> >                      SUN8I_HDMI_PHY_UNSCRAMBLE_MAGIC);
> >  
> >  }
> > 
> > +static void sun50i_hdmi_phy_init_h6(struct sun8i_hdmi_phy *phy)
> > +{
> > +       regmap_update_bits(phy->regs, SUN8I_HDMI_PHY_REXT_CTRL_REG,
> > +                          SUN8I_HDMI_PHY_REXT_CTRL_REXT_EN,
> > +                          SUN8I_HDMI_PHY_REXT_CTRL_REXT_EN);
> > +
> > +       regmap_update_bits(phy->regs, SUN8I_HDMI_PHY_REXT_CTRL_REG,
> > +                          0xffff0000, 0x80c00000);
> > +}
> > +
> > 
> >  static void sun8i_hdmi_phy_init_a83t(struct sun8i_hdmi_phy *phy)
> >  {
> >  
> >         sun8i_hdmi_phy_unlock(phy);
> > 
> > @@ -423,6 +549,13 @@ static const struct sun8i_hdmi_phy_variant
> > sun50i_a64_hdmi_phy = {> 
> >         .phy_config = &sun8i_hdmi_phy_config_h3,
> >  
> >  };
> > 
> > +static const struct sun8i_hdmi_phy_variant sun50i_h6_hdmi_phy = {
> > +       .cur_ctr  = sun50i_h6_cur_ctr,
> > +       .mpll_cfg = sun50i_h6_mpll_cfg,
> > +       .phy_cfg  = sun50i_h6_phy_config,
> > +       .phy_init = &sun50i_hdmi_phy_init_h6,
> > +};
> > +
> > 
> >  static const struct sun8i_hdmi_phy_variant sun8i_a83t_hdmi_phy = {
> >  
> >         .is_custom_phy = true,
> >         .phy_init = &sun8i_hdmi_phy_init_a83t,
> > 
> > @@ -443,6 +576,10 @@ static const struct of_device_id
> > sun8i_hdmi_phy_of_table[] = {> 
> >                 .compatible = "allwinner,sun50i-a64-hdmi-phy",
> >                 .data = &sun50i_a64_hdmi_phy,
> >         
> >         },
> > 
> > +       {
> > +               .compatible = "allwinner,sun50i-h6-hdmi-phy",
> > +               .data = &sun50i_h6_hdmi_phy,
> > +       },
> 
> Version sort please.
> 
> Regards
> ChenYu
> 
> >         {
> >         
> >                 .compatible = "allwinner,sun8i-a83t-hdmi-phy",
> >                 .data = &sun8i_a83t_hdmi_phy,
> > 
> > --
> > 2.18.0
> 
> On Sun, Sep 2, 2018 at 3:28 PM Jernej Skrabec <jernej.skrabec@siol.net> 
wrote:
> > H6 has Synopsys DWC HDMI 2.0 TX PHY.
> > 
> > mpll settings were calculated from specifications of similar Synopsys
> > HDMI PHY found in i.MX6. Other PHY settings were derived from BSP PHY
> > driver code.
> > 
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > ---
> > 
> >  drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c | 137 +++++++++++++++++++++++++
> >  1 file changed, 137 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
> > b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c index ee2bf61cd4d2..2f5499bd35ec
> > 100644
> > --- a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
> > +++ b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
> > @@ -14,6 +14,122 @@
> > 
> >   */
> >  
> >  #define I2C_ADDR       0x69
> > 
> > +static const struct dw_hdmi_mpll_config sun50i_h6_mpll_cfg[] = {
> > +       {
> > +               30666000, {
> > +                       { 0x00b3, 0x0000 },
> > +                       { 0x2153, 0x0000 },
> > +                       { 0x40f3, 0x0000 },
> > +               },
> > +       },  {
> > +               36800000, {
> > +                       { 0x00b3, 0x0000 },
> > +                       { 0x2153, 0x0000 },
> > +                       { 0x40a2, 0x0001 },
> > +               },
> > +       },  {
> > +               46000000, {
> > +                       { 0x00b3, 0x0000 },
> > +                       { 0x2142, 0x0001 },
> > +                       { 0x40a2, 0x0001 },
> > +               },
> > +       },  {
> > +               61333000, {
> > +                       { 0x0072, 0x0001 },
> > +                       { 0x2142, 0x0001 },
> > +                       { 0x40a2, 0x0001 },
> > +               },
> > +       },  {
> > +               73600000, {
> > +                       { 0x0072, 0x0001 },
> > +                       { 0x2142, 0x0001 },
> > +                       { 0x4061, 0x0002 },
> > +               },
> > +       },  {
> > +               92000000, {
> > +                       { 0x0072, 0x0001 },
> > +                       { 0x2145, 0x0002 },
> > +                       { 0x4061, 0x0002 },
> > +               },
> > +       },  {
> > +               122666000, {
> > +                       { 0x0051, 0x0002 },
> > +                       { 0x2145, 0x0002 },
> > +                       { 0x4061, 0x0002 },
> > +               },
> > +       },  {
> > +               147200000, {
> > +                       { 0x0051, 0x0002 },
> > +                       { 0x2145, 0x0002 },
> > +                       { 0x4064, 0x0003 },
> > +               },
> > +       },  {
> > +               184000000, {
> > +                       { 0x0051, 0x0002 },
> > +                       { 0x214c, 0x0003 },
> > +                       { 0x4064, 0x0003 },
> > +               },
> > +       },  {
> > +               226666000, {
> > +                       { 0x0040, 0x0003 },
> > +                       { 0x214c, 0x0003 },
> > +                       { 0x4064, 0x0003 },
> > +               },
> > +       },  {
> > +               272000000, {
> > +                       { 0x0040, 0x0003 },
> > +                       { 0x214c, 0x0003 },
> > +                       { 0x5a64, 0x0003 },
> > +               },
> > +       },  {
> > +               340000000, {
> > +                       { 0x0040, 0x0003 },
> > +                       { 0x3b4c, 0x0003 },
> > +                       { 0x5a64, 0x0003 },
> > +               },
> > +       },  {
> > +               600000000, {
> > +                       { 0x1a40, 0x0003 },
> > +                       { 0x3b4c, 0x0003 },
> > +                       { 0x5a64, 0x0003 },
> > +               },
> > +       }, {
> > +               ~0UL, {
> > +                       { 0x0000, 0x0000 },
> > +                       { 0x0000, 0x0000 },
> > +                       { 0x0000, 0x0000 },
> > +               },
> > +       }
> > +};
> > +
> > +static const struct dw_hdmi_curr_ctrl sun50i_h6_cur_ctr[] = {
> > +       /* pixelclk    bpp8    bpp10   bpp12 */
> > +       { 25175000,  { 0x0000, 0x0000, 0x0000 }, },
> > +       { 27000000,  { 0x0012, 0x0000, 0x0000 }, },
> > +       { 59400000,  { 0x0008, 0x0008, 0x0008 }, },
> > +       { 72000000,  { 0x0008, 0x0008, 0x001b }, },
> > +       { 74250000,  { 0x0013, 0x0013, 0x0013 }, },
> > +       { 90000000,  { 0x0008, 0x001a, 0x001b }, },
> > +       { 118800000, { 0x001b, 0x001a, 0x001b }, },
> > +       { 144000000, { 0x001b, 0x001a, 0x0034 }, },
> > +       { 180000000, { 0x001b, 0x0033, 0x0034 }, },
> > +       { 216000000, { 0x0036, 0x0033, 0x0034 }, },
> > +       { 237600000, { 0x0036, 0x0033, 0x001b }, },
> > +       { 288000000, { 0x0036, 0x001b, 0x001b }, },
> > +       { 297000000, { 0x0019, 0x001b, 0x0019 }, },
> > +       { 330000000, { 0x0036, 0x001b, 0x001b }, },
> > +       { 600000000, { 0x003f, 0x001b, 0x001b }, },
> > +       { ~0UL,      { 0x0000, 0x0000, 0x0000 }, }
> > +};
> > +
> > +static const struct dw_hdmi_phy_config sun50i_h6_phy_config[] = {
> > +       /*pixelclk   symbol   term   vlev*/
> > +       { 74250000,  0x8009, 0x0004, 0x0232},
> > +       { 148500000, 0x8029, 0x0004, 0x0273},
> > +       { 600000000, 0x8039, 0x0004, 0x014a},
> > +       { ~0UL,      0x0000, 0x0000, 0x0000}
> > +};
> > +
> > 
> >  static int sun8i_hdmi_phy_config_a83t(struct dw_hdmi *hdmi,
> >  
> >                                       struct sun8i_hdmi_phy *phy,
> >                                       unsigned int clk_rate)
> > 
> > @@ -290,6 +406,16 @@ static void sun8i_hdmi_phy_unlock(struct
> > sun8i_hdmi_phy *phy)> 
> >                      SUN8I_HDMI_PHY_UNSCRAMBLE_MAGIC);
> >  
> >  }
> > 
> > +static void sun50i_hdmi_phy_init_h6(struct sun8i_hdmi_phy *phy)
> > +{
> > +       regmap_update_bits(phy->regs, SUN8I_HDMI_PHY_REXT_CTRL_REG,
> > +                          SUN8I_HDMI_PHY_REXT_CTRL_REXT_EN,
> > +                          SUN8I_HDMI_PHY_REXT_CTRL_REXT_EN);
> > +
> > +       regmap_update_bits(phy->regs, SUN8I_HDMI_PHY_REXT_CTRL_REG,
> > +                          0xffff0000, 0x80c00000);
> > +}
> > +
> > 
> >  static void sun8i_hdmi_phy_init_a83t(struct sun8i_hdmi_phy *phy)
> >  {
> >  
> >         sun8i_hdmi_phy_unlock(phy);
> > 
> > @@ -423,6 +549,13 @@ static const struct sun8i_hdmi_phy_variant
> > sun50i_a64_hdmi_phy = {> 
> >         .phy_config = &sun8i_hdmi_phy_config_h3,
> >  
> >  };
> > 
> > +static const struct sun8i_hdmi_phy_variant sun50i_h6_hdmi_phy = {
> > +       .cur_ctr  = sun50i_h6_cur_ctr,
> > +       .mpll_cfg = sun50i_h6_mpll_cfg,
> > +       .phy_cfg  = sun50i_h6_phy_config,
> > +       .phy_init = &sun50i_hdmi_phy_init_h6,
> > +};
> > +
> > 
> >  static const struct sun8i_hdmi_phy_variant sun8i_a83t_hdmi_phy = {
> >  
> >         .is_custom_phy = true,
> >         .phy_init = &sun8i_hdmi_phy_init_a83t,
> > 
> > @@ -443,6 +576,10 @@ static const struct of_device_id
> > sun8i_hdmi_phy_of_table[] = {> 
> >                 .compatible = "allwinner,sun50i-a64-hdmi-phy",
> >                 .data = &sun50i_a64_hdmi_phy,
> >         
> >         },
> > 
> > +       {
> > +               .compatible = "allwinner,sun50i-h6-hdmi-phy",
> > +               .data = &sun50i_h6_hdmi_phy,
> > +       },
> > 
> >         {
> >         
> >                 .compatible = "allwinner,sun8i-a83t-hdmi-phy",
> >                 .data = &sun8i_a83t_hdmi_phy,
> > 
> > --
> > 2.18.0





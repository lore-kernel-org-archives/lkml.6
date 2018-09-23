Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4516AECE560
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 19:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0540B20989
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 19:40:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0540B20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbeIXBin (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 21:38:43 -0400
Received: from mailoutvs35.siol.net ([185.57.226.226]:59133 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726917AbeIXBin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 21:38:43 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 9E18F5204F3;
        Sun, 23 Sep 2018 21:40:13 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta10.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta10.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id zbR7ONr2fPFs; Sun, 23 Sep 2018 21:40:13 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id E935C52122A;
        Sun, 23 Sep 2018 21:40:12 +0200 (CEST)
Received: from jernej-laptop.localnet (cpe1-8-82.cable.triera.net [213.161.8.82])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPA id B11CE5204F3;
        Sun, 23 Sep 2018 21:40:11 +0200 (CEST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     linux-sunxi@googlegroups.com, wens@csie.org
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
        dri-devel <dri-devel@lists.freedesktop.org>
Subject: Re: [linux-sunxi] Re: [PATCH 13/27] drm/sun4i: Add support for H6 DE3 mixer 0
Date:   Sun, 23 Sep 2018 21:40:02 +0200
Message-ID: <6201242.bzTTWRITmP@jernej-laptop>
In-Reply-To: <CAGb2v65LzGgXORTx7PR+udZsrgGgmnXeaOW-jb=KMjHjTg7bRg@mail.gmail.com>
References: <20180902072643.4917-1-jernej.skrabec@siol.net> <CAGb2v66kp4B5VZfmTc8L6qt=OPHjbYBtXRbC=L6jGTzvEKvb=w@mail.gmail.com> <CAGb2v65LzGgXORTx7PR+udZsrgGgmnXeaOW-jb=KMjHjTg7bRg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne sobota, 22. september 2018 ob 15:47:03 CEST je Chen-Yu Tsai napisal(a):
> On Sat, Sep 22, 2018 at 9:23 PM Chen-Yu Tsai <wens@csie.org> wrote:
> > On Sun, Sep 2, 2018 at 3:27 PM Jernej Skrabec <jernej.skrabec@siol.net> 
wrote:
> > > Mixer 0 has 1 VI and 3 UI planes, scaler on all planes and can output
> > > 4K image @60Hz. It also support 10 bit colors.
> > 
> > AFAICT 10 bit color support is not implemented? Please mention this.

ok.

> > 
> > > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > > ---
> > > 
> > >  drivers/gpu/drm/sun4i/sun8i_mixer.c | 13 +++++++++++++
> > >  1 file changed, 13 insertions(+)
> > > 
> > > diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c
> > > b/drivers/gpu/drm/sun4i/sun8i_mixer.c index a9218abf0935..54eca2dd4b33
> > > 100644
> > > --- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
> > > +++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
> > > @@ -540,6 +540,15 @@ static int sun8i_mixer_remove(struct
> > > platform_device *pdev)> > 
> > >         return 0;
> > >  
> > >  }
> > > 
> > > +static const struct sun8i_mixer_cfg sun50i_h6_mixer0_cfg = {
> > 
> > Please sort the per-compatible structures according to "version sort"
> > rules.> 
> > > +       .ccsc           = 0,
> > > +       .is_de3         = true,
> > > +       .mod_rate       = 600000000,
> > > +       .scaler_mask    = 0xf,
> > > +       .ui_num         = 3,
> > > +       .vi_num         = 1,
> > > +};
> > > +
> > > 
> > >  static const struct sun8i_mixer_cfg sun8i_a83t_mixer0_cfg = {
> > >  
> > >         .ccsc           = 0,
> > >         .scaler_mask    = 0xf,
> > > 
> > > @@ -587,6 +596,10 @@ static const struct sun8i_mixer_cfg
> > > sun8i_v3s_mixer_cfg = {> > 
> > >  };
> > >  
> > >  static const struct of_device_id sun8i_mixer_of_table[] = {
> > > 
> > > +       {
> > > +               .compatible = "allwinner,sun50i-h6-de3-mixer-0",
> > > +               .data = &sun50i_h6_mixer0_cfg,
> > > +       },
> > 
> > Same here.
> > 
> > ChenYu
> 
> BTW, DE 3.0 includes a register in DE TOP called "DE IP configure register",
> which gives the number of IP blocks per class, per mixer. If we retrieve
> the configuration from this register, then we shouldn't need to
> differentiate between mixer-0 and mixer-1 with compatible strings.
> 
> What do you think?

IIRC, not all setting were correct when read from registers, but I would need 
to check again. I'm also not sure if register holds all possible settings, so 
it is safer to have separate list. We would also have to devise mechanism to 
get this data from DE2/3 CCU driver (it occupies the same memory space).

Perhaps the strongest argument is that some SoCs with DE3 have HW bug in 
mixer1 block, including that in H6. In order to work, mod clock has to be 
enabled for mixer0 and mixer1 at the same time. I would associate that quirk 
with mixer1 compatible.

Best regards,
Jernej




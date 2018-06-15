Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C19C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 17:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 815DA20896
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 17:35:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 815DA20896
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966214AbeFORfF convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 13:35:05 -0400
Received: from mailoutvs20.siol.net ([185.57.226.211]:33264 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S965916AbeFORfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 13:35:03 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id B6EEC521018;
        Fri, 15 Jun 2018 19:35:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta09.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta09.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id w8yAUAPZuqqD; Fri, 15 Jun 2018 19:35:00 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id EED8C520558;
        Fri, 15 Jun 2018 19:34:59 +0200 (CEST)
Received: from jernej-laptop.localnet (unknown [194.152.15.144])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPA id 9FE5C521018;
        Fri, 15 Jun 2018 19:34:57 +0200 (CEST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Subject: Re: [linux-sunxi] Re: [PATCH v2 11/27] drm/sun4i: tcon: Add support for tcon-top gate
Date:   Fri, 15 Jun 2018 19:33:53 +0200
Message-ID: <3871160.F3Km1rQkUz@jernej-laptop>
In-Reply-To: <CAGb2v66UFRKRF4_zbm8nQJYoOHb-iLbiU_0iYWep=WNiQDftMQ@mail.gmail.com>
References: <20180612200036.21483-1-jernej.skrabec@siol.net> <2948115.KggauuSURZ@jernej-laptop> <CAGb2v66UFRKRF4_zbm8nQJYoOHb-iLbiU_0iYWep=WNiQDftMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne petek, 15. junij 2018 ob 19:13:17 CEST je Chen-Yu Tsai napisal(a):
> On Sat, Jun 16, 2018 at 12:41 AM, Jernej Škrabec
> 
> <jernej.skrabec@siol.net> wrote:
> > Hi,
> > 
> > Dne petek, 15. junij 2018 ob 10:31:10 CEST je Maxime Ripard napisal(a):
> >> Hi,
> >> 
> >> On Tue, Jun 12, 2018 at 10:00:20PM +0200, Jernej Skrabec wrote:
> >> > TV TCONs connected to TCON TOP have to enable additional gate in order
> >> > to work.
> >> > 
> >> > Add support for such TCONs.
> >> > 
> >> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> >> > ---
> >> > 
> >> >  drivers/gpu/drm/sun4i/sun4i_tcon.c | 11 +++++++++++
> >> >  drivers/gpu/drm/sun4i/sun4i_tcon.h |  4 ++++
> >> >  2 files changed, 15 insertions(+)
> >> > 
> >> > diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c
> >> > b/drivers/gpu/drm/sun4i/sun4i_tcon.c index 08747fc3ee71..0afb5a94a414
> >> > 100644
> >> > --- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
> >> > +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> >> > @@ -688,6 +688,16 @@ static int sun4i_tcon_init_clocks(struct device
> >> > *dev,
> >> > 
> >> >             dev_err(dev, "Couldn't get the TCON bus clock\n");
> >> >             return PTR_ERR(tcon->clk);
> >> >     
> >> >     }
> >> > 
> >> > +
> >> > +   if (tcon->quirks->has_tcon_top_gate) {
> >> > +           tcon->top_clk = devm_clk_get(dev, "tcon-top");
> >> > +           if (IS_ERR(tcon->top_clk)) {
> >> > +                   dev_err(dev, "Couldn't get the TCON TOP bus
> >> > clock\n");
> >> > +                   return PTR_ERR(tcon->top_clk);
> >> > +           }
> >> > +           clk_prepare_enable(tcon->top_clk);
> >> > +   }
> >> > +
> >> 
> >> Is it required for the TCON itself to operate, or does the TCON
> >> requires the TCON TOP, which in turn requires that clock to be
> >> functional?
> >> 
> >> I find it quite odd to have a clock that isn't meant for a particular
> >> device to actually be wired to another device. I'm not saying this
> >> isn't the case, but it would be a first.
> > 
> > Documentation doesn't say much about that gate. I did few tests and TCON
> > registers can be read and written even if TCON TOP TV TCON gate is
> > disabled. However, there is no image, as expected.
> 
> The R40 manual does include it in the diagram, on page 504. There's also a
> mux to select whether the clock comes directly from the CCU or the TV
> encoder (a feedback mode?). I assume this is the gate you are referring to
> here, in which case it is not a bus clock, but rather the TCON module or
> channel clock, strangely routed.
> 
> > More interestingly, I enabled test pattern directly in TCON to eliminate
> > influence of the mixer. As soon as I disabled that gate, test pattern on
> > HDMI screen was gone, which suggest that this gate influences something
> > inside TCON.
> > 
> > Another test I did was that I moved enable/disable gate code to
> > sun4i_tcon_channel_set_status() and it worked just as well.
> > 
> > I'll ask AW engineer what that gate actually does, but from what I saw, I
> > would say that most appropriate location to enable/disable TCON TOP TV
> > TCON
> > gate is TCON driver. Alternatively, TCON TOP driver could check if any TV
> > TCON is in use and enable appropriate gate. However, that doesn't sound
> > right to me for some reason.
> 
> If what I said above it true, then yes, the appropriate location to enable
> it is the TCON driver, but moreover, the representation of the clock tree
> should be fixed such that the TCON takes the clock from the TCON TOP as its
> channel/ module clock instead. That way you don't need this patch, but
> you'd add another for all the clock routing.

Can you be more specific? I not sure what you mean here.

Best regards,
Jernej



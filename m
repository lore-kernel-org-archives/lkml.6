Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8086C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 01:23:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7426B20693
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 01:23:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7426B20693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754403AbeFUBXx convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 21:23:53 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35508 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754322AbeFUBXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 21:23:51 -0400
Received: by mail-wm0-f65.google.com with SMTP id j15-v6so2757945wme.0;
        Wed, 20 Jun 2018 18:23:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mI7qr4XxMo+pcDuQteXIYEECP1KcsWRYQsoeEuPUcog=;
        b=UB7ee5+RiWrR/Scl8oq0BwlNPen9CxAMWWGU/MkHfzQyvhxF57S1tlwbx3Vwd9LzeU
         j+VBSpn9+EDxeMHd9SVyk387mp0uz8AENpqImHC7kEKHlQiJhLMDiq4e5JIBMxmFXUa9
         unal5va1yFOg8koS0ibrG+d+YsHpwE/nbTeNB79IS06bvhXFzm0IF555SfZVH7kX0xPd
         Wrw/vme/LNlH2owSIAKWy3PfFpL4qJidV8luX8offgrquCeExu9WOe8pqLa0L8Bavm0w
         qE97gD0smzl6OzyFU4vY0hClmsdehQf7bpiM5Abo+eOcNRJ9yf3UlmFnbNlsLWWn972k
         ltEA==
X-Gm-Message-State: APt69E09gOeuAN1dey+8+NeteqLsz6YxYe8sB2p9jAfk+MBb4UTTDg01
        jC36KuRQxh44koDdqa+REbp2sqFEou4=
X-Google-Smtp-Source: ADUXVKKAxj//tGbAwT+cKm2HFuyI5I528+PjAvXDg8bQKil8aOSM8G30LyutONPXElPu0vZJ222Q0g==
X-Received: by 2002:a50:8cb7:: with SMTP id q52-v6mr19766931edq.17.1529544229544;
        Wed, 20 Jun 2018 18:23:49 -0700 (PDT)
Received: from mail-wm0-f52.google.com (mail-wm0-f52.google.com. [74.125.82.52])
        by smtp.gmail.com with ESMTPSA id l13-v6sm1404043edi.19.2018.06.20.18.23.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jun 2018 18:23:48 -0700 (PDT)
Received: by mail-wm0-f52.google.com with SMTP id 69-v6so2712116wmf.3;
        Wed, 20 Jun 2018 18:23:48 -0700 (PDT)
X-Received: by 2002:a1c:850c:: with SMTP id h12-v6mr3214364wmd.116.1529544228462;
 Wed, 20 Jun 2018 18:23:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:a158:0:0:0:0:0 with HTTP; Wed, 20 Jun 2018 18:23:27
 -0700 (PDT)
In-Reply-To: <2581098.bNJirayF9O@jernej-laptop>
References: <20180612200036.21483-1-jernej.skrabec@siol.net>
 <3871160.F3Km1rQkUz@jernej-laptop> <CAGb2v66Tv7876_heSve0zb+vWfz9kbwbrU8NjnpTwUHm6xOKJQ@mail.gmail.com>
 <2581098.bNJirayF9O@jernej-laptop>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Thu, 21 Jun 2018 09:23:27 +0800
X-Gmail-Original-Message-ID: <CAGb2v64iB8FP1Nf+vZM2wd6wzNLxWYrCP78D-rOUg881RPNpEA@mail.gmail.com>
Message-ID: <CAGb2v64iB8FP1Nf+vZM2wd6wzNLxWYrCP78D-rOUg881RPNpEA@mail.gmail.com>
Subject: Re: [linux-sunxi] Re: [PATCH v2 11/27] drm/sun4i: tcon: Add support
 for tcon-top gate
To:     Jernej Skrabec <jernej.skrabec@siol.net>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 3:37 AM, Jernej Škrabec <jernej.skrabec@siol.net> wrote:
> Dne sobota, 16. junij 2018 ob 07:48:38 CEST je Chen-Yu Tsai napisal(a):
>> On Sat, Jun 16, 2018 at 1:33 AM, Jernej Škrabec <jernej.skrabec@siol.net>
> wrote:
>> > Dne petek, 15. junij 2018 ob 19:13:17 CEST je Chen-Yu Tsai napisal(a):
>> >> On Sat, Jun 16, 2018 at 12:41 AM, Jernej Škrabec
>> >>
>> >> <jernej.skrabec@siol.net> wrote:
>> >> > Hi,
>> >> >
>> >> > Dne petek, 15. junij 2018 ob 10:31:10 CEST je Maxime Ripard napisal(a):
>> >> >> Hi,
>> >> >>
>> >> >> On Tue, Jun 12, 2018 at 10:00:20PM +0200, Jernej Skrabec wrote:
>> >> >> > TV TCONs connected to TCON TOP have to enable additional gate in
>> >> >> > order
>> >> >> > to work.
>> >> >> >
>> >> >> > Add support for such TCONs.
>> >> >> >
>> >> >> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
>> >> >> > ---
>> >> >> >
>> >> >> >  drivers/gpu/drm/sun4i/sun4i_tcon.c | 11 +++++++++++
>> >> >> >  drivers/gpu/drm/sun4i/sun4i_tcon.h |  4 ++++
>> >> >> >  2 files changed, 15 insertions(+)
>> >> >> >
>> >> >> > diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c
>> >> >> > b/drivers/gpu/drm/sun4i/sun4i_tcon.c index
>> >> >> > 08747fc3ee71..0afb5a94a414
>> >> >> > 100644
>> >> >> > --- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
>> >> >> > +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
>> >> >> > @@ -688,6 +688,16 @@ static int sun4i_tcon_init_clocks(struct device
>> >> >> > *dev,
>> >> >> >
>> >> >> >             dev_err(dev, "Couldn't get the TCON bus clock\n");
>> >> >> >             return PTR_ERR(tcon->clk);
>> >> >> >
>> >> >> >     }
>> >> >> >
>> >> >> > +
>> >> >> > +   if (tcon->quirks->has_tcon_top_gate) {
>> >> >> > +           tcon->top_clk = devm_clk_get(dev, "tcon-top");
>> >> >> > +           if (IS_ERR(tcon->top_clk)) {
>> >> >> > +                   dev_err(dev, "Couldn't get the TCON TOP bus
>> >> >> > clock\n");
>> >> >> > +                   return PTR_ERR(tcon->top_clk);
>> >> >> > +           }
>> >> >> > +           clk_prepare_enable(tcon->top_clk);
>> >> >> > +   }
>> >> >> > +
>> >> >>
>> >> >> Is it required for the TCON itself to operate, or does the TCON
>> >> >> requires the TCON TOP, which in turn requires that clock to be
>> >> >> functional?
>> >> >>
>> >> >> I find it quite odd to have a clock that isn't meant for a particular
>> >> >> device to actually be wired to another device. I'm not saying this
>> >> >> isn't the case, but it would be a first.
>> >> >
>> >> > Documentation doesn't say much about that gate. I did few tests and
>> >> > TCON
>> >> > registers can be read and written even if TCON TOP TV TCON gate is
>> >> > disabled. However, there is no image, as expected.
>> >>
>> >> The R40 manual does include it in the diagram, on page 504. There's also
>> >> a
>> >> mux to select whether the clock comes directly from the CCU or the TV
>> >> encoder (a feedback mode?). I assume this is the gate you are referring
>> >> to
>> >> here, in which case it is not a bus clock, but rather the TCON module or
>> >> channel clock, strangely routed.
>> >>
>> >> > More interestingly, I enabled test pattern directly in TCON to
>> >> > eliminate
>> >> > influence of the mixer. As soon as I disabled that gate, test pattern
>> >> > on
>> >> > HDMI screen was gone, which suggest that this gate influences something
>> >> > inside TCON.
>> >> >
>> >> > Another test I did was that I moved enable/disable gate code to
>> >> > sun4i_tcon_channel_set_status() and it worked just as well.
>> >> >
>> >> > I'll ask AW engineer what that gate actually does, but from what I saw,
>> >> > I
>> >> > would say that most appropriate location to enable/disable TCON TOP TV
>> >> > TCON
>> >> > gate is TCON driver. Alternatively, TCON TOP driver could check if any
>> >> > TV
>> >> > TCON is in use and enable appropriate gate. However, that doesn't sound
>> >> > right to me for some reason.
>> >>
>> >> If what I said above it true, then yes, the appropriate location to
>> >> enable
>> >> it is the TCON driver, but moreover, the representation of the clock tree
>> >> should be fixed such that the TCON takes the clock from the TCON TOP as
>> >> its
>> >> channel/ module clock instead. That way you don't need this patch, but
>> >> you'd add another for all the clock routing.
>> >
>> > Can you be more specific? I not sure what you mean here.
>>
>> For clock related properties in the device tree:
>>
>> &tcon_top {
>>     clocks = <&ccu CLK_BUS_TCON_TOP>,
>>              <&ccu CLK_TCON_TV0>,
>>              <&tve0>,
>>              <&ccu CLK_TCON_TV1>,
>>              <&tve1>;
>>     clock-names = "bus", "tcon-tv0", "tve0", "tcon-tv1", "tve1";
>>     clock-output-names = "tcon-top-tv0", "tcon-top-tv1";
>> };
>>
>> &tcon_tv0 {
>>     clocks = <&ccu CLK_BUS_TCON_TV0>, <&tcon_top 0>'
>>     clock-names = "ahb", "tcon-ch1";
>> };
>>
>> A diagram would look like:
>>                    | This part is TCON TOP |
>>
>>                    v                       v
>> CCU CLK_TCON_TV0 --|----\                  |
>>
>>                    |     mux ---- gate ----|-- TCON_TV0
>>
>> TVE0 --------------|----/                  |
>>
>> And the same goes for TCON_TV1 and TVE1.
>>
>> The user manual is a bit lacking on how TVE outputs a clock though.
>
> I didn't yet received any response on HW details from AW till now, but I would
> like to post new version of patches soon.
>
> While chaining like you described could be implemented easily, I don't think
> it really represents HW as it is. Tests showed that these two clocks are
> independent, otherwise register writes/reads wouldn't be possible with tcon-
> top gate disabled. I chose tcon-top bus clock as a parent becase if it is not
> enabled, it simply won't work.

AFAIK with the TCONs, even when the TCON channel clock (not the bus clock) is
disabled, register accesses still work. I'm saying that the TCON TOP gate
is downstream from the TCON channel clock in the CCU. These are not related
to the TCON bus clock in the CCU, which affects register access.

Did Allwinner provide any information regarding the hierarchy of the clocks?

> However, if everyone feels chaining is the best way to implement it, I'll do
> it.

I would like to get it right and match actual hardware. My proposal is
based on my understanding from the diagrams in the user manual.

Regards
ChenYu

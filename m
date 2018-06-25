Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97414C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 03:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B26125417
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 03:52:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B26125417
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753131AbeFYDwH convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 23:52:07 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46578 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752605AbeFYDwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 23:52:05 -0400
Received: by mail-ed1-f67.google.com with SMTP id r17-v6so4478353edo.13;
        Sun, 24 Jun 2018 20:52:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6H/kr/FZu4SVngWwkfImJSvM8QtEmLUODyDpFIcEQEY=;
        b=HBR/m26zN5Nr739Oiz6ZrM0iFHlQAdBWOwJ9JJZ/XeamOG351SmjVhgmFIs0TLf7fd
         OuY33d9Fw2kmBvZa+xyVLEOi9lO2NQjpCu7VOd62uPZOI/gsI7b1P4qE/37rb6o5DvFi
         dgwD7dJGSu4RMm1g4LP4EuBZEKKDed2xsB9ioWrBszQrKAqiLwXW7SHXWUAVzJVWzjRo
         H29a7FNPMfUVgrSECtn2ee1Ibr3rXoB1i8SBO6H7Dcg+Lpd9OE6F4Mkox+ffE5ijLIGT
         5ssSdYjAfb+PYDrhswaOisqeWEhjOkCzxxBiy7vh6gko27zHepQD8WcTbrORFR/n1Dg6
         iyLg==
X-Gm-Message-State: APt69E2RH2E7eRJpUBElK/mITJZ4zoohQ1nupd2MQM5nA98nIV9ZneaV
        gsPe6tj8gijLjGZYOJTqrDKzbEH5
X-Google-Smtp-Source: ADUXVKJoovm+De9wl3mKyLlKo23HBpuF6KWMrKH9WicCw6qryiMIz+VdNgQAKutlZ+dFWiL7XaLTnQ==
X-Received: by 2002:a50:f4ba:: with SMTP id s55-v6mr9837419edm.262.1529898723358;
        Sun, 24 Jun 2018 20:52:03 -0700 (PDT)
Received: from mail-wr0-f181.google.com (mail-wr0-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id i62-v6sm68963edi.10.2018.06.24.20.52.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Jun 2018 20:52:02 -0700 (PDT)
Received: by mail-wr0-f181.google.com with SMTP id a12-v6so12086609wro.1;
        Sun, 24 Jun 2018 20:52:01 -0700 (PDT)
X-Received: by 2002:adf:f98a:: with SMTP id f10-v6mr8531237wrr.105.1529898721577;
 Sun, 24 Jun 2018 20:52:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:a15a:0:0:0:0:0 with HTTP; Sun, 24 Jun 2018 20:51:41
 -0700 (PDT)
In-Reply-To: <4758026.sMRKe6aTTs@jernej-laptop>
References: <20180612200036.21483-1-jernej.skrabec@siol.net>
 <CAGb2v64iB8FP1Nf+vZM2wd6wzNLxWYrCP78D-rOUg881RPNpEA@mail.gmail.com>
 <2366311.u3CXHO0a4d@jernej-laptop> <4758026.sMRKe6aTTs@jernej-laptop>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 25 Jun 2018 11:51:41 +0800
X-Gmail-Original-Message-ID: <CAGb2v67wVpAKk-5kSpnbnBXz7DkHToPa6bwuRBnsfHovw74HVQ@mail.gmail.com>
Message-ID: <CAGb2v67wVpAKk-5kSpnbnBXz7DkHToPa6bwuRBnsfHovw74HVQ@mail.gmail.com>
Subject: Re: [linux-sunxi] Re: [PATCH v2 11/27] drm/sun4i: tcon: Add support
 for tcon-top gate
To:     =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@gmail.com>
Cc:     linux-sunxi <linux-sunxi@googlegroups.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
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
        linux-clk <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 3:52 AM, Jernej Škrabec
<jernej.skrabec@gmail.com> wrote:
> Dne četrtek, 21. junij 2018 ob 17:35:45 CEST je Jernej Škrabec napisal(a):
>> Dne četrtek, 21. junij 2018 ob 03:23:27 CEST je Chen-Yu Tsai napisal(a):
>> > On Thu, Jun 21, 2018 at 3:37 AM, Jernej Škrabec <jernej.skrabec@siol.net>
>>
>> wrote:
>> > > Dne sobota, 16. junij 2018 ob 07:48:38 CEST je Chen-Yu Tsai napisal(a):
>> > >> On Sat, Jun 16, 2018 at 1:33 AM, Jernej Škrabec
>> > >> <jernej.skrabec@siol.net>
>> > >
>> > > wrote:
>> > >> > Dne petek, 15. junij 2018 ob 19:13:17 CEST je Chen-Yu Tsai
> napisal(a):
>> > >> >> On Sat, Jun 16, 2018 at 12:41 AM, Jernej Škrabec
>> > >> >>
>> > >> >> <jernej.skrabec@siol.net> wrote:
>> > >> >> > Hi,
>> > >> >> >
>> > >> >> > Dne petek, 15. junij 2018 ob 10:31:10 CEST je Maxime Ripard
>>
>> napisal(a):
>> > >> >> >> Hi,
>> > >> >> >>
>> > >> >> >> On Tue, Jun 12, 2018 at 10:00:20PM +0200, Jernej Skrabec wrote:
>> > >> >> >> > TV TCONs connected to TCON TOP have to enable additional gate
>> > >> >> >> > in
>> > >> >> >> > order
>> > >> >> >> > to work.
>> > >> >> >> >
>> > >> >> >> > Add support for such TCONs.
>> > >> >> >> >
>> > >> >> >> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
>> > >> >> >> > ---
>> > >> >> >> >
>> > >> >> >> >  drivers/gpu/drm/sun4i/sun4i_tcon.c | 11 +++++++++++
>> > >> >> >> >  drivers/gpu/drm/sun4i/sun4i_tcon.h |  4 ++++
>> > >> >> >> >  2 files changed, 15 insertions(+)
>> > >> >> >> >
>> > >> >> >> > diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c
>> > >> >> >> > b/drivers/gpu/drm/sun4i/sun4i_tcon.c index
>> > >> >> >> > 08747fc3ee71..0afb5a94a414
>> > >> >> >> > 100644
>> > >> >> >> > --- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
>> > >> >> >> > +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
>> > >> >> >> > @@ -688,6 +688,16 @@ static int sun4i_tcon_init_clocks(struct
>> > >> >> >> > device
>> > >> >> >> > *dev,
>> > >> >> >> >
>> > >> >> >> >             dev_err(dev, "Couldn't get the TCON bus clock\n");
>> > >> >> >> >             return PTR_ERR(tcon->clk);
>> > >> >> >> >
>> > >> >> >> >     }
>> > >> >> >> >
>> > >> >> >> > +
>> > >> >> >> > +   if (tcon->quirks->has_tcon_top_gate) {
>> > >> >> >> > +           tcon->top_clk = devm_clk_get(dev, "tcon-top");
>> > >> >> >> > +           if (IS_ERR(tcon->top_clk)) {
>> > >> >> >> > +                   dev_err(dev, "Couldn't get the TCON TOP bus
>> > >> >> >> > clock\n");
>> > >> >> >> > +                   return PTR_ERR(tcon->top_clk);
>> > >> >> >> > +           }
>> > >> >> >> > +           clk_prepare_enable(tcon->top_clk);
>> > >> >> >> > +   }
>> > >> >> >> > +
>> > >> >> >>
>> > >> >> >> Is it required for the TCON itself to operate, or does the TCON
>> > >> >> >> requires the TCON TOP, which in turn requires that clock to be
>> > >> >> >> functional?
>> > >> >> >>
>> > >> >> >> I find it quite odd to have a clock that isn't meant for a
>> > >> >> >> particular
>> > >> >> >> device to actually be wired to another device. I'm not saying
>> > >> >> >> this
>> > >> >> >> isn't the case, but it would be a first.
>> > >> >> >
>> > >> >> > Documentation doesn't say much about that gate. I did few tests
>> > >> >> > and
>> > >> >> > TCON
>> > >> >> > registers can be read and written even if TCON TOP TV TCON gate is
>> > >> >> > disabled. However, there is no image, as expected.
>> > >> >>
>> > >> >> The R40 manual does include it in the diagram, on page 504. There's
>> > >> >> also
>> > >> >> a
>> > >> >> mux to select whether the clock comes directly from the CCU or the
>> > >> >> TV
>> > >> >> encoder (a feedback mode?). I assume this is the gate you are
>> > >> >> referring
>> > >> >> to
>> > >> >> here, in which case it is not a bus clock, but rather the TCON
>> > >> >> module
>> > >> >> or
>> > >> >> channel clock, strangely routed.
>> > >> >>
>> > >> >> > More interestingly, I enabled test pattern directly in TCON to
>> > >> >> > eliminate
>> > >> >> > influence of the mixer. As soon as I disabled that gate, test
>> > >> >> > pattern
>> > >> >> > on
>> > >> >> > HDMI screen was gone, which suggest that this gate influences
>> > >> >> > something
>> > >> >> > inside TCON.
>> > >> >> >
>> > >> >> > Another test I did was that I moved enable/disable gate code to
>> > >> >> > sun4i_tcon_channel_set_status() and it worked just as well.
>> > >> >> >
>> > >> >> > I'll ask AW engineer what that gate actually does, but from what I
>> > >> >> > saw,
>> > >> >> > I
>> > >> >> > would say that most appropriate location to enable/disable TCON
>> > >> >> > TOP
>> > >> >> > TV
>> > >> >> > TCON
>> > >> >> > gate is TCON driver. Alternatively, TCON TOP driver could check if
>> > >> >> > any
>> > >> >> > TV
>> > >> >> > TCON is in use and enable appropriate gate. However, that doesn't
>> > >> >> > sound
>> > >> >> > right to me for some reason.
>> > >> >>
>> > >> >> If what I said above it true, then yes, the appropriate location to
>> > >> >> enable
>> > >> >> it is the TCON driver, but moreover, the representation of the clock
>> > >> >> tree
>> > >> >> should be fixed such that the TCON takes the clock from the TCON TOP
>> > >> >> as
>> > >> >> its
>> > >> >> channel/ module clock instead. That way you don't need this patch,
>> > >> >> but
>> > >> >> you'd add another for all the clock routing.
>> > >> >
>> > >> > Can you be more specific? I not sure what you mean here.
>> > >>
>> > >> For clock related properties in the device tree:
>> > >>
>> > >> &tcon_top {
>> > >>
>> > >>     clocks = <&ccu CLK_BUS_TCON_TOP>,
>> > >>
>> > >>              <&ccu CLK_TCON_TV0>,
>> > >>              <&tve0>,
>> > >>              <&ccu CLK_TCON_TV1>,
>> > >>              <&tve1>;
>> > >>
>> > >>     clock-names = "bus", "tcon-tv0", "tve0", "tcon-tv1", "tve1";
>> > >>     clock-output-names = "tcon-top-tv0", "tcon-top-tv1";
>> > >>
>> > >> };
>> > >>
>> > >> &tcon_tv0 {
>> > >>
>> > >>     clocks = <&ccu CLK_BUS_TCON_TV0>, <&tcon_top 0>'
>> > >>     clock-names = "ahb", "tcon-ch1";
>> > >>
>> > >> };
>> > >>
>> > >> A diagram would look like:
>> > >>                    | This part is TCON TOP |
>> > >>
>> > >>                    v                       v
>> > >>
>> > >> CCU CLK_TCON_TV0 --|----\                  |
>> > >>
>> > >>                    |     mux ---- gate ----|-- TCON_TV0
>> > >>
>> > >> TVE0 --------------|----/                  |
>> > >>
>> > >> And the same goes for TCON_TV1 and TVE1.
>> > >>
>> > >> The user manual is a bit lacking on how TVE outputs a clock though.
>> > >
>> > > I didn't yet received any response on HW details from AW till now, but I
>> > > would like to post new version of patches soon.
>> > >
>> > > While chaining like you described could be implemented easily, I don't
>> > > think it really represents HW as it is. Tests showed that these two
>> > > clocks are independent, otherwise register writes/reads wouldn't be
>> > > possible with tcon- top gate disabled. I chose tcon-top bus clock as a
>> > > parent becase if it is not enabled, it simply won't work.
>> >
>> > AFAIK with the TCONs, even when the TCON channel clock (not the bus clock)
>> > is disabled, register accesses still work.
>>
>> You're right, I just tested that.
>>
>> > I'm saying that the TCON TOP
>> > gate is downstream from the TCON channel clock in the CCU. These are not
>> > related to the TCON bus clock in the CCU, which affects register access.
>> >
>> > Did Allwinner provide any information regarding the hierarchy of the
>> > clocks?
>> No reponse for now.
>>
>> > > However, if everyone feels chaining is the best way to implement it,
>> > > I'll
>> > > do it.
>> >
>> > I would like to get it right and match actual hardware. My proposal is
>> > based on my understanding from the diagrams in the user manual.
>>
>> So for now, your explanation is the most reasonable. Should we go ahead and
>> implement your idea?
>>
>> Please note that H6 has TCON-TOP too, but it has only one LCD TCON and one
>> TV TCON instead of two of each kind. That means we will have hole in
>> indices (tcon_lcd0 is 1, tcon_tv0 is 3, which is aligned with R40) and
>> different TCON- TOP binding (no tcon_tv1 channel clock), but setup is
>> exactly the same.
>
> I just noticed issue with this proposal. If we have following clock chain for
> HDMI, everythings is ok:
>
> TCON-TV0 -> TCON-TOP-TV0
>
> TCON TV sets TCON-TOP-TV0 clock rate, which in turn sets TCON-TV0 clock and
> everything works.
>
> However, when TVE will be configured, it would look like this:
>
> TVE0 -> TCON-TOP-TV0
>
> TVE driver will set TVE0 clock to 216 MHz and TCON TV would set TCON-TOP-TV0
> rate which in turn sets TVE0 clock to something like 13.5 MHz (or whatever is
> the right clock rate for PAL and NTSC). As you can see, same clock is set to
> two different rates by two different drivers.
>
> It *might* still work, since encoders set clock rate after TCON (at least that
> is my experience for HDMI pipeline), but that is still wrong.
>
> To overcome above issue, I would stick to original proposal with additional
> clock specified in TCON TV DT node. That way TCON driver would always set
> clock rate to TCON-TV0 clock. If TVE0 is enabled, TCON wouldn't interfere with
> setting clock rate, because TCON-TV0 clock would be decoupled in TCON-TOP mux.
>
> What do you think?

I think this is the wrong representation, and worse, you are trying to work
around software issues with it.

So to confirm some details, the TVE expects 216 MHz clock, and it expects the
TCON to run and output data at 216 MHz as well. Is that correct?

Would any settings for the TCON differ between when HDMI or TVE is used?

Does TVE and TCON run at 216 MHz regardless of resolution? I kind of doubt it.
It might be expecting 297 MHz for PC resolutions.

I think these kinds of quirks should be handled in the software, instead of
being papered over.

ChenYu

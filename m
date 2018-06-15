Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E134C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 17:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 159C0208B2
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 17:13:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 159C0208B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966046AbeFORNn convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 13:13:43 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35388 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756314AbeFORNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 13:13:41 -0400
Received: by mail-wm0-f68.google.com with SMTP id j15-v6so5135853wme.0;
        Fri, 15 Jun 2018 10:13:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tQVPlrQID9tyIuc78cpsyLCRRJsK74UL48g9PkmLhYI=;
        b=UtDnbKVOIQ7GMYgaqGEvmi4Iv7XOnOnj86s0OfAGRaUZjUZfCYBcU44VICINyhVpFb
         LLFPtToT4qU5QGHQKd/hQenBL+ag0adzA++yjca9qMM5CG+8JS8r1fsk7+SxlWFXIpis
         h6hkLcm5voKCkZqYk4Tn7olYoeBsCXT7v9BaVDwNdA0cwDrP9cs4oEd14uQkcuqezO92
         e2nsdawrCMU7mwqnKBi6RF8tugpxfWdXCheoJNxgVKdXdaCs/JI4FCu0rwCrTcY/oIGY
         v/wPLfHUX/fhqbUNIKvXdWISJXe+UZUKdeeiUauC0tiU1EiCsKyJN9dcTUFcc0t6e0AG
         MjyQ==
X-Gm-Message-State: APt69E2TLqivlinZ/AHQbXgkCYIGWVBXuZ2nhc8rlz2n6xMK5R4HOoIh
        lgirTmZjMLVEtP6yBLT5WcauY5qC
X-Google-Smtp-Source: ADUXVKJZNhxvRydukzTlaDluG3iaXe9YsBLFEx8/VEUr54iGT3fpF/1w+gLp361ZkLwzLmXsUxUrAQ==
X-Received: by 2002:a50:81a4:: with SMTP id 33-v6mr2544206ede.215.1529082819489;
        Fri, 15 Jun 2018 10:13:39 -0700 (PDT)
Received: from mail-wm0-f47.google.com (mail-wm0-f47.google.com. [74.125.82.47])
        by smtp.gmail.com with ESMTPSA id b58-v6sm4223184edb.59.2018.06.15.10.13.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Jun 2018 10:13:38 -0700 (PDT)
Received: by mail-wm0-f47.google.com with SMTP id v16-v6so4618824wmh.5;
        Fri, 15 Jun 2018 10:13:38 -0700 (PDT)
X-Received: by 2002:a1c:454f:: with SMTP id s76-v6mr1855581wma.16.1529082818254;
 Fri, 15 Jun 2018 10:13:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:a158:0:0:0:0:0 with HTTP; Fri, 15 Jun 2018 10:13:17
 -0700 (PDT)
In-Reply-To: <2948115.KggauuSURZ@jernej-laptop>
References: <20180612200036.21483-1-jernej.skrabec@siol.net>
 <20180612200036.21483-12-jernej.skrabec@siol.net> <20180615083110.laruycabvyjmesmo@flea>
 <2948115.KggauuSURZ@jernej-laptop>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Sat, 16 Jun 2018 01:13:17 +0800
X-Gmail-Original-Message-ID: <CAGb2v66UFRKRF4_zbm8nQJYoOHb-iLbiU_0iYWep=WNiQDftMQ@mail.gmail.com>
Message-ID: <CAGb2v66UFRKRF4_zbm8nQJYoOHb-iLbiU_0iYWep=WNiQDftMQ@mail.gmail.com>
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

On Sat, Jun 16, 2018 at 12:41 AM, Jernej Škrabec
<jernej.skrabec@siol.net> wrote:
> Hi,
>
> Dne petek, 15. junij 2018 ob 10:31:10 CEST je Maxime Ripard napisal(a):
>> Hi,
>>
>> On Tue, Jun 12, 2018 at 10:00:20PM +0200, Jernej Skrabec wrote:
>> > TV TCONs connected to TCON TOP have to enable additional gate in order
>> > to work.
>> >
>> > Add support for such TCONs.
>> >
>> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
>> > ---
>> >
>> >  drivers/gpu/drm/sun4i/sun4i_tcon.c | 11 +++++++++++
>> >  drivers/gpu/drm/sun4i/sun4i_tcon.h |  4 ++++
>> >  2 files changed, 15 insertions(+)
>> >
>> > diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c
>> > b/drivers/gpu/drm/sun4i/sun4i_tcon.c index 08747fc3ee71..0afb5a94a414
>> > 100644
>> > --- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
>> > +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
>> > @@ -688,6 +688,16 @@ static int sun4i_tcon_init_clocks(struct device *dev,
>> >
>> >             dev_err(dev, "Couldn't get the TCON bus clock\n");
>> >             return PTR_ERR(tcon->clk);
>> >
>> >     }
>> >
>> > +
>> > +   if (tcon->quirks->has_tcon_top_gate) {
>> > +           tcon->top_clk = devm_clk_get(dev, "tcon-top");
>> > +           if (IS_ERR(tcon->top_clk)) {
>> > +                   dev_err(dev, "Couldn't get the TCON TOP bus clock\n");
>> > +                   return PTR_ERR(tcon->top_clk);
>> > +           }
>> > +           clk_prepare_enable(tcon->top_clk);
>> > +   }
>> > +
>>
>> Is it required for the TCON itself to operate, or does the TCON
>> requires the TCON TOP, which in turn requires that clock to be
>> functional?
>>
>> I find it quite odd to have a clock that isn't meant for a particular
>> device to actually be wired to another device. I'm not saying this
>> isn't the case, but it would be a first.
>
> Documentation doesn't say much about that gate. I did few tests and TCON
> registers can be read and written even if TCON TOP TV TCON gate is disabled.
> However, there is no image, as expected.

The R40 manual does include it in the diagram, on page 504. There's also a
mux to select whether the clock comes directly from the CCU or the TV encoder
(a feedback mode?). I assume this is the gate you are referring to here, in
which case it is not a bus clock, but rather the TCON module or channel clock,
strangely routed.

> More interestingly, I enabled test pattern directly in TCON to eliminate
> influence of the mixer. As soon as I disabled that gate, test pattern on HDMI
> screen was gone, which suggest that this gate influences something inside
> TCON.
>
> Another test I did was that I moved enable/disable gate code to
> sun4i_tcon_channel_set_status() and it worked just as well.
>
> I'll ask AW engineer what that gate actually does, but from what I saw, I
> would say that most appropriate location to enable/disable TCON TOP TV TCON
> gate is TCON driver. Alternatively, TCON TOP driver could check if any TV TCON
> is in use and enable appropriate gate. However, that doesn't sound right to me
> for some reason.

If what I said above it true, then yes, the appropriate location to enable it
is the TCON driver, but moreover, the representation of the clock tree should
be fixed such that the TCON takes the clock from the TCON TOP as its channel/
module clock instead. That way you don't need this patch, but you'd add another
for all the clock routing.

ChenYu

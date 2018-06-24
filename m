Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A598EC43142
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 19:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46596252F2
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 19:54:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aceQmpaA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46596252F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751970AbeFXTyB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 15:54:01 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33037 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751728AbeFXTx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 15:53:59 -0400
Received: by mail-wm0-f67.google.com with SMTP id z6-v6so10669981wma.0;
        Sun, 24 Jun 2018 12:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pakBoFE3Y5J3aKkehePWxCLymUOh2vAwmOdYlXXMmgs=;
        b=aceQmpaA9viJEbNCZkpw9DG/dBf6suPK9UB6k2xOTEYqhC78qTTeAeUD7oRU9lmDv1
         P2zlV9D9AKz166SLWiKGY6eD9DOe3ZLHnf97zyCdnwGpHklLxK492WtUHqPNI7nm9Hwq
         0bXE4viR8Qsyii40t6O7mYEfFjaeIUN4/NKWPOMP8o2J+NW9a/+TlFoaXRAmTkJlkeg3
         uEvUxAysqt27ckhoio8RQFMCdqqeV3T0pjerwP7UibakqwFHsLnbcKh53T6He/VCzgMG
         DAT3IV5cno29E9BOD+8s+OkMbNPxOdG4krrJkCZ7l+vxsjDrw+eIj80pmG6R8gi0A+Fr
         VVyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pakBoFE3Y5J3aKkehePWxCLymUOh2vAwmOdYlXXMmgs=;
        b=sYf9lS/PfqHeYJD0NIkUzffJz4XimAXRuUcyAQ6D2eVHUlpQVPHDvCypOrzVLMzNe0
         QsP5mEyz5DkJyahsF0DLUL/9X9mr58de57Y98uVoOBk1M18XNGHUWsHvGNRuzcUg70YJ
         6uua4rp3Cy1OpD8l+FRttrdeLu2jWD7WAk0Kc7AbzLnC28H1ccLgzeobpdkQmm3iJF27
         8DVcrBIyTGBgg+WDBiKA8kByMxUDX1WU96hfIvenb4nBtjbj7kfPcfIpCv4gYXDvIm8v
         9jSJL1NqR37iD4XyIZostGGGGGqitQ48MqBpm9kxhx+TsycZwQupFz1rUEz+YtWVQukV
         Bi5A==
X-Gm-Message-State: APt69E3GiIAJCHeOIOAjWjDDyRjyztEXpv2lCIHFLZc0BpYVk0JUO5/v
        zx66ToCoc5YtQZlkxgt7whM=
X-Google-Smtp-Source: ADUXVKLdMH+uasfNe9EIEZy9e4RQPNo+83df8uK0fiqA90L1qNnm0q/NH5Hs2NdEq71TyoQNIevNvw==
X-Received: by 2002:a1c:4602:: with SMTP id t2-v6mr3711187wma.21.1529870038049;
        Sun, 24 Jun 2018 12:53:58 -0700 (PDT)
Received: from jernej-laptop.localnet ([194.152.15.144])
        by smtp.gmail.com with ESMTPSA id a124-v6sm1991575wmf.7.2018.06.24.12.53.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 24 Jun 2018 12:53:57 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     linux-sunxi@googlegroups.com
Cc:     Chen-Yu Tsai <wens@csie.org>,
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
Subject: Re: [linux-sunxi] Re: [PATCH v2 11/27] drm/sun4i: tcon: Add support for tcon-top gate
Date:   Sun, 24 Jun 2018 21:52:36 +0200
Message-ID: <4758026.sMRKe6aTTs@jernej-laptop>
In-Reply-To: <2366311.u3CXHO0a4d@jernej-laptop>
References: <20180612200036.21483-1-jernej.skrabec@siol.net> <CAGb2v64iB8FP1Nf+vZM2wd6wzNLxWYrCP78D-rOUg881RPNpEA@mail.gmail.com> <2366311.u3CXHO0a4d@jernej-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne =C4=8Detrtek, 21. junij 2018 ob 17:35:45 CEST je Jernej =C5=A0krabec na=
pisal(a):
> Dne =C4=8Detrtek, 21. junij 2018 ob 03:23:27 CEST je Chen-Yu Tsai napisal=
(a):
> > On Thu, Jun 21, 2018 at 3:37 AM, Jernej =C5=A0krabec <jernej.skrabec@si=
ol.net>
>=20
> wrote:
> > > Dne sobota, 16. junij 2018 ob 07:48:38 CEST je Chen-Yu Tsai napisal(a=
):
> > >> On Sat, Jun 16, 2018 at 1:33 AM, Jernej =C5=A0krabec
> > >> <jernej.skrabec@siol.net>
> > >=20
> > > wrote:
> > >> > Dne petek, 15. junij 2018 ob 19:13:17 CEST je Chen-Yu Tsai=20
napisal(a):
> > >> >> On Sat, Jun 16, 2018 at 12:41 AM, Jernej =C5=A0krabec
> > >> >>=20
> > >> >> <jernej.skrabec@siol.net> wrote:
> > >> >> > Hi,
> > >> >> >=20
> > >> >> > Dne petek, 15. junij 2018 ob 10:31:10 CEST je Maxime Ripard
>=20
> napisal(a):
> > >> >> >> Hi,
> > >> >> >>=20
> > >> >> >> On Tue, Jun 12, 2018 at 10:00:20PM +0200, Jernej Skrabec wrote:
> > >> >> >> > TV TCONs connected to TCON TOP have to enable additional gate
> > >> >> >> > in
> > >> >> >> > order
> > >> >> >> > to work.
> > >> >> >> >=20
> > >> >> >> > Add support for such TCONs.
> > >> >> >> >=20
> > >> >> >> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > >> >> >> > ---
> > >> >> >> >=20
> > >> >> >> >  drivers/gpu/drm/sun4i/sun4i_tcon.c | 11 +++++++++++
> > >> >> >> >  drivers/gpu/drm/sun4i/sun4i_tcon.h |  4 ++++
> > >> >> >> >  2 files changed, 15 insertions(+)
> > >> >> >> >=20
> > >> >> >> > diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c
> > >> >> >> > b/drivers/gpu/drm/sun4i/sun4i_tcon.c index
> > >> >> >> > 08747fc3ee71..0afb5a94a414
> > >> >> >> > 100644
> > >> >> >> > --- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
> > >> >> >> > +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> > >> >> >> > @@ -688,6 +688,16 @@ static int sun4i_tcon_init_clocks(struct
> > >> >> >> > device
> > >> >> >> > *dev,
> > >> >> >> >=20
> > >> >> >> >             dev_err(dev, "Couldn't get the TCON bus clock\n"=
);
> > >> >> >> >             return PTR_ERR(tcon->clk);
> > >> >> >> >    =20
> > >> >> >> >     }
> > >> >> >> >=20
> > >> >> >> > +
> > >> >> >> > +   if (tcon->quirks->has_tcon_top_gate) {
> > >> >> >> > +           tcon->top_clk =3D devm_clk_get(dev, "tcon-top");
> > >> >> >> > +           if (IS_ERR(tcon->top_clk)) {
> > >> >> >> > +                   dev_err(dev, "Couldn't get the TCON TOP =
bus
> > >> >> >> > clock\n");
> > >> >> >> > +                   return PTR_ERR(tcon->top_clk);
> > >> >> >> > +           }
> > >> >> >> > +           clk_prepare_enable(tcon->top_clk);
> > >> >> >> > +   }
> > >> >> >> > +
> > >> >> >>=20
> > >> >> >> Is it required for the TCON itself to operate, or does the TCON
> > >> >> >> requires the TCON TOP, which in turn requires that clock to be
> > >> >> >> functional?
> > >> >> >>=20
> > >> >> >> I find it quite odd to have a clock that isn't meant for a
> > >> >> >> particular
> > >> >> >> device to actually be wired to another device. I'm not saying
> > >> >> >> this
> > >> >> >> isn't the case, but it would be a first.
> > >> >> >=20
> > >> >> > Documentation doesn't say much about that gate. I did few tests
> > >> >> > and
> > >> >> > TCON
> > >> >> > registers can be read and written even if TCON TOP TV TCON gate=
 is
> > >> >> > disabled. However, there is no image, as expected.
> > >> >>=20
> > >> >> The R40 manual does include it in the diagram, on page 504. There=
's
> > >> >> also
> > >> >> a
> > >> >> mux to select whether the clock comes directly from the CCU or the
> > >> >> TV
> > >> >> encoder (a feedback mode?). I assume this is the gate you are
> > >> >> referring
> > >> >> to
> > >> >> here, in which case it is not a bus clock, but rather the TCON
> > >> >> module
> > >> >> or
> > >> >> channel clock, strangely routed.
> > >> >>=20
> > >> >> > More interestingly, I enabled test pattern directly in TCON to
> > >> >> > eliminate
> > >> >> > influence of the mixer. As soon as I disabled that gate, test
> > >> >> > pattern
> > >> >> > on
> > >> >> > HDMI screen was gone, which suggest that this gate influences
> > >> >> > something
> > >> >> > inside TCON.
> > >> >> >=20
> > >> >> > Another test I did was that I moved enable/disable gate code to
> > >> >> > sun4i_tcon_channel_set_status() and it worked just as well.
> > >> >> >=20
> > >> >> > I'll ask AW engineer what that gate actually does, but from wha=
t I
> > >> >> > saw,
> > >> >> > I
> > >> >> > would say that most appropriate location to enable/disable TCON
> > >> >> > TOP
> > >> >> > TV
> > >> >> > TCON
> > >> >> > gate is TCON driver. Alternatively, TCON TOP driver could check=
 if
> > >> >> > any
> > >> >> > TV
> > >> >> > TCON is in use and enable appropriate gate. However, that doesn=
't
> > >> >> > sound
> > >> >> > right to me for some reason.
> > >> >>=20
> > >> >> If what I said above it true, then yes, the appropriate location =
to
> > >> >> enable
> > >> >> it is the TCON driver, but moreover, the representation of the cl=
ock
> > >> >> tree
> > >> >> should be fixed such that the TCON takes the clock from the TCON =
TOP
> > >> >> as
> > >> >> its
> > >> >> channel/ module clock instead. That way you don't need this patch,
> > >> >> but
> > >> >> you'd add another for all the clock routing.
> > >> >=20
> > >> > Can you be more specific? I not sure what you mean here.
> > >>=20
> > >> For clock related properties in the device tree:
> > >>=20
> > >> &tcon_top {
> > >>=20
> > >>     clocks =3D <&ccu CLK_BUS_TCON_TOP>,
> > >>    =20
> > >>              <&ccu CLK_TCON_TV0>,
> > >>              <&tve0>,
> > >>              <&ccu CLK_TCON_TV1>,
> > >>              <&tve1>;
> > >>    =20
> > >>     clock-names =3D "bus", "tcon-tv0", "tve0", "tcon-tv1", "tve1";
> > >>     clock-output-names =3D "tcon-top-tv0", "tcon-top-tv1";
> > >>=20
> > >> };
> > >>=20
> > >> &tcon_tv0 {
> > >>=20
> > >>     clocks =3D <&ccu CLK_BUS_TCON_TV0>, <&tcon_top 0>'
> > >>     clock-names =3D "ahb", "tcon-ch1";
> > >>=20
> > >> };
> > >>=20
> > >> A diagram would look like:
> > >>                    | This part is TCON TOP |
> > >>                   =20
> > >>                    v                       v
> > >>=20
> > >> CCU CLK_TCON_TV0 --|----\                  |
> > >>=20
> > >>                    |     mux ---- gate ----|-- TCON_TV0
> > >>=20
> > >> TVE0 --------------|----/                  |
> > >>=20
> > >> And the same goes for TCON_TV1 and TVE1.
> > >>=20
> > >> The user manual is a bit lacking on how TVE outputs a clock though.
> > >=20
> > > I didn't yet received any response on HW details from AW till now, bu=
t I
> > > would like to post new version of patches soon.
> > >=20
> > > While chaining like you described could be implemented easily, I don't
> > > think it really represents HW as it is. Tests showed that these two
> > > clocks are independent, otherwise register writes/reads wouldn't be
> > > possible with tcon- top gate disabled. I chose tcon-top bus clock as a
> > > parent becase if it is not enabled, it simply won't work.
> >=20
> > AFAIK with the TCONs, even when the TCON channel clock (not the bus clo=
ck)
> > is disabled, register accesses still work.
>=20
> You're right, I just tested that.
>=20
> > I'm saying that the TCON TOP
> > gate is downstream from the TCON channel clock in the CCU. These are not
> > related to the TCON bus clock in the CCU, which affects register access.
> >=20
> > Did Allwinner provide any information regarding the hierarchy of the
> > clocks?
> No reponse for now.
>=20
> > > However, if everyone feels chaining is the best way to implement it,
> > > I'll
> > > do it.
> >=20
> > I would like to get it right and match actual hardware. My proposal is
> > based on my understanding from the diagrams in the user manual.
>=20
> So for now, your explanation is the most reasonable. Should we go ahead a=
nd
> implement your idea?
>=20
> Please note that H6 has TCON-TOP too, but it has only one LCD TCON and one
> TV TCON instead of two of each kind. That means we will have hole in
> indices (tcon_lcd0 is 1, tcon_tv0 is 3, which is aligned with R40) and
> different TCON- TOP binding (no tcon_tv1 channel clock), but setup is
> exactly the same.

I just noticed issue with this proposal. If we have following clock chain f=
or=20
HDMI, everythings is ok:

TCON-TV0 -> TCON-TOP-TV0

TCON TV sets TCON-TOP-TV0 clock rate, which in turn sets TCON-TV0 clock and=
=20
everything works.

However, when TVE will be configured, it would look like this:

TVE0 -> TCON-TOP-TV0

TVE driver will set TVE0 clock to 216 MHz and TCON TV would set TCON-TOP-TV=
0=20
rate which in turn sets TVE0 clock to something like 13.5 MHz (or whatever =
is=20
the right clock rate for PAL and NTSC). As you can see, same clock is set t=
o=20
two different rates by two different drivers.

It *might* still work, since encoders set clock rate after TCON (at least t=
hat=20
is my experience for HDMI pipeline), but that is still wrong.

To overcome above issue, I would stick to original proposal with additional=
=20
clock specified in TCON TV DT node. That way TCON driver would always set=20
clock rate to TCON-TV0 clock. If TVE0 is enabled, TCON wouldn't interfere w=
ith=20
setting clock rate, because TCON-TV0 clock would be decoupled in TCON-TOP m=
ux.

What do you think?

Best regards,
Jernej





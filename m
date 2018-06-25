Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F6EC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 09:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D22C2566D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 09:11:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eS4WTPfg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D22C2566D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754795AbeFYJL5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 05:11:57 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:55217 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754449AbeFYJLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 05:11:55 -0400
Received: by mail-wm0-f67.google.com with SMTP id i139-v6so1389981wmf.4;
        Mon, 25 Jun 2018 02:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NFd0IJMag7puFyBM68N2yrhKG4NuZaeYIDCYeaTPTXY=;
        b=eS4WTPfgK0i/E41ZdaAUXwt4M5wq+xtQFRKWn3B3PTlQp7RimtzPSAaLY06hbqFTNP
         icK9JFJgI37uTS+KqKbY1ySRVC3sBdItdaiLCvWvQP3J2ad9xJXFeOUF+nBG0Y9lvSz0
         ky5beXA/xQ8eTFkk6YWcDKAbaS2eDKzRwyo4oHBa8ne9rkcS+uAUyjwDm2jWpWM64FzT
         Vvg09hxz7qLU0ORQQZkA/FGq1z+pf+oIJ8UR+QG48bCFio55qmjmF4hbfwethkw0terF
         74OGtcdh4FSJv/vWoRvYD43Ho8sCv3tDB1lrbnfNdIEC85h8dwvN7RMHPdqgfUYjuBV4
         PgAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NFd0IJMag7puFyBM68N2yrhKG4NuZaeYIDCYeaTPTXY=;
        b=hTM0DqoCDFtvikIsHqxkoMuTNHD0hwD9BCYnRZBImRHORre4dFI7uPFk45gKy7Z79F
         SDKYw+SUvkps4KOMdVtOzO82ia4nEg4+16yaRuPUzReNDAk5GbiNueXI/5G+MNJVZieN
         3U7SF83SxpmecqQ3tmxH8GV7YukFX/uWyZw+S/k/SIonsRlCXUnb1my59hKHkHNDjyyG
         Mws83aqQxDHVHYVp8iMWw0cXeXL0aGhIlNXf+P4UGJ9CcKiXjOjyMw+m93Hlj100jyc7
         eKyeIJz1SCtI5YOTzUHMy8oWx2JMoNkEPRAGjF/1OUm888I/aRJ49rDl6iUp1gzrxuIB
         ilsQ==
X-Gm-Message-State: APt69E2jy55eE2OOZSJVMCS4JTZNUaw5bMYCNc97CxO/0WQ94EvRcokS
        Bp6NtL2iHgLvAYMm3FGGy6IgoSjL
X-Google-Smtp-Source: AAOMgpeLqlAo6P7mvRLImEzsS3dclVyWrmSls6UCtjCqv9LceTSQ1e7ITA7IXLtLvYM1J1xhfKBYdg==
X-Received: by 2002:a1c:84d0:: with SMTP id g199-v6mr349402wmd.90.1529917913511;
        Mon, 25 Jun 2018 02:11:53 -0700 (PDT)
Received: from jernej-laptop.localnet ([194.152.15.144])
        by smtp.gmail.com with ESMTPSA id u15-v6sm13256185wma.37.2018.06.25.02.11.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Jun 2018 02:11:52 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     linux-sunxi@googlegroups.com, wens@csie.org
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
        linux-clk <linux-clk@vger.kernel.org>
Subject: Re: [linux-sunxi] Re: [PATCH v2 11/27] drm/sun4i: tcon: Add support for tcon-top gate
Date:   Mon, 25 Jun 2018 11:10:30 +0200
Message-ID: <2426089.g6yXFYEL1F@jernej-laptop>
In-Reply-To: <CAGb2v676mFiOry5eQabzkyVaQ6R64gT2_XuBzTAtHorNzfwCuw@mail.gmail.com>
References: <20180612200036.21483-1-jernej.skrabec@siol.net> <1797170.duyCyYzgBk@jernej-laptop> <CAGb2v676mFiOry5eQabzkyVaQ6R64gT2_XuBzTAtHorNzfwCuw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne ponedeljek, 25. junij 2018 ob 10:14:52 CEST je Chen-Yu Tsai napisal(a):
> On Mon, Jun 25, 2018 at 3:58 PM, Jernej =C5=A0krabec
>=20
> <jernej.skrabec@gmail.com> wrote:
> > Dne ponedeljek, 25. junij 2018 ob 05:51:41 CEST je Chen-Yu Tsai=20
napisal(a):
> >> On Mon, Jun 25, 2018 at 3:52 AM, Jernej =C5=A0krabec
> >>=20
> >> <jernej.skrabec@gmail.com> wrote:
> >> > Dne =C4=8Detrtek, 21. junij 2018 ob 17:35:45 CEST je Jernej =C5=A0kr=
abec=20
napisal(a):
> >> >> Dne =C4=8Detrtek, 21. junij 2018 ob 03:23:27 CEST je Chen-Yu Tsai=20
napisal(a):
> >> >> > On Thu, Jun 21, 2018 at 3:37 AM, Jernej =C5=A0krabec
> >> >> > <jernej.skrabec@siol.net>
> >> >>=20
> >> >> wrote:
> >> >> > > Dne sobota, 16. junij 2018 ob 07:48:38 CEST je Chen-Yu Tsai
> >=20
> > napisal(a):
> >> >> > >> On Sat, Jun 16, 2018 at 1:33 AM, Jernej =C5=A0krabec
> >> >> > >> <jernej.skrabec@siol.net>
> >> >> > >=20
> >> >> > > wrote:
> >> >> > >> > Dne petek, 15. junij 2018 ob 19:13:17 CEST je Chen-Yu Tsai
> >> >=20
> >> > napisal(a):
> >> >> > >> >> On Sat, Jun 16, 2018 at 12:41 AM, Jernej =C5=A0krabec
> >> >> > >> >>=20
> >> >> > >> >> <jernej.skrabec@siol.net> wrote:
> >> >> > >> >> > Hi,
> >> >> > >> >> >=20
> >> >> > >> >> > Dne petek, 15. junij 2018 ob 10:31:10 CEST je Maxime Ripa=
rd
> >> >>=20
> >> >> napisal(a):
> >> >> > >> >> >> Hi,
> >> >> > >> >> >>=20
> >> >> > >> >> >> On Tue, Jun 12, 2018 at 10:00:20PM +0200, Jernej Skrabec
> >=20
> > wrote:
> >> >> > >> >> >> > TV TCONs connected to TCON TOP have to enable addition=
al
> >> >> > >> >> >> > gate
> >> >> > >> >> >> > in
> >> >> > >> >> >> > order
> >> >> > >> >> >> > to work.
> >> >> > >> >> >> >=20
> >> >> > >> >> >> > Add support for such TCONs.
> >> >> > >> >> >> >=20
> >> >> > >> >> >> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> >> >> > >> >> >> > ---
> >> >> > >> >> >> >=20
> >> >> > >> >> >> >  drivers/gpu/drm/sun4i/sun4i_tcon.c | 11 +++++++++++
> >> >> > >> >> >> >  drivers/gpu/drm/sun4i/sun4i_tcon.h |  4 ++++
> >> >> > >> >> >> >  2 files changed, 15 insertions(+)
> >> >> > >> >> >> >=20
> >> >> > >> >> >> > diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c
> >> >> > >> >> >> > b/drivers/gpu/drm/sun4i/sun4i_tcon.c index
> >> >> > >> >> >> > 08747fc3ee71..0afb5a94a414
> >> >> > >> >> >> > 100644
> >> >> > >> >> >> > --- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
> >> >> > >> >> >> > +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> >> >> > >> >> >> > @@ -688,6 +688,16 @@ static int
> >> >> > >> >> >> > sun4i_tcon_init_clocks(struct
> >> >> > >> >> >> > device
> >> >> > >> >> >> > *dev,
> >> >> > >> >> >> >=20
> >> >> > >> >> >> >             dev_err(dev, "Couldn't get the TCON bus
> >> >> > >> >> >> >             clock\n");
> >> >> > >> >> >> >             return PTR_ERR(tcon->clk);
> >> >> > >> >> >> >    =20
> >> >> > >> >> >> >     }
> >> >> > >> >> >> >=20
> >> >> > >> >> >> > +
> >> >> > >> >> >> > +   if (tcon->quirks->has_tcon_top_gate) {
> >> >> > >> >> >> > +           tcon->top_clk =3D devm_clk_get(dev,
> >> >> > >> >> >> > "tcon-top");
> >> >> > >> >> >> > +           if (IS_ERR(tcon->top_clk)) {
> >> >> > >> >> >> > +                   dev_err(dev, "Couldn't get the TCON
> >> >> > >> >> >> > TOP
> >> >> > >> >> >> > bus
> >> >> > >> >> >> > clock\n");
> >> >> > >> >> >> > +                   return PTR_ERR(tcon->top_clk);
> >> >> > >> >> >> > +           }
> >> >> > >> >> >> > +           clk_prepare_enable(tcon->top_clk);
> >> >> > >> >> >> > +   }
> >> >> > >> >> >> > +
> >> >> > >> >> >>=20
> >> >> > >> >> >> Is it required for the TCON itself to operate, or does t=
he
> >> >> > >> >> >> TCON
> >> >> > >> >> >> requires the TCON TOP, which in turn requires that clock=
 to
> >> >> > >> >> >> be
> >> >> > >> >> >> functional?
> >> >> > >> >> >>=20
> >> >> > >> >> >> I find it quite odd to have a clock that isn't meant for=
 a
> >> >> > >> >> >> particular
> >> >> > >> >> >> device to actually be wired to another device. I'm not
> >> >> > >> >> >> saying
> >> >> > >> >> >> this
> >> >> > >> >> >> isn't the case, but it would be a first.
> >> >> > >> >> >=20
> >> >> > >> >> > Documentation doesn't say much about that gate. I did few
> >> >> > >> >> > tests
> >> >> > >> >> > and
> >> >> > >> >> > TCON
> >> >> > >> >> > registers can be read and written even if TCON TOP TV TCON
> >> >> > >> >> > gate
> >> >> > >> >> > is
> >> >> > >> >> > disabled. However, there is no image, as expected.
> >> >> > >> >>=20
> >> >> > >> >> The R40 manual does include it in the diagram, on page 504.
> >> >> > >> >> There's
> >> >> > >> >> also
> >> >> > >> >> a
> >> >> > >> >> mux to select whether the clock comes directly from the CCU=
 or
> >> >> > >> >> the
> >> >> > >> >> TV
> >> >> > >> >> encoder (a feedback mode?). I assume this is the gate you a=
re
> >> >> > >> >> referring
> >> >> > >> >> to
> >> >> > >> >> here, in which case it is not a bus clock, but rather the T=
CON
> >> >> > >> >> module
> >> >> > >> >> or
> >> >> > >> >> channel clock, strangely routed.
> >> >> > >> >>=20
> >> >> > >> >> > More interestingly, I enabled test pattern directly in TC=
ON
> >> >> > >> >> > to
> >> >> > >> >> > eliminate
> >> >> > >> >> > influence of the mixer. As soon as I disabled that gate,
> >> >> > >> >> > test
> >> >> > >> >> > pattern
> >> >> > >> >> > on
> >> >> > >> >> > HDMI screen was gone, which suggest that this gate
> >> >> > >> >> > influences
> >> >> > >> >> > something
> >> >> > >> >> > inside TCON.
> >> >> > >> >> >=20
> >> >> > >> >> > Another test I did was that I moved enable/disable gate c=
ode
> >> >> > >> >> > to
> >> >> > >> >> > sun4i_tcon_channel_set_status() and it worked just as wel=
l.
> >> >> > >> >> >=20
> >> >> > >> >> > I'll ask AW engineer what that gate actually does, but fr=
om
> >> >> > >> >> > what I
> >> >> > >> >> > saw,
> >> >> > >> >> > I
> >> >> > >> >> > would say that most appropriate location to enable/disable
> >> >> > >> >> > TCON
> >> >> > >> >> > TOP
> >> >> > >> >> > TV
> >> >> > >> >> > TCON
> >> >> > >> >> > gate is TCON driver. Alternatively, TCON TOP driver could
> >> >> > >> >> > check
> >> >> > >> >> > if
> >> >> > >> >> > any
> >> >> > >> >> > TV
> >> >> > >> >> > TCON is in use and enable appropriate gate. However, that
> >> >> > >> >> > doesn't
> >> >> > >> >> > sound
> >> >> > >> >> > right to me for some reason.
> >> >> > >> >>=20
> >> >> > >> >> If what I said above it true, then yes, the appropriate
> >> >> > >> >> location
> >> >> > >> >> to
> >> >> > >> >> enable
> >> >> > >> >> it is the TCON driver, but moreover, the representation of =
the
> >> >> > >> >> clock
> >> >> > >> >> tree
> >> >> > >> >> should be fixed such that the TCON takes the clock from the
> >> >> > >> >> TCON
> >> >> > >> >> TOP
> >> >> > >> >> as
> >> >> > >> >> its
> >> >> > >> >> channel/ module clock instead. That way you don't need this
> >> >> > >> >> patch,
> >> >> > >> >> but
> >> >> > >> >> you'd add another for all the clock routing.
> >> >> > >> >=20
> >> >> > >> > Can you be more specific? I not sure what you mean here.
> >> >> > >>=20
> >> >> > >> For clock related properties in the device tree:
> >> >> > >>=20
> >> >> > >> &tcon_top {
> >> >> > >>=20
> >> >> > >>     clocks =3D <&ccu CLK_BUS_TCON_TOP>,
> >> >> > >>    =20
> >> >> > >>              <&ccu CLK_TCON_TV0>,
> >> >> > >>              <&tve0>,
> >> >> > >>              <&ccu CLK_TCON_TV1>,
> >> >> > >>              <&tve1>;
> >> >> > >>    =20
> >> >> > >>     clock-names =3D "bus", "tcon-tv0", "tve0", "tcon-tv1", "tv=
e1";
> >> >> > >>     clock-output-names =3D "tcon-top-tv0", "tcon-top-tv1";
> >> >> > >>=20
> >> >> > >> };
> >> >> > >>=20
> >> >> > >> &tcon_tv0 {
> >> >> > >>=20
> >> >> > >>     clocks =3D <&ccu CLK_BUS_TCON_TV0>, <&tcon_top 0>'
> >> >> > >>     clock-names =3D "ahb", "tcon-ch1";
> >> >> > >>=20
> >> >> > >> };
> >> >> > >>=20
> >> >> > >> A diagram would look like:
> >> >> > >>                    | This part is TCON TOP |
> >> >> > >>                   =20
> >> >> > >>                    v                       v
> >> >> > >>=20
> >> >> > >> CCU CLK_TCON_TV0 --|----\                  |
> >> >> > >>=20
> >> >> > >>                    |     mux ---- gate ----|-- TCON_TV0
> >> >> > >>=20
> >> >> > >> TVE0 --------------|----/                  |
> >> >> > >>=20
> >> >> > >> And the same goes for TCON_TV1 and TVE1.
> >> >> > >>=20
> >> >> > >> The user manual is a bit lacking on how TVE outputs a clock
> >> >> > >> though.
> >> >> > >=20
> >> >> > > I didn't yet received any response on HW details from AW till n=
ow,
> >> >> > > but I
> >> >> > > would like to post new version of patches soon.
> >> >> > >=20
> >> >> > > While chaining like you described could be implemented easily, I
> >> >> > > don't
> >> >> > > think it really represents HW as it is. Tests showed that these
> >> >> > > two
> >> >> > > clocks are independent, otherwise register writes/reads wouldn't
> >> >> > > be
> >> >> > > possible with tcon- top gate disabled. I chose tcon-top bus clo=
ck
> >> >> > > as
> >> >> > > a
> >> >> > > parent becase if it is not enabled, it simply won't work.
> >> >> >=20
> >> >> > AFAIK with the TCONs, even when the TCON channel clock (not the b=
us
> >> >> > clock)
> >> >> > is disabled, register accesses still work.
> >> >>=20
> >> >> You're right, I just tested that.
> >> >>=20
> >> >> > I'm saying that the TCON TOP
> >> >> > gate is downstream from the TCON channel clock in the CCU. These =
are
> >> >> > not
> >> >> > related to the TCON bus clock in the CCU, which affects register
> >> >> > access.
> >> >> >=20
> >> >> > Did Allwinner provide any information regarding the hierarchy of =
the
> >> >> > clocks?
> >> >>=20
> >> >> No reponse for now.
> >> >>=20
> >> >> > > However, if everyone feels chaining is the best way to implement
> >> >> > > it,
> >> >> > > I'll
> >> >> > > do it.
> >> >> >=20
> >> >> > I would like to get it right and match actual hardware. My propos=
al
> >> >> > is
> >> >> > based on my understanding from the diagrams in the user manual.
> >> >>=20
> >> >> So for now, your explanation is the most reasonable. Should we go
> >> >> ahead
> >> >> and
> >> >> implement your idea?
> >> >>=20
> >> >> Please note that H6 has TCON-TOP too, but it has only one LCD TCON =
and
> >> >> one
> >> >> TV TCON instead of two of each kind. That means we will have hole in
> >> >> indices (tcon_lcd0 is 1, tcon_tv0 is 3, which is aligned with R40) =
and
> >> >> different TCON- TOP binding (no tcon_tv1 channel clock), but setup =
is
> >> >> exactly the same.
> >> >=20
> >> > I just noticed issue with this proposal. If we have following clock
> >> > chain
> >> > for HDMI, everythings is ok:
> >> >=20
> >> > TCON-TV0 -> TCON-TOP-TV0
> >> >=20
> >> > TCON TV sets TCON-TOP-TV0 clock rate, which in turn sets TCON-TV0 cl=
ock
> >> > and
> >> > everything works.
> >> >=20
> >> > However, when TVE will be configured, it would look like this:
> >> >=20
> >> > TVE0 -> TCON-TOP-TV0
> >> >=20
> >> > TVE driver will set TVE0 clock to 216 MHz and TCON TV would set
> >> > TCON-TOP-TV0 rate which in turn sets TVE0 clock to something like 13=
=2E5
> >> > MHz (or whatever is the right clock rate for PAL and NTSC). As you c=
an
> >> > see, same clock is set to two different rates by two different drive=
rs.
> >> >=20
> >> > It *might* still work, since encoders set clock rate after TCON (at
> >> > least
> >> > that is my experience for HDMI pipeline), but that is still wrong.
> >> >=20
> >> > To overcome above issue, I would stick to original proposal with
> >> > additional
> >> > clock specified in TCON TV DT node. That way TCON driver would always
> >> > set
> >> > clock rate to TCON-TV0 clock. If TVE0 is enabled, TCON wouldn't
> >> > interfere
> >> > with setting clock rate, because TCON-TV0 clock would be decoupled in
> >> > TCON-TOP mux.
> >> >=20
> >> > What do you think?
> >>=20
> >> I think this is the wrong representation, and worse, you are trying to
> >> work
> >> around software issues with it.
> >>=20
> >> So to confirm some details, the TVE expects 216 MHz clock, and it expe=
cts
> >> the TCON to run and output data at 216 MHz as well. Is that correct?
> >=20
> > Yes, from my understanding. 216 MHz is correct at least for PAL and NTS=
C,
> > e.g. TV mode. TVE on R40 is also capable of RGB mode (VGA connector).
> >=20
> >> Would any settings for the TCON differ between when HDMI or TVE is use=
d?
> >=20
> > Apart of clock, no, other settings would be the same.
> >=20
> >> Does TVE and TCON run at 216 MHz regardless of resolution? I kind of
> >> doubt
> >> it. It might be expecting 297 MHz for PC resolutions.
> >=20
> > Please check this table in BSP:
> > https://github.com/BPI-SINOVOIP/BPI-M2U-bsp/blob/master/linux-sunxi/dri=
ver
> > s/ video/sunxi/disp2/tv/drv_tv.c#L24
> >=20
> > 216 MHz is applicable for low resolution, interlaced modes. Modes like
> > 1080P, 1080I have expected standard timing.
>=20
> That's weird. So it only applies to SDTV video resolutions. I remember
> seeing an "up sampling" setting for composite in the TVE, which goes all
> the way up to 216 MHz. Maybe that's the reason?
>=20

Probably. If upsampling is set to 0, it still needs 27 MHz, which is 2x mor=
e=20
than standard PAL/NTSC clock. After studying AC200 manual (which is similar=
 TV=20
encoder) and its driver, it seems the reason for that is 8 bit parallel=20
interface between TCON and TVE and 16 bit data (CCIR656).

However, actual tests would be needed to confirm all that.

> I wonder how the TCON manages this though. I mean with the dot clock this
> high, doesn't that mean the frame rate is much higher?
>=20

Not sure, but IMO it is downscaled somehow in TVE HW to get proper rates at=
=20
the end.

> >> I think these kinds of quirks should be handled in the software, inste=
ad
> >> of
> >> being papered over.
> >=20
> > Ok, that works for me too. I would just like to have such design that
> > would
> > later allow implementing TVE driver without much issues.
> >=20
> > BTW, H3 TV TCON which is connected to TVE doesn't have TCON-TV channel
> > clock at all, since it is controlled with TVE clock (same case as it
> > would be here, if TCON TOP mux is switched to TVE clock source).
>=20
> Does it require 216 MHz as well?

Yes. It supports only PAL and NTSC (only one DAC), so BSP driver sets TVE=20
clock to 216 MHz.

>=20
> > Maybe quirk can be added that it doesn't set clock rate at all if it is
> > connected to TVE?
>=20
> A quirk yes. But the dot clock would be 216 MHz instead of not setting it,
> and only for certain display modes. To be honest I think we can get by wi=
th
> just a TODO note for now.

Why not leave control of channel rate to TVE, since it knows if oversamplin=
g=20
is enabled or not? But that's debate for another time.

I will send new R40 HDMI patches according your original proposal.

Best regards,
Jernej





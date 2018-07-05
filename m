Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 727CEC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 07:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28D9224171
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 07:04:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28D9224171
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753476AbeGEHEN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 03:04:13 -0400
Received: from mail.bootlin.com ([62.4.15.54]:40269 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752681AbeGEHEK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 03:04:10 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id DA78020875; Thu,  5 Jul 2018 09:04:07 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-39-106.w90-88.abo.wanadoo.fr [90.88.158.106])
        by mail.bootlin.com (Postfix) with ESMTPSA id A1FB6207F4;
        Thu,  5 Jul 2018 09:03:57 +0200 (CEST)
Date:   Thu, 5 Jul 2018 09:03:58 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@siol.net>,
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
Subject: Re: [linux-sunxi] Re: [PATCH v3 09/24] drm/sun4i: Don't skip TCONs
 if they don't have channel 0
Message-ID: <20180705070358.7ng4shuo3pxp62q6@flea>
References: <20180625120304.7543-1-jernej.skrabec@siol.net>
 <2676604.ZYCNkuCdbT@jernej-laptop>
 <CAGb2v67kBRWkJpJogFR4GXgA66dsxVaMVWN8MDiP_wFTqxW-=g@mail.gmail.com>
 <8952939.l1hLr1Mv9y@jernej-laptop>
 <CAGb2v66_6RoYk6MRtTJeqg0Z09A7y+pvSxs7qeeND+iKPE_+BA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="i5zigfhfx43jr7yb"
Content-Disposition: inline
In-Reply-To: <CAGb2v66_6RoYk6MRtTJeqg0Z09A7y+pvSxs7qeeND+iKPE_+BA@mail.gmail.com>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--i5zigfhfx43jr7yb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 01, 2018 at 11:11:06PM +0800, Chen-Yu Tsai wrote:
> On Sun, Jul 1, 2018 at 4:27 PM, Jernej =C5=A0krabec <jernej.skrabec@siol.=
net> wrote:
> > Dne =C4=8Detrtek, 28. junij 2018 ob 08:24:34 CEST je Chen-Yu Tsai napis=
al(a):
> >> On Thu, Jun 28, 2018 at 12:45 PM, Jernej =C5=A0krabec
> >>
> >> <jernej.skrabec@siol.net> wrote:
> >> > Dne =C4=8Detrtek, 28. junij 2018 ob 03:51:31 CEST je Chen-Yu Tsai na=
pisal(a):
> >> >> On Mon, Jun 25, 2018 at 8:02 PM, Jernej Skrabec <jernej.skrabec@sio=
l.net>
> >> >
> >> > wrote:
> >> >> > TV TCONs (channel 1 only) are always connected to TV or HDMI enco=
der.
> >> >> > Because of that, all output endpoints on such TCON node will poin=
t to a
> >> >> > encoder which is part of component framework.
> >> >> >
> >> >> > Correct current graph traversing algorithm in such way that it do=
esn't
> >> >> > skip output enpoints with id 0 on TV TCONs.
> >> >>
> >> >> No. Our bindings say that endpoint 0 _is_ channel 0. For TCONs that=
 don't
> >> >> have channel 0, it must be skipped.
> >> >
> >> > I'm not sure where this is stated. I read TCON binding again. Can you
> >> > please point me to it?
> >>
> >> https://elixir.bootlin.com/linux/latest/source/Documentation/devicetre=
e/bind
> >> ings/display/sunxi/sun4i-drm.txt#L169
> >>
> >> Our TCON driver still expects RGB or LVDS panel / bridges on endpoint =
0.
> >
> > Yes, but that can only happen on TCON which has channel 0. TV TCONs (th=
ose
> > with channel 1 only) can't have panels or bridges connected to them, be=
cause
> > they are internally always connected to either HDMI or TV encoder or bo=
th.
> > Actually, R40 is the only SoC, where same TV TCON can be connected to TV
> > encoder or HDMI. Others have specialized TV TCONs, which are connect to=
 only
> > one encoder.
> >
> > IMO TV TCONs are really just stripped down LCD TCONs to support one (or=
 max
> > two) specific encoder.
>=20
> I agree. We've seen these first in the H3, and the reverse, TCONs only wi=
th
> LCD, on the A23/A33.
>=20
> >> So I guess this was sort of implied historically. It's no longer true.
> >> This is something we should probably fix.
> >
> > Fixed in what way? You mean update bindings to mention that TCON output
> > endpoint 0 is reserved for panels or bridges?
>=20
> Either that, or have the drm driver look at other endpoints. I guess we
> should ask Maxime if this is already done or not, since the DSI driver
> isn't endpoint 0 in the A33 dtsi.

The DSI driver isn't really a good example for this, since the panel
isn't described as part of the OF graph, but DSI binding require that
it's a child of the DSI controller node.

> >>
> >> In practice our drivers don't look at it (yet), but rely on the downst=
ream
> >> encoder type to determine which channel to use.
> >>
> >> But please add the "allwinner,tcon-channel" property as specified in
> >> the binding.
> >
> > It's my understanding of TCON binding documentation that property
> > "allwinner,tcon-channel" is needed only if TCON supports both channels.=
 TV
> > TCON clearly supports only channel 1. In that case, there is no doubt t=
o which
> > channel output endpoint belongs.
> >
> > If that's not true, dt bindings documentation should be reworded to con=
tain
> > word "needed" or something similar. Currently, no DT for newer SoC cont=
ains
> > that property (for example, A83T, H3, H5 or even A33).

Yeah, but that's mainly because we have a single output enabled for
each channel on those newer SoCs. When / if we enable the RGB and LVDS
output for example, we will have to set this.

> > On A33 this is even more interesting, since tcon0 has only channel
> > 0 and has DSI output endpoint with number 1. According to TCON
> > binding docs, if "allwinner,tcon-channel" is not preset, endpoint
> > number represent channel. So, that would mean DSI needs channel 1
> > on tcon which supports clearly only channel 0. So either there
> > TCON bindings documentation needs updates or DT for A33 has to be
> > updated.
>=20
> Maxime? You did the A33 DSI stuff.

I guess it's missing on the A33 DSI endpoint.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--i5zigfhfx43jr7yb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAls9wswACgkQ0rTAlCFN
r3Q3jRAAl2kPMyugf4WMM4IIZCeoxncS7O8gzPEmHA5kaNVDgF95DlT7ZCqufu1R
qvAfcEAJgFTJcxW57kG9MRU8JyTByIuG2lDbADRZyw2SHe3JfUPMtrnvJqa1pjI1
lMwdR5UXmxdpkzyn3A4JzAiUhfOzeo5QKly6ciefPpJVp0J3xyxXXZ/GLtV8Njrz
0/zvehN38bfj72BG4TxB1LgJiYt3+MeG03pwFLUmGy3tTrTFoFPixTzmHgzHMRF9
ZclAr7X+NgNkczB9+gGs+JmF0y8KwMp8QBATeQMAfXq8y4i70XqWteBFxAw02jKS
84vVFft3m0no7SV3ecGnfCxuwzXytk5fqCAO4m7rNomRttEXioaEaClHtN1n6Nz0
OfPchZTijgGKOb16TcrZccPHVa8K+IMZ8rowqRQmhdtY3jd0ehZf1Sv3rxN7sjyY
mgy3EHmwNWBKU6DzpSVPZ6fl7HtTixzsP5z4K43mMk0PDT3dPmDEV+e8ZfJMQDTw
YXr5eQrKXOQzQl8uzxnZosAUtESDYrQQnxtirXEmyW9KUe8zIXTBj9goStb2hv/2
7nWUtOksZyXWnU/Yc+CB4v9538s2Ekr3k5mVbyia6vrFjR2ZIoE6FRvuEXQCZdQD
RbDSgO3XiBWhwCMR2i6yvHbcHN1KT+YpMR6nnYC4VBaxDj094UQ=
=mKes
-----END PGP SIGNATURE-----

--i5zigfhfx43jr7yb--

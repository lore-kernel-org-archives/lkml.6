Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F623C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B859E20673
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:59:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B859E20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932850AbeGII7o (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 04:59:44 -0400
Received: from mail.bootlin.com ([62.4.15.54]:44815 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754142AbeGII7m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 04:59:42 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id C49E120914; Mon,  9 Jul 2018 10:59:40 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-12-56.w90-88.abo.wanadoo.fr [90.88.133.56])
        by mail.bootlin.com (Postfix) with ESMTPSA id 9448420893;
        Mon,  9 Jul 2018 10:59:30 +0200 (CEST)
Date:   Mon, 9 Jul 2018 10:59:30 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@siol.net>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
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
Message-ID: <20180709085930.dgcxrs3jqcrhu5gm@flea>
References: <20180625120304.7543-1-jernej.skrabec@siol.net>
 <CAGb2v66_6RoYk6MRtTJeqg0Z09A7y+pvSxs7qeeND+iKPE_+BA@mail.gmail.com>
 <20180705070358.7ng4shuo3pxp62q6@flea>
 <1699738.FoQmAThxyL@jernej-laptop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="iad3qlutlabjodpq"
Content-Disposition: inline
In-Reply-To: <1699738.FoQmAThxyL@jernej-laptop>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--iad3qlutlabjodpq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 05, 2018 at 10:03:35PM +0200, Jernej =C5=A0krabec wrote:
> Dne =C4=8Detrtek, 05. julij 2018 ob 09:03:58 CEST je Maxime Ripard napisa=
l(a):
> > On Sun, Jul 01, 2018 at 11:11:06PM +0800, Chen-Yu Tsai wrote:
> > > On Sun, Jul 1, 2018 at 4:27 PM, Jernej =C5=A0krabec <jernej.skrabec@s=
iol.net>=20
> wrote:
> > > > Dne =C4=8Detrtek, 28. junij 2018 ob 08:24:34 CEST je Chen-Yu Tsai n=
apisal(a):
> > > >> On Thu, Jun 28, 2018 at 12:45 PM, Jernej =C5=A0krabec
> > > >>=20
> > > >> <jernej.skrabec@siol.net> wrote:
> > > >> > Dne =C4=8Detrtek, 28. junij 2018 ob 03:51:31 CEST je Chen-Yu Tsa=
i=20
> napisal(a):
> > > >> >> On Mon, Jun 25, 2018 at 8:02 PM, Jernej Skrabec
> > > >> >> <jernej.skrabec@siol.net>
> > > >> >=20
> > > >> > wrote:
> > > >> >> > TV TCONs (channel 1 only) are always connected to TV or HDMI
> > > >> >> > encoder.
> > > >> >> > Because of that, all output endpoints on such TCON node will =
point
> > > >> >> > to a
> > > >> >> > encoder which is part of component framework.
> > > >> >> >=20
> > > >> >> > Correct current graph traversing algorithm in such way that it
> > > >> >> > doesn't
> > > >> >> > skip output enpoints with id 0 on TV TCONs.
> > > >> >>=20
> > > >> >> No. Our bindings say that endpoint 0 _is_ channel 0. For TCONs =
that
> > > >> >> don't
> > > >> >> have channel 0, it must be skipped.
> > > >> >=20
> > > >> > I'm not sure where this is stated. I read TCON binding again. Ca=
n you
> > > >> > please point me to it?
> > > >>=20
> > > >> https://elixir.bootlin.com/linux/latest/source/Documentation/devic=
etree
> > > >> /bind ings/display/sunxi/sun4i-drm.txt#L169
> > > >>=20
> > > >> Our TCON driver still expects RGB or LVDS panel / bridges on endpo=
int
> > > >> 0.
> > > >=20
> > > > Yes, but that can only happen on TCON which has channel 0. TV TCONs
> > > > (those
> > > > with channel 1 only) can't have panels or bridges connected to them,
> > > > because they are internally always connected to either HDMI or TV
> > > > encoder or both. Actually, R40 is the only SoC, where same TV TCON =
can
> > > > be connected to TV encoder or HDMI. Others have specialized TV TCON=
s,
> > > > which are connect to only one encoder.
> > > >=20
> > > > IMO TV TCONs are really just stripped down LCD TCONs to support one=
 (or
> > > > max
> > > > two) specific encoder.
> > >=20
> > > I agree. We've seen these first in the H3, and the reverse, TCONs only
> > > with
> > > LCD, on the A23/A33.
> > >=20
> > > >> So I guess this was sort of implied historically. It's no longer t=
rue.
> > > >> This is something we should probably fix.
> > > >=20
> > > > Fixed in what way? You mean update bindings to mention that TCON ou=
tput
> > > > endpoint 0 is reserved for panels or bridges?
> > >=20
> > > Either that, or have the drm driver look at other endpoints. I guess =
we
> > > should ask Maxime if this is already done or not, since the DSI driver
> > > isn't endpoint 0 in the A33 dtsi.
> >=20
> > The DSI driver isn't really a good example for this, since the panel
> > isn't described as part of the OF graph, but DSI binding require that
> > it's a child of the DSI controller node.
>=20
> So should be new behaviour reverted? I mean ignoring endpoint 0 on TV TCO=
Ns.
>=20
> For me, it doesn't make sense to check for panel or bridges on TV TCONs,=
=20
> because they are never exposed on physical pins. They are always connecte=
d to=20
> TVE or HDMI encoder internally.

It doesn't make sense to check for panels, yes, but it also makes sens
to have a child node at the endpoint 0 for TV TCONs.

> > > >> In practice our drivers don't look at it (yet), but rely on the
> > > >> downstream
> > > >> encoder type to determine which channel to use.
> > > >>=20
> > > >> But please add the "allwinner,tcon-channel" property as specified =
in
> > > >> the binding.
> > > >=20
> > > > It's my understanding of TCON binding documentation that property
> > > > "allwinner,tcon-channel" is needed only if TCON supports both chann=
els.
> > > > TV
> > > > TCON clearly supports only channel 1. In that case, there is no dou=
bt to
> > > > which channel output endpoint belongs.
> > > >=20
> > > > If that's not true, dt bindings documentation should be reworded to
> > > > contain
> > > > word "needed" or something similar. Currently, no DT for newer SoC
> > > > contains
> > > > that property (for example, A83T, H3, H5 or even A33).
> >=20
> > Yeah, but that's mainly because we have a single output enabled for
> > each channel on those newer SoCs. When / if we enable the RGB and LVDS
> > output for example, we will have to set this.
>=20
> So just to be clear, before I send follow up series, I have to add=20
> "allwinner,tcon-channel" property to DT, because both TV TCONs can be=20
> connected to either TVE or HDMI (trough TCON TOP)?
>=20
> BTW, since this property is not used at all in the code, why not just sim=
ply=20
> deprecate it and remove it from existing DTs? I noticed this is standard=
=20
> practice for obsolete properties.

It's not deprecated or obsolete, it's future-proofing.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--iad3qlutlabjodpq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAltDI/EACgkQ0rTAlCFN
r3T6+Q//Xrijr00TxUiNtp3VuKBQVfj/+jKCM/XlSi8EBRVS7B7g1ba2GLZgA6aJ
n1kfmxYJRrRQNzi77PZEBigLVKXzCuCURNp0iW9lMtvk6bxshkwQ1XbTQOTZqvu4
qAnp9ikrf2SbG1qKoiHE1uwZyNsJL1Kv5GxyvxF4/drPoLLUHeKv7jWnSdfDc6ak
LbKvx2y6Mo2b8XyBoqO1dRLaabzT9qdPUy1pAEH5u80fL9mBlnlV6wrZueEl8C0R
U1l4d1UXwFtOxNVdpf3NyP2ZZrkQC/0/o6lR2g98J0lw6Z6yw4Q5zW2y7YJS8oKc
RMZ/O4iG8FukaKbpBD4t2Z8Sf1zhYXyIKzM9GR/YxZ5mzAH992d69KaD2ybbwXsp
H8u/evIpLyINtfQZ8iz+AxuYxLU8y88q9YoWfXoohqa+seovEbNF8Jg38m9QCt+7
e03aNeQrG+yf8mc06r+F0pCSTgOVLZ72RLi3ZNxhO6lCAKSgU38X9luVgpBmGMIG
VB53BRjdCdHPLebNQIpy3RBUnuYgKPkA0F9bH2D2gtJImTBZ4PVY/OXalG9iqF4a
t3mVuZFz/CwiLL+v6TaZmUufnLjny9jhjM5aZFOxufyun9zKZb4CnGqBgdfGBruB
oDra7uWm8g9/dyJZ9i21JgijuXiybR/3EzZHjVe8LJj5xvuI03o=
=kknL
-----END PGP SIGNATURE-----

--iad3qlutlabjodpq--

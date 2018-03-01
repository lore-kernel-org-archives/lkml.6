Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964950AbeCAIXv (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 03:23:51 -0500
Received: from mail.bootlin.com ([62.4.15.54]:60987 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934985AbeCAIXu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 03:23:50 -0500
Date: Thu, 1 Mar 2018 09:23:47 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@siol.net>
Cc: wens@csie.org, airlied@linux.ie, robh+dt@kernel.org,
        mark.rutland@arm.com, mturquette@baylibre.com, sboyd@kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v2 00/16] Implement H3/H5 HDMI driver
Message-ID: <20180301082347.go4l7332kjoq5dmm@flea>
References: <20180227222701.9716-1-jernej.skrabec@siol.net>
 <2235934.0TF68fluGz@jernej-laptop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bms6j7mrz2uzijua"
Content-Disposition: inline
In-Reply-To: <2235934.0TF68fluGz@jernej-laptop>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bms6j7mrz2uzijua
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Feb 28, 2018 at 10:23:35PM +0100, Jernej =C5=A0krabec wrote:
> Dne torek, 27. februar 2018 ob 23:26:45 CET je Jernej Skrabec napisal(a):
> > This series implements H3/H5 HDMI driver. It was tested on OrangePi 2 (=
H3),
> > OrangePi Plus2e (H3) and OrangePi PC2 (H5) with many resolutions and it
> > works well. Bug, which prevented correct operation for some resolutions,
> > is also fixed.
> >=20
> > Code is based on linux-next, next-20180226 tag.
>=20
> Today I tried on this series on  next-20180228, but resolution switching=
=20
> doesn't really work. The reason for this is use of clk_set_rate_exclusive=
() in=20
> sun4i_tcon1_mode_set(). If I revert it to ordinary clk_set_rate() it work=
s ok.=20
> I investigated a bit and it seems that clocks stays at first set even if =
tcon=20
> (the owner of exclusive lock) request the new one. Example:
>=20
> [   69.325732] TCON clk wanted: 148500000
> [   69.325740] TCON real clk: 69272728
> [   69.325770] HDMI clk wanted: 148500000
> [   69.325773] HDMI real clk: 138545455
> [   69.325815] HDMI PHY clk wanted: 148500000
> [   69.325819] HDMI PHY real clk: 138545454
>=20
> Is there anything I can do to help debug this?

I don't recall if disable hook is called during a mode set, but if it
is, you can add a call to clk_rate_exclusive_put.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--bms6j7mrz2uzijua
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlqXuJIACgkQ0rTAlCFN
r3RkBRAAmbT74UhBx1jf6GnGS1Bu4/2UWpgjR2yq49jHCAeIOvqS53Y9H5NwiJcX
gxpNhfatCOVOohJudP0tVu0onlGJySfz3LkexmruDgu8dL/2bTPgerBPDLybg03f
jWpJSSmnwUFPPQb8uhEMExiE71O/PL4bYlaxjc/aXK/mq3YhD2txTah8qM0mPLZq
CWICp0mfjVyKAwFhNgdGLaXNeCPeAE+r5FRKCRAwX7fHw6G2iyzbQi3ZqQO5poOl
0DZCcsf6IQZC/Ym7lZ0CLwv2xDWEUhXtvora/mRMo42iYzS3a0ldUZg2/xbHy0gv
6q/GHx2sthrcxTyjdsGarIS/oi0fgOZN6D5dl/JOJUrNn8ZYVIBY/B0cOAESZisf
IeP2SXa0nWlQzTGX+gNrdeudcdhJz1wUzv1qmUuhAirpNxbxrAk+U7pECU8nLRNZ
Qo9GeruHmOIGIc16XHbWz6rdhm1Yu4Y8YR3jweMJlo2wvW71B4gStKXU32OSW6Av
L/6kBCawsOdctuBG6hmf/Rfod9D7iE2F/9BBdPeFUSsMsinub1cUxsEDaobP2VXX
VgK8tHoaq4vfx5l6NbUj7f99j2z8s37hjFH3yhkLvBRnF9VSSZPzXuC6pSTO+WDn
c0WFYqoUKSHrkblavABDSGTVntUquc2yuKKGXLW985owcTDq5u4=
=4IPA
-----END PGP SIGNATURE-----

--bms6j7mrz2uzijua--

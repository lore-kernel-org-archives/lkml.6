Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752190AbeC0ILg (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 04:11:36 -0400
Received: from mail.bootlin.com ([62.4.15.54]:36666 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750970AbeC0ILd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 04:11:33 -0400
Date: Tue, 27 Mar 2018 10:11:31 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Icenowy Zheng <icenowy@aosc.io>
Cc: linux-arm-kernel@lists.infradead.org, Rob Herring <robh@kernel.org>,
        devicetree@vger.kernel.org, jernej.skrabec@siol.net,
        linux-sunxi@googlegroups.com, linux-kernel@vger.kernel.org,
        Chen-Yu Tsai <wens@csie.org>, linux-clk@vger.kernel.org
Subject: Re: [linux-sunxi] Re: [PATCH 2/7] dt-bindings: add binding for the
 Allwinner A64 DE2 bus
Message-ID: <20180327081131.hd652vkhohez2hcc@flea>
References: <20180316175354.21437-1-icenowy@aosc.io>
 <20180320184646.dynqv6qubzabroe4@flea>
 <AAC74653-C6EB-4BE3-BB19-210687C1E158@aosc.io>
 <2866474.lRHIcLtROC@jernej-laptop>
 <9520BDDE-BFE3-4220-B48D-01A00CFA94DE@aosc.io>
 <20180326222258.uxpgj4bk4pg56b7o@rob-hp-laptop>
 <9A6A8961-D45C-4033-962E-83CCE8F01651@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="l7cgdzalfbw6gs6o"
Content-Disposition: inline
In-Reply-To: <9A6A8961-D45C-4033-962E-83CCE8F01651@aosc.io>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--l7cgdzalfbw6gs6o
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 27, 2018 at 07:31:18AM +0800, Icenowy Zheng wrote:
>=20
>=20
> =E4=BA=8E 2018=E5=B9=B43=E6=9C=8827=E6=97=A5 GMT+08:00 =E4=B8=8A=E5=8D=88=
6:22:58, Rob Herring <robh@kernel.org> =E5=86=99=E5=88=B0:
> >On Thu, Mar 22, 2018 at 02:08:43PM +0800, Icenowy Zheng wrote:
> >>=20
> >>=20
> >> =E4=BA=8E 2018=E5=B9=B43=E6=9C=8822=E6=97=A5 GMT+08:00 =E4=B8=8A=E5=8D=
=881:13:42, "Jernej =C5=A0krabec"
> ><jernej.skrabec@siol.net> =E5=86=99=E5=88=B0:
> >> >Hi all,
> >> >
> >> >Dne sreda, 21. marec 2018 ob 03:18:13 CET je Icenowy Zheng
> >napisal(a):
> >> >> =E4=BA=8E 2018=E5=B9=B43=E6=9C=8821=E6=97=A5 GMT+08:00 =E4=B8=8A=E5=
=8D=882:46:46, Maxime Ripard
> >> ><maxime.ripard@bootlin.com>=20
> >> >=E5=86=99=E5=88=B0:
> >> >> >On Sat, Mar 17, 2018 at 01:53:49AM +0800, Icenowy Zheng wrote:
> >> >> >> All the sub-blocks of Allwinner A64 DE2 needs the SRAM C on A64
> >> >SoC
> >> >> >
> >> >> >to
> >> >> >
> >> >> >> be claimed, otherwise the whole DE2 space is inaccessible.
> >> >> >>=20
> >> >> >> Add a device tree binding of the DE2 part as a sub-bus.
> >> >> >
> >> >> >Where did you get the info that it was a bus?
> >> >>=20
> >> >> There's no direct evidence, just some guess.
> >> >>=20
> >> >> The DE2 is a whole part that is just allocated a memory
> >> >> space at the user manual, and the SRAM controls the
> >> >> access to all modules in the DE2.
> >> >>=20
> >> >> So it might be a bus.
> >> >>=20
> >> >> Implement it as a bus is a clear representation on A64.
> >> >
> >> >Since there is already syscon for same mmio region, we migh as well
> >use
> >> >it=20
> >> >when loading ccu-sun8i-de2 driver on A64.
> >> >
> >> >Other options, like SRAM driver or bus driver, might better
> >represent
> >> >HW, but=20
> >>=20
> >> I think the device tree should properly represent the HW,
> >> it's a basic requirment.
> >>=20
> >> >then we would have two DT nodes covering same mmio region, which I
> >> >think is=20
> >> >not really acceptable.
> >>=20
> >> It's acceptable, and DE2 is not the only user of SRAM controller so
> >far.
> >
> >No, it's not acceptable. Don't create overlapping mmio regions in DT.
>=20
> Then should the SRAM controller driver be configured to take the syscon?

We could have a single DT node that would export a syscon yes, just
like you did for the R40 ethernet case.

I'm not sure the SRAM controller itself needs to take the syscon, it
just can export its own.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--l7cgdzalfbw6gs6o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlq5/LIACgkQ0rTAlCFN
r3Rqsg//bcROXUQWqCJ3N0cm6teljACF1FqkqeO/94ZIlcYMMP30HYKZ+jFU8j8n
/mp/Mm6pE1X5YT0Jkf0WXeFP0ns9xlF0aNTITEVZ45w682EFqUgOIrxB0vsJTndv
dYmPpIO9Rb9I5sA04umttMTh1undUL8g90Gy3uDBktcI12C81Bge7ebgbdfOM/Zt
S08zg/Z5JD5OrF7ojggNKnJUg+hSDTAB/zB7URAIj8fuNlP5TMdEkZRV1LdHrZtd
2Bz2uwprH8CdoeG/5Jm33cwtYximXvGtFPRkz2f2EAWICYPVTJuQA7QpZ8T8j0hB
Kwkc+MruItlgPk/3CIGLOjYqR1181OU4N1FpwOhfGvXtNv+UhmReUwbhqJGCopBy
leO8XTUq3G1w/X3xgLSTPCUe47akV2EAkAGMWBoOf4bopVkHE8Th4OV0mpo3ntjl
KZJvWjGpPv3O61m3Rqw5ZEFxtO7t9xPiR/Ix4iif8lrZaWRMqVbuBQknwS7+oJbf
ilm2+MJkZfN8rZ6RsjNYgpQVkJ5cScdf7n3iJ1ziGQX592OZfjzQORMMusvrJBhX
Rusk68z8Ge8ZKrgZ92pB5k/PYFniUlSjBjzHMXUjKnJKDY5BR94c7k7n3G8qJS4p
Zgl+H4c42Q2TIX4esUklJNcBCkzb1gXsVv5YGGVePlksP6FoiEg=
=yP6i
-----END PGP SIGNATURE-----

--l7cgdzalfbw6gs6o--

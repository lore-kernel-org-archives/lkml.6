Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032255AbeEXR53 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 13:57:29 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40100 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030352AbeEXR5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 13:57:25 -0400
Date: Thu, 24 May 2018 18:57:21 +0100
From: Mark Brown <broonie@kernel.org>
To: "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Cc: "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "mazziesaccount@gmail.com" <mazziesaccount@gmail.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Mutanen, Mikko" <Mikko.Mutanen@fi.rohmeurope.com>,
        "Haikola, Heikki" <Heikki.Haikola@fi.rohmeurope.com>
Subject: Re: [PATCH 4/9] regulator: bd71837: Devicetree bindings for BD71837
 regulators
Message-ID: <20180524175721.GB4828@sirena.org.uk>
References: <20180524055752.GE4249@localhost.localdomain>
 <20180524140118.GS4828@sirena.org.uk>
 <042F8805D2046347BB8420BEAE397A4016C06B47@WILL-MAIL002.REu.RohmEu.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WxezjuMNsgvRf6mf"
Content-Disposition: inline
In-Reply-To: <042F8805D2046347BB8420BEAE397A4016C06B47@WILL-MAIL002.REu.RohmEu.com>
X-Cookie: Excellent day to have a rotten day.
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WxezjuMNsgvRf6mf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 24, 2018 at 05:30:57PM +0000, Vaittinen, Matti wrote:
> > > On Thu, May 24, 2018 at 08:57:52AM +0300, Matti Vaittinen wrote:
> >
> > > +Required properties:
> > > + - compatible: should be "rohm,bd71837-pmic".
> > > + - regulator-name: should be "buck1", ..., "buck8" and "ldo1", ..., =
"ldo7"
> >
> > The MFD is for a single device, there should be no need for compatibles
> > on subfunctions.
>=20
> I will check this. I must admit I am not sure what is the de-facto mechan=
ism
> for assigning the correct device-tree nodes to sub devices if compatibles
> are not used? I think I saw device-tree node name being used for regulato=
rs

You can look at the regulators node within the parent device, you know
that in Linux the parent device will be the MFD.  Having a compatible
string within the device makes no difference here.  There's quite a few
in tree examples of this.

> Also, another thing I was wondering is how supply regulators should be
> handled? In this case the LDO5 is supplied by BUCK6 and LDO6 by
> BUCK7.=20

> From generic regulator bindings
> /Documentation/devicetree/bindings/regulator/regulator.txt
> I found statement:

> > - <name>-supply: phandle to the parent supply/regulator node

None of that stuff uses compatible strings, just handle it as covered in
the bindings.

--WxezjuMNsgvRf6mf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsG/QAACgkQJNaLcl1U
h9AHrwf+I5QHGPl/Ix4blMQJui270VI4vajg2PzTVHSlND62fWGf2+K6hzxJuRIX
0k4++LcNMX6Nxdww+O/TnXrnQKrHq/wtnihAnnXv3oOttOqMVIkFeV4k1cfl2SGV
isvpM+6HA8ac0SqXMZLxyo42ETc04gEcSk9O5UZ+D09d9zVKUfh615qcM/oR6NTm
ZFeDvuGad5rHqGxHgTJI/kNpCU1/x5ScJKzIDOm6c3QoWiDloZrYMsuXhz5LvEIW
rUAB97nrVAubeC0Zgb7W2BuMRzI4/eU8iXeLbIyExC+JLisBjXH1GULAg3WQ0g8R
l/7n1VK64rUqO/0EP2zMzC/0/chzmQ==
=gwWb
-----END PGP SIGNATURE-----

--WxezjuMNsgvRf6mf--

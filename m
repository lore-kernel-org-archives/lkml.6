Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967285AbeCAKDp (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 05:03:45 -0500
Received: from mail.bootlin.com ([62.4.15.54]:36721 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967069AbeCAKDm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 05:03:42 -0500
Date: Thu, 1 Mar 2018 11:03:28 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai <wens@csie.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: Add a binding for the sunxi message box
Message-ID: <20180301100328.3w36zdadeaqums44@flea>
References: <20180228022714.30068-1-samuel@sholland.org>
 <20180228022714.30068-2-samuel@sholland.org>
 <20180228082843.fga47gfrv2g5kmiz@flea>
 <d124c54f-7ac1-2305-0e69-94bc33c6eafe@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="g67y5xrgkxtfee53"
Content-Disposition: inline
In-Reply-To: <d124c54f-7ac1-2305-0e69-94bc33c6eafe@arm.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--g67y5xrgkxtfee53
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2018 at 05:17:03PM +0000, Andre Przywara wrote:
> Hi Samuel,
>=20
> thank you very much for writing and posting this!
>=20
> On 28/02/18 08:28, Maxime Ripard wrote:
> > Hi,
> >=20
> > On Tue, Feb 27, 2018 at 08:27:12PM -0600, Samuel Holland wrote:
> >> This mailbox hardware is present in several Allwinner sun8i and sun50i
> >> SoCs. Add a device tree binding for it.
> >>
> >> Signed-off-by: Samuel Holland <samuel@sholland.org>
> >> ---
> >>  .../devicetree/bindings/mailbox/sunxi-msgbox.txt   | 40 +++++++++++++=
+++++++++
> >>  1 file changed, 40 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/mailbox/sunxi-ms=
gbox.txt
> >>
> >> diff --git a/Documentation/devicetree/bindings/mailbox/sunxi-msgbox.tx=
t b/Documentation/devicetree/bindings/mailbox/sunxi-msgbox.txt
> >> new file mode 100644
> >> index 000000000000..3b3ed7f870a0
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/mailbox/sunxi-msgbox.txt
> >> @@ -0,0 +1,40 @@
> >> +Allwinner sunxi Message Box
> >> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> >> +
> >> +The hardware message box on sunxi SoCs is a two-user mailbox controll=
er
> >> +containing 8 unidirectional FIFOs bonded into 4 bidirectional mailbox=
 channels.
> >> +An interrupt is raised for received messages, but software must poll =
to know
> >> +when a transmitted message has been acknowledged by the remote user.
> >> +
> >> +Refer to ./mailbox.txt for generic information about mailbox device-t=
ree
> >> +bindings.
> >> +
> >> +Mailbox Device Node:
> >> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> +
> >> +Required properties:
> >> +--------------------
> >> +- compatible:		Must be "allwinner,sunxi-msgbox".
> >=20
> > The IP change quite often in the Allwinner SoCs, so it would be better
> > to use a more specific compatible there. IIRC that IP was introduced
> > with the A31, so what about sun6i-a31-msgbox?
>=20
> As much as I like generic compatible strings ;-) I agree with Maxime
> here. Can you change this to something like:
>=20
> - compatible: Must contain at least "allwinner,sun6i-a31-msgbox".
>               Should also contain one of the more specific strings, when
> 	      used on other SoCs which are compatible:
>=20
> And then list the strings for the SoCs which we know of, ideally have
> been tested also?
>=20
> The rationale behind this is that by listing those strings here we
> reserve them, to cover for future extensions or bugs found in those
> SoCs. So even though the driver would only match on
> "allwinner,sun6i-a31-msgbox" right now, we can extend it in the future.
> The actual DTs would always use:
> 	compatible =3D "allwinner,sun50i-a64-msgbox",
> 		     "allwinner,sun6i-a31-msgbox";
> Right now the first string would not match anything, but the second
> would. The driver would use the generic driver functionality.
> Should we find a bug or speciality in the A64, we can add the a64 string
> to the driver and connect it to the workaround, and the actual DTs would
> not need to be touched.
> Does this make sense?

It does to me :)

> >> +- reg:			Contains the mailbox register address range (base
> >> +			address and length).
> >> +- clocks:		phandle for the clock controller and specifier.
> >> +- clock-names:		Must be "bus".
>=20
> Maxime:
> Out of curiosity: There is only one clock, and just to gate the APB
> clock to the MMIO registers. So do we need clock-names?

We don't.

> Or is this good practise these days to allow extending the clocks
> later in a compatible manner? (Thinking of the sunxi pinctrl here.)

This is always doable, since if you ever have multiple clocks, you
will have clock-names, so any newer clock will have a name, and the
first one will usually be the first in the index. This is not as nice
as having it from the start, but it's definitely something we can have
in the binding as well.

> And is "bus" the correct naming? I see "apb" being used as well, is this
> legacy?

So we were using apb/ahb at the beginning, but we've had some IPs
moving from one generation to the other from the APB to AHB bus iirc
(or the other way around, this was quite some time ago).

Having some more generic name will also help to have genpd handle the
clocks and resets lines, which is something I've wanted to have for
quite some time, but is very low on my TODO-list...

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--g67y5xrgkxtfee53
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlqXz+8ACgkQ0rTAlCFN
r3QerBAAjzBFsAbOfcx7I/M5M1dca1mEfdVI27Udi0PDTlSGN3leyT7vQQP6HRbz
W5OjRuTI4t5JjqdxvE5GC39WusQbDDG6bDtLyGd1CwXUd9pfffOk1ij+qxkFoWNT
a0+J+ZryyuwW0N5z571pMtMbRzBJ4i8E1HgPmHxq1kMu8k4P/x3teHU0r3e3Z4dC
hasrtlUtBnziHCYrYNnWdrefH1ydn4w/Ag8gb8HV4xKW4BBbd28zKa2JGDskf55O
ud5IKJsLzlW+A79kSGKThsib8KWlu4iISnK5Nyr7nrVnP7X3Tg5+9Pc7vlLmNkl2
hZMc2VoYliapOTEUI5QZNpecKhwEgbcoC30cbGg+ZVDtkkNghfWwYIHMuwdJbnr9
zJPYIIaGbF8gWfipfyIDMHAy8wzxk3cDMfHTEj4H9mlR1a9l+IPNJPRLvtQLYoaj
nmqBlwEB5+lvn0RHSS6NEcyWGuMltNydWrRmhUI8Mj15abX31Hel2URqh+ZSVDNG
XjjJSaI1TQE34ZcB9GV1KsDh3OdSe59YYP8brNoaGsOA6enUC8qNiHkY1+oXbsgb
W/SRtxePqGpYoJjfXfxPweS5+C5aPDjpzTkRe2QJ8BTD57Sl92qlgDa8lrAxLE/3
pBPEyDnaRTbyeS/q5BHh0Q4RzSiB4rNp7Nk1Xuy+PKcK2G9zxe8=
=XI5u
-----END PGP SIGNATURE-----

--g67y5xrgkxtfee53--

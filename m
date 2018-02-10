Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752294AbeBJUMQ (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Feb 2018 15:12:16 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:46857 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751182AbeBJUMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Feb 2018 15:12:14 -0500
X-Google-Smtp-Source: AH8x2265s+wiQonyr0ocxQsqjHeBX5hjlgdNz8UIuBrP2gWUFhWp714Xsdh0du3/wTXc9176xPZGnw==
Date: Sat, 10 Feb 2018 21:12:07 +0100
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Sean Wang <sean.wang@mediatek.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Barry Song <baohua@kernel.org>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>, Linus Walleij <linus.walleij@linaro.org>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 5/7] watchdog: mtk: allow setting timeout in devicetree
Message-ID: <20180210201207.GC744@gmail.com>
References: <20180210091911.3644-1-marcus.folkesson@gmail.com>
 <20180210091911.3644-5-marcus.folkesson@gmail.com>
 <1518261002.9025.36.camel@mtkswgap22>
 <20180210124328.GB744@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="w7PDEPdKQumQfZlR"
Content-Disposition: inline
In-Reply-To: <20180210124328.GB744@gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--w7PDEPdKQumQfZlR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Sean,

On Sat, Feb 10, 2018 at 01:43:28PM +0100, Marcus Folkesson wrote:
> Hello Sean,
>=20
> On Sat, Feb 10, 2018 at 07:10:02PM +0800, Sean Wang wrote:
> >=20
> > Hi, Marcus
> >=20
> > The changes you made for dt-bindings and driver should be put into
> > separate patches.
>=20
> I actually thought about it but chose to have it in the same patch becaus=
e I
> did not see any direct advantage to separating them.
>=20
> But I can do that.
> I will come up with a v3 with this change if no one thinks differently.
>=20

When looking at the git log, I'm not that convinced it should be
separate patches.

For example, I found a4f741e3e157c3a5c8aea5f2ea62b692fbf17338 that is
doing the exact same thing as this patch.

There is plenty of patches that mixes the code change and dt bindings
updates.
Could it not be useful to overview both the implementation and
dt-mapping change in one view?

If you or anyone else still think it should be separated, please let me kno=
w and I will
come up with a v3.


> >=20
> > And the property timeout-sec seems to be generic enough to all devices,
> > so why not add a common document to describe it and allow those devices
> > to refer to, like other dt-bindings for other kinds of devices usually
> > did.
>=20
> It should be, but it requires that the driver is using
> watchdog_init_timeout() to set timeout, most of the drivers does not.
> Most drivers does not even use the watchdog API but register itself as
> misc devices.
>=20
> When we have all wdt drivers using the watchdog API, we should probably
> move the dt-binding to a common document.
>=20
> >=20
> > 	Sean
> >=20
>=20
> Thanks,
>=20
> Best regards
> Marcus Folkesson
>=20
> > On Sat, 2018-02-10 at 10:19 +0100, Marcus Folkesson wrote:
> > > watchdog_init_timeout() will allways pick timeout_param since it
> > > defaults to a valid timeout.
> > >=20
> > > By following best practice described in
> > > Documentation/watchdog/watchdog-kernel-api.txt, it also
> > > let us to set timout-sec property in devicetree.
> > >=20
> > > Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> > > Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> > > ---
> > >  Documentation/devicetree/bindings/watchdog/mtk-wdt.txt | 4 ++++
> > >  drivers/watchdog/mtk_wdt.c                             | 2 +-
> > >  2 files changed, 5 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt b=
/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
> > > index 5b38a30e608c..859dee167b91 100644
> > > --- a/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
> > > +++ b/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
> > > @@ -11,9 +11,13 @@ Required properties:
> > > =20
> > >  - reg : Specifies base physical address and size of the registers.
> > > =20
> > > +Optional properties:
> > > +- timeout-sec: contains the watchdog timeout in seconds.
> > > +
> > >  Example:
> > > =20
> > >  wdt: watchdog@10000000 {
> > >  	compatible =3D "mediatek,mt6589-wdt";
> > >  	reg =3D <0x10000000 0x18>;
> > > +	timeout-sec =3D <10>;
> > >  };
> > > diff --git a/drivers/watchdog/mtk_wdt.c b/drivers/watchdog/mtk_wdt.c
> > > index 7ed417a765c7..fcdc10ec28a3 100644
> > > --- a/drivers/watchdog/mtk_wdt.c
> > > +++ b/drivers/watchdog/mtk_wdt.c
> > > @@ -57,7 +57,7 @@
> > >  #define DRV_VERSION		"1.0"
> > > =20
> > >  static bool nowayout =3D WATCHDOG_NOWAYOUT;
> > > -static unsigned int timeout =3D WDT_MAX_TIMEOUT;
> > > +static unsigned int timeout;
> > > =20
> > >  struct mtk_wdt_dev {
> > >  	struct watchdog_device wdt_dev;
> >=20
> >=20

Best regards
Marcus Folkesson



--w7PDEPdKQumQfZlR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAlp/UhIACgkQiIBOb1ld
UjLTSg//Y1Wdm+EzphVBNcQEOVuer5HfbnXLStbtYpcKsmz4gwjdx7vMhdmebUZg
//6LIc3NBl/EowXi1zqR7/Eo57Xxd1iw5WxoRDHOqGeZtZ6BqdD3Rte240QhKnZX
gFBNfeUgSjnCrzbdAOrKz2g6M4W9Bqb6C5XwTrO3KXp7eUPxffIQYCSkwt2FKlKy
5MMEonSISxDhgUXvB7p29BnZqCtAlrnwo/wgkug7kmON4059RaFBoRmAiJxO0GuE
Z9ksVOFiOaUlM0zZpoCGoQAseFFv169s7JkVC9nphx3qu53i6/NqadyYdKqS6Dpz
L8gCOZKSt93rILxYANfaUnec07oxQNOxrOLF8BfKaJJiKlkI+k/w5c3DijvEngbj
8KxtttCgVMxrwc7IQg3Mw5zlG7Z2go08JbSBrxyHWt0DE2k2VpBLDPaXFKPIMufg
AyVsKPMfzms53w9sRtm8UMALc9fv7C4UIOKL9HHWIiicj6AHeUYU/0rpzyIJVPWU
whIoLZWasSkke3vxVQkR61MX7/6S07L52sKGQAGI6I65oSeAsfT4lAA0PyydU5y6
Iuoqc2MvGw4jm8n0xVsrwBC/NVHweMejksZYhOgpPlRzY05qxce8KlVPX/s58w7E
CxtbaDQNUTFCYa2B63fPqJqWR3jUR6y03caL3laEwEX4ZOvGd08=
=6wc6
-----END PGP SIGNATURE-----

--w7PDEPdKQumQfZlR--

Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SwcyN/sf"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AE1B960764
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751886AbeFFLHl (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 07:07:41 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:53622 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751689AbeFFLHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 07:07:39 -0400
X-Google-Smtp-Source: ADUXVKJg8X7oSnGf/HHh9i+uWpB2UJVVD5rrMBAxms1ysBk+zO7atGuYEbVrIWskevg4pe8KJzK47w==
Date: Wed, 6 Jun 2018 13:07:35 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: Dmitry Osipenko <digetx@gmail.com>, Stefan Agner <stefan@agner.ch>,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        marek.vasut@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        benjamin.lindqvist@endian.se, pgaikwad@nvidia.com, dev@lynxeye.de,
        mirza.krak@gmail.com, richard@nod.at, pdeschrijver@nvidia.com,
        linux-kernel@vger.kernel.org, krzk@kernel.org,
        jonathanh@nvidia.com, devicetree@vger.kernel.org,
        linux-mtd@lists.infradead.org, marcel@ziswiler.com,
        miquel.raynal@bootlin.com, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v3 3/6] mtd: rawnand: tegra: add devicetree binding
Message-ID: <20180606110735.GM11810@ulmo>
References: <20180531221637.6017-1-stefan@agner.ch>
 <20180531221637.6017-4-stefan@agner.ch>
 <20180601093025.2817ff30@bbrezillon>
 <faa40dac-ab2a-2d43-3a43-2d46cebcd539@gmail.com>
 <20180606103903.GJ11810@ulmo>
 <20180606124540.46bfa00b@bbrezillon>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tDYGg60iReQ7u8wj"
Content-Disposition: inline
In-Reply-To: <20180606124540.46bfa00b@bbrezillon>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tDYGg60iReQ7u8wj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 06, 2018 at 12:45:40PM +0200, Boris Brezillon wrote:
> Hi Thierry,
>=20
> On Wed, 6 Jun 2018 12:39:03 +0200
> Thierry Reding <thierry.reding@gmail.com> wrote:
>=20
> > On Tue, Jun 05, 2018 at 11:19:14PM +0300, Dmitry Osipenko wrote:
> > > On 01.06.2018 10:30, Boris Brezillon wrote: =20
> > > > On Fri,  1 Jun 2018 00:16:34 +0200
> > > > Stefan Agner <stefan@agner.ch> wrote:
> > > >  =20
> > > >> This adds the devicetree binding for the Tegra 2 NAND flash
> > > >> controller.
> > > >>
> > > >> Signed-off-by: Lucas Stach <dev@lynxeye.de>
> > > >> Signed-off-by: Stefan Agner <stefan@agner.ch>
> > > >> ---
> > > >>  .../bindings/mtd/nvidia-tegra20-nand.txt      | 64 ++++++++++++++=
+++++
> > > >>  1 file changed, 64 insertions(+)
> > > >>  create mode 100644 Documentation/devicetree/bindings/mtd/nvidia-t=
egra20-nand.txt
> > > >>
> > > >> diff --git a/Documentation/devicetree/bindings/mtd/nvidia-tegra20-=
nand.txt b/Documentation/devicetree/bindings/mtd/nvidia-tegra20-nand.txt
> > > >> new file mode 100644
> > > >> index 000000000000..5cd984ef046b
> > > >> --- /dev/null
> > > >> +++ b/Documentation/devicetree/bindings/mtd/nvidia-tegra20-nand.txt
> > > >> @@ -0,0 +1,64 @@
> > > >> +NVIDIA Tegra NAND Flash controller
> > > >> +
> > > >> +Required properties:
> > > >> +- compatible: Must be one of:
> > > >> +  - "nvidia,tegra20-nand" =20
> > > >=20
> > > > As discussed previously, I prefer "nvidia,tegra20-nand-controller" =
or
> > > > "nvidia,tegra20-nfc".
> > > >  =20
> > > >> +- reg: MMIO address range
> > > >> +- interrupts: interrupt output of the NFC controller
> > > >> +- clocks: Must contain an entry for each entry in clock-names.
> > > >> +  See ../clocks/clock-bindings.txt for details.
> > > >> +- clock-names: Must include the following entries:
> > > >> +  - nand
> > > >> +- resets: Must contain an entry for each entry in reset-names.
> > > >> +  See ../reset/reset.txt for details.
> > > >> +- reset-names: Must include the following entries:
> > > >> +  - nand
> > > >> +
> > > >> +Optional children nodes:
> > > >> +Individual NAND chips are children of the NAND controller node. C=
urrently
> > > >> +only one NAND chip supported.
> > > >> +
> > > >> +Required children node properties:
> > > >> +- reg: An integer ranging from 1 to 6 representing the CS line to=
 use.
> > > >> +
> > > >> +Optional children node properties:
> > > >> +- nand-ecc-mode: String, operation mode of the NAND ecc mode. Cur=
rently only
> > > >> +		 "hw" is supported.
> > > >> +- nand-ecc-algo: string, algorithm of NAND ECC.
> > > >> +		 Supported values with "hw" ECC mode are: "rs", "bch".
> > > >> +- nand-bus-width : See nand.txt
> > > >> +- nand-on-flash-bbt: See nand.txt
> > > >> +- nand-ecc-strength: integer representing the number of bits to c=
orrect
> > > >> +		     per ECC step (always 512). Supported strength using HW ECC
> > > >> +		     modes are:
> > > >> +		     - RS: 4, 6, 8
> > > >> +		     - BCH: 4, 8, 14, 16
> > > >> +- nand-ecc-maximize: See nand.txt
> > > >> +- nand-is-boot-medium: Makes sure only ECC strengths supported by=
 the boot ROM
> > > >> +		       are choosen.
> > > >> +- wp-gpios: GPIO specifier for the write protect pin.
> > > >> +
> > > >> +Optional child node of NAND chip nodes:
> > > >> +Partitions: see partition.txt
> > > >> +
> > > >> +  Example:
> > > >> +	nand@70008000 { =20
> > > >=20
> > > > 	nand-controller@70008000 {
> > > >  =20
> > > >> +		compatible =3D "nvidia,tegra20-nand"; =20
> > > >=20
> > > > 		compatible =3D "nvidia,tegra20-nand-controller";
> > > >=20
> > > > or
> > > >=20
> > > > 		compatible =3D "nvidia,tegra20-nfc";
> > > >  =20
> > >=20
> > > Maybe it's just me, but when I'm reading "nfc", my first association =
is the
> > > "Near Field Communication". Probably an explicit
> > > "nvidia,tegra20-nand-controller" variant is more preferable. =20
>=20
> I also prefer nvidia,tegra20-nand-controller.
>=20
> >=20
> > We don't really use a -controller suffix for any of the other
> > controllers because it is kind of implied. "nfc" is also not something
> > that is ever referred to in the technical documentation.
> >=20
> > "nvidia,tegra20-nand" would be most consistent with all the rest of
> > Tegra (c.f. "nvidia,tegra*-ahci", "nvidia,tegra*-pci",
> > "nvidia,tegra*-hda", "nvidia,tegra*-gmi", ...).
>=20
> People get confused about what this node represents when you just have
> "nvidia,tegra20-nand", and then you start seeing NAND related props or
> partition nodes being defined under the NAND controller node.
> I really prefer to have the "-controller" prefix here to avoid such
> confusions.

Hmm... odd. I mean, the node is already called nand-controller@...,
which makes it pretty obvious to me that this represents a controller
rather than a NAND chip. Also, the placement of this in the DT hierarchy
should make it pretty obvious that it is a controller since you can't
just put a NAND chip directly on the CPU's address bus.

In addition I think the nvidia,tegra* part already pretty strongly
suggests that this is part of an SoC, so further implies "controller".

Thierry

--tDYGg60iReQ7u8wj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlsXwHcACgkQ3SOs138+
s6FQgRAAh5km0NFrhz9HfM9KO8p6TboIk0ytTifOYnO0szX8nB9auX5pI1ggN6aO
vrMHkOHFAMLB34QkboVVVuINJun7FJpnz77Rm4/XV8tHvjn9s8r2gtVWZvnanBCc
ykAZ4gjn2mxa4UvYD7kIIQimS59t2j6Ic+jV5ho4gC/6RK04Q415SbRjU0MaAoeG
mUwzO9fMHhR0afQGtO8JrqeGKm67Qu40cvVgcpdUFAFEO50JWwG4YRZYBi2JweE4
N7YNR013a7P0Yet20f87hbuMLx958QNVRTneNUGsfDNLB0SdrBzPUqZk5e53y+Ot
+tm/tiTQttIh3SjfcHudRX9y42IdAPRae91GqfJLKbfWstTCOzGai91V9lDStZpY
7ZAx7IjbQ96L0XqXu3ySW7gjBhmzNl69lGGfgqpeairYoiI9XdHEeW4Z4JlIWQBE
wCb+pjWBgxGQmAaraaEUPRg54sVcLB132vlHfSM8Sac6mTF6ofUiC1Awuphikbdg
6g5SzX6Yi9TcQZdpQPwnio+lYlOY1RDIWkbz4kPhwCFxO6xLuM91/l8ws664Dtg6
+CdozIwWJQVL4mb2vkFaRCMBcx8IltkTMDgK+sPZ0TTNHyMi6ap2Ssd2NP8XDgsb
HM1nAcynVy5r/1zsWtI+vD3QFYxZL7VRrGFxg3D1vFbsls7asvs=
=Nfsx
-----END PGP SIGNATURE-----

--tDYGg60iReQ7u8wj--

Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W773ODwd"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C9375607B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932651AbeFFKjJ (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 06:39:09 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:41314 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932522AbeFFKjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 06:39:07 -0400
X-Google-Smtp-Source: ADUXVKJXVMOW6JUbazeIncFZ5+ObG/jYx2Uxqc5kdgJ0kousXptHxNTLbg1CeSNR4yKJ91PviGeFeg==
Date: Wed, 6 Jun 2018 12:39:03 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Cc: Boris Brezillon <boris.brezillon@bootlin.com>,
        Stefan Agner <stefan@agner.ch>, dwmw2@infradead.org,
        computersforpeace@gmail.com, marek.vasut@gmail.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        benjamin.lindqvist@endian.se, pgaikwad@nvidia.com, dev@lynxeye.de,
        mirza.krak@gmail.com, richard@nod.at, pdeschrijver@nvidia.com,
        linux-kernel@vger.kernel.org, krzk@kernel.org,
        jonathanh@nvidia.com, devicetree@vger.kernel.org,
        linux-mtd@lists.infradead.org, marcel@ziswiler.com,
        miquel.raynal@bootlin.com, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v3 3/6] mtd: rawnand: tegra: add devicetree binding
Message-ID: <20180606103903.GJ11810@ulmo>
References: <20180531221637.6017-1-stefan@agner.ch>
 <20180531221637.6017-4-stefan@agner.ch>
 <20180601093025.2817ff30@bbrezillon>
 <faa40dac-ab2a-2d43-3a43-2d46cebcd539@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="C7PTD44AewjTsiSV"
Content-Disposition: inline
In-Reply-To: <faa40dac-ab2a-2d43-3a43-2d46cebcd539@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--C7PTD44AewjTsiSV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 05, 2018 at 11:19:14PM +0300, Dmitry Osipenko wrote:
> On 01.06.2018 10:30, Boris Brezillon wrote:
> > On Fri,  1 Jun 2018 00:16:34 +0200
> > Stefan Agner <stefan@agner.ch> wrote:
> >=20
> >> This adds the devicetree binding for the Tegra 2 NAND flash
> >> controller.
> >>
> >> Signed-off-by: Lucas Stach <dev@lynxeye.de>
> >> Signed-off-by: Stefan Agner <stefan@agner.ch>
> >> ---
> >>  .../bindings/mtd/nvidia-tegra20-nand.txt      | 64 +++++++++++++++++++
> >>  1 file changed, 64 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/mtd/nvidia-tegra=
20-nand.txt
> >>
> >> diff --git a/Documentation/devicetree/bindings/mtd/nvidia-tegra20-nand=
=2Etxt b/Documentation/devicetree/bindings/mtd/nvidia-tegra20-nand.txt
> >> new file mode 100644
> >> index 000000000000..5cd984ef046b
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/mtd/nvidia-tegra20-nand.txt
> >> @@ -0,0 +1,64 @@
> >> +NVIDIA Tegra NAND Flash controller
> >> +
> >> +Required properties:
> >> +- compatible: Must be one of:
> >> +  - "nvidia,tegra20-nand"
> >=20
> > As discussed previously, I prefer "nvidia,tegra20-nand-controller" or
> > "nvidia,tegra20-nfc".
> >=20
> >> +- reg: MMIO address range
> >> +- interrupts: interrupt output of the NFC controller
> >> +- clocks: Must contain an entry for each entry in clock-names.
> >> +  See ../clocks/clock-bindings.txt for details.
> >> +- clock-names: Must include the following entries:
> >> +  - nand
> >> +- resets: Must contain an entry for each entry in reset-names.
> >> +  See ../reset/reset.txt for details.
> >> +- reset-names: Must include the following entries:
> >> +  - nand
> >> +
> >> +Optional children nodes:
> >> +Individual NAND chips are children of the NAND controller node. Curre=
ntly
> >> +only one NAND chip supported.
> >> +
> >> +Required children node properties:
> >> +- reg: An integer ranging from 1 to 6 representing the CS line to use.
> >> +
> >> +Optional children node properties:
> >> +- nand-ecc-mode: String, operation mode of the NAND ecc mode. Current=
ly only
> >> +		 "hw" is supported.
> >> +- nand-ecc-algo: string, algorithm of NAND ECC.
> >> +		 Supported values with "hw" ECC mode are: "rs", "bch".
> >> +- nand-bus-width : See nand.txt
> >> +- nand-on-flash-bbt: See nand.txt
> >> +- nand-ecc-strength: integer representing the number of bits to corre=
ct
> >> +		     per ECC step (always 512). Supported strength using HW ECC
> >> +		     modes are:
> >> +		     - RS: 4, 6, 8
> >> +		     - BCH: 4, 8, 14, 16
> >> +- nand-ecc-maximize: See nand.txt
> >> +- nand-is-boot-medium: Makes sure only ECC strengths supported by the=
 boot ROM
> >> +		       are choosen.
> >> +- wp-gpios: GPIO specifier for the write protect pin.
> >> +
> >> +Optional child node of NAND chip nodes:
> >> +Partitions: see partition.txt
> >> +
> >> +  Example:
> >> +	nand@70008000 {
> >=20
> > 	nand-controller@70008000 {
> >=20
> >> +		compatible =3D "nvidia,tegra20-nand";
> >=20
> > 		compatible =3D "nvidia,tegra20-nand-controller";
> >=20
> > or
> >=20
> > 		compatible =3D "nvidia,tegra20-nfc";
> >=20
>=20
> Maybe it's just me, but when I'm reading "nfc", my first association is t=
he
> "Near Field Communication". Probably an explicit
> "nvidia,tegra20-nand-controller" variant is more preferable.

We don't really use a -controller suffix for any of the other
controllers because it is kind of implied. "nfc" is also not something
that is ever referred to in the technical documentation.

"nvidia,tegra20-nand" would be most consistent with all the rest of
Tegra (c.f. "nvidia,tegra*-ahci", "nvidia,tegra*-pci",
"nvidia,tegra*-hda", "nvidia,tegra*-gmi", ...).

Thierry

--C7PTD44AewjTsiSV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlsXucMACgkQ3SOs138+
s6GOsQ/+P8gS5IrroBpzAwxFRbZlyPPj/3aDsFLrE/fNJTmO1q6w2rS+9WdTvoju
TdVzh0ljfD/HLvav4uMBKcnDwhy4izEdL7qDE/lnU6zelFoRRayzGOKg3wrFK8LT
2+aGutUIHrGZpLNyINDpeeRd1G2KF7nVvAb2LkBlqpgpB3Eqt6Y5LXQRsC2WzIN6
ZYH/1QFDMtX6xj5rfvBWG+fcV86WJw032YUKaW3sWIrE3Vio9/RQ9m++BqXcCPdC
f1m4EVSbfBMwVJRvWDngRL8pO+MdkyawNCeoTzjf/cb54GKYTdY4ENWUBf0YKNKb
tZpe70dUBYnRB8VJIGZEoTgRvW8qqbRxk04AltmhDIKqIld6T8Zfst47/DHq44H+
JgmBnnEKC2HYq0L0KlzRmQ7Az/4AZtmgQhLYdL3/8B5KuJrPQQE5M6GEpSp/KBQW
LhGMMk2YDVriI4Yb3w+yt5E9ftuTQ1vrtXkrMazTkfImKQIe+qz+W4eJaX45KefV
WhNRu68OvcE+Oa0VO8k7PKUSe0B+79yzsHEqgsyQwH4EmEwAtf7BOC0aOTrJBRMR
dTXCvmkjK8bxSk36YT/IynfcqqJSyGlDEUqKbazxVqTWDogO7fO/zghebY9Lb+Fv
sF7o97IyifBg5+Ow7o00oY37SaKGB3nO7Dcqv5nqWDYjqodPwec=
=7lox
-----END PGP SIGNATURE-----

--C7PTD44AewjTsiSV--

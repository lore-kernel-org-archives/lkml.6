Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752063AbeEMXWZ (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 19:22:25 -0400
Received: from ozlabs.org ([203.11.71.1]:36899 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751207AbeEMXWY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 19:22:24 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Mon, 14 May 2018 09:21:58 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>, Rob Herring <robh@kernel.org>
Subject: linux-next: build warning after merge of the imx-mxs tree
Message-ID: <20180514092158.297b4fe4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/UntMkUkLI_GU2hWxsTjFzXB"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/UntMkUkLI_GU2hWxsTjFzXB
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Shawn,

After merging the imx-mxs tree, today's linux-next build (arm
multi_v7_defconfig) produced this warning:

arch/arm/boot/dts/imx6dl-aristainetos_7.dtb: Warning (reg_format): /soc/ipu=
@2400000/port@2/endpoint@0:reg: property has invalid length (4 bytes) (#add=
ress-cells =3D=3D 2, #size-cells =3D=3D 1)
arch/arm/boot/dts/imx6dl-aristainetos_7.dtb: Warning (pci_device_bus_num): =
Failed prerequisite 'reg_format'
arch/arm/boot/dts/imx6dl-aristainetos_7.dtb: Warning (simple_bus_reg): Fail=
ed prerequisite 'reg_format'
arch/arm/boot/dts/imx6dl-aristainetos_7.dtb: Warning (avoid_default_addr_si=
ze): /soc/ipu@2400000/port@2/endpoint@0: Relying on default #address-cells =
value

and about 7000 more lines across several files ...

It is hard tell what introduced these warnings ...

--=20
Cheers,
Stephen Rothwell

--Sig_/UntMkUkLI_GU2hWxsTjFzXB
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlr4yJYACgkQAVBC80lX
0Gz9sAf+KsurCq4O8xpYM8iE0W/QaMyg/89ntiQ6od+clebLvzvLLGP0RrhZvD+/
2pA5Z6hqEo43Llt+pIAW218PmpBfJK0Wd0bDC7Rq83w26cjN6aNNI2CQRrsFwsns
kDIdYHOgyLcZA1DoDeYYxPg0DTURjSyE0R+sZASN3NlcbRJD6UgMNAeVccz36jBA
aOC76upRu/jwO++JjIt+2ytI2iaiVQ1w8mafpzjsDu3dk+RsE0eRG0LORefP10PN
kUDXBb0Headov2ZpkBtDjzkj5wjoyphrQKHwbFjbpg4wzzkSQbvXhG9hfq1lhDv7
KY8YbYNtq6UWi5ROf0cAafz/yKpexg==
=ot5P
-----END PGP SIGNATURE-----

--Sig_/UntMkUkLI_GU2hWxsTjFzXB--

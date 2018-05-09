Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756020AbeEIGE4 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 02:04:56 -0400
Received: from ozlabs.org ([203.11.71.1]:39025 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753147AbeEIGEy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 02:04:54 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Wed, 9 May 2018 16:04:49 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Rob Herring <robherring2@gmail.com>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>, linux-kbuild@vger.kernel.org
Subject: linux-next: build warning after merge of the devicetree tree
Message-ID: <20180509160449.68b865a2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/IL3STJjhnP56oio3HG38gOG"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/IL3STJjhnP56oio3HG38gOG
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Rob,

After merging the devicetree tree, today's linux-next build (arm
multi_v7_defconfig) produced this warning:

drivers/gpu/drm/rcar-du/rcar_du_of_lvds_r8a7795.dtb: Warning (graph_endpoin=
t): /fragment@1/__overlay__/port@3/endpoint: graph connection to node '/fra=
gment@0/__overlay__/lvds@feb90000/ports/port@0/endpoint' is not bidirection=
al
drivers/gpu/drm/rcar-du/rcar_du_of_lvds_r8a7790.dtb: Warning (graph_endpoin=
t): /fragment@1/__overlay__/port@1/endpoint: graph connection to node '/fra=
gment@0/__overlay__/lvds@feb90000/ports/port@0/endpoint' is not bidirection=
al
drivers/gpu/drm/rcar-du/rcar_du_of_lvds_r8a7790.dtb: Warning (graph_endpoin=
t): /fragment@1/__overlay__/port@2/endpoint: graph connection to node '/fra=
gment@0/__overlay__/lvds@feb94000/ports/port@0/endpoint' is not bidirection=
al

and over 2000 more :-(

Presumably introduced by commit

  0698fc8b542f ("scripts/dtc: Update to upstream version v1.4.6-21-g84e414b=
0b5bc")

but not suppressed by commit

  b63caea4b5b5 ("kbuild: disable new dtc graph and unit-address warnings")

--=20
Cheers,
Stephen Rothwell

--Sig_/IL3STJjhnP56oio3HG38gOG
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlryj4EACgkQAVBC80lX
0GyrFgf+J8ahqnp2Qy+xapk3K59kiIjZZn/KuDeSFU1x3Ael0CaBCbjYajMXn2uz
J7LdRmbpOFfS8oF7LhWyUeOBDL3enDw6NtGw9OWlML8j0z2zzAhIAzntjinKP7e5
aooI/yYAfh4W3ONPUHXPxBSobOA0U9WxCVWouilnxWHd5CL2asn0F9YMVWiFuKN0
PFi0JrwQgET/ErQrCESZWKabxTvdofLtInZN79tpQXzlaHefXebsS1B2nnQ7zbkw
N3AuDP3WJNMF++jePraBKAYZuH00M00yk6secT6NHzUZ3nOxeHpAhbZfbaBwVaxr
XgMsm1qQkinD0A6y++0QZQYUnl1SUQ==
=OITf
-----END PGP SIGNATURE-----

--Sig_/IL3STJjhnP56oio3HG38gOG--

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932677AbeEWMZm (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 08:25:42 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59618 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932070AbeEWMZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 08:25:40 -0400
Date: Wed, 23 May 2018 13:25:30 +0100
From: Mark Brown <broonie@kernel.org>
To: Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Doug Berger <opendmb@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: manual merge of the arm-soc tree with the arm tree
Message-ID: <20180523122530.GJ4828@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YPJ8CVbwFUtL7OFW"
Content-Disposition: inline
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YPJ8CVbwFUtL7OFW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in:

  arch/arm/include/asm/cputype.h

between commit:

  b2ccaa851e9882c10 ("ARM: add CPU part numbers for Cortex A73, A75 and Bra=
hma B15")

=66rom the arm tree and several commits from the arm-soc tree:

  842fa17d6c95368d7 ("ARM: add Broadcom Brahma-B15 main ID definition")
  9e35ddc962a656bf4 ("ARM: add Broadcom Brahma-B53 main ID definition")

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc arch/arm/include/asm/cputype.h
index adc4a3eef815,d1b62ee69f3b..000000000000
--- a/arch/arm/include/asm/cputype.h
+++ b/arch/arm/include/asm/cputype.h
@@@ -77,12 -75,11 +75,13 @@@
  #define ARM_CPU_PART_CORTEX_A12		0x4100c0d0
  #define ARM_CPU_PART_CORTEX_A17		0x4100c0e0
  #define ARM_CPU_PART_CORTEX_A15		0x4100c0f0
 +#define ARM_CPU_PART_CORTEX_A73		0x4100d090
 +#define ARM_CPU_PART_CORTEX_A75		0x4100d0a0
  #define ARM_CPU_PART_MASK		0xff00fff0
 =20
 -/* Broadcom implemented processors */
 +/* Broadcom cores */
  #define ARM_CPU_PART_BRAHMA_B15		0x420000f0
+ #define ARM_CPU_PART_BRAHMA_B53		0x42001000
 =20
  /* DEC implemented cores */
  #define ARM_CPU_PART_SA1100		0x4400a110

--YPJ8CVbwFUtL7OFW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsFXbkACgkQJNaLcl1U
h9B44Qf+IV0QSACk3u+0oDrLeggpqItPMwZuS8Rxh9zAbNsIa9fCBZ3KzriX3T+t
pFV26OSD5tWRn2YvI3IBPanaJqnJYvGq/nicIjc7LV65BMBcA/lDu81eYkCvDZ/r
w0WNb88y7StUnMdHdiGVsLuvh/m12jZJMOMqJoRAZGA5rF+NHtl8Z0kQ+o3ej2r7
0fs/nGdQqgGblp40h3QN7Sx90J2PX29IN02HA9/LB/5uvfjHZJOSYIaiUAqF4AF2
5bDT/BlGc9QpfDGq71s2eIt5za0KomePilJzHAza7AhFTvYOcLssbHtcUmv6Z7z6
Wp0QwdluQkcNYPm8+IcgnTguWUqkpg==
=7lBX
-----END PGP SIGNATURE-----

--YPJ8CVbwFUtL7OFW--

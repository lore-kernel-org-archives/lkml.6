Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968149AbeE2Xko (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 19:40:44 -0400
Received: from ozlabs.org ([203.11.71.1]:45181 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967772AbeE2Xkn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 19:40:43 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Wed, 30 May 2018 09:40:40 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>,
        Russell King <rmk@armlinux.org.uk>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Doug Berger <opendmb@gmail.com>
Subject: linux-next: manual merge of the arm-soc tree with the arm tree
Message-ID: <20180530094040.5fa6dcdd@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/oa+IXDveZvT0czFmcgKEI11"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/oa+IXDveZvT0czFmcgKEI11
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in:

  arch/arm/include/asm/cputype.h

between commit:

  1067a8130b17 ("ARM: add more CPU part numbers for Cortex and Brahma B15 C=
PUs")

from the arm tree and commits:

  9e35ddc962a6 ("ARM: add Broadcom Brahma-B53 main ID definition")
  842fa17d6c95 ("ARM: add Broadcom Brahma-B15 main ID definition")

from the arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/arm/include/asm/cputype.h
index 26021980504d,d1b62ee69f3b..000000000000
--- a/arch/arm/include/asm/cputype.h
+++ b/arch/arm/include/asm/cputype.h
@@@ -77,15 -75,11 +75,16 @@@
  #define ARM_CPU_PART_CORTEX_A12		0x4100c0d0
  #define ARM_CPU_PART_CORTEX_A17		0x4100c0e0
  #define ARM_CPU_PART_CORTEX_A15		0x4100c0f0
 +#define ARM_CPU_PART_CORTEX_A53		0x4100d030
 +#define ARM_CPU_PART_CORTEX_A57		0x4100d070
 +#define ARM_CPU_PART_CORTEX_A72		0x4100d080
 +#define ARM_CPU_PART_CORTEX_A73		0x4100d090
 +#define ARM_CPU_PART_CORTEX_A75		0x4100d0a0
  #define ARM_CPU_PART_MASK		0xff00fff0
 =20
- /* Broadcom cores */
+ /* Broadcom implemented processors */
  #define ARM_CPU_PART_BRAHMA_B15		0x420000f0
+ #define ARM_CPU_PART_BRAHMA_B53		0x42001000
 =20
  /* DEC implemented cores */
  #define ARM_CPU_PART_SA1100		0x4400a110

--Sig_/oa+IXDveZvT0czFmcgKEI11
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsN5PgACgkQAVBC80lX
0Gx81QgAgJ03X4xrOqGH1jZFJVvCz5nIAKT76vu841k/k/OiJV7o5o4j7ahN+9hr
DVIFUNA5legOjkCgkWRZboPlUPu9nnOeJfrHFgHGE03u82D3UOddeUBHpFlSOaL1
B7zej2NWFsIS6HuLRCAVuOY9Qj0DfdFtr+dLEg60AqMw2vtKEnbaTvoJb7Wo0AOx
AJCMiaxH2CEvWlLvZkwdR7UJDZd3EwO+Qsi2XPoK1Ag4IZRJISeoBPlQZV/sBx/B
kDyYLKqz7Dx+Io5KpsT3M9VCHI5C9tHPTe/ahlbvnXopJRzDEr77cZkfj1xm0Rb6
0WVSKgPNcoXDRTC68K7gGIaRKwDkLQ==
=DVNz
-----END PGP SIGNATURE-----

--Sig_/oa+IXDveZvT0czFmcgKEI11--

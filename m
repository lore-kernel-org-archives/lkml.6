Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934806AbeCHEwt (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 23:52:49 -0500
Received: from ozlabs.org ([103.22.144.67]:44165 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933575AbeCHEws (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 23:52:48 -0500
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Thu, 8 Mar 2018 15:52:26 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Huacai Chen <chenhc@lemote.com>
Subject: linux-next: build failure after merge of the akpm-current tree
Message-ID: <20180308155226.1ae520e5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/DHP7VtWh+09kF/gO1aOeDW3"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/DHP7VtWh+09kF/gO1aOeDW3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

After merging the akpm-current tree, today's linux-next build (arm
multi_v7_defconfig) failed like this:

`__stack_chk_guard' referenced in section `.text' of arch/arm/boot/compress=
ed/decompress.o: defined in discarded section `.data' of arch/arm/boot/comp=
ressed/misc.o
`__stack_chk_guard' referenced in section `.text' of arch/arm/boot/compress=
ed/decompress.o: defined in discarded section `.data' of arch/arm/boot/comp=
ressed/misc.o
arch/arm/boot/compressed/Makefile:185: recipe for target 'arch/arm/boot/com=
pressed/vmlinux' failed

Caused by commit

  2412eae312bf ("zboot: fix stack protector in compressed boot phase")

I have reverted that commit for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/DHP7VtWh+09kF/gO1aOeDW3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqgwYoACgkQAVBC80lX
0Gy/iAf/YUHnclh7pQDILR9jbr/jH3deriIobLYB5Ju42GkBElX2wn8b8+zY1dbJ
eO21bchpGyPeN1+Kowc79oPfBnV4dc81vQvvjnpuX5VJTDEqZNngERxchasV43qx
7HiguFRE80mbCxPH6+BvgJfxTtY3mKK2ID3rWNTl08w7aVB70CkbUqQ0HyTAQwWc
Q07s35alE+FQi+Hs9ya2t44jEXVQBnyUbVXP4WXiAJyjfbyjRHrd4BMxGRrBUt71
bDdMCjuPAqOGSzuETXDHKQWp8mAQPyD9AtZ/IUWRvblmJoydqA/trelPFRfiiD2G
NINspCGTRvEib+7h0SIT/gpqlhXgNA==
=LOEy
-----END PGP SIGNATURE-----

--Sig_/DHP7VtWh+09kF/gO1aOeDW3--

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755283AbeCSGHE (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 02:07:04 -0400
Received: from ozlabs.org ([103.22.144.67]:36213 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752285AbeCSGHD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 02:07:03 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Mon, 19 Mar 2018 17:06:27 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mateusz Guzik <mguzik@redhat.com>
Subject: linux-next: build failure after merge of the vfs tree
Message-ID: <20180319170627.04eae43b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/M1UKsN7kwrOeuzdlQbOCNtr"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/M1UKsN7kwrOeuzdlQbOCNtr
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Al,

After merging the vfs tree, today's linux-next build (x86_64 allnoconfig)
failed like this:

fs/super.c: In function 'do_thaw_all_callback':
fs/super.c:942:3: error: implicit declaration of function 'emergency_thaw_b=
dev'; did you mean 'emergency_remount'? [-Werror=3Dimplicit-function-declar=
ation]
   emergency_thaw_bdev(sb);
   ^~~~~~~~~~~~~~~~~~~
   emergency_remount

Caused by commit

  92afc556e622 ("buffer.c: call thaw_super during emergency thaw")

I have reverted that commit for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/M1UKsN7kwrOeuzdlQbOCNtr
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqvU2MACgkQAVBC80lX
0GzYIQgAn2ZoY9tpTcyyhL34y5Fu6JDDOEmOihPE4l/5KPQD0OUdaBs3690SX37e
mJrMuRiQwQD4qoyS8x/waqK20w/Cid8hg5saELuOWpbOfrgMOXSRN2/8vOGaXMmv
5E8/0ms4qwnVG8d03oaS4+VL/QYxg/CuVpc9QDBe0dTGUunKfDcbDWipwj/ZrjHo
SglQkLxTnan5swyda2xkJPvPk2rVemXAyHduwzgjoYJ2sqnkbSlvjFItz1SB3LIZ
rDFMCNh/mmlIxGTslNX7fFqZ6h/eqtj4g/PgBzmCeljSNEJWyuKxnje0eChu3szF
RvdJhsD/pxa+cSdf0kQ7LCI/qjWx/w==
=LnUB
-----END PGP SIGNATURE-----

--Sig_/M1UKsN7kwrOeuzdlQbOCNtr--

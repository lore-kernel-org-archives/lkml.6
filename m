Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932746AbeEaDuC (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 23:50:02 -0400
Received: from ozlabs.org ([203.11.71.1]:59247 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932704AbeEaDuA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 23:50:00 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Thu, 31 May 2018 13:49:49 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jens Axboe <axboe@kernel.dk>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: linux-next: build warning after merge of the block tree
Message-ID: <20180531134939.29d8632e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Lx2kETMdtyP7YgC0OrD_cFA"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Lx2kETMdtyP7YgC0OrD_cFA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Jens,

After merging the block tree, today's linux-next build (x86_64
allmodconfig) produced this warning:

drivers/md/md.c: In function 'mddev_put':
drivers/md/md.c:543:1: warning: the frame size of 2080 bytes is larger than=
 2048 bytes [-Wframe-larger-than=3D]
 }
 ^

This is caused because CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL is now
switched on.  Hopefully Kees (cc'd) can procide some guidance on how to
eliminate this warning.

--=20
Cheers,
Stephen Rothwell

--Sig_/Lx2kETMdtyP7YgC0OrD_cFA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsPcN0ACgkQAVBC80lX
0GzkzAf9EVHrOG9Zm2+BO6X/PNvtHJAcKQ5Rr2DEFOeKFO7r2/8X+hdwGJKGVKyg
VQ+cEuSAqpJsu/9FmYFJY3zci9tjCRiqeU/BKTcgx5aCK91VZghaoGgSPyiyBQwL
bCuZmL8jo+g1E0OlK/jHE1AEgY9inwnjZ8RwcQ6sB2c9GIywYM75+MuLXqbGulPG
PK5po51bxRSUa4hKFPUxECfPT/Q3PxMotM+3EPu2A/PsTlbolv/H+g2/HYMH7uFp
XLDhuu/K0evL2aA0Su9/cgBMaEWQiphwIxD+2fjEXu6bb8ZzwlvN5N5urK4NexAy
Uz2Ftv0ZyC2gRhMEqzEkH/hc/nggwQ==
=pv2H
-----END PGP SIGNATURE-----

--Sig_/Lx2kETMdtyP7YgC0OrD_cFA--

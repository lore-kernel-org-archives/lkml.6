Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751474AbeCNW51 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 18:57:27 -0400
Received: from ozlabs.org ([103.22.144.67]:41541 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750950AbeCNW50 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 18:57:26 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Thu, 15 Mar 2018 09:56:56 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: linux-next: manual merge of the asm-generic tree with the
 input-current tree
Message-ID: <20180315095656.6007fe3a@canb.auug.org.au>
In-Reply-To: <20180315093705.4e75ab90@canb.auug.org.au>
References: <20180315093705.4e75ab90@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/t+2d_Dr55iUjTR_fOswLbQw"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/t+2d_Dr55iUjTR_fOswLbQw
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

[Just adding Dimitry to cc]

On Thu, 15 Mar 2018 09:37:05 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Hi Arnd,
>=20
> Today's linux-next merge of the asm-generic tree got a conflict in:
>=20
>   drivers/input/joystick/analog.c
>=20
> between commit:
>=20
>   c9ab800167e1 ("Input: analog - use get_cycles() on PPC")
>=20
> from the input-current tree and commits:
>=20
>   739d875dd698 ("mn10300: Remove the architecture")
>   588020dcb92a ("treewide: simplify Kconfig dependencies for removed arch=
s")
>=20
> from the asm-generic tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
> --=20
> Cheers,
> Stephen Rothwell
>=20
> diff --cc drivers/input/joystick/analog.c
> index a942c4ccd2af,eefac7978f93..000000000000
> --- a/drivers/input/joystick/analog.c
> +++ b/drivers/input/joystick/analog.c
> @@@ -163,7 -163,7 +163,7 @@@ static unsigned int get_time_pit(void
>   #define GET_TIME(x)	do { x =3D (unsigned int)rdtsc(); } while (0)
>   #define DELTA(x,y)	((y)-(x))
>   #define TIME_NAME	"TSC"
> - #elif defined(__alpha__) || defined(CONFIG_MN10300) || defined(CONFIG_A=
RM) || defined(CONFIG_ARM64) || defined(CONFIG_PPC) || defined(CONFIG_RISCV=
) || defined(CONFIG_TILE)
>  -#elif defined(__alpha__) || defined(CONFIG_ARM) || defined(CONFIG_ARM64=
) || defined(CONFIG_RISCV)
> ++#elif defined(__alpha__) || defined(CONFIG_ARM) || defined(CONFIG_ARM64=
) || defined(CONFIG_PPC) || defined(CONFIG_RISCV)
>   #define GET_TIME(x)	do { x =3D get_cycles(); } while (0)
>   #define DELTA(x,y)	((y)-(x))
>   #define TIME_NAME	"get_cycles"

--Sig_/t+2d_Dr55iUjTR_fOswLbQw
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqpqLgACgkQAVBC80lX
0GwXQwf+Nno+3DamsdzL36b7lyztDTndOAMZf/CUF9zt5VaKTgJwiE96v5AJXS/Q
qEnl+vZ1M/U8dsVM44dLrakRI29YwrHVvuD5I1MJRqLLS0DTrCjL2tn/i1zuskgk
O0P2tXBR8VNKIpwdtthd+74kVEwc5hb3AlKdlE/3H0JYMyEtjMml9hTQ6UyJLJU4
/35lr8b3DdTytQ3Wl35sriyba+VaZEgUvleg8u5k11AYF0kPKyNgUcmBa5WQPl63
xRkK6tAfujdBYIQ6axn1XYe1pY4lh6vVjegE4iBqUlXXGTke0qEfkNFXFDjNgNnG
+ZmXLnHH+zEIoxcbUINd0MVAgw0qXQ==
=AQKp
-----END PGP SIGNATURE-----

--Sig_/t+2d_Dr55iUjTR_fOswLbQw--

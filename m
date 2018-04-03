Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755765AbeDCXHP (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 19:07:15 -0400
Received: from ozlabs.org ([103.22.144.67]:42425 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755732AbeDCXHO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 19:07:14 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Wed, 4 Apr 2018 09:06:00 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: linux-next: manual merge of the asm-generic tree with the
 input-current tree
Message-ID: <20180404090600.1ea10f79@canb.auug.org.au>
In-Reply-To: <20180315095656.6007fe3a@canb.auug.org.au>
References: <20180315093705.4e75ab90@canb.auug.org.au>
        <20180315095656.6007fe3a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/dz0QU.sXmxaqfyUBSfgpgGo"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/dz0QU.sXmxaqfyUBSfgpgGo
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 15 Mar 2018 09:56:56 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> [Just adding Dimitry to cc]
>=20
> On Thu, 15 Mar 2018 09:37:05 +1100 Stephen Rothwell <sfr@canb.auug.org.au=
> wrote:
> >
> > Today's linux-next merge of the asm-generic tree got a conflict in:
> >=20
> >   drivers/input/joystick/analog.c
> >=20
> > between commit:
> >=20
> >   c9ab800167e1 ("Input: analog - use get_cycles() on PPC")
> >=20
> > from the input-current tree and commits:
> >=20
> >   739d875dd698 ("mn10300: Remove the architecture")
> >   588020dcb92a ("treewide: simplify Kconfig dependencies for removed ar=
chs")
> >=20
> > from the asm-generic tree.
> >=20
> > I fixed it up (see below) and can carry the fix as necessary. This
> > is now fixed as far as linux-next is concerned, but any non trivial
> > conflicts should be mentioned to your upstream maintainer when your tree
> > is submitted for merging.  You may also want to consider cooperating
> > with the maintainer of the conflicting tree to minimise any particularly
> > complex conflicts.
> >=20
> > --=20
> > Cheers,
> > Stephen Rothwell
> >=20
> > diff --cc drivers/input/joystick/analog.c
> > index a942c4ccd2af,eefac7978f93..000000000000
> > --- a/drivers/input/joystick/analog.c
> > +++ b/drivers/input/joystick/analog.c
> > @@@ -163,7 -163,7 +163,7 @@@ static unsigned int get_time_pit(void
> >   #define GET_TIME(x)	do { x =3D (unsigned int)rdtsc(); } while (0)
> >   #define DELTA(x,y)	((y)-(x))
> >   #define TIME_NAME	"TSC"
> > - #elif defined(__alpha__) || defined(CONFIG_MN10300) || defined(CONFIG=
_ARM) || defined(CONFIG_ARM64) || defined(CONFIG_PPC) || defined(CONFIG_RIS=
CV) || defined(CONFIG_TILE)
> >  -#elif defined(__alpha__) || defined(CONFIG_ARM) || defined(CONFIG_ARM=
64) || defined(CONFIG_RISCV)
> > ++#elif defined(__alpha__) || defined(CONFIG_ARM) || defined(CONFIG_ARM=
64) || defined(CONFIG_PPC) || defined(CONFIG_RISCV)
> >   #define GET_TIME(x)	do { x =3D get_cycles(); } while (0)
> >   #define DELTA(x,y)	((y)-(x))
> >   #define TIME_NAME	"get_cycles" =20

This conflict now exists between the input-current tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/dz0QU.sXmxaqfyUBSfgpgGo
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlrECNgACgkQAVBC80lX
0Gy2Lwf+OgItgNnMppo741qAvkZubHM7v/FUe1RmCo1UTAdnY5afMQtBsTK4cDQY
PMTTAU6Coj7GT/Ils2dkhABbeP2/L1QGb1CxbvCvvwvIJ+mvF7wiFhbvBsYZlfNj
lMSI2O3/n2KGm1bS4SS5lGHT8M9bAQg8U+wz4cNbQBE9+pLaqpuk50X9mdHUSrLS
aV7czL+7F5cq3WgEwoZ7eJDp+1nYwMghTw4hA7O4NwMXdG01weX9Lpq2NLk8rX4w
C6W7JvTUY62EEse7cvhqBeAxse4/emOFcPKrkQTJ4v0MMRdu0WuZKnxei8mHrAd5
wIKI/uzSryqhvHVkO6NQq6hs5I46/A==
=W1nA
-----END PGP SIGNATURE-----

--Sig_/dz0QU.sXmxaqfyUBSfgpgGo--

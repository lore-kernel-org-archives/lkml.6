Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751731AbeCNWiA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 18:38:00 -0400
Received: from ozlabs.org ([103.22.144.67]:54543 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751357AbeCNWh6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 18:37:58 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Thu, 15 Mar 2018 09:37:05 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: linux-next: manual merge of the asm-generic tree with the
 input-current tree
Message-ID: <20180315093705.4e75ab90@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/QEUqqTTw6gSqoj_+ngjpSHk"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/QEUqqTTw6gSqoj_+ngjpSHk
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Arnd,

Today's linux-next merge of the asm-generic tree got a conflict in:

  drivers/input/joystick/analog.c

between commit:

  c9ab800167e1 ("Input: analog - use get_cycles() on PPC")

from the input-current tree and commits:

  739d875dd698 ("mn10300: Remove the architecture")
  588020dcb92a ("treewide: simplify Kconfig dependencies for removed archs")

from the asm-generic tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/input/joystick/analog.c
index a942c4ccd2af,eefac7978f93..000000000000
--- a/drivers/input/joystick/analog.c
+++ b/drivers/input/joystick/analog.c
@@@ -163,7 -163,7 +163,7 @@@ static unsigned int get_time_pit(void
  #define GET_TIME(x)	do { x =3D (unsigned int)rdtsc(); } while (0)
  #define DELTA(x,y)	((y)-(x))
  #define TIME_NAME	"TSC"
- #elif defined(__alpha__) || defined(CONFIG_MN10300) || defined(CONFIG_ARM=
) || defined(CONFIG_ARM64) || defined(CONFIG_PPC) || defined(CONFIG_RISCV) =
|| defined(CONFIG_TILE)
 -#elif defined(__alpha__) || defined(CONFIG_ARM) || defined(CONFIG_ARM64) =
|| defined(CONFIG_RISCV)
++#elif defined(__alpha__) || defined(CONFIG_ARM) || defined(CONFIG_ARM64) =
|| defined(CONFIG_PPC) || defined(CONFIG_RISCV)
  #define GET_TIME(x)	do { x =3D get_cycles(); } while (0)
  #define DELTA(x,y)	((y)-(x))
  #define TIME_NAME	"get_cycles"

--Sig_/QEUqqTTw6gSqoj_+ngjpSHk
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqppBEACgkQAVBC80lX
0GzoOAgAmKiX7XIiIVtTiSh1MsnacxAsbX4PmuuPGc6ilj8jnLZlKN+nR1X6o9oW
90Ndum29iBJtHUWusVKGcZqI34plJd7tpRoyN+GDQLDv/WDiK+dHrjSl4aHoBnak
G5LsXlZz22yUpxXZUjtR/t30wAniRcdB5W1JsI0BXaPnQTJvAhGiHTNxxqrXMA1G
OhJ6tmVJ5EFOWTRmYtJ7RBbhtKlv5MBfyz/s9FgCREwB/IWIdVJXTQlwYXHz/4Ap
UmcfAoG9NSvv9KmveygYaBFEjwDdt0fk0czjPvs9uoDuF28eoLz6UMebriimQaPs
RN7SUm2s9EUFhTUJrMUewF93t1H55Q==
=Bg1j
-----END PGP SIGNATURE-----

--Sig_/QEUqqTTw6gSqoj_+ngjpSHk--

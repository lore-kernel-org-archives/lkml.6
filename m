Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751698AbeERL42 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 07:56:28 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:45561 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751531AbeERL4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 07:56:22 -0400
X-Google-Smtp-Source: AB8JxZqmour0EIXdpHBc8a8cDtjVWY+zTNBMg8sZ9+EN0k1LDbaXcfZRihAarAhbGv+5FzS5+Kp7Qw==
Date: Fri, 18 May 2018 01:56:19 -1000
From: Joey Pabalinas <joeypabalinas@gmail.com>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Joey Pabalinas <joeypabalinas@gmail.com>
Subject: [PATCH v4] scripts/tags.sh: use `find` for $ALLSOURCE_ARCHS
 generation
Message-ID: <20180518115619.jqb4hqdym7fmrs2p@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wytobq62ncva55nz"
Content-Disposition: inline
User-Agent: NeoMutt/20180323-62-378db9
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wytobq62ncva55nz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Parsing `ls` is fragile at best and _will_ fail when $tree
contains spaces. Replace this with a find-generated string
and directly assign it to $ALLSOURCE_ARCHS; a subshell is
implied by $(), so `cd` doesn't affect the current working
directory.

Signed-off-by: Joey Pabalinas <joeypabalinas@gmail.com>

 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/scripts/tags.sh b/scripts/tags.sh
index 78e546ff689c2d5f40..c08347fdeef12a7621 100755
--- a/scripts/tags.sh
+++ b/scripts/tags.sh
@@ -26,24 +26,15 @@ else
 fi
=20
 # ignore userspace tools
 ignore=3D"$ignore ( -path ${tree}tools ) -prune -o"
=20
-# Find all available archs
-find_all_archs()
-{
-	ALLSOURCE_ARCHS=3D""
-	for arch in `ls ${tree}arch`; do
-		ALLSOURCE_ARCHS=3D"${ALLSOURCE_ARCHS} "${arch##\/}
-	done
-}
-
 # Detect if ALLSOURCE_ARCHS is set. If not, we assume SRCARCH
 if [ "${ALLSOURCE_ARCHS}" =3D "" ]; then
 	ALLSOURCE_ARCHS=3D${SRCARCH}
 elif [ "${ALLSOURCE_ARCHS}" =3D "all" ]; then
-	find_all_archs
+	ALLSOURCE_ARCHS=3D"$(find "${tree}arch/" -mindepth 1 -maxdepth 1 -type d =
-printf ' %f')"
 fi
=20
 # find sources in arch/$ARCH
 find_arch_sources()
 {
--=20
2.17.0.rc1.35.g90bbd502d54fe92035.dirty


--wytobq62ncva55nz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEKlZXrihdNOcUPZTNruvLfWhyVBkFAlr+v2MACgkQruvLfWhy
VBlPww/9H8KmT79aFo3HmikjUqjuI+Gv3Pbg5sXzACkVgO5RZEUCrWrNhZIU1r3V
9teWU8/ngA3Q/Ek5GohAnJ75DZ1jLFR0F71hd7Udrp+jIdavnenSYby9tkdRkrXs
Z5AbS1JkMocxa2yhsyX82TSLPiSOGRV6BDdGZkEG8ppvJVlcXhbjwWInG2ULDaE9
AmiwEz8McqlCGBUek1ZwnCh9o1HpLSCZuGfGpiuWGy4QCUb/GZXqyjvatigMwSae
pLgntnZKuayLx+d+qV3RblyZow9xu0fKGaYZjR8X4i+bD6oMSuPX75Ln6AzCkbJk
oqd1ZMcgcef0tT53H6K8iIhdevV19aszQ9UR7iq3WxK0cqIYGU41orwhJwrAX+eg
FCo99RkODWtj1HE18jf4dNyTypU8aX9cpIvEwTgFI5c3OZ/cODGVzz7EB6mIEkNZ
B+Pb+EUtCWEI1WFHGcoXcOWLaiQt1JI96Zwp6NpVAFC3AOpBoegimW3Vjd/GpPg5
SBlJeADhSUM2IQLwyQaCB/E15B1FsBVCWwx/0bU4nXjnjp279PSbbRTe91sHAQEn
ixlOWzTnZGAv1EePuD50nz5G9SBYy3WCxTPApaYajlHEuQqbM9W+lWXI3zZALrQX
yyEhZFpDyTBj+hDzUnUao96auG4GsKhqMYae8w+FlEjjKzbc6E8=
=2a/n
-----END PGP SIGNATURE-----

--wytobq62ncva55nz--

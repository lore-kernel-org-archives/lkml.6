Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752265AbeEPANR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 20:13:17 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:39598 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751489AbeEPANP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 20:13:15 -0400
X-Google-Smtp-Source: AB8JxZrcJQ7kFJKpzMHEtvBx7wSbIJcujUSuyNbA+m+FMrX/THNMmDwJtHtBTB+A5tJW+aqHWJXe2A==
Date: Tue, 15 May 2018 14:13:11 -1000
From: Joey Pabalinas <joeypabalinas@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Joey Pabalinas <joeypabalinas@gmail.com>
Subject: [PATCH] scripts/tags.sh: don't rely on parsing `ls` for
 $ALLSOURCE_ARCHS generation
Message-ID: <20180516001311.ng6wyxdjqty5ef5j@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="q74megjw7qc7hkty"
Content-Disposition: inline
User-Agent: NeoMutt/20180323-62-378db9
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--q74megjw7qc7hkty
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Parsing `ls` is fragile at best and _will_ fail when $tree
contains spaces. Replace this with a glob-generated string
and directly assign it to $ALLSOURCE_ARCHS; use a subshell
so `cd` doesn't affect the current working directory.

Signed-off-by: Joey Pabalinas <joeypabalinas@gmail.com>

 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/scripts/tags.sh b/scripts/tags.sh
index 78e546ff689c2d5f40..b84acf8889fe836c60 100755
--- a/scripts/tags.sh
+++ b/scripts/tags.sh
@@ -29,14 +29,11 @@ fi
 ignore=3D"$ignore ( -path ${tree}tools ) -prune -o"
=20
 # Find all available archs
 find_all_archs()
 {
-	ALLSOURCE_ARCHS=3D""
-	for arch in `ls ${tree}arch`; do
-		ALLSOURCE_ARCHS=3D"${ALLSOURCE_ARCHS} "${arch##\/}
-	done
+	ALLSOURCE_ARCHS=3D"$( (cd "${tree}arch/" && echo *) )"
 }
=20
 # Detect if ALLSOURCE_ARCHS is set. If not, we assume SRCARCH
 if [ "${ALLSOURCE_ARCHS}" =3D "" ]; then
 	ALLSOURCE_ARCHS=3D${SRCARCH}
--=20
2.17.0.rc1.35.g90bbd502d54fe92035.dirty


--q74megjw7qc7hkty
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEKlZXrihdNOcUPZTNruvLfWhyVBkFAlr7d5cACgkQruvLfWhy
VBm98BAAyFAeYjq+392LpgL8kvor1VJRF2MD4wl/lzJBPLhz85QtAQkuFoOAjGDI
gdLKd0MC5OYgQq+wS2GLdyMp7qOoPfZdG+nKz5D/NepIgjK4ePzuQ07YIFuo/L9Z
gW+LhHWQ3D0WmLw5i365GGI/e3jgs+apmU7dVfRurF0DoVj4a9KP61SFNtlWsZOL
E3+SoqICWyuuy/oIOZNXnbbDsapV8IbVsi51jrUWNNZdfevkYFyBG6YLvHyQ0WgU
agwUlMwgKKA0yuBDCGNX6BUHUBwzSpA/0AMmebIqRMBpIdgVFk5oPeYH24iISSA7
6wqeohte2XufoLEQ0pq+2BH3bcV2YthBXUhaeGNP0etklUb3hHDKQW1etNSzwJSN
p8GMdtV6jXCXuZtSKBYkjD6oJiY9hHPPCiysxoH7tdcmioqQzvWogU8+WMZ/nG/Y
drC0Odm0CPiXprYPftaYsq4acmhHq5dF0+NlU76XcqKmaSRruCQ6yXqoCSA0M+45
AQV5CT/09Z0RWTwheNOMZDxTyIqO6FCXHsBQW82h4OI/IE6d8edOs2wO+6yEdj6z
GFW05V06skx6dspQO9ElKqkyVzbSt3YUb9na5cYwOiYltzw80avsTPASFpCwdVAJ
Usy4otEJhIXw0NYKW/cauIu4HsSk9UxFyDWMu3xNVF7KqaM+mXg=
=qrGg
-----END PGP SIGNATURE-----

--q74megjw7qc7hkty--

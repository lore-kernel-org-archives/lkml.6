Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751892AbeEQV0Z (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 17:26:25 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:33424 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750924AbeEQV0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 17:26:24 -0400
X-Google-Smtp-Source: AB8JxZrsVhNu077i9LRTJdCC+oTlRVKdXugrhwhV3Yjobx8HhZFZZazKc9sHpS7uwGSZfjqeqq6e/A==
Date: Thu, 17 May 2018 11:26:21 -1000
From: Joey Pabalinas <joeypabalinas@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Joey Pabalinas <joeypabalinas@gmail.com>
Subject: [PATCH v2] scripts/tags.sh: don't parse `ls` for $ALLSOURCE_ARCHS
 generation
Message-ID: <20180517212621.i6ljgrcfhhadrkij@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nmt45bq3vtii2hpn"
Content-Disposition: inline
User-Agent: NeoMutt/20180323-62-378db9
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nmt45bq3vtii2hpn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Parsing `ls` is fragile at best and _will_ fail when $tree
contains spaces. Replace this with a glob-generated string
and directly assign it to $ALLSOURCE_ARCHS; a subshell is
implied by $(), so `cd` doesn't affect the current working
directory.

Signed-off-by: Joey Pabalinas <joeypabalinas@gmail.com>

 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/scripts/tags.sh b/scripts/tags.sh
index 78e546ff689c2d5f40..a4b089aa35efbc0a13 100755
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
+	ALLSOURCE_ARCHS=3D"$(cd "${tree}arch/" && echo *)"
 }
=20
 # Detect if ALLSOURCE_ARCHS is set. If not, we assume SRCARCH
 if [ "${ALLSOURCE_ARCHS}" =3D "" ]; then
 	ALLSOURCE_ARCHS=3D${SRCARCH}
--=20
2.17.0.rc1.35.g90bbd502d54fe92035.dirty

--nmt45bq3vtii2hpn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEKlZXrihdNOcUPZTNruvLfWhyVBkFAlr9830ACgkQruvLfWhy
VBmEyRAAxvIuQ/LVioeCJHeaHRIV9XEF8HbBDp630v+tREr9iXBjHOL5FWfyfA/3
bYk0+DCNCRYR4pTdoe0oyF5QmxwpdwdFiatQRTo8/r/J5+sXTsiOCUCadwomBczc
3S41xLfbmu4OajL+szz/85SlGyqX84c3MbOpiVTyRbh2GDPtfPg13ZPfcA/GYtuY
ttj45GvPemjx9oHCo6gZh93/wGShktM1M1KxzLiVngYvNdsot6J8AKm3Edb+VQpA
XvDxVuniCAMLs86iQxizOgTUHL5owTMWcIOGiIKIf5bCjJwSsZjVqpgz2bkx0Kl1
vsOBKJxuq++oYDM3VwtaFJMdOgbbZilff+43Cf3HKv81bMCGBnXQGtRVVvwi/Cr4
7Rl1rDJn3IhL5HbPoIsX7q+cpGtMzEq9J2Kx3kEnxe0PrgkAJMVv0DfSWNz5bRsp
e2nu5Q4n+QNDzZklpoKJw35pYjZfj4U+hwS4SloCHF8RS/9U6EODrNMpidoXx98D
p1WqL187QGyuhSBGir72CF0MrrCDFvXA3x+ISK0oSDjJUikP7MNBkMspk8F+hexD
+os8Ol+PBhixa/6xUXfHY2uJorAFIw2YmkElK2o7v95cmXVlfSJR/5AUQUoNj/Eq
5AQ6kkk8eb9LHt9ZNtaR31LsDnVXIzM7l9jyaiK5ynHJr/UluSw=
=2lV5
-----END PGP SIGNATURE-----

--nmt45bq3vtii2hpn--

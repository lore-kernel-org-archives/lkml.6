Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751374AbeEVJQM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 05:16:12 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:45867 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751160AbeEVJQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 05:16:10 -0400
X-Google-Smtp-Source: AB8JxZoGi77+dBTzUxxouN+M5zaZQZSkfMz4oMHpTuo7gU3tIQ7hi3oXYxBoB4LYycbNwE31fmDruA==
Date: Mon, 21 May 2018 23:16:06 -1000
From: Joey Pabalinas <joeypabalinas@gmail.com>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Joey Pabalinas <joeypabalinas@gmail.com>
Subject: [PATCH v5] scripts/tags.sh: use `find` for $ALLSOURCE_ARCHS
 generation
Message-ID: <20180522091606.uxvnrz7bbotpxnhn@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fr4cuyany7qhvesp"
Content-Disposition: inline
User-Agent: NeoMutt/20180323-62-378db9
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fr4cuyany7qhvesp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The current code includes 'Kconfig' in ALLSOURCE_ARCHS, but
it should not (Kconfig is not an architecture). Replace this
with a find-generated string and directly assign it to
$ALLSOURCE_ARCHS. The find_all_archs() function is no longer
needed for a one-liner with obvious semantics, so inline the
arch generation into the surrounding conditional.

Signed-off-by: Joey Pabalinas <joeypabalinas@gmail.com>

 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/scripts/tags.sh b/scripts/tags.sh
index 78e546ff689c2d5f40..e587610d149271171d 100755
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
+	ALLSOURCE_ARCHS=3D$(find ${tree}arch/ -mindepth 1 -maxdepth 1 -type d -pr=
intf '%f ')
 fi
=20
 # find sources in arch/$ARCH
 find_arch_sources()
 {
--=20
2.17.0.rc1.35.g90bbd502d54fe92035.dirty

--fr4cuyany7qhvesp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEKlZXrihdNOcUPZTNruvLfWhyVBkFAlsD39YACgkQruvLfWhy
VBloFRAAqVfelpt1TH6qM+GA0THndQQizTcPl/eAiZ4UaQfboNztKbH+ouBDe10A
X1+buVUTikKEr9KQi70nBcLe4ukE5TJPkVAO+RuWNkYROBw6CCeBVDzSbAydwa4f
10dryXqawpcr+dxDACM4nJkltGxVDa5dmNN4hYtFF6qkQI0OVdvPHP0mpUVM/vx6
s00u+gEsI9SfHb/dh+xQFwDTGbZtB3bBynUC7ipjti4AuR0hek5Rl2BSeRvvkKBW
d2jTNl++3LDTARWCmyBCQFFb3v+uYkTW2reriCyfrD8w16ZpEkdwO1o7QsgLHCbF
vMBoDGi9AKx9xoWNrjSEgyRPic6d3LlmJeFXaIxNlPebtPY5LIG/WG6+x4qnrCKt
HzT/e36AhFkHPqxtJbVn/9hfW6RGo8AVxS96FeGsQgUZAqKl/kvji2rWuEOS7UIA
qFowapCXMlAmlKpQyfkwUiNHAwgRHLXsbtxquLziEoVCRxSBR7g9reNip34QjmzX
R5z8DRZaKtKkwHbp/UXyU80Da5GmrM9luR7h1fdkuTef8FR9prUxxbHnv0pNzxtb
HAzN+IxTtBRMqZAEbWLidagyqbKlID1qNLSbwuBknlqVNTde5aQkR2lcUh8eBO+m
AzFlfwIaB3jpANLLcbUlJspJgidyHe5rczOeV3BeGFkeVUXi150=
=f0N4
-----END PGP SIGNATURE-----

--fr4cuyany7qhvesp--

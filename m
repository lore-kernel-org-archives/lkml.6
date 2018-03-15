Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932448AbeCOVjH (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 17:39:07 -0400
Received: from ozlabs.org ([103.22.144.67]:50387 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751877AbeCOVjG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 17:39:06 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Fri, 16 Mar 2018 08:38:34 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>,
        ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Patrice Chotard <patrice.chotard@st.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the arm-soc
 tree
Message-ID: <20180316083834.3aa0c438@canb.auug.org.au>
In-Reply-To: <CAK8P3a2-fUi0nnsLVJ6h_UuJCgwoNs2OEroYed2ofLd=FiPG0g@mail.gmail.com>
References: <20180316075629.019b6560@canb.auug.org.au>
        <CAK8P3a2-fUi0nnsLVJ6h_UuJCgwoNs2OEroYed2ofLd=FiPG0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/4Tpp=nJyFCEXiTiZpwCCHrC"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/4Tpp=nJyFCEXiTiZpwCCHrC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Arnd,

On Thu, 15 Mar 2018 22:06:29 +0100 Arnd Bergmann <arnd@arndb.de> wrote:
>
> What script do you use to find those? I guess I should check for
> missing signoffs as well when pulling a branch.

See below.  You can give it any commit range you would give e.g. gitk.
I run this using he ranges reported by the "git fetch" for each tree
each day.
--=20
Cheers,
Stephen Rothwell

#!/bin/bash

if [ "$#" -lt 1 ]; then
	printf "Usage: %s <commit range>\n", "$0" 1>&2
	exit 1
fi

commits=3D$(git rev-list --no-merges "$@")
if [ -z "$commits" ]; then
	printf "No commits\n"
	exit 0
fi

for c in $commits; do
	ae=3D$(git log -1 --format=3D'%ae' "$c")
	aE=3D$(git log -1 --format=3D'%aE' "$c")
	an=3D$(git log -1 --format=3D'%an' "$c")
	aN=3D$(git log -1 --format=3D'%aN' "$c")
	ce=3D$(git log -1 --format=3D'%ce' "$c")
	cE=3D$(git log -1 --format=3D'%cE' "$c")
	cn=3D$(git log -1 --format=3D'%cn' "$c")
	cN=3D$(git log -1 --format=3D'%cN' "$c")
	sob=3D$(git log -1 --format=3D'%b' "$c" | grep -i '^[[:space:]]*Signed-off=
-by:')

	am=3Dfalse
	cm=3Dfalse
	grep -i -q "<$ae>" <<<"$sob" ||
		grep -i -q "<$aE>" <<<"$sob" ||
		grep -i -q ":[[:space:]]*$an[[:space:]]*<" <<<"$sob" ||
		grep -i -q ":[[:space:]]*$aN[[:space:]]*<" <<<"$sob" ||
		am=3Dtrue
	grep -i -q "<$ce>" <<<"$sob" ||
		grep -i -q "<$cE>" <<<"$sob" ||
		grep -i -q ":[[:space:]]*$cn[[:space:]]*<" <<<"$sob" ||
		grep -i -q ":[[:space:]]*$cN[[:space:]]*<" <<<"$sob" ||
		cm=3Dtrue

	if "$am" || "$cm"; then
		printf "Commit %s\n" "$c"
		"$am" && printf "\tauthor SOB missing\n"
		"$cm" && printf "\tcommitter SOB missing\n"
		printf "%s %s\n%s\n" "$ae" "$ce" "$sob"
	fi
done

exec gitk "$@"

--Sig_/4Tpp=nJyFCEXiTiZpwCCHrC
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqq59oACgkQAVBC80lX
0GxWNQf/XNyHte04Fq3fqTaOZaStQ2IZkrZp15pJwablp/Cp7+JRevcVioCbbKqC
PQCWdWMVZgipdU9F1cbT7l1xoZUSzAICcYRN2nk71pxI0UVn2EaZhRtuchwXkZmM
1C/KVtKHFxLF1fEHIBq3jhdYm4BxVUOWxchlIRzmA+QEcj/heOk44i8wh1HEv9dw
EbIlaHLdy1evJXv6cwsCkUTh9q+/oSgB97+cN7+PJ4TSmq+/ft4cXG9u/43lxspt
f8irlYp4OhsHmluNE1YHd/gXpeTnMlN0h4h8mIlmEkeXgnpsqU3eLSLxRCd/eUrn
c0Wq+DaBkjmEKOXdF7IgUQ1LSVvlWg==
=hdCg
-----END PGP SIGNATURE-----

--Sig_/4Tpp=nJyFCEXiTiZpwCCHrC--

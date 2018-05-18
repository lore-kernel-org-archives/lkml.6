Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751524AbeERF7p (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 01:59:45 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:33717 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751023AbeERF7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 01:59:44 -0400
X-Google-Smtp-Source: AB8JxZqwziCEf4gz3JgcrYqawkKW4ZYY8HyikrSqoqycGDtyCIPTpEujDyWTuK6yBdOr3nci3GaYWQ==
Date: Thu, 17 May 2018 19:59:40 -1000
From: Joey Pabalinas <joeypabalinas@gmail.com>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Joey Pabalinas <joeypabalinas@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH] scripts/tags.sh: don't rely on parsing `ls` for
 $ALLSOURCE_ARCHS generation
Message-ID: <20180518055940.poyba3abl2mlzm5l@gmail.com>
References: <20180516001311.ng6wyxdjqty5ef5j@gmail.com>
 <CAK7LNAQdF-q0Xtx5wkHsRLSrVAGgU5oeo9BtbPaujDdq08sFfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="72zu3kpfcsuqmze5"
Content-Disposition: inline
In-Reply-To: <CAK7LNAQdF-q0Xtx5wkHsRLSrVAGgU5oeo9BtbPaujDdq08sFfA@mail.gmail.com>
User-Agent: NeoMutt/20180323-62-378db9
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--72zu3kpfcsuqmze5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 18, 2018 at 02:46:32PM +0900, Masahiro Yamada wrote:
> Andrew picked it up, but this patch is *bad*
>=20
> You missed arch/Kconfig.
>=20
> $(cd "${tree}arch/" && echo *)
> contains Kconfig, but it is not arch.

That was also something that I found a bit weird myself, but I had
assumed there was a good reason for keeping that. The original
command also returns a string containing Kconfig:

>  tree=3D"$PWD/"
>  echo "$tree"
>  ALLSOURCE_ARCHS=3D""
>  for arch in `ls ${tree}arch`; do
>          ALLSOURCE_ARCHS=3D"${ALLSOURCE_ARCHS} "${arch##\/}
>  done
>  echo "$ALLSOURCE_ARCHS"'

gives the same output as my command (albeit with an extra leading
space that shouldn't be important):

>  /store/code/projects/kernel/linux/
>   Kconfig alpha arc arm arm64 c6x h8300 hexagon ia64 m68k microblaze mips=
 nds32 nios2 openrisc parisc powerpc riscv s390 sh sparc um unicore32 x86 x=
tensa

However, if there really is no reason for that being there, I
have no complaints against fixing it. I'll send a v3 in a bit.

--=20
Cheers,
Joey Pabalinas

--72zu3kpfcsuqmze5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEKlZXrihdNOcUPZTNruvLfWhyVBkFAlr+a8wACgkQruvLfWhy
VBl5FxAAka/W1gdx1/4rZphjIkygMt3SSwF7/Ia6W880BaTijPmtWhiVS3C85D04
7D6ZCnN9/x8BeLu5ZZn+dxZ+EGtPJeN9nBxz1g2SLpXXyZxi0b07Ch5cLHJ7+tg1
Q9eoCT0uACCyLryKOpbY3BahnftUIwIrmWlnvPW5rHBSdU73tfzXH+diFqpNvXUU
3sLxjF/XK0cK99mSZ8MIvCmeHfCFPcnIETJF5Ennk4pUEu4BJCo/8kok7i1ZEKxd
8+Hxln0X7sXWSnY9hpjf6KB0kiww4go4+BhNOFkyRKurfAoIIe+yltUhob09hNuu
QG+X0VIJAroSSajN/8ZiNsSKYXrK6LB5tg8FzWQwAwlxwiKyOp/VX7ki8EYi3uvQ
gfjEPfZsW7d14NlzVUOUWJuDzPrEfm6cg20s5sS+cLTlhfcbGFontMjQs/ovtoS1
4p+Xzu/AOWFKEoqmN9GN0JZKu+SMo59XIJEnrhUsE8tUHg9cYr+Ds9FRqYXng8sU
JNgr7WdFYy6oHqO5zgURV+DaDBy/b2Vs60xfeCVtuRn4SSXS1ocxwl9SAJshok85
LEzgSxz5HgZ7QJLoKaTeXKGAyURlFy86kitizJXyATx6KVuHo7ZWRMBaPS57v3XR
vWfNUC+Nk7kRmfSujqpkvwEHCPDOhRWjETBiuc6ggpxbie+d3aA=
=fmjG
-----END PGP SIGNATURE-----

--72zu3kpfcsuqmze5--

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751414AbeEVIVY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 04:21:24 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:44997 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751174AbeEVIVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 04:21:21 -0400
X-Google-Smtp-Source: AB8JxZrTIvORWKVifa9wH63H6VsfxHmmZ/3XSKOh73OR+zj0lGWLh7JQjXjUqoEBbWEprp6xRKfgrA==
Date: Mon, 21 May 2018 22:21:17 -1000
From: Joey Pabalinas <joeypabalinas@gmail.com>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Joey Pabalinas <joeypabalinas@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH v4] scripts/tags.sh: use `find` for $ALLSOURCE_ARCHS
 generation
Message-ID: <20180522082117.p2b5jt5qtuwarqwo@gmail.com>
References: <20180518115619.jqb4hqdym7fmrs2p@gmail.com>
 <CAK7LNASuhoJsaBz6RjumbQnqhtyLJGLjkhGSs5-bvDz1TOuGww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="d6tcxwzylcsgbhiz"
Content-Disposition: inline
In-Reply-To: <CAK7LNASuhoJsaBz6RjumbQnqhtyLJGLjkhGSs5-bvDz1TOuGww@mail.gmail.com>
User-Agent: NeoMutt/20180323-62-378db9
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--d6tcxwzylcsgbhiz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 22, 2018 at 03:01:07PM +0900, Masahiro Yamada wrote:
> The commit log is wrong.
>=20
>=20
> 2018-05-18 20:56 GMT+09:00 Joey Pabalinas <joeypabalinas@gmail.com>:
> > Parsing `ls` is fragile at best and _will_ fail when $tree
> > contains spaces.
>=20
> This statement is wrong.
>=20
> The cause of the problem is not using whatever command you use,
> but missing quoting.
> The following would work even  if $tree contains spaces:
>=20
>     for arch in `ls "${tree}arch"`; do

Ah, to be completely honest that case didn't even occur to me.

> BTW, what was your motivation of this patch?
>=20
> Does ${tree} contain spaces?

>=20
> If the file path contains spaces, the top Makefile terminates it earlier.
>=20
> Makefile:128: *** main directory cannot contain spaces nor colons.  Stop.

It doesn't; I didn't realize the Makefile already had a guard against
spaces in paths. It was something I noticed when poking at something
else and I thought it might be something worth fixing.

But now I agree with you that this patch isn't really needed at all. I can
no longer think of a case where even the original

> for arch in `ls ${tree}arch`; do

would break since spaces are not allowed at all.

Well, on the bright side, the times you happen to be wrong are also the
times where you learn the most :)

--=20
Cheers,
Joey Pabalinas

--d6tcxwzylcsgbhiz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEKlZXrihdNOcUPZTNruvLfWhyVBkFAlsD0v0ACgkQruvLfWhy
VBlDcRAA0+uxzHtntIaAc8IaRdd0KaDYh6wMoUV/AjII4z0NoRtcyBpMOCpZGWLX
eim7dqbSutC+t4vOp9wih1BpMlx0KtNN9XX3wsVieknjZ2vLFNmQKZoYWc6oS3ZH
T+ZIanz9T9ZPGvpj7K5cAMq/BQ9U0/2a6ZB7Xr+4ARa4ovTCOfXCdSevJYIWMFF0
9beCbkuwIU5OhfDKqMx1rIaKIp98DD1MwEJIfDOPlLmLGp8LhJ5slAfKg4gg0e3l
J8bAgyqEC6iqCbK3XV59PQXWPmPdbEakVfSEaxUg5UCSgG3mANoGztm4FbPpqdk1
fjxVW6PYjI2LicE9xFBtKaKhILevGfN93zFkzs5/8miTiRCFjktrdMFPx9iMur2/
y0oHWTLgp6hkWCC3Mmb6h7sE4Z5h/o0bFeNUF2TgDsPpBwt3s4PI1wm5NzjzQAKn
qRUYk3JrPsRFXC7h1LMdQR4wcM+SW/UiLi7tbTiexudiFBsA7tTlzpLCf5zJEIR0
tGhtJZa5FSciYTY+HYmtRro/dPdCN40+Ph6ssRP6cM94CT49BD41p8+ICfMNnWtx
aR5yA5rwwB+0AjW3haoMvep/AGWXwpIyAVT+cDO4eU4F5oRoZncnZGLSkpNvK7o4
ng+L3utfaQTd8+f4IfjpofudTXW7dpu3prlii6NF+zWrrg1ReZo=
=jvU9
-----END PGP SIGNATURE-----

--d6tcxwzylcsgbhiz--

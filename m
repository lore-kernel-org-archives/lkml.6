Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751440AbeBXNsm (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Feb 2018 08:48:42 -0500
Received: from mout.gmx.net ([212.227.15.19]:37139 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751131AbeBXNsk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Feb 2018 08:48:40 -0500
Date: Sat, 24 Feb 2018 14:48:31 +0100
From: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: Christophe LEROY <christophe.leroy@c-s.fr>
Cc: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>, linux-mm@kvack.org,
        Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH 0/5] PPC32/ioremap: Use memblock API to check for RAM
Message-ID: <20180224134831.iulzv7iiz3tq7icr@latitude>
References: <20180222121516.23415-1-j.neuschaefer@gmx.net>
 <ca471c17-d2a7-e8e6-2d5a-a5a534e7e6d9@c-s.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="px5zsypbfveej6ru"
Content-Disposition: inline
In-Reply-To: <ca471c17-d2a7-e8e6-2d5a-a5a534e7e6d9@c-s.fr>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K0:W0T+xY/d/bWEBI/qzi4WpNZHGaGLKVo04JfLg1Ewx03+22khryn
 pnyI4tXtaHGBNyO2hTht5TmUl5w5bbrD/bTjYGgGMJCyiBBpMH2ATVcNvbiN4WN2hfoEYvu
 dV/jgY2UUi1dnNavQEMwkBWhFy7SPZQ4MC3asOKUPkqyQwD5Z2iPWOaeAuOYngR0i1BHAsU
 svZanNg/uHViKmamBOJ8A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/y131CPo8rw=:9QwgHJmW2PDkxFlhmrDq5x
 hcopfiFr06oiA6RKrnNq6dbeW3k/oIFKoaaGxgkFn3NuGKeO25+192SWLh/GeQuRpyhdF9QKO
 UfVCYItoq7t7MErvI3nJGH0aKmw1CMZN5PLbmg0l07G4u10xaOhMRsk1M973Orm+2i4ki/nMk
 /d25HmsACu5T1enyxBWXzrP87dee+uD12o0EsQb6wGhBpua1RhzfeMacFhf9QoGIF0b4ZdLnN
 FbiZ9Sl4ZWaAISnOiEg7MbZiMB/uhHv3FG2JCcTz/XV/eF6ZXEOdwadsYEBaYKTIgtZzCj4Oi
 nhBH/RxVklbesJjKVIZsC7WbVTw/UykKALyAxUq+yv57b8tqoiqDbS6F95I1j/+rZpWrPjm0m
 3qkObgT/wTHz7LEWbDCd+RS22MkuiRKnr+elrn+cCDxwwl6Xv/ttrHjTpVacbNARmavKlrQgV
 EZLQ6tyClDMoTIa8FDrvWME/snxGwQoYXE8DKuItdPrUP44/RlFOq8kOtbcinx5WY6tdPrCrM
 1ibLPzxK5+VYezmF3m7OOAemZnIk4ttWflGdTndaEQiMr4ky0s+jufQ64g4h6ueZ7zE2zckfI
 2U7UiLWqUFSU1YcO3lWI8olj3PZna3uJk1kVxClC3uJh7fBr386mq393/fzIp7lLQyhDQ9hpd
 He2xah7oU+VbM55t+KqBB3h1orxZ6XoIcpMVGkzW5WGiQUJzYv4cRgcJSuWi0s/GZVrp9I4Al
 7mGKJYAe8Ea1Y/TeiPQXzqq9Z7LSHIotdZtcD9Rn/nMIBB/0P39T8shk4fkMRN9mj6oWG0f1d
 sjn7/Nt9R+ZVQUOst4sQMeEiEQ2LQ==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--px5zsypbfveej6ru
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2018 at 09:01:17AM +0100, Christophe LEROY wrote:
>=20
>=20
> Le 22/02/2018 =C3=A0 13:15, Jonathan Neusch=C3=A4fer a =C3=A9crit=C2=A0:
> > This patchset solves the same problem as my previous one[1] but follows
> > a rather different approach. Instead of implementing DISCONTIGMEM for
> > PowerPC32, I simply switched the "is this RAM" check in __ioremap_caller
> > to the existing page_is_ram function, and unified page_is_ram to search
> > memblock.memory on PPC64 and PPC32.
> >=20
> > The intended result is, as before, that my Wii can allocate the MMIO
> > range of its GPIO controller, which was previously not possible, because
> > the reserved memory hack (__allow_ioremap_reserved) didn't affect the
> > API in kernel/resource.c.
> >=20
> > Thanks to Christophe Leroy for reviewing the previous patchset.
>=20
> I tested your new serie, it doesn't break my 8xx so it is OK for me.

Thanks for testing it!


Jonathan Neusch=C3=A4fer

--px5zsypbfveej6ru
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAABAgAGBQJakW0oAAoJEAgwRJqO81/bnNkP+wZw677bWbfnSz2yBIcXvWEF
rDZ1mxe7lkYQOB66/e07uuc/1MUFv2I01x8nF6hCGE1jRqE7P2UoTM8659xjpbGv
iSp+W1qc2KRjyrCXXUW/5gsCHW6Hs0uyDTsmfx9uHPmnVB0UedgFbseNTafL+Hna
0gwVM1mXRQSewlg/JV1jiEIonJvS4YOMM5TAFWT91FDZzsC7vLE/WsJrtAQaxfBY
IOe+0/PMICU9bBRk2wGkf8Aw89ydLPfwYKam6kABhsNFapBU61Rq6q4roOl0ZZp1
iPhzF45leSGjy1MU+f+jzZA4c58xJE82wJpxK5kES9v6yIOLGYjaMkmWVUj0FaOU
ky0TIc2mj4qRCIuMo8x0X0dMut1Je6Hri4JzlB01H1FgEvOoCj6exl4IIF69LU6A
mfJOZ9zPsaRrImqlT7i+sQwdTCC5733AdXssiotNuqLhSWpmfVv32EhjA6+ASNRk
jI5p24iIeneVCh7wV6XGeQXC3JR9ZLH8+H4OFCps2ElMjeHr35qtnX8HPkhT10gD
HLWSoZN5+itF5ZZn3KlowtUGHM7iycJz3VXbY6bYZp6+SmV0VL5K34b0NtmKQtUC
4M0Nu2X98Wluv37Zkh7Nc0mbodsS3RUDqMvcHPXuFZJN4sug/0BKqjtnq/V2p7sS
AHKoHGYHVDzl3QfavCBs
=RpIO
-----END PGP SIGNATURE-----

--px5zsypbfveej6ru--

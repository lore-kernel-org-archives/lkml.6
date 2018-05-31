Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751337AbeEaVaz (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 17:30:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:40282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750903AbeEaVax (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 17:30:53 -0400
Date: Thu, 31 May 2018 22:30:49 +0100
From: James Hogan <jhogan@kernel.org>
To: "Maciej W. Rozycki" <macro@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] MIPS: ptrace: Fix PTRACE_PEEKUSR requests for 64-bit FGRs
Message-ID: <20180531213048.GB30406@jamesdev>
References: <alpine.DEB.2.00.1805161306260.10896@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kXdP64Ggrk/fb43R"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1805161306260.10896@tp.orcam.me.uk>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kXdP64Ggrk/fb43R
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 16, 2018 at 04:39:58PM +0100, Maciej W. Rozycki wrote:
> Use 64-bit accesses for 64-bit floating-point general registers with=20
> PTRACE_PEEKUSR, removing the truncation of their upper halves in the=20
> FR=3D1 mode, caused by commit bbd426f542cb ("MIPS: Simplify FP context=20
> access"), which inadvertently switched them to using 32-bit accesses.
>=20
> The PTRACE_POKEUSR side is fine as it's never been broken and continues=
=20
> using 64-bit accesses.
>=20
> Cc: <stable@vger.kernel.org> # 3.19+
> Fixes: bbd426f542cb ("MIPS: Simplify FP context access")
> Signed-off-by: Maciej W. Rozycki <macro@mips.com>
> ---
> Hi,
>=20
>  Here's another one, spotted in the course of GDB PR gdb/22286 regression=
=20
> testing with the n64 ABI.  Please apply.
>=20
>   Maciej

Thanks, applied to mips-fixes, hopefully for 4.17 (but if it misses
tomorrows linux-next it may have to wait 'til 4.18).

Cheers
James

--kXdP64Ggrk/fb43R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQS7lRNBWUYtqfDOVL41zuSGKxAj8gUCWxBphwAKCRA1zuSGKxAj
8iD3AP9Kj0BRdIaIbiXcXrM2jUI27Svyt9XAdqcE4bEn5glHfwD+OUSfWsfkAm7B
DqzpiLqWGXrVIXqBXEtySES+p92FVgI=
=88k4
-----END PGP SIGNATURE-----

--kXdP64Ggrk/fb43R--

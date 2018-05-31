Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751291AbeEaVaE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 17:30:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:39062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750934AbeEaVaC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 17:30:02 -0400
Date: Thu, 31 May 2018 22:29:57 +0100
From: James Hogan <jhogan@kernel.org>
To: "Maciej W. Rozycki" <macro@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] MIPS: prctl: Disallow FRE without FR with PR_SET_FP_MODE
 requests
Message-ID: <20180531212956.GA30406@jamesdev>
References: <alpine.DEB.2.00.1805141439290.10896@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1805141439290.10896@tp.orcam.me.uk>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 15, 2018 at 11:04:44PM +0100, Maciej W. Rozycki wrote:
> Having PR_FP_MODE_FRE (i.e. Config5.FRE) set without PR_FP_MODE_FR (i.e.=
=20
> Status.FR) is not supported as the lone purpose of Config5.FRE is to=20
> emulate Status.FR=3D0 handling on FPU hardware that has Status.FR=3D1=20
> hardwired[1][2].  Also we do not handle this case elsewhere, and assume=
=20
> throughout our code that TIF_HYBRID_FPREGS and TIF_32BIT_FPREGS cannot=20
> be set both at once for a task, leading to inconsistent behaviour if=20
> this does happen.
>=20
> Return unsuccessfully then from prctl(2) PR_SET_FP_MODE calls requesting=
=20
> PR_FP_MODE_FRE to be set with PR_FP_MODE_FR clear.  This corresponds to=
=20
> modes allowed by `mips_set_personality_fp'.
>=20
> References:
>=20
> [1] "MIPS Architecture For Programmers, Vol. III: MIPS32 / microMIPS32
>     Privileged Resource Architecture", Imagination Technologies,
>     Document Number: MD00090, Revision 6.02, July 10, 2015, Table 9.69=20
>     "Config5 Register Field Descriptions", p. 262
>=20
> [2] "MIPS Architecture For Programmers, Volume III: MIPS64 / microMIPS64=
=20
>     Privileged Resource Architecture", Imagination Technologies,=20
>     Document Number: MD00091, Revision 6.03, December 22, 2015, Table=20
>     9.72 "Config5 Register Field Descriptions", p. 288
>=20
> Cc: stable@vger.kernel.org # 4.0+
> Fixes: 9791554b45a2 ("MIPS,prctl: add PR_[GS]ET_FP_MODE prctl options for=
 MIPS")
> Signed-off-by: Maciej W. Rozycki <macro@mips.com>

Thanks, applied to mips-fixes, hopefully for 4.17 (but if it misses
tomorrows linux-next it may have to wait 'til 4.18).

Cheers
James

--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQS7lRNBWUYtqfDOVL41zuSGKxAj8gUCWxBpUwAKCRA1zuSGKxAj
8nD+AQDlX/YPX/WyufbGvOmzQO3ows5pmEBYDLTntCMjLwfQLAEA9ODc1Qt8srfM
nrZ+PcIffTYPGEghVp1HHUcl1GHBqwU=
=UY2D
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--

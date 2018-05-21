Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753223AbeEUQOu (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 12:14:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:38120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752876AbeEUQOt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 12:14:49 -0400
Date: Mon, 21 May 2018 17:14:45 +0100
From: James Hogan <jhogan@kernel.org>
To: Matt Redfearn <matt.redfearn@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] MIPS: memset.S: Add comments to fault fixup
 handlers
Message-ID: <20180521161443.GA9998@jamesdev>
References: <1523979603-492-1-git-send-email-matt.redfearn@mips.com>
 <1523979603-492-4-git-send-email-matt.redfearn@mips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5mCyUwZo2JvN/JJP"
Content-Disposition: inline
In-Reply-To: <1523979603-492-4-git-send-email-matt.redfearn@mips.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 17, 2018 at 04:40:03PM +0100, Matt Redfearn wrote:
> diff --git a/arch/mips/lib/memset.S b/arch/mips/lib/memset.S
> index 1cc306520a55..a06dabe99d4b 100644
> --- a/arch/mips/lib/memset.S
> +++ b/arch/mips/lib/memset.S
> @@ -231,16 +231,25 @@
> =20
>  #ifdef CONFIG_CPU_MIPSR6
>  .Lbyte_fixup\@:
> +	/*
> +	 * unset_bytes =3D current_addr + 1
> +	 *      a2     =3D      t0      + 1

The code looks more like a2 =3D 1 - t0 to me:

> +	 */
>  	PTR_SUBU	a2, $0, t0
>  	jr		ra
>  	 PTR_ADDIU	a2, 1

I.e. t0 counts up to 1 and then stops.

Anyway I've applied patch 3 for 4.18.

Cheers
James

--5mCyUwZo2JvN/JJP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQS7lRNBWUYtqfDOVL41zuSGKxAj8gUCWwLwbgAKCRA1zuSGKxAj
8pVzAQCMm0CcwP/uwnlI1wpP3iYFikj0u1zLwAjzUkfKc9ulwQEAhFUoRm2/fb1m
ge9q5n/5sVHMJCTh9P/GShTwKXSvqQc=
=zRxf
-----END PGP SIGNATURE-----

--5mCyUwZo2JvN/JJP--

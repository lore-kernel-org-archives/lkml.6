Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753841AbeCVK0Q (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 06:26:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:44992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753848AbeCVK0L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 06:26:11 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 873DC217D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date: Thu, 22 Mar 2018 10:26:07 +0000
From: James Hogan <jhogan@kernel.org>
To: Paul Cercueil <paul@crapouillou.net>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: Fix build with DEBUG_ZBOOT and MACH_JZ4770
Message-ID: <20180322102606.GE13126@saruman>
References: <20180317201109.2000-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+SfteS7bOf3dGlBC"
Content-Disposition: inline
In-Reply-To: <20180317201109.2000-1-paul@crapouillou.net>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+SfteS7bOf3dGlBC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 17, 2018 at 09:11:09PM +0100, Paul Cercueil wrote:
> Since the UART addresses are the same across all Ingenic SoCs, we just
> use a #ifdef CONFIG_MACH_INGENIC instead of checking for indifidual
> Ingenic SoCs.

s/indifidual/individual/

> --- a/arch/mips/boot/compressed/uart-16550.c
> +++ b/arch/mips/boot/compressed/uart-16550.c
> @@ -18,9 +18,9 @@
>  #define PORT(offset) (CKSEG1ADDR(AR7_REGS_UART0) + (4 * offset))
>  #endif
> =20
> -#if defined(CONFIG_MACH_JZ4740) || defined(CONFIG_MACH_JZ4780)
> -#include <asm/mach-jz4740/base.h>
> -#define PORT(offset) (CKSEG1ADDR(JZ4740_UART0_BASE_ADDR) + (4 * offset))
> +#if CONFIG_MACH_INGENIC

I think you meant #ifdef there.

Cheers
James

--+SfteS7bOf3dGlBC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqzhLcACgkQbAtpk944
dnqphQ/+PoQSqqufgM0xaKRA59pBYup1OInKYfA036bzuE4HSp9dfiQCjRDAZdxG
8w8w5bD1OWkQhA6wNmB/uRXR43Qx2leZGbsT782iohUBZ6WkklkC4WrHsPbmmG0E
9QxheQOPVuLJTqjRfDzKpANwZxQDJk6Z0a7+78Za49pcfXjAwFphwjxMme2ryp4W
5naK+q5+MVJOF0MSgjS4QYgZIbAz9OVldTTd5sA9MdFavK8aIXBDWZUj6tpwv3XG
zlWAJ4sXjI0XNvQv7TUM3ig3TmOEH+P1hDvCskQ0Rl5QelPRD0BBDrQvjx9ps6kc
Vja7eQXIPIlZXOV4NtKsofWvto3ehmCUm5a8S/zIvYZHXrOXmYEl9CGX0rxWi/VJ
y+JwdTp2g9qAIYFLHzQ5E50hyK3J+RqfHlFaQ9Eb32GyNDPfb0hPaDGGeCcjMldY
MZvVqyPRltxAkiNJhEh4KYNB2OjFeJ/96MlsxShi/B7tBKBJkXf95HzcT3Lj6tkj
H5KExPvz3Yf3/nZLN7TL836P7MB4IZh+rbyQVObHPMNiPVhbVJB/fjjl40V43mRt
Sy1x4mLARE2Rtnm7zZDD5oBGQWxCm51f3Uqb5PQgoj2XhgQ1qizPcnmYx0mYgzSP
wk3sK8NSEH2YLmsigESg2u+hFsvJV1agOFb+hUkzUNkxdMRErpU=
=SpUz
-----END PGP SIGNATURE-----

--+SfteS7bOf3dGlBC--

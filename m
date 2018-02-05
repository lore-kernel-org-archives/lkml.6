Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753056AbeBENhI (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 08:37:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:42608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752607AbeBENhC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 08:37:02 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3477821734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date: Mon, 5 Feb 2018 13:36:57 +0000
From: James Hogan <jhogan@kernel.org>
To: Matt Redfearn <matt.redfearn@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: TXx9: use IS_BUILTIN() for CONFIG_LEDS_CLASS
Message-ID: <20180205133656.GB8479@saruman>
References: <1517225205-10374-1-git-send-email-matt.redfearn@mips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="OwLcNYc0lM97+oe1"
Content-Disposition: inline
In-Reply-To: <1517225205-10374-1-git-send-email-matt.redfearn@mips.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OwLcNYc0lM97+oe1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2018 at 11:26:45AM +0000, Matt Redfearn wrote:
> When commit b27311e1cace ("MIPS: TXx9: Add RBTX4939 board support")
> added board support for the RBTX4939, it added a call to
> led_classdev_register even if the LED class is built as a module.
> Built-in arch code cannot call module code directly like this. Commit
> b33b44073734 ("MIPS: TXX9: use IS_ENABLED() macro") subsequently
> changed the inclusion of this code to a single check that
> CONFIG_LEDS_CLASS is either builtin or a module, but the same issue
> remains.
> This leads to MIPS allmodconfig builds failing when CONFIG_MACH_TX49XX=3Dy
> is set:
>=20
> arch/mips/txx9/rbtx4939/setup.o: In function `rbtx4939_led_probe':
> setup.c:(.init.text+0xc0): undefined reference to `of_led_classdev_regist=
er'
> make: *** [Makefile:999: vmlinux] Error 1
>=20
> Fix this by using the IS_BUILTIN() macro instead.
>=20
> Fixes: b27311e1cace ("MIPS: TXx9: Add RBTX4939 board support")
> Fixes: b33b44073734 ("MIPS: TXX9: use IS_ENABLED() macro")
>=20
> Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>

Thanks, applied

Cheers
James

>=20
> ---
>=20
>  arch/mips/txx9/rbtx4939/setup.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/mips/txx9/rbtx4939/setup.c b/arch/mips/txx9/rbtx4939/se=
tup.c
> index 8b937300fb7f..fd26fadc8617 100644
> --- a/arch/mips/txx9/rbtx4939/setup.c
> +++ b/arch/mips/txx9/rbtx4939/setup.c
> @@ -186,7 +186,7 @@ static void __init rbtx4939_update_ioc_pen(void)
> =20
>  #define RBTX4939_MAX_7SEGLEDS	8
> =20
> -#if IS_ENABLED(CONFIG_LEDS_CLASS)
> +#if IS_BUILTIN(CONFIG_LEDS_CLASS)
>  static u8 led_val[RBTX4939_MAX_7SEGLEDS];
>  struct rbtx4939_led_data {
>  	struct led_classdev cdev;
> @@ -261,7 +261,7 @@ static inline void rbtx4939_led_setup(void)
> =20
>  static void __rbtx4939_7segled_putc(unsigned int pos, unsigned char val)
>  {
> -#if IS_ENABLED(CONFIG_LEDS_CLASS)
> +#if IS_BUILTIN(CONFIG_LEDS_CLASS)
>  	unsigned long flags;
>  	local_irq_save(flags);
>  	/* bit7: reserved for LED class */
> --=20
> 2.7.4
>=20

--OwLcNYc0lM97+oe1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlp4XfgACgkQbAtpk944
dnpwvw/6AqqBb8XqMxPvcfVvboO83hEPlc84gOXz/wT4BL60ZSFQ+JeM88/1EkjO
q8E4ANaepHmqUKobnomWyc4TdBtXIFrYxyKel/ipP9rN7v1tWahOznPle2hazHnN
y+5tvqw8seJVRer0ewDU6jXkp9jIIYkn/QIBp42uhMHjYLw4+hR/cIEKIZnVz7qY
xf2Q5v/p7BvOe2UCAO9Cb8TcYCxzMWh48MkhQeUq6aw22KwEaI1RViUBybsXkBw6
CGvIFOg43KgdfDew9S3ebTWa/hbFYSMraiccFb/7hev+fM9HkB0/eLl289DoRPE5
7omAiRyqqVBqi0yePJjEXvcyjH1hkRZFCZ7qKuZ//jDgd/ArzZuN4JBE+25RM+yZ
Qp83EQueg+8vErSDDT+S+E2druqNIPXFwL/tp11x8aGJu9fnM/M1e9n/G/FywQph
wrbWJztxo3JzsRNGe8thQOyqpiDW5vuiNYaxHHXv+/zrPZbAzNxy6rzo7gYpdIhP
PKs0CxBb3urmuCX4WOaM3B0/ZSukoQO+U/a7sbUxjiCINuXZjHqoc4QNpBtjPrBL
Fo0Oi9SyJp8iO4v7Nod9hbyUl9a05+qMl+6Lfoefic4nFc3g82KfXI96HptpKWfo
aGTnP1+AFOicYpUVuCSLfTNQoFG+Z6SHPs56GKKhlxRvjh0yUnQ=
=PTko
-----END PGP SIGNATURE-----

--OwLcNYc0lM97+oe1--

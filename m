Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752694AbeFDMb2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 08:31:28 -0400
Received: from mail.bootlin.com ([62.4.15.54]:48305 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752131AbeFDMb0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 08:31:26 -0400
Date: Mon, 4 Jun 2018 14:31:24 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] rtc: sunxi: fix possible race condition
Message-ID: <20180604123124.ix5iql3wfgjqymsv@flea>
References: <20180604120540.5782-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lbbrlf5xq4ckj7jx"
Content-Disposition: inline
In-Reply-To: <20180604120540.5782-1-alexandre.belloni@bootlin.com>
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lbbrlf5xq4ckj7jx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 04, 2018 at 02:05:40PM +0200, Alexandre Belloni wrote:
> The IRQ is requested before the struct rtc is allocated and registered, b=
ut
> this struct is used in the IRQ handler. This may lead to a NULL pointer
> dereference.
>=20
> Switch to devm_rtc_allocate_device/rtc_register_device to allocate the rtc
> before requesting the IRQ.
>=20
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--lbbrlf5xq4ckj7jx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlsVMRsACgkQ0rTAlCFN
r3TlhQ//X3Yo2WQrquX/evNNPHbPmAR1mGWC+xicF59ryY06dD1Q3P/VbEhmPEvU
9jc1XKLa+OqYL6WeyL+eavkGstb4B3O89+iDrXudrzDXL7xZHS+k/o+VJLQPxA7J
/T7r8T0Ik5HDoxzBcSsqvOCnXz0QzAnJG6YXczYsk1wj+IRiZBK7G6bcEgKXXDb/
NrStoK2802gBESKsIIBlInzoA2kbpr+acjpJzpskeKCkA5yYFs5o+SFW2k0xMEXe
zsHY8H6f6XPUTohxzQdEdIp1WqxF+BAlnmDfh13xhbIIKmoW8fMud1gQPtkcSwRV
J5VIerXb7pzw7/prZvjRIv+W0PsjlPDDMlEdXMigwYQd06lkQEbuCF57Rv/5i0r2
Q9sKjGq9WFHmBF1/qxyhDMXaqeYtqGg0Nb95liK5zBa3rPBc/Vi1XUkXaZhY3D5m
qYkYma7/E1s+s1Z9Y2F3CBsZX3KzExQD5twyaBGgx/ilLpY4KJMQfBOb0JAP0jYP
b4IR7w/Rm147AdxxuQGYHibmetJXowby5v6fNg8+tx7CWz23a+rKWFmFye9coQGL
3+IZvFqaEwyx7dmS2i5G9NWYF3pAhrUr1YTlxiXpfLvqIUWTLVqZ7PFpBRlZlWPm
02tRrfKXFwyiGK9Et9+vRNdMS0HwwYqFLeUBTcFL4YbRAnCKruE=
=4f4z
-----END PGP SIGNATURE-----

--lbbrlf5xq4ckj7jx--

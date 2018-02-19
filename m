Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752008AbeBSIKx (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 03:10:53 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:54400 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751628AbeBSIKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 03:10:52 -0500
Date: Mon, 19 Feb 2018 09:10:50 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Philipp Rossak <embed3d@gmail.com>
Cc: linux@armlinux.org.uk, wens@csie.org, davem@davemloft.net,
        arnd@arndb.de, mchehab@kernel.org, clabbe.montjoie@gmail.com,
        rask@formelder.dk, krzk@kernel.org, sean@mess.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [RFC PATCH] ARM: configs: sunxi: Set ondemand govenor as default
Message-ID: <20180219081050.vvfhnbw4foved2fb@flea.lan>
References: <20180217142235.28541-1-embed3d@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jrtnuvo447uvbywl"
Content-Disposition: inline
In-Reply-To: <20180217142235.28541-1-embed3d@gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jrtnuvo447uvbywl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 17, 2018 at 03:22:35PM +0100, Philipp Rossak wrote:
> Right now the performance govenor is the default frequency govenor on
> sunxi devices. This causes some general problems.
> When the cpu is idle the cpu runs with its maximum frequency.
> This causes a higher cpu temperature in the idle state. When the cpu is
> now under load the cpu gets with that higher idle temperature now faster
> to its thermal limits.
> An other big problem of the performace govenor is the missing
> thermal throttling. Some tests with cpuburn resulted in a system crash
> when the soc reached its thermal limits since no thermal throttling
> occurred.

This won't change anything with cpuburn. While cpuburn will be
running, ondemand will increase the frequency of the cores to the
maximum frequency, putting yourself in the exact same situation.

The only difference is going to be when you're idle or have a rather
small CPU load. But then, you won't heat much in that case either.

> With this patch we set the default frequency govenor to ondemand mode
> and reduce the temperature when the cpu is idle and activate the thermal
> throtteling.

This patch doesn't activate the thermal throttling.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com

--jrtnuvo447uvbywl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlqKhokACgkQ0rTAlCFN
r3RLww//WX03Qt3eETtgucMLWXAtLn+0wQfrMAHKQylgp1IfQK8h7CTzGN2OjXwo
RDUnXTY0YeF0NI1/s7Bmrf/c4q2in8ODuWIhZRUbNSwg+jQy0rrZ6C7NmrZXQOuz
lBkezs/QD6VGQ+UWs3VdyexAC3gYNRcmrk8v6RrC+hmcY7DZlxo9JU2SPNQ2qo3q
mv4gD9iqtVlUlNoF78Rm+ECkLuI6/hQrCzO97/ozYdo783jWke7tJedbORM26J85
Tnas/hyb0nmQciZYXZ43C/UY6qwmvkswCIYUUVKyVnh4aceSH+KDFTC8Q7jTx26P
eCjlueUrHXLGI4YYb3voHT7faXgDLpZWm3/PacCDfiPgA9JwlkTuSjzOiV/NP3WW
+tlI32OL4q1rBfQwDsI58HzkfAeJ2iC/y0axrLkLaRi7KQ5MNyYo1j7aNglgADEc
79PSOpSohcPcoU6KTOs5nnUoqjiqMNKE1zbZ48O6ewyuU6TAi3d1aYlq56Km0MQI
KYVagpcMvHD5mXK+/vx5TsdOuVazdhFWjQUrj8YGhMI3giIJDO0e7tSD79BzoNEG
J9q80hkUZR79qk4nDB1NDv7HsOFYoOL8+5qkSWJR9aNmG4+fVAexrJVgIPX8Rpn0
uxnB9sIt0dpgVXmIKNIcLCYn5Zwwy+3HCth+WIusGk7cf1m/oxw=
=WDUv
-----END PGP SIGNATURE-----

--jrtnuvo447uvbywl--

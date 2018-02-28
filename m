Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751923AbeB1IcR (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 03:32:17 -0500
Received: from mail.bootlin.com ([62.4.15.54]:53453 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751574AbeB1IcQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 03:32:16 -0500
Date: Wed, 28 Feb 2018 09:32:14 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Samuel Holland <samuel@sholland.org>
Cc: Chen-Yu Tsai <wens@csie.org>, Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Andre Przywara <andre.przywara@arm.com>
Subject: Re: [PATCH 3/3] mailbox: sunxi-msgbox: Add a new mailbox driver
Message-ID: <20180228083214.h4oi2kmjjqmoyfhn@flea>
References: <20180228022714.30068-1-samuel@sholland.org>
 <20180228022714.30068-4-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gqrk32numzck6ahn"
Content-Disposition: inline
In-Reply-To: <20180228022714.30068-4-samuel@sholland.org>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gqrk32numzck6ahn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2018 at 08:27:14PM -0600, Samuel Holland wrote:
> +	/*
> +	 * The failure path should not disable the clock or assert the reset,
> +	 * because the PSCI implementation in firmware relies on this device
> +	 * being functional. Claiming the clock in this driver is required to
> +	 * prevent Linux from turning it off.
> +	 */
> +	ret =3D clk_prepare_enable(clk);
> +	if (ret) {
> +		dev_err(dev, "Failed to enable bus clock: %d\n", ret);
> +		return ret;
> +	}

You don't need it to be always on though. You only need it to be
enabled when you access the registers (on both sides I guess?). So you
could very well enable the clock in your registers accessors in Linux,
and do the same in the ARISC firmware. That should work.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--gqrk32numzck6ahn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlqWaQ0ACgkQ0rTAlCFN
r3SsEA//RHcMOPjqa3tDFiz6Fp3+OnLXWEP1rskJUxy/Xs7B+OxsH4i3UVsrmpC4
mbfEt0ZC4PC/g2iXhzGxxEfJEpXvO8h+kYNG93mZ0qaKybskJ1ngFz+sEenP8Qxg
Ky6jqkhiaI6CGySMh8IPxSSmPEM6RLpYAI/E7QZPQDJBr+Sy7p8f9exLXNLkf36x
l9PYGJ8RK3zxs7egn9Rjdwxif4Yu8nx8iTZUVbA+ox+Zl2PVBxaD1vLRdAxmDRIc
1idGOhDssH1ZsyVrgDRhynAGHfDfQYSDjivHyK8r/sEmsZUScm8FdXYpAErKpcxS
y8sRulCeP7jgwFRWD7qFWPNYCsjua5ra1NXovue9AlioK07Gl1iRQL8umWNM2pWh
LN/GxE5obcr9zhtAaclCNEwYmn9IOvfmnnIPBTFz+RnTq9cin9s1k8lnk68X0SfA
qldGEKt4nvPhcYVPY5s4L3/Maq3ox1He6nKJjt+VrnVsCwmlLqZtbW2AUdPsFILh
dJqGyLngQ0yy7/3aFevf4WWpybhQXfl+GWA9pl/QB0Lmm6N8iverBwmMVxQhgx2T
VxPnOMviLzlzL29d90LZW9+clnqc3oRh0rXuhihtA3nnJvub8ex9QaWXHp2o0kMe
13x7DfWo7k13l99LMz4ulSpLbu98K5KCtTul7hQEbc/a8jDTLTA=
=od8V
-----END PGP SIGNATURE-----

--gqrk32numzck6ahn--

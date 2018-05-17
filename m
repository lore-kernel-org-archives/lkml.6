Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752850AbeEQQo6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 12:44:58 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58872 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752791AbeEQQoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 12:44:55 -0400
Date: Thu, 17 May 2018 13:32:04 +0900
From: Mark Brown <broonie@kernel.org>
To: Douglas Anderson <dianders@chromium.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: core: Quiet -EPROBE_DEFER from
 regulator_bulk_get()
Message-ID: <20180517043204.GA20254@sirena.org.uk>
References: <20180514224027.53748-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline
In-Reply-To: <20180514224027.53748-1-dianders@chromium.org>
X-Cookie: Are you a turtle?
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 14, 2018 at 03:40:27PM -0700, Douglas Anderson wrote:

> The -EPROBE_DEFER virus demands special case code to avoid printing
> error messages when the error is only -EPROBE_DEFER.  Spread the virus
> to a new host: regulator_bulk_get()

There's no requirement to suppress probe deferral messages and doing so
makes it harder to debug problems since things just fail silently.  It's
better to work on making the core smarter about probe ordering, for
example by building out the device dependency infrastructure so that it
can be used to avoid trying to probe things when we know there are
unsatisfied dependencies.

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlr9BcMACgkQJNaLcl1U
h9DsqQf9FxXcZTROQqCtxqnL3OgEqDOYr/ifxJduGFg3+Ltc2uAEwm7Z0wreQYSQ
lOddCjgWpWWytjJwhjYe7c+byTv/c2pWULY1ovs+9ZCDkLq4WeABvIfxW9zlNUdm
tNZ877Sj/iKBApQRoQLDjU13JEVN0rjidFiXEUDu4CpgzfIVWUns+7wTACUUzx1m
SplNfgW1bLdCAAto7kLpPB08J1HAzYaBziEoB6/2V3IZbkj5m5j+pXB5jcjhyejz
b3PRo/vZD3Vpau2KEKmxUQpL2Y018xF2TMQGdQFf988D8srpKIvWk+8JWdgvVKC8
M++6cbKaiUDNfe/0bC0lZQY+eVrdVg==
=mDO+
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--

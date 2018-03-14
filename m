Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751652AbeCNJhV (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 05:37:21 -0400
Received: from mail.bootlin.com ([62.4.15.54]:46368 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751295AbeCNJhT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 05:37:19 -0400
Date: Wed, 14 Mar 2018 10:37:18 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Giulio Benetti <giulio.benetti@micronovasrl.com>
Cc: David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/sun4i: Handle DRM_BUS_FLAG_PIXDATA_*EDGE
Message-ID: <20180314093717.glamqbj2curklztd@flea>
References: <1520963677-124239-1-git-send-email-giulio.benetti@micronovasrl.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4h5ue7ns54l4oqxk"
Content-Disposition: inline
In-Reply-To: <1520963677-124239-1-git-send-email-giulio.benetti@micronovasrl.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4h5ue7ns54l4oqxk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 13, 2018 at 06:54:37PM +0100, Giulio Benetti wrote:
> Handle both positive and negative dclk polarity,
> according to bus_flags, taking care of this:
>=20
> On A20 and similar SoCs, the only way to achieve Positive Edge
> (Rising Edge), is setting dclk clock phase to 2/3(240=B0).
> By default TCON works in Negative Edge(Falling Edge), this is why phase
> is set to 0 in that case.
> Unfortunately there's no way to logically invert dclk through IO_POL
> register.
> The only acceptable way to work, triple checked with scope,
> is using clock phase set to 0=B0 for Negative Edge and set to 240=B0 for
> Positive Edge.
> On A33 and similar SoCs there would be a 90=B0 phase option, but it divid=
es
> also dclk by 2.
> This patch is a way to avoid quirks all around TCON and DOTCLOCK drivers
> for using A33 90=B0 phase divided by 2 and consequently increase code
> complexity.
>=20
> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>

Applied, thanks!
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--4h5ue7ns54l4oqxk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlqo7U0ACgkQ0rTAlCFN
r3QNwRAAjNMJiq7njfEmhIRERvLHNq3qFUGqbl9esEEnqGP/P5OuakeQqprKnSOa
RT8KSsUuyudtwHirvenjgkEzmdXWm6Du5MKwykSnH1WfDnEbKcaI3i2ueMXbNQuh
BBE/zvAgwnVMwn9i2wvkfYtBexilaFADLJtvvr4UpUK7BTcT1E/k0YzxCTXqFIFb
JVRinrFqKhqqGQo/Uny5Hx3TL8p/sjAmpU9sjJL6EL9/dzWuo7vpxMyYslcP8y5P
0E2Ompqlrh02aGZqePqqS1mdiuVzalQui1LKeDeJm4Hg3VEy785YGVoRb5RPqADX
V+BxBDebE/YNAwj8lV7iGiiv1mcoJT0d4fXGkXnq3Qu5SrQo5iz4iu7UCNwcmB1q
tPl3neofmnaGAaXgz16cjN0n9ZycgRNZyf0NcNr059VFhFquiy+VZ6bKIu3na27m
T37FLdOQCfdtEeJo6C8RCQSuinioXrb/AuE1cAZaTABuYk0iE5QWcqtZSNXmHTgE
tiIU2XhacjgdFLVjblBVWGXhAfHMeeMu//vpRhGH+q3krn7lfZLAESqbwtt3vupD
slRUBziRYVILt+fZApKQ79N8FA4RCEihRULSx8X5DVNYqbHaEGXhoLR3gMf3qEEC
Q7TQDfvMhNoJH92hyFaL2MlF+IaE0OOcbv6VrcEeqvEGfQYLHuM=
=F+p/
-----END PGP SIGNATURE-----

--4h5ue7ns54l4oqxk--

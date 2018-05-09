Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934189AbeEIIj2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 04:39:28 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:39288 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934035AbeEIIjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 04:39:25 -0400
Date: Wed, 9 May 2018 17:39:19 +0900
From: Mark Brown <broonie@kernel.org>
To: Jorge Ramirez-Ortiz <jramirez@baylibre.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] regmap: allow volatile register writes with cached only
 read maps
Message-ID: <20180509083919.GU13402@sirena.org.uk>
References: <1525817169-29233-1-git-send-email-jramirez@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+OVWeTxrbAwQuiek"
Content-Disposition: inline
In-Reply-To: <1525817169-29233-1-git-send-email-jramirez@baylibre.com>
X-Cookie: Advancement in position.
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+OVWeTxrbAwQuiek
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 09, 2018 at 12:06:09AM +0200, Jorge Ramirez-Ortiz wrote:
> Regmap only allows volatile access to registers when the client
> supports both reads and writes.
>=20
> This commit bypasses that limitation and enables volatile writes to
> selected registers while maintaining cached accesses on all reads. For
> this, the client does not need to configure the reg_read callback.

I don't understand what voltile access means for write only devices.
Volatile means that we don't read the cache but go direct to the
hardware so if we can't read the hardware that's pretty redundant, a
volatile read that goes to the cache is just a default read.

--+OVWeTxrbAwQuiek
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrys7cACgkQJNaLcl1U
h9AobQf9EBlENS1fT0Wg4oW1Rxs8fVvO+tOXm+xCt7VSxAeLVtTaVzWUKRbK7fVh
XlgOcFlB36w1S+naDAs0yBhtcniGPcXgOCBobPplSthoYgycvqoFLdmDxdAHRQed
cG1PUQJf9iVJy7jhTyJiC2XcmuR21Mm0ooM3baVekXRDlejnmXvlQkA4ov7kkkiu
4Dog73pdpa3SeKWPCNIHlYbwQvJ+YWVvLXvRICVUu5AfxEO+8Vz2wzQ29SZdkSX5
WpqR+mE8h2uUx+BdIb17PC2FSb2bTVwxnpXuRyB9jPD6YVevXgpSE1I1dkwQUyji
XOEyQBNV+ZAUFTrK2jo7EiCJ9GfWPA==
=1fX7
-----END PGP SIGNATURE-----

--+OVWeTxrbAwQuiek--

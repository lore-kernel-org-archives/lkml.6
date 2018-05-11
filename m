Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751959AbeEKCBA (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 22:01:00 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:54182 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750798AbeEKCA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 22:00:58 -0400
Date: Fri, 11 May 2018 11:00:49 +0900
From: Mark Brown <broonie@kernel.org>
To: Jorge Ramirez-Ortiz <jramirez@baylibre.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] regmap: allow volatile register writes with cached only
 read maps
Message-ID: <20180511020049.GD949@sirena.org.uk>
References: <1525817169-29233-1-git-send-email-jramirez@baylibre.com>
 <20180509083919.GU13402@sirena.org.uk>
 <65607fde-d0e9-0f08-3042-f6a58b760896@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XvKFcGCOAo53UbWW"
Content-Disposition: inline
In-Reply-To: <65607fde-d0e9-0f08-3042-f6a58b760896@baylibre.com>
X-Cookie: Falling rock.
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XvKFcGCOAo53UbWW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 09, 2018 at 01:49:21PM +0200, Jorge Ramirez-Ortiz wrote:
> On 05/09/2018 10:39 AM, Mark Brown wrote:

> > I don't understand what voltile access means for write only devices.
> > Volatile means that we don't read the cache but go direct to the
> > hardware so if we can't read the hardware that's pretty redundant, a
> > volatile read that goes to the cache is just a default read.

> 1. only cached reads: (as a consequence every regmap write must succeed).
> 2. cached writes: do not access the hardware unless the value differs from
> what is in the cache already or (3) applies.
> 3. support for selectable volatile writes: those that will always access the
> device no matter what the cache holds.

We don't currently suppress writes except when regmap_update_bits()
notices that the modification was a noop.  You probably want to be using
regmap_write_bits() here instead of regmap_update_bits(), that will
always do the write.

--XvKFcGCOAo53UbWW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlr0+U4ACgkQJNaLcl1U
h9CwWQf/fiJ7F3xxH39O2dSNz/znNZAxwntGVsOp0YzSzKUVdQ7c5WXucyPkOE5I
fyV3k7R0qLDVKgA+hzR17fXnRHDSw2dw6cwT+tSlcbSzbhrRSXqF3PUXI6fMIm05
En8XuisDZnAyT+1dEUr31ufYnn2qKTrmOpO6s+HOJbWVd3vc4jE2SP8tbXO/cQ1k
dCy80ScqmU8dxpm89avEaZiwemDH3a6WSgIL0pvXtz9ksYPFgiYUMg1A8utd3eTQ
LBa/fDoO7JWh4v8s1/lZ8VDoIbiQjNHH3WIGwC/cgh6kMFsZfloa3j3lJ01NgFGr
mpV/iKn9tSZFeu4ss2y3uzefRRCHPg==
=bikF
-----END PGP SIGNATURE-----

--XvKFcGCOAo53UbWW--

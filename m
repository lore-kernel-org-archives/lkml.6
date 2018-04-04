Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751277AbeDDHIV (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 03:08:21 -0400
Received: from mail.bootlin.com ([62.4.15.54]:38295 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751098AbeDDHIT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 03:08:19 -0400
Date: Wed, 4 Apr 2018 09:08:18 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Sergey Suloev <ssuloev@orpaltech.com>
Cc: Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] spi: core: handle timeout error from
 transfer_one()
Message-ID: <20180404070817.6cens44jvlmdaxtm@flea>
References: <20180403152905.1524-1-ssuloev@orpaltech.com>
 <20180403152905.1524-2-ssuloev@orpaltech.com>
 <20180403155224.GA11578@sirena.org.uk>
 <c0476d75-821f-7a0d-3c3f-270304e7b032@orpaltech.com>
 <20180403161824.GB11578@sirena.org.uk>
 <dad0ea81-2dd6-ccc3-a0c9-cf20ff195b7f@orpaltech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jixbiuhukrqgg4cn"
Content-Disposition: inline
In-Reply-To: <dad0ea81-2dd6-ccc3-a0c9-cf20ff195b7f@orpaltech.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jixbiuhukrqgg4cn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 03, 2018 at 07:24:11PM +0300, Sergey Suloev wrote:
> On 04/03/2018 07:18 PM, Mark Brown wrote:
> > On Tue, Apr 03, 2018 at 07:00:55PM +0300, Sergey Suloev wrote:
> > > On 04/03/2018 06:52 PM, Mark Brown wrote:
> > > > On Tue, Apr 03, 2018 at 06:29:00PM +0300, Sergey Suloev wrote:
> > > > > As long as sun4i/sun6i SPI drivers have overriden the default
> > > > > "wait for completion" procedure then we need to properly
> > > > > handle -ETIMEDOUT error from transfer_one().
> > > > Why is this connected to those drivers specifically?
> > > These 2 drivers have their own "waiting" code and not using the code =
=66rom
> > > SPI core.
> > Does this not apply to any other driver - why is this something we only
> > have to do when these drivers do it?  That's what's setting off alarm
> > bells.
>=20
> sun4i/sun6i drivers have let's say "smart" waiting while SPI core uses a
> fixed interval to wait.
>=20
> I can't say for every SPI driver in kernel, that's outside of my area of
> expertise.

I'm not sure what's specific about the sun4i / sun6i case here. Your
patch doesn't have anything to do with the delay before the timeout,
but the fact that we return -ETIMEDOUT in the first place.

And I'm pretty sure that papering over an error returned by a driver
is not the right thing to do.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--jixbiuhukrqgg4cn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlrEeeEACgkQ0rTAlCFN
r3RTyg/+LLCk5LJ18AFnqN1WDMGyPF5NEgPeSYBdWEoBlP79QTs5DKYzgK/CW8/I
t3WkryZBNoBC0jb9NWa+YLjacANk4egs6hK7rY3kjkbIDx7Ni9QlEZpYFll0gZL9
f9mqE++6nIlS3qpFJNU+6g46NghIy0WhB3GhmXyzdb4meFMYo6KjiPLuqRSfjx2N
CpZ0gzRTKPGPLj13q0ZPBqHAID5hhNIDG954rYBOKyZh+ykSG2pIH0Z98DB7XWau
d3jBo50TI7XP3yEe3UkUlIgLa5j9PVIJyiZk9S2fDJqSeA7Oq5YLddkMsJtvsXcO
WXW8lFUrRJLrVmaerz04ga98ad4JO8LiXyXuGGMYoj63dJ++cM7kUjjzGXiMzuBB
jPDcUJaGZRV5mp2CzHpeecCtR0xPm0MquJcQp0tO7THWeSkttuqmb6MkJCMcEx9t
o1NhKwYZc/hyKpFnIYeZRNIobscfouo5t5np7pB1W7N8jSSFCr6Nyiu/XLDHF+h3
VmigIkT7HkkcHyDgItFK5eiw0TY1yGJtq58U6CxsMLdRpyTM7eWCJRY4ofGmncwa
c0d/eZ1QF6PLIlNCNxJMYSXa1iglLeXOuPUxj+fYzZPR7eiSXUFlwqAwFP21u2WD
nGGSG8ySISUT/v8j9hrzPG0CKk5Lmo3mDZi72iVAHIDPdBoUyMM=
=ZjNx
-----END PGP SIGNATURE-----

--jixbiuhukrqgg4cn--

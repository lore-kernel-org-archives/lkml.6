Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752849AbeDLQNe (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 12:13:34 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56382 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752406AbeDLQNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 12:13:32 -0400
Date: Thu, 12 Apr 2018 17:13:23 +0100
From: Mark Brown <broonie@kernel.org>
To: Sean Wang <sean.wang@mediatek.com>
Cc: matthias.bgg@gmail.com, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: mediatek: remove redundant MODULE_ALIAS entries
Message-ID: <20180412161323.GH9929@sirena.org.uk>
References: <58fc8553bdc3cbad8d107a905947b7e4d9c12b92.1522054975.git.sean.wang@mediatek.com>
 <20180328021416.GK29239@sirena.org.uk>
 <1522206543.18424.23.camel@mtkswgap22>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Bg2esWel0ueIH/G/"
Content-Disposition: inline
In-Reply-To: <1522206543.18424.23.camel@mtkswgap22>
X-Cookie: The coast was clear.
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Bg2esWel0ueIH/G/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 28, 2018 at 11:09:03AM +0800, Sean Wang wrote:
> On Wed, 2018-03-28 at 10:14 +0800, Mark Brown wrote:
> > On Mon, Mar 26, 2018 at 06:04:18PM +0800, sean.wang@mediatek.com wrote:
> > > From: Sean Wang <sean.wang@mediatek.com>

> > > MODULE_ALIAS exports information to allow the module to be auto-loade=
d at
> > > boot for the drivers registered using legacy platform registration.

> > > However, currently the driver is always used by DT-only platform,
> > > MODULE_ALIAS is redundant and should be removed properly.

> > There is no meaningful cost to having the alias there, why remove it?

> It's no explicitly improved to the driver, it only takes less bytes
> in .secion modinfo from 644 bytes to 620 bytes in the observation with
> objdump.

OK, that's a *very* small saving though especially given the block sizes
that filesystems tend to use.

> More importantly, it seems the driver should probably refer to another
> qualified driver at the initial development, but MODULE_ALIAS is
> forgetting to be removed to meet real usage for the module autoload.=20

I can't parse the above, sorry.

> Even I was curious whether people for the driver know the actual purpose
> the macro it's for.

> Removing MODULE_ALIAS is just to correct the driver to where it should
> be.

To me it's the other way around - ideally platform drivers should
remember to set up the MODULE_ALIAS, just as a joining the dots thing to
make sure that things that work when the driver is built in work when
built as a module.

--Bg2esWel0ueIH/G/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrPhaIACgkQJNaLcl1U
h9DMHwgAhd0vlEUQgTNCsJBgH2eZIifafg8x1AQmq/ics42nbhuEEHZ3M0F1uhsc
2LX8cjgZhy5umaTVgXQxxRwgVWXdIq1SnGqWmxEpLkym9cOwNrMxEFMk7qJIARFB
5Pmb04alsMWu16lYGv6KSPpVRIiFV6V+UlTm1BBX/huP4rlOYVEv3WaoXWRMB8vG
1kltkzZh7AEzyp0l5BUvZD3vFl9M5PMnj/MEb1FCoTjOOg6DK5y87mO2bsAvYhol
LNjIn7Z3szdcVWT8zDW0vFwkVe1WwTFerAJsZg4wI8LuliIHpnq/DPMTERQmvuTC
kNzQvILli2+HDInE/yUy0uFp5qbNCA==
=S7Iz
-----END PGP SIGNATURE-----

--Bg2esWel0ueIH/G/--

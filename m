Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935034AbeCHLZn (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 06:25:43 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:60316 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750966AbeCHLZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 06:25:40 -0500
Date: Thu, 8 Mar 2018 11:25:28 +0000
From: Mark Brown <broonie@kernel.org>
To: Lee Jones <lee.jones@linaro.org>
Cc: Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Tony Lindgren <tony@atomide.com>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCHv5 3/5] mfd: motorola-cpcap: Add audio-codec support
Message-ID: <20180308112528.GC6019@sirena.org.uk>
References: <20180223200254.25685-1-sebastian.reichel@collabora.co.uk>
 <20180223200254.25685-4-sebastian.reichel@collabora.co.uk>
 <20180307163211.rytfli5tb47yhtug@dell>
 <20180308094652.qg4atjw5c3hayaz3@earth.universe>
 <20180308095315.mpcmx2ob6yhsnrm6@dell>
 <20180308102757.jyi7uo566n6nuct5@earth.universe>
 <20180308104831.fflq2arj5dxgntia@dell>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0vzXIDBeUiKkjNJl"
Content-Disposition: inline
In-Reply-To: <20180308104831.fflq2arj5dxgntia@dell>
X-Cookie: Given my druthers, I'd druther not.
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0vzXIDBeUiKkjNJl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 08, 2018 at 10:48:31AM +0000, Lee Jones wrote:
> On Thu, 08 Mar 2018, Sebastian Reichel wrote:

> > I had it in PATCHv1-PATCHv4. It was removed, since Mark didn't want
> > to have it in the DT ABI.

> Right, but why?  Is it not a hardware device?  I think converting from
> devm_of_platform_populate() for one sub-device is a bit drastic.

It's not a separate physical device or IP and doesn't exist outside of
the MFD, it's just how Linux is currently choosing to divide up the chip
right now but that's totally open to change even in future versions of
Linux.  Clocks are a big issue with audio stuff, right now sections of
the clock tree get handled in the CODEC driver but we're going to want
to push them out to a clock driver so we're not reimplementing handling
for clocks.

--0vzXIDBeUiKkjNJl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqhHacACgkQJNaLcl1U
h9DETQf/QrTCO70nd6nwMsr13HX5SYWEaNAyWx8yHUHtSH0zKyR5fF5Csf/EcYaI
kaOQbe+fe9keFmT5nD0eZfBLfUyZ6qG1TtR0/nmQpi4BtW3war9/za9dvozmRqSk
Vani9yJlf0P1SgziEKPETn5hNXDG/GJD9qGlVoowZuzWY22F+nqxPb9A9d5lYMxG
3SpxrgfEPG7ymXTgvkkGNURbhoKw0JQ9JLpJNLM3PRD3VykNFv6FKrQOu4edHKL2
BNzfTIWDO9tU85UnZoyelnE9t6D0+PJN+AptOuyZulU1trdSj31Zb33IVwZorKLn
noxhrkV4JK4XZbuFIhSzfQKC66nv3A==
=T9Ey
-----END PGP SIGNATURE-----

--0vzXIDBeUiKkjNJl--

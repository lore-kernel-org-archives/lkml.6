Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752459AbeC1C32 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 22:29:28 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35286 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752319AbeC1C3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 22:29:25 -0400
Date: Wed, 28 Mar 2018 10:29:10 +0800
From: Mark Brown <broonie@kernel.org>
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Pavel Machek <pavel@ucw.cz>, Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>,
        Lee Jones <lee.jones@linaro.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: omap4-droid4: voice call support was Re: [PATCHv5,5/5] ARM: dts:
 omap4-droid4: add soundcard
Message-ID: <20180328022910.GM29239@sirena.org.uk>
References: <20180223200254.25685-6-sebastian.reichel@collabora.co.uk>
 <20180322204804.GA26871@amd>
 <20180322234832.o24ut5ahon46mdu4@earth.universe>
 <20180323100930.GA21644@amd>
 <20180323103006.alymgb3ywftb4gek@earth.universe>
 <20180326141638.GB1450@amd>
 <20180326155828.ttnduivadob4iqmd@earth.universe>
 <20180327121441.GH29239@sirena.org.uk>
 <20180327222237.wcx2aqznvdrvbaa5@earth.universe>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cN0A5YokcrYPGsSB"
Content-Disposition: inline
In-Reply-To: <20180327222237.wcx2aqznvdrvbaa5@earth.universe>
X-Cookie: Serenity through viciousness.
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cN0A5YokcrYPGsSB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 28, 2018 at 12:22:37AM +0200, Sebastian Reichel wrote:
> On Tue, Mar 27, 2018 at 08:14:41PM +0800, Mark Brown wrote:

> > No, this is exactly the sort of use case with multiple DAIs that the
> > graph card is intended to enable over the old simple-card.

> +----------+         +-------------+
> | OMAP4    |         | CPCAP       |
> |          |         |             |
> | [McBSP2] | <-----> | [HiFi DAI]  |
> |          |         |             |
> | [McBSP3] | <--+--> | [Voice DAI] |
> |          |    |    |             |
> +----------+    |    +-------------+
>                 |
> +----------+    |    +-------------+
> | MDM6600  |    |    | WL1285      |
> |          |    |    |             |
> |    [DAI] | <--+--> | [DAI]       |
> |          |         |             |
> +----------+         +-------------+

> Legend:
>     OMAP4   = SoC running Linux
>     CPCAP   = Audio codec
>     MDM6600 = Baseband
>     WL1285  = Bluetooth

> Re-reading the audio-graph-card binding document I still don't see
> how the network (OMAP.McBSP3, CPCAP.Voice, MDM6600, WL1285) is
> supposed to look like. It seems to expect point-to-point DAI
> connections.

Ugh, a TDM mux?  That's really unusual and not particularly supported
yet, you'd need to extend the graph card to do it.  It's where things
should end up for a generic card though.

--cN0A5YokcrYPGsSB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlq6/fUACgkQJNaLcl1U
h9C0Wgf/chTotUC9eLSM2kefgGQKyFJjAxPUYX/mQsycb5qlOcipCSSMxMLKhhNV
rOjGxqyWQVIdk9NloSxrpcmDcwiiAswI6pHyM/NCHPIUVbQTh8iAyH54BQUzxQHE
hS9odp7qwgzlnOB3cDglUI//3jBGVDqGUaR2rkmyXbY3OnpBLdBioFXItcGLFV87
Ra/Ix2Gbz5qHTUMxq8fm+yyfavLEOjQ/fTxLiRII177HtFf1SsCoQ5XzwNyxjfAP
gtVheyEHVdcWrMfuxKw3/49zM0jRrqrZwQvNoDGwCRYjX0jZs5BusGwW06h1tUij
gNx2sJSLZX9lrLs9l5P0E2DH8/R4ug==
=+2O+
-----END PGP SIGNATURE-----

--cN0A5YokcrYPGsSB--

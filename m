Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752214AbeDRRBd (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 13:01:33 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:39118 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751830AbeDRRBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 13:01:32 -0400
Date: Wed, 18 Apr 2018 18:00:54 +0100
From: Mark Brown <broonie@kernel.org>
To: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Akshu Agrawal <akshu.agrawal@amd.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        Markus Elfring <elfring@users.sourceforge.net>,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        "moderated list:SOUND" <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] ASoC: dwc: I2S Controller instance param added
Message-ID: <20180418170054.GK10061@sirena.org.uk>
References: <1524049494-19526-1-git-send-email-Vijendar.Mukunda@amd.com>
 <1524049494-19526-2-git-send-email-Vijendar.Mukunda@amd.com>
 <20180418112442.GB10061@sirena.org.uk>
 <a6a4cf79-b7f7-a565-28a8-6205f8d13936@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mGCtrYeZ202LI9ZG"
Content-Disposition: inline
In-Reply-To: <a6a4cf79-b7f7-a565-28a8-6205f8d13936@amd.com>
X-Cookie: Sank heaven for leetle curls.
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mGCtrYeZ202LI9ZG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 18, 2018 at 06:18:44PM +0530, Mukunda,Vijendar wrote:
> On Wednesday 18 April 2018 04:54 PM, Mark Brown wrote:
> > On Wed, Apr 18, 2018 at 04:34:52PM +0530, Vijendar Mukunda wrote:

> > > When multiple I2S controller instances created,
> > > i2s_instance parameter refers to i2s controller instance value.

> > You're missing the point here a bit - it's not just the defines for the
> > magic numbers that are the problem, it's the whole idea of passing
> > instance numbers around like this that's the big problem.  Whatever you

> In Audio Coprocessor (ACP), There are three I2S controllers can be
> configured/enabled.(I2S SP, I2S MICSP, BT I2S)
> Default enabled I2S controller instance is I2S SP instance.
> There is a requirement to enable BT I2S controller Instance along with
> I2S SP controller instance in one of our platforms Which has multiple codecs
> connected to each instance.

Describing how the system is wired up is the function of the machine
driver.  The individual drivers should just take configuration from the
machine driver.

> We have added one more parameter i2s instance to dwc platform data.
> So that AMDGPU ACP Driver will pass I2S controller instance value to dwc
> driver while creating device nodes for I2S Controllers.

This is not the way to do this - you can already get the struct device
for all the children from when they were instantiated, you should be
able to use this to reference them so you can bind the machine driver.
There's facilities for doing this (mostly serializing into dev_name() as
this was mostly used by board file based machines) which are already
used, if there's problems we should extend those rather than hacking
things into every single driver.

--mGCtrYeZ202LI9ZG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrXecUACgkQJNaLcl1U
h9B7EAf9FyPEUPnvk+z/hoE/cB2jaQS6z6AsXLbzGgHEDoPPqUm5MAUT4m+Vqvj0
1AM9N3sPC7jaH4jefZ3n0nNTC5w/Zgro6i+w4KrDBb78x/sc4OIc/1GiJeFw28jy
f/YJXmUwT239D3uQZJ4D4BhCc9iuOvyoLW/cqwqJTaENGUE9TvV7o/5dBk6+DlGH
M7neQVaW/M8/4QiiYQ8pkU+4eVxy4dpf3GERRY5HWBpOJsXuph8bIYsFxjqSsyNg
B0dbihDYZ/EHQTMQRgAZUvrVhKumyrA+4GZ++Ea0JFOr3NJbD0C31fXG1ua56Vvy
a0HAALsXqDf79SSH//pAQ4GpgalFag==
=iDzI
-----END PGP SIGNATURE-----

--mGCtrYeZ202LI9ZG--

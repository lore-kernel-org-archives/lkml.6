Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751962AbeECBjf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 21:39:35 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50594 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751837AbeECBjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 21:39:33 -0400
Date: Thu, 3 May 2018 10:39:19 +0900
From: Mark Brown <broonie@kernel.org>
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: Akshu Agrawal <akshu.agrawal@amd.com>,
        "djkurtz@chromium.org" <djkurtz@chromium.org>,
        "Alexander.Deucher@amd.com" <Alexander.Deucher@amd.com>,
        Support Opensource <Support.Opensource@diasemi.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "moderated list:SOUND" <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] ASoC: da7219: read fmw property to get mclk for
 non-dts systems
Message-ID: <20180503013919.GN2714@sirena.org.uk>
References: <1525080203-18947-1-git-send-email-akshu.agrawal@amd.com>
 <2E89032DDAA8B9408CB92943514A0337014C1E93BC@SW-EX-MBX01.diasemi.com>
 <20180501205006.GE2714@sirena.org.uk>
 <2E89032DDAA8B9408CB92943514A0337014C1E9782@SW-EX-MBX01.diasemi.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MSd2ShuMixI0uVaZ"
Content-Disposition: inline
In-Reply-To: <2E89032DDAA8B9408CB92943514A0337014C1E9782@SW-EX-MBX01.diasemi.com>
X-Cookie: Rubber bands have snappy endings!
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MSd2ShuMixI0uVaZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 02, 2018 at 10:13:55AM +0000, Adam Thomson wrote:
> On 01 May 2018 21:50, Mark Brown wrote:

> > There's a lot of things that ACPI *should* do but doesn't - it's a bit
> > of a shambles how ACPI standards get defined and what's there is not
> > really intended to handle systems like these semi-embedded ones.  One of
> > the big gaps in ACPI is that it has no handling at all of clocks, that's
> > supposed to be done transparently by firmware in the ACPI model.  What a
> > lot of the embedded Intel people have been doing is coopting the DT
> > bindings wholesale for ACPI systems but that has problems when you get
> > into areas which should be handled in some way on ACPI systems like
> > power and unfortunately clocks are kind of power adjacent so might be a
> > bit sketchy here.

> Yes I was aware that previously that was the case, although have not followed
> this for a while. It just feels here that we should aim for something more
> generic rather than a device specific property/binding, if possible, as that
> feels messy to me and I'm sure other drivers could take advantage of this as
> well. I've not looked at the clock code in too much detail though, at least with
> regards to this area, so not sure how feasible that is.

> As a suggestion for ACPI would it be possible to re-use the 'clock-names'
> property and add something in the framework to handle this?

I completely agree that ACPI should have handling for clocks but it
really feels like something that should be done as a proper spec rather
than just ad hoc by Linux like the x86 embedded people often do - it's
too close to the power management stuff that ACPI definitely does
handle.

--MSd2ShuMixI0uVaZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrqaEYACgkQJNaLcl1U
h9DjEwf/akcOq3FX7OJHawOodNuod6nfkVvTE5kWue1W5AVdzCXlsTknOiOkIn1z
pEPHEJ1G56wzcFt4ezga+5DkIYnB1RNzxCdC0noLuFEQNSegwJ7oskOQUaAwRTgd
2FlNUEi2pmEpP7A4bU6EonrIkhrC1zN5MHgmh4VjfBXpbVKEPvbxeTMDr1X8b2I2
sXXGMNDAn76mlG0xiEskLThHEpqyAFbxjBQIIBGmbgpjRIJJWg87WXT/0aLTBAEn
WzUK8iaNFiPeIqYNFH3drHquTqSHwZyXdhZwifT6m2hpK+UfHXTcEQNtf+6jbkEF
D1KA6ISg0/rcMVBzr40DQpx1qvCunA==
=nEHY
-----END PGP SIGNATURE-----

--MSd2ShuMixI0uVaZ--

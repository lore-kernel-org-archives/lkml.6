Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033369AbeCARRt (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 12:17:49 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57404 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032942AbeCARRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 12:17:47 -0500
Date: Thu, 1 Mar 2018 17:17:44 +0000
From: Mark Brown <broonie@kernel.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/9] ASoC: Intel: bytcr_rt5640: Drop unwanted
 ignore_suspend settings
Message-ID: <20180301171744.GE12864@sirena.org.uk>
References: <20180218220146.22485-1-hdegoede@redhat.com>
 <20180218220146.22485-9-hdegoede@redhat.com>
 <20180301162215.GC12864@sirena.org.uk>
 <55819630-6198-6227-63ef-69311b21b255@redhat.com>
 <20180301164819.GD12864@sirena.org.uk>
 <2aa03d98-7f61-0699-98d6-ac3ca3497c41@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pY3vCvL1qV+PayAL"
Content-Disposition: inline
In-Reply-To: <2aa03d98-7f61-0699-98d6-ac3ca3497c41@redhat.com>
X-Cookie: Real Users hate Real Programmers.
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pY3vCvL1qV+PayAL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 01, 2018 at 05:58:35PM +0100, Hans de Goede wrote:
> On 01-03-18 17:48, Mark Brown wrote:

> > That sounds like what's missing is hookup of whatever the DSP uses to
> > wake the system when it's getting to the bottom of the buffer?  That's
> > the normal way this stuff is implemented anyway.

> I'm afraid there is a lot more missing, at least from a standard Linux
> distro pov, just waking up is not enough, we need to also wakeup
> userspace to get the mp3-player (or whatever) to refill the buffer,
> but preferably without waking up the GPU, turning on the screen, etc.

> AFAIK support for this is currently completely missing, standard Linux
> userspace currently treats suspend-2-idle as a a full suspend and any
> wakeup as a full wakeup.

Sure, but do such userspaces exist - ChromeOS or something for example?

> So AFAICT currently the ignore-suspend flag is currently not useful
> and as the commit message mentions IIRC there were added to fix some
> issues with suspend/resume in the past.

Is it possible the issue was playback during suspend?

--pY3vCvL1qV+PayAL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqYNbcACgkQJNaLcl1U
h9DTygf/S3RtA9cznPWvGyDZqPW9Kh59QKnr01zWpfDaviHiRXqkJvuYxwUCcUJC
XV1dKSaC07XrEaCsb/zfRiMguUZPqknskx434j0JnwwRkOzbVVD7zoAVEq5U6Ayt
kzINfuwTO7O2eCmllR8SGE7qrHRfHx1QOQ/LsiRU0OfzoNcSAvnx/5q3setwniNi
ZeEVXT6nokHpyl5jQ2jdQ3iyNdp4NcaPfi7Fks+AO9YFxI+E+kniqwnViZrgNzI5
YO/3PXcHVCJS+GZ/f3O+UssI4DA1Df2WLeooB65eLMX9q5uvzABRuiJAQTvD+8RE
jZYPqqsPG8S0OHGzUHg9pCFFE2aPtQ==
=j7E9
-----END PGP SIGNATURE-----

--pY3vCvL1qV+PayAL--

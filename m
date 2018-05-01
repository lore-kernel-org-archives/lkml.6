Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751426AbeEAUuV (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 16:50:21 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:47004 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750766AbeEAUuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 16:50:20 -0400
Date: Wed, 2 May 2018 05:50:06 +0900
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
Message-ID: <20180501205006.GE2714@sirena.org.uk>
References: <1525080203-18947-1-git-send-email-akshu.agrawal@amd.com>
 <2E89032DDAA8B9408CB92943514A0337014C1E93BC@SW-EX-MBX01.diasemi.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ffoCPvUAPMgSXi6H"
Content-Disposition: inline
In-Reply-To: <2E89032DDAA8B9408CB92943514A0337014C1E93BC@SW-EX-MBX01.diasemi.com>
X-Cookie: Rubber bands have snappy endings!
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ffoCPvUAPMgSXi6H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 30, 2018 at 07:05:19PM +0000, Adam Thomson wrote:

> There is already a means via DT to specify the MCLK for a device using the
> generic clock DT bindings, and this driver already uses that. Should ACPI not
> have something similar to that which is generic, rather than adding device
> specific bindings/properties to achieve the same? There will be other drivers
> that will want to do the same.

There's a lot of things that ACPI *should* do but doesn't - it's a bit
of a shambles how ACPI standards get defined and what's there is not
really intended to handle systems like these semi-embedded ones.  One of
the big gaps in ACPI is that it has no handling at all of clocks, that's
supposed to be done transparently by firmware in the ACPI model.  What a
lot of the embedded Intel people have been doing is coopting the DT
bindings wholesale for ACPI systems but that has problems when you get
into areas which should be handled in some way on ACPI systems like
power and unfortunately clocks are kind of power adjacent so might be a
bit sketchy here.

--ffoCPvUAPMgSXi6H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlro0vwACgkQJNaLcl1U
h9CnAAf/VwTBy/ZB+foJzxfOU8xVz87nhic1tcWLDgNCiii2I9Cfik/BYvRa3iNF
MG2RsXxnHFmJEWt2bJMfCSpL8jPoc3zDpvm8vCVx3RHVHHJDzeD9Ju4YVIXf0Rzl
0YSW3hPQ9Kh5XiEl5bP35mRrzKKR0j2BJry7zKyvz79qKfg62NZFCfoEkUT622Ei
kK1DPkVo0laMTyRvx0U+s6U22tPPSQOetx9Gnajs3WGSbdg0Em2TQB6lp4WPG1U1
UT1EgDl8OQZ+jb2BPQXyIGsTd94k54JcrMhNrf3J+LyApPVr6XkJM8cNA2+OlPTd
vfR510l747ogAeMpE8LoyT3D0euZYA==
=Et4f
-----END PGP SIGNATURE-----

--ffoCPvUAPMgSXi6H--

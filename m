Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757109AbeEJLhx (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 07:37:53 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:58447 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756824AbeEJLhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 07:37:51 -0400
Date: Thu, 10 May 2018 13:37:49 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc: Baolin Wang <baolin.wang@linaro.org>, robh+dt@kernel.org,
        mark.rutland@arm.com, xiaotong.lu@spreadtrum.com, broonie@kernel.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] leds: Add Spreadtrum SC27xx breathing light
 controller driver
Message-ID: <20180510113749.GG6977@amd>
References: <f393ca5a99059e7086307b99fc435777fe09018b.1525757122.git.baolin.wang@linaro.org>
 <9a2a07b8eb313ae3ba64af911337ee7ff7c9ad43.1525757122.git.baolin.wang@linaro.org>
 <20180509142539.GB25131@amd>
 <bddc1f89-8c2c-ba6e-3c7e-d89710ed5424@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="p7qwJlK53pWzbayA"
Content-Disposition: inline
In-Reply-To: <bddc1f89-8c2c-ba6e-3c7e-d89710ed5424@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--p7qwJlK53pWzbayA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >>This patch adds Spreadtrum SC27xx PMIC series breathing light controller
> >>driver, which can support 3 LEDs. Each LED can work at normal PWM mode
> >>and breathing mode.
> >>
> >>diff --git a/Documentation/ABI/testing/sysfs-class-led-driver-sc27xx b/=
Documentation/ABI/testing/sysfs-class-led-driver-sc27xx
> >>new file mode 100644
> >>index 0000000..22166fb
> >>--- /dev/null
> >>+++ b/Documentation/ABI/testing/sysfs-class-led-driver-sc27xx
> >>@@ -0,0 +1,19 @@
> >>+What:		/sys/class/leds/<led>/rise_time
> >>+What:		/sys/class/leds/<led>/high_time
> >>+What:		/sys/class/leds/<led>/fall_time
> >>+What:		/sys/class/leds/<led>/low_time
> >>+Date:		May 2018
> >>+KernelVersion:	4.18
> >>+Contact:	Xiaotong Lu <xiaotong.lu@spreadtrum.com>
> >>+Description:
> >>+		Set the pattern generator rise, high, fall and low
> >>+		times (0..63). It's unit is 0.125s, it should be > 0.
> >>+
> >>+		1 - 125 ms
> >>+		2 - 250 ms
> >>+		3 - 375 ms
> >>+		...
> >>+		...
> >>+		...
> >>+		62 - 7.75 s
> >>+		63 - 7.875 s
> >
> >How does this interact with triggers? With manually setting
> >brightness? Are the pattern generators independend for the LEDs?
> >
> >Can you generate white breathing pattern? If so, how?
> >
> >How do you select between normal and breathing modes?
> >
> >I'd specify times in miliseconds or something, this is way too
> >hardware specific.
>=20
> Agreed.
>=20
> >Now... functionality like this is common between many LED
> >controllers. N900 could do this kind of "breathing", too, and it also
> >supports other patterns.
> >
> >I believe we need interface common between different LED controllers.
> >
> >And I guess it would be easiest if you dropped this part from initial
> >merge.
>=20
> I disagree here. We already had the same discussion at the occasion
> of the patch [0] and it turned out to be a dead-end [1]. Now we have
> neither the driver nor the generic pattern interface.
>=20
> We also already have some older LED class drivers that implement custom
> pattern interfaces (e.g. drivers/leds/leds-lm3533.c) and the same
> approach can be applied in this case.

Please don't. It was mistake to implement custom pattern interfaces
back then, it is still mistake now.
=20
If we really need solution now, I'd recommend "pattern" file with

"<delta time> <brightness> <delta time> <brightness>".

In this specific case, hardware only supports patterns in this format:

low_time 0 rise_time 255 high_time 255 fall_time 0

so driver would simply -EINVAL on anything else.

Best regards,

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--p7qwJlK53pWzbayA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlr0Lw0ACgkQMOfwapXb+vIRVACgwnjEX9KbjsguxrZHENVrg85k
DzEAoLHGFNDSqR/bS/Z/JhEioFUQBHOn
=v++i
-----END PGP SIGNATURE-----

--p7qwJlK53pWzbayA--

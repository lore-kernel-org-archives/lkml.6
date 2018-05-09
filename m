Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935065AbeEIOZn (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 10:25:43 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:58161 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933887AbeEIOZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 10:25:41 -0400
Date: Wed, 9 May 2018 16:25:39 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Baolin Wang <baolin.wang@linaro.org>
Cc: jacek.anaszewski@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        xiaotong.lu@spreadtrum.com, broonie@kernel.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] leds: Add Spreadtrum SC27xx breathing light
 controller driver
Message-ID: <20180509142539.GB25131@amd>
References: <f393ca5a99059e7086307b99fc435777fe09018b.1525757122.git.baolin.wang@linaro.org>
 <9a2a07b8eb313ae3ba64af911337ee7ff7c9ad43.1525757122.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="JP+T4n/bALQSJXh8"
Content-Disposition: inline
In-Reply-To: <9a2a07b8eb313ae3ba64af911337ee7ff7c9ad43.1525757122.git.baolin.wang@linaro.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--JP+T4n/bALQSJXh8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2018-05-08 13:39:45, Baolin Wang wrote:
> From: Xiaotong Lu <xiaotong.lu@spreadtrum.com>
>=20
> This patch adds Spreadtrum SC27xx PMIC series breathing light controller
> driver, which can support 3 LEDs. Each LED can work at normal PWM mode
> and breathing mode.
>=20
> diff --git a/Documentation/ABI/testing/sysfs-class-led-driver-sc27xx b/Do=
cumentation/ABI/testing/sysfs-class-led-driver-sc27xx
> new file mode 100644
> index 0000000..22166fb
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-class-led-driver-sc27xx
> @@ -0,0 +1,19 @@
> +What:		/sys/class/leds/<led>/rise_time
> +What:		/sys/class/leds/<led>/high_time
> +What:		/sys/class/leds/<led>/fall_time
> +What:		/sys/class/leds/<led>/low_time
> +Date:		May 2018
> +KernelVersion:	4.18
> +Contact:	Xiaotong Lu <xiaotong.lu@spreadtrum.com>
> +Description:
> +		Set the pattern generator rise, high, fall and low
> +		times (0..63). It's unit is 0.125s, it should be > 0.
> +
> +		1 - 125 ms
> +		2 - 250 ms
> +		3 - 375 ms
> +		...
> +		...
> +		...
> +		62 - 7.75 s
> +		63 - 7.875 s

How does this interact with triggers? With manually setting
brightness? Are the pattern generators independend for the LEDs?

Can you generate white breathing pattern? If so, how?

How do you select between normal and breathing modes?

I'd specify times in miliseconds or something, this is way too
hardware specific.

Now... functionality like this is common between many LED
controllers. N900 could do this kind of "breathing", too, and it also
supports other patterns.

I believe we need interface common between different LED controllers.

And I guess it would be easiest if you dropped this part from initial
merge.

Thanks and best regards,

								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--JP+T4n/bALQSJXh8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrzBOMACgkQMOfwapXb+vJ6AgCgntQ+iS7NFuZ6HniFO9sNh7eS
gyYAoJvq31PEZSnLU83UWVqOv700hzMp
=dNHU
-----END PGP SIGNATURE-----

--JP+T4n/bALQSJXh8--

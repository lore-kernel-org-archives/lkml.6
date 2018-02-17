Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751489AbeBQVTI (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 16:19:08 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:57931 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751262AbeBQVTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 16:19:06 -0500
Date: Sat, 17 Feb 2018 22:19:14 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Peter Hutterer <peter.hutterer@who-t.net>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>,
        Bastien Nocera <hadess@hadess.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
        Chuck Ebbert <cebbert.lkml@gmail.com>,
        Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] input: Add disable sysfs entry for every input device
Message-ID: <20180217211914.GB9640@amd>
References: <1482660296-8432-1-git-send-email-pali.rohar@gmail.com>
 <1483370825.2420.8.camel@hadess.net>
 <201701021809.58943@pali>
 <1483442481.2420.12.camel@hadess.net>
 <60c21c4d-bb81-342a-45e1-7e92313e05d7@gmail.com>
 <1483540655.2420.18.camel@hadess.net>
 <20180102215437.i3x2j6jvxtac4ntt@pali>
 <1514944049.2523.28.camel@hadess.net>
 <20180103093133.u7wszegjk2msxryl@pali>
 <20180109020424.GC29886@jelly>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ZfOjI3PrQbgiZnxM"
Content-Disposition: inline
In-Reply-To: <20180109020424.GC29886@jelly>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZfOjI3PrQbgiZnxM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > > So, do you mean to implement this "disable" action as ioctl for
> > > > particular /dev/input/event* device (instead of sysfs entry)?
> > >=20
> > > Yes, so the device can be powered down without the device node being
> > > closed and made unavailable. I don't know whether that's something
> > > that's already possible for all cases, but there's already
> > > opportunistic in a lot of drivers and subsystems.
> > >=20
> > > This opens up a whole new wave of potential problems, but it's a more
> > > generally useful mechanism, I would think.
> >=20
> > Ok. How should API for this ioctl looks like? And do you have an idea
> > for name of that ioctl?
> >=20
> > Dmitry, what do you think about it? It is acceptable for you?
>=20
> first: sysfs files are pretty terrible because writing to them requires r=
oot
> and we don't have the benefit of logind. so for any sysfs toggle expect
> a nicely integrated userspace solution to be less than optimal.

Well, you can chmod / chown sysfs files.

> besides: 99% of the above is figuring out the policy *when* to disable the
> device. disabling it is trivial by just closing the evdev nodes and tbh I
> don't think we (in userspace) should care about whether the device is
> powered down or now, it should be the default assumption that it is power=
ed
> down when not in use.
>=20
> for the cases where you must keep the device open but you don't want even=
ts,=20
> EVIOCSMASK is likely the best solution. improving the kernel so it powers
> down the device when the mask excludes all events (and there are no other
> listeners) could be an interesting task.

But yes, that sounds like an idea.

BTW in the meantime, someone added this to pmos wiki... this should
solve some of my problems.

Best regards,
								Pavel



FILE=3D~/.screenoff
if [ -f $FILE ]; then
 xinput set-prop 8 "Device Enabled" 1
 xinput set-prop 6 "Device Enabled" 1
 xinput set-prop 9 "Device Enabled" 1
 xset dpms force on
 rm ~/.screenoff
else
 xinput set-prop 8 "Device Enabled" 0
 xinput set-prop 6 "Device Enabled" 0
 xinput set-prop 9 "Device Enabled" 0
 xset dpms force off
 touch ~/.screenoff
fi
				=09

   =20
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--ZfOjI3PrQbgiZnxM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlqInFIACgkQMOfwapXb+vL/awCfZnFF2Msqonv7wV4aJYaJaADM
jfUAnilWGYTRsXLO3vwGbdY4aUW3uUw4
=JgLb
-----END PGP SIGNATURE-----

--ZfOjI3PrQbgiZnxM--

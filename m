Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752354AbeCCUpP (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Mar 2018 15:45:15 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:53665 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752175AbeCCUpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Mar 2018 15:45:14 -0500
Date: Sat, 3 Mar 2018 21:45:12 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Andrew Worsley <amworsley@gmail.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux-pm mailing list <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, 844788@bugs.debian.org
Subject: Re: 4.16-rc3 fails to resume on MacBookPro10,1 -
Message-ID: <20180303204512.GA9259@amd>
References: <CA+Y=x3=U_zheHBxeNSzL9nSdXOZB7rs-JDNr36323uJ9Uhx0Hg@mail.gmail.com>
 <CA+Y=x3=+kPXJRNYo91i4yJiqqVHDsMhn2pAwkmAH2LV3usd7Hg@mail.gmail.com>
 <20180303092417.GA30917@amd>
 <CAJZ5v0iVmE0jwRW1f6hnohSVzKsZbLr0axi+VKoR+FQcHM+_7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="IJpNTDwzlM2Ie8A6"
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iVmE0jwRW1f6hnohSVzKsZbLr0axi+VKoR+FQcHM+_7w@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat 2018-03-03 11:00:28, Rafael J. Wysocki wrote:
> On Sat, Mar 3, 2018 at 10:24 AM, Pavel Machek <pavel@ucw.cz> wrote:
> > Hi!
> >
> > On Sat 2018-03-03 17:27:36, Andrew Worsley wrote:
> >> On 3 March 2018 at 16:41, Andrew Worsley <amworsley@gmail.com> wrote:
> >> > Basically hangs on resuming after decompressing. The last statement
> >> > displayed is "resume: Image successfully loaded"
> >> >  - I attach a photo as I can't get access to it
> >> ....
> >> > Bug https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D844788
> >> >
> >> > I couldn't get anything from the function keys with this latest kern=
el.
> >> ...
> >>
> >> By plugging in a USB keyboard I can get sysrq stuff to work - but
> >> stupidly the kernel disables all the useful ones so I will have to
> >> compile a new kernel with it set to 1 so I can get some traces.
> >> Really annoyed by this default setting, presumably from debian?
> >> Wished there was a boot command line option to configure the allowed
> > options.
> >
> > So hibernation is broken on x86-64?
> >
> > Ideas for debugging:
> >
> > 1) get that sysrq to work, backtrace where it is hung would be very
> > useful.
> >
> > 2) try v4.15.
>=20
> That one works for me FWIW.
>=20
> > 3) try without KPTI enabled. Probably noone knows how it interacts
> > with that...
> >
> > (And 4), we should really start doing some periodic testing of hibernat=
ion).
>=20
> I do that, but the period is not particularly short ...

Ok, I've just tested linux-next, and it works ok for me on thinkpad
x60. (But that's probably rather different configuration from the
macbook).

Unfortunately, I could not deduce anything useful from the
backtraces. Andrew, could you try v4.15 with KPTI disabled ?

Thanks,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--IJpNTDwzlM2Ie8A6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlqbCVgACgkQMOfwapXb+vJ1hQCdEwz17vI/YD41sSxJxB4vYgng
VmoAoISdv9kN5zVqgS+f3sjOXtUqr+Im
=re5M
-----END PGP SIGNATURE-----

--IJpNTDwzlM2Ie8A6--

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932065AbeCCJYV (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Mar 2018 04:24:21 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:36149 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751566AbeCCJYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Mar 2018 04:24:19 -0500
Date: Sat, 3 Mar 2018 10:24:17 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Worsley <amworsley@gmail.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux-pm mailing list <linux-pm@vger.kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, 844788@bugs.debian.org
Subject: Re: 4.16-rc3 fails to resume on MacBookPro10,1 -
Message-ID: <20180303092417.GA30917@amd>
References: <CA+Y=x3=U_zheHBxeNSzL9nSdXOZB7rs-JDNr36323uJ9Uhx0Hg@mail.gmail.com>
 <CA+Y=x3=+kPXJRNYo91i4yJiqqVHDsMhn2pAwkmAH2LV3usd7Hg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
Content-Disposition: inline
In-Reply-To: <CA+Y=x3=+kPXJRNYo91i4yJiqqVHDsMhn2pAwkmAH2LV3usd7Hg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

On Sat 2018-03-03 17:27:36, Andrew Worsley wrote:
> On 3 March 2018 at 16:41, Andrew Worsley <amworsley@gmail.com> wrote:
> > Basically hangs on resuming after decompressing. The last statement
> > displayed is "resume: Image successfully loaded"
> >  - I attach a photo as I can't get access to it
> ....
> > Bug https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D844788
> >
> > I couldn't get anything from the function keys with this latest kernel.
> ...
>=20
> By plugging in a USB keyboard I can get sysrq stuff to work - but
> stupidly the kernel disables all the useful ones so I will have to
> compile a new kernel with it set to 1 so I can get some traces.
> Really annoyed by this default setting, presumably from debian?
> Wished there was a boot command line option to configure the allowed
options.

So hibernation is broken on x86-64?

Ideas for debugging:

1) get that sysrq to work, backtrace where it is hung would be very
useful.

2) try v4.15.

3) try without KPTI enabled. Probably noone knows how it interacts
with that...

(And 4), we should really start doing some periodic testing of hibernation).

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlqaacEACgkQMOfwapXb+vLkhgCfcJqRQfeEDvwGEhbtmszTvyP0
KF0AnjWyMWfjbUI2w/vLc/apw2uc0n3F
=ve+5
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--

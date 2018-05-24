Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965953AbeEXJXq (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 05:23:46 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:39140 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965831AbeEXJXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 05:23:44 -0400
Date: Thu, 24 May 2018 11:23:41 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Tony Lindgren <tony@atomide.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, sre@kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, khilman@kernel.org,
        ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com,
        abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl,
        sakari.ailus@linux.intel.com,
        Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: v4.17-rc1: regressions on N900, N950
Message-ID: <20180524092341.GA6349@amd>
References: <20180422074213.GA12428@amd>
 <20180423202940.ig6iud5lrbgnu35a@darkstar.musicnaut.iki.fi>
 <20180521213952.GA11596@amd>
 <20180522080250.4fzyvqrgw5oigexn@pali>
 <20180522194139.GB2299@darkstar.musicnaut.iki.fi>
 <20180522205824.GA24927@amd>
 <20180522215638.GC2299@darkstar.musicnaut.iki.fi>
 <20180523140615.GA27180@amd>
 <20180523201208.GA31731@amd>
 <20180523220456.GY98604@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Qxx1br4bt0+wmkIi"
Content-Disposition: inline
In-Reply-To: <20180523220456.GY98604@atomide.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2018-05-23 15:04:56, Tony Lindgren wrote:
> * Pavel Machek <pavel@ucw.cz> [180523 20:14]:
> > On Wed 2018-05-23 16:06:15, Pavel Machek wrote:
> > > On Wed 2018-05-23 00:56:38, Aaro Koskinen wrote:
> > > > Hi,
> > > >=20
> > > > On Tue, May 22, 2018 at 10:58:26PM +0200, Pavel Machek wrote:
> > > > > On Tue 2018-05-22 22:41:39, Aaro Koskinen wrote:
> > > > > > My device worked with v4.17-rc1 (haven't found time to test new=
er kernels),
> > > > > > but if you say the probe order is random then we must find some=
 proper way
> > > > > > to express the dependency.
> > > > >=20
> > > > > I started bisect, but.. that will probably not be useful.
> > > > >=20
> > > > > If your device works ok in v4.17-rc1, it probably works in newer =
-rcs,
> > > > > too.
> > > >=20
> > > > Actually, my statement may be bogus... Now I tried again with -rc1
> > > > (and also -rc6) and it fails... But v4.16 works.
> > > >=20
> > > > > Thanks for the ordering hint, I'll try to figure out what is goin=
g on
> > > > > there.
> > > >=20
> > > > My bisection pointed to 6fa7324ac5489ad43c4b6351355b869bc5458bef wh=
ich
> > > > doesn't seem to make any sense...?! So maybe there really is someth=
ing
> > > > random stuff going on? :-(
> > >=20
> > > So... I did some experiments on v4.16.
> > >=20
> > > Swapping tsc2005@0 and lcd: acx565akm@2 entries in the dts does break
> > > stuff.
> > >=20
> > > I thought it might be due to vio regulator, but it does not appear
> > > so... screen still works with tsc2005 driver disabled in .config. (so
> > > there's noone to enable vio regulator).
> >=20
> > Deleting tsc2005@0 entry also breaks screen.
> >=20
> > Replacing tsc2005@0 entry with=20
> >=20
> >         foobar@0 {
> > 	               compatible =3D "not really with anything";
> >  		       spi-max-frequency =3D <6000000>;
> >  		       reg =3D <0>;
> >  };
> >=20
> > still results in working touchscreen, removing any of the three fields
> > breaks it again.
>=20
> I bisected one regression down, see "omapdrm regression in v4.17-rc serie=
s"
> not sure if it covers all the issues being discussed here though.

This is something else... Video was very sensitive basically to random
stuff, even in v4.16, and I tried to debug that. If I remove dts
support for touchscreen, video stops working -- and that's bad.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlsGhJ0ACgkQMOfwapXb+vIAWwCgtO6RO1J7UnZXtIvUFdRPbpny
84AAoLCUbvApJcMWlJ6/Z06/ZHy9NmR7
=WAKn
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--

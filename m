Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932286AbeCIUT7 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 15:19:59 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:52043 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751192AbeCIUT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 15:19:58 -0500
Date: Fri, 9 Mar 2018 21:19:57 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Mark Brown <broonie@kernel.org>
Cc: Kees Cook <keescook@chromium.org>, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: soc-core: Add missing NULL check
Message-ID: <20180309201957.GA7069@amd>
References: <20180308200653.GA47801@beast>
 <20180309125050.GD5252@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="+HP7ph2BbKc20aGI"
Content-Disposition: inline
In-Reply-To: <20180309125050.GD5252@sirena.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2018-03-09 12:50:50, Mark Brown wrote:
> On Thu, Mar 08, 2018 at 12:06:53PM -0800, Kees Cook wrote:
>=20
> > If a codec is not attached to the sound soc, a NULL deref is possible a=
s a
> > regular user in /sys.
>=20
> I can't parse this, sorry.  What is the "sound soc"?
>=20
> > +++ b/sound/soc/soc-core.c
> > @@ -137,6 +137,9 @@ static ssize_t soc_codec_reg_show(struct snd_soc_co=
dec *codec, char *buf,
> >  	size_t total =3D 0;
> >  	loff_t p =3D 0;
> > =20
> > +	if (!codec || !codec->driver)
> > +		return 0;
> > +
>=20
> How are we managing to create a sysfs file for a CODEC which doesn't
> have a CODEC struct associated with it?  That is obviously nonsensical
> and suggests we've got some more serious problem going on here - if
> there's no CODEC those sysfs attributes simply shouldn't be there.

Look for "linux-next on n900: oops in codec_reg_show() when grepping
sysfs" ... should be in your inbox.
								Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--+HP7ph2BbKc20aGI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlqi7G0ACgkQMOfwapXb+vJs0QCfTPIVnAuhoIqDB/fjWIuRtEwD
OpMAniKHVGQxZHKELxmOfZ8VArHh06W4
=0i7s
-----END PGP SIGNATURE-----

--+HP7ph2BbKc20aGI--

Return-Path: <pavel@ucw.cz>
X-Google-Smtp-Source: AB8JxZpT52YIMaGmebojlm4TugzIV62hr4vBlV9V0+L8hxncj9pXBJ8cPtl7phsUzyEaBvu5G2KA
ARC-Seal: i=1; a=rsa-sha256; t=1525950876; cv=none;
        d=google.com; s=arc-20160816;
        b=Twe+OZUX3HR/mWlHSol44vxrcWQxJRSNB92USyhGlLaSZ/EEWyd15sv9ngMChkzGK8
         o0KpU2YU7s3r7DRMES9Y8P9O4vP/BSguQfW7JUxRKCCi5sCBWS5OgKPkj19Jr9C4TxS/
         PolA5lSWqT4Ay87M6MpoF24rD56H6QGfVJGSO3sqtqwMbFfytYDbYaV5LViBz6bzurWw
         /yN7pmLtQG7DoKVAv2SKwXrHtA1l7aTbPpxc/L2iRe+MYarb122l+mG0lq2goP6vFyll
         82EJL/OgkuhX+xSOP9GMz8N53BPl7eyLHB/GRDRoKFa6bxLcI5+ftipssFX8mmIGP3TK
         gn8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=HYjIxX3qCY5bG045XRYtv29S2IqHfIe4Z3/Jc8F2Sis=;
        b=jnx46PYK0pArJ1XmoN0kddRgi6hbzSKOgEUY2yoDbs+lErSec1DVvB32hzFqi5/f34
         wo5wZQi2mwu/tbU3z5NbqX4W/6kbW2DlfZW7jN8L1HLaeYKrIV4uyqEvJBuNkaAOgrjq
         dKQsIHhHKyjSwt+tii/FogathPESoSVZ7HoXBN1SZCjlA5UEzEejSu584dvo74uVVVT5
         tkrqAkO+ENvuX0XvDwDLRAHU5THY1IiEH5rRqNYbx+EKjIhqH183gGmrk/Z1DSdyj7Bc
         M9tL1vN7YN+AHh1Mftu12HLilbe1upMjltqGw7Xuu0GfS+r7lSkvJuM7DjA3l4TxEYuS
         qOEw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 195.113.26.193 is neither permitted nor denied by best guess record for domain of pavel@ucw.cz) smtp.mailfrom=pavel@ucw.cz
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 195.113.26.193 is neither permitted nor denied by best guess record for domain of pavel@ucw.cz) smtp.mailfrom=pavel@ucw.cz
Date: Thu, 10 May 2018 13:14:34 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Johan Hovold <johan@kernel.org>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-serial@vger.kernel.org,
	One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, kernel@pengutronix.de,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2] tty: implement led triggers
Message-ID: <20180510111434.GC6977@amd>
References: <0c1bb915-bd92-4433-61ec-78fdba453396@arm.com>
 <20180503201952.16592-1-u.kleine-koenig@pengutronix.de>
 <20180507080252.GO2285@localhost>
 <20180507084127.ekpd3ze2itkzo7fd@pengutronix.de>
 <20180507092710.GQ2285@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XMCwj5IQnwKtuyBG"
Content-Disposition: inline
In-Reply-To: <20180507092710.GQ2285@localhost>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599475610182983981?=
X-GMAIL-MSGID: =?utf-8?q?1600075465825630945?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--XMCwj5IQnwKtuyBG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > > @@ -499,6 +500,7 @@ static void flush_to_ldisc(struct work_struct *=
work)
> > > >  		struct tty_buffer *head =3D buf->head;
> > > >  		struct tty_buffer *next;
> > > >  		int count;
> > > > +		unsigned long delay =3D 50 /* ms */;
> > >=20
> > > Comment after the semicolon?
> >=20
> > Given that this comment is about the 50 and not the delay member, I
> > prefer it before the ;.
>=20
> Hmm. I personally find it hard to read and can only find about 30
> instances of this comment style (for assignments) in the kernel. And
> arguably the comment applies equally well to the delay variable in this
> case too.

It is not too traditional, but I believe it makes sense....

(and yes, I wish we had kernel in Rust, so we could have real units
attached to our variables...)

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--XMCwj5IQnwKtuyBG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlr0KZoACgkQMOfwapXb+vIrzgCfU4fdJn727jPwFygVxCwyEHzA
VngAnjVhVAdDKuEEc4AX6AS3tRyM9gtG
=dshO
-----END PGP SIGNATURE-----

--XMCwj5IQnwKtuyBG--

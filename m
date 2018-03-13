Return-Path: <pavel@ucw.cz>
X-Google-Smtp-Source: AG47ELt1r2lwMf+A4M69yvR58Y7ns5jf2Y0e6nRxWlZ4pWdCy/8EmcCMyj4QNktE8MH3Dm9Z80OW
ARC-Seal: i=1; a=rsa-sha256; t=1520947670; cv=none;
        d=google.com; s=arc-20160816;
        b=Iq9l63A/GQBSLtrUgpkmtyM4utzYav80bTzehU5QH6aTzAz6AgBe4AHxhEjqDLRPk9
         F39ahQVAS5coO5q5TNw+gCANXyol7qyy7+J+Xm6qFGNs3vnCuft8U+PO/P5bRIsNa868
         b8WLu4lxJjUdYlRlWaiUQuAvvl1ouCtvKmNQZhgV9PKH3k8cyWDXrvd0TdWcug3QZ+Rl
         7fZzlqrefsHPYDVXr9JmQZMuK9M0DwCWecxOhXaUke2AK5zyss0SZZsYmzOzBWl8OJzu
         a+AWtGU7XQ+ZjnJIFSYq/ExOlk45Kzqdm9CwkA6EiUqNXg4ImufsxYsqNaMNYy096URU
         LBFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=vV8uPHFSZD/GvuonjiehpeLTV/ln1/vSYulAa9gzKOo=;
        b=Zrnam2U6pM3lTigMPCbrm/UiR3ORgQz4yWR3SHRcfRfseK9r2h3d4BNOPUsL3YkYh6
         LJxqqDWql7YF3GIxk5Bk4ShjiqBV6an+esPIJIX3OWxB+aN5Krke5keDEPrfntvSwwxX
         vHqczg9GBNJzv6LT6J54Q44JDsU2UTFsqzTbS/313L0F6pZolasBzpFTnif24o0c+LyZ
         Az/0ymOQ7cFcI6q7jira9PcGsR8qsi6UqnmBlR0hj+UySTAXS0+8QsMRF1kx22Q5q6SB
         ab+Z10fhAtD9UDS7bqPoAoPgLZ1wQbjnt9U4+DE+jGn7xXnHX0dmXqTHTRDDJSY+G9jE
         Cccw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 195.113.26.193 is neither permitted nor denied by best guess record for domain of pavel@ucw.cz) smtp.mailfrom=pavel@ucw.cz
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 195.113.26.193 is neither permitted nor denied by best guess record for domain of pavel@ucw.cz) smtp.mailfrom=pavel@ucw.cz
Date: Tue, 13 Mar 2018 14:27:48 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Jacek Anaszewski <jacek.anaszewski@gmail.com>,
	Matthias Schiffer <mschiffer@universe-factory.net>,
	Sasha Levin <Alexander.Levin@microsoft.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	Matthieu CASTET <matthieu.castet@parrot.com>,
	"linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>
Subject: Re: [PATCH AUTOSEL for 4.14 065/110] led: core: Fix brightness
 setting when setting delay_off=0
Message-ID: <20180313132748.GA20246@amd>
References: <20180204090531.GA29468@amd>
 <20180204111500.GB14797@kroah.com>
 <20180204171736.GA1388@amd>
 <20180206020210.m6gl7vai4p6azb6s@sasha-lappy>
 <713113d8-7662-d80c-c62f-af020469d0bf@gmail.com>
 <f072a5c1-95f1-e81b-c629-ebdea723e6f4@universe-factory.net>
 <20180312152811.GB16944@kroah.com>
 <5747831a-b237-aa2c-cb47-9773cd2b5956@universe-factory.net>
 <0cd72fe4-2b98-e6f7-6ae7-530524786cec@gmail.com>
 <20180313093703.GB27669@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
Content-Disposition: inline
In-Reply-To: <20180313093703.GB27669@kroah.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1591491593744715241?=
X-GMAIL-MSGID: =?utf-8?q?1594829224051973993?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > At least 7b6af2c531 ("leds: core: Fix regression caused by commit
> > > 2b83ff96f51d") is missing, causing visible regressions (LEDs not work=
ing at
> > > all) on some OpenWrt devices. This was fixed in 4.4.121 by reverting =
the
> > > offending commit, but if I followed the discussion correctly, 4.9 sho=
uld
> > > get the follow-up commit 7b6af2c531 instead (like 4.14 already did).
> > >=20
> > > Jacek's mail I replied to mentions that eb1610b4c273 ("led: core: Fix
> > > blink_brightness setting race") should be included in 4.9 as well, bu=
t I
> > > don't know the impact of the issue it fixes.
> >=20
> > It doesn't fix any reported issue, but is just an improvement
> > aiming at preventing potential races while changing blink brightness.
> >=20
> > After taking closer look it turns out that for the patches in question
> > to apply cleanly we need in 4.9 also a patch which introduces atomic
> > bit fields for blink flags.
> >=20
> > Effectively, here is the list of patches required in 4.9 stable:
> >=20
> > Revert "led: core: Fix brightness setting when setting delay_off=3D0"
> >=20
> > followed by:
> >=20
> > a9c6ce57ec ("led: core: Use atomic bit-field for the blink-flags")
> > eb1610b4c2 ("led: core: Fix blink_brightness setting race")
> > 2b83ff96f5 ("led: core: Fix brightness setting when setting delay_off=
=3D0")
> > 7b6af2c531 ("leds: core: Fix regression caused by commit 2b83ff96f51d")
>=20
> Odd, I just got another report that the 4.9.87 release fixed some
> reported LED issues, so why do I need all of these?
>=20
> Should I just revert the single 2b83ff96f51d commit here instead?

I believe so, yes.

I'm not aware of any _really bad_ issues with LED subsystem in
4.9. Take a look at changelog of
2b83ff96f51d0b039c4561b9f95c824d7bddb85c -- it fixes rather
theoretical issue; user can reproduce it by hand in shell, but,
well... don't do it then.

The rest of fixes ... fix some more theoretical races. I don't think
it is -stable material, as I pointed out before.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlqn0dQACgkQMOfwapXb+vKZTwCgpCZaexLrN23mORvHiMe4/dJu
8koAoLdpi2/7/21hWSl3YGY5SS+uShI8
=y1T1
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--

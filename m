Return-Path: <pavel@ucw.cz>
X-Google-Smtp-Source: AG47ELvJKTdZQEO4vVP5geb/5xQ8BHabcJPRfnEyU8hMFmMBvxcJoIs91KZzKrd3kRjll2mOzvMg
ARC-Seal: i=1; a=rsa-sha256; t=1519756707; cv=none;
        d=google.com; s=arc-20160816;
        b=SyjC0sLMf1FdA93rAe9zVWskDirFKf5fPDgzGYrZLFSQmtzi97ROTK5r8SZlzODDmX
         APZParUpN3gwhHDNjKvhMLzAT5CYZyaoaeu3bazSBZzGghU6cZ6U8NTrFN5Q4rIHuIrM
         xJQuDX9VjEknTpKIjJQsIvTeJPbl0kZzUJjwRv42F4sIsK+TAr6I2y/ZwYVG+LZZgCqL
         1XdeqjUGlcTV6MoWE1F69zjwC3AWMWYyX+jpC4At544FeSRZ1FWI+BzsGyFxR3eZgbhO
         HSjqNU1AThus1w0TJRkT4SrlCqm8PYnv2YseOeodu7+DCLU5afTCKS7MP7E2i4C+PvX5
         HBXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=Ocjv6WHaT47C3dzbkQ9xVMwmZvTu1/r9EfglDpqC0/c=;
        b=saCRfudU4o/MvjGr6+UvKKHdjaTVlh99KSBjpWJFEXLp4IHataSE0/spm0WuhyY6Ho
         0fmORce6hsZ0e3pWOsiyHC/cyWL+KOEI1RAf4VsPD/dqGlTxXFDDKAmXU/PTkvKoRYJ0
         zQpKNY0bMCO9F6kwRd8vASueaWxrZf0TZ9tLSWJQMgKbNvlo0726hfUVBpVnJvQbwXCE
         9OIBaRAvb+EsRcCfEuG02pYHyv+4ryrbcBhvjh06hDYCs2OLAdOLoRd1weGRd3mYBOFW
         +jK5kw72MdL1Eggvj4cDuWRK8rq20EztBaO/mlg6k4ljXMYtlDpwoiVzLVflK+CT0XX+
         sSFg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 195.113.26.193 is neither permitted nor denied by best guess record for domain of pavel@ucw.cz) smtp.mailfrom=pavel@ucw.cz
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 195.113.26.193 is neither permitted nor denied by best guess record for domain of pavel@ucw.cz) smtp.mailfrom=pavel@ucw.cz
Date: Tue, 27 Feb 2018 19:38:26 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Johan Hovold <johan@kernel.org>
Cc: "H. Nikolaus Schaller" <hns@goldelico.com>,
	Mark Rutland <mark.rutland@arm.com>,
	DTML <devicetree@vger.kernel.org>,
	Thierry Reding <treding@nvidia.com>,
	Jonathan Cameron <jic23@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Tony Lindgren <tony@atomide.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Russell King <linux@armlinux.org.uk>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Kevin Hilman <khilman@baylibre.com>,
	=?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>,
	kernel@pyra-handheld.com,
	Discussions about the Letux Kernel <letux-kernel@openphoenux.org>,
	linux-omap <linux-omap@vger.kernel.org>,
	Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [Letux-kernel] [PATCH v5 3/5] misc serdev: Add w2sg0004 (gps
 receiver) power control driver
Message-ID: <20180227183826.GA32473@amd>
References: <cover.1512114576.git.hns@goldelico.com>
 <5494ad34b39a6c62601e3747440268dfb3be7d5a.1512114576.git.hns@goldelico.com>
 <20171222124427.GI3374@localhost>
 <91850CC3-B280-4701-9D07-96AFF3A79A6F@goldelico.com>
 <90F9A8E4-035A-4A9E-8AAB-757491D63E69@goldelico.com>
 <20180112153903.GB5992@localhost>
 <20180212152618.GC13962@amd>
 <20180227070415.GB18666@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: inline
In-Reply-To: <20180227070415.GB18666@localhost>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1584169666984958099?=
X-GMAIL-MSGID: =?utf-8?q?1593580408819774125?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > > Let's restart this discussion and focus on the main roadblock (othe=
rs
> > > > are minor details which can be sorted out later).
> > > >=20
> > > > If it feels like a hack, the key issue seems to me to be the choice=
 of
> > > > the API to present the GPS data to user space. Right?
> > >=20
> > > Or even more fundamentally, does this belong in the kernel at all?
> >=20
> > Yes, it does.
>=20
> But not necessarily in its current form.

Not necessarily, no. OTOH this hack was not too bad IIRC and we
usually do present NMEA to userspace at the moment. We'll need proper
GPS subsystem one day, but I'm afraid that will take some time...

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlqVpaIACgkQMOfwapXb+vLVKACcCK9CCeKVQ3hMNwRNIJJgsPv1
XuAAnRVH+t7hwwDq1BgR1dcqpRfgd2e4
=XIu1
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--

Return-Path: <pavel@ucw.cz>
X-Google-Smtp-Source: AH8x227a1NlzjpaSV8n9qX4Lti8o0r2NoALJFKrxqb8h1vWnVW99Xl0PnR++3Q4u3V4Lj030iser
ARC-Seal: i=1; a=rsa-sha256; t=1518449179; cv=none;
        d=google.com; s=arc-20160816;
        b=Q15RS3ZLZx8oTF1qmNX9q2kXv/kUv7CesgLH3FPXLfyo7iT850mRo2npSRXyvgWr5f
         pKh2zTcEJyp7VGgIZCbhDWolX1bvgIJgZbFSi3AiCh3/3/KjcwgLTCBOojht5l7+ViD4
         6cFY8WmBhSV60glD1aQtDlN6jlFzHXX0xCeSKSRtSSILyWoHTa+1vXQ8bzDhSM6F0E3q
         Mt+xHg1OD5LMPeh6OowGu+86MyDYw+36/p91FM5ZBHmdyu+N6IdStQEgZlSZ84/FQT9s
         U+Yxcyr+WEJCy8miZ38kPN/W5L+xYAmFx70ldcQ7uKmhPjxWV5OxSvZSguYIvpYrkTD9
         /x5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=vcak6BnBC9FQEz3w7qOBB8cgb3TjwUyZ5B2Y5FQghz8=;
        b=eS+sD4X3fNxwmGIhR66+gajhhhXFvtsMJvAxTc86FKo+n3uUDxJ+raHjPORxTbYvVb
         Ha5y2x9hz/L49VOepykLU3QonMqNZgTeWKyrWd6FJNe759S1nr7Ojn9WXxrDhyOdWJy2
         drQR1kQpuOncdIwy9pUo8I6AHEc2Vxo7LLD5bnWrAop61zhOMry8tWvksvz7FAeoD9WR
         9xam+7OOwr+BhCabl9/h9ujb/wV8op9JalOWrSgQ8VC+tei3ZdlTgZW9rVuQpJlyuLc4
         0O9+IwpYWAINpQSnWp31F6UnHhwqvocuKS5zVWUP5VtJQ+WENn1Q/oAvTGqzj8YM1Z8u
         mUxQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 195.113.26.193 is neither permitted nor denied by best guess record for domain of pavel@ucw.cz) smtp.mailfrom=pavel@ucw.cz
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 195.113.26.193 is neither permitted nor denied by best guess record for domain of pavel@ucw.cz) smtp.mailfrom=pavel@ucw.cz
Date: Mon, 12 Feb 2018 16:26:18 +0100
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
Message-ID: <20180212152618.GC13962@amd>
References: <cover.1512114576.git.hns@goldelico.com>
 <5494ad34b39a6c62601e3747440268dfb3be7d5a.1512114576.git.hns@goldelico.com>
 <20171222124427.GI3374@localhost>
 <91850CC3-B280-4701-9D07-96AFF3A79A6F@goldelico.com>
 <90F9A8E4-035A-4A9E-8AAB-757491D63E69@goldelico.com>
 <20180112153903.GB5992@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dkEUBIird37B8yKS"
Content-Disposition: inline
In-Reply-To: <20180112153903.GB5992@localhost>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1584169666984958099?=
X-GMAIL-MSGID: =?utf-8?q?1592209367346884866?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--dkEUBIird37B8yKS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Let's restart this discussion and focus on the main roadblock (others
> > are minor details which can be sorted out later).
> >=20
> > If it feels like a hack, the key issue seems to me to be the choice of
> > the API to present the GPS data to user space. Right?
>=20
> Or even more fundamentally, does this belong in the kernel at all?

Yes, it does.

> Given that we'd still depend on gpsd and other, proprietary, daemons to
> actually parse and use (also for control) the plethora of GPS protocols
> available, it may even be best to just keep it all in user space.

No. We'd want to move away from gpsd in the long
term. (/dev/input/mice was in similar situation.)

> Now, if we'd ever have a proper GPS framework that handled everything in
> kernel space (i.e. no more gpsd) then we would be able to write kernel
> drivers that also take care of PM. But perhaps that's unlikely to ever
> be realised given the state of things (proprietary protocols, numerous
> quirky implementations, etc).

That is what needs to happen.

> The kernel is probably not the place to be working around issues like
> that, even if serdev at least allows for such hacks to be fairly
> isolated in drivers (unlike some of the earlier proposals touching core
> code).

Oh, kernel is indeed right place to provide hardware abstraction --
and that includes bug workarounds.

We'd like unmodified userspace to run on any supported hardware,
remember?

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--dkEUBIird37B8yKS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlqBshoACgkQMOfwapXb+vLq0ACfa+0cUfIudCx3JKPfpMHeQ9Fk
se8AoIjq1ci/aJ0lgBOdyzieOOILfG/Q
=amcf
-----END PGP SIGNATURE-----

--dkEUBIird37B8yKS--

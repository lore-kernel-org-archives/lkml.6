Return-Path: <broonie@sirena.org.uk>
X-Google-Smtp-Source: AB8JxZoFM5MRt9xFQaAyOOXi+5ivuO62h13zkuC+AdhJJ0LV/DYjqLR+jSCJwxvMVRHK2/RJ3AJr
ARC-Seal: i=1; a=rsa-sha256; t=1525857511; cv=none;
        d=google.com; s=arc-20160816;
        b=QxM3iHPIIbTPpf7pyOtwgkc9CJ1ypdu6YSGDBnrJQS6kkfaawhGCqkzwSUyfR3U43c
         eD5Q7kEFF6Hjmlr44vVM4ObLCSglz623KDAGlUMxutltNYEYI9eEZ5rvcK1UCA+wMufq
         aOaNf6j5fw8ztcLeoYvQkxAPxyasb757f4juvGng8b23zhp/rE5E5MCdufcBUo8/bYzl
         KvKEZGnuk1NPEwT4pC9Flgwqv2IM/4AxApSfuYO6qZGuo+XZ6//GGk8wkLgI2TvRpDPe
         dBwuX8ZblWWuGdKwUsQuYL6w4dB8kvk2S7ETIy+cBF7ziV2JQBSAj9C+4AS+OYwv5ZaL
         xTQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=sjjyme0Bd5RwISJJzUhOZkcRESNoNhQIedqM1PB/L7E=;
        b=xuGQ8E/EQ3sCFAg23hx8203rq7ArHngW1Uoir79NOxs7jTW/24bSERqbrh8wKXFdWo
         cp73zCeVstWJuTFk8UIyGtQtnr1WG1SxbzDej5OU5vacHosLhfU3PvX4xF12Mq01wU48
         HGhL+y6Ga0wtAxF32Ej8Nsshi+FbGxjZsansp/NMI3ySdgRME47Vs3mtEwaC5dJOvBrj
         ExttpBpy4seXtfLQ0QpRST+ukk5qRPu588+qp93z9wD+i6DjnjXk6MjHLfED//BELk1G
         iX9NdeuvfzhepSpuRKDKjx+X4sV9CL7D6Wfljdi/whDImpxUbQIwEwCoYLV4WPFnqzJ0
         MGvw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@sirena.org.uk header.s=20170815-heliosphere header.b=G0v0N2rS;
       spf=pass (google.com: domain of broonie@sirena.org.uk designates 2a01:7e01::f03c:91ff:fed4:a3b6 as permitted sender) smtp.mailfrom=broonie@sirena.org.uk;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@sirena.org.uk header.s=20170815-heliosphere header.b=G0v0N2rS;
       spf=pass (google.com: domain of broonie@sirena.org.uk designates 2a01:7e01::f03c:91ff:fed4:a3b6 as permitted sender) smtp.mailfrom=broonie@sirena.org.uk;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Date: Wed, 9 May 2018 18:18:16 +0900
From: Mark Brown <broonie@kernel.org>
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Rob Herring <robh@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	devicetree@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Grant Likely <grant.likely@arm.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Architecture Mailman List <boot-architecture@lists.linaro.org>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	Alexander Graf <agraf@suse.de>
Subject: Re: [RFC PATCH] driver core: make deferring probe forever optional
Message-ID: <20180509091816.GZ13402@sirena.org.uk>
References: <20180501213114.20183-1-robh@kernel.org>
 <20180507183106.GF2259@tuxbook-pro>
 <CAL_Jsq+PRUR5rCeV820XZuQmQH3gD-X=6a5fNuF-9qVbq5dqFg@mail.gmail.com>
 <20180507223438.GB14924@minitux>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="x0Bbm7aQwrWvLJ2v"
Content-Disposition: inline
In-Reply-To: <20180507223438.GB14924@minitux>
X-Cookie: Advancement in position.
User-Agent: Mutt/1.9.5 (2018-04-13)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599298891509345819?=
X-GMAIL-MSGID: =?utf-8?q?1599977566941544677?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--x0Bbm7aQwrWvLJ2v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 07, 2018 at 03:34:38PM -0700, Bjorn Andersson wrote:

> And is this really a problem that does not exists in the ACPI world?

Sort of, in that on ACPI systems all devices are expected to live in
glorious isolation and anything they need transparently configured by
the firmware with any information about clock speeds or whatever coming
=66rom proprietary/device specific properties (though that's severely
frowned upon) or the apparently idiomatic technique of hardcoding based
on DMI data which has some scalability issues.  This works great for
systems intended to work in the ACPI model but is not entirely
successful once you get outside of that.

Some of the embedded ACPI people have been importing bits of DT
wholesale into ACPI, for those bits obviously all the DT issues get
imported too.

--x0Bbm7aQwrWvLJ2v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlryvNcACgkQJNaLcl1U
h9DA3gf+Iei5ou4tBOVJglGvoZ9igFjOMgHOgHeDUH2v8uKK7n2+aXapXif5Y6ky
wHId+gxnZvk35qkhFCyaDsz8Ay4LSk2JAP92DppH+BgLfaSfJ7aRi4tg6Zh6zGZ8
nb1p2OXP9v/Ai47mDOmPsum4VGWxxXdXUjhnNj0krhFZVPmvjqnQgHf7KMd4a2oZ
ppECMkwnFHpSjRE0hXrepCl+8nVDHVHhfboCY3nK+a5ZRhO5M1KjTsiJfi/+bxJW
4PkbPl8eQ/qHPY9iiebJtq9SGgjlwZSQfdGMBDG5JXMY/elWHBH2DpLvi/CvJFvk
1k1qhttEq3WiQbeNjieLdgNcu6GOBA==
=xcHg
-----END PGP SIGNATURE-----

--x0Bbm7aQwrWvLJ2v--

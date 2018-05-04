Return-Path: <pavel@ucw.cz>
X-Google-Smtp-Source: AB8JxZpT1Q9QZNMcu/+LmaQzH10oZSGhPsqgh/Wx4nDV83AoFP+tqEsVUpktSuiq/eLaJVTNbgY/
ARC-Seal: i=1; a=rsa-sha256; t=1525464196; cv=none;
        d=google.com; s=arc-20160816;
        b=f1itcfW16g+khGplyJohfflLWNEYYQBg5GPJLb2UhfBVmbc8GgWfQ8mzF6kLsZFcZm
         GUzjC9XPjKg3GEGCg5s70FQ+mHt0Y3wCG20f7tdQ/mGkE14CVzXANAt5vmhvCq1zEtQm
         DFyMko9F7j16+OeuHfksRU+BLCj3fpZf7ZFXd9PMlwxLVtpAdEJY80rdNyWsYd4OKPCH
         AozgCe19+Vd5ZR28Sfc0ipfEybh9uQiLztKdKxOC+cNvdtnZ+m6buEm5ZAQ4iHMYw/rG
         kvqm5qpLxzg0mbduyOl46qZOa58oJP+yfxfN2DKx+DxvLuhJ7b4Ox17flpR/1bMU65vw
         J+uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=W00ARIvNhZskPguOl58za0L4qdxnoVDXs194w3MfV4o=;
        b=lrYkmeTZujeW7HgVujGbOuTj4chRTcbhD+Gb8Hfa2teL4I1MikLxvNT2JeqCJ16sYh
         WqNpbyj35mQTMr6D9fO9wZa1w6cv2XmmC9avfL8xS1OcLB6vTenv8ZRflnDFgypnfky1
         y1k2T+V4Ai85dY1fDRB2tXaZauqRnjv7HW16ceEH8/7OA4HRus/yj6Gw2mUEfZcW1hrU
         AAEGiIjMkg4PLSUQXgvRf5UiqrjBi2qbcqr00aXFB8sHCt1sE17IfLGV6c/tj7ZsxVmM
         5DY4C9tvln8K3CohGlZdS/5CBKFmxSkNyE1GqUINY9SArhx9VgDIEJpmf1ANZMqgcjh+
         s53w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 195.113.26.193 is neither permitted nor denied by best guess record for domain of pavel@ucw.cz) smtp.mailfrom=pavel@ucw.cz
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 195.113.26.193 is neither permitted nor denied by best guess record for domain of pavel@ucw.cz) smtp.mailfrom=pavel@ucw.cz
Date: Fri, 4 May 2018 22:03:15 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Johan Hovold <johan@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Andreas Kemnade <andreas@kemnade.info>,
	Arnd Bergmann <arnd@arndb.de>,
	"H . Nikolaus Schaller" <hns@goldelico.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 0/7] gnss: add new GNSS subsystem
Message-ID: <20180504200315.GA22519@amd>
References: <20180424163458.11947-1-johan@kernel.org>
 <20180504132741.brn5jqv5ufjhp7ky@earth.universe>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9amGYk9869ThD9tj"
Content-Disposition: inline
In-Reply-To: <20180504132741.brn5jqv5ufjhp7ky@earth.universe>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598647061282688193?=
X-GMAIL-MSGID: =?utf-8?q?1599565144708319297?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Finally, note that documentation (including kerneldoc) remains to be
> > written, but hopefully this will not hinder review given that the
> > current interfaces are fairly self-describing.
>=20
> Great work. I like your design decisions. I have quite a few devices
> with have non-serial based GPS peripherals using binary protocols (*).
> As far as I can see it should be possible to add support for those.
>=20
> I have one concern, though. While providing raw data by
> default is fine generally, it is a problem with device
> auto-discovery. I think there should be some IOCTL from
> the start, that can be used to inform userspace about
> the raw protocol being used (i.e. "NMEA"). I fear, that
> userspace may start to just assume raw =3D NMEA without
> having this (especially since all initial drivers provide
> NMEA).

Yep, that would be nice.

> (*) I have those in mind:
>=20
> Nokia N900: The phone has GPS integrated into the modem and uses
> ISI encapsulated data. The protocol has been reverse engineered
> and it should be possible to write a kernel driver for handling
> the GPS packets and dumping the raw data to /dev/gnss0. I don't
> think this is particularly useful without a non-raw interface,
> though. It would still require a custom userspace implementation.

Actually... in this case it would be nice to do the protocol
processing in kernel and just present reasonable interface to
userland... or maybe NMEA.

> Droid 4: GPS is similar to N900, but different protocol and QMI
> encapsulated. This one also has known protocol with userspace
> implementation. I did not yet have a detailed look, if its possible
> to (un)wrap this in the kernel.

So, this is actually NMEA over QMI. I do have patches libqmi that
provides NMEA on stdout.

But there seems to be another possibile interface (yes, that modem is
crazy, and you can talk to it over few different interfaces), and
that's NMEA over GSM07.10. That one should be feasible to decode in
kernel and just provide NMEA to userland.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--9amGYk9869ThD9tj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrsvIMACgkQMOfwapXb+vKWzQCfZOPNaj3pxEakhZzPJGSdPibB
rWIAnirElFj5ptHna9t3I53DqNtFUjbQ
=P8q2
-----END PGP SIGNATURE-----

--9amGYk9869ThD9tj--

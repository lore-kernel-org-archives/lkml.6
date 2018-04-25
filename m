Return-Path: <pavel@ucw.cz>
X-Google-Smtp-Source: AIpwx4+jDjzfXRVVIwnU9jmwp8JxuWJCnTvpk2UfbPPPtM3useaOpKZFOLfOtTubuyODSsVaBKFV
ARC-Seal: i=1; a=rsa-sha256; t=1524637620; cv=none;
        d=google.com; s=arc-20160816;
        b=CWJAC6ggAfD/ls/RQCJp66oZeQva20PLzjbULT+Hfody+3ZaIbNsqUk6/L8vAnJuwl
         j7hEjrg/9B8ZQhPKErVLW0XdRQ2H8tUvkJc9nNj3n1uufndxaNrzVv24vjifS6SpTD3T
         TvncZhMRrLY9gTVgeI+5E72DmX9fSMNtLOWSb3dfYoGnZHQw2UHQXPAv8oU2tkjCKM/h
         q1Rr1on+WfVSexR9C7Qxyb1BIVDYctL91f04qABcynBegtp0SzR/XB0UccTSCgOC4HKp
         FzeFHd86NO+NyABFiGGjD/kOGhxRwL6ks5suqdibefqh1lzEiQ9qFSAalaYP5gr/wRHj
         4SnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=D8ezu8wBJk6G6tGK+3xnyR3YG9ReTunaO2QIKL/9CK8=;
        b=bYdFntbRarYlNzd1httubRipMN2Ik4lqt/tbu9pieI0cm+lEOw5Hj7zyWPUh+echne
         Dl1fLrAp6nHPWUx+2miAWjBzRBMxwIrlwCMrl36BlJUHoRh9eUomwbwtCeKO5aIyjUZD
         vkpf9eVtT16xQv3lCZZiPwDx6l/3S1H8Vw0Yh5VtZcZ9SBbzRCLKna4U1WkArm8bGxCe
         5cHma+H/i50KpcPEK/FIsYSRimVq7iSAL6yYbcWH5J0IZboWR7ZiOJuaQwuvTon6C8Bo
         UcMRkVNjumtyGf17uaTrmooop6tkd1tx8ApxKA6ZIS+YiJdeIvSXYc8tsMaXZvzbhxMA
         0SSw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 195.113.26.193 is neither permitted nor denied by best guess record for domain of pavel@ucw.cz) smtp.mailfrom=pavel@ucw.cz
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 195.113.26.193 is neither permitted nor denied by best guess record for domain of pavel@ucw.cz) smtp.mailfrom=pavel@ucw.cz
Date: Wed, 25 Apr 2018 08:26:59 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Andreas Kemnade <andreas@kemnade.info>,
	Arnd Bergmann <arnd@arndb.de>,
	"H . Nikolaus Schaller" <hns@goldelico.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 0/7] gnss: add new GNSS subsystem
Message-ID: <20180425062659.GA5352@amd>
References: <20180424163458.11947-1-johan@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k1lZvvs/B4yU6o8G"
Content-Disposition: inline
In-Reply-To: <20180424163458.11947-1-johan@kernel.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598647061282688193?=
X-GMAIL-MSGID: =?utf-8?q?1598698417377156485?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This series adds a new subsystem for GNSS receivers (e.g. GPS
> receivers).
>=20
> While GNSS receivers are typically accessed using a UART interface they
> often also support other I/O interfaces such as I2C, SPI and USB, while
> yet other devices use iomem or even some form of remote-processor
> messaging (rpmsg).
>    =20
> The new GNSS subsystem abstracts the underlying interface and provides a
> new "gnss" class type, which exposes a character-device interface (e.g.
> /dev/gnss0) to user space. This allows GNSS receivers to have a
> representation in the Linux device model, something which is important
> not least for power management purposes and which also allows for easy
> detection and (eventually) identification of GNSS devices.

Actually... no, what you done is not GNSS subsystem. It is generic
subsystem for a link + some controls, typically for power.

Yes, that setup is common for GPS receivers, but it is there also for
modems (droid 4: usb + gpios) and bluetooth dongles (n900: serial +
gpios).

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--k1lZvvs/B4yU6o8G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrgH7MACgkQMOfwapXb+vJM3QCfaB/TsM5fW9gWR+P8iDcIFSo5
9CAAn3AWDODk1U2XVOxgTGPJ/ruOiMyv
=apkP
-----END PGP SIGNATURE-----

--k1lZvvs/B4yU6o8G--

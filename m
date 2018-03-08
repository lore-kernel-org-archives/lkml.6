Return-Path: <andreas@kemnade.info>
X-Google-Smtp-Source: AG47ELsORTmOWJVcyg2/ap1ljKuPKFaLl/W3AN4P04c2BLsToUUKycZyAK+synjKUxjAsrbyWKWm
ARC-Seal: i=1; a=rsa-sha256; t=1520489859; cv=none;
        d=google.com; s=arc-20160816;
        b=EK3ncYesWT+Oy3gMUZMBMFKJl0gRekyWWvug8zgpYADFEYmOw7z2bPcdG8XkUcc2bQ
         dfHzMqrJFqviI0js2kDBfXc/yA0iMQ8CR5tdzhPVu2hKdGsbgh1fZfxE19P3saPUwfua
         23YoOZRVMjqoEmWpun7bVCeBE13GOW9JnRnwfsk0Sc2A+V7E/ZPGf6QvBTFDPTJWTA5a
         leJM+Was1GTtv7ouMfiC10Ji/3WPNfRym7w1xgipP/Sd6/R1tmHHP1Fl4jrDy96FEVKX
         2zY3zzWCMwH6D5AyExvTZNN0wcliOGyhZIfzUtevd2g8VLYy6+aY45DaOqimcWr1Zt4+
         d2DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:arc-authentication-results;
        bh=ArI6VI894rwjufFbjZI9HD/tyBRqjuT4AsuxEi5I89o=;
        b=QUdAXkJB2uyMH4E0U0GbNMxCy6njS4YNr5t4KrnPEPnN3XcIT6iK8oUf2x41LmRJ0x
         Xt46zaDcS09HGs/2Nm1wj1/4/CGf6pNnN2YcXJqaJGUUgI4kecee3F262Bj0qgw60rkn
         aSvMUoIsBbdj207Pb4rSbrI9oCYk9+RZ9YVJS4K9mMDVFNVBfwkVr8K0e75OZ6AEk431
         9Nl/ieUGUMKx7qjvEY+GEzw13EbuouRerFLd3lx4I9JhUmv4Quz/nqgWjdCGXV1fd1MW
         P2SjRCiEtGOPd96yT3gYydXXbPfmAbmjNzIbEkPA0k445n+GIUyEq+OfyLpkSXvqTN7N
         ml2w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 2a01:238:43f3:0:615b:ee97:1f81:cbf2 is neither permitted nor denied by best guess record for domain of andreas@kemnade.info) smtp.mailfrom=andreas@kemnade.info
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 2a01:238:43f3:0:615b:ee97:1f81:cbf2 is neither permitted nor denied by best guess record for domain of andreas@kemnade.info) smtp.mailfrom=andreas@kemnade.info
Date: Thu, 8 Mar 2018 07:16:44 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: Johan Hovold <johan@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, Jonathan
 Cameron <jic23@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Tony Lindgren
 <tony@atomide.com>, "H. Nikolaus Schaller" <hns@goldelico.com>,
 kernel@pyra-handheld.com, Russell King <linux@armlinux.org.uk>,
 linux-kernel@vger.kernel.org, Thierry Reding <treding@nvidia.com>, Rob
 Herring <robh+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 =?UTF-8?B?QmVub8OudA==?= Cousson <bcousson@baylibre.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, linux-omap@vger.kernel.org,
 Andreas =?UTF-8?B?RsOkcmJlcg==?= <afaerber@suse.de>,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [Letux-kernel] [PATCH v5 3/5] misc serdev: Add w2sg0004 (gps
 receiver) power control driver
Message-ID: <20180308071459.310d0ba2@aktux>
In-Reply-To: <20180118064736.GH3286@localhost>
References: <cover.1512114576.git.hns@goldelico.com>
	<5494ad34b39a6c62601e3747440268dfb3be7d5a.1512114576.git.hns@goldelico.com>
	<20171222124427.GI3374@localhost>
	<20180109184347.28ba0a6e@aktux>
	<20180112144647.GA5992@localhost>
	<20180112194022.7da1e726@kemnade.info>
	<20180118064736.GH3286@localhost>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_//GnIge=aWUzMu=J_ndxszsL"; protocol="application/pgp-signature"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1584169666984958099?=
X-GMAIL-MSGID: =?utf-8?q?1594349174818679319?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--Sig_//GnIge=aWUzMu=J_ndxszsL
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, 18 Jan 2018 17:47:36 +1100
Johan Hovold <johan@kernel.org> wrote:

[...]
> >=20
> > So to avoid having hardware information spread all over the table at le=
ast
> > these information would need to be in devicetree. But that also all fee=
ls
> > like a hack and hard to maintain. =20
>=20
> Having the device described in the device tree is certainly desirable,
> not least for chip identification. And with a GPS framework in the
> kernel with a well-defined interface, implementing power management
> would be straight forward.
>=20
Hmm, devicetree without in-kernel drivers, do we have anything like that
somewhere? I thought that was a big no-go. But maybe I am wrong.

> I'm just not convinced that the proposed tty interface is the right
> interface for this. User space would still rely on gpsd for the GPS
> protocols, and would also ultimately be managing power by killing gpsd
> or whatever daemon that would otherwise be holding the port open.
>=20
> Something like the generic power sequences that has been discussed
> elsewhere might be a better fit for this if all you want to do is power
> on and off on port open and close (and on suspend/resume). There really
> isn't anything GPS-specific in the current proposal (besides the
> suggested tty-device name).

So a bit like that mmc-powerseq stuff we already have?
>=20
> But sure, that wouldn't be sufficient to deal with the
> unknown-power-state problem with the device in question.
>=20
Maybe there could be a kind of active flag set by the tty if
there is traffic, so that active flag could be used in these
power sequence stuff? But then again the tty layer has to be extended
which would probably also cause a lot of ruffled feathers.

Regards,
Andreas

--Sig_//GnIge=aWUzMu=J_ndxszsL
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE7sDbhY5mwNpwYgrAfb1qx03ikyQFAlqg1UwACgkQfb1qx03i
kySUIRAAm+s1rDjwjMbnM/1njhhr3ul5v6ns3xiRWFYUCB9H16i/ts2OheXAj304
udSxZ1eMoY8mVnl9bvao7MY5k1xPR+tcHHG0cVNlR7ZvIpcfrao/10ljXSe52IlW
jZvO/9h7caocZT6AzqynwoctjClEj8Ck59FJfVM934utY7GDnPhWkFdADQdkPygB
zUtzDIj3RiWNKiMxq6QSzPF0PnEPTDKmpgIJjfmDTXxfxT/KfPaQCr2PanXAjI/L
rKADGmTfpMYF+x3bPcCHDLBytg3NZvYFYEp2EdKyBWzOrA9EVqzCqH8VqJ6cHbFZ
JePoNdy7bcoFNIG6i17iGCqCeSgG+fyrebXVEIY00f0NEXFiilGk5fdVEw8cZrhe
EJZHU+KbJFC598cTgZ7sP1btCFfs5Z3O5JDVQKwe4uAdkm0g+FmW+fWhxH8pLWXB
qMSX1NJ0GSlNBhUfJJ4/5Ud0Ft5RcltsiR4JuVbVixcjc5XFnr89EXm7CXEh1kne
RqS02zpvKIYUbWD1BQ53mj6l1j1SlTM78/ispS+bKN07aPWq72Q9E7s0Nuy6Xr21
99Iax7Eos6QmPLD5/CE+8C1Fj/BOKqjIcdDpjk8+jZ4nh2RtI/E500LvaqnlOxg1
YmQKZB0Epdm9ObZdm0KHtpNCrejTye0xt2BI251wwjg+bnikZHc=
=PAIm
-----END PGP SIGNATURE-----

--Sig_//GnIge=aWUzMu=J_ndxszsL--

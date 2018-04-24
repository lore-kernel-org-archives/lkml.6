Return-Path: <andreas@kemnade.info>
X-Google-Smtp-Source: AIpwx4+x1j88bCf1D4s66q06uN1BEQvy+ZytgmWyunXML7tgXv9akC36TXJzSZvS1QtBp18Fv8xC
ARC-Seal: i=1; a=rsa-sha256; t=1524603595; cv=none;
        d=google.com; s=arc-20160816;
        b=ibNfeMTk7V6oLge/c0d7WUuhpogk8onIz29OokU636m/GIe1o7yoGdRUd2l0m4/YnH
         qZ/kmtI82faMsT+0eZao/JKw8iqIIHk2sUL4gcvjlc0MxxjsyWzLZxGmf0VYQE7kINnf
         89vQJmVLTkE8gPlWnx3Z32ZDbKen1qONY1Uuv3DaXLBaOhFV0dWyV73JPbQWwpA2iB5g
         DzODDiJej6G1KM/8tDfgpdc+0ijrlPnSPb7UKKgCnZHaxjZojJscUwzp+ZtTX33cV86z
         0G2cd/yoCqOMnhsFFIEZkRgpDbKfA+7YI7mw5p93uSUz8tNRyrN1lobmVCoStayhHMd3
         7r0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:arc-authentication-results;
        bh=s1SakCgWmR8rClOFWo4H7FpuDacmExEndR+4cMsx3W8=;
        b=GzHXaKKirKHMj8WCBYodwZv0ELM8IlkavY490cXjJe5lCyCq9CIQsOplrKHAYM1B0b
         kNY1/dLPvOyyfzZVQmoiRIoNizWgoPV+SYJJjt20Ga4dHd7PP2iBE96ytN9zNrsVEM/O
         ViMtWMUC/UxIRKc7NguK82slE0m8wr1BtOMaSfXD7iMxOBqaey4GJq2PeGxBQXG+vnw+
         +7/t4OR3RAsSmlKsdtes+t5FJk4Ian38bih2i12hIlj5lqlozdOeXVDX2NCmmwzG/88N
         ukEeDyzYo3SAuqzvnIdBkRTnSTD+c7++u6wSElIOlS0A9ud5YCeRrV4Tw08ANdXR+Wf1
         rEFQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 2a01:238:43f3:0:615b:ee97:1f81:cbf2 is neither permitted nor denied by best guess record for domain of andreas@kemnade.info) smtp.mailfrom=andreas@kemnade.info
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 2a01:238:43f3:0:615b:ee97:1f81:cbf2 is neither permitted nor denied by best guess record for domain of andreas@kemnade.info) smtp.mailfrom=andreas@kemnade.info
Date: Tue, 24 Apr 2018 22:59:48 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: Pavel Machek <pavel@ucw.cz>
Cc: Johan Hovold <johan@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, "H .
 Nikolaus Schaller" <hns@goldelico.com>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH 0/7] gnss: add new GNSS subsystem
Message-ID: <20180424225948.4d6a121c@aktux>
In-Reply-To: <20180424201318.GA14390@amd>
References: <20180424163458.11947-1-johan@kernel.org>
	<20180424201318.GA14390@amd>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/iUOIrxxr_190Pw+bytR+Egf"; protocol="application/pgp-signature"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598647061282688193?=
X-GMAIL-MSGID: =?utf-8?q?1598662739757211708?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--Sig_/iUOIrxxr_190Pw+bytR+Egf
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 24 Apr 2018 22:13:19 +0200
Pavel Machek <pavel@ucw.cz> wrote:

> Hi!
>=20
> > This series adds a new subsystem for GNSS receivers (e.g. GPS
> > receivers). =20
>=20
> Actually... I'd just call it GPS subsystem. Yes, GPS is a bit
> misleading, but so is GNSS. We'd like Loran to use similar interface,
> right? We'd like to QZSS to use similar interface, too...
>=20
> https://www.pcworld.com/article/205325/japan_launches_its_first_gps_satel=
lite.html
> . QZSS is not _global_ positioning system. Still they call it GPS. I'd
> call it GPS too.
>=20
> (Alternatively, we could have drivers/position and /dev/pos0...)
>=20
> Looking closer... I'm not sure if it makes sense to push different
> protocols (SiRF, NMEA, ...) through one device. Userland should know
> what protocol to expect... Yes, there will be common code between
> /dev/nmea0 and /dev/sirf0...
>=20
> I don't know. I'd really like to see '/dev/input/event0'-like layer,
> so that userland would not need to know about different protocols. But
> your work solves some problems we have now...
>=20
I am not really sure what to do here. The question is if we can remove
nmea parsing from userspace if the kernel does it? There is the
use-case of having external loggers storing nmea data and userspace
will access the logger data and needs to have nmea parsing for that
anyway.

But for other more exotic stuff, it would be helpful that the user
space does not need to handle the differences.

Hmm, maybe userspace could register something like uinput devices for
having more complex calculation. Maybe triangulating using gsm cell
reception data. And the uinput-like device would have properties
attached like accuracy, costs.

Regards,
Andreas

--Sig_/iUOIrxxr_190Pw+bytR+Egf
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE7sDbhY5mwNpwYgrAfb1qx03ikyQFAlrfmsQACgkQfb1qx03i
kyRDKBAAwBRhpKL96WTkI+XgVKGr/Px9/pFXz0+YP5+lKoRV/8F9K/EBgjvKCBCg
OjHQU95fi06/XrtK9nCCysKrzsitZWKCmocb3gBbRoAzVCQrtBclfCfkgAZuDvY0
U80v2+lk8fqW4l9JKK2mYXed9nJBMRqbp8YXRHD72JafNHhrIdMQgT7GnlHLej2R
uWDSMpavD9koAbGV+3zvdt39jeMRwkOYVIa8W6j+p/OA78QXVxwOZh9r77SqJXq3
GR+jSNzGn4Y0zo75F8V12gZd/DnDF/uz3eDv/IEmYxa7BB0vJD6262pc5FRzuztd
xC5wEzPBJxsIIjXs568WfiVOgSQ0qToYeZLSh0li00dEObGvJo6cwdNXDX3LgFsG
cVtAJnLj7H9Qe6smiAnWMFGVl8oYa8ulgjMbviBX+YabkORb16LCrfEnPKEXA9xM
jKOYatE6BMtG2HfsfdyA8/25m2DDQ7z9ATlF6pzRJBCxFw2M9O1ZbCwE/yS4s/9U
RA88dr388kcqGOtnSzWp6RRycOPBUlTCXavSA2U147XFUYjOnAxclfkPU6nevB0G
lthNx5nZainInki5+vB738dOAb2EkTUVYqRwfBPEcIB2OsYbXQSOzemnXFXo3Mo6
AY5sf5nfZDZFeZ6tsJxvLe9XWMkg7V/lepcJLGxskkhK1yFuGkQ=
=x7d4
-----END PGP SIGNATURE-----

--Sig_/iUOIrxxr_190Pw+bytR+Egf--

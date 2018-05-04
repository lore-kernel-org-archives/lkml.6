Return-Path: <sebastian.reichel@collabora.co.uk>
X-Google-Smtp-Source: AB8JxZqyH9HlR2p555Bs2LQ2UeGuNbFaSJKaJ/f4VjMJgxQZnQC5mL2WW1nzTzOd3WvgKwzZkSxP
ARC-Seal: i=1; a=rsa-sha256; t=1525440465; cv=none;
        d=google.com; s=arc-20160816;
        b=ECYB3bdPlU4f1bi5vzu22/ovHxmRcZ/EiT6wUATJ2yA56ZQSsJZ/uCNARy+UfTq+nN
         irSckNyu1fwoHaWTHDtiLiZz2H6VV7Ho1LY/FT+hhtOvK8qOG0gxZmS+Q1UGfwxNCZZ0
         sZ/v0UgDqboTp1CYEAPxCP+ShG+tDOKqS3envFZRjsvBg29TUl3hLiFUpJZ4GWny/+uI
         wKRzxXEnSz0IOupaRPvXbGgWjSV8HiAaL0qFTHysm1FaqxQTTJh7am7iuvnWwHs1KJLu
         9FdISWe8r4B9GunGLbd43H4N7tRH6dVIif9ZVf6RcPwwfrmp+jYe4fsfeDioUHx0hti7
         yaLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=mrM/xJIN2da9c9jDkvzoG02hPI4giPjQjDYJ0pDtHH8=;
        b=QP3Gb5KKOv9FEzsWaVjVPJ0vVbr3D/VpOMEh6FhDdxbMaQ6EFfN5cgkPHp7K3gsNEO
         erkTEkIR+N70e8yJPYHmp+LG1ze2r4XBctm1+hHXBbqItNFcD/FlFz2DoD8RqIgDVS+C
         Qa2jq5DkAiTHrD5K8obXi+e/JSg8ZXqySd14ohl+/pvZgtZ7vm945yTv4EofJ7LgQY+V
         gjB+vnZEzlu7008dCRww0h1MYwDnSJ9qJRaE3TAFMT+amKUjWBL4Yp5q3JIZlih5+2OM
         ulTpCCYgzrDYYtX66hdWOGLO78d8nBhqFOckoy/glAiAE1izX9A1AagCc2hZH5ScVPAS
         tEVw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of sebastian.reichel@collabora.co.uk designates 46.235.227.227 as permitted sender) smtp.mailfrom=sebastian.reichel@collabora.co.uk;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=collabora.co.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of sebastian.reichel@collabora.co.uk designates 46.235.227.227 as permitted sender) smtp.mailfrom=sebastian.reichel@collabora.co.uk;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=collabora.co.uk
Date: Fri, 4 May 2018 15:27:41 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Andreas Kemnade <andreas@kemnade.info>,
	Arnd Bergmann <arnd@arndb.de>,
	"H . Nikolaus Schaller" <hns@goldelico.com>,
	Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 0/7] gnss: add new GNSS subsystem
Message-ID: <20180504132741.brn5jqv5ufjhp7ky@earth.universe>
References: <20180424163458.11947-1-johan@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="smpsuold57ovmvb7"
Content-Disposition: inline
In-Reply-To: <20180424163458.11947-1-johan@kernel.org>
User-Agent: NeoMutt/20180323
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598647061282688193?=
X-GMAIL-MSGID: =?utf-8?q?1599540260649175959?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--smpsuold57ovmvb7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Johan,

On Tue, Apr 24, 2018 at 06:34:51PM +0200, Johan Hovold wrote:
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
>=20
> Note that the character-device interface provides raw access to whatever
> protocol the receiver is (currently) using, such as NMEA 0183, UBX or
> SiRF Binary. These protocols are expected to be continued to be handled
> by user space for the time being, even if some hybrid solutions are also
> conceivable (e.g. to have kernel drivers issue management commands).
>
> This will still allow for better platform integration by allowing GNSS
> devices and their resources (e.g. regulators and enable-gpios) to be
> described by firmware and managed by kernel drivers rather than
> platform-specific scripts and services.
>    =20
> While the current interface is kept minimal, it could be extended using
> IOCTLs, sysfs or uevents as needs and proper abstraction levels are
> identified and determined (e.g. for device and feature identification).
>=20
> Another possible extension is to add generic 1PPS support.
>=20
> I decided to go with a custom character-device interface rather than
> pretend that these abstract GNSS devices are still TTY devices (e.g.
> /dev/ttyGNSS0). Obviously, modifying line settings or reading modem
> control signals does not make any sense for a device using, say, a
> USB (not USB-serial) or iomem interface. This also means, however, that
> user space would no longer be able to set the line speed to match a new
> port configuration that can be set using the various GNSS protocols when
> the underlying interface is indeed a UART; instead this would need to be
> taken care of by the driver.
>=20
> Also note that writes are always synchronous instead of requiring user
> space to call tcdrain() after every command.
>=20
> This all seems to work well-enough (e.g. with gpsd), but please let me
> know if I've overlooked something which would indeed require a TTY
> interface instead.
>=20
> As proof-of-concept I have implemented drivers for receivers based on
> two common GNSS chipsets (SiRFstar and u-blox), but due to lack of
> hardware these have so far only been tested using mockup devices and a
> USB-serial-based GPS device (using out-of-tree code). [ Let me know if
> you've got any evalutation kits to spare. ]
>=20
> Finally, note that documentation (including kerneldoc) remains to be
> written, but hopefully this will not hinder review given that the
> current interfaces are fairly self-describing.

Great work. I like your design decisions. I have quite a few devices
with have non-serial based GPS peripherals using binary protocols (*).
As far as I can see it should be possible to add support for those.

I have one concern, though. While providing raw data by
default is fine generally, it is a problem with device
auto-discovery. I think there should be some IOCTL from
the start, that can be used to inform userspace about
the raw protocol being used (i.e. "NMEA"). I fear, that
userspace may start to just assume raw =3D NMEA without
having this (especially since all initial drivers provide
NMEA).

(*) I have those in mind:

Nokia N900: The phone has GPS integrated into the modem and uses
ISI encapsulated data. The protocol has been reverse engineered
and it should be possible to write a kernel driver for handling
the GPS packets and dumping the raw data to /dev/gnss0. I don't
think this is particularly useful without a non-raw interface,
though. It would still require a custom userspace implementation.

Nokia N950/N9: Those phones have an I2C connected BCM4751, which
uses (proprietary, non-reverse-engineered) MEIF binary protocol.
Nokia's kernel had a driver, which provides a similar userspace
interface (char device with raw data from chip).

Droid 4: GPS is similar to N900, but different protocol and QMI
encapsulated. This one also has known protocol with userspace
implementation. I did not yet have a detailed look, if its possible
to (un)wrap this in the kernel.

-- Sebastian

--smpsuold57ovmvb7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlrsX8oACgkQ2O7X88g7
+prCNw//YWja9CZJXLW6bo7ByVpordi+pb9a0N0aftm11G2BqL9jQBSgzjeFktqb
1k8b6qlT4Qb+ScYd/Nqv3l4Z1nEbqN3O26LeLeiTPQtQbApdFS/E7JEuzktRNTTg
Nl/QaBHB5TIVZ8VxeaxcjazhzmknsrRl8xQK1WfXZNDry7w7M00V7/F347IVAFl1
l28ryF4HkdVZyeerfmzYX1Oa741ybc+kmI1F75vvqJNtgptCeIsC9VMDvTJv8zqH
jM+tEBINsEFiB1ZmYXAtgDc0Idbirqq6fPbr+qKNCky3HqXGxMoRQw27B9e/aju+
uzMC2vToFp6CanDtsJbKFKXZ56GI9g18SuOF9yi/OJzt+O77DzmumFvuUEnBP/U7
5aWZ7GEd/4p83Jgx4IcpgQA9kObvafjdHx7qGwrKm+Dua7mPx/GA20QkRYRnkl+W
H2KltC1FmNrVDUAOKa5MhiT1nedk2JtbpM3s1GNR408iPdDCmsnmb3wsVE8FnYqm
cJBwSu26zuoCD6CAzSOcH42ds1tF8SRGrROqA8z9e7gIagtBgcFsC2IM/jkNr1Jb
xex4+A5h+ACct2oCRAuZjo7hQ1dQqRvoPV+V+lq+FRJ/yFyH4LlGYdw2dJeZaQFN
lN8CzgP6SszwEIeoJu3lgHOJLSjhN8DCnXmP6JWE3l98T/t4nIo=
=Pd53
-----END PGP SIGNATURE-----

--smpsuold57ovmvb7--

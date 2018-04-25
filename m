Return-Path: <marcel@holtmann.org>
X-Google-Smtp-Source: AIpwx4/fEkqlXJ/pb+lPbwIuK1yssMk1iSODUh5xPcGGafComXo9/seYMgvEU1t28XpUbfmfMX8R
ARC-Seal: i=1; a=rsa-sha256; t=1524638990; cv=none;
        d=google.com; s=arc-20160816;
        b=BrF0cRKBIfR8MjvhbSuKhK1z6Fejh52xvnoyHb7mvJoU0R+ZWwttCOpqWN6SWl8kfH
         tvUUXMiedlBVypnA/KgmHgk+/c0iF6kZFkA+xvhgeFuYoAvN6HHg2cIWFckbxUpKybfD
         IumwRC6Sd/T1DSjWzaMcELnhR0q3xVapS2NW6xzWkDZEt9zwHbvRF3ClDSXY8Cb17Ro+
         1oc78K19uBebOoNy0wRD3X18VkAkW8Btkyx2dWAMx2FCAOBWIKB2rAoDEHzrhW54acDF
         XgqF8S50WjXknDgly2oBvvxZ+npx5lg+CXDI99f8ldr7VUkBTi/cY8WysilbQ9+HSjHC
         +cEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:arc-authentication-results;
        bh=pwn8u7CtNiN8qZW7WxmDlvmDRoRE4vEXaxpKJwcpcGw=;
        b=bhYkPqm9uFMBGGNv1Ky5E/HsUftGzpEUHDQ6OskfWLR5ouPvT6B2s9rJ6PSOjK94i7
         8rkTUPIsh3Bn71zj4QBeQmmzrDrTJhly/Uy1nyeOdgRjvOxzMaNQgYjYWXULaM/VS6BY
         1NlBHIr6sP6XhS/vLQ16ugbUI9lT6zdjEBCpUIqctgVSqK7XVKiePcRwTQ7JtbBbwVZZ
         BepGcK4tzurq0C/WOAmlFvZBQiffP5Dl0xRsS+Ic+CiethcyQilhB1LCO+X2cUsGC5Hs
         XaywLZAA7ietcLIUcDEgVyP6NneH0QeFPSvAauqSnLqi7X+WNy0tAf6W5ZRC9+P8WR2X
         Nmyw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of marcel@holtmann.org designates 212.227.132.17 as permitted sender) smtp.mailfrom=marcel@holtmann.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of marcel@holtmann.org designates 212.227.132.17 as permitted sender) smtp.mailfrom=marcel@holtmann.org
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: [PATCH 0/7] gnss: add new GNSS subsystem
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180424201318.GA14390@amd>
Date: Wed, 25 Apr 2018 08:49:49 +0200
Cc: Johan Hovold <johan@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Andreas Kemnade <andreas@kemnade.info>,
 Arnd Bergmann <arnd@arndb.de>,
 "H . Nikolaus Schaller" <hns@goldelico.com>,
 linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <5C928A70-2E4C-443D-A4F9-AACBF164C4BE@holtmann.org>
References: <20180424163458.11947-1-johan@kernel.org>
 <20180424201318.GA14390@amd>
To: Pavel Machek <pavel@ucw.cz>
X-Mailer: Apple Mail (2.3445.6.18)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598647061282688193?=
X-GMAIL-MSGID: =?utf-8?q?1598699854340267423?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Pavel,

>> This series adds a new subsystem for GNSS receivers (e.g. GPS
>> receivers).
>=20
> Actually... I'd just call it GPS subsystem. Yes, GPS is a bit
> misleading, but so is GNSS. We'd like Loran to use similar interface,
> right? We'd like to QZSS to use similar interface, too=E2=80=A6

GNSS is the term that is known and used by everybody in the industry to =
identify GPS, GLONASS, Galileo etc.

> =
https://www.pcworld.com/article/205325/japan_launches_its_first_gps_satell=
ite.html
> . QZSS is not _global_ positioning system. Still they call it GPS. I'd
> call it GPS too.
>=20
> (Alternatively, we could have drivers/position and /dev/pos0...)
>=20
> Looking closer... I'm not sure if it makes sense to push different
> protocols (SiRF, NMEA, ...) through one device. Userland should know
> what protocol to expect... Yes, there will be common code between
> /dev/nmea0 and /dev/sirf0=E2=80=A6

Device node naming is pointless, use DEVTYPE uevent property for =
identifying the expected protocol.

Regards

Marcel

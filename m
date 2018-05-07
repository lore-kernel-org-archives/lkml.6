Return-Path: <jhovold@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525688457; cv=none;
        d=google.com; s=arc-20160816;
        b=JggVayz2nHherZ50qEFmSM3x0WlW2uuxJFPuNWCZVRJbPLJvevSILHPRi9BsfpxH8L
         YmkOtPHa0YS2KKAPBwBgy+PsHfDcelXeFAUjN7sibFd4SC472u0Djfo893RzOut70OIy
         jTgIyz36TaZ5aMFodY4qhtStDmjueMewmxvBKSwK1O9UcPczKHoa8U047YGePUdP8DQ5
         Xt+1gkSzvCCVoDgRO4XOnZDkxJ/ICgnqaLZfWyNfe8XrvgMSwgVdQM8b0DgFmoyOUTX9
         PGodF5EF4E0kq2DqnPbHAxmLYGkbPtCRMCcrvyKESl6C1qdcKNslIASQsdCfmVeedZ7/
         ocSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:sender:dkim-signature
         :arc-authentication-results;
        bh=j1WqSkgg5qsE4dq8bYgUdpxDHufXN3CxgJMGETrol4E=;
        b=khWGkFbLkoFbQZ0bvHwHFfadtw85zBSX+py/ExYATpvprmSHOpM5UxFGpYrw/Pers7
         UtKsorZBoMneJhpLe8MMS90bruLm58fbWYDhP+p7RyY+uMj1JY8gA/aERj0O8/iN5jFD
         48qqUGMoFOpA2WkZGAqE8+IjM271NloUaZGJKTgSFYdQocwGkAhuDSj74xJFU44L4MLY
         Hdqp6IsP1iFjBpVNyiJMg2f0K22pBzUdxbb83OyApK4lmoWQjZghHZr3wGc7FRlz7vi+
         zlRqXehP2EcMZNgmddaUuQbagtZJyheTEfzzSLRi94Psrj9c1U8CnoESOCkI1PxdmG9e
         b2Ow==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=j0vy1NQv;
       spf=pass (google.com: domain of jhovold@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=jhovold@gmail.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=j0vy1NQv;
       spf=pass (google.com: domain of jhovold@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=jhovold@gmail.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
X-Google-Smtp-Source: AB8JxZoHJBIY2m8eghNLPshI6BdGX3kU21WO/kh2GxtXTIElJRy3Vk6huHiqAJ/VhllY3bJ/PIUSvQ==
Sender: Johan Hovold <jhovold@gmail.com>
Date: Mon, 7 May 2018 12:20:56 +0200
From: Johan Hovold <johan@kernel.org>
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Johan Hovold <johan@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Andreas Kemnade <andreas@kemnade.info>,
	Arnd Bergmann <arnd@arndb.de>,
	"H . Nikolaus Schaller" <hns@goldelico.com>,
	Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 0/7] gnss: add new GNSS subsystem
Message-ID: <20180507102056.GU2285@localhost>
References: <20180424163458.11947-1-johan@kernel.org>
 <20180504132741.brn5jqv5ufjhp7ky@earth.universe>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180504132741.brn5jqv5ufjhp7ky@earth.universe>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598647061282688193?=
X-GMAIL-MSGID: =?utf-8?q?1599800300251008499?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, May 04, 2018 at 03:27:41PM +0200, Sebastian Reichel wrote:
> Hi Johan,
> 
> On Tue, Apr 24, 2018 at 06:34:51PM +0200, Johan Hovold wrote:
> > This series adds a new subsystem for GNSS receivers (e.g. GPS
> > receivers).
> > 
> > While GNSS receivers are typically accessed using a UART interface they
> > often also support other I/O interfaces such as I2C, SPI and USB, while
> > yet other devices use iomem or even some form of remote-processor
> > messaging (rpmsg).
> >     
> > The new GNSS subsystem abstracts the underlying interface and provides a
> > new "gnss" class type, which exposes a character-device interface (e.g.
> > /dev/gnss0) to user space. This allows GNSS receivers to have a
> > representation in the Linux device model, something which is important
> > not least for power management purposes and which also allows for easy
> > detection and (eventually) identification of GNSS devices.
> > 
> > Note that the character-device interface provides raw access to whatever
> > protocol the receiver is (currently) using, such as NMEA 0183, UBX or
> > SiRF Binary. These protocols are expected to be continued to be handled
> > by user space for the time being, even if some hybrid solutions are also
> > conceivable (e.g. to have kernel drivers issue management commands).

> Great work. I like your design decisions. I have quite a few devices
> with have non-serial based GPS peripherals using binary protocols (*).
> As far as I can see it should be possible to add support for those.

Thanks! Yeah, the aim here was to abstract the actual I/O interface
used.

> I have one concern, though. While providing raw data by
> default is fine generally, it is a problem with device
> auto-discovery. I think there should be some IOCTL from
> the start, that can be used to inform userspace about
> the raw protocol being used (i.e. "NMEA"). I fear, that
> userspace may start to just assume raw = NMEA without
> having this (especially since all initial drivers provide
> NMEA).

One problem I see here would be that the driver does not necessarily
know either what protocol is currently being used. Some devices have
boot-pins which can be used to configure the initial protocol used (and
this could perhaps be reflected in DT), but this can often later be
changed (by user space) and even be made persistent using battery-backed
ram or eeproms.

Also note that at least u-blox devices supports having more than one
protocol active on the same port...

Thanks,
Johan

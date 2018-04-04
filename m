Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751451AbeDDOlr (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 10:41:47 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53270 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751247AbeDDOlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 10:41:45 -0400
Date: Wed, 4 Apr 2018 15:41:19 +0100
From: Mark Brown <broonie@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Tim Harvey <tharvey@gateworks.com>, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-watchdog@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 2/4] mfd: add Gateworks System Controller core driver
Message-ID: <20180404144119.GD7691@sirena.org.uk>
References: <1522250043-8065-1-git-send-email-tharvey@gateworks.com>
 <1522250043-8065-3-git-send-email-tharvey@gateworks.com>
 <CAJ+vNU3-gaTcMAzo5wB6oSfE-JQC3NBVRJS5zFMTE-nVpD4F5g@mail.gmail.com>
 <20180403164715.GA5676@lunn.ch>
 <CAJ+vNU31f+iY5LOG6QmdJetb=pPvY_gpKoS+49FSy70U1Ksd8g@mail.gmail.com>
 <20180404131239.GD20869@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5gxpn/Q6ypwruk0T"
Content-Disposition: inline
In-Reply-To: <20180404131239.GD20869@lunn.ch>
X-Cookie: An idle mind is worth two in the bush.
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5gxpn/Q6ypwruk0T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 04, 2018 at 03:12:39PM +0200, Andrew Lunn wrote:
> > What about the 'reset' functionality? Is there something in the power
> > supply API for hooking in a GPIO based power switch (in my case it
> > would be i2c) as I would think that would be common for ATX supplies?
> > I didn't see anything in Documentation/power.

> > This is what led me to the restart handler idea. Ultimately when
> > someone issues a 'reboot' I would like it to use the GSC to
> > power-cycle the board.

> I think you end up with the same problem. By the time you need to turn
> the power supply off, too much of the kernel is shut down to be able
> to use I2C. And if you are in the middle of an Oops, you have no idea
> of the current state. Another I2C transaction could be under way etc.
> All the current reset drivers are pretty much self contained, atomic
> and use KISS hardware like a GPIO.

> Maybe you best bet is to see if you can find any other I2C PMICs which
> the kernel supports.

Most systems have a handshake for final power down via asserting signals
rather than using register writes, the final power down sequence usually
runs way after software.  There's a few things that don't which just
unceremoniously cut the power earlier on without completing the full
power down sequence which for all practical purposes mostly works.

--5gxpn/Q6ypwruk0T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrE5A4ACgkQJNaLcl1U
h9DgoAf+NlREIN0n4GCyKvQf462pdjqt/gmnsC2BNEK8Mj1EUiX+m6x776go5EtQ
1Ss8tiBw6FqizVl/UEreGaSKAla/G3ksf4WXY8Y1DLnh86vLF13njlSFTSTUd+9I
R+FuERcjkksvH47j2+xhznMf8gTSrlzJnnuWPjqfFXMlGCeOIdeiNpg/CzcTYnBD
q2SZYWYAaqA9fJ8rc6ZDealK5U1cnCzyZiJCqGDBHtl3PgmZWFXjHAMfM86MfY9p
2yur6ADSkx9kOwe20LA8aZGcU9EZzAhiRakUm4d/ovXH+w+faj+rt+UH943uabZW
8i7kHaRzOBsVCA11FgDYY14UcJcXDQ==
=3nwB
-----END PGP SIGNATURE-----

--5gxpn/Q6ypwruk0T--

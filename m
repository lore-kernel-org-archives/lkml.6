Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 567CBECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 10:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16E7A20673
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 10:12:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16E7A20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728364AbeGTK7m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 06:59:42 -0400
Received: from sauhun.de ([88.99.104.3]:55854 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727518AbeGTK7l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 06:59:41 -0400
Received: from localhost (p54B33241.dip0.t-ipconnect.de [84.179.50.65])
        by pokefinder.org (Postfix) with ESMTPSA id 0BE525E000F;
        Fri, 20 Jul 2018 12:12:07 +0200 (CEST)
Date:   Fri, 20 Jul 2018 12:12:06 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Peter Rosin <peda@axentia.se>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        linux-i2c@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Przemyslaw Sroka <psroka@cadence.com>,
        Arkadiusz Golec <agolec@cadence.com>,
        Alan Douglas <adouglas@cadence.com>,
        Bartosz Folta <bfolta@cadence.com>,
        Damian Kos <dkos@cadence.com>,
        Alicja Jurasik-Urbaniak <alicja@cadence.com>,
        Cyprian Wronka <cwronka@cadence.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        Rafal Ciepiela <rafalc@cadence.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vitor Soares <Vitor.Soares@synopsys.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiang Lin <Xiang.Lin@synaptics.com>,
        linux-gpio@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>,
        Przemyslaw Gaj <pgaj@cadence.com>
Subject: Re: [PATCH v6 00/10] Add the I3C subsystem
Message-ID: <20180720101206.tv7nsoanwo5ftnia@ninjato>
References: <20180719152930.3715-1-boris.brezillon@bootlin.com>
 <CAK8P3a2MP5+oFz--e+BM24D8Ahw7H_RKgN1S6wY1nQE6JL0dmw@mail.gmail.com>
 <2ab0ab75-2df0-2714-f007-c33b25481016@axentia.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="buglsqpmzc2gtcib"
Content-Disposition: inline
In-Reply-To: <2ab0ab75-2df0-2714-f007-c33b25481016@axentia.se>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--buglsqpmzc2gtcib
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> I have not read much of the I3C spec. I'm just coming from the
> current situation with I2C and the i2c-demux-pinctrl driver which
> tries to retrofit this into the I2C world and is not doing a grand
> job. And how could it?
>=20
> If you can acknowledge that i2c-demux-pinctrl is needed for I2C
> but for some reason is not needed for I3C because of something
> that differs between I2C and I3C, then fine, by all means ditch
> the explicit bus object.
>=20
> But in my mind splitting up the devices on the same bus between
> several of our own masters and then not have a single object for
> the bus is going to cause headaches down the line. Be it address
> clashes or trouble with master ping-pong or whatever.
>=20
> I think the reason for i2c-demux-pinctrl is that some (most?) I2C
> hardware suffers from quirks and one way to work around it is to
> make selected accesses from a different master. I expect I3C HW
> to also suffer from quirks...
>=20
> Maybe a bit-bang I3C master isn't feasible for some fundamental
> reason? But if it is, then I'd say that it's just a matter of time
> until someone finds a situation where such a thing could be used to
> work around some I3C quirk. And then it might be too expensive to
> always use the bit-bang master for the affected device.
>=20
> But what do I know? Don't let me hold this series back...

Thanks, Peter. You nailed it, the I2C use case (and its limits). From
what I know about I3C, bit-banging doesn't sound very feasible to me, so
the situation might be a bit different. Still, no one knows about future
I3C use cases and HW quirks. This is why I encouraged the seperate bus
object because back then it was said it was easy to do and implement. If
this now becomes a show-stopper, we can surely re-decide. I am not
strong on this point, it was just something which would have helped I2C.
(And for that matter, we (=3D the Renesas Upstream Kernel Team) was
discussing something similar to the i2c demuxer for SPI, too. We have
multiple IP cores which can do SPI on R-Car, all with their pros and
cons)


--buglsqpmzc2gtcib
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAltRtXYACgkQFA3kzBSg
KbbC3g//Qw+XT9Q0C+cSSYBwENIyyKVec3nsbrnekmC6VqMsApKNsdiQQUhkS7pe
VFvc/3SOfmOhL791jwZ63MPvhhG00mGs1xL1jsoDql0xNcnodTbOFM61iIhJQQs2
uCr1xqHtQotCuUm3B1wcd4a1+adZePRwmT7o5jQL8jbPQBMZJDea/NphOEq5ewAI
rN6/P+CynS3NL1QaHV3fZKTSzd/vkWjDRXj19maT0FLyGfOvA5/hMtj0XQzfgJI+
iArvUIX8fZ7lkCPia/3tjsMkwpgCMHlbdWKsysbFl/Zr1ocVT5IappqbolvfZTwX
4QXnOtjEDY+AOfjrSXXlsjaFgnVqX+wFWk9MSpQmL95Yy2JImdjt50wUam3FPHFJ
sjCDfyu2ueefmzichetpDG0gu++kJSIRis0jOgsB2BVQ0Ak0Z6yvFK7rzHNssB8U
EXdS302fj+HV75O7H6ynN1dmBk4f5Xpw+X/3i6IQ3QUIAReVgc7s6JRq+3/Z0Npb
tNXjYUROJN4PZr1XqOC/8nMzEe3A2s+q5EkjBHUko1rfyq7vo1KqN5HkEjNlYwbR
Cf6ksivMfiWHHts94f6EhDTxMnWbkKdCR3ZfxSKQtXcVnh4MyZNAQggcszNmHhXz
iMymQYq7uYzAq1McBTP7vpBGzOK+kzwHZzcWl4y84AlaVP1oRbI=
=o7ro
-----END PGP SIGNATURE-----

--buglsqpmzc2gtcib--

Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB56DC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 07:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 755B0208D5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 07:40:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 755B0208D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755027AbeFRHkd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 03:40:33 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:54514 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753825AbeFRHkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 03:40:31 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id E45B6804D8; Mon, 18 Jun 2018 09:40:29 +0200 (CEST)
Date:   Mon, 18 Jun 2018 09:40:23 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Tony Lindgren <tony@atomide.com>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, sre@kernel.org, nekit1000@gmail.com,
        mpartap@gmx.net, merlijn@wizzup.org
Subject: Re: Charge counter on droid 4
Message-ID: <20180618074023.GA16955@amd>
References: <20180615080014.GA29192@amd>
 <20180615083156.GA32102@amd>
 <20180618065827.GN112168@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Content-Disposition: inline
In-Reply-To: <20180618065827.GN112168@atomide.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > Droid 4 has non-removable battery, yet the charge counter is reset to
> > > near zero on each boot of linux.
>=20
> Not sure if we actively do anything to reset it. I'm guessing
> it's the Motorola bootloader that resets everything on boot.

Too bad if that's the case :-(.

> > > Unfortunately, that makes charge counter pretty much useless on d4, as
> > > the "battery full" and "battery empty" limits will be different during
> > > each boot.
>=20
> From what I've seen also the stock kernel starts only with
> voltage based estimate initially after a reboot?
>=20
> > Hmm, and could we refrain from providing "power" values?
> >=20
> > I was thinking great, we have hardware that does proper power
> > measuerement for us. No.... it is driver providing synthetic
> > values. As userland has enough information to do that itself, I
> > believe we should not do this in kernel.
>=20
> Hmm I don't follow you, why would we want to remove these as
> they implement a standard sysfs interface?
>=20
> I use the sysfs interface all the time to monitor the power
> consumption and the output seems to match what I was seeing
> with my power supply.

So... there are mA, mAh values. Those come from hardware, and I
believe we should keep them.

But there are also mW, mWh values, which are synthetic. Userland can
compute them from mV, mA values... and it is confusing that kernel
provides them. (My tendency was to start computing these synthetic
values in userland, to compare them with "real hardware" values from
kernel. But then I looked at kernel implementation, and realized they
are synthetic, tooo...)

Best regards,
								Pavel
							=09
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlsnYecACgkQMOfwapXb+vI8DgCfXpZie5mE0eDnV65Ea3Jl7bDs
SZEAnRqWBqQ4gDyheZgFQ2te0nyW0Rqj
=Wn1S
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--

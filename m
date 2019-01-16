Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C9E2C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61DC1206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:55:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404136AbfAPKzl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 05:55:41 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:57346 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731772AbfAPKzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 05:55:41 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 09D7A80829; Wed, 16 Jan 2019 11:55:31 +0100 (CET)
Date:   Wed, 16 Jan 2019 11:55:37 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dachaac@gmail.com, robh+dt@kernel.org
Subject: Re: [PATCH v2 2/2] leds: lp50xx: Add the LP50XX family of the RGB
 LED driver
Message-ID: <20190116105537.GA1803@amd>
References: <20190114211723.11186-1-dmurphy@ti.com>
 <20190114211723.11186-2-dmurphy@ti.com>
 <ce911fdf-c7c2-63e8-5c7a-b0be965ab69b@gmail.com>
 <20190115222223.GA17363@amd>
 <79394d17-3124-75b2-ccac-dc1046499d14@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="fUYQa+Pmc3FrFX/N"
Content-Disposition: inline
In-Reply-To: <79394d17-3124-75b2-ccac-dc1046499d14@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> On 1/15/19 4:22 PM, Pavel Machek wrote:
> > Hi!
> >=20
> >>> +The 24-bit RGB value passed in follows the pattern 0xXXRRGGBB
> >>> +XX - Do not care ignored by the driver
> >>> +RR - is the 8 bit Red LED value
> >>> +GG - is the 8 bit Green LED value
> >>> +BB - is the 8 bit Blue LED value
> >>> +
> >>> +Example:
> >>> +LED module output 4 of the LP5024 will be a yellow color:
> >>> +echo 0xe6de00 > /sys/class/leds/lp5024\:led4_mod/color
> >>> +
> >>> +LED module output 4 of the LP5024 will be dimmed 50%:
> >>> +echo 0x80 > /sys/class/leds/lp5024\:led4_mod/brightness
> >>> +
> >>> +LED banked RGBs of the LP5036 will be a white color:
> >>> +echo 0xffffff > /sys/class/leds/lp5036\:led_banked/color
> >>
> >> This part with example cans remain in Documentation/leds if you
> >>> like.
> >=20
> > Does it actually work like that on hardware?
>=20
> What?

If you do echo 0xffffff > /sys/class/leds/lp5036\:led_banked/color,
does it actually produce white? With all the different RGB modules
manufacturers can use with lp5024P?

If you do echo 0xe6de00 > /sys/class/leds/lp5024\:led4_mod/color, does
it actually produce yellow, with all the different RGB modules
manufacturers can use with lp5024P?

> > Is it supposed to support "normal" RGB colors as seen on monitors?
>=20
> Monitors are not an application for this part.

You did not answer the question. When you talk about yellow, is it
same yellow the rest of world talks about?

> > Because 100% PWM on all channels does not result in white on hardware
> > I have.
>=20
> I don't know I am usually blinded by the light and have no diffuser over
> the LEDs to disperse the light so when I look I see all 3 colors.

How can we have useful discussion about colors when you don't see the
colors?

Place a piece of paper over the LEDs....

> > But...
> >=20
> > I believe we should have a reasonable design before we do something
> > like this. There's no guarantee someone will not use lp50xx with just
> > the white LEDs for example. How will this work? Plus existing hardware
> > already uses three separate LEDs for RGB LED. Why not provide same
> > interface?
>=20
> Which existing hardware?  Are they using this part?

Nokia N900. They are not using this part, but any interface we invent
should work there, too.

> <rant>
> Why are we delaying getting the RGB framework or HSV in?
> I would rather design against something you want instead of having
> everyone complain about every implementation I post.
> </rant>

Because you insist on creating new kernel interfaces, when existing
interfaces work, and are doing that badly.

Because your patches are of lower quality than is acceptable for linux
kernel.

Because you don't seem to be reading the emails.

I sent list of requirements for RGB led support. This does not meet
them.

> It is not a normal RGB driver.  The device collates the individual RGB
> clusters into a single brightness register and you can modify the intensi=
ty of the individual
> LEDs via other registers.  If brightness is 0 then the cluster is OFF reg=
ardless of the color
> set in the individual registers.

I understand that. So just set cluster brightness to 255 and you have
normal RGB driver you can control with existing interfaces. You don't
have to use every feature your hardware has.

You did not answer the "what if someone uses this with all white LEDs"
question.

You know what? First, submit driver with similar functionality to
existing RGB drivers, using same interface existing drivers are
using. When that is accepted, we can talk about extending
kernel<->user interfaces.

Thanks,
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--fUYQa+Pmc3FrFX/N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlw/DagACgkQMOfwapXb+vIoVgCfedc0OSdbNGb0hlloqu6krDpU
X6oAn3s2wHVdp1ECg7vpxXdJOQUskULQ
=APCk
-----END PGP SIGNATURE-----

--fUYQa+Pmc3FrFX/N--

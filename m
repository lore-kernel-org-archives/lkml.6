Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 528DAC282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 23:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 299D92171F
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 23:03:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbfA1XD5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 18:03:57 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:58917 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbfA1XD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 18:03:56 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id C6496801AD; Tue, 29 Jan 2019 00:03:45 +0100 (CET)
Date:   Tue, 29 Jan 2019 00:03:51 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dachaac@gmail.com, robh+dt@kernel.org
Subject: Re: RGB LED class Re: [PATCH v2 2/2] leds: lp50xx: Add the LP50XX
 family of the RGB LED driver
Message-ID: <20190128230351.GA5728@amd>
References: <20190114211723.11186-1-dmurphy@ti.com>
 <20190114211723.11186-2-dmurphy@ti.com>
 <ce911fdf-c7c2-63e8-5c7a-b0be965ab69b@gmail.com>
 <20190115222223.GA17363@amd>
 <79394d17-3124-75b2-ccac-dc1046499d14@ti.com>
 <20190116105537.GA1803@amd>
 <86299268-3202-814a-134b-04bd2170faab@ti.com>
 <8dfa2854-2814-6874-ab8e-1858e9a18acf@gmail.com>
 <20190118000235.GB27661@amd>
 <b7ee7c2b-0878-962c-71ee-3ef281f6de0f@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="XsQoSWH+UP9D9v3l"
Content-Disposition: inline
In-Reply-To: <b7ee7c2b-0878-962c-71ee-3ef281f6de0f@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > First, I think we want to decide if RGB LED should be presented as
> > 3 LEDs or as 1 LED... and what to do with existing RGB leds being
> > presented as 3 LEDs.
>=20
> What do we do with RGBW drivers?  Like the LP5562.  RGB can be grouped as=
 a single
> LED but does the white LED get grouped too or should it register as a new=
 LED?
>=20
> I am assuming the answer is that it would register as a new LED.

We could extend this to more than three channels, and specify "color"
for each channel. We could probably specify wavelength for
monochromatic LEDs and color temperature for white LEDs....

> >     pwm_channels -- "1000 240 300" -- "red part should be full on, green
> >     should be pwm controlled to 240/1000, blue should be 300/1000"
> >=20
>=20
> Why 1000?  Why not based on a duty cycle percentage and let the LED drive=
r figure out
> what that means to the device?
>=20
> pwm_channels -- "100 24 30" -- red part is full on 100%, green is 24% dut=
y cycle and
> blue is 30% duty cycle.

Percentage would work, too. Having base of 1000 (not 100) gives a bit
more precision.

> >     pwm_white -- "1000 500 400" -- tells userspace what to write to PWM
> >     channels to get approximately white color.
> >=20
>=20
> Same as above on the duty cycle.
>=20
> But I still am in disagreement with the kernel detailing what is white or=
 how to
> achieve white.
>=20
> Based on my earlier email about light pipes and the LED vendors and aging=
 I think product
> developers will need to fine tune what is "white" on their product from u=
ser space or even a DT node.
>

Yes, this needs to be in the DT and kernel needs to expose it to
userspace in sysfs.

> >     This would assume that RGB LEDs are always pwm controlled. That
> >     seems to be true for hardware I seen.
> >=20
>=20
> GPIO LEDs can be binary or use PWM depending on what is needed.
>=20
> >     + no complex math in kernel
>=20
> We can eliminate the math if we use the "color" file that was proposed an=
d pass in absolute
> hex/decimal numbers for color.

No you can't.

> >     + userspace knows enough to display arbitrary colors
> >=20
> >     + userspace can use full range of available PWM intensities
> >=20
>=20
> Do we need a pwm_max file to indicate to the user space what the max valu=
es of the pwm
> is for each color?

Maybe. I'd assume brightness_max would be equal to max pwm.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--XsQoSWH+UP9D9v3l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlxPilcACgkQMOfwapXb+vJrzACglsQtnLzislwoPMC/iz16rLlf
xZ8AnjMk2zkKk3dfNb9eCcvZR1xQQHWg
=9b19
-----END PGP SIGNATURE-----

--XsQoSWH+UP9D9v3l--

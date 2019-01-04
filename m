Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 829C7C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 20:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57249218E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 20:43:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbfADUn6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 15:43:58 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:59377 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbfADUn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 15:43:58 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id EE234808B8; Fri,  4 Jan 2019 21:43:48 +0100 (CET)
Date:   Fri, 4 Jan 2019 21:43:53 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Vesa =?iso-8859-1?B?SuTkc2tlbORpbmVu?= <dachaac@gmail.com>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Dan Murphy <dmurphy@ti.com>, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: Re: [PATCH 2/2] leds: lp5024: Add the LP5024/18 RGB LED driver
Message-ID: <20190104204353.GB2931@amd>
References: <20181219201047.GA23448@amd>
 <fd624cc1-9997-1cd5-c5cc-62e6897997cf@ti.com>
 <54f28115-0a7d-8e9c-3bec-6e91fb3981ec@gmail.com>
 <cd90f179-6c16-823f-496f-27f141e9c322@ti.com>
 <a72c11c0-949b-bdbc-df2c-4490e04a1065@gmail.com>
 <986b5105-2fdb-bd25-7c8a-ca8fd1ade821@gmail.com>
 <7f205102-e854-f1cb-cc03-1307d1cddc87@gmail.com>
 <c9f8965a-90f4-b456-8225-c70694c9f071@gmail.com>
 <20190103233425.GA10071@amd>
 <e99036ea-ffb6-83ab-726b-824e2557d161@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="b5gNqxB1S1yM7hjW"
Content-Disposition: inline
In-Reply-To: <e99036ea-ffb6-83ab-726b-824e2557d161@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--b5gNqxB1S1yM7hjW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >And... LEDs are linear-enough as it is. That is not a problem. But RGB
> >does _not_ expect linear response. That's why colors are _way_ off curre=
ntly.
>=20
> Example what I was given was some LEDs are off for let's say 20% of PWM
> linearity and then there is non-linear curve for PWM value vs. intensity
> (this was in context of white LCD backlight).

Well, we'll do non-linear curve calibration if we have to.=20

> As such I have nothing against adding support for HSL or other color space
> based brightness calculations. It might just need to be configurable what
> kind of mode is being used based on hardware solution in place. HSL seem =
to
> need a bit of fixed point math. Got floating point version working already
> but that does not work with kernel space so one needs to adapt it to fixed
> point.

First, we need _some_ kind of solution. Then we can decide kernel
vs. library. We can do floats in kernel too, if really required.

> One problem here is to figure out is if user configures some color -- is =
it
> configured with 100% brightness eg. Should one calculate RGB->HSL and then
> scale L with brightness and calculate RGB back for setting color -- or do=
es
> it mean replacing L with brightness value?

I don't understand the question here.

> Additional problem is then if you have let's say yellow LED color element
> there. How would one scale that then? Linear is of course easy. If you ne=
ed
> to configure this to some color space then how does one define the color =
in
> device tree so that such color space conversion is possible? One possible
> solution is to calibrate the curve (like what you do with LCD calibration)
> and then just assume brightness as linear brightness value in that
> case.

Calibrated curves would be nice...

For leds, you should be able to list the wavelength, right?

> Or if you have multi-color LED with red and green but no other color
> elements. How does brightness scaling work with this one?

I'd ignore that for now.

> >You say it is "rather slow" to change all 3 colors. How long does it
> >take, and how long do you need it to take?
>=20
> Some times in embedded linux systems you can see "stalls" in operation of=
 an
> application flow eg. time is spent in different places. I believe "slowes=
t"
> CPU with embedded linux we are using is Atmel's AT91 series (ARM9) and
> executing code in there can at times be a bit time consuming.
>=20
> I have seen delays like 18ms in TI's AM335x CPU series (Cortex-A8) and not
> even too high load situations (eg. breaking some serial protocols because=
 of
> breaks in transmission in-between transfer without being a problem in
> application code as such). It is completely different story when there is=
 a
> bit of load in system or some special situation in the kernel/OS.
>=20
> Running high priority thread for configuring LEDs to avoid problems sounds
> like a wrong solution.
>=20
> Co-worker of mine tried multi-color LED brightness sliding from user space
> with current PWM led driver and it was visible from eye that it was not
> timed smoothly.

Ok, 18msec is _way_ higher than sysfs overhead (like 400x?). If you
have slow i2c or something, then you'll get fun stuff, no matter what
the kernel<->user interface.

> For PWM controlled multi-color LEDs we don't yet have a solution. We need
> configurable color kernel based blinking.

> If we could figure out acceptable solution for color transition problem t=
hen
> I suppose all parties would be happy?

If you can get LEDs to display the colors in similar way monitors do,
that will be major step forward. Then we can design the rest, or maybe
ressurect the HSV patch.

									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--b5gNqxB1S1yM7hjW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlwvxYkACgkQMOfwapXb+vLJyACfVIxWUSZNjTS1skHNlO9AeGs6
GvQAn0V5zaq+uqu9zEDVdxxoZQh9Ujcp
=g1uI
-----END PGP SIGNATURE-----

--b5gNqxB1S1yM7hjW--

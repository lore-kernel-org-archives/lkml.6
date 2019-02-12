Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5C68C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 12:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E55120821
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 12:10:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729370AbfBLMKg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 07:10:36 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:35853 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727553AbfBLMKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 07:10:35 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id E657D80416; Tue, 12 Feb 2019 13:10:25 +0100 (CET)
Date:   Tue, 12 Feb 2019 13:10:32 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-pm@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v3 09/11] leds: max77650: add LEDs support
Message-ID: <20190212121032.GC25613@amd>
References: <20190201094736.32057-1-brgl@bgdev.pl>
 <20190201094736.32057-10-brgl@bgdev.pl>
 <78b99abb-f367-1533-0690-8da26957a664@gmail.com>
 <d86adc21-627f-0350-72e0-f6f10b023413@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="L6iaP+gRLNZHKoI4"
Content-Disposition: inline
In-Reply-To: <d86adc21-627f-0350-72e0-f6f10b023413@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--L6iaP+gRLNZHKoI4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!


> >> +static struct max77650_led *max77650_to_led(struct led_classdev *cdev)
> >> +{
> >> +=A0=A0=A0 return container_of(cdev, struct max77650_led, cdev);
> >> +}
> >> +
> >> +static int max77650_led_brightness_set(struct led_classdev *cdev,
> >> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 en=
um led_brightness brightness)
> >> +{
> >> +=A0=A0=A0 struct max77650_led *led =3D max77650_to_led(cdev);
> >> +=A0=A0=A0 int val, mask;
> >> +
>=20
> The register value and bits are only 8 bit why an int?

int is word size CPU prefers. It is ok here. If you force u8, it may
actually result in slower/bigger code.
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--L6iaP+gRLNZHKoI4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlxit7gACgkQMOfwapXb+vKeagCfQs/Zi7YeXVV37ZRpXicN7R20
JloAnjwl9w6tDCPswwMDR4nDGMl3RHJ7
=L2XV
-----END PGP SIGNATURE-----

--L6iaP+gRLNZHKoI4--

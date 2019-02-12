Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B738C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 12:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A2E420842
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 12:17:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728995AbfBLMRt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 07:17:49 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:36101 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbfBLMRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 07:17:48 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id B37BD8041A; Tue, 12 Feb 2019 13:17:39 +0100 (CET)
Date:   Tue, 12 Feb 2019 13:17:46 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-pm@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v3 10/11] input: max77650: add onkey support
Message-ID: <20190212121745.GE25613@amd>
References: <20190201094736.32057-1-brgl@bgdev.pl>
 <20190201094736.32057-11-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ZInfyf7laFu/Kiw7"
Content-Disposition: inline
In-Reply-To: <20190201094736.32057-11-brgl@bgdev.pl>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZInfyf7laFu/Kiw7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> +	error =3D device_property_read_string(dev,
> +					    "maxim,onkey-mode", &mode_prop);
> +	if (error)
> +		mode_prop =3D "push";
> +
> +	if (strcmp(mode_prop, "push") =3D=3D 0)
> +		mode =3D MAX77650_ONKEY_MODE_PUSH;
> +	else if (strcmp(mode_prop, "slide") =3D=3D 0)
> +		mode =3D MAX77650_ONKEY_MODE_SLIDE;
> +	else
> +		return -EINVAL;
=2E..
> +	onkey->input->name =3D "max77650_onkey";
> +	onkey->input->phys =3D "max77650_onkey/input0";
> +	onkey->input->id.bustype =3D BUS_I2C;
> +	input_set_capability(onkey->input, EV_KEY, onkey->code);

Is EV_KEY correct for mode=3D=3Dslide?


--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--ZInfyf7laFu/Kiw7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlxiuWkACgkQMOfwapXb+vL97gCfeIC+c5OV205NgupxrKvuj5CO
0kQAoI+IbZw8GC/aKAaDgtbl6y75BUXl
=skQG
-----END PGP SIGNATURE-----

--ZInfyf7laFu/Kiw7--

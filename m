Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E880C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 11:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26FBD2080D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 11:54:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728790AbfBLLyY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 06:54:24 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:35265 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbfBLLyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 06:54:24 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 57C2F80405; Tue, 12 Feb 2019 12:54:14 +0100 (CET)
Date:   Tue, 12 Feb 2019 12:54:20 +0100
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
Subject: Re: [PATCH v3 02/11] dt-bindings: power: supply: add DT bindings for
 max77650
Message-ID: <20190212115420.GA24296@amd>
References: <20190201094736.32057-1-brgl@bgdev.pl>
 <20190201094736.32057-3-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="2fHTh5uZTiUOsy+g"
Content-Disposition: inline
In-Reply-To: <20190201094736.32057-3-brgl@bgdev.pl>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> diff --git a/Documentation/devicetree/bindings/power/supply/max77650-char=
ger.txt b/Documentation/devicetree/bindings/power/supply/max77650-charger.t=
xt
> new file mode 100644
> index 000000000000..f3e00d41e299
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/max77650-charger.txt
> @@ -0,0 +1,27 @@
> +Battery charger driver for MAX77650 PMIC from Maxim Integrated.
> +
> +This module is part of the MAX77650 MFD device. For more details
> +see Documentation/devicetree/bindings/mfd/max77650.txt.
> +
> +The charger is represented as a sub-node of the PMIC node on the device =
tree.
> +
> +Required properties:
> +--------------------
> +- compatible:		Must be "maxim,max77650-charger"
> +
> +Optional properties:
> +--------------------
> +- maxim,vchgin-min:	Minimum CHGIN regulation voltage (in microvolts). Mu=
st be
> +			one of: 4000000, 4100000, 4200000, 4300000, 4400000,
> +			4500000, 4600000, 4700000.
> +- maxim,ichgin-lim:	CHGIN input current limit (in microamps). Must be on=
e of:
> +			95000, 190000, 285000, 380000, 475000.

We already have richtek,min-input-voltage-regulation and
ti,minimum-sys-voltage and ti,in-dpm-voltage.

This is not too consistent with with the rest.. and perhaps common
name should be used for those?

See also ti,current-limit. That seems to be direct match.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlxis+wACgkQMOfwapXb+vKIhACeIPSWDImPg0l/iknWEe1ACf1K
vXQAoL3d0cJ0+UOQ1AuSYm/A8jYVz8XN
=gprt
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--

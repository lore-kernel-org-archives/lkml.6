Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB26C004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 09:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6124B207DD
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 09:04:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6124B207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbeJXRbk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 13:31:40 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:48946 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727607AbeJXRbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 13:31:40 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 4DB9E807F1; Wed, 24 Oct 2018 11:04:21 +0200 (CEST)
Date:   Wed, 24 Oct 2018 11:04:21 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     robh+dt@kernel.org, jacek.anaszewski@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, lee.jones@linaro.org, tony@atomide.com
Subject: Re: [PATCH v4 2/7] dt-bindings: ti-lmu: Modify dt bindings for the
 LM3697
Message-ID: <20181024090421.GB24997@amd>
References: <20181023170623.31820-1-dmurphy@ti.com>
 <20181023170623.31820-2-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="/NkBOFFp2J2Af1nK"
Content-Disposition: inline
In-Reply-To: <20181023170623.31820-2-dmurphy@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/NkBOFFp2J2Af1nK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> The LM3697 is a single function LED driver. The single function LED
> driver needs to reside in the LED directory as a dedicated LED driver
> and not as a MFD device.  The device does have common brightness and ramp

So it is single function LED driver. That does not mean it can not
share bindings with the rest. Where the bindings live is not imporant.

> reside in the Documentation/devicetree/bindings/leds directory and follow=
 the
> current LED and general bindings guidelines.

What you forgot to tell us in the changelog:

> +Optional child properties:
> +	- runtime-ramp-up-msec: Current ramping from one brightness level to
> +				the a higher brightness level.
> +				Range from 2048 us - 117.44 s

The other binding uses "ramp-up-msec". Tell us why you are changing this, or
better don't change things needlessly.

We don't want to be using "runtime-ramp-up-msec" for one device and
"ramp-up-msec" for the other.

I'm not sure what other changes you did, and changelog does not tell
me.

> --- a/Documentation/devicetree/bindings/mfd/ti-lmu.txt
> +++ b/Documentation/devicetree/bindings/mfd/ti-lmu.txt
> @@ -9,7 +9,6 @@ TI LMU driver supports lighting devices below.
>    LM3632       Backlight and regulator
>    LM3633       Backlight, LED and fault monitor
>    LM3695       Backlight
> -  LM3697       Backlight and fault monitor
> =20
>  Required properties:
>    - compatible: Should be one of:

NAK. You can use existing binding.

									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--/NkBOFFp2J2Af1nK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvQNZUACgkQMOfwapXb+vLFrQCePprM1e0VfDEX433UAglIWdwL
N9wAn1JtNbW8lF43Y5o8u6F4uxfI7yfy
=JVUJ
-----END PGP SIGNATURE-----

--/NkBOFFp2J2Af1nK--

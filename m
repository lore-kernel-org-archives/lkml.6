Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80FAEC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 09:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B0B8208E8
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 09:55:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B0B8208E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbeHXN3O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 09:29:14 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:35143 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbeHXN3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 09:29:14 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 43E6383D5E; Fri, 24 Aug 2018 11:55:18 +0200 (CEST)
Date:   Fri, 24 Aug 2018 11:55:15 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     robh+dt@kernel.org, jacek.anaszewski@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: Re: [PATCH v5 1/2] dt-bindings: leds: Add bindings for lm3697 driver
Message-ID: <20180824095515.GB4045@amd>
References: <20180817151528.21623-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="XF85m9dhOBO43t/C"
Content-Disposition: inline
In-Reply-To: <20180817151528.21623-1-dmurphy@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XF85m9dhOBO43t/C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2018-08-17 10:15:27, Dan Murphy wrote:
> Add the device tree bindings for the lm3697
> LED driver for backlighting and display.
>=20
> Signed-off-by: Dan Murphy <dmurphy@ti.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

Some nits are below.

> +The LM3697 11-bit LED driver provides high-
> +performance backlight dimming for 1, 2, or 3 series
> +LED strings while delivering up to 90% efficiency.

LED core is 8-bit only... so full dynamic range can not be currently
used in linux -- right? Is there any plan to change/fix that?

> +This device is suitable for Display and Keypad Lighting

"display and keypad lighting."

> +Optional properties:
> +	- enable-gpios : gpio pin to enable/disable the device.

Remove "." at end of sentence, for consistency. "GPIO"?

> +All HVLED strings controlled by control bank A

":"?

> +led-controller@36 {
> +	compatible =3D "ti,lm3967";
> +	reg =3D <0x36>;
> +	#address-cells =3D <1>;
> +	#size-cells =3D <0>;
> +
> +	enable-gpios =3D <&gpio1 28 GPIO_ACTIVE_HIGH>;
> +	vled-supply =3D <&vbatt>;
> +
> +	led@0 {
> +		reg =3D <0>;
> +		led-sources =3D <1 1 1>;
> +		label =3D "white:backlight_cluster";
> +		linux,default-trigger =3D "backlight";
> +	};
> +}
> +
> +For more product information please see the link below:
> +http://www.ti.com/lit/ds/symlink/lm3697.pdf

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--XF85m9dhOBO43t/C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlt/1gMACgkQMOfwapXb+vJ7sQCfQERZBzCfSk1cLZSRcQj6SuJw
o9sAn0U3Yg2Pa2vLQIQUWc/jzi5nhnTG
=+Hlr
-----END PGP SIGNATURE-----

--XF85m9dhOBO43t/C--

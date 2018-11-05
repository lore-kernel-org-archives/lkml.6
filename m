Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99444C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 09:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48CE020862
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 09:06:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48CE020862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728918AbeKESYk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 13:24:40 -0500
Received: from mail.bootlin.com ([62.4.15.54]:57515 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbeKESYj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 13:24:39 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 5AC692080A; Mon,  5 Nov 2018 10:05:57 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-93-44.w90-88.abo.wanadoo.fr [90.88.34.44])
        by mail.bootlin.com (Postfix) with ESMTPSA id 294BE2072A;
        Mon,  5 Nov 2018 10:05:47 +0100 (CET)
Date:   Mon, 5 Nov 2018 10:05:47 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jonathan McDowell <noodles@earth.li>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCHv2] ARM: dts: sun8i-h3: Add dts for the Mapleboard MP130
Message-ID: <20181105090547.yuiblwnnpffykilg@flea>
References: <20181030221430.wu5cxicyf4ub2boa@earth.li>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="k2b2il23thni6h4h"
Content-Disposition: inline
In-Reply-To: <20181030221430.wu5cxicyf4ub2boa@earth.li>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--k2b2il23thni6h4h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 30, 2018 at 10:14:30PM +0000, Jonathan McDowell wrote:
> +	r_gpio_keys {
> +		compatible =3D "gpio-keys";
> +		pinctrl-names =3D "default";
> +
> +		power {
> +			label =3D "mp130:power";

That was my mistake, but it was correct in your first version.

> +&pio {
> +	leds_pio: led_pins {
> +		pins =3D "PA15";
> +		function =3D "gpio_out";
> +	};
> +};
> +
> +&r_pio {
> +	leds_r_pio: led_pins {
> +		pins =3D "PL10";
> +		function =3D "gpio_out";
> +	};
> +
> +	sw_r_pio: key_pins {
> +		pins =3D "PL3", "PL4";
> +		function =3D "gpio_in";
> +	};
> +};

You don't need these nodes at all.

I've fixed both issues and applied your patch for 4.21

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--k2b2il23thni6h4h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCW+AH6wAKCRDj7w1vZxhR
xZ1pAP99wHV8qJxv2Oqx5ONDlA3iBdyvnogejYVSfpKcT4j84gEAgAdQrQHd+Ghm
wnTwRrnoU5bumSWH4LV7xz5EV4iq0gI=
=TqgV
-----END PGP SIGNATURE-----

--k2b2il23thni6h4h--

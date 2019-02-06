Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C0AC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 12:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 373AD2073D
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 12:17:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730312AbfBFMRX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 07:17:23 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:43669 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbfBFMRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 07:17:21 -0500
X-Originating-IP: 185.94.189.187
Received: from localhost (unknown [185.94.189.187])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 06B2D60003;
        Wed,  6 Feb 2019 12:17:18 +0000 (UTC)
Date:   Wed, 6 Feb 2019 13:17:18 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH 1/9] pinctrl: sunxi: Support I/O bias voltage setting on
 A80
Message-ID: <20190206121718.3yqbirt5l3qwneco@flea>
References: <20190206033239.3619-1-wens@csie.org>
 <20190206033239.3619-2-wens@csie.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="p6xjb2ugcpauju6t"
Content-Disposition: inline
In-Reply-To: <20190206033239.3619-2-wens@csie.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--p6xjb2ugcpauju6t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 06, 2019 at 11:32:31AM +0800, Chen-Yu Tsai wrote:
> The A80 SoC has configuration registers for I/O bias voltage. Incorrect
> settings would make the affected peripherals inoperable in some cases,
> such as Ethernet RGMII signals biased at 2.5V with the settings still
> at 3.3V. However low speed signals such as MDIO on the same group of
> pins seem to be unaffected.
>=20
> Previously there was no way to know what the actual voltage used was,
> short of hard-coding a value in the device tree. With the new pin bank
> regulator supply support in place, the driver can now query the
> regulator for its voltage, and if it's valid (as opposed to being the
> dummy regulator), set the bias voltage setting accordingly.
>=20
> Add a quirk to denote the presence of the configuration registers, and
> a function to set the correct setting based on the voltage read back
> from the regulator.
>=20
> This is only done when the regulator is first acquired and enabled.
> While it would be nice to have a notifier on the regulator so that when
> the voltage changes, the driver can update the setting, in practice no
> board currently supports dynamic changing of the I/O voltages.
>=20
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--p6xjb2ugcpauju6t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXFrQTgAKCRDj7w1vZxhR
xflmAQDo9Z2Ucw2a5VIK7U4G/w5Xp43v5+NAyHQEt8A/U2QeQwEAlkjlIgausgbj
BAzCfh7mVPw+N3cAja1pOC78yhRs7wk=
=QGuC
-----END PGP SIGNATURE-----

--p6xjb2ugcpauju6t--

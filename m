Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFD39C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 18:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B39D222A1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 18:49:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732563AbfBOStU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 13:49:20 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:39095 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbfBOStU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 13:49:20 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 626A180441; Fri, 15 Feb 2019 19:49:10 +0100 (CET)
Date:   Fri, 15 Feb 2019 19:49:16 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Stefan Mavrodiev <stefan@olimex.com>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Lee Jones <lee.jones@linaro.org>,
        "open list:LED SUBSYSTEM" <linux-leds@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:X-POWERS MULTIFUNCTION PMIC DEVICE DRIVERS" 
        <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 5/8] arm64: dts: allwinner: Enable AXP803 CHGLED for
 Olimex boards
Message-ID: <20190215184916.GA17897@amd>
References: <20190215115013.11098-1-stefan@olimex.com>
 <20190215115013.11098-6-stefan@olimex.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
Content-Disposition: inline
In-Reply-To: <20190215115013.11098-6-stefan@olimex.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2019-02-15 13:50:10, Stefan Mavrodiev wrote:
> Teres-I and A64-OLinuXino commes with populated LED connected
> to AXP803. So to be used as battery indication, pass the LED control
> to the charger itself in mode 0 ( FULL while charging, OFF no battery
> or completed).
>=20
> Signed-off-by: Stefan Mavrodiev <stefan@olimex.com>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts | 6 ++++++
>  arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts   | 6 ++++++
>  2 files changed, 12 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts b/arc=
h/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
> index f7a4bccaa5d4..7d6930319fba 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
> @@ -177,6 +177,12 @@
> =20
>  #include "axp803.dtsi"
> =20
> +&axp_led {
> +	label =3D "a64-olinuxino:yellow:chgled";

There's little chance userspace will recognize this led.

Can you make it "platform:yellow:charging" and fix it for other
boards, too?

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlxnCawACgkQMOfwapXb+vLEAwCfUcSllFtWon2qQkW9JcK3hfq4
aMsAoKwCglaZGvwLk+NVMgYjCe18FLZf
=ftHA
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--

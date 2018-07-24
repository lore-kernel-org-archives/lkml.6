Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 319A0C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 08:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D746E20856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 08:56:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D746E20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388244AbeGXKCR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 06:02:17 -0400
Received: from mail.bootlin.com ([62.4.15.54]:51983 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388149AbeGXKCQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 06:02:16 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id D5043207AD; Tue, 24 Jul 2018 10:56:48 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-78-122.w90-88.abo.wanadoo.fr [90.88.20.122])
        by mail.bootlin.com (Postfix) with ESMTPSA id A5A3F20731;
        Tue, 24 Jul 2018 10:56:38 +0200 (CEST)
Date:   Tue, 24 Jul 2018 10:56:39 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH 2/3] arm64: allwinner: dts: h6: add pinmux for MMC1
Message-ID: <20180724085639.2cebno52qfxrzmdw@flea>
References: <20180724011551.49603-1-icenowy@aosc.io>
 <20180724011551.49603-3-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="m4pt6utzooijv4ko"
Content-Disposition: inline
In-Reply-To: <20180724011551.49603-3-icenowy@aosc.io>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--m4pt6utzooijv4ko
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 24, 2018 at 09:15:50AM +0800, Icenowy Zheng wrote:
> The MMC1 controller on H6, in the reference design and most third party
> design, is used to connect SDIO Wi-Fi.
>=20
> Add pinmux for it.
>=20
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/bo=
ot/dts/allwinner/sun50i-h6.dtsi
> index cfa5fffcf62b..ba1a3a3e2149 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> @@ -134,6 +134,14 @@
>  				bias-pull-up;
>  			};
> =20
> +			mmc1_pins: mmc1-pins {
> +				pins =3D "PG0", "PG1", "PG2", "PG3",
> +				       "PG4", "PG5";
> +				function =3D "mmc1";
> +				drive-strength =3D <30>;
> +				bias-pull-up;
> +			};
> +

Is that the sole muxing option for MMC1? If so, it should be added to
the mmc1 node.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--m4pt6utzooijv4ko
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAltW6cYACgkQ0rTAlCFN
r3QyVQ//cFfd6lGu4M7oL5C0+WEjCcQp83rcd9xC7g+SMavEwmo32v0VkePWN9No
BthJFmngNoSmYAnRXk3K1o4VLfARzvoiMKI5MmR/u8G2bdJ2vZOTEwVpDwWGFklK
S0E0odT7FwOtSjhzGDqt1GO7vWAI7irSREWG0kDrTtX3smjqzxCFcOnZX652pPhE
HoZ95xSyFoCIGxrGjtsovQL6Y55ag0N2bfpg2YW1h3Nwt7FbWyjab8NgomicF1RY
Kx7JKCvoVVMqYDwAkVeaGwo5/ej2oErUmRHlYizbd4iijdQ0dyjRU0ZIIP4Y+Ibu
HY8VzrjS7/9Sfnr28r8YwF3Cr0wtL6UHzzJhj9Nd0f2lZceV34oFW5nSoHxu69ao
WJwe3uQSE9xPgyCGwGmUWUJ7G60fbDsjEhIhagPOpCNmX4BTdGlOTJha811ntwA3
9AT55ACdweU6kd/xjwj2XyHrpURY/7V62Dp/KbJ8r4Q5lEVjFyXtYBnZc8OGQCj0
4/BUR8tkjuFRZcqEj0JjP0QkqM4NHVJ4cHmC4wfd9ADM35CIoXRw36oUS2Xl9mqd
nysQN0IWXmHXkJyURD8ZwJ/I3y2lajM4Dy4jjjiWABJ3EQFSGguDC/vvWdWmFJ7n
QgCxrrsUutgu4bDYrU/c3YKLieBq1nM3gwtXaj3K9FWLGBC3HDs=
=4Scx
-----END PGP SIGNATURE-----

--m4pt6utzooijv4ko--

Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0247C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 12:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D52F208AF
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 12:56:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D52F208AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731568AbeG0OSQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 10:18:16 -0400
Received: from mail.bootlin.com ([62.4.15.54]:36415 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730314AbeG0OSQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 10:18:16 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 0DA1E20893; Fri, 27 Jul 2018 14:56:25 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-89-120.w90-88.abo.wanadoo.fr [90.88.30.120])
        by mail.bootlin.com (Postfix) with ESMTPSA id CAA3A2072C;
        Fri, 27 Jul 2018 14:56:14 +0200 (CEST)
Date:   Fri, 27 Jul 2018 14:56:15 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v3.1 10/10] arm64: dts: allwinner: a64: Enable HDMI
 output on A64 boards w/ HDMI
Message-ID: <20180727125615.ju23ecgm6y4rz7p5@flea>
References: <20180726171257.6688-1-icenowy@aosc.io>
 <20180726171257.6688-11-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3xvit7syelf6yr45"
Content-Disposition: inline
In-Reply-To: <20180726171257.6688-11-icenowy@aosc.io>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3xvit7syelf6yr45
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 27, 2018 at 01:12:57AM +0800, Icenowy Zheng wrote:
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts b/arch/a=
rm64/boot/dts/allwinner/sun50i-a64-pine64.dts
> index 1b9b92e541d2..1b972bade9f6 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
> @@ -62,6 +62,21 @@
>  	chosen {
>  		stdout-path =3D "serial0:115200n8";
>  	};
> +
> +	connector {
> +		compatible =3D "hdmi-connector";
> +		type =3D "a";
> +
> +		port {
> +			hdmi_con_in: endpoint {
> +				remote-endpoint =3D <&hdmi_out_con>;
> +			};
> +		};
> +	};
> +};
> +
> +&de {
> +	status =3D "okay";
>  };
> =20
>  &ehci0 {
> @@ -82,6 +97,17 @@
> =20
>  };
> =20
> +&hdmi {
> +	hdmi-supply =3D <&reg_dldo1>;
> +	status =3D "okay";
> +};
> +
> +&hdmi_out {
> +	hdmi_out_con: endpoint {
> +		remote-endpoint =3D <&hdmi_con_in>;
> +	};
> +};
> +
>  &i2c1 {
>  	pinctrl-names =3D "default";
>  	pinctrl-0 =3D <&i2c1_pins>;
> @@ -99,6 +125,10 @@
>  	};
>  };
> =20
> +&mixer1 {
> +	status =3D "okay";
> +};
> +
>  &mmc0 {
>  	pinctrl-names =3D "default";
>  	pinctrl-0 =3D <&mmc0_pins>;
> @@ -238,6 +268,10 @@
>  	status =3D "disabled";
>  };
> =20
> +&tcon1 {
> +	status =3D "okay";
> +};

Is it working or not on the pine64?

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--3xvit7syelf6yr45
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAltbFm4ACgkQ0rTAlCFN
r3T7LhAAkfFcBA6X1XtL00YHltRxggxIhKJOsMNhjI+FlX+s0zu3VPW3DSmrepgK
ts4cEebJxlaobaHrEvE/fdvscPQgXKQsGvegeboi+jZtRwHF5uHKLxvdlc6dv/rT
d/QpHUGAgTYMsHeS40mHMWkndPM3IAFWW4PNUDazXepHGzc4Y4/joK+Ik0U2uhEK
Wr8U1ArDzkZTL7kEi7bW6WsHUaCWrTK/TjGOMJ/9cstL4i3bzeS19FvMs0Q2/v9/
RLgL9OJDyEz6vxdRXkZTrOI1QyzZr3yEj4/1P8UZihsaysFqje7s14GFaqOXSvVp
I9RJuses8/7MZApuhmnpSmUtui1Zctt/V1TZ6e3u6sCH8GNT5tpsOlSnfox4XiEV
ofx0oTC/xB8CBPogpFObrTy8NSPUut5mkTGc1QpAVwk5/Dw3xbIJzxF0g10uEgxv
mdQVHEpcjA/+c0gBWsg9fjhYJqshyWImiLw6F7VfeyF/tB3j1HJNMYLVZdfrcxkc
5g3bgtLiTcSISv37D8zvkd6Zp7esTmLZVS0jQpm1LxpgF1EoIdZXScmEdRPkFU0D
owbjIyZooZqtC7CID3Z7b0tONNgBrgbOAiqIgB3ZT34vCRtSxv4E9FQfrBf1Dk/6
DBpXKF8w96zcCqdte9AAKr7W3PlwjkpJPNBEGR/gp/i3K1W5Y1g=
=UoNb
-----END PGP SIGNATURE-----

--3xvit7syelf6yr45--

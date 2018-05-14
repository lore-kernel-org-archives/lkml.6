Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932202AbeENPhI (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 11:37:08 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:54478 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752089AbeENPhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 11:37:07 -0400
X-Auth-Info: I53fHRED8/+pqYmvFFLPG4+Jf0j/RCdmcUXwoZ30bY8=
Date: Mon, 14 May 2018 17:36:21 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>, Rob Herring <robh@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] display: panel: Add AUO g070vvn01 display support
 (800x480)
Message-ID: <20180514173621.797c6b8f@jawa>
In-Reply-To: <20180509155913.7562-1-lukma@denx.de>
References: <20180410102927.17787-1-lukma@denx.de>
        <20180509155913.7562-1-lukma@denx.de>
Organization: denx.de
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/bEOFgQ02ac65rt23.KWqx2G"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/bEOFgQ02ac65rt23.KWqx2G
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Dear All,

> This commit adds support for AUO's 7.0" display.

If I may gentle remind about this patch....=20

>=20
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
>=20
> ---
> Changes for v3:
> - Remove not used 'bus-format-override =3D "rgb565";' property
>=20
> Changes for v2:
> - Add *.txt suffix to the auo,g070wn01 file
> ---
>  .../bindings/display/panel/auo,g070vvn01.txt       | 29
> ++++++++++++++++++++
> drivers/gpu/drm/panel/panel-simple.c               | 31
> ++++++++++++++++++++++ 2 files changed, 60 insertions(+) create mode
> 100644
> Documentation/devicetree/bindings/display/panel/auo,g070vvn01.txt
>=20
> diff --git
> a/Documentation/devicetree/bindings/display/panel/auo,g070vvn01.txt
> b/Documentation/devicetree/bindings/display/panel/auo,g070vvn01.txt
> new file mode 100644 index 000000000000..49e4105378f6 --- /dev/null
> +++
> b/Documentation/devicetree/bindings/display/panel/auo,g070vvn01.txt
> @@ -0,0 +1,29 @@ +AU Optronics Corporation 7.0" FHD (800 x 480) TFT
> LCD panel +
> +Required properties:
> +- compatible: should be "auo,g070vvn01"
> +- backlight: phandle of the backlight device attached to the panel
> +- power-supply: single regulator to provide the supply voltage
> +
> +Required nodes:
> +- port: Parallel port mapping to connect this display
> +
> +This panel needs single power supply voltage. Its backlight is
> conntrolled +via PWM signal.
> +
> +Example:
> +--------
> +
> +Example device-tree definition when connected to iMX6Q based board
> +
> +	lcd_panel: lcd-panel {
> +		compatible =3D "auo,g070vvn01";
> +		backlight =3D <&backlight_lcd>;
> +		power-supply =3D <&reg_display>;
> +
> +		port {
> +			lcd_panel_in: endpoint {
> +				remote-endpoint =3D <&lcd_display_out>;
> +			};
> +		};
> +	};
> diff --git a/drivers/gpu/drm/panel/panel-simple.c
> b/drivers/gpu/drm/panel/panel-simple.c index
> cbf1ab404ee7..d9984bdb5bb5 100644 ---
> a/drivers/gpu/drm/panel/panel-simple.c +++
> b/drivers/gpu/drm/panel/panel-simple.c @@ -581,6 +581,34 @@ static
> const struct panel_desc auo_b133htn01 =3D { },
>  };
> =20
> +static const struct display_timing auo_g070vvn01_timings =3D {
> +	.pixelclock =3D { 33300000, 34209000, 45000000 },
> +	.hactive =3D { 800, 800, 800 },
> +	.hfront_porch =3D { 20, 40, 200 },
> +	.hback_porch =3D { 87, 40, 1 },
> +	.hsync_len =3D { 1, 48, 87 },
> +	.vactive =3D { 480, 480, 480 },
> +	.vfront_porch =3D { 5, 13, 200 },
> +	.vback_porch =3D { 31, 31, 29 },
> +	.vsync_len =3D { 1, 1, 3 },
> +};
> +
> +static const struct panel_desc auo_g070vvn01 =3D {
> +	.timings =3D &auo_g070vvn01_timings,
> +	.num_timings =3D 1,
> +	.bpc =3D 8,
> +	.size =3D {
> +		.width =3D 152,
> +		.height =3D 91,
> +	},
> +	.delay =3D {
> +		.prepare =3D 200,
> +		.enable =3D 50,
> +		.disable =3D 50,
> +		.unprepare =3D 1000,
> +	},
> +};
> +
>  static const struct drm_display_mode auo_g104sn02_mode =3D {
>  	.clock =3D 40000,
>  	.hdisplay =3D 800,
> @@ -2095,6 +2123,9 @@ static const struct of_device_id
> platform_of_match[] =3D { .compatible =3D "auo,b133xtn01",
>  		.data =3D &auo_b133xtn01,
>  	}, {
> +		.compatible =3D "auo,g070vvn01",
> +		.data =3D &auo_g070vvn01,
> +	}, {
>  		.compatible =3D "auo,g104sn02",
>  		.data =3D &auo_g104sn02,
>  	}, {




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de

--Sig_/bEOFgQ02ac65rt23.KWqx2G
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAlr5rPUACgkQAR8vZIA0
zr0+MQgArAtQ6d8lcdAVuGNv+jkwYyAzyhnBxEORc4uT7yDaQJOwCZl0TIXdHLrm
wXLj8q4CN6sbwrFosxi5YXaFSeXbo/D4QX+YbY5VSFqSMgfH9XQBIVOIFItmb5Sq
S+pM8d8yhVnVezxGqj93yLAtciOmXracuCFrv6yzT/gP86aCbSf5m0ySdct8rzMQ
fr2LDg00mZKrrQihG+Wt0/RiQ+XGyApRSdeqnLHV0HXOqkXuiAdaopLhIWgMWL3y
Mux5rmY1hfEZsJy9KxvXG/qqTYcbDGUWCzrU4N/o8OiyYAOOVRsV8wJgP6FLm3WA
cmP3lUaim90maOyFCiny/Av/B7n7hg==
=z3az
-----END PGP SIGNATURE-----

--Sig_/bEOFgQ02ac65rt23.KWqx2G--

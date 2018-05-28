Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932074AbeE1H4b (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 03:56:31 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:48856 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753797AbeE1H43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 03:56:29 -0400
X-Auth-Info: EwHn/MtgPmUDRXg4qxpgBKdD39Nb29YVmhNDTESdziE=
Date: Mon, 28 May 2018 09:55:19 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        David Airlie <airlied@linux.ie>, Rob Herring <robh@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] display: panel: Add KOE tx14d24vm1bpa display
 support (320x240)
Message-ID: <20180528095519.799adadc@jawa>
In-Reply-To: <20180519130533.2494bceb@jawa>
References: <20180412143715.6828-1-lukma@denx.de>
        <20180509154338.2841-1-lukma@denx.de>
        <20180519130533.2494bceb@jawa>
Organization: denx.de
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/uuSou+DfeqA05REohC6n9kT"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/uuSou+DfeqA05REohC6n9kT
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

> Hi Thierry,
>=20
> > This commit adds support for KOE's 5.7" display.
> >  =20
>=20
> Thierry, shall I perform some more work on this code, or is it
> eligible for applying to your tree?

Gentle ping. If Thierry is overworked - maybe there is a co-maintainer
so he/she could apply this patch?

>=20
> Best regards,
> =C5=81ukasz
>=20
> > Signed-off-by: Lukasz Majewski <lukma@denx.de>
> > ---
> >  .../bindings/display/panel/koe,tx14d24vm1bpa.txt   | 42
> > ++++++++++++++++++++++
> > drivers/gpu/drm/panel/panel-simple.c               | 26
> > ++++++++++++++ 2 files changed, 68 insertions(+) create mode 100644
> > Documentation/devicetree/bindings/display/panel/koe,tx14d24vm1bpa.txt
> >=20
> > diff --git
> > a/Documentation/devicetree/bindings/display/panel/koe,tx14d24vm1bpa.txt
> > b/Documentation/devicetree/bindings/display/panel/koe,tx14d24vm1bpa.txt
> > new file mode 100644 index 000000000000..be7ac666807b --- /dev/null
> > +++
> > b/Documentation/devicetree/bindings/display/panel/koe,tx14d24vm1bpa.txt
> > @@ -0,0 +1,42 @@ +Kaohsiung Opto-Electronics Inc. 5.7" QVGA (320 x
> > 240) TFT LCD panel +
> > +Required properties:
> > +- compatible: should be "koe,tx14d24vm1bpa"
> > +- backlight: phandle of the backlight device attached to the panel
> > +- power-supply: single regulator to provide the supply voltage
> > +
> > +Required nodes:
> > +- port: Parallel port mapping to connect this display
> > +
> > +This panel needs single power supply voltage. Its backlight is
> > conntrolled +via PWM signal.
> > +
> > +Example:
> > +--------
> > +
> > +Example device-tree definition when connected to iMX53 based board
> > +
> > +	lcd_panel: lcd-panel {
> > +		compatible =3D "koe,tx14d24vm1bpa";
> > +		backlight =3D <&backlight_lcd>;
> > +		power-supply =3D <&reg_3v3>;
> > +
> > +		port {
> > +			lcd_panel_in: endpoint {
> > +				remote-endpoint =3D
> > <&lcd_display_out>;
> > +			};
> > +		};
> > +	};
> > +
> > +Then one needs to extend the dispX node:
> > +
> > +	lcd_display: disp1 {
> > +
> > +		port@1 {
> > +			reg =3D <1>;
> > +
> > +			lcd_display_out: endpoint {
> > +				remote-endpoint =3D <&lcd_panel_in>;
> > +			};
> > +		};
> > +	};
> > diff --git a/drivers/gpu/drm/panel/panel-simple.c
> > b/drivers/gpu/drm/panel/panel-simple.c index
> > d9984bdb5bb5..103b43ce7dee 100644 ---
> > a/drivers/gpu/drm/panel/panel-simple.c +++
> > b/drivers/gpu/drm/panel/panel-simple.c @@ -1268,6 +1268,29 @@ static
> > const struct panel_desc innolux_zj070na_01p =3D { },
> >  };
> > =20
> > +static const struct display_timing koe_tx14d24vm1bpa_timing =3D {
> > +	.pixelclock =3D { 5580000, 5850000, 6200000 },
> > +	.hactive =3D { 320, 320, 320 },
> > +	.hfront_porch =3D { 30, 30, 30 },
> > +	.hback_porch =3D { 30, 30, 30 },
> > +	.hsync_len =3D { 1, 5, 17 },
> > +	.vactive =3D { 240, 240, 240 },
> > +	.vfront_porch =3D { 6, 6, 6 },
> > +	.vback_porch =3D { 5, 5, 5 },
> > +	.vsync_len =3D { 1, 2, 11 },
> > +	.flags =3D DISPLAY_FLAGS_DE_HIGH,
> > +};
> > +
> > +static const struct panel_desc koe_tx14d24vm1bpa =3D {
> > +	.timings =3D &koe_tx14d24vm1bpa_timing,
> > +	.num_timings =3D 1,
> > +	.bpc =3D 6,
> > +	.size =3D {
> > +		.width =3D 115,
> > +		.height =3D 86,
> > +	},
> > +};
> > +
> >  static const struct display_timing koe_tx31d200vm0baa_timing =3D {
> >  	.pixelclock =3D { 39600000, 43200000, 48000000 },
> >  	.hactive =3D { 1280, 1280, 1280 },
> > @@ -2204,6 +2227,9 @@ static const struct of_device_id
> > platform_of_match[] =3D { .compatible =3D "innolux,zj070na-01p",
> >  		.data =3D &innolux_zj070na_01p,
> >  	}, {
> > +		.compatible =3D "koe,tx14d24vm1bpa",
> > +		.data =3D &koe_tx14d24vm1bpa,
> > +	}, {
> >  		.compatible =3D "koe,tx31d200vm0baa",
> >  		.data =3D &koe_tx31d200vm0baa,
> >  	}, { =20
>=20
>=20
> Best regards,
>=20
> Lukasz Majewski
>=20
> --
>=20
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de

--Sig_/uuSou+DfeqA05REohC6n9kT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAlsLtecACgkQAR8vZIA0
zr30kAf+KpgwWHS0I7OcjqPI5qx7PRe3USTs2OQaPPzPrCwmn8mZ4xxUnSdstsYL
jevSWcbfqJHATME4JixqVfVFr3Ux6Ex72q53TowpmCk24jx1yI+ohyLMXxF/JPSU
c61qPQkzY6P7mKPo11PIUlfve492c3XB7yEzAfbbL0rfJDFRGeJZ625yWJSY9x0d
grM9/gOy+rqnB9mJZLnQMiI1uNhWkV/ZQQ/TMEQf6ykP92as9nJ1p2IgI/qywxg2
jwBHGkdWwAJWSr9nAOxFRp0qYq7wTzTtkezaCMWTGPoCpFjzS4PjfFf+rL8ZwS1f
BN1LnATOGzm3qH+Gb5xjlVp5UF3I+g==
=h+0B
-----END PGP SIGNATURE-----

--Sig_/uuSou+DfeqA05REohC6n9kT--

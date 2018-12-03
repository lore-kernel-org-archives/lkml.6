Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7040C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:33:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADFB72145D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:33:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADFB72145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbeLCJeC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 04:34:02 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:42853 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbeLCJeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 04:34:02 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 437fvD1DqBz1qxkG;
        Mon,  3 Dec 2018 10:33:44 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 437fvC6jR4z1qw61;
        Mon,  3 Dec 2018 10:33:43 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id DS0ps5AMs7us; Mon,  3 Dec 2018 10:33:42 +0100 (CET)
X-Auth-Info: q+CBZCsNybzeoxei96YH6J/qfVLomaVA1dHLaCx61uk=
Received: from jawa (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Mon,  3 Dec 2018 10:33:42 +0100 (CET)
Date:   Mon, 3 Dec 2018 10:33:33 +0100
From:   Lukasz Majewski <lukma@denx.de>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Stefan Agner <stefan@agner.ch>,
        Fabio Estevam <festevam@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>
Subject: Re: [PATCH] ARM: dts: Provide support for reading ID code from MVB
 device (BK4)
Message-ID: <20181203103333.111c2463@jawa>
In-Reply-To: <20181126143619.GB31334@dragon>
References: <20181113121213.14296-1-lukma@denx.de>
        <20181126143619.GB31334@dragon>
Organization: denx.de
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/4OQ7RAQWdTkk1qF09dh+./Q"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/4OQ7RAQWdTkk1qF09dh+./Q
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Shawn,

Thank you for the review.

> On Tue, Nov 13, 2018 at 01:12:13PM +0100, Lukasz Majewski wrote:
> > The procedure to read this ID value is as follows:
> >=20
> > rmmod spi_fsl_dspi
> > insmod spi-gpio.ko
> >=20
> > echo 504 > /sys/class/gpio/export
> > cat /sys/class/gpio/gpio504/value
> > ...
> > echo 511 > /sys/class/gpio/export
> > cat /sys/class/gpio/gpio511/value
> >=20
> > rmmod spi-gpio.ko
> > insmod spi_fsl_dspi
> >=20
> > Signed-off-by: Lukasz Majewski <lukma@denx.de>
>=20
> A prefix like 'ARM: dts: vf610-bk4: ...' might be better.

Ok.

>=20
> > ---
> >  arch/arm/boot/dts/vf610-bk4.dts | 31
> > +++++++++++++++++++++++++++++++ 1 file changed, 31 insertions(+)
> >=20
> > diff --git a/arch/arm/boot/dts/vf610-bk4.dts
> > b/arch/arm/boot/dts/vf610-bk4.dts index cab95714c058..f01c735807ae
> > 100644 --- a/arch/arm/boot/dts/vf610-bk4.dts
> > +++ b/arch/arm/boot/dts/vf610-bk4.dts
> > @@ -59,6 +59,29 @@
> >  		regulator-min-microvolt =3D <3300000>;
> >  		regulator-max-microvolt =3D <3300000>;
> >  	};
> > +
> > +	spi_gpio {
>=20
> We recommend hyphen rather than underscore be used in node name.

Ok. I will change it to spi-gpio

>=20
> > +		compatible =3D "spi-gpio";
> > +		pinctrl-0 =3D <&pinctrl_gpio_spi>;
> > +		pinctrl-names =3D "default";
> > +		#address-cells =3D <1>;
> > +		#size-cells =3D <0>;
> > +		/* PTD12 ->RPIO[91] */
> > +		sck-gpios  =3D <&gpio2 27 GPIO_ACTIVE_LOW>;
> > +		/* PTD10 ->RPIO[89] */
> > +		miso-gpios =3D <&gpio2 25 GPIO_ACTIVE_HIGH>;
> > +		num-chipselects =3D <0>;
> > +
> > +		72xx165@0 {
>=20
> Please use a generic name for the node.

This is a bit tricky.

Other DTS definitions for this compatible:

sn65hvs882: sn65hvs882@0 {
	compatible =3D "pisosr-gpio";
	...
	}

They use the exact used IC name - sn65hvs882, which IMHO is the way how
this node shall be described.

The reason is that the compatible is "pisosr-gpio" -> parallel input
serial output shift regsiter - gpio.

By adding the exact name of connected electronic IC - sn65hvs882 and in
my case IC from the 72xx165 family provides good description of the HW.

Maybe you have other idea how to provide the name of the IC connected?

>=20
> Shawn
>=20
> > +			compatible =3D "pisosr-gpio";
> > +			reg =3D <0>;
> > +			gpio-controller;
> > +			#gpio-cells =3D <2>;
> > +			/* PTB18 -> RGPIO[40] */
> > +			load-gpios  =3D <&gpio1 8 GPIO_ACTIVE_LOW>;
> > +			spi-max-frequency =3D <100000>;
> > +		};
> > +	};
> >  };
> > =20
> >  &adc0 {
> > @@ -430,6 +453,14 @@
> >  		>;
> >  	};
> > =20
> > +	pinctrl_gpio_spi: pinctrl-gpio-spi {
> > +		fsl,pins =3D <
> > +			VF610_PAD_PTB18__GPIO_40        0x1183
> > +			VF610_PAD_PTD10__GPIO_89        0x1183
> > +			VF610_PAD_PTD12__GPIO_91        0x1183
> > +		>;
> > +	};
> > +
> >  	pinctrl_i2c2: i2c2grp {
> >  		fsl,pins =3D <
> >  			VF610_PAD_PTA22__I2C2_SCL
> > 0x34df --=20
> > 2.11.0
> >=20




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/4OQ7RAQWdTkk1qF09dh+./Q
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAlwE+G4ACgkQAR8vZIA0
zr2v4gf+JOffL084LxwKXmYrHWohgLSaKYfGDIF/vVmqycfG1bzJIogeI73uM0bY
/9FtgeXd0P0IwRG8ugltg94fEN9itfWDeEHDt0TNvaSdcX0BNM1swp2JHNjINX/P
MdhHOj+geabFXHMahcu7Q5Pchr2u8Jfn0/7hMND9mY5bH5zqFiKlUSuNVuCacBaF
qHPp3TcXvFYnoo0nUKvPhnESvIGoxRHwZE99zpfeiFR15eLvvI5MSTYwsEd3nDNa
Zk78dT0tF3jpskE9bjsJSTXCFkbZuzIbFxHrgKSMCyoBhZZzkHZ91CqoSsLzKA+e
HMbXE1D9sjxiCtP2jBGJzUJKwj+DDA==
=85Ok
-----END PGP SIGNATURE-----

--Sig_/4OQ7RAQWdTkk1qF09dh+./Q--

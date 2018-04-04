Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751247AbeDDHsm (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 03:48:42 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:38267 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750711AbeDDHsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 03:48:40 -0400
X-Auth-Info: 9iXgxgrCDpEr3atFKSVpQ3odpFIzbzMp7rJoSSjdeCk=
Date: Wed, 4 Apr 2018 09:48:26 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Fabio Estevam <festevam@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2] ARM: dts: tpc: Device tree description of the iMX6Q
 TPC board
Message-ID: <20180404094826.36b2b998@jawa>
In-Reply-To: <CAOMZO5BMWtWo6O_qKOsA_27xaReGDGczrujqRW8k23pkwscvDA@mail.gmail.com>
References: <20180403165945.3981-1-lukma@denx.de>
        <CAOMZO5BMWtWo6O_qKOsA_27xaReGDGczrujqRW8k23pkwscvDA@mail.gmail.com>
Organization: denx.de
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/nmmmztlZ7hmKqpB._.hHImE"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/nmmmztlZ7hmKqpB._.hHImE
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Fabio,

Thanks for the feedback,

> Hi Lukasz,
>=20
> On Tue, Apr 3, 2018 at 1:59 PM, Lukasz Majewski <lukma@denx.de> wrote:
>=20
> > diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt
> > b/Documentation/devicetree/bindings/vendor-prefixes.txt index
> > ae850d6c0ad3..8ff7eadc8bef 100644 ---
> > a/Documentation/devicetree/bindings/vendor-prefixes.txt +++
> > b/Documentation/devicetree/bindings/vendor-prefixes.txt @@ -181,6
> > +181,7 @@ karo        Ka-Ro electronics GmbH keithkoep      Keith &
> > Koep GmbH keymile        Keymile GmbH
> >  khadas Khadas
> > +kiebackpeter    Kieback & Peter GmbH =20
>=20
> This should be a separate patch.

Ok.

>=20
> >  kinetic Kinetic Technologies
> >  kingnovel      Kingnovel Technology Co., Ltd.
> >  kosagi Sutajio Ko-Usagi PTE Ltd.
> > diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> > index ade7a38543dc..c148c4cf28f2 100644
> > --- a/arch/arm/boot/dts/Makefile
> > +++ b/arch/arm/boot/dts/Makefile
> > @@ -459,6 +459,7 @@ dtb-$(CONFIG_SOC_IMX6Q) +=3D \
> >         imx6q-icore-ofcap10.dtb \
> >         imx6q-icore-ofcap12.dtb \
> >         imx6q-icore-rqs.dtb \
> > +       imx6q-kp-tpc.dtb \
> >         imx6q-marsboard.dtb \
> >         imx6q-mccmon6.dtb \
> >         imx6q-nitrogen6x.dtb \
> > diff --git a/arch/arm/boot/dts/imx6q-kp-tpc.dts
> > b/arch/arm/boot/dts/imx6q-kp-tpc.dts new file mode 100644
> > index 000000000000..b5646040b516
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/imx6q-kp-tpc.dts
> > @@ -0,0 +1,23 @@
> > +/*
> > + * Copyright 2018
> > + * Lukasz Majewski, DENX Software Engineering, lukma@denx.de
> > + *
> > + * SPDX-License-Identifier: (GPL-2.0+ OR MIT) =20
>=20
> This line should be the first one and start with //

Ok.

>=20
> > + */
> > +
> > +/dts-v1/;
> > +
> > +#include "imx6q-kp.dtsi"
> > +
> > +/ {
> > +       model =3D "Freescale i.MX6 Qwuad K+P TPC Board";
> > +       compatible =3D "kiebackpeter,imx6q-tpc", "fsl,imx6q";
> > +
> > +       memory: memory@10000000 { =20
>=20
> Only memory@10000000 is enough.

Ok.

>=20
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/imx6q-kp.dtsi
> > @@ -0,0 +1,460 @@
> > +/*
> > + * Copyright 2018
> > + * Lukasz Majewski, DENX Software Engineering, lukma@denx.de
> > + *
> > + * SPDX-License-Identifier: (GPL-2.0+ OR MIT) =20
>=20
> Same here.
>=20
> > +       beeper {
> > +               compatible =3D "pwm-beeper";
> > +               pwms =3D <&pwm2 0 500000>; //2kHz =20
>=20
> No // style comments, please.
>=20
> > +       lcd_panel: lcd-panel {
> > +               compatible =3D "auo,g070vvn01"; =20
>=20
> I don't see this compatible string in linux-next.

I've sent support for this display yesterday.

[PATCH] display: panel: Add AUO g070vvn01 display support (800x480)


>=20
> > +&i2c1 {
> > +       clock-frequency =3D <400000>;
> > +       pinctrl-names =3D "default";
> > +       pinctrl-0 =3D <&pinctrl_i2c1>;
> > +       status =3D "okay";
> > +
> > +       goodix_ts@5d {
> > +               compatible =3D "goodix,gt911";
> > +               reg =3D <0x5d>;
> > +               pinctrl-names =3D "default";
> > +               pinctrl-0 =3D <&pinctrl_ts>;
> > +               interrupt-parent =3D <&gpio1>;
> > +               interrupts =3D <9 IRQ_TYPE_EDGE_FALLING>;
> > +               irq-gpios =3D <&gpio1 9 GPIO_ACTIVE_HIGH>;
> > +               reset-gpios =3D <&gpio5 2 GPIO_ACTIVE_HIGH>;
> > +       };
> > +
> > +       rx8025@32 {
> > +               compatible =3D "dallas,rx8025"; =20
>=20
> I don't see this compatible string in linux-next.

Ach... it should be "dallas,ds1307" as it supports also this chip. I
will fix it in v2.


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de

--Sig_/nmmmztlZ7hmKqpB._.hHImE
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAlrEg0oACgkQAR8vZIA0
zr0WyAf/YhvvxahEhRzc0WlrKD87kP5Be7v6bOfiCAglUIh+DT1vfyWjzSq4j+V2
lRNHjDQzUNfOzNu6vhPyMdtiTsRGBObBggw2gSMV8POSAxI+2R39jmmDcsorZCca
bxFfP5tPKSx/PT9OkhcnQdxo27zE1oWfySlDBxKRqWqSdTJRHA85g3S4gVY/4wyc
RwD+IDMmBeYR31WUqJkDOlvMGZZvi4DmqNtUSHJFEFHgCNXazh8ANzTqoZDY9E5k
oN9wF38RNtJGD7SvvN1MaNHTjdEznqZgk20EPeoYkuSLYDdaPFocnoXJTksmVeNX
6xyAiPmgRVtFpiCIxBr65TNZe9ahnw==
=zvnV
-----END PGP SIGNATURE-----

--Sig_/nmmmztlZ7hmKqpB._.hHImE--

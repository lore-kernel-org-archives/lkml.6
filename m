Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB4AC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 19:08:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBEFF20834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 19:08:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBEFF20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbeJZDmh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 23:42:37 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:43740 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbeJZDmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 23:42:37 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id BF24D26024C
Received: by earth.universe (Postfix, from userid 1000)
        id 05A963C0987; Thu, 25 Oct 2018 15:30:18 +0200 (CEST)
Date:   Thu, 25 Oct 2018 15:30:17 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Oskari Lemmela <oskari@lemmela.net>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Quentin Schulz <quentin.schulz@free-electrons.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v5 00/11] AXP8x3 AC and battery power supply support
Message-ID: <20181025133017.2rdnbgmvdlx67kcz@earth.universe>
References: <20181023185330.10472-1-oskari@lemmela.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ix4k4ufla4fevamq"
Content-Disposition: inline
In-Reply-To: <20181023185330.10472-1-oskari@lemmela.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ix4k4ufla4fevamq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Patches 1, 2 & 9 look good to me and do not seem to have any
dependencies. I plan to merge them after the merge window
for 4.20 closes.

-- Sebastian

On Tue, Oct 23, 2018 at 09:53:19PM +0300, Oskari Lemmela wrote:
> AXP813 AC power supply support with input current and
> voltage limiting support.
>=20
> AXP803 AC and battery power supply support.
>=20
> Changes in v5:
> * Return correct input current limit for values 0x6 and 0x7
> * Add specific compatibles for AXP803
> * Change commit messages
> * Add Vasily Khoruzhick Pinebook DTS patch
>=20
> Changes in v4:
> * Change order of axp20x-gpio in axp20x.c
> * Fix indentation and spaces to tabs in axp20x.c
>=20
> Changes in v3:
> * Reorder ac_power_supply DT node
> * Rename axp20x_ac_power_set_property function
> * Split mfd commit=20
>=20
> Changes in v2:
> * Reuse axp813 compatibles for axp803
> * Refactor axp20x_ac_power.c
>=20
> Oskari Lemmela (10):
>   dt-bindings: power: supply: axp20x: add AXP813 AC power DT binding
>   dt-bindings: power: supply: axp20x: add AXP803 power bindings
>   dt-bindings: gpio: gpio-axp209: add AXP803 GPIO bindings
>   dt-bindings: iio: adc: add AXP803 ADC bindings
>   ARM: dts: axp81x: add AC power supply subnode
>   arm64: dts: allwinner: axp803: add AC and battery power supplies
>   arm64: dts: allwinner: a64: sopine-baseboard: enable power supplies
>   power: supply: add AC power supply driver for AXP813
>   mfd: axp20x: Add AC power supply cell for AXP813
>   mfd: axp20x: Add supported cells for AXP803
>=20
> Vasily Khoruzhick (1):
>   arm64: dts: allwinner: a64: pinebook: enable power supplies
>=20
>  .../devicetree/bindings/gpio/gpio-axp209.txt  |  2 +
>  .../bindings/iio/adc/axp20x_adc.txt           |  2 +
>  .../bindings/power/supply/axp20x_ac_power.txt |  4 +
>  .../bindings/power/supply/axp20x_battery.txt  |  1 +
>  arch/arm/boot/dts/axp81x.dtsi                 |  5 +
>  arch/arm64/boot/dts/allwinner/axp803.dtsi     | 33 +++++++
>  .../dts/allwinner/sun50i-a64-pinebook.dts     |  8 ++
>  .../allwinner/sun50i-a64-sopine-baseboard.dts |  8 ++
>  drivers/mfd/axp20x.c                          | 20 ++++
>  drivers/power/supply/axp20x_ac_power.c        | 94 +++++++++++++++++++
>  include/linux/mfd/axp20x.h                    |  1 +
>  11 files changed, 178 insertions(+)
>=20
> --=20
> 2.17.1
>=20

--ix4k4ufla4fevamq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlvRxWcACgkQ2O7X88g7
+pqoYBAAml3HrRrerjuL11bRxxoJSeTc/PBvyYsHevJyPQTmFLHninb0wnrdGOJJ
bGXD4y4w/EPusLhkGCfmVmWuPTPZG4wnf5gJfHBOmFoTOcmjF68ASShpavKbCUH/
WEMp8mYT+o2eCSWbIuKrEb+6T+PI3ue8i+LpEx4B9i5nb2qg69zR//V1YP7CRK0E
rp1YUX4cIuBzxGSyi3SEbJGFOhrHeckCeWAvPi8DDlP7pXssO2qquAkb2tGzvJNF
UUz3JVlB4MOWNxhscTZIzQ2GDKGrcKNqqwK+PFPt5ewvr3bY/tJcmGc+IBPcrqls
zWPeex8tincMb5o6f4HuBwK0EDIR4wlne88km/OSRaW065wSE6xF377IlUmEkdam
1PNPYbGr6hckdATIgNeMtNPsd8b13zNQGWYcp718+lPo+Bbmqb5sYh8whU80s734
h6JIbfv5H4kr/r/4qcW13QU991bz6o0cMCmw9m0IikR5WI/PGL+Lu3R4u3jPU/+U
iCFNr5/oPBPBTg9epvSf9tGqu1PlbZtxJN2T5vpf67KKaUKczdb4+b86ZDxMcTAe
/ruSHYohiS3FD1JGT/S/s0cn0Q5qsN3pRMOaBnuaMgD/YIQpAPMmnD3xVCLg+3wD
ymj/0XhXTMnAXvNdasIVofcNuUmX/VtCEgCb0A/gJGiPTo9+xNA=
=0RM0
-----END PGP SIGNATURE-----

--ix4k4ufla4fevamq--

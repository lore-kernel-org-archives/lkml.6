Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754833AbeDCF7v (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 01:59:51 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:39871 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754305AbeDCF7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 01:59:49 -0400
Subject: Re: [PATCH RESEND v6 0/6] provide power off support for iMX6 with
 external PMIC
To: Shawn Guo <shawnguo@kernel.org>, Mark Brown <broonie@kernel.org>
Cc: kernel@pengutronix.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Russell King <linux@armlinux.org.uk>
References: <20180305102524.5905-1-o.rempel@pengutronix.de>
From: Oleksij Rempel <o.rempel@pengutronix.de>
Message-ID: <54c5cb44-b2d9-3dab-59d5-a6a73a957e8c@pengutronix.de>
Date: Tue, 3 Apr 2018 07:59:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180305102524.5905-1-o.rempel@pengutronix.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="gt8JCkXlQCcv9Am5QWMEiuJd727VldRPt"
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:13da
X-SA-Exim-Mail-From: o.rempel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gt8JCkXlQCcv9Am5QWMEiuJd727VldRPt
Content-Type: multipart/mixed; boundary="sN4iAMyDrtBdajReBDrS7us8r321BujXm";
 protected-headers="v1"
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Shawn Guo <shawnguo@kernel.org>, Mark Brown <broonie@kernel.org>
Cc: kernel@pengutronix.de, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Leonard Crestez <leonard.crestez@nxp.com>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@codeaurora.org>, Fabio Estevam <fabio.estevam@nxp.com>,
 Russell King <linux@armlinux.org.uk>
Message-ID: <54c5cb44-b2d9-3dab-59d5-a6a73a957e8c@pengutronix.de>
Subject: Re: [PATCH RESEND v6 0/6] provide power off support for iMX6 with
 external PMIC
References: <20180305102524.5905-1-o.rempel@pengutronix.de>
In-Reply-To: <20180305102524.5905-1-o.rempel@pengutronix.de>

--sN4iAMyDrtBdajReBDrS7us8r321BujXm
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

ping,

this week is a merge window. Any chance to get it in to 4.17?

On 05.03.2018 11:25, Oleksij Rempel wrote:
> This patch series is providing power off support for Freescale/NXP iMX6=
 based
> boards with external power management integrated circuit (PMIC).
> As a first step the PMIC is configured to turn off the system if the
> standby pin is asserted. On second step we assert the standby pin.
> For this reason we need to use pm_power_off_prepare.
>=20
> Usage of stnadby pin for power off is described in official iMX6
> documentation.
>=20
> 2018.03.05:
> As this patch set touches multiple subsystems I think it would make
> sense for Shawn Guo to take the all patch set.
> The only part which didn't receive an ACK is regulator stuff. So I woul=
d
> hope that Mark Brown can ACK it.
>=20
> Kind regards,
> Oleksij Rempel
>=20
> 2017.12.06:
> Adding Linus. Probably there is no maintainer for this patch set.
> No changes are made, tested on v4.15-rc1.
>=20
> 2017.10.27:
> Last version of this patch set was send at 20 Jun 2017, this is a rebas=
e against
> kernel v4.14-rc6. Probably this set got lost. If I forgot to address so=
me comments,
> please point me.
>=20
> changes:
> v6:
>  - rename imx6_pm_poweroff to imx6_pm_stby_poweroff
>  - fix "MPIC_STBY_REQ" typo in the comment.
>=20
> v5:
>  - remove useless includes from pm-imx6.c patch
>  - add Acked-by to "regulator: pfuze100: add fsl,pmic-stby-poweroff pro=
perty"
>    patch
>=20
> v4:
>  - update comment in "regulator: pfuze100: add fsl,pmic-stby-poweroff .=
=2E."
>    patch
>  - add Acked-by to "ARM: imx6q: provide documentation for new ..."
>    patch
>=20
> v3:
>  - set pm_power_off_prepare =3D NULL on .remove.
>  - documentation and spelling fixes.
>  - use %pf instead of lookup_symbol_name.
>=20
>=20
> Oleksij Rempel (6):
>   ARM: imx6q: provide documentation for new fsl,pmic-stby-poweroff
>     property
>   ARM: imx6: register pm_power_off handler if "fsl,pmic-stby-poweroff"
>     is set
>   kernel/reboot.c: export pm_power_off_prepare
>   regulator: pfuze100: add fsl,pmic-stby-poweroff property
>   regulator: pfuze100-regulator: provide pm_power_off_prepare handler
>   ARM: dts: imx6: RIoTboard provide standby on power off option
>=20
>  .../devicetree/bindings/clock/imx6q-clock.txt      |  8 ++
>  .../devicetree/bindings/regulator/pfuze100.txt     |  7 ++
>  arch/arm/boot/dts/imx6dl-riotboard.dts             |  5 ++
>  arch/arm/mach-imx/pm-imx6.c                        | 25 ++++++
>  drivers/regulator/pfuze100-regulator.c             | 92 ++++++++++++++=
++++++++
>  kernel/reboot.c                                    |  1 +
>  6 files changed, 138 insertions(+)
>=20


--sN4iAMyDrtBdajReBDrS7us8r321BujXm--

--gt8JCkXlQCcv9Am5QWMEiuJd727VldRPt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEpENFL0P3hvQ7p0DDdQOiSHVI77QFAlrDGEcACgkQdQOiSHVI
77TNVwf/QUzX/Y60TqqIZfA+LLoW0eRrMgQ/WiPyuW4crhKFDnXqg8sO6iKFX+H3
J4u0S6B+k4kyokXSfZr2Q7bBqegDKNmIrCTMg3uX3EwBDj2Fc5kOrzXykClGz3II
Io9jBhwYrS/DDCNHjTgVoEzYbrQdwsWRBRotqvFC/NKb92jMA4PyaFghOWA2+uJA
05r3d5+AWLs1c+H88m0K43GWHclNSddBRe+AVkPzNTm0UNRFnUZbo79KHxgTPViG
D/2Zk9lq6U8tTwh9rILD1+B76S28OzuaV0jJSFpOZmPQSEIxE8ss7fn8PFdSb3u4
IMUQ2Wgb3U9HGxXhuBykRO2AJZ6uYQ==
=3YBR
-----END PGP SIGNATURE-----

--gt8JCkXlQCcv9Am5QWMEiuJd727VldRPt--

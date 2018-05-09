Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756076AbeEIFGv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 01:06:51 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:43053 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756020AbeEIFGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 01:06:50 -0400
Date: Wed, 9 May 2018 07:06:28 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, kernel@pengutronix.de,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 2/6] ARM: imx6: register pm_power_off handler if
 "fsl,pmic-stby-poweroff" is set
Message-ID: <20180509050628.csbusplowpvmmiwa@pengutronix.de>
References: <20180305102524.5905-1-o.rempel@pengutronix.de>
 <20180305102524.5905-3-o.rempel@pengutronix.de>
 <20180508124033.GL16141@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="soqpjcx3im3qprt5"
Content-Disposition: inline
In-Reply-To: <20180508124033.GL16141@n2100.armlinux.org.uk>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-IRC: #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 07:01:48 up 138 days, 17:39, 70 users,  load average: 0.68, 0.23,
 0.07
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--soqpjcx3im3qprt5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 08, 2018 at 01:40:33PM +0100, Russell King - ARM Linux wrote:
> On Mon, Mar 05, 2018 at 11:25:19AM +0100, Oleksij Rempel wrote:
> > One of the Freescale recommended sequences for power off with external
> > PMIC is the following:
> > ...
> > 3.  SoC is programming PMIC for power off when standby is asserted.
> > 4.  In CCM STOP mode, Standby is asserted, PMIC gates SoC supplies.
> >=20
> > See:
> > http://www.nxp.com/assets/documents/data/en/reference-manuals/IMX6DQRM.=
pdf
> > page 5083
> >=20
> > This patch implements step 4. of this sequence.
> >=20
> > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > ---
> >  arch/arm/mach-imx/pm-imx6.c | 25 +++++++++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> >=20
> > diff --git a/arch/arm/mach-imx/pm-imx6.c b/arch/arm/mach-imx/pm-imx6.c
> > index ecdf071653d4..24689260a2a5 100644
> > --- a/arch/arm/mach-imx/pm-imx6.c
> > +++ b/arch/arm/mach-imx/pm-imx6.c
> > @@ -604,6 +604,28 @@ static void __init imx6_pm_common_init(const struc=
t imx6_pm_socdata
> >  				   IMX6Q_GPR1_GINT);
> >  }
> > =20
> > +static void imx6_pm_stby_poweroff(void)
> > +{
> > +	imx6_set_lpm(STOP_POWER_OFF);
> > +	cpu_suspend(0, imx6q_suspend_finish);
>=20
> Do you actually need to save the processor state etc here - the request
> is after all to power down the system and not to suspend.  Would calling
> imx6q_suspend_finish() directly work (and hence simplify the code) ?

yes you right. This will work as well.
I'll send changed version after Rafaels feedback for kernel/reboot.c
part.
Russell, can I expect your Signed-off-by for changed patch?

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--soqpjcx3im3qprt5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEpENFL0P3hvQ7p0DDdQOiSHVI77QFAlrygdAACgkQdQOiSHVI
77R93Qf+K3DxiMZbVQizzjCvsHOT4tntdIwXjwTzgw8o/vU1QDCNU+NK+vbFnbFW
D6BlSnJyU03IivY4Z1+5m/J3xzYvqWiXjyVwuOEVk9HRpbIgEQkZP7ClXvC7ZJo0
chLpRlDSvejxp1M5dhyuvZqK60IMnRdqdqQnWy24neucvK1l301w8C1cY2ZIP6IN
SxVDOw6Li+BDcS6eFxGlORVXpJcej6ulWYtsxLyWQtFM8VqPB+uK/GvUHG9ZQsd+
Fx4Y2XwvVALPK33HNjgV2m/gkGc2tC2IOniIg6v16LXiqTV9d5jMS75jpAUnxWQH
woku+n846M17jvaOU2uUe35+tpWY6g==
=M5Xn
-----END PGP SIGNATURE-----

--soqpjcx3im3qprt5--

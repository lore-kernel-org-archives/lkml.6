Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751840AbeEDSvC (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 14:51:02 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:36127 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751687AbeEDSvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 14:51:01 -0400
Date: Fri, 4 May 2018 20:50:52 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: kernel@pengutronix.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Russell King <linux@armlinux.org.uk>, Shawn Guo <shawnguo@kernel.org>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v6 3/6] kernel/reboot.c: export pm_power_off_prepare
Message-ID: <20180504185052.bjhfkvpgrblc7tfc@pengutronix.de>
References: <20180305102524.5905-1-o.rempel@pengutronix.de>
 <20180305102524.5905-4-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6e3ga3qhvjgmgc3v"
Content-Disposition: inline
In-Reply-To: <20180305102524.5905-4-o.rempel@pengutronix.de>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-IRC: #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 20:39:44 up 134 days,  7:17, 71 users,  load average: 0.07, 0.20,
 0.15
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6e3ga3qhvjgmgc3v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hallo Andrew,
I need your ACK or NACK for this patch.

This function is used to configure external PMIC to interpret
signal which will be triggered by pm_power_off as power off.
Since same signal can be used for stand by, I linked PMIC configuration
with pm_power_off_prepare to avoid possible conflicts.

On Mon, Mar 05, 2018 at 11:25:20AM +0100, Oleksij Rempel wrote:
> Export pm_power_off_prepare. It is needed to implement power off on
> Freescale/NXP iMX6 based boards with external power management
> integrated circuit (PMIC).
>=20
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  kernel/reboot.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/kernel/reboot.c b/kernel/reboot.c
> index e4ced883d8de..350be6baa60d 100644
> --- a/kernel/reboot.c
> +++ b/kernel/reboot.c
> @@ -49,6 +49,7 @@ int reboot_force;
>   */
> =20
>  void (*pm_power_off_prepare)(void);
> +EXPORT_SYMBOL(pm_power_off_prepare);
> =20
>  /**
>   *	emergency_restart - reboot the system
> --=20
> 2.16.1
>=20
>=20

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--6e3ga3qhvjgmgc3v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEpENFL0P3hvQ7p0DDdQOiSHVI77QFAlrsq4YACgkQdQOiSHVI
77RrrAf+NcAmX7I0v3A0RtYgJl4/U+SH3tfZ1+vLFOE2EL2V/xZyfRJzZofV94Rx
tZTDI2PidntjBmtIqLTYPCl70RjmmHJlzmmGHU34QqiTir9tJ8OCam1FXlJ5iv1U
zi/ET9pScJyf8NS9LghYbX8JAdZqcP9PtDKntT4a90KawVsJKlEEw+LDsncQ2AJa
lsdwTe/QsvMhSs4cRLDVd4G0q9xGZ/W7pkC+eB+z8tXQWU2IxLQ1OlWPG03K1e1n
xKs4loCLVWlfp2U73Nk6+F0A5Pek+mhhUDeqG/q64W6fTvD5MzZTk7uSuEs7rBwT
x6bJbpce+s88+W9Uw/7/H3CIMXniug==
=JJlX
-----END PGP SIGNATURE-----

--6e3ga3qhvjgmgc3v--

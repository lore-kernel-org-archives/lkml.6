Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753013AbeAaH3g (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 02:29:36 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:52673 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752987AbeAaH3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 02:29:33 -0500
Date: Wed, 31 Jan 2018 08:29:31 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
To: =?iso-8859-1?Q?Beno=EEt_Th=E9baudeau?=
        <benoit.thebaudeau.dev@gmail.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>,
        Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>,
        Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Subject: Re: [PATCH v2 2/2] ARM: dts: imx25-pinfunc: Always set SION for
 eSDHC CMD
Message-ID: <20180131072931.2hymk6xzerplfhcr@pengutronix.de>
References: <20180131000514.5286-1-benoit.thebaudeau.dev@gmail.com>
 <20180131000514.5286-2-benoit.thebaudeau.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180131000514.5286-2-benoit.thebaudeau.dev@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Benoît,

On Wed, Jan 31, 2018 at 01:05:14AM +0100, Benoît Thébaudeau wrote:
> The eSDHC does not work properly if the SION bit is not set for the
> bidirectional CMD signal, whatever the eSDHC instance and the selected
> pad. Therefore, setting SION is mandatory for all eSDHC CMD ports. Do
> this for MX25_PAD_*__ESDHCn_CMD in imx25-pinfunc.h in order to enforce
> this behavior for all boards.
> 
> This had already been done for eSDHC1, but not for eSDHC2. Also, define
> MX25_PAD_FEC_MDC__ESDHC2_CMD so that all the possible cases are covered
> from now on.
> 
> Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Benoît Thébaudeau <benoit.thebaudeau.dev@gmail.com>
> Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
> ---
> Changes v1 -> v2:
>  - Update eSDHC instance and port naming following the addition of "ARM:
>    dts: imx25-pinfunc: Use consistent naming for eSDHC".
>  - Reference the more verbose comment for MX25_PAD_SD1_CMD__ESDHC1_CMD
>    instead of copying the same less detailed comment everywhere
>    (suggested by Uwe).
> ---
>  arch/arm/boot/dts/imx25-pinfunc.h | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx25-pinfunc.h b/arch/arm/boot/dts/imx25-pinfunc.h
> index 2915c65a13c9..71a61c4c984f 100644
> --- a/arch/arm/boot/dts/imx25-pinfunc.h
> +++ b/arch/arm/boot/dts/imx25-pinfunc.h
> @@ -236,7 +236,8 @@
>  #define MX25_PAD_LD8__LD8			0x0e8 0x2e0 0x000 0x00 0x000
>  #define MX25_PAD_LD8__UART4_RXD			0x0e8 0x2e0 0x570 0x02 0x000
>  #define MX25_PAD_LD8__FEC_TX_ERR		0x0e8 0x2e0 0x000 0x05 0x000
> -#define MX25_PAD_LD8__ESDHC2_CMD		0x0e8 0x2e0 0x4e0 0x06 0x000
> +/* See the comment for MX25_PAD_SD1_CMD__ESDHC1_CMD. */

I'd write:

	/* SION must be set, see the comment for MX25_PAD_SD1_CMD__ESDHC1_CMD. */

to at least mention SION here.

Other than that the commit looks fine.

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

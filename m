Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752979AbeBEGJg (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 01:09:36 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:35358 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752885AbeBEGJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 01:09:01 -0500
X-Google-Smtp-Source: AH8x224XwGlzvdit+j1chryFM7uw+uOiSm1AwxOLYexMu7u3v1ATagauMQwVg6g47cwNoirX2YddGA==
Date: Mon, 5 Feb 2018 00:08:59 -0600
From: Rob Herring <robh@kernel.org>
To: =?iso-8859-1?Q?Beno=EEt_Th=E9baudeau?=
        <benoit.thebaudeau.dev@gmail.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>,
        Mark Rutland <mark.rutland@arm.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>,
        Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Subject: Re: [PATCH v3 2/2] ARM: dts: imx25-pinfunc: Always set SION for
 eSDHC CMD
Message-ID: <20180205034929.tdd22buxaigufo6y@rob-hp-laptop>
References: <20180131213544.4508-1-benoit.thebaudeau.dev@gmail.com>
 <20180131213544.4508-2-benoit.thebaudeau.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180131213544.4508-2-benoit.thebaudeau.dev@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 31, 2018 at 10:35:44PM +0100, Benoît Thébaudeau wrote:
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
> Changes v2 -> v3:
>  - Quickly mention SION in each comment, besides the reference to the
>    verbose comment (suggested by Uwe).
> Changes v1 -> v2:
>  - Update eSDHC instance and port naming following the addition of "ARM:
>    dts: imx25-pinfunc: Use consistent naming for eSDHC".
>  - Reference the more verbose comment for MX25_PAD_SD1_CMD__ESDHC1_CMD
>    instead of copying the same less detailed comment everywhere
>    (suggested by Uwe).
> ---
>  arch/arm/boot/dts/imx25-pinfunc.h | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>

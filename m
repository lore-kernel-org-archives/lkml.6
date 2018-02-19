Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752715AbeBSLq1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 06:46:27 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:57747 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752591AbeBSLqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 06:46:24 -0500
Message-ID: <1519040779.3408.7.camel@pengutronix.de>
Subject: Re: [PATCH 3/3] reset: simple: Allow user selection of driver
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Joel Stanley <joel@jms.id.au>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Andrew Jeffery <andrew@aj.id.au>
Cc: Lee Jones <lee.jones@linaro.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org
Date: Mon, 19 Feb 2018 12:46:19 +0100
In-Reply-To: <20180219065438.19933-4-joel@jms.id.au>
References: <20180219065438.19933-1-joel@jms.id.au>
         <20180219065438.19933-4-joel@jms.id.au>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-02-19 at 17:24 +1030, Joel Stanley wrote:
> Currently this driver is only user selectable if COMPILE_TEST is turned
> on. Users may wish to select (and deselect) it, so remove this
> restriction.

I would like to keep user visible options to a minimum unless there is a
good reason. What is the scenario in which a user would decide to
disable the default-enabled reset-simple driver, or the other way
around? This should be mentioned in the commit message.

Maybe this is an indication that there could be a better default than
just ARCH_ASPEED.

regards
Philipp

> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>  drivers/reset/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> index 18f152d251d7..7490a4370900 100644
> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -82,7 +82,7 @@ config RESET_PISTACHIO
>  	  This enables the reset driver for ImgTec Pistachio SoCs.
>  
>  config RESET_SIMPLE
> -	bool "Simple Reset Controller Driver" if COMPILE_TEST
> +	bool "Simple Reset Controller Driver"
>  	default ARCH_SOCFPGA || ARCH_STM32 || ARCH_STRATIX10 || ARCH_SUNXI || ARCH_ZX || ARCH_ASPEED
>  	help
>  	  This enables a simple reset controller driver for reset lines that

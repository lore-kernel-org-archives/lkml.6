Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CBA2C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 14:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDFA720849
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 14:35:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDFA720849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728907AbeLMOfh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 09:35:37 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:42821 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728921AbeLMOfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 09:35:36 -0500
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1gXS5I-00049s-Q5; Thu, 13 Dec 2018 15:35:28 +0100
Message-ID: <1544711727.3137.32.camel@pengutronix.de>
Subject: Re: [PATCH 1/3] arm64: Remove CONFIG_SOC_IMX8MQ and use ARCH_MXC
 instead
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Abel Vesa <abel.vesa@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>
Cc:     "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Olof Johansson <olof@lixom.net>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>, Rob Herring <robh@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Fabio Estevam <fabio.estevam@nxp.com>
Date:   Thu, 13 Dec 2018 15:35:27 +0100
In-Reply-To: <1544707047-4417-2-git-send-email-abel.vesa@nxp.com>
References: <1544707047-4417-1-git-send-email-abel.vesa@nxp.com>
         <1544707047-4417-2-git-send-email-abel.vesa@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, den 13.12.2018, 13:17 +0000 schrieb Abel Vesa:
> To keep aligned with arm64, remove the unnecessary SOC_IMX8MQ and use
> ARCH_MXC instead.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---
>  arch/arm64/Kconfig.platforms           | 8 --------
>  arch/arm64/boot/dts/freescale/Makefile | 2 +-
>  drivers/clk/imx/Makefile               | 3 ++-
>  drivers/phy/freescale/Kconfig          | 2 +-
>  drivers/pinctrl/freescale/Kconfig      | 2 +-
>  drivers/soc/imx/Kconfig                | 2 +-
>  6 files changed, 6 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/arm64/Kconfig.platforms
> b/arch/arm64/Kconfig.platforms
> index 7e1545a..318dbb9 100644
> --- a/arch/arm64/Kconfig.platforms
> +++ b/arch/arm64/Kconfig.platforms
> @@ -148,14 +148,6 @@ config ARCH_MXC
>  	  This enables support for the ARMv8 based SoCs in the
>  	  NXP i.MX family.
>  
> -config SOC_IMX8MQ
> -	bool "i.MX8MQ support"
> -	depends on ARCH_MXC
> -	select ARM64_ERRATUM_843419
> -	select ARM64_ERRATUM_845719
> -	help
> -	  This enables support for the i.MX8MQ SoC.
> -

NACK on this one. Having a single place where stuff that is absolutely
critical for proper SoC operation can be selected is very useful and
avoids hard to debug issues due to slightly wrong configs in the long
run.

Regards,
Lucas

>  config ARCH_QCOM
>  	bool "Qualcomm Platforms"
>  	select GPIOLIB
> diff --git a/arch/arm64/boot/dts/freescale/Makefile
> b/arch/arm64/boot/dts/freescale/Makefile
> index 0001361..f9be242 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -19,4 +19,4 @@ dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2088a-
> rdb.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2160a-qds.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2160a-rdb.dtb
>  
> -dtb-$(CONFIG_SOC_IMX8MQ) += imx8mq-evk.dtb
> +dtb-$(CONFIG_ARCH_MXC) += imx8mq-evk.dtb
> diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
> index 5c0b11e..62a1882 100644
> --- a/drivers/clk/imx/Makefile
> +++ b/drivers/clk/imx/Makefile
> @@ -34,5 +34,6 @@ obj-$(CONFIG_SOC_IMX6SX) += clk-imx6sx.o
>  obj-$(CONFIG_SOC_IMX6UL) += clk-imx6ul.o
>  obj-$(CONFIG_SOC_IMX7D)  += clk-imx7d.o
>  obj-$(CONFIG_SOC_IMX7ULP) += clk-imx7ulp.o
> -obj-$(CONFIG_SOC_IMX8MQ) += clk-imx8mq.o
>  obj-$(CONFIG_SOC_VF610)  += clk-vf610.o
> +
> +obj-$(CONFIG_ARCH_MXC) += clk-imx8mq.o
> diff --git a/drivers/phy/freescale/Kconfig
> b/drivers/phy/freescale/Kconfig
> index f050bd4..923c0ef 100644
> --- a/drivers/phy/freescale/Kconfig
> +++ b/drivers/phy/freescale/Kconfig
> @@ -2,4 +2,4 @@ config PHY_FSL_IMX8MQ_USB
>  	tristate "Freescale i.MX8M USB3 PHY"
>  	depends on OF && HAS_IOMEM
>  	select GENERIC_PHY
> -	default SOC_IMX8MQ
> +	default ARCH_MXC
> diff --git a/drivers/pinctrl/freescale/Kconfig
> b/drivers/pinctrl/freescale/Kconfig
> index 2d6db43..9874a16 100644
> --- a/drivers/pinctrl/freescale/Kconfig
> +++ b/drivers/pinctrl/freescale/Kconfig
> @@ -123,7 +123,7 @@ config PINCTRL_IMX7ULP
>  
>  config PINCTRL_IMX8MQ
>  	bool "IMX8MQ pinctrl driver"
> -	depends on SOC_IMX8MQ
> +	depends on ARCH_MXC
>  	select PINCTRL_IMX
>  	help
>  	  Say Y here to enable the imx8mq pinctrl driver
> diff --git a/drivers/soc/imx/Kconfig b/drivers/soc/imx/Kconfig
> index 2112d18..7ffbb6b 100644
> --- a/drivers/soc/imx/Kconfig
> +++ b/drivers/soc/imx/Kconfig
> @@ -2,7 +2,7 @@ menu "i.MX SoC drivers"
>  
>  config IMX_GPCV2_PM_DOMAINS
>  	bool "i.MX GPCv2 PM domains"
> -	depends on SOC_IMX7D || SOC_IMX8MQ || (COMPILE_TEST && OF)
> +	depends on SOC_IMX7D || ARCH_MXC || (COMPILE_TEST && OF)
>  	depends on PM
>  	select PM_GENERIC_DOMAINS
>  	default y if SOC_IMX7D

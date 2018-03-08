Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756008AbeCHPbO convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 10:31:14 -0500
Received: from smtprelay03.ispgateway.de ([80.67.31.37]:40322 "EHLO
        smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754580AbeCHPbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 10:31:11 -0500
Date: Thu, 8 Mar 2018 16:11:35 +0100
From: Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>
To: Martin Kaiser <martin@kaiser.cx>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: i.MX25: define SSI FIFO depth
Message-ID: <20180308161135.1f3d3d18@karo-electronics.de>
In-Reply-To: <1520373499-13623-1-git-send-email-martin@kaiser.cx>
References: <1520373499-13623-1-git-send-email-martin@kaiser.cx>
Organization: Ka-Ro electronics GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Df-Sender: bHdAa2Fyby1lbGVjdHJvbmljcy5kZQ==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue,  6 Mar 2018 22:58:19 +0100 Martin Kaiser wrote:
> According to the i.MX25 reference manuals, each SSI has four FIFOs. All
> of those FIFOs can store up to 15 entries.
> 
> The fsl_ssi driver's internal default for the FIFO depth in 8. Set our
> non-default FIFO depth explicitly in the Device Tree.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>  arch/arm/boot/dts/imx25.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
> index 9725705..cf70df2 100644
> --- a/arch/arm/boot/dts/imx25.dtsi
> +++ b/arch/arm/boot/dts/imx25.dtsi
> @@ -269,6 +269,7 @@
>  				dmas = <&sdma 24 1 0>,
>  				       <&sdma 25 1 0>;
>  				dma-names = "rx", "tx";
> +				fsl,fifo-depth = <15>;
>  				status = "disabled";
>  			};
>  
> @@ -329,6 +330,7 @@
>  				dmas = <&sdma 28 1 0>,
>  				       <&sdma 29 1 0>;
>  				dma-names = "rx", "tx";
> +				fsl,fifo-depth = <15>;
>  				status = "disabled";
>  			};
>  
You are changing the global .dtsi file. Did you test this change with
all devices that are affected by it?


Lothar Waßmann

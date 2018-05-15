Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752257AbeEOHMs (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 03:12:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:52824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752044AbeEOHMr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 03:12:47 -0400
Date: Tue, 15 May 2018 15:12:01 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: =?iso-8859-1?Q?Hern=E1n?= Gonzalez <hernan@vanguardiasur.com.ar>
Cc: s.hauer@pengutronix.de, kernel@pengutronix.de, fabio.estevam@nxp.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: imx6qdl-phytec-pfla02: Use IRQ_TYPE specifier
Message-ID: <20180515071200.GO26863@dragon>
References: <1526254115-3999-1-git-send-email-hernan@vanguardiasur.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1526254115-3999-1-git-send-email-hernan@vanguardiasur.com.ar>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 13, 2018 at 08:28:35PM -0300, Hernán Gonzalez wrote:
> Replace magic number with the proper IRQ_TYPE specifier to improve DT
> readability.
> 
> Signed-off-by: Hernán Gonzalez <hernan@vanguardiasur.com.ar>
> ---
>  arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi b/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
> index c58f344..1b79ee7 100644
> --- a/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
> @@ -115,7 +115,7 @@
>  		compatible = "dlg,da9063";
>  		reg = <0x58>;
>  		interrupt-parent = <&gpio2>;
> -		interrupts = <9 0x8>; /* active-low GPIO2_9 */
> +		interrupts = <9 IRQ_TYPE_LOW_LEVEL>; /* active-low GPIO2_9 */

It should be IRQ_TYPE_LEVEL_LOW.  I fixed it up and applied the patch.

Shawn

>  
>  		regulators {
>  			vddcore_reg: bcore1 {
> -- 
> 2.7.4
> 

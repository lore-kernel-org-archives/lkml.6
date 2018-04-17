Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752652AbeDQOWo (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 10:22:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:35218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751884AbeDQOWn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 10:22:43 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4940F2170D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=shawnguo@kernel.org
Date: Tue, 17 Apr 2018 22:22:05 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Anson Huang <Anson.Huang@nxp.com>
Cc: kernel@pengutronix.de, fabio.estevam@nxp.com, robh+dt@kernel.org,
        mark.rutland@arm.com, linux@armlinux.org.uk, mturquette@baylibre.com,
        sboyd@kernel.org, shengjiu.wang@nxp.com, Linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH V2 2/2] ARM: dts: imx6sx-sabreauto: add external 24MHz
 clock source
Message-ID: <20180417142203.GM25429@dragon>
References: <1521426645-19246-1-git-send-email-Anson.Huang@nxp.com>
 <1521426645-19246-2-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521426645-19246-2-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 19, 2018 at 10:30:45AM +0800, Anson Huang wrote:
> On i.MX6SX SabreAuto board, there is external 24MHz clock
> source for analog clock2, add this clock source to clock tree.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> changes since V1:
> 	remove unnecessary clocks container.

I understand this is suggested by Fabio, but I'm afraid that it's not
going to work with imx_obtain_fixed_clock() call, which is coded to
look for clocks under /clocks node.

Shawn

>  arch/arm/boot/dts/imx6sx-sabreauto.dts | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6sx-sabreauto.dts b/arch/arm/boot/dts/imx6sx-sabreauto.dts
> index 72da5ac..a3b022b 100644
> --- a/arch/arm/boot/dts/imx6sx-sabreauto.dts
> +++ b/arch/arm/boot/dts/imx6sx-sabreauto.dts
> @@ -18,6 +18,12 @@
>  		reg = <0x80000000 0x80000000>;
>  	};
>  
> +	codec_osc: anaclk2 {
> +		#clock-cells = <0>;
> +		compatible = "fixed-clock";
> +		clock-frequency = <24576000>;
> +	};
> +
>  	regulators {
>  		compatible = "simple-bus";
>  		#address-cells = <1>;
> -- 
> 2.7.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-clk" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

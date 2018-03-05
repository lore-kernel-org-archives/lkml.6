Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932099AbeCEOQF convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 09:16:05 -0500
Received: from gloria.sntech.de ([95.129.55.99]:36758 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751342AbeCEOQD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 09:16:03 -0500
From: Heiko Stuebner <heiko@sntech.de>
To: Daniel Schultz <d.schultz@phytec.de>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, w.egorov@phytec.de
Subject: Re: [PATCH] ARM: dts: rockchip: Add dp83867 CLK_OUT muxing
Date: Mon, 05 Mar 2018 15:15:46 +0100
Message-ID: <3530074.WSbKf9j6h0@phil>
In-Reply-To: <1520253911-46218-1-git-send-email-d.schultz@phytec.de>
References: <1520253911-46218-1-git-send-email-d.schultz@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

Am Montag, 5. März 2018, 13:45:11 CET schrieb Daniel Schultz:
> The CLK_O_SEL default is synchronous to XI input clock, which is 25 MHz.
> Set CLK_O_SEL to channel A transmit clock so we have 125 MHz on CLK_OUT.
> 
> Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
> ---
> 
> The binding will be added with the next merge of net-next:
> https://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git/commit/?id=9708fb630d19ee51ae3aeb3a533e3010da0e8570

I did find the commit, but no related change of the dp83867 dt binding
document [0], including a review by dt-maintainers.

While your property does not look overly complicated, the binding
should be updated nontheless.


Heiko

[0] https://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git/log/Documentation/devicetree/bindings/net/ti,dp83867.txt?id=9708fb630d19ee51ae3aeb3a533e3010da0e8570

>  arch/arm/boot/dts/rk3288-phycore-som.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/rk3288-phycore-som.dtsi b/arch/arm/boot/dts/rk3288-phycore-som.dtsi
> index bdd80aa..e60535d 100644
> --- a/arch/arm/boot/dts/rk3288-phycore-som.dtsi
> +++ b/arch/arm/boot/dts/rk3288-phycore-som.dtsi
> @@ -141,6 +141,7 @@
>  			ti,tx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
>  			ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
>  			enet-phy-lane-no-swap;
> +			ti,clk-output-sel = <DP83867_CLK_O_SEL_CHN_A_TCLK>;
>  		};
>  	};
>  };
> 

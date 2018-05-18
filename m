Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752517AbeERQlN (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 12:41:13 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:34085 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752491AbeERQlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 12:41:08 -0400
X-Google-Smtp-Source: AB8JxZpwUGbBkz1YxCw9yaXvfVGxq9I1CEYCas5Zuv+fjyL8QCU+TJ8DbEgpH7WAy4HbbVdDFhO8oQ==
Date: Fri, 18 May 2018 11:41:05 -0500
From: Rob Herring <robh@kernel.org>
To: Lin Huang <hl@rock-chips.com>
Cc: seanpaul@chromium.org, airlied@linux.ie, zyw@rock-chips.com,
        dianders@chromium.org, briannorris@chromium.org,
        linux-rockchip@lists.infradead.org, heiko@sntech.de,
        daniel.vetter@intel.com, jani.nikula@linux.intel.com,
        dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, eballetbo@gmail.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v5 2/4] Documentation: bindings: add phy_config for
 Rockchip USB Type-C PHY
Message-ID: <20180518164105.GA14201@rob-hp-laptop>
References: <1526548680-2552-1-git-send-email-hl@rock-chips.com>
 <1526548680-2552-2-git-send-email-hl@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526548680-2552-2-git-send-email-hl@rock-chips.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 17, 2018 at 05:17:58PM +0800, Lin Huang wrote:
> If want to do training outside DP Firmware, need phy voltage swing
> and pre_emphasis value.

"dt-bindings: phy: ..." for the subject please.

> 
> Signed-off-by: Lin Huang <hl@rock-chips.com>
> ---
> Changes in v2:
> - None 
> Changes in v3:
> - modify property description and add this property to Example
> Change in v4:
> - None
> Change in v5:
> - None
> 
>  .../devicetree/bindings/phy/phy-rockchip-typec.txt | 29 +++++++++++++++++++++-
>  1 file changed, 28 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt b/Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt
> index 960da7f..af298f2 100644
> --- a/Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt
> +++ b/Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt
> @@ -17,7 +17,8 @@ Required properties:
>  
>  Optional properties:
>   - extcon : extcon specifier for the Power Delivery
> -
> + - rockchip,phy_config : A list of voltage swing(mv) and pre-emphasis
> +			(dB) pairs.

rockchip,phy-config

>  Required nodes : a sub-node is required for each port the phy provides.
>  		 The sub-node name is used to identify dp or usb3 port,
>  		 and shall be the following entries:
> @@ -50,6 +51,19 @@ Example:
>  			 <&cru SRST_P_UPHY0_TCPHY>;
>  		reset-names = "uphy", "uphy-pipe", "uphy-tcphy";
>  
> +		rockchip,phy_config =<0x2a 0x00

space                                 ^

And format with inner <> ("< <0 1> <0 2> ... >") to show the pairs.

> +			0x1f 0x15
> +			0x14 0x22
> +			0x02 0x2b
> +			0x21 0x00
> +			0x12 0x15
> +			0x02 0x22
> +			0 0
> +			0x15 0x00
> +			0x00 0x15
> +			0 0
> +			0 0>;

Since you have <0 0> multiple times, I presume the index is significant 
and the length is fixed. Please define the index meaning and length 
above.

> +
>  		tcphy0_dp: dp-port {
>  			#phy-cells = <0>;
>  		};
> @@ -74,6 +88,19 @@ Example:
>  			 <&cru SRST_P_UPHY1_TCPHY>;
>  		reset-names = "uphy", "uphy-pipe", "uphy-tcphy";
>  
> +		rockchip,phy_config =<0x2a 0x00
> +			0x1f 0x15
> +			0x14 0x22
> +			0x02 0x2b
> +			0x21 0x00
> +			0x12 0x15
> +			0x02 0x22
> +			0 0
> +			0x15 0x00
> +			0x00 0x15
> +			0 0
> +			0 0>;
> +
>  		tcphy1_dp: dp-port {
>  			#phy-cells = <0>;
>  		};
> -- 
> 2.7.4
> 

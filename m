Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752128AbeERQYh (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 12:24:37 -0400
Received: from gloria.sntech.de ([95.129.55.99]:40620 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750957AbeERQYa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 12:24:30 -0400
From: Heiko Stuebner <heiko@sntech.de>
To: Lin Huang <hl@rock-chips.com>
Cc: seanpaul@chromium.org, airlied@linux.ie, zyw@rock-chips.com,
        dianders@chromium.org, briannorris@chromium.org,
        linux-rockchip@lists.infradead.org, daniel.vetter@intel.com,
        jani.nikula@linux.intel.com, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        eballetbo@gmail.com, robh+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 2/4] Documentation: bindings: add phy_config for Rockchip USB Type-C PHY
Date: Fri, 18 May 2018 18:24:00 +0200
Message-ID: <2417091.oYeT3lua5n@phil>
In-Reply-To: <1526548680-2552-2-git-send-email-hl@rock-chips.com>
References: <1526548680-2552-1-git-send-email-hl@rock-chips.com> <1526548680-2552-2-git-send-email-hl@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 17. Mai 2018, 11:17:58 CEST schrieb Lin Huang:
> If want to do training outside DP Firmware, need phy voltage swing
> and pre_emphasis value.
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

mv -> mV I'd think.

This needs a bit more explanation please. Especially as the multiple "0 0"
lines in the examples suggest some deeper ordering requirements.
Like the 3 blocks of 4 entries as can be seen in the default config in
patch3. The binding should definitly describe what these are.


>  Required nodes : a sub-node is required for each port the phy provides.
>  		 The sub-node name is used to identify dp or usb3 port,
>  		 and shall be the following entries:
> @@ -50,6 +51,19 @@ Example:
>  			 <&cru SRST_P_UPHY0_TCPHY>;
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

I don't think they should be hex-values, as according to the doc above
these are values in mV and dB .


Heiko

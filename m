Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753152AbeE3Mga (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 08:36:30 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:51678 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751870AbeE3Mg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 08:36:27 -0400
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Maciej Purski <m.purski@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>, Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH v2 07/10] dt-bindings: tc358754: add DT bindings
Date: Wed, 30 May 2018 15:36:29 +0300
Message-ID: <6047372.VZe6FOdiCA@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <1527682561-1386-8-git-send-email-m.purski@samsung.com>
References: <1527682561-1386-1-git-send-email-m.purski@samsung.com> <CGME20180530121627eucas1p1c8daf24d7c95e9e8b04a523d4662dfd9@eucas1p1.samsung.com> <1527682561-1386-8-git-send-email-m.purski@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maciej,

On Wednesday, 30 May 2018 15:15:58 EEST Maciej Purski wrote:
> From: Andrzej Hajda <a.hajda@samsung.com>
> 
> The patch adds bindings to Toshiba DSI/LVDS bridge TC358764.
> Bindings describe power supplies, reset gpio and video interfaces.
> 
> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> Signed-off-by: Maciej Purski <m.purski@samsung.com>
> ---
>  .../bindings/display/bridge/toshiba,tc358764.txt   | 37 +++++++++++++++++++
>  1 file changed, 37 insertions(+)
>  create mode 100644
> Documentation/devicetree/bindings/display/bridge/toshiba,tc358764.txt
> 
> diff --git
> a/Documentation/devicetree/bindings/display/bridge/toshiba,tc358764.txt
> b/Documentation/devicetree/bindings/display/bridge/toshiba,tc358764.txt new
> file mode 100644
> index 0000000..6eda14f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/toshiba,tc358764.txt
> @@ -0,0 +1,37 @@
> +TC358764 MIPI-DSI to LVDS panel bridge
> +
> +Required properties:
> +  - compatible: "toshiba,tc358764"
> +  - reg: the virtual channel number of a DSI peripheral
> +  - vddc-supply: core voltage supply, 1.2V
> +  - vddio-supply: I/O voltage supply, 1.8V or 3.3V
> +  - vddlvds-supply: LVDS1/2 voltage supply, 3.3V
> +  - reset-gpios: a GPIO spec for the reset pin
> +
> +The device node can contain zero to two 'port' child nodes, each with one
> +child 'endpoint' node, according to the bindings defined in [1].
> +The following are properties specific to those nodes.
> +
> +port:
> +  - reg: (required) can be 0 for DSI port or 1 for LVDS port;
> +
> +[1]: Documentation/devicetree/bindings/media/video-interfaces.txt

Could you please take the comments I made on v1 into account when you'll post 
v3 ?

> +Example:
> +
> +	bridge@0 {
> +		reg = <0>;
> +		compatible = "toshiba,tc358764";
> +		vddc-supply = <&vcc_1v2_reg>;
> +		vddio-supply = <&vcc_1v8_reg>;
> +		vddlvds-supply = <&vcc_3v3_reg>;
> +		reset-gpios = <&gpd1 6 GPIO_ACTIVE_LOW>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		port@1 {
> +			reg = <1>;
> +			lvds_ep: endpoint {
> +				remote-endpoint = <&panel_ep>;
> +			};
> +		};
> +	};


-- 
Regards,

Laurent Pinchart

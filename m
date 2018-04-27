Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759118AbeD0UC3 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 16:02:29 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:45955 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758787AbeD0UC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 16:02:27 -0400
X-Google-Smtp-Source: AB8JxZriZ3cBdeXZAVUG1RQUEbkzt/MVLmh7D6AdcBBVv++nEJajffMe/KuUQ9PMAM7XDeCdHGJQRA==
Date: Fri, 27 Apr 2018 15:02:25 -0500
From: Rob Herring <robh@kernel.org>
To: sean.wang@mediatek.com
Cc: mark.rutland@arm.com, sre@kernel.org, lee.jones@linaro.org,
        a.zummo@towertech.it, alexandre.belloni@free-electrons.com,
        matthias.bgg@gmail.com, eddie.huang@mediatek.com,
        devicetree@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/17] dt-bindings: power: reset: mt6323: add bindings
 for MT6323 power controller
Message-ID: <20180427200225.lq63ex7eiukc6egl@rob-hp-laptop>
References: <cover.1524646231.git.sean.wang@mediatek.com>
 <0b3123e42c8a47e3fa8b21aa2e139e6d3dc69f41.1524646231.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b3123e42c8a47e3fa8b21aa2e139e6d3dc69f41.1524646231.git.sean.wang@mediatek.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 25, 2018 at 05:32:27PM +0800, sean.wang@mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Adding device-tree binding for the power controller which is a tiny
> circuit block present as a part of MT6323 PMIC and is responsible for
> externally powering off or on a remote SoC the PMIC is connected to.
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  .../bindings/power/reset/mt6323-poweroff.txt         | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/reset/mt6323-poweroff.txt
> 
> diff --git a/Documentation/devicetree/bindings/power/reset/mt6323-poweroff.txt b/Documentation/devicetree/bindings/power/reset/mt6323-poweroff.txt
> new file mode 100644
> index 0000000..6f7c590
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/reset/mt6323-poweroff.txt
> @@ -0,0 +1,20 @@
> +Device Tree Bindings for Power Controller on MediaTek PMIC
> +
> +The power controller which could be found on PMIC is responsible for externally
> +powering off or on the remote MediaTek SoC through the circuit BBPU.
> +
> +Required properties:
> +- compatible: Should be one of follows
> +	"mediatek,mt6323-pwrc": for MT6323 PMIC
> +
> +Example:
> +
> +	pmic {
> +		compatible = "mediatek,mt6323";
> +
> +		...
> +
> +		power-controller {
> +			compatible = "mediatek,mt6323-pwrc";

Why do you need this in DT? It doesn't define any resources. The parent 
can just as well register a reset or poweroff handler.

Rob

> +		};
> +	}
> -- 
> 2.7.4
> 

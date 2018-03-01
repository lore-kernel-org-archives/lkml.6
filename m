Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967260AbeCAJuW convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 04:50:22 -0500
Received: from gloria.sntech.de ([95.129.55.99]:43206 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967161AbeCAJt4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 04:49:56 -0500
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: kishon@ti.com, groeck@chromium.org, gwendal@chromium.org,
        kernel@collabora.com, vicencb@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/6] dt-bindings: phy-rockchip-typec: move extcon property to be optional.
Date: Thu, 01 Mar 2018 10:49:52 +0100
Message-ID: <379977528.QSC4nRyzFz@diego>
In-Reply-To: <20180301092420.1191-3-enric.balletbo@collabora.com>
References: <20180301092420.1191-1-enric.balletbo@collabora.com> <20180301092420.1191-3-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enric,

Am Donnerstag, 1. März 2018, 10:24:16 CET schrieb Enric Balletbo i Serra:
> The extcon property is used to detect the cable-state but some boards,
> like Sapphire, currently does not seem to support, others might just not
> need, as are supposed to work in host-mode only. So, extcon property is
> not really a required property, move to be optional instead.

The change itself is justified, the "justification" in the message might
need some rework, as this sounds more like a kernel-side issue,
while the extcon should always be optional.

Something like:

The extcon property is used to detect the cable-state but some boards
just connect the type-c phy to a regular USB-A connector without any
power-delivery and thus no controller reporting the cable-state.
So the extcon property is not really a required property, move it to be 
optional instead.


For the change itself:
Reviewed-by: Heiko Stuebner <heiko@sntech.de>

> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> 
>  Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt
> b/Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt index
> 6ea867e3176f..a66f23a01129 100644
> --- a/Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt
> +++ b/Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt
> @@ -14,6 +14,8 @@ Required properties:
>   - resets : a list of phandle + reset specifier pairs
>   - reset-names : string reset name, must be:
>  		 "uphy", "uphy-pipe", "uphy-tcphy"
> +
> +Optional properties:
>   - extcon : extcon specifier for the Power Delivery
> 
>  Note, there are 2 type-c phys for RK3399, and they are almost identical,
> except

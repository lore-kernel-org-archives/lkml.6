Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751500AbeDXQfB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 12:35:01 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:36435 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750757AbeDXQe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 12:34:57 -0400
X-Google-Smtp-Source: AIpwx48Skf7RIt6BPA38dICR73tddUJb3TTV2+hzRdzyPRtqaqEVadgnahPKglUOAP/QseQ9NoxabQ==
Date: Tue, 24 Apr 2018 11:34:55 -0500
From: Rob Herring <robh@kernel.org>
To: =?iso-8859-1?Q?M=E5ns?= Andersson <mans.andersson@nibe.se>
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: TLK10X initial driver submission
Message-ID: <20180424163455.vmftcg5xbj6svtcu@rob-hp-laptop>
References: <20180419082816.109338-1-mans.andersson@nibe.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180419082816.109338-1-mans.andersson@nibe.se>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2018 at 10:28:16AM +0200, Måns Andersson wrote:
> From: Mans Andersson <mans.andersson@nibe.se>
> 
> Add suport for the TI TLK105 and TLK106 10/100Mbit ethernet phys.
> 
> In addition the TLK10X needs to be removed from DP83848 driver as the
> power back off support is added here for this device.
> 
> Datasheet:
> http://www.ti.com/lit/gpn/tlk106
> ---
>  .../devicetree/bindings/net/ti,tlk10x.txt          |  27 +++

Please split bindings to a separate patch.

>  drivers/net/phy/Kconfig                            |   5 +
>  drivers/net/phy/Makefile                           |   1 +
>  drivers/net/phy/dp83848.c                          |   3 -
>  drivers/net/phy/tlk10x.c                           | 209 +++++++++++++++++++++
>  5 files changed, 242 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/net/ti,tlk10x.txt
>  create mode 100644 drivers/net/phy/tlk10x.c
> 
> diff --git a/Documentation/devicetree/bindings/net/ti,tlk10x.txt b/Documentation/devicetree/bindings/net/ti,tlk10x.txt
> new file mode 100644
> index 0000000..371d0d7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/ti,tlk10x.txt
> @@ -0,0 +1,27 @@
> +* Texas Instruments - TLK105 / TLK106 ethernet PHYs
> +
> +Required properties:
> +	- reg - The ID number for the phy, usually a small integer

Isn't this the MDIO bus address?

This should have a compatible string too.

> +
> +Optional properties:
> +	- ti,power-back-off - Power Back Off Level
> +		Please refer to data sheet chapter 8.6 and TI Application
> +		Note SLLA3228
> +		0 - Normal Operation
> +		1 - Level 1 (up to 140m cable between TLK link partners)
> +		2 - Level 2 (up to 100m cable between TLK link partners)
> +		3 - Level 3 (up to 80m cable between TLK link partners)
> +
> +Default child nodes are standard Ethernet PHY device
> +nodes as described in Documentation/devicetree/bindings/net/phy.txt
> +
> +Example:
> +
> +	ethernet-phy@0 {
> +		reg = <0>;
> +		ti,power-back-off = <2>;
> +	};
> +
> +Datasheets and documentation can be found at:
> +http://www.ti.com/lit/gpn/tlk106
> +http://www.ti.com/lit/an/slla328/slla328.pdf

Move this to before the properties.

Rob

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751440AbeECRkZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 13:40:25 -0400
Received: from muru.com ([72.249.23.125]:40122 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751095AbeECRkW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 13:40:22 -0400
Date: Thu, 3 May 2018 10:40:19 -0700
From: Tony Lindgren <tony@atomide.com>
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
        =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH v4 00/14] dra7: mmc: Update mmc dt node to use sdhci-omap
Message-ID: <20180503174019.GX98604@atomide.com>
References: <20180427120905.3665-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180427120905.3665-1-kishon@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Kishon Vijay Abraham I <kishon@ti.com> [180427 05:11]:
> Changes from v3:
> *) Added dra7-mmc-iodelay.dtsi to add a new pinctrl group for clk line
>    without pullup to be used for dra71-evm and am57xx-idk.
> *) Rename wlcore node name to wifi
> 
> This series should be merged only after [1].
> [1] -> https://marc.info/?l=linux-omap&m=152482966225758&w=2
> 
> This series:
>  *) Adds wilink wlan support (Now all MMC instances in DRA7 will use
>     sdhci-omap)
>  *) Add a new pinctrl group for clk line without pullup required for
>     UHS cards to work reliably.
>  *) Update README to make sure users update .config file from 4.18
>     kernel.
>  *) Use sdhci-omap programming model.

Applying this series into omap-for-v4.18/dt-sdhci on top of the
immutable branch from Ulf.

> In the "Use sdhci-omap programming model" patch, "ti,omap4-hsmmc"
> compatible is removed. This is because if both "ti,dra7-sdhci" and
> "ti,omap4-hsmmc" is added and if there is probe deferral in sdhci_omap
> driver, the device is binding to omap_hsmmc driver.
> 
> Once omap_hsmmc and sdhci_omap driver are feature identical,
> sdhci_omap driver will be made to support omap_hsmmc binding
> (including "ti,omap4-hsmmc" compatible) and omap_hsmmc driver will
> be removed. Till then dt nodes with "ti,omap4-hsmmc" compatible
> will use omap_hsmmc driver and "ti,dra7-sdhci" compatible will
> use sdhci_omap driver.

Great that sounds good to me :) This way we can test and enable
it one SoC at a time.

Regards,

Tony

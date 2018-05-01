Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755600AbeEAOoD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 10:44:03 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:38510 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754084AbeEAOoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 10:44:00 -0400
X-Google-Smtp-Source: AB8JxZpyr/Nv/Csczagn8W1HPF/1DrfqfnX+mpbZ+lNlrAoiit5LmPci/M9HUbjjDK6k/pDC39kO1w==
Date: Tue, 1 May 2018 09:43:58 -0500
From: Rob Herring <robh@kernel.org>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmc: meson-gx: add device reset
Message-ID: <20180501144358.GA31556@rob-hp-laptop>
References: <20180426103817.12675-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180426103817.12675-1-jbrunet@baylibre.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 26, 2018 at 12:38:17PM +0200, Jerome Brunet wrote:
> Trigger the reset line of the mmc controller while probing, if available
> The reset should be optional for now, at least until all related DT node
> have the reset property
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  Documentation/devicetree/bindings/mmc/amlogic,meson-gx.txt | 2 ++
>  drivers/mmc/host/meson-gx-mmc.c                            | 6 ++++++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/amlogic,meson-gx.txt b/Documentation/devicetree/bindings/mmc/amlogic,meson-gx.txt
> index 5add8d7d855f..ba434375e7f2 100644
> --- a/Documentation/devicetree/bindings/mmc/amlogic,meson-gx.txt
> +++ b/Documentation/devicetree/bindings/mmc/amlogic,meson-gx.txt
> @@ -20,6 +20,7 @@ Required properties:
>  	"clkin1" - Other parent clock of internal mux
>    The driver has an internal mux clock which switches between clkin0 and clkin1 depending on the
>    clock rate requested by the MMC core.
> +- reset      : phandle of the internal reset line

resets

>  
>  Example:
>  
> @@ -30,4 +31,5 @@ Example:
>  		clocks = <&clkc CLKID_SD_EMMC_A>, <&xtal>, <&clkc CLKID_FCLK_DIV2>;
>  		clock-names = "core", "clkin0", "clkin1";
>  		pinctrl-0 = <&emmc_pins>;
> +		resets = <&reset RESET_SD_EMMC_A>;
>  	};

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752213AbeEPQ1Z (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 12:27:25 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:40549 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751579AbeEPQ1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 12:27:23 -0400
X-Google-Smtp-Source: AB8JxZqjhaWAl1nF+7TLjdQM29t0fqMmnlAMZ9fYCUyqBTzSQD4N2yZP8N3w4/CSXPtLLM8kqPs3kQ==
Message-ID: <1526488039.2897.65.camel@baylibre.com>
Subject: Re: [PATCH 2/2] ARM64: dts: meson-axg: remove incorrect i2c ao clock
From: Jerome Brunet <jbrunet@baylibre.com>
To: Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Wed, 16 May 2018 18:27:19 +0200
In-Reply-To: <20180516155203.24922-3-jbrunet@baylibre.com>
References: <20180516155203.24922-1-jbrunet@baylibre.com>
         <20180516155203.24922-3-jbrunet@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-05-16 at 17:52 +0200, Jerome Brunet wrote:
> The clock specified for the i2c AO controller is the one from
> the EE domain, which is incorrect as this controller needs the
> clock from AO clock controller.
> 
> Replace with xtal to avoid claiming an unrelated gate until the
> required clock controller becomes available.

I wrongly assumed the gate was provided by the clkc from AO domain.
Looking at what we did for the GX series, it seems to be provided by the EE
controller with CLKID_AO_I2C.

I'll send a v2 fixing this.
Sorry for the noise

> 
> Fixes: dc6f858e2690 ("ARM64: dts: meson-axg: add I2C DT info for Meson-AXG SoC")
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> index b59f341104d7..b82b9d79ec49 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> @@ -1110,7 +1110,12 @@
>  				compatible = "amlogic,meson-axg-i2c";
>  				reg = <0x0 0x05000 0x0 0x20>;
>  				interrupts = <GIC_SPI 195 IRQ_TYPE_EDGE_RISING>;
> -				clocks = <&clkc CLKID_I2C>;
> +
> +				/*
> +				 * FIXME: replace with the correct clock when
> +				 * the controller is available
> +				 */
> +				clocks = <&xtal>;
>  				#address-cells = <1>;
>  				#size-cells = <0>;
>  				status = "disabled";

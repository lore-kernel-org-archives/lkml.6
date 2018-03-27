Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752040AbeC0JAz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 05:00:55 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55263 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751054AbeC0JAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 05:00:52 -0400
X-Google-Smtp-Source: AG47ELuV/BDDljo0mx/OEJSL9nm7UtjcZLb67WSZ/mndmKQGEUUYOBLwL//HlQOG1cAr5nLDpXLPjw==
Message-ID: <1522141249.2632.25.camel@baylibre.com>
Subject: Re: [PATCH v2 7/7] ARM64: dts: meson-axg: add an 32K alt aoclk
From: Jerome Brunet <jbrunet@baylibre.com>
To: Yixun Lan <yixun.lan@amlogic.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>
Cc: Rob Herring <robh@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Date: Tue, 27 Mar 2018 11:00:49 +0200
In-Reply-To: <20180323143816.200573-8-yixun.lan@amlogic.com>
References: <20180323143816.200573-1-yixun.lan@amlogic.com>
         <20180323143816.200573-8-yixun.lan@amlogic.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-03-23 at 22:38 +0800, Yixun Lan wrote:
> The ao_clk81 in AO domain have two clock source,
> one from a 32K alt crystal we name it as ao_alt_clk,
> another is the clk81 signal from EE domain.
> 
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
> ---
>  arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> index b3d394f5d95a..48584d5a329b 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> @@ -109,6 +109,13 @@
>  		#clock-cells = <0>;
>  	};
>  
> +	ao_alt_xtal: ao_alt_xtal-clk {
> +		compatible = "fixed-clock";
> +		clock-frequency = <32000000>;
> +		clock-output-names = "ao_alt_xtal";
> +		#clock-cells = <0>;
> +	};

In DT, we seem to be using 'ao' and 'AO' to designate the Always On domain.
Maybe we should be try be consistent about this.

Anyway, this patch looks good but does not need to be part of the clkc_ao
series, it could go in independently.

Acked-by: Jerome Brunet <jbrunet@baylibre.com>

> +
>  	soc {
>  		compatible = "simple-bus";
>  		#address-cells = <2>;

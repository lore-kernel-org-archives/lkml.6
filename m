Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751412AbeEBIbT (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 04:31:19 -0400
Received: from lelnx194.ext.ti.com ([198.47.27.80]:49613 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751185AbeEBIbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 04:31:14 -0400
Subject: Re: [PATCH] arm: dts: am437x-sk-evm: add wilink8 support
To: Eyal Reizer <eyalreizer@gmail.com>, <bcousson@baylibre.com>,
        <tony@atomide.com>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linux-omap@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Eyal Reizer <eyalr@ti.com>
References: <1525159453-32489-1-git-send-email-eyalr@ti.com>
From: Sekhar Nori <nsekhar@ti.com>
Message-ID: <abebf4a1-11d6-413b-a3c0-4f46ac6fc485@ti.com>
Date: Wed, 2 May 2018 14:00:52 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1525159453-32489-1-git-send-email-eyalr@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 01 May 2018 12:54 PM, Eyal Reizer wrote:
> enable mmc3 used for wlan and uart1 used for bluetooth
> configure the gpios used for wlan and bluetooth controls
> add fixed voltage regulator used for wlan power control
> 
> Signed-off-by: Eyal Reizer <eyalr@ti.com>

ARM should be capitalized in subject line.

> +
> +&mmc3 {
> +	status = "okay";
> +	/*
> +	 * these are on the crossbar and are outlined in the
> +	 * xbar-event-map element
> +	 */
> +	dmas = <&edma_xbar 30 0 1>,
> +		<&edma_xbar 31 0 2>;
> +	dma-names = "tx", "rx";
> +	vmmc-supply = <&vmmcwl_fixed>;
> +	bus-width = <4>;
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&mmc3_pins_default>;
> +	pinctrl-1 = <&mmc3_pins_sleep>;
> +	cap-power-off-card;
> +	keep-power-in-suspend;
> +	ti,non-removable;
> +
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	wlcore: wlcore@0 {

wlcore@2

> +		compatible = "ti,wl1835";
> +		pinctrl-names = "default", "sleep";
> +		pinctrl-0 = <&wlan_pins_default>;
> +		pinctrl-1 = <&wlan_pins_sleep>;
> +		reg = <2>;
> +		interrupt-parent = <&gpio4>;
> +		interrupts = <13 IRQ_TYPE_LEVEL_HIGH>;
> +	};
> +};

Thanks,
Sekhar

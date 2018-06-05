Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751718AbeFEKHm (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 06:07:42 -0400
Received: from fllnx210.ext.ti.com ([198.47.19.17]:41323 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751564AbeFEKHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 06:07:40 -0400
Subject: Re: [PATCH] ARM: davinci: da850: Fix interrups property for gpio
To: <nsekhar@ti.com>
CC: <khilman@kernel.org>, <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1528193152-10657-1-git-send-email-j-keerthy@ti.com>
From: Keerthy <j-keerthy@ti.com>
Message-ID: <8ac6dddc-c914-92c5-2a97-85be6f7c0ee3@ti.com>
Date: Tue, 5 Jun 2018 15:37:07 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <1528193152-10657-1-git-send-email-j-keerthy@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tuesday 05 June 2018 03:35 PM, Keerthy wrote:
> The intc #interrupt-cells is equal to 1. Currently gpio
> node has 2 cells per IRQ which is wrong. Remove the additional
> cell for each of the interrupts.

Just noticed $Subject is not quite right. I will fix and send a v2 in a bit.

> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> Fixes: 2e38b946dc54 ("ARM: davinci: da850: add GPIO DT node")
> ---
>  arch/arm/boot/dts/da850.dtsi | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
> index f6f1597..0f4f817 100644
> --- a/arch/arm/boot/dts/da850.dtsi
> +++ b/arch/arm/boot/dts/da850.dtsi
> @@ -549,11 +549,7 @@
>  			gpio-controller;
>  			#gpio-cells = <2>;
>  			reg = <0x226000 0x1000>;
> -			interrupts = <42 IRQ_TYPE_EDGE_BOTH
> -				43 IRQ_TYPE_EDGE_BOTH 44 IRQ_TYPE_EDGE_BOTH
> -				45 IRQ_TYPE_EDGE_BOTH 46 IRQ_TYPE_EDGE_BOTH
> -				47 IRQ_TYPE_EDGE_BOTH 48 IRQ_TYPE_EDGE_BOTH
> -				49 IRQ_TYPE_EDGE_BOTH 50 IRQ_TYPE_EDGE_BOTH>;
> +			interrupts = <42 43 44 45 46 47 48 49 50>;
>  			ti,ngpio = <144>;
>  			ti,davinci-gpio-unbanked = <0>;
>  			status = "disabled";
> 

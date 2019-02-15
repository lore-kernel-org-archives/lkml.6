Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B8C0C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 08:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46022222DE
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 08:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ge/iLjf4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391411AbfBOIry (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 03:47:54 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:59350 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728761AbfBOIry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 03:47:54 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1F8loxG012681;
        Fri, 15 Feb 2019 02:47:50 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1550220470;
        bh=Hvyaajb+MHjAv7ncOUByb/REVL+23wPdwzLOY+aeQvk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=ge/iLjf4U1pKxjcxR9TuvOs+gEyDWoLnxUgsBpIdrnPRDcCnpO72VVrvuGUZQrnKE
         HFNHM39tQo2m6HvHuCmLbWpNLDG8zsXcOBjUV7QvNlt4hZj2Zq/kpUeQURv18wjRWX
         dI938Y1x3T8G/BCFIFRVLBEqRj+kC3EAwhsz9r6M=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1F8loqN036647
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 15 Feb 2019 02:47:50 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 15
 Feb 2019 02:47:49 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 15 Feb 2019 02:47:49 -0600
Received: from [127.0.0.1] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1F8ll80020171;
        Fri, 15 Feb 2019 02:47:48 -0600
Subject: Re: [PATCH] arm64: dts: ti: k3-am65-mcu: Add ADC nodes
To:     Vignesh R <vigneshr@ti.com>
CC:     Nishanth Menon <nm@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20190212122237.10976-1-vigneshr@ti.com>
From:   Tero Kristo <t-kristo@ti.com>
Message-ID: <53e9327d-e941-820e-d83c-d6c5ccf25e26@ti.com>
Date:   Fri, 15 Feb 2019 10:47:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190212122237.10976-1-vigneshr@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/02/2019 14:22, Vignesh R wrote:
> TI AM654 SoC has two ADC instances in the MCU domain. Add DT nodes for
> the same.
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> ---
> Tero,
> 
> Could you also pick up DT bindings here: https://patchwork.kernel.org/patch/10751429/
> All the Acks are in place.

Queued for 5.1, including the dt-binding.

Thanks, Tero

> 
>   arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi       | 30 +++++++++++++++++++
>   .../arm64/boot/dts/ti/k3-am654-base-board.dts | 12 ++++++++
>   2 files changed, 42 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
> index 593f718e8fb5..6f7d2b316ded 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
> @@ -57,4 +57,34 @@
>   		#address-cells = <1>;
>   		#size-cells = <0>;
>   	};
> +
> +	tscadc0: tscadc@40200000 {
> +		compatible = "ti,am654-tscadc", "ti,am3359-tscadc";
> +		reg = <0x0 0x40200000 0x0 0x1000>;
> +		interrupts = <GIC_SPI 580 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&k3_clks 0 2>;
> +		assigned-clocks = <&k3_clks 0 2>;
> +		assigned-clock-rates = <60000000>;
> +		clock-names = "adc_tsc_fck";
> +
> +		adc {
> +			#io-channel-cells = <1>;
> +			compatible = "ti,am654-adc", "ti,am3359-adc";
> +		};
> +	};
> +
> +	tscadc1: tscadc@40210000 {
> +		compatible = "ti,am654-tscadc", "ti,am3359-tscadc";
> +		reg = <0x0 0x40210000 0x0 0x1000>;
> +		interrupts = <GIC_SPI 581 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&k3_clks 1 2>;
> +		assigned-clocks = <&k3_clks 1 2>;
> +		assigned-clock-rates = <60000000>;
> +		clock-names = "adc_tsc_fck";
> +
> +		adc {
> +			#io-channel-cells = <1>;
> +			compatible = "ti,am654-adc", "ti,am3359-adc";
> +		};
> +	};
>   };
> diff --git a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
> index e41fc3a5987b..fb6df5c8f85b 100644
> --- a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
> @@ -163,3 +163,15 @@
>   		#size-cells= <1>;
>   	};
>   };
> +
> +&tscadc0 {
> +	adc {
> +		ti,adc-channels = <0 1 2 3 4 5 6 7>;
> +	};
> +};
> +
> +&tscadc1 {
> +	adc {
> +		ti,adc-channels = <0 1 2 3 4 5 6 7>;
> +	};
> +};
> 

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

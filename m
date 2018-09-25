Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD0FC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 15:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C01352098A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 15:48:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fh5qRBO6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C01352098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729644AbeIYV4p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 17:56:45 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37958 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729421AbeIYV4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 17:56:45 -0400
Received: by mail-ed1-f67.google.com with SMTP id x8-v6so5909216eds.5;
        Tue, 25 Sep 2018 08:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ehDh9e8OXCDqFF4hqUrZKMnc1RawGArR+EXDOns+SzY=;
        b=fh5qRBO6+jHofkif34ylswAsxbj5x8IB+se1t/Z1ezFD3XU/u9AyUpj54SgLvdbtti
         2jh1k8dTtYGQMEj9PmNtO6HyXMgoGcZgJV5c2Dy0PzPRagut/amWTq7RCgRK4znsaQpM
         IVF2uwZP4iRQREBVUYqBfuaS63yuBeonuYFNfzgGJdwUOtl3ky1BOSukC6JY/nyeEPST
         CNICwFhUKr9ctea+h32hMJjzcpp96CTxQpwpXfKY/ITX0/lyvHykjvapLWzeiP26nMbH
         pZ7rncXfWMUQwlSEW1557Q1wrJyi7G5IIv/vBf2EB7IKRK5qTX0vcCdxJKq9fMTLf3tI
         CpMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ehDh9e8OXCDqFF4hqUrZKMnc1RawGArR+EXDOns+SzY=;
        b=MDCpJP88hKm1Cuzxb7eUJJ7aRJthcl6e8x2Rjcn3GXtjnCwZazBPZV3OQloz0n2PcL
         zN2A0XqJFB/zbuYC57963CEOBmDElhfsvV2PASdBSjo5mtfSBMLMo8s7+Fjgl5snLbJl
         /ZlpoUr43IDgK5MVI7TLCMEHBAOiY5sd5xeVRtjJiyl5k/L+4L9fyFYNZyg/JPtPPXb4
         fxY8cXhivGx356IhjiuBVcR3JUIU/bhSbS/FIU3ktcAeQu/0GWJUlURKZazl6ZY0mbDU
         x9tweB4dlcIc9jq7GXWGorxdTH9yZ+bix+DjG5errnt4pRohs0Pu2CU8/ltQEtiFgWFH
         Eg4A==
X-Gm-Message-State: ABuFfogLj7BP0sGLvYdxeMkf4YC8w0sRrubgSwzdfAGsqNepfVlIb3vm
        AlwB/LLC7R3BfDQN3yCiWEU=
X-Google-Smtp-Source: ACcGV61VYXLEa5lrVNn9ZSR69MHL3EEeq94XZllxqoZPAOztQtvowY5gHJoWxwP9s9k7uxVgXB75cA==
X-Received: by 2002:a50:9feb:: with SMTP id c98-v6mr2194676edf.130.1537890515941;
        Tue, 25 Sep 2018 08:48:35 -0700 (PDT)
Received: from ziggy.stardust ([37.223.146.97])
        by smtp.gmail.com with ESMTPSA id u20-v6sm1893398eds.10.2018.09.25.08.48.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 08:48:34 -0700 (PDT)
Subject: Re: [Resend PATCH 5/5] arm: dts: mt7623: add display subsystem
 related device nodes
To:     Ryder Lee <ryder.lee@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Sean Wang <sean.wang@mediatek.com>,
        Roy Luo <cheng-hao.luo@mediatek.com>,
        Weijie Gao <weijie.gao@mediatek.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, CK Hu <ck.hu@mediatek.com>,
        chunhui dai <chunhui.dai@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>
References: <84011aa94dd7be9239b7a2f944dd30fc70568fbb.1536155449.git.ryder.lee@mediatek.com>
 <7105c341de3525761ad4067ca57c641c7097f773.1536155449.git.ryder.lee@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=matthias.bgg@gmail.com; prefer-encrypt=mutual; keydata=
 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
 UXI+r2JwH1CJjrHWeQEI2ucSKsNa8FllDmG/fQ==
Message-ID: <aef1f507-b217-5587-d058-fb0b08698cd1@gmail.com>
Date:   Tue, 25 Sep 2018 17:48:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <7105c341de3525761ad4067ca57c641c7097f773.1536155449.git.ryder.lee@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/09/2018 16:09, Ryder Lee wrote:
> Add display subsystem related device nodes for MT7623.
> 
> Cc: CK Hu <ck.hu@mediatek.com>
> Signed-off-by: chunhui dai <chunhui.dai@mediatek.com>
> Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
> I forgot to sort nodes in my previous mail. Sorry for the inconvenience.
> 
> This patch depends on the series: https://lkml.org/lkml/2018/9/5/223

That's not yet merged, right?

> 
> @Matthias,
> I know you're working on broken MMSYS - just want to ask whether it's possible
> to let the patch to go to your tree (if others are okay with it), and send a
> fixup one for MT7623 MMSYS later?

I know I'm a big blocker here, sorry for the inconvenience.
I'll do my best to get that in for the next release. If I make no progress on
that then we should find a different solution.

Regards,
Matthias

> ---
>  arch/arm/boot/dts/mt7623.dtsi                 | 177 ++++++++++++++++++++++++++
>  arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts |  83 ++++++++++++
>  arch/arm/boot/dts/mt7623n-rfb-emmc.dts        |  83 ++++++++++++
>  3 files changed, 343 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/mt7623.dtsi b/arch/arm/boot/dts/mt7623.dtsi
> index d01bdee..fdf9078 100644
> --- a/arch/arm/boot/dts/mt7623.dtsi
> +++ b/arch/arm/boot/dts/mt7623.dtsi
> @@ -23,6 +23,11 @@
>  	#address-cells = <2>;
>  	#size-cells = <2>;
>  
> +	aliases {
> +		rdma0 = &rdma0;
> +		rdma1 = &rdma1;
> +	};
> +
>  	cpu_opp_table: opp-table {
>  		compatible = "operating-points-v2";
>  		opp-shared;
> @@ -311,6 +316,25 @@
>  		clock-names = "spi", "wrap";
>  	};
>  
> +	mipi_tx0: mipi-dphy@10010000 {
> +		compatible = "mediatek,mt7623-mipi-tx",
> +			     "mediatek,mt2701-mipi-tx";
> +		reg = <0 0x10010000 0 0x90>;
> +		clocks = <&clk26m>;
> +		clock-output-names = "mipi_tx0_pll";
> +		#clock-cells = <0>;
> +		#phy-cells = <0>;
> +	};
> +
> +	cec: cec@10012000 {
> +		compatible = "mediatek,mt7623-cec",
> +			     "mediatek,mt8173-cec";
> +		reg = <0 0x10012000 0 0xbc>;
> +		interrupts = <GIC_SPI 182 IRQ_TYPE_LEVEL_LOW>;
> +		clocks = <&infracfg CLK_INFRA_CEC>;
> +		status = "disabled";
> +	};
> +
>  	cir: cir@10013000 {
>  		compatible = "mediatek,mt7623-cir";
>  		reg = <0 0x10013000 0 0x1000>;
> @@ -359,6 +383,18 @@
>  		#clock-cells = <1>;
>  	};
>  
> +	hdmi_phy: phy@10209100 {
> +		compatible = "mediatek,mt7623-hdmi-phy",
> +			     "mediatek,mt2701-hdmi-phy";
> +		reg = <0 0x10209100 0 0x24>;
> +		clocks = <&apmixedsys CLK_APMIXED_HDMI_REF>;
> +		clock-names = "pll_ref";
> +		clock-output-names = "hdmitx_dig_cts";
> +		#clock-cells = <0>;
> +		#phy-cells = <0>;
> +		status = "disabled";
> +	};
> +
>  	rng: rng@1020f000 {
>  		compatible = "mediatek,mt7623-rng";
>  		reg = <0 0x1020f000 0 0x1000>;
> @@ -558,6 +594,16 @@
>  		status = "disabled";
>  	};
>  
> +	hdmiddc0: i2c@11013000 {
> +		compatible = "mediatek,mt7623-hdmi-ddc",
> +			     "mediatek,mt8173-hdmi-ddc";
> +		interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_LOW>;
> +		reg = <0 0x11013000 0 0x1C>;
> +		clocks = <&pericfg CLK_PERI_I2C3>;
> +		clock-names = "ddc-i2c";
> +		status = "disabled";
> +	};
> +
>  	nor_flash: spi@11014000 {
>  		compatible = "mediatek,mt7623-nor",
>  			     "mediatek,mt8173-nor";
> @@ -732,6 +778,84 @@
>  		#clock-cells = <1>;
>  	};
>  
> +	display_components: dispsys@14000000 {
> +		compatible = "mediatek,mt7623-mmsys",
> +			     "mediatek,mt2701-mmsys";
> +		reg = <0 0x14000000 0 0x1000>;
> +		power-domains = <&scpsys MT2701_POWER_DOMAIN_DISP>;
> +	};
> +
> +	ovl@14007000 {
> +		compatible = "mediatek,mt7623-disp-ovl",
> +			     "mediatek,mt2701-disp-ovl";
> +		reg = <0 0x14007000 0 0x1000>;
> +		interrupts = <GIC_SPI 153 IRQ_TYPE_LEVEL_LOW>;
> +		clocks = <&mmsys CLK_MM_DISP_OVL>;
> +		iommus = <&iommu MT2701_M4U_PORT_DISP_OVL_0>;
> +		mediatek,larb = <&larb0>;
> +	};
> +
> +	rdma0: rdma@14008000 {
> +		compatible = "mediatek,mt7623-disp-rdma",
> +			     "mediatek,mt2701-disp-rdma";
> +		reg = <0 0x14008000 0 0x1000>;
> +		interrupts = <GIC_SPI 152 IRQ_TYPE_LEVEL_LOW>;
> +		clocks = <&mmsys CLK_MM_DISP_RDMA>;
> +		iommus = <&iommu MT2701_M4U_PORT_DISP_RDMA>;
> +		mediatek,larb = <&larb0>;
> +	};
> +
> +	wdma@14009000 {
> +		compatible = "mediatek,mt7623-disp-wdma",
> +			     "mediatek,mt2701-disp-wdma";
> +		reg = <0 0x14009000 0 0x1000>;
> +		interrupts = <GIC_SPI 154 IRQ_TYPE_LEVEL_LOW>;
> +		clocks = <&mmsys CLK_MM_DISP_WDMA>;
> +		iommus = <&iommu MT2701_M4U_PORT_DISP_WDMA>;
> +		mediatek,larb = <&larb0>;
> +	};
> +
> +	bls: pwm@1400a000 {
> +		compatible = "mediatek,mt7623-disp-pwm",
> +			     "mediatek,mt2701-disp-pwm";
> +		reg = <0 0x1400a000 0 0x1000>;
> +		#pwm-cells = <2>;
> +		clocks = <&mmsys CLK_MM_MDP_BLS_26M>,
> +			 <&mmsys CLK_MM_DISP_BLS>;
> +		clock-names = "main", "mm";
> +		status = "disabled";
> +	};
> +
> +	color@1400b000 {
> +		compatible = "mediatek,mt7623-disp-color",
> +			     "mediatek,mt2701-disp-color";
> +		reg = <0 0x1400b000 0 0x1000>;
> +		interrupts = <GIC_SPI 156 IRQ_TYPE_LEVEL_LOW>;
> +		clocks = <&mmsys CLK_MM_DISP_COLOR>;
> +	};
> +
> +	dsi: dsi@1400c000 {
> +		compatible = "mediatek,mt7623-dsi",
> +			     "mediatek,mt2701-dsi";
> +		reg = <0 0x1400c000 0 0x1000>;
> +		interrupts = <GIC_SPI 157 IRQ_TYPE_LEVEL_LOW>;
> +		clocks = <&mmsys CLK_MM_DSI_ENGINE>,
> +			 <&mmsys CLK_MM_DSI_DIG>,
> +			 <&mipi_tx0>;
> +		clock-names = "engine", "digital", "hs";
> +		phys = <&mipi_tx0>;
> +		phy-names = "dphy";
> +		status = "disabled";
> +	};
> +
> +	mutex: mutex@1400e000 {
> +		compatible = "mediatek,mt7623-disp-mutex",
> +			     "mediatek,mt2701-disp-mutex";
> +		reg = <0 0x1400e000 0 0x1000>;
> +		interrupts = <GIC_SPI 161 IRQ_TYPE_LEVEL_LOW>;
> +		clocks = <&mmsys CLK_MM_MUTEX_32K>;
> +	};
> +
>  	larb0: larb@14010000 {
>  		compatible = "mediatek,mt7623-smi-larb",
>  			     "mediatek,mt2701-smi-larb";
> @@ -744,6 +868,44 @@
>  		power-domains = <&scpsys MT2701_POWER_DOMAIN_DISP>;
>  	};
>  
> +	rdma1: rdma@14012000 {
> +		compatible = "mediatek,mt7623-disp-rdma",
> +			     "mediatek,mt2701-disp-rdma";
> +		reg = <0 0x14012000 0 0x1000>;
> +		interrupts = <GIC_SPI 164 IRQ_TYPE_LEVEL_LOW>;
> +		clocks = <&mmsys CLK_MM_DISP_RDMA1>;
> +		iommus = <&iommu MT2701_M4U_PORT_DISP_RDMA1>;
> +		mediatek,larb = <&larb0>;
> +	};
> +
> +	dpi0: dpi@14014000 {
> +		compatible = "mediatek,mt7623-dpi",
> +			     "mediatek,mt2701-dpi";
> +		reg = <0 0x14014000 0 0x1000>;
> +		interrupts = <GIC_SPI 194 IRQ_TYPE_LEVEL_LOW>;
> +		clocks = <&mmsys CLK_MM_DPI1_DIGL>,
> +			 <&mmsys CLK_MM_DPI1_ENGINE>,
> +			 <&topckgen CLK_TOP_TVDPLL>;
> +		clock-names = "pixel", "engine", "pll";
> +		status = "disabled";
> +	};
> +
> +	hdmi0: hdmi@14015000 {
> +		compatible = "mediatek,mt7623-hdmi",
> +			     "mediatek,mt8173-hdmi";
> +		reg = <0 0x14015000 0 0x400>;
> +		clocks = <&mmsys CLK_MM_HDMI_PIXEL>,
> +			 <&mmsys CLK_MM_HDMI_PLL>,
> +			 <&mmsys CLK_MM_HDMI_AUDIO>,
> +			 <&mmsys CLK_MM_HDMI_SPDIF>;
> +		clock-names = "pixel", "pll", "bclk", "spdif";
> +		phys = <&hdmi_phy>;
> +		phy-names = "hdmi";
> +		mediatek,syscon-hdmi = <&mmsys 0x900>;
> +		cec = <&cec>;
> +		status = "disabled";
> +	};
> +
>  	imgsys: syscon@15000000 {
>  		compatible = "mediatek,mt7623-imgsys",
>  			     "mediatek,mt2701-imgsys",
> @@ -1071,6 +1233,21 @@
>  		};
>  	};
>  
> +	hdmi_pins_a: hdmi-default {
> +		pins-hdmi {
> +			pinmux = <MT7623_PIN_123_HTPLG_FUNC_HTPLG>;
> +			input-enable;
> +			bias-pull-down;
> +		};
> +	};
> +
> +	hdmi_ddc_pins_a: hdmi_ddc-default {
> +		pins-hdmi-ddc {
> +			pinmux = <MT7623_PIN_124_GPIO124_FUNC_HDMISCK>,
> +				 <MT7623_PIN_125_GPIO125_FUNC_HDMISD>;
> +		};
> +	};
> +
>  	i2c0_pins_a: i2c0-default {
>  		pins-i2c0 {
>  			pinmux = <MT7623_PIN_75_SDA0_FUNC_SDA0>,
> diff --git a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
> index 2b760f9..dbce86b 100644
> --- a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
> +++ b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
> @@ -21,6 +21,19 @@
>  		stdout-path = "serial2:115200n8";
>  	};
>  
> +	connector {
> +		compatible = "hdmi-connector";
> +		label = "hdmi";
> +		type = "d";
> +		ddc-i2c-bus = <&hdmiddc0>;
> +
> +		port {
> +			hdmi_connector_in: endpoint {
> +				remote-endpoint = <&hdmi0_out>;
> +			};
> +		};
> +	};
> +
>  	cpus {
>  		cpu@0 {
>  			proc-supply = <&mt6323_vproc_reg>;
> @@ -114,10 +127,24 @@
>  	};
>  };
>  
> +&bls {
> +	status = "okay";
> +
> +	port {
> +		bls_out: endpoint {
> +			remote-endpoint = <&dpi0_in>;
> +		};
> +	};
> +};
> +
>  &btif {
>  	status = "okay";
>  };
>  
> +&cec {
> +	status = "okay";
> +};
> +
>  &cir {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&cir_pins_a>;
> @@ -128,6 +155,26 @@
>  	status = "okay";
>  };
>  
> +&dpi0 {
> +	status = "okay";
> +
> +	ports {
> +		port@0 {
> +			reg = <0>;
> +			dpi0_out: endpoint {
> +				remote-endpoint = <&hdmi0_in>;
> +			};
> +		};
> +
> +		port@1 {
> +			reg = <1>;
> +			dpi0_in: endpoint {
> +				remote-endpoint = <&bls_out>;
> +			};
> +		};
> +	};
> +};
> +
>  &eth {
>  	status = "okay";
>  
> @@ -199,6 +246,42 @@
>  	};
>  };
>  
> +&hdmi0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&hdmi_pins_a>;
> +	status = "okay";
> +
> +	ports {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		port@0 {
> +			reg = <0>;
> +			hdmi0_in: endpoint {
> +				remote-endpoint = <&dpi0_out>;
> +			};
> +		};
> +
> +		port@1 {
> +			reg = <1>;
> +			hdmi0_out: endpoint {
> +				remote-endpoint = <&hdmi_connector_in>;
> +			};
> +		};
> +	};
> +};
> +
> +&hdmiddc0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&hdmi_ddc_pins_a>;
> +	status = "okay";
> +};
> +
> +&hdmi_phy {
> +	mediatek,ibias = <0xa>;
> +	mediatek,ibias_up = <0x1c>;
> +	status = "okay";
> +};
> +
>  &i2c0 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&i2c0_pins_a>;
> diff --git a/arch/arm/boot/dts/mt7623n-rfb-emmc.dts b/arch/arm/boot/dts/mt7623n-rfb-emmc.dts
> index b760613..bdf9010 100644
> --- a/arch/arm/boot/dts/mt7623n-rfb-emmc.dts
> +++ b/arch/arm/boot/dts/mt7623n-rfb-emmc.dts
> @@ -24,6 +24,19 @@
>  		stdout-path = "serial2:115200n8";
>  	};
>  
> +	connector {
> +		compatible = "hdmi-connector";
> +		label = "hdmi";
> +		type = "d";
> +		ddc-i2c-bus = <&hdmiddc0>;
> +
> +		port {
> +			hdmi_connector_in: endpoint {
> +				remote-endpoint = <&hdmi0_out>;
> +			};
> +		};
> +	};
> +
>  	cpus {
>  		cpu@0 {
>  			proc-supply = <&mt6323_vproc_reg>;
> @@ -106,10 +119,24 @@
>  	};
>  };
>  
> +&bls {
> +	status = "okay";
> +
> +	port {
> +		bls_out: endpoint {
> +			remote-endpoint = <&dpi0_in>;
> +		};
> +	};
> +};
> +
>  &btif {
>  	status = "okay";
>  };
>  
> +&cec {
> +	status = "okay";
> +};
> +
>  &cir {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&cir_pins_a>;
> @@ -120,6 +147,26 @@
>  	status = "okay";
>  };
>  
> +&dpi0 {
> +	status = "okay";
> +
> +	ports {
> +		port@0 {
> +			reg = <0>;
> +			dpi0_out: endpoint {
> +				remote-endpoint = <&hdmi0_in>;
> +			};
> +		};
> +
> +		port@1 {
> +			reg = <1>;
> +			dpi0_in: endpoint {
> +				remote-endpoint = <&bls_out>;
> +			};
> +		};
> +	};
> +};
> +
>  &eth {
>  	status = "okay";
>  
> @@ -202,6 +249,42 @@
>  	};
>  };
>  
> +&hdmi0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&hdmi_pins_a>;
> +	status = "okay";
> +
> +	ports {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		port@0 {
> +			reg = <0>;
> +			hdmi0_in: endpoint {
> +				remote-endpoint = <&dpi0_out>;
> +			};
> +		};
> +
> +		port@1 {
> +			reg = <1>;
> +			hdmi0_out: endpoint {
> +				remote-endpoint = <&hdmi_connector_in>;
> +			};
> +		};
> +	};
> +};
> +
> +&hdmiddc0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&hdmi_ddc_pins_a>;
> +	status = "okay";
> +};
> +
> +&hdmi_phy {
> +	mediatek,ibias = <0xa>;
> +	mediatek,ibias_up = <0x1c>;
> +	status = "okay";
> +};
> +
>  &i2c0 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&i2c0_pins_a>;
> 

Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1064AC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 15:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAB122098A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 15:10:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V+QYUOlO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAB122098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729480AbeIYVSD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 17:18:03 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45431 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729098AbeIYVSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 17:18:03 -0400
Received: by mail-ed1-f67.google.com with SMTP id j2-v6so6331151edp.12;
        Tue, 25 Sep 2018 08:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=moMLlfMqNnzdLe3UkE0VUn+H/KiV5e7wEcjOdlNrZ94=;
        b=V+QYUOlO6l+jfbEwiCtB/rImj2ACD2EEsEgNRqE1wKqkz3m4ZIu49Gg273zRMdfg38
         kWR92UcfFVTaacEWKrtarWVmpb36q5NJkZAias4dFQZdd89+OKQKzhAXdiMjkjeFPfAm
         M4misps0ZZ1DP+WSNqiIRQiMDyGm3tNlQFnYRUFNXKac5LQbWUtbDbBJGC85DblGVhDY
         WaN/nwSlBuCFkxGKt8q5/HD/El+3Kofcgrvn8LPyPIi8OlYyTplZoiNsQRI4FrrMxo7v
         3B8R6XFPpIc8calqqf9SQYDDVShJG3JE5U13gLwSNRPMhosxYUuo7QQXe76dWVioZbxu
         nr8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=moMLlfMqNnzdLe3UkE0VUn+H/KiV5e7wEcjOdlNrZ94=;
        b=QUm8tZJgsi1LYaiV1jtoCjL63E0DHIUZJ20Y7s6w2Y3KiXFI7YYBd2eS1zaSyyfLcd
         pNdmlnFPz9ICn1HVzeanyiznkTNNEg3VRIuqjiAyA1NeC5uTQUZjH+Bznb7hhod91l9F
         EHB2ON3tXjENdaRsYQ4+3dm5JzNcpYUevug3eyUaqmqOUvtTwpP973mAgMaWiVnB4YyY
         HOHN25yNdsQHnqcUm8lhT3UmSaV5NnXzdyuq2b4j6G9XCWeH85mJKAVdhIis9ils2R/u
         ZlisDVDFWXAXBEH8xG1lXTO1OHlkmWgv6wPrhbIEuEmSru+TngkimtHqYI5f/fm+hhZ8
         X6jQ==
X-Gm-Message-State: ABuFfoiSy6uA+SKq5vZZ/OYixx8omyTz2TXl83lAR/SNni6bC1Gi+Gfd
        Y9DYUfPPbwCzoHmg8H6mheA=
X-Google-Smtp-Source: ACcGV632b9sTW2TTpb5amr1Gg5x0VDc330vb5CGZnV482Flb8THCgA6oFfvFSISfoBF8bUwmSTgIAQ==
X-Received: by 2002:a50:af03:: with SMTP id g3-v6mr2068224edd.220.1537888204871;
        Tue, 25 Sep 2018 08:10:04 -0700 (PDT)
Received: from ziggy.stardust ([37.223.146.97])
        by smtp.gmail.com with ESMTPSA id j14-v6sm8396898eda.76.2018.09.25.08.10.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 08:10:03 -0700 (PDT)
Subject: Re: [PATCH v1 1/5] arm64: dts: mt7622: add timer, CCI-400 and PMU
 nodes
To:     Ryder Lee <ryder.lee@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Sean Wang <sean.wang@mediatek.com>,
        Roy Luo <cheng-hao.luo@mediatek.com>,
        Weijie Gao <weijie.gao@mediatek.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <7d3ce6a89ffeb221dc3197b763521582bf300577.1534607107.git.ryder.lee@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=matthias.bgg@gmail.com; prefer-encrypt=mutual; keydata=
 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
 UXI+r2JwH1CJjrHWeQEI2ucSKsNa8FllDmG/fQ==
Message-ID: <5cd2bf92-251d-7a48-5bb0-95060d6ccb51@gmail.com>
Date:   Tue, 25 Sep 2018 17:10:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <7d3ce6a89ffeb221dc3197b763521582bf300577.1534607107.git.ryder.lee@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Whole series pushed to v4.19-next/dts64

Thanks!

On 18/08/2018 18:02, Ryder Lee wrote:
> Add device tree entries for timer, ARM CCI-400 and its PMU.
> Otherwise, we add a cortex-a53-pmu node to enable hw perfevents.
> 
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
> change since v1:
> - add a pmu node.
> ---
>  arch/arm64/boot/dts/mediatek/mt7622.dtsi | 55 ++++++++++++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt7622.dtsi b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
> index de2c47bd..d297100 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
> @@ -79,6 +79,7 @@
>  			#cooling-cells = <2>;
>  			enable-method = "psci";
>  			clock-frequency = <1300000000>;
> +			cci-control-port = <&cci_control2>;
>  		};
>  
>  		cpu1: cpu@1 {
> @@ -92,6 +93,7 @@
>  			#cooling-cells = <2>;
>  			enable-method = "psci";
>  			clock-frequency = <1300000000>;
> +			cci-control-port = <&cci_control2>;
>  		};
>  	};
>  
> @@ -113,6 +115,13 @@
>  		method      = "smc";
>  	};
>  
> +	pmu {
> +		compatible = "arm,cortex-a53-pmu";
> +		interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_SPI 9 IRQ_TYPE_LEVEL_LOW>;
> +		interrupt-affinity = <&cpu0>, <&cpu1>;
> +	};
> +
>  	reserved-memory {
>  		#address-cells = <2>;
>  		#size-cells = <2>;
> @@ -218,6 +227,16 @@
>  		#reset-cells = <1>;
>  	};
>  
> +        timer: timer@10004000 {
> +                compatible = "mediatek,mt7622-timer",
> +                             "mediatek,mt6577-timer";
> +                reg = <0 0x10004000 0 0x80>;
> +                interrupts = <GIC_SPI 152 IRQ_TYPE_LEVEL_LOW>;
> +                clocks = <&infracfg CLK_INFRA_APXGPT_PD>,
> +                         <&topckgen CLK_TOP_RTC>;
> +                clock-names = "system-clk", "rtc-clk";
> +        };
> +
>  	scpsys: scpsys@10006000 {
>  		compatible = "mediatek,mt7622-scpsys",
>  			     "syscon";
> @@ -325,6 +344,42 @@
>  		      <0 0x10360000 0 0x2000>;
>  	};
>  
> +	cci: cci@10390000 {
> +		compatible = "arm,cci-400";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		reg = <0 0x10390000 0 0x1000>;
> +		ranges = <0 0 0x10390000 0x10000>;
> +
> +		cci_control0: slave-if@1000 {
> +			compatible = "arm,cci-400-ctrl-if";
> +			interface-type = "ace-lite";
> +			reg = <0x1000 0x1000>;
> +		};
> +
> +		cci_control1: slave-if@4000 {
> +			compatible = "arm,cci-400-ctrl-if";
> +			interface-type = "ace";
> +			reg = <0x4000 0x1000>;
> +		};
> +
> +		cci_control2: slave-if@5000 {
> +			compatible = "arm,cci-400-ctrl-if";
> +			interface-type = "ace";
> +			reg = <0x5000 0x1000>;
> +		};
> +
> +		pmu@9000 {
> +			compatible = "arm,cci-400-pmu,r1";
> +			reg = <0x9000 0x5000>;
> +			interrupts = <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
> +		};
> +	};
> +
>  	auxadc: adc@11001000 {
>  		compatible = "mediatek,mt7622-auxadc";
>  		reg = <0 0x11001000 0 0x1000>;
> 

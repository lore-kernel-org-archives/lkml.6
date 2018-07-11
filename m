Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED522C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A79EA205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:25:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="uhI5w7/8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A79EA205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388441AbeGKQa6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 12:30:58 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:51646 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387834AbeGKQa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 12:30:58 -0400
Received: by mail-wm0-f66.google.com with SMTP id s12-v6so3003228wmc.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 09:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OfRkyFq29lQQdS6R/SlofIeqzn2E3RYjTUlTC12peto=;
        b=uhI5w7/8VZCzy45TgkERwO/WozJC+LR+v2dJKug7P13Znar4mZ1AiZf/S446xzKhm4
         G1N8+4kpW9m2Q7AkvtTrk1lFGFo/tT4PYcoklA1z8fHQvxblTrbfUn163wJkxjoUm45n
         WKWlLMqJLdTIAG199R613euJ18kiEmk6j58sPQVUPGSaoGzEI+leFP2ZZZ+AzqJH+8W2
         qE67PCvezh6JzB2g0BjJfEk99oRvBVbvJdKwlI7d6TBy6skB4RSsaU67GwjyPJhETDSH
         F/sI8SwLkV365c6nh3jEjJLa+lM3jVuscUbEKNDcKBJ9Y6q6legeVki48lwpKgo4yNS9
         rm4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OfRkyFq29lQQdS6R/SlofIeqzn2E3RYjTUlTC12peto=;
        b=cobzWUL5InJ94Huz3RZ8sVk3BhKO9C+H0SeGb14V4FQ/FHF58Ntg2L5Naq+nr1Hdqq
         aMQ/LgPrmUQpSIuL5vD6fIEHgfu0zMoyH+hby6fmAgAkqSgJtch6Gf9ymcxIGhdmZvm6
         O44UXK0KgESPWyto05ygDCQ/Div5mdQAiJqKYYzXmm4eIWwNJMwnPyADgiIV6n6JnIjc
         3rn/qY5QJ9mCbfeXbfhSDsmmUo0h9otwn1hb07qb7h10DK3FyTc8MfEDeIQD2IjIRxVV
         HSTOw0MTfUOpYdTQSUa9XK3/g3zLTLuPxeC1TxnuK+QoQb5fd28916Jv9qKBR+b9cOt3
         KWYw==
X-Gm-Message-State: APt69E1wa63dhQW9l0MGlSAhkDH1Phif7VYZD8a3PqSsr9wdFHwfY8B4
        G67GANsDx9x1QEOQUOmVy8zyRw==
X-Google-Smtp-Source: AAOMgpe0YJeNbjaSvmHNbh0rYnsqQLqJXwxAfsgTgd1kWBxXI8P0tdLLil8mx1Wplx3CBLD+r1FMJw==
X-Received: by 2002:a1c:9c4c:: with SMTP id f73-v6mr17016766wme.141.1531326351282;
        Wed, 11 Jul 2018 09:25:51 -0700 (PDT)
Received: from boomer ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id s2-v6sm17255815wrn.75.2018.07.11.09.25.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Jul 2018 09:25:50 -0700 (PDT)
Message-ID: <1531326349.2708.136.camel@baylibre.com>
Subject: Re: [PATCH v2] ARM64: dts: meson-axg: add saradc support
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Yixun Lan <yixun.lan@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Xingyu Chen <xingyu.chen@amlogic.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Date:   Wed, 11 Jul 2018 18:25:49 +0200
In-Reply-To: <20180702222515.13924-1-yixun.lan@amlogic.com>
References: <20180702222515.13924-1-yixun.lan@amlogic.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-07-02 at 22:25 +0000, Yixun Lan wrote:
> From: Xingyu Chen <xingyu.chen@amlogic.com>
> 
> Add the DT info for SAR ADC of the Amlogic's Meson-AXG SoC.
> 
> Signed-off-by: Xingyu Chen <xingyu.chen@amlogic.com>
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
> ---
> Hi kevin
>   I just re-send this patch which rebased to your khilman/v4.18/integ branch
>   Thanks
> Yixun
> 
> nothing changed since patch v1 [1]:
>  -
> 
> [1] https://lkml.kernel.org/r/20180326092117.208416-1-yixun.lan@amlogic.com
> 
> ---
>  .../arm64/boot/dts/amlogic/meson-axg-s400.dts |  5 +++++
>  arch/arm64/boot/dts/amlogic/meson-axg.dtsi    | 21 +++++++++++++++++++
>  2 files changed, 26 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
> index 4b3331fbfe39..6041f68b32ae 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
> @@ -153,3 +153,8 @@
>  		compatible = "brcm,bcm4329-fmac";
>  	};
>  };
> +
> +&saradc {
> +	status = "okay";
> +	vref-supply = <&vddio_ao18>;
> +};
> diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> index 67d7115e4eff..52678a69dbf8 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> @@ -91,6 +91,13 @@
>  		method = "smc";
>  	};
>  
> +	vddio_ao18: regulator-vddio_ao18 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VDDIO_AO18";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +	};

Kevin, Yixun,

I find odd that we are adding a regulator to SoC device tree file.
Those regulator are usually part of board file

Unless the regulator is actually inside the SoC, this is not the place for it.

Sorry for not catching this earlier.

> +
>  	timer {
>  		compatible = "arm,armv8-timer";
>  		interrupts = <GIC_PPI 13
> @@ -1194,6 +1201,20 @@
>  				interrupts = <GIC_SPI 196 IRQ_TYPE_EDGE_RISING>;
>  				status = "disabled";
>  			};
> +
> +			saradc: adc@9000 {
> +				compatible = "amlogic,meson-axg-saradc",
> +					"amlogic,meson-saradc";
> +				reg = <0x0 0x9000 0x0 0x38>;
> +				#io-channel-cells = <1>;
> +				interrupts = <GIC_SPI 73 IRQ_TYPE_EDGE_RISING>;
> +				clocks = <&xtal>,
> +					<&clkc_AO CLKID_AO_SAR_ADC>,
> +					<&clkc_AO CLKID_AO_SAR_ADC_CLK>,
> +					<&clkc_AO CLKID_AO_SAR_ADC_SEL>;
> +				clock-names = "clkin", "core", "adc_clk", "adc_sel";
> +				status = "disabled";
> +			};
>  		};
>  	};
>  };


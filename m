Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A5BAECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 15:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39AE4208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 15:43:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39AE4208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729360AbeGPQLM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 12:11:12 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:41008 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727532AbeGPQLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 12:11:12 -0400
Received: by mail-yb0-f193.google.com with SMTP id s8-v6so15586441ybe.8;
        Mon, 16 Jul 2018 08:43:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6GBit/ydJUGQDG0yG7JVkj9qQoGprqSEONdp/2NcC4A=;
        b=aMtoH4/pFGN5JW7TBznzWF4NGXKrzT3ShTw5ffEKSTZ3ud6yilH/uOZkzFnLiDebWW
         C32ncAcnlwl7IWEutgrbIMRS4lPxWrb1+LgQThHvikcSwsKl35HbigZC2HuoMWL935cz
         cSdVo/o7e8nZ8hiiYxkAjODJP9zQLEk705Z/H3x6+KRXxqQdQ+9aklnWEnAnnoTg5A3H
         9gS1fwoFKLqayFmcgeX+ZXlMNK0+cG+aeBLm11xhY55pkkIgKLPQqm3ZrPmZ/qGx0uv7
         rxHg/wsVS7EpqMpLm8B1CaiCiX2PLOx79nGLBQqafMz9RJsnAD7nzEvJUWrZD7UQz2XQ
         AZoQ==
X-Gm-Message-State: AOUpUlFyRK4QBek++Hg7HtZdYYJ9UEDvXGci0sHZ4uZusPhc1zLQvoQk
        qTEUYpWxlvTz2bIZI+Jjxw==
X-Google-Smtp-Source: AAOMgpfEvsluUxfQlaQlL/fxQQ2s4FM4FFxaWrYm/61vnJqOCthxbm4GeZTvUJ8iIXs1WQR7XKwwpw==
X-Received: by 2002:a25:da11:: with SMTP id n17-v6mr9141978ybf.409.1531755791994;
        Mon, 16 Jul 2018 08:43:11 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id e72-v6sm10598253ywa.61.2018.07.16.08.43.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 08:43:11 -0700 (PDT)
Date:   Mon, 16 Jul 2018 09:43:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     Aapo Vienamo <avienamo@nvidia.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/7] dt-bindings: Add Tegra PMC pad configuration
 bindings
Message-ID: <20180716154309.GA16477@rob-hp-laptop>
References: <1531396813-6581-1-git-send-email-avienamo@nvidia.com>
 <1531396813-6581-6-git-send-email-avienamo@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531396813-6581-6-git-send-email-avienamo@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 03:00:11PM +0300, Aapo Vienamo wrote:
> Document the pinctrl bindings used by the PMC driver for performing pad
> configuration. Both nvidia,tegra186-pmc.txt and nvidia,tegra20-pmc.txt
> are modified as they both cover SoC generations for which these bindings
> apply.
> 
> Add a header defining Tegra PMC pad voltage configurations.
> 
> Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> Acked-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  .../bindings/arm/tegra/nvidia,tegra186-pmc.txt     | 84 +++++++++++++++++++
>  .../bindings/arm/tegra/nvidia,tegra20-pmc.txt      | 95 ++++++++++++++++++++++
>  include/dt-bindings/pinctrl/pinctrl-tegra-io-pad.h | 18 ++++
>  3 files changed, 197 insertions(+)
>  create mode 100644 include/dt-bindings/pinctrl/pinctrl-tegra-io-pad.h
> 
> diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra186-pmc.txt b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra186-pmc.txt
> index 5a3bf7c..9528f41 100644
> --- a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra186-pmc.txt
> +++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra186-pmc.txt
> @@ -34,3 +34,87 @@ Board DTS:
>  	pmc@c360000 {
>  		nvidia,invert-interrupt;
>  	};
> +
> +== Pad Control Nodes ==
> +
> +The PMC can be used to set pad power state and voltage configuration.
> +The pad configuration is done via the pinctrl framework. The driver
> +implements power-source, low-power-enable, and low-power-disable pinconf
> +pin configuration node properties. Each pinctrl pin corresponds to a
> +single Tegra PMC pad. Thus, in the following sections of this document
> +pin refers to the pinctrl frameworks notion of a Tegra PMC pad.

"pinctrl framework" is Linux specific and doesn't belong in the binding. 
Neither does what a driver supports. Describe what the h/w supports.

> +
> +The pad configuration state nodes are placed under the pmc node and they
> +are referred to by the pinctrl client device properties. For more

Another driver detail not relevant.

> +information see the examples presented later and

examples don't document bindings. The documentation should be complete 
without examples.

> +Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt.
> +
> +The values accepted by power-source property are
> +TEGRA_IO_PAD_VOLTAGE_1V8 and TEGRA_IO_PAD_VOLTAGE_3V3, which are defined
> +in dt-bindings/pinctrl/pinctrl-tegra-io-pad.h.

You need to list out what properties the child nodes can have.

power-source needs a vendor prefix.

> +
> +Following pinctrl pin name strings are present on Tegra186:
> +csia		csib		dsi		mipi-bias
> +pex-clk-bias	pex-clk3	pex-clk2	pex-clk1
> +usb0		usb1		usb2		usb-bias
> +uart		audio		hsic		dbg
> +hdmi-dp0	hdmi-dp1	pex-cntrl	sdmmc2-hv
> +sdmmc4		cam		dsib		dsic
> +dsid		csic		csid		csie
> +dsif		spi		ufs		dmic-hv
> +edp		sdmmc1-hv	sdmmc3-hv	conn
> +audio-hv	ao-hv
> +
> +All of the listed Tegra186 pins except ao-hv support the
> +low-power-enable and low-power-disable properties. The power-source
> +property is supported following Tegra210 pins: sdmmc2-hv, dmic-hv,
> +sdmmc1-hv, sdmmc3-hv, audio-hv, ao-hv.
> +
> +Pad configuration state example:
> +	pmc: pmc@7000e400 {
> +		compatible = "nvidia,tegra186-pmc";
> +		reg = <0 0x0c360000 0 0x10000>,
> +		      <0 0x0c370000 0 0x10000>,
> +		      <0 0x0c380000 0 0x10000>,
> +		      <0 0x0c390000 0 0x10000>;
> +		reg-names = "pmc", "wake", "aotag", "scratch";
> +
> +		...
> +
> +		sdmmc1_3v3: sdmmc1-3v3 {
> +			pins = "sdmmc1-hv";
> +			power-source = <TEGRA_IO_PAD_VOLTAGE_3V3>;
> +		};
> +
> +		sdmmc1_1v8: sdmmc1-1v8 {
> +			pins = "sdmmc1-hv";
> +			power-source = <TEGRA_IO_PAD_VOLTAGE_1V8>;
> +		};
> +
> +		hdmi_off: hdmi-off {
> +			pins = "hdmi";
> +			low-power-enable;
> +		}
> +
> +		hdmi_on: hdmi-on {
> +			pins = "hdmi";
> +			low-power-disable;
> +		}
> +	};
> +
> +Pinctrl client example:
> +	sdmmc1: sdhci@3400000 {
> +		...
> +		pinctrl-names = "sdmmc-3v3", "sdmmc-1v8";
> +		pinctrl-0 = <&sdmmc1_3v3>;
> +		pinctrl-1 = <&sdmmc1_1v8>;
> +	};
> +
> +	...
> +
> +	sor0: sor@15540000 {
> +		...
> +		pinctrl-0 = <&hdmi_off>;
> +		pinctrl-1 = <&hdmi_on>;
> +		pinctrl-names = "hdmi-on", "hdmi-off";
> +	};
> diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
> index a74b37b..d50a505 100644
> --- a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
> +++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
> @@ -195,3 +195,98 @@ Example:
>  		power-domains = <&pd_audio>;
>  		...
>  	};
> +
> +== Pad Control Nodes ==

Similar comments in this file.

> +
> +The PMC can be used to set pad power state and voltage configuration.
> +This functionality is present on SoCs from Tegra124 onwards. The pad
> +configuration is done via the pinctrl framework. The driver implements
> +power-source, low-power-enable, and low-power-disable pinconf pin
> +configuration node properties. Each pinctrl pin corresponds to a single
> +Tegra PMC pad. Thus, in the following sections of this document pin
> +refers to the pinctrl frameworks notion of a Tegra PMC pad.
> +
> +The pad configuration state nodes are placed under the pmc node and they
> +are referred to by the pinctrl client device properties. For more
> +information see the examples presented later and
> +Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt.
> +
> +The values accepted by power-source property are
> +TEGRA_IO_PAD_VOLTAGE_1V8 and TEGRA_IO_PAD_VOLTAGE_3V3, which are defined
> +in dt-bindings/pinctrl/pinctrl-tegra-io-pad.h.
> +
> +Following pinctrl pin name strings are present on Tegra124 and Tegra132:
> +audio		bb		cam		comp
> +csia		csb		cse		dsi
> +dsib		dsic		dsid		hdmi
> +hsic		hv		lvds		mipi-bias
> +nand		pex-bias	pex-clk1	pex-clk2
> +pex-cntrl	sdmmc1		sdmmc3		sdmmc4
> +sys_ddc		uart		usb0		usb1
> +usb2		usb_bias
> +
> +All of the listed Tegra124 and Tegra132 pins support the
> +low-power-enable and low-power-disable properties. None of the pins
> +support the power-source property.
> +
> +Following pinctrl pin name strings are present on Tegra210:
> +audio		audio-hv	cam		csia
> +csib		csic		csid		csie
> +csif		dbg		debug-nonao	dmic
> +dp		dsi		dsib		dsic
> +dsid		emmc		emmc2		gpio
> +hdmi		hsic		lvds		mipi-bias
> +pex-bias	pex-clk1	pex-clk2	pex-cntrl
> +sdmmc1		sdmmc3		spi		spi-hv
> +uart		usb0		usb1		usb2
> +usb3		usb-bias
> +
> +All of the listed Tegra210 pins except pex-cntrl support the
> +low-power-enable and low-power-disable properties. The power-source
> +property is supported following Tegra210 pins: audio, audio-hv, cam,
> +dbg, dmic, gpio, pex-cntrl, sdmmc1, sdmmc3, spi, spi-hv, and uart.
> +
> +Pad configuration state example:
> +	pmc: pmc@7000e400 {
> +		compatible = "nvidia,tegra210-pmc";
> +		reg = <0x0 0x7000e400 0x0 0x400>;
> +		clocks = <&tegra_car TEGRA210_CLK_PCLK>, <&clk32k_in>;
> +		clock-names = "pclk", "clk32k_in";
> +
> +		...
> +
> +		sdmmc1_3v3: sdmmc1-3v3 {
> +			pins = "sdmmc1";
> +			power-source = <TEGRA_IO_PAD_VOLTAGE_3V3>;
> +		};
> +
> +		sdmmc1_1v8: sdmmc1-1v8 {
> +			pins = "sdmmc1";
> +			power-source = <TEGRA_IO_PAD_VOLTAGE_1V8>;
> +		};
> +
> +		hdmi_off: hdmi-off {
> +			pins = "hdmi";
> +			low-power-enable;
> +		}
> +
> +		hdmi_on: hdmi-on {
> +			pins = "hdmi";
> +			low-power-disable;
> +		}
> +	};
> +
> +Pinctrl client example:
> +	sdmmc1: sdhci@700b0000 {
> +		...
> +		pinctrl-names = "sdmmc-3v3", "sdmmc-1v8";
> +		pinctrl-0 = <&sdmmc1_3v3>;
> +		pinctrl-1 = <&sdmmc1_1v8>;
> +	};
> +	...
> +	sor@54540000 {
> +		...
> +		pinctrl-0 = <&hdmi_off>;
> +		pinctrl-1 = <&hdmi_on>;
> +		pinctrl-names = "hdmi-on", "hdmi-off";
> +	};
> diff --git a/include/dt-bindings/pinctrl/pinctrl-tegra-io-pad.h b/include/dt-bindings/pinctrl/pinctrl-tegra-io-pad.h
> new file mode 100644
> index 0000000..20f4340
> --- /dev/null
> +++ b/include/dt-bindings/pinctrl/pinctrl-tegra-io-pad.h
> @@ -0,0 +1,18 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * pinctrl-tegra-io-pad.h: Tegra I/O pad source voltage configuration constants
> + * pinctrl bindings.
> + *
> + * Copyright (c) 2018, NVIDIA CORPORATION.  All rights reserved.
> + *
> + * Author: Aapo Vienamo <avienamo@nvidia.com>
> + */
> +
> +#ifndef _DT_BINDINGS_PINCTRL_TEGRA_IO_PAD_H
> +#define _DT_BINDINGS_PINCTRL_TEGRA_IO_PAD_H
> +
> +/* Voltage levels of the I/O pad's source rail */
> +#define TEGRA_IO_PAD_VOLTAGE_1V8	0
> +#define TEGRA_IO_PAD_VOLTAGE_3V3	1
> +
> +#endif
> -- 
> 2.7.4
> 

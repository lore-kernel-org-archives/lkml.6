Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C04C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 12:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B49221582
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 12:52:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TbczyQiD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B49221582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731812AbeHCOs7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 10:48:59 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:32822 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728524AbeHCOs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 10:48:59 -0400
Received: by mail-pg1-f194.google.com with SMTP id r5-v6so2829608pgv.0;
        Fri, 03 Aug 2018 05:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sgFZHCdxecH7lDHDmShpUfOeKukz+HpIjHvg5ghIsmg=;
        b=TbczyQiDNVME6MFdTrtLwbcj7ZLZrHVLKNjztuqTdHdIZi3wNsfryc5k1T6lU4gzEP
         8wiEoDf/huIbNb/SRlkc2Lhvxh+CMPH7xZgL6glJEis5XrUBPiqWz2rWTXjqxd9PpPGm
         FeBjyM5h5yAmhXb3FtcIX+dqBHQFZoDDPcnNT/UweAxyUXuPQ5c8KcfWWEbkLsVuze7c
         1XNivArYVVNqt9pe+VH+T/v+xF5Bv2BAuAiXOnwOjZhGBbEwKg4wcWSTuYU9RRnj3TiB
         tvTwEUHNI2aRaBxP6EKuxPgqi40JIra9pc8GlvFdSBxWvcAYdGr+Zjhd7SeblqhFKUba
         seFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=sgFZHCdxecH7lDHDmShpUfOeKukz+HpIjHvg5ghIsmg=;
        b=fT+eo0UqlWBBvjHaglFrsbVJttUOY00SGC0VsmNUrDWt8pjlEneRXz82tlwcqgYZAv
         4eYwxTWiWUunF+m1MIBZAEeVn0+C/qh8afYZGEt/6JV0Se7nrJAT5BjEwmS+rE8D++EW
         6zwL3n4Tq2l4zkGmjwgJaz4tjs88OXmDz63FeDaBAUNI4FNTLkKgUt+iDwTQuJ6lruDZ
         0GDbU78WCWLBpkaZZdsG4MaqFiASC82Zo6iUEljAbezUzalOPaDCa4lSWvGJQb+AgfuZ
         HSh40aVNPXj/HuKq3dtaiD1oMgyef2ft3miseLhXdbeWttqDF6jpgYdZn+Du4sI9qid2
         fNLg==
X-Gm-Message-State: AOUpUlHueNQajWzsHub6Q4DVAO1SPwGJbRiKOlZ0HGr4/OSiO0qdTAIe
        jjy+cZv8UtV9VaCwRdfBdgfySoQ1
X-Google-Smtp-Source: AAOMgpfWAqRAMIQKXiVcJNBU1na132EG1tKiL14H0J0FzsaWcBRdp0JhGFb6CTjrw5pENcH4QFG26g==
X-Received: by 2002:a62:25c5:: with SMTP id l188-v6mr4329661pfl.179.1533300766213;
        Fri, 03 Aug 2018 05:52:46 -0700 (PDT)
Received: from ziggy.stardust ([93.176.148.203])
        by smtp.gmail.com with ESMTPSA id w16-v6sm14033582pfi.101.2018.08.03.05.52.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Aug 2018 05:52:44 -0700 (PDT)
Subject: Re: [PATCH v4 03/10] arm64: dts: Add Mediatek SoC MT8183 and
 evaluation board dts and Makefile
To:     Erin Lo <erin.lo@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Boyd <sboyd@codeaurora.org>
Cc:     devicetree@vger.kernel.org,
        srv_heupstream <srv_heupstream@mediatek.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, yingjoe.chen@mediatek.com,
        mars.cheng@mediatek.com, eddie.huang@mediatek.com,
        linux-clk@vger.kernel.org, Ben Ho <Ben.Ho@mediatek.com>
References: <1533015487-60189-1-git-send-email-erin.lo@mediatek.com>
 <1533015487-60189-4-git-send-email-erin.lo@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=matthias.bgg@gmail.com; prefer-encrypt=mutual; keydata=
 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
 UXI+r2JwH1CJjrHWeQEI2ucSKsNa8FllDmG/fQ==
Message-ID: <6a73e655-66bd-5f4e-9c37-06d310c80b8c@gmail.com>
Date:   Fri, 3 Aug 2018 14:52:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1533015487-60189-4-git-send-email-erin.lo@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 31/07/18 07:38, Erin Lo wrote:
> From: Ben Ho <Ben.Ho@mediatek.com>
> 
> Add basic chip support for Mediatek 8183
> 
> Signed-off-by: Ben Ho <Ben.Ho@mediatek.com>
> Signed-off-by: Erin Lo <erin.lo@mediatek.com>
> ---
>  arch/arm64/boot/dts/mediatek/Makefile       |   1 +
>  arch/arm64/boot/dts/mediatek/mt8183-evb.dts |  23 +++++
>  arch/arm64/boot/dts/mediatek/mt8183.dtsi    | 146 ++++++++++++++++++++++++++++
>  3 files changed, 170 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-evb.dts
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8183.dtsi
> 
> diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
> index 7506b0d..a91d462 100644
> --- a/arch/arm64/boot/dts/mediatek/Makefile
> +++ b/arch/arm64/boot/dts/mediatek/Makefile
> @@ -6,3 +6,4 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt6795-evb.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt6797-evb.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt7622-rfb1.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt8173-evb.dtb
> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-evb.dtb
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-evb.dts b/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
> new file mode 100644
> index 0000000..2a3dd5a
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
> @@ -0,0 +1,23 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright (c) 2018 MediaTek Inc.
> + * Author: Ben Ho <ben.ho@mediatek.com>
> + *	   Erin Lo <erin.lo@mediatek.com>
> + */
> +
> +/dts-v1/;
> +#include "mt8183.dtsi"
> +
> +/ {
> +	model = "MediaTek MT8183 evaluation board";
> +	compatible = "mediatek,mt8183-evb", "mediatek,mt8183";
> +
> +	memory@40000000 {
> +		device_type = "memory";
> +		reg = <0 0x40000000 0 0x80000000>;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:921600n8";

This should go into 10/10.

Regards,
Matthias

> +	};
> +};
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> new file mode 100644
> index 0000000..1553265
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> @@ -0,0 +1,146 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright (c) 2018 MediaTek Inc.
> + * Author: Ben Ho <ben.ho@mediatek.com>
> + *	   Erin Lo <erin.lo@mediatek.com>
> + */
> +
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +/ {
> +	compatible = "mediatek,mt8183";
> +	interrupt-parent = <&sysirq>;
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu-map {
> +			cluster0 {
> +				core0 {
> +					cpu = <&cpu0>;
> +				};
> +				core1 {
> +					cpu = <&cpu1>;
> +				};
> +				core2 {
> +					cpu = <&cpu2>;
> +				};
> +				core3 {
> +					cpu = <&cpu3>;
> +				};
> +			};
> +
> +			cluster1 {
> +				core0 {
> +					cpu = <&cpu4>;
> +				};
> +				core1 {
> +					cpu = <&cpu5>;
> +				};
> +				core2 {
> +					cpu = <&cpu6>;
> +				};
> +				core3 {
> +					cpu = <&cpu7>;
> +				};
> +			};
> +		};
> +
> +		cpu0: cpu@000 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			reg = <0x000>;
> +			enable-method = "psci";
> +		};
> +
> +		cpu1: cpu@001 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			reg = <0x001>;
> +			enable-method = "psci";
> +		};
> +
> +		cpu2: cpu@002 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			reg = <0x002>;
> +			enable-method = "psci";
> +		};
> +
> +		cpu3: cpu@003 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			reg = <0x003>;
> +			enable-method = "psci";
> +		};
> +
> +		cpu4: cpu@100 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a73";
> +			reg = <0x100>;
> +			enable-method = "psci";
> +		};
> +
> +		cpu5: cpu@101 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a73";
> +			reg = <0x101>;
> +			enable-method = "psci";
> +		};
> +
> +		cpu6: cpu@102 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a73";
> +			reg = <0x102>;
> +			enable-method = "psci";
> +		};
> +
> +		cpu7: cpu@103 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a73";
> +			reg = <0x103>;
> +			enable-method = "psci";
> +		};
> +	};
> +
> +	psci {
> +		compatible      = "arm,psci-1.0";
> +		method          = "smc";
> +	};
> +
> +	timer {
> +		compatible = "arm,armv8-timer";
> +		interrupt-parent = <&gic>;
> +		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
> +	};
> +
> +	gic: interrupt-controller@0c000000 {
> +		compatible = "arm,gic-v3";
> +		#interrupt-cells = <3>;
> +		interrupt-parent = <&gic>;
> +		interrupt-controller;
> +		reg = <0 0x0c000000 0 0x40000>,  /* GICD */
> +		      <0 0x0c100000 0 0x200000>, /* GICR */
> +		      <0 0x0c400000 0 0x2000>,   /* GICC */
> +		      <0 0x0c410000 0 0x1000>,   /* GICH */
> +		      <0 0x0c420000 0 0x2000>;   /* GICV */
> +
> +		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
> +	};
> +
> +	sysirq: intpol-controller@0c530a80 {
> +		compatible = "mediatek,mt8183-sysirq",
> +			     "mediatek,mt6577-sysirq";
> +		interrupt-controller;
> +		#interrupt-cells = <3>;
> +		interrupt-parent = <&gic>;
> +		reg = <0 0x0c530a80 0 0x50>;
> +	};
> +};
> 

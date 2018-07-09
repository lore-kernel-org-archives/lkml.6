Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB835C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 10:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E17F20882
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 10:21:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tAA6QqpR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E17F20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932622AbeGIKVC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 06:21:02 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38462 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754425AbeGIKU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 06:20:57 -0400
Received: by mail-ed1-f65.google.com with SMTP id a5-v6so13501913edt.5;
        Mon, 09 Jul 2018 03:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BaSywUF+HuTqs1IkCmS8d2zZuv/+65FZ5jy7kOf4fyE=;
        b=tAA6QqpRxWxCrBT1GvfmRt+8bHuk72GpOJ2P5zvzpLK3CH7BxW5yKCkA72RnEkdn+2
         rmNGCe423NQWbWjhRhdtUhab+lvTWBf+6vxT5FWicinvlsXk53bj8KRNQMxmsI6KTftj
         79zYeofifqNO29wgJikEVK9D/LIoWyaHOQhnL1KhIxlAFfpbW6Tfs3EmH46Nnii5j0mI
         iZA2Ija4/7gKs967YNwJPT7k2b96TU8QwkBOYd31kyPkinkjZhtWC7ERB0+W0jccQ3+L
         clZ7i2rjsiZy5ApW06pgco3e9F7N3XFnBvRXRJq3NmzfrJG9zUL7RtPpa/MSW1r4N5dt
         rV/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=BaSywUF+HuTqs1IkCmS8d2zZuv/+65FZ5jy7kOf4fyE=;
        b=l6Y8euk72zp9UYpTojSUoazRLXGCD5yMLuK7BCc04ywevRDb8mkVTxe3bRts+kmSvo
         dARnl8/JTNN7uTI3abG9bFM2hJ5lZCGKrOGEHzP2EpuDjA8aL6f5dp/MIcvCsksaonhJ
         Ec9y3HG8fEQUplmMnh5sQE6ggcP0Zw5UTQOCeeO6ljB8+AltQ2hjXWc2ylNd4nQQ4eeX
         8MPPKDrrIu//txnFIU1Qdmq91/gqahtFqQyQFWm7QYnGFpvAgDnB+yUSn9GH3YSh1MFF
         7NzlRjQZjFF5+vJC6sP8og0dU8Dm/gkftLYrHSjt2gHFCcrUul+tfcIpQ7FTHweI5zfF
         wlFw==
X-Gm-Message-State: APt69E3xHSAHuALHxfX0MmGB8mUVV/HQeqUGD22c4Mg0/Tt5MCw8nRGm
        jO8QQhgTGBLEFzuAFSf41wQ=
X-Google-Smtp-Source: AAOMgpfYdusfLV829J4QL44UkDg9Rk9PwP8ngQfut1JUgSgCVll5k+vhPok4PK6QpH5alD/SyqDnGQ==
X-Received: by 2002:a50:b56e:: with SMTP id z43-v6mr22098506edd.223.1531131655977;
        Mon, 09 Jul 2018 03:20:55 -0700 (PDT)
Received: from ziggy.stardust ([37.223.136.20])
        by smtp.gmail.com with ESMTPSA id p23-v6sm6370442edm.31.2018.07.09.03.20.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 03:20:54 -0700 (PDT)
Subject: Re: [PATCH v4 1/1] arm64: dts: mediatek: add mt6765 support
To:     Mars Cheng <mars.cheng@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     CC Hwang <cc.hwang@mediatek.com>,
        Loda Chou <loda.chou@mediatek.com>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, wsd_upstream@mediatek.com,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <1531116302-29921-1-git-send-email-mars.cheng@mediatek.com>
 <1531116302-29921-2-git-send-email-mars.cheng@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=matthias.bgg@gmail.com; prefer-encrypt=mutual; keydata=
 xsFNBFP1zgUBEAC21D6hk7//0kOmsUrE3eZ55kjc9DmFPKIz6l4NggqwQjBNRHIMh04BbCMY
 fL3eT7ZsYV5nur7zctmJ+vbszoOASXUpfq8M+S5hU2w7sBaVk5rpH9yW8CUWz2+ZpQXPJcFa
 OhLZuSKB1F5JcvLbETRjNzNU7B3TdS2+zkgQQdEyt7Ij2HXGLJ2w+yG2GuR9/iyCJRf10Okq
 gTh//XESJZ8S6KlOWbLXRE+yfkKDXQx2Jr1XuVvM3zPqH5FMg8reRVFsQ+vI0b+OlyekT/Xe
 0Hwvqkev95GG6x7yseJwI+2ydDH6M5O7fPKFW5mzAdDE2g/K9B4e2tYK6/rA7Fq4cqiAw1+u
 EgO44+eFgv082xtBez5WNkGn18vtw0LW3ESmKh19u6kEGoi0WZwslCNaGFrS4M7OH+aOJeqK
 fx5dIv2CEbxc6xnHY7dwkcHikTA4QdbdFeUSuj4YhIZ+0QlDVtS1QEXyvZbZky7ur9rHkZvP
 ZqlUsLJ2nOqsmahMTIQ8Mgx9SLEShWqD4kOF4zNfPJsgEMB49KbS2o9jxbGB+JKupjNddfxZ
 HlH1KF8QwCMZEYaTNogrVazuEJzx6JdRpR3sFda/0x5qjTadwIW6Cl9tkqe2h391dOGX1eOA
 1ntn9O/39KqSrWNGvm+1raHK+Ev1yPtn0Wxn+0oy1tl67TxUjQARAQABzSlNYXR0aGlhcyBC
 cnVnZ2VyIDxtYXR0aGlhcy5iZ2dAZ21haWwuY29tPsLBkgQTAQIAPAIbAwYLCQgHAwIGFQgC
 CQoLBBYCAwECHgECF4AWIQTmuZIYwPLDJRwsOhfZFAuyVhMC8QUCWt3scQIZAQAKCRDZFAuy
 VhMC8WzRD/4onkC+gCxG+dvui5SXCJ7bGLCu0xVtiGC673Kz5Aq3heITsERHBV0BqqctOEBy
 ZozQQe2Hindu9lasOmwfH8+vfTK+2teCgWesoE3g3XKbrOCB4RSrQmXGC3JYx6rcvMlLV/Ch
 YMRR3qv04BOchnjkGtvm9aZWH52/6XfChyh7XYndTe5F2bqeTjt+kF/ql+xMc4E6pniqIfkv
 c0wsH4CkBHqoZl9w5e/b9MspTqsU9NszTEOFhy7p2CYw6JEa/vmzR6YDzGs8AihieIXDOfpT
 DUr0YUlDrwDSrlm/2MjNIPTmSGHH94ScOqu/XmGW/0q1iar/Yr0leomUOeeEzCqQtunqShtE
 4Mn2uEixFL+9jiVtMjujr6mphznwpEqObPCZ3IcWqOFEz77rSL+oqFiEA03A2WBDlMm++Sve
 9jpkJBLosJRhAYmQ6ey6MFO6Krylw1LXcq5z1XQQavtFRgZoruHZ3XlhT5wcfLJtAqrtfCe0
 aQ0kJW+4zj9/So0uxJDAtGuOpDYnmK26dgFN0tAhVuNInEVhtErtLJHeJzFKJzNyQ4GlCaLw
 jKcwWcqDJcrx9R7LsCu4l2XpKiyxY6fO4O8DnSleVll9NPfAZFZvf8AIy3EQ8BokUsiuUYHz
 wUo6pclk55PZRaAsHDX/fNr24uC6Eh5oNQ+v4Pax/gtyyc7BTQRT9gkSARAApxtQ4zUMC512
 kZ+gCiySFcIF/mAf7+l45689Tn7LI1xmPQrAYJDoqQVXcyh3utgtvBvDLmpQ+1BfEONDWc8K
 RP6Abo35YqBx3udAkLZgr/RmEg3+Tiof+e1PJ2zRh5zmdei5MT8biE2zVd9DYSJHZ8ltEWIA
 LC9lAsv9oa+2L6naC+KFF3i0m5mxklgFoSthswUnonqvclsjYaiVPoSldDrreCPzmRCUd8zn
 f//Z4BxtlTw3SulF8weKLJ+Hlpw8lwb3sUl6yPS6pL6UV45gyWMe677bVUtxLYOu+kiv2B/+
 nrNRDs7B35y/J4t8dtK0S3M/7xtinPiYRmsnJdk+sdAe8TgGkEaooF57k1aczcJlUTBQvlYA
 Eg2NJnqaKg3SCJ4fEuT8rLjzuZmLkoHNumhH/mEbyKca82HvANu5C9clyQusJdU+MNRQLRmO
 Ad/wxGLJ0xmAye7Ozja86AIzbEmuNhNH9xNjwbwSJNZefV2SoZUv0+V9EfEVxTzraBNUZifq
 v6hernMQXGxs+lBjnyl624U8nnQWnA8PwJ2hI3DeQou1HypLFPeY9DfWv4xYdkyeOtGpueeB
 lqhtMoZ0kDw2C3vzj77nWwBgpgn1Vpf4hG/sW/CRR6tuIQWWTvUM3ACa1pgEsBvIEBiVvPxy
 AtL+L+Lh1Sni7w3HBk1EJvUAEQEAAcLBXwQYAQIACQUCU/YJEgIbDAAKCRDZFAuyVhMC8Qnd
 EACuN16mvivnWwLDdypvco5PF8w9yrfZDKW4ggf9TFVB9skzMNCuQc+tc+QM+ni2c4kKIdz2
 jmcg6QytgqVum6V1OsNmpjADaQkVp5jL0tmg6/KA9Tvr07Kuv+Uo4tSrS/4djDjJnXHEp/tB
 +Fw7CArNtUtLlc8SuADCmMD+kBOVWktZyzkBkDfBXlTWl46T/8291lEspDWe5YW1ZAH/HdCR
 1rQNZWjNCpB2Cic58CYMD1rSonCnbfUeyZYNNhNHZosl4dl7f+am87Q2x3pK0DLSoJRxWb7v
 ZB0uo9CzCSm3I++aYozF25xQoT+7zCx2cQi33jwvnJAK1o4VlNx36RfrxzBqc1uZGzJBCQu4
 8UjmUSsTwWC3HpE/D9sM+xACs803lFUIZC5H62G059cCPAXKgsFpNMKmBAWweBkVJAisoQeX
 50OP+/11ArV0cv+fOTfJj0/KwFXJaaYh3LUQNILLBNxkSrhCLl8dUg53IbHx4NfIAgqxLWGf
 XM8DY1aFdU79pac005PuhxCWkKTJz3gCmznnoat4GCnL5gy/m0Qk45l4PFqwWXVLo9AQg2Kp
 3mlIFZ6fsEKIAN5hxlbNvNb9V2Zo5bFZjPWPFTxOteM0omUAS+QopwU0yPLLGJVf2iCmItHc
 UXI+r2JwH1CJjrHWeQEI2ucSKsNa8FllDmG/fQ==
Message-ID: <7fb13f45-4e33-6efc-467b-c7256a40cbc9@gmail.com>
Date:   Mon, 9 Jul 2018 12:20:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1531116302-29921-2-git-send-email-mars.cheng@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/07/18 08:05, Mars Cheng wrote:
> This adds basic chip support for MT6765 SoC.
> 
> Signed-off-by: Mars Cheng <mars.cheng@mediatek.com>
> ---
>  arch/arm64/boot/dts/mediatek/Makefile       |    1 +
>  arch/arm64/boot/dts/mediatek/mt6765-evb.dts |   33 ++++++
>  arch/arm64/boot/dts/mediatek/mt6765.dtsi    |  156 +++++++++++++++++++++++++++
>  3 files changed, 190 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt6765-evb.dts
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt6765.dtsi
> 
> diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
> index ac17f60..7506b0d 100644
> --- a/arch/arm64/boot/dts/mediatek/Makefile
> +++ b/arch/arm64/boot/dts/mediatek/Makefile
> @@ -1,6 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt2712-evb.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt6755-evb.dtb
> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt6765-evb.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt6795-evb.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt6797-evb.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt7622-rfb1.dtb

As you can see, we have a long list of SoCs which are poorly supported.
I'm not very keen to just add another SoC which supports booting into a ramdisk
using the serial console. Do you have a roadmap adding mainline support for this
SoC?

Regards,
Matthias

> diff --git a/arch/arm64/boot/dts/mediatek/mt6765-evb.dts b/arch/arm64/boot/dts/mediatek/mt6765-evb.dts
> new file mode 100644
> index 0000000..36dddff2
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt6765-evb.dts
> @@ -0,0 +1,33 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * dts file for Mediatek MT6765
> + *
> + * (C) Copyright 2018. Mediatek, Inc.
> + *
> + * Mars Cheng <mars.cheng@mediatek.com>
> + */
> +
> +/dts-v1/;
> +#include "mt6765.dtsi"
> +
> +/ {
> +	model = "MediaTek MT6765 EVB";
> +	compatible = "mediatek,mt6765-evb", "mediatek,mt6765";
> +
> +	aliases {
> +		serial0 = &uart0;
> +	};
> +
> +	memory@40000000 {
> +		device_type = "memory";
> +		reg = <0 0x40000000 0 0x1e800000>;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:921600n8";
> +	};
> +};
> +
> +&uart0 {
> +	status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/mediatek/mt6765.dtsi b/arch/arm64/boot/dts/mediatek/mt6765.dtsi
> new file mode 100644
> index 0000000..cc365b1
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt6765.dtsi
> @@ -0,0 +1,156 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * dts file for Mediatek MT6765
> + *
> + * (C) Copyright 2018. Mediatek, Inc.
> + *
> + * Mars Cheng <mars.cheng@mediatek.com>
> + */
> +
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +/ {
> +	compatible = "mediatek,mt6765";
> +	interrupt-parent = <&sysirq>;
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	psci {
> +		compatible = "arm,psci-0.2";
> +		method = "smc";
> +	};
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu@0 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			enable-method = "psci";
> +			reg = <0x000>;
> +		};
> +
> +		cpu@1 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			enable-method = "psci";
> +			reg = <0x001>;
> +		};
> +
> +		cpu@2 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			enable-method = "psci";
> +			reg = <0x002>;
> +		};
> +
> +		cpu@3 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			enable-method = "psci";
> +			reg = <0x003>;
> +		};
> +
> +		cpu@100 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			enable-method = "psci";
> +			reg = <0x100>;
> +		};
> +
> +		cpu@101 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			enable-method = "psci";
> +			reg = <0x101>;
> +		};
> +
> +		cpu@102 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			enable-method = "psci";
> +			reg = <0x102>;
> +		};
> +
> +		cpu@103 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			enable-method = "psci";
> +			reg = <0x103>;
> +		};
> +	};
> +
> +	baud_clk: dummy26m {
> +		compatible = "fixed-clock";
> +		clock-frequency = <26000000>;
> +		#clock-cells = <0>;
> +	};
> +
> +	sys_clk: dummyclk {
> +		compatible = "fixed-clock";
> +		clock-frequency = <26000000>;
> +		#clock-cells = <0>;
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
> +	soc {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		compatible = "simple-bus";
> +		ranges;
> +
> +		gic: interrupt-controller@c000000 {
> +			compatible = "arm,gic-v3";
> +			#interrupt-cells = <3>;
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			interrupt-parent = <&gic>;
> +			interrupt-controller;
> +			reg = <0 0x0c000000 0 0x40000>,  /* GICD */
> +			      <0 0x0c100000 0 0x200000>, /* GICR */
> +			      <0 0x0c400000 0 0x2000>,   /* GICC */
> +			      <0 0x0c410000 0 0x2000>,   /* GICH */
> +			      <0 0x0c420000 0 0x20000>;  /* GICV */
> +			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
> +		};
> +
> +		sysirq: interrupt-controller@10200a80 {
> +			compatible = "mediatek,mt6765-sysirq",
> +				     "mediatek,mt6577-sysirq";
> +			interrupt-controller;
> +			#interrupt-cells = <3>;
> +			interrupt-parent = <&gic>;
> +			reg = <0 0x10200a80 0 0x50>;
> +		};
> +
> +		uart0: serial@11002000 {
> +			compatible = "mediatek,mt6765-uart",
> +				     "mediatek,mt6577-uart";
> +			reg = <0 0x11002000 0 0x400>;
> +			interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_LOW>;
> +			clocks = <&baud_clk>, <&sys_clk>;
> +			clock-names = "baud", "bus";
> +			status = "disabled";
> +		};
> +
> +		uart1: serial@11003000 {
> +			compatible = "mediatek,mt6765-uart",
> +				     "mediatek,mt6577-uart";
> +			reg = <0 0x11003000 0 0x400>;
> +			interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_LOW>;
> +			clocks = <&baud_clk>, <&sys_clk>;
> +			clock-names = "baud", "bus";
> +			status = "disabled";
> +		};
> +	}; /* end of soc */
> +};
> 

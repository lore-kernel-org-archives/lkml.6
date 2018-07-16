Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C2C2ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 13:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A25A520856
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 13:59:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XSvhcsp2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A25A520856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728437AbeGPO0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 10:26:48 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44742 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727581AbeGPO0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 10:26:47 -0400
Received: by mail-ed1-f65.google.com with SMTP id d17-v6so17976722eds.11;
        Mon, 16 Jul 2018 06:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ngd5M/Fj/uJjfyQ7e29pknu4TdiT7VIKMD0zhGdNq/4=;
        b=XSvhcsp2Q62kxGW/lDK02u9xEMnXVMSdiPrP9w4OHplKwh7DMpTkxZStyabfS8+ONZ
         5HerXKN68D04eVxMy1O34gmrDwK0G3jGwov/zXKGuhsiZYd+BXAzqtponY1GuNZUFv82
         CuZ4JMAo3g9nCISmOe5ppX3ODudmjaJ/uwmOUSLwjb2LZV35wxfT4bk47j/wLQzvyxez
         4fk+fALYCtl+EOobh9A190sWdGVSS7BUdFFU8bzcEuMnmzrTD74ub0qlmWi14ZnRWvaW
         bJVBGX+re9dnKRc+9Zg1rzzu8fKhqqEAKwyZqbhr2Qo9mnRf1RXR3bX3oqH8pV6P5oSk
         WdQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Ngd5M/Fj/uJjfyQ7e29pknu4TdiT7VIKMD0zhGdNq/4=;
        b=lnci6dX/oAMEbN0x+rm/t9DLSRCq8WXRj6aYVh+xqhnd+Gv+5PnIUvQ6zPxOJTjIyO
         jMNEVHVDtxdWhuG+ue9usf4uvTGvivAuNSa4h+m6HGR/zAbBD64/1jXsO+cWnAIIKOPH
         C9iJ6l1XlXe5GgvPTjw+V+1n9d60663yKQYE1qBmdU0JpVxEjzMId662h97EG0fpMUKf
         NqGTMTm3S9svOJlj3VQ7woKvoPfOsZL7gVzjKrureQ9gILFuuOyh80Gbim95WdSYBG/Z
         6srMcfjAFtrXQtqjJqBp314ZPoVnreBkHNEHVTqjV9olip8epIavxL0ye2hxAT+VsvAA
         gUVw==
X-Gm-Message-State: AOUpUlH/b01OVQvA9S79wt7WG7ukvFJ0PqfNKx9izu0N6fxDsKJDP1fW
        lhPjizILVll/aZOx4rdr8tQ=
X-Google-Smtp-Source: AAOMgpfJ38X08ucHOSBPU3Losybe2QdxYcxK4iITNbqsR20KlOI4WflFciDbZxNNolWH2foeHb0vuw==
X-Received: by 2002:a50:da01:: with SMTP id z1-v6mr17712915edj.62.1531749551153;
        Mon, 16 Jul 2018 06:59:11 -0700 (PDT)
Received: from ziggy.stardust ([37.223.136.20])
        by smtp.gmail.com with ESMTPSA id a9-v6sm4967611edi.26.2018.07.16.06.59.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 06:59:10 -0700 (PDT)
Subject: Re: [PATCH 1/2] arm: dts: mt7623: cleanup MT7623N NAND dts file
To:     Ryder Lee <ryder.lee@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>
References: <34e4c13bd1deeb8e090a74b4e7e9192512b3eff0.1531199139.git.ryder.lee@mediatek.com>
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
Message-ID: <53d30dd0-d805-1ff9-c0f0-4029e7ee453f@gmail.com>
Date:   Mon, 16 Jul 2018 15:59:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <34e4c13bd1deeb8e090a74b4e7e9192512b3eff0.1531199139.git.ryder.lee@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/07/18 07:09, Ryder Lee wrote:
> Normally, we didn't release this kind of baord to user. This specific
> board exists only in the early stage of development inside MediaTek -
> and that may confuse peoples.
> 
> Hence this patch removes related files accordingly.
> 
> Cc: John Crispin <john@phrozen.org>
> Cc: Sean Wang <sean.wang@mediatek.com>
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>

Whole series pushed to v4.18-next/dts32

Thanks a lot to everybody who provided feedback.

Regards,
Matthias

> ---
>  arch/arm/boot/dts/Makefile             |  1 -
>  arch/arm/boot/dts/mt7623n-rfb-nand.dts | 73 -----------------------------
>  arch/arm/boot/dts/mt7623n-rfb.dtsi     | 86 ----------------------------------
>  3 files changed, 160 deletions(-)
>  delete mode 100644 arch/arm/boot/dts/mt7623n-rfb-nand.dts
>  delete mode 100644 arch/arm/boot/dts/mt7623n-rfb.dtsi
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 37a3de7..dde494e 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -1168,7 +1168,6 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += \
>  	mt7623a-rfb-emmc.dtb \
>  	mt7623a-rfb-nand.dtb \
>  	mt7623n-rfb-emmc.dtb \
> -	mt7623n-rfb-nand.dtb \
>  	mt7623n-bananapi-bpi-r2.dtb \
>  	mt8127-moose.dtb \
>  	mt8135-evbp1.dtb
> diff --git a/arch/arm/boot/dts/mt7623n-rfb-nand.dts b/arch/arm/boot/dts/mt7623n-rfb-nand.dts
> deleted file mode 100644
> index 96ff3c9..0000000
> --- a/arch/arm/boot/dts/mt7623n-rfb-nand.dts
> +++ /dev/null
> @@ -1,73 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * Copyright (c) 2017 MediaTek Inc.
> - * Author: John Crispin <john@phrozen.org>
> - *
> - */
> -
> -/dts-v1/;
> -#include "mt7623n-rfb.dtsi"
> -
> -/ {
> -	model = "MediaTek MT7623N NAND reference board";
> -	compatible = "mediatek,mt7623n-rfb-nand", "mediatek,mt7623";
> -};
> -
> -&bch {
> -	status = "okay";
> -};
> -
> -&nandc {
> -	status = "okay";
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&nand_pins_default>;
> -
> -	nand@0 {
> -		reg = <0>;
> -		spare_per_sector = <64>;
> -		nand-ecc-mode = "hw";
> -		nand-ecc-strength = <12>;
> -		nand-ecc-step-size = <1024>;
> -
> -		partitions {
> -			compatible = "fixed-partitions";
> -			#address-cells = <1>;
> -			#size-cells = <1>;
> -
> -			partition@0 {
> -				label = "preloader";
> -				reg = <0x0 0x40000>;
> -			};
> -
> -			partition@40000 {
> -				label = "uboot";
> -				reg = <0x40000 0x80000>;
> -			};
> -
> -			partition@c0000 {
> -				label = "uboot-env";
> -				reg = <0xC0000 0x40000>;
> -			};
> -
> -			partition@140000 {
> -				label = "bootimg";
> -				reg = <0x140000 0x2000000>;
> -			};
> -
> -			partition@2140000 {
> -				label = "recovery";
> -				reg = <0x2140000 0x2000000>;
> -			};
> -
> -			partition@4140000 {
> -				label = "rootfs";
> -				reg = <0x4140000 0x1000000>;
> -			};
> -
> -			partition@5140000 {
> -				label = "usrdata";
> -				reg = <0x5140000 0x1000000>;
> -			};
> -		};
> -	};
> -};
> diff --git a/arch/arm/boot/dts/mt7623n-rfb.dtsi b/arch/arm/boot/dts/mt7623n-rfb.dtsi
> deleted file mode 100644
> index 5c5cc7d..0000000
> --- a/arch/arm/boot/dts/mt7623n-rfb.dtsi
> +++ /dev/null
> @@ -1,86 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * Copyright (c) 2017 MediaTek Inc.
> - * Author: John Crispin <john@phrozen.org>
> - *	   Sean Wang <sean.wang@mediatek.com>
> - *
> - */
> -
> -/dts-v1/;
> -#include "mt7623.dtsi"
> -#include "mt6323.dtsi"
> -
> -/ {
> -	aliases {
> -		serial0 = &uart0;
> -		serial1 = &uart1;
> -		serial2 = &uart2;
> -	};
> -
> -	chosen {
> -		stdout-path = "serial2:115200n8";
> -	};
> -
> -	cpus {
> -		cpu0 {
> -			proc-supply = <&mt6323_vproc_reg>;
> -		};
> -
> -		cpu1 {
> -			proc-supply = <&mt6323_vproc_reg>;
> -		};
> -
> -		cpu2 {
> -			proc-supply = <&mt6323_vproc_reg>;
> -		};
> -
> -		cpu3 {
> -			proc-supply = <&mt6323_vproc_reg>;
> -		};
> -	};
> -
> -	memory@80000000 {
> -		device_type = "memory";
> -		reg = <0 0x80000000 0 0x40000000>;
> -	};
> -
> -	usb_p1_vbus: regulator-5v {
> -		compatible = "regulator-fixed";
> -		regulator-name = "usb_vbus";
> -		regulator-min-microvolt = <5000000>;
> -		regulator-max-microvolt = <5000000>;
> -		gpio = <&pio 135 GPIO_ACTIVE_HIGH>;
> -		enable-active-high;
> -	};
> -};
> -
> -&mmc0 {
> -	vmmc-supply = <&mt6323_vemc3v3_reg>;
> -	vqmmc-supply = <&mt6323_vio18_reg>;
> -};
> -
> -&mmc1 {
> -	vmmc-supply = <&mt6323_vmch_reg>;
> -	vqmmc-supply = <&mt6323_vmc_reg>;
> -};
> -
> -&uart0 {
> -	status = "okay";
> -};
> -
> -&uart1 {
> -	status = "okay";
> -};
> -
> -&uart2 {
> -	status = "okay";
> -};
> -
> -&usb1 {
> -	vbus-supply = <&usb_p1_vbus>;
> -	status = "okay";
> -};
> -
> -&u3phy1 {
> -	status = "okay";
> -};
> 

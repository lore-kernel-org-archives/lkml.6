Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF0FC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 21:37:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8DF020869
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 21:37:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CaiGjP/+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728510AbfAaVhb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 16:37:31 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38432 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbfAaVha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 16:37:30 -0500
Received: by mail-wm1-f66.google.com with SMTP id m22so4134127wml.3;
        Thu, 31 Jan 2019 13:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=P43reIF9qv1ZQhe1F/ECe+aZY12u1uKqJ1BKMnYRGzw=;
        b=CaiGjP/+81CldWrdIhSyG3xXL0AWOthXoyn6E+cZEilTp+LhQALq/0K4RGjI94rp3e
         cPfZPXrcb9z5KpQd9C0tiI0FsbdR8AnBZkk1GxFRVEjw/EKJQctFMHd7+HIIVc3T+sCU
         9oG8oWMzxRTBUB2JfcV0avyUyIM6N31LC0n51IWkzjkxSXwaOVoUikw5F09Z7sn3ib9e
         tp+a291dlVkfYAEyfJ5R47NWMFE1ZYOyAQsL99aiJ0yifeZjD8LFPwbstD/5dZmr6PyW
         SaS90GXPfdakgi+qKczXugKt6Ih8o81Y/ylEekFceNuX3whKCjWp9MmPnPptyaXjyCPJ
         Ruow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=P43reIF9qv1ZQhe1F/ECe+aZY12u1uKqJ1BKMnYRGzw=;
        b=tAltK1YviwkWR2D9IDWINWw1p3kbemiCEV2N6tTgAP4RgF3kEtu+pW3X0uF0xAYVwy
         HbwwpH+8L152wg5OUZgF3NxQgCsOpt4b0oBNU0vknRp4312RoQJWpiLspv+zQYlITebx
         Zx5T05oENbzVRJWXakvUfM85olafZzpAxTO2Sjg6aMbhdnrtpeQgGfZS4mJmVJCdo1A/
         kgFRJPmkSgvvfl6gyDvnS1HacaiRYT4ilqhiLbptDUQJrR9QS5o3T/wx+N0XfMSzz1l+
         Zbc9gE/BBzlEhbekJwR8I4cV++mkdNicPCHFnG0BF0JczfPYUTwgXan1CZaKNtaHrhBg
         xd3g==
X-Gm-Message-State: AJcUuke/3V5PmxdEK3biUNPduAekmrGE/butYw0K5PnVy1MLlGq7Dhlk
        6PnBng3Ph1kopE/x3RXxoh3AkfXK
X-Google-Smtp-Source: ALg8bN4/qhhCWgJDhfoCPJXCHC+I8UxeV6WsVHAYJc94703zs5T41ySLhFzDgtUA8ygQv0bICdKcHA==
X-Received: by 2002:a1c:9183:: with SMTP id t125mr30252246wmd.79.1548970647913;
        Thu, 31 Jan 2019 13:37:27 -0800 (PST)
Received: from [192.168.1.18] (chf233.neoplus.adsl.tpnet.pl. [83.31.3.233])
        by smtp.gmail.com with ESMTPSA id 127sm474708wmm.45.2019.01.31.13.37.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 13:37:27 -0800 (PST)
Subject: Re: [PATCH 3/5] dt-bindings: leds: Add binding for axp20x-led device
 driver
To:     Stefan Mavrodiev <stefan@olimex.com>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        "open list:LED SUBSYSTEM" <linux-leds@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:X-POWERS MULTIFUNCTION PMIC DEVICE DRIVERS" 
        <linux-kernel@vger.kernel.org>
References: <20190131082308.22522-1-stefan@olimex.com>
 <20190131082308.22522-3-stefan@olimex.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <990611bd-9c6f-aa03-6cb9-431d9415891d@gmail.com>
Date:   Thu, 31 Jan 2019 22:37:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190131082308.22522-3-stefan@olimex.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan,

Thank you for the patch.

I have few nits below.

On 1/31/19 9:23 AM, Stefan Mavrodiev wrote:
> This adds the devicetree bindings for charge led indicator found
> on most of X-Powers AXP20X PMICs.
> 
> Signed-off-by: Stefan Mavrodiev <stefan@olimex.com>
> ---
>   .../devicetree/bindings/leds/leds-axp20x.txt  | 74 +++++++++++++++++++
>   1 file changed, 74 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/leds/leds-axp20x.txt
> 
> diff --git a/Documentation/devicetree/bindings/leds/leds-axp20x.txt b/Documentation/devicetree/bindings/leds/leds-axp20x.txt
> new file mode 100644
> index 000000000000..73fae22ffe29
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/leds-axp20x.txt
> @@ -0,0 +1,74 @@
> +Device Tree Bindings for LED support on X-Powers PMIC
> +
> +Most of the X-Powers PMICs have integrated battery charger with LED indicator.
> +The output is open-drain, so the state is either high-Z or output-low. The
> +driver is subnode of AXP20X MFD driver, since it uses shared bus with all

s/is subnode/is a subnode/

> +other cells.
> +The LED can be controlled either manually or automatic. Then in automatic

s/or automatic/or automatically/

> +(controlled by the charger) there are two indication modes:
> +
> +Mode-A
> +======
> +- output-low:		Charging
> +- high-Z		Not charging
> +- 1Hz flashing:		Abnormal alarm
> +- 4Hz flashing		Overvoltage alarm
> +
> +Mode-B
> +======
> +- output-low:		Battery full
> +- high-Z		Not charging
> +- 1Hz flashing:		Charging
> +- 4Hz flashing		Overvoltage or abnormal alarm
> +
> +The control and the mode can be changed from sysfs.
> +
> +For AXP20X MFD bindings see:
> +Documentation/devicetree/bindings/mfd/axp20x.txt
> +
> +Required properties:
> +- compatible : Must be "x-powers,axp20x-led"
> +
> +Supported common leds properties, see ./common.txt for more information:

s/leds/LED/

Please remove ", see ./common.txt for more information" in favor
of references indicated below.

> +- label : sets LED label. If omitted, dt device node is used

Please change it to:
- label : See Documentation/devicetree/bindings/leds/common.txt

> +- linux,default-trigger : See
> +- default-state:

- linux,default-trigger : See 
Documentation/devicetree/bindings/leds/common.txt

> +
> +Optional properties:
> +- x-powers,charger-mode: 0 for Mode-A, 1 for Mode-B
> +			 If omitted, then the control is set to manual mode.
> +			 On invalid value, Mode-A is used.
> +
> +
> +Example:
> +
> +	axp803: pmic@3a3 {
> +		compatible = "x-powers,axp803";
> +
> +		...
> +
> +		axp20x-led {

s/axp20x-led/led@0/

> +			compatible = "x-powers,axp20x-led";
> +			status = "okay";
> +
> +			label = "axp20x:yellow:chgled";
> +			linux,default-trigger = "timer";
> +			default-state = "on";
> +		};
> +	};
> +
> +or
> +
> +	axp803: pmic@3a3 {
> +		compatible = "x-powers,axp803";
> +
> +		...
> +
> +		axp20x-led {

s/axp20x-led/led@0/

> +			compatible = "x-powers,axp20x-led";
> +			status = "okay";
> +
> +			label = "axp20x:yellow:chgled";
> +			x-powers,charger-mode = "mode-b";
> +		};
> +	};
> 

-- 
Best regards,
Jacek Anaszewski

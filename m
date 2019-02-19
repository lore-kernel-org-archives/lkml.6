Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA67C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 08:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73C7B21902
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 08:26:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="bBtjtR94"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbfBSI0F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 03:26:05 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44139 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbfBSI0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 03:26:04 -0500
Received: by mail-lf1-f67.google.com with SMTP id g2so14215670lfh.11
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 00:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hmq5WPiromDeB85Np7x7T2H/64gZOsG3LrZaMp8ezj0=;
        b=bBtjtR94cofMndSNi0QRarGclKku7kXHcQDQ25EFUDiyBOz/B31aGQKnfpWzmGtjHj
         wbxA0gb3I+TWab1eb+IhqmTZnQ81LDq3ei21mzDmrwyVVrsD+JFxnpCaXIAE0MNAZ1Tn
         lOz/Fg52JtPX8qBCYAyJWli2cIYzhT7bF60DYmXE1g51hwQqn3mhwWfcyac6X8gkqlGe
         NO14gm/3N/KY5kQCqSwyQlc70Fs8+XDyiJ7MmGOCFhSKGdIBfy8VaPHfqEcJSbqnA6cO
         vJlyd3EcURyTlpl9RqS3ChdYY8G6RyHJ1SpJED/YJ4brvuwvOPc12e/DEwvyCF63FuEI
         M/FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hmq5WPiromDeB85Np7x7T2H/64gZOsG3LrZaMp8ezj0=;
        b=s0XIuK0B+TSok5NX8aVGCYs96pLHMaOc4U7D8BXTMZChQO3WDv+XSX0h9LYy56Z86S
         Hehlm8iMDFp/cszzToPRwa8dDUzDDSyCIzgi2f8p55TQbTMnSkO07B2Ef3pFjUsvp9su
         jUYAqnk+D9UYS/VoRLNNaUGW8G7I/+6OC9WVtAWiD5xDH+0rVCFUT/XrNsSdSnmBiUJS
         aRZ78ILt5CCfADlDulkin5038N4RuY195ZVwF3VES34x0UziR0nYW2Fpauu++qgzQQKy
         h8TDdAMIpifxweivubkHrwfepedMwosAzVK8Vg9fmbMVWBHr2qSiD1cvt99lpb+PlUef
         k/fA==
X-Gm-Message-State: AHQUAua3jGgQZZzQkVitQekFnh+o3rMfqOsXxCowAjZ4puaZYpufO5Jr
        TRO8Y8tmHWrWIHq9hLKkEM8rIA==
X-Google-Smtp-Source: AHgI3IZPbUuWYBranDoadxPk7Y9CMw1G8m9sZFEz5G8jqNt365oH3OrNrmQ5Sr+e79EnTQ7GEtMIyg==
X-Received: by 2002:a19:f244:: with SMTP id d4mr17686735lfk.0.1550564762186;
        Tue, 19 Feb 2019 00:26:02 -0800 (PST)
Received: from [192.168.0.199] ([31.173.81.43])
        by smtp.gmail.com with ESMTPSA id v8sm3768544lji.51.2019.02.19.00.26.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Feb 2019 00:26:01 -0800 (PST)
Subject: Re: [PATCH v2 02/10] dt-bindings: misc: Add bindings for HiSilicon
 usb hub and data role switch functionality on HiKey960
To:     Yu Chen <chenyu56@huawei.com>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     john.stultz@linaro.org, suzhuangluan@hisilicon.com,
        kongfei@hisilicon.com, liuyu712@hisilicon.com,
        wanghu17@hisilicon.com, butao@hisilicon.com, chenyao11@huawei.com,
        fangshengzhou@hisilicon.com, lipengcheng8@huawei.com,
        songxiaowei@hisilicon.com, xuyiping@hisilicon.com,
        xuyoujun4@huawei.com, yudongbin@hisilicon.com,
        zangleigang@hisilicon.com, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Binghui Wang <wangbinghui@hisilicon.com>
References: <20190218112310.17860-1-chenyu56@huawei.com>
 <20190218112310.17860-3-chenyu56@huawei.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <22270fce-602e-d9fd-0416-58bfecc40b07@cogentembedded.com>
Date:   Tue, 19 Feb 2019 11:25:55 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190218112310.17860-3-chenyu56@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 18.02.2019 14:23, Yu Chen wrote:

> This patch adds binding documentation to support usb hub and usb
> data role switch of Hisilicon HiKey960 Board.
> 
> Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: John Stultz <john.stultz@linaro.org>
> Cc: Binghui Wang <wangbinghui@hisilicon.com>
> Signed-off-by: Yu Chen <chenyu56@huawei.com>
> ---
> v1:
> * Fix some format errors as suggested by Sergei.
> * Modify gpio description to use gpiod API.
> v2:
> * Remove information about Hikey.
> * Fix gpio description.
> * Remove device_type of endpoint.
> ---
> ---
>   .../bindings/misc/hisilicon-hikey-usb.txt          | 35 ++++++++++++++++++++++
>   1 file changed, 35 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/misc/hisilicon-hikey-usb.txt
> 
> diff --git a/Documentation/devicetree/bindings/misc/hisilicon-hikey-usb.txt b/Documentation/devicetree/bindings/misc/hisilicon-hikey-usb.txt
> new file mode 100644
> index 000000000000..c2b789b515df
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/hisilicon-hikey-usb.txt
> @@ -0,0 +1,35 @@
> +Support usb hub and usb data role switch of Hisilicon HiKey960 Board.
> +
> +-----------------------------
> +
> +Required properties:
> +- compatible: "hisilicon,gpio-hubv1","hisilicon,hikey960-usb"

    Only one of those, looking at your example?
    Need a space after comma, BTW.

> +- typec-vbus-gpios: gpio to control the vbus of typeC port
> +- typec-vbus-enable-val: gpio value that enable the vbus of typeC port

    Hm, I thought that can be inferred from the GPIO specifier above...

> +- otg-switch-gpios: gpio to switch DP & DM between the hub and typeC port
> +- hub-vdd33-en-gpios: gpio to enable the power of hub
> +- pinctrl-0: pinctrl config

    You forgot about "pinctrl-names"...

> +
> +Example
> +-----
> +
> +	hisi_hikey_usb: hisi_hikey_usb {
> +		compatible = "hisilicon,hikey960-usb";
> +		typec-vbus-gpios = <&gpio25 2 0>;
> +		typec-vbus-enable-val = <1>;
> +		otg-switch-gpios = <&gpio25 6 0>;
> +		hub-vdd33-en-gpios = <&gpio5 6 0>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&usbhub5734_pmx_func>;
> +
> +		port {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			hikey_usb_ep: endpoint@0 {
> +				reg = <0>;
> +				remote-endpoint = <&dwc3_role_switch_notify>;
> +			};
> +		};
> +
> +	};

MBR, Sergei

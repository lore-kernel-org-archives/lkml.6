Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF603C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 20:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 950DB2077C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 20:39:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FXpgMSVL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 950DB2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbeIEBGX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 21:06:23 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:41307 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbeIEBGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 21:06:23 -0400
Received: by mail-qt0-f195.google.com with SMTP id t39-v6so5612803qtc.8
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 13:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=p+LsW6yK5Ha7yWY5W/eKPo9Srat7ATvJzTqj5JMOW2o=;
        b=FXpgMSVL5EDbO7Yc3vjSBYYbYsW2zYJuj4ZdgqJO1m+r62WvCd41MF4wXjZr7I+t6G
         FxsUcc406DMjm5mI7DJIoTzzx6argwh8puSG40iOm8TX9KgcatGFXth+GVgrqAxh9fwq
         vypvimZhRHSoLziwi9PBn2bKpcVHdzhtXQTBA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=p+LsW6yK5Ha7yWY5W/eKPo9Srat7ATvJzTqj5JMOW2o=;
        b=TqAV/alPgv3nDR5RdFzShokOAkCyiw81pFgDD5873NfWmD5G1M5aAN8zMoiZbnwmBK
         r4AVn5Qt4GRwq3T6P6omwYXtUiHDb8PM1und+yt6Icjo+yfYMXlhOyOSLIyv3Dw5YlA6
         2CmWfWPB7rIuo8i3X+PmqgLncI8SnAXB0CVtzVTbu1IvHkqTgJ54MuuFdPrHNcNKTEfa
         4caBwsqx4SuE/0ixxW3yCkJ49AScwrZPocKMydN5n4NrAS6nwOeL+HWCOP3+IKfCLLco
         AOloyh28L1GMjwg6fJ4pN9Zb/B3bT9Vwz2M0hbLHHYjEreor4Wk0aFKC5PNUP9N7Ov9O
         O7sQ==
X-Gm-Message-State: APzg51Ce0p5Cp1bnoFvMm/s0ohdOMzZ8kQhoeMWqLXPcitTi8Bj4cTfT
        QOZ45F3u4MPSg/PvKb4TkcEZmg==
X-Google-Smtp-Source: ANB0Vdav5G1Fvu2ZNzLGTU+8+6vLNYMRwg1t1lhBj7KuVkM2JvLrTBdAA40sRy6LbxDi31AARbNTHQ==
X-Received: by 2002:aed:2c27:: with SMTP id f36-v6mr32535246qtd.229.1536093575571;
        Tue, 04 Sep 2018 13:39:35 -0700 (PDT)
Received: from [10.136.8.248] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id o10-v6sm14772753qta.54.2018.09.04.13.39.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 13:39:34 -0700 (PDT)
Subject: Re: [PATCH v3 1/3] ARM: dts: NSP: Enable SFP on bcm958625hr
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jon Mason <jonmason@broadcom.com>,
        "maintainer:BROADCOM IPROC ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, andrew@lunn.ch,
        rmk+kernel@armlinux.org.uk
References: <20180831192039.11842-1-f.fainelli@gmail.com>
 <20180831192039.11842-2-f.fainelli@gmail.com>
From:   Ray Jui <ray.jui@broadcom.com>
Message-ID: <68b987de-9229-4606-a972-650b3f486e19@broadcom.com>
Date:   Tue, 4 Sep 2018 13:39:30 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180831192039.11842-2-f.fainelli@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/31/2018 12:20 PM, Florian Fainelli wrote:
> Enable the SFP connected to port 5 of the switch and wire up all GPIOs
> to the SFP cage. Because of a hardware limitation of the i2c controller
> on the iProc SoCs which prevents large i2c (> 63 bytes) transactions to
> work, we use the i2c-gpio interface instead, which does not have that
> limitation. This allows us to read the SFP module EEPROM, which would
> not be possible otherwise since it exceeds that size during a single
> read transfer.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>   arch/arm/boot/dts/bcm958625hr.dts | 26 ++++++++++++++++++++++++++
>   1 file changed, 26 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/bcm958625hr.dts b/arch/arm/boot/dts/bcm958625hr.dts
> index ea3fc194f8f3..a53a2f629d74 100644
> --- a/arch/arm/boot/dts/bcm958625hr.dts
> +++ b/arch/arm/boot/dts/bcm958625hr.dts
> @@ -58,6 +58,24 @@
>   		open-source;
>   		priority = <200>;
>   	};
> +
> +	/* Hardware I2C block cannot do more than 63 bytes per transfer,
> +	 * which would prevent reading from a SFP's EEPROM (256 byte).
> +	 */
> +	i2c1: i2c {
> +		compatible = "i2c-gpio";
> +		sda-gpios = <&gpioa 5 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +		scl-gpios = <&gpioa 4 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +	};
> +
> +	sfp: sfp {
> +		compatible = "sff,sfp";
> +		i2c-bus = <&i2c1>;
> +		mod-def0-gpios = <&gpioa 28 GPIO_ACTIVE_LOW>;
> +		los-gpios = <&gpioa 24 GPIO_ACTIVE_HIGH>;
> +		tx-fault-gpios = <&gpioa 30 GPIO_ACTIVE_HIGH>;
> +		tx-disable-gpios = <&gpioa 26 GPIO_ACTIVE_HIGH>;
> +	};
>   };
>   
>   &amac0 {
> @@ -210,6 +228,14 @@
>   			reg = <4>;
>   		};
>   
> +		port@5 {
> +			label = "sfp";
> +			phy-mode = "sgmii";
> +			reg = <5>;
> +			sfp = <&sfp>;
> +			managed = "in-band-status";
> +		};
> +
>   		port@8 {
>   			ethernet = <&amac2>;
>   			label = "cpu";
> 

Looks good to me. Thanks!

Reviewed-by: Ray Jui <ray.jui@broadcom.com>

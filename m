Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6164EC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 21:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 194572084A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 21:31:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PsQd8scv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 194572084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbeH2BYj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 21:24:39 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:40355 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbeH2BYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 21:24:39 -0400
Received: by mail-qk0-f195.google.com with SMTP id c126-v6so2038955qkd.7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 14:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bp5C8dkkEKoS+jRu9dkXcGIDmvHsqyq3UGcDLqMeaR0=;
        b=PsQd8scvEy2Ze5fk0NuAEYFZmY7vj9as/U60zVnd2f5fvvKxH6SHJWI0GydD6Jipob
         BuDTg6+bQLbFbPIHMAXg84AKQm75Nde2B3jiHbYSV91NUJ2e7NY7q2NGMqVOuMvOgqh5
         BRyZQq+CKvTH9K3Zv4WLmDxbzibkgnAbZa5y4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bp5C8dkkEKoS+jRu9dkXcGIDmvHsqyq3UGcDLqMeaR0=;
        b=fxGoK1Y+p68c/jgFqdU4qKzTwT2CeU8pFEKGD5CxS+xA45rh4dgyhaUvzbq0cC0iQE
         y5Xc/hSqJzOucVLUkchF3vFlw8hhAKj1Rmx53Gu1nxfxBsAIyDTHY3TfnuGCjwliXmXt
         YjVBkX/t5ZZ8WX8RgYPsKdCXmYc/ItKEWb49Ob1XAZYXF5J5ZUWPtF+O5gmhoTSRaGUq
         jZ15nFSxOOmy2JBy8wldMXI02/vu+4rDXLVSMeO3pJIRB7ar0iKL/PDomzAapsTLHYLj
         af9T54f3SXD70yN5ABzxXHCihl5rrwRIx3WxdB6M9FJ60gv6OKiT8ExYD/ZwFFh0wKWB
         3LCg==
X-Gm-Message-State: APzg51A1ECOyI9yHkcymzfZAoshkMOdcLtjhUoIXutMAxXRDi1Bqoeny
        2csplVGb3kgDofgSakVnsXzU2Q==
X-Google-Smtp-Source: ANB0VdYsMrXaL+OripN6JePH6FRPqd0w4kux6ZFN8VaqFzXcN0T53hd8Ajj3Xp3k6C657NEkmXHkYg==
X-Received: by 2002:a37:98c1:: with SMTP id a184-v6mr3600833qke.328.1535491866199;
        Tue, 28 Aug 2018 14:31:06 -0700 (PDT)
Received: from [10.136.8.248] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id u7-v6sm1435390qtc.76.2018.08.28.14.31.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 14:31:05 -0700 (PDT)
Subject: Re: [PATCH v2 1/3] ARM: dts: NSP: Enable SFP on bcm958625hr
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
References: <20180828175420.7992-1-f.fainelli@gmail.com>
 <20180828175420.7992-2-f.fainelli@gmail.com>
From:   Ray Jui <ray.jui@broadcom.com>
Message-ID: <b1c97c3e-ae7f-8948-5146-df27e38da961@broadcom.com>
Date:   Tue, 28 Aug 2018 14:31:02 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180828175420.7992-2-f.fainelli@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/28/2018 10:54 AM, Florian Fainelli wrote:
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
> index ea3fc194f8f3..6fa0d8d1a218 100644
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
> +	i2c1: i2c1 {

nit, "i2c1: i2c {" ?

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

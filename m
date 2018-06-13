Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 4D350C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 19:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED10E208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 19:50:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KrFX0khx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED10E208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935647AbeFMTu1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 15:50:27 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33451 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935381AbeFMTuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 15:50:25 -0400
Received: by mail-wm0-f65.google.com with SMTP id z6-v6so503668wma.0;
        Wed, 13 Jun 2018 12:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lT0CRwSkmUkviCjpQjkfrpfQX85ebac1pGDjLcA/tKA=;
        b=KrFX0khxodZgYa8ZTWAXB9j/213ivTCwhBHtBQfIM71YvyDnqBDshHJOSkalV+tHbD
         HGt7+PaWecbRE1+4CaoPS25l6y2NDrtpkfwbm3ioAjMsMk/d4E6Cx+0x1VdatcydpvzZ
         KHh1veuHH5hcyOAAfjWu8wd9BjjZlvKwJJ2W7aqTzPGGf+9qOGbTWMHfO0X/JtTNiuT7
         lKsQEBQKXBG8+5XprtyMb+hlSb6+GMGhzCv+z0XDr4aH1t3/dKlSEZ8IvciZjY7gIH7m
         K3NlLZtGtzDWZmPq79HwVULd5Ogonm4hcubFl+IKwKghqyH+R1i5oabDpNmnRK7OIqSU
         xD6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=lT0CRwSkmUkviCjpQjkfrpfQX85ebac1pGDjLcA/tKA=;
        b=odviGpsrubWCSRx0xsXBZoza9INxRKX8Z2t9ulzWpWwAx3ILPmsj/dzwXiZWsv9+bb
         xiLROCA4Q1OpKN9tcaIC9/zOZ6MTymVcs8VUZ/K8bF/12v50HFkRjWDvmb3s0SeCwkfw
         xmzRo6aKDkSwtRxnA57Ww5PcUR65xajlZZRu4DwBQKHjEjoTNcBc3bv44SZM6uCC7o83
         pNZvGr8QZIWXIAhgR8u8bSHBXbhPpxidoqxVxRsDikmna12NowuCxpxGXi7bUMJWTXFN
         QLkEFJxpAQlJV7Kk71publSHI4F7GV4wD0jCTks2F7TDXIQUmOWWygpoSX4Dce63DI/g
         UY8w==
X-Gm-Message-State: APt69E1OeQ9mcl1s2y5DqVCW+WFyO5whAF4E1dZuRfxz9hYajId1q89M
        KIqzXOBp2IJkkg0uHzVKujc=
X-Google-Smtp-Source: ADUXVKJQLxtER8qcnwTj6Biu3reI599jZW9pW8FYe4isCdy1oM0KqF2hFOx0CvlvY+vfBtSKeLxrNQ==
X-Received: by 2002:a50:884f:: with SMTP id c15-v6mr5550712edc.211.1528919423956;
        Wed, 13 Jun 2018 12:50:23 -0700 (PDT)
Received: from [10.69.41.93] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id 2-v6sm2138849edz.67.2018.06.13.12.50.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jun 2018 12:50:22 -0700 (PDT)
Subject: Re: [PATCH 2/5] ARM: dts: cygnus: Fix PCIe controller interrupt type
To:     Ray Jui <ray.jui@broadcom.com>,
        linux-arm-kernel@lists.infradead.org,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
References: <1528834891-17807-1-git-send-email-ray.jui@broadcom.com>
 <1528834891-17807-3-git-send-email-ray.jui@broadcom.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <99e3ab78-a639-5244-75a6-af39e56e7c67@gmail.com>
Date:   Wed, 13 Jun 2018 12:50:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1528834891-17807-3-git-send-email-ray.jui@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/12/2018 01:21 PM, Ray Jui wrote:
> Fix PCIe controller interrupt to use IRQ_TYPE_LEVEL_HIGH for Broadcom
> Cygnus SoC
> 
> Fixes: cd590b50a936 ("ARM: dts: enable PCIe support for Cygnus")

This one is valid

> Fixes: 0f0b21a83ad2 ("ARM: dts: Move all Cygnus peripherals into axi
> bus")
> Fixes: 9c5101f7a253 ("ARM: dts: Reorder Cygnus peripherals")
> Fixes: f6b889358a82 ("ARM: dts: Enable MSI support for Broadcom Cygnus")

And this one too, but the two others, I would probably drop them so we
can get the backports to be possibly applicable as far as when these two
commits can be resolved, does that work?

> 
> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
> ---
>  arch/arm/boot/dts/bcm-cygnus.dtsi | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi b/arch/arm/boot/dts/bcm-cygnus.dtsi
> index 835a6f7..2c4df2d 100644
> --- a/arch/arm/boot/dts/bcm-cygnus.dtsi
> +++ b/arch/arm/boot/dts/bcm-cygnus.dtsi
> @@ -256,7 +256,7 @@
>  
>  			#interrupt-cells = <1>;
>  			interrupt-map-mask = <0 0 0 0>;
> -			interrupt-map = <0 0 0 0 &gic GIC_SPI 100 IRQ_TYPE_NONE>;
> +			interrupt-map = <0 0 0 0 &gic GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
>  
>  			linux,pci-domain = <0>;
>  
> @@ -278,10 +278,10 @@
>  				compatible = "brcm,iproc-msi";
>  				msi-controller;
>  				interrupt-parent = <&gic>;
> -				interrupts = <GIC_SPI 96 IRQ_TYPE_NONE>,
> -					     <GIC_SPI 97 IRQ_TYPE_NONE>,
> -					     <GIC_SPI 98 IRQ_TYPE_NONE>,
> -					     <GIC_SPI 99 IRQ_TYPE_NONE>;
> +				interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>;
>  			};
>  		};
>  
> @@ -291,7 +291,7 @@
>  
>  			#interrupt-cells = <1>;
>  			interrupt-map-mask = <0 0 0 0>;
> -			interrupt-map = <0 0 0 0 &gic GIC_SPI 106 IRQ_TYPE_NONE>;
> +			interrupt-map = <0 0 0 0 &gic GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
>  
>  			linux,pci-domain = <1>;
>  
> @@ -313,10 +313,10 @@
>  				compatible = "brcm,iproc-msi";
>  				msi-controller;
>  				interrupt-parent = <&gic>;
> -				interrupts = <GIC_SPI 102 IRQ_TYPE_NONE>,
> -					     <GIC_SPI 103 IRQ_TYPE_NONE>,
> -					     <GIC_SPI 104 IRQ_TYPE_NONE>,
> -					     <GIC_SPI 105 IRQ_TYPE_NONE>;
> +				interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
>  			};
>  		};
>  
> 


-- 
Florian

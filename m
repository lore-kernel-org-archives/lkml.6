Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 91qIGNVeGVv9MgAAmS7hNA
	; Thu, 07 Jun 2018 16:35:58 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 844136089E; Thu,  7 Jun 2018 16:35:58 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VXt50F6f"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 05CE6605A2;
	Thu,  7 Jun 2018 16:35:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 05CE6605A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933034AbeFGQfz (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 12:35:55 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:36238 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932418AbeFGQfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 12:35:53 -0400
Received: by mail-qt0-f195.google.com with SMTP id o9-v6so10477814qtp.3;
        Thu, 07 Jun 2018 09:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lzZWRNcCJPPshpZcZFmS4b2C4AaYc+1wXz8mab7cLyI=;
        b=VXt50F6fXkho8iBoHLlBpUjhw3dGIcR0+Y3D8XHAvRPw1JUBn+29MgDFuXVYQqYD8O
         atdeRG4OpIe2277N0+WlRhRjk5O24PPwiiZI95UbpBp7pB1nFSUNWqZ/v9qg9Y1pra/N
         rhHeuSl0MJsUkxu1tX0gCNXWGvweVVC4dosMI2muykKzfMy/MJVs8135Un+Wr4kt+IPz
         9Skq4vyKfa0GxYjol6D4V7ZpuDDJkcSHurmD+S1foxaYdMFiIkxhMsEbolOqlWZdZFKY
         eR74ZreR7pPbQWtqw3jIT6Uz0EKOTYd4GiKa5tEnUWZx6qyTyXI6RASBNPMUCcHkCoTY
         nijQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=lzZWRNcCJPPshpZcZFmS4b2C4AaYc+1wXz8mab7cLyI=;
        b=B+KLv5QlksUylgS+94mVbezWcLePvwTZO5AlraQHMUD3Eadg5Q5JhCBEUsUfprbXMY
         NW/cHr0QWQw61n1F+0QsZlzMqPshTIpvlv/8w54/pnETKZEujzRMuwosgwvvBWRTRzDs
         kHMkWMcYWgT8/maqkk0ASZhAjvXv1E3R2x2sziSyeZamCWUvpxZIRZXK2uaq79lvoImq
         b9s6EjtdiPRvWTZa4isuN9sFVzP0ZtczBurQnd45Z1BJ646AR1d9lvoCwFiYZOoALRoG
         VJFarRzoJAQBK86S7oFLqFdKq2sWxVwt8H/CH9rxGjpAtOsPEAarSBn4PEQufrBe0dik
         HUZA==
X-Gm-Message-State: APt69E0nA9OOkluODhQ6bElBDglvO6iXPl++vtRsxgOpnDsYQLHJ+WQG
        wI6UuRgOdLXoNVZjfDVAUzE=
X-Google-Smtp-Source: ADUXVKLXkT7AVeQDvKIW9gro/lcOOwWqxgRmVwThtvIiRt5qtsSMMZPIDh4ExAydaxWGMeQcF7Q1Ow==
X-Received: by 2002:ac8:2238:: with SMTP id o53-v6mr2460682qto.355.1528389352267;
        Thu, 07 Jun 2018 09:35:52 -0700 (PDT)
Received: from [10.69.41.93] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id e63-v6sm8473007qkj.62.2018.06.07.09.35.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 09:35:50 -0700 (PDT)
Subject: Re: [PATCH v2 1/1] ARM: dts: cygnus: enable iproc-hwrng
To: Scott Branden <scott.branden@broadcom.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Clement Peron <peron.clem@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc: BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Mohamed Ismail Abdul Packir Mohamed
        <mohamed-ismail.abdul@broadcom.com>
References: <1528309291-25579-1-git-send-email-scott.branden@broadcom.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <c0b4d69d-2826-320e-974e-c7cdbf341747@gmail.com>
Date: Thu, 7 Jun 2018 09:35:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1528309291-25579-1-git-send-email-scott.branden@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/06/2018 11:21 AM, Scott Branden wrote:
> From: Mohamed Ismail Abdul Packir Mohamed <mohamed-ismail.abdul@broadcom.com>
> 
> Enable the HW rng driver "iproc-rng200" for all cygnus platforms.
> 
> Signed-off-by: Mohamed Ismail Abdul Packir Mohamed <mohamed-ismail.abdul@broadcom.com>
> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
> Signed-off-by: Scott Branden <scott.branden@broadcom.com>

Clement, do you want to test this and reported back?

> ---
>  arch/arm/boot/dts/bcm-cygnus.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi b/arch/arm/boot/dts/bcm-cygnus.dtsi
> index 9fe4f5a..b0e38fa 100644
> --- a/arch/arm/boot/dts/bcm-cygnus.dtsi
> +++ b/arch/arm/boot/dts/bcm-cygnus.dtsi
> @@ -417,6 +417,11 @@
>  			status = "disabled";
>  		};
>  
> +		rng: rng@18032000 {
> +			compatible = "brcm,iproc-rng200";
> +			reg = <0x18032000 0x28>;
> +		};
> +
>  		sdhci0: sdhci@18041000 {
>  			compatible = "brcm,sdhci-iproc-cygnus";
>  			reg = <0x18041000 0x100>;
> 


-- 
Florian

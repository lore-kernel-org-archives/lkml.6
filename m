Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C32DECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 13:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C27D52084A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 13:15:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OkhYif4p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C27D52084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731612AbeGTODm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 10:03:42 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37541 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731176AbeGTODm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 10:03:42 -0400
Received: by mail-wr1-f68.google.com with SMTP id q10-v6so11312075wrd.4
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 06:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YS6nxKpOJPBL1nx2aZRXuFP1Cy9etmwkUKHYv5rTWrY=;
        b=OkhYif4pJesSzF90u5+7w1b1bfLGrwqfoDf0a3xl83BkjTO8FbkbaSllDvPD6dx2ke
         h0Wn3vwGW7UKPZnvLB/LmTyTqBJhOZEwWRJNa89XYD+5D/6sL+Xbqo6O6oLwkCebf5/M
         3O3GkFqpCEHk1oytDgTmZbMVKoJyfjMna6xHk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YS6nxKpOJPBL1nx2aZRXuFP1Cy9etmwkUKHYv5rTWrY=;
        b=t1u/8hNNopjhGb7LtfxbIipl2Ba7GOjQ/8rWeNXRr7OdoPjFx7lNJRnCikVJJuBBOv
         zIDU55rSuCTczO32z2CG0Yp/qEDz6ogiN+J0aviu5Zk0m8fPvP6cTo0Ml/afPtAGitd/
         GhtoAomaQAMnxcwf5bwJYuZdn03+pytefPBKUZvrn4WR8KmrcYlU0Lkj9WiccIEcvlL1
         9W4Frz5mLfeidzhTfr0OB3petwQuMHuLlcMXPNbhP+EQZvuC0WJxKpzN3nbsHLWPtRg6
         IPV4slh9hREXGqbSP6WbLRHObl9LIqK1jd1tL2Wq3YoVHv+8tFdh1EPOvPoapAxKS37E
         pOLQ==
X-Gm-Message-State: AOUpUlHOOGOZC5O9PjxKo1Pwp9a9E4sfLVDVoD/WizLpzc73EpVJ251M
        0brqqlPpyFBM4vUlyDzwvSn6FA==
X-Google-Smtp-Source: AAOMgpeXozaVbkOJTSVnLpppKwKh6DzoJcBFD5RJgK0yG6tN4JmvpysuQ/6/bOjXIeYGp/h2/68Rgg==
X-Received: by 2002:adf:ef8c:: with SMTP id d12-v6mr1594627wro.195.1532092526386;
        Fri, 20 Jul 2018 06:15:26 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.googlemail.com with ESMTPSA id e7-v6sm3615098wrm.14.2018.07.20.06.15.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Jul 2018 06:15:25 -0700 (PDT)
Subject: Re: [PATCH V4 3/8] backlight: qcom-wled: Add new properties for
 PMI8998
To:     Kiran Gunda <kgunda@codeaurora.org>, bjorn.andersson@linaro.org,
        jingoohan1@gmail.com, lee.jones@linaro.org,
        b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org,
        jacek.anaszewski@gmail.com, pavel@ucw.cz, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org
References: <1531131741-19971-1-git-send-email-kgunda@codeaurora.org>
 <1531131741-19971-4-git-send-email-kgunda@codeaurora.org>
From:   Daniel Thompson <daniel.thompson@linaro.org>
Message-ID: <a0f60860-6442-a091-9bdb-ade1d1092e19@linaro.org>
Date:   Fri, 20 Jul 2018 14:15:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1531131741-19971-4-git-send-email-kgunda@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/07/18 11:22, Kiran Gunda wrote:
> Update the bindings with the new properties used for
> PMI8998.
> 
> Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>

Acked-by: Daniel Thompson <daniel.thompson@linaro.org>


> ---
> Changes from V3:
> 	- Removed the default values.
> 	- Removed pmi8998 example.
> 
>   .../bindings/leds/backlight/qcom-wled.txt          | 76 ++++++++++++++++++----
>   1 file changed, 62 insertions(+), 14 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/leds/backlight/qcom-wled.txt b/Documentation/devicetree/bindings/leds/backlight/qcom-wled.txt
> index 14f28f2..3f22ced 100644
> --- a/Documentation/devicetree/bindings/leds/backlight/qcom-wled.txt
> +++ b/Documentation/devicetree/bindings/leds/backlight/qcom-wled.txt
> @@ -20,8 +20,7 @@ platforms. The PMIC is connected to the host processor via SPMI bus.
>   - default-brightness
>   	Usage:        optional
>   	Value type:   <u32>
> -	Definition:   brightness value on boot, value from: 0-4095
> -		      Default: 2048
> +	Definition:   brightness value on boot, value from: 0-4095.
>   
>   - label
>   	Usage:        required
> @@ -48,20 +47,24 @@ platforms. The PMIC is connected to the host processor via SPMI bus.
>   - qcom,current-limit
>   	Usage:        optional
>   	Value type:   <u32>
> -	Definition:   mA; per-string current limit
> -		      value: For pm8941: from 0 to 25 with 5 mA step
> -			     Default 20 mA.
> -			     For pmi8998: from 0 to 30 with 5 mA step
> -			     Default 25 mA.
> +	Definition:   mA; per-string current limit; value from 0 to 25 with
> +		      1 mA step.
> +		      This property is supported only for pm8941.
> +
> +- qcom,current-limit-microamp
> +	Usage:        optional
> +	Value type:   <u32>
> +	Definition:   uA; per-string current limit; value from 0 to 30000 with
> +		      2500 uA step.
>   
>   - qcom,current-boost-limit
>   	Usage:        optional
>   	Value type:   <u32>
>   	Definition:   mA; boost current limit.
>   		      For pm8941: one of: 105, 385, 525, 805, 980, 1260, 1400,
> -		      1680. Default: 805 mA
> +		      1680.
>   		      For pmi8998: one of: 105, 280, 450, 620, 970, 1150, 1300,
> -		      1500. Default: 970 mA
> +		      1500.
>   
>   - qcom,switching-freq
>   	Usage:        optional
> @@ -69,22 +72,66 @@ platforms. The PMIC is connected to the host processor via SPMI bus.
>   	 Definition:   kHz; switching frequency; one of: 600, 640, 685, 738,
>   		       800, 872, 960, 1066, 1200, 1371, 1600, 1920, 2400, 3200,
>   		       4800, 9600.
> -		       Default: for pm8941: 1600 kHz
> -				for pmi8998: 800 kHz
>   
>   - qcom,ovp
>   	Usage:        optional
>   	Value type:   <u32>
>   	Definition:   V; Over-voltage protection limit; one of:
> -		      27, 29, 32, 35. default: 29V
> +		      27, 29, 32, 35.
>   		      This property is supported only for PM8941.
>   
> +- qcom,ovp-millivolt
> +	Usage:        optional
> +	Value type:   <u32>
> +	Definition:   mV; Over-voltage protection limit;
> +		      For pmi8998: one of 18100, 19600, 29600, 31100
> +		      If this property is not specified for PM8941, it
> +		      falls back to "qcom,ovp" property.
> +
>   - qcom,num-strings
>   	Usage:        optional
>   	Value type:   <u32>
>   	Definition:   #; number of led strings attached;
> -		      value from 1 to 3. default: 2
> -		      This property is supported only for PM8941.
> +		      value: For PM8941 from 1 to 3.
> +			     For PMI8998 from 1 to 4.
> +
> +- interrupts
> +	Usage:        optional
> +	Value type:   <prop encoded array>
> +	Definition:   Interrupts associated with WLED. This should be
> +		      "short" and "ovp" interrupts. Interrupts can be
> +		      specified as per the encoding listed under
> +		      Documentation/devicetree/bindings/spmi/
> +		      qcom,spmi-pmic-arb.txt.
> +
> +- interrupt-names
> +	Usage:        optional
> +	Value type:   <string>
> +	Definition:   Interrupt names associated with the interrupts.
> +		      Must be "short" and "ovp". The short circuit detection
> +		      is not supported for PM8941.
> +
> +- qcom,enabled-strings
> +	Usage:        optional
> +	Value tyoe:   <u32 array>
> +	Definition:   Array of the WLED strings numbered from 0 to 3. Each
> +		      string of leds are operated individually. Specify the
> +		      list of strings used by the device. Any combination of
> +		      led strings can be used.
> +
> +- qcom,external-pfet
> +	Usage:        optional
> +	Value type:   <bool>
> +	Definition:   Specify if external PFET control for short circuit
> +		      protection is used. This property is supported only
> +		      for PMI8998.
> +
> +- qcom,auto-string-detection
> +	Usage:        optional
> +	Value type:   <bool>
> +	Definition:   Enables auto-detection of the WLED string configuration.
> +		      This feature is not supported for PM8941.
> +
>   
>   Example:
>   
> @@ -99,4 +146,5 @@ pm8941-wled@d800 {
>   	qcom,switching-freq = <1600>;
>   	qcom,ovp = <29>;
>   	qcom,num-strings = <2>;
> +	qcom,enabled-strings = <0x00 0x01>;
>   };
> 


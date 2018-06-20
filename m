Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10083C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 19:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B45CF208A1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 19:05:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B45CF208A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754940AbeFTTFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 15:05:08 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:42784 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754626AbeFTTFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 15:05:05 -0400
Received: by mail-pf0-f196.google.com with SMTP id w7-v6so251990pfn.9;
        Wed, 20 Jun 2018 12:05:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JFGD1ThS2YkXhZKgGLjNqiOqzddp65bwqVozihTmQX8=;
        b=YM1/V7AE16bbjCJw/OUh28ZuFEga3RKh74Wx6XDDHiNUAqkXoZbcRW+4njQrEwhkmd
         /SDs35P+L9LCegfRSIfjOlPZ8T1S7j6RSfUGnqS0lRugF0ohtHlXLfN+zDaJFu4pLUfe
         uhJGXeYd5kKDeKBStNUDbykmP6rzuUf/O6Tcf5gcNURL/aE8qRWJymbUdi1Yj0sVNOB0
         IY8QzWpFNOF1Ci+NbMiIxMVwW+OTNmutsVTJ2zopyBA59N/klZCfIuniUG/0+MB6SJKR
         z3UxvOzP7ptYETzA/vYVx8vHR8UR8RVoIj4lBLFvdDPYYjiQuULGhyQypNrAr1ttnsNt
         +JrQ==
X-Gm-Message-State: APt69E0dwokb1Wm+B69hmiAY+bXgrMMkGQLjt/CZg8lhYIpl7KH0lkm0
        ag4sFwRlWF8N/of+/BjAgw==
X-Google-Smtp-Source: ADUXVKJQ2IHiSAPUUadcx681kY3P6QXPz44RCY7O/ODQXTvvTZs/u9Wb6DICt9rhInGZsdVLcUhHCA==
X-Received: by 2002:a62:9c0d:: with SMTP id f13-v6mr6702143pfe.215.1529521504390;
        Wed, 20 Jun 2018 12:05:04 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id x5-v6sm4446206pfh.67.2018.06.20.12.05.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 12:05:03 -0700 (PDT)
Date:   Wed, 20 Jun 2018 13:05:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kiran Gunda <kgunda@codeaurora.org>
Cc:     bjorn.andersson@linaro.org, jingoohan1@gmail.com,
        lee.jones@linaro.org, b.zolnierkie@samsung.com,
        dri-devel@lists.freedesktop.org,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH V3 3/7] backlight: qcom-wled: Add new properties for
 PMI8998
Message-ID: <20180620190502.GA20160@rob-hp-laptop>
References: <1529406822-15379-1-git-send-email-kgunda@codeaurora.org>
 <1529406822-15379-4-git-send-email-kgunda@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529406822-15379-4-git-send-email-kgunda@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 04:43:38PM +0530, Kiran Gunda wrote:
> Update the bindings with the new properties used for
> PMI8998.
> 
> Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>
> ---
>  .../bindings/leds/backlight/qcom-wled.txt          | 84 ++++++++++++++++++++--
>  1 file changed, 77 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/leds/backlight/qcom-wled.txt b/Documentation/devicetree/bindings/leds/backlight/qcom-wled.txt
> index 14f28f2..503ce87 100644
> --- a/Documentation/devicetree/bindings/leds/backlight/qcom-wled.txt
> +++ b/Documentation/devicetree/bindings/leds/backlight/qcom-wled.txt
> @@ -48,11 +48,15 @@ platforms. The PMIC is connected to the host processor via SPMI bus.
>  - qcom,current-limit
>  	Usage:        optional
>  	Value type:   <u32>
> -	Definition:   mA; per-string current limit
> -		      value: For pm8941: from 0 to 25 with 5 mA step
> -			     Default 20 mA.
> -			     For pmi8998: from 0 to 30 with 5 mA step
> -			     Default 25 mA.
> +	Definition:   mA; per-string current limit; value from 0 to 25 with
> +		      1 mA step. Default 20 mA.
> +		      This property is supported only for pm8941.
> +
> +- qcom,current-limit-microamp
> +	Usage:        optional
> +	Value type:   <u32>
> +	Definition:   uA; per-string current limit; value from 0 to 30000 with
> +		      2500 uA step. Default 25000 uA.

This doesn't really seem worth adding just to add '-microamp'.


>  - qcom,current-boost-limit
>  	Usage:        optional
> @@ -79,12 +83,61 @@ platforms. The PMIC is connected to the host processor via SPMI bus.
>  		      27, 29, 32, 35. default: 29V
>  		      This property is supported only for PM8941.
>  
> +- qcom,ovp-millivolt

Is this the same as qcom,ovp? If so, same comment.

> +	Usage:        optional
> +	Value type:   <u32>
> +	Definition:   mV; Over-voltage protection limit;
> +		      For pmi8998: one of 18100, 19600, 29600, 31100
> +		      Default: 29600 mV
> +		      If this property is not specified for PM8941, it
> +		      falls back to "qcom,ovp" property.
> +
>  - qcom,num-strings
>  	Usage:        optional
>  	Value type:   <u32>
>  	Definition:   #; number of led strings attached;
> -		      value from 1 to 3. default: 2
> -		      This property is supported only for PM8941.
> +		      value: For PM8941 from 1 to 3. default: 2
> +			     For PMI8998 from 1 to 4. default: 4
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
> +		      for pm8941: Default values are [00 01].
> +		      for pmi8998: Default values are [00 01 02 03].

u32 or u8 because dts syntax for 8-bit array is [].

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
>  Example:
>  
> @@ -99,4 +152,21 @@ pm8941-wled@d800 {
>  	qcom,switching-freq = <1600>;
>  	qcom,ovp = <29>;
>  	qcom,num-strings = <2>;
> +	qcom,enabled-strings = <0x00 0x01>;
> +};
> +
> +pmi8998-wled@d800 {

led-controller {

And needs a unit-address.

> +	compatible = "qcom,pmi8998-wled";
> +	reg = <0xd800 0xd900>;
> +	label = "backlight";
> +
> +	interrupts = <3 0xd8 2 IRQ_TYPE_EDGE_RISING>,
> +		     <3 0xd8 1 IRQ_TYPE_EDGE_RISING>;
> +	interrupt-names = "short", "ovp";
> +	qcom,current-limit-microamp = <25000>;
> +	qcom,current-boost-limit = <805>;
> +	qcom,switching-freq = <1600>;
> +	qcom,ovp-millivolt = <29600>;
> +	qcom,num-strings = <4>;
> +	qcom,enabled-strings = <0x00 0x01 0x02 0x03>;
>  };
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
>  a Linux Foundation Collaborative Project
> 

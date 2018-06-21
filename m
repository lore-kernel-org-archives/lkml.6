Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F45C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 13:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A344D20837
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 13:13:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KOhpSd8A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A344D20837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933189AbeFUNNF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 09:13:05 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:44934 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933115AbeFUNNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 09:13:01 -0400
Received: by mail-wr0-f193.google.com with SMTP id p12-v6so1535720wrn.11
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 06:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0G+sEfmmi8L25Ifa4zPf0c+E6j+i2vE9du906bSSO44=;
        b=KOhpSd8AQQNkWzsFyOANKLbdvRiyXkV07Nqs1PeydxV+lwH5LC7Swsp/lwhQCW4c+j
         /lFnCKDsuWHlQeAqIAb2Ua9qV/53o/KRf3I7yvArWOM+KoUDcm3fLPs5L9GDn50acu38
         KhMNBD9x8sq+QPo+VM7gn5dM+ZhNk028/DAO8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0G+sEfmmi8L25Ifa4zPf0c+E6j+i2vE9du906bSSO44=;
        b=QnZUKJ2vC9/PzgAFsrqvt4e2lhlg9gN3P5u84eMhNbvgNAYpEjBRs+R80PMp4m+x0S
         OtgR+E7aRiMMXB4wpkJao0ckCd2mtAFI9QadfwKrmyAi2w8wvHajCv3q97LLDNPi+LQE
         gQVWbR0Fow7/wYIM7lVtNfDixFUZhSm0hfOyQ1Ox1HHBmAzWeEI4JW9tQZRDrGqPpIux
         5BfE6Shh1AOAtZJNMd8VqWQToMH32FSo5GyvcbpoogCTb8h6Nq9xz5kn51K9OpgbgdKS
         2BK2KrnTCs5JKQ/BeBHpm4jeMNmZpgqIh4VS4Dgk9pMcjFoj3AaoN1vOjBCzrd+xPh5p
         LOHw==
X-Gm-Message-State: APt69E19cEguU6q3kmFbm+sYLI8mUiVMDpGPmHVreJ0sizKw8Y1iV9aA
        iCQrUubC7+PnzIzOdl8NcTXRQg==
X-Google-Smtp-Source: ADUXVKJeF0q1G26eQW54Mtg+VRfyR+0KZpmnUV+dRGpvQErN2STWxYKJ5AjjkTetblhJMulg+I2ZLw==
X-Received: by 2002:adf:ad2f:: with SMTP id p44-v6mr22304436wrc.164.1529586780370;
        Thu, 21 Jun 2018 06:13:00 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id l15-v6sm6677621wrs.95.2018.06.21.06.12.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jun 2018 06:12:59 -0700 (PDT)
Date:   Thu, 21 Jun 2018 14:12:57 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Kiran Gunda <kgunda@codeaurora.org>
Cc:     bjorn.andersson@linaro.org, jingoohan1@gmail.com,
        lee.jones@linaro.org, b.zolnierkie@samsung.com,
        dri-devel@lists.freedesktop.org,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH V3 2/7] backlight: qcom-wled: restructure the qcom-wled
 bindings
Message-ID: <20180621131257.bql555n5vgwamtlu@holly.lan>
References: <1529406822-15379-1-git-send-email-kgunda@codeaurora.org>
 <1529406822-15379-3-git-send-email-kgunda@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529406822-15379-3-git-send-email-kgunda@codeaurora.org>
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 04:43:37PM +0530, Kiran Gunda wrote:
> Restructure the qcom-wled bindings for the better readability.
> 
> Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>

Acked-by: Daniel Thompson <daniel.thompson@linaro.org>

> ---
>  .../bindings/leds/backlight/qcom-wled.txt          | 110 ++++++++++++++++-----
>  1 file changed, 85 insertions(+), 25 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/leds/backlight/qcom-wled.txt b/Documentation/devicetree/bindings/leds/backlight/qcom-wled.txt
> index fb39e32..14f28f2 100644
> --- a/Documentation/devicetree/bindings/leds/backlight/qcom-wled.txt
> +++ b/Documentation/devicetree/bindings/leds/backlight/qcom-wled.txt
> @@ -1,30 +1,90 @@
>  Binding for Qualcomm Technologies, Inc. WLED driver
>  
> -Required properties:
> -- compatible: should be "qcom,pm8941-wled"
> -- reg: slave address
> -
> -Optional properties:
> -- default-brightness: brightness value on boot, value from: 0-4095
> -	default: 2048
> -- label: The name of the backlight device
> -- qcom,cs-out: bool; enable current sink output
> -- qcom,cabc: bool; enable content adaptive backlight control
> -- qcom,ext-gen: bool; use externally generated modulator signal to dim
> -- qcom,current-limit: mA; per-string current limit; value from 0 to 25
> -	default: 20mA
> -- qcom,current-boost-limit: mA; boost current limit; one of:
> -	105, 385, 525, 805, 980, 1260, 1400, 1680
> -	default: 805mA
> -- qcom,switching-freq: kHz; switching frequency; one of:
> -	600, 640, 685, 738, 800, 872, 960, 1066, 1200, 1371,
> -	1600, 1920, 2400, 3200, 4800, 9600,
> -	default: 1600kHz
> -- qcom,ovp: V; Over-voltage protection limit; one of:
> -	27, 29, 32, 35
> -	default: 29V
> -- qcom,num-strings: #; number of led strings attached; value from 1 to 3
> -	default: 2
> +WLED (White Light Emitting Diode) driver is used for controlling display
> +backlight that is part of PMIC on Qualcomm Technologies, Inc. reference
> +platforms. The PMIC is connected to the host processor via SPMI bus.
> +
> +- compatible
> +	Usage:        required
> +	Value type:   <string>
> +	Definition:   should be one of:
> +			"qcom,pm8941-wled"
> +			"qcom,pmi8998-wled"
> +			"qcom,pm660l-wled"
> +
> +- reg
> +	Usage:        required
> +	Value type:   <prop encoded array>
> +	Definition:   Base address of the WLED modules.
> +
> +- default-brightness
> +	Usage:        optional
> +	Value type:   <u32>
> +	Definition:   brightness value on boot, value from: 0-4095
> +		      Default: 2048
> +
> +- label
> +	Usage:        required
> +	Value type:   <string>
> +	Definition:   The name of the backlight device
> +
> +- qcom,cs-out
> +	Usage:        optional
> +	Value type:   <bool>
> +	Definition:   enable current sink output.
> +		      This property is supported only for PM8941.
> +
> +- qcom,cabc
> +	Usage:        optional
> +	Value type:   <bool>
> +	Definition:   enable content adaptive backlight control.
> +
> +- qcom,ext-gen
> +	Usage:        optional
> +	Value type:   <bool>
> +	Definition:   use externally generated modulator signal to dim.
> +		      This property is supported only for PM8941.
> +
> +- qcom,current-limit
> +	Usage:        optional
> +	Value type:   <u32>
> +	Definition:   mA; per-string current limit
> +		      value: For pm8941: from 0 to 25 with 5 mA step
> +			     Default 20 mA.
> +			     For pmi8998: from 0 to 30 with 5 mA step
> +			     Default 25 mA.
> +
> +- qcom,current-boost-limit
> +	Usage:        optional
> +	Value type:   <u32>
> +	Definition:   mA; boost current limit.
> +		      For pm8941: one of: 105, 385, 525, 805, 980, 1260, 1400,
> +		      1680. Default: 805 mA
> +		      For pmi8998: one of: 105, 280, 450, 620, 970, 1150, 1300,
> +		      1500. Default: 970 mA
> +
> +- qcom,switching-freq
> +	Usage:        optional
> +	Value type:   <u32>
> +	 Definition:   kHz; switching frequency; one of: 600, 640, 685, 738,
> +		       800, 872, 960, 1066, 1200, 1371, 1600, 1920, 2400, 3200,
> +		       4800, 9600.
> +		       Default: for pm8941: 1600 kHz
> +				for pmi8998: 800 kHz
> +
> +- qcom,ovp
> +	Usage:        optional
> +	Value type:   <u32>
> +	Definition:   V; Over-voltage protection limit; one of:
> +		      27, 29, 32, 35. default: 29V
> +		      This property is supported only for PM8941.
> +
> +- qcom,num-strings
> +	Usage:        optional
> +	Value type:   <u32>
> +	Definition:   #; number of led strings attached;
> +		      value from 1 to 3. default: 2
> +		      This property is supported only for PM8941.
>  
>  Example:
>  
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
>  a Linux Foundation Collaborative Project
> 

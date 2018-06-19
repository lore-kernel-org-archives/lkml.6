Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C04C1B0F1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 22:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40B712083A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 22:54:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XJ0GcG7X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40B712083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754339AbeFSWyA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 18:54:00 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:37184 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752903AbeFSWx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 18:53:58 -0400
Received: by mail-pf0-f194.google.com with SMTP id y5-v6so578168pfn.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 15:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=v0cDnhcaPwrdhMm2w/N/XmnYbjvJPTI564hdmuB8SEs=;
        b=XJ0GcG7XIGdc0S3kXipcrvPU9+f66ZQp8MHa+xUT/dYO0QtJ9hxc13T1ZQaI6E5uxP
         TLC9B66yRRr535M45sIcIp61n34sXMtgYeyQNCkBZkwkqQRw2BSdZArA5Ho/WkjkHuHQ
         gG5uXCm9Dq9adCizTzE8mEza8kVBYNaYH4AN4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=v0cDnhcaPwrdhMm2w/N/XmnYbjvJPTI564hdmuB8SEs=;
        b=OHxdBsOvslcHfQEG+vQo51uGjwWAUFokt0D0HmAmCku8h+BAPj6zIlbU+sfN26A2hD
         FSOn2d51dUXsvuUoy27p7c2D1ujN8bjadfc5Txt3SYhi6LnE51w34whzq87E0vyVSbRS
         kJ7BV27rkLgSbKnmnzGQ5aJm1uRFsvpBjMnNWDAPbJrPwHkQNbPIU7OyJot8nMXN2a5S
         MNNuYm1sRH+dgp+Prh7o+Oa2GIXD3gBwiglQOXlA7bY69f7ODN1E5lzWk+RRV92qtu+7
         KIyogH2MawfsV+9reAxW+Z4ZK93CNuqfULPGmrvieBH0S85RSfkFrLU4p9rPjgiz+ski
         +t3w==
X-Gm-Message-State: APt69E0/wWEfjVDfHQzsxy7t2h5JrqxUaVy7ilvqEK24OrEUxJfSUKIi
        LY59Y/WyQRx4OPVns+ylPcsv5w==
X-Google-Smtp-Source: ADUXVKJwcEXp+YPUqW2rRgJUn0D8vYBhCxjBzQeZoADINsAQx+sqQb2tPBlcbpXhXTCP9RvHYeACAg==
X-Received: by 2002:a62:e117:: with SMTP id q23-v6mr20200806pfh.75.1529448837368;
        Tue, 19 Jun 2018 15:53:57 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 84-v6sm968310pfl.186.2018.06.19.15.53.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Jun 2018 15:53:56 -0700 (PDT)
Date:   Tue, 19 Jun 2018 15:56:15 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Kiran Gunda <kgunda@codeaurora.org>
Cc:     jingoohan1@gmail.com, lee.jones@linaro.org,
        b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH V3 2/7] backlight: qcom-wled: restructure the qcom-wled
 bindings
Message-ID: <20180619225615.GF15126@tuxbook-pro>
References: <1529406822-15379-1-git-send-email-kgunda@codeaurora.org>
 <1529406822-15379-3-git-send-email-kgunda@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529406822-15379-3-git-send-email-kgunda@codeaurora.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 19 Jun 04:13 PDT 2018, Kiran Gunda wrote:

> Restructure the qcom-wled bindings for the better readability.
> 
> Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

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

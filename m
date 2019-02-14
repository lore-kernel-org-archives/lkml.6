Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71518C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 367F82229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:40:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wvigSyXF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395212AbfBNJkB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 04:40:01 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39403 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389937AbfBNJjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 04:39:54 -0500
Received: by mail-wm1-f65.google.com with SMTP id f16so5342590wmh.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 01:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=q15hbtt9WXmy92nKipuQ9vgHOWydPh18IRhSxNmaIXs=;
        b=wvigSyXFeQC9z5R8fus40Gkzc7wguZ8TId9D/y3KgJZcJbX7wiTNcknZDEXI0yLjIu
         O+jN6tcYHNrGk8T2nutTophyayY6jgbPLqh0sOacv2H8KkuCeq0DMENgArydFf78JlQh
         clQcAi5tEnsgap6xIJGMrslwxn0Ln6sR/df2zd+hnZocS8XTektdvdw2x0ZexX4X7CXd
         +hXuwn57IN840MI9ylGmuoz1Zf7vIOt5ibsQV3zpcI7llh83OjSqwt8XFwqauIrrVvi2
         ICr9TWn7CP3yKU5l1tlypwrMrHskWBidbT4LxI7RfmE2eFCVA8lPa8/x8JjWlIyc5COr
         +F0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=q15hbtt9WXmy92nKipuQ9vgHOWydPh18IRhSxNmaIXs=;
        b=ZHG/SsQGcca+hsP3ia+8U9oAzGtQALtzVXt5xvf8UFZX6FomJFuIdiIePBjA9qLXby
         3UcAEvARRTSUgIFkOsUHj1X7yuICvhBrCgtvOvd7lzEp9L3JIkdxzich+O8hJictOUxR
         vSAGE42k7mAT2XdXIGnkDe/7LEE9D2LRhcCAB904SyZh5E3Lcq4kKmi8iBlq1Da7SAJR
         hsoNrd14SgTG8NZRX6mwhrv8MmVbZTvNsJo/3Io/C08QqKz01JrpNzVGXFdE0jDGk8TV
         o5g5VY0Gthm/9K0O0msaEkK1/83GS32Ne8032YsB9/T8U4MfxDfyHc90A+pCAU/IfpSQ
         Sgwg==
X-Gm-Message-State: AHQUAuaAVH5JL10nPBvdBmPG2TV3s6ddy0vz/Hs68mxw+5DapFno/S6N
        xVh4uRwJ8SghQLZ693J+F0ob2StP/bc=
X-Google-Smtp-Source: AHgI3IaUFG1SqOw4HE+Bn83VTEBreWQ23kIOBQZkA1NPSPkNMMpguJaVz9/Qc690lZTb+N0p8wOmhQ==
X-Received: by 2002:a1c:101:: with SMTP id 1mr822798wmb.128.1550137191770;
        Thu, 14 Feb 2019 01:39:51 -0800 (PST)
Received: from dell ([2a01:4c8:c:28c9:4c60:37da:d7a:230])
        by smtp.gmail.com with ESMTPSA id p4sm999786wrs.74.2019.02.14.01.39.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Feb 2019 01:39:51 -0800 (PST)
Date:   Thu, 14 Feb 2019 09:39:49 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Virendra Kakade <virendra.kakade@ni.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        sre@kernel.org, moritz.fischer@ettus.com
Subject: Re: [RFC 5/6] power: supply: Ettus Research E31x battery driver
Message-ID: <20190214093949.GH13737@dell>
References: <20190212010143.3729-1-virendra.kakade@ni.com>
 <20190212010143.3729-6-virendra.kakade@ni.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190212010143.3729-6-virendra.kakade@ni.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Feb 2019, Virendra Kakade wrote:

> Document bindings for the E31x devices battery.
> 
> Signed-off-by: Virendra Kakade <virendra.kakade@ni.com>
> ---
>  Documentation/devicetree/bindings/mfd/e31x-pmu.txt |  8 +++++++-
>  .../bindings/power/supply/e31x-battery.txt         | 14 ++++++++++++++
>  2 files changed, 21 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/e31x-battery.txt
> 
> diff --git a/Documentation/devicetree/bindings/mfd/e31x-pmu.txt b/Documentation/devicetree/bindings/mfd/e31x-pmu.txt
> index 3798886578ba..223ab9e0d680 100644
> --- a/Documentation/devicetree/bindings/mfd/e31x-pmu.txt
> +++ b/Documentation/devicetree/bindings/mfd/e31x-pmu.txt
> @@ -4,11 +4,14 @@ Required properties:
>  - compatible : Must be "ni,e31x-pmu"
>  - regmap     : Must be <&regmapnode>
>  
> -e31x-pmu has a sub-device called e31x-charger.
> +e31x-pmu consists of two sub-devices, e31x-charger and e31x-battery.
>  
>  For the e31x-charger properties please refer to:
>  Documentation/device-tree/bindings/power/supply/e31x-charger.txt
>  
> +For the e31x-battery properties please refer to:
> +Documentation/device-tree/bindings/power/supply/e31x-battery.txt

Same comment as I provided in the Charger patch.

>  Example:
>  
>  pmu {
> @@ -18,5 +21,8 @@ pmu {
>  	charger: charger@0{
>  		compatible = "ni,e31x-charger";
>  	};
> +	battery: battery@1{
> +		compatible = "ni,e31x-battery";
> +	};
>  };

Still seems kinda simple.

> diff --git a/Documentation/devicetree/bindings/power/supply/e31x-battery.txt b/Documentation/devicetree/bindings/power/supply/e31x-battery.txt
> new file mode 100644
> index 000000000000..e09cd92ef82e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/e31x-battery.txt
> @@ -0,0 +1,14 @@
> +Ettus Research/National Instruments E31x Devices Battery
> +
> +Some variants of the E31x devices have an in-built Li-ion
> +battery. This driver provides capability to monitor
> +the battery.
> +
> +Required properties:
> +- compatible: Must be "ni,e31x-battery"
> +
> +Example:
> +
> +battery: battery@0{
> +	compatible = "ni,e31x-battery";
> +};

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

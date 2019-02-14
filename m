Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5740C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7476B222CC
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:38:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HvWKikLj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395109AbfBNJiZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 04:38:25 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44180 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392466AbfBNJiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 04:38:24 -0500
Received: by mail-wr1-f66.google.com with SMTP id v16so5647832wrn.11
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 01:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=kjkynXhQHgQqAMBKbIBJ2Fa5JpTV0s6khppBIggmVK8=;
        b=HvWKikLjzC6XvOsgplMLQNBTiivtSIbw8CT5a5fbHhn1fLPrDb96Ki4bZT1/VvlgXZ
         HBGK0eVnZvKS6KRflf/5IDnUODpFhyxdjTckV+1JlueN+//4UTy8QB1gQjtp5Js9Gkv4
         MmQHhqW1DyyVAa6mb+TslTx1JI75u/o32lcjjHyDeeXApMTGSoXlWvkc+wComROZHp8O
         /e1J17bsasJS7VNbzNAUx5Qb26rlmpbazbmiYVtFppxvAX9+dyhiLd+mir031QxbxJav
         5OjA19P3vNJeTDvlIpzmDrLnW++U4NOUZHJDBsx8HE/in/v/lANZaFBTUTlI9efn1+nI
         4uuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=kjkynXhQHgQqAMBKbIBJ2Fa5JpTV0s6khppBIggmVK8=;
        b=aWDB5XFP10Dw34dj0e42/O8V+SVnflbUEPVFHiWxKWEiNAX370rBaY46xKPGdRv15q
         ogtBwvTpYeflI/cLEMoA4lICamAs6OEPEtd0o31m+8L3eTHwr9w2kBJL/xWoBbWHt4Vt
         orcvukRYfqUoWGTDuuYNi4GWF6ROKHoknVKyhvxnC7Je1mFZ+Li6aIxNIwDUn/18GZuY
         GsTiUY9CeIhj8R/QeTVu1RVIz97HVmYFpf7tQPkafaHvA98Rus+is/RjFQzu9d/dnhv1
         W7LWVGmgu071Q9yO9eUZSvlwOyeipEcfsnYtZAfEgGypu60lWJG7XIpXa0JWeu+qkGxC
         ghlg==
X-Gm-Message-State: AHQUAuY9jhBFIFUdX8dqSh7OyFi50Ut+tJX3DL4mU/0/tbC6Vy9+ZXw5
        1ZtAEBo1zhwWZiYhwAoS1tISTA==
X-Google-Smtp-Source: AHgI3IYXKyL8dd2fvFvv/7aRm3HTfNxQUUM5z4Ed6arYZm91oNC8jNVVMAISUHeuGaNobHQiUqRrNg==
X-Received: by 2002:adf:f805:: with SMTP id s5mr2031830wrp.234.1550137102033;
        Thu, 14 Feb 2019 01:38:22 -0800 (PST)
Received: from dell ([2a01:4c8:c:28c9:4c60:37da:d7a:230])
        by smtp.gmail.com with ESMTPSA id w23sm1707223wmc.38.2019.02.14.01.38.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Feb 2019 01:38:21 -0800 (PST)
Date:   Thu, 14 Feb 2019 09:38:19 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Virendra Kakade <virendra.kakade@ni.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        sre@kernel.org, moritz.fischer@ettus.com
Subject: Re: [RFC 3/6] power: supply: Ettus Research E31x charger driver
Message-ID: <20190214093819.GG13737@dell>
References: <20190212010143.3729-1-virendra.kakade@ni.com>
 <20190212010143.3729-4-virendra.kakade@ni.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190212010143.3729-4-virendra.kakade@ni.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Feb 2019, Virendra Kakade wrote:

> Document bindings for the E31x devices charger.
> 
> Signed-off-by: Virendra Kakade <virendra.kakade@ni.com>
> ---
>  Documentation/devicetree/bindings/mfd/e31x-pmu.txt |  8 ++++++++
>  .../bindings/power/supply/e31x-charger.txt         | 14 ++++++++++++++
>  2 files changed, 22 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/e31x-charger.txt
> 
> diff --git a/Documentation/devicetree/bindings/mfd/e31x-pmu.txt b/Documentation/devicetree/bindings/mfd/e31x-pmu.txt
> index ebb5625f6c74..3798886578ba 100644
> --- a/Documentation/devicetree/bindings/mfd/e31x-pmu.txt
> +++ b/Documentation/devicetree/bindings/mfd/e31x-pmu.txt
> @@ -4,11 +4,19 @@ Required properties:
>  - compatible : Must be "ni,e31x-pmu"
>  - regmap     : Must be <&regmapnode>
>  
> +e31x-pmu has a sub-device called e31x-charger.
> +
> +For the e31x-charger properties please refer to:
> +Documentation/device-tree/bindings/power/supply/e31x-charger.txt

Use relative path, so:

  ../power/supply/e31x-charger.txt

>  Example:
>  
>  pmu {
>  	compatible = "ni,e31x-pmu";
>  	regmap = <&devctrl>;
>  	status = "okay";

'\n' here.

> +	charger: charger@0{
> +		compatible = "ni,e31x-charger";
> +	};
>  };
>  
> diff --git a/Documentation/devicetree/bindings/power/supply/e31x-charger.txt b/Documentation/devicetree/bindings/power/supply/e31x-charger.txt
> new file mode 100644
> index 000000000000..ae9fedcbf1b2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/e31x-charger.txt
> @@ -0,0 +1,14 @@
> +Ettus Research/National Instruments  E31x Devices Charger

Too many spaces.

> +All E31x devices have to be connected to an external power supply
> +charger to charge the in-built battery or supply power.
> +Some capability is provided to monitor this charger.

Why the linefeed here?  Take "Some" up to the previous line.

> +Required properties:
> +- compatible: Must be "ni,e31x-charger"
> +
> +Example:
> +
> +charger: charger@0{
> +	compatible = "ni,e31x-charger";
> +};

Not sure this really requires documentation.  Seems kinda simple.

I'll leave that up to Rob et al.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

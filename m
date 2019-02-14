Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6515C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7511E2229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:23:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b+e2VAHP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392473AbfBNJXP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 04:23:15 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38085 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390125AbfBNJXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 04:23:15 -0500
Received: by mail-wr1-f66.google.com with SMTP id v13so5622146wrw.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 01:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=9k/LIGQhUpABvLCk42mZFsQuNOmZs0f9/Ru/D3fAVNE=;
        b=b+e2VAHP2wTv6jQ03ImxFmqQsoceByNZkdBWs4yNmAtBcjCbJclcFQ8txFo7G8hlzO
         uZhVVmSV9BGLMKlPd6zeoe11S6KHyb8zYv9m+l+cykJPqC8+8lr9ofyKWXXQhhK2XAiD
         wz2u7+ihURgdlfjKWfvsKowy19G8KQsSvfu3MoyE7FhgXFMVxSj8qdk6B1yzAPs1QlcX
         MGY+VY5YNStIqXFYu1223FeJEI5sUNBbC83ckwwo+g+CCnHtCbtuwUKh8PzMOdU49+xR
         X8yElPF7tEq1tVX5UER33Jh6IHdgMEJMJod3koGBnoGZWFlD/K7ZZU5t8GN+Fszqb8iL
         b2Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=9k/LIGQhUpABvLCk42mZFsQuNOmZs0f9/Ru/D3fAVNE=;
        b=KQc4Yb8dMk/TdlSTCkP/yLam0RCNO+JNVfi8rvrSHKiBMkPzjjMkup3rjMgTuYNAy5
         sZ4QNVIZc3qxPhHJxnh7RErWQMyiI4Uz43bCphvI4fSVgCKr789PcfyAt0TbdYNJsaa5
         wTMYa/K1z4CBcH9nwmYuUzrS/xWo9QIdJkNDTEewlvDuKmmqFUwmLErE83+UpIe58cXE
         Tq9e+IDbf3alKjINPZwX7evLYJuMeOXdN9Z4wb3GOsWJencgqvEUVl4vaTaNj42LIPoF
         hDlb7gAw2/5VJfNYNnLq+JIQ2tf/JLS3HOnuckKRdjshyLw4MGssIV3c4utYWXYmWOVl
         8oAw==
X-Gm-Message-State: AHQUAuYpSAXo7o1wbMTQzdGcs8+21Px2RmYETy8fLKgiSrtxUXRApvp2
        qjIcJgZPW1N/2GctdqnDGCuQAA==
X-Google-Smtp-Source: AHgI3IZk6kWyruuwtTLVSw0GPlLqqxYngWEi+0xMpePR+mlKcXwXIFXwh2MUQUEh3CAQg9skD0A46w==
X-Received: by 2002:a5d:6244:: with SMTP id m4mr1914252wrv.314.1550136192635;
        Thu, 14 Feb 2019 01:23:12 -0800 (PST)
Received: from dell ([2a01:4c8:c:28c9:4c60:37da:d7a:230])
        by smtp.gmail.com with ESMTPSA id y187sm1179320wmy.41.2019.02.14.01.23.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Feb 2019 01:23:12 -0800 (PST)
Date:   Thu, 14 Feb 2019 09:23:10 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Virendra Kakade <virendra.kakade@ni.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        sre@kernel.org, moritz.fischer@ettus.com
Subject: Re: [RFC 1/6] mfd: Support for Ettus Research E31x devices PMU
Message-ID: <20190214092310.GE13737@dell>
References: <20190212010143.3729-1-virendra.kakade@ni.com>
 <20190212010143.3729-2-virendra.kakade@ni.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190212010143.3729-2-virendra.kakade@ni.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Feb 2019, Virendra Kakade wrote:

> Document bindings for E31x device PMU MFD driver.
> 
> Signed-off-by: Virendra Kakade <virendra.kakade@ni.com>
> ---
>  Documentation/devicetree/bindings/mfd/e31x-pmu.txt | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/e31x-pmu.txt
> 
> diff --git a/Documentation/devicetree/bindings/mfd/e31x-pmu.txt b/Documentation/devicetree/bindings/mfd/e31x-pmu.txt
> new file mode 100644
> index 000000000000..ebb5625f6c74
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/e31x-pmu.txt
> @@ -0,0 +1,14 @@
> +Ettus Research/National Instruments E31x PMU MFD driver

Please expand on what PMU is.

MFD is a Linuxisum and has no place in the description.

You can supplement it with "parent device" or some such.

> +Required properties:
> +- compatible : Must be "ni,e31x-pmu"
> +- regmap     : Must be <&regmapnode>
> +
> +Example:
> +
> +pmu {
> +	compatible = "ni,e31x-pmu";

No address?

> +	regmap = <&devctrl>;
> +	status = "okay";

Not required in DT documentation.

> +};
> +

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

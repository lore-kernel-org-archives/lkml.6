Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA6C1C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 21:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A02CE2082F
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 21:58:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hAwUu+jF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728614AbfA2V6v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 16:58:51 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:56216 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727339AbfA2V6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 16:58:50 -0500
Received: by mail-wm1-f67.google.com with SMTP id y139so19374521wmc.5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 13:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dxqiJP9zxtcIbTNaCfsLsQfjpBBmJ8e4nh0y9uR73Yo=;
        b=hAwUu+jF73VACkNwiYFvClP7JzQLKuIDdnUJkVu4Z+rPOWiRJBEzbULZ4OZzVh2+F2
         Bq1+kVVqh3Lz2MohKi0YikU0eRJV/2naTRm/WsPeZPEP5SxM8w2ajypWsB1axtH/nvbe
         Lc3YWVI43HNNid06i1zRHBY38NKq+ZrA7/PAI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dxqiJP9zxtcIbTNaCfsLsQfjpBBmJ8e4nh0y9uR73Yo=;
        b=oXS8v3Gofz6NDVOcqqoZitiK30xGwFihdxKP+UvXLTvFsX38Gyzh/2in5nag55RSGQ
         1cCixA2rPTJx+K6wbCesSmU8dYFABMoS3Dvw/Ns20wM+XYEGrd94/e5JLNxhgjUYLxO2
         uO9Oc0IncNp24keMW0f6DbnKi2Z8AmpRsm4CTvpauRcEiJa2nkdfmR4qhm83sJ+6+rvp
         CqLFmH3PT9h6khsoWa/7rmbAlb8NixKSzfoptHjGy7lglnmkcm+7S2v+fiX3TcODK20G
         jaHApx+0GYJIGQQ3nXvBsoR1A4P9GDsShBgjgCE2cKWCKEAgGv37DwXfAIE44KNvX2eV
         jkVQ==
X-Gm-Message-State: AJcUukd6ckLPl8zjb/dnJsXpsBXN0wZbjyMzkPguYveEcUduXvUNpa/a
        tf2a9EdQ8qQWvPCGlVDg43qbYw==
X-Google-Smtp-Source: ALg8bN4B2YJKrvwtai3l2s8UN7k953Ho6+/QEbX1eQFKvKq36lNOhh51gdSdRGJLXACXauKPSQqVDg==
X-Received: by 2002:a1c:b455:: with SMTP id d82mr23758219wmf.78.1548799128997;
        Tue, 29 Jan 2019 13:58:48 -0800 (PST)
Received: from [192.168.1.2] (233.red-81-47-145.staticip.rima-tde.net. [81.47.145.233])
        by smtp.gmail.com with ESMTPSA id h131sm71388wmd.17.2019.01.29.13.58.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 13:58:48 -0800 (PST)
Subject: Re: [PATCH] arm64: dts: qcs404: evb: Fix voltages for s5 and l3
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Khasim Syed Mohammed <khasim.mohammed@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>
References: <20190125232954.26166-1-bjorn.andersson@linaro.org>
From:   Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>
Message-ID: <32b8136d-3acb-66e9-948c-ee8903b91401@linaro.org>
Date:   Tue, 29 Jan 2019 22:58:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190125232954.26166-1-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/26/19 00:29, Bjorn Andersson wrote:
> PMS405 S5 was upstreamed without a voltage and PMS405 L3 is outside the
> acceptable range, causing PCIe to fail. Fix these.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/qcs404-evb.dtsi | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
> index 579ddaf4f5fa..072061aa1b79 100644
> --- a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
> +++ b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
> @@ -72,8 +72,8 @@
>  		};
>  
>  		vreg_s5_1p35: s5 {
> -			regulator-min-microvolt = <>;
> -			regulator-max-microvolt = <>;
> +			regulator-min-microvolt = <1352000>;
> +			regulator-max-microvolt = <1352000>;
>  		};
>  
>  		vreg_l1_1p3: l1 {
> @@ -87,7 +87,7 @@
>  		};
>  
>  		vreg_l3_1p05: l3 {
> -			regulator-min-microvolt = <976000>;
> +			regulator-min-microvolt = <1050000>;


the linear range for this regulator is
 - REGULATOR_LINEAR_RANGE(312000, 0, 127, 8000),

meaning that 1050000 is actually not a valid selectable value (ie, after
applying the above constrains 1056000 would be selected instead)

In order for a driver to be able to successfully request min = 1050000,
regulator-min-microvolt should be set to 1048000 (and 1056000 would be
applied)

the question is, should this property contain only hardware achievable
values? or should drivers only request hardware achievable values? the
way the constrains are implemented it has to be one of the two (I think
the former would be more intuitive - ie if the dts
regulator-min-microvolt is a valid value)

>  			regulator-max-microvolt = <1160000>;
>  		};
>  
> 


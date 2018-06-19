Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED764C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 11:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5AFA2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 11:16:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EE/NXf01"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5AFA2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937742AbeFSLPT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 07:15:19 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:32804 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937701AbeFSLPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 07:15:12 -0400
Received: by mail-wm0-f66.google.com with SMTP id z6-v6so18487266wma.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 04:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3qG2GD9vEydpZNA+93iHdGaoMR6QtDzUT2eZmaGdZXQ=;
        b=EE/NXf01ichKu/Q4IegwGIfQvryjFVhd0A4AdLG5a4IogkdRY5i8D6882ORg46qQaR
         Sn8oHipaKHpHKzvddbw+uXS+Ay5qWx7lwW3cVPrUJ+WEzQAV8ePQZIzmyrc4/bUjE9Hg
         td+C3YgLNLMf2ZYkwhrOXBVRbZKYxs/sHzmDc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3qG2GD9vEydpZNA+93iHdGaoMR6QtDzUT2eZmaGdZXQ=;
        b=t5ah/g+5DBizdK0YPoj0McKtE2paLa7ZpKxrYonNLOYVS84xmKW3oPvHZEPtcuT5cV
         EzMzj+p4hAn4W4Kc76XYWdQWSkLZJOdYcXSLXUcUXV7eo5RxafUnKGSl8DxS5BNWw7Hk
         WHhXSba0O1tQ+OkSOT00NkcptrDdnSFIKjspW2fVK/FxXmlsN3Cap/kNR+QXhxAryqF2
         G4+MOkYCHxSKjDtOGNPikcmlu2uER4iAf8YLPUpI8FTsDMl3XqFo4EJ18r5mOKzyBbyq
         YN80N6RXDxYADT/dXq07Zqt9OHnpFkGhrosIIcdbArdRjroGMoyEfde2mB6+lujcqynk
         +tIA==
X-Gm-Message-State: APt69E0JV29r1LnnSt9WNr9HFuswx4IYv7XnWYm+wSq5aTnn9h7eLoYA
        pKSPHQrLvkVo3/InigX9Tim4Bg==
X-Google-Smtp-Source: ADUXVKLwXSqEjjeC4a+6kT2LyeacjjTFB4xWuqz1zoOPAqHs1z5t2MoyIhKl7TklkLPWHf9gPNt9SQ==
X-Received: by 2002:a50:9553:: with SMTP id v19-v6mr14701044eda.268.1529406911245;
        Tue, 19 Jun 2018 04:15:11 -0700 (PDT)
Received: from [192.168.1.180] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id s2-v6sm9616725edm.13.2018.06.19.04.15.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 04:15:10 -0700 (PDT)
Subject: Re: [PATCH] dt-bindings: Fix unbalanced quotation marks
To:     =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>,
        devicetree@vger.kernel.org
Cc:     Mark Rutland <mark.rutland@arm.com>, linux-mips@linux-mips.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Madalin Bucur <madalin.bucur@nxp.com>,
        James Hogan <jhogan@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-samsung-soc@vger.kernel.org,
        Kevin Hilman <khilman@kernel.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Kukjin Kim <kgene@kernel.org>, linux-input@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jason Cooper <jason@lakedaemon.net>, linux-pm@vger.kernel.org,
        Marc Zyngier <marc.zyngier@arm.com>,
        Hauke Mehrtens <hauke@hauke-m.de>, linux-gpio@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, linux-tegra@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Anthony Kim <anthony.kim@hideep.com>, netdev@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Mark Brown <broonie@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
References: <20180617143127.11421-1-j.neuschaefer@gmx.net>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <1d775530-e250-6397-8e60-4dac8d580f7d@linaro.org>
Date:   Tue, 19 Jun 2018 12:15:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180617143127.11421-1-j.neuschaefer@gmx.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17/06/18 15:31, Jonathan Neuschäfer wrote:
>   example:
> diff --git a/Documentation/devicetree/bindings/sound/qcom,apq8016-sbc.txt b/Documentation/devicetree/bindings/sound/qcom,apq8016-sbc.txt
> index 6a4aadc4ce06..84b28dbe9f15 100644
> --- a/Documentation/devicetree/bindings/sound/qcom,apq8016-sbc.txt
> +++ b/Documentation/devicetree/bindings/sound/qcom,apq8016-sbc.txt
> @@ -30,7 +30,7 @@ Required properties:
>   
>   			  Board connectors:
>   			  * Headset Mic
> -			  * Secondary Mic",
> +			  * Secondary Mic
>   			  * DMIC
>   			  * Ext Spk
>   
> diff --git a/Documentation/devicetree/bindings/sound/qcom,apq8096.txt b/Documentation/devicetree/bindings/sound/qcom,apq8096.txt
> index aa54e49fc8a2..c7600a93ab39 100644
> --- a/Documentation/devicetree/bindings/sound/qcom,apq8096.txt
> +++ b/Documentation/devicetree/bindings/sound/qcom,apq8096.txt
> @@ -35,7 +35,7 @@ This binding describes the APQ8096 sound card, which uses qdsp for audio.
>   			"Digital Mic3"
>   
>   		Audio pins and MicBias on WCD9335 Codec:
> -			"MIC_BIAS1
> +			"MIC_BIAS1"
>   			"MIC_BIAS2"
>   			"MIC_BIAS3"
>   			"MIC_BIAS4"

for apq8016 and apq8096 parts:

Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>


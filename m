Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B06C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 09:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E349A20870
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 09:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XcGNEiKE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E349A20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729686AbeJ2SUD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 14:20:03 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34353 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729654AbeJ2SUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 14:20:02 -0400
Received: by mail-wr1-f68.google.com with SMTP id l6-v6so7849900wrt.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 02:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OsTQgLLgCIRJdq59GEZqSi0nH+pLjK8j0ZoJK6yAm4o=;
        b=XcGNEiKEuwO4DS8/w9SXAmauClSs2FlWl5DBUa8A4soVj22cE2wEXEJgccbjiA0jlg
         Ny8TYj3YmRTIb+6x3GYA4vMkFGkaop0fKAjiUIERdc1jXVlqmfKf5GBeqxk2/C0i8Wo6
         QfLvV1nISCzxYwTpvPy8fF+Fik3i2lXpBbkco=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OsTQgLLgCIRJdq59GEZqSi0nH+pLjK8j0ZoJK6yAm4o=;
        b=d3UekN3uzMlwWC7rvVBIoWqvscSmdgxh/SM5MK+y0s4a0CtktINUvIzRwSujz+7jvf
         2stRxUXtWZ67ow/6GU5mTCQ86uUZPc5eRhpjk5a12jIpdxnCnK2Bpydpifsnj+nHCMj6
         N50OccpaDIdsQpxYGbDo4FAXSbb/27KKGOJ3X/UVZs1oRXvyXxK10xBsMPpsjxw7I3QU
         MnEatJL6QRDKNLvddFjAyWoUWyAK7aapUPlzFaD348fI0ULNjVugwiAu13eldrCpJ0M7
         PQFjyipJZLWALc5YSVJL75bk/uNcyufS0uYh8WhS5WACmMzGQKLkJ0iJRbU+k1tPYjjh
         WipQ==
X-Gm-Message-State: AGRZ1gJLqmI3tVV88uIPqQWsflVyr15We9GS9g/9lghE1EbvEer7fYd6
        f7pgjMQr5S6df7o6rU8BdWLEXA==
X-Google-Smtp-Source: AJdET5dTfd7oYCLYAiV1MRzQBQOGz2kWOHsksatGqmOCzMSU/CksLPFY4OItejNp7mYz++vpJbI0dg==
X-Received: by 2002:adf:e14b:: with SMTP id f11-v6mr13140553wri.42.1540805529128;
        Mon, 29 Oct 2018 02:32:09 -0700 (PDT)
Received: from [192.168.27.209] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id e14-v6sm13748979wrs.69.2018.10.29.02.32.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 02:32:08 -0700 (PDT)
Subject: Re: [PATCH] arm64: dts: qcom: sdm845: Add SCM DT node
To:     Sibi Sankar <sibis@codeaurora.org>, andy.gross@linaro.org,
        david.brown@linaro.org, robh+dt@kernel.org
Cc:     bjorn.andersson@linaro.org, dianders@chromium.org,
        evgreen@chromium.org, benchan@chromium.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        tsoni@codeaurora.org
References: <20181026122542.4714-1-sibis@codeaurora.org>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <9fb3d2d2-37b5-27d2-ad27-45c77ebe1df2@linaro.org>
Date:   Mon, 29 Oct 2018 11:32:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181026122542.4714-1-sibis@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sibi,

On 10/26/2018 03:25 PM, Sibi Sankar wrote:
> Add SCM DT node to enable SCM functionality on SDM845.
> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index b72bdb0a31a5..fad22acfda4d 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -221,6 +221,12 @@
>  		};
>  	};
>  
> +	firmware {
> +		scm {
> +			compatible = "qcom,scm-sdm845", "qcom,scm";
> +		};
> +	};

What will happen if the platform is without tz firmware? I'd move this
DT node in sdm845-mtp.dts or at least make it status = disabled.

-- 
regards,
Stan

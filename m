Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76211C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 08:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46A3A20881
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 08:33:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="g6gIniAT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbfA1IdE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 03:33:04 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35253 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbfA1IdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 03:33:03 -0500
Received: by mail-wm1-f67.google.com with SMTP id t200so12941620wmt.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 00:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TMGf9RSmS6cVngD+QMX5KaapcUOQZokd+oMFA3JcxDY=;
        b=g6gIniATiDadeYP0NJ6Zjei0v3/WBlJweUV6YVWgEWYMp+oNnTkcv7F7/MRGKC2spb
         ipSgmfRnxpifxrjSyTIYJYT9hpdi+/rKts4G19Jh3F7eIIJV2VG+ofIuXA03C/tImdv5
         MoA37gh0W0tq50j+I3ISkFpXrhadt00+G4GyU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TMGf9RSmS6cVngD+QMX5KaapcUOQZokd+oMFA3JcxDY=;
        b=UeNTTridhZ3HCgLu/tAieTUs4+XlxrHLoSMnF8GimUjFq6YYvDSusB7w2lZsxv2Zcs
         tgD6kGGkQJlyQ6PBTO3krtAMrIPhs2l1C0edlyLTqQt06eEHTnAUGr7DMVYlrp4+ujTv
         YZVmE07oj3H6Fez0l1XNjBLhnz29tx4jBKUpMAOSkMcIJm9Di009L6soFtNk5qUBwuTW
         Tv+sXJ/zi/CMElnNLPDIQcEkfywjH9O4f8D/02rtwrPzp11jtYsGB4MCeluiOMgM66Ob
         B/mBg1WpCA3GKKi2Zc/VAUG+k/60i7b7yRJIuSkNbFl/RT3JvxYiaIKkHOZKIQTZE61y
         DYig==
X-Gm-Message-State: AJcUukdbHqh6EG855nKvkHnmJY69HDLBeYCCBQHVdUAyK73GgLazX6GI
        HAMLYnl3/4hljUXDCqic1+J9YA==
X-Google-Smtp-Source: AHgI3IZG5ofnaVURj9ZggrfGEMFTblYyfYKVuxfJ2SSPXwb6vXZabq3moeBiTEtjjqccc8z4jYjqxA==
X-Received: by 2002:a1c:488b:: with SMTP id v133mr6524469wma.31.1548664381376;
        Mon, 28 Jan 2019 00:33:01 -0800 (PST)
Received: from [192.168.0.41] (20.36.129.77.rev.sfr.net. [77.129.36.20])
        by smtp.googlemail.com with ESMTPSA id l20sm244726694wrb.93.2019.01.28.00.32.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 00:33:00 -0800 (PST)
Subject: Re: [PATCH v4 3/9] cpufreq: qcom-hw: Register as a cpufreq cooling
 device
To:     Amit Kucheria <amit.kucheria@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, viresh.kumar@linaro.org,
        edubezval@gmail.com, swboyd@chromium.org, dianders@chromium.org,
        mka@chromium.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Taniya Das <tdas@codeaurora.org>, linux-pm@vger.kernel.org
References: <cover.1548654899.git.amit.kucheria@linaro.org>
 <65d7297bbf98fd525d3785f2e8eb5a412ffd3a6b.1548654899.git.amit.kucheria@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <36e00871-46c5-3c55-5a47-904a2796e4d4@linaro.org>
Date:   Mon, 28 Jan 2019 09:32:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <65d7297bbf98fd525d3785f2e8eb5a412ffd3a6b.1548654899.git.amit.kucheria@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/01/2019 07:41, Amit Kucheria wrote:
> Add the CPUFREQ_AUTO_REGISTER_COOLING_DEV flag to allow the cpufreq core
> to auto-register the driver as a cooling device.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> Tested-by: Matthias Kaehlcke <mka@chromium.org>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>  drivers/cpufreq/qcom-cpufreq-hw.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> index d83939a1b3d4..ed32849a3d40 100644
> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> @@ -231,7 +231,8 @@ static struct freq_attr *qcom_cpufreq_hw_attr[] = {
>  
>  static struct cpufreq_driver cpufreq_qcom_hw_driver = {
>  	.flags		= CPUFREQ_STICKY | CPUFREQ_NEED_INITIAL_FREQ_CHECK |
> -			  CPUFREQ_HAVE_GOVERNOR_PER_POLICY,
> +			  CPUFREQ_HAVE_GOVERNOR_PER_POLICY |
> +			  CPUFREQ_AUTO_REGISTER_COOLING_DEV,
>  	.verify		= cpufreq_generic_frequency_table_verify,
>  	.target_index	= qcom_cpufreq_hw_target_index,
>  	.get		= qcom_cpufreq_hw_get,
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


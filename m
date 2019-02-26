Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F67EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 08:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D5DF2173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 08:56:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U0xZpIty"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbfBZI4w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 03:56:52 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51396 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726866AbfBZI4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 03:56:51 -0500
Received: by mail-wm1-f67.google.com with SMTP id n19so1531008wmi.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 00:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1reYrhlaAuB4eo3CMe90jJ9SMBi76XHEt328qbtS2o0=;
        b=U0xZpIty2vw342ISfjJMYZNl5trB5gZHV5e16G+2xUBkoy5Qswd8JCPOxBoF1j1tBI
         uLP0xkQvWgXYNT8HNEugXfppkLfabkXkoFbDyboX3yByBxsYlFeCtZA42COyd0pxZqlo
         tglwMf9Lo8FMwEmYefHN2x3KTVFouRJ4HhpGGtv5jyu41kHkDzOW0qQwi6We249R8MYT
         0dToBkZvbNL11kl5Kedt4UaxrWscnjn+NQdwg0oBZmBtGwj+uRTuJ6iqQDsJ/JKZfP8z
         7dL5hpnZEFrvFnuXFkjoR13CWQ5kafC/gY3w0/w0mRW1jRDe0iWWq13f6JV0sVfjkm4Z
         T++g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1reYrhlaAuB4eo3CMe90jJ9SMBi76XHEt328qbtS2o0=;
        b=i7FEIUABMPtE8Kyfr9T3O6JO4a188eKo4DiBemsJtO0ec3C7v8X3n8B6SfYMr3GtPr
         Vl9LNGT+TXRrA1S4QgD6vbYUGj0mgtmgD62n0iP73NQEOayvN0D0Loh/dSWOPiLnJ/Xt
         4gYa6z168M5Oz4EEovxlSqw0Ox15NVwmvbZi+KA05QsRyRHGy9yu0GavrL0rAvuSOIs6
         2v8GUaHiaq9Au6Xr6hoa40zkCXDQxM4hidAss/6mmyBXrV0IhZf76Rrqsd3+bSELfBEN
         eJS0m+08aPKbHoFYVWeTifCHSCvXV4A1KjiFIwoqgx3Q2NZsbliGAzxoEgSozbXKf+Ft
         lhIg==
X-Gm-Message-State: AHQUAuag/VL4jqypkps1Wx0expoXKzww673LqpMCLS68RGAYmBY38kIh
        DXFF4YZ1wcBwoQvw/PbpfgGWo2XWjso=
X-Google-Smtp-Source: AHgI3IbztN5TTPKvoJKrezYf0pyZmwx0XrTnMRUvnH3tfwse+u0Z5qwU+hZRu6BuuQCxyVSNxywKYg==
X-Received: by 2002:a1c:4c1a:: with SMTP id z26mr1874534wmf.139.1551171409865;
        Tue, 26 Feb 2019 00:56:49 -0800 (PST)
Received: from [192.168.28.130] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id v10sm5464808wrn.26.2019.02.26.00.56.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 00:56:49 -0800 (PST)
Subject: Re: [PATCH] media: venus: core: fix max load for msm8996 and sdm845
To:     Alexandre Courbot <acourbot@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20190226081746.73667-1-acourbot@chromium.org>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <0fffb277-9f32-8dfd-6f47-255c4ef13f48@linaro.org>
Date:   Tue, 26 Feb 2019 10:56:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190226081746.73667-1-acourbot@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

Thanks for the fix, and I'm sorry for the typo.

On 2/26/19 10:17 AM, Alexandre Courbot wrote:
> Patch commit de5a0bafcfc4 ("media: venus: core: correct maximum hardware
> load for sdm845") meant to increase the maximum hardware load for sdm845,
> but ended up changing the one for msm8996 instead.
> 
> Fixes: de5a0bafcfc4 ("media: venus: core: correct maximum hardware load for sdm845")
> 
> Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
> ---
>  drivers/media/platform/qcom/venus/core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>

> 
> diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
> index 739366744e0f..435c7b68bbed 100644
> --- a/drivers/media/platform/qcom/venus/core.c
> +++ b/drivers/media/platform/qcom/venus/core.c
> @@ -455,7 +455,7 @@ static const struct venus_resources msm8996_res = {
>  	.reg_tbl_size = ARRAY_SIZE(msm8996_reg_preset),
>  	.clks = {"core", "iface", "bus", "mbus" },
>  	.clks_num = 4,
> -	.max_load = 3110400,	/* 4096x2160@90 */
> +	.max_load = 2563200,
>  	.hfi_version = HFI_VERSION_3XX,
>  	.vmem_id = VIDC_RESOURCE_NONE,
>  	.vmem_size = 0,
> @@ -478,7 +478,7 @@ static const struct venus_resources sdm845_res = {
>  	.freq_tbl_size = ARRAY_SIZE(sdm845_freq_table),
>  	.clks = {"core", "iface", "bus" },
>  	.clks_num = 3,
> -	.max_load = 2563200,
> +	.max_load = 3110400,	/* 4096x2160@90 */
>  	.hfi_version = HFI_VERSION_4XX,
>  	.vmem_id = VIDC_RESOURCE_NONE,
>  	.vmem_size = 0,
> 

-- 
regards,
Stan

Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B53F6C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 12:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59B7420874
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 12:11:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gXd5Dw11"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59B7420874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937789AbeFSMLk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 08:11:40 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:52861 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937592AbeFSMLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 08:11:38 -0400
Received: by mail-wm0-f66.google.com with SMTP id p126-v6so19554683wmb.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 05:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aqaf8otg4vLRgN5BG+gsOgs6gpaZrrOA4CX+O+8j0mU=;
        b=gXd5Dw115k4yuO7MOdaiYoTIur2FB06MuORvys8M/vopJdBCgDaWZuf8YhPjMBaBHh
         5557qjP16NYMQOw5FQArG3R4S8/25F4rIPtP+Q9OXYgc7eDqRrtsxn3/XrHub1eay95l
         92YkGeIPuw2jT2ub9CoC3uY9KcnL270hTvVvA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aqaf8otg4vLRgN5BG+gsOgs6gpaZrrOA4CX+O+8j0mU=;
        b=VLPekAy/8nPu2BtHXh+El36hFquK5rB1wRwvxT7BJpo1HFwY5B8amqDxYPNW1T3/VL
         nPDGZ5xMnGpCLYaWZaZV5VsuVSFexN/D9dO2ygf/kO162XzskpDF2al/s6coHMyUoxmt
         zTwZNQ/WthcuzcTxiBOQYSsQSYE3x900K30QytO/9W9HgVYETQ4Y4mUKSyWP1dz227fI
         Iz7yG7qSXkyL3nKQc28fgKKZVJPJYNwsiPvj63EDkb+2P9AY0VQFGTVYZfcRWaYjslJp
         Cnobuu8i8SZzCYtDJINn8pTjE2lSy06eMX0qY/W1IYPDBLAT/zqqA+xDOR0by7+VTJKo
         4/pA==
X-Gm-Message-State: APt69E0KiuoWP70Ag5p8lCPeyoTGaWxeBIzppdM+PE7L2s9L1a357cZw
        /ipDArK2Z7+nCgHi9h+YwoJY0Q==
X-Google-Smtp-Source: ADUXVKKtJeJ6T8YdQkFUGQPjd9FVB3UydwmqlsNo43/XlZEUBZFLfNUK7hHYMYlFADrm5zX1+2cwkA==
X-Received: by 2002:a1c:8b52:: with SMTP id n79-v6mr11425526wmd.148.1529410297328;
        Tue, 19 Jun 2018 05:11:37 -0700 (PDT)
Received: from [192.168.27.209] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id t14-v6sm21091187wrm.79.2018.06.19.05.11.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 05:11:36 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] hwrng: msm - Add support for prng v2
To:     Vinod Koul <vinod.koul@linaro.org>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        Vinod Koul <vkoul@kernel.org>
References: <20180619095430.26358-1-vkoul@kernel.org>
 <20180619095430.26358-3-vkoul@kernel.org>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <b7543a73-e35a-c015-3bba-1e3ab3a389d5@linaro.org>
Date:   Tue, 19 Jun 2018 15:11:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180619095430.26358-3-vkoul@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod,

On 06/19/2018 12:54 PM, Vinod Koul wrote:
> Qcom 8996 and later chips support prng v2 which requires to
> implement only .read callback for hwrng.
> 
> This version of chip has multiple Execution Environments (EE) and
> secure world is typically responsible for configuring the prng.
> 
> Add driver data for qcom,prng as 0 and qcom,prng-v2 as 1 and use
> that to skip initialization and cleanup routines.
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>  drivers/char/hw_random/msm-rng.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/char/hw_random/msm-rng.c b/drivers/char/hw_random/msm-rng.c
> index 841fee845ec9..4676520e1f16 100644
> --- a/drivers/char/hw_random/msm-rng.c
> +++ b/drivers/char/hw_random/msm-rng.c
> @@ -17,6 +17,7 @@
>  #include <linux/io.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> +#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  
>  /* Device specific register offsets */
> @@ -131,6 +132,7 @@ static int msm_rng_probe(struct platform_device *pdev)
>  {
>  	struct resource *res;
>  	struct msm_rng *rng;
> +	unsigned int skip_init;
>  	int ret;
>  
>  	rng = devm_kzalloc(&pdev->dev, sizeof(*rng), GFP_KERNEL);
> @@ -149,9 +151,12 @@ static int msm_rng_probe(struct platform_device *pdev)
>  		return PTR_ERR(rng->clk);
>  
>  	rng->hwrng.name = KBUILD_MODNAME,
> -	rng->hwrng.init = msm_rng_init,
> -	rng->hwrng.cleanup = msm_rng_cleanup,
> -	rng->hwrng.read = msm_rng_read,
> +	rng->hwrng.read = msm_rng_read;
> +	skip_init = (unsigned long)of_device_get_match_data(&pdev->dev);

skip_init is unsigned int, despite I think you don't need to cast it.

> +	if (!skip_init) {
> +		rng->hwrng.init = msm_rng_init;
> +		rng->hwrng.cleanup = msm_rng_cleanup;
> +	}
>  
>  	ret = devm_hwrng_register(&pdev->dev, &rng->hwrng);
>  	if (ret) {
> @@ -163,7 +168,8 @@ static int msm_rng_probe(struct platform_device *pdev)
>  }
>  
>  static const struct of_device_id msm_rng_of_match[] = {
> -	{ .compatible = "qcom,prng", },
> +	{ .compatible = "qcom,prng", .data = (void *)0},
> +	{ .compatible = "qcom,prng-v2", .data = (void *)1},

No need to cast. IMO it'd be better to create defines for these numbers:

#define PRNG_V1	0
#define PRNG_V2	1


-- 
regards,
Stan

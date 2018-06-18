Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 165C1C5AE59
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 18:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BACB32075A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 18:21:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IMFMHcKw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BACB32075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935857AbeFRSV3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 14:21:29 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:38347 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935744AbeFRSV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 14:21:27 -0400
Received: by mail-pg0-f67.google.com with SMTP id c9-v6so7904591pgf.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 11:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XKF+1rlkUR2VkIsqXpnZ7spkhmjc0ANekSWfF6SmwDY=;
        b=IMFMHcKwAzCIy3hYEatIIQTMiW+fqhs/SQjxg0DwuNY157r5hz2eZKCEi49FL6Xoug
         DDv0kWmuewitQSWMGspb5BGPzkEJMcg8B90ehJuChUq8VIeWkWnucC3gIgz+urtzQt+I
         hTwhjXmNTVj21VkpjixnDElfuiHhbFCowAx7s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XKF+1rlkUR2VkIsqXpnZ7spkhmjc0ANekSWfF6SmwDY=;
        b=Wkohf3+4Oe48dF4x17X48tq8MzFMhf6zXhR05/IvylyXs839VrVkvkCC9gyc+IodYq
         3IYlsFQEieWPNW72IXFJsFZmthWay0S6T/RQas3XU4Y9082ghdKrTOautLecz8jDv8cC
         oD9yy96ltlyYxlmUtoc+ZFJXywgk0fVrgQvuoJM+ZG04Zbh4lmB0LRffIQsRqcQ+3DZ1
         q0u+sdY2OvRhY8WUrdPBtFodpoFq58TLgM5LRhYdDep44VFhnZQMAxyxFI3bKbPuzPzi
         QJd1rIiw5stemAHbWmgKrCW76NrOepXlyxo7bXB/qwYT+PiAcQEazDLAkQYwQu/dgSzR
         dhuw==
X-Gm-Message-State: APt69E0OtmOw0kL+UUVZcIXTk5wyXidnPF3WXO1fBV4xPlYpEdJgVKvr
        7FdfALViPvn2Fy/t4oG6NMiXAQ==
X-Google-Smtp-Source: ADUXVKLJz9j0EBDzxOnvEYxKy+fHzk1NQhZxKef64H3FKRNGqqv/71C+tfLA63XDmDKhLRg0/DAZfQ==
X-Received: by 2002:a63:a809:: with SMTP id o9-v6mr12236340pgf.313.1529346086528;
        Mon, 18 Jun 2018 11:21:26 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id p12-v6sm27109742pfi.175.2018.06.18.11.21.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Jun 2018 11:21:25 -0700 (PDT)
Date:   Mon, 18 Jun 2018 11:21:23 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Vinod Koul <vinod.koul@linaro.org>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH 3/3] hwrng: msm - Add support for prng v2
Message-ID: <20180618182123.GT14924@minitux>
References: <20180618141259.23141-1-vkoul@kernel.org>
 <20180618141259.23141-4-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180618141259.23141-4-vkoul@kernel.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 18 Jun 07:12 PDT 2018, Vinod Koul wrote:

> Qcom 8996 and later chips support prng v2 where we need to only
> implement .read callback for hwrng.
> 

The hardware still needs initialization, so I think you should expand
this to mention that the initialization is moved to secure world and
that's the reason why we only implement read.

The question is what happens in projects with other security models.

> Add a new table for v2 which supports this and get version required for
> driver data.
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>  drivers/char/hw_random/msm-rng.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/hw_random/msm-rng.c b/drivers/char/hw_random/msm-rng.c
> index 7644474035e5..3f509072a6c6 100644
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
> @@ -132,10 +133,16 @@ static struct hwrng msm_rng = {
>  	.read = msm_rng_read,
>  };
>  
> +static struct hwrng msm_rng_v2 = {
> +	.name = KBUILD_MODNAME,
> +	.read = msm_rng_read,
> +};
> +
>  static int msm_rng_probe(struct platform_device *pdev)
>  {
>  	struct resource *res;
>  	struct msm_rng *rng;
> +	unsigned int version;
>  	int ret;
>  
>  	rng = devm_kzalloc(&pdev->dev, sizeof(*rng), GFP_KERNEL);
> @@ -154,6 +161,9 @@ static int msm_rng_probe(struct platform_device *pdev)
>  		return PTR_ERR(rng->clk);
>  
>  	rng->hwrng = &msm_rng;
> +	version = (unsigned long)of_device_get_match_data(&pdev->dev);

If this is "version" then please make it 1 or 2, if you agree with
Stephen's suggestion of omitting the initialization of init I think this
would be better as 0/1 and the variable named "skip_init".

> +	if (version)
> +		rng->hwrng = &msm_rng_v2;
>  
>  	rng->hwrng->priv = (unsigned long)rng;
>  	ret = devm_hwrng_register(&pdev->dev, rng->hwrng);
> @@ -166,7 +176,8 @@ static int msm_rng_probe(struct platform_device *pdev)
>  }
>  
>  static const struct of_device_id msm_rng_of_match[] = {
> -	{ .compatible = "qcom,prng", },
> +	{ .compatible = "qcom,prng", .data = (void *)0},
> +	{ .compatible = "qcom,prng-v2", .data = (void *)1},
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, msm_rng_of_match);

Regards,
Bjorn

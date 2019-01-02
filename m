Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 555CCC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 03:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F55921871
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 03:33:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hZwgecIl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728427AbfABDdu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 22:33:50 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45001 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728342AbfABDdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 22:33:49 -0500
Received: by mail-pl1-f196.google.com with SMTP id e11so13962802plt.11
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jan 2019 19:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uq5CYdN4rpYlcA9vGoLlFxweuR+uctIjkUvsg7EqyaA=;
        b=hZwgecIlOv9roDEUV/gxWGCVf/idSzltEVQWnMeguWjJZjVwRSDLzMpXIormXp4pU8
         UxEJ9f9sBGxo2E3g9ckGqLLaRgq+4XcLMV7WWR+zH5vWYE9tcsIvY2u86lk3oc+GO7Y/
         t4/eOA+Bqlyw2ZIZtf0Bn0d8Y9VKb5zxP/sZU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uq5CYdN4rpYlcA9vGoLlFxweuR+uctIjkUvsg7EqyaA=;
        b=KC0KmcUyHFFvH43HV5rMQz/eIWcfzbuoFEP+aQ/d+kMjKSszm6tLaQusJmkMZ6s/h5
         fP5z2fMYTBosAUcdypVLD0OFpE/2e7c9Twzz98W4d7aZyMgPh5emzWLje7v6btdbWt7t
         JW/FJv0KCErVt7uuPy0A5x584gqd7Pim6m7KSliv6HyKWiv92cLYYnJD13I8X0rXyr32
         P3MwXnHZUojGFyTRj+lofm0e0rpOAPN0Z1DJL4J7A8DcIlaO5ITiIJswlV1Ac0lKCjHN
         ptPf1Rs6+sGOD5jFkb1SfW+vjeqfjH7MbfkpPBq5Rs9PsxSJWwGpi2AKpkz+TYh1PJkU
         Xo3A==
X-Gm-Message-State: AJcUukfbTg33vtBOJP97pJRuObpEzyKRKHWS3MfPRtdKOO7zKAaPLiHm
        nd8Jp56S/eAU8XHSgSGPI0Qixg==
X-Google-Smtp-Source: ALg8bN5vzC9IRc+H0EVtjKBBabwvrp5F30uT9w6p3BCaUbWWB6MHNgximvhj53s4hPkMJJw0pRgdNg==
X-Received: by 2002:a17:902:2b84:: with SMTP id l4mr42226855plb.191.1546400028617;
        Tue, 01 Jan 2019 19:33:48 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id d3sm66389465pgl.64.2019.01.01.19.33.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 Jan 2019 19:33:47 -0800 (PST)
Date:   Tue, 1 Jan 2019 19:32:40 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     amit.kucheria@linaro.org, edubezval@gmail.com,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, daniel.lezcano@linaro.org
Subject: Re: [PATCH v2] thermal: tsens: qcom: do not create duplicate regmap
 debugfs entries
Message-ID: <20190102033240.GA22852@builder>
References: <20181206093917.26610-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181206093917.26610-1-srinivas.kandagatla@linaro.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 06 Dec 01:39 PST 2018, Srinivas Kandagatla wrote:

> Regmap would use device name to create debugfs entries. If the device
> has multiple regmaps it is recommended to use name field in regmap_config.
> Fix this by providing name to the regmap configs correctly.
> 
> Without this patch we would see below error on DB820c.
> 
> qcom-tsens 4a9000.thermal-sensor: Failed to create 4a9000.thermal-sensor
> debugfs directory
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Acked-by: Amit Kucheria <amit.kucheria@linaro.org>
> Tested-by: Amit Kucheria <amit.kucheria@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
> Changes since v1:
>  -rename tsens_config to tsens_tm_config as suggested by Amit.
> 
>  drivers/thermal/qcom/tsens-common.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
> index 3be4be2e0465..ddfdf88ffb4e 100644
> --- a/drivers/thermal/qcom/tsens-common.c
> +++ b/drivers/thermal/qcom/tsens-common.c
> @@ -113,7 +113,15 @@ int get_temp_common(struct tsens_device *tmdev, int id, int *temp)
>  	return 0;
>  }
>  
> -static const struct regmap_config tsens_config = {
> +static const struct regmap_config tsens_tm_config = {
> +	.name		= "tm",
> +	.reg_bits	= 32,
> +	.val_bits	= 32,
> +	.reg_stride	= 4,
> +};
> +
> +static const struct regmap_config tsens_srot_config = {
> +	.name		= "srot",
>  	.reg_bits	= 32,
>  	.val_bits	= 32,
>  	.reg_stride	= 4,
> @@ -139,8 +147,8 @@ int __init init_common(struct tsens_device *tmdev)
>  		if (IS_ERR(srot_base))
>  			return PTR_ERR(srot_base);
>  
> -		tmdev->srot_map = devm_regmap_init_mmio(tmdev->dev,
> -							srot_base, &tsens_config);
> +		tmdev->srot_map = devm_regmap_init_mmio(tmdev->dev, srot_base,
> +							&tsens_srot_config);
>  		if (IS_ERR(tmdev->srot_map))
>  			return PTR_ERR(tmdev->srot_map);
>  
> @@ -154,7 +162,8 @@ int __init init_common(struct tsens_device *tmdev)
>  	if (IS_ERR(tm_base))
>  		return PTR_ERR(tm_base);
>  
> -	tmdev->tm_map = devm_regmap_init_mmio(tmdev->dev, tm_base, &tsens_config);
> +	tmdev->tm_map = devm_regmap_init_mmio(tmdev->dev, tm_base,
> +						 &tsens_tm_config);
>  	if (IS_ERR(tmdev->tm_map))
>  		return PTR_ERR(tmdev->tm_map);
>  
> -- 
> 2.19.2
> 

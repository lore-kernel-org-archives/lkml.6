Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55AA9C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 01:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D21521738
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 01:17:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KXGgjemT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727725AbfBTBRX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 20:17:23 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44865 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbfBTBRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 20:17:23 -0500
Received: by mail-pg1-f196.google.com with SMTP id y1so10968436pgk.11;
        Tue, 19 Feb 2019 17:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KXiFe4c4tdBC2TbAFxFsyMmT5j8GVM3q9ybo5Xp+Brc=;
        b=KXGgjemT0NzDUAaH4KaDXIhTDdc2CPIBUgsH0DBUBrhwUoTH7Ne1gJv0WkiUqmyODZ
         iUZ56BHVgPfPFK2f/UuIdqn3UxlNrmhunzkBFLA8TGw6xLoUFWZhVTlhamAgiWvHKvs4
         rW6wjib/sJRoIpbyEyMjHbXSIuhPJuh0jojhgbB/d6IrC7XNifJRX9H8zBwRuSkKxlhX
         zcPuDKjzvNvjJZw++r4KZbC+/tJNl+qIuuhtGZlWTwvLQukd4tGgHuekl33PJE/LflCd
         wjX5d1dgYPPaRroNObNdWZXawjPpr9NLGQWb295ljfO5mMDAHJaWORsfBRWNk31/3P3x
         0y/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KXiFe4c4tdBC2TbAFxFsyMmT5j8GVM3q9ybo5Xp+Brc=;
        b=VHrue/0JE5I4rSjVMk/2BjvECVJr4u5+FEceu7EnTS3OKlMrCleqjo054A4IwzQ57P
         pB64hLCz2as4fFjg8G2EeV7EdX3u8Iby/qa3n/NpAv/2ENXHIVzEECdAPDflVCqNqmrJ
         KOg6IqAgiTRX8yUyg0Bz7dO2IMV/Hrgw3AxnwNEcYTozhgtDXwx4w4EcjxWKUXYtawLI
         /bLCgFEev0RH8MAdpteVifIaabHYYsHMYVJRuqwYJQ5Smlr+0ceea3rD1766BL6/LzP5
         zuEFRULhjAA5D5GdEc95qOCJKIS8PckloDcEK9q6ZfKRG3qDNMBrPOqfsoaviD7xoAG4
         3WGw==
X-Gm-Message-State: AHQUAubf0q0pRdE0kUfOLAM91X2bAxGlq3uhyjbNEiiFy2XgxcmNlNXu
        T38n9TPRKOLMaFX8zF9OHQpnFv9J
X-Google-Smtp-Source: AHgI3IaNvAA3mIgCkirvDgN0nPw06UsonQijE6q/8mefaNqfrn0UODwjhB/4C3fB9aLdmkQmgVSI8w==
X-Received: by 2002:a63:2682:: with SMTP id m124mr25383596pgm.35.1550625442540;
        Tue, 19 Feb 2019 17:17:22 -0800 (PST)
Received: from localhost.localdomain ([2601:644:8201:32e0:7256:81ff:febd:926d])
        by smtp.gmail.com with ESMTPSA id n19sm38865978pfg.67.2019.02.19.17.17.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Feb 2019 17:17:21 -0800 (PST)
Date:   Tue, 19 Feb 2019 17:17:19 -0800
From:   Eduardo Valentin <edubezval@gmail.com>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, andy.gross@linaro.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v1 13/24] drivers: thermal: tsens: Print IP version
Message-ID: <20190220011718.GD2811@localhost.localdomain>
References: <cover.1549525708.git.amit.kucheria@linaro.org>
 <ab6dd34ce0236de12ec1e9984931780c3df643f9.1549525708.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab6dd34ce0236de12ec1e9984931780c3df643f9.1549525708.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2019 at 04:19:31PM +0530, Amit Kucheria wrote:
> On some TSENS IP, version is stored. Print that version at init.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  drivers/thermal/qcom/tsens-common.c | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
> index aae3d71d7eed..39cd5733fd44 100644
> --- a/drivers/thermal/qcom/tsens-common.c
> +++ b/drivers/thermal/qcom/tsens-common.c
> @@ -121,7 +121,7 @@ int __init init_common(struct tsens_priv *priv)
>  	void __iomem *tm_base, *srot_base;
>  	struct device *dev = priv->dev;
>  	struct resource *res;
> -	u32 enabled;
> +	u32 enabled, maj_ver, min_ver;
>  	int ret, i, j;
>  	struct platform_device *op = of_find_device_by_node(priv->dev->of_node);
>  
> @@ -155,6 +155,27 @@ int __init init_common(struct tsens_priv *priv)
>  	if (IS_ERR(priv->tm_map))
>  		return PTR_ERR(priv->tm_map);
>  
> +	for (i = 0; i < MAX_REGFIELDS; i++) {
> +		priv->rf[i] = NULL;
> +	}
> +
> +	/* alloc regmap_fields in srot_map */
> +	if (priv->feat->ver_info) {
> +		for (i = 0, j = VER_MAJOR; i < 2; i++, j++) {
> +			priv->rf[j] = devm_regmap_field_alloc(dev, priv->srot_map,
> +							      priv->fields[j]);
> +			if (IS_ERR(priv->rf[j]))
> +				return PTR_ERR(priv->rf[j]);
> +		}
> +		ret = regmap_field_read(priv->rf[VER_MAJOR], &maj_ver);
> +		if (ret)
> +			return ret;
> +		ret = regmap_field_read(priv->rf[VER_MINOR], &min_ver);
> +		if (ret)
> +			return ret;
> +		dev_info(dev, "version: %d.%d\n", maj_ver, min_ver);

Is this really needed? Printing stuff into kernel log during boot can
just add a lot of info that ends up just slowing down things. Besides,
if this info is important shouldnt be available somewhere else as the
kernel log is a circular buffer and eventually that line will get
wrapped up?

> +	}
> +
>  	priv->rf[TSENS_EN] = devm_regmap_field_alloc(dev, priv->srot_map,
>  						     priv->fields[TSENS_EN]);
>  	if (IS_ERR(priv->rf[TSENS_EN]))
> -- 
> 2.17.1
> 

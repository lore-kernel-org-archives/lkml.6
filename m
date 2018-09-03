Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F198CC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 20:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91B2020867
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 20:54:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EnzlnWN6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91B2020867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727493AbeIDBQL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 21:16:11 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44653 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727199AbeIDBQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 21:16:11 -0400
Received: by mail-pl1-f195.google.com with SMTP id ba4-v6so588663plb.11
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 13:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=N7U77cmztyami7gnuJsqb415pXO5tpq5xA5PS7jyeAs=;
        b=EnzlnWN6Htbno+c826xFEEGS48/YIzKkVXR8JMpG+eszCMYzd9MUbp9rjHKtSSY/ij
         fxXeXsi8Potv7DD/Ipziu6s8duh73mmzVKF95iNsPqRQ1XRgkAhjUQXcZFR60HyVuvab
         xHikNpATONAQyB1jRKPea33RqXYXX+g1eMbRI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=N7U77cmztyami7gnuJsqb415pXO5tpq5xA5PS7jyeAs=;
        b=D0HKEbKnCgSuB6t6NB91H8GZf+973XSGZGXLF5T5D66tu0XwFXluJ3EeKwQUhBB83x
         eQJV6C8mUAJDtUQAtr7M0HEwLAUz4I2GDJU1CTQbPG9vtKNODVOD+yMPIb1AVZKi8+I5
         4XprI9aUgn40+OcGdhPB0U6+Ust0qZmA6RGrxr/kWbd6kLL+Rp9Kiv7bVsjIlepNEWRB
         eeBIwpsGes/9K7f3nYhsdtOYByXw/uxnTncuFA8GB4UDqo1dn9bWjqaQejn5CahMiDW0
         bFSRFl4PbFLX444eKzDQIcdg2/IOp35ilBdE2NuR+pnK4K05QH8kvpheFBK/eBItXX6+
         xUow==
X-Gm-Message-State: APzg51BgU0TYL1VXfptW5QROfM0nHq6pC4YvHgm9yt2coeBaSOeSxhu4
        GtWu4lih+s/X4NgfKG8pGUa3pA==
X-Google-Smtp-Source: ANB0VdYUctif3ZxNyZs/CPOocN5RXmERhMStHICRabEbhAKAFHuiqNOUI01oM2QThkpXYmcPdLJlIQ==
X-Received: by 2002:a17:902:9a8a:: with SMTP id w10-v6mr29719195plp.14.1536008055199;
        Mon, 03 Sep 2018 13:54:15 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id v20-v6sm42086104pfk.12.2018.09.03.13.54.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Sep 2018 13:54:14 -0700 (PDT)
Date:   Mon, 3 Sep 2018 13:58:09 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH] pinctrl: qcom: spmi-mpp: Fix drive strength setting
Message-ID: <20180903205809.GC1437@tuxbook-pro>
References: <20180831005852.156465-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180831005852.156465-1-swboyd@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 30 Aug 17:58 PDT 2018, Stephen Boyd wrote:

> It looks like we parse the drive strength setting here, but never
> actually write it into the hardware to update it. Parse the setting and
> then write it at the end of the pinconf setting function so that it
> actually sticks in the hardware.
> 
> Fixes: 0e948042c420 ("pinctrl: qcom: spmi-mpp: Implement support for sink mode")
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Doug Anderson <dianders@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/pinctrl/qcom/pinctrl-spmi-mpp.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pinctrl/qcom/pinctrl-spmi-mpp.c b/drivers/pinctrl/qcom/pinctrl-spmi-mpp.c
> index 6556dbeae65e..1793a4d05e15 100644
> --- a/drivers/pinctrl/qcom/pinctrl-spmi-mpp.c
> +++ b/drivers/pinctrl/qcom/pinctrl-spmi-mpp.c
> @@ -455,7 +455,7 @@ static int pmic_mpp_config_set(struct pinctrl_dev *pctldev, unsigned int pin,
>  			pad->dtest = arg;
>  			break;
>  		case PIN_CONFIG_DRIVE_STRENGTH:
> -			arg = pad->drive_strength;
> +			pad->drive_strength = arg;
>  			break;
>  		case PMIC_MPP_CONF_AMUX_ROUTE:
>  			if (arg >= PMIC_MPP_AMUX_ROUTE_ABUS4)
> @@ -502,6 +502,10 @@ static int pmic_mpp_config_set(struct pinctrl_dev *pctldev, unsigned int pin,
>  	if (ret < 0)
>  		return ret;
>  
> +	ret = pmic_mpp_write(state, pad, PMIC_MPP_REG_SINK_CTL, pad->drive_strength);
> +	if (ret < 0)
> +		return ret;
> +
>  	val = pad->is_enabled << PMIC_MPP_REG_MASTER_EN_SHIFT;
>  
>  	return pmic_mpp_write(state, pad, PMIC_MPP_REG_EN_CTL, val);
> -- 
> Sent by a computer through tubes
> 

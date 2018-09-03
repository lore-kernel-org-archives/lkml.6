Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4831EC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 21:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B74CB20652
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 21:00:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AmZUHt5Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B74CB20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727580AbeIDBWL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 21:22:11 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37158 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727368AbeIDBWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 21:22:11 -0400
Received: by mail-pl1-f194.google.com with SMTP id f1-v6so608093plt.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 14:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mikqNWhTavbhpBYosw0lFS9K7b3Nn/SLF6u2apzMKwE=;
        b=AmZUHt5ZztTZwX+JOdraVGfkJjoxiDXe+hFF/7fmPwASghwi1SWmSAjw7ZXXrc1Cv0
         653BJyUENEzPJjczsn0HiIemyH75QHicDTOg1Bv7Y17mOpb8EseF3CKEoT9ZR4nAai+X
         Vk3oYmVdHLUjLhHNovpfCWivdSLq8WIP2294Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mikqNWhTavbhpBYosw0lFS9K7b3Nn/SLF6u2apzMKwE=;
        b=NJE1G8XElZRVPsoxQw8V00J1khFvhMBIJLGSpCk3F7qPWXCetGqqNGh/5THJqXGgql
         7EN4q1NL+8acd4c/5cB7FtVmdH7Jo/k31op4h/aVLInxQUfsRd+Rcab+Om809TTRDLyX
         GmGFizY55HJZQWf7uOi2MX1JP7C887N3bXso4w37rmCt5B4NU3mj6hUbtwExxoP+pkA+
         fPBcST0zTqZcsopciCGNcMEKVNsYo8yrf5/DoOgQIfV3wo1CvtjdXOfvMpVEEOKx7mTF
         MYlKc7Wb1oe0vtb3Pn1EXzaTI1MdJ2ddxVQwmIWTQsOg7PQ41Avp06bSfi9rXMh/Vrxt
         yjzA==
X-Gm-Message-State: APzg51DPHCNmkt7WAV4kQKBuAPjZ8GuJqn1AaOY4UC4k9fF+q2QRs8Gs
        NLZ7zKTJBgN2heWQ6RHa3aBenA==
X-Google-Smtp-Source: ANB0VdYiDvsHBeyXsyCBS16CMnHkpjmn7GZXzvqCSv9oh1Hx6JxPGCwmYmd1+931tK5hyNbG8aKHzQ==
X-Received: by 2002:a17:902:b78a:: with SMTP id e10-v6mr30646835pls.79.1536008413940;
        Mon, 03 Sep 2018 14:00:13 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id b21-v6sm34471352pfe.148.2018.09.03.14.00.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Sep 2018 14:00:13 -0700 (PDT)
Date:   Mon, 3 Sep 2018 14:04:07 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "Ivan T . Ivanov" <iivanov@mm-sol.com>,
        Stephen Boyd <swboyd@chromium.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [RFT PATCH 2/2] pinctrl: spmi-mpp: Fix pmic_mpp_config_get() to
 be compliant
Message-ID: <20180903210407.GE1437@tuxbook-pro>
References: <20180830152340.242249-1-dianders@chromium.org>
 <20180830152340.242249-3-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180830152340.242249-3-dianders@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 30 Aug 08:23 PDT 2018, Douglas Anderson wrote:

> If you look at "pinconf-groups" in debugfs for ssbi-mpp you'll notice
> it looks like nonsense.
> 
> The problem is fairly well described in commit 1cf86bc21257 ("pinctrl:
> qcom: spmi-gpio: Fix pmic_gpio_config_get() to be compliant") and
> commit 05e0c828955c ("pinctrl: msm: Fix msm_config_group_get() to be
> compliant"), but it was pointed out that ssbi-mpp has the same
> problem.  Let's fix it there too.
> 
> NOTE: in case it's helpful to someone reading this, the way to tell
> whether to do the -EINVAL or not is to look at the PCONFDUMP for a
> given attribute.  If the last element (has_arg) is false then you need
> to do the -EINVAL trick.
> 
> ALSO NOTE: it seems unlikely that the values returned when we try to
> get PIN_CONFIG_BIAS_PULL_UP will actually be printed since "has_arg"
> is false for that one, but I guess it's still fine to return different
> values so I kept doing that.  It seems like another driver (ssbi-gpio)
> uses a custom attribute (PM8XXX_QCOM_PULL_UP_STRENGTH) for something
> similar so maybe a future change should do that here too.
> 
> Fixes: cfb24f6ebd38 ("pinctrl: Qualcomm SPMI PMIC MPP pin controller driver")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
> 
>  drivers/pinctrl/qcom/pinctrl-spmi-mpp.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pinctrl/qcom/pinctrl-spmi-mpp.c b/drivers/pinctrl/qcom/pinctrl-spmi-mpp.c
> index 6556dbeae65e..ce2950ffd525 100644
> --- a/drivers/pinctrl/qcom/pinctrl-spmi-mpp.c
> +++ b/drivers/pinctrl/qcom/pinctrl-spmi-mpp.c
> @@ -343,13 +343,12 @@ static int pmic_mpp_config_get(struct pinctrl_dev *pctldev,
>  
>  	switch (param) {
>  	case PIN_CONFIG_BIAS_DISABLE:
> -		arg = pad->pullup == PMIC_MPP_PULL_UP_OPEN;
> +		if (pad->pullup != PMIC_MPP_PULL_UP_OPEN)
> +			return -EINVAL;
> +		arg = 1;
>  		break;
>  	case PIN_CONFIG_BIAS_PULL_UP:
>  		switch (pad->pullup) {
> -		case PMIC_MPP_PULL_UP_OPEN:
> -			arg = 0;
> -			break;
>  		case PMIC_MPP_PULL_UP_0P6KOHM:
>  			arg = 600;
>  			break;
> @@ -364,13 +363,17 @@ static int pmic_mpp_config_get(struct pinctrl_dev *pctldev,
>  		}
>  		break;
>  	case PIN_CONFIG_BIAS_HIGH_IMPEDANCE:
> -		arg = !pad->is_enabled;
> +		if (pad->is_enabled)
> +			return -EINVAL;
> +		arg = 1;
>  		break;
>  	case PIN_CONFIG_POWER_SOURCE:
>  		arg = pad->power_source;
>  		break;
>  	case PIN_CONFIG_INPUT_ENABLE:
> -		arg = pad->input_enabled;
> +		if (!pad->input_enabled)
> +			return -EINVAL;
> +		arg = 1;
>  		break;
>  	case PIN_CONFIG_OUTPUT:
>  		arg = pad->out_value;
> @@ -382,7 +385,9 @@ static int pmic_mpp_config_get(struct pinctrl_dev *pctldev,
>  		arg = pad->amux_input;
>  		break;
>  	case PMIC_MPP_CONF_PAIRED:
> -		arg = pad->paired;
> +		if (!pad->paired)
> +			return -EINVAL;
> +		arg = 1;
>  		break;
>  	case PIN_CONFIG_DRIVE_STRENGTH:
>  		arg = pad->drive_strength;
> -- 
> 2.19.0.rc0.228.g281dcd1b4d0-goog
> 

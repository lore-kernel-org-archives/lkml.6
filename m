Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4015C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 15:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BEC020658
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 15:32:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BOT/RNQW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BEC020658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729139AbeH2T3y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 15:29:54 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44159 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729088AbeH2T3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 15:29:54 -0400
Received: by mail-pg1-f196.google.com with SMTP id r1-v6so2474032pgp.11
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 08:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sImJ+lABjlmCiG9UVJvsZV9U4AYO+RNp3EC7jjB9htQ=;
        b=BOT/RNQWIKE3+63phLRldJNpVgtknmo2ijcvUuaLj4nZl7ZqlPTqYntzbZXIAv0U9Z
         DqLfXPXAMGQ+m5by2HNvUVGGs6tdiVkCUo9C1zy9DBZrwjjR8eVhLWRT7IfSsd+HJ03y
         H3iKVdVt7N7xryGjrLxzCwrRrTu8QmV4FZQlE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sImJ+lABjlmCiG9UVJvsZV9U4AYO+RNp3EC7jjB9htQ=;
        b=Bbxad4cfCvqA+r8vD31R59vQxlyEKFMIlybFzYIEXb4QPq+UoinQukkzBsq8Yidc7h
         ehaxednjgQFZf5B2tK3ncaU2bNppr0iPTD7KLzbB4XlMDHwePT6YA2qvXB2OuvpKBawN
         id429QS5Vcfp+ilUzIQYx61G1zcTxxWMh7abm9UJbh7/4Ez1l+/7wSzoyN7Qt1hOyMPY
         hdiSX5R/Afokr06Wg39CvVuLWoG3oPodVJQmwSZH20S3IOgJTnuy1R07Lu1DV+5pw0qI
         biMV1aAxWrJATZIrcbr2CnLE8cbCahsii2JwG2t/Pvmv2YzDYG47pZ8RqKdijaRcNd8L
         DBBQ==
X-Gm-Message-State: APzg51DBt7mzqiOlz03vhuOcfh4RrYoqzcINkQI8W1IFZtD2CgMDP5n9
        mIT53/U1OXf2XPfZX/Qxakz/
X-Google-Smtp-Source: ANB0VdY6jXkxq9uAwkxTnzjNoDySfa5R2ehNPjk4rbOCmEC2dbgBB7HJqCVbHtNrEtvixUqTQojq6A==
X-Received: by 2002:a65:6398:: with SMTP id h24-v6mr6248534pgv.245.1535556745079;
        Wed, 29 Aug 2018 08:32:25 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:6384:6a6:70b9:a288:9cdc:3e44])
        by smtp.gmail.com with ESMTPSA id r19-v6sm20440368pgo.43.2018.08.29.08.32.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Aug 2018 08:32:24 -0700 (PDT)
Date:   Wed, 29 Aug 2018 21:02:14 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Saravanan Sekar <sravanhome@gmail.com>
Cc:     linus.walleij@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        afaerber@suse.de, catalin.marinas@arm.com, will.deacon@arm.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        pn@denx.de, mp-cs@actions-semi.com, jeff.chen@actions-semi.com,
        thomas.liau@actions-semi.com, linux@cubietech.com
Subject: Re: [PATCH v5 2/5] pinctrl: actions: define pad control configurtion
 to SoC specific
Message-ID: <20180829153214.GB21136@Mani-XPS-13-9360>
References: <20180829082413.2512005-1-sravanhome@gmail.com>
 <20180829082413.2512005-3-sravanhome@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180829082413.2512005-3-sravanhome@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 10:24:10AM +0200, Saravanan Sekar wrote:
> pad control for s900 and s700 are differs in number of
> pull control configuraions
> s900 has 4 pull controls - high impedence, pull up, pull down, repeater
> s700, s500 has 2 pull controls - pull up and pull down
> 
> so pad control configuration has to SoC specific, moved out from pinctrl
> common to s700, s900 specific.
>

This patch is not adding anything for S700 so no need to mention it in
last line.

> Signed-off-by: Parthiban Nallathambi <pn@denx.de>
> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> ---
>  drivers/pinctrl/actions/pinctrl-owl.c  | 64 +++++----------------------------
>  drivers/pinctrl/actions/pinctrl-owl.h  | 13 ++++---
>  drivers/pinctrl/actions/pinctrl-s900.c | 66 +++++++++++++++++++++++++++++++++-
>  3 files changed, 79 insertions(+), 64 deletions(-)
> 
> diff --git a/drivers/pinctrl/actions/pinctrl-owl.c b/drivers/pinctrl/actions/pinctrl-owl.c
> index 9d18c02f192b..cc242d6a47c3 100644
> --- a/drivers/pinctrl/actions/pinctrl-owl.c
> +++ b/drivers/pinctrl/actions/pinctrl-owl.c
> @@ -246,60 +246,6 @@ static int owl_pad_pinconf_reg(const struct owl_padinfo *info,
>  	return 0;
>  }
>  
> -static int owl_pad_pinconf_arg2val(const struct owl_padinfo *info,
> -				unsigned int param,
> -				u32 *arg)
> -{
> -	switch (param) {
> -	case PIN_CONFIG_BIAS_BUS_HOLD:
> -		*arg = OWL_PINCONF_PULL_HOLD;
> -		break;
> -	case PIN_CONFIG_BIAS_HIGH_IMPEDANCE:
> -		*arg = OWL_PINCONF_PULL_HIZ;
> -		break;
> -	case PIN_CONFIG_BIAS_PULL_DOWN:
> -		*arg = OWL_PINCONF_PULL_DOWN;
> -		break;
> -	case PIN_CONFIG_BIAS_PULL_UP:
> -		*arg = OWL_PINCONF_PULL_UP;
> -		break;
> -	case PIN_CONFIG_INPUT_SCHMITT_ENABLE:
> -		*arg = (*arg >= 1 ? 1 : 0);
> -		break;
> -	default:
> -		return -ENOTSUPP;
> -	}
> -
> -	return 0;
> -}
> -
> -static int owl_pad_pinconf_val2arg(const struct owl_padinfo *padinfo,
> -				unsigned int param,
> -				u32 *arg)
> -{
> -	switch (param) {
> -	case PIN_CONFIG_BIAS_BUS_HOLD:
> -		*arg = *arg == OWL_PINCONF_PULL_HOLD;
> -		break;
> -	case PIN_CONFIG_BIAS_HIGH_IMPEDANCE:
> -		*arg = *arg == OWL_PINCONF_PULL_HIZ;
> -		break;
> -	case PIN_CONFIG_BIAS_PULL_DOWN:
> -		*arg = *arg == OWL_PINCONF_PULL_DOWN;
> -		break;
> -	case PIN_CONFIG_BIAS_PULL_UP:
> -		*arg = *arg == OWL_PINCONF_PULL_UP;
> -		break;
> -	case PIN_CONFIG_INPUT_SCHMITT_ENABLE:
> -		*arg = *arg == 1;
> -		break;
> -	default:
> -		return -ENOTSUPP;
> -	}
> -
> -	return 0;
> -}
> -
>  static int owl_pin_config_get(struct pinctrl_dev *pctrldev,
>  				unsigned int pin,
>  				unsigned long *config)
> @@ -318,7 +264,10 @@ static int owl_pin_config_get(struct pinctrl_dev *pctrldev,
>  
>  	arg = owl_read_field(pctrl, reg, bit, width);
>  
> -	ret = owl_pad_pinconf_val2arg(info, param, &arg);
> +	if (!pctrl->soc->padctl_val2arg)
> +		return -ENOTSUPP;
> +
> +	ret = pctrl->soc->padctl_val2arg(info, param, &arg);
>  	if (ret)
>  		return ret;
>  
> @@ -349,7 +298,10 @@ static int owl_pin_config_set(struct pinctrl_dev *pctrldev,
>  		if (ret)
>  			return ret;
>  
> -		ret = owl_pad_pinconf_arg2val(info, param, &arg);
> +		if (!pctrl->soc->padctl_arg2val)
> +			return -ENOTSUPP;
> +
> +		ret = pctrl->soc->padctl_arg2val(info, param, &arg);
>  		if (ret)
>  			return ret;
>  
> diff --git a/drivers/pinctrl/actions/pinctrl-owl.h b/drivers/pinctrl/actions/pinctrl-owl.h
> index 31cc33d7c4a5..dae2e8363fd5 100644
> --- a/drivers/pinctrl/actions/pinctrl-owl.h
> +++ b/drivers/pinctrl/actions/pinctrl-owl.h
> @@ -145,13 +145,6 @@
>  		.shared_ctl_offset = _share,			\
>  	}
>  
> -enum owl_pinconf_pull {
> -	OWL_PINCONF_PULL_HIZ,
> -	OWL_PINCONF_PULL_DOWN,
> -	OWL_PINCONF_PULL_UP,
> -	OWL_PINCONF_PULL_HOLD,
> -};
> -
>  enum owl_pinconf_drv {
>  	OWL_PINCONF_DRV_2MA,
>  	OWL_PINCONF_DRV_4MA,
> @@ -305,6 +298,12 @@ struct owl_pinctrl_soc_data {
>  	unsigned int ngpios;
>  	const struct owl_gpio_port *ports;
>  	unsigned int nports;
> +	int (*padctl_val2arg)(const struct owl_padinfo *padinfo,
> +				unsigned int param,
> +				u32 *arg);
> +	int (*padctl_arg2val)(const struct owl_padinfo *info,
> +				unsigned int param,
> +				u32 *arg);
>  };
>  
>  int owl_pinctrl_probe(struct platform_device *pdev,
> diff --git a/drivers/pinctrl/actions/pinctrl-s900.c b/drivers/pinctrl/actions/pinctrl-s900.c
> index 0597009d8369..2e19fecbe5e9 100644
> --- a/drivers/pinctrl/actions/pinctrl-s900.c
> +++ b/drivers/pinctrl/actions/pinctrl-s900.c
> @@ -13,6 +13,7 @@
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/pinctrl/pinctrl.h>
> +#include <linux/pinctrl/pinconf-generic.h>
>  #include "pinctrl-owl.h"
>  
>  /* Pinctrl registers offset */
> @@ -1717,6 +1718,67 @@ static const struct owl_gpio_port s900_gpio_ports[] = {
>  	OWL_GPIO_PORT(F, 0x00F0, 8, 0x0, 0x4, 0x8, 0x460, 0x140, 0x144, 0x178, 0)
>  };
>  
> +enum owl_pinconf_pull {

Since this enum is SoC specific, it could be s900_pinconf_pull.

Regards,
Mani

> +	OWL_PINCONF_PULL_HIZ,
> +	OWL_PINCONF_PULL_DOWN,
> +	OWL_PINCONF_PULL_UP,
> +	OWL_PINCONF_PULL_HOLD,
> +};
> +
> +static int s900_pad_pinconf_arg2val(const struct owl_padinfo *info,
> +				unsigned int param,
> +				u32 *arg)
> +{
> +	switch (param) {
> +	case PIN_CONFIG_BIAS_BUS_HOLD:
> +		*arg = OWL_PINCONF_PULL_HOLD;
> +		break;
> +	case PIN_CONFIG_BIAS_HIGH_IMPEDANCE:
> +		*arg = OWL_PINCONF_PULL_HIZ;
> +		break;
> +	case PIN_CONFIG_BIAS_PULL_DOWN:
> +		*arg = OWL_PINCONF_PULL_DOWN;
> +		break;
> +	case PIN_CONFIG_BIAS_PULL_UP:
> +		*arg = OWL_PINCONF_PULL_UP;
> +		break;
> +	case PIN_CONFIG_INPUT_SCHMITT_ENABLE:
> +		*arg = (*arg >= 1 ? 1 : 0);
> +		break;
> +	default:
> +		return -ENOTSUPP;
> +	}
> +
> +	return 0;
> +}
> +
> +static int s900_pad_pinconf_val2arg(const struct owl_padinfo *padinfo,
> +				unsigned int param,
> +				u32 *arg)
> +{
> +	switch (param) {
> +	case PIN_CONFIG_BIAS_BUS_HOLD:
> +		*arg = *arg == OWL_PINCONF_PULL_HOLD;
> +		break;
> +	case PIN_CONFIG_BIAS_HIGH_IMPEDANCE:
> +		*arg = *arg == OWL_PINCONF_PULL_HIZ;
> +		break;
> +	case PIN_CONFIG_BIAS_PULL_DOWN:
> +		*arg = *arg == OWL_PINCONF_PULL_DOWN;
> +		break;
> +	case PIN_CONFIG_BIAS_PULL_UP:
> +		*arg = *arg == OWL_PINCONF_PULL_UP;
> +		break;
> +	case PIN_CONFIG_INPUT_SCHMITT_ENABLE:
> +		*arg = *arg == 1;
> +		break;
> +	default:
> +		return -ENOTSUPP;
> +	}
> +
> +	return 0;
> +}
> +
>  static struct owl_pinctrl_soc_data s900_pinctrl_data = {
>  	.padinfo = s900_padinfo,
>  	.pins = (const struct pinctrl_pin_desc *)s900_pads,
> @@ -1727,7 +1789,9 @@ static struct owl_pinctrl_soc_data s900_pinctrl_data = {
>  	.ngroups = ARRAY_SIZE(s900_groups),
>  	.ngpios = NUM_GPIOS,
>  	.ports = s900_gpio_ports,
> -	.nports = ARRAY_SIZE(s900_gpio_ports)
> +	.nports = ARRAY_SIZE(s900_gpio_ports),
> +	.padctl_arg2val = s900_pad_pinconf_arg2val,
> +	.padctl_val2arg = s900_pad_pinconf_val2arg,
>  };
>  
>  static int s900_pinctrl_probe(struct platform_device *pdev)
> -- 
> 2.14.4
> 

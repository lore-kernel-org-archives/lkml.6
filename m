Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49256C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 08:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09D4720874
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 08:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547196509;
	bh=Q5LfcHVZ+apOezTRBcM32GuzjTorrpPv9saMHIzdpH4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FGjY7YzfA8bBxqmKwC23gis817sKxJh7/bDIc0rtkie9B3cMwV8d+D0G/djlccNxQ
	 LPI5+qtpJw8iNczYYeXISMVN/ZVuCfzjwkRaeS8m+CNWrZR0WSW5aHcvs6RDPpRC8O
	 Dv3U32crExHC7xS/8dkaKMjgKZwA5bG+KwGEUibQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731239AbfAKIs2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 03:48:28 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39486 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbfAKIs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 03:48:27 -0500
Received: by mail-lf1-f66.google.com with SMTP id n18so10253025lfh.6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 00:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MYbhUSo4g5UhVhyMz7UTYahyparcv+2WwveqAEfFR58=;
        b=jHY5dMWwQzbKJ5ty+A4KJPLr3wd/jGp6mlGsVAQGdOx924citTpdWgCZDpJ0m4oRbs
         AflWGIemDnTka+ZpcDy03KQQttT7Hnj84WKIbuLvbJb2LM8MRN6XF+6DqY8IY6gp+3xR
         su0yAgyNtFP7RRQIaU3iCjjN/quZHdhxX7nqvxiqtCxck+fB7Zd24CHxOW+hwKSJyb/p
         7pdwIzmfvobfbNHpECNUGeDiW5IrCo/iSQCkzMZWyBUX3WOZMv6tiH3Ap1+9dJfEYjJr
         RnYu6W9ra0YpscQ3MJ0To9oTN/D1/gxqJmHsROYsO3/KrYvH3qKFcFR8MRvM/0bgCzH5
         7bTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=MYbhUSo4g5UhVhyMz7UTYahyparcv+2WwveqAEfFR58=;
        b=pHMyMPDQvVm5OFz7brt3yg5MWXIjbIRSaRJNEOe3i57Kx6qxJhZ1Vvlw+qoHV8KmpK
         BpsT5doT9kLyh51NPykBfXkXJSokueb3QSRCzQ7TqQgTLxuc/43SJpGNVztxAjwGbyRl
         dMiuzXUXV59zd1/0qsTAM5xmKuTLFbA2C9LHPwFgl0iHLh/xuAbnmb2o7Itqywy1xGJZ
         IMvdgNP1pdeEvKwJuGLolQnmi9f03y9JFtXVjG+dttETM04GOGYvaR6vVviCdRxd3eE9
         cbxIzmbmWer+iwiTEhFTG9cxl+TxGpFB6vGwnGjiDIIKksWd25JBCCO9+DZ/qaHHY9Zp
         Siqw==
X-Gm-Message-State: AJcUukcEjYL1Z7tetJWiEzAYP5nVey8AXP3x5cqmhJB8erZ2i7/rotio
        U+yb011Miv2fPVs0GwZ29OzLGDm6
X-Google-Smtp-Source: ALg8bN4ETHXozXx/gVuOUeNRik82SXTHZ2XNt7O46QP4WtZMDvrUw8ynWGeQCzEPriz+TKI+8l+0oQ==
X-Received: by 2002:a19:2906:: with SMTP id p6mr7292009lfp.17.1547196503703;
        Fri, 11 Jan 2019 00:48:23 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id l21-v6sm15695934ljj.48.2019.01.11.00.48.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Jan 2019 00:48:22 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1ghsUH-0002Ba-85; Fri, 11 Jan 2019 09:48:21 +0100
Date:   Fri, 11 Jan 2019 09:48:21 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Nishad Kamdar <nishadkamdar@gmail.com>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alex Elder <elder@kernel.org>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/3] staging: greybus: arche-platform: Switch to the
 gpio descriptor interface
Message-ID: <20190111084821.GD3383@localhost>
References: <cover.1547141413.git.nishadkamdar@gmail.com>
 <35b03691b11f4c6a8441e6952457f8359b0655aa.1547141413.git.nishadkamdar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35b03691b11f4c6a8441e6952457f8359b0655aa.1547141413.git.nishadkamdar@gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 11:23:07PM +0530, Nishad Kamdar wrote:
> Use the gpiod interface instead of the deprecated old non-descriptor
> interface while continuing to ignore gpio flags from device tree in
> "svc_reset_onoff()" for now.
> 
> Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> ---
> Changes in v5:
>   - Change the commit message.
>   - Restore the names of the gpio device-tree properties without
>     the "-gpio" suffix.
> Changes in v4:
>  - Move 'gpio_desc *svc_sysboot' below the reset flag
>    as it is more logical to have reset flag below
>    reset gpio.
>  - Remove a few unnecessary line breaks.
> Changes in v3:
>  - Add this patch to a patchset.
> Changes in v2:
>  - Move comment to the same line as to what it applies to.
> ---

Also looks good. Some really minor comments to a couple of the error
messages. The issues are there in the current code, but since you modify
these messages anyway you might as well fix them up. Please fix that and
resend with my

Reviewed-by: Johan Hovold <johan@kernel.org>

Really good job with this!

> @@ -435,6 +428,7 @@ static int arche_platform_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct device_node *np = dev->of_node;
>  	int ret;
> +	unsigned int flags;
>  
>  	arche_pdata = devm_kzalloc(&pdev->dev, sizeof(*arche_pdata),
>  				   GFP_KERNEL);
> @@ -444,61 +438,33 @@ static int arche_platform_probe(struct platform_device *pdev)
>  	/* setup svc reset gpio */
>  	arche_pdata->is_reset_act_hi = of_property_read_bool(np,
>  							     "svc,reset-active-high");
> -	arche_pdata->svc_reset_gpio = of_get_named_gpio(np,
> -							"svc,reset-gpio",
> -							0);
> -	if (!gpio_is_valid(arche_pdata->svc_reset_gpio)) {
> -		dev_err(dev, "failed to get reset-gpio\n");
> -		return arche_pdata->svc_reset_gpio;
> -	}
> -	ret = devm_gpio_request(dev, arche_pdata->svc_reset_gpio, "svc-reset");
> -	if (ret) {
> -		dev_err(dev, "failed to request svc-reset gpio:%d\n", ret);
> -		return ret;
> -	}
> -	ret = gpio_direction_output(arche_pdata->svc_reset_gpio,
> -				    arche_pdata->is_reset_act_hi);
> -	if (ret) {
> -		dev_err(dev, "failed to set svc-reset gpio dir:%d\n", ret);
> +	if (arche_pdata->is_reset_act_hi)
> +		flags = GPIOD_OUT_HIGH;
> +	else
> +		flags = GPIOD_OUT_LOW;
> +
> +	arche_pdata->svc_reset = devm_gpiod_get(dev, "svc,reset", flags);
> +	if (IS_ERR(arche_pdata->svc_reset)) {
> +		ret = PTR_ERR(arche_pdata->svc_reset);
> +		dev_err(dev, "failed to request svc-reset GPIO:%d\n", ret);

Add a space after ':' for consistency.

> @@ -515,19 +481,11 @@ static int arche_platform_probe(struct platform_device *pdev)
>  	arche_pdata->num_apbs = of_get_child_count(np);
>  	dev_dbg(dev, "Number of APB's available - %d\n", arche_pdata->num_apbs);
>  
> -	arche_pdata->wake_detect_gpio = of_get_named_gpio(np,
> -							  "svc,wake-detect-gpio",
> -							  0);
> -	if (arche_pdata->wake_detect_gpio < 0) {
> -		dev_err(dev, "failed to get wake detect gpio\n");
> -		return arche_pdata->wake_detect_gpio;
> -	}
> -
> -	ret = devm_gpio_request(dev, arche_pdata->wake_detect_gpio,
> -				"wake detect");
> -	if (ret) {
> -		dev_err(dev, "Failed requesting wake_detect gpio %d\n",
> -			arche_pdata->wake_detect_gpio);
> +	arche_pdata->wake_detect = devm_gpiod_get(dev, "svc,wake-detect",
> +						  GPIOD_IN);
> +	if (IS_ERR(arche_pdata->wake_detect)) {
> +		ret = PTR_ERR(arche_pdata->wake_detect);
> +		dev_err(dev, "Failed requesting wake_detect GPIO %d\n", ret);

Add colon after "GPIO" for consistency (and to avoid ambiguity).

>  		return ret;
>  	}

Thanks,
Johan

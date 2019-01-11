Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F9C4C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 08:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68C42214C6
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 08:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547196099;
	bh=y3zo7UvWKct1CppzNLwcgHcTCQpQvJweU7CxDPY8TdU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TuN7ut4lngaXVbQtpjeOaY86cAwcRyDNvXnTva4LLtbc4NDVIELWM3LPueAgYoriz
	 lthwCkNxkDt/2HMVajgsRmUgvmdfWEXVfhCfDbhGYlinYdDntuHh5w1Xf2+zpN2i63
	 MdOLf5QAmq7dSq0G0xlYpL2Ysy8YjEPiw3BSqLfM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731191AbfAKIli (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 03:41:38 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44219 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbfAKIli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 03:41:38 -0500
Received: by mail-lj1-f195.google.com with SMTP id k19-v6so12174048lji.11
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 00:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MK/d2TswovDB4sVlO5M6J9VUb/27qE0eUCQzm6JX6Ok=;
        b=WerIisUHWzQ+G27wOcOuKtp6abvY6Bz41NsxK2oORLPR0x1nip7YAtNPt2genRq3mB
         Wrs+IGWISw2NipuDXQJbTO2sTCdwvbooc6Ilj99VwGP6GgZIU1wNaQkZl/S3ntQCMnXm
         SNw+tmZJcmAFYnqyvt/7+rfTNM12oGGzX5b566W3fiG1CP4ErYCTJddM44ugjUD6FR8p
         xO8oqWY/GmVBLspnCgVTJCb4GgKBlGIWaesyn/yLxnAyYnQqIB7kGkcdz9GMMj+6kLNq
         UkwFnwWATzkSo8hUpo7B3QHfIk1U77tBqjjhP2FDcqsHWQyepflZnG1p7nQ3HhUuovYQ
         YmAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=MK/d2TswovDB4sVlO5M6J9VUb/27qE0eUCQzm6JX6Ok=;
        b=ASGPhukmPfhSwBvAt9bt6ysUDKUTeWqQ29WklevrRgR3a4VaKdYi3DJYo7ibeDiq/e
         b0htzROWzzqZrtg8vP9z0SUSY+ey/JOp66RHehZKbCBCxSkZp+GY/YblzRiCWgcGkE/4
         /u7qVETxnVZqbcTGlia0MfjYUSVoZjnbLPADzN0pvNG6QIQpf5EtU9o8C0tZq+czufTb
         gnesdepHur3x7xI7rpKMU3JNis0FVLUqsJJUbH2s3KV3KdBr5ZIGCLzUMM2tRhzxT8qZ
         srEg094+IMEXP8wocEfnAzSsZ0/2oTqYVfMHeIK9FX9hp3xysN43L4hy8L1Z/JhFuQmp
         eNcg==
X-Gm-Message-State: AJcUukcrJwpqujGjuQjKko7gD+vuRVq7bZa7rPwbkeRnuQd8Ygs4V8CI
        r1wxPWTOJUL79+Esv+TKEQQ=
X-Google-Smtp-Source: ALg8bN6tR+aCP8447nU40Je9a4HWkTrMWDAhecDyUzDVxqXPtVuIDsnr+YrgTaZA8VVHQ1Zbpq1gyQ==
X-Received: by 2002:a2e:55d3:: with SMTP id g80-v6mr8918098lje.78.1547196095900;
        Fri, 11 Jan 2019 00:41:35 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id l21-v6sm15562694lji.6.2019.01.11.00.41.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Jan 2019 00:41:35 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1ghsNi-00029V-E4; Fri, 11 Jan 2019 09:41:34 +0100
Date:   Fri, 11 Jan 2019 09:41:34 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Nishad Kamdar <nishadkamdar@gmail.com>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alex Elder <elder@kernel.org>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/3] staging: greybus: arche-apb-ctrl.c: Switch to the
 gpio descriptor interface
Message-ID: <20190111084134.GC3383@localhost>
References: <cover.1547141413.git.nishadkamdar@gmail.com>
 <0f65372f6f223244f7125d074816d5da9e513a8b.1547141413.git.nishadkamdar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f65372f6f223244f7125d074816d5da9e513a8b.1547141413.git.nishadkamdar@gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 11:21:04PM +0530, Nishad Kamdar wrote:
> Use the gpiod interface instead of the deprecated old non-descriptor
> interface while continuing to ignore gpio flags from device tree in
> functions "deassert_reset()" and "assert_reset()" for now.
> 
> Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> ---
> Changes in v5:
>  - Change the commit message.
>  - Restore the names of the gpio device-tree properties without
>    the "-gpio" suffix.
> Changes in v4:
>  - Use gpiod_set_raw_value() for deassert_reset() and
>    assert_reset() as gpiod_set_value() will change the
>    sematics of these calls by taking any gpio flags
>    into account.
>  - Remove some unnecesssary line breaks.
>  - Restore 'spi_en' gpio check in fw_flashing_seq()
>    as it is currently optional.
> Changes in v3:
>  - Add this patch in a patchset.
> Changes in v2:
>  - Resolved compilation errors.
> ---

Also looks good now. You can add my

Reviewed-by: Johan Hovold <johan@kernel.org>

Found one really minor nit below, which doesn't really need to be fixed,
but since you may need to update the third patch, you might as well
consider this too.

>  	/* It's not mandatory to support power management interface */
> -	apb->pwroff_gpio = of_get_named_gpio(np, "pwr-off-gpios", 0);
> -	if (apb->pwroff_gpio < 0) {
> -		dev_err(dev, "failed to get power off gpio\n");
> -		return apb->pwroff_gpio;
> -	}
> -	ret = devm_gpio_request_one(dev, apb->pwroff_gpio,
> -				    GPIOF_IN, "pwroff_n");
> -	if (ret) {
> -		dev_err(dev, "Failed requesting pwroff_n gpio %d\n",
> -			apb->pwroff_gpio);
> +	apb->pwroff = devm_gpiod_get_optional(dev, "pwr-off",
> +					      GPIOD_IN);

Looks like you don't need to break the above statement any more either.

> +	if (IS_ERR(apb->pwroff)) {
> +		ret = PTR_ERR(apb->pwroff);
> +		dev_err(dev, "Failed requesting pwroff_n GPIO: %d\n", ret);
>  		return ret;
>  	}
>  
>  	/* Do not make clock mandatory as of now (for DB3) */
> -	apb->clk_en_gpio = of_get_named_gpio(np, "clock-en-gpio", 0);
> -	if (apb->clk_en_gpio < 0) {
> -		dev_warn(dev, "failed to get clock en gpio\n");
> -	} else if (gpio_is_valid(apb->clk_en_gpio)) {
> -		ret = devm_gpio_request_one(dev, apb->clk_en_gpio,
> -					    GPIOF_OUT_INIT_LOW, "apb_clk_en");
> -		if (ret) {
> -			dev_warn(dev, "Failed requesting APB clock en gpio %d\n",
> -				 apb->clk_en_gpio);
> -			return ret;
> -		}
> +	apb->clk_en = devm_gpiod_get_optional(dev, "clock-en",
> +					      GPIOD_OUT_LOW);

Same here?

> +	if (IS_ERR(apb->clk_en)) {
> +		ret = PTR_ERR(apb->clk_en);
> +		dev_err(dev, "Failed requesting APB clock en GPIO: %d\n", ret);
> +		return ret;
>  	}

Johan

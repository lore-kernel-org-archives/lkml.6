Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91FD9C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 11:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C07E20652
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 11:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547033748;
	bh=4mtWFDG884yJNHya0V5sDKdLIa6y/pdBWtMFAEANZaE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DOZCcQ6lfWiNKshY1ICSsfuUmaXGTQ5j5MxbhN/sC0VRdsgNPhRPT4F+hm44b8/Pd
	 EuB/J8cXoQguK0/ApfEc3lLv7Y2N0lcGMZqgrQ9x8XSeIl/T57rpR5HltK9lHk3yg/
	 JFE3vQ3SI2gZkzLCmw8llWn8ZgVN4bDohF/Unm0M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730865AbfAILfr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 06:35:47 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33963 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730633AbfAILfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 06:35:47 -0500
Received: by mail-lj1-f193.google.com with SMTP id u89-v6so6208710lje.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 03:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3nxf9UbXLxcCq3x5mDmsxrZpp0H+NRkYgjJLa3+h11E=;
        b=m1wZN7e650Er+vb6ab6vnpGTjElhGeQXos5SyPzEXP332wznyRNUwmkR3oLiJ4CosI
         d2ruodGEJ9evV2GZh73CFY8mNuJ4GbeTOoa3WZZsVJaf5C8MPB85BoX8DiPVOsjF3G0x
         LDO1HWpIDY4jm+o8SlIEr45v1fQ7zbFvKXoZCgmdRJDDD39GhKCR5o5ix0OM+sznw7XY
         HTHW7Q+oiOFtTnqVldvopghQisGmjW+w1tUWT6/I99B2w8NLroCCi9RxAeEClvikhoTH
         u3+9yeqSd8K9uTFJXQIqbjGRoNm37dGWDlD4vatgu3nj+x55eFT/h7abGLUQuPPj8P44
         sUEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=3nxf9UbXLxcCq3x5mDmsxrZpp0H+NRkYgjJLa3+h11E=;
        b=EOFTFm8jUnK6g3Eay+5DUNIKrz7VqGfifnnEOrgERp9ucJUoU9SXLpE0oocZqJHtPJ
         /SGQ1O027abETjDu4vc3dPua0/NTAqQL0PHRPUmlVsZZUIiqLwt1lo1sQKGulUeW5iiL
         8h+O3SWwZfnuL7z0wOMj+Ok6iBp0ak2uXOcwYrYa3ER2dRr9mtLwB0oOmkB9zV7hS2WO
         t2YSaGoKBOYKS9wsBC9icYgO0F5Y/noiRFUG9LvlQGQzKFnFlEpG4wpH5uMndRUOu4+C
         0N5qNg7dk9UYIvReJZfhhrKwv747DpU77PgRXAkvsxE0zVSn7+7YryQZs58neYuYMAOY
         IHzw==
X-Gm-Message-State: AJcUukfNJNQaxnGJToHpsTV0SbjNb8SMGDBjkibkaFd4ITEzTOap/xGj
        Y/sbRhxWFLTmU4IgJHU6hTI=
X-Google-Smtp-Source: ALg8bN45d0OTxDJcT7q17UArBDiEHTlIEzED8K6Tevk2wphhJlDvvVIAdyZGHankXXeETuCRKpCw2Q==
X-Received: by 2002:a2e:710a:: with SMTP id m10-v6mr3211943ljc.66.1547033744081;
        Wed, 09 Jan 2019 03:35:44 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id d23sm13759603lfc.11.2019.01.09.03.35.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jan 2019 03:35:43 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1ghC9D-0008Pi-Mg; Wed, 09 Jan 2019 12:35:47 +0100
Date:   Wed, 9 Jan 2019 12:35:47 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Nishad Kamdar <nishadkamdar@gmail.com>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alex Elder <elder@kernel.org>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/4] staging: greybus: arche-platform: Switch to the
 gpio descriptor interface
Message-ID: <20190109113547.GL14782@localhost>
References: <cover.1545488665.git.nishadkamdar@gmail.com>
 <fa242dd022340b8cd8fa6bab9138a718980b3871.1545488665.git.nishadkamdar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa242dd022340b8cd8fa6bab9138a718980b3871.1545488665.git.nishadkamdar@gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 22, 2018 at 08:23:02PM +0530, Nishad Kamdar wrote:
> Use the gpiod interface instead of the deprecated
> old non-descriptor interface.
> 
> Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> ---
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

> -static inline void svc_reset_onoff(unsigned int gpio, bool onoff)
> +static inline void svc_reset_onoff(struct gpio_desc *gpio, bool onoff)
>  {
> -	gpio_set_value(gpio, onoff);
> +	gpiod_set_value(gpio, onoff);
>  }

Please use the raw interface here too, until we've done away with the
polarity properties and can honour the generic device tree flags. Please
make a comment about this in the commit message too.

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
> +	arche_pdata->svc_reset = devm_gpiod_get(dev, "svc,reset-gpio", flags);

Again, you cannot just rename devicetree properties like this. Keep the
current names for now (and drop the -gpio suffix when requesting).

Johan

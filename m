Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F65C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 19:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F24772080F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 19:42:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UuF7Xhlj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729707AbfBETmv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 14:42:51 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43499 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729569AbfBETmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 14:42:51 -0500
Received: by mail-pf1-f194.google.com with SMTP id w73so1944711pfk.10;
        Tue, 05 Feb 2019 11:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=K8CIyAdQyhYAshuJG9VWuQMt+aNQRX/uxjkSUykOlzE=;
        b=UuF7XhljTnWM0vBKgYmWny2CjUV4UtFKR5Wa5T2IjLKLCb/N24l+brg+Hh6q4h7OwA
         tM72UNHR7zyavmaK+kLhH5dK7fPYfEpo5gdSwm/NS42Yz1M9iM02+xr2r49aCYQzBkP4
         Hpa5MNtqYWhgLzaHnuNX0v7q848Qog6BFVA5+aIyZLPXY4HmAiPY/4TxDEdutSMTntXP
         9/gAga+M5PNgR18+z+tDZQ2ToOeAUKZp0uTewUDw2UHorEuNXzXJTVBksfCK+3uxjbNW
         3JK99qWQqcc6WEpx6Gf9bMHt666Mu+mHskwG6rwdKUgthc8ISWs1UbzE5oLaSmBR+v+g
         IXbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=K8CIyAdQyhYAshuJG9VWuQMt+aNQRX/uxjkSUykOlzE=;
        b=QlJITSkApwuULkp4lhf6SMKVHQVdTeFtTe3AVO7aKEvTcECFu49uUJfvWU22xZ1ota
         A3VNc/iwP8gxmsO71WUNGo3zk/R+sBakrfWZmQEIhnNKIRAyXxpKYYw26kA44YlDpPiw
         ZadyynvQks8I4Wtvx+mvCL1oAF1Cc6qj7ZgdX1rB80EJreZW5/GAXwWhGtxtgk4UDklE
         ocEVHJy/KLa/g8CLe1iv7BTc2YlbYjkkSvKN/7XbFWy5nokE3sGSCAx/CKrsJZeCYU6d
         jJAs6T+6UEYGC0SdG604NpgNCSaf0QFflf+7mqZ5ggQ/w03yY497qmOOGxB5IFEaeo1A
         EnRw==
X-Gm-Message-State: AHQUAubrhw3UfuGwbu1U8mDjBSt10uimozSNSS3RL2MLFoU0rYM1FA1/
        Pi4Isyszy/ocXsckWv9o/8s=
X-Google-Smtp-Source: AHgI3IbLALYsZgkOIvovasTlJSijX0+KyZ1BNPe1vMkqLQEs7YE3Xtd32PIJBq3sCdbINtGu3sAFpg==
X-Received: by 2002:a63:2706:: with SMTP id n6mr5872664pgn.352.1549395769215;
        Tue, 05 Feb 2019 11:42:49 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id f32sm4476160pgf.80.2019.02.05.11.42.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Feb 2019 11:42:48 -0800 (PST)
Date:   Tue, 5 Feb 2019 11:42:46 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Brian Masney <masneyb@onstation.org>
Cc:     andy.gross@linaro.org, david.brown@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, devicetree@vger.kernel.org,
        jonathan@marek.ca
Subject: Re: [PATCH v3 2/3] Input: add new vibrator driver for various MSM
 SOCs
Message-ID: <20190205194246.GA19151@dtor-ws>
References: <20181025012937.2154-1-masneyb@onstation.org>
 <20181025012937.2154-3-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181025012937.2154-3-masneyb@onstation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Brian,

On Wed, Oct 24, 2018 at 09:29:36PM -0400, Brian Masney wrote:
> This patch adds a new vibrator driver that supports various Qualcomm
> MSM SOCs. Driver was tested on a LG Nexus 5 (hammerhead) phone.
> 

...

> +
> +#define msm_vibrator_write(msm_vibrator, offset, value) \
> +	writel((value), (void __iomem *)((msm_vibrator)->base + (offset)))

Make in a function? It will be inlined anyways...

> +
> +	vibrator->vcc = devm_regulator_get(&pdev->dev, "vcc");
> +	if (IS_ERR(vibrator->vcc)) {
> +		if (PTR_ERR(vibrator->vcc) != -EPROBE_DEFER)
> +			dev_err(&pdev->dev, "Failed to get regulator: %ld\n",
> +				PTR_ERR(vibrator->vcc));
> +		return PTR_ERR(vibrator->vcc);
> +	}
> +
> +	vibrator->enable_gpio = devm_gpiod_get(&pdev->dev, "enable",
> +					       GPIOD_OUT_LOW);
> +	if (IS_ERR(vibrator->enable_gpio)) {

You have explicit deferral handling for the regulator, but not gpio. I'd
prefer if we did (or not) it consistently.

> +		dev_err(&pdev->dev, "Failed to get enable gpio: %ld\n",
> +			PTR_ERR(vibrator->enable_gpio));
> +		return PTR_ERR(vibrator->enable_gpio);
> +	}
> +
> +	vibrator->clk = devm_clk_get(&pdev->dev, "pwm");
> +	if (IS_ERR(vibrator->clk)) {

Same here.

> +		dev_err(&pdev->dev, "Failed to lookup pwm clock: %ld\n",
> +			PTR_ERR(vibrator->clk));
> +		return PTR_ERR(vibrator->clk);
> +	}
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		dev_err(&pdev->dev, "Failed to get platform resource\n");
> +		return -ENODEV;
> +	}
> +
> +	vibrator->base = devm_ioremap(&pdev->dev, res->start,
> +				     resource_size(res));
> +	if (IS_ERR(vibrator->base)) {

devm_ioremap() returns NULL on error. You either need to check for NULL
or see of you can use devm_ioremap_resource().

> +		dev_err(&pdev->dev, "Failed to iomap resource: %ld\n",
> +			PTR_ERR(vibrator->base));
> +		return PTR_ERR(vibrator->base);
> +	}
> +
> +	vibrator->enabled = false;
> +	mutex_init(&vibrator->mutex);
> +	INIT_WORK(&vibrator->worker, msm_vibrator_worker);
> +
> +	vibrator->input->name = "msm-vibrator";
> +	vibrator->input->id.bustype = BUS_HOST;
> +	vibrator->input->dev.parent = &pdev->dev;

You allocated input device with devm so there is no need to set parent
by hand.

> +	vibrator->input->close = msm_vibrator_close;
> +
> +	input_set_drvdata(vibrator->input, vibrator);
> +	input_set_capability(vibrator->input, EV_FF, FF_RUMBLE);
> +
> +	ret = input_ff_create_memless(vibrator->input, NULL,
> +				      msm_vibrator_play_effect);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to create ff memless: %d", ret);
> +		return ret;
> +	}
> +
> +	ret = input_register_device(vibrator->input);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to register input device: %d", ret);
> +		return ret;
> +	}
> +
> +	platform_set_drvdata(pdev, vibrator);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused msm_vibrator_suspend(struct device *dev)
> +{
> +	struct msm_vibrator *vibrator = dev_get_drvdata(dev);

Prefer explicit platform_get_drvdata() since we are working with
platform device (even though it resolves to the same thing).

> +
> +	cancel_work_sync(&vibrator->worker);
> +
> +	if (vibrator->enabled)
> +		msm_vibrator_stop(vibrator);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused msm_vibrator_resume(struct device *dev)
> +{
> +	struct msm_vibrator *vibrator = dev_get_drvdata(dev);

Same here.

Thanks.

-- 
Dmitry

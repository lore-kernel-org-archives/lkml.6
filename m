Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53A0FC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 18:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EF9D20811
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 18:30:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KRrDIofH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730143AbfBESah (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 13:30:37 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44621 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728993AbfBESag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 13:30:36 -0500
Received: by mail-lj1-f196.google.com with SMTP id k19-v6so3719821lji.11;
        Tue, 05 Feb 2019 10:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zsRpKuqcR4XzY4cG+nYq+fp6x32HO8rPZGifUy0n3uE=;
        b=KRrDIofHM71yRNsLZ7jpn+e6X12IbCkgCBBaa2bvKOb2bvdAgrY1+cUWqtJCAjxDLN
         9yA8N7lABhKFvfldJUJcusYAmbOIoAVTuq558gp6BJtAMAd0csDujiNivmzI5AZ2JGQD
         XnhaOXwV6I8eDWTu8fj4aNuG5dcchlyzY47YmbqyyOi4W8Yes2IOHzXCEPRrW0pslXSG
         VtYZYFso7akSqObNfQJJgoLeaMYX20lpsiGATfhJhkia6of8UPVDj2WRO1iQWIQLpCd4
         VSrTMmWvbhB5OugzxzfpfYo/77RMLTdnNfPTavZtp4plf+x6jMjuu8hqorQ2bVUCZL98
         StVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zsRpKuqcR4XzY4cG+nYq+fp6x32HO8rPZGifUy0n3uE=;
        b=haQVy24rUpmYym1nEu4Ji8EaijkGADtHJ4b9oS99ykhmP1nEWMcfnnRGXeWIe5Uk+Z
         Lx20QOeFqz/S9z3PVAhWLf8bWicebn2MIsLdnrC3Kwnam/P8DcaEWrzAc9tT9fyfFy2S
         /+WzyRds05N0lH+zLOkDrjirxEnoLlGbbbPFTlC/XAdyhcqWVS/RUa5eO/ZiofF4pfor
         EG3hWzJ9VIf6IAYZdA0ucAi1N8jiivk+hMElSSOzvRMiWaclWmCioU4sTkXHfczU6NgC
         YUMnPmH6TJnphGigJxvpGs3+h+ruYuKT9KpJfhLSw/H1JcYZnQZKh4bvxYzn1p0e3k1f
         Tl9Q==
X-Gm-Message-State: AHQUAubx0WG4JZRDkLLDarHReCGWHCzCYK611zoe10cv0mNvSDYQosNf
        xUa7zcoUl8rDL1vRkFZB/Wk=
X-Google-Smtp-Source: AHgI3IZnjfpGALi+7YoLdPdkNEl3xKVY0NcGochiM0myzR4+z+nChy6WjgpHUgR/c98++SCjEsTl1g==
X-Received: by 2002:a2e:2a06:: with SMTP id q6-v6mr3603183ljq.37.1549391433209;
        Tue, 05 Feb 2019 10:30:33 -0800 (PST)
Received: from localhost (89-70-37-207.dynamic.chello.pl. [89.70.37.207])
        by smtp.gmail.com with ESMTPSA id r29-v6sm3339904ljd.44.2019.02.05.10.30.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Feb 2019 10:30:32 -0800 (PST)
Date:   Tue, 5 Feb 2019 19:30:09 +0100
From:   Tomasz Duszynski <tduszyns@gmail.com>
To:     Fabrice Gasnier <fabrice.gasnier@st.com>
Cc:     jic23@kernel.org, thierry.reding@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, alexandre.torgue@st.com,
        mcoquelin.stm32@gmail.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        vilhelm.gray@gmail.com, linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 2/4] pwm: stm32-lp: Add power management support
Message-ID: <20190205183005.GA13960@arch>
References: <1549370429-19116-1-git-send-email-fabrice.gasnier@st.com>
 <1549370429-19116-3-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1549370429-19116-3-git-send-email-fabrice.gasnier@st.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 05, 2019 at 01:40:27PM +0100, Fabrice Gasnier wrote:
> Add suspend/resume PM sleep ops. When going to low power, disable
> active PWM channel. Active PWM channel is resumed, by calling
> pwm_apply_state(). This is inspired by Thierry's comment in [1].
> Don't touch inactive channels, as it may be used by other LPTimer MFD
> child driver.
> [1]https://lkml.org/lkml/2017/12/5/175
>
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
>  drivers/pwm/pwm-stm32-lp.c | 38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>
> diff --git a/drivers/pwm/pwm-stm32-lp.c b/drivers/pwm/pwm-stm32-lp.c
> index 0059b24c..0c40d48 100644
> --- a/drivers/pwm/pwm-stm32-lp.c
> +++ b/drivers/pwm/pwm-stm32-lp.c
> @@ -13,6 +13,7 @@
>  #include <linux/mfd/stm32-lptimer.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> +#include <linux/pinctrl/consumer.h>
>  #include <linux/platform_device.h>
>  #include <linux/pwm.h>
>
> @@ -20,6 +21,8 @@ struct stm32_pwm_lp {
>  	struct pwm_chip chip;
>  	struct clk *clk;
>  	struct regmap *regmap;
> +	struct pwm_state suspend;
> +	bool suspended;
>  };
>
>  static inline struct stm32_pwm_lp *to_stm32_pwm_lp(struct pwm_chip *chip)
> @@ -223,6 +226,40 @@ static int stm32_pwm_lp_remove(struct platform_device *pdev)
>  	return pwmchip_remove(&priv->chip);
>  }
>
> +#ifdef CONFIG_PM_SLEEP

You might consider dropping ifdefs and marking pm functions with
__maybe_unused instead. In case CONFIG_PM_SLEEP=n then these two guys
will be removed and pm ops structure will be empty.

> +static int stm32_pwm_lp_suspend(struct device *dev)
> +{
> +	struct stm32_pwm_lp *priv = dev_get_drvdata(dev);
> +

I guess you first need to get platform_device from dev and eventually
stm32_pwm_lp. Wondering how this works now.

> +	pwm_get_state(&priv->chip.pwms[0], &priv->suspend);
> +	priv->suspended = priv->suspend.enabled;
> +
> +	/* safe to call pwm_disable() for already disabled pwm */
> +	pwm_disable(&priv->chip.pwms[0]);
> +
> +	return pinctrl_pm_select_sleep_state(dev);
> +}
> +
> +static int stm32_pwm_lp_resume(struct device *dev)
> +{
> +	struct stm32_pwm_lp *priv = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = pinctrl_pm_select_default_state(dev);
> +	if (ret)
> +		return ret;
> +
> +	/* Only restore suspended pwm, not to disrupt other MFD child */
> +	if (!priv->suspended)
> +		return 0;

Would it make sense to use suspend.enabled directly?

> +
> +	return pwm_apply_state(&priv->chip.pwms[0], &priv->suspend);
> +}
> +#endif
> +
> +static SIMPLE_DEV_PM_OPS(stm32_pwm_lp_pm_ops, stm32_pwm_lp_suspend,
> +			 stm32_pwm_lp_resume);
> +
>  static const struct of_device_id stm32_pwm_lp_of_match[] = {
>  	{ .compatible = "st,stm32-pwm-lp", },
>  	{},
> @@ -235,6 +272,7 @@ static int stm32_pwm_lp_remove(struct platform_device *pdev)
>  	.driver	= {
>  		.name = "stm32-pwm-lp",
>  		.of_match_table = of_match_ptr(stm32_pwm_lp_of_match),
> +		.pm = &stm32_pwm_lp_pm_ops,
>  	},
>  };
>  module_platform_driver(stm32_pwm_lp_driver);
> --
> 1.9.1
>

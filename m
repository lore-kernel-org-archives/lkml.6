Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02620C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 03:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EB592152E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 03:03:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tf5vz1Ks"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EB592152E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbeH0Grm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 02:47:42 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34480 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727078AbeH0Grm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 02:47:42 -0400
Received: by mail-pf1-f196.google.com with SMTP id k19-v6so7032691pfi.1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Aug 2018 20:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6eqJkEWAbrZfb0PGXw2aVbUsPAF/xyAX7BBHGGT4MAA=;
        b=Tf5vz1KswFylXzMDG9Wj81ss2lgFFhmDBKK2qpXzhfkXGyEQCIvJwiIBNYhsIxUkwi
         q6S2196MM8v3fFcVehmD0fVzYHyZGW6cE1HYsdcsbmJBBGzyxHYxZbI0MDw3ed9RUM9B
         uyMkIZRmP3C/lGas7d0MKjXbehND7wqtoAc+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6eqJkEWAbrZfb0PGXw2aVbUsPAF/xyAX7BBHGGT4MAA=;
        b=K5i771sHdzrtOXJxjmWVe4ZJftc+qgYPyry89ev5DTqkUhORovLujJUEI1PymZOVe6
         RCKnw3u6FNdHTI7rgAPVqG8pmfYTKJFehBlSfmnd3ttMhUH+gVAvQieB63wUMAu4QG1t
         dcH+gSdtJsGrEE61icILBVpzUbmNrYuWqcBcSj2PfRwh3oxsTbXLlt+KdDcXojoJj+CW
         3qaiXOCjm0FIS23fjw7bkPeLuTt+fy8onWEdgjEHCoP9VtrV4SMQABsGrggcJ0mYbMH1
         F2AIFTxukAWU2XKCJd9tT3+nugKcgesojxy2zR0Hv3LNHp4ZDCysWKdOFsC4FMpeodTa
         GM2w==
X-Gm-Message-State: APzg51D0NIYrma5gneKxTh9855jAJYI4GxVgjDW+dLT9exWGoJbgOIng
        mlR8DjM4Vw6uQrj1jQ+uLRg6qQ==
X-Google-Smtp-Source: ANB0VdaIG9Z7egODaf7lXlHObozpIYWYT1dx9zyeJX/mF+pBoeLl8+LcJveUsIW6A5f3Ghdaeykqww==
X-Received: by 2002:a62:1391:: with SMTP id 17-v6mr12213905pft.34.1535338982608;
        Sun, 26 Aug 2018 20:03:02 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id b73-v6sm14843370pfj.93.2018.08.26.20.03.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 26 Aug 2018 20:03:01 -0700 (PDT)
Date:   Sun, 26 Aug 2018 20:06:41 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v3 3/3] pinctrl: msm: Configure interrupts as input and
 gpio mode
Message-ID: <20180827030641.GJ3048@tuxbook-pro>
References: <20180816200648.90458-1-swboyd@chromium.org>
 <20180816200648.90458-4-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180816200648.90458-4-swboyd@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 16 Aug 13:06 PDT 2018, Stephen Boyd wrote:

> When requesting a gpio as an interrupt, we should make sure to mux the
> pin as the GPIO function and configure it to be an input so that various
> functions or output signals don't affect the interrupt state of the pin.
> So far, we've relied on pinmux configurations in DT to handle this, but
> let's explicitly configure this in the code so that DT implementers
> don't have to get this part right.
> 
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Doug Anderson <dianders@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/pinctrl/qcom/pinctrl-msm.c | 37 ++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
> index 793504057ad0..defed34d32b0 100644
> --- a/drivers/pinctrl/qcom/pinctrl-msm.c
> +++ b/drivers/pinctrl/qcom/pinctrl-msm.c
> @@ -837,6 +837,41 @@ static int msm_gpio_irq_set_wake(struct irq_data *d, unsigned int on)
>  	return 0;
>  }
>  
> +static int msm_gpio_irq_reqres(struct irq_data *d)
> +{
> +	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
> +	struct msm_pinctrl *pctrl = gpiochip_get_data(gc);
> +	int ret;
> +
> +	if (!try_module_get(gc->owner))
> +		return -ENODEV;
> +
> +	ret = msm_pinmux_request_gpio(pctrl->pctrl, NULL, d->hwirq);
> +	if (ret)
> +		goto out;
> +	msm_gpio_direction_input(gc, d->hwirq);
> +
> +	if (gpiochip_lock_as_irq(gc, d->hwirq)) {
> +		dev_err(gc->parent,
> +			"unable to lock HW IRQ %lu for IRQ\n",
> +			d->hwirq);
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +	return 0;
> +out:
> +	module_put(gc->owner);
> +	return ret;
> +}
> +
> +static void msm_gpio_irq_relres(struct irq_data *d)
> +{
> +	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
> +
> +	gpiochip_unlock_as_irq(gc, d->hwirq);
> +	module_put(gc->owner);
> +}
> +
>  static void msm_gpio_irq_handler(struct irq_desc *desc)
>  {
>  	struct gpio_chip *gc = irq_desc_get_handler_data(desc);
> @@ -935,6 +970,8 @@ static int msm_gpio_init(struct msm_pinctrl *pctrl)
>  	pctrl->irq_chip.irq_ack = msm_gpio_irq_ack;
>  	pctrl->irq_chip.irq_set_type = msm_gpio_irq_set_type;
>  	pctrl->irq_chip.irq_set_wake = msm_gpio_irq_set_wake;
> +	pctrl->irq_chip.irq_request_resources = msm_gpio_irq_reqres;
> +	pctrl->irq_chip.irq_release_resources = msm_gpio_irq_relres;
>  
>  	ret = gpiochip_add_data(&pctrl->chip, pctrl);
>  	if (ret) {
> -- 
> Sent by a computer through tubes
> 

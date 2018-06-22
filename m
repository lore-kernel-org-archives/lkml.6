Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC3FFC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 17:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 781E1246FC
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 17:56:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="debUvxWP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 781E1246FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934032AbeFVR4S (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 13:56:18 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:43025 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932973AbeFVR4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 13:56:16 -0400
Received: by mail-pf0-f196.google.com with SMTP id y8-v6so3553628pfm.10
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 10:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GuK5akyC11ueEqylpVazGP75t3BmgmkmespSzdAWnRY=;
        b=debUvxWPP/DIwQeSSkYewK43PUiwGfqDZDEE9mA1EWWkJQhhEOoXHQ00108G5TWudQ
         /+dqEYZ8BK2qJA7gTO5pIh6H94pIdYk+LtCsHKw3qnNrSPfSyNGnlTMdqWjjeivqYcnn
         kONXnt3nMS0v6WFoFwQ1dyTjnDOphN3H4fFnw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GuK5akyC11ueEqylpVazGP75t3BmgmkmespSzdAWnRY=;
        b=n75AppgMFkjKA48yTXlKp7SW07iYHvpJ5Wn97hTQuQZthrvEg8BU/3ZYplrrIKy9mE
         HUqWomvCmfoUabMakscDgYvh+DKqn6OndwMxXTke9ZwVdTPYMy0BoXfiYmYnY7xhjmGl
         z/jFy2V8l0ISXKWuv7lGC5g6TGexuFl6VImlfFSqCULrvhvY0NeceCPmewQLidYbJOsf
         kVI30WdI9prnYpt3XPXx+x4n3L14cOU/TwXyEcOT0GkOloRnA2/RExYl7ePm8O6olPgv
         w7go7IQ+n5zuRDsBypNeA0DiC3ZcEf8nZpCd584daWd9G4E3Qr/LXucdKivfa1T5MEwB
         9euQ==
X-Gm-Message-State: APt69E09WHlA7iX/tQO1eWS/vIg8tM0otTyZ1pGJ7XOZlFmnlyke71Eb
        lPDVMX7rQrsddincNOJyll5cDQ==
X-Google-Smtp-Source: ADUXVKKNpJ1BalFg+Ybf9uyfEsI2gMDKF0Oit/cWFA+rmocPWSY2+8/fgE5he+msgfqo45sJ56QNIw==
X-Received: by 2002:a62:993:: with SMTP id 19-v6mr2766237pfj.105.1529690175922;
        Fri, 22 Jun 2018 10:56:15 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id p73-v6sm21911411pfa.142.2018.06.22.10.56.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Jun 2018 10:56:14 -0700 (PDT)
Date:   Fri, 22 Jun 2018 10:58:36 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH 2/3] pinctrl: msm: Mux out gpio function with
 gpio_request()
Message-ID: <20180622175836.GC3402@tuxbook-pro>
References: <20180618205255.246104-1-swboyd@chromium.org>
 <20180618205255.246104-3-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180618205255.246104-3-swboyd@chromium.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 18 Jun 13:52 PDT 2018, Stephen Boyd wrote:

> We rely on devices to use pinmuxing configurations in DT to select the
> GPIO function (function 0) if they're going to use the gpio in GPIO
> mode. Let's simplify things for driver authors by implementing
> gpio_request_enable() for this pinctrl driver to mux out the GPIO
> function when the gpio is use from gpiolib.
> 
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> Cc: Doug Anderson <dianders@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/pinctrl/qcom/pinctrl-msm.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
> index 3563c4394837..eacfc5b85f7f 100644
> --- a/drivers/pinctrl/qcom/pinctrl-msm.c
> +++ b/drivers/pinctrl/qcom/pinctrl-msm.c
> @@ -176,11 +176,27 @@ static int msm_pinmux_set_mux(struct pinctrl_dev *pctldev,
>  	return 0;
>  }
>  
> +static int msm_pinmux_request_gpio(struct pinctrl_dev *pctldev,
> +				   struct pinctrl_gpio_range *range,
> +				   unsigned offset)
> +{
> +	struct msm_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
> +	const struct msm_pingroup *g = &pctrl->soc->groups[offset];
> +
> +	/* No funcs? Probably ACPI so can't do anything here */
> +	if (!g->nfuncs)
> +		return 0;
> +
> +	/* For now assume function 0 is GPIO because it always is */
> +	return msm_pinmux_set_mux(pctldev, 0, offset);
> +}
> +
>  static const struct pinmux_ops msm_pinmux_ops = {
>  	.request		= msm_pinmux_request,
>  	.get_functions_count	= msm_get_functions_count,
>  	.get_function_name	= msm_get_function_name,
>  	.get_function_groups	= msm_get_function_groups,
> +	.gpio_request_enable	= msm_pinmux_request_gpio,
>  	.set_mux		= msm_pinmux_set_mux,
>  };
>  
> -- 
> Sent by a computer through tubes
> 

Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BEA013F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 11:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB3C1208A1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 11:13:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="I8gi8z6l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB3C1208A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbeG3Mre (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 08:47:34 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34857 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbeG3Mre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 08:47:34 -0400
Received: by mail-wm0-f65.google.com with SMTP id o18-v6so13359737wmc.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 04:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uCdhdFY6DbFvcQej9Q3xvESg1fjy1AXLb3cYlSLsN1g=;
        b=I8gi8z6lV25HCk+fpjWFPaL4binQKd7d+dFOiAL1tVxoBlrRn1wp1Zkxful04EI22l
         h2nchDfK135TTInLtrBOijDopvuk6M6YMbnSjc7dRi1d5TZydBaPATjzYBH6PqNIDASi
         C7LJq6G9kgedsxX/hHFUy4LfLy27Q4br3SiyY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uCdhdFY6DbFvcQej9Q3xvESg1fjy1AXLb3cYlSLsN1g=;
        b=dUlRvi/62/tCZzY+Wspqhzjrhb2AJEdakYHWyPtcCblPRcWl2Lv0v7J0V8hknK28uJ
         ulhbxsfZDSpEKxzn/5JHsYg2OFW/+zY9ugf4HIfmoRQBMwqBkzRgwM89p6cQWaPYks22
         pWk1VR6aqg2JW1nXefya/D8awF6TOqodmTvsEmTq+euoi9mFldLgLFNrJrms4jv59sBz
         IWg5lXjBk6ej+nXvK97MZ3Gg8cFAMcZqsyNgiOsp0n0GFbtJhwZ7Wk8RQpuGG+SJZhSa
         5V4/KfLidD8su58UdCrEfU/Sm49kR4HHNo0I04EL4g/PcY2XgeHxS8ZwxzzEI9+s0YN1
         efCQ==
X-Gm-Message-State: AOUpUlFa3nBFtPmLe5BlgogToUM1Ki0gSoL/cH4esPmmMLXwVeAZdmwD
        TqSTvqHPVEguhZ/G8XIohbf51w==
X-Google-Smtp-Source: AAOMgpfEJSyoJ9cU7fndAJVxhv7hmd40mOY4SPz50hRDtYSz2tdRvBduYNnH+569Jm8XVSLvQ2yDHQ==
X-Received: by 2002:a1c:6d1c:: with SMTP id i28-v6mr15497389wmc.97.1532949183258;
        Mon, 30 Jul 2018 04:13:03 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id w23-v6sm6874336wmc.43.2018.07.30.04.13.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Jul 2018 04:13:02 -0700 (PDT)
Date:   Mon, 30 Jul 2018 12:12:59 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org, kernel@collabora.com,
        cl@rock-chips.com, linux-pwm@vger.kernel.org,
        linux-fbdev@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, Jingoo Han <jingoohan1@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2] backlight: pwm_bl: switch to using "atomic" PWM API
Message-ID: <20180730111259.5qjtchfo67nquila@holly.lan>
References: <20180727151121.12296-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180727151121.12296-1-enric.balletbo@collabora.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 05:11:21PM +0200, Enric Balletbo i Serra wrote:
> The "atomic" API allows us to configure PWM period and duty_cycle and
> enable it in one call.
> 
> The patch also moves the pwm_init_state just before any use of the
> pwm_state struct, this fixes a potential bug where pwm_get_state
> can be called before pwm_init_state.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> 
> Changes in v2:
> - Do not force the PWM be off in the first call to pwm_apply_state.
> - Delayed applying the state until we know what the period is.
> - Removed pb->period as after the conversion is not needed.

Re-reading this I have spotted a couple of things I probably could have
mentioned against v1... sorry.

I think it's looking good though, I expect to be able to ack v3.


>  drivers/video/backlight/pwm_bl.c | 71 ++++++++++++++++++--------------
>  1 file changed, 41 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
> index bdfcc0a71db1..dd1cb29b5332 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> @@ -28,7 +28,6 @@
>  struct pwm_bl_data {
>  	struct pwm_device	*pwm;
>  	struct device		*dev;
> -	unsigned int		period;
>  	unsigned int		lth_brightness;
>  	unsigned int		*levels;
>  	bool			enabled;
> @@ -46,7 +45,8 @@ struct pwm_bl_data {
>  	void			(*exit)(struct device *);
>  };
>  
> -static void pwm_backlight_power_on(struct pwm_bl_data *pb, int brightness)
> +static void pwm_backlight_power_on(struct pwm_bl_data *pb,
> +				   struct pwm_state *state)
>  {
>  	int err;
>  
> @@ -57,7 +57,8 @@ static void pwm_backlight_power_on(struct pwm_bl_data *pb, int brightness)
>  	if (err < 0)
>  		dev_err(pb->dev, "failed to enable power supply\n");
>  
> -	pwm_enable(pb->pwm);
> +	state->enabled = true;
> +	pwm_apply_state(pb->pwm, state);
>  
>  	if (pb->post_pwm_on_delay)
>  		msleep(pb->post_pwm_on_delay);
> @@ -70,6 +71,8 @@ static void pwm_backlight_power_on(struct pwm_bl_data *pb, int brightness)
>  
>  static void pwm_backlight_power_off(struct pwm_bl_data *pb)
>  {
> +	struct pwm_state state;
> +
>  	if (!pb->enabled)
>  		return;
>  
> @@ -79,8 +82,10 @@ static void pwm_backlight_power_off(struct pwm_bl_data *pb)
>  	if (pb->pwm_off_delay)
>  		msleep(pb->pwm_off_delay);
>  
> -	pwm_config(pb->pwm, 0, pb->period);
> -	pwm_disable(pb->pwm);
> +	pwm_get_state(pb->pwm, &state);
> +	state.enabled = false;
> +	state.duty_cycle = 0;
> +	pwm_apply_state(pb->pwm, &state);

This is an in exact conversion because this code ignores a failure to
set the duty cycle to zero whilst pwm_apply_state() does not.

This would only matter if pwm_config() returns an error and given that a
PWM which does not support a duty cycle of zero is permitted to adjust
zero to the smallest supported value there is no *need* for a driver to
return an error here. In other words... this is a subtle change of
behaviour and perhaps (even probably) irrelevant.

However I'm still interested whether you did any work to confirm or
deny whether drivers that reports error on zero duty cycle actually
exist.


>  	regulator_disable(pb->power_supply);
>  	pb->enabled = false;
> @@ -89,14 +94,17 @@ static void pwm_backlight_power_off(struct pwm_bl_data *pb)
>  static int compute_duty_cycle(struct pwm_bl_data *pb, int brightness)
>  {
>  	unsigned int lth = pb->lth_brightness;
> +	struct pwm_state state;
>  	u64 duty_cycle;
>  
> +	pwm_get_state(pb->pwm, &state);
> +
>  	if (pb->levels)
>  		duty_cycle = pb->levels[brightness];
>  	else
>  		duty_cycle = brightness;
>  
> -	duty_cycle *= pb->period - lth;
> +	duty_cycle *= state.period - lth;
>  	do_div(duty_cycle, pb->scale);
>  
>  	return duty_cycle + lth;
> @@ -106,6 +114,7 @@ static int pwm_backlight_update_status(struct backlight_device *bl)
>  {
>  	struct pwm_bl_data *pb = bl_get_data(bl);
>  	int brightness = bl->props.brightness;
> +	struct pwm_state state;
>  	int duty_cycle;
>  
>  	if (bl->props.power != FB_BLANK_UNBLANK ||
> @@ -118,8 +127,12 @@ static int pwm_backlight_update_status(struct backlight_device *bl)
>  
>  	if (brightness > 0) {
>  		duty_cycle = compute_duty_cycle(pb, brightness);
> -		pwm_config(pb->pwm, duty_cycle, pb->period);

In principle the same subtle change applies here... but if pwm_config()
reported an error here then the backlight probably didn't work before
your change either so less need to worry about it!


> -		pwm_backlight_power_on(pb, brightness);
> +		pwm_get_state(pb->pwm, &state);
> +		state.duty_cycle = duty_cycle;
> +		if (!state.enabled)
> +			pwm_backlight_power_on(pb, &state);

It verges towards nit picking but I don't really like the way a half updated
state is shared between ...update_status and ...power_on.

I'd rather it looked something like:

		pwm_get_state(pb->pwm, &state);
		if (!state.enabled) {
			pwm_backlight_power_on(pb);  <-- no sharing here,
			                                 make on match off
		} else {
			pwm_backlight_update_duty_cycle(pb, &state, brightness);
			pwm_apply_state(pb->pwm, &state);
		}
	
(and have pwm_backlight_power_on() also call ...update_duty_cycle too)

Thoughts?


Daniel.

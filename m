Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2EF1C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 08:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C5492172C
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 08:48:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YyO8u/oj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C5492172C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731244AbeHNLeb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 07:34:31 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:51003 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731117AbeHNLeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 07:34:31 -0400
Received: by mail-wm0-f67.google.com with SMTP id s12-v6so11464406wmc.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 01:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FiMxUa/VosdIO4ryXjJSgjyrZspZcVv4RNw+pzhBHBM=;
        b=YyO8u/ojDkVIpcIRNvNKRqwiujQp6lDnHgqU6gmkfn/8Sps8hOqPdkidJJ6Mgmee6q
         cbLeiF15rdMQKgOu42wX+zDKnbCgwfQqoqVKGEWXvKmMYb0xAvZ5zKcfqom1Gc5ZD5b7
         PIVMH+RnrhGQtMQ0AijIjhM4kOWwGGas4svBs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FiMxUa/VosdIO4ryXjJSgjyrZspZcVv4RNw+pzhBHBM=;
        b=ofchJ1XhvaixK/oQlHhePJIfN6gfbt3oTs/Zy95f+7eJyeWno+Jll7TsyhI8mvJoWX
         n6K/kocJbFnQXkZ6LE8ZrWbN78D0iUnFWWyuFOsGpTDxjf5b4SzhZ32HGdTpM63JKYGU
         ZohfIDhyHquaCsw3sw0+NEaYxXldZOAS2yOHP8G1xDT+oZWP3wcXq0wvjsWbnpNVBpgl
         pSBhcgIpEYlcPr3PJUyaSCcAa6ha++Juq5nRhgXMXcNS0+KLzkOSrvIXAJI8TNNme2Mt
         MiSL3Hbn8g8mReyQIe555d4YPj6J6t1K3M3k8SoL1sSmC4I21GvOeR7KVO8twLEy9Ioc
         N15A==
X-Gm-Message-State: AOUpUlER7GOrtAepedDv+szzvzhkGisOujVP6Um4x18hmQJTygHYciGj
        WDfDJm56EU1n1Y5mxje6z2ZD5w==
X-Google-Smtp-Source: AA+uWPzgQuPpCgGr0iGsYcEeptX0KNJj8vV8qZFVtpZUP1iOgvHNf+QCRuILZoRrNoNocLBh/xEFnw==
X-Received: by 2002:a1c:55c2:: with SMTP id j185-v6mr10501835wmb.104.1534236496852;
        Tue, 14 Aug 2018 01:48:16 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id m207-v6sm12386647wma.31.2018.08.14.01.48.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Aug 2018 01:48:15 -0700 (PDT)
Date:   Tue, 14 Aug 2018 09:48:13 +0100
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
Message-ID: <20180814084813.krmxiwux7ufcywaf@holly.lan>
References: <20180727151121.12296-1-enric.balletbo@collabora.com>
 <20180730111259.5qjtchfo67nquila@holly.lan>
 <d4f418dd-f5bb-c08a-e43b-f15fbc435961@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4f418dd-f5bb-c08a-e43b-f15fbc435961@collabora.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 07, 2018 at 11:38:04AM +0200, Enric Balletbo i Serra wrote:
> Hi Daniel,
> 
> On 30/07/18 13:12, Daniel Thompson wrote:
> > On Fri, Jul 27, 2018 at 05:11:21PM +0200, Enric Balletbo i Serra wrote:
> >> The "atomic" API allows us to configure PWM period and duty_cycle and
> >> enable it in one call.
> >>
> >> The patch also moves the pwm_init_state just before any use of the
> >> pwm_state struct, this fixes a potential bug where pwm_get_state
> >> can be called before pwm_init_state.
> >>
> >> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> >> ---
> >>
> >> Changes in v2:
> >> - Do not force the PWM be off in the first call to pwm_apply_state.
> >> - Delayed applying the state until we know what the period is.
> >> - Removed pb->period as after the conversion is not needed.
> > 
> > Re-reading this I have spotted a couple of things I probably could have
> > mentioned against v1... sorry.
> > 
> > I think it's looking good though, I expect to be able to ack v3.
> > 
> > 
> >>  drivers/video/backlight/pwm_bl.c | 71 ++++++++++++++++++--------------
> >>  1 file changed, 41 insertions(+), 30 deletions(-)
> >>
> >> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
> >> index bdfcc0a71db1..dd1cb29b5332 100644
> >> --- a/drivers/video/backlight/pwm_bl.c
> >> +++ b/drivers/video/backlight/pwm_bl.c
> >> @@ -28,7 +28,6 @@
> >>  struct pwm_bl_data {
> >>  	struct pwm_device	*pwm;
> >>  	struct device		*dev;
> >> -	unsigned int		period;
> >>  	unsigned int		lth_brightness;
> >>  	unsigned int		*levels;
> >>  	bool			enabled;
> >> @@ -46,7 +45,8 @@ struct pwm_bl_data {
> >>  	void			(*exit)(struct device *);
> >>  };
> >>  
> >> -static void pwm_backlight_power_on(struct pwm_bl_data *pb, int brightness)
> >> +static void pwm_backlight_power_on(struct pwm_bl_data *pb,
> >> +				   struct pwm_state *state)
> >>  {
> >>  	int err;
> >>  
> >> @@ -57,7 +57,8 @@ static void pwm_backlight_power_on(struct pwm_bl_data *pb, int brightness)
> >>  	if (err < 0)
> >>  		dev_err(pb->dev, "failed to enable power supply\n");
> >>  
> >> -	pwm_enable(pb->pwm);
> >> +	state->enabled = true;
> >> +	pwm_apply_state(pb->pwm, state);
> >>  
> >>  	if (pb->post_pwm_on_delay)
> >>  		msleep(pb->post_pwm_on_delay);
> >> @@ -70,6 +71,8 @@ static void pwm_backlight_power_on(struct pwm_bl_data *pb, int brightness)
> >>  
> >>  static void pwm_backlight_power_off(struct pwm_bl_data *pb)
> >>  {
> >> +	struct pwm_state state;
> >> +
> >>  	if (!pb->enabled)
> >>  		return;
> >>  
> >> @@ -79,8 +82,10 @@ static void pwm_backlight_power_off(struct pwm_bl_data *pb)
> >>  	if (pb->pwm_off_delay)
> >>  		msleep(pb->pwm_off_delay);
> >>  
> >> -	pwm_config(pb->pwm, 0, pb->period);
> >> -	pwm_disable(pb->pwm);
> >> +	pwm_get_state(pb->pwm, &state);
> >> +	state.enabled = false;
> >> +	state.duty_cycle = 0;
> >> +	pwm_apply_state(pb->pwm, &state);
> > 
> > This is an in exact conversion because this code ignores a failure to
> > set the duty cycle to zero whilst pwm_apply_state() does not.
> > 
> > This would only matter if pwm_config() returns an error and given that a
> > PWM which does not support a duty cycle of zero is permitted to adjust
> > zero to the smallest supported value there is no *need* for a driver to
> > return an error here. In other words... this is a subtle change of
> > behaviour and perhaps (even probably) irrelevant.
> > 
> > However I'm still interested whether you did any work to confirm or
> > deny whether drivers that reports error on zero duty cycle actually
> > exist.
> > 
> 
> Interesting, actually I don't have a use case for this, and I think that there
> is nothing in the kernel. I know that some devices (like chromebook minnie and
> jaq) the pwm must be >= 1% or 3% for the first non-zero value but I don't know
> any where 0 is a problem.
> 
> > 
> >>  	regulator_disable(pb->power_supply);
> >>  	pb->enabled = false;
> >> @@ -89,14 +94,17 @@ static void pwm_backlight_power_off(struct pwm_bl_data *pb)
> >>  static int compute_duty_cycle(struct pwm_bl_data *pb, int brightness)
> >>  {
> >>  	unsigned int lth = pb->lth_brightness;
> >> +	struct pwm_state state;
> >>  	u64 duty_cycle;
> >>  
> >> +	pwm_get_state(pb->pwm, &state);
> >> +
> >>  	if (pb->levels)
> >>  		duty_cycle = pb->levels[brightness];
> >>  	else
> >>  		duty_cycle = brightness;
> >>  
> >> -	duty_cycle *= pb->period - lth;
> >> +	duty_cycle *= state.period - lth;
> >>  	do_div(duty_cycle, pb->scale);
> >>  
> >>  	return duty_cycle + lth;
> >> @@ -106,6 +114,7 @@ static int pwm_backlight_update_status(struct backlight_device *bl)
> >>  {
> >>  	struct pwm_bl_data *pb = bl_get_data(bl);
> >>  	int brightness = bl->props.brightness;
> >> +	struct pwm_state state;
> >>  	int duty_cycle;
> >>  
> >>  	if (bl->props.power != FB_BLANK_UNBLANK ||
> >> @@ -118,8 +127,12 @@ static int pwm_backlight_update_status(struct backlight_device *bl)
> >>  
> >>  	if (brightness > 0) {
> >>  		duty_cycle = compute_duty_cycle(pb, brightness);
> >> -		pwm_config(pb->pwm, duty_cycle, pb->period);
> > 
> > In principle the same subtle change applies here... but if pwm_config()
> > reported an error here then the backlight probably didn't work before
> > your change either so less need to worry about it!
> > 
> > 
> >> -		pwm_backlight_power_on(pb, brightness);
> >> +		pwm_get_state(pb->pwm, &state);
> >> +		state.duty_cycle = duty_cycle;
> >> +		if (!state.enabled)
> >> +			pwm_backlight_power_on(pb, &state);
> > 
> > It verges towards nit picking but I don't really like the way a half updated
> > state is shared between ...update_status and ...power_on.
> > 
> > I'd rather it looked something like:
> > 
> > 		pwm_get_state(pb->pwm, &state);
> > 		if (!state.enabled) {
> > 			pwm_backlight_power_on(pb);  <-- no sharing here,
> > 			                                 make on match off
> > 		} else {
> > 			pwm_backlight_update_duty_cycle(pb, &state, brightness);
> > 			pwm_apply_state(pb->pwm, &state);
> > 		}
> > 	
> > (and have pwm_backlight_power_on() also call ...update_duty_cycle too)
> > 
> > Thoughts?
> 
> What about something like this:
> 
> static int pwm_backlight_update_status(struct backlight_device *bl)
> {
>         ...
> 
> 	if (brightness > 0) {
> 		pwm_get_state(pb->pwm, &state);
>                 /* we can get rid of duty_cycle temporal variable */
> 		state.duty_cycle = compute_duty_cycle(pb, brightness);
> 		pwm_apply_state(pb->pwm, &state);
> 		pwm_backlight_power_on(pb);
> 	} else
> 		pwm_backlight_power_off(pb);
>         ...
> }

This reads very well. I'm happy to go with this approach.


> static void pwm_backlight_power_on(struct pwm_bl_data *pb)
> {
> 	struct pwm_state state;
> 
> 	pwm_get_state(pb->pwm, &state);
> 
> 	if (state.enabled)
> 		return;
> 
>         ...
> 
> 	state.enabled = true;
> 	pwm_apply_state(pb->pwm, &state);
> 
>         ...
> }
> 
> static void pwm_backlight_power_off(struct pwm_bl_data *pb)
> {
> 	struct pwm_state state;
> 
>         ...
> 
> 	pwm_get_state(pb->pwm, &state);
> 	state.enabled = false;
> 	state.duty_cycle = 0;
> 	pwm_apply_state(pb->pwm, &state);
> 
>         ...
> }
> 
> And I think that we can get rid of pb->enabled variable.
> 
> Best regards,
>  Enric
> 
> > 
> > 
> > Daniel.
> > 

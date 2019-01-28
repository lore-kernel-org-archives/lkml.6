Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1660FC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 11:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D51B320882
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 11:05:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QjhfuOYV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726848AbfA1LFy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 06:05:54 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35074 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbfA1LFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 06:05:53 -0500
Received: by mail-wm1-f66.google.com with SMTP id t200so13504522wmt.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 03:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PB5pA5GKrN7y5OVHQcaOfdCOpg8Wl9SqU/L08GFqYsk=;
        b=QjhfuOYV8OofV2CJMprEm3LwJBR/f9YUZUpjS7rDuSciyY7uWnNShK1A++iahgx4oH
         DoTb9pj01Y/TP5Rve3jO7oOVmuUFW0GmrkGX95iwdENhUntGrHOZAYjLzUzOx2NKKtE0
         tVOzbnCavJskGdU7gJskYdCkL86j7WAmLeSEE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PB5pA5GKrN7y5OVHQcaOfdCOpg8Wl9SqU/L08GFqYsk=;
        b=q2/xETXilUJA3BvVQZXibVAZxZgYJCJQmE9D+GfqcM2P2Bor1n3/mTZORwUi/NAs9X
         AYRzunUnplCd9p0hDodqNXGjIb5X7sVJ2VbFQqUDVGQZmfiT6bZd1ND12EQ25MCsKcLX
         oY8EKwG8CecyNJZCYCkuuN+K5qlefKLPM8XVnORYqoHKR0ob9oTM0NKSMCa5BNj1Bdyh
         453tFpkrPOcZHhij4S4lChPPjAsoUqczP5WY2Ty2dHYPSaKh5yNBiDja/8n7eouG4oQ6
         /WxSht1/uRJHOQe7OU+LBiyMxb4NnNzB/lQ51KIUiAGqKecENhPjY+1BwqDeuqRHcvbj
         sCRQ==
X-Gm-Message-State: AJcUukcQXuDP1iKFHJ/bVyjisqJbS2Z3oh7KSCkd3D+Jr52PixNQwILs
        D3wo2TLJjTfx6G4Q3ZYeFmJGnA==
X-Google-Smtp-Source: ALg8bN4WCVRmPU+sOcpK9CFgRVVrDrZS1cFJuVU5CYSXY3XhObbuAVvbTj8r2rgPWdNW0QyfKTofDA==
X-Received: by 2002:a1c:bd86:: with SMTP id n128mr16506937wmf.22.1548673551767;
        Mon, 28 Jan 2019 03:05:51 -0800 (PST)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id j24sm139989260wrd.86.2019.01.28.03.05.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 03:05:50 -0800 (PST)
Date:   Mon, 28 Jan 2019 11:05:48 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, linux-pwm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] backlight: pwm_bl: Use gpiod_get_value_cansleep() to get
 initial state
Message-ID: <20190128110548.lqjgzxrppmezwtki@holly.lan>
References: <20190127145054.3770-1-wens@csie.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190127145054.3770-1-wens@csie.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 27, 2019 at 10:50:54PM +0800, Chen-Yu Tsai wrote:
> gpiod_get_value() gives out a warning if access to the underlying gpiochip
> requires sleeping, which is common for I2C based chips:
> 
>     WARNING: CPU: 0 PID: 77 at drivers/gpio/gpiolib.c:2500 gpiod_get_value+0xd0/0x100
>     Modules linked in:
>     CPU: 0 PID: 77 Comm: kworker/0:2 Not tainted 4.14.0-rc3-00589-gf32897915d48-dirty #90
>     Hardware name: Allwinner sun4i/sun5i Families
>     Workqueue: events deferred_probe_work_func
>     [<c010ec50>] (unwind_backtrace) from [<c010b784>] (show_stack+0x10/0x14)
>     [<c010b784>] (show_stack) from [<c0797224>] (dump_stack+0x88/0x9c)
>     [<c0797224>] (dump_stack) from [<c0125b08>] (__warn+0xe8/0x100)
>     [<c0125b08>] (__warn) from [<c0125bd0>] (warn_slowpath_null+0x20/0x28)
>     [<c0125bd0>] (warn_slowpath_null) from [<c037069c>] (gpiod_get_value+0xd0/0x100)
>     [<c037069c>] (gpiod_get_value) from [<c03778d0>] (pwm_backlight_probe+0x238/0x508)
>     [<c03778d0>] (pwm_backlight_probe) from [<c0411a2c>] (platform_drv_probe+0x50/0xac)
>     [<c0411a2c>] (platform_drv_probe) from [<c0410224>] (driver_probe_device+0x238/0x2e8)
>     [<c0410224>] (driver_probe_device) from [<c040e820>] (bus_for_each_drv+0x44/0x94)
>     [<c040e820>] (bus_for_each_drv) from [<c040ff0c>] (__device_attach+0xb0/0x114)
>     [<c040ff0c>] (__device_attach) from [<c040f4f8>] (bus_probe_device+0x84/0x8c)
>     [<c040f4f8>] (bus_probe_device) from [<c040f944>] (deferred_probe_work_func+0x50/0x14c)
>     [<c040f944>] (deferred_probe_work_func) from [<c013be84>] (process_one_work+0x1ec/0x414)
>     [<c013be84>] (process_one_work) from [<c013ce5c>] (worker_thread+0x2b0/0x5a0)
>     [<c013ce5c>] (worker_thread) from [<c0141908>] (kthread+0x14c/0x154)
>     [<c0141908>] (kthread) from [<c0107ab0>] (ret_from_fork+0x14/0x24)
> 
> This was missed in commit 0c9501f823a4 ("backlight: pwm_bl: Handle gpio
> that can sleep"). The code was then moved to a separate function in
> commit 7613c922315e ("backlight: pwm_bl: Move the checks for initial power
> state to a separate function").
> 
> The only usage of gpiod_get_value() is during the probe stage, which is
> safe to sleep in. Switch to gpiod_get_value_cansleep().
> 
> Fixes: 0c9501f823a4 ("backlight: pwm_bl: Handle gpio that can sleep")
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>


Acked-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.

> ---
>  drivers/video/backlight/pwm_bl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
> index feb90764a811..53b8ceea9bde 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> @@ -435,7 +435,7 @@ static int pwm_backlight_initial_power_state(const struct pwm_bl_data *pb)
>  	 */
>  
>  	/* if the enable GPIO is disabled, do not enable the backlight */
> -	if (pb->enable_gpio && gpiod_get_value(pb->enable_gpio) == 0)
> +	if (pb->enable_gpio && gpiod_get_value_cansleep(pb->enable_gpio) == 0)
>  		return FB_BLANK_POWERDOWN;
>  
>  	/* The regulator is disabled, do not enable the backlight */
> -- 
> 2.20.1
> 

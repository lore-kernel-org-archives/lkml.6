Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6053DC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ECC720989
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:36:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="L22TyK+P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbfA3NgK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 08:36:10 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51723 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbfA3NgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 08:36:09 -0500
Received: by mail-wm1-f67.google.com with SMTP id b11so21675481wmj.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 05:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=kFbF0FeQdzTBYlHXUUF6ycmN8fz5072JGBoOUv/RLLA=;
        b=L22TyK+Pp5MyMEIWLQ/6o4B19fMzOjUfQb45WtpQis4S5GiBj3sjAZMO9sR4hznDQr
         XVn7lMJkYd68xeX/M9qUQiOTa+2bxMRTUo9UrTA3J2DxvUa/ou5NTUrwTJqItDHlDLd7
         vE1z8ISo55pjn8PAHQNoIj74zMaNu8tcL5lig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=kFbF0FeQdzTBYlHXUUF6ycmN8fz5072JGBoOUv/RLLA=;
        b=VUmqt7Fgz7vvGG3H8ryglkE0PN9fBsGloXdAlN/6gbWm8tKgZpOx5M0YNNhNPgSUnr
         nkKNEfKsLVHrw1oCGdt0+wJutp770Dz+Ywlq3LqZs/EjJ3vkZxtn2BVVs++2DsCGBeEA
         D390wqcG6S1Ox2laWFWTA2k67LZzllJp5fk/JCEeemr3vmTG3Na7OmzKwIJav36cZ2rz
         YiB+yaoHl3oZSKfHUTmWzLiIH6wdHY7smWXykjtuFRZctLTEeqOoo09qVVP9ON+C8Kmg
         gaO11sjdYi0g0kMxfo6Gjn2jhv4lgINzVBk2jkVl7KgvYazbA623nWs2tLwrVzRP2bMh
         YeWw==
X-Gm-Message-State: AJcUukcljwVamIsk3l1GOWsyX3rJfIS4xfqNUlX9xiJ5D2GBaILYa7ry
        3Cm4oneq5saJoxzYD7dbZISzsg==
X-Google-Smtp-Source: ALg8bN4VtjNtbVtDaN9mwpjT06cXPYYAjsqAaMjvkpo5bcBe/H1rp0A7G3j+i4Sloge30ojDL6i21w==
X-Received: by 2002:a1c:19c2:: with SMTP id 185mr26252266wmz.8.1548855367053;
        Wed, 30 Jan 2019 05:36:07 -0800 (PST)
Received: from dell ([2.27.35.198])
        by smtp.gmail.com with ESMTPSA id f191sm2268436wmg.12.2019.01.30.05.36.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Jan 2019 05:36:06 -0800 (PST)
Date:   Wed, 30 Jan 2019 13:36:05 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, linux-pwm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] backlight: pwm_bl: Use gpiod_get_value_cansleep() to get
 initial state
Message-ID: <20190130133605.GI4701@dell>
References: <20190127145054.3770-1-wens@csie.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190127145054.3770-1-wens@csie.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Jan 2019, Chen-Yu Tsai wrote:

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
> ---
>  drivers/video/backlight/pwm_bl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

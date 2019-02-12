Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C16C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 09:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BAC021773
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 09:08:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fGEQslgv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728606AbfBLJIf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 04:08:35 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35488 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728289AbfBLJIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 04:08:35 -0500
Received: by mail-wr1-f67.google.com with SMTP id t18so1795711wrx.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 01:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+BEHkIPnxNuYl01r30SPtz0G+P4sqTbcQQD+CaNVvT0=;
        b=fGEQslgvp5BuSUYCAlrp/WIkjDro0BmuGUycmttu3qbr32RQC77zY6M2V8+Sy/1DP8
         o37yH47oltnsZWNqbrSIlxh1VUCB/WQnYT1RemwwMHRTa4ryksN5jqBfwNdAcX+lSIZJ
         ZQjQgFYRDfAMkgi+3DRLibAljYaAxWnJq2XmTsxv6mW0pYllR0gCUPtjWiftrJomTifF
         W0lvxP/qizR+yl92mL3yK/HiLvath+AR/2PiaKh71PRS14JqqkxS7zNKggJeVoYQKZKp
         zUHUF18T3BN7a+cc1u0EZi6+6oAlrZUlvKPvbv9/s+QlzAfJ5DHSRnZG9TwWJE5Suyhl
         6UgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+BEHkIPnxNuYl01r30SPtz0G+P4sqTbcQQD+CaNVvT0=;
        b=o5Vbgc18CJx67tselEf3gXSY3mHsDmCrKMcf97CIR4BBneJFmlnE2aqroXfTaH/OZt
         Zmam2K6vAm6kfRl52RoqKA59G2i40x2DjMNDi6HDo5B4J4SNom7VHvd/IU21kUXVUeQe
         j1Wpa3098A0NIOsz43EOQ/QVj9rDsaVTDqu20u0pG8s5SnB3dSwnLW0Pnr/iK3Or9Ieu
         NupPAValPdl95feF0zJ/zhUuyZa+a6xLdkrAAok05m/eeKhWvFA6Mamr6Eh+ofqBsz3b
         OUnA6awtyQoSLChM7Z3Mx42JZg2VX4AnKP7LFYRjEZZ6YbGxlT5pHSlxrxkR3UpMn+xx
         lBPA==
X-Gm-Message-State: AHQUAub3erZ7EK1zOLau4zxZSzvR+NLNIJRQlD7Z9fWDN8rY+aW2zzIt
        dzzfh0+jKFQrmJpYoj0ZDUIfog==
X-Google-Smtp-Source: AHgI3Ia9S+X22vR7/yzpqJkACZGunUCgZnKuZ26IMIVPZhvf+gDHAdSfHEY4KiVOJZn4KkjiRMdX2g==
X-Received: by 2002:a5d:4149:: with SMTP id c9mr2118936wrq.58.1549962512843;
        Tue, 12 Feb 2019 01:08:32 -0800 (PST)
Received: from [192.168.27.65] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id r22sm2566097wmh.2.2019.02.12.01.08.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 01:08:31 -0800 (PST)
Subject: Re: [PATCH 1/3] clocksource: timer-ti-dm: Fix pwm dmtimer usage of
 fck reparenting
To:     Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org
Cc:     linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "H . Nikolaus Schaller" <hns@goldelico.com>,
        Keerthy <j-keerthy@ti.com>,
        Ladislav Michl <ladis@linux-mips.org>,
        Pavel Machek <pavel@ucw.cz>,
        Sebastian Reichel <sre@kernel.org>,
        Tero Kristo <t-kristo@ti.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
References: <20190122175717.13428-1-tony@atomide.com>
 <20190122175717.13428-2-tony@atomide.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <00e47cf9-b444-4fcf-0d1a-11ff61edf008@linaro.org>
Date:   Tue, 12 Feb 2019 10:08:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190122175717.13428-2-tony@atomide.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/01/2019 18:57, Tony Lindgren wrote:
> Commit 84badc5ec5fc ("ARM: dts: omap4: Move l4 child devices to probe
> them with ti-sysc") moved some omap4 timers to probe with ti-sysc
> interconnect target module. Turns out this broke pwm-omap-dmtimer
> where we now try to reparent the clock to itself with the following:
> 
> omap_dm_timer_of_set_source: failed to set parent
> 
> With ti-sysc, we can now configure the clock sources in the dts
> with assigned-clocks and assigned-clock-parents. So we should be able
> to remove omap_dm_timer_of_set_source with clean-up patches later on.
> But for now, let's just fix it first by checking if parent and fck
> are the same and bail out of so.
> 
> Fixes: 84badc5ec5fc ("ARM: dts: omap4: Move l4 child devices to probe
> them with ti-sysc")
> Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: H. Nikolaus Schaller <hns@goldelico.com>
> Cc: Keerthy <j-keerthy@ti.com>
> Cc: Ladislav Michl <ladis@linux-mips.org>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: Tero Kristo <t-kristo@ti.com>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Reported-by: H. Nikolaus Schaller <hns@goldelico.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---

Do you want me to take it through my tree (1 et 3)?

>  drivers/clocksource/timer-ti-dm.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
> --- a/drivers/clocksource/timer-ti-dm.c
> +++ b/drivers/clocksource/timer-ti-dm.c
> @@ -154,6 +154,10 @@ static int omap_dm_timer_of_set_source(struct omap_dm_timer *timer)
>  	if (IS_ERR(parent))
>  		return -ENODEV;
>  
> +	/* Bail out if both clocks point to fck */
> +	if (clk_is_match(parent, timer->fclk))
> +		return 0;
> +
>  	ret = clk_set_parent(timer->fclk, parent);
>  	if (ret < 0)
>  		pr_err("%s: failed to set parent\n", __func__);
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


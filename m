Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D09CC5AE5E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 20:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 415742075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 20:42:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KXd+VxqB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 415742075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030526AbeFSUmv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 16:42:51 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:39682 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030301AbeFSUmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 16:42:46 -0400
Received: by mail-wm0-f65.google.com with SMTP id p11-v6so2819385wmc.4;
        Tue, 19 Jun 2018 13:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4kb8jX0fj7/zKcUgHAd51nupuXpqT5jMT/7PD+5Ritk=;
        b=KXd+VxqBZK0dBzr44jEU8ykehkkuRJy98yooxDA+WhZAK1RjC581zmMbyeXFbZ4Gwh
         2YZ963/ruyyOskmCVZeiVrKSRvTPi6wBDmCojjyVP5eDX+7bY+D+EkpqqfctXv83Bj+F
         OrKPMxx3oxwGYiVmm4iXtjTAHJIYaJtsIvcsqYPSugT9svuJM/l2JT98EdgFZFA5PNok
         EAWbtB0RXdwml5MxvVk2R2jCpliONcLvVFdfChszWgS1uG5amMtQJZo2f3gE6tEVo7dh
         dTOdGDmkwC9w+p7To0oFhhRlFFPMfu6Q/K5u4ZVZCOSiTbqvN6ube47DQvlDdkl1Nnag
         RYNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4kb8jX0fj7/zKcUgHAd51nupuXpqT5jMT/7PD+5Ritk=;
        b=D1Q8an9ZLyMh68dxMPwUWsRrRxj31uifgoiy6t0+Oy+guCknPXYaxo/58VGa1cbp3D
         DywW/Osbk3O7+JahQQZMurin0wuxgi23A8Uwnj6cTrX6zidiS11XG3SlKApM/ir0lyCs
         iX/0yB/em7iHRSeAdxHPbKU5uVLqCGT5wyDtGQ9C+6QfhlmszrqxS8tihPBO2ONL+XXl
         haCF+sQMI9FmHfmqHfCSCKC8ViItqD3qMdo/4f7+/C80Rm5xrA6iJ3svRJH2/RUN79Jk
         o2hbWednMHmAFgekSHqpDmiW2PG4yB0KsMABjDtYDnHf+eCxZdbpHUdH+yyX2UFEVtSG
         Fzug==
X-Gm-Message-State: APt69E2teCJF+n2YnGKODTx3Xxv7RyYuuC5rxCjka4lbCcegwxxTORvj
        bG8B2KSp5xigty2AGu2YcRFyMCQm
X-Google-Smtp-Source: ADUXVKJ4fOLBrVE5BN45Yw3pBFDWpKaT5iPaiHyUKOoqtcWRoPnjisxKH6hIgGS02Qdj21OTf0B0Hw==
X-Received: by 2002:a1c:150:: with SMTP id 77-v6mr13799975wmb.3.1529440964716;
        Tue, 19 Jun 2018 13:42:44 -0700 (PDT)
Received: from [192.168.1.18] (cji5.neoplus.adsl.tpnet.pl. [83.31.58.5])
        by smtp.gmail.com with ESMTPSA id b124-v6sm1505409wmf.11.2018.06.19.13.42.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 13:42:43 -0700 (PDT)
Subject: Re: [PATCH] [v2] leds: ledtrig-activity: use ktime_get_boot_ns()
To:     Arnd Bergmann <arnd@arndb.de>, Pavel Machek <pavel@ucw.cz>
Cc:     y2038@lists.linaro.org, Willy Tarreau <w@1wt.eu>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180619082215.2990745-1-arnd@arndb.de>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <32253e65-4f59-f332-d631-2d5f496a0ac7@gmail.com>
Date:   Tue, 19 Jun 2018 22:42:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180619082215.2990745-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

Thank you for the update.

On 06/19/2018 10:18 AM, Arnd Bergmann wrote:
> get_monotonic_boottime() is deprecated, so let's convert this to
> the simpler ktime_get_boot_ns().
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v2: don't drop 'cpus' multiplication, as Pavel and Willy point out
>      that needs to be kept
> ---
>   drivers/leds/trigger/ledtrig-activity.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/leds/trigger/ledtrig-activity.c b/drivers/leds/trigger/ledtrig-activity.c
> index 5081894082bd..6c6f8a9b8d9a 100644
> --- a/drivers/leds/trigger/ledtrig-activity.c
> +++ b/drivers/leds/trigger/ledtrig-activity.c
> @@ -37,7 +37,6 @@ static void led_activity_function(struct timer_list *t)
>   	struct activity_data *activity_data = from_timer(activity_data, t,
>   							 timer);
>   	struct led_classdev *led_cdev = activity_data->led_cdev;
> -	struct timespec boot_time;
>   	unsigned int target;
>   	unsigned int usage;
>   	int delay;
> @@ -57,8 +56,6 @@ static void led_activity_function(struct timer_list *t)
>   		return;
>   	}
>   
> -	get_monotonic_boottime(&boot_time);
> -
>   	cpus = 0;
>   	curr_used = 0;
>   
> @@ -76,7 +73,7 @@ static void led_activity_function(struct timer_list *t)
>   	 * down to 16us, ensuring we won't overflow 32-bit computations below
>   	 * even up to 3k CPUs, while keeping divides cheap on smaller systems.
>   	 */
> -	curr_boot = timespec_to_ns(&boot_time) * cpus;
> +	curr_boot = ktime_get_boot_ns() * cpus;
>   	diff_boot = (curr_boot - activity_data->last_boot) >> 16;
>   	diff_used = (curr_used - activity_data->last_used) >> 16;
>   	activity_data->last_boot = curr_boot;
> 

Applied.

-- 
Best regards,
Jacek Anaszewski

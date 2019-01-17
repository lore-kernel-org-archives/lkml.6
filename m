Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F5E6C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 05:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB832205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 05:49:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fTr8ggFX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729602AbfAQFtV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 00:49:21 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43898 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728499AbfAQFtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 00:49:20 -0500
Received: by mail-pg1-f195.google.com with SMTP id v28so3917852pgk.10
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 21:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pV6w5zBcNIn0CdpE5qe/bD/3UXSmkBbu0VG7ZuQvYuY=;
        b=fTr8ggFXr8imKvwEeXvT3sJLlPZ855lkgIwHk5uMrrxvzmzvKA6WBHYOzHUhSqhXdO
         DCQzPxryyf+rD2m1m3CjBrkcjgcBcNLyyJS7LtwWWrfilhqU2dSPeWeyDu8XRVCMN1vO
         gRt0X6TVnVRcK7nGWceg/nsfIJzu4lTsPcug0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pV6w5zBcNIn0CdpE5qe/bD/3UXSmkBbu0VG7ZuQvYuY=;
        b=gKeH+AkmXsh0rPkg/TDig686ARgCTXHPYVFjd/v6caSIQRvC1e4PROc5K5FvfqaKFS
         2cPs6DL6xD6WBy5NXJWSNftX6cU2QxcMCVrSjHhGPn7W5dZMFt5YQ+/B6S+aXpuZEXr2
         SNAIQb5ohzE4UjRVfBCxyubOvL7n7tg3zTB2tPod+A+GNkZAcXPHWJyBt3XKq49CMitG
         qABKtBu1HPrSOjCj2fbzSuGZ/9IBIpxb6gPmlVynWocmIE1mtvLgEkOmyESswqQzHEeR
         +m1Fl1C1TFfTxUaPu0t+MefF4uac6Ci5NStfu3ZQ1JPhT72w6FInOp5Fwz954XVy5/2U
         a1Jw==
X-Gm-Message-State: AJcUukeGscLXXFVKdv3gOiMoDF3p5a6d44COdy3Bz+7OMQ2ZwzN6YHkw
        /RCOKeN9EHgWhoH3/jfEvEi3ug==
X-Google-Smtp-Source: ALg8bN66gAIX4K4TNYh79R+zB3Fqideh9PQeveVNZqZiwUrZThY1JOWpHygd5CFfSW9Pwh9Ka27M2g==
X-Received: by 2002:a63:e445:: with SMTP id i5mr12234356pgk.307.1547704159184;
        Wed, 16 Jan 2019 21:49:19 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id a17sm643310pgm.26.2019.01.16.21.49.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 21:49:18 -0800 (PST)
Date:   Thu, 17 Jan 2019 11:19:16 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        edubezval@gmail.com, swboyd@chromium.org, dianders@chromium.org,
        mka@chromium.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "open list:CPU FREQUENCY DRIVERS" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v1 00/10] cpufreq: Add flag to auto-register as cooling
 device
Message-ID: <20190117054916.dqduckt7larn32av@vireshk-i7>
References: <cover.1547481320.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1547481320.git.amit.kucheria@linaro.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-01-19, 22:04, Amit Kucheria wrote:
> Add a flag to be used by cpufreq drivers to tell cpufreq core to
> auto-register themselves as a thermal cooling device.
> 
> There series converts over all the drivers except arm_big_little.c.
> Tested on SDM845 with the qcom-cpufreq-hw driver. Only compile-tested the
> others. 
> 
> Things needing fixing:
>  - Look at how to detect that we're not in IKS mode in arm_big_little's
>    .ready callback.

is_bL_switching_enabled() lets you know if IKS is enabled or not.
Set/clear flag conditionally before the cpufreq-driver is registered,
based on the output of is_bL_switching_enabled().

>  - The other pending issue is to fix allmodconfig that leaves us with
>    CPU_FREQ=y and THERMAL=m (CPU_THERMAL=y). That leads to undefined
>    references for functions defined in cpu_cooling.c

Okay, that's a terrible thing and the solution looks to be rather
difficult.

For others who may not be aware of the issue here, currently the
cpufreq drivers use helpers of cpu_cooling.c (CONFIG_CPU_THERMAL),
which uses helpers of the thermal core (CONFIG_THERMAL).
CONFIG_THERMAL is defined as tristate and CONFIG_CPU_THERMAL as bool
in Kconfigs.

The cpufreq drivers using the cpu_cooling.c file have this in their
Kconfig entry:

# if CPU_THERMAL is on and THERMAL=m, ARM_BIT_LITTLE_CPUFREQ cannot be =y
#       depends on !CPU_THERMAL || THERMAL


This series now places the cpufreq core in place of the cpufreq driver
and it messes up everything. It is not just about allmodconfig, but
any configuration which makes the compilation fail.

What are the solutions we have now ?

1. Have following for CONFIG_CPU_FREQ
       depends on !CPU_THERMAL || THERMAL

   The platforms which don't need CPU_THERMAL (like x86) should not
   enable CPU_THERMAL anymore if they want CONFIG_THERMAL=m.

   @amit: If this gets accepted, please update the Kconfig entries for
   all those drivers to not have above lines anymore.

- Change CONFIG_THERMAL to bool instead of tristate ?

- Anything else ?

-- 
viresh

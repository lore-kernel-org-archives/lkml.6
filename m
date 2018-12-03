Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6604BC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1779520851
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:07:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aqGzTNGk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1779520851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbeLCKH7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 05:07:59 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55174 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbeLCKH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 05:07:59 -0500
Received: by mail-wm1-f67.google.com with SMTP id z18so5088271wmc.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 02:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=s4VcA+gm2jxL7FKXBfTK7DFS0BlTv9gMpYsgHKyHYhY=;
        b=aqGzTNGk6u1UoQJNWLDEShmgaMTogovhmutyJy6dDD8ju2G4tPRJ8aAFYUWMcuycv/
         /zbswGYBI02sByOkxZlbfJ3C60d0Yrqr2D886ruS8v3/3ApoNCSSHhngR3hs/IAbQhDf
         5zlM+VfYp4w8ZHuIPUovzoNp29F5yypZw4TzE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=s4VcA+gm2jxL7FKXBfTK7DFS0BlTv9gMpYsgHKyHYhY=;
        b=Tz7eyLXa2NLBSeel75q5uap60dr5+wKBp7s3bFQ39kKg8dd+n9KYmXVUbWb+18WOFC
         cbA5Xi8HFTYjp9tKgepifuTu9V/nVV/J0w1lCO1J0TBCJJIQeb2Q5flqPD4s/JM4N+ja
         Pqm4KJ3Lu7/ay6904sazGeDicnuAtBdU01WP8OLH64tjPC2uGzpPkDZyJ31OFS5Efmur
         y22t/JZcAVVj1A2NmY5GUUMRJalqhA297mInGIHeiJocewYwRs0Rw4oSRCzTFyE+YwRz
         6RMiWl1pSiCMhIhWs2V5J9/Mx9uzx9GZsq8k9qNTSABp8zw8QYjNv3WhbLE8jyyYOf3J
         p1Xg==
X-Gm-Message-State: AA+aEWY+7Coaoxa6DCzCxe27owVtquHDoahGtBjzXEyHO1VkTkv40SIa
        MyOEgNKNRIfj+WERBAOyszjtKg==
X-Google-Smtp-Source: AFSGD/WwBBXD0MMJGYgcgPqLBsjKiGirmpGOYHtlChDk8wQgnNDJ2XCDubmiPwnXoumWXKTXhnzr7Q==
X-Received: by 2002:a7b:c44d:: with SMTP id l13mr7752446wmi.144.1543831655632;
        Mon, 03 Dec 2018 02:07:35 -0800 (PST)
Received: from [192.168.0.40] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id r3sm10782412wrs.78.2018.12.03.02.07.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 02:07:35 -0800 (PST)
Subject: Re: [PATCH] sched/cpufreq: Add the SPDX tags
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org, mingo@kernel.org, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>
References: <1539892534-16917-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <e21423b4-ec9c-ae6e-0b1f-c33e659b3cb0@linaro.org>
Date:   Mon, 3 Dec 2018 11:07:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1539892534-16917-1-git-send-email-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/10/2018 21:55, Daniel Lezcano wrote:
> The SPDX tags are not present in cpufreq.c and cpufreq_schedutil.c.
> 
> Add them and remove the license descriptions
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Hi Rafael,

I think this patch passed between the cracks.

 -- Daniel

> ---
>  kernel/sched/cpufreq.c           | 5 +----
>  kernel/sched/cpufreq_schedutil.c | 5 +----
>  2 files changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/sched/cpufreq.c b/kernel/sched/cpufreq.c
> index 5e54cbc..22bd898 100644
> --- a/kernel/sched/cpufreq.c
> +++ b/kernel/sched/cpufreq.c
> @@ -1,12 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * Scheduler code and data structures related to cpufreq.
>   *
>   * Copyright (C) 2016, Intel Corporation
>   * Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
>   */
>  #include "sched.h"
>  
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 3fffad3..626ddd4 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -1,12 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * CPUFreq governor based on scheduler-provided CPU utilization data.
>   *
>   * Copyright (C) 2016, Intel Corporation
>   * Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
>   */
>  
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


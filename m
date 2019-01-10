Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01950C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 01:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0B892173B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 01:02:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Zm7h3nM7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726914AbfAJBCA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 20:02:00 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45836 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbfAJBB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 20:01:59 -0500
Received: by mail-pf1-f196.google.com with SMTP id g62so4466392pfd.12
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 17:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=48k2tfaVkuCjX7VKHs5SKEon79tbbADS21HoSx9XbYs=;
        b=Zm7h3nM7Oxsfn63RSiUAUSVpIoBUwNghwQVWiNL4Zje04a4iv0ybhz7LbZZdnK/bJz
         kXNahSp93yqYLyt6rjU/1yVl3oBZ9UScOCFQB/YM+zNZIk8P7KlTiMoiANTadEMH61r4
         tCZeK0ZwVQ3o3HVQ9kPo5l7Wl6k8mPfliSCR0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=48k2tfaVkuCjX7VKHs5SKEon79tbbADS21HoSx9XbYs=;
        b=fCTY6hD7THOPVaRrkaE7ZsspbXDzVQmjvL8AiMqaWR7dk1SeOylvY1GA+bMPybMBN0
         9adJybYM71cgoSWGwepna62DgAzBU16BpdKvDOjNoW5ewxThPbzcq1M7rlvX6qtTV5mC
         x8XcTTcRyYL9o5UqTYuM7SXNkpY7N30sRDM+eDd274R6opf59KGZNy/PqR9hLTtsw7Tw
         byaANaCYoAsAm1U14sQmr5hQ07ykJtiAeD5GVGDCUEUAOUcHtsvyrwpHeILzPhKNyX7o
         dWLb6Y+sBhXn0L227P1y906sQ07L77Mr6/FV2DhePtthGjaerrq6vzHqb67J5Ce767Rr
         95cw==
X-Gm-Message-State: AJcUukcNIFZqf1dxlkGO8uocSZrmpZD8G4A7/PskBB+7eOfJU3MrVFVZ
        8U1LLPv3jrmFOHC9PXc7M7d9MA==
X-Google-Smtp-Source: ALg8bN6cM+lIuU2ZocSKkCf4i9N6Lq8OQF3vfWEY1b0fpHL8mEUwOUyt77ruQwqEUmKgvS0Wu2AQRw==
X-Received: by 2002:a62:d448:: with SMTP id u8mr8128840pfl.105.1547082118779;
        Wed, 09 Jan 2019 17:01:58 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id t24sm97327224pfh.21.2019.01.09.17.01.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Jan 2019 17:01:58 -0800 (PST)
Date:   Wed, 9 Jan 2019 17:01:57 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, viresh.kumar@linaro.org,
        edubezval@gmail.com, andy.gross@linaro.org, tdas@codeaurora.org,
        swboyd@chromium.org, dianders@chromium.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "open list:CPU FREQUENCY DRIVERS" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v1 2/7] drivers: cpufreq: Add thermal_cooling_device
 pointer to struct cpufreq_policy
Message-ID: <20190110010157.GU261387@google.com>
References: <cover.1547078153.git.amit.kucheria@linaro.org>
 <aadc9cff04dc310138b41979239ce51938afedce.1547078153.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aadc9cff04dc310138b41979239ce51938afedce.1547078153.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 05:30:51AM +0530, Amit Kucheria wrote:
> Several cpufreq drivers register themselves as thermal cooling devices.
> Adding a pointer to struct cpufreq_policy removes the need for them to
> store this pointer in a private data structure.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  include/linux/cpufreq.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index c86d6d8bdfed..2496549d7573 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -95,6 +95,8 @@ struct cpufreq_policy {
>  	struct cpufreq_frequency_table	*freq_table;
>  	enum cpufreq_table_sorting freq_table_sorted;
>  
> +	struct thermal_cooling_device *cooldev; /* Pointer to the cooling
> +						 * device if used for thermal mitigation */
>  	struct list_head        policy_list;
>  	struct kobject		kobj;
>  	struct completion	kobj_unregister;

I've mixed feelings about this. It's definitely desirable to avoid
code duplication and tying the cooling device to the cpufreq_policy is
a convenient way to achieve that. However semantically it seems a bit
odd that a CPU cooling device is part of the cpufreq policy.

Anyway, unless there are better ideas we probably want to be pragmatic
here, so if Viresh is fine with it who am I to complain ;-)

Cheers

Matthias



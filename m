Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F85C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 09:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96391214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 09:53:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MHiVgAr5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbfAJJxD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 04:53:03 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45347 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727893AbfAJJxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 04:53:03 -0500
Received: by mail-wr1-f67.google.com with SMTP id t6so10547758wrr.12
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 01:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1yZeSQ30Tm3iQTm/rUp7onyO024u+ZimzqVhFCVCuko=;
        b=MHiVgAr5pNCGMB6Anhh08zm1kC5DABTYtg0VeBAJhphngUdmjoKrZ1D/7Q9RJQ3Xjs
         v6L51ctDvbHwTOCcDtj/gBk5ebGtjtqYuIkFYFEyt41aMzjqOZamIMWYTjKwAzKAG2Jv
         2qq/90MJNH7qgpGYT3PjC7UDyHSRgWvFyqkWw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1yZeSQ30Tm3iQTm/rUp7onyO024u+ZimzqVhFCVCuko=;
        b=i5PHpEJn5VOWTCjHehWADvhUl05prsxAnJ64fR/xI434SJDansud1MTxfK+C82KD4H
         iUcrDbvbYk2LlL06Pkm8AK5UavaG0RhHpcISuMrY/2R31VWCVzwZh/qRbvu22JL8ik+g
         uDJZ8W08CC4eDONnZsWxUtjl8vMWm7hW2NnI0S1nljnL5LT16v0vj5+AJQIPPhzyHpmu
         fNa1EVGfbvMbiMRVlKnfwa9JNpAJm7jnOX2QIKEjLBYMY5Lq/1ZJdFY+4cf5oxIjlprC
         2qjSva6I8JMDIqRn3j9xWtnQHPqMxfPcKTG0Cnh7Z8rcxGVSvAOmPjZ4SqAdZwLFfJ7g
         fkaw==
X-Gm-Message-State: AJcUukdg7ohhSb1GhE/Gp5Bi/PZAVYW4mng/Vp5C/Kc32ZmEKddUXZea
        VXVrNDEwRvdp3vAF2oFcM33uWg==
X-Google-Smtp-Source: ALg8bN43A6rV/sr9W9NC81jeAmDcXFAHQz0/dzhgUPv241lo99pVPUNS5G8sc1BFdmzwpWbLMRLU5Q==
X-Received: by 2002:adf:db01:: with SMTP id s1mr8217466wri.214.1547113981038;
        Thu, 10 Jan 2019 01:53:01 -0800 (PST)
Received: from [192.168.0.41] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id 133sm19771317wme.9.2019.01.10.01.52.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jan 2019 01:53:00 -0800 (PST)
Subject: Re: [PATCH v2] cpuidle: Add 'above' and 'below' idle state metrics
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     Doug Smythies <dsmythies@telus.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <3514439.dzOWKx1Cjx@aspire.rjw.lan>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <e89ee355-3d87-1fe7-a1ff-91a1dd43177b@linaro.org>
Date:   Thu, 10 Jan 2019 10:52:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <3514439.dzOWKx1Cjx@aspire.rjw.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/2018 12:30, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Add two new metrics for CPU idle states, "above" and "below", to count
> the number of times the given state had been asked for (or entered
> from the kernel's perspective), but the observed idle duration turned
> out to be too short or too long for it (respectively).
> 
> These metrics help to estimate the quality of the CPU idle governor
> in use.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> -> v2: Fix a leftover in the documentation from the previous versions
>        of the patch and a typo in the changelog.
> 
> ---
>  Documentation/ABI/testing/sysfs-devices-system-cpu |    7 ++++
>  Documentation/admin-guide/pm/cpuidle.rst           |   10 ++++++
>  drivers/cpuidle/cpuidle.c                          |   31 ++++++++++++++++++++-
>  drivers/cpuidle/sysfs.c                            |    6 ++++
>  include/linux/cpuidle.h                            |    2 +
>  5 files changed, 55 insertions(+), 1 deletion(-)
> 
> Index: linux-pm/drivers/cpuidle/cpuidle.c
> ===================================================================
> --- linux-pm.orig/drivers/cpuidle/cpuidle.c
> +++ linux-pm/drivers/cpuidle/cpuidle.c
> @@ -202,7 +202,6 @@ int cpuidle_enter_state(struct cpuidle_d
>  	struct cpuidle_state *target_state = &drv->states[index];
>  	bool broadcast = !!(target_state->flags & CPUIDLE_FLAG_TIMER_STOP);
>  	ktime_t time_start, time_end;
> -	s64 diff;
>  
>  	/*
>  	 * Tell the time framework to switch to a broadcast timer because our
> @@ -248,6 +247,9 @@ int cpuidle_enter_state(struct cpuidle_d
>  		local_irq_enable();
>  
>  	if (entered_state >= 0) {
> +		s64 diff, delay = drv->states[entered_state].exit_latency;
> +		int i;
> +
>  		/*
>  		 * Update cpuidle counters
>  		 * This can be moved to within driver enter routine,
> @@ -260,6 +262,33 @@ int cpuidle_enter_state(struct cpuidle_d
>  		dev->last_residency = (int)diff;

Shouldn't we subtract the 'delay' from the computed 'diff' in any case ?

Otherwise the 'last_residency' accumulates the effective sleep time and
the time to wakeup. We are interested in the sleep time only for
prediction and metrics no ?

>  		dev->states_usage[entered_state].time += dev->last_residency;
>  		dev->states_usage[entered_state].usage++;
> +
> +		if (diff < drv->states[entered_state].target_residency) {
> +			for (i = entered_state - 1; i >= 0; i--) {
> +				if (drv->states[i].disabled ||
> +				    dev->states_usage[i].disable)
> +					continue;
> +
> +				/* Shallower states are enabled, so update. */
> +				dev->states_usage[entered_state].above++;
> +				break;
> +			}
> +		} else if (diff > delay) {
> +			for (i = entered_state + 1; i < drv->state_count; i++) {
> +				if (drv->states[i].disabled ||
> +				    dev->states_usage[i].disable)
> +					continue;
> +
> +				/*
> +				 * Update if a deeper state would have been a
> +				 * better match for the observed idle duration.
> +				 */
> +				if (diff - delay >= drv->states[i].target_residency)
> +					dev->states_usage[entered_state].below++;
> +
> +				break;
> +			}
> +		}
>  	} else {


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B701C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 11:20:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CF5F2184A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 11:20:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FRaKmh7m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729270AbeLSLUH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 06:20:07 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53910 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728150AbeLSLUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 06:20:06 -0500
Received: by mail-wm1-f66.google.com with SMTP id d15so5688867wmb.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 03:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WBYtpgi3L43g/g3bal8OsjXx3jBVIwyK4ycCMrvCSkk=;
        b=FRaKmh7mMZT2QEE9wDGOGpeyti9mUyh0siUC7a5gkVptOsCADAnD/tAPHmdEe/Ng6R
         TFsiTzmtmF9FnbNe8dlmwvehBS802WJkRIBpTjzffWvREWhBsuCVI7l/8eg+7KmTF+ck
         tPfYXMl6Vk9cGxtjmFhugK/jYWczynFPx96D0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WBYtpgi3L43g/g3bal8OsjXx3jBVIwyK4ycCMrvCSkk=;
        b=Oz8AZXFo8ZFHfJK2wpJEBdSNoQCFyZ18CPjrNho4Q16MHfELIWLyab162F1Gcjzb8X
         MW8WVeVJMQX4SwPE97rKGUaVilGjStuxy6sA/9lVSzk/kEusOwss53jtCWT39qUXkRs4
         rrrAjkIcDkm5as6Gs+CEzM2hrU7GmJCvWoNtTMMSER424zgyLHtfyFqyFyjVVXgas5Vp
         +a9wSZTfsU7vuxLmGn84bpUZxAa1UgzZgdsS6S7QgSrgKw942wH34FquxdgonAaljkLI
         1/uX1nD5cAdymbEroxUy8s9kph+xcz+3waYYaEvX77wTgNE30qrdnF+7pvc28wHD0tqN
         jlBQ==
X-Gm-Message-State: AA+aEWbYVOnXQlOdTN26BpOrbzt4yXJWqvWVBWlMmAjWeotkV5sj5jyA
        qFkHrnRBeiwJscT8v1WWGU6qCQ==
X-Google-Smtp-Source: AFSGD/XnZmZt9xFIeOB20qjLjHxFqeLwsBc9nMG284v7jY0YuqvRKn/244M5kqZKPMdnUzyHHjZ0RQ==
X-Received: by 2002:a1c:a9d4:: with SMTP id s203mr5930739wme.132.1545218403694;
        Wed, 19 Dec 2018 03:20:03 -0800 (PST)
Received: from [192.168.0.40] (197.26.136.77.rev.sfr.net. [77.136.26.197])
        by smtp.googlemail.com with ESMTPSA id l14sm13600521wrp.55.2018.12.19.03.20.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 03:20:02 -0800 (PST)
Subject: Re: [PATCH v10 07/27] cpuidle: dt: Support hierarchical CPU idle
 states
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org
Cc:     "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lina Iyer <lina.iyer@linaro.org>
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
 <20181129174700.16585-8-ulf.hansson@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <8b8eaac3-9b17-a853-b02e-a5ec4a0c911d@linaro.org>
Date:   Wed, 19 Dec 2018 12:20:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181129174700.16585-8-ulf.hansson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/11/2018 18:46, Ulf Hansson wrote:
> From: Lina Iyer <lina.iyer@linaro.org>
> 
> Currently CPU's idle states are represented in a flattened model, via the
> "cpu-idle-states" binding from within the CPU's device nodes.
> 
> Support the hierarchical layout during parsing and validating of the CPU's
> idle states. This is simply done by calling the new OF helper,
> of_get_cpu_state_node().
> 
> Cc: Lina Iyer <ilina@codeaurora.org>
> Suggested-by: Sudeep Holla <sudeep.holla@arm.com>
> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
> Co-developed-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
> 
> Changes in v10:
> 	- None.
> 
> ---
>  drivers/cpuidle/dt_idle_states.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cpuidle/dt_idle_states.c b/drivers/cpuidle/dt_idle_states.c
> index 53342b7f1010..13f9b7cd32d1 100644
> --- a/drivers/cpuidle/dt_idle_states.c
> +++ b/drivers/cpuidle/dt_idle_states.c
> @@ -118,8 +118,7 @@ static bool idle_state_valid(struct device_node *state_node, unsigned int idx,
>  	for (cpu = cpumask_next(cpumask_first(cpumask), cpumask);
>  	     cpu < nr_cpu_ids; cpu = cpumask_next(cpu, cpumask)) {
>  		cpu_node = of_cpu_device_node_get(cpu);
> -		curr_state_node = of_parse_phandle(cpu_node, "cpu-idle-states",
> -						   idx);
> +		curr_state_node = of_get_cpu_state_node(cpu_node, idx);
>  		if (state_node != curr_state_node)
>  			valid = false;
>  
> @@ -176,7 +175,7 @@ int dt_init_idle_driver(struct cpuidle_driver *drv,
>  	cpu_node = of_cpu_device_node_get(cpumask_first(cpumask));
>  
>  	for (i = 0; ; i++) {
> -		state_node = of_parse_phandle(cpu_node, "cpu-idle-states", i);
> +		state_node = of_get_cpu_state_node(cpu_node, i);
>  		if (!state_node)
>  			break;
>  
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


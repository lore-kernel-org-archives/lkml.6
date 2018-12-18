Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B69AC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 10:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE6192184C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 10:39:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="S3UE84c4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbeLRKjV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 05:39:21 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44435 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbeLRKjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 05:39:21 -0500
Received: by mail-wr1-f66.google.com with SMTP id z5so15334069wrt.11
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 02:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vdkpDLFMM0k7of4w6g7qyHm6s3TEaG0a7qSnU/OuC1k=;
        b=S3UE84c4+0vxvDogAXa4K+c7In4isGXjFfj84ZVzsdHzNBdlLvL/oExnDOAv0gXAVP
         uorOagc1UB/z7vq1aSvj5eIxV8mDBNJZodqpEhYzL2EvW08aYMma1CcTYOYAUmfGHiHn
         6tzCsuZH+Ouge8oiXfPBS7/3/4yC/uosQR1e8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vdkpDLFMM0k7of4w6g7qyHm6s3TEaG0a7qSnU/OuC1k=;
        b=XT8e5m3nNS11hdcp2sfHazdlx2fILeQS68H9us8OXqaDyOth/E1umnojhNPn3aJ8JN
         GPcYUkheDsW861qVXHRFZRGj5V25oHF8AB8OW1QJ9DNrWXOxsIuP+gZP22eqqu4RmCOk
         0A2Bplz6H+rv6vZdMoHHxeImzxaUfjK57iGJvNMO1vdyHav7FLFGqY1rv32DY2nEQhuC
         cyWRqOEgVAO6DU7hjFV+lJ0E06DdRWdRhWNWy/Z/QxwFZjNotILQrWdQ85OHT+grRPBZ
         FTROUYDgOFZ+xpRg5kDhd+CmM5gWxb9M1mggdT0xcUlLpP6Yc1O9vqeZTGNK1l1THItP
         13CQ==
X-Gm-Message-State: AA+aEWZ0URs2/78gv0ZUXxcYeAJ77C/hvdfiqBoFT5O2EMtt7rbPn/Ol
        jGBj/5my8mLmvLbn3Lc+iX74YH3QzVQ=
X-Google-Smtp-Source: AFSGD/UIUWry9I61RXOyyIAmYrKy1UDFndompH45nSVHbdKRe5/qBnYorOBSdipU8eRLlVbNEIFpkg==
X-Received: by 2002:adf:e78f:: with SMTP id n15mr14533115wrm.115.1545129557283;
        Tue, 18 Dec 2018 02:39:17 -0800 (PST)
Received: from [192.168.0.40] (105.50.92.92.rev.sfr.net. [92.92.50.105])
        by smtp.googlemail.com with ESMTPSA id v132sm1862367wme.20.2018.12.18.02.39.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 02:39:16 -0800 (PST)
Subject: Re: [PATCH v10 01/27] PM / Domains: Add generic data pointer to
 genpd_power_state struct
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
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
 <20181129174700.16585-2-ulf.hansson@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <81caa4b6-d0ac-f351-2ecf-47fb0f7dcc74@linaro.org>
Date:   Tue, 18 Dec 2018 11:39:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181129174700.16585-2-ulf.hansson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/11/2018 18:46, Ulf Hansson wrote:
> Let's add a data pointer to the genpd_power_state struct, to allow a genpd
> backend driver to store per state specific data. In order to introduce the
> pointer, we also need to adopt how genpd frees the allocated data for the
> default genpd_power_state struct, that it may allocate at pm_genpd_init().
> 
> More precisely, let's use an internal genpd flag to understand when the
> states needs to be freed by genpd. When freeing the states data in
> genpd_remove(), let's also clear the corresponding genpd->states pointer
> and reset the genpd->state_count. In this way, a genpd backend driver
> becomes aware of when there is state specific data for it to free.
> 
> Cc: Lina Iyer <ilina@codeaurora.org>
> Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
> 
> Changes in v10:
> 	- Update the patch allow backend drivers to free the states specific
> 	  data during genpd removal. Due to this added complexity, I decided to
> 	  keep the patch separate, rather than fold it into the patch that makes
> 	  use of the new void pointer, which was suggested by Rafael.
> 	- Claim authorship of the patch as lots of changes has been done since
> 	  the original pick up from Lina Iyer.
> 
> ---
>  drivers/base/power/domain.c | 8 ++++++--
>  include/linux/pm_domain.h   | 3 ++-
>  2 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 7f38a92b444a..e27b91d36a2a 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -1620,7 +1620,7 @@ static int genpd_set_default_power_state(struct generic_pm_domain *genpd)
>  
>  	genpd->states = state;
>  	genpd->state_count = 1;
> -	genpd->free = state;
> +	genpd->free_state = true;
>  
>  	return 0;
>  }
> @@ -1736,7 +1736,11 @@ static int genpd_remove(struct generic_pm_domain *genpd)
>  	list_del(&genpd->gpd_list_node);
>  	genpd_unlock(genpd);
>  	cancel_work_sync(&genpd->power_off_work);
> -	kfree(genpd->free);
> +	if (genpd->free_state) {
> +		kfree(genpd->states);
> +		genpd->states = NULL;
> +		genpd->state_count = 0;

Why these two initializations? After genpd_remove, this structure
shouldn't be used anymore, no ?

> +	}

Instead of a flag, replacing the 'free' pointer to a 'free' callback
will allow to keep the free path self-encapsulated in domain.c

genpd->free(genpd->states);

Patch 18/27 can fill this field with its specific free pointer.



>  	pr_debug("%s: removed %s\n", __func__, genpd->name);
>  
>  	return 0;
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index 3b5d7280e52e..f9e09bd4152c 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -69,6 +69,7 @@ struct genpd_power_state {
>  	s64 residency_ns;
>  	struct fwnode_handle *fwnode;
>  	ktime_t idle_time;
> +	void *data;
>  };
>  
>  struct genpd_lock_ops;
> @@ -110,7 +111,7 @@ struct generic_pm_domain {
>  	struct genpd_power_state *states;
>  	unsigned int state_count; /* number of states */
>  	unsigned int state_idx; /* state that genpd will go to when off */
> -	void *free; /* Free the state that was allocated for default */
> +	bool free_state; /* Free the state that was allocated for default */
>  	ktime_t on_time;
>  	ktime_t accounting_time;
>  	const struct genpd_lock_ops *lock_ops;
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


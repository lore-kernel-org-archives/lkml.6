Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68F85C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 10:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DBFE2145D
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 10:10:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XGf3et6z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728959AbfBEKKv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 05:10:51 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55157 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727039AbfBEKKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 05:10:51 -0500
Received: by mail-wm1-f67.google.com with SMTP id a62so2916887wmh.4
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 02:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fXd6DbXSx8O30DE77NsjshJqWksv0B74q6S2C+obTY4=;
        b=XGf3et6zvH1XRd8xzd/9CgQF+y/UQkLvR9OqCbbfHOspCFUE5zwOaGIp6rhCDfee6k
         QVvaLbm/5XV8DQSOInVQ2mr1qK8/AMPOcXcgW98RZbgenEwtEhopHcfNF5iGk5VGZIf+
         hdIiRtZTy/hGJoiPZhkCzK33Aarfiv/zxv06WaPZlGlQcqryiv3kGrx0HjbjIEbdAc1V
         oxdAw4xTliVCH868SoRfS1+wFUp+ENGuTMbJ+QAF/6w6Rs5xX7yn0aqPZUbiLnhBRzAI
         rvVV5J/dzz2BUK8ZhoF5RuBxhe5MNz9j+hrNn/TunVisPVzodyGSjijY6IuFKvfJkxCg
         2FYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fXd6DbXSx8O30DE77NsjshJqWksv0B74q6S2C+obTY4=;
        b=LFmiV4J/gD/MKfO/Wv64NkoSSnZAN1fXwidMq4nh4A0tmCAXK1gBitJMBj0hoGapgI
         h/kWajrWtfc6VDbVovfr4wPo29JDujhjlsOAjMChg45RY8vapmRf+04QvUtGYgOk1F1e
         /6OpN+tN+CqmX9ajEbx342yNwN3lepKOmIfOEV2YCfaZiGzsS1AwgTamWx2gQIZyTSCg
         1jESKUy35HXNjoJe9Gom0dn0koJ9ajn06niwD++MCX7/uoLcO3lfzns98EiSj53YcT+9
         VF/SKIt2iKnbki5NQmYR1A8x4gjrZeHZ/XzYYy2K/ANPI8hJ9SFs/cP6v2mAlfzULPKT
         NcNA==
X-Gm-Message-State: AHQUAuabKgGMjxPQ425T+ty0QeaVhRl+Pjnd18r5rVfH+xWxUePKUMcb
        souAL0QOmane/KPIylLwknU=
X-Google-Smtp-Source: AHgI3IZT/s15wuBzS8Luay+LFzBvf01xJRRWD3Xk961FXSknAExQY0BIe6UKJ/jEYq86mQ3h2e2Zjg==
X-Received: by 2002:a7b:c24c:: with SMTP id b12mr2810014wmj.29.1549361448578;
        Tue, 05 Feb 2019 02:10:48 -0800 (PST)
Received: from Red ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id c18sm11868785wre.32.2019.02.05.02.10.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 02:10:47 -0800 (PST)
Date:   Tue, 5 Feb 2019 11:10:45 +0100
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     will.deacon@arm.com, mark.rutland@arm.com, suzuki.poulose@arm.com,
        peterz@infradead.org, bigeasy@linutronix.de,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        "Li, Meng" <Meng.Li@windriver.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/5] perf/arm-cci: Fix CPU hotplug race avoidance
Message-ID: <20190205101045.GB27918@Red>
References: <cover.1549299188.git.robin.murphy@arm.com>
 <606ff8c3f7f35ccdcb4b52a49f692fb20e27359c.1549299188.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <606ff8c3f7f35ccdcb4b52a49f692fb20e27359c.1549299188.git.robin.murphy@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04, 2019 at 05:09:04PM +0000, Robin Murphy wrote:
> The arm-cci probe logic faces a cyclic dependency wherein it has to pick
> a valid CPU to associate with before registering the PMU device, has to
> have the PMU state initialised before handling hotplug events in case it
> must be migrated, but has to have the hotplug notifier registered before
> the chosen CPU may go offline lest things get out of sync. The present
> code has tried to solve the races by using get_cpu() to pick the current
> CPU and prevent it from disappearing while the other two registrations
> are performed, but that results in taking mutexes with preemption
> disabled, which makes certain configurations very unhappy:
> 
> [ 1.983337] BUG: sleeping function called from invalid context at kernel/locking/rtmutex.c:2004
> [ 1.983340] in_atomic(): 1, irqs_disabled(): 0, pid: 1, name: swapper/0
> [ 1.983342] Preemption disabled at:
> [ 1.983353] [<ffffff80089801f4>] cci_pmu_probe+0x1dc/0x488
> [ 1.983360] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.18.20-rt8-yocto-preempt-rt #1
> [ 1.983362] Hardware name: ZynqMP ZCU102 Rev1.0 (DT)
> [ 1.983364] Call trace:
> [ 1.983369] dump_backtrace+0x0/0x158
> [ 1.983372] show_stack+0x24/0x30
> [ 1.983378] dump_stack+0x80/0xa4
> [ 1.983383] ___might_sleep+0x138/0x160
> [ 1.983386] __might_sleep+0x58/0x90
> [ 1.983391] __rt_mutex_lock_state+0x30/0xc0
> [ 1.983395] _mutex_lock+0x24/0x30
> [ 1.983400] perf_pmu_register+0x2c/0x388
> [ 1.983404] cci_pmu_probe+0x2bc/0x488
> [ 1.983409] platform_drv_probe+0x58/0xa8
> 
> However, we don't actually mind being preempted or migrated at this
> point; all that really matters is that whichever CPU we pick does not
> get offlined before we're done. Thus, do the robust thing and instead
> take the lock to inhibit CPU hotplug for the duration. This also
> revealed an additional race in assigning the global pointer too late
> relative to the hotplug notifier, so that gets fixed in the process.
> 
> Reported-by: "Li, Meng" <Meng.Li@windriver.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/perf/arm-cci.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/perf/arm-cci.c b/drivers/perf/arm-cci.c
> index 1bfeb160c5b1..f6d9df07ec9b 100644
> --- a/drivers/perf/arm-cci.c
> +++ b/drivers/perf/arm-cci.c
> @@ -1692,21 +1692,23 @@ static int cci_pmu_probe(struct platform_device *pdev)
>  	raw_spin_lock_init(&cci_pmu->hw_events.pmu_lock);
>  	mutex_init(&cci_pmu->reserve_mutex);
>  	atomic_set(&cci_pmu->active_events, 0);
> -	cci_pmu->cpu = get_cpu();
> +
> +	cpus_read_lock();
> +	cci_pmu->cpu = smp_processor_id();
>  
>  	ret = cci_pmu_init(cci_pmu, pdev);
> -	if (ret) {
> -		put_cpu();
> -		return ret;
> -	}
> +	if (ret)
> +		goto out;
>  
> -	cpuhp_setup_state_nocalls(CPUHP_AP_PERF_ARM_CCI_ONLINE,
> -				  "perf/arm/cci:online", NULL,
> -				  cci_pmu_offline_cpu);
> -	put_cpu();
>  	g_cci_pmu = cci_pmu;
> +	cpuhp_setup_state_nocalls_cpuslocked(CPUHP_AP_PERF_ARM_CCI_ONLINE,
> +					     "perf/arm/cci:online", NULL,
> +					     cci_pmu_offline_cpu);
> +
>  	pr_info("ARM %s PMU driver probed", cci_pmu->model->name);
> -	return 0;
> +out:
> +	cpus_read_unlock();
> +	return ret;
>  }
>  
>  static int cci_pmu_remove(struct platform_device *pdev)
> -- 
> 2.20.1.dirty

Hello

Thanks, this patch fix my issue that I has reported here:
https://lkml.org/lkml/2017/12/29/139
https://lkml.org/lkml/2018/11/12/1901

Tested-by: Corentin Labbe <clabbe.montjoie@gmail.com>
Tested-on: sun8i-a83t-bananapi-m3

Regards

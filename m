Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C7AEC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4640E20838
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549882282;
	bh=FNzkkT6AfU1uYks/NNGeFD2TCbAC8Xua+umZtmYu74I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=o6ybaE4cC9V5y+FnhOky/2w/49Wevjc9c4xmcb2l6aqFUwSY3NP1VzbFZ4xy1tuoW
	 /hvyjDbm9IUq68soljv+jvzqPlCZQ8G9d5XFQEVvROwynIB+DL/XMfY9yzDodNtpwQ
	 MH3hxUEkQ3hVGNCSg/gs2VHMBJCA5S0jkws4xMig=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbfBKKvU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 05:51:20 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46620 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725931AbfBKKvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 05:51:20 -0500
Received: by mail-ot1-f66.google.com with SMTP id w25so16580844otm.13;
        Mon, 11 Feb 2019 02:51:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ic4LJwtH6696vNmZdjpk5xP0gtKSELq4x6VhSZ/Ny5Q=;
        b=fHybl2+KlwMSFu6PnSz+0T8EZJE0IccypLqwKGSK5naU5tA42tKO3hUAOgsI7FycXB
         WUohHFR3CWjh7oj5Bu/svClAVPu7tdskbBmL+M6+IoE+CUE3x582vU9JjE89S7Oospel
         efuqWmrdGXaQgCMaTmnr114mTfg9vsedPlFIxZnvVDCUc52Zig/SHnyOjXLOhr2fbF8f
         D2A94Y4Fxby14t0HFQSiYcB9kLp59uZVIoiIHwM++9SG2/AwIjdKkagognfKtNYK0MTm
         fKGzYWya+wmcLwtk9E1e3TPB5PhPS8atzn9o7fl4DSUXJKMjJi730+z0lkOZeagK9Cxt
         T8kw==
X-Gm-Message-State: AHQUAuYcIAxRtbKdmcUeqOhHN3tIFhqbSOP7yO1Jd07G5pYXORowriAL
        BfiqkNtYKyzQHg1h/6kKsq0EIrjkIk1t/8aE9RQ=
X-Google-Smtp-Source: AHgI3IanjKo39zrTNezkSEYw4ljU/kGAEBLjj9t0ip0VhgVAu7iLLnZbL/hJ6nF85Ahpjzp1OPwROv8QgHUAfS3tFig=
X-Received: by 2002:a9d:7990:: with SMTP id h16mr19708326otm.222.1549882279240;
 Mon, 11 Feb 2019 02:51:19 -0800 (PST)
MIME-Version: 1.0
References: <cover.1549874368.git.viresh.kumar@linaro.org> <03ac36a174f6c28be0b3af9d2db8631d56695f1d.1549874368.git.viresh.kumar@linaro.org>
In-Reply-To: <03ac36a174f6c28be0b3af9d2db8631d56695f1d.1549874368.git.viresh.kumar@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 11 Feb 2019 11:51:07 +0100
Message-ID: <CAJZ5v0hhxUQxf9VbhU_6B29MYspNo0Go+o4_OkxgnBe8+bGTdw@mail.gmail.com>
Subject: Re: [PATCH 1/2] cpufreq: Allow light-weight tear down on CPU offline operation
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 9:41 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> The cpufreq core doesn't remove the cpufreq policy anymore on CPU
> offline operation, rather that happens when the CPU device gets
> unregistered from the kernel. This allows faster recovery when the CPU
> comes back online. This is also very useful during system wide
> suspend/resume where we offline all non-boot CPUs during suspend and
> then bring them back on resume.
>
> This commit takes the same idea a step ahead to allow drivers to do
> light weight tear-down during CPU offline operation.
>
> A new callback is introduced, light_weight_exit(), which gets called
> when all the CPUs of a policy are removed/offlined and the existing
> exit() callback gets called when the policy gets freed.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq.c | 16 +++++++++++-----
>  include/linux/cpufreq.h   |  1 +
>  2 files changed, 12 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 96a69c67a545..215a8bfc78bb 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1421,11 +1421,12 @@ static int cpufreq_offline(unsigned int cpu)
>                 cpufreq_exit_governor(policy);
>
>         /*
> -        * Perform the ->exit() even during light-weight tear-down,
> -        * since this is a core component, and is essential for the
> -        * subsequent light-weight ->init() to succeed.
> +        * Perform the ->light_weight_exit() during light-weight tear-down, as
> +        * that allows fast recovery when the CPU comes back.
>          */
> -       if (cpufreq_driver->exit) {
> +       if (cpufreq_driver->light_weight_exit) {
> +               cpufreq_driver->light_weight_exit(policy);
> +       } else if (cpufreq_driver->exit) {
>                 cpufreq_driver->exit(policy);
>                 policy->freq_table = NULL;
>         }
> @@ -1454,8 +1455,13 @@ static void cpufreq_remove_dev(struct device *dev, struct subsys_interface *sif)
>         cpumask_clear_cpu(cpu, policy->real_cpus);
>         remove_cpu_dev_symlink(policy, dev);
>
> -       if (cpumask_empty(policy->real_cpus))
> +       if (cpumask_empty(policy->real_cpus)) {
> +               /* We did light-weight exit earlier, do full tear down now */
> +               if (cpufreq_driver->light_weight_exit)
> +                       cpufreq_driver->exit(policy);
> +
>                 cpufreq_policy_free(policy);
> +       }
>  }
>
>  /**
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 9db074ecbbd7..36ce31516041 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -325,6 +325,7 @@ struct cpufreq_driver {
>         /* optional */
>         int             (*bios_limit)(int cpu, unsigned int *limit);
>
> +       int             (*light_weight_exit)(struct cpufreq_policy *policy);

Can you call it "offline"?

>         int             (*exit)(struct cpufreq_policy *policy);
>         void            (*stop_cpu)(struct cpufreq_policy *policy);
>         int             (*suspend)(struct cpufreq_policy *policy);
> --

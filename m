Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4767C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 892D82084D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549881700;
	bh=8Zrh5rb7DzOxZv9Cv1/Xgoouo0EsAyGmtg83mFCXv0s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=LfgTidGoZhAcTWV9I+7rIHWm9EguBz2llK3Ly9ZQ/tMYq3wU4f8a9v9/XZUb0rZp5
	 RJONW1EXbgVjj+WVI+lYtgJntP26rh3XQ8H5cg9VAygbarytm5luWC/IvD0b1kzD/8
	 0LhFBY4FymKOg0xTeMWoq9yx3mE+tf09/6B+IkmY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbfBKKlj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 05:41:39 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36068 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbfBKKli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 05:41:38 -0500
Received: by mail-ot1-f66.google.com with SMTP id k98so16656283otk.3;
        Mon, 11 Feb 2019 02:41:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DTeNYlRJ/aP3cdKlrOjhsf9amGhrXIf1xkhDVObUBm4=;
        b=WMGxHfQxuyUHybd+gHghp5EMGjFYO+GMo+PRnGqYZeBTbfGj6Wiqf+4BS2yyPmWsHx
         7LwugKmZbTlIvEyI1JZy1+GG4QOg/3+tqIZfTW2P8h4sKrDszvMRGLbMnslqCw/yjStW
         rbP4h8qvbquUic0bFFOvGq0zk7PJ9wgEDVQGlmosMSs33SFOp04T1SOeXwvLRJ7lNmMo
         k+3QnY6xtL5w2CRBwFeCdx71nggjcM+x4RTAqovfWbYidckt5lYyO8baC/z76NkVRYmH
         bT6w20b7ZS8qOtRhdJZgUDc2gxiALPrtWu8R4WJo39cC8IcUZHEtJnqg7FVjHWUp/WrR
         JgXw==
X-Gm-Message-State: AHQUAuaMhaon+o1xa2qilDBP+dPjvuFgprM0k8mU4XPFR9HHN9Va+goA
        Jb9lOpLirT1SM0wEOKubnyOlWEvSdS+r4SNe9DI=
X-Google-Smtp-Source: AHgI3IbyZyDkhkyL4qfjrtEeHeVX3Vx8X5rjeAFrRFw6M/+UOO4knxaBkHmkGqzYXT8eQVC2nL1+Tj36X6n6ymiXlVQ=
X-Received: by 2002:a9d:5e8c:: with SMTP id f12mr28463893otl.343.1549881697327;
 Mon, 11 Feb 2019 02:41:37 -0800 (PST)
MIME-Version: 1.0
References: <20190209120232.21582-1-yu.c.chen@intel.com>
In-Reply-To: <20190209120232.21582-1-yu.c.chen@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 11 Feb 2019 11:41:26 +0100
Message-ID: <CAJZ5v0ggyrn7XJmoDP8Z8F_VJ67K0D4GCLJa7xWcX4gursOB5Q@mail.gmail.com>
Subject: Re: [PATCH][RFC] ACPI: add "processor.broadcast_ppc" hook to
 broadcast _PPC to all online CPUs
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 9, 2019 at 12:54 PM Chen Yu <yu.c.chen@intel.com> wrote:
>
> On Dell Inc. XPS13 9333, the BIOS changes the value of
> MSR_IA32_MISC_ENABLE_TURBO_DISABLE at runtime (e.g., when
> the power source changes), the maximum frequency of the
> CPU is not updated accordingly. This is due to the policy's
> cpuinfo.max is not updated when _PPC notifier fires.
>
> Fix this problem by updating the policy's cpuinfo.max
> and broadcast the _PPC notifier to all online CPUs.
>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=200759
> Reported-and-tested-by: Gabriele Mazzotta <gabriele.mzt@gmail.com>
> Originally-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
>  drivers/acpi/processor_perflib.c | 16 ++++++++++++++--
>  drivers/cpufreq/cpufreq.c        |  2 ++
>  drivers/cpufreq/intel_pstate.c   | 15 ++++++++++++++-
>  3 files changed, 30 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_perflib.c
> index a303fd0e108c..737dbf5aa7f7 100644
> --- a/drivers/acpi/processor_perflib.c
> +++ b/drivers/acpi/processor_perflib.c
> @@ -63,6 +63,10 @@ module_param(ignore_ppc, int, 0644);
>  MODULE_PARM_DESC(ignore_ppc, "If the frequency of your machine gets wrongly" \
>                  "limited by BIOS, this should help");
>
> +static int broadcast_ppc;
> +module_param(broadcast_ppc, int, 0644);
> +MODULE_PARM_DESC(broadcast_ppc, "Broadcast the ppc to all online CPUs");
> +
>  #define PPC_REGISTERED   1
>  #define PPC_IN_USE       2
>
> @@ -180,8 +184,16 @@ void acpi_processor_ppc_has_changed(struct acpi_processor *pr, int event_flag)
>                 else
>                         acpi_processor_ppc_ost(pr->handle, 0);
>         }
> -       if (ret >= 0)
> -               cpufreq_update_policy(pr->id);
> +       if (ret >= 0) {
> +               if (broadcast_ppc) {
> +                       int cpu;
> +
> +                       for_each_possible_cpu(cpu)
> +                               cpufreq_update_policy(cpu);
> +               } else {
> +                       cpufreq_update_policy(pr->id);
> +               }
> +       }
>  }
>
>  int acpi_processor_get_bios_limit(int cpu, unsigned int *limit)
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index e35a886e00bc..95e08816b512 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2237,6 +2237,8 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
>
>         policy->min = new_policy->min;
>         policy->max = new_policy->max;
> +       policy->cpuinfo.max_freq = new_policy->cpuinfo.max_freq;
> +       policy->cpuinfo.min_freq = new_policy->cpuinfo.min_freq;
>         trace_cpu_frequency_limits(policy);
>
>         policy->cached_target_freq = UINT_MAX;
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index dd66decf2087..e1881313c396 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -2081,11 +2081,24 @@ static void intel_pstate_adjust_policy_max(struct cpufreq_policy *policy,
>
>  static int intel_pstate_verify_policy(struct cpufreq_policy *policy)
>  {
> +       int max_freq;
>         struct cpudata *cpu = all_cpu_data[policy->cpu];
>
>         update_turbo_state();

Well, update_turbo_state() should handle the case at hand already.

That's what it's for actually: It checks if
MSR_IA32_MISC_ENABLE_TURBO_DISABLE is set and sets
global.turbo_disabled is that's the case.

Why isn't that sufficient?

> +       max_freq = intel_pstate_get_max_freq(cpu);
> +
> +       if (acpi_ppc && policy->max == policy->cpuinfo.max_freq &&
> +           max_freq != policy->cpuinfo.max_freq) {
> +               /*
> +                * System was not running under any constraints, but the
> +                * current max possible frequency is changed. So reset
> +                * policy limits.
> +                */
> +               policy->cpuinfo.max_freq = policy->max = max_freq;
> +       }

Why does policy->cpuinfo.max_freq need to be updated?

> +
>         cpufreq_verify_within_limits(policy, policy->cpuinfo.min_freq,
> -                                    intel_pstate_get_max_freq(cpu));
> +                                    max_freq);
>
>         if (policy->policy != CPUFREQ_POLICY_POWERSAVE &&
>             policy->policy != CPUFREQ_POLICY_PERFORMANCE)
> --

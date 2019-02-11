Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE71EC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A06F020821
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:33:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l1wH+MzB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbfBKKdM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 05:33:12 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34207 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbfBKKdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 05:33:11 -0500
Received: by mail-pg1-f194.google.com with SMTP id d9so4780992pgl.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 02:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lRiHNyu36ryCHRXmhn7MP9bdbWvIoPN1bMGVU9CPovw=;
        b=l1wH+MzByY0sOvgTxUcfO5nQhF4TsCt5TtsJVAtAeAL9bhJTP7i7Bwtd00cCFMI+Be
         Mwll5ZBtXeiVL/FboGj1X5Ap9TnII9+U/B4IV68VxLpKD7bk2n3/gj41xjtLN/EfpZQ5
         L+kjhrWnQuyrMtxPyn6zUUTaQhmSsPUZXRHgNcs+t6vflFNezoms0iChgZlZDVrazwuK
         8Qr3Bk0eoZNaNGI5ZPqrEtrFpahRNh+tE4n0c3pK0NcdKhxSvNnkPEUmAMzvgpLGAWuH
         QCi5ACP6x6eGtg7SDtw0IbuTh0cnIfg5M+Pl3zRtJJr66KI5qwTqsvCAKouW0zJZJ/iT
         s7Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lRiHNyu36ryCHRXmhn7MP9bdbWvIoPN1bMGVU9CPovw=;
        b=ASHhPwoUoZno7eArTYA3DhOXJAUjBQTYax/qX1n9QZMiHKlE5i+A1WTKD+242nzgNW
         c+ox9AGM+Q8J4Mzo07XWJvyHSLlOnRF8HEhwMSU/Cj818Br9jxVTXbnAEgVVPMvPLMsr
         vO19c6O2t5tPPd/dVu/MHyyXIuG2ZN5Wlp14/asEpABh1/nLqMEoMW1caaugi2f5VhL0
         eqrevBthCT7sY8AUUj44p386pCLotpZjpDDHpp2mZfDT5duPY84FGX7CLwqVI2c5mZXV
         KIE/jyuuQTcjDu9L0FhLTxQLCHtEofR+QwXfd10dKOU32eyIwqdOM1jjly2VsBF2Ogy9
         pTrQ==
X-Gm-Message-State: AHQUAubo2/HORNrsKc4tVmEd1Ft8jKkQYBP5ftZTgtTa//Qf9lhwYu0E
        VurpP9Z7DA6QCSadCN5O9kKuWw==
X-Google-Smtp-Source: AHgI3IYrKR4H5HaXkp3nb8zBF6W55nrqQkpr3M+MRBCNmNHNC6EDgEx3fdyuf7v2nI2UB7o0DMMtMQ==
X-Received: by 2002:a63:4005:: with SMTP id n5mr4982485pga.86.1549881190457;
        Mon, 11 Feb 2019 02:33:10 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id b9sm10565406pgt.66.2019.02.11.02.33.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 02:33:09 -0800 (PST)
Date:   Mon, 11 Feb 2019 16:03:07 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] ACPI: add "processor.broadcast_ppc" hook to
 broadcast  _PPC to all online CPUs
Message-ID: <20190211103307.rccddkso3f5s3yko@vireshk-i7>
References: <20190209120232.21582-1-yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190209120232.21582-1-yu.c.chen@intel.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-02-19, 20:02, Chen Yu wrote:
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
>  		 "limited by BIOS, this should help");
>  
> +static int broadcast_ppc;
> +module_param(broadcast_ppc, int, 0644);
> +MODULE_PARM_DESC(broadcast_ppc, "Broadcast the ppc to all online CPUs");
> +
>  #define PPC_REGISTERED   1
>  #define PPC_IN_USE       2
>  
> @@ -180,8 +184,16 @@ void acpi_processor_ppc_has_changed(struct acpi_processor *pr, int event_flag)
>  		else
>  			acpi_processor_ppc_ost(pr->handle, 0);
>  	}
> -	if (ret >= 0)
> -		cpufreq_update_policy(pr->id);
> +	if (ret >= 0) {
> +		if (broadcast_ppc) {
> +			int cpu;
> +
> +			for_each_possible_cpu(cpu)
> +				cpufreq_update_policy(cpu);
> +		} else {
> +			cpufreq_update_policy(pr->id);
> +		}
> +	}
>  }
>  
>  int acpi_processor_get_bios_limit(int cpu, unsigned int *limit)
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index e35a886e00bc..95e08816b512 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2237,6 +2237,8 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
>  
>  	policy->min = new_policy->min;
>  	policy->max = new_policy->max;
> +	policy->cpuinfo.max_freq = new_policy->cpuinfo.max_freq;
> +	policy->cpuinfo.min_freq = new_policy->cpuinfo.min_freq;
>  	trace_cpu_frequency_limits(policy);
>  
>  	policy->cached_target_freq = UINT_MAX;
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index dd66decf2087..e1881313c396 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -2081,11 +2081,24 @@ static void intel_pstate_adjust_policy_max(struct cpufreq_policy *policy,
>  
>  static int intel_pstate_verify_policy(struct cpufreq_policy *policy)
>  {
> +	int max_freq;
>  	struct cpudata *cpu = all_cpu_data[policy->cpu];
>  
>  	update_turbo_state();
> +	max_freq = intel_pstate_get_max_freq(cpu);
> +
> +	if (acpi_ppc && policy->max == policy->cpuinfo.max_freq &&

Why do have this check for policy->max here ?

> +	    max_freq != policy->cpuinfo.max_freq) {
> +		/*
> +		 * System was not running under any constraints, but the
> +		 * current max possible frequency is changed. So reset
> +		 * policy limits.
> +		 */
> +		policy->cpuinfo.max_freq = policy->max = max_freq;
> +	}
> +
>  	cpufreq_verify_within_limits(policy, policy->cpuinfo.min_freq,
> -				     intel_pstate_get_max_freq(cpu));
> +				     max_freq);
>  
>  	if (policy->policy != CPUFREQ_POLICY_POWERSAVE &&
>  	    policy->policy != CPUFREQ_POLICY_PERFORMANCE)
> -- 
> 2.17.1

-- 
viresh

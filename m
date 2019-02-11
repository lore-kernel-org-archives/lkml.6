Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C13D9C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 241AF20844
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:30:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fnYcUNSl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbfBKKaP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 05:30:15 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43356 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbfBKKaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 05:30:14 -0500
Received: by mail-pf1-f195.google.com with SMTP id q17so1690126pfh.10
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 02:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KgBx2XjHiNZYKIR8WvTuQvMN8vSlmMOa5QLfSmN+B9k=;
        b=fnYcUNSlCrdeianA6NPS9OE2s9sHlQk1SIRB8hvxZykV0Bpqkvdz1Y19L/Beg0iy+S
         yc5prbZWgOAeqJenAiU7RFzDLmmV1oFIm9J8yrBE/VUgiWzWW+SBj9Fq3ycrz71DUnWx
         ctsCtmnzMtEItfSFQkszNvze37KZH0uGld9brX2PvU2cFkf/n2ywM2w0anr2WWUpkTTV
         R9FTA1kOkwXBtGR4t/lMX4beKkuEwjC+YSSQ7uONncI8U7pb89f+5ouNcYkYVyFi/6jC
         sIzsOc4wMZ/5ntNpLICvE6NO+vEQTp6s3jX40E6hnKXkIQIxXX8Qabn3NSmikxRbmeuC
         WzFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KgBx2XjHiNZYKIR8WvTuQvMN8vSlmMOa5QLfSmN+B9k=;
        b=mJJaPHwQvZJeMxCJes8I51F2XUwoo871yzpftumr02zv8FivyF4OstQ9vHvyGirv/2
         +MMO/O3bUE/9Q/gJAzIKJLB90SlMNrCF98AI9Msq3dXS/DtuYO5PCMxsQ5eGnT128y7+
         n/3RkCejl/IQGKnOmHX1AIkLgvKr/armXEOYX2wplx4c0rx6ipf7JfvnTHGwfJqEG9bk
         AkXQpAOQvbhBb5/UKJn/0E1LO1Su5fXh2NJ92wymLlTsqgDxKQhPdoN8i3rIrlFGZ9E7
         0uJFnoLtgZXXqVkQC7qHvN45O3JA40wmNUOyKAAwmsecEKJwOAzupkimWiFnu3vRBQH5
         PZOw==
X-Gm-Message-State: AHQUAuboW8VwCvbO6dmFUKgJ+lv1o7mbTwYbIkOEJJu/fiwt1SNjr7Si
        J+NtarVArtJCLAlx//qKiBpoMQ==
X-Google-Smtp-Source: AHgI3IbEHnsdf6jzEUGLt8eA2NEwuSWM9BOhgMQwWHC7hJbLFI4d9nnBUSzRiDTPl7AuFChwTpenvg==
X-Received: by 2002:a63:2ccb:: with SMTP id s194mr32686087pgs.214.1549881013280;
        Mon, 11 Feb 2019 02:30:13 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id i8sm17416172pgo.19.2019.02.11.02.30.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 02:30:12 -0800 (PST)
Date:   Mon, 11 Feb 2019 16:00:10 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Chen Yu <yu.c.chen@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] ACPI: add "processor.broadcast_ppc" hook to
 broadcast _PPC to all online CPUs
Message-ID: <20190211103010.qet5jvncvkdl7s5n@vireshk-i7>
References: <20190209120232.21582-1-yu.c.chen@intel.com>
 <20190211091627.homaij2rtqzrytbu@vireshk-i7>
 <CAJZ5v0gMV-GCoFcwa4zMKPf8W=o=bb6fzB7ZRAxkKUyjNwqc+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gMV-GCoFcwa4zMKPf8W=o=bb6fzB7ZRAxkKUyjNwqc+w@mail.gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-02-19, 11:20, Rafael J. Wysocki wrote:
> On Mon, Feb 11, 2019 at 10:16 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 09-02-19, 20:02, Chen Yu wrote:
> > > On Dell Inc. XPS13 9333, the BIOS changes the value of
> > > MSR_IA32_MISC_ENABLE_TURBO_DISABLE at runtime (e.g., when
> > > the power source changes), the maximum frequency of the
> > > CPU is not updated accordingly. This is due to the policy's
> > > cpuinfo.max is not updated when _PPC notifier fires.
> > >
> > > Fix this problem by updating the policy's cpuinfo.max
> > > and broadcast the _PPC notifier to all online CPUs.
> > >
> > > Link: https://bugzilla.kernel.org/show_bug.cgi?id=200759
> > > Reported-and-tested-by: Gabriele Mazzotta <gabriele.mzt@gmail.com>
> > > Originally-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> > > ---
> > >  drivers/acpi/processor_perflib.c | 16 ++++++++++++++--
> > >  drivers/cpufreq/cpufreq.c        |  2 ++
> > >  drivers/cpufreq/intel_pstate.c   | 15 ++++++++++++++-
> > >  3 files changed, 30 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_perflib.c
> > > index a303fd0e108c..737dbf5aa7f7 100644
> > > --- a/drivers/acpi/processor_perflib.c
> > > +++ b/drivers/acpi/processor_perflib.c
> > > @@ -63,6 +63,10 @@ module_param(ignore_ppc, int, 0644);
> > >  MODULE_PARM_DESC(ignore_ppc, "If the frequency of your machine gets wrongly" \
> > >                "limited by BIOS, this should help");
> > >
> > > +static int broadcast_ppc;
> > > +module_param(broadcast_ppc, int, 0644);
> > > +MODULE_PARM_DESC(broadcast_ppc, "Broadcast the ppc to all online CPUs");
> > > +
> > >  #define PPC_REGISTERED   1
> > >  #define PPC_IN_USE       2
> > >
> > > @@ -180,8 +184,16 @@ void acpi_processor_ppc_has_changed(struct acpi_processor *pr, int event_flag)
> > >               else
> > >                       acpi_processor_ppc_ost(pr->handle, 0);
> > >       }
> > > -     if (ret >= 0)
> > > -             cpufreq_update_policy(pr->id);
> > > +     if (ret >= 0) {
> > > +             if (broadcast_ppc) {
> > > +                     int cpu;
> > > +
> > > +                     for_each_possible_cpu(cpu)
> > > +                             cpufreq_update_policy(cpu);
> > > +             } else {
> > > +                     cpufreq_update_policy(pr->id);
> > > +             }
> > > +     }
> > >  }
> > >
> > >  int acpi_processor_get_bios_limit(int cpu, unsigned int *limit)
> > > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > > index e35a886e00bc..95e08816b512 100644
> > > --- a/drivers/cpufreq/cpufreq.c
> > > +++ b/drivers/cpufreq/cpufreq.c
> > > @@ -2237,6 +2237,8 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
> > >
> > >       policy->min = new_policy->min;
> > >       policy->max = new_policy->max;
> > > +     policy->cpuinfo.max_freq = new_policy->cpuinfo.max_freq;
> > > +     policy->cpuinfo.min_freq = new_policy->cpuinfo.min_freq;
> > >       trace_cpu_frequency_limits(policy);
> > >
> > >       policy->cached_target_freq = UINT_MAX;
> > > diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> > > index dd66decf2087..e1881313c396 100644
> > > --- a/drivers/cpufreq/intel_pstate.c
> > > +++ b/drivers/cpufreq/intel_pstate.c
> > > @@ -2081,11 +2081,24 @@ static void intel_pstate_adjust_policy_max(struct cpufreq_policy *policy,
> > >
> > >  static int intel_pstate_verify_policy(struct cpufreq_policy *policy)
> > >  {
> > > +     int max_freq;
> > >       struct cpudata *cpu = all_cpu_data[policy->cpu];
> > >
> > >       update_turbo_state();
> > > +     max_freq = intel_pstate_get_max_freq(cpu);
> > > +
> > > +     if (acpi_ppc && policy->max == policy->cpuinfo.max_freq &&
> > > +         max_freq != policy->cpuinfo.max_freq) {
> > > +             /*
> > > +              * System was not running under any constraints, but the
> > > +              * current max possible frequency is changed. So reset
> > > +              * policy limits.
> > > +              */
> > > +             policy->cpuinfo.max_freq = policy->max = max_freq;
> > > +     }
> > > +
> > >       cpufreq_verify_within_limits(policy, policy->cpuinfo.min_freq,
> > > -                                  intel_pstate_get_max_freq(cpu));
> > > +                                  max_freq);
> > >
> > >       if (policy->policy != CPUFREQ_POLICY_POWERSAVE &&
> > >           policy->policy != CPUFREQ_POLICY_PERFORMANCE)
> >
> > By TURBO I believe this is about boost-frequencies and you should use
> > that infrastructure to make it work, isn't it ?
> 
> I guess you mean the the "boost" attribute in the core, but that's not
> applicable to intel_pstate.

Ahh, I missed the part that this is for the !has_target() platforms :(

-- 
viresh

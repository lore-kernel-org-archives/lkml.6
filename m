Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA62C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AC7F21479
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549880470;
	bh=n8Zb3A7uF4zbDFRTlE1fUSR25s7h4OPU+XFzGwlTbUo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=1ke3jy4vjJhEJsNr838j/X99y1nqPjbXqH7AP4e5k+W7Odip6pUAK9IfjQFUelSbD
	 lUgJ4Lvy3E8h7mCtomTAjJYlVeyxosza++P9ozmzPSApvinBVTgK6fWJ2TpKqnQA3S
	 //yTNXoAPMvDvS4h5xhdnhd4gR5A0Y5zqEiXbmG4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbfBKKVI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 05:21:08 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42384 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726838AbfBKKVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 05:21:04 -0500
Received: by mail-ot1-f65.google.com with SMTP id i5so6010801oto.9;
        Mon, 11 Feb 2019 02:21:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sWXlyqPvUAwYY3rUh9I48msHqIUucM+gXfM4oOYDct0=;
        b=TIvQ427MNlF0BlmMZHNlhx2CHpvPh47NMz5lAaRxB3WHvZ169O+w9+UlHejFEbzn8D
         y3nhaQTbVh1CKKChMSv/bDHbE3za2o8fxmR/yqSnuJwt0+ENVa46/k5K30qi1lX5xv9A
         dRfyEdAq96omA62Z0pj0DQikwKbxlHwlI9zFfuMBlS+AkEtCTQaWlhjb2Aci7J1Ep74S
         CCW5fa2HIOPn56IEFCR9igINx2feg2s8LPNOCQa9AHzCc3JvOJ1YxrCO4i4ll2v4z1SB
         ftqX4k984Xx15J12/K/PWM7L3qEmUt8uVDH4RAkr3jJRd6n7wzVSlybiKVhxO31gXWvu
         QwBg==
X-Gm-Message-State: AHQUAuZt8fYZ6NzyNL1fL72VFEme2WBjeZ8Su0ysiSXx8FEdTn387xqk
        EIdqBR2LClyBldGpzRRuq9zXa12jRY1FDZEWhX4=
X-Google-Smtp-Source: AHgI3IY5lNeDNAg5Wx4ja0iR9zdn21Hpmjw+1fbV90p4a4lz8ZM/2yPA4vpNXNsL0Q5kkvAEPh8WSw6/WStYrEPCXjM=
X-Received: by 2002:a9d:718d:: with SMTP id o13mr7399580otj.119.1549880462631;
 Mon, 11 Feb 2019 02:21:02 -0800 (PST)
MIME-Version: 1.0
References: <20190209120232.21582-1-yu.c.chen@intel.com> <20190211091627.homaij2rtqzrytbu@vireshk-i7>
In-Reply-To: <20190211091627.homaij2rtqzrytbu@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 11 Feb 2019 11:20:51 +0100
Message-ID: <CAJZ5v0gMV-GCoFcwa4zMKPf8W=o=bb6fzB7ZRAxkKUyjNwqc+w@mail.gmail.com>
Subject: Re: [PATCH][RFC] ACPI: add "processor.broadcast_ppc" hook to
 broadcast _PPC to all online CPUs
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Chen Yu <yu.c.chen@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 10:16 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 09-02-19, 20:02, Chen Yu wrote:
> > On Dell Inc. XPS13 9333, the BIOS changes the value of
> > MSR_IA32_MISC_ENABLE_TURBO_DISABLE at runtime (e.g., when
> > the power source changes), the maximum frequency of the
> > CPU is not updated accordingly. This is due to the policy's
> > cpuinfo.max is not updated when _PPC notifier fires.
> >
> > Fix this problem by updating the policy's cpuinfo.max
> > and broadcast the _PPC notifier to all online CPUs.
> >
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=200759
> > Reported-and-tested-by: Gabriele Mazzotta <gabriele.mzt@gmail.com>
> > Originally-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> > ---
> >  drivers/acpi/processor_perflib.c | 16 ++++++++++++++--
> >  drivers/cpufreq/cpufreq.c        |  2 ++
> >  drivers/cpufreq/intel_pstate.c   | 15 ++++++++++++++-
> >  3 files changed, 30 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_perflib.c
> > index a303fd0e108c..737dbf5aa7f7 100644
> > --- a/drivers/acpi/processor_perflib.c
> > +++ b/drivers/acpi/processor_perflib.c
> > @@ -63,6 +63,10 @@ module_param(ignore_ppc, int, 0644);
> >  MODULE_PARM_DESC(ignore_ppc, "If the frequency of your machine gets wrongly" \
> >                "limited by BIOS, this should help");
> >
> > +static int broadcast_ppc;
> > +module_param(broadcast_ppc, int, 0644);
> > +MODULE_PARM_DESC(broadcast_ppc, "Broadcast the ppc to all online CPUs");
> > +
> >  #define PPC_REGISTERED   1
> >  #define PPC_IN_USE       2
> >
> > @@ -180,8 +184,16 @@ void acpi_processor_ppc_has_changed(struct acpi_processor *pr, int event_flag)
> >               else
> >                       acpi_processor_ppc_ost(pr->handle, 0);
> >       }
> > -     if (ret >= 0)
> > -             cpufreq_update_policy(pr->id);
> > +     if (ret >= 0) {
> > +             if (broadcast_ppc) {
> > +                     int cpu;
> > +
> > +                     for_each_possible_cpu(cpu)
> > +                             cpufreq_update_policy(cpu);
> > +             } else {
> > +                     cpufreq_update_policy(pr->id);
> > +             }
> > +     }
> >  }
> >
> >  int acpi_processor_get_bios_limit(int cpu, unsigned int *limit)
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index e35a886e00bc..95e08816b512 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -2237,6 +2237,8 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
> >
> >       policy->min = new_policy->min;
> >       policy->max = new_policy->max;
> > +     policy->cpuinfo.max_freq = new_policy->cpuinfo.max_freq;
> > +     policy->cpuinfo.min_freq = new_policy->cpuinfo.min_freq;
> >       trace_cpu_frequency_limits(policy);
> >
> >       policy->cached_target_freq = UINT_MAX;
> > diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> > index dd66decf2087..e1881313c396 100644
> > --- a/drivers/cpufreq/intel_pstate.c
> > +++ b/drivers/cpufreq/intel_pstate.c
> > @@ -2081,11 +2081,24 @@ static void intel_pstate_adjust_policy_max(struct cpufreq_policy *policy,
> >
> >  static int intel_pstate_verify_policy(struct cpufreq_policy *policy)
> >  {
> > +     int max_freq;
> >       struct cpudata *cpu = all_cpu_data[policy->cpu];
> >
> >       update_turbo_state();
> > +     max_freq = intel_pstate_get_max_freq(cpu);
> > +
> > +     if (acpi_ppc && policy->max == policy->cpuinfo.max_freq &&
> > +         max_freq != policy->cpuinfo.max_freq) {
> > +             /*
> > +              * System was not running under any constraints, but the
> > +              * current max possible frequency is changed. So reset
> > +              * policy limits.
> > +              */
> > +             policy->cpuinfo.max_freq = policy->max = max_freq;
> > +     }
> > +
> >       cpufreq_verify_within_limits(policy, policy->cpuinfo.min_freq,
> > -                                  intel_pstate_get_max_freq(cpu));
> > +                                  max_freq);
> >
> >       if (policy->policy != CPUFREQ_POLICY_POWERSAVE &&
> >           policy->policy != CPUFREQ_POLICY_PERFORMANCE)
>
> By TURBO I believe this is about boost-frequencies and you should use
> that infrastructure to make it work, isn't it ?

I guess you mean the the "boost" attribute in the core, but that's not
applicable to intel_pstate.

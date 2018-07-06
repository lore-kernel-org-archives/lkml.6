Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16254C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 10:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B461F208EC
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 10:10:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="f8WlKBaq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B461F208EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754143AbeGFKKQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 06:10:16 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:43679 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753314AbeGFKKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 06:10:14 -0400
Received: by mail-io0-f196.google.com with SMTP id i23-v6so10371164iog.10
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 03:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UtEEk7EM2nmtcM5pWAbePal9nLV9gKndfIijQZosEMQ=;
        b=f8WlKBaqlfMQssqPldu6JVR8RGSrHpUYT96w+uadZo9TzgH3Cpqwuy1EdKRn6lFN7b
         U2JyAJbrUfyuX3HwEuCG4dBxILU7JEQBva7pYJ5ET9wTgZO2zzLN1IGu/M0Qbh7Y1ll2
         bKpzrsellWq07wZYbtw1ASdMmlr1GnWVk1KNY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UtEEk7EM2nmtcM5pWAbePal9nLV9gKndfIijQZosEMQ=;
        b=Aw31Jfb4UOg/5MxQ3GRF+92dXByZCfHGD6VelHqs7Tka4TsROZHQakeMg9xBrfV1Xo
         7bu8k8qjzmQnUpfrcFhYr526QpwIBjHfgITsD6fv8ipZCGPqcRhAhQJhQG4RsW31qHLZ
         EpVDWMv/hvDCDbd22Uj9PCLg0lOIn85RX7Vp5BCkaO7WT0PoXX7TQ9mh58intWK6A6xq
         4FYvY21gw6AbzK1TB7eeFHuZ+GFYJRUZwWKZzBpnFeqL6uI+h69x4J8Z/zGnGyGAxNeD
         5buw9Ki0bvnsd+IOa3uRynJbz6QSqlMf4H7PpZGyOM4MfhWZb+YqEIKimrIx/Fn95FXp
         m2+Q==
X-Gm-Message-State: APt69E3E+htjTvLn/NeCb7I5ecDlhxoddVDjLaiQ33sFNaui1tKDb+I6
        +wRGsJw9BQI4J3a3lGBu3twhZvuvydnWUTfpfhb2EA==
X-Google-Smtp-Source: AAOMgpdmxUfWwDYZ43aYP98s5+IaHVwuTxAI0uiA/Zdk50NjCVImPIPolJFPY98VrIX+gf6CkfRXCoacwA66cbAcaTg=
X-Received: by 2002:a6b:1884:: with SMTP id 126-v6mr7420089ioy.183.1530871813598;
 Fri, 06 Jul 2018 03:10:13 -0700 (PDT)
MIME-Version: 1.0
References: <20180628114043.24724-1-quentin.perret@arm.com> <20180628114043.24724-13-quentin.perret@arm.com>
In-Reply-To: <20180628114043.24724-13-quentin.perret@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 6 Jul 2018 12:10:02 +0200
Message-ID: <CAKfTPtAANKzw7QTzKiU_ntiGYMxZD3etd8wMzXtngwUWHXj+Hg@mail.gmail.com>
Subject: Re: [RFC PATCH v4 12/12] OPTIONAL: cpufreq: dt: Register an Energy Model
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Chris Redpath <chris.redpath@arm.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        viresh kumar <viresh.kumar@linaro.org>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Cc: Steve Muckle" <smuckle@google.com>, adharmap@quicinc.com,
        "Kannan, Saravana" <skannan@quicinc.com>, pkondeti@codeaurora.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        currojerez@riseup.net, Javi Merino <javi.merino@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Jun 2018 at 13:41, Quentin Perret <quentin.perret@arm.com> wrote:
>
> *******************************************************************
> * This patch illustrates the usage of the newly introduced Energy *
> * Model framework and isn't supposed to be merged as-is.          *
> *******************************************************************
>
> The Energy Model framework provides an API to register the active power
> of CPUs. Call this API from the cpufreq-dt driver with an estimation
> of the power as P = C * V^2 * f with C, V, and f respectively the
> capacitance of the CPU and the voltage and frequency of the OPP.
>
> The CPU capacitance is read from the "dynamic-power-coefficient" DT
> binding (originally introduced for thermal/IPA), and the voltage and
> frequency values from PM_OPP.
>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Quentin Perret <quentin.perret@arm.com>
> ---
>  drivers/cpufreq/cpufreq-dt.c | 45 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 44 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
> index 190ea0dccb79..5a0747f73121 100644
> --- a/drivers/cpufreq/cpufreq-dt.c
> +++ b/drivers/cpufreq/cpufreq-dt.c
> @@ -16,6 +16,7 @@
>  #include <linux/cpu_cooling.h>
>  #include <linux/cpufreq.h>
>  #include <linux/cpumask.h>
> +#include <linux/energy_model.h>
>  #include <linux/err.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> @@ -149,8 +150,47 @@ static int resources_available(void)
>         return 0;
>  }
>
> +static int of_est_power(unsigned long *mW, unsigned long *KHz, int cpu)
> +{
> +       unsigned long mV, Hz, MHz;
> +       struct device *cpu_dev;
> +       struct dev_pm_opp *opp;
> +       struct device_node *np;
> +       u32 cap;
> +       u64 tmp;
> +
> +       cpu_dev = get_cpu_device(cpu);
> +       if (!cpu_dev)
> +               return -ENODEV;
> +
> +       np = of_node_get(cpu_dev->of_node);
> +       if (!np)
> +               return -EINVAL;
> +
> +       if (of_property_read_u32(np, "dynamic-power-coefficient", &cap))
> +               return -EINVAL;
> +
> +       Hz = *KHz * 1000;
> +       opp = dev_pm_opp_find_freq_ceil(cpu_dev, &Hz);
> +       if (IS_ERR(opp))
> +               return -EINVAL;
> +
> +       mV = dev_pm_opp_get_voltage(opp) / 1000;
> +       dev_pm_opp_put(opp);
> +
> +       MHz = Hz / 1000000;
> +       tmp = (u64)cap * mV * mV * MHz;
> +       do_div(tmp, 1000000000);

Could you explain the formula above ? and especially the 1000000000 it
seems related to the use of mV and mW instead of uV and uW ...

Can't you just optimize that into
tmp = (u64)cap * mV * mV * Hz;
do_div(tmp, 1000);

> +
> +       *mW = (unsigned long)tmp;
> +       *KHz = Hz / 1000;
> +
> +       return 0;
> +}
> +
>  static int cpufreq_init(struct cpufreq_policy *policy)
>  {
> +       struct em_data_callback em_cb = EM_DATA_CB(of_est_power);
>         struct cpufreq_frequency_table *freq_table;
>         struct opp_table *opp_table = NULL;
>         struct private_data *priv;
> @@ -159,7 +199,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
>         unsigned int transition_latency;
>         bool fallback = false;
>         const char *name;
> -       int ret;
> +       int ret, nr_opp;
>
>         cpu_dev = get_cpu_device(policy->cpu);
>         if (!cpu_dev) {
> @@ -226,6 +266,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
>                 ret = -EPROBE_DEFER;
>                 goto out_free_opp;
>         }
> +       nr_opp = ret;
>
>         if (fallback) {
>                 cpumask_setall(policy->cpus);
> @@ -278,6 +319,8 @@ static int cpufreq_init(struct cpufreq_policy *policy)
>         policy->cpuinfo.transition_latency = transition_latency;
>         policy->dvfs_possible_from_any_cpu = true;
>
> +       em_register_freq_domain(policy->cpus, nr_opp, &em_cb);
> +
>         return 0;
>
>  out_free_cpufreq_table:
> --
> 2.17.1
>

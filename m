Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 5zVPCqpEGVtKFAAAmS7hNA
	; Thu, 07 Jun 2018 14:46:04 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 54FD5608BA; Thu,  7 Jun 2018 14:46:04 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 2E116602FC;
	Thu,  7 Jun 2018 14:46:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2E116602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934879AbeFGOqB (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:46:01 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:39461 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934566AbeFGOo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:44:26 -0400
Received: by mail-wm0-f66.google.com with SMTP id p11-v6so19715145wmc.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 07:44:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lPIdMeIPFkIk5sx+VXXdmtBINEcDvlVn0Mp2Z0UMp70=;
        b=WD5fr4gxHRXoECm5W+Fsg+rwVx+UbZY5jPq7nb+0EzzhYOyVcIcpJzTZFRjHEd918C
         VSLVUV6/LXyMi16aF2Rb1kIh80W+4TxkHJgGuA/6m+ENGZwP/qM3/xgXLqjCxErt8lrV
         o2wRCGMPECEOaFmU2GopVSfgiiolkG6tFxmdhkv3iNkdcPsF7vtaonJ78G6IdlRmpQbZ
         gQoG+XYvflzeyeNALIb1+iW4lC4Yz40zfbb1PKQ5i9chR8hvGP9v9gFN5eOa84h19Wwp
         6bZrFO8iXGasMFqzgOaxqfNhEOwBpU5KQ0ItuFF8Nh+qaeh/8ea0I5u8o8B+bLSJCqGG
         fPNg==
X-Gm-Message-State: APt69E14AOrtsLLbkiOrXiGhbFAmDtJCgUAGigkVIKqt2fYbYG0h3+5y
        3K3VEtoVGu1o0uat0UnlBl1uEA==
X-Google-Smtp-Source: ADUXVKIel/tFc2NOtFSjOrBH9mUqSArjvXc+EU1byrM/YO19p/tUFtmbQry/Gv9rs5tnFAXyYCsPVg==
X-Received: by 2002:a1c:2806:: with SMTP id o6-v6mr1801388wmo.151.1528382665257;
        Thu, 07 Jun 2018 07:44:25 -0700 (PDT)
Received: from localhost.localdomain ([151.15.207.242])
        by smtp.gmail.com with ESMTPSA id j21-v6sm1178238wme.36.2018.06.07.07.44.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Jun 2018 07:44:24 -0700 (PDT)
Date: Thu, 7 Jun 2018 16:44:22 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Quentin Perret <quentin.perret@arm.com>
Cc: peterz@infradead.org, rjw@rjwysocki.net,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, mingo@redhat.com,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        chris.redpath@arm.com, patrick.bellasi@arm.com,
        valentin.schneider@arm.com, vincent.guittot@linaro.org,
        thara.gopinath@linaro.org, viresh.kumar@linaro.org,
        tkjos@google.com, joelaf@google.com, smuckle@google.com,
        adharmap@quicinc.com, skannan@quicinc.com, pkondeti@codeaurora.org,
        edubezval@gmail.com, srinivas.pandruvada@linux.intel.com,
        currojerez@riseup.net, javi.merino@kernel.org
Subject: Re: [RFC PATCH v3 05/10] sched/topology: Reference the Energy Model
 of CPUs when available
Message-ID: <20180607144422.GA17216@localhost.localdomain>
References: <20180521142505.6522-1-quentin.perret@arm.com>
 <20180521142505.6522-6-quentin.perret@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180521142505.6522-6-quentin.perret@arm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 21/05/18 15:25, Quentin Perret wrote:
> In order to use EAS, the task scheduler has to know about the Energy
> Model (EM) of the platform. This commit extends the scheduler topology
> code to take references on the frequency domains objects of the EM
> framework for all online CPUs. Hence, the availability of the EM for
> those CPUs is guaranteed to the scheduler at runtime without further
> checks in latency sensitive code paths (i.e. task wake-up).
> 
> A (RCU-protected) private list of online frequency domains is maintained
> by the scheduler to enable fast iterations. Furthermore, the availability
> of an EM is notified to the rest of the scheduler with a static key,
> which ensures a low impact on non-EAS systems.
> 
> Energy Aware Scheduling can be started if and only if:
>    1. all online CPUs are covered by the EM;
>    2. the EM complexity is low enough to keep scheduling overheads low;
>    3. the platform has an asymmetric CPU capacity topology (detected by
>       looking for the SD_ASYM_CPUCAPACITY flag in the sched_domain
>       hierarchy).

Not sure about this. How about multi-freq domain same max capacity
systems. I understand that most of the energy saving come from selecting
the right (big/LITTLE) cluster, but EM should still be useful to drive
OPP selection (that was one of the use-cases we discussed lately IIRC)
and also to decide between packing or spreading, no?

> The sched_energy_enabled() function which returns the status of the
> static key is stubbed to false when CONFIG_ENERGY_MODEL=n, hence making
> sure that all the code behind it can be compiled out by constant
> propagation.

Actually, do we need a config option at all? Shouldn't the static key
(and RCU machinery) guard against unwanted overheads when EM is not
present/used?

I was thinking it should be pretty similar to schedutil setup, no?

> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Quentin Perret <quentin.perret@arm.com>
> ---
>  kernel/sched/sched.h    |  27 ++++++++++
>  kernel/sched/topology.c | 113 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 140 insertions(+)
> 
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index ce562d3b7526..7c517076a74a 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -63,6 +63,7 @@
>  #include <linux/syscalls.h>
>  #include <linux/task_work.h>
>  #include <linux/tsacct_kern.h>
> +#include <linux/energy_model.h>
>  
>  #include <asm/tlb.h>
>  
> @@ -2162,3 +2163,29 @@ static inline unsigned long cpu_util_cfs(struct rq *rq)
>  	return util;
>  }
>  #endif
> +
> +struct sched_energy_fd {
> +	struct em_freq_domain *fd;
> +	struct list_head next;
> +	struct rcu_head rcu;
> +};
> +
> +#ifdef CONFIG_ENERGY_MODEL
> +extern struct static_key_false sched_energy_present;
> +static inline bool sched_energy_enabled(void)
> +{
> +	return static_branch_unlikely(&sched_energy_present);
> +}
> +
> +extern struct list_head sched_energy_fd_list;
> +#define for_each_freq_domain(sfd) \
> +		list_for_each_entry_rcu(sfd, &sched_energy_fd_list, next)
> +#define freq_domain_span(sfd) (&((sfd)->fd->cpus))
> +#else
> +static inline bool sched_energy_enabled(void)
> +{
> +	return false;
> +}
> +#define for_each_freq_domain(sfd) for (sfd = NULL; sfd;)
> +#define freq_domain_span(sfd) NULL
> +#endif
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 64cc564f5255..3e22c798f18d 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -1500,6 +1500,116 @@ void sched_domains_numa_masks_clear(unsigned int cpu)
>  
>  #endif /* CONFIG_NUMA */
>  
> +#ifdef CONFIG_ENERGY_MODEL
> +
> +/*
> + * The complexity of the Energy Model is defined as the product of the number
> + * of frequency domains with the sum of the number of CPUs and the total
> + * number of OPPs in all frequency domains. It is generally not a good idea
> + * to use such a model on very complex platform because of the associated
> + * scheduling overheads. The arbitrary constraint below prevents that. It
> + * makes EAS usable up to 16 CPUs with per-CPU DVFS and less than 8 OPPs each,
> + * for example.
> + */
> +#define EM_MAX_COMPLEXITY 2048

Do we really need this hardcoded constant?

I guess if one spent time deriving an EM for a big system with lot of
OPPs, she/he already knows what is doing? :)

> +
> +DEFINE_STATIC_KEY_FALSE(sched_energy_present);
> +LIST_HEAD(sched_energy_fd_list);
> +
> +static struct sched_energy_fd *find_sched_energy_fd(int cpu)
> +{
> +	struct sched_energy_fd *sfd;
> +
> +	for_each_freq_domain(sfd) {
> +		if (cpumask_test_cpu(cpu, freq_domain_span(sfd)))
> +			return sfd;
> +	}
> +
> +	return NULL;
> +}
> +
> +static void free_sched_energy_fd(struct rcu_head *rp)
> +{
> +	struct sched_energy_fd *sfd;
> +
> +	sfd = container_of(rp, struct sched_energy_fd, rcu);
> +	kfree(sfd);
> +}
> +
> +static void build_sched_energy(void)
> +{
> +	struct sched_energy_fd *sfd, *tmp;
> +	struct em_freq_domain *fd;
> +	struct sched_domain *sd;
> +	int cpu, nr_fd = 0, nr_opp = 0;
> +
> +	rcu_read_lock();
> +
> +	/* Disable EAS entirely whenever the system isn't asymmetric. */
> +	cpu = cpumask_first(cpu_online_mask);
> +	sd = lowest_flag_domain(cpu, SD_ASYM_CPUCAPACITY);
> +	if (!sd) {
> +		pr_debug("%s: no SD_ASYM_CPUCAPACITY\n", __func__);
> +		goto disable;
> +	}
> +
> +	/* Make sure to have an energy model for all CPUs. */
> +	for_each_online_cpu(cpu) {
> +		/* Skip CPUs with a known energy model. */
> +		sfd = find_sched_energy_fd(cpu);
> +		if (sfd)
> +			continue;
> +
> +		/* Add the energy model of others. */
> +		fd = em_cpu_get(cpu);
> +		if (!fd)
> +			goto disable;
> +		sfd = kzalloc(sizeof(*sfd), GFP_NOWAIT);
> +		if (!sfd)
> +			goto disable;
> +		sfd->fd = fd;
> +		list_add_rcu(&sfd->next, &sched_energy_fd_list);
> +	}
> +
> +	list_for_each_entry_safe(sfd, tmp, &sched_energy_fd_list, next) {
> +		if (cpumask_intersects(freq_domain_span(sfd),
> +							cpu_online_mask)) {
> +			nr_opp += em_fd_nr_cap_states(sfd->fd);
> +			nr_fd++;
> +			continue;
> +		}
> +
> +		/* Remove the unused frequency domains */
> +		list_del_rcu(&sfd->next);
> +		call_rcu(&sfd->rcu, free_sched_energy_fd);

Unused because of? Hotplug?

Not sure, but I guess you have considered the idea of tearing all this
down when sched domains are destroied and then rebuilding it again? Why
did you decide for this approach? Or maybe I just missed where you do
that. :/

> +	}
> +
> +	/* Bail out if the Energy Model complexity is too high. */
> +	if (nr_fd * (nr_opp + num_online_cpus()) > EM_MAX_COMPLEXITY) {
> +		pr_warn("%s: EM complexity too high, stopping EAS", __func__);
> +		goto disable;
> +	}
> +
> +	rcu_read_unlock();
> +	static_branch_enable_cpuslocked(&sched_energy_present);
> +	pr_debug("%s: EAS started\n", __func__);

I'd vote for a pr_info here instead, maybe printing info about the em as
well. Looks pretty useful to me to have that in dmesg. Maybe guarded by
sched_debug?

Best,

- Juri

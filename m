Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id tSBWGH1EGVuCFAAAmS7hNA
	; Thu, 07 Jun 2018 14:44:21 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 71EAD608BA; Thu,  7 Jun 2018 14:44:21 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 9A63D607E7;
	Thu,  7 Jun 2018 14:44:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9A63D607E7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934891AbeFGOoS (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:44:18 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:40986 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934070AbeFGOoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:44:14 -0400
Received: by mail-wr0-f196.google.com with SMTP id h10-v6so10131305wrq.8
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 07:44:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=grSx2x3asy2nHdMpcJSRY+6ObtO9DCkYWIuklQv4nsE=;
        b=qOj53YANvpuOWXuEhTwThbYzF7+ZFW2/98HCzv3yndM6lWHjqO0LHVssg6wVWPu070
         pKI0ZquST0g12fxrC2efKZGZ0sNpL93NJbb24WvuxqV795OpN5QQZ7MVwp9E7/VOXAl1
         s02PfPIt6Ojg/veavNLRXXQ5djLLF3UsvARqWw3GKHHcHG7/oQJAQSuOBCQl9dKTly4x
         ++Th9/Jx2TTE8/P7t9w1CBC2mhk7YJ2+HsaXBbf2Ja4IBvCfFH+OI91y4mf/x6R+jSU/
         F4rXCB803OUJ53wB764H2v0/XUhOUfqFFANpAtm7pWPPvKBKKYg4sJK9oIW5rVTyq9ld
         GLHA==
X-Gm-Message-State: APt69E2uZwX+PTvXpIaIJX16UzozpbhNYUhIYpsf0vftbA3vExnh/XcV
        +Uem8vwzp2UnQjtb6cqUS/GliA==
X-Google-Smtp-Source: ADUXVKItN8H9ltTWCy1VKEgrRHlkEEq6gvy6WPYOOssnEuNmdLpBDc5mvZPsRgHaIRVYYgKqN4mCbg==
X-Received: by 2002:adf:c907:: with SMTP id m7-v6mr2126774wrh.6.1528382653267;
        Thu, 07 Jun 2018 07:44:13 -0700 (PDT)
Received: from localhost.localdomain ([151.15.207.242])
        by smtp.gmail.com with ESMTPSA id u15-v6sm2704661wma.37.2018.06.07.07.44.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Jun 2018 07:44:12 -0700 (PDT)
Date: Thu, 7 Jun 2018 16:44:09 +0200
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
Subject: Re: [RFC PATCH v3 03/10] PM: Introduce an Energy Model management
 framework
Message-ID: <20180607144409.GB3311@localhost.localdomain>
References: <20180521142505.6522-1-quentin.perret@arm.com>
 <20180521142505.6522-4-quentin.perret@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180521142505.6522-4-quentin.perret@arm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/05/18 15:24, Quentin Perret wrote:
> Several subsystems in the kernel (scheduler and/or thermal at the time
> of writing) can benefit from knowing about the energy consumed by CPUs.
> Yet, this information can come from different sources (DT or firmware for
> example), in different formats, hence making it hard to exploit without
> a standard API.
> 
> This patch attempts to solve this issue by introducing a centralized
> Energy Model (EM) framework which can be used to interface the data
> providers with the client subsystems. This framework standardizes the
> API to expose power costs, and to access them from multiple locations.
> 
> The current design assumes that all CPUs in a frequency domain share the
> same micro-architecture. As such, the EM data is structured in a
> per-frequency-domain fashion. Drivers aware of frequency domains
> (typically, but not limited to, CPUFreq drivers) are expected to register
> data in the EM framework using the em_register_freq_domain() API. To do
> so, the drivers must provide a callback function that will be called by
> the EM framework to populate the tables. As of today, only the active
> power of the CPUs is considered. For each frequency domain, the EM
> includes a list of <frequency, power, capacity> tuples for the capacity
> states of the domain alongside a cpumask covering the involved CPUs.
> 
> The EM framework also provides an API to re-scale the capacity values
> of the model asynchronously, after it has been created. This is required
> for architectures where the capacity scale factor of CPUs can change at
> run-time. This is the case for Arm/Arm64 for example where the
> arch_topology driver recomputes the capacity scale factors of the CPUs
> after the maximum frequency of all CPUs has been discovered. Although
> complex, the process of creating and re-scaling the EM has to be kept in
> two separate steps to fulfill the needs of the different users. The thermal
> subsystem doesn't use the capacity values and shouldn't have dependencies
> on subsystems providing them. On the other hand, the task scheduler needs
> the capacity values, and it will benefit from seeing them up-to-date when
> applicable.
> 
> Because of this need for asynchronous update, the capacity state table
> of each frequency domain is protected by RCU, hence guaranteeing a safe
> modification of the table and a fast access to readers in latency-sensitive
> code paths.
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Signed-off-by: Quentin Perret <quentin.perret@arm.com>
> ---

OK, I think I'll start with a few comments while I get more into
understanding the set. :)

> +static void fd_update_cs_table(struct em_cs_table *cs_table, int cpu)
> +{
> +	unsigned long cmax = arch_scale_cpu_capacity(NULL, cpu);
> +	int max_cap_state = cs_table->nr_cap_states - 1;
                 ^
You don't need this on the stack, right?

> +	unsigned long fmax = cs_table->state[max_cap_state].frequency;
> +	int i;
> +
> +	for (i = 0; i < cs_table->nr_cap_states; i++)
> +		cs_table->state[i].capacity = cmax *
> +					cs_table->state[i].frequency / fmax;
> +}
> +
> +static struct em_freq_domain *em_create_fd(cpumask_t *span, int nr_states,
> +						struct em_data_callback *cb)
> +{
> +	unsigned long opp_eff, prev_opp_eff = ULONG_MAX;
> +	int i, ret, cpu = cpumask_first(span);
> +	struct em_freq_domain *fd;
> +	unsigned long power, freq;
> +
> +	if (!cb->active_power)
> +		return NULL;
> +
> +	fd = kzalloc(sizeof(*fd), GFP_KERNEL);
> +	if (!fd)
> +		return NULL;
> +
> +	fd->cs_table = alloc_cs_table(nr_states);

Mmm, don't you need to rcu_assign_pointer this first one as well?

> +	if (!fd->cs_table)
> +		goto free_fd;
> +
> +	/* Copy the span of the frequency domain */
> +	cpumask_copy(&fd->cpus, span);
> +
> +	/* Build the list of capacity states for this freq domain */
> +	for (i = 0, freq = 0; i < nr_states; i++, freq++) {
                     ^                              ^
The fact that this relies on active_power() to use ceil OPP for a given
freq might deserve a comment. Also, is this behaviour of active_power()
standardized?

> +		ret = cb->active_power(&power, &freq, cpu);
> +		if (ret)
> +			goto free_cs_table;
> +
> +		fd->cs_table->state[i].power = power;
> +		fd->cs_table->state[i].frequency = freq;
> +
> +		/*
> +		 * The hertz/watts efficiency ratio should decrease as the
> +		 * frequency grows on sane platforms. If not, warn the user
> +		 * that some high OPPs are more power efficient than some
> +		 * of the lower ones.
> +		 */
> +		opp_eff = freq / power;
> +		if (opp_eff >= prev_opp_eff)
> +			pr_warn("%*pbl: hz/watt efficiency: OPP %d >= OPP%d\n",
> +					cpumask_pr_args(span), i, i - 1);
> +		prev_opp_eff = opp_eff;
> +	}
> +	fd_update_cs_table(fd->cs_table, cpu);
> +
> +	return fd;
> +
> +free_cs_table:
> +	free_cs_table(fd->cs_table);
> +free_fd:
> +	kfree(fd);
> +
> +	return NULL;
> +}
> +
> +static void rcu_free_cs_table(struct rcu_head *rp)
> +{
> +	struct em_cs_table *table;
> +
> +	table = container_of(rp, struct em_cs_table, rcu);
> +	free_cs_table(table);
> +}
> +
> +/**
> + * em_rescale_cpu_capacity() - Re-scale capacity values of the Energy Model
> + *
> + * This re-scales the capacity values for all capacity states of all frequency
> + * domains of the Energy Model. This should be used when the capacity values
> + * of the CPUs are updated at run-time, after the EM was registered.
> + */
> +void em_rescale_cpu_capacity(void)

So, is this thought to be called eventually also after thermal capping
events and such?

> +{
> +	struct em_cs_table *old_table, *new_table;
> +	struct em_freq_domain *fd;
> +	unsigned long flags;
> +	int nr_states, cpu;
> +
> +	read_lock_irqsave(&em_data_lock, flags);

Don't you need write_lock_ here, since you are going to exchange the
em tables?

> +	for_each_cpu(cpu, cpu_possible_mask) {
> +		fd = per_cpu(em_data, cpu);
> +		if (!fd || cpu != cpumask_first(&fd->cpus))
> +			continue;
> +
> +		/* Copy the existing table. */
> +		old_table = rcu_dereference(fd->cs_table);
> +		nr_states = old_table->nr_cap_states;
> +		new_table = alloc_cs_table(nr_states);
> +		if (!new_table) {
> +			read_unlock_irqrestore(&em_data_lock, flags);
> +			return;
> +		}
> +		memcpy(new_table->state, old_table->state,
> +					nr_states * sizeof(*new_table->state));
> +
> +		/* Re-scale the capacity values on the copy. */
> +		fd_update_cs_table(new_table, cpumask_first(&fd->cpus));
> +
> +		/* Replace the table with the rescaled version. */
> +		rcu_assign_pointer(fd->cs_table, new_table);
> +		call_rcu(&old_table->rcu, rcu_free_cs_table);
> +	}
> +	read_unlock_irqrestore(&em_data_lock, flags);
> +	pr_debug("Re-scaled CPU capacities\n");
> +}
> +EXPORT_SYMBOL_GPL(em_rescale_cpu_capacity);
> +
> +/**
> + * em_cpu_get() - Return the frequency domain for a CPU
> + * @cpu : CPU to find the frequency domain for
> + *
> + * Return: the frequency domain to which 'cpu' belongs, or NULL if it doesn't
> + * exist.
> + */
> +struct em_freq_domain *em_cpu_get(int cpu)
> +{
> +	struct em_freq_domain *fd;
> +	unsigned long flags;
> +
> +	read_lock_irqsave(&em_data_lock, flags);
> +	fd = per_cpu(em_data, cpu);
> +	read_unlock_irqrestore(&em_data_lock, flags);
> +
> +	return fd;
> +}
> +EXPORT_SYMBOL_GPL(em_cpu_get);

Mmm, this gets complicated pretty fast eh? :)

I had to go back and forth between patches to start understanding the
different data structures and how they are use, and I'm not sure yet
I've got the full picture. I guess some nice diagram (cover letter or
documentation patch) would help a lot.

Locking of such data structures is pretty involved as well, adding
comments/docs shouldn't harm. :)

Best,

- Juri

Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EABC2C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 08:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 982DB2083A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 08:42:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="G+OoRuIn";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="l+mYHUmL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 982DB2083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937440AbeFSImM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 04:42:12 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57564 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937388AbeFSImJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 04:42:09 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 79EDF60B22; Tue, 19 Jun 2018 08:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529397728;
        bh=4Ba4/fiIAe8okicJw+AvqtN/NuFAKYXniN1wWK3qRFE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G+OoRuInx/KhZNRRiHRS48iIef41OoFaOrls0Osp/PpgMHr1ktExm+ydeKoM457i7
         CzZUVadtcwNnXslwA1fraCGbk98lMgqB7cgHqwzDESnwnM+82YkxU6P/NcPyUJE5vZ
         m85Po0JbqP7bCyQhc4kBxt5jOvxrpYbE7W2sESpo=
Received: from codeaurora.org (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pkondeti@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3214F60B7A;
        Tue, 19 Jun 2018 08:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529397726;
        bh=4Ba4/fiIAe8okicJw+AvqtN/NuFAKYXniN1wWK3qRFE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l+mYHUmLf4fteU6ZkKBnbLrfg9XMPVwK6MyNPyuyvVDRve+ZbQUiElLttAx+qAkEH
         VBJZUYoMoc0EtZErFU4b9cgrf/t1U3VVuVcnWwLu/Z45gySR9vQRU4Mb0AUxAFTSgE
         l/s0v7yIGmJqj5LtZNzWZe28aQm2dRlPPnZ4jMj8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3214F60B7A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=pkondeti@codeaurora.org
Date:   Tue, 19 Jun 2018 14:11:56 +0530
From:   Pavan Kondeti <pkondeti@codeaurora.org>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     peterz@infradead.org, rjw@rjwysocki.net,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, mingo@redhat.com,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        chris.redpath@arm.com, patrick.bellasi@arm.com,
        valentin.schneider@arm.com, vincent.guittot@linaro.org,
        thara.gopinath@linaro.org, viresh.kumar@linaro.org,
        tkjos@google.com, joelaf@google.com, smuckle@google.com,
        adharmap@quicinc.com, skannan@quicinc.com, juri.lelli@redhat.com,
        edubezval@gmail.com, srinivas.pandruvada@linux.intel.com,
        currojerez@riseup.net, javi.merino@kernel.org
Subject: Re: [RFC PATCH v3 09/10] sched/fair: Select an energy-efficient CPU
 on task wake-up
Message-ID: <20180619084156.GC9208@codeaurora.org>
References: <20180521142505.6522-1-quentin.perret@arm.com>
 <20180521142505.6522-10-quentin.perret@arm.com>
 <20180619050601.GA9208@codeaurora.org>
 <20180619075723.GQ17720@e108498-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180619075723.GQ17720@e108498-lin.cambridge.arm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 08:57:23AM +0100, Quentin Perret wrote:
> Hi Pavan,
> 
> On Tuesday 19 Jun 2018 at 10:36:01 (+0530), Pavan Kondeti wrote:
> > On Mon, May 21, 2018 at 03:25:04PM +0100, Quentin Perret wrote:
> > 
> > <snip>
> > 
> > > +	if (cpumask_test_cpu(prev_cpu, &p->cpus_allowed))
> > > +		prev_energy = best_energy = compute_energy(p, prev_cpu);
> > > +	else
> > > +		prev_energy = best_energy = ULONG_MAX;
> > > +
> > > +	for_each_freq_domain(sfd) {
> > > +		unsigned long spare_cap, max_spare_cap = 0;
> > > +		int max_spare_cap_cpu = -1;
> > > +		unsigned long util;
> > > +
> > > +		/* Find the CPU with the max spare cap in the freq. dom. */
> > > +		for_each_cpu_and(cpu, freq_domain_span(sfd), sched_domain_span(sd)) {
> > > +			if (!cpumask_test_cpu(cpu, &p->cpus_allowed))
> > > +				continue;
> > > +
> > > +			if (cpu == prev_cpu)
> > > +				continue;
> > > +
> > > +			/* Skip CPUs that will be overutilized */
> > > +			util = cpu_util_wake(cpu, p) + task_util;
> > > +			cpu_cap = capacity_of(cpu);
> > > +			if (cpu_cap * 1024 < util * capacity_margin)
> > > +				continue;
> > > +
> > > +			spare_cap = cpu_cap - util;
> > > +			if (spare_cap > max_spare_cap) {
> > > +				max_spare_cap = spare_cap;
> > > +				max_spare_cap_cpu = cpu;
> > > +			}
> > > +		}
> > > +
> > > +		/* Evaluate the energy impact of using this CPU. */
> > > +		if (max_spare_cap_cpu >= 0) {
> > > +			cur_energy = compute_energy(p, max_spare_cap_cpu);
> > > +			if (cur_energy < best_energy) {
> > > +				best_energy = cur_energy;
> > > +				best_energy_cpu = max_spare_cap_cpu;
> > > +			}
> > > +		}
> > > +	}
> > > +
> > > +	/*
> > > +	 * We pick the best CPU only if it saves at least 1.5% of the
> > > +	 * energy used by prev_cpu.
> > > +	 */
> > > +	if ((prev_energy - best_energy) > (prev_energy >> 6))
> > > +		return best_energy_cpu;
> > > +
> > > +	return prev_cpu;
> > > +}
> > 
> > We are comparing the best_energy_cpu against prev_cpu even when prev_cpu
> > can't accommodate the waking task. Is this intentional? Should not we
> > discard the prev_cpu if it can't accommodate the task.
> > 
> > This can potentially make a BIG task run on a lower capacity CPU until
> > load balancer kicks in and corrects the situation.
> 
> We shouldn't enter find_energy_efficient_cpu() in the first place if the
> system is overutilized, so that shouldn't too much of an issue in
> general.
> 

With UTIL_EST enabled, the overutilization condtion may get turned off when
that 1 BIG task goes to sleep. When it wakes up again, we may place it on
the previous CPU due to the above mentioned issue.

It is not just an existing overutilization condition. By placing this task
on the prev_cpu, we may enter overutilization state.

> But yeah, there is one small corner case where prev_cpu is overutilized
> and the system has not been flagged as such yet (when the tasks wakes-up
> shortly before the tick for ex). I think it's possible to cover this case
> by extending the "if (cpumask_test_cpu(prev_cpu, &p->cpus_allowed))"
> condition at the top of the function with a check on capacity_margin.
> 

LGTM.

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.


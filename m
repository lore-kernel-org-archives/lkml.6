Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5926C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 05:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DA042083A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 05:06:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ec2tVdYI";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="iGvW7xpQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DA042083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755952AbeFSFGP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 01:06:15 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44224 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751602AbeFSFGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 01:06:12 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 60EB460B1E; Tue, 19 Jun 2018 05:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529384772;
        bh=u/s/sdA6kjjvB6aNykJ1nXPxKMoyQJwQRROY0fH9xi8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ec2tVdYICAPE0aFOQOLw9HiUyGP7tzcPfiunccY1YHD+aC9ViW572tDBNz17xLNXQ
         /pdDbbSqzVvMKjWK5xbLUy0Ddq69UXhJoZnYUR/2XHt+de5w9F0R7pkIc6ofOWSoHC
         j1GMFC/oHOiGiIl/gfwvbW8oi/3FuuPY1I7eP9Pw=
Received: from codeaurora.org (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pkondeti@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 25EFA6060A;
        Tue, 19 Jun 2018 05:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529384771;
        bh=u/s/sdA6kjjvB6aNykJ1nXPxKMoyQJwQRROY0fH9xi8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iGvW7xpQkVDDRvqk3SVPiPmebcLu6rWD0f7ia38YRcq2fHjo/V3CVuNdaOJE35zSc
         EVKMdHTBcnr5wMg3rdXyvdh4EaJ232Eqj9RNVCF9D7PTB+uZCUi869YmIo/A60ho5t
         IdjrzSo0qIIyhZlcp3g0ztNys15ehVB+ctryftwc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 25EFA6060A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=pkondeti@codeaurora.org
Date:   Tue, 19 Jun 2018 10:36:01 +0530
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
Message-ID: <20180619050601.GA9208@codeaurora.org>
References: <20180521142505.6522-1-quentin.perret@arm.com>
 <20180521142505.6522-10-quentin.perret@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180521142505.6522-10-quentin.perret@arm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2018 at 03:25:04PM +0100, Quentin Perret wrote:

<snip>

> +	if (cpumask_test_cpu(prev_cpu, &p->cpus_allowed))
> +		prev_energy = best_energy = compute_energy(p, prev_cpu);
> +	else
> +		prev_energy = best_energy = ULONG_MAX;
> +
> +	for_each_freq_domain(sfd) {
> +		unsigned long spare_cap, max_spare_cap = 0;
> +		int max_spare_cap_cpu = -1;
> +		unsigned long util;
> +
> +		/* Find the CPU with the max spare cap in the freq. dom. */
> +		for_each_cpu_and(cpu, freq_domain_span(sfd), sched_domain_span(sd)) {
> +			if (!cpumask_test_cpu(cpu, &p->cpus_allowed))
> +				continue;
> +
> +			if (cpu == prev_cpu)
> +				continue;
> +
> +			/* Skip CPUs that will be overutilized */
> +			util = cpu_util_wake(cpu, p) + task_util;
> +			cpu_cap = capacity_of(cpu);
> +			if (cpu_cap * 1024 < util * capacity_margin)
> +				continue;
> +
> +			spare_cap = cpu_cap - util;
> +			if (spare_cap > max_spare_cap) {
> +				max_spare_cap = spare_cap;
> +				max_spare_cap_cpu = cpu;
> +			}
> +		}
> +
> +		/* Evaluate the energy impact of using this CPU. */
> +		if (max_spare_cap_cpu >= 0) {
> +			cur_energy = compute_energy(p, max_spare_cap_cpu);
> +			if (cur_energy < best_energy) {
> +				best_energy = cur_energy;
> +				best_energy_cpu = max_spare_cap_cpu;
> +			}
> +		}
> +	}
> +
> +	/*
> +	 * We pick the best CPU only if it saves at least 1.5% of the
> +	 * energy used by prev_cpu.
> +	 */
> +	if ((prev_energy - best_energy) > (prev_energy >> 6))
> +		return best_energy_cpu;
> +
> +	return prev_cpu;
> +}

We are comparing the best_energy_cpu against prev_cpu even when prev_cpu
can't accommodate the waking task. Is this intentional? Should not we
discard the prev_cpu if it can't accommodate the task.

This can potentially make a BIG task run on a lower capacity CPU until
load balancer kicks in and corrects the situation.

Thanks,
Pavan
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.


Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39F09C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 07:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFED920661
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 07:01:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="KkON4Epb";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="H5MrMZPE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFED920661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755803AbeFSHBR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 03:01:17 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46802 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751337AbeFSHBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 03:01:14 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6D4AC60B16; Tue, 19 Jun 2018 07:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529391674;
        bh=gih+LvUCybb976nuhnQeu7Shw9g6udKDNJaZkf4EUGA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KkON4Epb23+R0VlOByiykPZe6DVq+8ati0duWBjay9bGfc0xUiIQOX1dRMkxSWrRg
         19wPFPrVI0PeyK7N3P1OC9Go7W/t8+YDXKT6e5xHvBvEBfEi6HpajOACnklaZLTS4a
         ClJu4xDRxv1wbDvUb4yTGMfWDcyUDQ8R96sWLOAM=
Received: from codeaurora.org (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pkondeti@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E7851607EB;
        Tue, 19 Jun 2018 07:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529391673;
        bh=gih+LvUCybb976nuhnQeu7Shw9g6udKDNJaZkf4EUGA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H5MrMZPEsr8sxJ+9cTWHCl0pBdai/xUxuQb43G0O6GGz0yl5FeZg8roAi+m3qN7rZ
         EWBKULif7YQtvXSGKiahOGFif4S8ddfrj21Vqi7wHzqrLx4/AdtRRu/UDi6Kp/Kww3
         fWAd7ZLak+f9/ycxyjR8BcSIcagtVXE/F15bw400=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E7851607EB
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=pkondeti@codeaurora.org
Date:   Tue, 19 Jun 2018 12:31:03 +0530
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
Subject: Re: [RFC PATCH v3 06/10] sched: Add over-utilization/tipping point
 indicator
Message-ID: <20180619070103.GB9208@codeaurora.org>
References: <20180521142505.6522-1-quentin.perret@arm.com>
 <20180521142505.6522-7-quentin.perret@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180521142505.6522-7-quentin.perret@arm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2018 at 03:25:01PM +0100, Quentin Perret wrote:

<snip>

>  	util_est_enqueue(&rq->cfs, p);
>  	hrtick_update(rq);
> @@ -8121,11 +8144,12 @@ static bool update_nohz_stats(struct rq *rq, bool force)
>   * @local_group: Does group contain this_cpu.
>   * @sgs: variable to hold the statistics for this group.
>   * @overload: Indicate more than one runnable task for any CPU.
> + * @overutilized: Indicate overutilization for any CPU.
>   */
>  static inline void update_sg_lb_stats(struct lb_env *env,
>  			struct sched_group *group, int load_idx,
>  			int local_group, struct sg_lb_stats *sgs,
> -			bool *overload)
> +			bool *overload, int *overutilized)
>  {
>  	unsigned long load;
>  	int i, nr_running;
> @@ -8152,6 +8176,9 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>  		if (nr_running > 1)
>  			*overload = true;
>  
> +		if (cpu_overutilized(i))
> +			*overutilized = 1;
> +

There is no need to check if every CPU is overutilized or not once
*overutilized is marked as true, right? 

<snip>

>  
> @@ -8586,6 +8621,10 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
>  	 * this level.
>  	 */
>  	update_sd_lb_stats(env, &sds);
> +
> +	if (sched_energy_enabled() && !READ_ONCE(env->dst_rq->rd->overutilized))
> +		goto out_balanced;
> +

Is there any reason for sending no-hz idle kicks but bailing out here when
system is not overutilized?

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.


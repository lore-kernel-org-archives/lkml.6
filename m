Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5100C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 09:18:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 691B32083D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 09:18:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Xm9w2gCJ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Em3FR0wG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 691B32083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965504AbeFSJSz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 05:18:55 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60086 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756212AbeFSJSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 05:18:52 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6B39660B10; Tue, 19 Jun 2018 09:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529399932;
        bh=MwwMtXhYHd5TCSVTk/luwo6w+f8A3OHM9YjsFxhAv9s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xm9w2gCJAGHm4UhjuxKHw/gr2pNY/3s3dFNKnsvq5b0jaCvjQ5bh16PaMEGcfOCtx
         xV9wAEh8vPiCA26XFGoA8cLjL0hx9k2yDyzrKYdG3CmnHSG6O8EJGn6Hs3mj4cWuiG
         wwPD5e+SCvLHOGdb1XCLN1iqUDZDECJIflk7KF6U=
Received: from codeaurora.org (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pkondeti@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 029A060714;
        Tue, 19 Jun 2018 09:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529399931;
        bh=MwwMtXhYHd5TCSVTk/luwo6w+f8A3OHM9YjsFxhAv9s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Em3FR0wGcTRzc8Gkeyt31aIv66RDK2sGyYcpzH/IQK0MJiiJ36FuwyKqbxmrh12i1
         ktS+FXPXeDSvw+6vJzw64kKn0b01AWBzZSdo3qinmF/gpiJVMO8zmY3WVQLXF55ct1
         luU3Q4XcsZ2LkubQxnnAANBxD/62rBXQJ0pGGBRI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 029A060714
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=pkondeti@codeaurora.org
Date:   Tue, 19 Jun 2018 14:48:41 +0530
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
Subject: Re: [RFC PATCH v3 10/10] arch_topology: Start Energy Aware Scheduling
Message-ID: <20180619091841.GD9208@codeaurora.org>
References: <20180521142505.6522-1-quentin.perret@arm.com>
 <20180521142505.6522-11-quentin.perret@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180521142505.6522-11-quentin.perret@arm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2018 at 03:25:05PM +0100, Quentin Perret wrote:

<snip>

> +static void start_eas_workfn(struct work_struct *work);
> +static DECLARE_WORK(start_eas_work, start_eas_workfn);
> +
>  static int
>  init_cpu_capacity_callback(struct notifier_block *nb,
>  			   unsigned long val,
> @@ -204,6 +209,7 @@ init_cpu_capacity_callback(struct notifier_block *nb,
>  		free_raw_capacity();
>  		pr_debug("cpu_capacity: parsing done\n");
>  		schedule_work(&parsing_done_work);
> +		schedule_work(&start_eas_work);
>  	}
>  
>  	return 0;
> @@ -249,6 +255,19 @@ static void parsing_done_workfn(struct work_struct *work)
>  	free_cpumask_var(cpus_to_visit);
>  }
>  
> +static void start_eas_workfn(struct work_struct *work)
> +{
> +	/* Make sure the EM knows about the updated CPU capacities. */
> +	rcu_read_lock();
> +	em_rescale_cpu_capacity();
> +	rcu_read_unlock();
> +
> +	/* Inform the scheduler about the EM availability. */
> +	cpus_read_lock();
> +	rebuild_sched_domains();
> +	cpus_read_unlock();
> +}

Rebuilding the sched domains is unnecessary for the platform that don't have
energy-model. In fact, we can completely avoid scheduling this work.

There seems to be a sysfs interface exposed by this driver to change cpu_scale.
Should we worry about it? I don't know what is the usecase for changing the
cpu_scale from user space.

Are we expecting that the energy-model is populated by this time? If it is
not, should not we build the sched domains again after the energy-model is
populated?

Thanks,
Pavan
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.


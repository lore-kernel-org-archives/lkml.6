Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FAA6C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33B7C20877
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:08:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33B7C20877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754642AbeGIQIA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 12:08:00 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34256 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754525AbeGIQH6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 12:07:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 370DEED1;
        Mon,  9 Jul 2018 09:07:58 -0700 (PDT)
Received: from e108498-lin.cambridge.arm.com (e108498-lin.cambridge.arm.com [10.1.211.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3CE9E3F589;
        Mon,  9 Jul 2018 09:07:54 -0700 (PDT)
Date:   Mon, 9 Jul 2018 17:07:52 +0100
From:   Quentin Perret <quentin.perret@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, gregkh@linuxfoundation.org,
        mingo@redhat.com, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com,
        patrick.bellasi@arm.com, valentin.schneider@arm.com,
        vincent.guittot@linaro.org, thara.gopinath@linaro.org,
        viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org,
        smuckle@google.com, adharmap@quicinc.com, skannan@quicinc.com,
        pkondeti@codeaurora.org, juri.lelli@redhat.com,
        edubezval@gmail.com, srinivas.pandruvada@linux.intel.com,
        currojerez@riseup.net, javi.merino@kernel.org
Subject: Re: [RFC PATCH v4 09/12] sched/fair: Introduce an energy estimation
 helper function
Message-ID: <20180709160752.GB17598@e108498-lin.cambridge.arm.com>
References: <20180628114043.24724-1-quentin.perret@arm.com>
 <20180628114043.24724-10-quentin.perret@arm.com>
 <20180706131243.GV2458@hirez.programming.kicks-ass.net>
 <20180706151212.GD17577@e108498-lin.cambridge.arm.com>
 <20180706154949.GO2494@hirez.programming.kicks-ass.net>
 <20180706170443.GE17577@e108498-lin.cambridge.arm.com>
 <20180709120138.GQ2494@hirez.programming.kicks-ass.net>
 <20180709152825.GA17598@e108498-lin.cambridge.arm.com>
 <20180709154226.GZ2476@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180709154226.GZ2476@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 09 Jul 2018 at 17:42:26 (+0200), Peter Zijlstra wrote:
> On Mon, Jul 09, 2018 at 04:28:26PM +0100, Quentin Perret wrote:
> > What about moving schedutil_freq_util() to sched.h and give it a more
> > generic name (total_cpu_util() ?) with no dependencies on
> > CONFIG_CPU_FREQ_GOV_SCHEDUTIL ? Also, 'energy_util' would have to be
> > renamed I guess (busy_time_util ?).
> 
> Bit big for an inline,

True, but that will be used in the wake-up path ...

> and I don't think there's much point using all
> this without schedutil.

For that total_cpu_util() function I was suggesting, the main point
would be to avoid code duplication with scale_rt_capacity(). Not sure
if that matters ?

Thanks,
Quentin

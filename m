Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D32AC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:02:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67F7D21741
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:02:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733080AbfA1QOb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:14:31 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:48296 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732949AbfA1QO1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:14:27 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9C6F380D;
        Mon, 28 Jan 2019 08:14:26 -0800 (PST)
Received: from queper01-lin (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 375713F59C;
        Mon, 28 Jan 2019 08:14:22 -0800 (PST)
Date:   Mon, 28 Jan 2019 16:14:17 +0000
From:   Quentin Perret <quentin.perret@arm.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>, adharmap@codeaurora.org,
        chris.redpath@arm.com, currojerez@riseup.net,
        dietmar.eggemann@arm.com, edubezval@gmail.com,
        gregkh@linuxfoundation.org, javi.merino@kernel.org,
        joel@joelfernandes.org, juri.lelli@redhat.com,
        patrick.bellasi@arm.com, pkondeti@codeaurora.org,
        rjw@rjwysocki.net, skannan@codeaurora.org, smuckle@google.com,
        srinivas.pandruvada@linux.intel.com, thara.gopinath@linaro.org,
        tkjos@google.com, valentin.schneider@arm.com,
        vincent.guittot@linaro.org, viresh.kumar@linaro.org,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH AUTOSEL 4.20 163/304] sched/topology: Add lowest CPU
 asymmetry sched_domain level pointer
Message-ID: <20190128161415.4r4b2gq54o6qdrxa@queper01-lin>
References: <20190128154341.47195-1-sashal@kernel.org>
 <20190128154341.47195-163-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190128154341.47195-163-sashal@kernel.org>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sasha,

On Monday 28 Jan 2019 at 10:41:20 (-0500), Sasha Levin wrote:
> From: Quentin Perret <quentin.perret@arm.com>
> 
> [ Upstream commit 011b27bb5d3139e8b5fe9ceff1fc7f6dc3145071 ]
> 
> Add another member to the family of per-cpu sched_domain shortcut
> pointers. This one, sd_asym_cpucapacity, points to the lowest level
> at which the SD_ASYM_CPUCAPACITY flag is set. While at it, rename the
> sd_asym shortcut to sd_asym_packing to avoid confusions.
> 
> Generally speaking, the largest opportunity to save energy via
> scheduling comes from a smarter exploitation of heterogeneous platforms
> (i.e. big.LITTLE). Consequently, the sd_asym_cpucapacity shortcut will
> be used at first as the lowest domain where Energy-Aware Scheduling
> (EAS) should be applied. For example, it is possible to apply EAS within
> a socket on a multi-socket system, as long as each socket has an
> asymmetric topology. Energy-aware cross-sockets wake-up balancing will
> only happen when the system is over-utilized, or this_cpu and prev_cpu
> are in different sockets.

Although I'm not really confident about the process for those AUTOSEL
patches, I think this one alone won't help anybody without the other ~10
EAS patches. And I assume you definitely don't want to mark those as
stable, so I'm not sure if this one is a good candidate either.

On a side note, the best description I could find of AUTOSEL with a
5 min Google search is this:  https://lwn.net/Articles/750057/
Do you have any pointers to a doc where I can read up about AUTOSEL ?

Thanks,
Quentin

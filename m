Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id ajLhDfpaGlsfZwAAmS7hNA
	; Fri, 08 Jun 2018 10:31:25 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id E7E39607A4; Fri,  8 Jun 2018 10:31:24 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 58C6A601C3;
	Fri,  8 Jun 2018 10:31:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 58C6A601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752478AbeFHKbV (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 06:31:21 -0400
Received: from foss.arm.com ([217.140.101.70]:60570 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751079AbeFHKbU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 06:31:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A21CE1596;
        Fri,  8 Jun 2018 03:31:19 -0700 (PDT)
Received: from e108498-lin.cambridge.arm.com (e108498-lin.cambridge.arm.com [10.1.211.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AC5BA3F59D;
        Fri,  8 Jun 2018 03:31:15 -0700 (PDT)
Date: Fri, 8 Jun 2018 11:31:14 +0100
From: Quentin Perret <quentin.perret@arm.com>
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>, peterz@infradead.org,
        rjw@rjwysocki.net, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        mingo@redhat.com, morten.rasmussen@arm.com, chris.redpath@arm.com,
        patrick.bellasi@arm.com, valentin.schneider@arm.com,
        vincent.guittot@linaro.org, thara.gopinath@linaro.org,
        viresh.kumar@linaro.org, tkjos@google.com, joelaf@google.com,
        smuckle@google.com, adharmap@quicinc.com, skannan@quicinc.com,
        pkondeti@codeaurora.org, edubezval@gmail.com,
        srinivas.pandruvada@linux.intel.com, currojerez@riseup.net,
        javi.merino@kernel.org
Subject: Re: [RFC PATCH v3 03/10] PM: Introduce an Energy Model management
 framework
Message-ID: <20180608103113.GB418@e108498-lin.cambridge.arm.com>
References: <20180521142505.6522-1-quentin.perret@arm.com>
 <20180521142505.6522-4-quentin.perret@arm.com>
 <20180607144409.GB3311@localhost.localdomain>
 <20180607151954.GA3597@e108498-lin.cambridge.arm.com>
 <52b9575b-4c2a-01df-fadd-10ccf3146112@arm.com>
 <20180608082511.GE3597@e108498-lin.cambridge.arm.com>
 <20180608093613.GD658@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180608093613.GD658@localhost.localdomain>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 08 Jun 2018 at 11:36:13 (+0200), Juri Lelli wrote:
> On 08/06/18 09:25, Quentin Perret wrote:
> > Hi Dietmar,
> > 
> > On Thursday 07 Jun 2018 at 17:55:32 (+0200), Dietmar Eggemann wrote:
> 
> [...]
> 
> > > IMHO, part of the problem why this might be harder to understand is the fact
> > > that the patches show the use of the 2. init call
> > > 'em_rescale_cpu_capacity()' but not the 1. one 'em_register_freq_domain()'.
> > > I guess that Quentin wanted to keep the set as small as possible.
> > 
> > Yes, this is confusing. I'm now starting to think that patch 10/10 should
> > probably not be part of this patch-set, especially if I don't provide
> > the patches registering the freq domains from the CPUFreq drivers. And
> > it's the only "Arm-specific" patch in this arch-independent patch-set.
> > 
> > So I think I'll drop patch 10/10 for v4 ... That part should be
> > discussed separately, with the rest of the Arm-specific changes.
> 
> Mmm, I would actually vote to at least have one example showing how and
> where the em_register_freq_domain() is going to be used. I had to look
> at the repo you referenced since I think it's quite fundamental piece to
> understand the design, IMHO.

Hmmm I see your point. OK, having an example will help. I'll keep patch
10/10 and add an other one tweaking cpufreq-dt to give an example. But
I'll mark the two as OPTIONAL. I really hope we can reach an agreement
on the core design ideas before discussing too much the details on the
driver side.

There are several valid places where em_register_freq_domain() can be
called. But the exact way of doing so will be platform-dependent, and
driver-dependent, so let's agree on what we want to know from the
drivers first :-)

Thanks,
Quentin

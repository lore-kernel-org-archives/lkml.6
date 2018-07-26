Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA2CBC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 17:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8490620671
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 17:01:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8490620671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388584AbeGZSTj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 14:19:39 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59850 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731864AbeGZSTj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 14:19:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 774D37A9;
        Thu, 26 Jul 2018 10:01:57 -0700 (PDT)
Received: from queper01-lin (queper01-lin.emea.arm.com [10.4.13.27])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 814123F575;
        Thu, 26 Jul 2018 10:01:53 -0700 (PDT)
Date:   Thu, 26 Jul 2018 18:01:48 +0100
From:   Quentin Perret <quentin.perret@arm.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     peterz@infradead.org, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        gregkh@linuxfoundation.org, mingo@redhat.com,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        chris.redpath@arm.com, patrick.bellasi@arm.com,
        vincent.guittot@linaro.org, thara.gopinath@linaro.org,
        viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org,
        smuckle@google.com, adharmap@quicinc.com, skannan@quicinc.com,
        pkondeti@codeaurora.org, juri.lelli@redhat.com,
        edubezval@gmail.com, srinivas.pandruvada@linux.intel.com,
        currojerez@riseup.net, javi.merino@kernel.org
Subject: Re: [PATCH v5 06/14] sched/topology: Lowest energy aware balancing
 sched_domain level pointer
Message-ID: <20180726170146.k5mx2px46blrdiqj@queper01-lin>
References: <20180724122521.22109-1-quentin.perret@arm.com>
 <20180724122521.22109-7-quentin.perret@arm.com>
 <76777be2-0f70-ca54-21a8-5af77a47ea86@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76777be2-0f70-ca54-21a8-5af77a47ea86@arm.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 26 Jul 2018 at 17:00:50 (+0100), Valentin Schneider wrote:
> > +DECLARE_PER_CPU(struct sched_domain *, sd_ea);
> 
> There's already the asym-packing shortcut which is making naming a bit more
> tedious, but should that really be named energy-aware? IMO it's just the
> lowest level at which we can see asymmetry, so perhaps it should be named
> as such, i.e. something like sd_asym_capa (and perhaps rename the other one
> as sd_asym_pack)?

So the 'sd_ea' name comes from the usage we do of this shortcut, and also
because this is how the EAS shortcut has always been called, historically.

But TBH, if nobody is against that, I don't mind changing the name at all.
And maybe we should go for the longer names ? 'sd_asym_packing' and
'sd_asym_cpucapacity' aren't that long, I think. And they're
descriptive :-)

Thanks,
Quentin

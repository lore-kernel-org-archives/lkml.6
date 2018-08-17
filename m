Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEE11C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 10:34:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A6E8208E6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 10:34:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A6E8208E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbeHQNhm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 09:37:42 -0400
Received: from foss.arm.com ([217.140.101.70]:45804 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726608AbeHQNhl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 09:37:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D8C97A9;
        Fri, 17 Aug 2018 03:34:46 -0700 (PDT)
Received: from queper01-lin (queper01-lin.emea.arm.com [10.4.13.27])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3F2B43F5BD;
        Fri, 17 Aug 2018 03:34:43 -0700 (PDT)
Date:   Fri, 17 Aug 2018 11:34:38 +0100
From:   Quentin Perret <quentin.perret@arm.com>
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     Juri Lelli <juri.lelli@redhat.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paul Turner <pjt@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v3 01/14] sched/core: uclamp: extend sched_setattr to
 support utilization clamping
Message-ID: <20180817103406.gmve4clcxmhwlmtc@queper01-lin>
References: <20180806163946.28380-1-patrick.bellasi@arm.com>
 <20180806163946.28380-2-patrick.bellasi@arm.com>
 <20180807123550.GA3062@localhost.localdomain>
 <20180809091427.4p2c4fbxocpkjaby@darkstar>
 <20180809095043.GC22465@localhost.localdomain>
 <20180809152313.lewfhufidhxb2qrk@darkstar>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180809152313.lewfhufidhxb2qrk@darkstar>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Patrick,

On Thursday 09 Aug 2018 at 16:23:13 (+0100), Patrick Bellasi wrote:
> On 09-Aug 11:50, Juri Lelli wrote:
> > On 09/08/18 10:14, Patrick Bellasi wrote:
> > > On 07-Aug 14:35, Juri Lelli wrote:
> > > > On 06/08/18 17:39, Patrick Bellasi wrote:
> 
> [...]
> 
> > > 1) make CAP_SYS_NICE protected the clamp groups, with an optional boot
> > >    time parameter to relax this check
> > 
> > It seems to me that this might work well with that the intended usage of
> > the interface that you depict above. SMS only (or any privileged user)
> > will be in control of how groups are configured, so no problem for
> > normal users.
> 
> Yes, well... apart normal users still getting a -ENOSPC is they are
> requesting one of the not pre-configured clamp values. Which is why
> the following bits can be helpful.

So IIUC, normal users would still be free of choosing their clamp values
as long as they choose one in the list of pre-allocated ones ? Is that
correct ?

If yes, that would still let normal users make they tasks look bigger no ?
They could just choose the clamp group with the highest min_clamp or
something. Isn't this a problem too ? I mean, if that can be abused easily,
I'm pretty sure people _will_ abuse it ...

Or maybe I misunderstood something ?

Thanks,
Quentin

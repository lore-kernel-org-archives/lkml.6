Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B58C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 12:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD2B221473
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 12:28:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD2B221473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbeHTPoU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 11:44:20 -0400
Received: from foss.arm.com ([217.140.101.70]:36966 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726535AbeHTPoU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 11:44:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 65361ED1;
        Mon, 20 Aug 2018 05:28:54 -0700 (PDT)
Received: from e110439-lin (e110439-lin.Emea.Arm.com [10.4.12.126])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BBC073F2EA;
        Mon, 20 Aug 2018 05:28:51 -0700 (PDT)
Date:   Mon, 20 Aug 2018 13:28:49 +0100
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paul Turner <pjt@google.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v3 09/14] sched/core: uclamp: propagate parent clamps
Message-ID: <20180820122849.GN2960@e110439-lin>
References: <20180806163946.28380-1-patrick.bellasi@arm.com>
 <20180806163946.28380-10-patrick.bellasi@arm.com>
 <804c7937-2c47-0781-9c53-a8ef8eb04530@arm.com>
 <20180817144540.GL2960@e110439-lin>
 <d6c3b6f4-b3bd-22d9-70c0-38ad587b9339@arm.com>
 <0a26a0de-f9e6-ef77-ceac-eb25bbf01664@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a26a0de-f9e6-ef77-ceac-eb25bbf01664@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-Aug 12:01, Dietmar Eggemann wrote:
> On 08/17/2018 05:50 PM, Dietmar Eggemann wrote:
> >On 08/17/2018 04:45 PM, Patrick Bellasi wrote:
> >>On 17-Aug 15:43, Dietmar Eggemann wrote:
> >>>On 08/06/2018 06:39 PM, Patrick Bellasi wrote:
> 
> [...]
> 
> >>AFAIK the default hierarcy (cgroups v2) has a much more stricy set of
> >>requirements for the "delegation model".
> >
> >Could be ... I guess I have to study this more.
> 
> So I see that this idea with the .effective files is used in Waiman's new
> cpuset cgroupv2 controller proposal.
> 
> The cpu controller with you util clamp extension has to be usable under
> cgroupv2 and cgroupv1, I assume?

Right, and in general what works for v2 should work fine for v1 too.

Best,
Patrick

-- 
#include <best/regards.h>

Patrick Bellasi

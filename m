Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F391C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 16:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66A97206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 16:26:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66A97206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbeIKV0d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 17:26:33 -0400
Received: from foss.arm.com ([217.140.101.70]:46366 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726943AbeIKV0d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 17:26:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DDA5318A;
        Tue, 11 Sep 2018 09:26:29 -0700 (PDT)
Received: from e110439-lin (e110439-lin.Emea.Arm.com [10.4.12.126])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1B1B33F703;
        Tue, 11 Sep 2018 09:26:26 -0700 (PDT)
Date:   Tue, 11 Sep 2018 17:26:24 +0100
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v4 08/16] sched/core: uclamp: propagate parent clamps
Message-ID: <20180911162624.GB1413@e110439-lin>
References: <20180828135324.21976-1-patrick.bellasi@arm.com>
 <20180828135324.21976-9-patrick.bellasi@arm.com>
 <20180911151819.GH1100574@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180911151819.GH1100574@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-Sep 08:18, Tejun Heo wrote:
> Hello, Patrick.

Hi Tejun,

> Can we first concentrate on getting in the non-cgroup part first?

That's the reason why I've reordered (as per your request) the series
to have all the core and non-cgroup related bits at the beginning.

There are a couple of patches at the end of this series which can be
anticipated but, apart from those, the cgroup code is very well
self-contained within patches 7-12.

> The feature has to make sense without cgroup too

Indeed, this is what I worked on since you pointed out in v1 that
there must be a meaningful non-cgroup API and that's what we have
since v2.

> and I think it'd be a lot easier to discuss cgroup details once the
> scheduler core side is settled.

IMHO, developing the cgroup interface on top of the core bits is quite
important to ensure that we have effective data structures and
implementation which can satisfy both worlds.

My question is: IF the scheduler maintainers are going to be happy
with the overall design for the core bits, are you happy to start the
review of the cgroups bits before the core ones are (eventually) merged?

Cheers,
Patrick

-- 
#include <best/regards.h>

Patrick Bellasi

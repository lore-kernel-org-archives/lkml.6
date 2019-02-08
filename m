Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F91EC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CCA92177B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549627911;
	bh=7JHvMZEcypfbn66mq/KIG+0lRtQEclcJi6NwZXXiRYs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=wfwewVpD1YSYrA0WJIKLxaNi+zBGZg+YQEqW6M66dweleD2o3JZeDcq/kUXfZsZ++
	 6MBI58W+vCMGhBcwAUURqWKjA43vlLyvkBpZwqk1sNL9Ktmy4WH41ezOUYS3HDap4n
	 hVjqxQvXm4HiYjKVz39x+wfl9u5IpVGPCujbRjwM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbfBHMLt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 07:11:49 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41027 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbfBHMLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 07:11:49 -0500
Received: by mail-ot1-f65.google.com with SMTP id u16so5418061otk.8;
        Fri, 08 Feb 2019 04:11:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wsA+dybxqi2ItNZsa8eWQdYwSQC3xyJqlm1pxWtB+50=;
        b=gg7Fm+m0DTfcYaOO5U2nEMcwfs8dT1R3EPyyIzuLiR3ozV5UzJIhg4QGcijjlmmP+w
         kezt7H7992uxK/WjlZsRxpVJ4L24nrZvrsaa0HdUTtVQGTWVxXoA8UINlBCmQMP02OUC
         k6nc0RtAqRxOESpbQlESjSvLBxZht1TPub2bZ0KJIQbiRmwK+VqDCd1kiVqAGACkX7ki
         Fv73YKP0wbHvcuD1TqGtB6h7KkXvUm+WOYJtjrS9s4G45hHrH7LoCWn3kKrpiiKDk6uy
         kgedLoJWFe257QYDxjRYfOEv82ja3BEqj6P867EPtoRR0oZDydHujhAbxgwsUM9Tu8N9
         xfWA==
X-Gm-Message-State: AHQUAuao+5vYHH4cq/NtfkOZlbY3j19j4s0WVjGwRqaUf0J/D7audsop
        WtKbe8k8napwJ8yyaTX1a0N/WMcfTiLYRowKIyg=
X-Google-Smtp-Source: AHgI3IY62mavJ1l/fVm73MoNdYYFoh3fLz1Enqt5vM61cq5zhYA9xMlptYpXZfCTECNjRX8CzpWINVxOgdgLHo49ngk=
X-Received: by 2002:a9d:7990:: with SMTP id h16mr5532351otm.222.1549627906624;
 Fri, 08 Feb 2019 04:11:46 -0800 (PST)
MIME-Version: 1.0
References: <CGME20190207122255eucas1p1cdebed838c799eca46cce6a654a26187@eucas1p1.samsung.com>
 <20190207122227.19873-1-m.szyprowski@samsung.com> <20190208110053.GA7913@e107155-lin>
 <87302853-74cc-8eeb-6bd4-6338746e0738@samsung.com> <20190208115122.GA13043@e107155-lin>
 <66b33c07-4970-b60a-d924-d4baba79c836@samsung.com>
In-Reply-To: <66b33c07-4970-b60a-d924-d4baba79c836@samsung.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 8 Feb 2019 13:11:35 +0100
Message-ID: <CAJZ5v0h5BqdKoLoSjMLHjwzCtEgtxkJ=UOQG7VQ3zyTHAsUTbQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] cpufreq/opp: rework regulator initialization
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Samsung SoC <linux-samsung-soc@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Dave Gerlach <d-gerlach@ti.com>,
        Wolfram Sang <wsa@the-dreams.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 8, 2019 at 1:04 PM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>
> Hi Sudeep,
>
> On 2019-02-08 12:51, Sudeep Holla wrote:
> > On Fri, Feb 08, 2019 at 12:47:06PM +0100, Marek Szyprowski wrote:
> >> On 2019-02-08 12:00, Sudeep Holla wrote:
> >>> On Thu, Feb 07, 2019 at 01:22:25PM +0100, Marek Szyprowski wrote:
> >>>> Dear All,
> >>>>
> >>>> This is a scenario that triggers the above issue:
> >>> [...]
> >>>> 1. system disables non-boot cpu's at the end of system suspend procedure,
> >>>> 2. this in turn deinitializes cpufreq drivers for the disabled cpus,
> >>>> 3. early in the system resume procedure all cpus are got back to online
> >>>>    state,
> >>>> 4. this in turn causes cpufreq to be initialized for the newly onlined
> >>>>    cpus,
> >>>> 5. cpufreq-dt acquires all its resources (clocks, regulators) during
> >>>>    ->init() callback,
> >>> This is strictly not just restricted to cpufreq-dt, but to any driver
> >>> supporting multiple policies. So we need a generic fix not just
> >>> cpufreq-dt specific.
> >> Could you point which other driver needs similar fix? Here in cpufreq-dt
> >> the problem was caused by using regulator api (indirectly) from
> >> ->init(). All other drivers, which have regulators support, are for old,
> >> obsolete, uni-processor systems, which don't have the problem of
> >> secondary cpu suspend during system suspend/resume cycle.
> >>
> > scmi_cpufreq for instance. We can fix that in driver my moving to polling
> > to get cpufreq_get_rate, but we support both polling and interrupt based.
> > We may wait for remote processor interrupt in get_rate.
>
> Frankly, I don't feel I know enough to touch this driver and I don't
> think that this can even be fixed in a generic way in the cpufreq core.
> Maybe a comment somewhere is needed that ->init() might be called during
> early system resume with irqs off and driver is responsible for handling
> such case until the proper resume?

Well, adding a comment to that effect certainly won't hurt as that's
how things work now.

However, it looks like something needs to be done in addition to that.

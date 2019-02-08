Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF7CEC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 11:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7E4B2075D
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 11:01:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbfBHLBG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 06:01:06 -0500
Received: from foss.arm.com ([217.140.101.70]:48482 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726465AbfBHLBF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 06:01:05 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1E8A4A78;
        Fri,  8 Feb 2019 03:01:05 -0800 (PST)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2E7063F557;
        Fri,  8 Feb 2019 03:01:03 -0800 (PST)
Date:   Fri, 8 Feb 2019 11:00:53 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Dave Gerlach <d-gerlach@ti.com>,
        Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 0/2] cpufreq/opp: rework regulator initialization
Message-ID: <20190208110053.GA7913@e107155-lin>
References: <CGME20190207122255eucas1p1cdebed838c799eca46cce6a654a26187@eucas1p1.samsung.com>
 <20190207122227.19873-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190207122227.19873-1-m.szyprowski@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2019 at 01:22:25PM +0100, Marek Szyprowski wrote:
> Dear All,
>
> This is a scenario that triggers the above issue:
>

[...]

> 1. system disables non-boot cpu's at the end of system suspend procedure,
> 2. this in turn deinitializes cpufreq drivers for the disabled cpus,
> 3. early in the system resume procedure all cpus are got back to online
>    state,
> 4. this in turn causes cpufreq to be initialized for the newly onlined
>    cpus,
> 5. cpufreq-dt acquires all its resources (clocks, regulators) during
>    ->init() callback,

This is strictly not just restricted to cpufreq-dt, but to any driver
supporting multiple policies. So we need a generic fix not just
cpufreq-dt specific.

--
Regards,
Sudeep

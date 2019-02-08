Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 663D5C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 14:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38CCC20869
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 14:28:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbfBHO2W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 09:28:22 -0500
Received: from foss.arm.com ([217.140.101.70]:52202 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726887AbfBHO2W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 09:28:22 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9F981A78;
        Fri,  8 Feb 2019 06:28:21 -0800 (PST)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8A6193F557;
        Fri,  8 Feb 2019 06:28:19 -0800 (PST)
Date:   Fri, 8 Feb 2019 14:28:12 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Samsung SoC <linux-samsung-soc@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Dave Gerlach <d-gerlach@ti.com>,
        Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 0/2] cpufreq/opp: rework regulator initialization
Message-ID: <20190208142812.GA22401@e107155-lin>
References: <CGME20190207122255eucas1p1cdebed838c799eca46cce6a654a26187@eucas1p1.samsung.com>
 <20190207122227.19873-1-m.szyprowski@samsung.com>
 <20190208064957.zhyue42kpgaoslwm@vireshk-i7>
 <CAJZ5v0iU1+YdAqHai+r_ubC1FarC2JWBuc98MG58n+y9=1WB=A@mail.gmail.com>
 <20190208103133.ysvaroyniuc3k4i5@vireshk-i7>
 <CAJZ5v0ghQ6bTV8atd6dtq8=ZBDUpDRVsCiAhwQVtfoMH-JhH9A@mail.gmail.com>
 <20190208113904.GB7913@e107155-lin>
 <CAJZ5v0gbh2LDq+6P_CQ+GWOxEdQrRUqQnx7v59hvs2_wwx9=kw@mail.gmail.com>
 <20190208120949.GB13043@e107155-lin>
 <CAJZ5v0jkpMyXrg9HwFizXLBEu0tggBmMbhZZZxzt_+a10cmuYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jkpMyXrg9HwFizXLBEu0tggBmMbhZZZxzt_+a10cmuYA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2019 at 01:23:37PM +0100, Rafael J. Wysocki wrote:
> On Fri, Feb 8, 2019 at 1:09 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
> >

[...]

> > Yes, in that case additional logic in the driver also needed. I am fine
> > if we enforce driver to deal with this issue, but was thinking if we can
> > make it generic. Also I was just trying to avoid adding _suspend/resume
> > to driver just to avoid this issue.
>
> I was wondering if cpufreq_offline()/online() could be invoked from
> cpufreq_suspend()/resume() for the nonboot CPUs - if the driver needs
> it (there could be a driver flag to indicate that).
>
> If they are made exit immediately when cpufreq_suspended is set (and
> the requisite driver flag is set too), that might work AFAICS.

Yes that sounds feasible. It should be fine to assume it's safe to call
cpufreq_online on a CPU even for CPU that might have failed to come
online or didn't reached a state in CPUHP from where CPUFreq callback
is executed or am I missing something ?

--
Regards,
Sudeep

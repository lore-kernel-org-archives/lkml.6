Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15CF0C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE9EA20857
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:15:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbfA2JPy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 04:15:54 -0500
Received: from foss.arm.com ([217.140.101.70]:60628 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725298AbfA2JPx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 04:15:53 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3D4A780D;
        Tue, 29 Jan 2019 01:15:53 -0800 (PST)
Received: from queper01-lin (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B1D093F7A6;
        Tue, 29 Jan 2019 01:15:50 -0800 (PST)
Date:   Tue, 29 Jan 2019 09:15:49 +0000
From:   Quentin Perret <quentin.perret@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Matthias Kaehlcke <mka@chromium.org>, rjw@rjwysocki.net,
        sudeep.holla@arm.com, liviu.dudau@arm.com,
        lorenzo.pieralisi@arm.com, robh+dt@kernel.org,
        mark.rutland@arm.com, nm@ti.com, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        dietmar.eggemann@arm.com
Subject: Re: [PATCH 2/7] cpufreq: dt: Register an Energy Model
Message-ID: <20190129091546.tfh3lo4w4sosfuba@queper01-lin>
References: <20190128165522.31749-1-quentin.perret@arm.com>
 <20190128165522.31749-3-quentin.perret@arm.com>
 <20190128193656.GI81583@google.com>
 <20190129052144.plicqu4vozh3l3ss@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190129052144.plicqu4vozh3l3ss@vireshk-i7>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 29 Jan 2019 at 10:51:44 (+0530), Viresh Kumar wrote:
> On 28-01-19, 11:36, Matthias Kaehlcke wrote:
> > I think this patch will result in error messages at registration on
> > platforms that use the cpufreq-dt driver and don't specify
> > 'dynamic-power-coefficient' for the CPUs in the DT. Not sure if that's
> > a problem as long as the cpufreq initialization succeeds regardless,
> > it could be seen as a not-so-gentle nudge to add the values.
> 
> That wouldn't be acceptable.

Fair enough. What I can propose in this case is to have in PM_OPP a
helper called 'dev_pm_opp_of_register_em()' or something like this. This
function will check all prerequisites are present (we have the right
values in DT, and so on) and then call (or not) em_register_perf_domain().
Then we can make the CPUFreq drivers use that instead of calling
em_register_perf_domain() directly.

That would also make it easy to implement Matthias' suggestion to not
call em_register_perf_domain() if an EM is already present.

Would that work ?

Thanks,
Quentin

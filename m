Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2499BC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 09:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7C59214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 09:08:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbfAJJI5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 04:08:57 -0500
Received: from foss.arm.com ([217.140.101.70]:58266 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727455AbfAJJI5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 04:08:57 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D79780D;
        Thu, 10 Jan 2019 01:08:56 -0800 (PST)
Received: from queper01-lin (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 811983F694;
        Thu, 10 Jan 2019 01:08:52 -0800 (PST)
Date:   Thu, 10 Jan 2019 09:08:47 +0000
From:   Quentin Perret <quentin.perret@arm.com>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     peterz@infradead.org, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        gregkh@linuxfoundation.org, mingo@redhat.com,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        chris.redpath@arm.com, patrick.bellasi@arm.com,
        valentin.schneider@arm.com, vincent.guittot@linaro.org,
        thara.gopinath@linaro.org, viresh.kumar@linaro.org,
        tkjos@google.com, joel@joelfernandes.org, smuckle@google.com,
        adharmap@codeaurora.org, skannan@codeaurora.org,
        pkondeti@codeaurora.org, juri.lelli@redhat.com,
        edubezval@gmail.com, srinivas.pandruvada@linux.intel.com,
        currojerez@riseup.net, javi.merino@kernel.org
Subject: Re: [PATCH v10 15/15] OPTIONAL: cpufreq: dt: Register an Energy Model
Message-ID: <20190110090845.6eeu326iudgmpdet@queper01-lin>
References: <20181203095628.11858-1-quentin.perret@arm.com>
 <20181203095628.11858-16-quentin.perret@arm.com>
 <20190108203813.GS261387@google.com>
 <20190109105757.2rowxn3anzyycuod@queper01-lin>
 <20190109181451.GT261387@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190109181451.GT261387@google.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 09 Jan 2019 at 10:14:51 (-0800), Matthias Kaehlcke wrote:
> I think registering the perf domain only once is fine, since the info
> isn't supposed to change and will likely be used again after
> _exit(). However since we have em_cpu_get() I'd suggest to use it and
> only call em_register_perf_domain() if no perf domain is registered
> yet for the CPU. This makes it more evident that the registration is
> only done once and simplifies error handling (currently not done at
> all), since it's not necessary to check for the special case -EEXIST.

Right, a check on em_cpu_get() on the driver side shouldn't hurt. We
don't actually have upstream drivers using that API yet but I intend to
change that soon. I guess we'll need to have that discussion with each
individual CPUFreq driver maintainer but that hopefully shouldn't be a
problem.

Thanks for the feedback,
Quentin

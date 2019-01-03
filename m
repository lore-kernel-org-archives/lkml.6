Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2120C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 12:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6034C217F5
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 12:06:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730711AbfACMGS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 07:06:18 -0500
Received: from foss.arm.com ([217.140.101.70]:48050 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729118AbfACMGS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 07:06:18 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AFDB9A78;
        Thu,  3 Jan 2019 04:06:17 -0800 (PST)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B65493F5D4;
        Thu,  3 Jan 2019 04:06:14 -0800 (PST)
Date:   Thu, 3 Jan 2019 12:06:12 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org,
        "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 00/27] PM / Domains: Support hierarchical CPU
 arrangement (PSCI/ARM)
Message-ID: <20190103120612.GC23511@e107155-lin>
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181129174700.16585-1-ulf.hansson@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 06:46:33PM +0100, Ulf Hansson wrote:
> Over the years this series have been iterated and discussed at various Linux
> conferences and LKML. In this new v10, a quite significant amount of changes
> have been made to address comments from v8 and v9. A summary is available
> below, although let's start with a brand new clarification of the motivation
> behind this series.

I would like to raise few points, not blockers as such but need to be
discussed and resolved before proceeding further.
1. CPU Idle Retention states
	- How will be deal with flattening (which brings back the DT bindings,
	  i.e. do we have all we need) ? Because today there are no users of
	  this binding yet. I know we all agreed and added after LPC2017 but
	  I am not convinced about flattening with only valid states.
	- Will domain governor ensure not to enter deeper idles states based
	  on its sub-domain states. E.g.: when CPUs are in retention, so
	  called container/cluster domain can enter retention or below and not
	  power off states.
	- Is the case of not calling cpu_pm_{enter,exit} handled now ?

2. Now that we have SDM845 which may soon have platform co-ordinated idle
   support in mainline, I *really* would like to see some power comparison
   numbers(i.e. PC without cluster idle states). This has been the main theme
   for most of the discussion on this topic for years and now we are close
   to have some platform, we need to try.

3. Also, after adding such complexity, we really need a platform with an
   option to build and upgrade firmware easily. This will help to prevent
   this being not maintained for long without a platform to test, also
   avoid adding lots of quirks to deal with broken firmware so that newer
   platforms deal those issues in the firmware correctly.

--
Regards,
Sudeep

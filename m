Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C4A8C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 12:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34073214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 12:04:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbfA1MEl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 07:04:41 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:59053 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbfA1MEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 07:04:40 -0500
Received: from 79.184.255.169.ipv4.supernova.orange.pl (79.184.255.169) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id cd1a21482ae1fd7b; Mon, 28 Jan 2019 13:04:38 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Amit Kucheria <amit.kucheria@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        viresh.kumar@linaro.org, edubezval@gmail.com, swboyd@chromium.org,
        dianders@chromium.org, mka@chromium.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Tao Wang <kevin.wangtao@hisilicon.com>,
        Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 2/9] cpufreq: Auto-register the driver as a thermal cooling device if asked
Date:   Mon, 28 Jan 2019 13:03:20 +0100
Message-ID: <12294707.IXbBkGfcfl@aspire.rjw.lan>
In-Reply-To: <3afd5b04-5caf-053d-48c9-f719eec58da0@linaro.org>
References: <cover.1548654899.git.amit.kucheria@linaro.org> <f6f09e5af6fe78fc27cbdc53a8dc688c6b4124b7.1548654899.git.amit.kucheria@linaro.org> <3afd5b04-5caf-053d-48c9-f719eec58da0@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, January 28, 2019 9:32:44 AM CET Daniel Lezcano wrote:
> On 28/01/2019 07:41, Amit Kucheria wrote:
> > All cpufreq drivers do similar things to register as a cooling device.
> > Provide a cpufreq driver flag so drivers can just ask the cpufreq core
> > to register the cooling device on their behalf. This allows us to get
> > rid of duplicated code in the drivers.
> > 
> > In order to allow this, we add a struct thermal_cooling_device pointer
> > to struct cpufreq_policy so that drivers don't need to store it in a
> > private data structure.
> > 
> > Suggested-by: Stephen Boyd <swboyd@chromium.org>
> > Suggested-by: Viresh Kumar <viresh.kumar@linaro.org>
> > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> > Tested-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> 
> [ ... ]
> 
> > +/*
> > + * Set by drivers that want the core to automatically register the cpufreq
> > + * driver as a thermal cooling device.
> > + */
> > +#define CPUFREQ_AUTO_REGISTER_COOLING_DEV	BIT(7)
> > +
> 
> Isn't the CPUFREQ_IS_COOLING_DEV more appropriate? We define a property
> of the cpufreq driver and the resulting action is to auto-register, no?

Yes.

Cheers,
Rafael


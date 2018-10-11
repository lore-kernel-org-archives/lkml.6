Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB5FCC32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 16:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8016120659
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 16:01:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8016120659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729443AbeJKX3S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:29:18 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40262 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726036AbeJKX3R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:29:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C759CED1;
        Thu, 11 Oct 2018 09:01:27 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 07E153F5D3;
        Thu, 11 Oct 2018 09:01:24 -0700 (PDT)
Date:   Thu, 11 Oct 2018 17:01:22 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>
Subject: Re: [PATCH v9 05/11] of: base: Add of_get_cpu_state_node() to get
 idle states for a CPU node
Message-ID: <20181011160122.GB28583@e107155-lin>
References: <20181003143824.13059-1-ulf.hansson@linaro.org>
 <20181003143824.13059-6-ulf.hansson@linaro.org>
 <20181010150331.GB4844@e107155-lin>
 <CAPDyKFq7bNJM5Y4y78tnOEvg7ntmYFtJoDvFH8uR2yUUK9o4HA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFq7bNJM5Y4y78tnOEvg7ntmYFtJoDvFH8uR2yUUK9o4HA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 05:05:07PM +0200, Ulf Hansson wrote:
> On 10 October 2018 at 17:03, Sudeep Holla <sudeep.holla@arm.com> wrote:
[...]
> >
> > No strong opinion but I am wondering if it makes sense to get cpu
> > logical index and fetch the cpu of_node here to contain the refcount on
> > it within this function while we are trying to consolidate. I do see
> > that may not be so useful in psci.c but keeping refcount for cpu of_node
> > here keeps the user free from that.
> 
> I see your point.
> 
> However, I am hesitating doing that change, as it would be a waste for
> the psci case, but I also think that it may becomes a bit less
> straight forward to use this helper function.
> 
> Although, no strong opinions from my side either, but since Rob is
> happy with this, there is no need to change it, I think.
>

Sure, no problem.

--
Regards,
Sudeep

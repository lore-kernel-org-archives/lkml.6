Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB79C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 10:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B924120868
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 10:13:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B924120868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728401AbeJLRpU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 13:45:20 -0400
Received: from foss.arm.com ([217.140.101.70]:49108 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726917AbeJLRpT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 13:45:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 86752F;
        Fri, 12 Oct 2018 03:13:39 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 707943F5B7;
        Fri, 12 Oct 2018 03:13:36 -0700 (PDT)
Date:   Fri, 12 Oct 2018 11:13:30 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
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
        Lina Iyer <lina.iyer@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v9 04/11] dt: psci: Update DT bindings to support
 hierarchical PSCI states
Message-ID: <20181012101330.GA31003@e107155-lin>
References: <20181003143824.13059-1-ulf.hansson@linaro.org>
 <20181003143824.13059-5-ulf.hansson@linaro.org>
 <20181010150312.GA4844@e107155-lin>
 <CAPDyKFqP3wbd+5rvLcscNf1LUSZDROLqafsLq0Kyh0KziRJrZQ@mail.gmail.com>
 <20181011164126.GD28583@e107155-lin>
 <CAPDyKFq3=E=qDkozsu-MupEL_Efpdq62Z3aMWwGQWc+OdzPq8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFq3=E=qDkozsu-MupEL_Efpdq62Z3aMWwGQWc+OdzPq8w@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 11:43:11AM +0200, Ulf Hansson wrote:
> On 11 October 2018 at 18:41, Sudeep Holla <sudeep.holla@arm.com> wrote:
[...]

> > Yes, nearly there. Just thought good to add a note that the representation
> > has no affinity towards any PSCI idle state mechanism(PC or OSI). So
> > that it's never assumed or misunderstood.
>
> I understand your point. However, I think the following sentence still
> makes sense (exist in the suggest change above).
>
> "In PSCI firmware v1.0, the OS-Initiated mode is introduced. In order
> to use it, the hierarchical representation must be used."
>
> How about if I add: "For the default platform-coordinated mode, both
> representations are viable options."
>
I would also add couple of things, how about this order:

In PSCI firmware v1.0, the OS-Initiated mode is introduced. However the
flattened vs hierarchical DT representation of power domains is orthogonal
to OS-Initiated vs platform-coordinated PSCI CPU suspend modes and
should be considered independent of each other.

The hierarchical representation helps and makes it easy to implement
OSI mode and OS implementations may choose to mandate it.

For the default platform-coordinated mode, both representations are
viable options.

--
Regards,
Sudeep

Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C1E4C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 10:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D1A520645
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 10:46:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D1A520645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbeJERo5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 13:44:57 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49780 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727691AbeJERo5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 13:44:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 96B0F7A9;
        Fri,  5 Oct 2018 03:46:43 -0700 (PDT)
Received: from red-moon (red-moon.emea.arm.com [10.4.13.120])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CF5903F5A0;
        Fri,  5 Oct 2018 03:46:40 -0700 (PDT)
Date:   Fri, 5 Oct 2018 11:47:29 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
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
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 00/11] PM / Domains: Support hierarchical CPU
 arrangement (PSCI/ARM) (a subset)
Message-ID: <20181005104729.GB25651@red-moon>
References: <20181003143824.13059-1-ulf.hansson@linaro.org>
 <CAJZ5v0h7jvoa4oUeM4FgFizF_jbAonoAgP3m417n_TGqfqNsqg@mail.gmail.com>
 <CAPDyKFq0GLs2AMA+6b-Khf+4kGxzVCTvtehp-YmwV2h=_SP4=g@mail.gmail.com>
 <10136406.EY9A7BdqYq@aspire.rjw.lan>
 <CAJZ5v0iv9OYoaLYHsmdp2xbDuENPgue_mBgFujdmesnBOegRKQ@mail.gmail.com>
 <20181004155755.GD5233@e107981-ln.cambridge.arm.com>
 <CAJZ5v0j+W2CHiqkniXNJgZ3DU9pOpd_83Wj9Egwf+pVkRCjZLg@mail.gmail.com>
 <20181004172109.GA16878@red-moon>
 <CAPDyKFrWzDU9BsfAnx7uoaXq=gmGg2r46Mn-cJHSWUk-TmyomA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFrWzDU9BsfAnx7uoaXq=gmGg2r46Mn-cJHSWUk-TmyomA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 04, 2018 at 08:36:24PM +0200, Ulf Hansson wrote:
> On 4 October 2018 at 19:21, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:
> > On Thu, Oct 04, 2018 at 07:07:27PM +0200, Rafael J. Wysocki wrote:
> >
> > [...]
> >
> >> > > I don't see any dependency there, so I'll queue up the 1-3 in
> >> > > pm-domains and the 4-6 in pm-cpuidle.
> >> >
> >> > I do not see why we should merge patches 4-6 for v4.20; they add legacy
> >> > (DT bindings and related parsing code) with no user in the kernel; we
> >> > may still want to tweak them, in particular PSCI DT bindings.
> >>
> >> My impression was that 4-6 have been agreed on due to the ACKs they
> >> carry.  I'll drop them if that's not the case.
> >
> > I have not expressed myself correctly: they have been agreed (even
> > though as I said they may require some tweaking) but I see no urgency
> > of merging them in v4.20 since they have no user. They contain DT
> > bindings, that create ABI/legacy, I think it is better to have code
> > that uses them in the kernel before merging them and creating a
> > dependency that is not needed.
> 
> There is already code using the new bindings, for the idle states.
> Please have look at patch 5, 6 and 11.

I had a look before replying and I reiterate the point, there is
no reason to merge those patches without the rest of the series,
none. There is already a way to describe idle states in the kernel
and it works very well, we will add one when we need it not before.

> Moreover, you have had plenty on time to look at the series, as those
> patches haven't changed since a very long time.

So ?

> May I suggest you do the review instead, so we can move things
> forward, please. The changes in the v9 series should be trivial to
> review.

There is no reason to merge patches [4, 5, 6, 10] stand-alone, they
are not solving any problem and they do not provide any benefit
other than adding useless ABI/legacy, they make sense when we look
at the whole series.

> >> > Likewise, it makes no sense to merge patches 7-8 without the rest of
> >> > the PSCI patches.
> 
> Well, those patches are part of this series, because Mark wanted me to
> move the files. Is really such a big deal? I think it makes sense, no
> matter what happens afterwards.

We can merge patches [7-8] even if there is no urgency at all to do so,
usually PSCI patches go via arm-soc whose patches queue is now closed
and I do not think that's a problem at all.

Lorenzo

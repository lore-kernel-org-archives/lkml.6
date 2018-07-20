Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21007ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 13:54:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 329CA206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 13:54:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 329CA206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731919AbeGTOmj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 10:42:39 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:36686 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727693AbeGTOmj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 10:42:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 50D4F80D;
        Fri, 20 Jul 2018 06:54:14 -0700 (PDT)
Received: from e105550-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CB9BE3F73C;
        Fri, 20 Jul 2018 06:54:12 -0700 (PDT)
Date:   Fri, 20 Jul 2018 14:54:10 +0100
From:   Morten Rasmussen <morten.rasmussen@arm.com>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     peterz@infradead.org, mingo@redhat.com, valentin.schneider@arm.com,
        dietmar.eggemann@arm.com, vincent.guittot@linaro.org,
        gaku.inami.xh@renesas.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv4 11/12] sched/core: Disable SD_ASYM_CPUCAPACITY for
 root_domains without asymmetry
Message-ID: <20180720135410.GD19287@e105550-lin.cambridge.arm.com>
References: <1530699470-29808-1-git-send-email-morten.rasmussen@arm.com>
 <1530699470-29808-12-git-send-email-morten.rasmussen@arm.com>
 <20180705133142.GD32579@e108498-lin.cambridge.arm.com>
 <20180705141349.GD8596@e105550-lin.cambridge.arm.com>
 <20180705150311.GE32579@e108498-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180705150311.GE32579@e108498-lin.cambridge.arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 05, 2018 at 04:03:11PM +0100, Quentin Perret wrote:
> On Thursday 05 Jul 2018 at 15:13:49 (+0100), Morten Rasmussen wrote:
> > 3. Detecting the flag in generic kernel/sched/* code means that all
> > architectures will pay the for the overhead when building/rebuilding the
> > sched_domain hierarchy, and all architectures that sets the cpu
> > capacities to asymmetric will set the flag whether they like it or not.
> > I'm not sure if this is a problem.
> 
> That is true as well ...
> 
> > 
> > In the end it is really about how much of this we want in generic code
> > and how much we hide in arch/, and if we dare to touch the sched_domain
> > build code ;-)
> 
> Right so you can argue that the arch code is here to give you a
> system-level information, and that if the scheduler wants to virtually
> split that system, then it's its job to make sure that happens properly.
> That is exactly what your patch does (IIUC), and I now think that this
> is a very sensible middle-ground option. But this is debatable so I'm
> interested to see what others think :-)

I went ahead an hacked up some patches that sets the flag automatically
as part of the sched_domain build process. I posted them so people can
have a look: 1532093554-30504-1-git-send-email-morten.rasmussen@arm.com

With those patches this patch has to be reverted/dropped.

Morten

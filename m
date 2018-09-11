Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 827ADC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 11:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DD952088F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 11:04:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DD952088F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbeIKQDH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 12:03:07 -0400
Received: from foss.arm.com ([217.140.101.70]:42228 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726569AbeIKQDG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 12:03:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7DB7A7A9;
        Tue, 11 Sep 2018 04:04:17 -0700 (PDT)
Received: from e105550-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 043043F557;
        Tue, 11 Sep 2018 04:04:15 -0700 (PDT)
Date:   Tue, 11 Sep 2018 12:04:09 +0100
From:   Morten Rasmussen <morten.rasmussen@arm.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     peterz@infradead.org, mingo@redhat.com, valentin.schneider@arm.com,
        dietmar.eggemann@arm.com, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/4] sched/topology: SD_ASYM_CPUCAPACITY flag detection
Message-ID: <20180911110409.GA16613@e105550-lin.cambridge.arm.com>
References: <1532093554-30504-1-git-send-email-morten.rasmussen@arm.com>
 <1532093554-30504-2-git-send-email-morten.rasmussen@arm.com>
 <20180910082111.GA48257@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180910082111.GA48257@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 10:21:11AM +0200, Ingo Molnar wrote:
> 
> * Morten Rasmussen <morten.rasmussen@arm.com> wrote:
> 
> > The SD_ASYM_CPUCAPACITY sched_domain flag is supposed to mark the
> > sched_domain in the hierarchy where all cpu capacities are visible for
> > any cpu's point of view on asymmetric cpu capacity systems. The
> 
> >  /*
> > + * Find the sched_domain_topology_level where all cpu capacities are visible
> > + * for all cpus.
> > + */
> 
> > +	/*
> > +	 * Examine topology from all cpu's point of views to detect the lowest
> > +	 * sched_domain_topology_level where a highest capacity cpu is visible
> > +	 * to everyone.
> > +	 */
> 
> >  #define SD_WAKE_AFFINE               0x0020  /* Wake task to waking CPU */
> > -#define SD_ASYM_CPUCAPACITY  0x0040  /* Groups have different max cpu capacities */
> > +#define SD_ASYM_CPUCAPACITY  0x0040  /* Domain members have different cpu capacities */
> 
> For future reference: *please* capitalize 'CPU' and 'CPUs' in future patches like the rest of 
> the scheduler does.
> 
> You can see it spelled right above the new definition: 'waking CPU' ;-)
> 
> (I fixed this up in this patch.)

Noted. Thanks for fixing up the patch.

Morten

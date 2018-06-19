Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06147C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 06:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0E8720693
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 06:01:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0E8720693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937360AbeFSGBy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 02:01:54 -0400
Received: from foss.arm.com ([217.140.101.70]:42812 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937085AbeFSGBx (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 02:01:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D933E1529;
        Mon, 18 Jun 2018 23:01:52 -0700 (PDT)
Received: from salmiak (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D04063F25D;
        Mon, 18 Jun 2018 23:01:49 -0700 (PDT)
Date:   Tue, 19 Jun 2018 07:01:42 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     "Jin, Yao" <yao.jin@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, acme@kernel.org,
        jolsa@kernel.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, me@kylehuey.com,
        Linux-kernel@vger.kernel.org, vincent.weaver@maine.edu,
        will.deacon@arm.com, eranian@google.com, namhyung@kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v1 1/2] perf/core: Use sysctl to turn on/off dropping
 leaked kernel samples
Message-ID: <20180619060142.62nppodwkauhnm5j@salmiak>
References: <1529057003-2212-1-git-send-email-yao.jin@linux.intel.com>
 <1529057003-2212-2-git-send-email-yao.jin@linux.intel.com>
 <20180615113608.6m74sm7gpl5p6oqe@lakrids.cambridge.arm.com>
 <52c75f12-1f91-405d-0b05-0aa6a9c09306@linux.intel.com>
 <20180618104522.GI2458@hirez.programming.kicks-ass.net>
 <f66f6738-c612-1535-3661-dcc654750fa8@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f66f6738-c612-1535-3661-dcc654750fa8@linux.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 09:39:02AM +0800, Jin, Yao wrote:
> 
> 
> On 6/18/2018 6:45 PM, Peter Zijlstra wrote:
> > On Mon, Jun 18, 2018 at 02:55:32PM +0800, Jin, Yao wrote:
> > > Thanks for providing the patch. I understand this approach.
> > > 
> > > In my opinion, the skid window is from counter overflow to interrupt
> > > delivered. While if the skid window is too *big* (e.g. user -> kernel), it
> > > should be not very useful. So personally, I'd prefer to drop the samples.
> > 
> > I really don't get your insitence on dropping the sample. Dropping
> > samples is bad. Furthermore, doing what Mark suggests actually improves
> > the result by reducing the skid, if the event happened before we entered
> > (as it damn well should) then the user regs, which point at the entry
> > site, are a better approximation than our in-kernel set.
> > 
> > So not only do you not loose the sample, you actually get a better
> > sample.
> > 
> 
> OK, that's fine, thanks!
> 
> I guess Mark will post this patch, right?

I'll try to spin something shortly -- I'm just figuring out how this should
work with guest sampling.

Thanks,
Mark.

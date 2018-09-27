Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49EF2C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 20:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D39C216FE
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 20:39:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D39C216FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbeI1C7m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 22:59:42 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:52990 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727295AbeI1C7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 22:59:42 -0400
Received: from p5492e4c1.dip0.t-ipconnect.de ([84.146.228.193] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g5d3t-0002sl-W5; Thu, 27 Sep 2018 22:39:02 +0200
Date:   Thu, 27 Sep 2018 22:39:01 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Reinette Chatre <reinette.chatre@intel.com>
cc:     Peter Zijlstra <peterz@infradead.org>, fenghua.yu@intel.com,
        tony.luck@intel.com, mingo@redhat.com, acme@kernel.org,
        gavin.hindman@intel.com, jithu.joseph@intel.com,
        dave.hansen@intel.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V5 0/6] perf and x86/intel_rdt: Fix lack of coordination
 with perf
In-Reply-To: <77383a1e-f343-7529-24cf-874f0999507d@intel.com>
Message-ID: <alpine.DEB.2.21.1809272123440.8118@nanos.tec.linutronix.de>
References: <cover.1537377064.git.reinette.chatre@intel.com> <20180920141150.GY24124@hirez.programming.kicks-ass.net> <77383a1e-f343-7529-24cf-874f0999507d@intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Sep 2018, Reinette Chatre wrote:

> Dear Maintainers,

Sorry for replying late.

> On 9/20/2018 7:11 AM, Peter Zijlstra wrote:
> > On Wed, Sep 19, 2018 at 10:29:05AM -0700, Reinette Chatre wrote:
> >> Reinette Chatre (6):
> >>   perf/core: Add sanity check to deal with pinned event failure
> >>   perf/x86: Add helper to obtain performance counter index
> >>   x86/intel_rdt: Remove local register variables
> >>   x86/intel_rdt: Create required perf event attributes
> >>   x86/intel_rdt: Use perf infrastructure for measurements
> >>   x86/intel_rdt: Re-enable pseudo-lock measurements
> >>
> >>  Documentation/x86/intel_rdt_ui.txt          |  22 +-
> >>  arch/x86/events/core.c                      |  21 ++
> >>  arch/x86/include/asm/perf_event.h           |   1 +
> >>  arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c | 372 ++++++++++++--------
> >>  kernel/events/core.c                        |   6 +
> >>  5 files changed, 261 insertions(+), 161 deletions(-)
> > 
> > Yeah, these look good, thanks!
> > 
> > Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > 
> 
> Could you please consider this series for inclusion into v4.19?

So in principle I'm having no objections as this really is mostly a RDT
only issue.

Peter, any objections against the Perf part of it, aside the core patch
which is an obvious fix?

Thanks,

	tglx

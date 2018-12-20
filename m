Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D9CC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 01:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4EA920672
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 01:46:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729489AbeLTBqI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 20:46:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:38098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726604AbeLTBqI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 20:46:08 -0500
Received: from home.goodmis.org (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2647520672;
        Thu, 20 Dec 2018 01:46:07 +0000 (UTC)
Date:   Wed, 19 Dec 2018 20:46:05 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joe Perches <joe@perches.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: Re: [RFC][PATCH] string.h: Add strncmp_prefix() helper macro
Message-ID: <20181220014605.focjb2tuysvjbh6k@home.goodmis.org>
References: <20181219163207.792e0f97@gandalf.local.home>
 <a5a26ed80402a0abdc83dffc2e7fb28b0b96450f.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5a26ed80402a0abdc83dffc2e7fb28b0b96450f.camel@perches.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Another email not as my daughter. ]

On Wed, Dec 19, 2018 at 02:05:32PM -0800, Joe Perches wrote:
> On Wed, 2018-12-19 at 16:32 -0500, Bryana Rostedt wrote:
> > a quick grep in the kernel tree found several
> > (thousands!) of cases that use this construct. A quick grep also
> > revealed that there's probably several bugs in that use case. Some are
> > that people forgot the "- 1" (which I found) and others could be that
> > the constant for the sizeof is different than the constant (although, I
> > haven't found any of those, but I also didn't look hard).
> 
> Several dozen cases exist like strncmp(foo, "bar", 4)
> where it might as well use strcmp instead.
> 
> And a few mismatches exist like:
> 
> drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c:2285:		if (!strncmp(opt, "eee_timer:", 6)) {
> tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c:318:	if (!strncmp(s, "power", 9))
> tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c:321:	if (!strncmp(s, "balance-power", 17))
> j

Yeah I saw these too. But that's just more justification to get a helper
function applied.

I'll look at the options, and then just add it to my queue for the next merge
window. I'll have to add the commit that is added as a requirement of other
patches that will sure need to go to stable.

-- Steve


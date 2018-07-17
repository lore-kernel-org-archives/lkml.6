Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D29ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D72320C0E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:06:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D72320C0E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729652AbeGQJhe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 05:37:34 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:55746 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728340AbeGQJhe (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Tue, 17 Jul 2018 05:37:34 -0400
Received: from emea4-mta.ukb.novell.com ([10.120.13.87])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Tue, 17 Jul 2018 11:05:56 +0200
Received: from suselix (nwb-a10-snat.microfocus.com [10.120.13.201])
        by emea4-mta.ukb.novell.com with ESMTP (TLS encrypted); Tue, 17 Jul 2018 10:05:51 +0100
Date:   Tue, 17 Jul 2018 11:05:49 +0200
From:   Andreas Herrmann <aherrmann@suse.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Commit 554c8aa8ecad causing severe performance degression with
 pcc-cpufreq
Message-ID: <20180717090549.pbhpua443yqguyhy@suselix>
References: <20180717065048.74mmgk4t5utjaa6a@suselix>
 <20180717081507.GS2476@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180717081507.GS2476@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 10:15:07AM +0200, Peter Zijlstra wrote:
> On Tue, Jul 17, 2018 at 08:50:48AM +0200, Andreas Herrmann wrote:
> > I've recently noticed that commit 554c8aa8ecad ("sched: idle: Select
> > idle state before stopping the tick") causes severe performance drop
> > for systems using pcc-cpufreq driver. Depending on the number of CPUs
> > the system might be almost unusable. 
> 
> Have you looked at that driver? It features a global lock which is taken
> for all cpufreq operations. Once you get past a handful of cpus that
> will constrict your system exactly as you say.

Yes, I figured that already and you better use another cpufreq driver
on those systems. (But that such systems with this driver are almost
unusable is a new feature ;-)

> What kind of machine are you running this on, and can you configure the
> thing to use anything else?

Its an older system.

HP ProLiant DL580 Gen8, CPUs are Intel(R) Xeon(R) CPU E7-4890
4 nodes, With HT enabled 120 logical CPUs.

Yes you can configure it using something else.

For the record. On this and similar systems pcc-cpufreq driver is used
when BIOS setting for power management option "Power Regulator" is set
to

  "Dynamic Power Savings Mode"

AFAIK this is the default setting for this option. When changing this
setting to "OS Control Mode" intel_pstate driver should be loaded.

> If so, do so and never look back.

Ok, I am fine with this.


Thanks,

Andreas

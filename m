Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31DAFC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 13:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2E162082A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 13:22:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2E162082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbeJCUKV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 16:10:21 -0400
Received: from outbound-smtp25.blacknight.com ([81.17.249.193]:40101 "EHLO
        outbound-smtp25.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726720AbeJCUKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 16:10:21 -0400
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp25.blacknight.com (Postfix) with ESMTPS id 4A16CB8813
        for <linux-kernel@vger.kernel.org>; Wed,  3 Oct 2018 14:21:57 +0100 (IST)
Received: (qmail 7280 invoked from network); 3 Oct 2018 13:21:57 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.229.88])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 3 Oct 2018 13:21:57 -0000
Date:   Wed, 3 Oct 2018 14:21:55 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Jirka Hladky <jhladky@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH 2/2] mm, numa: Migrate pages to local nodes quicker early
 in the lifetime of a task
Message-ID: <20181003132155.GD7003@techsingularity.net>
References: <20181001100525.29789-1-mgorman@techsingularity.net>
 <20181001100525.29789-3-mgorman@techsingularity.net>
 <20181002124149.GB4593@linux.vnet.ibm.com>
 <20181002135459.GA7003@techsingularity.net>
 <20181002173005.GD4593@linux.vnet.ibm.com>
 <20181003130741.GA4488@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20181003130741.GA4488@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 03, 2018 at 06:37:41PM +0530, Srikar Dronamraju wrote:
> * Srikar Dronamraju <srikar@linux.vnet.ibm.com> [2018-10-02 23:00:05]:
> 
> > I will try to get a DayTrader run in a day or two. There JVM and db threads
> > act on the same memory, I presume it might show some insights.
> 
> I ran 2 runs of daytrader 7 with and without patch on a 2 node power9
> PowerNv box.
> https://github.com/WASdev/sample.daytrader7
> In each run, has 8 JVMs.
> 
> Throughputs (Higher are better)
> Without patch 19216.8 18900.7 Average: 19058.75
> With patch    18644.5 18480.9 Average: 18562.70
> 
> Difference being -2.6% regression
> 

That's unfortunate.

How much does this workload normally vary between runs? If you monitor
migrations over time, is there an increase spike in migration early in
the lifetime of the workload?

-- 
Mel Gorman
SUSE Labs

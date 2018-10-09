Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31737C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 15:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01A372087D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 15:58:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01A372087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbeJIXPz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 19:15:55 -0400
Received: from foss.arm.com ([217.140.101.70]:40850 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726418AbeJIXPy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 19:15:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 58F0B80D;
        Tue,  9 Oct 2018 08:58:19 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 28DA43F5D3;
        Tue,  9 Oct 2018 08:58:19 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 7BA991AE0B3B; Tue,  9 Oct 2018 16:58:18 +0100 (BST)
Date:   Tue, 9 Oct 2018 16:58:18 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Lukasz Luba <l.luba@partner.samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com, mingo@redhat.com, corbet@lwn.net
Subject: Re: [PATCH] Doc: lockdep: add information about performance impact
Message-ID: <20181009155818.GD9259@arm.com>
References: <CGME20181009153935eucas1p2dec146575ed5fefd4a0b2b6cb9bac056@eucas1p2.samsung.com>
 <20181009153935eucas1p2dec146575ed5fefd4a0b2b6cb9bac056~b_ujkjRd31303013030eucas1p2C@eucas1p2.samsung.com>
 <20181009154359.GB5728@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181009154359.GB5728@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 09, 2018 at 05:43:59PM +0200, Peter Zijlstra wrote:
> On Tue, Oct 09, 2018 at 05:39:27PM +0200, Lukasz Luba wrote:
> > This patch add some warning related to performance drop.
> > It should be mentioned that this is not for free
> > and the platfrom resources (cache, bus interconnect, etc.)
> > will be used more frequently.
> 
> To me this reads a bit like: water is wet.
> 
> Is this really needed?

I don't think so -- this is a debug option under "kernel hacking". Surely
the perf hit comes with the territory.

Will

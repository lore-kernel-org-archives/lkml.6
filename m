Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3AA6C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 14:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54E2D24018
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 14:46:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54E2D24018
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753895AbeGEOqS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 10:46:18 -0400
Received: from foss.arm.com ([217.140.101.70]:51260 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753785AbeGEOqR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 10:46:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2483718A;
        Thu,  5 Jul 2018 07:46:17 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E98F73F5BA;
        Thu,  5 Jul 2018 07:46:16 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 350861AE3638; Thu,  5 Jul 2018 15:46:57 +0100 (BST)
Date:   Thu, 5 Jul 2018 15:46:57 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Andrea Parri <andrea.parri@amarulasolutions.com>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        dlustig@nvidia.com
Subject: Re: [PATCH 2/2] tools/memory-model: Add write ordering by
 release-acquire and by locks
Message-ID: <20180705144656.GF14470@arm.com>
References: <20180704121103.GB26941@arm.com>
 <Pine.LNX.4.44L0.1807051010380.1697-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1807051010380.1697-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 05, 2018 at 10:21:36AM -0400, Alan Stern wrote:
> On Wed, 4 Jul 2018, Will Deacon wrote:
> > On Tue, Jul 03, 2018 at 01:28:17PM -0400, Alan Stern wrote:
> > > Would this be allowed if smp_load_acquire() was implemented with LDAPR?
> > > If the answer is yes then we will have to remove the rfi-rel-acq and
> > > rel-rf-acq-po relations from the memory model entirely.
> > 
> > I don't understand what you mean by "rfi-rel-acq-po", and I assume you mean
> > rel-rfi-acq-po for the other? Sounds like I'm confused here.
> 
> "rfi-rel-acq" is the relation which was removed by the first of my two
> patches (it is now back in business since Paul reverted the commits),
> and "rel-rf-acq-po" is the relation that was introduced to replace it.

Sorry, yes, I realised this after I'd replied. Curious: but why do you name
the relations this way around, as opposed to e.g. rel-rfi-acq? It's
obviously up to you, but I just couldn't figure out what inspired the
ordering.

> At any rate, it looks like instead of strengthening the relation, I
> should write a patch that removes it entirely.  I also will add new,
> stronger relations for use with locking, essentially making spin_lock
> and spin_unlock be RCsc.

Thanks, Alan. I'll try to review them a bit more quickly this time, too.

Will

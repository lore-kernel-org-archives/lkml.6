Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C44ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C2D620850
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:06:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C2D620850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729684AbeGQPjl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 11:39:41 -0400
Received: from verein.lst.de ([213.95.11.211]:51955 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728489AbeGQPjk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 11:39:40 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id E54816FC87; Tue, 17 Jul 2018 17:09:08 +0200 (CEST)
Date:   Tue, 17 Jul 2018 17:09:08 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Jason Baron <jbaron@akamai.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: waitqueue lockdep annotation V3
Message-ID: <20180717150908.GA22502@lst.de>
References: <20171214152344.6880-1-hch@lst.de> <20180712191753.fvk2qersdvhcoqzp@linux-r8p5> <20180717142437.GA20286@lst.de> <20180717150439.GY2476@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180717150439.GY2476@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 05:04:39PM +0200, Peter Zijlstra wrote:
> On Tue, Jul 17, 2018 at 04:24:37PM +0200, Christoph Hellwig wrote:
> > On Thu, Jul 12, 2018 at 12:17:53PM -0700, Davidlohr Bueso wrote:
> > > On Thu, 14 Dec 2017, Christoph Hellwig wrote:
> > >
> > >> Hi all,
> > >>
> > >> this series adds a strategic lockdep_assert_held to __wake_up_common
> > >> to ensure callers really do hold the wait_queue_head lock when calling
> > >> the unlocked wake_up variants.  It turns out epoll did not do this
> > >> for a fairly common path (hit all the time by systemd during bootup),
> > >> so the second patch fixed this instance as well.
> > >
> > > I ran into these changes because of patch 1 getting rid of ep->lock. Is
> > > there any reason why this series was never picked up?
> > 
> > I'd love to see this merged, but I never heard back about it.
> 
> Seeing how it touched fs bits, I was expecting this to go through the
> vfs tree; was that not the intended target?

I don't really care which way it goes, although tip is more reliably
at picking up changes than the vfs tree..

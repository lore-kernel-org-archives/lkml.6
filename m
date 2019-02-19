Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC00C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5758521908
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:37:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729198AbfBSQhr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 11:37:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52856 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725991AbfBSQhr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 11:37:47 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0025BC05B017;
        Tue, 19 Feb 2019 16:37:46 +0000 (UTC)
Received: from pauld.bos.csb (dhcp-17-51.bos.redhat.com [10.18.17.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C26A75D970;
        Tue, 19 Feb 2019 16:37:45 +0000 (UTC)
Date:   Tue, 19 Feb 2019 11:37:44 -0500
From:   Phil Auld <pauld@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, tglx@linutronix.de, pjt@google.com,
        tim.c.chen@linux.intel.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, subhra.mazumdar@oracle.com,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com
Subject: Re: [RFC][PATCH 03/16] sched: Wrap rq::lock access
Message-ID: <20190219163743.GB10816@pauld.bos.csb>
References: <20190218165620.383905466@infradead.org>
 <20190218173514.064516553@infradead.org>
 <20190219161343.GA10816@pauld.bos.csb>
 <20190219162250.GC32494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190219162250.GC32494@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Tue, 19 Feb 2019 16:37:47 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 05:22:50PM +0100 Peter Zijlstra wrote:
> On Tue, Feb 19, 2019 at 11:13:43AM -0500, Phil Auld wrote:
> > On Mon, Feb 18, 2019 at 05:56:23PM +0100 Peter Zijlstra wrote:
> > > In preparation of playing games with rq->lock, abstract the thing
> > > using an accessor.
> > > 
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > 
> > Hi Peter,
> > 
> > Sorry... what tree are these for?  They don't apply to mainline. 
> > Some branch on tip, I guess?
> 
> tip/master I think; any rejects should be trivial tough.

Yep... git foo failed. I was on an old branch on tip by mistake, which didn't 
have rq_clock_pelt. 


Thanks,
Phil
-- 

Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7745BECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 13:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 032552151C
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 13:39:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 032552151C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731826AbeISTRZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 15:17:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:39654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731250AbeISTRZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 15:17:25 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7B312098A;
        Wed, 19 Sep 2018 13:39:24 +0000 (UTC)
Date:   Wed, 19 Sep 2018 09:39:23 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vaibhav Nagarnaik <vnagarnaik@google.com>,
        Jason Behmer <jbehmer@google.com>, stable@vger.kernel.org
Subject: Re: [GIT PULL] ring-buffer: Allow for rescheduling when removing
 pages
Message-ID: <20180919093923.0422eced@gandalf.local.home>
In-Reply-To: <20180919060706.GA17950@kroah.com>
References: <20180918191413.4426aef4@gandalf.local.home>
        <20180919060706.GA17950@kroah.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Sep 2018 08:07:06 +0200
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Tue, Sep 18, 2018 at 07:14:13PM -0400, Steven Rostedt wrote:
> > 
> > Linus (aka Greg),
> > 
> > Vaibhav Nagarnaik found that modifying the ring buffer size could cause
> > a huge latency in the system because it does a while loop to free pages
> > without releasing the CPU (on non preempt kernels). In a case where there
> > are hundreds of thousands of pages to free it could actually cause a system
> > stall. A properly place cond_resched() solves this issue.
> > 
> > 
> > Please pull the latest trace-v4.19-rc4 tree, which can be found at:
> > 
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
> > trace-v4.19-rc4  
> 
> Ick, line wrapping makes it hard to cut/paste :(

??

That's the way I have always posted pull requests. I place the branch
on the second line. It's not line wrapped, it's a hard coded new line.
Long ago I was told to do it that way.

Should that be changed? It would be trivial to update my scripts.

> 
> Anyway, now pulled and pushed out.

Thanks,

-- Steve


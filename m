Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A93CFC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 18:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CDB620858
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 18:56:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CDB620858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733035AbeITAgA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 20:36:00 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50192 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387510AbeITAei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 20:34:38 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 846F4CC9;
        Wed, 19 Sep 2018 18:55:22 +0000 (UTC)
Date:   Wed, 19 Sep 2018 20:55:20 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vaibhav Nagarnaik <vnagarnaik@google.com>,
        Jason Behmer <jbehmer@google.com>, stable@vger.kernel.org
Subject: Re: [GIT PULL] ring-buffer: Allow for rescheduling when removing
 pages
Message-ID: <20180919185520.GA23184@kroah.com>
References: <20180918191413.4426aef4@gandalf.local.home>
 <20180919060706.GA17950@kroah.com>
 <20180919093923.0422eced@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180919093923.0422eced@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 09:39:23AM -0400, Steven Rostedt wrote:
> On Wed, 19 Sep 2018 08:07:06 +0200
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> 
> > On Tue, Sep 18, 2018 at 07:14:13PM -0400, Steven Rostedt wrote:
> > > 
> > > Linus (aka Greg),
> > > 
> > > Vaibhav Nagarnaik found that modifying the ring buffer size could cause
> > > a huge latency in the system because it does a while loop to free pages
> > > without releasing the CPU (on non preempt kernels). In a case where there
> > > are hundreds of thousands of pages to free it could actually cause a system
> > > stall. A properly place cond_resched() solves this issue.
> > > 
> > > 
> > > Please pull the latest trace-v4.19-rc4 tree, which can be found at:
> > > 
> > > 
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
> > > trace-v4.19-rc4  
> > 
> > Ick, line wrapping makes it hard to cut/paste :(
> 
> ??
> 
> That's the way I have always posted pull requests. I place the branch
> on the second line. It's not line wrapped, it's a hard coded new line.
> Long ago I was told to do it that way.
> 
> Should that be changed? It would be trivial to update my scripts.

Ah, ok, that's not what I have been doing for a long time, nor what the
sub-maintainers that send stuff to me have done.  Normally it is:
	git_url tag

Like this one for perf stuff:
	https://lore.kernel.org/lkml/20171027195047.27132-1-acme@kernel.org/

If you have been doing it this way to Linus, that's fine, I can adapt :)

thanks,

greg k-h

Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE371C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 06:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACF402098A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 06:07:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACF402098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731084AbeISLnb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 07:43:31 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41068 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731053AbeISLna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 07:43:30 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 66DAF92B;
        Wed, 19 Sep 2018 06:07:09 +0000 (UTC)
Date:   Wed, 19 Sep 2018 08:07:06 +0200
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
Message-ID: <20180919060706.GA17950@kroah.com>
References: <20180918191413.4426aef4@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180918191413.4426aef4@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2018 at 07:14:13PM -0400, Steven Rostedt wrote:
> 
> Linus (aka Greg),
> 
> Vaibhav Nagarnaik found that modifying the ring buffer size could cause
> a huge latency in the system because it does a while loop to free pages
> without releasing the CPU (on non preempt kernels). In a case where there
> are hundreds of thousands of pages to free it could actually cause a system
> stall. A properly place cond_resched() solves this issue.
> 
> 
> Please pull the latest trace-v4.19-rc4 tree, which can be found at:
> 
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
> trace-v4.19-rc4

Ick, line wrapping makes it hard to cut/paste :(

Anyway, now pulled and pushed out.

greg k-h

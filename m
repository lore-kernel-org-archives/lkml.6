Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 773D3C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 14:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F26620663
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 14:30:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F26620663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728320AbeJVWtV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 18:49:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:58464 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727210AbeJVWtV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 18:49:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 16113B040;
        Mon, 22 Oct 2018 14:30:31 +0000 (UTC)
Date:   Mon, 22 Oct 2018 16:30:29 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Daniel Wang <wonderfly@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Jiri Slaby <jslaby@suse.com>,
        Peter Feiner <pfeiner@google.com>,
        linux-serial@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        john.ogness@linutronix.de
Subject: Re: [RFC][PATCHv2 2/4] printk: move printk_safe macros to printk
 header
Message-ID: <20181022143029.i4jc5vjq4t3tagb3@pathway.suse.cz>
References: <20181016050428.17966-1-sergey.senozhatsky@gmail.com>
 <20181016050428.17966-3-sergey.senozhatsky@gmail.com>
 <20181016072719.GB4030@hirez.programming.kicks-ass.net>
 <20181016114006.6q5atyaitapcwbud@pathway.suse.cz>
 <20181016121752.GA2537@hirez.programming.kicks-ass.net>
 <20181017105015.udzegzfh7cxgatso@pathway.suse.cz>
 <20181017140044.GK3121@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181017140044.GK3121@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2018-10-17 16:00:44, Peter Zijlstra wrote:
> On Wed, Oct 17, 2018 at 12:50:15PM +0200, Petr Mladek wrote:
> > Also note that by deferred printk I mean deferring the console
> > handling! IMHO, there are _no more problems_ with storing
> > the messages into the buffer if we accept that the current
> > very limited use of printk_safe per-cpu buffers is easier
> > than any complicated generic lockless buffer.
> 
> They hide messages. The whole two radically different printk paths is
> also quite horrible.

I agree that having everything in one buffer with unified
and safe access from any context would be a great win.


> And lockless buffers aren't all _that_ complicated, esp. not when
> performance isn't the top priority.
>
> And earlycon is mostly usable, esp. the serial ones. Those, when
> configured, should synchronously print along. The current design
> also makes that difficult.
>
> A wee little like so; typed in a hurry, never been near a compiler.

Thanks a lot for the code. I still need to find time to better
understand it. Anyway, it looks worth considering.

Best Regards,
Petr

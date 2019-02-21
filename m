Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC0DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F9D42084F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:51:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbfBUNvo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 08:51:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:37304 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725385AbfBUNvn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 08:51:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4F945AF81;
        Thu, 21 Feb 2019 13:51:42 +0000 (UTC)
Date:   Thu, 21 Feb 2019 14:51:40 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Wang <wonderfly@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Jiri Slaby <jslaby@suse.com>,
        Peter Feiner <pfeiner@google.com>,
        linux-serial@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC PATCH v1 04/25] printk-rb: add writer interface
Message-ID: <20190221135140.enamunz6p54dt443@pathway.suse.cz>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
 <20190212143003.48446-5-john.ogness@linutronix.de>
 <20190214151650.5y337yy2jnnztsc6@pathway.suse.cz>
 <87ef8aosby.fsf@linutronix.de>
 <20190215134711.pimxhuwipkzlgq23@pathway.suse.cz>
 <87d0nr5heh.fsf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d0nr5heh.fsf@linutronix.de>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 2019-02-17 02:32:22, John Ogness wrote:
> Hi Petr,
> 
> I've made changes to the patch that hopefully align with what you are
> looking for. I would appreciate it if you could go over it and see if
> the changes are in the right direction. And if so, you should decide
> whether I should make these kinds of changes for the whole series and
> submit a v2 before you continue with the review.
> 
> The list of changes:
> 
> - Added comments everywhere I think they could be useful. Is it too
>   much?

Some comments probably can get shortened. But I personally find
them really helpful.

I am not going to do a detailed review of this variant at the moment.
I would like to finish the review of the entire patchset first.

> - I tried moving calc_next() into prb_reserve(), but it was pure
>   insanity. I played with refactoring for a while until I found
>   something that I think looks nice. I moved the implementation of
>   calc_next() along with its containing loop into a new function
>   find_res_ptrs(). This function does what calc_next() and push_tail()
>   did. With this solution, I think prb_reserve() looks pretty
>   clean. However, the optimization of communicating about the wrap is
>   gone. So even though find_res_ptrs() knew if a wrap occurred,
>   prb_reserve() figures it out again for itself. If we want the
>   optimization, I still think the best approach is the -1,0,1 return
>   value of find_res_ptrs().

I still have to go more deeply into it. Anyway, the new code looks
much better than the previous one.

Best Regards,
Petr

Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 582B0ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 06:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0810520673
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 06:47:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0810520673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730556AbeGSH33 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 03:29:29 -0400
Received: from muru.com ([72.249.23.125]:52060 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726890AbeGSH33 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 03:29:29 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 0F3E88127;
        Thu, 19 Jul 2018 06:51:06 +0000 (UTC)
Date:   Wed, 18 Jul 2018 23:47:52 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v1 0/3] console, serial8250: Disable PM and DMA ops
Message-ID: <20180719064752.GJ99251@atomide.com>
References: <20180516100842.xuma7b3e727w7bpz@linutronix.de>
 <CAHp75Vc2bJQHiWYcdKK+7wwMw2fSWxMauxP-dMRUAUdKnet7WQ@mail.gmail.com>
 <20180516104734.357oevogppu5bsg4@linutronix.de>
 <ed9879ef42a70d2609f60f73834cabb7e3df9e2f.camel@linux.intel.com>
 <20180517135621.GJ98604@atomide.com>
 <CAHp75VfqAK6+dPWWkQXjy0V-AFSGLSDJ9CmnUv=ba0F66TDTVg@mail.gmail.com>
 <20180517193008.GV25808@atomide.com>
 <CAHp75Ve56pyEC41XZ9i9yxBNberQe=ee2miQL0v9T4vRtkWPBQ@mail.gmail.com>
 <20180523175859.GO98604@atomide.com>
 <c10bb604a6bf416e2092ae64a2cb9bb4658ea0eb.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c10bb604a6bf416e2092ae64a2cb9bb4658ea0eb.camel@linux.intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Andy Shevchenko <andriy.shevchenko@linux.intel.com> [180718 15:17]:
> On Wed, 2018-05-23 at 10:58 -0700, Tony Lindgren wrote:
> > 
> > OK yeah console.idle sounds good to me. We should default to a
> > safe option.
> 
> I'll see what we can do here.

Like we discussed offline I think if we allow detaching and attaching
kernel console from userspace we can get rid of irqsafe completely :)
And in that case no need for console.idle or anything like that.

Then if kernel console is attached, we can keep console uart enabled.
If detached, it can do runtime PM if hardware supports it.

Not sure if we need some separate new /sys entry for that, maybe
we already have that with the loglevel in /proc/sys/kernel/printk?

Regards,

Tony


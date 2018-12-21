Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A19C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2579021906
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:32:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kTGTW+Gc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732211AbeLUHcW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 02:32:22 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43556 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727758AbeLUHcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 02:32:20 -0500
Received: by mail-pg1-f194.google.com with SMTP id v28so2108915pgk.10
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 23:32:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=J1vgKin2ByWEqEgoiBIgqdHFxC+97dra4Ek8pxlY7Tc=;
        b=kTGTW+Gc1JXUKr/IlvGvwzl3WGfFtaJYeqWCG5C+03zDndqIJryaIdvLqAzGE3T9NU
         naiv8I9q5Y/loVPuA6E1+0rpozRgJzXNVS8qgGYBiOSVgdQeRd9YeP2ZZTSYNN/nn7PQ
         arjMREp7ooFpSFCuHKX7MBQBJMeWeXDQGrgtN6X632kTMnrSkSZ2cFp0fThGI/JZG2rN
         5aX8/SKmAx2YBR9/cAPjovXwvou5uM1VVPtjvpUNioBBfAHOYWoy2HBvLKPUQgDpGowz
         rjzH+bsZuOSZEUUrB4lK7nB74od3GdJxrr2zTLTN/dkun95Le2GLLroWsq1LZeUhaFKq
         VwPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=J1vgKin2ByWEqEgoiBIgqdHFxC+97dra4Ek8pxlY7Tc=;
        b=Sosta/4IqnUl9kpM9OIhkxPlhDv20ECJdq1DAqBBqwR1rzHUoHJ8L6HdlXQVMX1Q6i
         WDH2JJxDfYgZTpB2SbQkEdsg6Qn7IW+rbmBB9jyQ8NYaiAdbBdoYawEZC2YMrFOh23No
         Sbkbr4CK9ick3hebEs4liyf+lyGDxFmEDvVuUFVaY4AwZHuosJoTDcx6QUZWZ3AW8ZPv
         NohfgSZUPTYbGj3Kek4ClBxTQGPr6OxLsLKL/jrSZOjMB6OIsh/Rrku3CCyVA7XGYVH1
         9SPE6mYwAw6u49xs3vEmp4CRxSv661IBEJUOU7XGjs9YnlTg2bKb8mbu8j1Vo6mcXSn2
         wKgw==
X-Gm-Message-State: AA+aEWaGp0khZ+ONshgINo3zFPl3DV9n9AGOBJB/9N+0vrmZBWnmAUYt
        PwVrMl7+DXmRJkmz0S6glN8=
X-Google-Smtp-Source: AFSGD/Vnu+Fte+Dd+fFjaOQiX1Ef5bLDBheYvxCm02rQSbpY/w6JBW8pLzZ3X+mUtu8Z74K/j0Y+zg==
X-Received: by 2002:a62:dbc2:: with SMTP id f185mr1396605pfg.235.1545377540261;
        Thu, 20 Dec 2018 23:32:20 -0800 (PST)
Received: from localhost ([110.70.50.218])
        by smtp.gmail.com with ESMTPSA id b2sm31787424pgg.87.2018.12.20.23.32.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 23:32:19 -0800 (PST)
Date:   Fri, 21 Dec 2018 16:32:15 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Borislav Petkov <bp@alien8.de>, Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] printk: increase devkmsg write() ratelimit
Message-ID: <20181221073215.GA8951@jagdpanzerIV>
References: <20181218142623.GH7485@zn.tnic>
 <20181218145558.GD665@tigerII.localdomain>
 <20181218150313.GI7485@zn.tnic>
 <20181218151455.GE665@tigerII.localdomain>
 <20181218152413.GJ7485@zn.tnic>
 <20181218165217.GA534@tigerII.localdomain>
 <20181218172109.GK15430@hirez.programming.kicks-ass.net>
 <20181218123748.3aadd16c@gandalf.local.home>
 <20181220113537.GA701@jagdpanzerIV>
 <20181220085803.4c5853e8@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181220085803.4c5853e8@gandalf.local.home>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (12/20/18 08:58), Steven Rostedt wrote:
> > > Userspace processes should never be able to overwrite messages
> > > from the kernel.
> > 
> > I would agree.
> > 
> > It's a bit funny that kernel people first take the patch in and then,
> > when user-space begins to use the feature, start to object and ratelimit.
> 
> Please note the "kernel people" to first take it in, were also systemd
> developers.

Good point.

> Honestly, it should have been a separate buffer to begin with, and I
> wish I pushed for that when it was first added. It's not too late. We
> can still make it a separate buffer.

Ideally, yes, separating them will make sense.

[..]
> When the system is up and running, it works. But I believe systemd can
> still only use ksmsg for initial boot up messages before it does the
> chroot.
[..]
> Do you get systemd messages before chroot with this patch compared to
> what you get without it?

You are right.

systemd cannot log anything really early - there should be /dev/kmsg char
device so they can open() it and write() to it. IOW only after chr_dev_init()
they can append messages to devkmsg. Which is still early enough, perhaps
earlier than UART init. systemd can log to tty, but unlike logbuf messages,
messages written to tty cannot be re-played:

+->  chr_dev_init() create /dev/kmsg
|      persistent storage is not mounted yet
|      writes to /dev/kmsg work
|      ...
|    chroot
|    mount /dev/sdX
+->  journald starts
     pulls logbuf (devkmsg)
     syslog now works
     "systemd[1]: Starting Flush Journal to Persistent Storage..."

So without devkmsg some early systemd messages can be lost (between
chr_dev_init() and exec(journald)), just like you said; or (best case)
will go to serial log. Messages before chr_dev_init() will be lost
because there is no /dev/kmsg; messages after exec(journald) do not
necessarily depend on /dev/kmsg and can be logged via syslog/journal
interface.

	-ss

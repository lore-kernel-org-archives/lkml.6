Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF92DC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 04:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73561214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 04:32:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="btsobOz5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73561214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbeJQM0l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 08:26:41 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38409 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbeJQM0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 08:26:41 -0400
Received: by mail-pl1-f195.google.com with SMTP id q19-v6so8966310pll.5;
        Tue, 16 Oct 2018 21:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Up+Nm6ar1d1xj3x5+wKEUWkqKVkIxNqamg+4hSpOuyk=;
        b=btsobOz5uKWIxGjaMA8rtxq2lFfcawJkecY06CF3Q8eHu8jAVGGY9WcwsMfj/qit9T
         0qelR03bkZX4vmErAdNJLlpVsloJB8omNOjs2+qTiKeX9ZEMWpJe9HIjpYkBNiROXWee
         JYRw/F/aQU1822HaMiX0kfLMEbomU7CEq5G0m2dmZIBPGtzWZJWwAG4lxEzXIQWw6YWr
         5LhX3moxQHuqRJxQN27GbYHJt06L/e9BLX0rE1dLn22SKsC2prWS+nyUN8UJf8BUAqg+
         ANBAoWRPiilu5PIBusRDD17PN2QrlVcYLCFn2BpIR3t7azoFNWW/M/m/dAFg1Na2qYWq
         7eMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Up+Nm6ar1d1xj3x5+wKEUWkqKVkIxNqamg+4hSpOuyk=;
        b=Ae1lu/zPVfMpviZ+TqE50a+SFqICRiZMK1C2bJuVl+w+j4Lm3WKJFg4YqfNszzo3ee
         MoeCkv2I4S4rBOP56/39J0YJSzeBv6OJjfB+qYaw1xYNjyK0x151WPntcGxjBEtr3nXz
         XOvqCQtwi7K093ukmnjRTLbbKI2Xu2k5Vt3FCQuMsNb6p0e+8GQO7Q/TcjzLl/OmYxDr
         Q3MLkp6PJz2P0+HV2gg20fa/t+kgJfngkN7LvpoW7AJcXxCQtskepP7wSHi1AnMRbgqm
         Xawy7xGwy/OcyFIV3d8VP+mC/bk1n6Wy7yVolLkB8dpVVP3ZEOutFR5CGJiJnYwZkMfz
         G/WA==
X-Gm-Message-State: ABuFfoiXt4aBqiABBJsX+NjdWEBga5YROrkvbru5Ukb9MDQpBPxETWdL
        wx+lI1cIPCYLJtvaFgyR8NU=
X-Google-Smtp-Source: ACcGV63SMXHhRIV4k+7wXr2zsetHGSSYahchbeujQ/aY0j8SiZVqB7cw/jsymzmwSt3vHnEmjpdCMA==
X-Received: by 2002:a17:902:4681:: with SMTP id p1-v6mr16351354pld.97.1539750776964;
        Tue, 16 Oct 2018 21:32:56 -0700 (PDT)
Received: from localhost ([110.70.53.52])
        by smtp.gmail.com with ESMTPSA id t15-v6sm24634957pfj.7.2018.10.16.21.32.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Oct 2018 21:32:55 -0700 (PDT)
Date:   Wed, 17 Oct 2018 13:32:51 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
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
Subject: Re: [RFC][PATCHv2 2/4] printk: move printk_safe macros to printk
 header
Message-ID: <20181017043251.GC1068@jagdpanzerIV>
References: <20181016050428.17966-1-sergey.senozhatsky@gmail.com>
 <20181016050428.17966-3-sergey.senozhatsky@gmail.com>
 <20181016072719.GB4030@hirez.programming.kicks-ass.net>
 <20181016122734.GA1259@jagdpanzerIV>
 <20181016125415.GA3121@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181016125415.GA3121@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (10/16/18 14:54), Peter Zijlstra wrote:
> On Tue, Oct 16, 2018 at 09:27:34PM +0900, Sergey Senozhatsky wrote:
> > per-CPU printk_safe _semi-magic_ makes some things simple to handle.
> > We can't just remove per-CPU buffers and add a wake_up_process() at
> > the bottom of vprintk_emit(). Because this will deadlock:
> > 
> >   printk()
> >    wake_up_process()
> >     try_to_wake_up()
> >      raw_spin_lock_irqsave()
> >  <NMI>
> >       printk()
> >        wake_up_process()
> >         try_to_wake_up()
> >          raw_spin_lock_irqsave()
> > 
> > So we still need some amount of per-CPU printk() semi-magic anyway.
> 
> All we need is 4 max-line-length buffers per-CPU. Nothing more.

OK, similar to what Steven did with cpu_buffer->current_context.

> The above trainwreck is the direct result of forcing synchronous
> printk'ing (which I'm otherwise a big fan of, but regular console
> drivers stink and are unfixable).

Yep.

> > And printk-kthread offloding will not eliminate the need of
> > printk_deferred().
> 
> Why not? printk() will reduce to a lockless buffer insert. IOW _all_
> printk is deferred.

Aha! Interesting. I didn't realize you were talking about
"all printk()-s are deferred".
OK, jump to the last part of this mail.

> All you need are 4 max-line-length buffers per CPU and a global/shared
> lockless buffer.
> 
> printk will determine the current context:
> 
>   task, softirq, hardirq or NMI
> 
> and pick the corresponding per-cpu line buffer and do the vsnprintf()
> thing. Then we have the actual line length and content. With the length
> we reserve the bytes from the global buffer, we memcpy into the buffer
> and commit.
> 
> Done.
> 
> The printk thread will observe it lags behind the buffer head and will
> start printk-ing crud from task context.

[you can skip this part]

This probably will be a bit more hairy. logbuf is written to by many
sources and is read from by many sides, including user-space [both read()
and write()]. So we will need more flags/magic around memcpy(). A simple,
"grab the logbuf entry, set the proper offset to point to the next available
logbuf record and then do memcpy()" won't suffice. We need a flag for
"memcpy() complete, we can read this entry". Otherwise:

CPU0		CPU1		CPU2			CPU3
printk		printk					printk_kthread
logbuf_entry A	logbuf_entry B  syslog(read all)	call_console_drivers
memcpy		memcpy		read unfinished		print unfinished
					A and B			A and B

[..]

> > We do, however, have loads of problems with all those dependencies which
> > come from serial drivers and friends: timekeeping, scheduler (scheduler
> > is brilliant and cool, but we do have some deadlocks in printk because of
> > it ;), tty, net, MM, wq, etc. So I generally like the idea of "detached
> > serial consoles" (that's what I call it). IOW, elimination of the direct
> > printk -> serial console path. 
> 
> Right; we need to get rid of that in the generic case. Only allow
> lockless consoles (earlycon) to be used synchonously. With maybe a
> special case for the BUG/PANIC case to push things out ASAP.
[..]
> > So, unless I'm missing something, things are not entirely that simple:
> > - throw away printk_safe semi-magic
> > - add a lockless logbuf
> > - add wake_up_process() to vprintk_emit().
> 
> No, no wakups. irq_work to wake the printk-thread, at most.

All right. OK. So we are on the same page here:

printk has internal locks - logbuf spin_lock; and external locks - all
the scheduler locks, console_sem, net, tty, wq, you name it. printk() is
not aware of those external locks; the only way to fix it is to remove
them from printk(). And that's why

	"turn printk() into printk_deferred() and fix printk() deadlocks
	 in general case"

was my final proposal at the 2016 KS, NM, USA [1] (grep for printk_deferred).
I mentioned this idea several times since then, and even sent a patch, doing
this "printk is now printk_deferred unless we are in panic" thing. As far
as I remember, back then the idea/patch were rejected [2], and one of
reviewers even hinted that I was crazy :-) I have absolutely no issues
with that, but, considering past experiences, I'd really like to:

- Have more opinions on this. People please speak out.
- Have clear "let's do it" from Cc-ed people.


If we are really doing this, then let's split it and have
incremental changes. Namely, what I suggest is:

- keep internal printk lock - logbuf lock for now; we know how to
  handle it. I promise.

- keep printk_safe for now, we need it to deal with logbuf lock

- keep printk_safe completely internal to printk

- add printk_kthread

- do printk()->irq_work()->wake_up_process(printk_kthread)
  change and remove external locks dependency

- use direct printk() for panic() case

- do something about early_printk


That's big enough already.
From there, once we land this thing, we can start building new logbuf,
stealing code from Steven, improving per-CPU buffers and so on.


Are we doing this?


[1] https://lwn.net/Articles/705938/
[2] https://lore.kernel.org/lkml/20170202090722.GW6515@twins.programming.kicks-ass.net/

	-ss

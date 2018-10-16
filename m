Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9607DC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 12:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38EF02089E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 12:27:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FLFav5XK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38EF02089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbeJPURy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 16:17:54 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38919 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbeJPURy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 16:17:54 -0400
Received: by mail-pg1-f196.google.com with SMTP id r9-v6so10791270pgv.6;
        Tue, 16 Oct 2018 05:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jnqmgdEnIZu5pO808ibRJWMJO0X2TOwKIXEq6NIihPg=;
        b=FLFav5XKxhjOrbVyitGYOchyPjMB25xRi1kf8V6JnvEe1Ak/Q22umPcD11XTRkllGt
         l3NUVCiXdNyfIgq3Yxb7/UksEw5EBRuRjN1vAQErg0252GS7ZHJzA8AdUQfMQNtzhB++
         v0cfmwT+uUMowlIqZSPSvSUgf+mUGd+ivRaLanZAK9JR180fMCdnCcI5WfsfRF25Tfpz
         T3JSEZIkC7bNtvnGFCao0jaAZZnGLPzEQYTekfI8JEBDhbzwQEWX3yOl9xlWaMPq9L5V
         w41ZAeQgKmnC0iiqkhJAgf3pn4vW3YLKQKfwUMSkMyhMqdUwhle6lmaUYrW+pAJKhXYS
         a7FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jnqmgdEnIZu5pO808ibRJWMJO0X2TOwKIXEq6NIihPg=;
        b=PVDVRvTNzErMPSdeVN1ATDQmRNwnF5hlTpH2F8Fph6CDeug694Z3wHXngRaDJTMcHd
         oeOepwaPfjr/s7xm9wlg/qG5BLk42HKeFooqdjx47HHfoPGdRNbf+HVrYG+UygjpR3N3
         e7j1XPyWACqgkVuyOwK7241HdFK3JUDoHzKVOFjYFIOtNRh0fRf8sAX5xTm9f1wawCcy
         a6wdk4wotb/yHA0X0PhrBL+MK4jfx6gGb9GhGss6U3ODn0dQOlHC9fNwi7WDv/hnTgQf
         RIZE2QKrSMlecu1PDXxbSaIfZtdcjoHFA2T13QrLVVV3/hxsynu4bXld3Kzl+c5cjMjM
         gNAg==
X-Gm-Message-State: ABuFfog/7JBZSFzmf6bPIIEZWMWWZby2WptIRl7XJZm5tYnQH2NRZGHQ
        PzjpCvLqztjW2E32MZTJgz0=
X-Google-Smtp-Source: ACcGV63dto2vAuSIKn7oi5z/JVThvOAAGCUSYhePZxjm8HqJ90ZV6jBXGsMd/Xp1twe1BRTq/bnaXA==
X-Received: by 2002:a62:67c3:: with SMTP id t64-v6mr14496433pfj.76.1539692859351;
        Tue, 16 Oct 2018 05:27:39 -0700 (PDT)
Received: from localhost ([175.223.10.117])
        by smtp.gmail.com with ESMTPSA id d197-v6sm21174914pga.1.2018.10.16.05.27.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Oct 2018 05:27:38 -0700 (PDT)
Date:   Tue, 16 Oct 2018 21:27:34 +0900
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
Message-ID: <20181016122734.GA1259@jagdpanzerIV>
References: <20181016050428.17966-1-sergey.senozhatsky@gmail.com>
 <20181016050428.17966-3-sergey.senozhatsky@gmail.com>
 <20181016072719.GB4030@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181016072719.GB4030@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (10/16/18 09:27), Peter Zijlstra wrote:
> 
> So I really _really_ hate all this. Utterly detest it.

I learned a new word today - detest. I can haz re-entrant consoles now please?

> That whole magic 'safe' printk buffer crap is just that crap.

No, I don't see it this way; printk_safe is *semi-magic* at best! :)

> Instead of this tinkering around the edges, why don't you make the main
> logbuf a lockless ringbuffer and then delegate the actual printing of
> that buffer to a kthread, except for earlycon, which can do synchronous
> output.

Well, hmm. These are good questions. Let me think.

per-CPU printk_safe _semi-magic_ makes some things simple to handle.
We can't just remove per-CPU buffers and add a wake_up_process() at
the bottom of vprintk_emit(). Because this will deadlock:

  printk()
   wake_up_process()
    try_to_wake_up()
     raw_spin_lock_irqsave()
 <NMI>
      printk()
       wake_up_process()
        try_to_wake_up()
         raw_spin_lock_irqsave()

So we still need some amount of per-CPU printk() semi-magic anyway.

And printk-kthread offloding will not eliminate the need of
printk_deferred(). Which is very hard to use in the right places, like
always; and we don't have any ways to find out that a random innocently
looking printk() may actually be invoked from somewhere deep in the
call-chain with rq lock or pi_lock being locked some 5 frames ago, until
that printk() actually gets invoked and possibly deadlocks the system.

Having "unprotected" wake_up_process() in vprintk_emit(), in fact,
will make the need for printk_deferred() even bigger.

On the other hand, we have wake_up_klogd_work_func() in printk, which
uses irq work, so we, may be, can wakeup printk_kthread from there and,
thus, remove all the external locks from printk()... But I doubt it that
anyone will ever ACK such a patch.

Speaking of lockless logbuf,
logbuf buffer and logbuf_lock are the smallest of the problems printk
currently has. Mainly because of lockless semi-magical printk_safe
buffers. Replacing one lockless buffer with another lockless buffer will
not simplify things in this department. We probably additionally will
have some nasty screw ups, e.g. when NMI printk on CPUA interrupts normal
printk on the same CPUA and now we have mixed in characters; and so on.
per-CPU printk_safe at least keeps us on the safe side in these cases and
looks fairly simple. I also sort of like that logbuf_lock lets us to have
a single static textbuf buffer which we use to vscnprintf() printk messages,
and how printk_safe helps us to get recursive errors/warnings from
vscnprintf(). So printk_safe/printk_nmi things are not _entirely_ crappy,
I guess.

We do, however, have loads of problems with all those dependencies which
come from serial drivers and friends: timekeeping, scheduler (scheduler
is brilliant and cool, but we do have some deadlocks in printk because of
it ;), tty, net, MM, wq, etc. So I generally like the idea of "detached
serial consoles" (that's what I call it). IOW, elimination of the direct
printk -> serial console path. I don't hate the idea of a complete printk
re-work. But some people do, tho. And they have their points. Some people
like the synchronous printk nature and see scheduler dependency as a
"regression".

The current approach - use the existing printk_safe mechanism and
case-by-case, manually, break dependencies which can deadlock us is
a lazy approach, yes; and not very convenient. I'm aware of it.

So, unless I'm missing something, things are not entirely that simple:
- throw away printk_safe semi-magic
- add a lockless logbuf
- add wake_up_process() to vprintk_emit().

It does not completely remove dependency on "external" locks - scheduler,
etc. And as long as we have them - printk can deadlock.

Am I missing something?


Another idea, which I had like a year ago, was to treat printk logbuf
messages in serial consoles the same way they treat uart xmit buffer.
Each console has an IRQ handler, which reads pending messages from xmit
buffer and prints them to the console:

	int serial_foo_irq(...)
	{
		unsigned int max_count = TX_FIFO_DEPTH;

		while (max_count) {
			unsigned int c;

			if (uart_circ_empty(xmit))
				break;

			c = xmit->buf[xmit->tail];
			writel(port, UART_TX, c);
			xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
			max_count--;
		}
	}

We can do the same for printk logbuf. Each console can have last_seen_idx.
And read logbuf messages (poll logbuf) starting from that per-console
last_seen_idx in IRQ handler; we don't have to call into scheduler, net,
etc. printk() will simply add messages to logbuf, consoles will poll pending
messages from IRQs handlers; and everyone is happy... And we will do direct
printk -> console_drivers only for early_con or when in panic().

	-ss

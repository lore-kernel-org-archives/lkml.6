Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F0BC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 07:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6636620849
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 07:27:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cy1EXlxU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6636620849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbeGKHaH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 03:30:07 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:35358 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbeGKHaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 03:30:06 -0400
Received: by mail-pl0-f66.google.com with SMTP id k1-v6so8783499plt.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 00:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uTrMysqOYxwsUdEJrMHjWIkDMUQGt2E7Em3DklBFaRY=;
        b=Cy1EXlxUbeUQ1eg5B2E7VbS8XPBTARDL5XN+7VzazndWqW7/cZaGuIED5Kmngf8JJa
         f64gGadpoBJ/SuYwsZqUmN9ETUfS25kXZFEiiS7iQO+MaGGtkZLl4SKXSx4PK6VwHc6F
         55g92EtFXvrYY30STMq17varQdI4Fdn1EgvFJXvW15yzoiEG1eL/dq9f353zzdVQ3/Tu
         ybZb0S/yY6LB3/c+nNR3tEIrarTo80e7EZ7L9ivIiAEydQHGoJ6soNZGAO2baMshHeuH
         +YWYatDjhESpIv0T39y+89EjWkE4vWumGry1FVdEm43C9DE4cfOweBcblus3mUQHhZ0E
         u4sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uTrMysqOYxwsUdEJrMHjWIkDMUQGt2E7Em3DklBFaRY=;
        b=QDvcXeUdlsV5U30sEd9JaMxf1SoKuqJtAvE9fz3T1j+KdzTesglrvWE3XMwQMIdpDJ
         DjWpzVPYu7ylRGsApiAJUfPem2bFLEXUsOUNDawuousyzaJ0yZR0eSuB9lkV99NFMwFE
         +pUci2hSQmyaVhb7qEpAX6iNOUvdmH1cHOWaVhh+at6k+csM3VqXBzXLjUa085A2/XX8
         5vxzlpxelmnj+1WCfUU0BGrVIid3lC/ANTlR9s9k4WhymZmfiJP/oRDFBHzcEDFkEV9u
         hILgx/xEtU9j48Qk4FWcHoOhz1ZUHZ5cpzAZaI0WTTkvQSGpt36LswBKWUg+n/IZg7H2
         PDDw==
X-Gm-Message-State: APt69E0pm0lzUCWwOeKwCayqI69ktOCrN+R19LZtYn5JsmD4D2XKTH9W
        g0a9WYZFdxgmL+ZLVgAvIHE=
X-Google-Smtp-Source: AAOMgpf1MKgM5mO6Zzl8ZWkQqRlwfX7Gre6UwDKny0EwJnAqs+4dC8QlQqLxnNzCnHunwW/rQbN/bg==
X-Received: by 2002:a17:902:1101:: with SMTP id d1-v6mr27158743pla.147.1531294033986;
        Wed, 11 Jul 2018 00:27:13 -0700 (PDT)
Received: from localhost ([175.223.23.177])
        by smtp.gmail.com with ESMTPSA id y16-v6sm9717494pgc.73.2018.07.11.00.27.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Jul 2018 00:27:12 -0700 (PDT)
Date:   Wed, 11 Jul 2018 16:27:09 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: printk() from NMI backtrace can delay a lot
Message-ID: <20180711072709.GA663@jagdpanzerIV>
References: <bf037670-c647-b34a-486b-53ec3661b48e@i-love.sakura.ne.jp>
 <20180703043021.GA547@jagdpanzerIV>
 <20180703152944.GQ533219@devbig577.frc2.facebook.com>
 <20180703163145.GB391@tigerII.localdomain>
 <20180710115036.parj36owujllwr2i@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180710115036.parj36owujllwr2i@pathway.suse.cz>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc-ng Alan, Greg, Jiri
A lockdep report: https://lore.kernel.org/lkml/20180703043021.GA547@jagdpanzerIV/T/#u

On (07/10/18 13:50), Petr Mladek wrote:
> > 
> > Another option *possibly* could be...
> > 
> > ... maybe we can brake another lock dependency. I don't quite understand,
> > and surely I'm missing something here, why serial driver call
> > tty_flip_buffer_push() under uart_port->lock. E.g.
> > 
> > 	serial_driver_handle_irq()
> > 	{
> > 		spin_lock(uart_port->lock);
> > 
> > 		.. TX() / RX()
> > 
> > 		tty_flip_buffer_push(uart_port->tty_port);
> > 		spin_unlock(uart_port->lock);
> > 	}
> > 
> > it might be the case that we can do
> > 
> > 	serial_driver_handle_irq()
> > 	{
> > 		spin_loc(uart_port->lock);
> > 
> > 		.. TX / RX
> > 
> > 		spin_unlock(uart_port->lock);
> > 
> > 		tty_flip_buffer_push(uart_port->tty_port);
> 
> Hmm, this looks racy. For example, I see the following in
> serial_lpc32xx_interrupt():
> 
> 		tty_insert_flip_char(tport, 0, TTY_OVERRUN);
> 		tty_schedule_flip(tport);
> 
> where tty_insert_flip_char() manipulates flag/char/used:
> 
> 			*flag_buf_ptr(tb, tb->used) = flag;
> 		*char_buf_ptr(tb, tb->used++) = ch;
> 
> and tty_schedule_flip() copies "used" -> "commit":
> 
> 	smp_store_release(&buf->tail->commit, buf->tail->used);
> 	queue_work(system_unbound_wq, &buf->work);

I'm lacking some ["a lot of", actually] knowledge here.

Alan, Jiri could you help us?

Correct me if I'm wrong. I thought that flip buffers are used to "cache"
received chars/commands from the device before device "sends" (flushes)
them to ldisc. So chars are added to flip buffers by the device itself - RX
function, which is most commonly called from the device's IRQ handler.
That's why we see things like

	foo_irq_handler()
	{
	...	spin_lock(uart_port->lock);

		foo_TX_chars();
		tty_flip_buffer_push();  // tty_schedule_flip()
	...
		spin_unlock(uart_port->lock);
	}

or

	foo_irq_handler()
	{
	...	spin_lock(uart_port->lock);

		foo_TX_chars()
		{
			...
			tty_insert_flip_char();
			tty_schedule_flip();
		}
	...
		spin_unlock(uart_port->lock);
	}

So it seems that flip buffers are for RX routines. Is this right?

Thus, if foo_irq_handler()->tty_flip_buffer_push() raced with something, then
it must have been another IRQ that appended data to the same uart_port flip
buffer. Which, probably, should not happen. There should be no other race
conditions. Correct?

So I'm still wondering if we can safely change this

	foo_irq_handler()
	{
	...	spin_lock(uart_port->lock);

		foo_TX_chars();
		tty_flip_buffer_push();  // tty_schedule_flip()
	...
		spin_unlock(uart_port->lock);
	}

to this

	foo_irq_handler()
	{
	...	spin_lock(uart_port->lock);

		foo_TX_chars();
	...
		spin_unlock(uart_port->lock);

		tty_flip_buffer_push();  // tty_schedule_flip()
	}

Alan, Jiri, can we do this?

> So far, the best (and realistic?) idea seems to be switching to
> printk_deferred() context when port->lock is taken. It would
> be a well defined pattern that people might get used to.

Hmm. Not sure, maybe I'm missing something. In this particular case we
don't call printk() under port->lock, so it doesn't matter if we are in
"normal" printk mode or in some "safe" printk mode. What we have is:

	UART port->lock --> WQ pool->lock

Which is OK, and port->lock is sort of "innocent".

It's the stuff that we do under WQ pool->lock that hurts (deadlock).

	WQ pool->lock -> printk -> UART port->lock

If we want printk_deferred() / printk_safe() to help us here, then
we need to switch to printk_deferred() / printk_safe() every time
we take WQ pool->lock. Which is, basically, what I have already
suggested.

But I'd rather try to move tty_flip_buffer_push() out of uart_port->lock
scope [if possible], so we would break the
		uart_port->lock -> WQ pool->lock
dependency.

	-ss

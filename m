Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE9CC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 16:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18A8824728
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 16:31:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="onYzZRHB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18A8824728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933016AbeGCQbu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 12:31:50 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:39823 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932312AbeGCQbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 12:31:48 -0400
Received: by mail-pg0-f68.google.com with SMTP id n2-v6so1217608pgq.6
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 09:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pi9cmIziociMI2flXn+poqzfFoGnowHg/L8yCPGRgoM=;
        b=onYzZRHBzWep8TYrHZqq/FJ+T9MTEAyQKg+Q9VDvC+CLbJ1+EF0Mo9KV6WbG0KJiE/
         Icr1pcNfeWMkVW41/ZzKhnrxqsAM7Ju/m0KBsh2CepAsRLSsVywmzempIHc3HblZt7oK
         8JWFyPVK90t1yaPs7WQOcSbBXfioTkqwpHpl8BP6A1xmmcd7U5+4bzkWdX2RXJlYkqff
         vvP/RYG7E6AOjNGlIzJn388h6zOsEUiuF92zOJf7kpb+zdvN+u68ys5Kgz/ErbXCQMzZ
         zU/XDFpXWgZnmnB9WyVWoyWN30Nq4c9uIbRLWN/B77O0fQzIrAIc3UkEsLqM9zQzaCAH
         PaRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pi9cmIziociMI2flXn+poqzfFoGnowHg/L8yCPGRgoM=;
        b=KbbQ3mWcU+GcEhiiZvTa8u8T+2Ix/J0t/PuASvEvueeEkouSTad1CCqGX9VJv/E/pf
         XbkJHc4n038HjTxl8BM9fzLRUab+Cf8aW/L6RuKDw/6EylpDpjfmaJp8KdM7yxFqnqP5
         OISpNBZaAGDxGBQh0klnnxTkPFvGFuvbQE2jAYeSUObVan9ptlxVESRS/LfHNZ8U/+WP
         Afhn4dxBBsopclb23Td29UEnmpS+vUi4rLVQ4bOnLhwzJZYFEN5JMsEG4z60mxD8pNT6
         4AxZYsrWHRp17s/z/GpgauYiBJnAoiPYpv0KuhqTMMIC5mQqEk1esls6SwZBMAX5/wxD
         4gvA==
X-Gm-Message-State: APt69E3oL13Is3ad6Qc6Tc4nJsK87l8QHdetkbDkZPU7MleUeNbVvsJf
        OuEPJa+EoUhNtf7f2tMeklM=
X-Google-Smtp-Source: AAOMgpdi48S+5VUW53w3y2QbNUpNNCIlTCs0DuhYK+Sb5TnFn2ZIdUKNHgBuOAcO70SvDP1q+zBPVw==
X-Received: by 2002:a63:b74a:: with SMTP id w10-v6mr17751230pgt.266.1530635508136;
        Tue, 03 Jul 2018 09:31:48 -0700 (PDT)
Received: from localhost ([121.137.63.184])
        by smtp.gmail.com with ESMTPSA id u67-v6sm3769233pfi.30.2018.07.03.09.31.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 09:31:47 -0700 (PDT)
Date:   Wed, 4 Jul 2018 01:31:45 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Steven Rostedt <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: printk() from NMI backtrace can delay a lot
Message-ID: <20180703163145.GB391@tigerII.localdomain>
References: <bf037670-c647-b34a-486b-53ec3661b48e@i-love.sakura.ne.jp>
 <20180703043021.GA547@jagdpanzerIV>
 <20180703152944.GQ533219@devbig577.frc2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180703152944.GQ533219@devbig577.frc2.facebook.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Tejun

On (07/03/18 08:29), Tejun Heo wrote:
> Hello, Sergey.
> 
> On Tue, Jul 03, 2018 at 01:30:21PM +0900, Sergey Senozhatsky wrote:
> > Cc-ing Linus, Tejun, Andrew
> > [I'll keep the entire lockdep report]
> > 
> > On (07/02/18 19:26), Tetsuo Handa wrote:
> > [..]
> > > 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606834] swapper/0/0 is trying to acquire lock:
> > > 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606835] 00000000316e1432 (console_owner){-.-.}, at: console_unlock+0x1ce/0x8b0
> > > 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606840] 
> > > 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606841] but task is already holding lock:
> > > 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606842] 000000009b45dcb4 (&(&pool->lock)->rlock){-.-.}, at: show_workqueue_state+0x3b2/0x900
> > > 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606847] 
> > > 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606848] which lock already depends on the new lock.
> ...
> > But anyway. So we can have [but I'm not completely sure. Maybe lockdep has
> > something else on its mind] something like this:
> > 
> > 	CPU1					CPU0
> > 
> > 	#IRQ					#soft irq
> > 	serial8250_handle_irq()			wq_watchdog_timer_fn()
> > 	 spin_lock(&uart_port->lock)		 show_workqueue_state()
> > 	  serial8250_rx_chars()			   spin_lock(&pool->lock)
> > 	   tty_flip_buffer_push()		    printk()
> > 	    tty_schedule_flip()			     serial8250_console_write()
> > 	     queue_work()			      spin_lock(&uart_port->lock)
> > 	      __queue_work()
> > 	       spin_lock(&pool->lock)
> > 
> > We need to break the pool->lock -> uart_port->lock chain.
> > 
> > - use printk_deferred() to show WQs states [show_workqueue_state() is
> >   a timer callback, so local IRQs are enabled]. But show_workqueue_state()
> >   is also available via sysrq.
> > 
> > - what Alan Cox suggested: use spin_trylock() in serial8250_console_write()
> >   and just discard (do not print anything on console) console->writes() that
> >   can deadlock us [uart_port->lock is already locked]. This basically means
> >   that sometimes there will be no output on a serial console, or there
> >   will be missing line. Which kind of contradicts the purpose of print
> >   out.
> > 
> > We are facing the risk of no output on serial consoles in both case. Thus
> > there must be some other way out of this.
> 
> show_workqueue_state() is only used when something is already horribly
> broken or when invoked through sysrq.

Tetsuo is hammering sysrq for fun and profit ;)

> I'm not sure it's worthwhile to make invasive changes to avoid lockdep
> warnings.  If anything, we should make show_workqueue_state() avoid
> grabbing pool->lock (e.g. use trylock and fallback to probe_kernel_reads
> if that fails).  I'm a bit skeptical how actually useful that'd be tho.

So, I agree.

Another option *possibly* could be...

... maybe we can brake another lock dependency. I don't quite understand,
and surely I'm missing something here, why serial driver call
tty_flip_buffer_push() under uart_port->lock. E.g.

	serial_driver_handle_irq()
	{
		spin_lock(uart_port->lock);

		.. TX() / RX()

		tty_flip_buffer_push(uart_port->tty_port);
		spin_unlock(uart_port->lock);
	}

it might be the case that we can do

	serial_driver_handle_irq()
	{
		spin_loc(uart_port->lock);

		.. TX / RX

		spin_unlock(uart_port->lock);

		tty_flip_buffer_push(uart_port->tty_port);
	}

This should break this chain

	uart_port->lock -> pool->lock   // -> sheduler/etc.


Can we do it? What am I missing?

	-ss

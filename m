Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A89C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 00:53:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 960BB208A5
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 00:53:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ke6aiY/C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 960BB208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937175AbeFSAxR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 20:53:17 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36889 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937115AbeFSAxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 20:53:13 -0400
Received: by mail-pf0-f194.google.com with SMTP id y5-v6so9030539pfn.4;
        Mon, 18 Jun 2018 17:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VsoFhXMw09AO7XYWBrCsA6oMZaJw/cdYYkFkjNp7uaw=;
        b=ke6aiY/C+cU5c1H+HQVoRIYu6bK/jFOsZknWU1gHd1ZtdNg/zbsxktJhJoGSDV2vIU
         7xaVD9qOc/UF6iNJDgJsG38QFZRxVBCsfEejufoPdKRP8tBuZ/dU3dEQyOWeMxQ0u+BC
         E/H5DyCPSBgmNrGemBywFzSMsgbKzASDWyJDUVdmjyc4fEyk0QPwtZbG2JWk9wcKrxeb
         ltmER4qgmnNrwf9kRDJNh3YLW+7Ow8/6Icnm/1zrBj1uOLYK8EzPt6OCX2fNJCH1e9L1
         9lKodu/IAXCH+jknKFBVhjbzQQHhoRAe9zyp0zmJYJa0/j6M7XqsQkHsIHbwBk94L4lO
         H6pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VsoFhXMw09AO7XYWBrCsA6oMZaJw/cdYYkFkjNp7uaw=;
        b=o4cTfe6UMpgTyhtSVfN3WOfycKiKrwmn4pPxwzCtd4cvyKyJ38ru8cAWKqTS2sSbyK
         FY0BttmRKDgrSzTeLrPofuPRQ8Q3q1ZJ9Kc6CHBgnTiljSwBU3Eh3GouVVi3nvgRlbHb
         dsL+OMazDYJukOKRTE7fETsT+Mu+6dXHuYoRuji96ou5twYzw8brpmdMsfrFyWzH4MjY
         KMapFFgGrXYENdrgTGf5m4H+FsEvNtBIlo1wvhVFLnWGDnuALn08lq23qDtgKcf8XosB
         ZLa+HNM73Lb5thH5ZsRq4eQR2FL8H4bd6zQT977Zo4ITynoDA3vkDY3/E838rg67TvBE
         JaqA==
X-Gm-Message-State: APt69E16ekCNSKC7oPRfoiZRi8J9mbQ1PGrsU55tOguk6uI6akIftRH6
        D5CdPP2e5MFzN3l50qH/deE=
X-Google-Smtp-Source: ADUXVKLqyoYpvfRPFOG1tY0Jyvh61ht8FY61a9Erj0NI3M4QWmCgPYS2v2KJOMmQ4Y2PKi3AKpEOHA==
X-Received: by 2002:a63:7f15:: with SMTP id a21-v6mr12861107pgd.21.1529369592917;
        Mon, 18 Jun 2018 17:53:12 -0700 (PDT)
Received: from localhost ([175.223.26.106])
        by smtp.gmail.com with ESMTPSA id p22-v6sm34961337pfj.166.2018.06.18.17.53.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Jun 2018 17:53:11 -0700 (PDT)
Date:   Tue, 19 Jun 2018 09:53:08 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC][PATCH 0/6] Use printk_safe context for TTY and UART port
 locks
Message-ID: <20180619005308.GA405@jagdpanzerIV>
References: <20180615093919.559-1-sergey.senozhatsky@gmail.com>
 <20180618143818.50b2f2f9@alans-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180618143818.50b2f2f9@alans-desktop>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for taking a look!

On (06/18/18 14:38), Alan Cox wrote:
> > It doesn't come as a surprise that recursive printk() calls are not the
> > only way for us to deadlock in printk() and we still have a whole bunch
> > of other printk() deadlock scenarios. For instance, those that involve
> > TTY port->lock spin_lock and UART port->lock spin_lock.
> 
> The tty layer code there is not re-entrant. Nor is it supposed to be

Could be.

But at least we have circular locking dependency in tty,
see [1] for more details:

  tty_port->lock  => uart_port->lock

   CPU0
   tty
    spin_lock(&tty_port->lock)
     printk()
      call_console_drivers()
       foo_console_write()
        spin_lock(&uart_port->lock)

Whereas we normally have

  uart_port->lock => tty_port->lock

   CPU1
   IRQ
    foo_console_handle_IRQ()
     spin_lock(&uart_port->lock)
      tty
       spin_lock(&tty_port->lock)


If we switch to printk_safe when we take tty_port->lock then we
remove the printk->uart_port chain from the picture.

> > So the idea of this patch set is to take tty_port->lock and
> > uart_port->lock from printk_safe context and to eliminate some
> > of non-recursive printk() deadlocks - the ones that don't start
> > in printk(), but involve console related locks and thus eventually
> > deadlock us in printk(). For this purpose the patch set introduces
> > several helper macros:
> 
> I don't see how this helps - if you recurse into the uart code you are
> still hitting the paths that are unsafe when re-entered. All you've done
> is messed up a pile of locking code on critical performance paths.
> 
> As it stands I think it's a bad idea.

The only new thing is that we inc/dec per-CPU printk context
variable when we lock/unlock tty/uart port lock:

	printk_safe_enter() -> this_cpu_inc(printk_context);
	printk_safe_exit() -> this_cpu_dec(printk_context);

How does this help? Suppose we have the following

       IRQ
       foo_console_handle_IRQ()
        spin_lock(&uart_port->lock)
         uart_write_wakeup()
          tty_port_tty_wakeup()
           tty_port_default_wakeup()
            printk()
             call_console_drivers()
              foo_console_write()
               spin_lock(&uart_port->lock)  << deadlock

If we take uart_port lock from printk_safe context, we remove the
   printk->call_console_drivers->foo_console_write->spin_lock
chain. Because printk() output will endup in a per-CPU buffer,
which will be flushed later from irq_work. So the whole thing
becomes:

       IRQ
       foo_console_handle_IRQ()
        printk_safe_enter()
        spin_lock(&uart_port->lock)
         uart_write_wakeup()
          tty_port_tty_wakeup()
           tty_port_default_wakeup()
            printk()                           << we don't re-enter foo_console_driver
                                               << from printk() anymore
             printk_safe_log_store()
              irq_work_queue
        spin_unlock(&uart_port->lock)
        printk_safe_exit()
       iret

       #flush per-CPU buffer
       IRQ
        printk_safe_flush_buffer()
         vprintk_deferred()

> > Of course, TTY and UART port spin_locks are not the only locks that
> > we can deadlock on. So this patch set does not address all deadlock
> > scenarios, it just makes a small step forward.
> > 
> > Any opinions?
> 
> The cure is worse than the disease.

Because of this_cpu_inc(printk_context) / this_cpu_dec(printk_context)?
May be. That's why I put RFC :)

> The only case that's worth looking at is the direct polled console code
> paths. The moment you touch the other layers you add essentially never
> needed code to hot paths.
> 
> Given printk nowdays is already somewhat unreliable with all the perf
> related changes, and we have other good debug tools I think it would be
> far cleaner to have some kind of
> 
> 
> 	if (spin_trylock(...)) {
> 		console_defer(buffer);
> 		return;
> 	}
> 
> helper layer in the printk/console logic, at least for the non panic/oops
> cases.

spin_trylock() in every ->foo_console_write() callback?
This still will not address the reported deadlock [1].

[1] lkml.kernel.org/r/000000000000d557e7056e1c7a01@google.com

	-ss

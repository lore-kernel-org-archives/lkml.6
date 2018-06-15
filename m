Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 64B09C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 09:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1010C208B2
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 09:40:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AH+osUGr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1010C208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755943AbeFOJkV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 05:40:21 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:39248 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755750AbeFOJkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 05:40:18 -0400
Received: by mail-pl0-f68.google.com with SMTP id f1-v6so5077443plt.6;
        Fri, 15 Jun 2018 02:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=FxiyMrsLU61PJtXOHyVBAkeXXxlbqeE2Cp3oknnLxvE=;
        b=AH+osUGrlf/2HB/+jNGHIRkulCeAD6QabAU8nUpBstRCdmHHNOyBXGQVVAHgRywWFf
         ys3U/7UAweggTz0VdO1lgs3Qzfa/39KP1VWyTQLYqK6wvfGgYzOW2UhmNOviuW/ud1EC
         usbsKlC/2rP76hSW4O73zuWkzQN9QCNFFCiCpBKepTV1HGI8GLJ2PQn07xYeEVBDD6K4
         9iXXwueGB3nf9ecotyIsofBEgeH+G61OA4dJ5kbcCqnl7hC15p5omBc5ec8r8oTvWrVx
         h5Fs1hLU1ZH6JPvlu8EpVOF0WTZGQREjwO8bu6/TPyVrUXH+Hn5GNwgS9WmJlQEkAgzm
         580Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FxiyMrsLU61PJtXOHyVBAkeXXxlbqeE2Cp3oknnLxvE=;
        b=VOLpA6ctCrF1D3z6a+DhRTeO6POuLLB7+L4wCNJU1uw0g6PekF5eTB0+7APh+BsbEh
         nFUeSEHTIohF8wmciuvokaHsq/a9geAYnC1WsBnidrnu9w93PGUgNM+HhAs231sJFpKs
         KSr82JiEfrjuH8b39EfJK70FVMw81dzaDBKxn7N2QEx0A9uz8A9ilZJZrzgDs+wMSJxR
         sZgUZwG7bSC05PcbaecXpDKO5rbLmKZAsxIYrm6S6cEtrDEk7PX1RO6IHG2JPKlwv6eG
         W0vxJ8XzlORRpiI1+kEreEl1lM45guZu5jfS57n00PGU4wt0L6Aiq9LLtJunXdnIy077
         g44Q==
X-Gm-Message-State: APt69E3Q/8wc4sUL8oXfiIydWwSr2wUjAn6JhS2sXzqDoYojCP3lGbjK
        AM6Vw23BWEUsTW30rxBKd3Q=
X-Google-Smtp-Source: ADUXVKJS0CGXiOMTw6mhKpuBdDbs2ZZzJnvjVXgNEdxAAx7nQCtgwPdh40h4xaAJNaUOUcFYNKv1Mw==
X-Received: by 2002:a17:902:5945:: with SMTP id e5-v6mr1204316plj.64.1529055617816;
        Fri, 15 Jun 2018 02:40:17 -0700 (PDT)
Received: from localhost.localdomain ([175.223.48.179])
        by smtp.gmail.com with ESMTPSA id p1-v6sm11628551pfh.58.2018.06.15.02.40.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Jun 2018 02:40:16 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: [RFC][PATCH 0/6] Use printk_safe context for TTY and UART port locks
Date:   Fri, 15 Jun 2018 18:39:13 +0900
Message-Id: <20180615093919.559-1-sergey.senozhatsky@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hello,

	RFC

	printk_safe buffers help us to avoid printk() deadlocks that are
caused by recursive printk() calls, e.g.

printk()
 vprintk_emit()
 spin_lock(&logbuf_lock)
  vsnprintf()
   format_decode()
    warn_slowpath_fmt()
     vprintk_emit()
     spin_lock(&logbuf_lock)   << deadlock

It doesn't come as a surprise that recursive printk() calls are not the
only way for us to deadlock in printk() and we still have a whole bunch
of other printk() deadlock scenarios. For instance, those that involve
TTY port->lock spin_lock and UART port->lock spin_lock.

syzbot recently hit one of such scenarios [1]:

 CPU0                                     CPU1
 tty_ioctl()
  spin_lock(&tty_port->lock)              IRQ
   kmalloc()                              foo_console_handle_IRQ()
    printk()                               spin_lock(&uart_port->lock)
     call_console_drivers()                 tty_wakeup()
      foo_console_driver()
       spin_lock(&uart_port->lock)           spin_lock(&tty_port->lock)

So the idea of this patch set is to take tty_port->lock and
uart_port->lock from printk_safe context and to eliminate some
of non-recursive printk() deadlocks - the ones that don't start
in printk(), but involve console related locks and thus eventually
deadlock us in printk(). For this purpose the patch set introduces
several helper macros:

- uart_port_lock_irq() / uart_port_unlock_irq()
  uart_port_lock_irqsave() / uart_port_unlock_irqrestore()

  To lock/unlock uart_port->lock spin_lock from printk_safe
  context.

And

- tty_port_lock_irq() / tty_port_unlock_irq()
  tty_port_lock_irqsave() / tty_port_unlock_irqrestore()

  To lock/unlock tty_port->lock spin_lock from printk_safe
  context.

I converted tty/pty/serial_core to use those helper macros.
Now, the boring part is that all serial console drivers must be converted
to use uart_port_lock macros. In this patch set I only modified the 8250
serial console [since this is RFC patch set], but if the patch set will
not see a lot of opposition I can do so for the rest of serial consoles
[or ask the maintainers to help me out]. The conversion is pretty
simple.

It would be great if we could "forbid" direct tty_port->lock and
uart_port->lock manipulation [I don't know, rename them to ->__lock]
and enforce uart_port_lock/tty_port_lock macros usage.

There are some other cases [2] that we can handle with this
patch set. For instance:

   IRQ
   spin_lock(&uart_port->lock)
    tty_wakeup()
     tty_port_default_wakeup()
      tty_port_tty_get()
       refcount_inc()
        WARN_ONCE()
         printk()
          call_console_drivers()
           foo_console_driver()
            spin_lock(&uart_port->lock)               << deadlock

Of course, TTY and UART port spin_locks are not the only locks that
we can deadlock on. So this patch set does not address all deadlock
scenarios, it just makes a small step forward.

Any opinions?

[1]: lkml.kernel.org/r/00000000000087008b056df8fbb3@google.com
[2]: lkml.kernel.org/r/20180607051019.GA10406@jagdpanzerIV

Sergey Senozhatsky (6):
  printk: move printk_safe macros to printk header
  tty: add tty_port locking helpers
  tty/pty: switch to tty_port helpers
  serial: add uart port locking helpers
  serial: switch to uart_port locking helpers
  tty: 8250: switch to uart_port locking helpers

 drivers/tty/pty.c                   |   4 +-
 drivers/tty/serial/8250/8250_core.c |   8 +-
 drivers/tty/serial/8250/8250_dma.c  |   4 +-
 drivers/tty/serial/8250/8250_port.c |  74 +++++++++----------
 drivers/tty/serial/serial_core.c    | 109 ++++++++++++++--------------
 drivers/tty/tty_port.c              |  38 +++++-----
 include/linux/printk.h              |  40 ++++++++++
 include/linux/serial_core.h         |  35 +++++++++
 include/linux/tty.h                 |  24 ++++++
 kernel/printk/internal.h            |  37 ----------
 10 files changed, 218 insertions(+), 155 deletions(-)

-- 
2.17.1


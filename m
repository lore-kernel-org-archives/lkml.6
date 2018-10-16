Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90086C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 05:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D2382054F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 05:05:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Br9kMAcq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D2382054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbeJPMxk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 08:53:40 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37467 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727678AbeJPMxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 08:53:40 -0400
Received: by mail-pg1-f193.google.com with SMTP id c10-v6so10243015pgq.4;
        Mon, 15 Oct 2018 22:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ds86N7pYnLGBZvXTOIR+hl8aWrfLHPS4bIIhZSc2aKY=;
        b=Br9kMAcqXgYHr/Ht9lE9d7++bTPaYW04ZFFeiGnKPawUxKUo6TCl25xXo5jq6IdYBb
         Lv3PDJbP9xwPC4Zx9mFZPEFuKwlFS4ZD1ieA0IRC78RyacOlrxk1MpNlDejvnUYGY1bJ
         L63YFQu6vnKkcH4FU/WQ7oFK8tSQCbXI6Fw1GMTH98n5r3+2ugfINod/8zYzpjnMT5G2
         oANV4NDqTZj3Q+eqrwPOXsiDTsmr8/b6vbjUiznIh5uM9on8pbyaRjrFqcQb7E3FeM+C
         A2NvsnZHgLNaPsLnTBSW04JAkUtnbnn3kr/Vs4g173rZhGv7l2JYoTSXpcG+B9DOqMvS
         rRjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ds86N7pYnLGBZvXTOIR+hl8aWrfLHPS4bIIhZSc2aKY=;
        b=co8KdCTlCW6TYB02jVpduJaD8e+Cc6lTYqPbZgpwwu6KIisZcryHLC90a9yrfggmAo
         SxuRsL+ZM0UjpnU4jjz0ptSfn7iIJYB2RASHz5bQ+rOFyEjOD6wmg3O0J3JQ9a/tOrkf
         b3Q1fxC/Ods4EOcC8f5+4de3tXf38Gq1EnltkJy3M7x+nxBqT0wnhJyLuW2KEbrzutPL
         6X+DNy7ZNdfsTjshoPwzEvT1QC9qDCjVin+ncTTI5eJ0Bq1l6n5LoKK2KLU/h4ndO0uz
         nggXutZe2j8Hecthwm5VUVJBBAt6om7U41HppW/61DupgHNhNNaztsGBoVv07nuUun/U
         KeHg==
X-Gm-Message-State: ABuFfoghwKfiR6+vMv3bEYw9k0FqUUtbT/D5Wv2cMm23a1HC2jxUxIoD
        RUoNfaYg4QYjCCk0PXOIXTlCcRMa
X-Google-Smtp-Source: ACcGV60mRG/lXV20FStxm4ezJTOAkiuaebm60yK8Q3GehrMhxzPwq9vf1OtcQ+5WrBNpEiK19+ND4g==
X-Received: by 2002:a63:6286:: with SMTP id w128-v6mr18377507pgb.72.1539666304138;
        Mon, 15 Oct 2018 22:05:04 -0700 (PDT)
Received: from localhost.localdomain ([175.223.10.117])
        by smtp.gmail.com with ESMTPSA id e131-v6sm19353225pfc.52.2018.10.15.22.04.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 22:05:03 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Wang <wonderfly@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Jiri Slaby <jslaby@suse.com>,
        Peter Feiner <pfeiner@google.com>,
        linux-serial@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: [RFC][PATCHv2 3/4] serial: introduce uart_port locking helpers
Date:   Tue, 16 Oct 2018 14:04:27 +0900
Message-Id: <20181016050428.17966-4-sergey.senozhatsky@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016050428.17966-1-sergey.senozhatsky@gmail.com>
References: <20181016050428.17966-1-sergey.senozhatsky@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch introduces several macros which should make serial console
drivers less printk() deadlock prone.

There are several console driver entry points so we are looking at
several slightly different deadlock scenarios.

- The first entry point is console ->write() callback, which we call
  from printk(). A possible deadlock scenario there is:

  CPU0
	<NMI>
	spin_lock_irqsave(&port->lock, flags)      << deadlock
	serial_foo_write()
	call_console_drivers()
	console_unlock()
	console_flush_on_panic()
	panic()
	<NMI/>
	spin_lock_irqsave(&port->lock, flags)
	serial_foo_write()
	call_console_drivers()
	console_unlock()
	printk()
	...

  ->write() callback, generally speaking, must be re-entrant in two cases:
   1) sysrq
   2) panic (oops_in_progress)

  And this is what uart_port_lock_for_printk()/uart_port_unlock_after_printk()
  macros are for.

  Usage example:

	static serial_foo_write(...)
	{
		struct uart_port *port;
		unsigned long flags;
		bool locked;

		uart_port_lock_for_printk(port, flags, locked);
		uart_console_write(port, s, count, serial_foo_putchar);
		uart_port_unlock_after_printk(port, flags, locked);
	}

  Some of the serial drivers already use _some sort_ of
  uart_port_lock_for_printk(), some are not panic() re-entrant. This
  should address the issue.

- The rest (of entry points) requires a bit different handling.
  Let's take a look at the following backtrace:

  	CPU0
	<IRQ>
	spin_lock_irqsave(&port->lock, flags)      << deadlock
	serial_foo_write()
	call_console_drivers()
	console_unlock()
	printk()
	__queue_work()
	tty_flip_buffer_push()
	spin_lock_irqsave(&port->lock, flags)
	serial_foo_handle_IRQ()
	<IRQ/>

  Serial drivers invoke tons of core kernel functions - WQ, MM, etc. All
  of which may printk() in various cases. So we can't really just
  "remove those printk-s". The simples way to address this seems to be
  PRINTK_SAFE_CONTEXT_MASK.

  printk_safe() is a special printk() mode, which redirects recursive
  printk()-s to a secondary (per-CPU) buffer; so we don't re-enter
  printk() and serial console driver. The secondary (per-CPU) buffer is
  flushed and printed to the consoles later, from a safe context, when
  we know that we are not in printk()-recursion anymore.

  And this is what uart_port_lock_*()/uart_port_unlock_*() macros are
  for. With uart_port_lock_irqsave() the previous example would turn
  into:

	CPU0
	<IRQ>
	irq_work_queue()
	printk_safe_log_store()
	printk()
	__queue_work()
	tty_flip_buffer_push()
	uart_port_lock_irqsave(port, flags)
	serial_foo_handle_IRQ()
	<IRQ/>

  As of now, no consoles are re-entrant when printk() initiated by
  console's driver IRQ handler. This macro should address the issue.

Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
---
 include/linux/serial_core.h | 48 +++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 047fa67d039b..acc6966fea8e 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -266,6 +266,54 @@ struct uart_port {
 	void			*private_data;		/* generic platform data pointer */
 };
 
+#define uart_port_lock_irq(p)						\
+	do {								\
+		printk_safe_enter_irq();				\
+		spin_lock(&(p)->lock);					\
+	} while (0)
+
+#define uart_port_unlock_irq(p)					\
+	do {								\
+		spin_unlock(&(p)->lock);				\
+		printk_safe_exit_irq();					\
+	} while (0)
+
+#define uart_port_lock_irqsave(p, flags)				\
+	do {								\
+		printk_safe_enter_irqsave(flags);			\
+		spin_lock(&(p)->lock);					\
+	} while (0)
+
+#define uart_port_unlock_irqrestore(p, flags)				\
+	do {								\
+		spin_unlock(&(p)->lock);				\
+		printk_safe_exit_irqrestore(flags);			\
+	} while (0)
+
+#if defined(CONFIG_SERIAL_CORE_CONSOLE) || defined(SUPPORT_SYSRQ)
+#define uart_port_in_sysrq(p)		p->sysrq
+#else
+#define uart_port_in_sysrq(p)		0
+#endif
+
+#define uart_port_lock_for_printk(p, flags, locked)			\
+	do {								\
+		locked = true;						\
+		if (uart_port_in_sysrq(p))				\
+			locked = false;					\
+		else if (oops_in_progress)				\
+			locked = spin_trylock_irqsave(&(p)->lock,	\
+						      flags);		\
+		else							\
+			spin_lock_irqsave(&(p)->lock, flags);		\
+	} while (0)
+
+#define uart_port_unlock_after_printk(p, flags, locked)		\
+	do {								\
+		if (locked)						\
+			spin_unlock_irqrestore(&(p)->lock, flags);	\
+	} while (0)
+
 static inline int serial_port_in(struct uart_port *up, int offset)
 {
 	return up->serial_in(up, offset);
-- 
2.19.1


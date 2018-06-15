Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 6CCB1C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 09:40:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 232FF208B2
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 09:40:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YV788qNz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 232FF208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756144AbeFOJku (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 05:40:50 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33820 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755727AbeFOJkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 05:40:47 -0400
Received: by mail-pg0-f68.google.com with SMTP id q4-v6so4205266pgr.1;
        Fri, 15 Jun 2018 02:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PT83TKBpCznvBe2B2xp5bAwXHF0jUpSgjjrcexvnRXM=;
        b=YV788qNzrxDvwLWp5cQYU2mGgOHDuiWmNBDS3/3BK8HLy6C5KBsqWBVzce8vQ+6/f2
         7WAHBNnZvVeGpeG0mMbRKkf67w2G7+hri3g0zmI56yZXwrMYqX8lOS2aR15jQe5Mwu1+
         MAzRIfADl0LfNlh5/v2bX7tYcWCvcixjfmG23obNPuciHCjvxgoT7SImOAUz37W2cKd7
         z5ZUaIOCqW2+46CJ8KrvushItphrP5ykEOlOQ23fBBTdJr0NbTYcuTWw9fHoSo2KDjP3
         vLM/u4noPAnBYBu7xrPLezjxO1gN0aIIgzSLaQCSuAFXAUFD1+OzXkMyUvg1B93DKY79
         /4WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PT83TKBpCznvBe2B2xp5bAwXHF0jUpSgjjrcexvnRXM=;
        b=BK7Ggy3hTj+qwJBXP7c/YjOFyeb0/PTLaTcxgJi04OCtaAaopVSbfwekIo1yutPh6f
         IDroGtW6c+AYcGP3BZl6ORWwJCpV3u2967YuRW4lOoDF1cbkm3JmyusJ3fBum3F5RbVG
         /bZy4BoK+kOxTQ3qmN4D0YaiUZq4miYIGnLRkoOBcVbNpFzhd2VrYAD6Iu4jsWLd7lfZ
         dPFfnMpWmA4IHK68+Q3I5y0s2yRGPPTuys96DBnIyh/FBuawtL5y+//doCcXyM50UFgZ
         6+Z08QhaccQ5eT8uRMgjfWdFSzxw3+8qdPMyeinUnJNOZC1D4aSFuGbmH0XZB94P+SQ6
         guvw==
X-Gm-Message-State: APt69E3HFBCOAFA7WP4zdTAyJDKeeZwPljbHpcVpBV/v22rQ0vmPf8gz
        I1EslsRIojuAQ4XA5+DWOK4=
X-Google-Smtp-Source: ADUXVKLAmdAzOJa61VBwkgBCluIjQ4x55O1Niury7oOsaFGCrYHBbX4QysBZxojlHOlijntGXfW0dg==
X-Received: by 2002:a63:6e44:: with SMTP id j65-v6mr934402pgc.14.1529055646569;
        Fri, 15 Jun 2018 02:40:46 -0700 (PDT)
Received: from localhost.localdomain ([175.223.48.179])
        by smtp.gmail.com with ESMTPSA id p1-v6sm11628551pfh.58.2018.06.15.02.40.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Jun 2018 02:40:45 -0700 (PDT)
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
Subject: [RFC][PATCH 4/6] serial: add uart port locking helpers
Date:   Fri, 15 Jun 2018 18:39:17 +0900
Message-Id: <20180615093919.559-5-sergey.senozhatsky@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180615093919.559-1-sergey.senozhatsky@gmail.com>
References: <20180615093919.559-1-sergey.senozhatsky@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UART port spin_lock is one of the locks that can cause a
printk-recursion deadlock, thus we need to lock it from
printk_safe context. An example of a possible deadlock:

   IRQ
   foo_console_handle_IRQ()
    spin_lock(&uart_port->lock)
     tty_wakeup()
      printk()
       call_console_drivers()
        foo_console_write()
         spin_lock(&uart_port->lock)  << deadlock

This patch adds uart_port->lock helper macros which take care
of printk_safe context and redirect potentially unsafe printk()
calls to per-CPU buffers, which we flush later from safe a
context. The helper macros will turn the above mentioned deadlock
scenario into:

   IRQ
   foo_console_handle_IRQ()
    printk_safe_enter()
    spin_lock(&uart_port->lock)
     tty_wakeup()
      printk()
       printk_safe_log_store()
        irq_work_queue()
    spin_unlock(&uart_port->lock)
    printk_safe_exit()
   iret

   IRQ
    printk_safe_flush_buffer()
     vprintk_deferred()

Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
---
 include/linux/serial_core.h | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 06ea4eeb09ab..deb464520946 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -256,6 +256,41 @@ struct uart_port {
 	void			*private_data;		/* generic platform data pointer */
 };
 
+#define uart_port_lock_irq(lock)				\
+	do {							\
+		printk_safe_enter_irq();			\
+		spin_lock(lock);				\
+	} while (0)
+
+#define uart_port_unlock_irq(lock)				\
+	do {							\
+		spin_unlock(lock);				\
+		printk_safe_exit_irq();				\
+	} while (0)
+
+#define uart_port_lock_irqsave(lock, flags)			\
+	do {							\
+		printk_safe_enter_irqsave(flags);		\
+		spin_lock(lock);				\
+	} while (0)
+
+#define uart_port_trylock_irqsave(lock, flags)			\
+	({							\
+		int locked;					\
+								\
+		printk_safe_enter_irqsave(flags);		\
+		locked = spin_trylock(lock);			\
+		if (!locked)					\
+			printk_safe_exit_irqrestore(flags);	\
+		locked;						\
+	})
+
+#define uart_port_unlock_irqrestore(lock, flags)		\
+	do {							\
+		spin_unlock(lock);				\
+		printk_safe_exit_irqrestore(flags);		\
+	} while (0)
+
 static inline int serial_port_in(struct uart_port *up, int offset)
 {
 	return up->serial_in(up, offset);
-- 
2.17.1


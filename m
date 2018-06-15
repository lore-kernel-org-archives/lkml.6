Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 64D69C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 09:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF827208B2
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 09:41:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rA2gNsxK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF827208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756172AbeFOJk6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 05:40:58 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:41480 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756157AbeFOJky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 05:40:54 -0400
Received: by mail-pg0-f67.google.com with SMTP id l65-v6so4195287pgl.8;
        Fri, 15 Jun 2018 02:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SnxyuQmSc0KFAW5p9FQO6nqEQP9ykR3kcnJZ0R7vRjA=;
        b=rA2gNsxKfRjQbwc+k5IYjUpni5Ara2hPLmTVeqDnsR21wd5I+Ccmx4NWICaY0xJEkF
         h4biWZv9SSzaedlKKPq1KUh7qwjCXhM0UYXJqPqDarx7hVI3eULn+aIL5wNImSgdSUVq
         7vPv+Zfg/F7+jPEHc7dLJw7HZ8RqUDzbV0deM55rSpMhetFwCKIh0zIyiUnFcF62njUg
         22CUgDJJsrlYFplCefZv7UbXo0UwZi9eFZsubtVmNSE0TSFTLMSwk4ObTpvpCOoB8jUI
         uPBS0LZJKu0A0Nv460Xymowbb2wt0ZKaTQGCBZWP1kWphNxmAtYVTMNbApO1idOAZV3f
         IHPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SnxyuQmSc0KFAW5p9FQO6nqEQP9ykR3kcnJZ0R7vRjA=;
        b=TrLWp2FMKG4rMeg0nWZI2AmculF5DV3U8V++KYuNZ4F5T0bmYYZ8Dyc5heszxX+NeS
         fWTWEQG3p1BxA8H1WHwwkptJ/P5xxCXHlOgHdf+MCjH8PN8BoFivcm/rFzLuipPnzG8b
         HCMe+VRP4GuRgog1YH/lRLrZZSVLp8RermOzb7MjxPVIUsc7rllK9qxab5prbisWSXEa
         vY8NXDMhZ+0V4cStoDRCrunkIRhBAe3aSRgiuE0WTM2+WoDnr8mWA7Ldi4aZoAabEk0N
         6M/1wK44l3wnOyUIwsaK52gjgdZzTo4QWswGC8M7B6KOMBJ9sIjU3VcUQchbDQ538eth
         SPqA==
X-Gm-Message-State: APt69E1iHdPyKWCaifurCdClx74qnyFFghNkGtHCICl46CJBND1wM2ir
        +MbxeykjCRLMmzaylc0QW3Y=
X-Google-Smtp-Source: ADUXVKIrABuRzWpH5FYuUFJBl8c/mD6RnveavgHficnutzR+TJVNZqZkDBZKj6d9IaGOBGB5N8fSPQ==
X-Received: by 2002:a63:89c2:: with SMTP id v185-v6mr896751pgd.196.1529055653422;
        Fri, 15 Jun 2018 02:40:53 -0700 (PDT)
Received: from localhost.localdomain ([175.223.48.179])
        by smtp.gmail.com with ESMTPSA id p1-v6sm11628551pfh.58.2018.06.15.02.40.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Jun 2018 02:40:52 -0700 (PDT)
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
Subject: [RFC][PATCH 5/6] serial: switch to uart_port locking helpers
Date:   Fri, 15 Jun 2018 18:39:18 +0900
Message-Id: <20180615093919.559-6-sergey.senozhatsky@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180615093919.559-1-sergey.senozhatsky@gmail.com>
References: <20180615093919.559-1-sergey.senozhatsky@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not directly lock/unlock uart_port->lock, but use uart_port_lock
helper macros.

The patch also renames serial_core internal macros uart_port_lock()
and uart_port_unlock() to uart_port_ref_lock() and to
uart_port_unlock_deref() correspondingly.

Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
---
 drivers/tty/serial/serial_core.c | 101 ++++++++++++++++---------------
 1 file changed, 51 insertions(+), 50 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 48b3377d7f77..48624ca485e5 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -65,19 +65,20 @@ static inline void uart_port_deref(struct uart_port *uport)
 		wake_up(&uport->state->remove_wait);
 }
 
-#define uart_port_lock(state, flags)					\
+#define uart_port_ref_lock(state, flags)				\
 	({								\
 		struct uart_port *__uport = uart_port_ref(state);	\
 		if (__uport)						\
-			spin_lock_irqsave(&__uport->lock, flags);	\
+			uart_port_lock_irqsave(&__uport->lock, flags);	\
 		__uport;						\
 	})
 
-#define uart_port_unlock(uport, flags)					\
+#define uart_port_unlock_deref(uport, flags)				\
 	({								\
 		struct uart_port *__uport = uport;			\
 		if (__uport) {						\
-			spin_unlock_irqrestore(&__uport->lock, flags);	\
+			uart_port_unlock_irqrestore(&__uport->lock,	\
+						    flags);		\
 			uart_port_deref(__uport);			\
 		}							\
 	})
@@ -109,10 +110,10 @@ static void uart_stop(struct tty_struct *tty)
 	struct uart_port *port;
 	unsigned long flags;
 
-	port = uart_port_lock(state, flags);
+	port = uart_port_ref_lock(state, flags);
 	if (port)
 		port->ops->stop_tx(port);
-	uart_port_unlock(port, flags);
+	uart_port_unlock_deref(port, flags);
 }
 
 static void __uart_start(struct tty_struct *tty)
@@ -130,9 +131,9 @@ static void uart_start(struct tty_struct *tty)
 	struct uart_port *port;
 	unsigned long flags;
 
-	port = uart_port_lock(state, flags);
+	port = uart_port_ref_lock(state, flags);
 	__uart_start(tty);
-	uart_port_unlock(port, flags);
+	uart_port_unlock_deref(port, flags);
 }
 
 static void
@@ -141,12 +142,12 @@ uart_update_mctrl(struct uart_port *port, unsigned int set, unsigned int clear)
 	unsigned long flags;
 	unsigned int old;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(&port->lock, flags);
 	old = port->mctrl;
 	port->mctrl = (old & ~clear) | set;
 	if (old != port->mctrl)
 		port->ops->set_mctrl(port, port->mctrl);
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(&port->lock, flags);
 }
 
 #define uart_set_mctrl(port, set)	uart_update_mctrl(port, set, 0)
@@ -499,7 +500,7 @@ static void uart_change_speed(struct tty_struct *tty, struct uart_state *state,
 	/*
 	 * Set modem status enables based on termios cflag
 	 */
-	spin_lock_irq(&uport->lock);
+	uart_port_lock_irq(&uport->lock);
 	if (termios->c_cflag & CRTSCTS)
 		uport->status |= UPSTAT_CTS_ENABLE;
 	else
@@ -521,7 +522,7 @@ static void uart_change_speed(struct tty_struct *tty, struct uart_state *state,
 		if (hw_stopped)
 			__uart_start(tty);
 	}
-	spin_unlock_irq(&uport->lock);
+	uart_port_unlock_irq(&uport->lock);
 }
 
 static int uart_put_char(struct tty_struct *tty, unsigned char c)
@@ -536,13 +537,13 @@ static int uart_put_char(struct tty_struct *tty, unsigned char c)
 	if (!circ->buf)
 		return 0;
 
-	port = uart_port_lock(state, flags);
+	port = uart_port_ref_lock(state, flags);
 	if (port && uart_circ_chars_free(circ) != 0) {
 		circ->buf[circ->head] = c;
 		circ->head = (circ->head + 1) & (UART_XMIT_SIZE - 1);
 		ret = 1;
 	}
-	uart_port_unlock(port, flags);
+	uart_port_unlock_deref(port, flags);
 	return ret;
 }
 
@@ -573,7 +574,7 @@ static int uart_write(struct tty_struct *tty,
 	if (!circ->buf)
 		return 0;
 
-	port = uart_port_lock(state, flags);
+	port = uart_port_ref_lock(state, flags);
 	while (port) {
 		c = CIRC_SPACE_TO_END(circ->head, circ->tail, UART_XMIT_SIZE);
 		if (count < c)
@@ -588,7 +589,7 @@ static int uart_write(struct tty_struct *tty,
 	}
 
 	__uart_start(tty);
-	uart_port_unlock(port, flags);
+	uart_port_unlock_deref(port, flags);
 	return ret;
 }
 
@@ -599,9 +600,9 @@ static int uart_write_room(struct tty_struct *tty)
 	unsigned long flags;
 	int ret;
 
-	port = uart_port_lock(state, flags);
+	port = uart_port_ref_lock(state, flags);
 	ret = uart_circ_chars_free(&state->xmit);
-	uart_port_unlock(port, flags);
+	uart_port_unlock_deref(port, flags);
 	return ret;
 }
 
@@ -612,9 +613,9 @@ static int uart_chars_in_buffer(struct tty_struct *tty)
 	unsigned long flags;
 	int ret;
 
-	port = uart_port_lock(state, flags);
+	port = uart_port_ref_lock(state, flags);
 	ret = uart_circ_chars_pending(&state->xmit);
-	uart_port_unlock(port, flags);
+	uart_port_unlock_deref(port, flags);
 	return ret;
 }
 
@@ -635,13 +636,13 @@ static void uart_flush_buffer(struct tty_struct *tty)
 
 	pr_debug("uart_flush_buffer(%d) called\n", tty->index);
 
-	port = uart_port_lock(state, flags);
+	port = uart_port_ref_lock(state, flags);
 	if (!port)
 		return;
 	uart_circ_clear(&state->xmit);
 	if (port->ops->flush_buffer)
 		port->ops->flush_buffer(port);
-	uart_port_unlock(port, flags);
+	uart_port_unlock_deref(port, flags);
 	tty_port_tty_wakeup(&state->port);
 }
 
@@ -662,11 +663,11 @@ static void uart_send_xchar(struct tty_struct *tty, char ch)
 	if (port->ops->send_xchar)
 		port->ops->send_xchar(port, ch);
 	else {
-		spin_lock_irqsave(&port->lock, flags);
+		uart_port_lock_irqsave(&port->lock, flags);
 		port->x_char = ch;
 		if (ch)
 			port->ops->start_tx(port);
-		spin_unlock_irqrestore(&port->lock, flags);
+		uart_port_unlock_irqrestore(&port->lock, flags);
 	}
 	uart_port_deref(port);
 }
@@ -1048,9 +1049,9 @@ static int uart_tiocmget(struct tty_struct *tty)
 
 	if (!tty_io_error(tty)) {
 		result = uport->mctrl;
-		spin_lock_irq(&uport->lock);
+		uart_port_lock_irq(&uport->lock);
 		result |= uport->ops->get_mctrl(uport);
-		spin_unlock_irq(&uport->lock);
+		uart_port_unlock_irq(&uport->lock);
 	}
 out:
 	mutex_unlock(&port->mutex);
@@ -1186,16 +1187,16 @@ static int uart_wait_modem_status(struct uart_state *state, unsigned long arg)
 	uport = uart_port_ref(state);
 	if (!uport)
 		return -EIO;
-	spin_lock_irq(&uport->lock);
+	uart_port_lock_irq(&uport->lock);
 	memcpy(&cprev, &uport->icount, sizeof(struct uart_icount));
 	uart_enable_ms(uport);
-	spin_unlock_irq(&uport->lock);
+	uart_port_unlock_irq(&uport->lock);
 
 	add_wait_queue(&port->delta_msr_wait, &wait);
 	for (;;) {
-		spin_lock_irq(&uport->lock);
+		uart_port_lock_irq(&uport->lock);
 		memcpy(&cnow, &uport->icount, sizeof(struct uart_icount));
-		spin_unlock_irq(&uport->lock);
+		uart_port_unlock_irq(&uport->lock);
 
 		set_current_state(TASK_INTERRUPTIBLE);
 
@@ -1240,9 +1241,9 @@ static int uart_get_icount(struct tty_struct *tty,
 	uport = uart_port_ref(state);
 	if (!uport)
 		return -EIO;
-	spin_lock_irq(&uport->lock);
+	uart_port_lock_irq(&uport->lock);
 	memcpy(&cnow, &uport->icount, sizeof(struct uart_icount));
-	spin_unlock_irq(&uport->lock);
+	uart_port_unlock_irq(&uport->lock);
 	uart_port_deref(uport);
 
 	icount->cts         = cnow.cts;
@@ -1266,9 +1267,9 @@ static int uart_get_rs485_config(struct uart_port *port,
 	unsigned long flags;
 	struct serial_rs485 aux;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(&port->lock, flags);
 	aux = port->rs485;
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(&port->lock, flags);
 
 	if (copy_to_user(rs485, &aux, sizeof(aux)))
 		return -EFAULT;
@@ -1289,9 +1290,9 @@ static int uart_set_rs485_config(struct uart_port *port,
 	if (copy_from_user(&rs485, rs485_user, sizeof(*rs485_user)))
 		return -EFAULT;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(&port->lock, flags);
 	ret = port->rs485_config(port, &rs485);
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(&port->lock, flags);
 	if (ret)
 		return ret;
 
@@ -1503,9 +1504,9 @@ static void uart_tty_port_shutdown(struct tty_port *port)
 	if (WARN(!uport, "detached port still initialized!\n"))
 		return;
 
-	spin_lock_irq(&uport->lock);
+	uart_port_lock_irq(&uport->lock);
 	uport->ops->stop_rx(uport);
-	spin_unlock_irq(&uport->lock);
+	uart_port_unlock_irq(&uport->lock);
 
 	uart_port_shutdown(port);
 
@@ -1659,10 +1660,10 @@ static int uart_carrier_raised(struct tty_port *port)
 	 */
 	if (WARN_ON(!uport))
 		return 1;
-	spin_lock_irq(&uport->lock);
+	uart_port_lock_irq(&uport->lock);
 	uart_enable_ms(uport);
 	mctrl = uport->ops->get_mctrl(uport);
-	spin_unlock_irq(&uport->lock);
+	uart_port_unlock_irq(&uport->lock);
 	uart_port_deref(uport);
 	if (mctrl & TIOCM_CAR)
 		return 1;
@@ -1770,9 +1771,9 @@ static void uart_line_info(struct seq_file *m, struct uart_driver *drv, int i)
 		pm_state = state->pm_state;
 		if (pm_state != UART_PM_STATE_ON)
 			uart_change_pm(state, UART_PM_STATE_ON);
-		spin_lock_irq(&uport->lock);
+		uart_port_unlock_irq(&uport->lock);
 		status = uport->ops->get_mctrl(uport);
-		spin_unlock_irq(&uport->lock);
+		uart_port_unlock_irq(&uport->lock);
 		if (pm_state != UART_PM_STATE_ON)
 			uart_change_pm(state, pm_state);
 
@@ -2099,11 +2100,11 @@ int uart_suspend_port(struct uart_driver *drv, struct uart_port *uport)
 		tty_port_set_suspended(port, 1);
 		tty_port_set_initialized(port, 0);
 
-		spin_lock_irq(&uport->lock);
+		uart_port_lock_irq(&uport->lock);
 		ops->stop_tx(uport);
 		ops->set_mctrl(uport, 0);
 		ops->stop_rx(uport);
-		spin_unlock_irq(&uport->lock);
+		uart_port_unlock_irq(&uport->lock);
 
 		/*
 		 * Wait for the transmitter to empty.
@@ -2179,9 +2180,9 @@ int uart_resume_port(struct uart_driver *drv, struct uart_port *uport)
 		int ret;
 
 		uart_change_pm(state, UART_PM_STATE_ON);
-		spin_lock_irq(&uport->lock);
+		uart_port_lock_irq(&uport->lock);
 		ops->set_mctrl(uport, 0);
-		spin_unlock_irq(&uport->lock);
+		uart_port_unlock_irq(&uport->lock);
 		if (console_suspend_enabled || !uart_console(uport)) {
 			/* Protected by port mutex for now */
 			struct tty_struct *tty = port->tty;
@@ -2189,10 +2190,10 @@ int uart_resume_port(struct uart_driver *drv, struct uart_port *uport)
 			if (ret == 0) {
 				if (tty)
 					uart_change_speed(tty, state, NULL);
-				spin_lock_irq(&uport->lock);
+				uart_port_unlock_irq(&uport->lock);
 				ops->set_mctrl(uport, uport->mctrl);
 				ops->start_tx(uport);
-				spin_unlock_irq(&uport->lock);
+				uart_port_unlock_irq(&uport->lock);
 				tty_port_set_initialized(port, 1);
 			} else {
 				/*
@@ -2286,9 +2287,9 @@ uart_configure_port(struct uart_driver *drv, struct uart_state *state,
 		 * keep the DTR setting that is set in uart_set_options()
 		 * We probably don't need a spinlock around this, but
 		 */
-		spin_lock_irqsave(&port->lock, flags);
+		uart_port_lock_irqsave(&port->lock, flags);
 		port->ops->set_mctrl(port, port->mctrl & TIOCM_DTR);
-		spin_unlock_irqrestore(&port->lock, flags);
+		uart_port_unlock_irqrestore(&port->lock, flags);
 
 		/*
 		 * If this driver supports console, and it hasn't been
-- 
2.17.1


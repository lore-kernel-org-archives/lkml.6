Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 88EF3C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 09:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A7AD208B2
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 09:41:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h67AKUVY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A7AD208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756189AbeFOJlH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 05:41:07 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34859 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756176AbeFOJlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 05:41:00 -0400
Received: by mail-pf0-f194.google.com with SMTP id c22-v6so4629945pfi.2;
        Fri, 15 Jun 2018 02:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=M3j5J7+lLk5PqA+j7wX21WuUT8bAo3g8O6dWIvmL0hE=;
        b=h67AKUVY1E/XBJVOzfDNYWAXTieQp/UXPm/v/2N2YNlkrwNAUSZZq/2HAYEWZ+aTr/
         R8mJPuW7UDR/h41ZKP9IOsUKwG4xeOc7C/qBQTQrvoqL/X5ox4xxFYA+mtqNPzwjyaV4
         2yqdjVGKGfsfmnqYsYKXamQojoK8de7kf6NvfjYcoaol3TgUnbf16MRM4QLKsOlkOIuX
         N95zDqLuOC5Z8Ujlm2wgAN2TfyQRh1xfb1qxefClj3dBmC1vll1R/C5lh+ZHuBdU6+K/
         ePSTmMMlz183XfVZXD0lxpkegwPf/X1aryD1w1RUzZf9SOfvgc7uCJIfZhQY1JKDsloI
         v/QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=M3j5J7+lLk5PqA+j7wX21WuUT8bAo3g8O6dWIvmL0hE=;
        b=QAmfNecuTvOtGz1Q6VmDxmvc8f5neJMZogGTRDtTSl8JEfRbz1iIft2MSoBqmPYuWg
         3BdrkQtUXg6sU1CRg26u+7otZbfed4b5wvHtOFvg4nTBpDCJunFoHsgs0sx5YXufrYGb
         MZXp0QVREVHGlKksiF2BMOzKvFIwUqFlbhHSWRtu7nMz4fLSnkmDm2k0XqiGniN2oo5q
         y8UceZ4rIBDnF6j742WVu4uryE7PvlVpf3j6p03rc2wb3pe3CQptQbsMXVHwryVV9Miw
         vpKwjPwmtIsXnNthXLBKQsi4yRqobuB/GcczZ0/S5EcTIPaA/HLc7EMW3idYP302xHtp
         oH2Q==
X-Gm-Message-State: APt69E1PqSnv3eXpxZI4FTYsm5366/TxG0hUNqqhkp4gNpUkVwpMZqyb
        1s4z0x/w8vcH1Pak63MzeWY=
X-Google-Smtp-Source: ADUXVKLjnDTOq3ey/U+Iq1Y61v5EUCftmafCRQfgzk1eKXnNrLRzsnBshA5+eI9HfKZYVKCS/w42Ng==
X-Received: by 2002:a62:3e11:: with SMTP id l17-v6mr1117376pfa.18.1529055660050;
        Fri, 15 Jun 2018 02:41:00 -0700 (PDT)
Received: from localhost.localdomain ([175.223.48.179])
        by smtp.gmail.com with ESMTPSA id p1-v6sm11628551pfh.58.2018.06.15.02.40.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Jun 2018 02:40:58 -0700 (PDT)
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
Subject: [RFC][PATCH 6/6] tty: 8250: switch to uart_port locking helpers
Date:   Fri, 15 Jun 2018 18:39:19 +0900
Message-Id: <20180615093919.559-7-sergey.senozhatsky@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180615093919.559-1-sergey.senozhatsky@gmail.com>
References: <20180615093919.559-1-sergey.senozhatsky@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not directly lock/unlock uart_port->lock, but use uart_port_lock
helper macros.

Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
---
 drivers/tty/serial/8250/8250_core.c |  8 ++--
 drivers/tty/serial/8250/8250_dma.c  |  4 +-
 drivers/tty/serial/8250/8250_port.c | 74 ++++++++++++++---------------
 3 files changed, 43 insertions(+), 43 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 9342fc2ee7df..ce7aa601c809 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -272,7 +272,7 @@ static void serial8250_backup_timeout(struct timer_list *t)
 	unsigned int iir, ier = 0, lsr;
 	unsigned long flags;
 
-	spin_lock_irqsave(&up->port.lock, flags);
+	uart_port_lock_irqsave(&up->port.lock, flags);
 
 	/*
 	 * Must disable interrupts or else we risk racing with the interrupt
@@ -306,7 +306,7 @@ static void serial8250_backup_timeout(struct timer_list *t)
 	if (up->port.irq)
 		serial_out(up, UART_IER, ier);
 
-	spin_unlock_irqrestore(&up->port.lock, flags);
+	uart_port_unlock_irqrestore(&up->port.lock, flags);
 
 	/* Standard timer interval plus 0.2s to keep the port running */
 	mod_timer(&up->timer,
@@ -1078,9 +1078,9 @@ void serial8250_unregister_port(int line)
 	if (uart->em485) {
 		unsigned long flags;
 
-		spin_lock_irqsave(&uart->port.lock, flags);
+		uart_port_lock_irqsave(&uart->port.lock, flags);
 		serial8250_em485_destroy(uart);
-		spin_unlock_irqrestore(&uart->port.lock, flags);
+		uart_port_unlock_irqrestore(&uart->port.lock, flags);
 	}
 
 	uart_remove_one_port(&serial8250_reg, &uart->port);
diff --git a/drivers/tty/serial/8250/8250_dma.c b/drivers/tty/serial/8250/8250_dma.c
index bfa1a857f3ff..ec601779c32f 100644
--- a/drivers/tty/serial/8250/8250_dma.c
+++ b/drivers/tty/serial/8250/8250_dma.c
@@ -22,7 +22,7 @@ static void __dma_tx_complete(void *param)
 	dma_sync_single_for_cpu(dma->txchan->device->dev, dma->tx_addr,
 				UART_XMIT_SIZE, DMA_TO_DEVICE);
 
-	spin_lock_irqsave(&p->port.lock, flags);
+	uart_port_lock_irqsave(&p->port.lock, flags);
 
 	dma->tx_running = 0;
 
@@ -39,7 +39,7 @@ static void __dma_tx_complete(void *param)
 		serial_port_out(&p->port, UART_IER, p->ier);
 	}
 
-	spin_unlock_irqrestore(&p->port.lock, flags);
+	uart_port_unlock_irqrestore(&p->port.lock, flags);
 }
 
 static void __dma_rx_complete(void *param)
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index cf541aab2bd0..a1ee17870ebc 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -772,9 +772,9 @@ static void enable_rsa(struct uart_8250_port *up)
 {
 	if (up->port.type == PORT_RSA) {
 		if (up->port.uartclk != SERIAL_RSA_BAUD_BASE * 16) {
-			spin_lock_irq(&up->port.lock);
+			uart_port_lock_irq(&up->port.lock);
 			__enable_rsa(up);
-			spin_unlock_irq(&up->port.lock);
+			uart_port_unlock_irq(&up->port.lock);
 		}
 		if (up->port.uartclk == SERIAL_RSA_BAUD_BASE * 16)
 			serial_out(up, UART_RSA_FRR, 0);
@@ -794,7 +794,7 @@ static void disable_rsa(struct uart_8250_port *up)
 
 	if (up->port.type == PORT_RSA &&
 	    up->port.uartclk == SERIAL_RSA_BAUD_BASE * 16) {
-		spin_lock_irq(&up->port.lock);
+		uart_port_lock_irq(&up->port.lock);
 
 		mode = serial_in(up, UART_RSA_MSR);
 		result = !(mode & UART_RSA_MSR_FIFO);
@@ -807,7 +807,7 @@ static void disable_rsa(struct uart_8250_port *up)
 
 		if (result)
 			up->port.uartclk = SERIAL_RSA_BAUD_BASE_LO * 16;
-		spin_unlock_irq(&up->port.lock);
+		uart_port_unlock_irq(&up->port.lock);
 	}
 }
 #endif /* CONFIG_SERIAL_8250_RSA */
@@ -1218,7 +1218,7 @@ static void autoconfig(struct uart_8250_port *up)
 	 * We really do need global IRQs disabled here - we're going to
 	 * be frobbing the chips IRQ enable register to see if it exists.
 	 */
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(&port->lock, flags);
 
 	up->capabilities = 0;
 	up->bugs = 0;
@@ -1257,7 +1257,7 @@ static void autoconfig(struct uart_8250_port *up)
 			/*
 			 * We failed; there's nothing here
 			 */
-			spin_unlock_irqrestore(&port->lock, flags);
+			uart_port_unlock_irqrestore(&port->lock, flags);
 			DEBUG_AUTOCONF("IER test failed (%02x, %02x) ",
 				       scratch2, scratch3);
 			goto out;
@@ -1281,7 +1281,7 @@ static void autoconfig(struct uart_8250_port *up)
 		status1 = serial_in(up, UART_MSR) & 0xF0;
 		serial8250_out_MCR(up, save_mcr);
 		if (status1 != 0x90) {
-			spin_unlock_irqrestore(&port->lock, flags);
+			uart_port_unlock_irqrestore(&port->lock, flags);
 			DEBUG_AUTOCONF("LOOP test failed (%02x) ",
 				       status1);
 			goto out;
@@ -1354,7 +1354,7 @@ static void autoconfig(struct uart_8250_port *up)
 		serial_out(up, UART_IER, 0);
 
 out_lock:
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(&port->lock, flags);
 
 	/*
 	 * Check if the device is a Fintek F81216A
@@ -1466,12 +1466,12 @@ static enum hrtimer_restart serial8250_em485_handle_stop_tx(struct hrtimer *t)
 	p = em485->port;
 
 	serial8250_rpm_get(p);
-	spin_lock_irqsave(&p->port.lock, flags);
+	uart_port_lock_irqsave(&p->port.lock, flags);
 	if (em485->active_timer == &em485->stop_tx_timer) {
 		__do_stop_tx_rs485(p);
 		em485->active_timer = NULL;
 	}
-	spin_unlock_irqrestore(&p->port.lock, flags);
+	uart_port_unlock_irqrestore(&p->port.lock, flags);
 	serial8250_rpm_put(p);
 	return HRTIMER_NORESTART;
 }
@@ -1620,12 +1620,12 @@ static enum hrtimer_restart serial8250_em485_handle_start_tx(struct hrtimer *t)
 	em485 = container_of(t, struct uart_8250_em485, start_tx_timer);
 	p = em485->port;
 
-	spin_lock_irqsave(&p->port.lock, flags);
+	uart_port_lock_irqsave(&p->port.lock, flags);
 	if (em485->active_timer == &em485->start_tx_timer) {
 		__start_tx(&p->port);
 		em485->active_timer = NULL;
 	}
-	spin_unlock_irqrestore(&p->port.lock, flags);
+	uart_port_unlock_irqrestore(&p->port.lock, flags);
 	return HRTIMER_NORESTART;
 }
 
@@ -1867,7 +1867,7 @@ int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
 	if (iir & UART_IIR_NO_INT)
 		return 0;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(&port->lock, flags);
 
 	status = serial_port_in(port, UART_LSR);
 
@@ -1880,7 +1880,7 @@ int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
 	if ((!up->dma || up->dma->tx_err) && (status & UART_LSR_THRE))
 		serial8250_tx_chars(up);
 
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(&port->lock, flags);
 	return 1;
 }
 EXPORT_SYMBOL_GPL(serial8250_handle_irq);
@@ -1915,9 +1915,9 @@ static int serial8250_tx_threshold_handle_irq(struct uart_port *port)
 	if ((iir & UART_IIR_ID) == UART_IIR_THRI) {
 		struct uart_8250_port *up = up_to_u8250p(port);
 
-		spin_lock_irqsave(&port->lock, flags);
+		uart_port_lock_irqsave(&port->lock, flags);
 		serial8250_tx_chars(up);
-		spin_unlock_irqrestore(&port->lock, flags);
+		uart_port_unlock_irqrestore(&port->lock, flags);
 	}
 
 	iir = serial_port_in(port, UART_IIR);
@@ -1932,10 +1932,10 @@ static unsigned int serial8250_tx_empty(struct uart_port *port)
 
 	serial8250_rpm_get(up);
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(&port->lock, flags);
 	lsr = serial_port_in(port, UART_LSR);
 	up->lsr_saved_flags |= lsr & LSR_SAVE_FLAGS;
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(&port->lock, flags);
 
 	serial8250_rpm_put(up);
 
@@ -2008,13 +2008,13 @@ static void serial8250_break_ctl(struct uart_port *port, int break_state)
 	unsigned long flags;
 
 	serial8250_rpm_get(up);
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(&port->lock, flags);
 	if (break_state == -1)
 		up->lcr |= UART_LCR_SBC;
 	else
 		up->lcr &= ~UART_LCR_SBC;
 	serial_port_out(port, UART_LCR, up->lcr);
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(&port->lock, flags);
 	serial8250_rpm_put(up);
 }
 
@@ -2266,7 +2266,7 @@ int serial8250_do_startup(struct uart_port *port)
 		 * the interrupt is enabled.  Delays are necessary to
 		 * allow register changes to become visible.
 		 */
-		spin_lock_irqsave(&port->lock, flags);
+		uart_port_lock_irqsave(&port->lock, flags);
 		if (up->port.irqflags & IRQF_SHARED)
 			disable_irq_nosync(port->irq);
 
@@ -2282,7 +2282,7 @@ int serial8250_do_startup(struct uart_port *port)
 
 		if (port->irqflags & IRQF_SHARED)
 			enable_irq(port->irq);
-		spin_unlock_irqrestore(&port->lock, flags);
+		uart_port_unlock_irqrestore(&port->lock, flags);
 
 		/*
 		 * If the interrupt is not reasserted, or we otherwise
@@ -2304,7 +2304,7 @@ int serial8250_do_startup(struct uart_port *port)
 	 */
 	serial_port_out(port, UART_LCR, UART_LCR_WLEN8);
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(&port->lock, flags);
 	if (up->port.flags & UPF_FOURPORT) {
 		if (!up->port.irq)
 			up->port.mctrl |= TIOCM_OUT1;
@@ -2351,7 +2351,7 @@ int serial8250_do_startup(struct uart_port *port)
 	}
 
 dont_test_tx_en:
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(&port->lock, flags);
 
 	/*
 	 * Clear the interrupt registers again for luck, and clear the
@@ -2418,17 +2418,17 @@ void serial8250_do_shutdown(struct uart_port *port)
 	/*
 	 * Disable interrupts from this port
 	 */
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(&port->lock, flags);
 	up->ier = 0;
 	serial_port_out(port, UART_IER, 0);
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(&port->lock, flags);
 
 	synchronize_irq(port->irq);
 
 	if (up->dma)
 		serial8250_release_dma(up);
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(&port->lock, flags);
 	if (port->flags & UPF_FOURPORT) {
 		/* reset interrupts on the AST Fourport board */
 		inb((port->iobase & 0xfe0) | 0x1f);
@@ -2437,7 +2437,7 @@ void serial8250_do_shutdown(struct uart_port *port)
 		port->mctrl &= ~TIOCM_OUT2;
 
 	serial8250_set_mctrl(port, port->mctrl);
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(&port->lock, flags);
 
 	/*
 	 * Disable break condition and FIFOs
@@ -2643,7 +2643,7 @@ serial8250_do_set_termios(struct uart_port *port, struct ktermios *termios,
 	 * interrupts disabled.
 	 */
 	serial8250_rpm_get(up);
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(&port->lock, flags);
 
 	up->lcr = cval;					/* Save computed LCR */
 
@@ -2747,7 +2747,7 @@ serial8250_do_set_termios(struct uart_port *port, struct ktermios *termios,
 		serial_port_out(port, UART_FCR, up->fcr);	/* set fcr */
 	}
 	serial8250_set_mctrl(port, port->mctrl);
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(&port->lock, flags);
 	serial8250_rpm_put(up);
 
 	/* Don't rewrite B0 */
@@ -2770,15 +2770,15 @@ void serial8250_do_set_ldisc(struct uart_port *port, struct ktermios *termios)
 {
 	if (termios->c_line == N_PPS) {
 		port->flags |= UPF_HARDPPS_CD;
-		spin_lock_irq(&port->lock);
+		uart_port_lock_irq(&port->lock);
 		serial8250_enable_ms(port);
-		spin_unlock_irq(&port->lock);
+		uart_port_unlock_irq(&port->lock);
 	} else {
 		port->flags &= ~UPF_HARDPPS_CD;
 		if (!UART_ENABLE_MS(port, termios->c_cflag)) {
-			spin_lock_irq(&port->lock);
+			uart_port_lock_irq(&port->lock);
 			serial8250_disable_ms(port);
-			spin_unlock_irq(&port->lock);
+			uart_port_unlock_irq(&port->lock);
 		}
 	}
 }
@@ -3225,9 +3225,9 @@ void serial8250_console_write(struct uart_8250_port *up, const char *s,
 	if (port->sysrq)
 		locked = 0;
 	else if (oops_in_progress)
-		locked = spin_trylock_irqsave(&port->lock, flags);
+		locked = uart_port_trylock_irqsave(&port->lock, flags);
 	else
-		spin_lock_irqsave(&port->lock, flags);
+		uart_port_lock_irqsave(&port->lock, flags);
 
 	/*
 	 *	First save the IER then disable the interrupts
@@ -3265,7 +3265,7 @@ void serial8250_console_write(struct uart_8250_port *up, const char *s,
 		serial8250_modem_status(up);
 
 	if (locked)
-		spin_unlock_irqrestore(&port->lock, flags);
+		uart_port_unlock_irqrestore(&port->lock, flags);
 	serial8250_rpm_put(up);
 }
 
-- 
2.17.1


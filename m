Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04113C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 05:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EC032054F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 05:05:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="msMOyPIk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EC032054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727760AbeJPMxs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 08:53:48 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40495 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727678AbeJPMxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 08:53:48 -0400
Received: by mail-pf1-f193.google.com with SMTP id g21-v6so3818466pfi.7;
        Mon, 15 Oct 2018 22:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/Bmse8VRObcCB6rDTcDcGB1fvNdk4tWJcUDcVjNyNFo=;
        b=msMOyPIkJyiVZKfG/p7YDrQPacS6y1iH4tWFlV6zqHYN6jUJwc/fPwTPDu4QJbfM0J
         h0jHyLTa6zUAls6ZNgljhNpD8pz2Y4DvFrQ+1ofysxxl4vYhslkNqUZChWxOLUNGlfl6
         /NoeMyu64GIqs6ElNFMr8EZ5XC3DTxWFJgwT4mGiUVx3OpFY3K4Kdigx2XPaYvXB2S5V
         JSLBlSjkcQ4gauvaVh/nKlWDfOdXlLGWxRKwprn+iO2YnQ+mC11KM54h3+sHjs7Ah0ev
         Id6AmeEVxXTtyYbZUpmDFmgu72mI0Ei3WBKrzIQARFFmO8nviJYM7ku5OgTyZZlhMNeh
         N6JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/Bmse8VRObcCB6rDTcDcGB1fvNdk4tWJcUDcVjNyNFo=;
        b=bU0KFhDjCWkZNyBCBN2PniUSvDrmvHoBjKwqE2JqlfroGs7BsXvYy1bY/KIjGBcfn4
         rHqPjJVJlHZ22V28nEcGVJD/Hse+wIj1cNfgqj/bZv7Vs1BjunH3fNyjMLACtmOWKlFB
         N66tNVGAdlMcDpQ6+VUag3NqRve5z/Lz7Q9umcNbkhVDVXfn7dGXMhANqbpT8r/VaWCd
         kMz8rXduCrBCLtXC04eYukpd9VL+XTK1AQGpjb1OmqkR5fGkYotzeo0AYWskzfeu1VAB
         7D0XwRMQVsp/XGN02EZ387uN6S9ZNbFlHLBD1/O4tTxvbjIL125OQh3L7eiNt6q7EXyc
         3MIQ==
X-Gm-Message-State: ABuFfogfSWfz+cwyddudciv1NqFggvLVdHUJLZt+oONUp7QRZY5bAS91
        cyHXRsmoidGLGt2JSVnw/e6zYX7N
X-Google-Smtp-Source: ACcGV633UCg/kz8gajvcfWJosLyylt7VOv5WUO3kq1z9THsuEg0YN6FSqmA/zI8Hzr0QBKEolRpGOA==
X-Received: by 2002:a62:3641:: with SMTP id d62-v6mr11607895pfa.97.1539666311734;
        Mon, 15 Oct 2018 22:05:11 -0700 (PDT)
Received: from localhost.localdomain ([175.223.10.117])
        by smtp.gmail.com with ESMTPSA id e131-v6sm19353225pfc.52.2018.10.15.22.05.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 22:05:10 -0700 (PDT)
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
Subject: [RFC][PATCHv2 4/4] tty: 8250: switch to uart_port locking helpers
Date:   Tue, 16 Oct 2018 14:04:28 +0900
Message-Id: <20181016050428.17966-5-sergey.senozhatsky@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016050428.17966-1-sergey.senozhatsky@gmail.com>
References: <20181016050428.17966-1-sergey.senozhatsky@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to uart_port_lock macros:

- use uart_port_lock_for_printk()/uart_port_unlock_after_printk() in
  serial8250_console_write().

- use uart_port_lock_*()/uart_port_unlock_*() elsewhere.

Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
---
 drivers/tty/serial/8250/8250_core.c |  8 +--
 drivers/tty/serial/8250/8250_dma.c  |  4 +-
 drivers/tty/serial/8250/8250_port.c | 81 +++++++++++++----------------
 3 files changed, 43 insertions(+), 50 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 94f3e1c64490..34fe546260f6 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -268,7 +268,7 @@ static void serial8250_backup_timeout(struct timer_list *t)
 	unsigned int iir, ier = 0, lsr;
 	unsigned long flags;
 
-	spin_lock_irqsave(&up->port.lock, flags);
+	uart_port_lock_irqsave(&up->port, flags);
 
 	/*
 	 * Must disable interrupts or else we risk racing with the interrupt
@@ -302,7 +302,7 @@ static void serial8250_backup_timeout(struct timer_list *t)
 	if (up->port.irq)
 		serial_out(up, UART_IER, ier);
 
-	spin_unlock_irqrestore(&up->port.lock, flags);
+	uart_port_unlock_irqrestore(&up->port, flags);
 
 	/* Standard timer interval plus 0.2s to keep the port running */
 	mod_timer(&up->timer,
@@ -1078,9 +1078,9 @@ void serial8250_unregister_port(int line)
 	if (uart->em485) {
 		unsigned long flags;
 
-		spin_lock_irqsave(&uart->port.lock, flags);
+		uart_port_lock_irqsave(&uart->port, flags);
 		serial8250_em485_destroy(uart);
-		spin_unlock_irqrestore(&uart->port.lock, flags);
+		uart_port_unlock_irqrestore(&uart->port, flags);
 	}
 
 	uart_remove_one_port(&serial8250_reg, &uart->port);
diff --git a/drivers/tty/serial/8250/8250_dma.c b/drivers/tty/serial/8250/8250_dma.c
index bfa1a857f3ff..a9255b4e9353 100644
--- a/drivers/tty/serial/8250/8250_dma.c
+++ b/drivers/tty/serial/8250/8250_dma.c
@@ -22,7 +22,7 @@ static void __dma_tx_complete(void *param)
 	dma_sync_single_for_cpu(dma->txchan->device->dev, dma->tx_addr,
 				UART_XMIT_SIZE, DMA_TO_DEVICE);
 
-	spin_lock_irqsave(&p->port.lock, flags);
+	uart_port_lock_irqsave(&p->port, flags);
 
 	dma->tx_running = 0;
 
@@ -39,7 +39,7 @@ static void __dma_tx_complete(void *param)
 		serial_port_out(&p->port, UART_IER, p->ier);
 	}
 
-	spin_unlock_irqrestore(&p->port.lock, flags);
+	uart_port_unlock_irqrestore(&p->port, flags);
 }
 
 static void __dma_rx_complete(void *param)
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index f776b3eafb96..340aecf23dc5 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -790,9 +790,9 @@ static void enable_rsa(struct uart_8250_port *up)
 {
 	if (up->port.type == PORT_RSA) {
 		if (up->port.uartclk != SERIAL_RSA_BAUD_BASE * 16) {
-			spin_lock_irq(&up->port.lock);
+			uart_port_lock_irq(&up->port);
 			__enable_rsa(up);
-			spin_unlock_irq(&up->port.lock);
+			uart_port_unlock_irq(&up->port);
 		}
 		if (up->port.uartclk == SERIAL_RSA_BAUD_BASE * 16)
 			serial_out(up, UART_RSA_FRR, 0);
@@ -812,7 +812,7 @@ static void disable_rsa(struct uart_8250_port *up)
 
 	if (up->port.type == PORT_RSA &&
 	    up->port.uartclk == SERIAL_RSA_BAUD_BASE * 16) {
-		spin_lock_irq(&up->port.lock);
+		uart_port_lock_irq(&up->port);
 
 		mode = serial_in(up, UART_RSA_MSR);
 		result = !(mode & UART_RSA_MSR_FIFO);
@@ -825,7 +825,7 @@ static void disable_rsa(struct uart_8250_port *up)
 
 		if (result)
 			up->port.uartclk = SERIAL_RSA_BAUD_BASE_LO * 16;
-		spin_unlock_irq(&up->port.lock);
+		uart_port_unlock_irq(&up->port);
 	}
 }
 #endif /* CONFIG_SERIAL_8250_RSA */
@@ -1236,7 +1236,7 @@ static void autoconfig(struct uart_8250_port *up)
 	 * We really do need global IRQs disabled here - we're going to
 	 * be frobbing the chips IRQ enable register to see if it exists.
 	 */
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, flags);
 
 	up->capabilities = 0;
 	up->bugs = 0;
@@ -1275,7 +1275,7 @@ static void autoconfig(struct uart_8250_port *up)
 			/*
 			 * We failed; there's nothing here
 			 */
-			spin_unlock_irqrestore(&port->lock, flags);
+			uart_port_unlock_irqrestore(port, flags);
 			DEBUG_AUTOCONF("IER test failed (%02x, %02x) ",
 				       scratch2, scratch3);
 			goto out;
@@ -1299,7 +1299,7 @@ static void autoconfig(struct uart_8250_port *up)
 		status1 = serial_in(up, UART_MSR) & 0xF0;
 		serial8250_out_MCR(up, save_mcr);
 		if (status1 != 0x90) {
-			spin_unlock_irqrestore(&port->lock, flags);
+			uart_port_unlock_irqrestore(port, flags);
 			DEBUG_AUTOCONF("LOOP test failed (%02x) ",
 				       status1);
 			goto out;
@@ -1372,7 +1372,7 @@ static void autoconfig(struct uart_8250_port *up)
 		serial_out(up, UART_IER, 0);
 
 out_lock:
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 
 	/*
 	 * Check if the device is a Fintek F81216A
@@ -1483,12 +1483,12 @@ static enum hrtimer_restart serial8250_em485_handle_stop_tx(struct hrtimer *t)
 	p = em485->port;
 
 	serial8250_rpm_get(p);
-	spin_lock_irqsave(&p->port.lock, flags);
+	uart_port_lock_irqsave(&p->port, flags);
 	if (em485->active_timer == &em485->stop_tx_timer) {
 		__do_stop_tx_rs485(p);
 		em485->active_timer = NULL;
 	}
-	spin_unlock_irqrestore(&p->port.lock, flags);
+	uart_port_unlock_irqrestore(&p->port, flags);
 	serial8250_rpm_put(p);
 	return HRTIMER_NORESTART;
 }
@@ -1637,12 +1637,12 @@ static enum hrtimer_restart serial8250_em485_handle_start_tx(struct hrtimer *t)
 	em485 = container_of(t, struct uart_8250_em485, start_tx_timer);
 	p = em485->port;
 
-	spin_lock_irqsave(&p->port.lock, flags);
+	uart_port_lock_irqsave(&p->port, flags);
 	if (em485->active_timer == &em485->start_tx_timer) {
 		__start_tx(&p->port);
 		em485->active_timer = NULL;
 	}
-	spin_unlock_irqrestore(&p->port.lock, flags);
+	uart_port_unlock_irqrestore(&p->port, flags);
 	return HRTIMER_NORESTART;
 }
 
@@ -1884,7 +1884,7 @@ int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
 	if (iir & UART_IIR_NO_INT)
 		return 0;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, flags);
 
 	status = serial_port_in(port, UART_LSR);
 
@@ -1897,7 +1897,7 @@ int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
 	if ((!up->dma || up->dma->tx_err) && (status & UART_LSR_THRE))
 		serial8250_tx_chars(up);
 
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 	return 1;
 }
 EXPORT_SYMBOL_GPL(serial8250_handle_irq);
@@ -1932,9 +1932,9 @@ static int serial8250_tx_threshold_handle_irq(struct uart_port *port)
 	if ((iir & UART_IIR_ID) == UART_IIR_THRI) {
 		struct uart_8250_port *up = up_to_u8250p(port);
 
-		spin_lock_irqsave(&port->lock, flags);
+		uart_port_lock_irqsave(port, flags);
 		serial8250_tx_chars(up);
-		spin_unlock_irqrestore(&port->lock, flags);
+		uart_port_unlock_irqrestore(port, flags);
 	}
 
 	iir = serial_port_in(port, UART_IIR);
@@ -1949,10 +1949,10 @@ static unsigned int serial8250_tx_empty(struct uart_port *port)
 
 	serial8250_rpm_get(up);
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, flags);
 	lsr = serial_port_in(port, UART_LSR);
 	up->lsr_saved_flags |= lsr & LSR_SAVE_FLAGS;
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 
 	serial8250_rpm_put(up);
 
@@ -2025,13 +2025,13 @@ static void serial8250_break_ctl(struct uart_port *port, int break_state)
 	unsigned long flags;
 
 	serial8250_rpm_get(up);
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, flags);
 	if (break_state == -1)
 		up->lcr |= UART_LCR_SBC;
 	else
 		up->lcr &= ~UART_LCR_SBC;
 	serial_port_out(port, UART_LCR, up->lcr);
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 	serial8250_rpm_put(up);
 }
 
@@ -2282,7 +2282,7 @@ int serial8250_do_startup(struct uart_port *port)
 		 * the interrupt is enabled.  Delays are necessary to
 		 * allow register changes to become visible.
 		 */
-		spin_lock_irqsave(&port->lock, flags);
+		uart_port_lock_irqsave(port, flags);
 		if (up->port.irqflags & IRQF_SHARED)
 			disable_irq_nosync(port->irq);
 
@@ -2298,7 +2298,7 @@ int serial8250_do_startup(struct uart_port *port)
 
 		if (port->irqflags & IRQF_SHARED)
 			enable_irq(port->irq);
-		spin_unlock_irqrestore(&port->lock, flags);
+		uart_port_unlock_irqrestore(port, flags);
 
 		/*
 		 * If the interrupt is not reasserted, or we otherwise
@@ -2320,7 +2320,7 @@ int serial8250_do_startup(struct uart_port *port)
 	 */
 	serial_port_out(port, UART_LCR, UART_LCR_WLEN8);
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, flags);
 	if (up->port.flags & UPF_FOURPORT) {
 		if (!up->port.irq)
 			up->port.mctrl |= TIOCM_OUT1;
@@ -2367,7 +2367,7 @@ int serial8250_do_startup(struct uart_port *port)
 	}
 
 dont_test_tx_en:
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 
 	/*
 	 * Clear the interrupt registers again for luck, and clear the
@@ -2434,17 +2434,17 @@ void serial8250_do_shutdown(struct uart_port *port)
 	/*
 	 * Disable interrupts from this port
 	 */
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, flags);
 	up->ier = 0;
 	serial_port_out(port, UART_IER, 0);
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 
 	synchronize_irq(port->irq);
 
 	if (up->dma)
 		serial8250_release_dma(up);
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, flags);
 	if (port->flags & UPF_FOURPORT) {
 		/* reset interrupts on the AST Fourport board */
 		inb((port->iobase & 0xfe0) | 0x1f);
@@ -2453,7 +2453,7 @@ void serial8250_do_shutdown(struct uart_port *port)
 		port->mctrl &= ~TIOCM_OUT2;
 
 	serial8250_set_mctrl(port, port->mctrl);
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 
 	/*
 	 * Disable break condition and FIFOs
@@ -2679,7 +2679,7 @@ serial8250_do_set_termios(struct uart_port *port, struct ktermios *termios,
 	 * interrupts disabled.
 	 */
 	serial8250_rpm_get(up);
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, flags);
 
 	up->lcr = cval;					/* Save computed LCR */
 
@@ -2783,7 +2783,7 @@ serial8250_do_set_termios(struct uart_port *port, struct ktermios *termios,
 		serial_port_out(port, UART_FCR, up->fcr);	/* set fcr */
 	}
 	serial8250_set_mctrl(port, port->mctrl);
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 	serial8250_rpm_put(up);
 
 	/* Don't rewrite B0 */
@@ -2806,15 +2806,15 @@ void serial8250_do_set_ldisc(struct uart_port *port, struct ktermios *termios)
 {
 	if (termios->c_line == N_PPS) {
 		port->flags |= UPF_HARDPPS_CD;
-		spin_lock_irq(&port->lock);
+		uart_port_lock_irq(port);
 		serial8250_enable_ms(port);
-		spin_unlock_irq(&port->lock);
+		uart_port_unlock_irq(port);
 	} else {
 		port->flags &= ~UPF_HARDPPS_CD;
 		if (!UART_ENABLE_MS(port, termios->c_cflag)) {
-			spin_lock_irq(&port->lock);
+			uart_port_lock_irq(port);
 			serial8250_disable_ms(port);
-			spin_unlock_irq(&port->lock);
+			uart_port_unlock_irq(port);
 		}
 	}
 }
@@ -3252,19 +3252,13 @@ void serial8250_console_write(struct uart_8250_port *up, const char *s,
 	struct uart_port *port = &up->port;
 	unsigned long flags;
 	unsigned int ier;
-	int locked = 1;
+	bool locked;
 
 	touch_nmi_watchdog();
 
 	serial8250_rpm_get(up);
 
-	if (port->sysrq)
-		locked = 0;
-	else if (oops_in_progress)
-		locked = spin_trylock_irqsave(&port->lock, flags);
-	else
-		spin_lock_irqsave(&port->lock, flags);
-
+	uart_port_lock_for_printk(port, flags, locked);
 	/*
 	 *	First save the IER then disable the interrupts
 	 */
@@ -3300,8 +3294,7 @@ void serial8250_console_write(struct uart_8250_port *up, const char *s,
 	if (up->msr_saved_flags)
 		serial8250_modem_status(up);
 
-	if (locked)
-		spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_after_printk(port, flags, locked);
 	serial8250_rpm_put(up);
 }
 
-- 
2.19.1


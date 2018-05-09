Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-970685-1525898702-2-8302356584351431722
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525898701; b=iJRvfrCAEgHa6KZMD/jerVj3AjrISupe3dD5v3VHuDQxvQpRJj
    MPgn+6INfHWqdpQI4W7sGLdtqFjUhPkYj5TkMwYOkw2Z6wBR2Ht3dHnvlyXXFSRx
    GEb+o8NC2/ed3ndEhazmcwaNtcNHi7t0XiF5NAJmFii8yBcBk3Hr9EKYBHajbVJr
    61EiXWQlCnGbFLFSc6YXIhtEyZHfkRDXhnsGZeB9DKT1wRN1qBC3VHLVSJAs0peP
    TRTE4iIVEnU7BpQ52MfOYlGlF2SPTXCpLx4cbWp7hiq2rAjNGzp5K2NWkoaQ+AK5
    ai2D8OmjnRWkX9rWsKI6855MWMX8ZBKM5fJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1525898701; bh=JpR9Gl5pqTkvCf05pdxZcoUpe1T9Sf
    yoCNOXq26bQx4=; b=jUXbz4Or5untlEURmgmqoIUxj7O4B+gMQ9OYOGcAGuUbzB
    QOZ1gi1RqAzw6GfJvSN95q4xBTzQEHeBftwcdUWhD7UTNDYCzSyExQ/4aI9FN6wF
    wdLpFJngH3008H0Ltyd/sTnEuOW1LvWqzW31LJgRrTNtEcmHXxZPwTwjiEEbIx49
    p90avUJ5a180PTkx9d/uMChwWBAzOiIHBuDnoKfW7cFMgknO0ojl29toBJCPcL+f
    arx5kGNSBslrOl1faQ2OAS9sO3krRE8zzAOCt7GtsjwQ6NcDDFYkE+q5u2FUF1R+
    u5d1DnFXA+RJ1UMtgZr4+TiLup6IBBrhgwW73zrA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=chromium.org header.i=@chromium.org header.b=Rf81FNBa
    x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=EML3DVJ7;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=chromium.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=chromium.org header.i=@chromium.org header.b=Rf81FNBa
      x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=EML3DVJ7;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=chromium.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMXr9dQUtfzZz/sncuvpWMjKLyNgqwpBQEmta+Ugob1eLQsVOMAwhZw531OHW0aKqbqSwwSOPkEkZoC2wbgc9Y7BBHX69Q00HsJJqbElSwJFYBSZyrAP
    iH8bT7sFZVODD4g4IZcW58gTADmfr2NLMjTH4K9GH09pUjKYpwpCa8h3BtZzC3jrjwGdtIMJ4SVsq4h0RjbpKsuYOqpMDI7FUHnY9v6TZb1nr04y0WdIrZF9
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=xqWC_Br6kY4A:10 a=VUJBJC2UJ8kA:10
    a=cm27Pg_UAAAA:8 a=OLL_FvSJAAAA:8 a=VwQbUJbxAAAA:8 a=GjtXIiNx2l-0IVn_ssMA:9
    a=Ec-IJR0R58AA:10 a=x8gzFH9gYPwA:10 a=AWcnj_ag4PAA:10
    a=xmb-EsYY8bH0VWELuYED:22 a=oIrB72frpwYPwTMnlWqB:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964793AbeEIUo6 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 9 May 2018 16:44:58 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:40719 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935475AbeEIUo5 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 9 May 2018 16:44:57 -0400
X-Google-Smtp-Source: AB8JxZoVvSPuZIrcNpykAzm/K/Llax6QSoXnJ6KcC+qeUN75QR2SRP/2zcZazRUjmBzufenBETkZ/Q==
From: Evan Green <evgreen@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Karthikeyan Ramasubramanian <kramasub@codeaurora.org>,
        Doug Anderson <dianders@chromium.org>
Cc: Evan Green <evgreen@chromium.org>
Subject: [PATCH] tty: serial: msm_geni_serial: Fix TX infinite loop
Date: Wed,  9 May 2018 13:44:29 -0700
Message-Id: <20180509204429.62778-1-evgreen@chromium.org>
X-Mailer: git-send-email 2.13.5
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The GENI serial driver handled transmit by leaving stuff in the
common circular buffer until it had completely caught up to the head,
then clearing it out all at once. This is a suboptimal way to do
transmit, as it leaves data in the circular buffer that could be
freed. Moreover, the logic implementing it is wrong, and it is easy to
get into a situation where the UART infinitely writes out the same buffer.

I could reproduce infinite serial output of the same buffer by running
dmesg, then hitting Ctrl-C. I believe what happened is xmit_size was
something large, marching towards a larger value. Then the generic OS
code flushed out the buffer and replaced it with two characters. Now the
xmit_size is a large value marching towards a small value, which it wasn't
expecting. The driver subtracts xmit_size (very large) from
uart_circ_chars_pending (2), underflows, and repeats ad nauseum. The
locking isn't wrong here, as the locks are held whenever the buffer is
manipulated, it's just that the driver wasn't expecting the buffer to be
flushed out from underneath it in between transmits.

This change reworks transmit to grab what it can from the circular buffer,
and then update ->tail, both fixing the underflow and freeing up space
for a smoother circular experience.

Signed-off-by: Evan Green <evgreen@chromium.org>
---

Note: This patch applies on top of Karthik's series of 8 fixup patches,
which seem basically ready to go, at:

https://www.spinics.net/lists/linux-arm-msm/msg36561.html

Karthik had some concerns here in that apparently he had done it the way it
was on purpose in order to avoid a watchdog timeout with very large kernel
logs. Doug's and my best interpretation of his explanation is that maybe the
UART is so fast, and the FIFO is potentially only 16 bytes wide, so by the
time the data has been loaded up into the FIFO and the interrupt handler
returns, the UART has finished and the interrupt fires again immediately.
His original solution works because the buffer fills up completely,
and handle_tx calls stop_tx and uart_write_wakeup, which usually happens to
take enough time to let the interrupting core schedule something.

The old way this driver was doing it, artificially letting the circular buffer
balloon up and eventually pop, still seems like the wrong approach to me.
Perhaps this means that DMA mode should be considered, or a threaded irq,
or at least a larger FIFO. Or perhaps smaller kernel logs.

 drivers/tty/serial/qcom_geni_serial.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 9d773a991369..f296a62bd811 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -98,7 +98,6 @@ struct qcom_geni_serial_port {
 	enum geni_se_xfer_mode xfer_mode;
 	bool setup;
 	int (*handle_rx)(struct uart_port *uport, u32 bytes, bool drop);
-	unsigned int xmit_size;
 	unsigned int baud;
 	unsigned int tx_bytes_pw;
 	unsigned int rx_bytes_pw;
@@ -462,7 +461,6 @@ static void qcom_geni_serial_stop_tx(struct uart_port *uport)
 		writel_relaxed(0, uport->membase +
 				     SE_GENI_TX_WATERMARK_REG);
 	}
-	port->xmit_size = 0;
 	writel_relaxed(irq_en, uport->membase + SE_GENI_M_IRQ_EN);
 	status = readl_relaxed(uport->membase + SE_GENI_STATUS);
 	/* Possible stop tx is called multiple times. */
@@ -592,16 +590,13 @@ static void qcom_geni_serial_handle_tx(struct uart_port *uport)
 	chunk = uart_circ_chars_pending(xmit);
 	status = readl_relaxed(uport->membase + SE_GENI_TX_FIFO_STATUS);
 	/* Both FIFO and framework buffer are drained */
-	if (chunk == port->xmit_size && !status) {
-		port->xmit_size = 0;
-		uart_circ_clear(xmit);
+	if (!chunk && !status) {
 		qcom_geni_serial_stop_tx(uport);
 		goto out_write_wakeup;
 	}
-	chunk -= port->xmit_size;
 
 	avail = (port->tx_fifo_depth - port->tx_wm) * port->tx_bytes_pw;
-	tail = (xmit->tail + port->xmit_size) & (UART_XMIT_SIZE - 1);
+	tail = xmit->tail;
 	chunk = min3((size_t)chunk, (size_t)(UART_XMIT_SIZE - tail), avail);
 	if (!chunk)
 		goto out_write_wakeup;
@@ -622,14 +617,16 @@ static void qcom_geni_serial_handle_tx(struct uart_port *uport)
 		iowrite32_rep(uport->membase + SE_GENI_TX_FIFOn, buf, 1);
 
 		i += tx_bytes;
-		tail = (tail + tx_bytes) & (UART_XMIT_SIZE - 1);
+		tail += tx_bytes;
 		uport->icount.tx += tx_bytes;
 		remaining -= tx_bytes;
 	}
+
+	xmit->tail = tail & (UART_XMIT_SIZE - 1);
 	qcom_geni_serial_poll_tx_done(uport);
-	port->xmit_size += chunk;
 out_write_wakeup:
-	uart_write_wakeup(uport);
+	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
+		uart_write_wakeup(uport);
 }
 
 static irqreturn_t qcom_geni_serial_isr(int isr, void *dev)
-- 
2.17.0.441.gb46fe60e1d-goog


Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3339499-1523479928-2-4264838331673906497
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523479927; b=Ni2HpuHtsORG09q9VNPkAm3q156xAguBK500ARgy7ysFPdkKUH
    RONvxHGzfrc/uSuNeWucoEeq4aJ6wy5IPrdES7GgJffa2k8rvlfv5VtazYBcpFl5
    kDcHlnBp6ydlTlWtYpYWlGncpH3kso/iPy5hrKPNDCDvqBAvSz4mA24brplgAsco
    9+0kqXSUHWv+jXkwG4B/TIB7K5c5oHWO5GHtyhm6YsyfdwgRNXMKtGiDPGU4mNn0
    KwRjrDqLESxzmkty36ZqRqQtot4t4MWnGmsI7/WG+EUn36bpfdfN932A0M90Uttq
    gYNNia8PhNnAysz9aGJUC4GEST4rAVXeh9hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523479927; bh=lUCrNVHr6ZVG139dEfVeuzniAZMhiF
    DX5ZU5MXEVIvM=; b=fwkTvO2MW3S3knuSnU2GSWhTpQ/SyJIGFulat+SD1HITNv
    gTgCN6glRm2vQwuX+ETz4qbek1UgNBUWpfZ1lLy55xhynvnwxJlssuyw712synKt
    c2FaAbXCyqE16TNLaZWzTLTlqHdM1QbLmZUoflRO4uGDX0NqifIEbwHiP7gG7kp8
    FRqSEFwojfZyszDFNuNX0PTfitHc3aviZVmilSQnQMEpNM23Fnj//nWcvSHGs4Hh
    M4V6QcgcfWnfw+wVVQs+jEONdmm9uEFUU1rtPJf/zoq1374tgwRCOwqeq3eZNM/d
    fSzBAaXXg5wrGAfGVNsxpcf20uqzWztWRecA/D4A==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfN1iuiw+zOLsCJJKnYSiMML4e5EyF4Ov997R+EKGFTjvJLFGGYhgfFcflrhsDzR7TccEWzUSjWQbhJKwBuO1SmuyfPws6UjugQCLwnNIjvFdfJaYbOhM
    Pm4tYOFCR2/ss2I705JoKKqBL6/ttKpRmg2lVgKbXUah2jPeJhUqlHxfVguH0OVoN2orF/ue74IA3WxyfRX5/xzzjXSMNqyVnd5LlWlZ23ONWrNMJatMSt1A
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=ag1SF4gXAAAA:8 a=yMhMjlubAAAA:8 a=pXsxn4-ixa34lSzHDawA:9 a=QEXdDO2ut3YA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755537AbeDKSpd (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:45:33 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58608 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755500AbeDKSpb (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:45:31 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 048/190] serial: sh-sci: Fix race condition causing garbage during shutdown
Date: Wed, 11 Apr 2018 20:34:54 +0200
Message-Id: <20180411183553.074508354@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geert Uytterhoeven <geert+renesas@glider.be>


[ Upstream commit 1cf4a7efdc71cab84c42cfea7200608711ea954f ]

If DMA is enabled and used, a burst of old data may be seen on the
serial console during "poweroff" or "reboot".  uart_flush_buffer()
clears the circular buffer, but sci_port.tx_dma_len is not reset.
This leads to a circular buffer overflow, dumping (UART_XMIT_SIZE -
sci_port.tx_dma_len) bytes.

To fix this, add a .flush_buffer() callback that resets
sci_port.tx_dma_len.

Inspired by commit 31ca2c63fdc0aee7 ("tty/serial: atmel: fix race
condition (TX+DMA)").

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/sh-sci.c |   16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1457,7 +1457,16 @@ static void sci_free_dma(struct uart_por
 	if (s->chan_rx)
 		sci_rx_dma_release(s, false);
 }
-#else
+
+static void sci_flush_buffer(struct uart_port *port)
+{
+	/*
+	 * In uart_flush_buffer(), the xmit circular buffer has just been
+	 * cleared, so we have to reset tx_dma_len accordingly.
+	 */
+	to_sci_port(port)->tx_dma_len = 0;
+}
+#else /* !CONFIG_SERIAL_SH_SCI_DMA */
 static inline void sci_request_dma(struct uart_port *port)
 {
 }
@@ -1465,7 +1474,9 @@ static inline void sci_request_dma(struc
 static inline void sci_free_dma(struct uart_port *port)
 {
 }
-#endif
+
+#define sci_flush_buffer	NULL
+#endif /* !CONFIG_SERIAL_SH_SCI_DMA */
 
 static irqreturn_t sci_rx_interrupt(int irq, void *ptr)
 {
@@ -2205,6 +2216,7 @@ static struct uart_ops sci_uart_ops = {
 	.break_ctl	= sci_break_ctl,
 	.startup	= sci_startup,
 	.shutdown	= sci_shutdown,
+	.flush_buffer	= sci_flush_buffer,
 	.set_termios	= sci_set_termios,
 	.pm		= sci_pm,
 	.type		= sci_type,

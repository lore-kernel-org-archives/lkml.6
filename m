Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DATE_IN_PAST_96_XX,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65C12C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3517C2175B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:59:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="WSV81ETS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730056AbfBEP7v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 10:59:51 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54925 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729547AbfBEP7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 10:59:51 -0500
Received: by mail-wm1-f66.google.com with SMTP id a62so4197863wmh.4
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 07:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version;
        bh=obC/o0x/Of+oiYvDNo+3FmUgPGJAQl+NE5x85eXAQHI=;
        b=WSV81ETS+kogLHB4BvEl6z/BdttOBfQ9jLyogcbwsk8O19p2eJ0F87NbLRjxhPSY5m
         jru04119WHfN5Ojw0FqEIYDTbm883PI2wFjbPV4qVeN6TE1SfV707mJos0aAAXrdVjGd
         UVZ5O98son0kInTPtFBdl31QBQT018TiJbDlPq7hHUXTPeGDswp1xUuOQQZ8kCCNFzvM
         0jLnZk08zYrCG96BfpERA2AJPeweqEfm5iBeW6P6cOHy5hGmAzVKwOA3hR5EeQ1MzCL6
         DacGQGFQCsj1er9+HxPHY6gwsKFFNujj76py9cyjFI5vhpJzinV5mzWrxZX+qJW771AT
         AZ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version;
        bh=obC/o0x/Of+oiYvDNo+3FmUgPGJAQl+NE5x85eXAQHI=;
        b=I6o5Bf+/JxPM9fGpvyYtbLWWjH1qxiSjnff+deQ8RXS6kriZhav6PPwylqLg+HdZn9
         qP7DXKLbZvRV8r27I/rrZoyqLjU40+NgPGYH9h5gk1xAkY68bzcoMGrYZG+1+9Ym9J7/
         DFW8bdatwiQEMJSxDvL/W7m8o97VK6miLWE6ZfNrJgYbQ1Cq5Qy3y+hLKH8dkk4v/H7h
         iWlE7UBwnZxazbi1Hva/qyvzdRtWpPvRc5lXmAYoFgGU6yJQpZMEUcjb/TyK/F4l9Oup
         YX/dpubcMxvxTBO+8S2GwLJwe2u0GS2BIURKMHz1UC1wzlLLLlyi0aa+KIpFo8bRkSxx
         eCBQ==
X-Gm-Message-State: AHQUAubph1i/rKuGEB+7jOTrEZUG+avXjcnA5woMiX2oCfKnOzxBArNP
        nP5/sH45EFVr80QS/JhnRQ+CGw==
X-Google-Smtp-Source: AHgI3IYSrGj7kHlF8uGsZVxlBXMYAo+pXQSmbx+a+mIkXGS/XNkMYdNI1G7+AD7n1YIQ7vnG8Tm7QQ==
X-Received: by 2002:a1c:d082:: with SMTP id h124mr4071012wmg.21.1549382388516;
        Tue, 05 Feb 2019 07:59:48 -0800 (PST)
Received: from localhost ([2620:10d:c092:180::1:a0f9])
        by smtp.gmail.com with ESMTPSA id s66sm11635832wmf.34.2019.02.05.07.59.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 07:59:47 -0800 (PST)
From:   Julien Masson <jmasson@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] tty: serial: meson_uart: Add support for kernel debugger
Date:   Fri, 1 Feb 2019 08:36:59 +0100
Message-ID: <864l9i1b0t.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kgdb invokes the poll_put_char and poll_get_char when communicating
with the host. This patch implement the serial polling hooks for the
meson_uart to be used for KGDB debugging over serial line.

Signed-off-by: Julien Masson <jmasson@baylibre.com>
---
 drivers/tty/serial/meson_uart.c | 46 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
index 8a84259..49b20da 100644
--- a/drivers/tty/serial/meson_uart.c
+++ b/drivers/tty/serial/meson_uart.c
@@ -426,6 +426,48 @@ static void meson_uart_config_port(struct uart_port *port, int flags)
 	}
 }
 
+#ifdef CONFIG_CONSOLE_POLL
+/*
+ * Console polling routines for writing and reading from the uart while
+ * in an interrupt or debug context (i.e. kgdb).
+ */
+
+static int meson_uart_poll_get_char(struct uart_port *port)
+{
+	u32 c;
+	unsigned long flags;
+
+	spin_lock_irqsave(&port->lock, flags);
+
+	if (readl(port->membase + AML_UART_STATUS) & AML_UART_RX_EMPTY)
+		c = NO_POLL_CHAR;
+	else
+		c = readl(port->membase + AML_UART_RFIFO);
+
+	spin_unlock_irqrestore(&port->lock, flags);
+
+	return c;
+}
+
+static void meson_uart_poll_put_char(struct uart_port *port, unsigned char c)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&port->lock, flags);
+
+	while (!(readl(port->membase + AML_UART_STATUS) & AML_UART_TX_EMPTY))
+		cpu_relax();
+
+	writel(c, port->membase + AML_UART_WFIFO);
+
+	while (!(readl(port->membase + AML_UART_STATUS) & AML_UART_TX_EMPTY))
+		cpu_relax();
+
+	spin_unlock_irqrestore(&port->lock, flags);
+}
+
+#endif /* CONFIG_CONSOLE_POLL */
+
 static const struct uart_ops meson_uart_ops = {
 	.set_mctrl      = meson_uart_set_mctrl,
 	.get_mctrl      = meson_uart_get_mctrl,
@@ -441,6 +483,10 @@ static const struct uart_ops meson_uart_ops = {
 	.request_port	= meson_uart_request_port,
 	.release_port	= meson_uart_release_port,
 	.verify_port	= meson_uart_verify_port,
+#ifdef CONFIG_CONSOLE_POLL
+	.poll_get_char	= meson_uart_poll_get_char,
+	.poll_put_char	= meson_uart_poll_put_char,
+#endif
 };
 
 #ifdef CONFIG_SERIAL_MESON_CONSOLE
-- 
2.7.4


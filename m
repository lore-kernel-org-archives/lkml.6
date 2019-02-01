Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6821C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 09:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97B9D21872
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 09:59:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="WFxTxX2h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727971AbfBAJ7t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 04:59:49 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34077 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726658AbfBAJ7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 04:59:48 -0500
Received: by mail-wm1-f65.google.com with SMTP id y185so4136095wmd.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 01:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=FiRsK6Rkv+MGMGuc5WsI9lDR8qk6mP1jDsr/R3+Ts38=;
        b=WFxTxX2htHocA7ziAHT44X9GHyroRFZDjWeGl1wJQP5WgZTAdioUYL7AwLlxRa+9oi
         AXnG5d/9Ow3QsJ8GuJY9qOKf+TmSSaJ0R9sfV4DP7GGMJRm7qShUFKai2LHQ5YSxrQuM
         CsBE1upw4E+gsy0xlCjinyoGDI5qjRqtztdCg8WdbIvUg74jgu0jiQeOP0N3dtxEc2VU
         CQbYzv6c4KMLK4X3cpmMDs2je/nlYTURMtGg9hVt8F8CX4J/YAbVr69VFk+gwYG9etE0
         ze9YmdPz43NLDBeEdn59w+RspCFrmgiVVItaF9nUEJn85ndX5hKDu50u/gQUbYYMc9G3
         pj1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FiRsK6Rkv+MGMGuc5WsI9lDR8qk6mP1jDsr/R3+Ts38=;
        b=kJRIJxrTKzi8GWDaDgJIY0SvNSRMN+hjozD0uHsxs/zi9CB1hokgv7Ndv5y0rkPUD3
         dMpnTsxIUHOd3ooqXuIhP5FZp7bplfNcycPWtl33WH/S+Hxz1Wia0R7DpV1Ta30tmhOh
         2B6ZTVwZ/BLVtlS/BB7KHST9ewhVgutQyMmUReDP8WptqUb5yYhTtIijCtEjt4A6GoMJ
         kP/ww+5HX3BzN9ZrBJa3Khkrobc+JQSAGJueAfFzeTJB6fAXc0OkIN78PzbqclJetI5o
         kCHmcc1Gwbs+h/yIkXyWOCglq7AUZX8Uu+F/a9Tmj8eSaOZOHWhrI0Febytjv0dGfxUL
         o5pw==
X-Gm-Message-State: AHQUAuYasCLyjqncgp8kbEVoDRJlUQ43vMBg07tvMIhrtfTIS8xo7qTX
        eJExcPJEbph+ttu7OZf1ls/isA==
X-Google-Smtp-Source: AHgI3IZgN68Dd4TBWQgMN1xSpOyT80n1YWlSjhqNutRu+Ll1aJ8L4L4uKbHKRMLLEoQS8bP4SueW6w==
X-Received: by 2002:a1c:7fca:: with SMTP id a193mr1724626wmd.36.1549015186690;
        Fri, 01 Feb 2019 01:59:46 -0800 (PST)
Received: from julienm-ubuntu-20JES0UQ00.home ([2a01:cb1d:333:ad00:9812:3ac:b5fb:9a4e])
        by smtp.gmail.com with ESMTPSA id 129sm4086575wmd.18.2019.02.01.01.59.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 01 Feb 2019 01:59:45 -0800 (PST)
From:   Julien Masson <jmasson@baylibre.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Julien Masson <jmasson@baylibre.com>, Jiri Slaby <jslaby@suse.com>,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] tty: serial: meson_uart: Add support for kernel debugger
Date:   Fri,  1 Feb 2019 10:59:22 +0100
Message-Id: <1549015162-17418-1-git-send-email-jmasson@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kgdb invokes the poll_put_char and poll_get_char when communicating
with the host. This patch implement the serial polling hooks for the
meson_uart to be used for KGDB debugging over serial line.

Signed-off-by: Julien Masson <jmasson@baylibre.com>
---
It has been tested on "Le Potato" board:
https://libre.computer/products/boards/aml-s905x-cc/

Kernel command line arguments:
kgdboc=ttyAML0,115200 kgdbretry=4 nokaslr kgdbcon

Kernel modules:
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_KERNEL=y
CONFIG_FRAME_POINTER=y
CONFIG_KGDB=y
CONFIG_KGDB_SERIAL_CONSOLE=y

Warning: for single step instruction I had to apply this patch:
https://lore.kernel.org/patchwork/patch/562423/

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


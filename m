Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E662AC282C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1DF2218D3
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:30:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="E/G1eVpc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbfBGRaS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 12:30:18 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41011 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726742AbfBGRaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 12:30:16 -0500
Received: by mail-ed1-f68.google.com with SMTP id p15so534789edy.8
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 09:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version;
        bh=goV4oeui+QjZXGASbWEnmi9tnJ5aRRm3TV6+qGVkZCw=;
        b=E/G1eVpclGbPqa6wEwR+w2v8D7LjGwl1tAIfNRowttC7eNOQpkPu667FDpDXYrNELx
         5QCX2dVTrTZAu3VHSS9v+/14Q4WKrnAktZHQnCYhQ9zBaPPPCYy9otw/JYxe/dwQq2n1
         pbNLeVX7sgvao51xy6MK8X5Jz3EWf1YxW0Nju7yEqa7N0LhU7Ji2ExddPoPXbJtKiaIS
         C3q7393v1NxEk8BRT/i5rsTfe5VLQs5ZGYMBdVXZNCf3FMGV0d2HfSXa5yoMzVsLCtsN
         fjs2CJXo59KZTAgbsHExzLwyNorAH2U6mcTEhqaxjIWdMbJ4Q+1IISoBjmkkhzDbX3zZ
         yPEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version;
        bh=goV4oeui+QjZXGASbWEnmi9tnJ5aRRm3TV6+qGVkZCw=;
        b=nWu0K8nWqv0uxB28K0Md/9AMCWkiLHR4wGRrqY2tt9dAOXvZcMoLvRM9c2H3FMCEJQ
         iF3/w7QasLlLwWBo+KynsSGRDrRILHkpP/ZpAPVrgBUvY+EkklYR0Oyu2rqYOAe5Udrr
         SXTiFpVPsl7pz8py5DfQToF1qvTvqHlWrehCQIDJ55krkoZntPBvDg/u0J/h26wyEbTF
         FXotpNlmgwt7UmWxwEciUnJ8EgRO5s+Wwfy4bRC7ikEKDQXq2DEmVyORMO3XFjBhtUm8
         P5mjVOjjKdkBmHRPxdC8QdeAT24rchuUW5PoKWM5P+wcPGl3voFZvj3lWlY8Hu1HgWCE
         UFLw==
X-Gm-Message-State: AHQUAubWmRN62CRSH+fQoFQPGp9uZ42iAWU5dmb4ubTspy6YOzwGU57G
        b/RI3AFmK9ZtHFL/saqD68sY9w==
X-Google-Smtp-Source: AHgI3Ia1KW0iSGh1qbZtY6aDlkL1lwFh8uSLrKbWxO0couClL/4F1IkZWaqSpRyPGLODpi3nwn7HSg==
X-Received: by 2002:a17:906:12cf:: with SMTP id l15mr7724322ejb.31.1549560614919;
        Thu, 07 Feb 2019 09:30:14 -0800 (PST)
Received: from localhost ([2620:10d:c092:180::1:a0f9])
        by smtp.gmail.com with ESMTPSA id w27sm4275214eje.76.2019.02.07.09.30.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 09:30:13 -0800 (PST)
From:   Julien Masson <jmasson@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        Jiri Slaby <jslaby@suse.com>,
        Julien Masson <jmasson@baylibre.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] tty: serial: meson_uart: Add support for kernel debugger
Date:   Thu,  7 Feb 2019 18:11:29 +0100
Message-ID: <86k1ibv74r.fsf@baylibre.com>
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

Changes since v1 [0]:
* Use readl_poll_timeout_atomic instead of looping with read + cpu_relax
  -> read every 5 usecs during 1 msec
* add some comments

[0]: https://lore.kernel.org/lkml/1549015162-17418-1-git-send-email-jmasson@baylibre.com

 drivers/tty/serial/meson_uart.c | 65 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
index 8a84259..bcff572 100644
--- a/drivers/tty/serial/meson_uart.c
+++ b/drivers/tty/serial/meson_uart.c
@@ -14,6 +14,7 @@
 #include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/of.h>
@@ -75,6 +76,8 @@
 #define AML_UART_PORT_NUM		6
 #define AML_UART_DEV_NAME		"ttyAML"
 
+#define AML_UART_POLL_USEC		5
+#define AML_UART_TIMEOUT_USEC		1000
 
 static struct uart_driver meson_uart_driver;
 
@@ -426,6 +429,64 @@ static void meson_uart_config_port(struct uart_port *port, int flags)
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
+	u32 reg;
+	int ret;
+
+	spin_lock_irqsave(&port->lock, flags);
+
+	/* Wait until FIFO is empty or timeout */
+	ret = readl_poll_timeout_atomic(port->membase + AML_UART_STATUS, reg,
+					reg & AML_UART_TX_EMPTY,
+					AML_UART_POLL_USEC,
+					AML_UART_TIMEOUT_USEC);
+	if (ret == -ETIMEDOUT) {
+		dev_err(port->dev, "Timeout waiting for UART TX EMPTY\n");
+		goto out;
+	}
+
+	/* Write the character */
+	writel(c, port->membase + AML_UART_WFIFO);
+
+	/* Wait until FIFO is empty or timeout */
+	ret = readl_poll_timeout_atomic(port->membase + AML_UART_STATUS, reg,
+					reg & AML_UART_TX_EMPTY,
+					AML_UART_POLL_USEC,
+					AML_UART_TIMEOUT_USEC);
+	if (ret == -ETIMEDOUT)
+		dev_err(port->dev, "Timeout waiting for UART TX EMPTY\n");
+
+out:
+	spin_unlock_irqrestore(&port->lock, flags);
+}
+
+#endif /* CONFIG_CONSOLE_POLL */
+
 static const struct uart_ops meson_uart_ops = {
 	.set_mctrl      = meson_uart_set_mctrl,
 	.get_mctrl      = meson_uart_get_mctrl,
@@ -441,6 +502,10 @@ static const struct uart_ops meson_uart_ops = {
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


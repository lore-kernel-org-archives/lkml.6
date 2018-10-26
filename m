Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A5CBC6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 11:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2E60207DD
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 11:17:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RY9+BIsr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2E60207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbeJZTxj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 15:53:39 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42944 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727666AbeJZTxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 15:53:37 -0400
Received: by mail-wr1-f66.google.com with SMTP id y15-v6so929619wru.9;
        Fri, 26 Oct 2018 04:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t0SsqNzZTENUg3cef2avj+k6dlilGRNUZUBNqnDuQY8=;
        b=RY9+BIsrumY8ePdidBrujhUl2GfBZrj+XUj/pshWioPizS435NzMLIm+bSMPsF3Rnc
         Pugj6QgPDzReqgvBkwXILinJFp05pjDxAx+U2uHiTMFXqZSBou++Zr//7oE9ytgQciFd
         bl1F/fhuJQJ4F/kLJ6IAmuQdOBIHFKmDx3ptNjB24+OGUsCpVBobHxLswleumQpbcKq4
         NyhOGtQhSSLTiqPNp30/gnOF7GYt3eZPb3gDJVgmlymf9wbF5ckqlFreuiiE1cpmAhHv
         SiwA+kC2TIGPvjEo3z3xgQ3J91ZU9WCGypva8J5t60setY5FiwhfnsP3gOyEvC+PUHqz
         Avhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t0SsqNzZTENUg3cef2avj+k6dlilGRNUZUBNqnDuQY8=;
        b=WmZSswf1L62NkpvkrleIMXtzbZLbfeyK/AnE+4j8L41OqeJHQ/ltQOBxzCzM9qQDtn
         jAqf7jCIGTz4AiUYmmwgBYjhmyYHPggxl5QaKYKYFc638rKxfYFWnCQfWWWbNbpCAD1t
         ttqvKzB1noZrcykuB91rrWGLE9gagIUgW+hS+AwFf5AHx7yJpvtTdX1+TquczDiI+KGt
         BF0bn8QMD8MBfckE7fOnngXwLQsO3tMmnav7xwt1K78CTUOT5uutSVGH+hFfzqua806/
         WIIfqkQvrQb2Lzt1dC80y6HGedXXZY7OxFIcIqpkt/v2Lksg+BNkTvNH5SiTv9lc6Ab+
         JJ7g==
X-Gm-Message-State: AGRZ1gL0/Rb4Utg7DYl5jwYLNncYtpO75sMkwscPREKUs+dCCwbcbEkF
        TB2ahLrKzwtJqjSeGLxAGL0=
X-Google-Smtp-Source: AJdET5feOeZcPaKS2eIVrNMlwRa/X0gvfisQPWEgQsufsxoRWfud4mZc3DzMzfEtDNnDhF0JRVLxeg==
X-Received: by 2002:a5d:620b:: with SMTP id y11-v6mr5216349wru.105.1540552613320;
        Fri, 26 Oct 2018 04:16:53 -0700 (PDT)
Received: from localhost (pD9E511F8.dip0.t-ipconnect.de. [217.229.17.248])
        by smtp.gmail.com with ESMTPSA id z185-v6sm6601402wmz.47.2018.10.26.04.16.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Oct 2018 04:16:52 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Timo Alho <talho@nvidia.com>, Pekka Pessi <ppessi@nvidia.com>,
        Mika Liljeberg <mliljeberg@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 7/9] serial: Add Tegra Combined UART driver
Date:   Fri, 26 Oct 2018 13:16:36 +0200
Message-Id: <20181026111638.10759-8-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181026111638.10759-1-thierry.reding@gmail.com>
References: <20181026111638.10759-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

The Tegra Combined UART (TCU) is a mailbox-based mechanism that allows
multiplexing multiple "virtual UARTs" into a single hardware serial
port. The TCU is the primary serial port on Tegra194 devices.

Add a TCU driver utilizing the mailbox framework, as the used mailboxes
are part of Tegra HSP blocks that are already controlled by the Tegra
HSP mailbox driver.

Based on work by  Mikko Perttunen <mperttunen@nvidia.com>.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/tty/serial/Kconfig       |  22 +++
 drivers/tty/serial/Makefile      |   1 +
 drivers/tty/serial/tegra-tcu.c   | 299 +++++++++++++++++++++++++++++++
 include/uapi/linux/serial_core.h |   3 +
 4 files changed, 325 insertions(+)
 create mode 100644 drivers/tty/serial/tegra-tcu.c

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 32886c304641..785306388aa4 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -323,6 +323,28 @@ config SERIAL_TEGRA
 	  are enabled). This driver uses the APB DMA to achieve higher baudrate
 	  and better performance.
 
+config SERIAL_TEGRA_TCU
+	tristate "NVIDIA Tegra Combined UART"
+	depends on ARCH_TEGRA && TEGRA_HSP_MBOX
+	select SERIAL_CORE
+	help
+	  Support for the mailbox-based TCU (Tegra Combined UART) serial port.
+	  TCU is a virtual serial port that allows multiplexing multiple data
+	  streams into a single hardware serial port.
+
+config SERIAL_TEGRA_TCU_CONSOLE
+	bool "Support for console on a Tegra TCU serial port"
+	depends on SERIAL_TEGRA_TCU=y
+	select SERIAL_CORE_CONSOLE
+	default y
+	---help---
+	  If you say Y here, it will be possible to use a the Tegra TCU as the
+	  system console (the system console is the device which receives all
+	  kernel messages and warnings and which allows logins in single user
+	  mode).
+
+	  If unsure, say Y.
+
 config SERIAL_MAX3100
 	tristate "MAX3100 support"
 	depends on SPI
diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
index daac675612df..4ad82231ff8a 100644
--- a/drivers/tty/serial/Makefile
+++ b/drivers/tty/serial/Makefile
@@ -76,6 +76,7 @@ obj-$(CONFIG_SERIAL_LANTIQ)	+= lantiq.o
 obj-$(CONFIG_SERIAL_XILINX_PS_UART) += xilinx_uartps.o
 obj-$(CONFIG_SERIAL_SIRFSOC) += sirfsoc_uart.o
 obj-$(CONFIG_SERIAL_TEGRA) += serial-tegra.o
+obj-$(CONFIG_SERIAL_TEGRA_TCU) += tegra-tcu.o
 obj-$(CONFIG_SERIAL_AR933X)   += ar933x_uart.o
 obj-$(CONFIG_SERIAL_EFM32_UART) += efm32-uart.o
 obj-$(CONFIG_SERIAL_ARC)	+= arc_uart.o
diff --git a/drivers/tty/serial/tegra-tcu.c b/drivers/tty/serial/tegra-tcu.c
new file mode 100644
index 000000000000..1d360cd03b18
--- /dev/null
+++ b/drivers/tty/serial/tegra-tcu.c
@@ -0,0 +1,299 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018, NVIDIA CORPORATION.  All rights reserved.
+ */
+
+#include <linux/console.h>
+#include <linux/mailbox_client.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/serial.h>
+#include <linux/serial_core.h>
+#include <linux/slab.h>
+#include <linux/tty.h>
+#include <linux/tty_flip.h>
+
+#define TCU_MBOX_BYTE(i, x)			((x) << (i * 8))
+#define TCU_MBOX_BYTE_V(x, i)			(((x) >> (i * 8)) & 0xff)
+#define TCU_MBOX_NUM_BYTES(x)			((x) << 24)
+#define TCU_MBOX_NUM_BYTES_V(x)			(((x) >> 24) & 0x3)
+
+struct tegra_tcu {
+	struct uart_driver driver;
+#if IS_ENABLED(CONFIG_SERIAL_TEGRA_TCU_CONSOLE)
+	struct console console;
+#endif
+	struct uart_port port;
+
+	struct mbox_client tx_client, rx_client;
+	struct mbox_chan *tx, *rx;
+};
+
+static unsigned int tegra_tcu_uart_tx_empty(struct uart_port *port)
+{
+	return TIOCSER_TEMT;
+}
+
+static void tegra_tcu_uart_set_mctrl(struct uart_port *port, unsigned int mctrl)
+{
+}
+
+static unsigned int tegra_tcu_uart_get_mctrl(struct uart_port *port)
+{
+	return 0;
+}
+
+static void tegra_tcu_uart_stop_tx(struct uart_port *port)
+{
+}
+
+static void tegra_tcu_write_one(struct tegra_tcu *tcu, u32 value,
+			       unsigned int count)
+{
+	void *msg;
+
+	value |= TCU_MBOX_NUM_BYTES(count);
+	msg = (void *)(unsigned long)value;
+	mbox_send_message(tcu->tx, msg);
+}
+
+static void tegra_tcu_write(struct tegra_tcu *tcu, const char *s,
+			    unsigned int count)
+{
+	unsigned int written = 0, i = 0;
+	bool insert_nl = false;
+	u32 value = 0;
+
+	while (i < count) {
+		if (insert_nl) {
+			value |= TCU_MBOX_BYTE(written++, '\n');
+			insert_nl = false;
+			i++;
+		} else if (s[i] == '\n') {
+			value |= TCU_MBOX_BYTE(written++, '\r');
+			insert_nl = true;
+		} else {
+			value |= TCU_MBOX_BYTE(written++, s[i++]);
+		}
+
+		if (written == 3) {
+			tegra_tcu_write_one(tcu, value, 3);
+			value = written = 0;
+		}
+	}
+
+	if (written)
+		tegra_tcu_write_one(tcu, value, written);
+}
+
+static void tegra_tcu_uart_start_tx(struct uart_port *port)
+{
+	struct tegra_tcu *tcu = port->private_data;
+	struct circ_buf *xmit = &port->state->xmit;
+	unsigned long count;
+
+	for (;;) {
+		count = CIRC_CNT_TO_END(xmit->head, xmit->tail, UART_XMIT_SIZE);
+		if (!count)
+			break;
+
+		tegra_tcu_write(tcu, &xmit->buf[xmit->tail], count);
+		xmit->tail = (xmit->tail + count) & (UART_XMIT_SIZE - 1);
+	}
+
+	uart_write_wakeup(port);
+}
+
+static void tegra_tcu_uart_stop_rx(struct uart_port *port)
+{
+}
+
+static void tegra_tcu_uart_break_ctl(struct uart_port *port, int ctl)
+{
+}
+
+static int tegra_tcu_uart_startup(struct uart_port *port)
+{
+	return 0;
+}
+
+static void tegra_tcu_uart_shutdown(struct uart_port *port)
+{
+}
+
+static void tegra_tcu_uart_set_termios(struct uart_port *port,
+				       struct ktermios *new,
+				       struct ktermios *old)
+{
+}
+
+static const struct uart_ops tegra_tcu_uart_ops = {
+	.tx_empty = tegra_tcu_uart_tx_empty,
+	.set_mctrl = tegra_tcu_uart_set_mctrl,
+	.get_mctrl = tegra_tcu_uart_get_mctrl,
+	.stop_tx = tegra_tcu_uart_stop_tx,
+	.start_tx = tegra_tcu_uart_start_tx,
+	.stop_rx = tegra_tcu_uart_stop_rx,
+	.break_ctl = tegra_tcu_uart_break_ctl,
+	.startup = tegra_tcu_uart_startup,
+	.shutdown = tegra_tcu_uart_shutdown,
+	.set_termios = tegra_tcu_uart_set_termios,
+};
+
+#if IS_ENABLED(CONFIG_SERIAL_TEGRA_TCU_CONSOLE)
+static void tegra_tcu_console_write(struct console *cons, const char *s,
+				    unsigned int count)
+{
+	struct tegra_tcu *tcu = container_of(cons, struct tegra_tcu, console);
+
+	tegra_tcu_write(tcu, s, count);
+}
+
+static int tegra_tcu_console_setup(struct console *cons, char *options)
+{
+	return 0;
+}
+#endif
+
+static void tegra_tcu_receive(struct mbox_client *cl, void *msg)
+{
+	struct tegra_tcu *tcu = container_of(cl, struct tegra_tcu, rx_client);
+	struct tty_port *port = &tcu->port.state->port;
+	u32 value = (u32)(unsigned long)msg;
+	unsigned int num_bytes, i;
+
+	num_bytes = TCU_MBOX_NUM_BYTES_V(value);
+
+	for (i = 0; i < num_bytes; i++)
+		tty_insert_flip_char(port, TCU_MBOX_BYTE_V(value, i),
+				     TTY_NORMAL);
+
+	tty_flip_buffer_push(port);
+}
+
+static int tegra_tcu_probe(struct platform_device *pdev)
+{
+	struct uart_port *port;
+	struct tegra_tcu *tcu;
+	int err;
+
+	tcu = devm_kzalloc(&pdev->dev, sizeof(*tcu), GFP_KERNEL);
+	if (!tcu)
+		return -ENOMEM;
+
+	tcu->tx_client.dev = &pdev->dev;
+	tcu->tx_client.tx_block = true;
+	tcu->tx_client.tx_tout = 10000;
+	tcu->rx_client.dev = &pdev->dev;
+	tcu->rx_client.rx_callback = tegra_tcu_receive;
+
+	tcu->tx = mbox_request_channel_byname(&tcu->tx_client, "tx");
+	if (IS_ERR(tcu->tx)) {
+		err = PTR_ERR(tcu->tx);
+		dev_err(&pdev->dev, "failed to get tx mailbox: %d\n", err);
+		return err;
+	}
+
+	tcu->rx = mbox_request_channel_byname(&tcu->rx_client, "rx");
+	if (IS_ERR(tcu->rx)) {
+		err = PTR_ERR(tcu->rx);
+		dev_err(&pdev->dev, "failed to get rx mailbox: %d\n", err);
+		goto free_tx;
+	}
+
+#if IS_ENABLED(CONFIG_SERIAL_TEGRA_TCU_CONSOLE)
+	/* setup the console */
+	strcpy(tcu->console.name, "ttyTCU");
+	tcu->console.device = uart_console_device;
+	tcu->console.flags = CON_PRINTBUFFER | CON_ANYTIME;
+	tcu->console.index = -1;
+	tcu->console.write = tegra_tcu_console_write;
+	tcu->console.setup = tegra_tcu_console_setup;
+	tcu->console.data = &tcu->driver;
+#endif
+
+	/* setup the driver */
+	tcu->driver.owner = THIS_MODULE;
+	tcu->driver.driver_name = "tegra-tcu";
+	tcu->driver.dev_name = "ttyTCU";
+#if IS_ENABLED(CONFIG_SERIAL_TEGRA_TCU_CONSOLE)
+	tcu->driver.cons = &tcu->console;
+#endif
+	tcu->driver.nr = 1;
+
+	err = uart_register_driver(&tcu->driver);
+	if (err) {
+		dev_err(&pdev->dev, "failed to register UART driver: %d\n",
+			err);
+		goto free_rx;
+	}
+
+	/* setup the port */
+	port = &tcu->port;
+	spin_lock_init(&port->lock);
+	port->dev = &pdev->dev;
+	port->type = PORT_TEGRA_TCU;
+	port->ops = &tegra_tcu_uart_ops;
+	port->fifosize = 1;
+	port->iotype = UPIO_MEM;
+	port->flags = UPF_BOOT_AUTOCONF;
+	port->private_data = tcu;
+
+	err = uart_add_one_port(&tcu->driver, port);
+	if (err) {
+		dev_err(&pdev->dev, "failed to add UART port: %d\n", err);
+		goto unregister_uart;
+	}
+
+	platform_set_drvdata(pdev, tcu);
+#if IS_ENABLED(CONFIG_SERIAL_TEGRA_TCU_CONSOLE)
+	register_console(&tcu->console);
+#endif
+
+	return 0;
+
+unregister_uart:
+	uart_unregister_driver(&tcu->driver);
+free_rx:
+	mbox_free_channel(tcu->rx);
+free_tx:
+	mbox_free_channel(tcu->tx);
+
+	return err;
+}
+
+static int tegra_tcu_remove(struct platform_device *pdev)
+{
+	struct tegra_tcu *tcu = platform_get_drvdata(pdev);
+
+#if IS_ENABLED(CONFIG_SERIAL_TEGRA_TCU_CONSOLE)
+	unregister_console(&tcu->console);
+#endif
+	uart_remove_one_port(&tcu->driver, &tcu->port);
+	uart_unregister_driver(&tcu->driver);
+	mbox_free_channel(tcu->rx);
+	mbox_free_channel(tcu->tx);
+
+	return 0;
+}
+
+static const struct of_device_id tegra_tcu_match[] = {
+	{ .compatible = "nvidia,tegra194-tcu" },
+	{ }
+};
+
+static struct platform_driver tegra_tcu_driver = {
+	.driver = {
+		.name = "tegra-tcu",
+		.of_match_table = tegra_tcu_match,
+	},
+	.probe = tegra_tcu_probe,
+	.remove = tegra_tcu_remove,
+};
+module_platform_driver(tegra_tcu_driver);
+
+MODULE_AUTHOR("Mikko Perttunen <mperttunen@nvidia.com>");
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("NVIDIA Tegra Combined UART driver");
diff --git a/include/uapi/linux/serial_core.h b/include/uapi/linux/serial_core.h
index dce5f9dae121..69883c32cb98 100644
--- a/include/uapi/linux/serial_core.h
+++ b/include/uapi/linux/serial_core.h
@@ -79,6 +79,9 @@
 /* Nuvoton UART */
 #define PORT_NPCM	40
 
+/* NVIDIA Tegra Combined UART */
+#define PORT_TEGRA_TCU	41
+
 /* Intel EG20 */
 #define PORT_PCH_8LINE	44
 #define PORT_PCH_2LINE	45
-- 
2.19.1


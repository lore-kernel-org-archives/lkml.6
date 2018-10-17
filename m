Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D0BC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 04:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12857214AB
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 04:08:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g04BJ9IU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12857214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbeJQMCd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 08:02:33 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36337 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbeJQMCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 08:02:32 -0400
Received: by mail-pf1-f196.google.com with SMTP id l81-v6so12517853pfg.3;
        Tue, 16 Oct 2018 21:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4stslWU+EEwvDZ3xE3sxRnC1pusElVxcNLfHFTcmLrs=;
        b=g04BJ9IUXwuU1IPBx67OcMT+ad0S6MRtUsUfVj1a21R1AtfKLqGYD/f01NnYNSoEsD
         HML3ZSokijbywBkjcUsDbfLtEuChmTm4N5+1PJZS0EF7EaD8qmWvoH84fnekVOOrPyjH
         ZSBBmavlgQOrtTWO2WaFwUSCc+dZuw7oCFVQXWOn9q7ycPrfXEIdfwSJ+xdwahpkYoGE
         XhTLn1QmajTe757VEXuSDVYye6u2rnRypt0N223llHuzj7qFyLnJI0shtGFr0NMjdby8
         TihLDcwCx7RUbyA8WCFrcZ0CQ3mP/U1hw7EWTrvhSFE+bmEc21NEW/QW2jbIoA1+r7tf
         S0Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4stslWU+EEwvDZ3xE3sxRnC1pusElVxcNLfHFTcmLrs=;
        b=Pw1dFtRxf9JYVDjPdfNWY5vzJqZ37Z1wPNpvVAXqQH5r+TBFUvyAgMaU3FMg2Dmz20
         8ZfGotfwnE1ns4FuHdGpm2h+mRdqgT6nQUy3LeDsebixu+L2lTDDcn+lFf6d8Xgdg39s
         SmYIb1J5Z9Wxf5VvCFBwDIX1If1szpWvkw1zCmO2I3A+wxWthuSE72UcsGatexbPMu2B
         P4r4Ol/8x8O9E3Zeyu/ScnkuBms30zZ7P9TjCu/CAqmRVXcya+eAgnrcF1LqGn8C7wC6
         jB8QYwXw6sc/s+/AtsSq1BGMThSUWCl5a19v4nmP6zUt1SCqSRZbAa5tcniIaIbOlG2c
         LAMg==
X-Gm-Message-State: ABuFfohvL4kPs+yqe5s9l92RMnnYxR0X2ho3o+5enpkSXOCiFyYvDWPM
        Uc9ddDSi+bb9dufiRTzJMmk=
X-Google-Smtp-Source: ACcGV62IHxW/2jUB2abPk3/GmNAf6BLdXM/JdZafZYdHtSOImoKCd+tKmOAse8hR9PN74Lq/EgUKdA==
X-Received: by 2002:a63:e05:: with SMTP id d5-v6mr22755830pgl.272.1539749330132;
        Tue, 16 Oct 2018 21:08:50 -0700 (PDT)
Received: from Pilot130.192.168.0.22 (211-20-114-70.HINET-IP.hinet.net. [211.20.114.70])
        by smtp.googlemail.com with ESMTPSA id i21-v6sm20998554pgj.55.2018.10.16.21.08.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 16 Oct 2018 21:08:49 -0700 (PDT)
From:   "sudheer.v" <open.sudheer@gmail.com>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Russell King <linux@armlinux.org.uk>,
        Dan Williams <dan.j.williams@intel.com>,
        Jiri Slaby <jslaby@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Michael Moese <mmoese@suse.de>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org
Cc:     "sudheer.v" <open.sudheer@gmail.com>,
        Sudheer V <sudheer.veliseti@aspeedtech.com>,
        ShivahShankar Shakarnarayan rao 
        <shivahshankar.shankarnarayanrao@aspeedtech.com>
Subject: [[PATCH] 8/9] DMA-UART-Driver-for-AST2500
Date:   Wed, 17 Oct 2018 09:41:05 +0530
Message-Id: <1539749466-3912-9-git-send-email-open.sudheer@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1539749466-3912-1-git-send-email-open.sudheer@gmail.com>
References: <1539749466-3912-1-git-send-email-open.sudheer@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: sudheer.v <open.sudheer@gmail.com>
---
 drivers/tty/serial/8250/8250_aspeed_uart_dma.c | 1594 ++++++++++++++++++++++++
 1 file changed, 1594 insertions(+)
 create mode 100644 drivers/tty/serial/8250/8250_aspeed_uart_dma.c

diff --git a/drivers/tty/serial/8250/8250_aspeed_uart_dma.c b/drivers/tty/serial/8250/8250_aspeed_uart_dma.c
new file mode 100644
index 0000000..e1019a8
--- /dev/null
+++ b/drivers/tty/serial/8250/8250_aspeed_uart_dma.c
@@ -0,0 +1,1594 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *   drivers/tty/serial/8250/8250_aspeed_uart_dma.c
+ *    1. 2018/07/01 Shivah Shankar created
+ *    2. 2018/08/25 sudheer.veliseti<open.sudheer@gmail.com> modified
+ *
+ */
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/ioport.h>
+#include <linux/init.h>
+#include <linux/console.h>
+#include<linux/slab.h>
+#include <linux/delay.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/tty.h>
+#include <linux/tty_flip.h>
+#include <linux/serial_reg.h>
+#include <linux/serial_core.h>
+#include <linux/serial.h>
+#include <linux/serial_8250.h>
+#include <linux/nmi.h>
+#include <linux/mutex.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <asm/irq.h>
+
+#include "8250.h"
+#include <linux/dma-mapping.h>
+#define SDMA_RX_BUFF_SIZE                               0x10000 //65536
+#define DMA_BUFF_SIZE                           0x1000  //4096
+
+
+
+
+#undef UART_XMIT_SIZE
+#define UART_XMIT_SIZE	0x1000
+#define UART_RX_SIZE	0x10000
+
+#ifdef UART_DMA_DEBUG
+	#define UART_DBG(fmt, args...) pr_debug("%s() " fmt, __func__, ## args)
+#else
+	#define UART_DBG(fmt, args...)
+#endif
+
+#ifdef CONFIG_UART_TX_DMA_DEBUG
+	#define UART_TX_DBG(fmt, args...) pr_debug("%s()"fmt, __func__, ## args)
+#else
+	#define UART_TX_DBG(fmt, args...)
+#endif
+
+/*
+ * Configuration:
+ *   share_irqs - whether we pass IRQF_SHARED to request_irq().  This option
+ *                is unsafe when used on edge-triggered interrupts.
+ */
+static unsigned int share_irqs = SERIAL8250_SHARE_IRQS;
+
+static unsigned int nr_uarts = CONFIG_AST_RUNTIME_DMA_UARTS;
+
+/*
+ * Debugging.
+ */
+#if 0
+#define DEBUG_AUTOCONF(fmt...)	UART_DBG(fmt)
+#else
+#define DEBUG_AUTOCONF(fmt...)	do { } while (0)
+#endif
+
+#if 0
+#define DEBUG_INTR(fmt...)	UART_DBG(fmt)
+#else
+#define DEBUG_INTR(fmt...)	do { } while (0)
+#endif
+
+#define PASS_LIMIT	256
+
+#include <asm/serial.h>
+
+
+#define UART_DMA_NR		CONFIG_AST_NR_DMA_UARTS
+
+struct ast_uart_port {
+	struct uart_port	port;
+	struct platform_device	*pdev;
+	unsigned short		capabilities;	/* port capabilities */
+	unsigned short		bugs;		/* port bugs */
+	unsigned int		tx_loadsz;	/* transmit fifo load size */
+	unsigned char		acr;
+	unsigned char		ier;
+	unsigned char		lcr;
+	unsigned char		mcr;
+	unsigned char		mcr_mask;	/* mask of user bits */
+	unsigned char		mcr_force;	/* mask of forced bits */
+	unsigned int		channel_no;
+	struct scatterlist	rx_sgl;
+	struct dma_chan		*rx_dma_chan;
+	struct circ_buf		rx_dma_buf;
+	dma_addr_t		dma_rx_addr;
+	u8			rx_in_progress;
+	struct dma_async_tx_descriptor		*rx_dma_desc;
+	dma_cookie_t		rx_cookie;
+	unsigned int		rx_bytes_requested;
+	unsigned int		rx_bytes_transferred;
+	struct tasklet_struct	rx_tasklet;
+	struct scatterlist	tx_sgl;
+	struct dma_chan		*tx_dma_chan;
+	struct circ_buf		tx_dma_buf;
+	dma_addr_t		dma_tx_addr;
+	u8			tx_in_progress;
+	struct dma_async_tx_descriptor		*tx_dma_desc;
+	dma_cookie_t		tx_cookie;
+	unsigned int		tx_bytes_requested;
+	unsigned int		tx_bytes_transferred;
+	struct tasklet_struct	tx_tasklet;
+	spinlock_t lock;
+	int			tx_done;
+	int			tx_count;
+	/*
+	 * Some bits in registers are cleared on a read, so they must
+	 * be saved whenever the register is read but the bits will not
+	 * be immediately processed.
+	 */
+#define LSR_SAVE_FLAGS UART_LSR_BRK_ERROR_BITS
+	unsigned char		lsr_saved_flags;
+#define MSR_SAVE_FLAGS UART_MSR_ANY_DELTA
+	unsigned char		msr_saved_flags;
+
+	/*
+	 * We provide a per-port pm hook.
+	 */
+	void			(*pm)(struct uart_port *port,
+				      unsigned int state, unsigned int old);
+};
+
+static struct ast_uart_port ast_uart_ports[UART_DMA_NR];
+
+static int ast_dma_channel_setup(struct ast_uart_port *up);
+static inline struct ast_uart_port *
+to_ast_dma_uart_port(struct uart_port *uart)
+{
+	return container_of(uart, struct ast_uart_port, port);
+}
+
+struct irq_info {
+	spinlock_t		lock;
+	struct ast_uart_port *up;
+};
+
+static void ast_dma_channel_teardown(struct ast_uart_port *s);
+static struct irq_info ast_uart_irq[1];
+static DEFINE_MUTEX(ast_uart_mutex);
+
+/*
+ * Here we define the default xmit fifo size used for each type of UART.
+ */
+static const struct serial8250_config uart_config[] = {
+	[PORT_UNKNOWN] = {
+		.name		= "unknown",
+		.fifo_size	= 1,
+		.tx_loadsz	= 1,
+	},
+	[PORT_8250] = {
+		.name		= "8250",
+		.fifo_size	= 1,
+		.tx_loadsz	= 1,
+	},
+	[PORT_16450] = {
+		.name		= "16450",
+		.fifo_size	= 1,
+		.tx_loadsz	= 1,
+	},
+	[PORT_16550] = {
+		.name		= "16550",
+		.fifo_size	= 1,
+		.tx_loadsz	= 1,
+	},
+	[PORT_16550A] = {
+		.name		= "16550A",
+		.fifo_size	= 16,
+		.tx_loadsz	= 16,
+		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10
+							| UART_FCR_DMA_SELECT,
+		.flags		= UART_CAP_FIFO,
+	},
+};
+
+/* sane hardware needs no mapping */
+#define map_8250_in_reg(up, offset) (offset)
+#define map_8250_out_reg(up, offset) (offset)
+
+static void ast_uart_unregister_port(int line);
+static int ast_uart_register_port(struct uart_port *port,
+					unsigned int channel_no);
+
+static unsigned int ast_serial_in(struct ast_uart_port *up, int offset)
+{
+	offset = map_8250_in_reg(up, offset) << up->port.regshift;
+
+		return readb(up->port.membase + offset);
+}
+
+static void
+ast_serial_out(struct ast_uart_port *up, int offset, int value)
+{
+	/* Save the offset before it's remapped */
+	offset = map_8250_out_reg(up, offset) << up->port.regshift;
+
+		writeb(value, up->port.membase + offset);
+}
+
+
+/*
+ * We used to support using pause I/O for certain machines.  We
+ * haven't supported this for a while, but just in case it's badly
+ * needed for certain old 386 machines, I've left these #define's
+ * in....
+ */
+#define serial_inp(up, offset)		ast_serial_in(up, offset)
+#define serial_outp(up, offset, value)	ast_serial_out(up, offset, value)
+
+/* Uart divisor latch read */
+static inline int _serial_dl_read(struct ast_uart_port *up)
+{
+	return serial_inp(up, UART_DLL) | serial_inp(up, UART_DLM) << 8;
+}
+
+/* Uart divisor latch write */
+static inline void _serial_dl_write(struct ast_uart_port *up, int value)
+{
+	serial_outp(up, UART_DLL, value & 0xff);
+	serial_outp(up, UART_DLM, value >> 8 & 0xff);
+}
+
+#define serial_dl_read(up) _serial_dl_read(up)
+#define serial_dl_write(up, value) _serial_dl_write(up, value)
+
+static void ast_uart_tx_dma_complete(void *args);
+
+static int ast_uart_start_tx_dma(struct ast_uart_port *up,
+		unsigned long count)
+{
+	struct circ_buf *xmit = &up->port.state->xmit;
+	dma_addr_t tx_phys_addr;
+
+	UART_DBG("Entered %s count is %d\n", __func__, count);
+	UART_DBG("up->tx_cookie = %d\n", up->tx_cookie);
+	if (up->tx_cookie == 0) {
+		dma_sync_single_for_device(up->port.dev, up->dma_tx_addr,
+						UART_XMIT_SIZE, DMA_TO_DEVICE);
+	tx_phys_addr = up->dma_tx_addr + xmit->tail;
+	UART_DBG("Transmit address is %x actual is %x\n", tx_phys_addr,
+							up->dma_tx_addr);
+	up->tx_dma_desc = dmaengine_prep_slave_single(up->tx_dma_chan,
+		tx_phys_addr, count, DMA_MEM_TO_DEV, DMA_PREP_INTERRUPT);
+	if (!up->tx_dma_desc) {
+		dev_err(up->port.dev, "Not able to get desc for Tx\n");
+		return -EIO;
+	}
+
+	up->tx_dma_desc->callback = ast_uart_tx_dma_complete;
+	up->tx_dma_desc->callback_param = up;
+	up->tx_in_progress = 1;
+	up->tx_bytes_requested = count;
+	up->tx_bytes_transferred = 0;
+	up->tx_cookie = dmaengine_submit(up->tx_dma_desc);
+	}
+	dma_async_issue_pending(up->tx_dma_chan);
+	return 0;
+}
+static void ast_uart_start_next_tx(struct ast_uart_port *up)
+{
+	unsigned long count;
+	struct circ_buf *xmit = &up->port.state->xmit;
+
+	count = CIRC_CNT_TO_END(xmit->head, xmit->tail, UART_XMIT_SIZE);
+	if (count)
+		ast_uart_start_tx_dma(up, count);
+}
+static void ast_uart_tx_sdma_tasklet_func(unsigned long data)
+{
+	struct ast_uart_port *up = ((struct ast_uart_port *)data);
+	struct circ_buf *xmit = &up->port.state->xmit;
+	unsigned long flags = 0;
+
+	UART_DBG("In %s bytes to send is %d\n", __func__, CIRC_CNT(xmit->head,
+	spin_lock_irqsave(&up->port.lock, flags);
+					    xmit->tail, UART_XMIT_SIZE));
+	if (!uart_circ_empty(xmit) && !up->tx_in_progress) {
+		UART_DBG("Calling ast_uart_start_next_tx\n");
+		ast_uart_start_next_tx(up);
+	}
+	spin_unlock_irqrestore(&up->port.lock, flags);
+}
+
+static void ast_uart_tx_dma_complete(void *args)
+{
+	struct ast_uart_port *up = args;
+	struct circ_buf *xmit = &up->port.state->xmit;
+	struct dma_tx_state state;
+	unsigned long flags;
+	unsigned int count;
+	enum dma_status status;
+
+	status = dmaengine_tx_status(up->tx_dma_chan, up->tx_cookie, &state);
+	UART_DBG("%s:state.residue=%d\n", __func__, state.residue);
+	UART_DBG("up->tx_bytes_requested=%d up->tx_bytes_transferred=%d\n",
+			    up->tx_bytes_requested, up->tx_bytes_transferred);
+	if (status == DMA_COMPLETE) {
+		up->tx_cookie = 0;
+		count = up->tx_bytes_requested - up->tx_bytes_transferred;
+		UART_DBG("DMA_COMPLETE:bytes till end of Buffer=%d\n", count);
+	} else{
+		count = up->tx_bytes_requested - state.residue;
+		up->tx_bytes_transferred += count;
+		UART_DBG("DMA_not_COMPLETE: count=%d\n", count);
+	}
+	UART_DBG("up->tx_bytes_requested=%d up->tx_bytes_transferred=%d\n",
+			    up->tx_bytes_requested, up->tx_bytes_transferred);
+	UART_DBG("xmit->head=%d and xmit->tail=%d\n", xmit->head, xmit->tail);
+	async_tx_ack(up->tx_dma_desc);
+	spin_lock_irqsave(&up->port.lock, flags);
+	xmit->tail = (xmit->tail + count) & (UART_XMIT_SIZE - 1);
+	up->tx_in_progress = 0;
+	UART_DBG("updated xmit->head=%d and xmit->tail=%d\n",
+					    xmit->head, xmit->tail);
+	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
+		uart_write_wakeup(&up->port);
+	ast_uart_start_next_tx(up);
+	spin_unlock_irqrestore(&up->port.lock, flags);
+}
+
+static void ast_uart_rx_sdma_tasklet_func(unsigned long data);
+static void ast_uart_rx_dma_complete(void *args)
+{
+	struct ast_uart_port *up = args;
+	struct dma_tx_state state;
+	struct circ_buf *rx_ring = &up->rx_dma_buf;
+	unsigned int count;
+	unsigned int temp = 0;
+	enum dma_status status;
+
+	UART_DBG("line [%d],head = %d, len : %d\n",
+				up->port.line, up->rx_dma_buf.head, count);
+	status = dmaengine_tx_status(up->rx_dma_chan, up->rx_cookie, &state);
+	UART_DBG("Freespace in buffer=%d\n", state.residue);
+	UART_DBG("up->rx_bytes_requested=%d up->rx_bytes_transferred=%d\n",
+			    up->rx_bytes_requested, up->rx_bytes_transferred);
+	if (status == DMA_COMPLETE) {
+		up->rx_cookie = 0;
+		count = up->rx_bytes_requested - up->rx_bytes_transferred;
+		up->rx_in_progress = 0;
+		UART_DBG("DMA_COMPLETE:bytes till end of Buffer=%d\n", count);
+	} else{
+		temp = up->rx_bytes_requested - state.residue;
+		count = temp - up->rx_bytes_transferred;
+		up->rx_bytes_transferred = temp;
+		UART_DBG("DMA_not_COMPLETE:fill index =%d\n", temp, count);
+		UART_DBG("bytes to be rxed in current lap=%d\n", count);
+		UART_DBG("rx_bytes_transfred=%d\n", up->rx_bytes_transferred);
+	}
+
+	UART_DBG("rx_ring->head=%d rx_ring->tail=%d\n",
+				    rx_ring->head, rx_ring->tail);
+	rx_ring->head = (rx_ring->head + count) & (UART_RX_SIZE - 1);
+	UART_DBG("updated rx_ring->head=%d rx_ring->tail=%d\n",
+					rx_ring->head, rx_ring->tail);
+	ast_uart_rx_sdma_tasklet_func((unsigned long)up);
+}
+
+static int ast_uart_start_rx_dma(struct ast_uart_port *up,
+					unsigned long count)
+{
+	struct circ_buf *rx_ring = &up->rx_dma_buf;
+	dma_addr_t rx_phys_addr;
+
+	UART_DBG("%s:up->rx_dma_chan= %d\n", __func__, up->rx_dma_chan);
+	UART_DBG("up->rx_cookie = %d\n", up->rx_cookie);
+	if (up->rx_cookie == 0) {
+		dma_sync_single_for_device(up->port.dev, up->dma_rx_addr,
+					UART_RX_SIZE, DMA_FROM_DEVICE);
+		rx_phys_addr = up->dma_rx_addr + rx_ring->tail;
+		up->rx_dma_desc = dmaengine_prep_slave_single(up->rx_dma_chan,
+		rx_phys_addr, UART_RX_SIZE, DMA_DEV_TO_MEM, DMA_PREP_INTERRUPT);
+		if (!up->rx_dma_desc) {
+			dev_err(up->port.dev, "Not able to get desc for Rx\n");
+			return -EIO;
+		}
+		up->rx_dma_desc->callback = ast_uart_rx_dma_complete;
+		up->rx_dma_desc->callback_param = up;
+		up->rx_in_progress = 1;
+		up->rx_bytes_requested = UART_RX_SIZE;
+		up->rx_bytes_transferred = 0;
+		up->rx_cookie = dmaengine_submit(up->rx_dma_desc);
+	}
+	dma_async_issue_pending(up->rx_dma_chan);
+	return 0;
+}
+
+static void ast_uart_rx_sdma_tasklet_func(unsigned long data)
+{
+	struct ast_uart_port *up = ((struct ast_uart_port *)data);
+	struct tty_port *port = &up->port.state->port;
+	struct circ_buf *rx_ring = &up->rx_dma_buf;
+	unsigned long flags;
+	int count;
+	int copy = 0;
+
+	UART_DBG("line [%d], rx_ring->head = %d, rx_ring->tail = %d\n",
+			    up->port.line, rx_ring->head, rx_ring->tail);
+	spin_lock_irqsave(&up->port.lock, flags);
+	if (rx_ring->head > rx_ring->tail) {
+		count = rx_ring->head - rx_ring->tail;
+		UART_DBG("^^^^ count=%d rx_ring->head=%d rx_ring->tail=%d\n",
+					count, rx_ring->head, rx_ring->tail);
+		copy = tty_insert_flip_string(port,
+					rx_ring->buf + rx_ring->tail, count);
+	} else if (rx_ring->head < rx_ring->tail) {
+		count = SDMA_RX_BUFF_SIZE - rx_ring->tail;
+		UART_DBG("rollovr:count=%d rx_ring->head=%d rx_ring->tail=%d\n",
+				    count, rx_ring->head, rx_ring->tail);
+		copy = tty_insert_flip_string(port,
+					rx_ring->buf + rx_ring->tail, count);
+	} else {
+		count = 0;
+	}
+	if (copy != count)
+		UART_DBG("!!!!!!!! ERROR 111\n");
+	if (count) {
+		UART_DBG("count = %d\n", count);
+		rx_ring->tail += count;
+		rx_ring->tail &= (SDMA_RX_BUFF_SIZE - 1);
+		up->port.icount.rx += count;
+		tty_flip_buffer_push(port);
+		spin_unlock_irqrestore(&up->port.lock, flags);
+		ast_uart_start_rx_dma(up, count);
+		spin_lock_irqsave(&up->port.lock, flags);
+	}
+	spin_unlock_irqrestore(&up->port.lock, flags);
+}
+
+/*
+ * FIFO support.
+ */
+static inline void serial8250_clear_fifos(struct ast_uart_port *p)
+{
+	serial_outp(p, UART_FCR, UART_FCR_ENABLE_FIFO);
+	serial_outp(p, UART_FCR, UART_FCR_ENABLE_FIFO |
+		       UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT);
+	serial_outp(p, UART_FCR, 0);
+}
+
+/*
+ * This routine is called by rs_init() to initialize a specific serial
+ * port.
+ */
+static void autoconfig(struct ast_uart_port *up)
+{
+	unsigned long flags;
+
+	UART_DBG("line [%d]\n", up->port.line);
+	if (!up->port.iobase && !up->port.mapbase && !up->port.membase)
+		return;
+
+	DEBUG_AUTOCONF("ttyDMA%d: autoconf (0x%04x, 0x%p): ",
+			up->port.line, up->port.iobase, up->port.membase);
+
+	spin_lock_irqsave(&up->port.lock, flags);
+
+	up->capabilities = 0;
+	up->bugs = 0;
+
+	up->port.type = PORT_16550A;
+	up->capabilities |= UART_CAP_FIFO;
+
+	up->port.fifosize = uart_config[up->port.type].fifo_size;
+	up->capabilities = uart_config[up->port.type].flags;
+	up->tx_loadsz = uart_config[up->port.type].tx_loadsz;
+
+	if (up->port.type == PORT_UNKNOWN)
+		goto out;
+
+	/*
+	 * Reset the UART.
+	 */
+	serial8250_clear_fifos(up);
+	ast_serial_in(up, UART_RX);
+	serial_outp(up, UART_IER, 0);
+
+ out:
+	spin_unlock_irqrestore(&up->port.lock, flags);
+	DEBUG_AUTOCONF("type=%s\n", uart_config[up->port.type].name);
+}
+
+
+static inline void __stop_tx(struct ast_uart_port *p)
+{
+	if (p->ier & UART_IER_THRI) {
+		p->ier &= ~UART_IER_THRI;
+		ast_serial_out(p, UART_IER, p->ier);
+	}
+}
+
+static void serial8250_stop_tx(struct uart_port *port)
+{
+	struct ast_uart_port *up = to_ast_dma_uart_port(port);
+	struct circ_buf *xmit = &up->port.state->xmit;
+	struct dma_tx_state state;
+	unsigned int count;
+
+	__stop_tx(up);
+	if (!up->tx_in_progress)
+		return;
+	dmaengine_terminate_all(up->tx_dma_chan);
+	dmaengine_tx_status(up->tx_dma_chan, up->tx_cookie, &state);
+	count = up->tx_bytes_requested - state.residue;
+	async_tx_ack(up->tx_dma_desc);
+	xmit->tail = (xmit->tail + count) & (UART_XMIT_SIZE - 1);
+	up->tx_in_progress = 0;
+}
+
+static void transmit_chars(struct ast_uart_port *up);
+
+static void serial8250_start_tx(struct uart_port *port)
+{
+	struct ast_uart_port *up = to_ast_dma_uart_port(port);
+	struct circ_buf *xmit = &up->port.state->xmit;
+
+	UART_DBG("\n%s:line %d", __func__, port->line);
+	UART_TX_DBG("line [%d]\n", port->line);
+	if (!uart_circ_empty(xmit) && !up->tx_in_progress) {
+		UART_DBG("Calling ast_uart_start_next_tx\n");
+		ast_uart_start_next_tx(up);
+	}
+}
+
+static void serial8250_stop_rx(struct uart_port *port)
+{
+	struct ast_uart_port *up = to_ast_dma_uart_port(port);
+	struct dma_tx_state state;
+
+	up->ier &= ~UART_IER_RLSI;
+	up->port.read_status_mask &= ~UART_LSR_DR;
+	ast_serial_out(up, UART_IER, up->ier);
+	if (!up->rx_in_progress)
+		return;
+	dmaengine_terminate_all(up->rx_dma_chan);
+	dmaengine_tx_status(up->rx_dma_chan, up->rx_cookie, &state);
+	up->rx_in_progress = 0;
+	up->rx_bytes_transferred = 0;
+}
+
+static void serial8250_enable_ms(struct uart_port *port)
+{
+	struct ast_uart_port *up = to_ast_dma_uart_port(port);
+
+	UART_DBG("line [%d]\n", port->line);
+	up->ier |= UART_IER_MSI;
+	ast_serial_out(up, UART_IER, up->ier);
+}
+
+static void transmit_chars(struct ast_uart_port *up)
+{
+	struct circ_buf *xmit = &up->port.state->xmit;
+	int count;
+
+	if (up->port.x_char) {
+		serial_outp(up, UART_TX, up->port.x_char);
+		up->port.icount.tx++;
+		up->port.x_char = 0;
+		return;
+	}
+	if (uart_tx_stopped(&up->port)) {
+		serial8250_stop_tx(&up->port);
+		return;
+	}
+	if (uart_circ_empty(xmit)) {
+		__stop_tx(up);
+		return;
+	}
+
+	count = up->tx_loadsz;
+	do {
+		ast_serial_out(up, UART_TX, xmit->buf[xmit->tail]);
+		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
+		up->port.icount.tx++;
+		if (uart_circ_empty(xmit))
+			break;
+	} while (--count > 0);
+
+	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
+		uart_write_wakeup(&up->port);
+
+	if (uart_circ_empty(xmit))
+		__stop_tx(up);
+}
+
+static unsigned int check_modem_status(struct ast_uart_port *up)
+{
+	unsigned int status = ast_serial_in(up, UART_MSR);
+
+	UART_DBG("line [%d]\n", up->port.line);
+	status |= up->msr_saved_flags;
+	up->msr_saved_flags = 0;
+	if (status & UART_MSR_ANY_DELTA && up->ier & UART_IER_MSI &&
+					    up->port.state != NULL) {
+		if (status & UART_MSR_TERI)
+			up->port.icount.rng++;
+		if (status & UART_MSR_DDSR)
+			up->port.icount.dsr++;
+		if (status & UART_MSR_DDCD)
+			uart_handle_dcd_change(&up->port,
+							status & UART_MSR_DCD);
+		if (status & UART_MSR_DCTS)
+			uart_handle_cts_change(&up->port,
+							status & UART_MSR_CTS);
+		wake_up_interruptible(&up->port.state->port.delta_msr_wait);
+	}
+	return status;
+}
+
+/*
+ * This handles the interrupt from one port.
+ */
+static inline void
+serial8250_handle_port(struct ast_uart_port *up)
+{
+	unsigned int status;
+	unsigned long flags;
+
+	spin_lock_irqsave(&up->port.lock, flags);
+
+	status = serial_inp(up, UART_LSR);
+
+	DEBUG_INTR("status = %x...", status);
+
+	check_modem_status(up);
+	if (status & UART_LSR_THRE)
+		transmit_chars(up);
+
+	spin_unlock_irqrestore(&up->port.lock, flags);
+}
+
+/*
+ * This is the serial driver's interrupt routine.
+ */
+static irqreturn_t ast_uart_interrupt(int irq, void *dev_id)
+{
+	struct irq_info *i = dev_id;
+	int pass_counter = 0, handled = 0, end = 0;
+
+	DEBUG_INTR("(%d) ", irq);
+	spin_lock(&i->lock);
+	do {
+		struct ast_uart_port *up;
+		unsigned int iir;
+
+		up = (struct ast_uart_port *)(i->up);
+		iir = ast_serial_in(up, UART_IIR);
+		if (!(iir & UART_IIR_NO_INT)) {
+			serial8250_handle_port(up);
+			handled = 1;
+		} else
+			end = 1;
+
+		if (pass_counter++ > PASS_LIMIT) {
+			/* If we hit this, we're dead. */
+			UART_DBG(KERN_ERR
+			  "ast-uart-dma:too much work for irqi%d", irq);
+			break;
+		}
+	} while (end);
+
+	spin_unlock(&i->lock);
+
+	DEBUG_INTR("end.\n");
+
+	return IRQ_RETVAL(handled);
+}
+
+static unsigned int serial8250_tx_empty(struct uart_port *port)
+{
+	struct ast_uart_port *up = to_ast_dma_uart_port(port);
+	unsigned long flags;
+	unsigned int lsr;
+
+	UART_TX_DBG("line [%d]\n", up->port.line);
+
+	spin_lock_irqsave(&up->port.lock, flags);
+	lsr = ast_serial_in(up, UART_LSR);
+	up->lsr_saved_flags |= lsr & LSR_SAVE_FLAGS;
+	spin_unlock_irqrestore(&up->port.lock, flags);
+
+	return lsr & UART_LSR_TEMT ? TIOCSER_TEMT : 0;
+}
+
+static unsigned int serial8250_get_mctrl(struct uart_port *port)
+{
+	struct ast_uart_port *up = to_ast_dma_uart_port(port);
+	unsigned int status;
+	unsigned int ret;
+
+	status = check_modem_status(up);
+
+	ret = 0;
+	if (status & UART_MSR_DCD)
+		ret |= TIOCM_CAR;
+	if (status & UART_MSR_RI)
+		ret |= TIOCM_RNG;
+	if (status & UART_MSR_DSR)
+		ret |= TIOCM_DSR;
+	if (status & UART_MSR_CTS)
+		ret |= TIOCM_CTS;
+	return ret;
+}
+
+static void serial8250_set_mctrl(struct uart_port *port, unsigned int mctrl)
+{
+	struct ast_uart_port *up = to_ast_dma_uart_port(port);
+	unsigned char mcr = 0;
+	//UART_DBG("serial8250_set_mctrl %x\n",mctrl);
+	//TODO .... Issue for fix ......
+	mctrl = 0;
+
+	if (mctrl & TIOCM_RTS)
+		mcr |= UART_MCR_RTS;
+	if (mctrl & TIOCM_DTR)
+		mcr |= UART_MCR_DTR;
+	if (mctrl & TIOCM_OUT1)
+		mcr |= UART_MCR_OUT1;
+	if (mctrl & TIOCM_OUT2)
+		mcr |= UART_MCR_OUT2;
+	if (mctrl & TIOCM_LOOP)
+		mcr |= UART_MCR_LOOP;
+
+	mcr = (mcr & up->mcr_mask) | up->mcr_force | up->mcr;
+
+	ast_serial_out(up, UART_MCR, mcr);
+}
+
+static void serial8250_break_ctl(struct uart_port *port, int break_state)
+{
+	struct ast_uart_port *up = to_ast_dma_uart_port(port);
+	unsigned long flags;
+
+	spin_lock_irqsave(&up->port.lock, flags);
+	if (break_state == -1)
+		up->lcr |= UART_LCR_SBC;
+	else
+		up->lcr &= ~UART_LCR_SBC;
+	ast_serial_out(up, UART_LCR, up->lcr);
+	spin_unlock_irqrestore(&up->port.lock, flags);
+}
+
+static int serial8250_startup(struct uart_port *port)
+{
+	struct ast_uart_port *up = to_ast_dma_uart_port(port);
+	//TX DMA
+	struct circ_buf *xmit = &up->port.state->xmit;
+	unsigned long flags;
+	unsigned char lsr, iir;
+	int retval;
+	struct dma_slave_config dma_sconfig;
+	int irq_flags = up->port.flags & UPF_SHARE_IRQ ? IRQF_SHARED : 0;
+
+	up->capabilities = uart_config[up->port.type].flags;
+	up->mcr = 0;
+	/*
+	 * Clear the FIFO buffers and disable them.
+	 * (they will be reenabled in set_termios())
+	 */
+	serial8250_clear_fifos(up);
+	UART_DBG("1: line [%d]\n", port->line);
+
+	/*
+	 * Clear the interrupt registers.
+	 */
+	(void) serial_inp(up, UART_LSR);
+	(void) serial_inp(up, UART_RX);
+	(void) serial_inp(up, UART_IIR);
+	(void) serial_inp(up, UART_MSR);
+
+	ast_uart_irq[0].up = up;
+	retval = request_irq(up->port.irq, ast_uart_interrupt,
+				 irq_flags, "ast-uart-dma", ast_uart_irq);
+	if (retval)
+		return retval;
+
+	/*
+	 * Now, initialize the UART
+	 */
+	serial_outp(up, UART_LCR, UART_LCR_WLEN8);
+
+	spin_lock_irqsave(&up->port.lock, flags);
+	up->port.mctrl |= TIOCM_OUT2;
+
+	serial8250_set_mctrl(&up->port, up->port.mctrl);
+
+	/*
+	 * Do a quick test to see if we receive an
+	 * interrupt when we enable the TX irq.
+	 */
+	serial_outp(up, UART_IER, UART_IER_THRI);
+	lsr = ast_serial_in(up, UART_LSR);
+	iir = ast_serial_in(up, UART_IIR);
+	serial_outp(up, UART_IER, 0);
+
+	if (lsr & UART_LSR_TEMT && iir & UART_IIR_NO_INT) {
+		if (!(up->bugs & UART_BUG_TXEN)) {
+			up->bugs |= UART_BUG_TXEN;
+			UART_DBG("ttyDMA%d - enabling bad tx status\n",
+				 port->line);
+		}
+	} else {
+		up->bugs &= ~UART_BUG_TXEN;
+	}
+
+	spin_unlock_irqrestore(&up->port.lock, flags);
+
+	/*
+	 * Clear the interrupt registers again for luck, and clear the
+	 * saved flags to avoid getting false values from polling
+	 * routines or the previous session.
+	 */
+	serial_inp(up, UART_LSR);
+	serial_inp(up, UART_RX);
+	serial_inp(up, UART_IIR);
+	serial_inp(up, UART_MSR);
+	up->lsr_saved_flags = 0;
+	up->msr_saved_flags = 0;
+
+	//RX DMA
+	up->rx_dma_buf.head = 0;
+	up->rx_dma_buf.tail = 0;
+	up->port.icount.rx = 0;
+	ast_dma_channel_setup(up);
+	up->rx_dma_buf.buf = dma_alloc_coherent(port->dev, UART_RX_SIZE,
+					&up->dma_rx_addr, GFP_KERNEL);
+	if (!up->rx_dma_buf.buf)
+		ast_dma_channel_teardown(up);
+#if 1
+	memset(&dma_sconfig, 0, sizeof(struct dma_slave_config));
+	dma_sconfig.dst_addr = up->dma_rx_addr;
+	dma_sconfig.dst_port_window_size = UART_RX_SIZE;
+	dma_sconfig.dst_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
+	dma_sconfig.dst_maxburst = 4;
+	dma_sconfig.slave_id = up->channel_no;
+
+	dmaengine_slave_config(up->rx_dma_chan, &dma_sconfig);
+
+	//ast_uart_start_rx_dma(up, UART_RX_SIZE);
+	dma_sync_single_for_device(up->port.dev, up->dma_rx_addr,
+			UART_RX_SIZE, DMA_FROM_DEVICE);
+
+	up->rx_dma_desc = dmaengine_prep_slave_single(up->rx_dma_chan,
+			up->dma_rx_addr, UART_RX_SIZE, DMA_DEV_TO_MEM,
+			DMA_PREP_INTERRUPT);
+	if (!up->rx_dma_desc) {
+		dev_err(up->port.dev, "Not able to get desc for Rx\n");
+		return -EIO;
+	}
+	up->rx_dma_desc->callback = ast_uart_rx_dma_complete;
+	up->rx_dma_desc->callback_param = up;
+	up->rx_in_progress = 1;
+	up->rx_bytes_requested = UART_RX_SIZE;
+	up->rx_cookie = dmaengine_submit(up->rx_dma_desc);
+#endif
+
+	memset(&dma_sconfig, 0, sizeof(struct dma_slave_config));
+
+	up->tx_done = 1;
+	up->tx_count = 0;
+	up->tx_dma_buf.head = 0;
+	up->tx_dma_buf.tail = 0;
+	up->tx_dma_buf.buf = xmit->buf;
+	UART_DBG("head:0x%x tail:0x%x\n", xmit->head, xmit->tail);
+	xmit->head = 0;
+	xmit->tail = 0;
+
+	up->dma_tx_addr = dma_map_single(port->dev,
+				       up->tx_dma_buf.buf,
+				       UART_XMIT_SIZE,
+				       DMA_TO_DEVICE);
+#if 1
+	dma_sconfig.src_addr = up->dma_tx_addr;
+	dma_sconfig.src_port_window_size = UART_XMIT_SIZE;
+	dma_sconfig.src_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
+	dma_sconfig.src_maxburst = 4;
+	dma_sconfig.slave_id = up->channel_no;
+	dmaengine_slave_config(up->tx_dma_chan, &dma_sconfig);
+#endif
+	//STOP and TRIGGER is done in SDMA driver
+	return 0;
+}
+
+static void serial8250_shutdown(struct uart_port *port)
+{
+	struct ast_uart_port *up = to_ast_dma_uart_port(port);
+	unsigned long flags;
+
+	up->ier = 0;
+	serial_outp(up, UART_IER, 0);
+
+	spin_lock_irqsave(&up->port.lock, flags);
+	up->port.mctrl &= ~TIOCM_OUT2;
+
+	serial8250_set_mctrl(&up->port, up->port.mctrl);
+	spin_unlock_irqrestore(&up->port.lock, flags);
+
+	/*
+	 * Disable break condition and FIFOs
+	 */
+	ast_serial_out(up, UART_LCR, serial_inp(up, UART_LCR) & ~UART_LCR_SBC);
+	serial8250_clear_fifos(up);
+
+	(void) ast_serial_in(up, UART_RX);
+
+	up->rx_in_progress = 0;
+	up->tx_in_progress = 0;
+	dma_release_channel(up->rx_dma_chan);
+	dma_release_channel(up->tx_dma_chan);
+	dma_free_coherent(port->dev, UART_RX_SIZE,
+					up->rx_dma_buf.buf, up->dma_rx_addr);
+	dma_unmap_single(port->dev, up->dma_tx_addr,
+					UART_XMIT_SIZE, DMA_TO_DEVICE);
+	up->rx_dma_chan = NULL;
+	up->tx_dma_chan = NULL;
+	up->dma_rx_addr = 0;
+	up->dma_rx_addr = 0;
+	//Tx buffer will free by serial_core.c
+	free_irq(up->port.irq, ast_uart_irq);
+}
+
+static unsigned int serial8250_get_divisor(struct uart_port *port,
+							unsigned int baud)
+{
+	unsigned int quot;
+
+	quot = uart_get_divisor(port, baud);
+	return quot;
+}
+
+static void
+serial8250_set_termios(struct uart_port *port, struct ktermios *termios,
+		       struct ktermios *old)
+{
+	struct ast_uart_port *up = to_ast_dma_uart_port(port);
+	unsigned char cval, fcr = 0;
+	unsigned long flags;
+	unsigned int baud, quot;
+
+	switch (termios->c_cflag & CSIZE) {
+	case CS5:
+		cval = UART_LCR_WLEN5;
+		break;
+	case CS6:
+		cval = UART_LCR_WLEN6;
+		break;
+	case CS7:
+		cval = UART_LCR_WLEN7;
+		break;
+	default:
+	case CS8:
+		cval = UART_LCR_WLEN8;
+		break;
+	}
+
+	if (termios->c_cflag & CSTOPB)
+		cval |= UART_LCR_STOP;
+	if (termios->c_cflag & PARENB)
+		cval |= UART_LCR_PARITY;
+	if (!(termios->c_cflag & PARODD))
+		cval |= UART_LCR_EPAR;
+#ifdef CMSPAR
+	if (termios->c_cflag & CMSPAR)
+		cval |= UART_LCR_SPAR;
+#endif
+
+	/*
+	 * Ask the core to calculate the divisor for us.
+	 */
+	baud = uart_get_baud_rate(port, termios, old, 0, port->uartclk/16);
+	quot = serial8250_get_divisor(port, baud);
+
+	if (up->capabilities & UART_CAP_FIFO && up->port.fifosize > 1) {
+		if (baud < 2400)
+			fcr = UART_FCR_ENABLE_FIFO | UART_FCR_TRIGGER_1;
+		else
+			fcr = uart_config[up->port.type].fcr;
+	}
+
+	/*
+	 * Ok, we're now changing the port state.  Do it with
+	 * interrupts disabled.
+	 */
+	spin_lock_irqsave(&up->port.lock, flags);
+
+	/*
+	 * Update the per-port timeout.
+	 */
+	uart_update_timeout(port, termios->c_cflag, baud);
+
+	up->port.read_status_mask = UART_LSR_OE | UART_LSR_THRE | UART_LSR_DR;
+	if (termios->c_iflag & INPCK)
+		up->port.read_status_mask |= UART_LSR_FE | UART_LSR_PE;
+	if (termios->c_iflag & (BRKINT | PARMRK))
+		up->port.read_status_mask |= UART_LSR_BI;
+
+	/*
+	 * Characteres to ignore
+	 */
+	up->port.ignore_status_mask = 0;
+	if (termios->c_iflag & IGNPAR)
+		up->port.ignore_status_mask |= UART_LSR_PE | UART_LSR_FE;
+	if (termios->c_iflag & IGNBRK) {
+		up->port.ignore_status_mask |= UART_LSR_BI;
+		/*
+		 * If we're ignoring parity and break indicators,
+		 * ignore overruns too (for real raw support).
+		 */
+		if (termios->c_iflag & IGNPAR)
+			up->port.ignore_status_mask |= UART_LSR_OE;
+	}
+
+	/*
+	 * ignore all characters if CREAD is not set
+	 */
+	if ((termios->c_cflag & CREAD) == 0)
+		up->port.ignore_status_mask |= UART_LSR_DR;
+
+	/*
+	 * CTS flow control flag and modem status interrupts
+	 */
+	up->ier &= ~UART_IER_MSI;
+	if (UART_ENABLE_MS(&up->port, termios->c_cflag))
+		up->ier |= UART_IER_MSI;
+
+	ast_serial_out(up, UART_IER, up->ier);
+
+
+	serial_outp(up, UART_LCR, cval | UART_LCR_DLAB);/* set DLAB */
+
+	serial_dl_write(up, quot);
+
+	/*
+	 * LCR DLAB must be set to enable 64-byte FIFO mode. If the FCR
+	 * is written without DLAB set, this mode will be disabled.
+	 */
+
+	serial_outp(up, UART_LCR, cval);		/* reset DLAB */
+	up->lcr = cval;					/* Save LCR */
+		if (fcr & UART_FCR_ENABLE_FIFO) {
+			/* emulated UARTs (Lucent Venus 167x) need two steps */
+			serial_outp(up, UART_FCR, UART_FCR_ENABLE_FIFO);
+		}
+		serial_outp(up, UART_FCR, fcr);		/* set fcr */
+	serial8250_set_mctrl(&up->port, up->port.mctrl);
+	spin_unlock_irqrestore(&up->port.lock, flags);
+	/* Don't rewrite B0 */
+	if (tty_termios_baud_rate(termios))
+		tty_termios_encode_baud_rate(termios, baud, baud);
+}
+
+static void
+serial8250_pm(struct uart_port *port, unsigned int state,
+	      unsigned int oldstate)
+{
+	struct ast_uart_port *p = (struct ast_uart_port *)port;
+
+	if (p->pm)
+		p->pm(port, state, oldstate);
+}
+
+/*
+ * Resource handling.
+ */
+static int serial8250_request_std_resource(struct ast_uart_port *up)
+{
+	unsigned int size = 8 << up->port.regshift;
+	int ret = 0;
+
+	if (!up->port.mapbase)
+		return ret;
+
+	if (!request_mem_region(up->port.mapbase, size, "ast-uart-dma")) {
+		ret = -EBUSY;
+		return ret;
+	}
+
+	if (up->port.flags & UPF_IOREMAP) {
+		up->port.membase = ioremap_nocache(up->port.mapbase, size);
+		if (!up->port.membase) {
+			release_mem_region(up->port.mapbase, size);
+			ret = -ENOMEM;
+			return ret;
+		}
+	}
+	return ret;
+}
+
+static void serial8250_release_std_resource(struct ast_uart_port *up)
+{
+	unsigned int size = 8 << up->port.regshift;
+
+		if (!up->port.mapbase)
+			return;
+
+		if (up->port.flags & UPF_IOREMAP) {
+			iounmap(up->port.membase);
+			up->port.membase = NULL;
+		}
+
+		release_mem_region(up->port.mapbase, size);
+}
+
+
+static void serial8250_release_port(struct uart_port *port)
+{
+	struct ast_uart_port *up = (struct ast_uart_port *)port;
+
+	serial8250_release_std_resource(up);
+}
+
+static int serial8250_request_port(struct uart_port *port)
+{
+	struct ast_uart_port *up = (struct ast_uart_port *)port;
+	int ret = 0;
+
+	ret = serial8250_request_std_resource(up);
+	if (ret == 0)
+		serial8250_release_std_resource(up);
+
+	return ret;
+}
+
+static void serial8250_config_port(struct uart_port *port, int flags)
+{
+	struct ast_uart_port *up = (struct ast_uart_port *)port;
+	int ret;
+
+	/*
+	 * Find the region that we can probe for.  This in turn
+	 * tells us whether we can probe for the type of port.
+	 */
+	ret = serial8250_request_std_resource(up);
+	if (ret < 0)
+		return;
+
+	if (flags & UART_CONFIG_TYPE)
+		autoconfig(up);
+
+	if (up->port.type == PORT_UNKNOWN)
+		serial8250_release_std_resource(up);
+}
+
+static int
+serial8250_verify_port(struct uart_port *port, struct serial_struct *ser)
+{
+	return 0;
+}
+
+static const char *
+serial8250_type(struct uart_port *port)
+{
+	int type = port->type;
+
+	if (type >= ARRAY_SIZE(uart_config))
+		type = 0;
+	return uart_config[type].name;
+}
+
+static const struct uart_ops serial8250_pops = {
+	.tx_empty	= serial8250_tx_empty,
+	.set_mctrl	= serial8250_set_mctrl,
+	.get_mctrl	= serial8250_get_mctrl,
+	.stop_tx	= serial8250_stop_tx,
+	.start_tx	= serial8250_start_tx,
+	.stop_rx	= serial8250_stop_rx,
+	.enable_ms	= serial8250_enable_ms,
+	.break_ctl	= serial8250_break_ctl,
+	.startup	= serial8250_startup,
+	.shutdown	= serial8250_shutdown,
+	.set_termios	= serial8250_set_termios,
+	.pm		= serial8250_pm,
+	.type		= serial8250_type,
+	.release_port	= serial8250_release_port,
+	.request_port	= serial8250_request_port,
+	.config_port	= serial8250_config_port,
+	.verify_port	= serial8250_verify_port,
+};
+
+static void __init serial8250_isa_init_ports(void)
+{
+	static int first = 1;
+	int i;
+
+	if (!first)
+		return;
+	first = 0;
+
+	for (i = 0; i < nr_uarts; i++) {
+		struct ast_uart_port *up = &ast_uart_ports[i];
+
+		up->port.line = i;
+		spin_lock_init(&up->port.lock);
+
+		/*
+		 * ALPHA_KLUDGE_MCR needs to be killed.
+		 */
+		up->mcr_mask = ~ALPHA_KLUDGE_MCR;
+		up->mcr_force = ALPHA_KLUDGE_MCR;
+
+		up->port.ops = &serial8250_pops;
+	}
+
+}
+
+static void __init
+serial8250_register_ports(struct uart_driver *drv, struct device *dev)
+{
+	int i;
+	struct ast_uart_port *up = NULL;
+
+	serial8250_isa_init_ports();
+	for (i = 0; i < nr_uarts; i++) {
+		up = &ast_uart_ports[i];
+		up->port.dev = dev;
+		uart_add_one_port(drv, &up->port);
+	}
+}
+
+#define SERIAL8250_CONSOLE	NULL
+
+static struct uart_driver serial8250_reg = {
+	.owner			= THIS_MODULE,
+	.driver_name		= "ast-uart-dma",
+	.dev_name		= "ttyDMA",
+#if 0
+	.major			= TTY_MAJOR,
+	.minor			= 64,
+#else
+	.major			= 204, // like atmel_serial
+	.minor			= 155,
+#endif
+	.nr			= UART_DMA_NR,
+	.cons			= SERIAL8250_CONSOLE,
+};
+
+static void ast_dma_channel_teardown(struct ast_uart_port *s)
+{
+	UART_DBG("Teardown called\n");
+	if (s->tx_dma_chan) {
+		dma_release_channel(s->tx_dma_chan);
+		s->tx_dma_chan = NULL;
+	}
+	if (s->rx_dma_chan) {
+		dma_release_channel(s->rx_dma_chan);
+		s->rx_dma_chan = NULL;
+	}
+
+}
+static int ast_dma_channel_setup(struct ast_uart_port *up)
+{
+	up->rx_dma_chan = dma_request_slave_channel(up->port.dev, "rx");
+	UART_DBG("Entered %s ptr is %p\n", __func__, up->rx_dma_chan);
+	if (!up->rx_dma_chan)
+		goto err_out;
+
+	up->tx_dma_chan = dma_request_slave_channel(up->port.dev, "tx");
+	UART_DBG("Entered %s ptr is %p\n", __func__, up->tx_dma_chan);
+	if (!up->tx_dma_chan)
+		goto err_out;
+
+	return 0;
+err_out:
+	ast_dma_channel_teardown(up);
+	return -EINVAL;
+}
+
+/*
+ * Register a set of serial devices attached to a platform device.  The
+ * list is terminated with a zero flags entry, which means we expect
+ * all entries to have at least UPF_BOOT_AUTOCONF set.
+ */
+struct clk *clk;
+static int serial8250_probe(struct platform_device *dev)
+{
+	struct device_node *np = dev->dev.of_node;
+	struct uart_port port;
+	int ret;
+	u32 read = 0;
+	struct resource *res = 0;
+
+	if (UART_XMIT_SIZE > DMA_BUFF_SIZE)
+		UART_DBG("UART_XMIT_SIZE > DMA_BUFF_SIZE : Please Check\n");
+	memset(&port, 0, sizeof(struct uart_port));
+
+	port.irq = platform_get_irq(dev, 0);
+	if (port.irq < 0) {
+		dev_err(&dev->dev, "cannot get irq\n");
+		return port.irq;
+	}
+	res = platform_get_resource(dev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&dev->dev, "Register base not found");
+		return -ENODEV;
+	}
+	port.mapbase = res->start;
+	clk = devm_clk_get(&dev->dev, NULL);
+	if (IS_ERR(clk))
+		dev_err(&dev->dev, "missing controller clock");
+
+	ret = clk_prepare_enable(clk);
+	if (ret) {
+		dev_err(&dev->dev, "failed to enable DMA UART Clk\n");
+		return ret;
+	}
+	port.uartclk = clk_get_rate(clk);
+
+	if (of_property_read_u32(np, "reg-shift", &read) == 0)
+		port.regshift = read;
+	port.iotype = UPIO_MEM;
+	port.flags = UPF_IOREMAP | UPF_BOOT_AUTOCONF | UPF_SKIP_TEST;
+	port.dev = &dev->dev;
+	if (share_irqs)
+		port.flags |= UPF_SHARE_IRQ;
+	ret = ast_uart_register_port(&port, read);
+	if (ret < 0) {
+		dev_err(&dev->dev,
+		"Fail:register_port at index %d(IO%lx MEM%llx IRQ%d): %d\n",
+		read, port.iobase, (unsigned long long)port.mapbase,
+								port.irq, ret);
+	}
+	return ret;
+}
+
+/*
+ * Remove serial ports registered against a platform device.
+ */
+static int serial8250_remove(struct platform_device *dev)
+{
+	int i;
+
+	for (i = 0; i < nr_uarts; i++) {
+		struct ast_uart_port *up = &ast_uart_ports[i];
+
+		if (up->port.dev == &dev->dev)
+			ast_uart_unregister_port(i);
+		ast_dma_channel_teardown(up);
+	}
+	return 0;
+}
+
+static int serial8250_suspend(struct platform_device *dev, pm_message_t state)
+{
+	int i;
+
+	for (i = 0; i < UART_DMA_NR; i++) {
+		struct ast_uart_port *up = &ast_uart_ports[i];
+
+		if (up->port.type != PORT_UNKNOWN && up->port.dev == &dev->dev)
+			uart_suspend_port(&serial8250_reg, &up->port);
+	}
+
+	return 0;
+}
+
+static int serial8250_resume(struct platform_device *dev)
+{
+	int i;
+
+	for (i = 0; i < UART_DMA_NR; i++) {
+		struct ast_uart_port *up = &ast_uart_ports[i];
+
+		if (up->port.type != PORT_UNKNOWN && up->port.dev == &dev->dev)
+			serial8250_resume_port(i);
+	}
+
+	return 0;
+}
+
+static const struct of_device_id ast_serial_dt_ids[] = {
+	 { .compatible = "aspeed,ast-sdma-uart", },
+	 { /* sentinel */ }
+};
+
+static struct platform_driver serial8250_ast_dma_driver = {
+	.probe		= serial8250_probe,
+	.remove		= serial8250_remove,
+	.suspend	= serial8250_suspend,
+	.resume		= serial8250_resume,
+	.driver		= {
+		.name	= "ast-uart-dma",
+		.of_match_table     = of_match_ptr(ast_serial_dt_ids),
+	},
+};
+
+/*
+ * This "device" covers _all_ ISA 8250-compatible serial devices listed
+ * in the table in include/asm/serial.h
+ */
+static struct platform_device *serial8250_isa_devs;
+
+/*
+ * serial8250_register_port and serial8250_unregister_port allows for
+ * 16x50 serial ports to be configured at run-time, to support PCMCIA
+ * modems and PCI multiport cards.
+ */
+
+static struct ast_uart_port *
+		serial8250_find_match_or_unused(struct uart_port *port)
+{
+	int i;
+
+	/*
+	 * First, find a port entry which matches.
+	 */
+	for (i = 0; i < nr_uarts; i++) {
+		if (uart_match_port(&ast_uart_ports[i].port, port))
+			return &ast_uart_ports[i];
+	}
+	/*
+	 * We didn't find a matching entry, so look for the first
+	 * free entry.  We look for one which hasn't been previously
+	 * used (indicated by zero iobase).
+	 */
+	for (i = 0; i < nr_uarts; i++)
+		if (ast_uart_ports[i].port.type == PORT_UNKNOWN &&
+		    ast_uart_ports[i].port.iobase == 0)
+			return &ast_uart_ports[i];
+	/*
+	 * That also failed.  Last resort is to find any entry which
+	 * doesn't have a real port associated with it.
+	 */
+	for (i = 0; i < nr_uarts; i++)
+		if (ast_uart_ports[i].port.type == PORT_UNKNOWN)
+			return &ast_uart_ports[i];
+
+	return NULL;
+}
+
+/**
+ *	serial8250_register_port - register a serial port
+ *	@port: serial port template
+ *
+ *	Configure the serial port specified by the request. If the
+ *	port exists and is in use, it is hung up and unregistered
+ *	first.
+ *
+ *	The port is then probed and if necessary the IRQ is autodetected
+ *	If this fails an error is returned.
+ *
+ *	On success the port is ready to use and the line number is returned.
+ */
+static int ast_uart_register_port(struct uart_port *port,
+					unsigned int channel_no)
+{
+	struct ast_uart_port *uart;
+	int ret = -ENOSPC;
+
+	if (port->uartclk == 0)
+		return -EINVAL;
+
+	mutex_lock(&ast_uart_mutex);
+
+	uart = serial8250_find_match_or_unused(port);
+	if (uart) {
+		uart_remove_one_port(&serial8250_reg, &uart->port);
+		uart->port.iobase       = port->iobase;
+		uart->port.membase      = port->membase;
+		uart->port.irq          = port->irq;
+		uart->port.uartclk      = port->uartclk;
+		uart->port.fifosize     = port->fifosize;
+		uart->port.regshift     = port->regshift;
+		uart->port.iotype       = port->iotype;
+		uart->port.flags        = port->flags | UPF_BOOT_AUTOCONF;
+		uart->port.mapbase      = port->mapbase;
+		uart->port.private_data = uart;
+		if (port->dev) {
+			UART_DBG("Writing dev\n");
+			uart->port.dev = port->dev;
+		}
+		ret = uart_add_one_port(&serial8250_reg, &uart->port);
+		if (ret != 0) {
+			UART_DBG("uart_add_one_port: Failed for port=%p",
+								&uart->port);
+			return ret;
+		}
+		uart->channel_no = channel_no;
+		spin_lock_init(&uart->lock);
+
+		tasklet_init(&uart->tx_tasklet, ast_uart_tx_sdma_tasklet_func,
+				(unsigned long)uart);
+		tasklet_init(&uart->rx_tasklet, ast_uart_rx_sdma_tasklet_func,
+				(unsigned long)uart);
+	}
+
+	mutex_unlock(&ast_uart_mutex);
+	return ret;
+}
+EXPORT_SYMBOL(ast_uart_register_port);
+
+/**
+ *	serial8250_unregister_port - remove a 16x50 serial port at runtime
+ *	@line: serial line number
+ *
+ *	Remove one serial port.  This may not be called from interrupt
+ *	context.  We hand the port back to the our control.
+ */
+static void ast_uart_unregister_port(int line)
+{
+	struct ast_uart_port *uart = &ast_uart_ports[line];
+
+	mutex_lock(&ast_uart_mutex);
+	uart_remove_one_port(&serial8250_reg, &uart->port);
+	if (serial8250_isa_devs) {
+		uart->port.flags &= ~UPF_BOOT_AUTOCONF;
+		uart->port.type = PORT_UNKNOWN;
+		uart->port.dev = &serial8250_isa_devs->dev;
+		uart_add_one_port(&serial8250_reg, &uart->port);
+	} else {
+		uart->port.dev = NULL;
+	}
+	mutex_unlock(&ast_uart_mutex);
+}
+EXPORT_SYMBOL(ast_uart_unregister_port);
+
+static int __init ast_uart_init(void)
+{
+	int ret;
+
+	if (nr_uarts > UART_DMA_NR)
+		nr_uarts = UART_DMA_NR;
+
+	UART_DBG(KERN_INFO
+	"ast-uart-dma: UART driver with DMA %d ports, IRQ sharing %sabled\n",
+					nr_uarts, share_irqs ? "en" : "dis");
+	spin_lock_init(&ast_uart_irq[0].lock);
+
+	ret = uart_register_driver(&serial8250_reg);
+	if (ret)
+		goto out;
+
+	serial8250_isa_devs = platform_device_alloc("ast-uart-dma",
+						    PLAT8250_DEV_LEGACY);
+	if (!serial8250_isa_devs) {
+		ret = -ENOMEM;
+		goto unreg_uart_drv;
+	}
+
+	ret = platform_device_add(serial8250_isa_devs);
+	if (ret)
+		goto put_dev;
+
+	serial8250_register_ports(&serial8250_reg, &serial8250_isa_devs->dev);
+
+	ret = platform_driver_register(&serial8250_ast_dma_driver);
+	if (ret == 0)
+		goto out;
+
+	platform_device_del(serial8250_isa_devs);
+ put_dev:
+	platform_device_put(serial8250_isa_devs);
+ unreg_uart_drv:
+	uart_unregister_driver(&serial8250_reg);
+ out:
+	return ret;
+}
+
+static void __exit ast_uart_exit(void)
+{
+	struct platform_device *isa_dev = serial8250_isa_devs;
+
+	/*
+	 * This tells serial8250_unregister_port() not to re-register
+	 * the ports (thereby making serial8250_ast_dma_driver permanently
+	 * in use.)
+	 */
+	serial8250_isa_devs = NULL;
+
+	platform_driver_unregister(&serial8250_ast_dma_driver);
+	platform_device_unregister(isa_dev);
+
+	uart_unregister_driver(&serial8250_reg);
+}
+
+late_initcall(ast_uart_init);
+module_exit(ast_uart_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("AST DMA serial driver");
+MODULE_ALIAS_CHARDEV_MAJOR(TTY_MAJOR);
-- 
1.9.1


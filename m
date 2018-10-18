Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D07ECDE45
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 22:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F81121476
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 22:38:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lGk8oAd/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F81121476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbeJSGlf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 02:41:35 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:48651 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725906AbeJSGle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 02:41:34 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 4D100BF2;
        Thu, 18 Oct 2018 18:38:25 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 18 Oct 2018 18:38:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:in-reply-to:message-id
        :references:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=BjmidE2AoVk771QABJuEHlYpXzdPS
        UeAPSFZeA5Hic0=; b=lGk8oAd/e35RTS8zzQTcjt3xgk9AXiOhXd6FDVFroNA7c
        esA451nVD7ne+rJ65055WvX5gnxWjH/sKfKZWYRHkL3nYRXpFQpxhqI+dVa62kvR
        RNfNs7XW5bXQ0bxIFliBJVYUq3Pe/9xWd8pzZyC184sgGxmANeQypdro+l1n9lIu
        g9em9dxGm+FzQesTzo6iaaP0rLuEB+Z7NBwjZv6jhzUbU9WsGQIACvGbifxp21wD
        vQnLGgdmrwbAI86kRVhFnP6atPsm9Eb2HK2gWhwysIYVSDXUOX4koxMO/gO9Vo9v
        3ey7BsRqdHM17oQHfdL+YOY8RDA+F9wTwbQTfiMqQ==
X-ME-Sender: <xms:YAvJWwktqAWGuFqYMryLETynHofaeUocTKJU5RN0bk6hvQfUMj60Jw>
X-ME-Proxy: <xmx:YAvJWymcykb-uqai6oOQjKjePp4Yv6sDt-GCzB1VsUcr7nUg8jdtkA>
    <xmx:YAvJWxYz1mssbW-WG4rPRyLZQHBmfcFRgY-mMnw3cZz-MWMCz96N6g>
    <xmx:YAvJW4OhmSzbj8XIsUFA2meXMdLBvaPAACNFU0yD-BwaK7Z_WxTkxg>
    <xmx:YAvJW2j-exCtZhd1n-5Oz0XXbkecrpwRVshFwzHk6S-SBTIZlXPEgA>
    <xmx:YAvJW8MaRYqFamW5nYEVx6FtV8lMXLkwMqRzTK7zbxvfvGOjdXGuig>
    <xmx:YAvJW9Yy1HQ7oOKB5KyBXQdHZXXaIrVT0iOsXddgIhj6N5OeCt21SQ>
Received: from localhost (124-169-31-211.dyn.iinet.net.au [124.169.31.211])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0D691E4071;
        Thu, 18 Oct 2018 18:38:23 -0400 (EDT)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/7] tty: Fix spacing between kernel-doc sections
Date:   Fri, 19 Oct 2018 09:37:05 +1100
Message-Id: <20181018223707.9891-6-tobin@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181018223707.9891-1-tobin@kernel.org>
References: <20181018223707.9891-1-tobin@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a specified spacing for kernel-doc layout in
Documentation/doc-guide/kernel-doc.rst we should try to adhere to it as
much as possible.

Fix spacing between sections.

Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---
 drivers/tty/n_hdlc.c              | 2 ++
 drivers/tty/serial/serial-tegra.c | 2 --
 drivers/tty/serial/uartlite.c     | 5 +----
 drivers/tty/tty_buffer.c          | 1 +
 drivers/tty/tty_port.c            | 2 --
 5 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/n_hdlc.c b/drivers/tty/n_hdlc.c
index 4b7aaf9ee09c..5b0c776a43a2 100644
--- a/drivers/tty/n_hdlc.c
+++ b/drivers/tty/n_hdlc.c
@@ -794,6 +794,7 @@ static int n_hdlc_tty_ioctl(struct tty_struct *tty, struct file *file,
  *
  * Determine which operations (read/write) will not block and return info
  * to caller.
+ *
  * Returns a bit mask containing info on which ops will not block.
  */
 static __poll_t n_hdlc_tty_poll(struct tty_struct *tty, struct file *filp,
@@ -918,6 +919,7 @@ static void n_hdlc_buf_put(struct n_hdlc_buf_list *buf_list,
  *
  * Remove and return an HDLC buffer from the head of the specified HDLC buffer
  * list.
+ *
  * Returns a pointer to HDLC buffer if available, otherwise %NULL.
  */
 static struct n_hdlc_buf *n_hdlc_buf_get(struct n_hdlc_buf_list *buf_list)
diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index 872f3b2ed196..cb240a899127 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -74,7 +74,6 @@
 
 /**
  * tegra_uart_chip_data: SOC specific data.
- *
  * @tx_fifo_full_status: Status flag available for checking tx fifo full.
  * @allow_txfifo_reset_fifo_mode: allow_tx fifo reset with fifo mode or not.
  *			Tegra30 does not allow this.
@@ -220,7 +219,6 @@ static void tegra_uart_break_ctl(struct uart_port *u, int break_ctl)
 
 /**
  * tegra_uart_wait_cycle_time() - Wait for N UART clock periods
- *
  * @tup:	Tegra serial port data structure.
  * @cycles:	Number of clock periods to wait.
  *
diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
index 94a91748da40..718d3bbd002d 100644
--- a/drivers/tty/serial/uartlite.c
+++ b/drivers/tty/serial/uartlite.c
@@ -605,7 +605,6 @@ static struct uart_driver ulite_uart_driver = {
 
 /**
  * ulite_assign() - register a uartlite device with the driver
- *
  * @dev: pointer to device structure
  * @id: requested id number.  Pass -1 for automatic port assignment
  * @base: base address of uartlite registers
@@ -687,7 +686,6 @@ static int ulite_assign(struct device *dev, int id, u32 base, int irq,
 
 /**
  * ulite_release() - register a uartlite device with the driver
- *
  * @dev: pointer to device structure
  */
 static int ulite_release(struct device *dev)
@@ -706,7 +704,6 @@ static int ulite_release(struct device *dev)
 
 /**
  * ulite_suspend() - Stop the device.
- *
  * @dev: handle to the device structure.
  * Return: 0 always.
  */
@@ -722,8 +719,8 @@ static int __maybe_unused ulite_suspend(struct device *dev)
 
 /**
  * ulite_resume() - Resume the device.
- *
  * @dev: handle to the device structure.
+ *
  * Return: 0 on success, errno otherwise.
  */
 static int __maybe_unused ulite_resume(struct device *dev)
diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
index d50dbe06896b..5f05500ee4d0 100644
--- a/drivers/tty/tty_buffer.c
+++ b/drivers/tty/tty_buffer.c
@@ -148,6 +148,7 @@ void tty_buffer_free_all(struct tty_port *port)
  * Allocate a new tty buffer to hold the desired number of characters.
  * We round our buffers off in 256 character chunks to get better
  * allocation behaviour.
+ *
  * Return NULL if out of memory or the allocation would exceed the
  * per device queue
  */
diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
index 60927a52ec9c..d4dfe29a6348 100644
--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -363,7 +363,6 @@ EXPORT_SYMBOL(tty_port_hangup);
 
 /**
  * tty_port_tty_hangup() - helper to hang up a tty
- *
  * @port: tty port
  * @check_clocal: hang only ttys with CLOCAL unset?
  */
@@ -379,7 +378,6 @@ EXPORT_SYMBOL_GPL(tty_port_tty_hangup);
 
 /**
  * tty_port_tty_wakeup() - helper to wake up a tty
- *
  * @port: tty port
  */
 void tty_port_tty_wakeup(struct tty_port *port)
-- 
2.17.1


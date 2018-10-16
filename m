Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90FA5C5ACCC
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 23:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EC0121471
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 23:22:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K4DKFYys"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EC0121471
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbeJQHO4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 03:14:56 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:45605 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727297AbeJQHO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 03:14:56 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 607B7221C7;
        Tue, 16 Oct 2018 19:22:13 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 16 Oct 2018 19:22:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:in-reply-to:message-id
        :references:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=cwZNUTXqxxqeq0rx7jK+XXm/JpFGv
        nygHLmFN/zLxyw=; b=K4DKFYyskGwXjxqK7a95J+tOF0oKWOiUXE8JaLq1FHb0B
        R8cn/oGK11eS35Kzp9E5QwmxvjD7YQXG/0A0G7F1XO5SSFq+O+OmuVC+ncFz6O8v
        cW/fzLDB4w4yab5Wrez4DrwLNHTY8oPAlrDvUwrZx3fXx25T/CznQnEE/Md0sCiM
        F4MzBbTHbq2t6/n3N6dCbUWIjMmY1Tj5j/KsgMaajZYFlMSAjDxHOZhW/f8kwNp6
        ehHhesNQAgekakIwcLEyvka0zVQRqPXtfl9E/yA3r+sBm66Kt/t7iDlsGdtA7vXF
        MACWblTrubX+uaskaBzfvgbKwJP1qnUs3JLSO3Kjg==
X-ME-Sender: <xms:pXLGW3fSAUX4rf-Ccjt8m2PzYie4mbHvgEcDFW84dX-3IuL5DJeKCg>
X-ME-Proxy: <xmx:pXLGW95WwT3QzW_E9UEld4UaKXYM9hmENGx6SWGr66_r1ossF3Rnxg>
    <xmx:pXLGW1Fv64ecPTnRUVhyX4igHFZYhvxZXLb2j2Ty7TkSNUK3osynhA>
    <xmx:pXLGW5FJz8pXA35UzOMVNnJbV3NIs04BAHCPrJQ8t9db6eghAXetVg>
    <xmx:pXLGW2shZCsupROA1ORGsl0O3XYdwfAbx73SVP-UeGajVI4DbojUqA>
    <xmx:pXLGW1aig6nUkxhUP2M1jVHHQJRf8sL27ZNoY94nu0jccFj5ZQKQfw>
    <xmx:pXLGWzH1LXsfk-CsKQzStPMvmJAG55idDjx-G6pDItsOvBP94A0d5Q>
Received: from localhost (ppp121-44-203-227.bras1.syd2.internode.on.net [121.44.203.227])
        by mail.messagingengine.com (Postfix) with ESMTPA id 44945E4074;
        Tue, 16 Oct 2018 19:22:11 -0400 (EDT)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     "Tobin C. Harding" <tobin@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] tty: Fix spacing between kernel-doc sections
Date:   Wed, 17 Oct 2018 10:21:28 +1100
Message-Id: <20181016232130.728-6-tobin@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181016232130.728-1-tobin@kernel.org>
References: <20181016232130.728-1-tobin@kernel.org>
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
index bd08f2aa1da0..971795c7695f 100644
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


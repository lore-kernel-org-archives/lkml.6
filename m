Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F58CC5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 23:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96E7C21471
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 23:22:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V9Px4WaK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96E7C21471
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727294AbeJQHOr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 03:14:47 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:55787 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726936AbeJQHOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 03:14:47 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 57F242211A;
        Tue, 16 Oct 2018 19:22:00 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 16 Oct 2018 19:22:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:in-reply-to:message-id
        :references:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=cSOEvO0DiDugl85xmCtGnnQyNC5Ku
        2QKnPbRAyGDOTE=; b=V9Px4WaKhOSZleKCzKUqiQmSu9EyOC54huEBLDk09//2K
        7jdoHcoIyrlSQfu11q+OSK1MkXqdc6bLXIn2wcG5p86C90Y5VZx8jbr9EdW0hQ0P
        X9Cib7XMCAlKcD+8GjzoHH5MEUPV4pf5jk6P+qlqble6t0x/WE71JvJuuqg6TqD8
        FkUVMc5IMgc5eMaPV4+e5M42mbHHlpTJIOFfe6gvqP70/Ac8/8nrWXAayJChcEy2
        IkOZOaUbOhP3j2MO/4viFH+Ppz16sL/1yD2pDU/O834hNLOUBB5ppdPWCsabCPsK
        1Xn4QEw/cL3nPQgdKb0JD+oeplRY/rQhqlfL7xvPA==
X-ME-Sender: <xms:l3LGW6K3EaRoRHiml6sL1XxCt0ztwFgAFTQP1KuyK0wqddyCe2zvgw>
X-ME-Proxy: <xmx:l3LGW59SwEuU02a93kciGhSfmHSHl7SzNBJtTXoXy81WVVoeGB0hSg>
    <xmx:l3LGW0JDM10lLMG7kBHbogGV5dNjnMLtj7aSSU8SPmCzhY1yTgW1Tg>
    <xmx:mHLGW_0Bs-TyiuIm0srhdQo5WbsJQdDVAVFqCkgbe8X9zr5eIRZ9fw>
    <xmx:mHLGWwUMqXMFZ0CDZ-ybHyOI0OLoHyyu1AiyrFaVd6-PgqFUXI7gHg>
    <xmx:mHLGW9j6xnmMIIqfito4I2oc-5Yt76lkOPCGqv-JrWV9JnPo7GUNWQ>
    <xmx:mHLGW2M51ZZBbuQQW3M5z2Dn5JeAJPvdJeTzIHKPzAwjwPosycfHkQ>
Received: from localhost (ppp121-44-203-227.bras1.syd2.internode.on.net [121.44.203.227])
        by mail.messagingengine.com (Postfix) with ESMTPA id 37516102ED;
        Tue, 16 Oct 2018 19:21:57 -0400 (EDT)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        linux-kernel@vger.kernel.org, "Tobin C. Harding" <me@tobin.cc>
Subject: [PATCH 2/7] tty: Remove trailing whitespace
Date:   Wed, 17 Oct 2018 10:21:25 +1100
Message-Id: <20181016232130.728-3-tobin@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181016232130.728-1-tobin@kernel.org>
References: <20181016232130.728-1-tobin@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Tobin C. Harding" <me@tobin.cc>

Currently files under drivers/tty/ contain trailing whitespace.  This is
easy to fix and easy to review so lets do it now before we do other
kernel-docs cleanups.

Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---
 drivers/tty/amiserial.c         |   19 +-
 drivers/tty/cyclades.c          |    2 +-
 drivers/tty/hvc/hvc_console.c   |    2 +-
 drivers/tty/hvc/hvc_xen.c       |    2 +-
 drivers/tty/hvc/hvcs.c          |    4 +-
 drivers/tty/moxa.c              |    8 +-
 drivers/tty/mxser.c             |    4 +-
 drivers/tty/n_hdlc.c            |  154 ++---
 drivers/tty/n_r3964.c           |    6 +-
 drivers/tty/rocket.c            |   70 +--
 drivers/tty/serial/21285.c      |    2 +-
 drivers/tty/serial/amba-pl010.c |    2 +-
 drivers/tty/serial/max3100.c    |    2 +-
 drivers/tty/serial/max310x.c    |    2 +-
 drivers/tty/serial/mux.c        |   12 +-
 drivers/tty/serial/pmac_zilog.c |   58 +-
 drivers/tty/serial/sa1100.c     |    2 +-
 drivers/tty/serial/sunsab.c     |   14 +-
 drivers/tty/serial/sunsu.c      |    4 +-
 drivers/tty/serial/sunzilog.c   |    8 +-
 drivers/tty/synclink.c          | 1016 +++++++++++++++----------------
 drivers/tty/synclinkmp.c        |   16 +-
 drivers/tty/tty_io.c            |    2 +-
 drivers/tty/tty_ioctl.c         |    2 +-
 drivers/tty/vt/consolemap.c     |   50 +-
 drivers/tty/vt/keyboard.c       |    2 +-
 drivers/tty/vt/vt.c             |   12 +-
 drivers/tty/vt/vt_ioctl.c       |   16 +-
 28 files changed, 746 insertions(+), 747 deletions(-)

diff --git a/drivers/tty/amiserial.c b/drivers/tty/amiserial.c
index 73d4033cef6b..7027b85e0428 100644
--- a/drivers/tty/amiserial.c
+++ b/drivers/tty/amiserial.c
@@ -17,7 +17,7 @@
  * Richard Lucock 28/12/99
  *
  *  Copyright (C) 1991, 1992  Linus Torvalds
- *  Copyright (C) 1992, 1993, 1994, 1995, 1996, 1997, 
+ *  Copyright (C) 1992, 1993, 1994, 1995, 1996, 1997,
  *		1998, 1999  Theodore Ts'o
  *
  */
@@ -239,7 +239,7 @@ static void rs_start(struct tty_struct *tty)
  * rs_interrupt() should try to keep the interrupt handler as fast as
  * possible.  After you are done making modifications, it is not a bad
  * idea to do:
- * 
+ *
  * gcc -S -DKERNEL -Wall -Wstrict-prototypes -O6 -fomit-frame-pointer serial.c
  *
  * and look at the resulting assemble code in serial.s.
@@ -746,7 +746,7 @@ static void change_speed(struct tty_struct *tty, struct serial_state *info,
 	if (I_IGNBRK(tty)) {
 		info->ignore_status_mask |= UART_LSR_BI;
 		/*
-		 * If we're ignore parity and break indicators, ignore 
+		 * If we're ignore parity and break indicators, ignore
 		 * overruns too.  (For real raw support).
 		 */
 		if (I_IGNPAR(tty))
@@ -940,7 +940,7 @@ static void rs_send_xchar(struct tty_struct *tty, char ch)
 /*
  * ------------------------------------------------------------
  * rs_throttle()
- * 
+ *
  * This routine is called by the upper-layer tty layer to signal that
  * incoming characters should be throttled.
  * ------------------------------------------------------------
@@ -1085,7 +1085,6 @@ static int set_serial_info(struct tty_struct *tty, struct serial_state *state,
 	return retval;
 }
 
-
 /*
  * get_lsr_info - get line status register info
  *
@@ -1266,7 +1265,7 @@ static int rs_ioctl(struct tty_struct *tty,
 				local_irq_save(flags);
 				cnow = info->icount; /* atomic copy */
 				local_irq_restore(flags);
-				if (cnow.rng == cprev.rng && cnow.dsr == cprev.dsr && 
+				if (cnow.rng == cprev.rng && cnow.dsr == cprev.dsr &&
 				    cnow.dcd == cprev.dcd && cnow.cts == cprev.cts) {
 					ret = -EIO; /* no change => error */
 					break;
@@ -1348,7 +1347,7 @@ static void rs_set_termios(struct tty_struct *tty, struct ktermios *old_termios)
 /*
  * ------------------------------------------------------------
  * rs_close()
- * 
+ *
  * This routine is called when the serial port gets closed.  First, we
  * wait for the last remaining data to be sent.  Then, we unlink its
  * async structure from the interrupt chain if necessary, and we free
@@ -1390,7 +1389,7 @@ static void rs_close(struct tty_struct *tty, struct file * filp)
 	}
 	shutdown(tty, state);
 	rs_flush_buffer(tty);
-		
+
 	tty_ldisc_flush(tty);
 	port->tty = NULL;
 
@@ -1418,7 +1417,7 @@ static void rs_wait_until_sent(struct tty_struct *tty, int timeout)
 	 * Set the check interval to be 1/5 of the estimated time to
 	 * send a single character, and make it at least 1.  The check
 	 * interval should also be less than the timeout.
-	 * 
+	 *
 	 * Note: we have to use pretty tight timings here to satisfy
 	 * the NIST-PCTS.
 	 */
@@ -1669,7 +1668,7 @@ static int __init amiga_serial_probe(struct platform_device *pdev)
 	state = rs_table;
 	state->port = (int)&custom.serdatr; /* Just to give it a value */
 	state->custom_divisor = 0;
-	state->icount.cts = state->icount.dsr = 
+	state->icount.cts = state->icount.dsr =
 	  state->icount.rng = state->icount.dcd = 0;
 	state->icount.rx = state->icount.tx = 0;
 	state->icount.frame = state->icount.parity = 0;
diff --git a/drivers/tty/cyclades.c b/drivers/tty/cyclades.c
index 6d3c58051ce3..c82fce6f39ed 100644
--- a/drivers/tty/cyclades.c
+++ b/drivers/tty/cyclades.c
@@ -1028,7 +1028,7 @@ static void cyz_handle_tx(struct cyclades_port *info)
 
 	if (!char_count)
 		return;
-		
+
 	tty = tty_port_tty_get(&info->port);
 	if (tty == NULL)
 		goto ztxdone;
diff --git a/drivers/tty/hvc/hvc_console.c b/drivers/tty/hvc/hvc_console.c
index 676cf5b73ed2..6d57d0bfff5d 100644
--- a/drivers/tty/hvc/hvc_console.c
+++ b/drivers/tty/hvc/hvc_console.c
@@ -204,7 +204,7 @@ static struct tty_driver *hvc_console_device(struct console *c, int *index)
 }
 
 static int hvc_console_setup(struct console *co, char *options)
-{	
+{
 	if (co->index < 0 || co->index >= MAX_NR_HVC_CONSOLES)
 		return -ENODEV;
 
diff --git a/drivers/tty/hvc/hvc_xen.c b/drivers/tty/hvc/hvc_xen.c
index dc43fa96c3de..2c32dd544829 100644
--- a/drivers/tty/hvc/hvc_xen.c
+++ b/drivers/tty/hvc/hvc_xen.c
@@ -114,7 +114,7 @@ static int domU_write_console(uint32_t vtermno, const char *data, int len)
 	 */
 	while (len) {
 		int sent = __write_console(cons, data, len);
-		
+
 		data += sent;
 		len -= sent;
 
diff --git a/drivers/tty/hvc/hvcs.c b/drivers/tty/hvc/hvcs.c
index cb4db1b3ca3c..2420068d69d8 100644
--- a/drivers/tty/hvc/hvcs.c
+++ b/drivers/tty/hvc/hvcs.c
@@ -153,8 +153,8 @@ MODULE_VERSION(HVCS_DRIVER_VERSION);
 /*
  * The hcall interface involves putting 8 chars into each of two registers.
  * We load up those 2 registers (in arch/powerpc/platforms/pseries/hvconsole.c)
- * by casting char[16] to long[2].  It would work without __ALIGNED__, but a 
- * little (tiny) bit slower because an unaligned load is slower than aligned 
+ * by casting char[16] to long[2].  It would work without __ALIGNED__, but a
+ * little (tiny) bit slower because an unaligned load is slower than aligned
  * load.
  */
 #define __ALIGNED__	__attribute__((__aligned__(8)))
diff --git a/drivers/tty/moxa.c b/drivers/tty/moxa.c
index 7ce06f43b6ae..91c3599a93d4 100644
--- a/drivers/tty/moxa.c
+++ b/drivers/tty/moxa.c
@@ -1635,10 +1635,10 @@ static void MoxaPortFlushData(struct moxa_port *port, int mode)
  *      Syntax:
  *      void MoxaPortFlushData(int port, int mode);
  *           int port           : port number (0 - 127)
- *           int mode    
- *                      0       : flush the Rx buffer 
- *                      1       : flush the Tx buffer 
- *                      2       : flush the Rx and Tx buffer 
+ *           int mode
+ *                      0       : flush the Rx buffer
+ *                      1       : flush the Tx buffer
+ *                      2       : flush the Rx and Tx buffer
  *
  *
  *      Function 20:    Write data.
diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index 3f800b35689e..aac8c747e85a 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -1089,7 +1089,7 @@ static void mxser_close(struct tty_struct *tty, struct file *filp)
 	mutex_unlock(&port->mutex);
 	info->closing = 0;
 	/* Right now the tty_port set is done outside of the close_end helper
-	   as we don't yet have everyone using refcounts */	
+	   as we don't yet have everyone using refcounts */
 	tty_port_close_end(port, tty);
 	tty_port_tty_set(port, NULL);
 }
@@ -1517,7 +1517,7 @@ static int mxser_ioctl_special(unsigned int cmd, void __user *argp)
 				mutex_lock(&port->mutex);
 				if (!ip->ioaddr)
 					goto copy;
-				
+
 				tty = tty_port_tty_get(port);
 
 				if (!tty)
diff --git a/drivers/tty/n_hdlc.c b/drivers/tty/n_hdlc.c
index 1f2e24424b44..789251f8a1e2 100644
--- a/drivers/tty/n_hdlc.c
+++ b/drivers/tty/n_hdlc.c
@@ -18,7 +18,7 @@
  * All HDLC data is frame oriented which means:
  *
  * 1. tty write calls represent one complete transmit frame of data
- *    The device driver should accept the complete frame or none of 
+ *    The device driver should accept the complete frame or none of
  *    the frame (busy) in the write method. Each write call should have
  *    a byte count in the range of 2-65535 bytes (2 is min HDLC frame
  *    with 1 addr byte and 1 ctrl byte). The max byte count of 65535
@@ -39,7 +39,7 @@
  *    tty read calls.
  *
  * 3. tty read calls returns an entire frame of data or nothing.
- *    
+ *
  * 4. all send and receive data is considered raw. No processing
  *    or translation is performed by the line discipline, regardless
  *    of the tty flags
@@ -107,7 +107,7 @@
 /*
  * Buffers for individual HDLC frames
  */
-#define MAX_HDLC_FRAME_SIZE 65535 
+#define MAX_HDLC_FRAME_SIZE 65535
 #define DEFAULT_RX_BUF_COUNT 10
 #define MAX_RX_BUF_COUNT 60
 #define DEFAULT_TX_BUF_COUNT 3
@@ -234,10 +234,10 @@ static void n_hdlc_release(struct n_hdlc *n_hdlc)
 {
 	struct tty_struct *tty = n_hdlc2tty (n_hdlc);
 	struct n_hdlc_buf *buf;
-	
-	if (debuglevel >= DEBUG_LEVEL_INFO)	
+
+	if (debuglevel >= DEBUG_LEVEL_INFO)
 		printk("%s(%d)n_hdlc_release() called\n",__FILE__,__LINE__);
-		
+
 	/* Ensure that the n_hdlcd process is not hanging on select()/poll() */
 	wake_up_interruptible (&tty->read_wait);
 	wake_up_interruptible (&tty->write_wait);
@@ -275,7 +275,7 @@ static void n_hdlc_release(struct n_hdlc *n_hdlc)
 			break;
 	}
 	kfree(n_hdlc);
-	
+
 }	/* end of n_hdlc_release() */
 
 /**
@@ -289,9 +289,9 @@ static void n_hdlc_tty_close(struct tty_struct *tty)
 {
 	struct n_hdlc *n_hdlc = tty2n_hdlc (tty);
 
-	if (debuglevel >= DEBUG_LEVEL_INFO)	
+	if (debuglevel >= DEBUG_LEVEL_INFO)
 		printk("%s(%d)n_hdlc_tty_close() called\n",__FILE__,__LINE__);
-		
+
 	if (n_hdlc != NULL) {
 		if (n_hdlc->magic != HDLC_MAGIC) {
 			printk (KERN_WARNING"n_hdlc: trying to close unopened tty!\n");
@@ -311,10 +311,10 @@ static void n_hdlc_tty_close(struct tty_struct *tty)
 			n_hdlc_release (n_hdlc);
 		}
 	}
-	
-	if (debuglevel >= DEBUG_LEVEL_INFO)	
+
+	if (debuglevel >= DEBUG_LEVEL_INFO)
 		printk("%s(%d)n_hdlc_tty_close() success\n",__FILE__,__LINE__);
-		
+
 }	/* end of n_hdlc_tty_close() */
 
 /**
@@ -327,40 +327,40 @@ static int n_hdlc_tty_open (struct tty_struct *tty)
 {
 	struct n_hdlc *n_hdlc = tty2n_hdlc (tty);
 
-	if (debuglevel >= DEBUG_LEVEL_INFO)	
+	if (debuglevel >= DEBUG_LEVEL_INFO)
 		printk("%s(%d)n_hdlc_tty_open() called (device=%s)\n",
 		__FILE__,__LINE__,
 		tty->name);
-		
+
 	/* There should not be an existing table for this slot. */
 	if (n_hdlc) {
 		printk (KERN_ERR"n_hdlc_tty_open:tty already associated!\n" );
 		return -EEXIST;
 	}
-	
+
 	n_hdlc = n_hdlc_alloc();
 	if (!n_hdlc) {
 		printk (KERN_ERR "n_hdlc_alloc failed\n");
 		return -ENFILE;
 	}
-		
+
 	tty->disc_data = n_hdlc;
 	n_hdlc->tty    = tty;
 	tty->receive_room = 65536;
-	
+
 #if defined(TTY_NO_WRITE_SPLIT)
 	/* change tty_io write() to not split large writes into 8K chunks */
 	set_bit(TTY_NO_WRITE_SPLIT,&tty->flags);
 #endif
-	
+
 	/* flush receive data from driver */
 	tty_driver_flush_buffer(tty);
-		
-	if (debuglevel >= DEBUG_LEVEL_INFO)	
+
+	if (debuglevel >= DEBUG_LEVEL_INFO)
 		printk("%s(%d)n_hdlc_tty_open() success\n",__FILE__,__LINE__);
-		
+
 	return 0;
-	
+
 }	/* end of n_tty_hdlc_open() */
 
 /**
@@ -378,10 +378,10 @@ static void n_hdlc_send_frames(struct n_hdlc *n_hdlc, struct tty_struct *tty)
 	unsigned long flags;
 	struct n_hdlc_buf *tbuf;
 
-	if (debuglevel >= DEBUG_LEVEL_INFO)	
+	if (debuglevel >= DEBUG_LEVEL_INFO)
 		printk("%s(%d)n_hdlc_send_frames() called\n",__FILE__,__LINE__);
  check_again:
-		
+
 	spin_lock_irqsave(&n_hdlc->tx_buf_list.spinlock, flags);
 	if (n_hdlc->tbusy) {
 		n_hdlc->woke_up = 1;
@@ -394,10 +394,10 @@ static void n_hdlc_send_frames(struct n_hdlc *n_hdlc, struct tty_struct *tty)
 
 	tbuf = n_hdlc_buf_get(&n_hdlc->tx_buf_list);
 	while (tbuf) {
-		if (debuglevel >= DEBUG_LEVEL_INFO)	
+		if (debuglevel >= DEBUG_LEVEL_INFO)
 			printk("%s(%d)sending frame %p, count=%d\n",
 				__FILE__,__LINE__,tbuf,tbuf->count);
-			
+
 		/* Send the next block of data to device */
 		set_bit(TTY_DO_WRITE_WAKEUP, &tty->flags);
 		actual = tty->ops->write(tty, tbuf->buf, tbuf->count);
@@ -411,22 +411,22 @@ static void n_hdlc_send_frames(struct n_hdlc *n_hdlc, struct tty_struct *tty)
 		/* pretending it was accepted by driver */
 		if (actual < 0)
 			actual = tbuf->count;
-		
+
 		if (actual == tbuf->count) {
-			if (debuglevel >= DEBUG_LEVEL_INFO)	
+			if (debuglevel >= DEBUG_LEVEL_INFO)
 				printk("%s(%d)frame %p completed\n",
 					__FILE__,__LINE__,tbuf);
-					
+
 			/* free current transmit buffer */
 			n_hdlc_buf_put(&n_hdlc->tx_free_buf_list, tbuf);
 
 			/* wait up sleeping writers */
 			wake_up_interruptible(&tty->write_wait);
-	
+
 			/* get next pending transmit buffer */
 			tbuf = n_hdlc_buf_get(&n_hdlc->tx_buf_list);
 		} else {
-			if (debuglevel >= DEBUG_LEVEL_INFO)	
+			if (debuglevel >= DEBUG_LEVEL_INFO)
 				printk("%s(%d)frame %p pending\n",
 					__FILE__,__LINE__,tbuf);
 
@@ -438,21 +438,21 @@ static void n_hdlc_send_frames(struct n_hdlc *n_hdlc, struct tty_struct *tty)
 			break;
 		}
 	}
-	
+
 	if (!tbuf)
 		clear_bit(TTY_DO_WRITE_WAKEUP, &tty->flags);
-	
+
 	/* Clear the re-entry flag */
 	spin_lock_irqsave(&n_hdlc->tx_buf_list.spinlock, flags);
 	n_hdlc->tbusy = 0;
-	spin_unlock_irqrestore(&n_hdlc->tx_buf_list.spinlock, flags); 
-	
+	spin_unlock_irqrestore(&n_hdlc->tx_buf_list.spinlock, flags);
+
 	if (n_hdlc->woke_up)
 	  goto check_again;
 
-	if (debuglevel >= DEBUG_LEVEL_INFO)	
+	if (debuglevel >= DEBUG_LEVEL_INFO)
 		printk("%s(%d)n_hdlc_send_frames() exit\n",__FILE__,__LINE__);
-		
+
 }	/* end of n_hdlc_send_frames() */
 
 /**
@@ -465,9 +465,9 @@ static void n_hdlc_tty_wakeup(struct tty_struct *tty)
 {
 	struct n_hdlc *n_hdlc = tty2n_hdlc(tty);
 
-	if (debuglevel >= DEBUG_LEVEL_INFO)	
+	if (debuglevel >= DEBUG_LEVEL_INFO)
 		printk("%s(%d)n_hdlc_tty_wakeup() called\n",__FILE__,__LINE__);
-		
+
 	if (!n_hdlc)
 		return;
 
@@ -477,7 +477,7 @@ static void n_hdlc_tty_wakeup(struct tty_struct *tty)
 	}
 
 	n_hdlc_send_frames (n_hdlc, tty);
-		
+
 }	/* end of n_hdlc_tty_wakeup() */
 
 /**
@@ -496,29 +496,29 @@ static void n_hdlc_tty_receive(struct tty_struct *tty, const __u8 *data,
 	register struct n_hdlc *n_hdlc = tty2n_hdlc (tty);
 	register struct n_hdlc_buf *buf;
 
-	if (debuglevel >= DEBUG_LEVEL_INFO)	
+	if (debuglevel >= DEBUG_LEVEL_INFO)
 		printk("%s(%d)n_hdlc_tty_receive() called count=%d\n",
 			__FILE__,__LINE__, count);
-		
+
 	/* This can happen if stuff comes in on the backup tty */
 	if (!n_hdlc || tty != n_hdlc->tty)
 		return;
-		
+
 	/* verify line is using HDLC discipline */
 	if (n_hdlc->magic != HDLC_MAGIC) {
 		printk("%s(%d) line not using HDLC discipline\n",
 			__FILE__,__LINE__);
 		return;
 	}
-	
+
 	if ( count>maxframe ) {
-		if (debuglevel >= DEBUG_LEVEL_INFO)	
+		if (debuglevel >= DEBUG_LEVEL_INFO)
 			printk("%s(%d) rx count>maxframesize, data discarded\n",
 			       __FILE__,__LINE__);
 		return;
 	}
 
-	/* get a free HDLC buffer */	
+	/* get a free HDLC buffer */
 	buf = n_hdlc_buf_get(&n_hdlc->rx_free_buf_list);
 	if (!buf) {
 		/* no buffers in free list, attempt to allocate another rx buffer */
@@ -526,21 +526,21 @@ static void n_hdlc_tty_receive(struct tty_struct *tty, const __u8 *data,
 		if (n_hdlc->rx_buf_list.count < MAX_RX_BUF_COUNT)
 			buf = kmalloc(N_HDLC_BUF_SIZE, GFP_ATOMIC);
 	}
-	
+
 	if (!buf) {
-		if (debuglevel >= DEBUG_LEVEL_INFO)	
+		if (debuglevel >= DEBUG_LEVEL_INFO)
 			printk("%s(%d) no more rx buffers, data discarded\n",
 			       __FILE__,__LINE__);
 		return;
 	}
-		
+
 	/* copy received data to HDLC buffer */
 	memcpy(buf->buf,data,count);
 	buf->count=count;
 
 	/* add HDLC buffer to list of received frames */
 	n_hdlc_buf_put(&n_hdlc->rx_buf_list, buf);
-	
+
 	/* wake up any blocked reads and perform async signalling */
 	wake_up_interruptible (&tty->read_wait);
 	if (n_hdlc->tty->fasync != NULL)
@@ -565,9 +565,9 @@ static ssize_t n_hdlc_tty_read(struct tty_struct *tty, struct file *file,
 	struct n_hdlc_buf *rbuf;
 	DECLARE_WAITQUEUE(wait, current);
 
-	if (debuglevel >= DEBUG_LEVEL_INFO)	
+	if (debuglevel >= DEBUG_LEVEL_INFO)
 		printk("%s(%d)n_hdlc_tty_read() called\n",__FILE__,__LINE__);
-		
+
 	/* Validate the pointers */
 	if (!n_hdlc)
 		return -EIO;
@@ -610,7 +610,7 @@ static ssize_t n_hdlc_tty_read(struct tty_struct *tty, struct file *file,
 				n_hdlc_buf_put(&n_hdlc->rx_free_buf_list, rbuf);
 			break;
 		}
-			
+
 		/* no data */
 		if (file->f_flags & O_NONBLOCK) {
 			ret = -EAGAIN;
@@ -629,7 +629,7 @@ static ssize_t n_hdlc_tty_read(struct tty_struct *tty, struct file *file,
 	__set_current_state(TASK_RUNNING);
 
 	return ret;
-	
+
 }	/* end of n_hdlc_tty_read() */
 
 /**
@@ -649,10 +649,10 @@ static ssize_t n_hdlc_tty_write(struct tty_struct *tty, struct file *file,
 	DECLARE_WAITQUEUE(wait, current);
 	struct n_hdlc_buf *tbuf;
 
-	if (debuglevel >= DEBUG_LEVEL_INFO)	
+	if (debuglevel >= DEBUG_LEVEL_INFO)
 		printk("%s(%d)n_hdlc_tty_write() called count=%zd\n",
 			__FILE__,__LINE__,count);
-		
+
 	/* Verify pointers */
 	if (!n_hdlc)
 		return -EIO;
@@ -669,12 +669,12 @@ static ssize_t n_hdlc_tty_write(struct tty_struct *tty, struct file *file,
 				maxframe );
 		count = maxframe;
 	}
-	
+
 	add_wait_queue(&tty->write_wait, &wait);
 
 	for (;;) {
 		set_current_state(TASK_INTERRUPTIBLE);
-	
+
 		tbuf = n_hdlc_buf_get(&n_hdlc->tx_free_buf_list);
 		if (tbuf)
 			break;
@@ -684,15 +684,15 @@ static ssize_t n_hdlc_tty_write(struct tty_struct *tty, struct file *file,
 			break;
 		}
 		schedule();
-			
+
 		n_hdlc = tty2n_hdlc (tty);
-		if (!n_hdlc || n_hdlc->magic != HDLC_MAGIC || 
+		if (!n_hdlc || n_hdlc->magic != HDLC_MAGIC ||
 		    tty != n_hdlc->tty) {
 			printk("n_hdlc_tty_write: %p invalid after wait!\n", n_hdlc);
 			error = -EIO;
 			break;
 		}
-			
+
 		if (signal_pending(current)) {
 			error = -EINTR;
 			break;
@@ -702,7 +702,7 @@ static ssize_t n_hdlc_tty_write(struct tty_struct *tty, struct file *file,
 	__set_current_state(TASK_RUNNING);
 	remove_wait_queue(&tty->write_wait, &wait);
 
-	if (!error) {		
+	if (!error) {
 		/* Retrieve the user's buffer */
 		memcpy(tbuf->buf, data, count);
 
@@ -713,7 +713,7 @@ static ssize_t n_hdlc_tty_write(struct tty_struct *tty, struct file *file,
 	}
 
 	return error;
-	
+
 }	/* end of n_hdlc_tty_write() */
 
 /**
@@ -734,10 +734,10 @@ static int n_hdlc_tty_ioctl(struct tty_struct *tty, struct file *file,
 	unsigned long flags;
 	struct n_hdlc_buf *buf = NULL;
 
-	if (debuglevel >= DEBUG_LEVEL_INFO)	
+	if (debuglevel >= DEBUG_LEVEL_INFO)
 		printk("%s(%d)n_hdlc_tty_ioctl() called %d\n",
 			__FILE__,__LINE__,cmd);
-		
+
 	/* Verify the status of the device */
 	if (!n_hdlc || n_hdlc->magic != HDLC_MAGIC)
 		return -EBADF;
@@ -783,7 +783,7 @@ static int n_hdlc_tty_ioctl(struct tty_struct *tty, struct file *file,
 		break;
 	}
 	return error;
-	
+
 }	/* end of n_hdlc_tty_ioctl() */
 
 /**
@@ -791,7 +791,7 @@ static int n_hdlc_tty_ioctl(struct tty_struct *tty, struct file *file,
  * @tty - pointer to tty instance data
  * @filp - pointer to open file object for device
  * @poll_table - wait queue for operations
- * 
+ *
  * Determine which operations (read/write) will not block and return info
  * to caller.
  * Returns a bit mask containing info on which ops will not block.
@@ -802,9 +802,9 @@ static __poll_t n_hdlc_tty_poll(struct tty_struct *tty, struct file *filp,
 	struct n_hdlc *n_hdlc = tty2n_hdlc (tty);
 	__poll_t mask = 0;
 
-	if (debuglevel >= DEBUG_LEVEL_INFO)	
+	if (debuglevel >= DEBUG_LEVEL_INFO)
 		printk("%s(%d)n_hdlc_tty_poll() called\n",__FILE__,__LINE__);
-		
+
 	if (n_hdlc && n_hdlc->magic == HDLC_MAGIC && tty == n_hdlc->tty) {
 		/* queue current process into any wait queue that */
 		/* may awaken in the future (read and write) */
@@ -855,25 +855,25 @@ static struct n_hdlc *n_hdlc_alloc(void)
 		buf = kmalloc(N_HDLC_BUF_SIZE, GFP_KERNEL);
 		if (buf)
 			n_hdlc_buf_put(&n_hdlc->rx_free_buf_list,buf);
-		else if (debuglevel >= DEBUG_LEVEL_INFO)	
+		else if (debuglevel >= DEBUG_LEVEL_INFO)
 			printk("%s(%d)n_hdlc_alloc(), kalloc() failed for rx buffer %d\n",__FILE__,__LINE__, i);
 	}
-	
+
 	/* allocate free tx buffer list */
 	for(i=0;i<DEFAULT_TX_BUF_COUNT;i++) {
 		buf = kmalloc(N_HDLC_BUF_SIZE, GFP_KERNEL);
 		if (buf)
 			n_hdlc_buf_put(&n_hdlc->tx_free_buf_list,buf);
-		else if (debuglevel >= DEBUG_LEVEL_INFO)	
+		else if (debuglevel >= DEBUG_LEVEL_INFO)
 			printk("%s(%d)n_hdlc_alloc(), kalloc() failed for tx buffer %d\n",__FILE__,__LINE__, i);
 	}
-	
+
 	/* Initialize the control block */
 	n_hdlc->magic  = HDLC_MAGIC;
 	n_hdlc->flags  = 0;
-	
+
 	return n_hdlc;
-	
+
 }	/* end of n_hdlc_alloc() */
 
 /**
@@ -915,7 +915,7 @@ static void n_hdlc_buf_put(struct n_hdlc_buf_list *buf_list,
 /**
  * n_hdlc_buf_get - remove and return an HDLC buffer from list
  * @buf_list - pointer to HDLC buffer list
- * 
+ *
  * Remove and return an HDLC buffer from the head of the specified HDLC buffer
  * list.
  * Returns a pointer to HDLC buffer if available, otherwise %NULL.
@@ -964,7 +964,7 @@ static int __init n_hdlc_init(void)
 		printk(hdlc_register_fail, status);
 
 	return status;
-	
+
 }	/* end of init_module() */
 
 static const char hdlc_unregister_ok[] __exitdata =
diff --git a/drivers/tty/n_r3964.c b/drivers/tty/n_r3964.c
index dbf1ab36758e..84f4f4f9b7c1 100644
--- a/drivers/tty/n_r3964.c
+++ b/drivers/tty/n_r3964.c
@@ -2,7 +2,7 @@
 /* r3964 linediscipline for linux
  *
  * -----------------------------------------------------------
- * Copyright by 
+ * Copyright by
  * Philips Automation Projects
  * Kassel (Germany)
  * -----------------------------------------------------------
@@ -1126,8 +1126,8 @@ static ssize_t r3964_write(struct tty_struct *tty, struct file *file,
 	unsigned char *new_data;
 
 	TRACE_L("write request, %d characters", count);
-/* 
- * Verify the pointers 
+/*
+ * Verify the pointers
  */
 
 	if (!pInfo)
diff --git a/drivers/tty/rocket.c b/drivers/tty/rocket.c
index c123fdb7eed8..c01fc69b8944 100644
--- a/drivers/tty/rocket.c
+++ b/drivers/tty/rocket.c
@@ -3,7 +3,7 @@
  * RocketPort device driver for Linux
  *
  * Written by Theodore Ts'o, 1995, 1996, 1997, 1998, 1999, 2000.
- * 
+ *
  * Copyright (C) 1995, 1996, 1997, 1998, 1999, 2000, 2003 by Comtrol, Inc.
  */
 
@@ -14,14 +14,14 @@
  * from user mode) and the timer bottom half (tasklet).  This is a polled driver, interrupts
  * are not used.
  *
- * Critical data: 
- * -  rp_table[], accessed through passed "info" pointers, is a global (static) array of 
- *    serial port state information and the xmit_buf circular buffer.  Protected by 
+ * Critical data:
+ * -  rp_table[], accessed through passed "info" pointers, is a global (static) array of
+ *    serial port state information and the xmit_buf circular buffer.  Protected by
  *    a per port spinlock.
  * -  xmit_flags[], an array of ints indexed by line (port) number, indicating that there
  *    is data to be transmitted.  Protected by atomic bit operations.
  * -  rp_num_ports, int indicating number of open ports, protected by atomic operations.
- * 
+ *
  * rp_write() and rp_write_char() functions use a per port semaphore to protect against
  * simultaneous access to the same port by more than one process.
  */
@@ -90,7 +90,7 @@ static void rp_do_poll(struct timer_list *unused);
 
 static struct tty_driver *rocket_driver;
 
-static struct rocket_version driver_version = {	
+static struct rocket_version driver_version = {
 	ROCKET_VERSION, ROCKET_DATE
 };
 
@@ -205,8 +205,8 @@ static Byte_t sBitMapSetTbl[8] = {
 static int sClockPrescale = 0x14;
 
 /*
- *  Line number is the ttySIx number (x), the Minor number.  We 
- *  assign them sequentially, starting at zero.  The following 
+ *  Line number is the ttySIx number (x), the Minor number.  We
+ *  assign them sequentially, starting at zero.  The following
  *  array keeps track of the line number assigned to a given board/aiop/channel.
  */
 static unsigned char lineNumbers[MAX_RP_PORTS];
@@ -294,9 +294,9 @@ static inline int rocket_paranoia_check(struct r_port *info,
 }
 
 
-/*  Serial port receive data function.  Called (from timer poll) when an AIOPIC signals 
- *  that receive data is present on a serial port.  Pulls data from FIFO, moves it into the 
- *  tty layer.  
+/*  Serial port receive data function.  Called (from timer poll) when an AIOPIC signals
+ *  that receive data is present on a serial port.  Pulls data from FIFO, moves it into the
+ *  tty layer.
  */
 static void rp_do_receive(struct r_port *info, CHANNEL_t *cp,
 		unsigned int ChanStatus)
@@ -327,7 +327,7 @@ static void rp_do_receive(struct r_port *info, CHANNEL_t *cp,
 		}
 	}
 
-	/* 
+	/*
 	 * if we previously entered status mode, then read down the
 	 * FIFO one word at a time, pulling apart the character and
 	 * the status.  Update error counters depending on status
@@ -402,9 +402,9 @@ static void rp_do_receive(struct r_port *info, CHANNEL_t *cp,
 }
 
 /*
- *  Serial port transmit data function.  Called from the timer polling loop as a 
+ *  Serial port transmit data function.  Called from the timer polling loop as a
  *  result of a bit set in xmit_flags[], indicating data (from the tty layer) is ready
- *  to be sent out the serial port.  Data is buffered in rp_table[line].xmit_buf, it is 
+ *  to be sent out the serial port.  Data is buffered in rp_table[line].xmit_buf, it is
  *  moved to the port's xmit FIFO.  *info is critical data, protected by spinlocks.
  */
 static void rp_do_transmit(struct r_port *info)
@@ -472,7 +472,7 @@ static void rp_do_transmit(struct r_port *info)
 /*
  *  Called when a serial port signals it has read data in it's RX FIFO.
  *  It checks what interrupts are pending and services them, including
- *  receiving serial data.  
+ *  receiving serial data.
  */
 static void rp_handle_port(struct r_port *info)
 {
@@ -574,8 +574,8 @@ static void rp_do_poll(struct timer_list *unused)
 
 		/*
 		 *  xmit_flags contains bit-significant flags, indicating there is data
-		 *  to xmit on the port. Bit 0 is port 0 on this board, bit 1 is port 
-		 *  1, ... (32 total possible).  The variable i has the aiop and ch 
+		 *  to xmit on the port. Bit 0 is port 0 on this board, bit 1 is port
+		 *  1, ... (32 total possible).  The variable i has the aiop and ch
 		 *  numbers encoded in it (port 0-7 are aiop0, 8-15 are aiop1, etc).
 		 */
 		if (xmitmask) {
@@ -598,8 +598,8 @@ static void rp_do_poll(struct timer_list *unused)
 }
 
 /*
- *  Initializes the r_port structure for a port, as well as enabling the port on 
- *  the board.  
+ *  Initializes the r_port structure for a port, as well as enabling the port on
+ *  the board.
  *  Inputs:  board, aiop, chan numbers
  */
 static void __init
@@ -686,7 +686,7 @@ init_r_port(int board, int aiop, int chan, struct pci_dev *pci_dev)
 }
 
 /*
- *  Configures a rocketport port according to its termio settings.  Called from 
+ *  Configures a rocketport port according to its termio settings.  Called from
  *  user mode into the driver (exception handler).  *info CD manipulation is spinlock protected.
  */
 static void configure_r_port(struct tty_struct *tty, struct r_port *info,
@@ -862,8 +862,8 @@ static void dtr_rts(struct tty_port *port, int on)
 }
 
 /*
- *  Exception handler that opens a serial port.  Creates xmit_buf storage, fills in 
- *  port's r_port struct.  Initializes the port hardware.  
+ *  Exception handler that opens a serial port.  Creates xmit_buf storage, fills in
+ *  port's r_port struct.  Initializes the port hardware.
  */
 static int rp_open(struct tty_struct *tty, struct file *filp)
 {
@@ -877,7 +877,7 @@ static int rp_open(struct tty_struct *tty, struct file *filp)
 	if (info == NULL)
 		return -ENXIO;
 	port = &info->port;
-	
+
 	page = __get_free_page(GFP_KERNEL);
 	if (!page)
 		return -ENOMEM;
@@ -962,7 +962,7 @@ static void rp_close(struct tty_struct *tty, struct file *filp)
 	struct tty_port *port = &info->port;
 	int timeout;
 	CHANNEL_t *cp;
-	
+
 	if (rocket_paranoia_check(info, "rp_close"))
 		return;
 
@@ -998,7 +998,7 @@ static void rp_close(struct tty_struct *tty, struct file *filp)
 		sClrDTR(cp);
 
 	rp_flush_buffer(tty);
-		
+
 	tty_ldisc_flush(tty);
 
 	clear_bit((info->aiop * 8) + info->chan, (void *) &xmit_flags[info->board]);
@@ -1119,7 +1119,7 @@ static int sGetChanRI(CHANNEL_T * ChP)
 /*  Here are the routines used by rp_ioctl.  These are all called from exception handlers.  */
 
 /*
- *  Returns the state of the serial modem control lines.  These next 2 functions 
+ *  Returns the state of the serial modem control lines.  These next 2 functions
  *  are the way kernel versions > 2.5 handle modem control lines rather than IOCTLs.
  */
 static int rp_tiocmget(struct tty_struct *tty)
@@ -1129,7 +1129,7 @@ static int rp_tiocmget(struct tty_struct *tty)
 
 	ChanStatus = sGetChanStatusLo(&info->channel);
 	control = info->channel.TxControl[3];
-	result = ((control & SET_RTS) ? TIOCM_RTS : 0) | 
+	result = ((control & SET_RTS) ? TIOCM_RTS : 0) |
 		((control & SET_DTR) ?  TIOCM_DTR : 0) |
 		((ChanStatus & CD_ACT) ? TIOCM_CAR : 0) |
 		(sGetChanRI(&info->channel) ? TIOCM_RNG : 0) |
@@ -1139,7 +1139,7 @@ static int rp_tiocmget(struct tty_struct *tty)
 	return result;
 }
 
-/* 
+/*
  *  Sets the modem control lines
  */
 static int rp_tiocmset(struct tty_struct *tty,
@@ -1537,7 +1537,7 @@ static int rp_put_char(struct tty_struct *tty, unsigned char ch)
  *  Exception handler - write routine, called when user app writes to the device.
  *  A per port write mutex is used to protect from another process writing to
  *  this port at the same time.  This other process could be running on the other CPU
- *  or get control of the CPU if the copy_from_user() blocks due to a page fault (swapped out). 
+ *  or get control of the CPU if the copy_from_user() blocks due to a page fault (swapped out).
  *  Spinlocks protect the info xmit members.
  */
 static int rp_write(struct tty_struct *tty,
@@ -1564,7 +1564,7 @@ static int rp_write(struct tty_struct *tty,
 		info->xmit_fifo_room = TXFIFO_SIZE - sGetTxCnt(cp);
 
         /*
-	 *  If the write queue for the port is empty, and there is FIFO space, stuff bytes 
+	 *  If the write queue for the port is empty, and there is FIFO space, stuff bytes
 	 *  into FIFO.  Use the write queue for temp storage.
          */
 	if (!tty->stopped && info->xmit_cnt == 0 && info->xmit_fifo_room > 0) {
@@ -1617,7 +1617,7 @@ static int rp_write(struct tty_struct *tty,
 
 	if ((retval > 0) && !tty->stopped)
 		set_bit((info->aiop * 8) + info->chan, (void *) &xmit_flags[info->board]);
-	
+
 end:
 	if (info->xmit_cnt < WAKEUP_CHARS) {
 		tty_wakeup(tty);
@@ -2285,7 +2285,7 @@ static int __init init_ISA(int i)
 	rocketModel[i].numPorts = total_num_chan;
 	rocketModel[i].model = MODEL_ISA;
 
-	printk(KERN_INFO "RocketPort ISA card #%d found at 0x%lx - %d AIOPs %s\n", 
+	printk(KERN_INFO "RocketPort ISA card #%d found at 0x%lx - %d AIOPs %s\n",
 	       i, rcktpt_io_addr[i], num_aiops, type_string);
 
 	printk(KERN_INFO "Installing %s, creating /dev/ttyR%d - %ld\n",
@@ -2339,7 +2339,7 @@ static int __init rp_init(void)
 		goto err;
 
 	/*
-	 *  If board 1 is non-zero, there is at least one ISA configured.  If controller is 
+	 *  If board 1 is non-zero, there is at least one ISA configured.  If controller is
 	 *  zero, use the default controller IO address of board1 + 0x40.
 	 */
 	if (board1) {
@@ -3104,8 +3104,8 @@ static unsigned char GetLineNumber(int ctrl, int aiop, int ch)
 
 /*
  *  Stores the line number associated with a given controller (board), aiop
- *  and channel number.  
- *  Returns:  The line number assigned 
+ *  and channel number.
+ *  Returns:  The line number assigned
  */
 static unsigned char SetLineNumber(int ctrl, int aiop, int ch)
 {
diff --git a/drivers/tty/serial/21285.c b/drivers/tty/serial/21285.c
index 32b3acf8150a..6176f5e8b228 100644
--- a/drivers/tty/serial/21285.c
+++ b/drivers/tty/serial/21285.c
@@ -227,7 +227,7 @@ serial21285_set_termios(struct uart_port *port, struct ktermios *termios,
 	/*
 	 * Ask the core to calculate the divisor for us.
 	 */
-	baud = uart_get_baud_rate(port, termios, old, 0, port->uartclk/16); 
+	baud = uart_get_baud_rate(port, termios, old, 0, port->uartclk/16);
 	quot = uart_get_divisor(port, baud);
 	b = port->uartclk / (16 * quot);
 	tty_termios_encode_baud_rate(termios, b, b);
diff --git a/drivers/tty/serial/amba-pl010.c b/drivers/tty/serial/amba-pl010.c
index 2c37d11726ab..fa49f25a7fbc 100644
--- a/drivers/tty/serial/amba-pl010.c
+++ b/drivers/tty/serial/amba-pl010.c
@@ -390,7 +390,7 @@ pl010_set_termios(struct uart_port *port, struct ktermios *termios,
 	/*
 	 * Ask the core to calculate the divisor for us.
 	 */
-	baud = uart_get_baud_rate(port, termios, old, 0, uap->port.uartclk/16); 
+	baud = uart_get_baud_rate(port, termios, old, 0, uap->port.uartclk/16);
 	quot = uart_get_divisor(port, baud);
 
 	switch (termios->c_cflag & CSIZE) {
diff --git a/drivers/tty/serial/max3100.c b/drivers/tty/serial/max3100.c
index 371569a0fd00..95090a6ad6c4 100644
--- a/drivers/tty/serial/max3100.c
+++ b/drivers/tty/serial/max3100.c
@@ -826,7 +826,7 @@ static int max3100_remove(struct spi_device *spi)
 		}
 
 	WARN_ON(i == MAX_MAX3100);
-	
+
 	/* check if this is the last chip we have */
 	for (i = 0; i < MAX_MAX3100; i++)
 		if (max3100s[i]) {
diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 3db48fcd6068..aae234b14be6 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -386,7 +386,7 @@ static int max14830_detect(struct device *dev)
 			   MAX310X_EXTREG_ENBL);
 	if (ret)
 		return ret;
-	
+
 	regmap_read(s->regmap, MAX310X_REVID_EXTREG, &val);
 	regmap_write(s->regmap, MAX310X_GLOBALCMD_REG, MAX310X_EXTREG_DSBL);
 	if (((val & MAX310x_REV_MASK) != MAX14830_REV_ID)) {
diff --git a/drivers/tty/serial/mux.c b/drivers/tty/serial/mux.c
index 880d1b3127c2..f7d67125675e 100644
--- a/drivers/tty/serial/mux.c
+++ b/drivers/tty/serial/mux.c
@@ -108,7 +108,7 @@ static int __init get_mux_port_count(struct parisc_device *dev)
 static unsigned int mux_tx_empty(struct uart_port *port)
 {
 	return UART_GET_FIFO_CNT(port) ? 0 : TIOCSER_TEMT;
-} 
+}
 
 /**
  * mux_set_mctrl - Set the current state of the modem control inputs.
@@ -130,7 +130,7 @@ static void mux_set_mctrl(struct uart_port *port, unsigned int mctrl)
  * treated as permanently active.
  */
 static unsigned int mux_get_mctrl(struct uart_port *port)
-{ 
+{
 	return TIOCM_CAR | TIOCM_DSR | TIOCM_CTS;
 }
 
@@ -209,7 +209,7 @@ static void mux_write(struct uart_port *port)
 
 	} while(--count > 0);
 
-	while(UART_GET_FIFO_CNT(port)) 
+	while(UART_GET_FIFO_CNT(port))
 		udelay(1);
 
 	if(uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
@@ -254,7 +254,7 @@ static void mux_read(struct uart_port *port)
 
 		tty_insert_flip_char(tport, data & 0xFF, TTY_NORMAL);
 	}
-	
+
 	if (start_count != port->icount.rx)
 		tty_flip_buffer_push(tport);
 }
@@ -312,7 +312,7 @@ static const char *mux_type(struct uart_port *port)
 /**
  * mux_release_port - Release memory and IO regions.
  * @port: Ptr to the uart_port.
- * 
+ *
  * Release any memory and IO region resources currently in use by
  * the port.
  */
@@ -372,7 +372,7 @@ static int mux_verify_port(struct uart_port *port, struct serial_struct *ser)
  * This function periodically polls the Serial MUX to check for new data.
  */
 static void mux_poll(struct timer_list *unused)
-{  
+{
 	int i;
 
 	for(i = 0; i < port_cnt; ++i) {
diff --git a/drivers/tty/serial/pmac_zilog.c b/drivers/tty/serial/pmac_zilog.c
index a5558051de74..5fcd34bbd0ce 100644
--- a/drivers/tty/serial/pmac_zilog.c
+++ b/drivers/tty/serial/pmac_zilog.c
@@ -2,7 +2,7 @@
 /*
  * Driver for PowerMac Z85c30 based ESCC cell found in the
  * "macio" ASICs of various PowerMac models
- * 
+ *
  * Copyright (C) 2003 Ben. Herrenschmidt (benh@kernel.crashing.org)
  *
  * Derived from drivers/macintosh/macserial.c by Paul Mackerras
@@ -108,7 +108,7 @@ static struct uart_driver pmz_uart_reg = {
 };
 
 
-/* 
+/*
  * Load all registers to reprogram the port
  * This function must only be called when the TX is not busy.  The UART
  * port lock must be held and local interrupts disabled.
@@ -165,7 +165,7 @@ static void pmz_load_zsregs(struct uart_pmac_port *uap, u8 *regs)
 	/* Lower and upper byte of baud rate generator divisor.  */
 	write_zsreg(uap, R12, regs[R12]);
 	write_zsreg(uap, R13, regs[R13]);
-	
+
 	/* Now rewrite R14, with BRENAB (if set).  */
 	write_zsreg(uap, R14, regs[R14]);
 
@@ -184,7 +184,7 @@ static void pmz_load_zsregs(struct uart_pmac_port *uap, u8 *regs)
 	write_zsreg(uap, R9, regs[R9]);
 }
 
-/* 
+/*
  * We do like sunzilog to avoid disrupting pending Tx
  * Reprogram the Zilog channel HW registers with the copies found in the
  * software state struct.  If the transmitter is busy, we defer this update
@@ -460,7 +460,7 @@ static irqreturn_t pmz_interrupt(int irq, void *dev_id)
 			goto skip_a;
 		}
 		write_zsreg(uap_a, R0, RES_H_IUS);
-		zssync(uap_a);		
+		zssync(uap_a);
 		if (r3 & CHAEXT)
 			pmz_status_handle(uap_a);
 		if (r3 & CHARxIP)
@@ -510,7 +510,7 @@ static inline u8 pmz_peek_status(struct uart_pmac_port *uap)
 {
 	unsigned long flags;
 	u8 status;
-	
+
 	spin_lock_irqsave(&uap->port.lock, flags);
 	status = read_zsreg(uap, R0);
 	spin_unlock_irqrestore(&uap->port.lock, flags);
@@ -518,7 +518,7 @@ static inline u8 pmz_peek_status(struct uart_pmac_port *uap)
 	return status;
 }
 
-/* 
+/*
  * Check if transmitter is empty
  * The port lock is not held.
  */
@@ -532,7 +532,7 @@ static unsigned int pmz_tx_empty(struct uart_port *port)
 	return 0;
 }
 
-/* 
+/*
  * Set Modem Control (RTS & DTR) bits
  * The port lock is held and interrupts are disabled.
  * Note: Shall we really filter out RTS on external ports or
@@ -563,7 +563,7 @@ static void pmz_set_mctrl(struct uart_port *port, unsigned int mctrl)
 	else
 		clear_bits |= DTR;
 
-	/* NOTE: Not subject to 'transmitter active' rule.  */ 
+	/* NOTE: Not subject to 'transmitter active' rule.  */
 	uap->curregs[R5] |= set_bits;
 	uap->curregs[R5] &= ~clear_bits;
 
@@ -573,7 +573,7 @@ static void pmz_set_mctrl(struct uart_port *port, unsigned int mctrl)
 	zssync(uap);
 }
 
-/* 
+/*
  * Get Modem Control bits (only the input ones, the core will
  * or that with a cached value of the control ones)
  * The port lock is held and interrupts are disabled.
@@ -597,7 +597,7 @@ static unsigned int pmz_get_mctrl(struct uart_port *port)
 	return ret;
 }
 
-/* 
+/*
  * Stop TX side. Dealt like sunzilog at next Tx interrupt,
  * though for DMA, we will have to do a bit more.
  * The port lock is held and interrupts are disabled.
@@ -607,7 +607,7 @@ static void pmz_stop_tx(struct uart_port *port)
 	to_pmz(port)->flags |= PMACZILOG_FLAG_TX_STOPPED;
 }
 
-/* 
+/*
  * Kick the Tx side.
  * The port lock is held and interrupts are disabled.
  */
@@ -652,7 +652,7 @@ static void pmz_start_tx(struct uart_port *port)
 	pmz_debug("pmz: start_tx() done.\n");
 }
 
-/* 
+/*
  * Stop Rx side, basically disable emitting of
  * Rx interrupts on the port. We don't disable the rx
  * side of the chip proper though
@@ -671,7 +671,7 @@ static void pmz_stop_rx(struct uart_port *port)
 	pmz_debug("pmz: stop_rx() done.\n");
 }
 
-/* 
+/*
  * Enable modem status change interrupts
  * The port lock is held.
  */
@@ -691,7 +691,7 @@ static void pmz_enable_ms(struct uart_port *port)
 	}
 }
 
-/* 
+/*
  * Control break state emission
  * The port lock is not held.
  */
@@ -924,7 +924,7 @@ static int pmz_startup(struct uart_port *port)
 		spin_lock_irqsave(&port->lock, flags);
 		pwr_delay = __pmz_startup(uap);
 		spin_unlock_irqrestore(&port->lock, flags);
-	}	
+	}
 	sprintf(uap->irq_name, PMACZILOG_NAME"%d", uap->port.line);
 	if (request_irq(uap->port.irq, pmz_interrupt, IRQF_SHARED,
 			uap->irq_name, uap)) {
@@ -1176,7 +1176,7 @@ static void pmz_irda_setup(struct uart_pmac_port *uap, unsigned long *baud)
 	mdelay(1);
 
 	/* Switch SCC to 19200 */
-	pmz_convert_to_zs(uap, CS8, 0, 19200);		
+	pmz_convert_to_zs(uap, CS8, 0, 19200);
 	pmz_load_zsregs(uap, uap->curregs);
 	mdelay(1);
 
@@ -1284,7 +1284,7 @@ static void pmz_set_termios(struct uart_port *port, struct ktermios *termios,
 	struct uart_pmac_port *uap = to_pmz(port);
 	unsigned long flags;
 
-	spin_lock_irqsave(&port->lock, flags);	
+	spin_lock_irqsave(&port->lock, flags);
 
 	/* Disable IRQs on the port */
 	pmz_interrupt_control(uap, 0);
@@ -1415,7 +1415,7 @@ static int __init pmz_init_port(struct uart_pmac_port *uap)
 
 	uap->control_reg = uap->port.membase;
 	uap->data_reg = uap->control_reg + 0x10;
-	
+
 	/*
 	 * Request & map DBDMA registers
 	 */
@@ -1426,15 +1426,15 @@ static int __init pmz_init_port(struct uart_pmac_port *uap)
 #else
 	memset(&r_txdma, 0, sizeof(struct resource));
 	memset(&r_rxdma, 0, sizeof(struct resource));
-#endif	
+#endif
 	if (ZS_HAS_DMA(uap)) {
 		uap->tx_dma_regs = ioremap(r_txdma.start, 0x100);
-		if (uap->tx_dma_regs == NULL) {	
+		if (uap->tx_dma_regs == NULL) {
 			uap->flags &= ~PMACZILOG_FLAG_HAS_DMA;
 			goto no_dma;
 		}
 		uap->rx_dma_regs = ioremap(r_rxdma.start, 0x100);
-		if (uap->rx_dma_regs == NULL) {	
+		if (uap->rx_dma_regs == NULL) {
 			iounmap(uap->tx_dma_regs);
 			uap->tx_dma_regs = NULL;
 			uap->flags &= ~PMACZILOG_FLAG_HAS_DMA;
@@ -1545,7 +1545,7 @@ static int pmz_attach(struct macio_dev *mdev, const struct of_device_id *match)
 {
 	struct uart_pmac_port *uap;
 	int i;
-	
+
 	/* Iterate the pmz_ports array to find a matching entry
 	 */
 	for (i = 0; i < MAX_ZS_PORTS; i++)
@@ -1580,7 +1580,7 @@ static int pmz_attach(struct macio_dev *mdev, const struct of_device_id *match)
 static int pmz_detach(struct macio_dev *mdev)
 {
 	struct uart_pmac_port	*uap = dev_get_drvdata(&mdev->ofdev.dev);
-	
+
 	if (!uap)
 		return -ENODEV;
 
@@ -1593,7 +1593,7 @@ static int pmz_detach(struct macio_dev *mdev)
 	dev_set_drvdata(&mdev->ofdev.dev, NULL);
 	uap->dev = NULL;
 	uap->port.dev = NULL;
-	
+
 	return 0;
 }
 
@@ -1643,7 +1643,7 @@ static int __init pmz_probe(void)
 	for_each_node_by_name(node_p, "escc") {
 		/*
 		 * First get channel A/B node pointers
-		 * 
+		 *
 		 * TODO: Add routines with proper locking to do that...
 		 */
 		node_a = node_b = NULL;
@@ -1871,7 +1871,7 @@ static int __init init_pmz(void)
 	int rc, i;
 	printk(KERN_INFO "%s\n", version);
 
-	/* 
+	/*
 	 * First, we need to do a direct OF-based probe pass. We
 	 * do that because we want serial console up before the
 	 * macio stuffs calls us back, and since that makes it
@@ -1892,7 +1892,7 @@ static int __init init_pmz(void)
 	 */
 	rc = pmz_register();
 	if (rc) {
-		printk(KERN_ERR 
+		printk(KERN_ERR
 			"pmac_zilog: Error registering serial device, disabling pmac_zilog.\n"
 			"pmac_zilog: Did another serial driver already claim the minors?\n");
 		/* effectively "pmz_unprobe()" */
@@ -2027,7 +2027,7 @@ static int __init pmz_console_setup(struct console *co, char *options)
 	pwr_delay = __pmz_startup(uap);
 	if (pwr_delay)
 		mdelay(pwr_delay);
-	
+
 	if (options)
 		uart_parse_options(options, &baud, &parity, &bits, &flow);
 
diff --git a/drivers/tty/serial/sa1100.c b/drivers/tty/serial/sa1100.c
index a399772be3fc..ef20d42c321c 100644
--- a/drivers/tty/serial/sa1100.c
+++ b/drivers/tty/serial/sa1100.c
@@ -436,7 +436,7 @@ sa1100_set_termios(struct uart_port *port, struct ktermios *termios,
 	/*
 	 * Ask the core to calculate the divisor for us.
 	 */
-	baud = uart_get_baud_rate(port, termios, old, 0, port->uartclk/16); 
+	baud = uart_get_baud_rate(port, termios, old, 0, port->uartclk/16);
 	quot = uart_get_divisor(port, baud);
 
 	spin_lock_irqsave(&sport->port.lock, flags);
diff --git a/drivers/tty/serial/sunsab.c b/drivers/tty/serial/sunsab.c
index 7744ed852d52..680df0e62bda 100644
--- a/drivers/tty/serial/sunsab.c
+++ b/drivers/tty/serial/sunsab.c
@@ -447,7 +447,7 @@ static void sunsab_start_tx(struct uart_port *port)
 
 	up->interrupt_mask1 &= ~(SAB82532_IMR1_ALLS|SAB82532_IMR1_XPR);
 	writeb(up->interrupt_mask1, &up->regs->w.imr1);
-	
+
 	if (!test_bit(SAB82532_XPR, &up->irqflags))
 		return;
 
@@ -554,7 +554,7 @@ static int sunsab_startup(struct uart_port *port)
 	(void) readb(&up->regs->r.isr1);
 
 	/*
-	 * Now, initialize the UART 
+	 * Now, initialize the UART
 	 */
 	writeb(0, &up->regs->w.ccr0);				/* power-down */
 	writeb(SAB82532_CCR0_MCE | SAB82532_CCR0_SC_NRZ |
@@ -568,7 +568,7 @@ static int sunsab_startup(struct uart_port *port)
 			   SAB82532_MODE_RAC);
 	writeb(up->cached_mode, &up->regs->w.mode);
 	writeb(SAB82532_RFC_DPS|SAB82532_RFC_RFTH_32, &up->regs->w.rfc);
-	
+
 	tmp = readb(&up->regs->rw.ccr0);
 	tmp |= SAB82532_CCR0_PU;	/* power-up */
 	writeb(tmp, &up->regs->rw.ccr0);
@@ -612,7 +612,7 @@ static void sunsab_shutdown(struct uart_port *port)
 	up->cached_dafo &= ~SAB82532_DAFO_XBRK;
 	writeb(up->cached_dafo, &up->regs->rw.dafo);
 
-	/* Disable Receiver */	
+	/* Disable Receiver */
 	up->cached_mode &= ~SAB82532_MODE_RAC;
 	writeb(up->cached_mode, &up->regs->rw.mode);
 
@@ -627,7 +627,7 @@ static void sunsab_shutdown(struct uart_port *port)
 	 * speed the chip was configured for when the port was open).
 	 */
 #if 0
-	/* Power Down */	
+	/* Power Down */
 	tmp = readb(&up->regs->rw.ccr0);
 	tmp &= ~SAB82532_CCR0_PU;
 	writeb(tmp, &up->regs->rw.ccr0);
@@ -797,7 +797,7 @@ static const char *sunsab_type(struct uart_port *port)
 {
 	struct uart_sunsab_port *up = (void *)port;
 	static char buf[36];
-	
+
 	sprintf(buf, "SAB82532 %s", sab82532_version[up->type]);
 	return buf;
 }
@@ -942,7 +942,7 @@ static int sunsab_console_setup(struct console *con, char *options)
 	sunsab_set_mctrl(&up->port, TIOCM_DTR | TIOCM_RTS);
 
 	spin_unlock_irqrestore(&up->port.lock, flags);
-	
+
 	return 0;
 }
 
diff --git a/drivers/tty/serial/sunsu.c b/drivers/tty/serial/sunsu.c
index 1a371c37a644..a2b9b963d521 100644
--- a/drivers/tty/serial/sunsu.c
+++ b/drivers/tty/serial/sunsu.c
@@ -913,7 +913,7 @@ sunsu_set_termios(struct uart_port *port, struct ktermios *termios,
 	/*
 	 * Ask the core to calculate the divisor for us.
 	 */
-	baud = uart_get_baud_rate(port, termios, old, 0, port->uartclk/16); 
+	baud = uart_get_baud_rate(port, termios, old, 0, port->uartclk/16);
 	quot = uart_get_divisor(port, baud);
 
 	sunsu_change_speed(port, termios->c_cflag, termios->c_iflag, quot);
@@ -1079,7 +1079,7 @@ static void sunsu_autoconfig(struct uart_sunsu_port *up)
 	save_mcr = serial_in(up, UART_MCR);
 	save_lcr = serial_in(up, UART_LCR);
 
-	/* 
+	/*
 	 * Check to see if a UART is really there.  Certain broken
 	 * internal modems based on the Rockwell chipset fail this
 	 * test, because they apparently don't implement the loopback
diff --git a/drivers/tty/serial/sunzilog.c b/drivers/tty/serial/sunzilog.c
index cb0dbff46db0..801856a2c2db 100644
--- a/drivers/tty/serial/sunzilog.c
+++ b/drivers/tty/serial/sunzilog.c
@@ -228,7 +228,7 @@ static int __load_zsregs(struct zilog_channel __iomem *channel, unsigned char *r
 	/* Lower and upper byte of baud rate generator divisor.  */
 	write_zsreg(channel, R12, regs[R12]);
 	write_zsreg(channel, R13, regs[R13]);
-	
+
 	/* Now rewrite R14, with BRENAB (if set).  */
 	write_zsreg(channel, R14, regs[R14]);
 
@@ -661,7 +661,7 @@ static void sunzilog_set_mctrl(struct uart_port *port, unsigned int mctrl)
 	else
 		clear_bits |= DTR;
 
-	/* NOTE: Not subject to 'transmitter active' rule.  */ 
+	/* NOTE: Not subject to 'transmitter active' rule.  */
 	up->curregs[R5] |= set_bits;
 	up->curregs[R5] &= ~clear_bits;
 	write_zsreg(channel, R5, up->curregs[R5]);
@@ -749,7 +749,7 @@ static void sunzilog_enable_ms(struct uart_port *port)
 	if (new_reg != up->curregs[R15]) {
 		up->curregs[R15] = new_reg;
 
-		/* NOTE: Not subject to 'transmitter active' rule.  */ 
+		/* NOTE: Not subject to 'transmitter active' rule.  */
 		write_zsreg(channel, R15, up->curregs[R15] & ~WR7pEN);
 	}
 }
@@ -776,7 +776,7 @@ static void sunzilog_break_ctl(struct uart_port *port, int break_state)
 	if (new_reg != up->curregs[R5]) {
 		up->curregs[R5] = new_reg;
 
-		/* NOTE: Not subject to 'transmitter active' rule.  */ 
+		/* NOTE: Not subject to 'transmitter active' rule.  */
 		write_zsreg(channel, R5, up->curregs[R5]);
 	}
 
diff --git a/drivers/tty/synclink.c b/drivers/tty/synclink.c
index fbdf4d01c6a9..1dec82fae106 100644
--- a/drivers/tty/synclink.c
+++ b/drivers/tty/synclink.c
@@ -21,7 +21,7 @@
  * contains exactly one complete HDLC frame. Calling mgsl_put_char
  * will start assembling an HDLC frame that will not be sent until
  * mgsl_flush_chars or mgsl_write is called.
- * 
+ *
  * Synchronous receive data is reported as complete frames. To accomplish
  * this, the TTY flip buffer is bypassed (too small to hold largest
  * frame and may fragment frames) and the line discipline
@@ -153,7 +153,7 @@ typedef struct _DMABUFFERENTRY
 #define IO_PIN_SHUTDOWN_LIMIT 100
 
 struct	_input_signal_events {
-	int	ri_up;	
+	int	ri_up;
 	int	ri_down;
 	int	dsr_up;
 	int	dsr_down;
@@ -174,29 +174,29 @@ struct tx_holding_buffer {
 /*
  * Device instance data structure
  */
- 
+
 struct mgsl_struct {
 	int			magic;
 	struct tty_port		port;
 	int			line;
 	int                     hw_version;
-	
+
 	struct mgsl_icount	icount;
-	
+
 	int			timeout;
 	int			x_char;		/* xon/xoff character */
 	u16			read_status_mask;
-	u16			ignore_status_mask;	
+	u16			ignore_status_mask;
 	unsigned char 		*xmit_buf;
 	int			xmit_head;
 	int			xmit_tail;
 	int			xmit_cnt;
-	
+
 	wait_queue_head_t	status_event_wait_q;
 	wait_queue_head_t	event_wait_q;
 	struct timer_list	tx_timer;	/* HDLC transmit timeout timer */
 	struct mgsl_struct	*next_device;	/* device list link */
-	
+
 	spinlock_t irq_spinlock;		/* spinlock for synchronizing with ISR */
 	struct work_struct task;		/* task structure for scheduling bh */
 
@@ -210,7 +210,7 @@ struct mgsl_struct {
 	bool bh_running;		/* Protection from multiple */
 	int isr_overflow;
 	bool bh_requested;
-	
+
 	int dcd_chkcount;		/* check counts to prevent */
 	int cts_chkcount;		/* too many IRQs if a signal */
 	int dsr_chkcount;		/* is floating */
@@ -230,7 +230,7 @@ struct mgsl_struct {
 	DMABUFFERENTRY *tx_buffer_list;	/* list of transmit buffer entries */
 	int start_tx_dma_buffer;	/* tx dma buffer to start tx dma operation */
 	int current_tx_buffer;          /* next tx dma buffer to be loaded */
-	
+
 	unsigned char *intermediate_rxbuffer;
 
 	int num_tx_holding_buffers;	/* number of tx holding buffer allocated */
@@ -259,11 +259,11 @@ struct mgsl_struct {
 	unsigned int io_base;		/* base I/O address of adapter */
 	unsigned int io_addr_size;	/* size of the I/O address range */
 	bool io_addr_requested;		/* true if I/O address requested */
-	
+
 	unsigned int irq_level;		/* interrupt level */
 	unsigned long irq_flags;
 	bool irq_requested;		/* true if IRQ requested */
-	
+
 	unsigned int dma_level;		/* DMA channel */
 	bool dma_requested;		/* true if dma channel requested */
 
@@ -295,7 +295,7 @@ struct mgsl_struct {
 
 	bool loopmode_insert_requested;
 	bool loopmode_send_done_requested;
-	
+
 	struct	_input_signal_events	input_signal_events;
 
 	/* generic HDLC device parts */
@@ -376,7 +376,7 @@ struct mgsl_struct {
 #define DCR	0x06	/* DMA Control Register (shared) */
 #define DACR	0x08	/* DMA Array count Register (shared) */
 #define BDCR	0x12	/* Burst/Dwell Control Register (shared) */
-#define DIVR	0x14	/* DMA Interrupt Vector Register (shared) */	
+#define DIVR	0x14	/* DMA Interrupt Vector Register (shared) */
 #define DICR	0x18	/* DMA Interrupt Control Register (shared) */
 #define CDIR	0x1a	/* Clear DMA Interrupt Register (shared) */
 #define SDIR	0x1c	/* Set DMA Interrupt Register (shared) */
@@ -486,7 +486,7 @@ struct mgsl_struct {
 /*
  * Bits for enabling and disabling IRQs in Interrupt Control Register (ICR)
  */
- 
+
 #define RECEIVE_STATUS		BIT5
 #define RECEIVE_DATA		BIT4
 #define TRANSMIT_STATUS		BIT3
@@ -516,7 +516,7 @@ struct mgsl_struct {
 #define usc_UnlatchRxstatusBits(a,b) usc_OutReg( (a), RCSR, (u16)((b) & RXSTATUS_ALL) )
 
 /*
- * Values for setting transmit idle mode in 
+ * Values for setting transmit idle mode in
  * Transmit Control/status Register (TCSR)
  */
 #define IDLEMODE_FLAGS			0x0000
@@ -552,7 +552,7 @@ struct mgsl_struct {
 #define TXSTATUS_FIFO_EMPTY		BIT0
 #define TXSTATUS_ALL			0x00fa
 #define usc_UnlatchTxstatusBits(a,b) usc_OutReg( (a), TCSR, (u16)((a)->tcsr_value + ((b) & 0x00FF)) )
-				
+
 
 #define MISCSTATUS_RXC_LATCHED		BIT15
 #define MISCSTATUS_RXC			BIT14
@@ -865,7 +865,7 @@ static int debug_level;
 static int maxframe[MAX_TOTAL_DEVICES];
 static int txdmabufs[MAX_TOTAL_DEVICES];
 static int txholdbufs[MAX_TOTAL_DEVICES];
-	
+
 module_param(break_on_load, bool, 0);
 module_param(ttymajor, int, 0);
 module_param_hw_array(io, int, ioport, NULL, 0);
@@ -967,7 +967,7 @@ static void ldisc_receive_buf(struct tty_struct *tty,
 }
 
 /* mgsl_stop()		throttle (stop) transmitter
- * 	
+ *
  * Arguments:		tty	pointer to tty info structure
  * Return Value:	None
  */
@@ -975,22 +975,22 @@ static void mgsl_stop(struct tty_struct *tty)
 {
 	struct mgsl_struct *info = tty->driver_data;
 	unsigned long flags;
-	
+
 	if (mgsl_paranoia_check(info, tty->name, "mgsl_stop"))
 		return;
-	
+
 	if ( debug_level >= DEBUG_LEVEL_INFO )
-		printk("mgsl_stop(%s)\n",info->device_name);	
-		
+		printk("mgsl_stop(%s)\n",info->device_name);
+
 	spin_lock_irqsave(&info->irq_spinlock,flags);
 	if (info->tx_enabled)
 	 	usc_stop_transmitter(info);
 	spin_unlock_irqrestore(&info->irq_spinlock,flags);
-	
+
 }	/* end of mgsl_stop() */
 
 /* mgsl_start()		release (start) transmitter
- * 	
+ *
  * Arguments:		tty	pointer to tty info structure
  * Return Value:	None
  */
@@ -998,18 +998,18 @@ static void mgsl_start(struct tty_struct *tty)
 {
 	struct mgsl_struct *info = tty->driver_data;
 	unsigned long flags;
-	
+
 	if (mgsl_paranoia_check(info, tty->name, "mgsl_start"))
 		return;
-	
+
 	if ( debug_level >= DEBUG_LEVEL_INFO )
-		printk("mgsl_start(%s)\n",info->device_name);	
-		
+		printk("mgsl_start(%s)\n",info->device_name);
+
 	spin_lock_irqsave(&info->irq_spinlock,flags);
 	if (!info->tx_enabled)
 	 	usc_start_transmitter(info);
 	spin_unlock_irqrestore(&info->irq_spinlock,flags);
-	
+
 }	/* end of mgsl_start() */
 
 /*
@@ -1023,7 +1023,7 @@ static int mgsl_bh_action(struct mgsl_struct *info)
 {
 	unsigned long flags;
 	int rc = 0;
-	
+
 	spin_lock_irqsave(&info->irq_spinlock,flags);
 
 	if (info->pending_bh & BH_RECEIVE) {
@@ -1042,9 +1042,9 @@ static int mgsl_bh_action(struct mgsl_struct *info)
 		info->bh_running = false;
 		info->bh_requested = false;
 	}
-	
+
 	spin_unlock_irqrestore(&info->irq_spinlock,flags);
-	
+
 	return rc;
 }
 
@@ -1060,18 +1060,18 @@ static void mgsl_bh_handler(struct work_struct *work)
 	if ( debug_level >= DEBUG_LEVEL_BH )
 		printk( "%s(%d):mgsl_bh_handler(%s) entry\n",
 			__FILE__,__LINE__,info->device_name);
-	
+
 	info->bh_running = true;
 
 	while((action = mgsl_bh_action(info)) != 0) {
-	
+
 		/* Process work item */
 		if ( debug_level >= DEBUG_LEVEL_BH )
 			printk( "%s(%d):mgsl_bh_handler() work item action=%d\n",
 				__FILE__,__LINE__,action);
 
 		switch (action) {
-		
+
 		case BH_RECEIVE:
 			mgsl_bh_receive(info);
 			break;
@@ -1101,7 +1101,7 @@ static void mgsl_bh_receive(struct mgsl_struct *info)
 	if ( debug_level >= DEBUG_LEVEL_BH )
 		printk( "%s(%d):mgsl_bh_receive(%s)\n",
 			__FILE__,__LINE__,info->device_name);
-	
+
 	do
 	{
 		if (info->rx_rcc_underrun) {
@@ -1118,7 +1118,7 @@ static void mgsl_bh_transmit(struct mgsl_struct *info)
 {
 	struct tty_struct *tty = info->port.tty;
 	unsigned long flags;
-	
+
 	if ( debug_level >= DEBUG_LEVEL_BH )
 		printk( "%s(%d):mgsl_bh_transmit() entry on %s\n",
 			__FILE__,__LINE__,info->device_name);
@@ -1148,7 +1148,7 @@ static void mgsl_bh_status(struct mgsl_struct *info)
 }
 
 /* mgsl_isr_receive_status()
- * 
+ *
  *	Service a receive status interrupt. The type of status
  *	interrupt is indicated by the state of the RCSR.
  *	This is only used for HDLC mode.
@@ -1163,18 +1163,18 @@ static void mgsl_isr_receive_status( struct mgsl_struct *info )
 	if ( debug_level >= DEBUG_LEVEL_ISR )
 		printk("%s(%d):mgsl_isr_receive_status status=%04X\n",
 			__FILE__,__LINE__,status);
-			
- 	if ( (status & RXSTATUS_ABORT_RECEIVED) && 
+
+	if ( (status & RXSTATUS_ABORT_RECEIVED) &&
 		info->loopmode_insert_requested &&
  		usc_loopmode_active(info) )
  	{
 		++info->icount.rxabort;
 	 	info->loopmode_insert_requested = false;
- 
+
  		/* clear CMR:13 to start echoing RxD to TxD */
 		info->cmr_value &= ~BIT13;
  		usc_OutReg(info, CMR, info->cmr_value);
- 
+
 		/* disable received abort irq (no longer required) */
 	 	usc_OutReg(info, RICR,
  			(usc_InReg(info, RICR) & ~RXSTATUS_ABORT_RECEIVED));
@@ -1199,12 +1199,12 @@ static void mgsl_isr_receive_status( struct mgsl_struct *info )
 }	/* end of mgsl_isr_receive_status() */
 
 /* mgsl_isr_transmit_status()
- * 
+ *
  * 	Service a transmit status interrupt
  *	HDLC mode :end of transmit frame
  *	Async mode:all data is sent
  * 	transmit status is indicated by bits in the TCSR.
- * 
+ *
  * Arguments:		info	       pointer to device instance data
  * Return Value:	None
  */
@@ -1212,13 +1212,13 @@ static void mgsl_isr_transmit_status( struct mgsl_struct *info )
 {
 	u16 status = usc_InReg( info, TCSR );
 
-	if ( debug_level >= DEBUG_LEVEL_ISR )	
+	if ( debug_level >= DEBUG_LEVEL_ISR )
 		printk("%s(%d):mgsl_isr_transmit_status status=%04X\n",
 			__FILE__,__LINE__,status);
-	
+
 	usc_ClearIrqPendingBits( info, TRANSMIT_STATUS );
 	usc_UnlatchTxstatusBits( info, status );
-	
+
 	if ( status & (TXSTATUS_UNDERRUN | TXSTATUS_ABORT_SENT) )
 	{
 		/* finished sending HDLC abort. This may leave	*/
@@ -1229,7 +1229,7 @@ static void mgsl_isr_transmit_status( struct mgsl_struct *info )
  		usc_DmaCmd( info, DmaCmd_ResetTxChannel );
  		usc_RTCmd( info, RTCmd_PurgeTxFifo );
 	}
- 
+
 	if ( status & TXSTATUS_EOF_SENT )
 		info->icount.txok++;
 	else if ( status & TXSTATUS_UNDERRUN )
@@ -1238,11 +1238,11 @@ static void mgsl_isr_transmit_status( struct mgsl_struct *info )
 		info->icount.txabort++;
 	else
 		info->icount.txunder++;
-			
+
 	info->tx_active = false;
 	info->xmit_cnt = info->xmit_head = info->xmit_tail = 0;
-	del_timer(&info->tx_timer);	
-	
+	del_timer(&info->tx_timer);
+
 	if ( info->drop_rts_on_tx_done ) {
 		usc_get_serial_signals( info );
 		if ( info->serial_signals & SerialSignal_RTS ) {
@@ -1255,7 +1255,7 @@ static void mgsl_isr_transmit_status( struct mgsl_struct *info )
 #if SYNCLINK_GENERIC_HDLC
 	if (info->netcount)
 		hdlcdev_tx_done(info);
-	else 
+	else
 #endif
 	{
 		if (info->port.tty->stopped || info->port.tty->hw_stopped) {
@@ -1268,10 +1268,10 @@ static void mgsl_isr_transmit_status( struct mgsl_struct *info )
 }	/* end of mgsl_isr_transmit_status() */
 
 /* mgsl_isr_io_pin()
- * 
+ *
  * 	Service an Input/Output pin interrupt. The type of
  * 	interrupt is indicated by bits in the MISR
- * 	
+ *
  * Arguments:		info	       pointer to device instance data
  * Return Value:	None
  */
@@ -1280,10 +1280,10 @@ static void mgsl_isr_io_pin( struct mgsl_struct *info )
  	struct	mgsl_icount *icount;
 	u16 status = usc_InReg( info, MISR );
 
-	if ( debug_level >= DEBUG_LEVEL_ISR )	
+	if ( debug_level >= DEBUG_LEVEL_ISR )
 		printk("%s(%d):mgsl_isr_io_pin status=%04X\n",
 			__FILE__,__LINE__,status);
-			
+
 	usc_ClearIrqPendingBits( info, IO_PIN );
 	usc_UnlatchIostatusBits( info, status );
 
@@ -1296,9 +1296,9 @@ static void mgsl_isr_io_pin( struct mgsl_struct *info )
 				usc_DisablestatusIrqs(info,SICR_RI);
 			icount->rng++;
 			if ( status & MISCSTATUS_RI )
-				info->input_signal_events.ri_up++;	
+				info->input_signal_events.ri_up++;
 			else
-				info->input_signal_events.ri_down++;	
+				info->input_signal_events.ri_down++;
 		}
 		if (status & MISCSTATUS_DSR_LATCHED) {
 			if ((info->dsr_chkcount)++ >= IO_PIN_SHUTDOWN_LIMIT)
@@ -1353,7 +1353,7 @@ static void mgsl_isr_io_pin( struct mgsl_struct *info )
 					tty_hangup(info->port.tty);
 			}
 		}
-	
+
 		if (tty_port_cts_enabled(&info->port) &&
 		     (status & MISCSTATUS_CTS_LATCHED) ) {
 			if (info->port.tty->hw_stopped) {
@@ -1378,7 +1378,7 @@ static void mgsl_isr_io_pin( struct mgsl_struct *info )
 	}
 
 	info->pending_bh |= BH_STATUS;
-	
+
 	/* for diagnostics set IRQ flag */
 	if ( status & MISCSTATUS_TXC_LATCHED ){
 		usc_OutReg( info, SICR,
@@ -1390,41 +1390,41 @@ static void mgsl_isr_io_pin( struct mgsl_struct *info )
 }	/* end of mgsl_isr_io_pin() */
 
 /* mgsl_isr_transmit_data()
- * 
+ *
  * 	Service a transmit data interrupt (async mode only).
- * 
+ *
  * Arguments:		info	pointer to device instance data
  * Return Value:	None
  */
 static void mgsl_isr_transmit_data( struct mgsl_struct *info )
 {
-	if ( debug_level >= DEBUG_LEVEL_ISR )	
+	if ( debug_level >= DEBUG_LEVEL_ISR )
 		printk("%s(%d):mgsl_isr_transmit_data xmit_cnt=%d\n",
 			__FILE__,__LINE__,info->xmit_cnt);
-			
+
 	usc_ClearIrqPendingBits( info, TRANSMIT_DATA );
-	
+
 	if (info->port.tty->stopped || info->port.tty->hw_stopped) {
 		usc_stop_transmitter(info);
 		return;
 	}
-	
+
 	if ( info->xmit_cnt )
 		usc_load_txfifo( info );
 	else
 		info->tx_active = false;
-		
+
 	if (info->xmit_cnt < WAKEUP_CHARS)
 		info->pending_bh |= BH_TRANSMIT;
 
 }	/* end of mgsl_isr_transmit_data() */
 
 /* mgsl_isr_receive_data()
- * 
+ *
  * 	Service a receive data interrupt. This occurs
  * 	when operating in asynchronous interrupt transfer mode.
- *	The receive data FIFO is flushed to the receive data buffers. 
- * 
+ *	The receive data FIFO is flushed to the receive data buffers.
+ *
  * Arguments:		info		pointer to device instance data
  * Return Value:	None
  */
@@ -1435,13 +1435,13 @@ static void mgsl_isr_receive_data( struct mgsl_struct *info )
 	int work = 0;
 	unsigned char DataByte;
  	struct	mgsl_icount *icount = &info->icount;
-	
-	if ( debug_level >= DEBUG_LEVEL_ISR )	
+
+	if ( debug_level >= DEBUG_LEVEL_ISR )
 		printk("%s(%d):mgsl_isr_receive_data\n",
 			__FILE__,__LINE__);
 
 	usc_ClearIrqPendingBits( info, RECEIVE_DATA );
-	
+
 	/* select FIFO status for RICR readback */
 	usc_RCmd( info, RCmd_SelectRicrRxFifostatus );
 
@@ -1464,9 +1464,9 @@ static void mgsl_isr_receive_data( struct mgsl_struct *info )
 		if ( status & (RXSTATUS_FRAMING_ERROR | RXSTATUS_PARITY_ERROR |
 				RXSTATUS_OVERRUN | RXSTATUS_BREAK_RECEIVED) )
 			usc_UnlatchRxstatusBits(info,RXSTATUS_ALL);
-		
+
 		icount->rx++;
-		
+
 		flag = 0;
 		if ( status & (RXSTATUS_FRAMING_ERROR | RXSTATUS_PARITY_ERROR |
 				RXSTATUS_OVERRUN | RXSTATUS_BREAK_RECEIVED) ) {
@@ -1489,9 +1489,9 @@ static void mgsl_isr_receive_data( struct mgsl_struct *info )
 			/* discard char if tty control flags say so */
 			if (status & info->ignore_status_mask)
 				continue;
-				
+
 			status &= info->read_status_mask;
-		
+
 			if (status & RXSTATUS_BREAK_RECEIVED) {
 				flag = TTY_BREAK;
 				if (info->port.flags & ASYNC_SAK)
@@ -1516,15 +1516,15 @@ static void mgsl_isr_receive_data( struct mgsl_struct *info )
 			__FILE__,__LINE__,icount->rx,icount->brk,
 			icount->parity,icount->frame,icount->overrun);
 	}
-			
+
 	if(work)
 		tty_flip_buffer_push(&info->port);
 }
 
 /* mgsl_isr_misc()
- * 
+ *
  * 	Service a miscellaneous interrupt source.
- * 	
+ *
  * Arguments:		info		pointer to device extension (instance data)
  * Return Value:	None
  */
@@ -1532,10 +1532,10 @@ static void mgsl_isr_misc( struct mgsl_struct *info )
 {
 	u16 status = usc_InReg( info, MISR );
 
-	if ( debug_level >= DEBUG_LEVEL_ISR )	
+	if ( debug_level >= DEBUG_LEVEL_ISR )
 		printk("%s(%d):mgsl_isr_misc status=%04X\n",
 			__FILE__,__LINE__,status);
-			
+
 	if ((status & MISCSTATUS_RCC_UNDERRUN) &&
 	    (info->params.mode == MGSL_MODE_HDLC)) {
 
@@ -1560,7 +1560,7 @@ static void mgsl_isr_misc( struct mgsl_struct *info )
  *
  * 	Services undefined interrupt vectors from the
  * 	USC. (hence this function SHOULD never be called)
- * 
+ *
  * Arguments:		info		pointer to device extension (instance data)
  * Return Value:	None
  */
@@ -1570,28 +1570,28 @@ static void mgsl_isr_null( struct mgsl_struct *info )
 }	/* end of mgsl_isr_null() */
 
 /* mgsl_isr_receive_dma()
- * 
+ *
  * 	Service a receive DMA channel interrupt.
  * 	For this driver there are two sources of receive DMA interrupts
  * 	as identified in the Receive DMA mode Register (RDMR):
- * 
+ *
  * 	BIT3	EOA/EOL		End of List, all receive buffers in receive
  * 				buffer list have been filled (no more free buffers
  * 				available). The DMA controller has shut down.
- * 
+ *
  * 	BIT2	EOB		End of Buffer. This interrupt occurs when a receive
  * 				DMA buffer is terminated in response to completion
  * 				of a good frame or a frame with errors. The status
  * 				of the frame is stored in the buffer entry in the
  * 				list of receive buffer entries.
- * 
+ *
  * Arguments:		info		pointer to device instance data
  * Return Value:	None
  */
 static void mgsl_isr_receive_dma( struct mgsl_struct *info )
 {
 	u16 status;
-	
+
 	/* clear interrupt pending and IUS bit for Rx DMA IRQ */
 	usc_OutDmaReg( info, CDIR, BIT9 | BIT1 );
 
@@ -1599,12 +1599,12 @@ static void mgsl_isr_receive_dma( struct mgsl_struct *info )
 	/* This also clears the status bits. */
 	status = usc_InDmaReg( info, RDMR );
 
-	if ( debug_level >= DEBUG_LEVEL_ISR )	
+	if ( debug_level >= DEBUG_LEVEL_ISR )
 		printk("%s(%d):mgsl_isr_receive_dma(%s) status=%04X\n",
 			__FILE__,__LINE__,info->device_name,status);
-			
+
 	info->pending_bh |= BH_RECEIVE;
-	
+
 	if ( status & BIT3 ) {
 		info->rx_overflow = true;
 		info->icount.buf_overrun++;
@@ -1665,14 +1665,14 @@ static void mgsl_isr_transmit_dma( struct mgsl_struct *info )
 }	/* end of mgsl_isr_transmit_dma() */
 
 /* mgsl_interrupt()
- * 
+ *
  * 	Interrupt service routine entry point.
- * 	
+ *
  * Arguments:
- * 
+ *
  * 	irq		interrupt number that caused interrupt
  * 	dev_id		device ID supplied during interrupt registration
- * 	
+ *
  * Return Value: None
  */
 static irqreturn_t mgsl_interrupt(int dummy, void *dev_id)
@@ -1681,7 +1681,7 @@ static irqreturn_t mgsl_interrupt(int dummy, void *dev_id)
 	u16 UscVector;
 	u16 DmaVector;
 
-	if ( debug_level >= DEBUG_LEVEL_ISR )	
+	if ( debug_level >= DEBUG_LEVEL_ISR )
 		printk(KERN_DEBUG "%s(%d):mgsl_interrupt(%d)entry.\n",
 			__FILE__, __LINE__, info->irq_level);
 
@@ -1691,14 +1691,14 @@ static irqreturn_t mgsl_interrupt(int dummy, void *dev_id)
 		/* Read the interrupt vectors from hardware. */
 		UscVector = usc_InReg(info, IVR) >> 9;
 		DmaVector = usc_InDmaReg(info, DIVR);
-		
-		if ( debug_level >= DEBUG_LEVEL_ISR )	
+
+		if ( debug_level >= DEBUG_LEVEL_ISR )
 			printk("%s(%d):%s UscVector=%08X DmaVector=%08X\n",
 				__FILE__,__LINE__,info->device_name,UscVector,DmaVector);
-			
+
 		if ( !UscVector && !DmaVector )
 			break;
-			
+
 		/* Dispatch interrupt vector */
 		if ( UscVector )
 			(*UscIsrTable[UscVector])(info);
@@ -1715,13 +1715,13 @@ static irqreturn_t mgsl_interrupt(int dummy, void *dev_id)
 			break;
 		}
 	}
-	
-	/* Request bottom half processing if there's something 
+
+	/* Request bottom half processing if there's something
 	 * for it to do and the bh is not already running
 	 */
 
 	if ( info->pending_bh && !info->bh_running && !info->bh_requested ) {
-		if ( debug_level >= DEBUG_LEVEL_ISR )	
+		if ( debug_level >= DEBUG_LEVEL_ISR )
 			printk("%s(%d):%s queueing bh task.\n",
 				__FILE__,__LINE__,info->device_name);
 		schedule_work(&info->task);
@@ -1729,8 +1729,8 @@ static irqreturn_t mgsl_interrupt(int dummy, void *dev_id)
 	}
 
 	spin_unlock(&info->irq_spinlock);
-	
-	if ( debug_level >= DEBUG_LEVEL_ISR )	
+
+	if ( debug_level >= DEBUG_LEVEL_ISR )
 		printk(KERN_DEBUG "%s(%d):mgsl_interrupt(%d)exit.\n",
 			__FILE__, __LINE__, info->irq_level);
 
@@ -1738,9 +1738,9 @@ static irqreturn_t mgsl_interrupt(int dummy, void *dev_id)
 }	/* end of mgsl_interrupt() */
 
 /* startup()
- * 
+ *
  * 	Initialize and start device.
- * 	
+ *
  * Arguments:		info	pointer to device instance data
  * Return Value:	0 if success, otherwise error code
  */
@@ -1765,18 +1765,18 @@ static int startup(struct mgsl_struct * info)
 	}
 
 	info->pending_bh = 0;
-	
+
 	memset(&info->icount, 0, sizeof(info->icount));
 
 	timer_setup(&info->tx_timer, mgsl_tx_timeout, 0);
-	
+
 	/* Allocate and claim adapter resources */
 	retval = mgsl_claim_resources(info);
-	
+
 	/* perform existence check and diagnostics */
 	if ( !retval )
 		retval = mgsl_adapter_test(info);
-		
+
 	if ( retval ) {
   		if (capable(CAP_SYS_ADMIN) && info->port.tty)
 			set_bit(TTY_IO_ERROR, &info->port.tty->flags);
@@ -1863,20 +1863,20 @@ static void mgsl_program_hw(struct mgsl_struct *info)
 	unsigned long flags;
 
 	spin_lock_irqsave(&info->irq_spinlock,flags);
-	
+
 	usc_stop_receiver(info);
 	usc_stop_transmitter(info);
 	info->xmit_cnt = info->xmit_head = info->xmit_tail = 0;
-	
+
 	if (info->params.mode == MGSL_MODE_HDLC ||
 	    info->params.mode == MGSL_MODE_RAW ||
 	    info->netcount)
 		usc_set_sync_mode(info);
 	else
 		usc_set_async_mode(info);
-		
+
 	usc_set_serial_signals(info);
-	
+
 	info->dcd_chkcount = 0;
 	info->cts_chkcount = 0;
 	info->ri_chkcount = 0;
@@ -1885,10 +1885,10 @@ static void mgsl_program_hw(struct mgsl_struct *info)
 	usc_EnableStatusIrqs(info,SICR_CTS+SICR_DSR+SICR_DCD+SICR_RI);
 	usc_EnableInterrupts(info, IO_PIN);
 	usc_get_serial_signals(info);
-		
+
 	if (info->netcount || info->port.tty->termios.c_cflag & CREAD)
 		usc_start_receiver(info);
-		
+
 	spin_unlock_irqrestore(&info->irq_spinlock,flags);
 }
 
@@ -1901,11 +1901,11 @@ static void mgsl_change_params(struct mgsl_struct *info)
 
 	if (!info->port.tty)
 		return;
-		
+
 	if (debug_level >= DEBUG_LEVEL_INFO)
 		printk("%s(%d):mgsl_change_params(%s)\n",
 			 __FILE__,__LINE__, info->device_name );
-			 
+
 	cflag = info->port.tty->termios.c_cflag;
 
 	/* if B0 rate (hangup) specified then negate RTS and DTR */
@@ -1914,9 +1914,9 @@ static void mgsl_change_params(struct mgsl_struct *info)
 		info->serial_signals |= SerialSignal_RTS | SerialSignal_DTR;
 	else
 		info->serial_signals &= ~(SerialSignal_RTS | SerialSignal_DTR);
-	
+
 	/* byte size and parity */
-	
+
 	switch (cflag & CSIZE) {
 	      case CS5: info->params.data_bits = 5; break;
 	      case CS6: info->params.data_bits = 6; break;
@@ -1925,7 +1925,7 @@ static void mgsl_change_params(struct mgsl_struct *info)
 	      /* Never happens, but GCC is too dumb to figure it out */
 	      default:  info->params.data_bits = 7; break;
 	      }
-	      
+
 	if (cflag & CSTOPB)
 		info->params.stop_bits = 2;
 	else
@@ -1946,7 +1946,7 @@ static void mgsl_change_params(struct mgsl_struct *info)
 	/* calculate number of jiffies to transmit a full
 	 * FIFO (32 bytes) at specified data rate
 	 */
-	bits_per_char = info->params.data_bits + 
+	bits_per_char = info->params.data_bits +
 			info->params.stop_bits + 1;
 
 	/* if port data rate is set to 460800 or less then
@@ -1955,9 +1955,9 @@ static void mgsl_change_params(struct mgsl_struct *info)
 	 */
 	if (info->params.data_rate <= 460800)
 		info->params.data_rate = tty_get_baud_rate(info->port.tty);
-	
+
 	if ( info->params.data_rate ) {
-		info->timeout = (32*HZ*bits_per_char) / 
+		info->timeout = (32*HZ*bits_per_char) /
 				info->params.data_rate;
 	}
 	info->timeout += HZ/50;		/* Add .02 seconds of slop */
@@ -1966,18 +1966,18 @@ static void mgsl_change_params(struct mgsl_struct *info)
 	tty_port_set_check_carrier(&info->port, ~cflag & CLOCAL);
 
 	/* process tty input control flags */
-	
+
 	info->read_status_mask = RXSTATUS_OVERRUN;
 	if (I_INPCK(info->port.tty))
 		info->read_status_mask |= RXSTATUS_PARITY_ERROR | RXSTATUS_FRAMING_ERROR;
  	if (I_BRKINT(info->port.tty) || I_PARMRK(info->port.tty))
  		info->read_status_mask |= RXSTATUS_BREAK_RECEIVED;
-	
+
 	if (I_IGNPAR(info->port.tty))
 		info->ignore_status_mask |= RXSTATUS_PARITY_ERROR | RXSTATUS_FRAMING_ERROR;
 	if (I_IGNBRK(info->port.tty)) {
 		info->ignore_status_mask |= RXSTATUS_BREAK_RECEIVED;
-		/* If ignoring parity and break indicators, ignore 
+		/* If ignoring parity and break indicators, ignore
 		 * overruns too.  (For real raw support).
 		 */
 		if (I_IGNPAR(info->port.tty))
@@ -1989,12 +1989,12 @@ static void mgsl_change_params(struct mgsl_struct *info)
 }	/* end of mgsl_change_params() */
 
 /* mgsl_put_char()
- * 
+ *
  * 	Add a character to the transmit buffer.
- * 	
+ *
  * Arguments:		tty	pointer to tty information structure
  * 			ch	character to add to transmit buffer
- * 		
+ *
  * Return Value:	None
  */
 static int mgsl_put_char(struct tty_struct *tty, unsigned char ch)
@@ -2006,8 +2006,8 @@ static int mgsl_put_char(struct tty_struct *tty, unsigned char ch)
 	if (debug_level >= DEBUG_LEVEL_INFO) {
 		printk(KERN_DEBUG "%s(%d):mgsl_put_char(%d) on %s\n",
 			__FILE__, __LINE__, ch, info->device_name);
-	}		
-	
+	}
+
 	if (mgsl_paranoia_check(info, tty->name, "mgsl_put_char"))
 		return 0;
 
@@ -2015,7 +2015,7 @@ static int mgsl_put_char(struct tty_struct *tty, unsigned char ch)
 		return 0;
 
 	spin_lock_irqsave(&info->irq_spinlock, flags);
-	
+
 	if ((info->params.mode == MGSL_MODE_ASYNC ) || !info->tx_active) {
 		if (info->xmit_cnt < SERIAL_XMIT_SIZE - 1) {
 			info->xmit_buf[info->xmit_head++] = ch;
@@ -2026,14 +2026,14 @@ static int mgsl_put_char(struct tty_struct *tty, unsigned char ch)
 	}
 	spin_unlock_irqrestore(&info->irq_spinlock, flags);
 	return ret;
-	
+
 }	/* end of mgsl_put_char() */
 
 /* mgsl_flush_chars()
- * 
+ *
  * 	Enable transmitter so remaining characters in the
  * 	transmit buffer are sent.
- * 	
+ *
  * Arguments:		tty	pointer to tty information structure
  * Return Value:	None
  */
@@ -2041,11 +2041,11 @@ static void mgsl_flush_chars(struct tty_struct *tty)
 {
 	struct mgsl_struct *info = tty->driver_data;
 	unsigned long flags;
-				
+
 	if ( debug_level >= DEBUG_LEVEL_INFO )
 		printk( "%s(%d):mgsl_flush_chars() entry on %s xmit_cnt=%d\n",
 			__FILE__,__LINE__,info->device_name,info->xmit_cnt);
-	
+
 	if (mgsl_paranoia_check(info, tty->name, "mgsl_flush_chars"))
 		return;
 
@@ -2058,7 +2058,7 @@ static void mgsl_flush_chars(struct tty_struct *tty)
 			__FILE__,__LINE__,info->device_name );
 
 	spin_lock_irqsave(&info->irq_spinlock,flags);
-	
+
 	if (!info->tx_active) {
 		if ( (info->params.mode == MGSL_MODE_HDLC ||
 			info->params.mode == MGSL_MODE_RAW) && info->xmit_cnt ) {
@@ -2070,21 +2070,21 @@ static void mgsl_flush_chars(struct tty_struct *tty)
 		}
 	 	usc_start_transmitter(info);
 	}
-	
+
 	spin_unlock_irqrestore(&info->irq_spinlock,flags);
-	
+
 }	/* end of mgsl_flush_chars() */
 
 /* mgsl_write()
- * 
+ *
  * 	Send a block of data
- * 	
+ *
  * Arguments:
- * 
+ *
  * 	tty		pointer to tty information structure
  * 	buf		pointer to buffer containing send data
  * 	count		size of send data in bytes
- * 	
+ *
  * Return Value:	number of characters written
  */
 static int mgsl_write(struct tty_struct * tty,
@@ -2093,11 +2093,11 @@ static int mgsl_write(struct tty_struct * tty,
 	int	c, ret = 0;
 	struct mgsl_struct *info = tty->driver_data;
 	unsigned long flags;
-	
+
 	if ( debug_level >= DEBUG_LEVEL_INFO )
 		printk( "%s(%d):mgsl_write(%s) count=%d\n",
 			__FILE__,__LINE__,info->device_name,count);
-	
+
 	if (mgsl_paranoia_check(info, tty->name, "mgsl_write"))
 		goto cleanup;
 
@@ -2136,7 +2136,7 @@ static int mgsl_write(struct tty_struct * tty,
 			spin_unlock_irqrestore(&info->irq_spinlock,flags);
 			goto cleanup;
 		}
-	
+
 		/* if operating in HDLC LoopMode and the adapter  */
 		/* has yet to be inserted into the loop, we can't */
 		/* transmit					  */
@@ -2152,7 +2152,7 @@ static int mgsl_write(struct tty_struct * tty,
 			/* Send accumulated from send_char() calls */
 			/* as frame and wait before accepting more data. */
 			ret = 0;
-			
+
 			/* copy data from circular xmit_buf to */
 			/* transmit DMA buffer. */
 			mgsl_load_tx_dma_buffer(info,
@@ -2187,27 +2187,27 @@ static int mgsl_write(struct tty_struct * tty,
 			count -= c;
 			ret += c;
 		}
-	}	
-	
+	}
+
  	if (info->xmit_cnt && !tty->stopped && !tty->hw_stopped) {
 		spin_lock_irqsave(&info->irq_spinlock,flags);
 		if (!info->tx_active)
 		 	usc_start_transmitter(info);
 		spin_unlock_irqrestore(&info->irq_spinlock,flags);
  	}
-cleanup:	
+cleanup:
 	if ( debug_level >= DEBUG_LEVEL_INFO )
 		printk( "%s(%d):mgsl_write(%s) returning=%d\n",
 			__FILE__,__LINE__,info->device_name,ret);
-			
+
 	return ret;
-	
+
 }	/* end of mgsl_write() */
 
 /* mgsl_write_room()
  *
  *	Return the count of free bytes in transmit buffer
- * 	
+ *
  * Arguments:		tty	pointer to tty info structure
  * Return Value:	None
  */
@@ -2215,17 +2215,17 @@ static int mgsl_write_room(struct tty_struct *tty)
 {
 	struct mgsl_struct *info = tty->driver_data;
 	int	ret;
-				
+
 	if (mgsl_paranoia_check(info, tty->name, "mgsl_write_room"))
 		return 0;
 	ret = SERIAL_XMIT_SIZE - info->xmit_cnt - 1;
 	if (ret < 0)
 		ret = 0;
-		
+
 	if (debug_level >= DEBUG_LEVEL_INFO)
 		printk("%s(%d):mgsl_write_room(%s)=%d\n",
 			 __FILE__,__LINE__, info->device_name,ret );
-			 
+
 	if ( info->params.mode == MGSL_MODE_HDLC ||
 		info->params.mode == MGSL_MODE_RAW ) {
 		/* operating in synchronous (frame oriented) mode */
@@ -2234,33 +2234,33 @@ static int mgsl_write_room(struct tty_struct *tty)
 		else
 			return HDLC_MAX_FRAME_SIZE;
 	}
-	
+
 	return ret;
-	
+
 }	/* end of mgsl_write_room() */
 
 /* mgsl_chars_in_buffer()
  *
  *	Return the count of bytes in transmit buffer
- * 	
+ *
  * Arguments:		tty	pointer to tty info structure
  * Return Value:	None
  */
 static int mgsl_chars_in_buffer(struct tty_struct *tty)
 {
 	struct mgsl_struct *info = tty->driver_data;
-			 
+
 	if (debug_level >= DEBUG_LEVEL_INFO)
 		printk("%s(%d):mgsl_chars_in_buffer(%s)\n",
 			 __FILE__,__LINE__, info->device_name );
-			 
+
 	if (mgsl_paranoia_check(info, tty->name, "mgsl_chars_in_buffer"))
 		return 0;
-		
+
 	if (debug_level >= DEBUG_LEVEL_INFO)
 		printk("%s(%d):mgsl_chars_in_buffer(%s)=%d\n",
 			 __FILE__,__LINE__, info->device_name,info->xmit_cnt );
-			 
+
 	if ( info->params.mode == MGSL_MODE_HDLC ||
 		info->params.mode == MGSL_MODE_RAW ) {
 		/* operating in synchronous (frame oriented) mode */
@@ -2269,14 +2269,14 @@ static int mgsl_chars_in_buffer(struct tty_struct *tty)
 		else
 			return 0;
 	}
-			 
+
 	return info->xmit_cnt;
 }	/* end of mgsl_chars_in_buffer() */
 
 /* mgsl_flush_buffer()
  *
  *	Discard all data in the send buffer
- * 	
+ *
  * Arguments:		tty	pointer to tty info structure
  * Return Value:	None
  */
@@ -2284,26 +2284,26 @@ static void mgsl_flush_buffer(struct tty_struct *tty)
 {
 	struct mgsl_struct *info = tty->driver_data;
 	unsigned long flags;
-	
+
 	if (debug_level >= DEBUG_LEVEL_INFO)
 		printk("%s(%d):mgsl_flush_buffer(%s) entry\n",
 			 __FILE__,__LINE__, info->device_name );
-	
+
 	if (mgsl_paranoia_check(info, tty->name, "mgsl_flush_buffer"))
 		return;
-		
-	spin_lock_irqsave(&info->irq_spinlock,flags); 
+
+	spin_lock_irqsave(&info->irq_spinlock,flags);
 	info->xmit_cnt = info->xmit_head = info->xmit_tail = 0;
-	del_timer(&info->tx_timer);	
+	del_timer(&info->tx_timer);
 	spin_unlock_irqrestore(&info->irq_spinlock,flags);
-	
+
 	tty_wakeup(tty);
 }
 
 /* mgsl_send_xchar()
  *
  *	Send a high-priority XON/XOFF character
- * 	
+ *
  * Arguments:		tty	pointer to tty info structure
  *			ch	character to send
  * Return Value:	None
@@ -2316,7 +2316,7 @@ static void mgsl_send_xchar(struct tty_struct *tty, char ch)
 	if (debug_level >= DEBUG_LEVEL_INFO)
 		printk("%s(%d):mgsl_send_xchar(%s,%d)\n",
 			 __FILE__,__LINE__, info->device_name, ch );
-			 
+
 	if (mgsl_paranoia_check(info, tty->name, "mgsl_send_xchar"))
 		return;
 
@@ -2331,9 +2331,9 @@ static void mgsl_send_xchar(struct tty_struct *tty, char ch)
 }	/* end of mgsl_send_xchar() */
 
 /* mgsl_throttle()
- * 
+ *
  * 	Signal remote device to throttle send data (our receive data)
- * 	
+ *
  * Arguments:		tty	pointer to tty info structure
  * Return Value:	None
  */
@@ -2341,14 +2341,14 @@ static void mgsl_throttle(struct tty_struct * tty)
 {
 	struct mgsl_struct *info = tty->driver_data;
 	unsigned long flags;
-	
+
 	if (debug_level >= DEBUG_LEVEL_INFO)
 		printk("%s(%d):mgsl_throttle(%s) entry\n",
 			 __FILE__,__LINE__, info->device_name );
 
 	if (mgsl_paranoia_check(info, tty->name, "mgsl_throttle"))
 		return;
-	
+
 	if (I_IXOFF(tty))
 		mgsl_send_xchar(tty, STOP_CHAR(tty));
 
@@ -2361,9 +2361,9 @@ static void mgsl_throttle(struct tty_struct * tty)
 }	/* end of mgsl_throttle() */
 
 /* mgsl_unthrottle()
- * 
+ *
  * 	Signal remote device to stop throttling send data (our receive data)
- * 	
+ *
  * Arguments:		tty	pointer to tty info structure
  * Return Value:	None
  */
@@ -2371,14 +2371,14 @@ static void mgsl_unthrottle(struct tty_struct * tty)
 {
 	struct mgsl_struct *info = tty->driver_data;
 	unsigned long flags;
-	
+
 	if (debug_level >= DEBUG_LEVEL_INFO)
 		printk("%s(%d):mgsl_unthrottle(%s) entry\n",
 			 __FILE__,__LINE__, info->device_name );
 
 	if (mgsl_paranoia_check(info, tty->name, "mgsl_unthrottle"))
 		return;
-	
+
 	if (I_IXOFF(tty)) {
 		if (info->x_char)
 			info->x_char = 0;
@@ -2392,26 +2392,26 @@ static void mgsl_unthrottle(struct tty_struct * tty)
 	 	usc_set_serial_signals(info);
 		spin_unlock_irqrestore(&info->irq_spinlock,flags);
 	}
-	
+
 }	/* end of mgsl_unthrottle() */
 
 /* mgsl_get_stats()
- * 
+ *
  * 	get the current serial parameters information
  *
  * Arguments:	info		pointer to device instance data
  * 		user_icount	pointer to buffer to hold returned stats
- * 	
+ *
  * Return Value:	0 if success, otherwise error code
  */
 static int mgsl_get_stats(struct mgsl_struct * info, struct mgsl_icount __user *user_icount)
 {
 	int err;
-	
+
 	if (debug_level >= DEBUG_LEVEL_INFO)
 		printk("%s(%d):mgsl_get_params(%s)\n",
 			 __FILE__,__LINE__, info->device_name);
-			
+
 	if (!user_icount) {
 		memset(&info->icount, 0, sizeof(info->icount));
 	} else {
@@ -2421,18 +2421,18 @@ static int mgsl_get_stats(struct mgsl_struct * info, struct mgsl_icount __user *
 		if (err)
 			return -EFAULT;
 	}
-	
+
 	return 0;
-	
+
 }	/* end of mgsl_get_stats() */
 
 /* mgsl_get_params()
- * 
+ *
  * 	get the current serial parameters information
  *
  * Arguments:	info		pointer to device instance data
  * 		user_params	pointer to buffer to hold returned params
- * 	
+ *
  * Return Value:	0 if success, otherwise error code
  */
 static int mgsl_get_params(struct mgsl_struct * info, MGSL_PARAMS __user *user_params)
@@ -2441,7 +2441,7 @@ static int mgsl_get_params(struct mgsl_struct * info, MGSL_PARAMS __user *user_p
 	if (debug_level >= DEBUG_LEVEL_INFO)
 		printk("%s(%d):mgsl_get_params(%s)\n",
 			 __FILE__,__LINE__, info->device_name);
-			
+
 	mutex_lock(&info->port.mutex);
 	COPY_TO_USER(err,user_params, &info->params, sizeof(MGSL_PARAMS));
 	mutex_unlock(&info->port.mutex);
@@ -2451,17 +2451,17 @@ static int mgsl_get_params(struct mgsl_struct * info, MGSL_PARAMS __user *user_p
 				__FILE__,__LINE__,info->device_name);
 		return -EFAULT;
 	}
-	
+
 	return 0;
-	
+
 }	/* end of mgsl_get_params() */
 
 /* mgsl_set_params()
- * 
+ *
  * 	set the serial parameters
- * 	
+ *
  * Arguments:
- * 
+ *
  * 	info		pointer to device instance data
  * 	new_params	user buffer containing new serial params
  *
@@ -2472,7 +2472,7 @@ static int mgsl_set_params(struct mgsl_struct * info, MGSL_PARAMS __user *new_pa
  	unsigned long flags;
 	MGSL_PARAMS tmp_params;
 	int err;
- 
+
 	if (debug_level >= DEBUG_LEVEL_INFO)
 		printk("%s(%d):mgsl_set_params %s\n", __FILE__,__LINE__,
 			info->device_name );
@@ -2483,36 +2483,36 @@ static int mgsl_set_params(struct mgsl_struct * info, MGSL_PARAMS __user *new_pa
 				__FILE__,__LINE__,info->device_name);
 		return -EFAULT;
 	}
-	
+
 	mutex_lock(&info->port.mutex);
 	spin_lock_irqsave(&info->irq_spinlock,flags);
 	memcpy(&info->params,&tmp_params,sizeof(MGSL_PARAMS));
 	spin_unlock_irqrestore(&info->irq_spinlock,flags);
-	
+
  	mgsl_change_params(info);
 	mutex_unlock(&info->port.mutex);
-	
+
 	return 0;
-	
+
 }	/* end of mgsl_set_params() */
 
 /* mgsl_get_txidle()
- * 
+ *
  * 	get the current transmit idle mode
  *
  * Arguments:	info		pointer to device instance data
  * 		idle_mode	pointer to buffer to hold returned idle mode
- * 	
+ *
  * Return Value:	0 if success, otherwise error code
  */
 static int mgsl_get_txidle(struct mgsl_struct * info, int __user *idle_mode)
 {
 	int err;
-	
+
 	if (debug_level >= DEBUG_LEVEL_INFO)
 		printk("%s(%d):mgsl_get_txidle(%s)=%d\n",
 			 __FILE__,__LINE__, info->device_name, info->idle_mode);
-			
+
 	COPY_TO_USER(err,idle_mode, &info->idle_mode, sizeof(int));
 	if (err) {
 		if ( debug_level >= DEBUG_LEVEL_INFO )
@@ -2520,13 +2520,13 @@ static int mgsl_get_txidle(struct mgsl_struct * info, int __user *idle_mode)
 				__FILE__,__LINE__,info->device_name);
 		return -EFAULT;
 	}
-	
+
 	return 0;
-	
+
 }	/* end of mgsl_get_txidle() */
 
 /* mgsl_set_txidle()	service ioctl to set transmit idle mode
- * 	
+ *
  * Arguments:	 	info		pointer to device instance data
  * 			idle_mode	new idle mode
  *
@@ -2535,25 +2535,25 @@ static int mgsl_get_txidle(struct mgsl_struct * info, int __user *idle_mode)
 static int mgsl_set_txidle(struct mgsl_struct * info, int idle_mode)
 {
  	unsigned long flags;
- 
+
 	if (debug_level >= DEBUG_LEVEL_INFO)
 		printk("%s(%d):mgsl_set_txidle(%s,%d)\n", __FILE__,__LINE__,
 			info->device_name, idle_mode );
-			
+
 	spin_lock_irqsave(&info->irq_spinlock,flags);
 	info->idle_mode = idle_mode;
 	usc_set_txidle( info );
 	spin_unlock_irqrestore(&info->irq_spinlock,flags);
 	return 0;
-	
+
 }	/* end of mgsl_set_txidle() */
 
 /* mgsl_txenable()
- * 
+ *
  * 	enable or disable the transmitter
- * 	
+ *
  * Arguments:
- * 
+ *
  * 	info		pointer to device instance data
  * 	enable		1 = enable, 0 = disable
  *
@@ -2562,11 +2562,11 @@ static int mgsl_set_txidle(struct mgsl_struct * info, int idle_mode)
 static int mgsl_txenable(struct mgsl_struct * info, int enable)
 {
  	unsigned long flags;
- 
+
 	if (debug_level >= DEBUG_LEVEL_INFO)
 		printk("%s(%d):mgsl_txenable(%s,%d)\n", __FILE__,__LINE__,
 			info->device_name, enable);
-			
+
 	spin_lock_irqsave(&info->irq_spinlock,flags);
 	if ( enable ) {
 		if ( !info->tx_enabled ) {
@@ -2588,22 +2588,22 @@ static int mgsl_txenable(struct mgsl_struct * info, int enable)
 	}
 	spin_unlock_irqrestore(&info->irq_spinlock,flags);
 	return 0;
-	
+
 }	/* end of mgsl_txenable() */
 
 /* mgsl_txabort()	abort send HDLC frame
- * 	
+ *
  * Arguments:	 	info		pointer to device instance data
  * Return Value:	0 if success, otherwise error code
  */
 static int mgsl_txabort(struct mgsl_struct * info)
 {
  	unsigned long flags;
- 
+
 	if (debug_level >= DEBUG_LEVEL_INFO)
 		printk("%s(%d):mgsl_txabort(%s)\n", __FILE__,__LINE__,
 			info->device_name);
-			
+
 	spin_lock_irqsave(&info->irq_spinlock,flags);
 	if ( info->tx_active && info->params.mode == MGSL_MODE_HDLC )
 	{
@@ -2614,11 +2614,11 @@ static int mgsl_txabort(struct mgsl_struct * info)
 	}
 	spin_unlock_irqrestore(&info->irq_spinlock,flags);
 	return 0;
-	
+
 }	/* end of mgsl_txabort() */
 
 /* mgsl_rxenable() 	enable or disable the receiver
- * 	
+ *
  * Arguments:	 	info		pointer to device instance data
  * 			enable		1 = enable, 0 = disable
  * Return Value:	0 if success, otherwise error code
@@ -2626,11 +2626,11 @@ static int mgsl_txabort(struct mgsl_struct * info)
 static int mgsl_rxenable(struct mgsl_struct * info, int enable)
 {
  	unsigned long flags;
- 
+
 	if (debug_level >= DEBUG_LEVEL_INFO)
 		printk("%s(%d):mgsl_rxenable(%s,%d)\n", __FILE__,__LINE__,
 			info->device_name, enable);
-			
+
 	spin_lock_irqsave(&info->irq_spinlock,flags);
 	if ( enable ) {
 		if ( !info->rx_enabled )
@@ -2641,11 +2641,11 @@ static int mgsl_rxenable(struct mgsl_struct * info, int enable)
 	}
 	spin_unlock_irqrestore(&info->irq_spinlock,flags);
 	return 0;
-	
+
 }	/* end of mgsl_rxenable() */
 
 /* mgsl_wait_event() 	wait for specified event to occur
- * 	
+ *
  * Arguments:	 	info	pointer to device instance data
  * 			mask	pointer to bitmask of events to wait for
  * Return Value:	0 	if successful and bit mask updated with
@@ -2667,7 +2667,7 @@ static int mgsl_wait_event(struct mgsl_struct * info, int __user * mask_ptr)
 	if (rc) {
 		return  -EFAULT;
 	}
-		 
+
 	if (debug_level >= DEBUG_LEVEL_INFO)
 		printk("%s(%d):mgsl_wait_event(%s,%d)\n", __FILE__,__LINE__,
 			info->device_name, mask);
@@ -2690,7 +2690,7 @@ static int mgsl_wait_event(struct mgsl_struct * info, int __user * mask_ptr)
 	/* save current irq counts */
 	cprev = info->icount;
 	oldsigs = info->input_signal_events;
-	
+
 	/* enable hunt and idle irqs if needed */
 	if (mask & (MgslEvent_ExitHuntMode + MgslEvent_IdleReceived)) {
 		u16 oldreg = usc_InReg(info,RICR);
@@ -2700,12 +2700,12 @@ static int mgsl_wait_event(struct mgsl_struct * info, int __user * mask_ptr)
 		if (oldreg != newreg)
 			usc_OutReg(info, RICR, newreg);
 	}
-	
+
 	set_current_state(TASK_INTERRUPTIBLE);
 	add_wait_queue(&info->event_wait_q, &wait);
-	
+
 	spin_unlock_irqrestore(&info->irq_spinlock,flags);
-	
+
 
 	for(;;) {
 		schedule();
@@ -2713,7 +2713,7 @@ static int mgsl_wait_event(struct mgsl_struct * info, int __user * mask_ptr)
 			rc = -ERESTARTSYS;
 			break;
 		}
-			
+
 		/* get current irq counts */
 		spin_lock_irqsave(&info->irq_spinlock,flags);
 		cnow = info->icount;
@@ -2749,11 +2749,11 @@ static int mgsl_wait_event(struct mgsl_struct * info, int __user * mask_ptr)
 			  (cnow.rxidle      != cprev.rxidle     ? MgslEvent_IdleReceived:0) );
 		if (events)
 			break;
-		
+
 		cprev = cnow;
 		oldsigs = newsigs;
 	}
-	
+
 	remove_wait_queue(&info->event_wait_q, &wait);
 	set_current_state(TASK_RUNNING);
 
@@ -2769,9 +2769,9 @@ static int mgsl_wait_event(struct mgsl_struct * info, int __user * mask_ptr)
 exit:
 	if ( rc == 0 )
 		PUT_USER(rc, events, mask_ptr);
-		
+
 	return rc;
-	
+
 }	/* end of mgsl_wait_event() */
 
 static int modem_input_wait(struct mgsl_struct *info,int arg)
@@ -2887,22 +2887,22 @@ static int mgsl_break(struct tty_struct *tty, int break_state)
 {
 	struct mgsl_struct * info = tty->driver_data;
 	unsigned long flags;
-	
+
 	if (debug_level >= DEBUG_LEVEL_INFO)
 		printk("%s(%d):mgsl_break(%s,%d)\n",
 			 __FILE__,__LINE__, info->device_name, break_state);
-			 
+
 	if (mgsl_paranoia_check(info, tty->name, "mgsl_break"))
 		return -EINVAL;
 
 	spin_lock_irqsave(&info->irq_spinlock,flags);
  	if (break_state == -1)
 		usc_OutReg(info,IOCR,(u16)(usc_InReg(info,IOCR) | BIT7));
-	else 
+	else
 		usc_OutReg(info,IOCR,(u16)(usc_InReg(info,IOCR) & ~BIT7));
 	spin_unlock_irqrestore(&info->irq_spinlock,flags);
 	return 0;
-	
+
 }	/* end of mgsl_break() */
 
 /*
@@ -2938,24 +2938,24 @@ static int msgl_get_icount(struct tty_struct *tty,
 }
 
 /* mgsl_ioctl()	Service an IOCTL request
- * 	
+ *
  * Arguments:
- * 
+ *
  * 	tty	pointer to tty instance data
  * 	cmd	IOCTL command code
  * 	arg	command argument/context
- * 	
+ *
  * Return Value:	0 if success, otherwise error code
  */
 static int mgsl_ioctl(struct tty_struct *tty,
 		    unsigned int cmd, unsigned long arg)
 {
 	struct mgsl_struct * info = tty->driver_data;
-	
+
 	if (debug_level >= DEBUG_LEVEL_INFO)
 		printk("%s(%d):mgsl_ioctl %s cmd=%08X\n", __FILE__,__LINE__,
 			info->device_name, cmd );
-	
+
 	if (mgsl_paranoia_check(info, tty->name, "mgsl_ioctl"))
 		return -ENODEV;
 
@@ -2971,7 +2971,7 @@ static int mgsl_ioctl(struct tty_struct *tty,
 static int mgsl_ioctl_common(struct mgsl_struct *info, unsigned int cmd, unsigned long arg)
 {
 	void __user *argp = (void __user *)arg;
-	
+
 	switch (cmd) {
 		case MGSL_IOCGPARAMS:
 			return mgsl_get_params(info, argp);
@@ -3006,25 +3006,25 @@ static int mgsl_ioctl_common(struct mgsl_struct *info, unsigned int cmd, unsigne
 }
 
 /* mgsl_set_termios()
- * 
+ *
  * 	Set new termios settings
- * 	
+ *
  * Arguments:
- * 
+ *
  * 	tty		pointer to tty structure
  * 	termios		pointer to buffer to hold returned old termios
- * 	
+ *
  * Return Value:		None
  */
 static void mgsl_set_termios(struct tty_struct *tty, struct ktermios *old_termios)
 {
 	struct mgsl_struct *info = tty->driver_data;
 	unsigned long flags;
-	
+
 	if (debug_level >= DEBUG_LEVEL_INFO)
 		printk("%s(%d):mgsl_set_termios %s\n", __FILE__,__LINE__,
 			tty->driver->name );
-	
+
 	mgsl_change_params(info);
 
 	/* Handle transition to B0 status */
@@ -3054,15 +3054,15 @@ static void mgsl_set_termios(struct tty_struct *tty, struct ktermios *old_termio
 }	/* end of mgsl_set_termios() */
 
 /* mgsl_close()
- * 
+ *
  * 	Called when port is closed. Wait for remaining data to be
  * 	sent. Disable port and free resources.
- * 	
+ *
  * Arguments:
- * 
+ *
  * 	tty	pointer to open tty structure
  * 	filp	pointer to open file object
- * 	
+ *
  * Return Value:	None
  */
 static void mgsl_close(struct tty_struct *tty, struct file * filp)
@@ -3071,7 +3071,7 @@ static void mgsl_close(struct tty_struct *tty, struct file * filp)
 
 	if (mgsl_paranoia_check(info, tty->name, "mgsl_close"))
 		return;
-	
+
 	if (debug_level >= DEBUG_LEVEL_INFO)
 		printk("%s(%d):mgsl_close(%s) entry, count=%d\n",
 			 __FILE__,__LINE__, info->device_name, info->port.count);
@@ -3087,13 +3087,13 @@ static void mgsl_close(struct tty_struct *tty, struct file * filp)
 	shutdown(info);
 	mutex_unlock(&info->port.mutex);
 
-	tty_port_close_end(&info->port, tty);	
+	tty_port_close_end(&info->port, tty);
 	info->port.tty = NULL;
-cleanup:			
+cleanup:
 	if (debug_level >= DEBUG_LEVEL_INFO)
 		printk("%s(%d):mgsl_close(%s) exit, count=%d\n", __FILE__,__LINE__,
 			tty->driver->name, info->port.count);
-			
+
 }	/* end of mgsl_close() */
 
 /* mgsl_wait_until_sent()
@@ -3131,7 +3131,7 @@ static void mgsl_wait_until_sent(struct tty_struct *tty, int timeout)
 	 * send a character, and make it at least 1. The check
 	 * interval should also be less than the timeout.
 	 * Note: use tight timings here to satisfy the NIST-PCTS.
-	 */ 
+	 */
 
 	if ( info->params.data_rate ) {
 	       	char_time = info->timeout/(32 * 5);
@@ -3139,10 +3139,10 @@ static void mgsl_wait_until_sent(struct tty_struct *tty, int timeout)
 			char_time++;
 	} else
 		char_time = 1;
-		
+
 	if (timeout)
 		char_time = min_t(unsigned long, char_time, timeout);
-		
+
 	if ( info->params.mode == MGSL_MODE_HDLC ||
 		info->params.mode == MGSL_MODE_RAW ) {
 		while (info->tx_active) {
@@ -3162,12 +3162,12 @@ static void mgsl_wait_until_sent(struct tty_struct *tty, int timeout)
 				break;
 		}
 	}
-      
+
 exit:
 	if (debug_level >= DEBUG_LEVEL_INFO)
 		printk("%s(%d):mgsl_wait_until_sent(%s) exit\n",
 			 __FILE__,__LINE__, info->device_name );
-			 
+
 }	/* end of mgsl_wait_until_sent() */
 
 /* mgsl_hangup()
@@ -3181,23 +3181,23 @@ static void mgsl_wait_until_sent(struct tty_struct *tty, int timeout)
 static void mgsl_hangup(struct tty_struct *tty)
 {
 	struct mgsl_struct * info = tty->driver_data;
-	
+
 	if (debug_level >= DEBUG_LEVEL_INFO)
 		printk("%s(%d):mgsl_hangup(%s)\n",
 			 __FILE__,__LINE__, info->device_name );
-			 
+
 	if (mgsl_paranoia_check(info, tty->name, "mgsl_hangup"))
 		return;
 
 	mgsl_flush_buffer(tty);
 	shutdown(info);
-	
-	info->port.count = 0;	
+
+	info->port.count = 0;
 	tty_port_set_active(&info->port, 0);
 	info->port.tty = NULL;
 
 	wake_up_interruptible(&info->port.open_wait);
-	
+
 }	/* end of mgsl_hangup() */
 
 /*
@@ -3210,7 +3210,7 @@ static int carrier_raised(struct tty_port *port)
 {
 	unsigned long flags;
 	struct mgsl_struct *info = container_of(port, struct mgsl_struct, port);
-	
+
 	spin_lock_irqsave(&info->irq_spinlock, flags);
  	usc_get_serial_signals(info);
 	spin_unlock_irqrestore(&info->irq_spinlock, flags);
@@ -3233,16 +3233,16 @@ static void dtr_rts(struct tty_port *port, int on)
 
 
 /* block_til_ready()
- * 
+ *
  * 	Block the current process until the specified port
  * 	is ready to be opened.
- * 	
+ *
  * Arguments:
- * 
+ *
  * 	tty		pointer to tty info structure
  * 	filp		pointer to open file object
  * 	info		pointer to device instance data
- * 	
+ *
  * Return Value:	0 if success, otherwise error code
  */
 static int block_til_ready(struct tty_struct *tty, struct file * filp,
@@ -3254,7 +3254,7 @@ static int block_til_ready(struct tty_struct *tty, struct file * filp,
 	unsigned long	flags;
 	int		dcd;
 	struct tty_port *port = &info->port;
-	
+
 	if (debug_level >= DEBUG_LEVEL_INFO)
 		printk("%s(%d):block_til_ready on %s\n",
 			 __FILE__,__LINE__, tty->driver->name );
@@ -3274,10 +3274,10 @@ static int block_til_ready(struct tty_struct *tty, struct file * filp,
 	 * mgsl_close() knows when to free things.  We restore it upon
 	 * exit, either normal or abnormal.
 	 */
-	 
+
 	retval = 0;
 	add_wait_queue(&port->open_wait, &wait);
-	
+
 	if (debug_level >= DEBUG_LEVEL_INFO)
 		printk("%s(%d):block_til_ready before block on %s count=%d\n",
 			 __FILE__,__LINE__, tty->driver->name, port->count );
@@ -3307,33 +3307,33 @@ static int block_til_ready(struct tty_struct *tty, struct file * filp,
 			retval = -ERESTARTSYS;
 			break;
 		}
-		
+
 		if (debug_level >= DEBUG_LEVEL_INFO)
 			printk("%s(%d):block_til_ready blocking on %s count=%d\n",
 				 __FILE__,__LINE__, tty->driver->name, port->count );
-				 
+
 		tty_unlock(tty);
 		schedule();
 		tty_lock(tty);
 	}
-	
+
 	set_current_state(TASK_RUNNING);
 	remove_wait_queue(&port->open_wait, &wait);
-	
+
 	/* FIXME: Racy on hangup during close wait */
 	if (!tty_hung_up_p(filp))
 		port->count++;
 	port->blocked_open--;
-	
+
 	if (debug_level >= DEBUG_LEVEL_INFO)
 		printk("%s(%d):block_til_ready after blocking on %s count=%d\n",
 			 __FILE__,__LINE__, tty->driver->name, port->count );
-			 
+
 	if (!retval)
 		tty_port_set_active(port, 1);
-		
+
 	return retval;
-	
+
 }	/* end of block_til_ready() */
 
 static int mgsl_install(struct tty_driver *driver, struct tty_struct *tty)
@@ -3376,7 +3376,7 @@ static int mgsl_open(struct tty_struct *tty, struct file * filp)
 	int retval;
 
 	info->port.tty = tty;
-		
+
 	if (debug_level >= DEBUG_LEVEL_INFO)
 		printk("%s(%d):mgsl_open(%s), old ref count = %d\n",
 			 __FILE__,__LINE__,tty->driver->name, info->port.count);
@@ -3411,17 +3411,17 @@ static int mgsl_open(struct tty_struct *tty, struct file * filp)
 		printk("%s(%d):mgsl_open(%s) success\n",
 			 __FILE__,__LINE__, info->device_name);
 	retval = 0;
-	
-cleanup:			
+
+cleanup:
 	if (retval) {
 		if (tty->count == 1)
 			info->port.tty = NULL; /* tty layer will release tty struct */
 		if(info->port.count)
 			info->port.count--;
 	}
-	
+
 	return retval;
-	
+
 }	/* end of mgsl_open() */
 
 /*
@@ -3439,7 +3439,7 @@ static inline void line_info(struct seq_file *m, struct mgsl_struct *info)
 			info->phys_memory_base, info->phys_lcr_base);
 	} else {
 		seq_printf(m, "%s:(E)ISA io:%04X irq:%d dma:%d",
-			info->device_name, info->io_base, 
+			info->device_name, info->io_base,
 			info->irq_level, info->dma_level);
 	}
 
@@ -3447,7 +3447,7 @@ static inline void line_info(struct seq_file *m, struct mgsl_struct *info)
 	spin_lock_irqsave(&info->irq_spinlock,flags);
  	usc_get_serial_signals(info);
 	spin_unlock_irqrestore(&info->irq_spinlock,flags);
-	
+
 	stat_buf[0] = 0;
 	stat_buf[1] = 0;
 	if (info->serial_signals & SerialSignal_RTS)
@@ -3491,16 +3491,16 @@ static inline void line_info(struct seq_file *m, struct mgsl_struct *info)
 		if (info->icount.overrun)
 			seq_printf(m, " oe:%d", info->icount.overrun);
 	}
-	
+
 	/* Append serial signal status to end */
 	seq_printf(m, " %s\n", stat_buf+1);
-	
+
 	seq_printf(m, "txactive=%d bh_req=%d bh_run=%d pending_bh=%x\n",
 	 info->tx_active,info->bh_requested,info->bh_running,
 	 info->pending_bh);
-	 
+
 	spin_lock_irqsave(&info->irq_spinlock,flags);
-	{	
+	{
 	u16 Tcsr = usc_InReg( info, TCSR );
 	u16 Tdmr = usc_InDmaReg( info, TDMR );
 	u16 Ticr = usc_InReg( info, TICR );
@@ -3523,9 +3523,9 @@ static inline void line_info(struct seq_file *m, struct mgsl_struct *info)
 static int mgsl_proc_show(struct seq_file *m, void *v)
 {
 	struct mgsl_struct *info;
-	
+
 	seq_printf(m, "synclink driver:%s\n", driver_version);
-	
+
 	info = mgsl_device_list;
 	while( info ) {
 		line_info(m, info);
@@ -3535,10 +3535,10 @@ static int mgsl_proc_show(struct seq_file *m, void *v)
 }
 
 /* mgsl_allocate_dma_buffers()
- * 
+ *
  * 	Allocate and format DMA buffers (ISA adapter)
  * 	or format shared memory buffers (PCI adapter).
- * 
+ *
  * Arguments:		info	pointer to device instance data
  * Return Value:	0 if success, otherwise error
  */
@@ -3595,12 +3595,12 @@ static int mgsl_allocate_dma_buffers(struct mgsl_struct *info)
 
 		info->tx_buffer_count = info->num_tx_dma_buffers * BuffersPerFrame;
 		info->rx_buffer_count = (BuffersPerFrame * MAXRXFRAMES) + 6;
-		
-		/* 
-		 * limit total TxBuffers & RxBuffers to 62 4K total 
-		 * (ala PCI Allocation) 
+
+		/*
+		 * limit total TxBuffers & RxBuffers to 62 4K total
+		 * (ala PCI Allocation)
 		 */
-		
+
 		if ( (info->tx_buffer_count + info->rx_buffer_count) > 62 )
 			info->rx_buffer_count = 62 - info->tx_buffer_count;
 
@@ -3609,16 +3609,16 @@ static int mgsl_allocate_dma_buffers(struct mgsl_struct *info)
 	if ( debug_level >= DEBUG_LEVEL_INFO )
 		printk("%s(%d):Allocating %d TX and %d RX DMA buffers.\n",
 			__FILE__,__LINE__, info->tx_buffer_count,info->rx_buffer_count);
-	
+
 	if ( mgsl_alloc_buffer_list_memory( info ) < 0 ||
-		  mgsl_alloc_frame_memory(info, info->rx_buffer_list, info->rx_buffer_count) < 0 || 
-		  mgsl_alloc_frame_memory(info, info->tx_buffer_list, info->tx_buffer_count) < 0 || 
+		  mgsl_alloc_frame_memory(info, info->rx_buffer_list, info->rx_buffer_count) < 0 ||
+		  mgsl_alloc_frame_memory(info, info->tx_buffer_list, info->tx_buffer_count) < 0 ||
 		  mgsl_alloc_intermediate_rxbuffer_memory(info) < 0  ||
 		  mgsl_alloc_intermediate_txbuffer_memory(info) < 0 ) {
 		printk("%s(%d):Can't allocate DMA buffer memory\n",__FILE__,__LINE__);
 		return -ENOMEM;
 	}
-	
+
 	mgsl_reset_rx_dma_buffers( info );
   	mgsl_reset_tx_dma_buffers( info );
 
@@ -3628,24 +3628,24 @@ static int mgsl_allocate_dma_buffers(struct mgsl_struct *info)
 
 /*
  * mgsl_alloc_buffer_list_memory()
- * 
+ *
  * Allocate a common DMA buffer for use as the
  * receive and transmit buffer lists.
- * 
+ *
  * A buffer list is a set of buffer entries where each entry contains
  * a pointer to an actual buffer and a pointer to the next buffer entry
  * (plus some other info about the buffer).
- * 
+ *
  * The buffer entries for a list are built to form a circular list so
  * that when the entire list has been traversed you start back at the
  * beginning.
- * 
+ *
  * This function allocates memory for just the buffer entries.
  * The links (pointer to next entry) are filled in with the physical
  * address of the next entry so the adapter can navigate the list
  * using bus master DMA. The pointers to the actual buffers are filled
  * out later when the actual buffers are allocated.
- * 
+ *
  * Arguments:		info	pointer to device instance data
  * Return Value:	0 if success, otherwise error
  */
@@ -3727,7 +3727,7 @@ static int mgsl_alloc_buffer_list_memory( struct mgsl_struct *info )
 /* Free DMA buffers allocated for use as the
  * receive and transmit buffer lists.
  * Warning:
- * 
+ *
  * 	The data transfer buffers associated with the buffer list
  * 	MUST be freed before freeing the buffer list itself because
  * 	the buffer list contains the information necessary to free
@@ -3737,7 +3737,7 @@ static void mgsl_free_buffer_list_memory( struct mgsl_struct *info )
 {
 	if (info->buffer_list && info->bus_type != MGSL_BUS_TYPE_PCI)
 		dma_free_coherent(NULL, BUFFERLISTSIZE, info->buffer_list, info->buffer_list_dma_addr);
-		
+
 	info->buffer_list = NULL;
 	info->rx_buffer_list = NULL;
 	info->tx_buffer_list = NULL;
@@ -3746,18 +3746,18 @@ static void mgsl_free_buffer_list_memory( struct mgsl_struct *info )
 
 /*
  * mgsl_alloc_frame_memory()
- * 
+ *
  * 	Allocate the frame DMA buffers used by the specified buffer list.
  * 	Each DMA buffer will be one memory page in size. This is necessary
  * 	because memory can fragment enough that it may be impossible
  * 	contiguous pages.
- * 
+ *
  * Arguments:
- * 
+ *
  *	info		pointer to device instance data
  * 	BufferList	pointer to list of buffer entries
  * 	Buffercount	count of buffer entries in buffer list
- * 
+ *
  * Return Value:	0 if success, otherwise -ENOMEM
  */
 static int mgsl_alloc_frame_memory(struct mgsl_struct *info,DMABUFFERENTRY *BufferList,int Buffercount)
@@ -3789,16 +3789,16 @@ static int mgsl_alloc_frame_memory(struct mgsl_struct *info,DMABUFFERENTRY *Buff
 
 /*
  * mgsl_free_frame_memory()
- * 
+ *
  * 	Free the buffers associated with
  * 	each buffer entry of a buffer list.
- * 
+ *
  * Arguments:
- * 
+ *
  *	info		pointer to device instance data
  * 	BufferList	pointer to list of buffer entries
  * 	Buffercount	count of buffer entries in buffer list
- * 
+ *
  * Return Value:	None
  */
 static void mgsl_free_frame_memory(struct mgsl_struct *info, DMABUFFERENTRY *BufferList, int Buffercount)
@@ -3818,9 +3818,9 @@ static void mgsl_free_frame_memory(struct mgsl_struct *info, DMABUFFERENTRY *Buf
 }	/* end of mgsl_free_frame_memory() */
 
 /* mgsl_free_dma_buffers()
- * 
+ *
  * 	Free DMA buffers
- * 	
+ *
  * Arguments:		info	pointer to device instance data
  * Return Value:	None
  */
@@ -3835,14 +3835,14 @@ static void mgsl_free_dma_buffers( struct mgsl_struct *info )
 
 /*
  * mgsl_alloc_intermediate_rxbuffer_memory()
- * 
+ *
  * 	Allocate a buffer large enough to hold max_frame_size. This buffer
  *	is used to pass an assembled frame to the line discipline.
- * 
+ *
  * Arguments:
- * 
+ *
  *	info		pointer to device instance data
- * 
+ *
  * Return Value:	0 if success, otherwise -ENOMEM
  */
 static int mgsl_alloc_intermediate_rxbuffer_memory(struct mgsl_struct *info)
@@ -3863,12 +3863,12 @@ static int mgsl_alloc_intermediate_rxbuffer_memory(struct mgsl_struct *info)
 
 /*
  * mgsl_free_intermediate_rxbuffer_memory()
- * 
- * 
+ *
+ *
  * Arguments:
- * 
+ *
  *	info		pointer to device instance data
- * 
+ *
  * Return Value:	None
  */
 static void mgsl_free_intermediate_rxbuffer_memory(struct mgsl_struct *info)
@@ -4032,7 +4032,7 @@ static int mgsl_claim_resources(struct mgsl_struct *info)
 		return -ENODEV;
 	}
 	info->io_addr_requested = true;
-	
+
 	if ( request_irq(info->irq_level,mgsl_interrupt,info->irq_flags,
 		info->device_name, info ) < 0 ) {
 		printk( "%s(%d):Can't request interrupt on device %s IRQ=%d\n",
@@ -4040,7 +4040,7 @@ static int mgsl_claim_resources(struct mgsl_struct *info)
 		goto errout;
 	}
 	info->irq_requested = true;
-	
+
 	if ( info->bus_type == MGSL_BUS_TYPE_PCI ) {
 		if (request_mem_region(info->phys_memory_base,0x40000,"synclink") == NULL) {
 			printk( "%s(%d):mem addr conflict device %s Addr=%08X\n",
@@ -4062,13 +4062,13 @@ static int mgsl_claim_resources(struct mgsl_struct *info)
 				__FILE__,__LINE__,info->device_name, info->phys_memory_base );
 			goto errout;
 		}
-		
+
 		if ( !mgsl_memory_test(info) ) {
 			printk( "%s(%d):Failed shared memory test %s MemAddr=%08X\n",
 				__FILE__,__LINE__,info->device_name, info->phys_memory_base );
 			goto errout;
 		}
-		
+
 		info->lcr_base = ioremap_nocache(info->phys_lcr_base,
 								PAGE_SIZE);
 		if (!info->lcr_base) {
@@ -4077,10 +4077,10 @@ static int mgsl_claim_resources(struct mgsl_struct *info)
 			goto errout;
 		}
 		info->lcr_base += info->lcr_offset;
-		
+
 	} else {
 		/* claim DMA channel */
-		
+
 		if (request_dma(info->dma_level,info->device_name) < 0){
 			printk( "%s(%d):Can't request DMA channel on device %s DMA=%d\n",
 				__FILE__,__LINE__,info->device_name, info->dma_level );
@@ -4088,17 +4088,17 @@ static int mgsl_claim_resources(struct mgsl_struct *info)
 		}
 		info->dma_requested = true;
 
-		/* ISA adapter uses bus master DMA */		
+		/* ISA adapter uses bus master DMA */
 		set_dma_mode(info->dma_level,DMA_MODE_CASCADE);
 		enable_dma(info->dma_level);
 	}
-	
+
 	if ( mgsl_allocate_dma_buffers(info) < 0 ) {
 		printk( "%s(%d):Can't allocate DMA buffers on device %s DMA=%d\n",
 			__FILE__,__LINE__,info->device_name, info->dma_level );
 		goto errout;
-	}	
-	
+	}
+
 	return 0;
 errout:
 	mgsl_release_resources(info);
@@ -4111,7 +4111,7 @@ static void mgsl_release_resources(struct mgsl_struct *info)
 	if ( debug_level >= DEBUG_LEVEL_INFO )
 		printk( "%s(%d):mgsl_release_resources(%s) entry\n",
 			__FILE__,__LINE__,info->device_name );
-			
+
 	if ( info->irq_requested ) {
 		free_irq(info->irq_level, info);
 		info->irq_requested = false;
@@ -4124,7 +4124,7 @@ static void mgsl_release_resources(struct mgsl_struct *info)
 	mgsl_free_dma_buffers(info);
 	mgsl_free_intermediate_rxbuffer_memory(info);
      	mgsl_free_intermediate_txbuffer_memory(info);
-	
+
 	if ( info->io_addr_requested ) {
 		release_region(info->io_base,info->io_addr_size);
 		info->io_addr_requested = false;
@@ -4145,18 +4145,18 @@ static void mgsl_release_resources(struct mgsl_struct *info)
 		iounmap(info->lcr_base - info->lcr_offset);
 		info->lcr_base = NULL;
 	}
-	
+
 	if ( debug_level >= DEBUG_LEVEL_INFO )
 		printk( "%s(%d):mgsl_release_resources(%s) exit\n",
 			__FILE__,__LINE__,info->device_name );
-			
+
 }	/* end of mgsl_release_resources() */
 
 /* mgsl_add_device()
- * 
+ *
  * 	Add the specified device instance data structure to the
  * 	global linked list of devices and increment the device count.
- * 	
+ *
  * Arguments:		info	pointer to device instance data
  * Return Value:	None
  */
@@ -4165,7 +4165,7 @@ static void mgsl_add_device( struct mgsl_struct *info )
 	info->next_device = NULL;
 	info->line = mgsl_device_count;
 	sprintf(info->device_name,"ttySL%d",info->line);
-	
+
 	if (info->line < MAX_TOTAL_DEVICES) {
 		if (maxframe[info->line])
 			info->max_frame_size = maxframe[info->line];
@@ -4186,21 +4186,21 @@ static void mgsl_add_device( struct mgsl_struct *info )
 	}
 
 	mgsl_device_count++;
-	
+
 	if ( !mgsl_device_list )
 		mgsl_device_list = info;
-	else {	
+	else {
 		struct mgsl_struct *current_dev = mgsl_device_list;
 		while( current_dev->next_device )
 			current_dev = current_dev->next_device;
 		current_dev->next_device = info;
 	}
-	
+
 	if ( info->max_frame_size < 4096 )
 		info->max_frame_size = 4096;
 	else if ( info->max_frame_size > 65535 )
 		info->max_frame_size = 65535;
-	
+
 	if ( info->bus_type == MGSL_BUS_TYPE_PCI ) {
 		printk( "SyncLink PCI v%d %s: IO=%04X IRQ=%d Mem=%08X,%08X MaxFrameSize=%u\n",
 			info->hw_version + 1, info->device_name, info->io_base, info->irq_level,
@@ -4225,19 +4225,19 @@ static const struct tty_port_operations mgsl_port_ops = {
 
 
 /* mgsl_allocate_device()
- * 
+ *
  * 	Allocate and initialize a device instance structure
- * 	
+ *
  * Arguments:		none
  * Return Value:	pointer to mgsl_struct if success, otherwise NULL
  */
 static struct mgsl_struct* mgsl_allocate_device(void)
 {
 	struct mgsl_struct *info;
-	
+
 	info = kzalloc(sizeof(struct mgsl_struct),
 		 GFP_KERNEL);
-		 
+
 	if (!info) {
 		printk("Error can't allocate device instance data\n");
 	} else {
@@ -4257,7 +4257,7 @@ static struct mgsl_struct* mgsl_allocate_device(void)
 		info->num_tx_dma_buffers = 1;
 		info->num_tx_holding_buffers = 0;
 	}
-	
+
 	return info;
 
 }	/* end of mgsl_allocate_device()*/
@@ -4298,7 +4298,7 @@ static int mgsl_init_tty(void)
 	serial_driver = alloc_tty_driver(128);
 	if (!serial_driver)
 		return -ENOMEM;
-	
+
 	serial_driver->driver_name = "synclink";
 	serial_driver->name = "ttySL";
 	serial_driver->major = ttymajor;
@@ -4319,7 +4319,7 @@ static int mgsl_init_tty(void)
 		serial_driver = NULL;
 		return rc;
 	}
-			
+
  	printk("%s %s, tty major#%d\n",
 		driver_name, driver_version,
 		serial_driver->major);
@@ -4332,14 +4332,14 @@ static void mgsl_enum_isa_devices(void)
 {
 	struct mgsl_struct *info;
 	int i;
-		
+
 	/* Check for user specified ISA devices */
-	
+
 	for (i=0 ;(i < MAX_ISA_DEVICES) && io[i] && irq[i]; i++){
 		if ( debug_level >= DEBUG_LEVEL_INFO )
 			printk("ISA device specified io=%04X,irq=%d,dma=%d\n",
 				io[i], irq[i], dma[i] );
-		
+
 		info = mgsl_allocate_device();
 		if ( !info ) {
 			/* error allocating device instance data */
@@ -4347,7 +4347,7 @@ static void mgsl_enum_isa_devices(void)
 				printk( "can't allocate device instance data.\n");
 			continue;
 		}
-		
+
 		/* Copy user configuration info to device instance data */
 		info->io_base = (unsigned int)io[i];
 		info->irq_level = (unsigned int)irq[i];
@@ -4356,7 +4356,7 @@ static void mgsl_enum_isa_devices(void)
 		info->bus_type = MGSL_BUS_TYPE_ISA;
 		info->io_addr_size = 16;
 		info->irq_flags = 0;
-		
+
 		mgsl_add_device( info );
 	}
 }
@@ -4388,7 +4388,7 @@ static void synclink_cleanup(void)
 		tty_port_destroy(&tmp->port);
 		kfree(tmp);
 	}
-	
+
 	if (pci_registered)
 		pci_unregister_driver(&synclink_pci_driver);
 }
@@ -4516,7 +4516,7 @@ static void usc_OutDmaReg( struct mgsl_struct *info, u16 RegAddr, u16 RegValue )
 		inw( info->io_base );
 
 }	/* end of usc_OutDmaReg() */
- 
+
 /*
  * usc_InDmaReg()
  *
@@ -4546,7 +4546,7 @@ static u16 usc_InDmaReg( struct mgsl_struct *info, u16 RegAddr )
  *
  * usc_OutReg()
  *
- *    Write a 16-bit value to a USC serial channel register 
+ *    Write a 16-bit value to a USC serial channel register
  *
  * Arguments:
  *
@@ -4602,7 +4602,7 @@ static void usc_set_sdlc_mode( struct mgsl_struct *info )
 {
 	u16 RegValue;
 	bool PreSL1660;
-	
+
 	/*
 	 * determine if the IUSC on the adapter is pre-SL1660. If
 	 * not, take advantage of the UnderWait feature of more
@@ -4631,14 +4631,14 @@ static void usc_set_sdlc_mode( struct mgsl_struct *info )
  	   ** 1000 1110 0000 0110 = 0x8e06
  	   */
  	   RegValue = 0x8e06;
- 
+
  	   /*--------------------------------------------------
  	    * ignore user options for UnderRun Actions and
  	    * preambles
  	    *--------------------------------------------------*/
  	}
  	else
- 	{	
+	{
 		/* Channel mode Register (CMR)
 		 *
 		 * <15..14>  00    Tx Sub modes, Underrun Action
@@ -4776,7 +4776,7 @@ static void usc_set_sdlc_mode( struct mgsl_struct *info )
 	usc_ClearIrqPendingBits( info, RECEIVE_STATUS );
 
 	/* Transmit mode Register (TMR)
-	 *	
+	 *
 	 * <15..13>	000	encoding
 	 * <12..11>	00	FCS = 16bit CRC CCITT (x15 + x12 + x5 + 1)
 	 * <10>		1	1 = Start CRC as all 1s (use for SDLC/HDLC)
@@ -4831,7 +4831,7 @@ static void usc_set_sdlc_mode( struct mgsl_struct *info )
 
 	if ( info->bus_type == MGSL_BUS_TYPE_PCI )
 		usc_OutReg( info, TICR, 0x0736 );
-	else								
+	else
 		usc_OutReg( info, TICR, 0x1436 );
 
 	usc_UnlatchTxstatusBits( info, TXSTATUS_ALL );
@@ -4851,14 +4851,14 @@ static void usc_set_sdlc_mode( struct mgsl_struct *info )
 	** <2>         	x	All Sent
 	** <1>         	x	TxUnder
 	** <0>         	x	TxEmpty
-	** 
+	**
 	** 0000 0000 0000 0000 = 0x0000
 	*/
 	info->tcsr_value = 0;
 
 	if ( !PreSL1660 )
 		info->tcsr_value |= TCSR_UNDERWAIT;
-		
+
 	usc_OutReg( info, TCSR, info->tcsr_value );
 
 	/* Clock mode Control Register (CMCR)
@@ -4946,7 +4946,7 @@ static void usc_set_sdlc_mode( struct mgsl_struct *info )
 
  		/*--------------------------------------------------
  		 * ejz: for DPLL mode, application should use the
- 		 * same clock speed as the partner system, even 
+		 * same clock speed as the partner system, even
  		 * though clocking is derived from the input RxData.
  		 * In case the user uses a 0 for the clock speed,
  		 * default to 0xffffffff and don't try to divide by
@@ -4961,7 +4961,7 @@ static void usc_set_sdlc_mode( struct mgsl_struct *info )
  		}
  		else
  			Tc = -1;
- 				  
+
 
 		/* Write 16-bit Time Constant for BRG1 */
 		usc_OutReg( info, TC1R, Tc );
@@ -5008,7 +5008,7 @@ static void usc_set_sdlc_mode( struct mgsl_struct *info )
 		usc_OutReg( info, SICR,
 			    (u16)(usc_InReg(info,SICR) | SICR_CTS_INACTIVE) );
 	}
-	
+
 
 	/* enable Master Interrupt Enable bit (MIE) */
 	usc_EnableMasterIrqBit( info );
@@ -5161,7 +5161,7 @@ static void usc_set_sdlc_mode( struct mgsl_struct *info )
 
 	usc_stop_transmitter(info);
 	usc_stop_receiver(info);
-	
+
 }	/* end of usc_set_sdlc_mode() */
 
 /* usc_enable_loopback()
@@ -5179,7 +5179,7 @@ static void usc_enable_loopback(struct mgsl_struct *info, int enable)
 	if (enable) {
 		/* blank external TXD output */
 		usc_OutReg(info,IOCR,usc_InReg(info,IOCR) | (BIT7 | BIT6));
-	
+
 		/* Clock mode Control Register (CMCR)
 		 *
 		 * <15..14>	00	counter 1 Disabled
@@ -5218,12 +5218,12 @@ static void usc_enable_loopback(struct mgsl_struct *info, int enable)
 	} else {
 		/* enable external TXD output */
 		usc_OutReg(info,IOCR,usc_InReg(info,IOCR) & ~(BIT7 | BIT6));
-	
+
 		/* clear Internal Data loopback mode */
 		info->loopback_bits = 0;
 		outw( 0,info->io_base + CCAR );
 	}
-	
+
 }	/* end of usc_enable_loopback() */
 
 /* usc_enable_aux_clock()
@@ -5313,7 +5313,7 @@ static void usc_process_rxoverrun_sync( struct mgsl_struct *info )
 
 	/* CurrentRxBuffer points to the 1st buffer of the next */
 	/* possibly available receive frame. */
-	
+
 	frame_start_index = start_index = end_index = info->current_rx_buffer;
 
 	/* Search for an unfinished string of buffers. This means */
@@ -5392,9 +5392,9 @@ static void usc_process_rxoverrun_sync( struct mgsl_struct *info )
 		usc_UnlatchRxstatusBits(info,RXSTATUS_ALL);
 		usc_ClearIrqPendingBits(info, RECEIVE_DATA|RECEIVE_STATUS);
 		usc_UnlatchRxstatusBits(info, RECEIVE_DATA|RECEIVE_STATUS);
-		
+
 		usc_EnableReceiver(info,DISABLE_UNCONDITIONAL);
-		
+
 		/* This empties the receive FIFO and loads the RCC with RCLR */
 		usc_OutReg( info, CCSR, (u16)(usc_InReg(info,CCSR) | BIT13) );
 
@@ -5439,7 +5439,7 @@ static void usc_stop_receiver( struct mgsl_struct *info )
 	if (debug_level >= DEBUG_LEVEL_ISR)
 		printk("%s(%d):usc_stop_receiver(%s)\n",
 			 __FILE__,__LINE__, info->device_name );
-			 
+
 	/* Disable receive DMA channel. */
 	/* This also disables receive DMA channel interrupts */
 	usc_DmaCmd( info, DmaCmd_ResetRxChannel );
@@ -5457,12 +5457,12 @@ static void usc_stop_receiver( struct mgsl_struct *info )
 	info->rx_enabled = false;
 	info->rx_overflow = false;
 	info->rx_rcc_underrun = false;
-	
+
 }	/* end of stop_receiver() */
 
 /* usc_start_receiver()
  *
- *	Enable the USC receiver 
+ *	Enable the USC receiver
  *
  * Arguments:		info	pointer to device instance data
  * Return Value:	None
@@ -5470,7 +5470,7 @@ static void usc_stop_receiver( struct mgsl_struct *info )
 static void usc_start_receiver( struct mgsl_struct *info )
 {
 	u32 phys_addr;
-	
+
 	if (debug_level >= DEBUG_LEVEL_ISR)
 		printk("%s(%d):usc_start_receiver(%s)\n",
 			 __FILE__,__LINE__, info->device_name );
@@ -5539,7 +5539,7 @@ static void usc_start_transmitter( struct mgsl_struct *info )
 	if (debug_level >= DEBUG_LEVEL_ISR)
 		printk("%s(%d):usc_start_transmitter(%s)\n",
 			 __FILE__,__LINE__, info->device_name );
-			 
+
 	if ( info->xmit_cnt ) {
 
 		/* If auto RTS enabled and RTS is inactive, then assert */
@@ -5568,7 +5568,7 @@ static void usc_start_transmitter( struct mgsl_struct *info )
 		} else {
 			/* Disable transmit DMA controller while programming. */
 			usc_DmaCmd( info, DmaCmd_ResetTxChannel );
-			
+
 			/* Transmit DMA buffer is loaded, so program USC */
 			/* to send the frame contained in the buffers.	 */
 
@@ -5611,9 +5611,9 @@ static void usc_start_transmitter( struct mgsl_struct *info )
 
 			/* Initialize Transmit DMA Channel */
 			usc_DmaCmd( info, DmaCmd_InitTxChannel );
-			
+
 			usc_TCmd( info, TCmd_SendFrame );
-			
+
 			mod_timer(&info->tx_timer, jiffies +
 					msecs_to_jiffies(5000));
 		}
@@ -5642,9 +5642,9 @@ static void usc_stop_transmitter( struct mgsl_struct *info )
 	if (debug_level >= DEBUG_LEVEL_ISR)
 		printk("%s(%d):usc_stop_transmitter(%s)\n",
 			 __FILE__,__LINE__, info->device_name );
-			 
-	del_timer(&info->tx_timer);	
-			 
+
+	del_timer(&info->tx_timer);
+
 	usc_UnlatchTxstatusBits( info, TXSTATUS_ALL );
 	usc_ClearIrqPendingBits( info, TRANSMIT_STATUS + TRANSMIT_DATA );
 	usc_DisableInterrupts( info, TRANSMIT_STATUS + TRANSMIT_DATA );
@@ -5670,10 +5670,10 @@ static void usc_load_txfifo( struct mgsl_struct *info )
 {
 	int Fifocount;
 	u8 TwoBytes[2];
-	
+
 	if ( !info->xmit_cnt && !info->x_char )
-		return; 
-		
+		return;
+
 	/* Select transmit FIFO status readback in TICR */
 	usc_TCmd( info, TCmd_SelectTicrTxFifostatus );
 
@@ -5685,22 +5685,22 @@ static void usc_load_txfifo( struct mgsl_struct *info )
 
 		if ( (info->xmit_cnt > 1) && (Fifocount > 1) && !info->x_char ) {
  			/* write a 16-bit word from transmit buffer to 16C32 */
-				
+
 			TwoBytes[0] = info->xmit_buf[info->xmit_tail++];
 			info->xmit_tail = info->xmit_tail & (SERIAL_XMIT_SIZE-1);
 			TwoBytes[1] = info->xmit_buf[info->xmit_tail++];
 			info->xmit_tail = info->xmit_tail & (SERIAL_XMIT_SIZE-1);
-			
+
 			outw( *((u16 *)TwoBytes), info->io_base + DATAREG);
-				
+
 			info->xmit_cnt -= 2;
 			info->icount.tx += 2;
 		} else {
 			/* only 1 byte left to transmit or 1 FIFO slot left */
-			
+
 			outw( (inw( info->io_base + CCAR) & 0x0780) | (TDR+LSBONLY),
 				info->io_base + CCAR );
-			
+
 			if (info->x_char) {
 				/* transmit pending high priority char */
 				outw( info->x_char,info->io_base + CCAR );
@@ -5739,8 +5739,8 @@ static void usc_reset( struct mgsl_struct *info )
 		*MiscCtrl = info->misc_ctrl_value;
 
 		/*
-		 * Force at least 170ns delay before clearing 
-		 * reset bit. Each read from LCR takes at least 
+		 * Force at least 170ns delay before clearing
+		 * reset bit. Each read from LCR takes at least
 		 * 30ns so 10 times for 300ns to be safe.
 		 */
 		for(i=0;i<10;i++)
@@ -5784,7 +5784,7 @@ static void usc_reset( struct mgsl_struct *info )
 	 * By writing to io_base + SDPIN the Wait/Ack pin is
 	 * programmed to work as a Wait pin.
 	 */
-	
+
 	outw( 0x000c,info->io_base + SDPIN );
 
 
@@ -5866,7 +5866,7 @@ static void usc_set_async_mode( struct mgsl_struct *info )
 		RegValue |= BIT14;
 	usc_OutReg( info, CMR, RegValue );
 
-	
+
 	/* Receiver mode Register (RMR)
 	 *
 	 * <15..13>	000	encoding = None
@@ -5897,7 +5897,7 @@ static void usc_set_async_mode( struct mgsl_struct *info )
 
 	usc_RCmd( info, RCmd_SelectRicrIntLevel );
 
-	
+
 	/* Receive Interrupt Control Register (RICR)
 	 *
 	 * <15..8>	?		RxFIFO IRQ Request Level
@@ -5917,13 +5917,13 @@ static void usc_set_async_mode( struct mgsl_struct *info )
 	 *
 	 * 0000 0000 0100 0000 = 0x0000 + (FIFOLEVEL in MSB)
 	 */
-	
+
 	usc_OutReg( info, RICR, 0x0000 );
 
 	usc_UnlatchRxstatusBits( info, RXSTATUS_ALL );
 	usc_ClearIrqPendingBits( info, RECEIVE_STATUS );
 
-	
+
 	/* Transmit mode Register (TMR)
 	 *
 	 * <15..13>	000	encoding = None
@@ -5956,7 +5956,7 @@ static void usc_set_async_mode( struct mgsl_struct *info )
 
 	usc_TCmd( info, TCmd_SelectTicrIntLevel );
 
-	
+
 	/* Transmit Interrupt Control Register (TICR)
 	 *
 	 * <15..8>	?	Transmit FIFO IRQ Level
@@ -5979,7 +5979,7 @@ static void usc_set_async_mode( struct mgsl_struct *info )
 
 	usc_enable_async_clock( info, info->params.data_rate );
 
-	
+
 	/* Channel Control/status Register (CCSR)
 	 *
 	 * <15>		X	RCC FIFO Overflow status (RO)
@@ -5997,7 +5997,7 @@ static void usc_set_async_mode( struct mgsl_struct *info )
 	 *
 	 *	0000 0000 0010 0000 = 0x0020
 	 */
-	
+
 	usc_OutReg( info, CCSR, 0x0020 );
 
 	usc_DisableInterrupts( info, TRANSMIT_STATUS + TRANSMIT_DATA +
@@ -6041,7 +6041,7 @@ static void usc_loopback_frame( struct mgsl_struct *info )
 	unsigned long oldmode = info->params.mode;
 
 	info->params.mode = MGSL_MODE_HDLC;
-	
+
 	usc_DisableMasterIrqBit( info );
 
 	usc_set_sdlc_mode( info );
@@ -6049,7 +6049,7 @@ static void usc_loopback_frame( struct mgsl_struct *info )
 
 	/* Write 16-bit Time Constant for BRG0 */
 	usc_OutReg( info, TC0R, 0 );
-	
+
 	/* Channel Control Register (CCR)
 	 *
 	 * <15..14>	00	Don't use 32-bit Tx Control Blocks (TCBs)
@@ -6083,7 +6083,7 @@ static void usc_loopback_frame( struct mgsl_struct *info )
 	/* ENABLE TRANSMITTER */
 	usc_TCmd( info, TCmd_SendFrame );
 	usc_EnableTransmitter(info,ENABLE_UNCONDITIONAL);
-							
+
 	/* WAIT FOR RECEIVE COMPLETE */
 	for (i=0 ; i<1000 ; i++)
 		if (usc_InReg( info, RCSR ) & (BIT8 | BIT4 | BIT3 | BIT1))
@@ -6221,7 +6221,7 @@ static void usc_get_serial_signals( struct mgsl_struct *info )
  *
  *	Set the state of RTS and DTR based on contents of
  *	serial_signals member of device extension.
- *	
+ *
  * Arguments:		info	pointer to device instance data
  * Return Value:	None
  */
@@ -6262,7 +6262,7 @@ static void usc_enable_async_clock( struct mgsl_struct *info, u32 data_rate )
 	if ( data_rate )	{
 		/*
 		 * Clock mode Control Register (CMCR)
-		 * 
+		 *
 		 * <15..14>     00      counter 1 Disabled
 		 * <13..12>     00      counter 0 Disabled
 		 * <11..10>     11      BRG1 Input is TxC Pin
@@ -6273,7 +6273,7 @@ static void usc_enable_async_clock( struct mgsl_struct *info, u32 data_rate )
 		 *
 		 * 0000 1111 0110 0100 = 0x0f64
 		 */
-		
+
 		usc_OutReg( info, CMCR, 0x0f64 );
 
 
@@ -6288,7 +6288,7 @@ static void usc_enable_async_clock( struct mgsl_struct *info, u32 data_rate )
 		else
 			usc_OutReg( info, TC0R, (u16)((921600/data_rate) - 1) );
 
-		
+
 		/*
 		 * Hardware Configuration Register (HCR)
 		 * Clear Bit 1, BRG0 mode = Continuous
@@ -6400,11 +6400,11 @@ static int num_free_tx_dma_buffers(struct mgsl_struct *info)
 
 /*
  * mgsl_reset_rx_dma_buffers()
- * 
+ *
  * 	Set the count for all receive buffers to DMABUFFERSIZE
  * 	and set the current buffer to the first buffer. This effectively
  * 	makes all buffers free and discards any data in buffers.
- * 
+ *
  * Arguments:		info	pointer to device instance data
  * Return Value:	None
  */
@@ -6424,16 +6424,16 @@ static void mgsl_reset_rx_dma_buffers( struct mgsl_struct *info )
 
 /*
  * mgsl_free_rx_frame_buffers()
- * 
+ *
  * 	Free the receive buffers used by a received SDLC
  * 	frame such that the buffers can be reused.
- * 
+ *
  * Arguments:
- * 
+ *
  * 	info			pointer to device instance data
  * 	StartIndex		index of 1st receive buffer of frame
  * 	EndIndex		index of last receive buffer of frame
- * 
+ *
  * Return Value:	None
  */
 static void mgsl_free_rx_frame_buffers( struct mgsl_struct *info, unsigned int StartIndex, unsigned int EndIndex )
@@ -6472,7 +6472,7 @@ static void mgsl_free_rx_frame_buffers( struct mgsl_struct *info, unsigned int S
 }	/* end of free_rx_frame_buffers() */
 
 /* mgsl_get_rx_frame()
- * 
+ *
  * 	This function attempts to return a received SDLC frame from the
  * 	receive DMA buffers. Only frames received without errors are returned.
  *
@@ -6489,7 +6489,7 @@ static bool mgsl_get_rx_frame(struct mgsl_struct *info)
 	unsigned long flags;
 	struct tty_struct *tty = info->port.tty;
 	bool return_frame = false;
-	
+
 	/*
 	 * current_rx_buffer points to the 1st buffer of the next available
 	 * receive frame. To find the last buffer of the frame look for
@@ -6533,7 +6533,7 @@ static bool mgsl_get_rx_frame(struct mgsl_struct *info)
 
 
 	/* check status of receive frame */
-	
+
 	status = info->rx_buffer_list[EndIndex].status;
 
 	if ( status & (RXSTATUS_SHORT_FRAME | RXSTATUS_OVERRUN |
@@ -6572,17 +6572,17 @@ static bool mgsl_get_rx_frame(struct mgsl_struct *info)
 		if ( info->params.crc_type == HDLC_CRC_16_CCITT )
 			framesize -= 2;
 		else if ( info->params.crc_type == HDLC_CRC_32_CCITT )
-			framesize -= 4;		
+			framesize -= 4;
 	}
 
 	if ( debug_level >= DEBUG_LEVEL_BH )
 		printk("%s(%d):mgsl_get_rx_frame(%s) status=%04X size=%d\n",
 			__FILE__,__LINE__,info->device_name,status,framesize);
-			
+
 	if ( debug_level >= DEBUG_LEVEL_DATA )
 		mgsl_trace_block(info,info->rx_buffer_list[StartIndex].virt_addr,
 			min_t(int, framesize, DMABUFFERSIZE),0);
-		
+
 	if (framesize) {
 		if ( ( (info->params.crc_type & HDLC_CRC_RETURN_EX) &&
 				((framesize+1) > info->max_frame_size) ) ||
@@ -6596,19 +6596,19 @@ static bool mgsl_get_rx_frame(struct mgsl_struct *info)
 
 			if ( !(status & RXSTATUS_CRC_ERROR))
 				info->icount.rxok++;
-			
+
 			while(copy_count) {
 				int partial_count;
 				if ( copy_count > DMABUFFERSIZE )
 					partial_count = DMABUFFERSIZE;
 				else
 					partial_count = copy_count;
-			
+
 				pBufEntry = &(info->rx_buffer_list[index]);
 				memcpy( ptmp, pBufEntry->virt_addr, partial_count );
 				ptmp += partial_count;
 				copy_count -= partial_count;
-				
+
 				if ( ++index == info->rx_buffer_count )
 					index = 0;
 			}
@@ -6641,8 +6641,8 @@ static bool mgsl_get_rx_frame(struct mgsl_struct *info)
 Cleanup:
 
 	if ( info->rx_enabled && info->rx_overflow ) {
-		/* The receiver needs to restarted because of 
-		 * a receive overflow (buffer or FIFO). If the 
+		/* The receiver needs to restarted because of
+		 * a receive overflow (buffer or FIFO). If the
 		 * receive buffers are now empty, then restart receiver.
 		 */
 
@@ -6831,15 +6831,15 @@ static bool mgsl_get_raw_rx_frame(struct mgsl_struct *info)
 }	/* end of mgsl_get_raw_rx_frame() */
 
 /* mgsl_load_tx_dma_buffer()
- * 
+ *
  * 	Load the transmit DMA buffer with the specified data.
- * 
+ *
  * Arguments:
- * 
+ *
  * 	info		pointer to device extension
  * 	Buffer		pointer to buffer containing frame to load
  * 	BufferSize	size in bytes of frame in Buffer
- * 
+ *
  * Return Value: 	None
  */
 static void mgsl_load_tx_dma_buffer(struct mgsl_struct *info,
@@ -6848,7 +6848,7 @@ static void mgsl_load_tx_dma_buffer(struct mgsl_struct *info,
 	unsigned short Copycount;
 	unsigned int i = 0;
 	DMABUFFERENTRY *pBufEntry;
-	
+
 	if ( debug_level >= DEBUG_LEVEL_DATA )
 		mgsl_trace_block(info,Buffer, min_t(int, BufferSize, DMABUFFERSIZE), 1);
 
@@ -6858,7 +6858,7 @@ static void mgsl_load_tx_dma_buffer(struct mgsl_struct *info,
 		 */
 	 	info->cmr_value |= BIT13;
 	}
-		
+
 	/* begin loading the frame in the next available tx dma
 	 * buffer, remember it's starting location for setting
 	 * up tx dma operation
@@ -6879,7 +6879,7 @@ static void mgsl_load_tx_dma_buffer(struct mgsl_struct *info,
 	while( BufferSize ){
 		/* Get a pointer to next DMA buffer entry. */
 		pBufEntry = &info->tx_buffer_list[i++];
-			
+
 		if ( i == info->tx_buffer_count )
 			i=0;
 
@@ -6913,9 +6913,9 @@ static void mgsl_load_tx_dma_buffer(struct mgsl_struct *info,
 
 /*
  * mgsl_register_test()
- * 
+ *
  * 	Performs a register test of the 16C32.
- * 	
+ *
  * Arguments:		info	pointer to device instance data
  * Return Value:		true if test passed, otherwise false
  */
@@ -6971,7 +6971,7 @@ static bool mgsl_register_test( struct mgsl_struct *info )
 }	/* end of mgsl_register_test() */
 
 /* mgsl_irq_test() 	Perform interrupt test of the 16C32.
- * 
+ *
  * Arguments:		info	pointer to device instance data
  * Return Value:	true if test passed, otherwise false
  */
@@ -6984,7 +6984,7 @@ static bool mgsl_irq_test( struct mgsl_struct *info )
 	usc_reset(info);
 
 	/*
-	 * Setup 16C32 to interrupt on TxC pin (14MHz clock) transition. 
+	 * Setup 16C32 to interrupt on TxC pin (14MHz clock) transition.
 	 * The ISR sets irq_occurred to true.
 	 */
 
@@ -6999,7 +6999,7 @@ static bool mgsl_irq_test( struct mgsl_struct *info )
 	usc_EnableMasterIrqBit(info);
 	usc_EnableInterrupts(info, IO_PIN);
 	usc_ClearIrqPendingBits(info, IO_PIN);
-	
+
 	usc_UnlatchIostatusBits(info, MISCSTATUS_TXC_LATCHED);
 	usc_EnableStatusIrqs(info, SICR_TXC_ACTIVE + SICR_TXC_INACTIVE);
 
@@ -7009,21 +7009,21 @@ static bool mgsl_irq_test( struct mgsl_struct *info )
 	while( EndTime-- && !info->irq_occurred ) {
 		msleep_interruptible(10);
 	}
-	
+
 	spin_lock_irqsave(&info->irq_spinlock,flags);
 	usc_reset(info);
 	spin_unlock_irqrestore(&info->irq_spinlock,flags);
-	
+
 	return info->irq_occurred;
 
 }	/* end of mgsl_irq_test() */
 
 /* mgsl_dma_test()
- * 
+ *
  * 	Perform a DMA test of the 16C32. A small frame is
  * 	transmitted via DMA from a transmit buffer to a receive buffer
  * 	using single buffer DMA mode.
- * 	
+ *
  * Arguments:		info	pointer to device instance data
  * Return Value:	true if test passed, otherwise false
  */
@@ -7044,17 +7044,17 @@ static bool mgsl_dma_test( struct mgsl_struct *info )
 	memcpy(&tmp_params,&info->params,sizeof(MGSL_PARAMS));
 	/* load default port options */
 	memcpy(&info->params,&default_params,sizeof(MGSL_PARAMS));
-	
+
 #define TESTFRAMESIZE 40
 
 	spin_lock_irqsave(&info->irq_spinlock,flags);
-	
+
 	/* setup 16C32 for SDLC DMA transfer mode */
 
 	usc_reset(info);
 	usc_set_sdlc_mode(info);
 	usc_enable_loopback(info,1);
-	
+
 	/* Reprogram the RDMR so that the 16C32 does NOT clear the count
 	 * field of the buffer entry after fetching buffer address. This
 	 * way we can detect a DMA failure for a DMA read (which should be
@@ -7063,7 +7063,7 @@ static bool mgsl_dma_test( struct mgsl_struct *info )
 	 */
 
 	/* Receive DMA mode Register (RDMR)
-	 * 
+	 *
 	 * <15..14>	11	DMA mode = Linked List Buffer mode
 	 * <13>		1	RSBinA/L = store Rx status Block in List entry
 	 * <12>		0	1 = Clear count of List Entry after fetching
@@ -7071,12 +7071,12 @@ static bool mgsl_dma_test( struct mgsl_struct *info )
 	 * <9>		1	Terminate Buffer on RxBound
 	 * <8>		0	Bus Width = 16bits
 	 * <7..0>		?	status Bits (write as 0s)
-	 * 
+	 *
 	 * 1110 0010 0000 0000 = 0xe200
 	 */
 
 	usc_OutDmaReg( info, RDMR, 0xe200 );
-	
+
 	spin_unlock_irqrestore(&info->irq_spinlock,flags);
 
 
@@ -7112,12 +7112,12 @@ static bool mgsl_dma_test( struct mgsl_struct *info )
 
 	info->tx_buffer_list[1].count = 0;
 	info->rx_buffer_list[1].count = 0;
-	
+
 
 	/***************************/
 	/* Program 16C32 receiver. */
 	/***************************/
-	
+
 	spin_lock_irqsave(&info->irq_spinlock,flags);
 
 	/* setup DMA transfers */
@@ -7134,7 +7134,7 @@ static bool mgsl_dma_test( struct mgsl_struct *info )
 
 	/* Enable Receiver (RMR <1..0> = 10) */
 	usc_OutReg( info, RMR, (unsigned short)((usc_InReg(info, RMR) & 0xfffc) | 0x0002) );
-	
+
 	spin_unlock_irqrestore(&info->irq_spinlock,flags);
 
 
@@ -7167,7 +7167,7 @@ static bool mgsl_dma_test( struct mgsl_struct *info )
 	/******************************/
 	/* Program 16C32 transmitter. */
 	/******************************/
-	
+
 	spin_lock_irqsave(&info->irq_spinlock,flags);
 
 	/* Program the Transmit Character Length Register (TCLR) */
@@ -7190,14 +7190,14 @@ static bool mgsl_dma_test( struct mgsl_struct *info )
 	/* wait for DMA controller to fill transmit FIFO */
 
 	usc_TCmd( info, TCmd_SelectTicrTxFifostatus );
-	
+
 	spin_unlock_irqrestore(&info->irq_spinlock,flags);
 
 
 	/**********************************/
 	/* WAIT FOR TRANSMIT FIFO TO FILL */
 	/**********************************/
-	
+
 	/* Wait 100ms */
 	EndTime = jiffies + msecs_to_jiffies(100);
 
@@ -7210,7 +7210,7 @@ static bool mgsl_dma_test( struct mgsl_struct *info )
 		spin_lock_irqsave(&info->irq_spinlock,flags);
 		FifoLevel = usc_InReg(info, TICR) >> 8;
 		spin_unlock_irqrestore(&info->irq_spinlock,flags);
-			
+
 		if ( FifoLevel < 16 )
 			break;
 		else
@@ -7228,11 +7228,11 @@ static bool mgsl_dma_test( struct mgsl_struct *info )
 		/* Enable 16C32 transmitter. */
 
 		spin_lock_irqsave(&info->irq_spinlock,flags);
-		
+
 		/* Transmit mode Register (TMR), <1..0> = 10, Enable Transmitter */
 		usc_TCmd( info, TCmd_SendFrame );
 		usc_OutReg( info, TMR, (unsigned short)((usc_InReg(info, TMR) & 0xfffc) | 0x0002) );
-		
+
 		spin_unlock_irqrestore(&info->irq_spinlock,flags);
 
 
@@ -7307,15 +7307,15 @@ static bool mgsl_dma_test( struct mgsl_struct *info )
 
 	/* restore current port options */
 	memcpy(&info->params,&tmp_params,sizeof(MGSL_PARAMS));
-	
+
 	return rc;
 
 }	/* end of mgsl_dma_test() */
 
 /* mgsl_adapter_test()
- * 
+ *
  * 	Perform the register, IRQ, and DMA tests for the 16C32.
- * 	
+ *
  * Arguments:		info	pointer to device instance data
  * Return Value:	0 if success, otherwise -ENODEV
  */
@@ -7324,7 +7324,7 @@ static int mgsl_adapter_test( struct mgsl_struct *info )
 	if ( debug_level >= DEBUG_LEVEL_INFO )
 		printk( "%s(%d):Testing device %s\n",
 			__FILE__,__LINE__,info->device_name );
-			
+
 	if ( !mgsl_register_test( info ) ) {
 		info->init_error = DiagStatus_AddressFailure;
 		printk( "%s(%d):Register test failure for device %s Addr=%04X\n",
@@ -7349,15 +7349,15 @@ static int mgsl_adapter_test( struct mgsl_struct *info )
 	if ( debug_level >= DEBUG_LEVEL_INFO )
 		printk( "%s(%d):device %s passed diagnostics\n",
 			__FILE__,__LINE__,info->device_name );
-			
+
 	return 0;
 
 }	/* end of mgsl_adapter_test() */
 
 /* mgsl_memory_test()
- * 
+ *
  * 	Test the shared memory on a PCI adapter.
- * 
+ *
  * Arguments:		info	pointer to device instance data
  * Return Value:	true if test passed, otherwise false
  */
@@ -7407,35 +7407,35 @@ static bool mgsl_memory_test( struct mgsl_struct *info )
 
 
 /* mgsl_load_pci_memory()
- * 
+ *
  * 	Load a large block of data into the PCI shared memory.
  * 	Use this instead of memcpy() or memmove() to move data
  * 	into the PCI shared memory.
- * 
+ *
  * Notes:
- * 
+ *
  * 	This function prevents the PCI9050 interface chip from hogging
  * 	the adapter local bus, which can starve the 16C32 by preventing
  * 	16C32 bus master cycles.
- * 
+ *
  * 	The PCI9050 documentation says that the 9050 will always release
  * 	control of the local bus after completing the current read
  * 	or write operation.
- * 
+ *
  * 	It appears that as long as the PCI9050 write FIFO is full, the
  * 	PCI9050 treats all of the writes as a single burst transaction
  * 	and will not release the bus. This causes DMA latency problems
  * 	at high speeds when copying large data blocks to the shared
  * 	memory.
- * 
+ *
  * 	This function in effect, breaks the a large shared memory write
  * 	into multiple transations by interleaving a shared memory read
  * 	which will flush the write FIFO and 'complete' the write
  * 	transation. This allows any pending DMA request to gain control
  * 	of the local bus in a timely fasion.
- * 
+ *
  * Arguments:
- * 
+ *
  * 	TargetPtr	pointer to target address in PCI shared memory
  * 	SourcePtr	pointer to source buffer for data
  * 	count		count in bytes of data to copy
@@ -7472,13 +7472,13 @@ static void mgsl_trace_block(struct mgsl_struct *info,const char* data, int coun
 		printk("%s tx data:\n",info->device_name);
 	else
 		printk("%s rx data:\n",info->device_name);
-		
+
 	while(count) {
 		if (count > 16)
 			linecount = 16;
 		else
 			linecount = count;
-			
+
 		for(i=0;i<linecount;i++)
 			printk("%02X ",(unsigned char)data[i]);
 		for(;i<17;i++)
@@ -7490,17 +7490,17 @@ static void mgsl_trace_block(struct mgsl_struct *info,const char* data, int coun
 				printk(".");
 		}
 		printk("\n");
-		
+
 		data  += linecount;
 		count -= linecount;
 	}
 }	/* end of mgsl_trace_block() */
 
 /* mgsl_tx_timeout()
- * 
+ *
  * 	called when HDLC frame times out
  * 	update stats and do tx completion processing
- * 	
+ *
  * Arguments:	context		pointer to device instance data
  * Return Value:	None
  */
@@ -7508,7 +7508,7 @@ static void mgsl_tx_timeout(struct timer_list *t)
 {
 	struct mgsl_struct *info = from_timer(info, t, tx_timer);
 	unsigned long flags;
-	
+
 	if ( debug_level >= DEBUG_LEVEL_INFO )
 		printk( "%s(%d):mgsl_tx_timeout(%s)\n",
 			__FILE__,__LINE__,info->device_name);
@@ -7525,14 +7525,14 @@ static void mgsl_tx_timeout(struct timer_list *t)
 		usc_loopmode_cancel_transmit( info );
 
 	spin_unlock_irqrestore(&info->irq_spinlock,flags);
-	
+
 #if SYNCLINK_GENERIC_HDLC
 	if (info->netcount)
 		hdlcdev_tx_done(info);
 	else
 #endif
 		mgsl_bh_transmit(info);
-	
+
 }	/* end of mgsl_tx_timeout() */
 
 /* signal that there are no more frames to send, so that
@@ -7542,7 +7542,7 @@ static void mgsl_tx_timeout(struct timer_list *t)
 static int mgsl_loopmode_send_done( struct mgsl_struct * info )
 {
 	unsigned long flags;
-	
+
 	spin_lock_irqsave(&info->irq_spinlock,flags);
 	if (info->params.flags & HDLC_FLAG_HDLC_LOOPMODE) {
 		if (info->tx_active)
@@ -7583,13 +7583,13 @@ static void usc_loopmode_cancel_transmit( struct mgsl_struct * info )
 static void usc_loopmode_insert_request( struct mgsl_struct * info )
 {
  	info->loopmode_insert_requested = true;
- 
+
  	/* enable RxAbort irq. On next RxAbort, clear CMR:13 to
  	 * begin repeating TxData on RxData (complete insertion)
 	 */
- 	usc_OutReg( info, RICR, 
+	usc_OutReg( info, RICR,
 		(usc_InReg( info, RICR ) | RXSTATUS_ABORT_RECEIVED ) );
-		
+
 	/* set CMR:13 to insert into loop on next GoAhead (RxAbort) */
 	info->cmr_value |= BIT13;
  	usc_OutReg(info, CMR, info->cmr_value);
@@ -8045,11 +8045,11 @@ static int synclink_init_one (struct pci_dev *dev,
 	}
 
         /* Copy user configuration info to device instance data */
-		
+
 	info->io_base = pci_resource_start(dev, 2);
 	info->irq_level = dev->irq;
 	info->phys_memory_base = pci_resource_start(dev, 3);
-				
+
         /* Because veremap only works on page boundaries we must map
 	 * a larger area than is actually implemented for the LCR
 	 * memory range. We map a full page starting at the page boundary.
@@ -8057,7 +8057,7 @@ static int synclink_init_one (struct pci_dev *dev,
 	info->phys_lcr_base = pci_resource_start(dev, 0);
 	info->lcr_offset    = info->phys_lcr_base & (PAGE_SIZE-1);
 	info->phys_lcr_base &= ~(PAGE_SIZE-1);
-				
+
 	info->bus_type = MGSL_BUS_TYPE_PCI;
 	info->io_addr_size = 8;
 	info->irq_flags = IRQF_SHARED;
@@ -8068,14 +8068,14 @@ static int synclink_init_one (struct pci_dev *dev,
 		info->hw_version = 1;
 	} else {
 		/* Version 0 PCI9050 based 5V PCI adapter
-		 * A PCI9050 bug prevents reading LCR registers if 
+		 * A PCI9050 bug prevents reading LCR registers if
 		 * LCR base address bit 7 is set. Maintain shadow
 		 * value so we can write to LCR misc control reg.
 		 */
 		info->misc_ctrl_value = 0x087e4546;
 		info->hw_version = 0;
 	}
-				
+
 	mgsl_add_device(info);
 
 	return 0;
diff --git a/drivers/tty/synclinkmp.c b/drivers/tty/synclinkmp.c
index 1e4d5b9c981a..58570451d0be 100644
--- a/drivers/tty/synclinkmp.c
+++ b/drivers/tty/synclinkmp.c
@@ -946,7 +946,7 @@ static int write(struct tty_struct *tty,
 			    info->max_frame_size - info->tx_put));
 		if (c <= 0)
 			break;
-			
+
 		memcpy(info->tx_buf + info->tx_put, buf, c);
 
 		spin_lock_irqsave(&info->lock,flags);
@@ -1291,7 +1291,7 @@ static int ioctl(struct tty_struct *tty,
 		 */
 	case TIOCMIWAIT:
 		return modem_input_wait(info,(int)arg);
-		
+
 		/*
 		 * Get counter of input serial line interrupts (DCD,RI,DSR,CTS)
 		 * Return: write counters to the user passed counter struct
@@ -2092,7 +2092,7 @@ static void isr_rxint(SLMP_INFO * info)
 
 	if (status2)
 		write_reg(info, SR2, status2);
-	
+
 	if ( debug_level >= DEBUG_LEVEL_ISR )
 		printk("%s(%d):%s isr_rxint status=%02X %02x\n",
 			__FILE__,__LINE__,info->device_name,status,status2);
@@ -4213,24 +4213,24 @@ static void tx_start(SLMP_INFO *info)
 
 			write_reg(info, TXDMA + DSR, 0); 		/* disable DMA channel */
 			write_reg(info, TXDMA + DCMD, SWABORT);	/* reset/init DMA channel */
-	
+
 			/* set TX CDA (current descriptor address) */
 			write_reg16(info, TXDMA + CDA,
 				info->tx_buf_list_ex[0].phys_entry);
-	
+
 			/* set TX EDA (last descriptor address) */
 			write_reg16(info, TXDMA + EDA,
 				info->tx_buf_list_ex[info->last_tx_buf].phys_entry);
-	
+
 			/* enable underrun IRQ */
 			info->ie1_value &= ~IDLE;
 			info->ie1_value |= UDRN;
 			write_reg(info, IE1, info->ie1_value);
 			write_reg(info, SR1, (unsigned char)(IDLE + UDRN));
-	
+
 			write_reg(info, TXDMA + DIR, 0x40);		/* enable Tx DMA interrupts (EOM) */
 			write_reg(info, TXDMA + DSR, 0xf2);		/* clear Tx DMA IRQs, enable Tx DMA */
-	
+
 			mod_timer(&info->tx_timer, jiffies +
 					msecs_to_jiffies(5000));
 		}
diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index df94cdbe0096..6e47e9a5e86d 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -2701,7 +2701,7 @@ static int this_tty(const void *t, struct file *file, unsigned fd)
 		return 0;
 	return file_tty(file) != t ? 0 : fd + 1;
 }
-	
+
 /*
  * This implements the "Secure Attention Key" ---  the idea is to
  * prevent trojan horses by killing all processes associated with this
diff --git a/drivers/tty/tty_ioctl.c b/drivers/tty/tty_ioctl.c
index f9bcae2b7e36..56426611050d 100644
--- a/drivers/tty/tty_ioctl.c
+++ b/drivers/tty/tty_ioctl.c
@@ -832,7 +832,7 @@ int tty_mode_ioctl(struct tty_struct *tty, struct file *file,
 		return set_termiox(real_tty, p, TERMIOS_WAIT);
 	case TCSETXF:
 		return set_termiox(real_tty, p, TERMIOS_FLUSH);
-#endif		
+#endif
 	case TIOCGSOFTCAR:
 		copy_termios(real_tty, &kterm);
 		ret = put_user((kterm.c_cflag & CLOCAL) ? 1 : 0,
diff --git a/drivers/tty/vt/consolemap.c b/drivers/tty/vt/consolemap.c
index 97d02684b922..71086e4abc9a 100644
--- a/drivers/tty/vt/consolemap.c
+++ b/drivers/tty/vt/consolemap.c
@@ -71,7 +71,7 @@ static unsigned short translations[][256] = {
     0x00e8, 0x00e9, 0x00ea, 0x00eb, 0x00ec, 0x00ed, 0x00ee, 0x00ef,
     0x00f0, 0x00f1, 0x00f2, 0x00f3, 0x00f4, 0x00f5, 0x00f6, 0x00f7,
     0x00f8, 0x00f9, 0x00fa, 0x00fb, 0x00fc, 0x00fd, 0x00fe, 0x00ff
-  }, 
+  },
   /* VT100 graphics mapped to Unicode */
   {
     0x0000, 0x0001, 0x0002, 0x0003, 0x0004, 0x0005, 0x0006, 0x0007,
@@ -109,7 +109,7 @@ static unsigned short translations[][256] = {
   },
   /* IBM Codepage 437 mapped to Unicode */
   {
-    0x0000, 0x263a, 0x263b, 0x2665, 0x2666, 0x2663, 0x2660, 0x2022, 
+    0x0000, 0x263a, 0x263b, 0x2665, 0x2666, 0x2663, 0x2660, 0x2022,
     0x25d8, 0x25cb, 0x25d9, 0x2642, 0x2640, 0x266a, 0x266b, 0x263c,
     0x25b6, 0x25c0, 0x2195, 0x203c, 0x00b6, 0x00a7, 0x25ac, 0x21a8,
     0x2191, 0x2193, 0x2192, 0x2190, 0x221f, 0x2194, 0x25b2, 0x25bc,
@@ -141,7 +141,7 @@ static unsigned short translations[][256] = {
     0x03a6, 0x0398, 0x03a9, 0x03b4, 0x221e, 0x03c6, 0x03b5, 0x2229,
     0x2261, 0x00b1, 0x2265, 0x2264, 0x2320, 0x2321, 0x00f7, 0x2248,
     0x00b0, 0x2219, 0x00b7, 0x221a, 0x207f, 0x00b2, 0x25a0, 0x00a0
-  }, 
+  },
   /* User mapping -- default to codes for direct font mapping */
   {
     0xf000, 0xf001, 0xf002, 0xf003, 0xf004, 0xf005, 0xf006, 0xf007,
@@ -201,7 +201,7 @@ static void set_inverse_transl(struct vc_data *conp, struct uni_pagedir *p, int
 	int j, glyph;
 	unsigned short *t = translations[i];
 	unsigned char *q;
-	
+
 	if (!p) return;
 	q = p->inverse_translations[i];
 
@@ -298,7 +298,7 @@ static void update_user_maps(void)
 {
 	int i;
 	struct uni_pagedir *p, *q = NULL;
-	
+
 	for (i = 0; i < MAX_NR_CONSOLES; i++) {
 		if (!vc_cons_allocated(i))
 			continue;
@@ -381,7 +381,7 @@ int con_get_trans_new(ushort __user * arg)
 }
 
 /*
- * Unicode -> current font conversion 
+ * Unicode -> current font conversion
  *
  * A font has at most 512 chars, usually 256.
  * But one font position may represent several Unicode chars.
@@ -398,7 +398,7 @@ static void con_release_unimap(struct uni_pagedir *p)
 	u16 **p1;
 	int i, j;
 
-	if (p == dflt) dflt = NULL;  
+	if (p == dflt) dflt = NULL;
 	for (i = 0; i < 32; i++) {
 		p1 = p->uni_pgdir[i];
 		if (p1 != NULL) {
@@ -430,12 +430,12 @@ void con_free_unimap(struct vc_data *vc)
 	con_release_unimap(p);
 	kfree(p);
 }
-  
+
 static int con_unify_unimap(struct vc_data *conp, struct uni_pagedir *p)
 {
 	int i, j, k;
 	struct uni_pagedir *q;
-	
+
 	for (i = 0; i < MAX_NR_CONSOLES; i++) {
 		if (!vc_cons_allocated(i))
 			continue;
@@ -494,7 +494,7 @@ con_insert_unipair(struct uni_pagedir *p, u_short unicode, u_short fontpos)
 	}
 
 	p2[unicode & 0x3f] = fontpos;
-	
+
 	p->sum += (fontpos << 20) + unicode;
 
 	return 0;
@@ -532,7 +532,7 @@ int con_clear_unimap(struct vc_data *vc)
 	console_unlock();
 	return ret;
 }
-	
+
 int con_set_unimap(struct vc_data *vc, ushort ct, struct unipair __user *list)
 {
 	int err = 0, err1, i;
@@ -556,17 +556,17 @@ int con_set_unimap(struct vc_data *vc, ushort ct, struct unipair __user *list)
 
 		goto out_unlock;
 	}
-	
+
 	if (p->refcount > 1) {
 		int j, k;
 		u16 **p1, *p2, l;
-		
+
 		err1 = con_do_clear_unimap(vc);
 		if (err1) {
 			err = err1;
 			goto out_unlock;
 		}
-		
+
 		/*
 		 * Since refcount was > 1, con_clear_unimap() allocated a
 		 * a new uni_pagedir for this vc.  Re: p != q
@@ -628,7 +628,7 @@ int con_set_unimap(struct vc_data *vc, ushort ct, struct unipair __user *list)
 		if (err1)
 			err = err1;
 	}
-	
+
 	/*
 	 * Merge with fontmaps of any other virtual consoles.
 	 */
@@ -652,7 +652,7 @@ int con_set_unimap(struct vc_data *vc, ushort ct, struct unipair __user *list)
  *	Loads the unimap for the hardware font, as defined in uni_hash.tbl.
  *	The representation used was the most compact I could come up
  *	with.  This routine is executed at video setup, and when the
- *	PIO_FONTRESET ioctl is called. 
+ *	PIO_FONTRESET ioctl is called.
  *
  *	The caller must hold the console lock
  */
@@ -675,23 +675,23 @@ int con_set_default_unimap(struct vc_data *vc)
 		}
 		return 0;
 	}
-	
+
 	/* The default font is always 256 characters */
 
 	err = con_do_clear_unimap(vc);
 	if (err)
 		return err;
-    
+
 	p = *vc->vc_uni_pagedir_loc;
 	q = dfont_unitable;
-	
+
 	for (i = 0; i < 256; i++)
 		for (j = dfont_unicount[i]; j; j--) {
 			err1 = con_insert_unipair(p, *(q++), i);
 			if (err1)
 				err = err1;
 		}
-			
+
 	if (con_unify_unimap(vc, p)) {
 		dflt = *vc->vc_uni_pagedir_loc;
 		return err;
@@ -807,12 +807,12 @@ int conv_uni_to_8bit(u32 uni)
 }
 
 int
-conv_uni_to_pc(struct vc_data *conp, long ucs) 
+conv_uni_to_pc(struct vc_data *conp, long ucs)
 {
 	int h;
 	u16 **p1, *p2;
 	struct uni_pagedir *p;
-  
+
 	/* Only 16-bit codes supported at this time */
 	if (ucs > 0xffff)
 		return -4;		/* Not found */
@@ -827,7 +827,7 @@ conv_uni_to_pc(struct vc_data *conp, long ucs)
 	 */
 	else if ((ucs & ~UNI_DIRECT_MASK) == UNI_DIRECT_BASE)
 		return ucs & UNI_DIRECT_MASK;
-  
+
 	if (!*conp->vc_uni_pagedir_loc)
 		return -3;
 
@@ -845,11 +845,11 @@ conv_uni_to_pc(struct vc_data *conp, long ucs)
  * initialized.  It must be possible to call kmalloc(..., GFP_KERNEL)
  * from this function, hence the call from sys_setup.
  */
-void __init 
+void __init
 console_map_init(void)
 {
 	int i;
-	
+
 	for (i = 0; i < MAX_NR_CONSOLES; i++)
 		if (vc_cons_allocated(i) && !*vc_cons[i].d->vc_uni_pagedir_loc)
 			con_set_default_unimap(vc_cons[i].d);
diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index 214ad559fd2d..4d044bc7122f 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -1769,7 +1769,7 @@ int vt_do_diacrit(unsigned int cmd, void __user *udp, int perm)
 					  ct * sizeof(struct kbdiacruc));
 			if (IS_ERR(buf))
 				return PTR_ERR(buf);
-		} 
+		}
 		spin_lock_irqsave(&kbd_event_lock, flags);
 		if (ct)
 			memcpy(accent_table, buf,
diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 94131c746ef7..27f0f19a4c31 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -38,7 +38,7 @@
  *
  *     - Arno Griffioen <arno@usn.nl>
  *     - David Carter <carter@cs.bris.ac.uk>
- * 
+ *
  *   The abstract console driver provides a generic interface for a text
  *   console. It supports VGA text mode, frame buffer based graphical consoles
  *   and special graphics processors that are only accessible through some
@@ -293,7 +293,7 @@ static inline bool con_should_update(const struct vc_data *vc)
 static inline unsigned short *screenpos(struct vc_data *vc, int offset, int viewed)
 {
 	unsigned short *p;
-	
+
 	if (!viewed)
 		p = (unsigned short *)(vc->vc_origin + offset);
 	else if (!vc->vc_sw->con_screen_pos)
@@ -4380,9 +4380,9 @@ void reset_palette(struct vc_data *vc)
  *  Font switching
  *
  *  Currently we only support fonts up to 32 pixels wide, at a maximum height
- *  of 32 pixels. Userspace fontdata is stored with 32 bytes (shorts/ints, 
- *  depending on width) reserved for each character which is kinda wasty, but 
- *  this is done in order to maintain compatibility with the EGA/VGA fonts. It 
+ *  of 32 pixels. Userspace fontdata is stored with 32 bytes (shorts/ints,
+ *  depending on width) reserved for each character which is kinda wasty, but
+ *  this is done in order to maintain compatibility with the EGA/VGA fonts. It
  *  is up to the actual low-level console-driver convert data into its favorite
  *  format (maybe we should add a `fontoffset' field to the `display'
  *  structure so we won't have to convert the fontdata all the time.
@@ -4421,7 +4421,7 @@ static int con_font_get(struct vc_data *vc, struct console_font_op *op)
 	if (op->data && font.charcount > op->charcount)
 		rc = -ENOSPC;
 	if (!(op->flags & KD_FONT_FLAG_OLD)) {
-		if (font.width > op->width || font.height > op->height) 
+		if (font.width > op->width || font.height > op->height)
 			rc = -ENOSPC;
 	} else {
 		if (font.width != 8)
diff --git a/drivers/tty/vt/vt_ioctl.c b/drivers/tty/vt/vt_ioctl.c
index 30e02ec5d6a0..801f2f6e1302 100644
--- a/drivers/tty/vt/vt_ioctl.c
+++ b/drivers/tty/vt/vt_ioctl.c
@@ -222,13 +222,13 @@ int vt_waitactive(int n)
 
 
 
-static inline int 
+static inline int
 do_fontx_ioctl(int cmd, struct consolefontdesc __user *user_cfd, int perm, struct console_font_op *op)
 {
 	struct consolefontdesc cfdarg;
 	int i;
 
-	if (copy_from_user(&cfdarg, user_cfd, sizeof(struct consolefontdesc))) 
+	if (copy_from_user(&cfdarg, user_cfd, sizeof(struct consolefontdesc)))
 		return -EFAULT;
 
 	switch (cmd) {
@@ -262,7 +262,7 @@ do_fontx_ioctl(int cmd, struct consolefontdesc __user *user_cfd, int perm, struc
 	return -EINVAL;
 }
 
-static inline int 
+static inline int
 do_unimap_ioctl(int cmd, struct unimapdesc __user *user_ud, int perm, struct vc_data *vc)
 {
 	struct unimapdesc tmp;
@@ -328,7 +328,7 @@ static void vt_disallocate_all(void)
 
 /*
  * We handle the console-specific ioctl's here.  We allow the
- * capability to modify any console, not just the fg_console. 
+ * capability to modify any console, not just the fg_console.
  */
 int vt_ioctl(struct tty_struct *tty,
 	     unsigned int cmd, unsigned long arg)
@@ -382,7 +382,7 @@ int vt_ioctl(struct tty_struct *tty,
 			return -EPERM;
 	{
 		unsigned int ticks, count;
-		
+
 		/*
 		 * Generate the tone for the appropriate number of ticks.
 		 * If the time is zero, turn off sound ourselves.
@@ -433,11 +433,11 @@ int vt_ioctl(struct tty_struct *tty,
 #endif
 
 	/* Linux m68k/i386 interface for setting the keyboard delay/repeat rate */
-		
+
 	case KDKBDREP:
 	{
 		struct kbd_repeat kbrep;
-		
+
 		if (!capable(CAP_SYS_TTY_CONFIG))
 			return -EPERM;
 
@@ -664,7 +664,7 @@ int vt_ioctl(struct tty_struct *tty,
 			if (! VT_IS_IN_USE(i))
 				break;
 		uival = i < MAX_NR_CONSOLES ? (i+1) : -1;
-		goto setint;		 
+		goto setint;
 
 	/*
 	 * ioctl(fd, VT_ACTIVATE, num) will cause us to switch to vt # num,
-- 
2.17.1


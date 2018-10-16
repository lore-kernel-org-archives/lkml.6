Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6036BC5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 23:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BACC621471
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 23:22:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mPr8WRP8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BACC621471
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbeJQHOl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 03:14:41 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:41349 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726936AbeJQHOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 03:14:41 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 81B8A21FB7;
        Tue, 16 Oct 2018 19:21:55 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 16 Oct 2018 19:21:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:in-reply-to:message-id
        :references:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=IGkokoriJnHn/17GLcoDOXvS7AYLL
        HgAkcxzs1IBrXw=; b=mPr8WRP8oZnITU6t0E1yyaEsBFn+9uEaR/zslFwlb9r0O
        ZCcwMayuZCRe46axkTX7O3EgfbiKs3UJ3j84OQKmyORIK4PD3roAhq+SrwIz5HiW
        lp6nq/yNdCJzq9zQVbyYsxTx11q6ck1mMgyMbiaFohm9/X4RcDD/0kv4iLo4MOlR
        tSNVE28u+s9WqwfygoAaD+Gaef7rNFT8RWlXzodrSDETsg34WQvuVPTKBOUbEO91
        e2nqdSvbd/+VjPSK40584pVi9t9pUIoqgbBFuMrd3PAXpEeZOHSDDUugbDHeiU1m
        ERmvCeOcQwT3yfscf7IeJVZZLfqGG4iFYznEF8V7A==
X-ME-Sender: <xms:k3LGW_PwjCw-24blR27Y929vDFu9cdAyY5zMYFIAQPrACMAwpziY5g>
X-ME-Proxy: <xmx:k3LGW0dCHCVvxBLIZAyrHVolpCUO9eohosHtjp2PS80S-UQbZ6-2Qg>
    <xmx:k3LGW71rpwgSagDFTEiBn2iySlN2bfrKL9f1o_Pi7Wwpf-nPEsdzGw>
    <xmx:k3LGW9liKIikoguQOT45BtqLz3o30FffCSqa1BJr4fjA1YJ959EKjQ>
    <xmx:k3LGWyrnXN7n2VpRfLsvVZO5eInJV1_pIbyOxXnRKX7VqMgI6Axitw>
    <xmx:k3LGW_EluX960xDRYZxJEn5lJMSJwGFKxahJpOYOEBF7H-12sNAaDQ>
    <xmx:k3LGW3l-QpKUcxjd1J3nGqhlCQGtxKVYoye23Eqps404jvJYjlQ3PQ>
Received: from localhost (ppp121-44-203-227.bras1.syd2.internode.on.net [121.44.203.227])
        by mail.messagingengine.com (Postfix) with ESMTPA id E33B4102ED;
        Tue, 16 Oct 2018 19:21:53 -0400 (EDT)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     "Tobin C. Harding" <tobin@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] tty: Fix whitespace before tab warnings
Date:   Wed, 17 Oct 2018 10:21:24 +1100
Message-Id: <20181016232130.728-2-tobin@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181016232130.728-1-tobin@kernel.org>
References: <20181016232130.728-1-tobin@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is whitespace only.

Checkpatch emits a BUNCH of warnings of type

	WARNING: please, no spaces at the start of a line
	WARNING: please, no space before tabs

While these may seem trivial they hinder further cleanup efforts because
there are so many that later cleanup touches many of the same lines,
this makes the cleanup patches super noisy when parsed with
checkpatch (although checkpatching this series is prohibitively noisy
even with this patch).

In preparation for doing kernel-docs cleanup fix all the whitespace
before tab and whitespace at start of line warnings.  We do not fix any
that are obviously there for extra-ordinary formatting reasons.

Any line in the diff with obvious other formatting errors is fixed also
excluding kernel-docs lines.

Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---
 drivers/tty/amiserial.c                     |  43 ++++---
 drivers/tty/hvc/hvc_console.c               |   2 +-
 drivers/tty/ipwireless/tty.c                |   2 +-
 drivers/tty/isicom.c                        |   4 +-
 drivers/tty/moxa.c                          |  30 +++--
 drivers/tty/mxser.c                         |  10 +-
 drivers/tty/n_hdlc.c                        |  10 +-
 drivers/tty/rocket.c                        |   8 +-
 drivers/tty/serdev/core.c                   |   2 +-
 drivers/tty/serial/8250/8250_dw.c           |   4 +-
 drivers/tty/serial/amba-pl011.c             |   8 +-
 drivers/tty/serial/cpm_uart/cpm_uart_core.c |   8 +-
 drivers/tty/serial/icom.c                   |   5 +-
 drivers/tty/serial/ip22zilog.c              |   2 +-
 drivers/tty/serial/jsm/jsm_neo.c            |   2 +-
 drivers/tty/serial/mux.c                    |   6 +-
 drivers/tty/serial/mxs-auart.c              |   2 +-
 drivers/tty/serial/pmac_zilog.c             |   4 +-
 drivers/tty/serial/pxa.c                    |  20 +--
 drivers/tty/serial/serial_txx9.c            |   2 +-
 drivers/tty/serial/sn_console.c             |  38 +++---
 drivers/tty/serial/sunsab.c                 |   2 +-
 drivers/tty/serial/sunsu.c                  |   4 +-
 drivers/tty/serial/sunzilog.c               |   2 +-
 drivers/tty/serial/ucc_uart.c               | 134 ++++++++++----------
 drivers/tty/serial/vr41xx_siu.c             |   2 +-
 drivers/tty/serial/zs.c                     |  12 +-
 drivers/tty/sysrq.c                         |  34 ++---
 drivers/tty/tty_baudrate.c                  |   2 +-
 drivers/tty/tty_io.c                        |  22 ++--
 drivers/tty/tty_ioctl.c                     |   2 +-
 drivers/tty/tty_jobctrl.c                   |   8 +-
 drivers/tty/vt/consolemap.c                 |   6 +-
 drivers/tty/vt/keyboard.c                   |  29 +++--
 drivers/tty/vt/selection.c                  |  12 +-
 drivers/tty/vt/vt.c                         |  40 +++---
 drivers/tty/vt/vt_ioctl.c                   |  14 +-
 37 files changed, 271 insertions(+), 266 deletions(-)

diff --git a/drivers/tty/amiserial.c b/drivers/tty/amiserial.c
index 34dead614149..73d4033cef6b 100644
--- a/drivers/tty/amiserial.c
+++ b/drivers/tty/amiserial.c
@@ -18,7 +18,7 @@
  *
  *  Copyright (C) 1991, 1992  Linus Torvalds
  *  Copyright (C) 1992, 1993, 1994, 1995, 1996, 1997, 
- * 		1998, 1999  Theodore Ts'o
+ *		1998, 1999  Theodore Ts'o
  *
  */
 
@@ -26,8 +26,8 @@
  * Serial driver configuration section.  Here are the various options:
  *
  * SERIAL_PARANOIA_CHECK
- * 		Check the magic number for the async_structure where
- * 		ever possible.
+ *		Check the magic number for the async_structure where
+ *		ever possible.
  */
 
 #include <linux/delay.h>
@@ -104,8 +104,8 @@ struct serial_state {
 	int			ignore_status_mask;
 	int			timeout;
 	int			quot;
-	int			IER; 	/* Interrupt Enable Register */
-	int			MCR; 	/* Modem control register */
+	int			IER;	/* Interrupt Enable Register */
+	int			MCR;	/* Modem control register */
 	int			x_char;	/* xon/xoff character */
 };
 
@@ -173,7 +173,8 @@ static inline int serial_paranoia_check(struct serial_state *info,
 
 static __inline__ void rtsdtr_ctrl(int bits)
 {
-    ciab.pra = ((bits & (SER_RTS | SER_DTR)) ^ (SER_RTS | SER_DTR)) | (ciab.pra & ~(SER_RTS | SER_DTR));
+	ciab.pra = ((bits & (SER_RTS | SER_DTR)) ^ (SER_RTS | SER_DTR)) |
+		   (ciab.pra & ~(SER_RTS | SER_DTR));
 }
 
 /*
@@ -243,13 +244,13 @@ static void rs_start(struct tty_struct *tty)
  *
  * and look at the resulting assemble code in serial.s.
  *
- * 				- Ted Ts'o (tytso@mit.edu), 7-Mar-93
+ *				- Ted Ts'o (tytso@mit.edu), 7-Mar-93
  * -----------------------------------------------------------------------
  */
 
 static void receive_chars(struct serial_state *info)
 {
-        int status;
+	int status;
 	int serdatr;
 	unsigned char ch, flag;
 	struct	async_icount *icount;
@@ -912,7 +913,7 @@ static void rs_flush_buffer(struct tty_struct *tty)
 static void rs_send_xchar(struct tty_struct *tty, char ch)
 {
 	struct serial_state *info = tty->driver_data;
-        unsigned long flags;
+	unsigned long flags;
 
 	if (serial_paranoia_check(info, tty->name, "rs_send_xchar"))
 		return;
@@ -921,8 +922,8 @@ static void rs_send_xchar(struct tty_struct *tty, char ch)
 	if (ch) {
 		/* Make sure transmit interrupts are on */
 
-	        /* Check this ! */
-	        local_irq_save(flags);
+		/* Check this ! */
+		local_irq_save(flags);
 		if(!(custom.intenar & IF_TBE)) {
 		    custom.intena = IF_SETCLR | IF_TBE;
 		    mb();
@@ -1000,7 +1001,7 @@ static int get_serial_info(struct tty_struct *tty, struct serial_state *state,
 			   struct serial_struct __user * retinfo)
 {
 	struct serial_struct tmp;
-   
+
 	memset(&tmp, 0, sizeof(tmp));
 	tty_lock(tty);
 	tmp.line = tty->index;
@@ -1023,7 +1024,7 @@ static int set_serial_info(struct tty_struct *tty, struct serial_state *state,
 	struct tty_port *port = &state->tport;
 	struct serial_struct new_serial;
 	bool change_spd;
-	int 			retval = 0;
+	int			retval = 0;
 
 	if (copy_from_user(&new_serial,new_info,sizeof(new_serial)))
 		return -EFAULT;
@@ -1036,7 +1037,7 @@ static int set_serial_info(struct tty_struct *tty, struct serial_state *state,
 		tty_unlock(tty);
 		return -EINVAL;
 	}
-  
+
 	if (!serial_isroot()) {
 		if ((new_serial.baud_base != state->baud_base) ||
 		    (new_serial.close_delay != port->close_delay) ||
@@ -1089,11 +1090,11 @@ static int set_serial_info(struct tty_struct *tty, struct serial_state *state,
  * get_lsr_info - get line status register info
  *
  * Purpose: Let user call ioctl() to get info when the UART physically
- * 	    is emptied.  On bus types like RS485, the transmitter must
- * 	    release the bus after transmitting. This must be done when
- * 	    the transmit shift register is empty, not be done when the
- * 	    transmit holding register is empty.  This functionality
- * 	    allows an RS485 driver to be written in user space. 
+ *	    is emptied.  On bus types like RS485, the transmitter must
+ *	    release the bus after transmitting. This must be done when
+ *	    the transmit shift register is empty, not be done when the
+ *	    transmit holding register is empty.  This functionality
+ *	    allows an RS485 driver to be written in user space.
  */
 static int get_lsr_info(struct serial_state *info, unsigned int __user *value)
 {
@@ -1251,7 +1252,7 @@ static int rs_ioctl(struct tty_struct *tty,
 		/*
 		 * Wait for any of the 4 modem inputs (DCD,RI,DSR,CTS) to change
 		 * - mask passed in arg for lines of interest
- 		 *   (use |'ed TIOCM_RNG/DSR/CD/CTS for masking)
+		 *   (use |'ed TIOCM_RNG/DSR/CD/CTS for masking)
 		 * Caller should use TIOCGICOUNT to see which one it was
 		 */
 		case TIOCMIWAIT:
@@ -1581,7 +1582,7 @@ static int rs_proc_show(struct seq_file *m, void *v)
  */
 static void show_serial_version(void)
 {
- 	printk(KERN_INFO "%s version %s\n", serial_name, serial_version);
+	printk(KERN_INFO "%s version %s\n", serial_name, serial_version);
 }
 
 
diff --git a/drivers/tty/hvc/hvc_console.c b/drivers/tty/hvc/hvc_console.c
index 27284a2dcd2b..676cf5b73ed2 100644
--- a/drivers/tty/hvc/hvc_console.c
+++ b/drivers/tty/hvc/hvc_console.c
@@ -268,7 +268,7 @@ static void hvc_check_console(int index)
 	if (hvc_console.flags & CON_ENABLED)
 		return;
 
- 	/* If this index is what the user requested, then register
+	/* If this index is what the user requested, then register
 	 * now (setup won't fail at this point).  It's ok to just
 	 * call register again if previously .setup failed.
 	 */
diff --git a/drivers/tty/ipwireless/tty.c b/drivers/tty/ipwireless/tty.c
index 1ef751c27ac6..20779f7e6e32 100644
--- a/drivers/tty/ipwireless/tty.c
+++ b/drivers/tty/ipwireless/tty.c
@@ -35,7 +35,7 @@
 #include "hardware.h"
 #include "main.h"
 
-#define IPWIRELESS_PCMCIA_START 	(0)
+#define IPWIRELESS_PCMCIA_START	(0)
 #define IPWIRELESS_PCMCIA_MINORS	(24)
 #define IPWIRELESS_PCMCIA_MINOR_RANGE	(8)
 
diff --git a/drivers/tty/isicom.c b/drivers/tty/isicom.c
index 8d96e86966f1..b45eb8b20606 100644
--- a/drivers/tty/isicom.c
+++ b/drivers/tty/isicom.c
@@ -86,7 +86,7 @@
  *	10/12/03  Ravindra		Made to work for Fedora Core 1 of
  *					Red Hat Distribution
  *
- *	06/01/05  Alan Cox 		Merged the ISI and base kernel strands
+ *	06/01/05  Alan Cox		Merged the ISI and base kernel strands
  *					into a single 2.6 driver
  *
  *	***********************************************************
@@ -1665,7 +1665,7 @@ static int __init isicom_init(void)
 		goto error;
 	}
 
-	isicom_normal->name 			= "ttyM";
+	isicom_normal->name			= "ttyM";
 	isicom_normal->major			= ISICOM_NMAJOR;
 	isicom_normal->minor_start		= 0;
 	isicom_normal->type			= TTY_DRIVER_TYPE_SERIAL;
diff --git a/drivers/tty/moxa.c b/drivers/tty/moxa.c
index 250a19f042d7..7ce06f43b6ae 100644
--- a/drivers/tty/moxa.c
+++ b/drivers/tty/moxa.c
@@ -148,7 +148,7 @@ struct mon_str {
 
 /* statusflags */
 #define TXSTOPPED	1
-#define LOWWAIT 	2
+#define LOWWAIT	2
 #define EMPTYWAIT	3
 
 
@@ -244,8 +244,9 @@ static void moxa_wait_finish(void __iomem *ofsAddr)
 
 static void moxafunc(void __iomem *ofsAddr, u16 cmd, u16 arg)
 {
-        unsigned long flags;
-        spin_lock_irqsave(&moxafunc_lock, flags);
+	unsigned long flags;
+
+	spin_lock_irqsave(&moxafunc_lock, flags);
 	writew(arg, ofsAddr + FuncArg);
 	writew(cmd, ofsAddr + FuncCode);
 	moxa_wait_finish(ofsAddr);
@@ -254,9 +255,10 @@ static void moxafunc(void __iomem *ofsAddr, u16 cmd, u16 arg)
 
 static int moxafuncret(void __iomem *ofsAddr, u16 cmd, u16 arg)
 {
-        unsigned long flags;
-        u16 ret;
-        spin_lock_irqsave(&moxafunc_lock, flags);
+	unsigned long flags;
+	u16 ret;
+
+	spin_lock_irqsave(&moxafunc_lock, flags);
 	writew(arg, ofsAddr + FuncArg);
 	writew(cmd, ofsAddr + FuncCode);
 	moxa_wait_finish(ofsAddr);
@@ -348,9 +350,9 @@ static int moxa_ioctl(struct tty_struct *tty,
 				memset(&tmp, 0, sizeof(tmp));
 				spin_lock_bh(&moxa_lock);
 				if (!moxa_boards[i].ready) {
-				        spin_unlock_bh(&moxa_lock);
+					spin_unlock_bh(&moxa_lock);
 					goto copy;
-                                }
+				}
 
 				status = MoxaPortLineStatus(p);
 				spin_unlock_bh(&moxa_lock);
@@ -1138,7 +1140,7 @@ module_exit(moxa_exit);
 static void moxa_shutdown(struct tty_port *port)
 {
 	struct moxa_port *ch = container_of(port, struct moxa_port, port);
-        MoxaPortDisable(ch);
+	MoxaPortDisable(ch);
 	MoxaPortFlushData(ch, 2);
 }
 
@@ -1260,7 +1262,7 @@ static int moxa_chars_in_buffer(struct tty_struct *tty)
 		 * Make it possible to wakeup anything waiting for output
 		 * in tty_ioctl.c, etc.
 		 */
-        	set_bit(EMPTYWAIT, &ch->statusflags);
+		set_bit(EMPTYWAIT, &ch->statusflags);
 	return chars;
 }
 
@@ -1361,8 +1363,8 @@ static void moxa_new_dcdstate(struct moxa_port *p, u8 dcd)
 
 	spin_lock_irqsave(&p->port.lock, flags);
 	if (dcd != p->DCDState) {
-        	p->DCDState = dcd;
-        	spin_unlock_irqrestore(&p->port.lock, flags);
+		p->DCDState = dcd;
+		spin_unlock_irqrestore(&p->port.lock, flags);
 		if (!dcd)
 			tty_port_tty_hangup(&p->port, true);
 	}
@@ -1496,7 +1498,7 @@ static void moxa_set_tty_param(struct tty_struct *tty, struct ktermios *old_term
 }
 
 /*****************************************************************************
- *	Driver level functions: 					     *
+ *	Driver level functions:					             *
  *****************************************************************************/
 
 static void MoxaPortFlushData(struct moxa_port *port, int mode)
@@ -2080,7 +2082,7 @@ static int moxa_set_serial_info(struct moxa_port *info,
 
 
 /*****************************************************************************
- *	Static local functions: 					     *
+ *	Static local functions:					             *
  *****************************************************************************/
 
 static void MoxaSetFifo(struct moxa_port *port, int enable)
diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index 8bc15cb67a58..3f800b35689e 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -1429,11 +1429,11 @@ static void __init mxser_normal_mode(int port)
 	outb(0x00, port + 4);
 }
 
-#define CHIP_SK 	0x01	/* Serial Data Clock  in Eprom */
-#define CHIP_DO 	0x02	/* Serial Data Output in Eprom */
-#define CHIP_CS 	0x04	/* Serial Chip Select in Eprom */
-#define CHIP_DI 	0x08	/* Serial Data Input  in Eprom */
-#define EN_CCMD 	0x000	/* Chip's command register     */
+#define CHIP_SK	0x01	/* Serial Data Clock  in Eprom */
+#define CHIP_DO	0x02	/* Serial Data Output in Eprom */
+#define CHIP_CS	0x04	/* Serial Chip Select in Eprom */
+#define CHIP_DI	0x08	/* Serial Data Input  in Eprom */
+#define EN_CCMD	0x000	/* Chip's command register     */
 #define EN0_RSARLO	0x008	/* Remote start address reg 0  */
 #define EN0_RSARHI	0x009	/* Remote start address reg 1  */
 #define EN0_RCNTLO	0x00A	/* Remote byte count reg WR    */
diff --git a/drivers/tty/n_hdlc.c b/drivers/tty/n_hdlc.c
index dabb391909aa..1f2e24424b44 100644
--- a/drivers/tty/n_hdlc.c
+++ b/drivers/tty/n_hdlc.c
@@ -382,10 +382,10 @@ static void n_hdlc_send_frames(struct n_hdlc *n_hdlc, struct tty_struct *tty)
 		printk("%s(%d)n_hdlc_send_frames() called\n",__FILE__,__LINE__);
  check_again:
 		
- 	spin_lock_irqsave(&n_hdlc->tx_buf_list.spinlock, flags);
+	spin_lock_irqsave(&n_hdlc->tx_buf_list.spinlock, flags);
 	if (n_hdlc->tbusy) {
 		n_hdlc->woke_up = 1;
- 		spin_unlock_irqrestore(&n_hdlc->tx_buf_list.spinlock, flags);
+		spin_unlock_irqrestore(&n_hdlc->tx_buf_list.spinlock, flags);
 		return;
 	}
 	n_hdlc->tbusy = 1;
@@ -447,7 +447,7 @@ static void n_hdlc_send_frames(struct n_hdlc *n_hdlc, struct tty_struct *tty)
 	n_hdlc->tbusy = 0;
 	spin_unlock_irqrestore(&n_hdlc->tx_buf_list.spinlock, flags); 
 	
-        if (n_hdlc->woke_up)
+	if (n_hdlc->woke_up)
 	  goto check_again;
 
 	if (debuglevel >= DEBUG_LEVEL_INFO)	
@@ -554,7 +554,7 @@ static void n_hdlc_tty_receive(struct tty_struct *tty, const __u8 *data,
  * @file - pointer to open file object
  * @buf - pointer to returned data buffer
  * @nr - size of returned data buffer
- * 	
+ *
  * Returns the number of bytes returned or error code.
  */
 static ssize_t n_hdlc_tty_read(struct tty_struct *tty, struct file *file,
@@ -638,7 +638,7 @@ static ssize_t n_hdlc_tty_read(struct tty_struct *tty, struct file *file,
  * @file - pointer to file object data
  * @data - pointer to transmit data (one frame)
  * @count - size of transmit frame in bytes
- * 		
+ *
  * Returns the number of bytes written (or error code).
  */
 static ssize_t n_hdlc_tty_write(struct tty_struct *tty, struct file *file,
diff --git a/drivers/tty/rocket.c b/drivers/tty/rocket.c
index b121d8f8f3d7..c123fdb7eed8 100644
--- a/drivers/tty/rocket.c
+++ b/drivers/tty/rocket.c
@@ -1253,7 +1253,7 @@ static int reset_rm2(struct r_port *info, void __user *arg)
 		reset = 1;
 
 	if (rcktpt_type[info->board] != ROCKET_TYPE_MODEMII &&
-            rcktpt_type[info->board] != ROCKET_TYPE_MODEMIII)
+	    rcktpt_type[info->board] != ROCKET_TYPE_MODEMIII)
 		return -EINVAL;
 
 	if (info->ctlp->BusType == isISA)
@@ -1619,8 +1619,8 @@ static int rp_write(struct tty_struct *tty,
 		set_bit((info->aiop * 8) + info->chan, (void *) &xmit_flags[info->board]);
 	
 end:
- 	if (info->xmit_cnt < WAKEUP_CHARS) {
- 		tty_wakeup(tty);
+	if (info->xmit_cnt < WAKEUP_CHARS) {
+		tty_wakeup(tty);
 #ifdef ROCKETPORT_HAVE_POLL_WAIT
 		wake_up_interruptible(&tty->poll_wait);
 #endif
@@ -2257,7 +2257,7 @@ static int __init init_ISA(int i)
 		rcktpt_io_addr[i] = 0;
 		return (0);
 	}
-  
+
 	rocketModel[i].startingPortNumber = nextLineNumber;
 
 	for (aiop = 0; aiop < num_aiops; aiop++) {
diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index 9db93f500b4e..bc4d2f9d3333 100644
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -648,7 +648,7 @@ int __serdev_device_driver_register(struct serdev_device_driver *sdrv, struct mo
 	sdrv->driver.owner = owner;
 
 	/* force drivers to async probe so I/O is possible in probe */
-        sdrv->driver.probe_type = PROBE_PREFER_ASYNCHRONOUS;
+	sdrv->driver.probe_type = PROBE_PREFER_ASYNCHRONOUS;
 
 	return driver_register(&sdrv->driver);
 }
diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index d31b975dd3fd..85f3f03603fd 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -243,9 +243,9 @@ static void dw8250_serial_out32be(struct uart_port *p, int offset, int value)
 
 static unsigned int dw8250_serial_in32be(struct uart_port *p, int offset)
 {
-       unsigned int value = ioread32be(p->membase + (offset << p->regshift));
+	unsigned int value = ioread32be(p->membase + (offset << p->regshift));
 
-       return dw8250_modify_msr(p, offset, value);
+	return dw8250_modify_msr(p, offset, value);
 }
 
 
diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index ebd33c0232e6..8a47ba2cfe54 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1822,11 +1822,11 @@ static int sbsa_uart_startup(struct uart_port *port)
 static void pl011_shutdown_channel(struct uart_amba_port *uap,
 					unsigned int lcrh)
 {
-      unsigned long val;
+	unsigned long val;
 
-      val = pl011_read(uap, lcrh);
-      val &= ~(UART01x_LCRH_BRK | UART01x_LCRH_FEN);
-      pl011_write(val, uap, lcrh);
+	val = pl011_read(uap, lcrh);
+	val &= ~(UART01x_LCRH_BRK | UART01x_LCRH_FEN);
+	pl011_write(val, uap, lcrh);
 }
 
 /*
diff --git a/drivers/tty/serial/cpm_uart/cpm_uart_core.c b/drivers/tty/serial/cpm_uart/cpm_uart_core.c
index 79ad30d34949..d61605fc9f6b 100644
--- a/drivers/tty/serial/cpm_uart/cpm_uart_core.c
+++ b/drivers/tty/serial/cpm_uart/cpm_uart_core.c
@@ -481,8 +481,8 @@ static void cpm_uart_shutdown(struct uart_port *port)
 }
 
 static void cpm_uart_set_termios(struct uart_port *port,
-                                 struct ktermios *termios,
-                                 struct ktermios *old)
+				 struct ktermios *termios,
+				 struct ktermios *old)
 {
 	int baud;
 	unsigned long flags;
@@ -1138,7 +1138,7 @@ static const struct uart_ops cpm_uart_pops = {
 struct uart_cpm_port cpm_uart_ports[UART_NR];
 
 static int cpm_uart_init_port(struct device_node *np,
-                              struct uart_cpm_port *pinfo)
+			      struct uart_cpm_port *pinfo)
 {
 	const u32 *data;
 	void __iomem *mem, *pram;
@@ -1451,7 +1451,7 @@ static struct platform_driver cpm_uart_driver = {
 	},
 	.probe = cpm_uart_probe,
 	.remove = cpm_uart_remove,
- };
+};
 
 static int __init cpm_uart_init(void)
 {
diff --git a/drivers/tty/serial/icom.c b/drivers/tty/serial/icom.c
index ad374f7c476d..001621aec4a0 100644
--- a/drivers/tty/serial/icom.c
+++ b/drivers/tty/serial/icom.c
@@ -1505,8 +1505,9 @@ static int icom_probe(struct pci_dev *dev,
 	}
 
 	pci_write_config_dword(dev, PCI_COMMAND,
-		command_reg | PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER
- 		| PCI_COMMAND_PARITY | PCI_COMMAND_SERR);
+			       command_reg | PCI_COMMAND_MEMORY |
+			       PCI_COMMAND_MASTER | PCI_COMMAND_PARITY |
+			       PCI_COMMAND_SERR);
 
 	if (ent->driver_data == ADAPTER_V1) {
 		pci_write_config_dword(dev, 0x44, 0x8300830A);
diff --git a/drivers/tty/serial/ip22zilog.c b/drivers/tty/serial/ip22zilog.c
index 8c810733df3d..05c835e08256 100644
--- a/drivers/tty/serial/ip22zilog.c
+++ b/drivers/tty/serial/ip22zilog.c
@@ -1091,7 +1091,7 @@ static void __init ip22zilog_prepare(void)
 		spin_lock_init(&ip22zilog_port_table[channel].port.lock);
 
 	ip22zilog_irq_chain = &ip22zilog_port_table[NUM_CHANNELS - 1];
-        up = &ip22zilog_port_table[0];
+	up = &ip22zilog_port_table[0];
 	for (channel = NUM_CHANNELS - 1 ; channel > 0; channel--)
 		up[channel].next = &up[channel - 1];
 	up[channel].next = NULL;
diff --git a/drivers/tty/serial/jsm/jsm_neo.c b/drivers/tty/serial/jsm/jsm_neo.c
index bf0e2a4cb0ce..50f805b9a1b1 100644
--- a/drivers/tty/serial/jsm/jsm_neo.c
+++ b/drivers/tty/serial/jsm/jsm_neo.c
@@ -29,7 +29,7 @@ static u32 jsm_offset_table[8] = { 0x01, 0x02, 0x04, 0x08, 0x10, 0x20, 0x40, 0x8
  */
 static inline void neo_pci_posting_flush(struct jsm_board *bd)
 {
-      readb(bd->re_map_membase + 0x8D);
+	readb(bd->re_map_membase + 0x8D);
 }
 
 static void neo_set_cts_flow_control(struct jsm_channel *ch)
diff --git a/drivers/tty/serial/mux.c b/drivers/tty/serial/mux.c
index 00ce31e8d19a..880d1b3127c2 100644
--- a/drivers/tty/serial/mux.c
+++ b/drivers/tty/serial/mux.c
@@ -405,7 +405,7 @@ static void mux_console_write(struct console *co, const char *s, unsigned count)
 
 static int mux_console_setup(struct console *co, char *options)
 {
-        return 0;
+	return 0;
 }
 
 static struct console mux_console = {
@@ -457,7 +457,7 @@ static int __init mux_probe(struct parisc_device *dev)
 
 	dev_set_drvdata(&dev->dev, (void *)(long)port_count);
 	request_mem_region(dev->hpa.start + MUX_OFFSET,
-                           port_count * MUX_LINE_OFFSET, "Mux");
+			   port_count * MUX_LINE_OFFSET, "Mux");
 
 	if(!port_cnt) {
 		mux_driver.cons = MUX_CONSOLE;
@@ -576,7 +576,7 @@ static int __init mux_init(void)
 		mod_timer(&mux_timer, jiffies + MUX_POLL_DELAY);
 
 #ifdef CONFIG_SERIAL_MUX_CONSOLE
-	        register_console(&mux_console);
+		register_console(&mux_console);
 #endif
 	}
 
diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index 27235a526cce..c5869064fd99 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -1329,7 +1329,7 @@ static const struct uart_ops mxs_auart_ops = {
 	.shutdown       = mxs_auart_shutdown,
 	.set_termios    = mxs_auart_settermios,
 	.set_ldisc      = mxs_auart_set_ldisc,
-	.type	   	= mxs_auart_type,
+	.type		= mxs_auart_type,
 	.release_port   = mxs_auart_release_port,
 	.request_port   = mxs_auart_request_port,
 	.config_port    = mxs_auart_config_port,
diff --git a/drivers/tty/serial/pmac_zilog.c b/drivers/tty/serial/pmac_zilog.c
index a9d40988e1c8..a5558051de74 100644
--- a/drivers/tty/serial/pmac_zilog.c
+++ b/drivers/tty/serial/pmac_zilog.c
@@ -1845,7 +1845,7 @@ MODULE_DEVICE_TABLE (of, pmz_match);
 
 static struct macio_driver pmz_driver = {
 	.driver = {
-		.name 		= "pmac_zilog",
+		.name		= "pmac_zilog",
 		.owner		= THIS_MODULE,
 		.of_match_table	= pmz_match,
 	},
@@ -1894,7 +1894,7 @@ static int __init init_pmz(void)
 	if (rc) {
 		printk(KERN_ERR 
 			"pmac_zilog: Error registering serial device, disabling pmac_zilog.\n"
-		 	"pmac_zilog: Did another serial driver already claim the minors?\n"); 
+			"pmac_zilog: Did another serial driver already claim the minors?\n");
 		/* effectively "pmz_unprobe()" */
 		for (i=0; i < pmz_ports_count; i++)
 			pmz_dispose_port(&pmz_ports[i]);
diff --git a/drivers/tty/serial/pxa.c b/drivers/tty/serial/pxa.c
index 4932b674f7ef..dd102571a751 100644
--- a/drivers/tty/serial/pxa.c
+++ b/drivers/tty/serial/pxa.c
@@ -795,22 +795,22 @@ static struct uart_driver serial_pxa_reg = {
 #ifdef CONFIG_PM
 static int serial_pxa_suspend(struct device *dev)
 {
-        struct uart_pxa_port *sport = dev_get_drvdata(dev);
+	struct uart_pxa_port *sport = dev_get_drvdata(dev);
 
-        if (sport)
-                uart_suspend_port(&serial_pxa_reg, &sport->port);
+	if (sport)
+		uart_suspend_port(&serial_pxa_reg, &sport->port);
 
-        return 0;
+	return 0;
 }
 
 static int serial_pxa_resume(struct device *dev)
 {
-        struct uart_pxa_port *sport = dev_get_drvdata(dev);
+	struct uart_pxa_port *sport = dev_get_drvdata(dev);
 
-        if (sport)
-                uart_resume_port(&serial_pxa_reg, &sport->port);
+	if (sport)
+		uart_resume_port(&serial_pxa_reg, &sport->port);
 
-        return 0;
+	return 0;
 }
 
 static const struct dev_pm_ops serial_pxa_pm_ops = {
@@ -914,10 +914,10 @@ static int serial_pxa_probe(struct platform_device *dev)
 }
 
 static struct platform_driver serial_pxa_driver = {
-        .probe          = serial_pxa_probe,
+	.probe          = serial_pxa_probe,
 
 	.driver		= {
-	        .name	= "pxa2xx-uart",
+		.name	= "pxa2xx-uart",
 #ifdef CONFIG_PM
 		.pm	= &serial_pxa_pm_ops,
 #endif
diff --git a/drivers/tty/serial/serial_txx9.c b/drivers/tty/serial/serial_txx9.c
index 1b4008d022bf..33c630d0f1b2 100644
--- a/drivers/tty/serial/serial_txx9.c
+++ b/drivers/tty/serial/serial_txx9.c
@@ -1259,7 +1259,7 @@ static int __init serial_txx9_init(void)
 {
 	int ret;
 
- 	printk(KERN_INFO "%s version %s\n", serial_name, serial_version);
+	printk(KERN_INFO "%s version %s\n", serial_name, serial_version);
 
 	ret = uart_register_driver(&serial_txx9_reg);
 	if (ret)
diff --git a/drivers/tty/serial/sn_console.c b/drivers/tty/serial/sn_console.c
index fe9170731c16..457a062fffd8 100644
--- a/drivers/tty/serial/sn_console.c
+++ b/drivers/tty/serial/sn_console.c
@@ -454,31 +454,31 @@ sn_receive_chars(struct sn_cons_port *port, unsigned long flags)
 			break;
 		}
 #ifdef CONFIG_MAGIC_SYSRQ
-                if (sysrq_requested) {
-                        unsigned long sysrq_timeout = sysrq_requested + HZ*5;
-
-                        sysrq_requested = 0;
-                        if (ch && time_before(jiffies, sysrq_timeout)) {
-                                spin_unlock_irqrestore(&port->sc_port.lock, flags);
-                                handle_sysrq(ch);
-                                spin_lock_irqsave(&port->sc_port.lock, flags);
-                                /* ignore actual sysrq command char */
-                                continue;
-                        }
-                }
-                if (ch == *sysrq_serial_ptr) {
-                        if (!(*++sysrq_serial_ptr)) {
-                                sysrq_requested = jiffies;
-                                sysrq_serial_ptr = sysrq_serial_str;
-                        }
+		if (sysrq_requested) {
+			unsigned long sysrq_timeout = sysrq_requested + HZ*5;
+
+			sysrq_requested = 0;
+			if (ch && time_before(jiffies, sysrq_timeout)) {
+				spin_unlock_irqrestore(&port->sc_port.lock, flags);
+				handle_sysrq(ch);
+				spin_lock_irqsave(&port->sc_port.lock, flags);
+				/* ignore actual sysrq command char */
+				continue;
+			}
+		}
+		if (ch == *sysrq_serial_ptr) {
+			if (!(*++sysrq_serial_ptr)) {
+				sysrq_requested = jiffies;
+				sysrq_serial_ptr = sysrq_serial_str;
+			}
 			/*
 			 * ignore the whole sysrq string except for the
 			 * leading escape
 			 */
 			if (ch != '\e')
 				continue;
-                }
-                else
+		}
+		else
 			sysrq_serial_ptr = sysrq_serial_str;
 #endif /* CONFIG_MAGIC_SYSRQ */
 
diff --git a/drivers/tty/serial/sunsab.c b/drivers/tty/serial/sunsab.c
index 72131b5e132e..7744ed852d52 100644
--- a/drivers/tty/serial/sunsab.c
+++ b/drivers/tty/serial/sunsab.c
@@ -654,7 +654,7 @@ static void calc_ebrg(int baud, int *n_ret, int *m_ret)
 		*m_ret = 0;
 		return;
 	}
-     
+
 	/*
 	 * We scale numbers by 10 so that we get better accuracy
 	 * without having to use floating point.  Here we increment m
diff --git a/drivers/tty/serial/sunsu.c b/drivers/tty/serial/sunsu.c
index 6cf3e9b0728f..1a371c37a644 100644
--- a/drivers/tty/serial/sunsu.c
+++ b/drivers/tty/serial/sunsu.c
@@ -74,7 +74,7 @@ static const struct serial_uart_config uart_config[] = {
 	{ "16450",	1,	0 },
 	{ "16550",	1,	0 },
 	{ "16550A",	16,	UART_CLEAR_FIFO | UART_USE_FIFO },
-	{ "Cirrus",	1, 	0 },
+	{ "Cirrus",	1,	0 },
 	{ "ST16650",	1,	UART_CLEAR_FIFO | UART_STARTECH },
 	{ "ST16650V2",	32,	UART_CLEAR_FIFO | UART_USE_FIFO | UART_STARTECH },
 	{ "TI16750",	64,	UART_CLEAR_FIFO | UART_USE_FIFO },
@@ -1138,7 +1138,7 @@ static void sunsu_autoconfig(struct uart_sunsu_port *up)
 			 * mode if the UART_FCR7_64BYTE bit was set
 			 * while UART_LCR_DLAB was latched.
 			 */
- 			serial_outp(up, UART_FCR, UART_FCR_ENABLE_FIFO);
+			serial_outp(up, UART_FCR, UART_FCR_ENABLE_FIFO);
 			serial_outp(up, UART_LCR, 0);
 			serial_outp(up, UART_FCR,
 				    UART_FCR_ENABLE_FIFO | UART_FCR7_64BYTE);
diff --git a/drivers/tty/serial/sunzilog.c b/drivers/tty/serial/sunzilog.c
index bc7af8b08a72..cb0dbff46db0 100644
--- a/drivers/tty/serial/sunzilog.c
+++ b/drivers/tty/serial/sunzilog.c
@@ -394,7 +394,7 @@ sunzilog_receive_chars(struct uart_sunzilog_port *up,
 
 		if (up->port.ignore_status_mask == 0xff ||
 		    (r1 & up->port.ignore_status_mask) == 0) {
-		    	tty_insert_flip_char(port, ch, flag);
+			tty_insert_flip_char(port, ch, flag);
 		}
 		if (r1 & Rx_OVR)
 			tty_insert_flip_char(port, 0, TTY_OVERRUN);
diff --git a/drivers/tty/serial/ucc_uart.c b/drivers/tty/serial/ucc_uart.c
index 2b6376e6e5ad..11064dcd7826 100644
--- a/drivers/tty/serial/ucc_uart.c
+++ b/drivers/tty/serial/ucc_uart.c
@@ -39,7 +39,7 @@
  * but Soft-UART is a hack and we want to keep everything related to it in
  * this file.
  */
-#define UCC_SLOW_GUMR_H_SUART   	0x00004000      /* Soft-UART */
+#define UCC_SLOW_GUMR_H_SUART		0x00004000      /* Soft-UART */
 
 /*
  * soft_uart is 1 if we need to use Soft-UART mode
@@ -87,82 +87,82 @@ static int firmware_loaded;
 
 struct ucc_uart_pram {
 	struct ucc_slow_pram common;
-	u8 res1[8];     	/* reserved */
-	__be16 maxidl;  	/* Maximum idle chars */
-	__be16 idlc;    	/* temp idle counter */
-	__be16 brkcr;   	/* Break count register */
-	__be16 parec;   	/* receive parity error counter */
-	__be16 frmec;   	/* receive framing error counter */
-	__be16 nosec;   	/* receive noise counter */
-	__be16 brkec;   	/* receive break condition counter */
-	__be16 brkln;   	/* last received break length */
+	u8 res1[8];		/* reserved */
+	__be16 maxidl;		/* Maximum idle chars */
+	__be16 idlc;		/* temp idle counter */
+	__be16 brkcr;		/* Break count register */
+	__be16 parec;		/* receive parity error counter */
+	__be16 frmec;		/* receive framing error counter */
+	__be16 nosec;		/* receive noise counter */
+	__be16 brkec;		/* receive break condition counter */
+	__be16 brkln;		/* last received break length */
 	__be16 uaddr[2];	/* UART address character 1 & 2 */
-	__be16 rtemp;   	/* Temp storage */
-	__be16 toseq;   	/* Transmit out of sequence char */
+	__be16 rtemp;		/* Temp storage */
+	__be16 toseq;		/* Transmit out of sequence char */
 	__be16 cchars[8];       /* control characters 1-8 */
-	__be16 rccm;    	/* receive control character mask */
-	__be16 rccr;    	/* receive control character register */
-	__be16 rlbc;    	/* receive last break character */
-	__be16 res2;    	/* reserved */
-	__be32 res3;    	/* reserved, should be cleared */
+	__be16 rccm;		/* receive control character mask */
+	__be16 rccr;		/* receive control character register */
+	__be16 rlbc;		/* receive last break character */
+	__be16 res2;		/* reserved */
+	__be32 res3;		/* reserved, should be cleared */
 	u8 res4;		/* reserved, should be cleared */
-	u8 res5[3];     	/* reserved, should be cleared */
-	__be32 res6;    	/* reserved, should be cleared */
-	__be32 res7;    	/* reserved, should be cleared */
-	__be32 res8;    	/* reserved, should be cleared */
-	__be32 res9;    	/* reserved, should be cleared */
-	__be32 res10;   	/* reserved, should be cleared */
-	__be32 res11;   	/* reserved, should be cleared */
-	__be32 res12;   	/* reserved, should be cleared */
-	__be32 res13;   	/* reserved, should be cleared */
+	u8 res5[3];		/* reserved, should be cleared */
+	__be32 res6;		/* reserved, should be cleared */
+	__be32 res7;		/* reserved, should be cleared */
+	__be32 res8;		/* reserved, should be cleared */
+	__be32 res9;		/* reserved, should be cleared */
+	__be32 res10;		/* reserved, should be cleared */
+	__be32 res11;		/* reserved, should be cleared */
+	__be32 res12;		/* reserved, should be cleared */
+	__be32 res13;		/* reserved, should be cleared */
 /* The rest is for Soft-UART only */
-	__be16 supsmr;  	/* 0x90, Shadow UPSMR */
-	__be16 res92;   	/* 0x92, reserved, initialize to 0 */
+	__be16 supsmr;		/* 0x90, Shadow UPSMR */
+	__be16 res92;		/* 0x92, reserved, initialize to 0 */
 	__be32 rx_state;	/* 0x94, RX state, initialize to 0 */
-	__be32 rx_cnt;  	/* 0x98, RX count, initialize to 0 */
-	u8 rx_length;   	/* 0x9C, Char length, set to 1+CL+PEN+1+SL */
-	u8 rx_bitmark;  	/* 0x9D, reserved, initialize to 0 */
+	__be32 rx_cnt;		/* 0x98, RX count, initialize to 0 */
+	u8 rx_length;		/* 0x9C, Char length, set to 1+CL+PEN+1+SL */
+	u8 rx_bitmark;		/* 0x9D, reserved, initialize to 0 */
 	u8 rx_temp_dlst_qe;     /* 0x9E, reserved, initialize to 0 */
 	u8 res14[0xBC - 0x9F];  /* reserved */
 	__be32 dump_ptr;	/* 0xBC, Dump pointer */
 	__be32 rx_frame_rem;    /* 0xC0, reserved, initialize to 0 */
 	u8 rx_frame_rem_size;   /* 0xC4, reserved, initialize to 0 */
-	u8 tx_mode;     	/* 0xC5, mode, 0=AHDLC, 1=UART */
+	u8 tx_mode;		/* 0xC5, mode, 0=AHDLC, 1=UART */
 	__be16 tx_state;	/* 0xC6, TX state */
 	u8 res15[0xD0 - 0xC8];  /* reserved */
-	__be32 resD0;   	/* 0xD0, reserved, initialize to 0 */
-	u8 resD4;       	/* 0xD4, reserved, initialize to 0 */
-	__be16 resD5;   	/* 0xD5, reserved, initialize to 0 */
+	__be32 resD0;		/* 0xD0, reserved, initialize to 0 */
+	u8 resD4;		/* 0xD4, reserved, initialize to 0 */
+	__be16 resD5;		/* 0xD5, reserved, initialize to 0 */
 } __attribute__ ((packed));
 
 /* SUPSMR definitions, for Soft-UART only */
-#define UCC_UART_SUPSMR_SL      	0x8000
+#define UCC_UART_SUPSMR_SL		0x8000
 #define UCC_UART_SUPSMR_RPM_MASK	0x6000
-#define UCC_UART_SUPSMR_RPM_ODD 	0x0000
-#define UCC_UART_SUPSMR_RPM_LOW 	0x2000
+#define UCC_UART_SUPSMR_RPM_ODD	0x0000
+#define UCC_UART_SUPSMR_RPM_LOW	0x2000
 #define UCC_UART_SUPSMR_RPM_EVEN	0x4000
 #define UCC_UART_SUPSMR_RPM_HIGH	0x6000
-#define UCC_UART_SUPSMR_PEN     	0x1000
+#define UCC_UART_SUPSMR_PEN		0x1000
 #define UCC_UART_SUPSMR_TPM_MASK	0x0C00
-#define UCC_UART_SUPSMR_TPM_ODD 	0x0000
-#define UCC_UART_SUPSMR_TPM_LOW 	0x0400
+#define UCC_UART_SUPSMR_TPM_ODD	0x0000
+#define UCC_UART_SUPSMR_TPM_LOW	0x0400
 #define UCC_UART_SUPSMR_TPM_EVEN	0x0800
 #define UCC_UART_SUPSMR_TPM_HIGH	0x0C00
-#define UCC_UART_SUPSMR_FRZ     	0x0100
-#define UCC_UART_SUPSMR_UM_MASK 	0x00c0
+#define UCC_UART_SUPSMR_FRZ		0x0100
+#define UCC_UART_SUPSMR_UM_MASK	0x00c0
 #define UCC_UART_SUPSMR_UM_NORMAL       0x0000
 #define UCC_UART_SUPSMR_UM_MAN_MULTI    0x0040
 #define UCC_UART_SUPSMR_UM_AUTO_MULTI   0x00c0
-#define UCC_UART_SUPSMR_CL_MASK 	0x0030
-#define UCC_UART_SUPSMR_CL_8    	0x0030
-#define UCC_UART_SUPSMR_CL_7    	0x0020
-#define UCC_UART_SUPSMR_CL_6    	0x0010
-#define UCC_UART_SUPSMR_CL_5    	0x0000
+#define UCC_UART_SUPSMR_CL_MASK	0x0030
+#define UCC_UART_SUPSMR_CL_8		0x0030
+#define UCC_UART_SUPSMR_CL_7		0x0020
+#define UCC_UART_SUPSMR_CL_6		0x0010
+#define UCC_UART_SUPSMR_CL_5		0x0000
 
-#define UCC_UART_TX_STATE_AHDLC 	0x00
-#define UCC_UART_TX_STATE_UART  	0x01
-#define UCC_UART_TX_STATE_X1    	0x00
-#define UCC_UART_TX_STATE_X16   	0x80
+#define UCC_UART_TX_STATE_AHDLC	0x00
+#define UCC_UART_TX_STATE_UART		0x01
+#define UCC_UART_TX_STATE_X1		0x00
+#define UCC_UART_TX_STATE_X16		0x80
 
 #define UCC_UART_PRAM_ALIGNMENT 0x100
 
@@ -191,18 +191,18 @@ struct uart_qe_port {
 	struct qe_bd *tx_cur;
 	unsigned char *tx_buf;
 	unsigned char *rx_buf;
-	void *bd_virt;  	/* virtual address of the BD buffers */
+	void *bd_virt;		/* virtual address of the BD buffers */
 	dma_addr_t bd_dma_addr; /* bus address of the BD buffers */
 	unsigned int bd_size;   /* size of BD buffer space */
 };
 
 static struct uart_driver ucc_uart_driver = {
-	.owner  	= THIS_MODULE,
+	.owner		= THIS_MODULE,
 	.driver_name    = "ucc_uart",
 	.dev_name       = "ttyQE",
-	.major  	= SERIAL_QE_MAJOR,
-	.minor  	= SERIAL_QE_MINOR,
-	.nr     	= UCC_MAX_UART,
+	.major		= SERIAL_QE_MAJOR,
+	.minor		= SERIAL_QE_MINOR,
+	.nr		= UCC_MAX_UART,
 };
 
 /*
@@ -1094,7 +1094,7 @@ static const struct uart_ops qe_uart_pops = {
 	.startup	= qe_uart_startup,
 	.shutdown       = qe_uart_shutdown,
 	.set_termios    = qe_uart_set_termios,
-	.type   	= qe_uart_type,
+	.type		= qe_uart_type,
 	.release_port   = qe_uart_release_port,
 	.request_port   = qe_uart_request_port,
 	.config_port    = qe_uart_config_port,
@@ -1111,16 +1111,16 @@ static const struct uart_ops qe_uart_pops = {
  *
  * The new way is:
  *
- *      	cpu@0 {
- *      		compatible = "PowerPC,8323";
- *      		device_type = "cpu";
- *      		...
+ *		cpu@0 {
+ *			compatible = "PowerPC,8323";
+ *			device_type = "cpu";
+ *			...
  *
  *
  * The old way is:
- *      	 PowerPC,8323@0 {
- *      		device_type = "cpu";
- *      		...
+ *		 PowerPC,8323@0 {
+ *			device_type = "cpu";
+ *			...
  *
  * This code first checks the new way, and then the old way.
  */
@@ -1488,8 +1488,8 @@ static struct platform_driver ucc_uart_of_driver = {
 		.name = "ucc_uart",
 		.of_match_table    = ucc_uart_match,
 	},
-	.probe  	= ucc_uart_probe,
-	.remove 	= ucc_uart_remove,
+	.probe	= ucc_uart_probe,
+	.remove	= ucc_uart_remove,
 };
 
 static int __init ucc_uart_init(void)
diff --git a/drivers/tty/serial/vr41xx_siu.c b/drivers/tty/serial/vr41xx_siu.c
index 6d106e33f842..277301e9ef77 100644
--- a/drivers/tty/serial/vr41xx_siu.c
+++ b/drivers/tty/serial/vr41xx_siu.c
@@ -500,7 +500,7 @@ static void siu_shutdown(struct uart_port *port)
 }
 
 static void siu_set_termios(struct uart_port *port, struct ktermios *new,
-                            struct ktermios *old)
+			    struct ktermios *old)
 {
 	tcflag_t c_cflag, c_iflag;
 	uint8_t lcr, fcr, ier;
diff --git a/drivers/tty/serial/zs.c b/drivers/tty/serial/zs.c
index b03d3e458ea2..120da605d0df 100644
--- a/drivers/tty/serial/zs.c
+++ b/drivers/tty/serial/zs.c
@@ -98,7 +98,7 @@ static char zs_version[] __initdata = "0.10";
 #define ZS_CHAN_IO_STRIDE 4		/* Register alignment.  */
 #define ZS_CHAN_IO_OFFSET 1		/* The SCC resides on the high byte
 					   of the 16-bit IOBUS.  */
-#define ZS_CLOCK        7372800 	/* Z85C30 PCLK input clock rate.  */
+#define ZS_CLOCK        7372800	/* Z85C30 PCLK input clock rate.  */
 
 #define to_zport(uport) container_of(uport, struct zs_port, port)
 
@@ -299,11 +299,11 @@ static void load_zsregs(struct zs_port *zport, u8 *regs, int irq)
  * zs_tx_empty() -- get the transmitter empty status
  *
  * Purpose: Let user call ioctl() to get info when the UART physically
- * 	    is emptied.  On bus types like RS485, the transmitter must
- * 	    release the bus after transmitting.  This must be done when
- * 	    the transmit shift register is empty, not be done when the
- * 	    transmit holding register is empty.  This functionality
- * 	    allows an RS485 driver to be written in user space.
+ *	    is emptied.  On bus types like RS485, the transmitter must
+ *	    release the bus after transmitting.  This must be done when
+ *	    the transmit shift register is empty, not be done when the
+ *	    transmit holding register is empty.  This functionality
+ *	    allows an RS485 driver to be written in user space.
  */
 static unsigned int zs_tx_empty(struct uart_port *uport)
 {
diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index 06ed20dd01ba..c87cee67fc15 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -512,22 +512,22 @@ static int sysrq_key_table_key2index(int key)
  */
 struct sysrq_key_op *__sysrq_get_key_op(int key)
 {
-        struct sysrq_key_op *op_p = NULL;
-        int i;
+	struct sysrq_key_op *op_p = NULL;
+	int i;
 
 	i = sysrq_key_table_key2index(key);
 	if (i != -1)
-	        op_p = sysrq_key_table[i];
+		op_p = sysrq_key_table[i];
 
-        return op_p;
+	return op_p;
 }
 
 static void __sysrq_put_key_op(int key, struct sysrq_key_op *op_p)
 {
-        int i = sysrq_key_table_key2index(key);
+	int i = sysrq_key_table_key2index(key);
 
-        if (i != -1)
-                sysrq_key_table[i] = op_p;
+	if (i != -1)
+		sysrq_key_table[i] = op_p;
 }
 
 void __handle_sysrq(int key, bool check_mask)
@@ -548,8 +548,8 @@ void __handle_sysrq(int key, bool check_mask)
 	console_loglevel = CONSOLE_LOGLEVEL_DEFAULT;
 	pr_info("SysRq : ");
 
-        op_p = __sysrq_get_key_op(key);
-        if (op_p) {
+	op_p = __sysrq_get_key_op(key);
+	if (op_p) {
 		/*
 		 * Should we check for enabled operations (/proc/sysrq-trigger
 		 * should not) and is the invoked operation enabled?
@@ -595,13 +595,13 @@ static int sysrq_reset_downtime_ms;
 
 /* Simple translation table for the SysRq keys */
 static const unsigned char sysrq_xlate[KEY_CNT] =
-        "\000\0331234567890-=\177\t"                    /* 0x00 - 0x0f */
-        "qwertyuiop[]\r\000as"                          /* 0x10 - 0x1f */
-        "dfghjkl;'`\000\\zxcv"                          /* 0x20 - 0x2f */
-        "bnm,./\000*\000 \000\201\202\203\204\205"      /* 0x30 - 0x3f */
-        "\206\207\210\211\212\000\000789-456+1"         /* 0x40 - 0x4f */
-        "230\177\000\000\213\214\000\000\000\000\000\000\000\000\000\000" /* 0x50 - 0x5f */
-        "\r\000/";                                      /* 0x60 - 0x6f */
+	"\000\0331234567890-=\177\t"                    /* 0x00 - 0x0f */
+	"qwertyuiop[]\r\000as"                          /* 0x10 - 0x1f */
+	"dfghjkl;'`\000\\zxcv"                          /* 0x20 - 0x2f */
+	"bnm,./\000*\000 \000\201\202\203\204\205"      /* 0x30 - 0x3f */
+	"\206\207\210\211\212\000\000789-456+1"         /* 0x40 - 0x4f */
+	"230\177\000\000\213\214\000\000\000\000\000\000\000\000\000\000" /* 0x50 - 0x5f */
+	"\r\000/";                                      /* 0x60 - 0x6f */
 
 struct sysrq_state {
 	struct input_handle handle;
@@ -1055,7 +1055,7 @@ int sysrq_toggle_support(int enable_mask)
 }
 
 static int __sysrq_swap_key_ops(int key, struct sysrq_key_op *insert_op_p,
-                                struct sysrq_key_op *remove_op_p)
+				struct sysrq_key_op *remove_op_p)
 {
 	int retval;
 
diff --git a/drivers/tty/tty_baudrate.c b/drivers/tty/tty_baudrate.c
index 7576ceace571..ceee34760c62 100644
--- a/drivers/tty/tty_baudrate.c
+++ b/drivers/tty/tty_baudrate.c
@@ -150,7 +150,7 @@ void tty_termios_encode_baud_rate(struct ktermios *termios,
 	int iclose = ibaud/50, oclose = obaud/50;
 	int ibinput = 0;
 
-	if (obaud == 0)			/* CD dropped 		  */
+	if (obaud == 0)			/* CD dropped */
 		ibaud = 0;		/* Clear ibaud to be sure */
 
 	termios->c_ispeed = ibaud;
diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 252eef2c32f9..df94cdbe0096 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -33,7 +33,7 @@
  *	-- Nick Holloway <alfie@dcs.warwick.ac.uk>, 27th May 1993.
  *
  * Rewrote canonical mode and added more termios flags.
- * 	-- julian@uhunix.uhcc.hawaii.edu (J. Cowley), 13Jan94
+ *	-- julian@uhunix.uhcc.hawaii.edu (J. Cowley), 13Jan94
  *
  * Reorganized FASYNC support so mouse code can share it.
  *	-- ctm@ardi.com, 9Sep95
@@ -1023,7 +1023,7 @@ static ssize_t tty_write(struct file *file, const char __user *buf,
 						size_t count, loff_t *ppos)
 {
 	struct tty_struct *tty = file_tty(file);
- 	struct tty_ldisc *ld;
+	struct tty_ldisc *ld;
 	ssize_t ret;
 
 	if (tty_paranoia_check(tty, file_inode(file), "tty_write"))
@@ -1244,8 +1244,8 @@ static void tty_driver_remove_tty(struct tty_driver *driver, struct tty_struct *
 }
 
 /*
- * 	tty_reopen()	- fast re-open of an open tty
- * 	@tty	- the tty to open
+ *	tty_reopen()	- fast re-open of an open tty
+ *	@tty	- the tty to open
  *
  *	Return 0 on success, -errno on error.
  *	Re-opens on master ptys are not allowed and return -EIO.
@@ -1811,8 +1811,8 @@ static struct tty_struct *tty_open_current_tty(dev_t device, struct file *filp)
  *	@index: index for the device in the @return driver
  *	@return: driver for this inode (with increased refcount)
  *
- * 	If @return is not erroneous, the caller is responsible to decrement the
- * 	refcount by tty_driver_kref_put.
+ *	If @return is not erroneous, the caller is responsible to decrement the
+ *	refcount by tty_driver_kref_put.
  *
  *	Locking: tty_mutex protects get_tty_driver
  */
@@ -2624,7 +2624,7 @@ long tty_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	case TIOCGICOUNT:
 		retval = tty_tiocgicount(tty, p);
 		/* For the moment allow fall through to the old method */
-        	if (retval != -EINVAL)
+		if (retval != -EINVAL)
 			return retval;
 		break;
 	case TCFLSH:
@@ -3013,11 +3013,11 @@ struct device *tty_register_device_attr(struct tty_driver *driver,
 EXPORT_SYMBOL_GPL(tty_register_device_attr);
 
 /**
- * 	tty_unregister_device - unregister a tty device
- * 	@driver: the tty driver that describes the tty device
- * 	@index: the index in the tty driver for this tty device
+ *	tty_unregister_device - unregister a tty device
+ *	@driver: the tty driver that describes the tty device
+ *	@index: the index in the tty driver for this tty device
  *
- * 	If a tty device is registered with a call to tty_register_device() then
+ *	If a tty device is registered with a call to tty_register_device() then
  *	this function must be called when the tty device is gone.
  *
  *	Locking: ??
diff --git a/drivers/tty/tty_ioctl.c b/drivers/tty/tty_ioctl.c
index d99fec44036c..f9bcae2b7e36 100644
--- a/drivers/tty/tty_ioctl.c
+++ b/drivers/tty/tty_ioctl.c
@@ -72,7 +72,7 @@ EXPORT_SYMBOL(tty_chars_in_buffer);
  *	the number of bytes written. If no method is provided 2K is always
  *	returned and data may be lost as there will be no flow control.
  */
- 
+
 int tty_write_room(struct tty_struct *tty)
 {
 	if (tty->ops->write_room)
diff --git a/drivers/tty/tty_jobctrl.c b/drivers/tty/tty_jobctrl.c
index c4ecd66fafef..6155cc7b3f56 100644
--- a/drivers/tty/tty_jobctrl.c
+++ b/drivers/tty/tty_jobctrl.c
@@ -238,10 +238,10 @@ int tty_signal_session_leader(struct tty_struct *tty, int exit_session)
  *	it wants to disassociate itself from its controlling tty.
  *
  *	It performs the following functions:
- * 	(1)  Sends a SIGHUP and SIGCONT to the foreground process group
- * 	(2)  Clears the tty from being controlling the session
- * 	(3)  Clears the controlling tty for all processes in the
- * 		session group.
+ *	(1)  Sends a SIGHUP and SIGCONT to the foreground process group
+ *	(2)  Clears the tty from being controlling the session
+ *	(3)  Clears the controlling tty for all processes in the
+ *		session group.
  *
  *	The argument on_exit is set to 1 if called when a process is
  *	exiting; it is 0 if called by the ioctl TIOCNOTTY.
diff --git a/drivers/tty/vt/consolemap.c b/drivers/tty/vt/consolemap.c
index 7c7ada0b3ea0..97d02684b922 100644
--- a/drivers/tty/vt/consolemap.c
+++ b/drivers/tty/vt/consolemap.c
@@ -187,7 +187,7 @@ static unsigned short translations[][256] = {
 static int inv_translate[MAX_NR_CONSOLES];
 
 struct uni_pagedir {
-	u16 		**uni_pgdir[32];
+	u16		**uni_pgdir[32];
 	unsigned long	refcount;
 	unsigned long	sum;
 	unsigned char	*inverse_translations[4];
@@ -215,7 +215,7 @@ static void set_inverse_transl(struct vc_data *conp, struct uni_pagedir *p, int
 		glyph = conv_uni_to_pc(conp, t[j]);
 		if (glyph >= 0 && glyph < MAX_GLYPH && q[glyph] < 32) {
 			/* prefer '-' above SHY etc. */
-		  	q[glyph] = j;
+			q[glyph] = j;
 		}
 	}
 }
@@ -249,7 +249,7 @@ static void set_inverse_trans_unicode(struct vc_data *conp,
 				glyph = p2[k];
 				if (glyph >= 0 && glyph < MAX_GLYPH
 					       && q[glyph] < 32)
-		  			q[glyph] = (i << 11) + (j << 6) + k;
+					q[glyph] = (i << 11) + (j << 6) + k;
 			}
 		}
 	}
diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index 88312c6c92cc..214ad559fd2d 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -1110,8 +1110,9 @@ static unsigned char getledstate(void)
 
 void setledstate(struct kbd_struct *kb, unsigned int led)
 {
-        unsigned long flags;
-        spin_lock_irqsave(&led_lock, flags);
+	unsigned long flags;
+
+	spin_lock_irqsave(&led_lock, flags);
 	if (!(led & ~7)) {
 		ledioctl = led;
 		kb->ledmode = LED_SHOW_IOCTL;
@@ -2047,7 +2048,7 @@ int vt_do_kdgkb_ioctl(int cmd, struct kbsentry __user *user_kdgkb, int perm)
 			fj = first_free;
 
 		delta = (q ? -strlen(q) : 1) + strlen(kbs->kb_string);
-		if (delta <= funcbufleft) { 	/* it fits in current buf */
+		if (delta <= funcbufleft) {	/* it fits in current buf */
 		    if (j < MAX_NR_FUNC) {
 			memmove(fj + delta, fj, first_free - fj);
 			for (k = j; k < MAX_NR_FUNC; k++)
@@ -2099,16 +2100,16 @@ int vt_do_kdgkb_ioctl(int cmd, struct kbsentry __user *user_kdgkb, int perm)
 int vt_do_kdskled(int console, int cmd, unsigned long arg, int perm)
 {
 	struct kbd_struct *kb = kbd_table + console;
-        unsigned long flags;
+	unsigned long flags;
 	unsigned char ucval;
 
-        switch(cmd) {
+	switch(cmd) {
 	/* the ioctls below read/set the flags usually shown in the leds */
 	/* don't use them - they will go away without warning */
 	case KDGKBLED:
-                spin_lock_irqsave(&kbd_event_lock, flags);
+		spin_lock_irqsave(&kbd_event_lock, flags);
 		ucval = kb->ledflagstate | (kb->default_ledflagstate << 4);
-                spin_unlock_irqrestore(&kbd_event_lock, flags);
+		spin_unlock_irqrestore(&kbd_event_lock, flags);
 		return put_user(ucval, (char __user *)arg);
 
 	case KDSKBLED:
@@ -2116,11 +2117,11 @@ int vt_do_kdskled(int console, int cmd, unsigned long arg, int perm)
 			return -EPERM;
 		if (arg & ~0x77)
 			return -EINVAL;
-                spin_lock_irqsave(&led_lock, flags);
+		spin_lock_irqsave(&led_lock, flags);
 		kb->ledflagstate = (arg & 7);
 		kb->default_ledflagstate = ((arg >> 4) & 7);
 		set_leds();
-                spin_unlock_irqrestore(&led_lock, flags);
+		spin_unlock_irqrestore(&led_lock, flags);
 		return 0;
 
 	/* the ioctls below only set the lights, not the functions */
@@ -2134,8 +2135,8 @@ int vt_do_kdskled(int console, int cmd, unsigned long arg, int perm)
 			return -EPERM;
 		setledstate(kb, arg);
 		return 0;
-        }
-        return -ENOIOCTLCMD;
+	}
+	return -ENOIOCTLCMD;
 }
 
 int vt_do_kdgkbmode(int console)
@@ -2165,7 +2166,7 @@ int vt_do_kdgkbmode(int console)
 int vt_do_kdgkbmeta(int console)
 {
 	struct kbd_struct *kb = kbd_table + console;
-        /* Again a spot read so no locking */
+	/* Again a spot read so no locking */
 	return vc_kbd_mode(kb, VC_META) ? K_ESCPREFIX : K_METABIT;
 }
 
@@ -2192,8 +2193,8 @@ void vt_reset_unicode(int console)
  */
 int vt_get_shift_state(void)
 {
-        /* Don't lock as this is a transient report */
-        return shift_state;
+	/* Don't lock as this is a transient report */
+	return shift_state;
 }
 
 /**
diff --git a/drivers/tty/vt/selection.c b/drivers/tty/vt/selection.c
index 07496c711d7d..75aa58ea79b6 100644
--- a/drivers/tty/vt/selection.c
+++ b/drivers/tty/vt/selection.c
@@ -37,7 +37,7 @@ extern void poke_blanked_console(void);
 /* Use a dynamic buffer, instead of static (Dec 1994) */
 struct vc_data *sel_cons;		/* must not be deallocated */
 static int use_unicode;
-static volatile int sel_start = -1; 	/* cleared by clear_selection */
+static volatile int sel_start = -1;	/* cleared by clear_selection */
 static int sel_end;
 static int sel_buffer_lth;
 static char *sel_buffer;
@@ -86,10 +86,10 @@ void clear_selection(void)
  * 128 bits. Locked by the console lock.
  */
 static u32 inwordLut[]={
-  0x00000000, /* control chars     */
-  0x03FFE000, /* digits and "-./"  */
-  0x87FFFFFE, /* uppercase and '_' */
-  0x07FFFFFE, /* lowercase         */
+	0x00000000, /* control chars     */
+	0x03FFE000, /* digits and "-./"  */
+	0x87FFFFFE, /* uppercase and '_' */
+	0x07FFFFFE, /* lowercase         */
 };
 
 static inline int inword(const u32 c)
@@ -154,7 +154,7 @@ static int store_utf8(u32 c, char *p)
 }
 
 /**
- *	set_selection		- 	set the current selection.
+ *	set_selection		-	set the current selection.
  *	@sel: user selection info
  *	@tty: the console tty
  *
diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 5f1183b0b89d..94131c746ef7 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -700,7 +700,7 @@ void update_region(struct vc_data *vc, unsigned long start, int count)
 /* Structure of attributes is hardware-dependent */
 
 static u8 build_attr(struct vc_data *vc, u8 _color, u8 _intensity, u8 _blink,
-    u8 _underline, u8 _reverse, u8 _italic)
+		     u8 _underline, u8 _reverse, u8 _italic)
 {
 	if (vc->vc_sw->con_build_attr)
 		return vc->vc_sw->con_build_attr(vc, _color, _intensity,
@@ -1399,7 +1399,7 @@ static void gotoxy(struct vc_data *vc, int new_x, int new_y)
 			vc->vc_x = new_x;
 	}
 
- 	if (vc->vc_decom) {
+	if (vc->vc_decom) {
 		min_y = vc->vc_top;
 		max_y = vc->vc_bottom;
 	} else {
@@ -1436,13 +1436,13 @@ void scrollfront(struct vc_data *vc, int lines)
 
 static void lf(struct vc_data *vc)
 {
-    	/* don't scroll if above bottom of scrolling region, or
+	/* don't scroll if above bottom of scrolling region, or
 	 * if below scrolling region
 	 */
-    	if (vc->vc_y + 1 == vc->vc_bottom)
+	if (vc->vc_y + 1 == vc->vc_bottom)
 		con_scroll(vc, vc->vc_top, vc->vc_bottom, SM_UP, 1);
 	else if (vc->vc_y < vc->vc_rows - 1) {
-	    	vc->vc_y++;
+		vc->vc_y++;
 		vc->vc_pos += vc->vc_size_row;
 	}
 	vc->vc_need_wrap = 0;
@@ -1451,7 +1451,7 @@ static void lf(struct vc_data *vc)
 
 static void ri(struct vc_data *vc)
 {
-    	/* don't scroll if below top of scrolling region, or
+	/* don't scroll if below top of scrolling region, or
 	 * if above scrolling region
 	 */
 	if (vc->vc_y == vc->vc_top)
@@ -2653,17 +2653,17 @@ static int do_con_write(struct tty_struct *tty, const unsigned char *buf, int co
 					&param) == NOTIFY_STOP)
 			continue;
 
-                /* If the original code was a control character we
-                 * only allow a glyph to be displayed if the code is
-                 * not normally used (such as for cursor movement) or
-                 * if the disp_ctrl mode has been explicitly enabled.
-                 * Certain characters (as given by the CTRL_ALWAYS
-                 * bitmap) are always displayed as control characters,
-                 * as the console would be pretty useless without
-                 * them; to display an arbitrary font position use the
-                 * direct-to-font zone in UTF-8 mode.
-                 */
-                ok = tc && (c >= 32 ||
+		/* If the original code was a control character we
+		 * only allow a glyph to be displayed if the code is
+		 * not normally used (such as for cursor movement) or
+		 * if the disp_ctrl mode has been explicitly enabled.
+		 * Certain characters (as given by the CTRL_ALWAYS
+		 * bitmap) are always displayed as control characters,
+		 * as the console would be pretty useless without
+		 * them; to display an arbitrary font position use the
+		 * direct-to-font zone in UTF-8 mode.
+		 */
+		ok = tc && (c >= 32 ||
 			    !(vc->vc_disp_ctrl ? (CTRL_ALWAYS >> c) & 1 :
 				  vc->vc_utf || ((CTRL_ACTION >> c) & 1)))
 			&& (c != 127 || vc->vc_disp_ctrl)
@@ -2847,7 +2847,7 @@ struct tty_driver *console_driver;
 /**
  * vt_kmsg_redirect() - Sets/gets the kernel message console
  * @new:	The new virtual terminal number or -1 if the console should stay
- * 		unchanged
+ *		unchanged
  *
  * By default, the kernel messages are always printed on the current virtual
  * console. However, the user may modify that default with the
@@ -3636,7 +3636,7 @@ static int vt_bind(struct con_driver *con)
 	const struct consw *defcsw = NULL, *csw = NULL;
 	int i, more = 1, first = -1, last = -1, deflt = 0;
 
- 	if (!con->con || !(con->flag & CON_DRIVER_FLAG_MODULE))
+	if (!con->con || !(con->flag & CON_DRIVER_FLAG_MODULE))
 		goto err;
 
 	csw = con->con;
@@ -3687,7 +3687,7 @@ static int vt_unbind(struct con_driver *con)
 	int i, more = 1, first = -1, last = -1, deflt = 0;
 	int ret;
 
- 	if (!con->con || !(con->flag & CON_DRIVER_FLAG_MODULE))
+	if (!con->con || !(con->flag & CON_DRIVER_FLAG_MODULE))
 		goto err;
 
 	csw = con->con;
diff --git a/drivers/tty/vt/vt_ioctl.c b/drivers/tty/vt/vt_ioctl.c
index 73cdc0d633dd..30e02ec5d6a0 100644
--- a/drivers/tty/vt/vt_ioctl.c
+++ b/drivers/tty/vt/vt_ioctl.c
@@ -230,7 +230,7 @@ do_fontx_ioctl(int cmd, struct consolefontdesc __user *user_cfd, int perm, struc
 
 	if (copy_from_user(&cfdarg, user_cfd, sizeof(struct consolefontdesc))) 
 		return -EFAULT;
- 	
+
 	switch (cmd) {
 	case PIO_FONTX:
 		if (!perm)
@@ -345,7 +345,7 @@ int vt_ioctl(struct tty_struct *tty,
 	console = vc->vc_num;
 
 
-	if (!vc_cons_allocated(console)) { 	/* impossible? */
+	if (!vc_cons_allocated(console)) {	/* impossible? */
 		ret = -ENOIOCTLCMD;
 		goto out;
 	}
@@ -358,7 +358,7 @@ int vt_ioctl(struct tty_struct *tty,
 	perm = 0;
 	if (current->signal->tty == tty || capable(CAP_SYS_TTY_CONFIG))
 		perm = 1;
- 
+
 	switch (cmd) {
 	case TIOCLINUX:
 		ret = tioclinux(tty, arg);
@@ -915,14 +915,14 @@ int vt_ioctl(struct tty_struct *tty,
 	}
 
 	case PIO_CMAP:
-                if (!perm)
+		if (!perm)
 			ret = -EPERM;
 		else
-	                ret = con_set_cmap(up);
+			ret = con_set_cmap(up);
 		break;
 
 	case GIO_CMAP:
-                ret = con_get_cmap(up);
+		ret = con_get_cmap(up);
 		break;
 
 	case PIO_FONTX:
@@ -1182,7 +1182,7 @@ long vt_compat_ioctl(struct tty_struct *tty,
 
 	console = vc->vc_num;
 
-	if (!vc_cons_allocated(console)) { 	/* impossible? */
+	if (!vc_cons_allocated(console)) {	/* impossible? */
 		ret = -ENOIOCTLCMD;
 		goto out;
 	}
-- 
2.17.1


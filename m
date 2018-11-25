Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 147D8C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 19:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B58972086E
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 19:47:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GD/o41/E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B58972086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbeKZGjj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 01:39:39 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33643 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbeKZGji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 01:39:38 -0500
Received: by mail-wm1-f68.google.com with SMTP id 79so15114308wmo.0
        for <linux-kernel@vger.kernel.org>; Sun, 25 Nov 2018 11:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0c/QWjjXCm7V0GcXWazQQo+4s/PtNOVld+RVj1jNBiM=;
        b=GD/o41/E05BW80DIZv/CwcuDYw+h+ho8og6HhIkBLUemc4DXP8pyQvsMDzRRj4GpZH
         rsLGKxVmbmU0pZ9FFW0W/XkMU4a9m0Vu97JCJPFPBwgn7ECDltc7/RJs4yr2NYzYLvG+
         F1sa/UCttU6W/vTUl4NbZyd8nOZi+wNjr4OUPDtBMOuAN2n/4H7KdhYUm9X9CXlL1Nv6
         3TelqJZqwJsxSSXq3qM2msam2Rv37tDFZdyzO1ENn7FHTs1tTtT0guUJkSBgcOsdrtvV
         BlwUDgL9V5sniaICoPwnQqjptBh/kLAJd3Ul8lnDF7N5maUJXOgfxYVw+P1q0SE7kD+X
         qftA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0c/QWjjXCm7V0GcXWazQQo+4s/PtNOVld+RVj1jNBiM=;
        b=j0bDRZstjA/4Fq6JlqUdd/2tTP6CyLIxquWp8B/PuTh+/n8EDJyspPIOo8U3oL5WuM
         bSYz3MgDHIjz0XpcwHBlSJGkO2CV+9lMZyIWopenz+M3dIdTri1ETB/mxD1ehrn92+Px
         cbKX8/61wtAf4l3Ge8Vki1o2TP5KFJEn2doX5Bv+d9K2BJlo7JKWPli48QojUGY+JJ9h
         ERfIJu67WvXyQ6O43mQUBWW/RXcwqj/VV0lK/t01s42OlggBmTymVTbbIlG3hJKkZ6f5
         QoLMBUsyDJJu85k9nz3ErsdVuKjMAhGeuMphEt6tZRyBtUEjYYhXc+p1mMTaEPSWymb6
         FxLA==
X-Gm-Message-State: AGRZ1gKo+2/78z55AgcIzRhSciDUh6pn/JYAQ44SHW6T7wROkKjF6qEw
        de66WaxQdL/froBX1mCm57o=
X-Google-Smtp-Source: AJdET5dLIN99gYSpaT8a9APxkp3N5Oz8IcHq8EjVygLzst6nvmDYTTZmipDthaTPgLKGSAnsVHOwYg==
X-Received: by 2002:a1c:aacf:: with SMTP id t198-v6mr20468919wme.108.1543175267158;
        Sun, 25 Nov 2018 11:47:47 -0800 (PST)
Received: from localhost.localdomain (cpc101300-bagu16-2-0-cust362.1-3.cable.virginm.net. [86.21.41.107])
        by smtp.gmail.com with ESMTPSA id y138sm15744436wmc.16.2018.11.25.11.47.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Nov 2018 11:47:46 -0800 (PST)
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 6/6] char: lp: fix spacing style before open parenthesis
Date:   Sun, 25 Nov 2018 19:47:37 +0000
Message-Id: <20181125194737.5591-6-sudipm.mukherjee@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181125194737.5591-1-sudipm.mukherjee@gmail.com>
References: <20181125194737.5591-1-sudipm.mukherjee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the checkpatch warning:
"space prohibited between function name and open parenthesis"

Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---
 drivers/char/lp.c | 184 +++++++++++++++++++++++++++---------------------------
 1 file changed, 92 insertions(+), 92 deletions(-)

diff --git a/drivers/char/lp.c b/drivers/char/lp.c
index 017ea457a9d7..e0a92d764eee 100644
--- a/drivers/char/lp.c
+++ b/drivers/char/lp.c
@@ -166,7 +166,7 @@ static struct parport *console_registered;
 static void lp_claim_parport_or_block(struct lp_struct *this_lp)
 {
 	if (!test_and_set_bit(LP_PARPORT_CLAIMED, &this_lp->bits)) {
-		parport_claim_or_block (this_lp->dev);
+		parport_claim_or_block(this_lp->dev);
 	}
 }
 
@@ -174,7 +174,7 @@ static void lp_claim_parport_or_block(struct lp_struct *this_lp)
 static void lp_release_parport(struct lp_struct *this_lp)
 {
 	if (test_and_clear_bit(LP_PARPORT_CLAIMED, &this_lp->bits)) {
-		parport_release (this_lp->dev);
+		parport_release(this_lp->dev);
 	}
 }
 
@@ -194,9 +194,9 @@ static int lp_preempt(void *handle)
  */
 static int lp_negotiate(struct parport *port, int mode)
 {
-	if (parport_negotiate (port, mode) != 0) {
+	if (parport_negotiate(port, mode) != 0) {
 		mode = IEEE1284_MODE_COMPAT;
-		parport_negotiate (port, mode);
+		parport_negotiate(port, mode);
 	}
 
 	return mode;
@@ -205,16 +205,16 @@ static int lp_negotiate(struct parport *port, int mode)
 static int lp_reset(int minor)
 {
 	int retval;
-	lp_claim_parport_or_block (&lp_table[minor]);
+	lp_claim_parport_or_block(&lp_table[minor]);
 	w_ctr(minor, LP_PSELECP);
-	udelay (LP_DELAY);
+	udelay(LP_DELAY);
 	w_ctr(minor, LP_PSELECP | LP_PINITP);
 	retval = r_str(minor);
-	lp_release_parport (&lp_table[minor]);
+	lp_release_parport(&lp_table[minor]);
 	return retval;
 }
 
-static void lp_error (int minor)
+static void lp_error(int minor)
 {
 	DEFINE_WAIT(wait);
 	int polling;
@@ -224,14 +224,14 @@ static void lp_error (int minor)
 
 	polling = lp_table[minor].dev->port->irq == PARPORT_IRQ_NONE;
 	if (polling)
-		lp_release_parport (&lp_table[minor]);
+		lp_release_parport(&lp_table[minor]);
 	prepare_to_wait(&lp_table[minor].waitq, &wait, TASK_INTERRUPTIBLE);
 	schedule_timeout(LP_TIMEOUT_POLLED);
 	finish_wait(&lp_table[minor].waitq, &wait);
 	if (polling)
-		lp_claim_parport_or_block (&lp_table[minor]);
+		lp_claim_parport_or_block(&lp_table[minor]);
 	else
-		parport_yield_blocking (lp_table[minor].dev);
+		parport_yield_blocking(lp_table[minor].dev);
 }
 
 static int lp_check_status(int minor)
@@ -283,10 +283,10 @@ static int lp_wait_ready(int minor, int nonblock)
 	}
 
 	do {
-		error = lp_check_status (minor);
+		error = lp_check_status(minor);
 		if (error && (nonblock || (LP_F(minor) & LP_ABORT)))
 			break;
-		if (signal_pending (current)) {
+		if (signal_pending(current)) {
 			error = -EINTR;
 			break;
 		}
@@ -320,26 +320,26 @@ static ssize_t lp_write(struct file *file, const char __user *buf,
 	if (mutex_lock_interruptible(&lp_table[minor].port_mutex))
 		return -EINTR;
 
-	if (copy_from_user (kbuf, buf, copy_size)) {
+	if (copy_from_user(kbuf, buf, copy_size)) {
 		retv = -EFAULT;
 		goto out_unlock;
 	}
 
 	/* Claim Parport or sleep until it becomes available
 	 */
-	lp_claim_parport_or_block (&lp_table[minor]);
+	lp_claim_parport_or_block(&lp_table[minor]);
 	/* Go to the proper mode. */
-	lp_table[minor].current_mode = lp_negotiate (port,
-						     lp_table[minor].best_mode);
+	lp_table[minor].current_mode = lp_negotiate(port,
+						    lp_table[minor].best_mode);
 
-	parport_set_timeout (lp_table[minor].dev,
-			     (nonblock ? PARPORT_INACTIVITY_O_NONBLOCK
-			      : lp_table[minor].timeout));
+	parport_set_timeout(lp_table[minor].dev,
+			    (nonblock ? PARPORT_INACTIVITY_O_NONBLOCK
+			     : lp_table[minor].timeout));
 
-	if ((retv = lp_wait_ready (minor, nonblock)) == 0)
+	if ((retv = lp_wait_ready(minor, nonblock)) == 0)
 	do {
 		/* Write the data. */
-		written = parport_write (port, kbuf, copy_size);
+		written = parport_write(port, kbuf, copy_size);
 		if (written > 0) {
 			copy_size -= written;
 			count -= written;
@@ -347,7 +347,7 @@ static ssize_t lp_write(struct file *file, const char __user *buf,
 			retv += written;
 		}
 
-		if (signal_pending (current)) {
+		if (signal_pending(current)) {
 			if (retv == 0)
 				retv = -EINTR;
 
@@ -358,11 +358,11 @@ static ssize_t lp_write(struct file *file, const char __user *buf,
 			/* incomplete write -> check error ! */
 			int error;
 
-			parport_negotiate (lp_table[minor].dev->port,
-					   IEEE1284_MODE_COMPAT);
+			parport_negotiate(lp_table[minor].dev->port,
+					  IEEE1284_MODE_COMPAT);
 			lp_table[minor].current_mode = IEEE1284_MODE_COMPAT;
 
-			error = lp_wait_ready (minor, nonblock);
+			error = lp_wait_ready(minor, nonblock);
 
 			if (error) {
 				if (retv == 0)
@@ -374,13 +374,13 @@ static ssize_t lp_write(struct file *file, const char __user *buf,
 				break;
 			}
 
-			parport_yield_blocking (lp_table[minor].dev);
+			parport_yield_blocking(lp_table[minor].dev);
 			lp_table[minor].current_mode
-			  = lp_negotiate (port,
-					  lp_table[minor].best_mode);
+			  = lp_negotiate(port,
+					 lp_table[minor].best_mode);
 
 		} else if (need_resched())
-			schedule ();
+			schedule();
 
 		if (count) {
 			copy_size = count;
@@ -398,10 +398,10 @@ static ssize_t lp_write(struct file *file, const char __user *buf,
 	if (test_and_clear_bit(LP_PREEMPT_REQUEST,
 			       &lp_table[minor].bits)) {
 		printk(KERN_INFO "lp%d releasing parport\n", minor);
-		parport_negotiate (lp_table[minor].dev->port,
-				   IEEE1284_MODE_COMPAT);
+		parport_negotiate(lp_table[minor].dev->port,
+				  IEEE1284_MODE_COMPAT);
 		lp_table[minor].current_mode = IEEE1284_MODE_COMPAT;
-		lp_release_parport (&lp_table[minor]);
+		lp_release_parport(&lp_table[minor]);
 	}
 out_unlock:
 	mutex_unlock(&lp_table[minor].port_mutex);
@@ -429,21 +429,21 @@ static ssize_t lp_read(struct file *file, char __user *buf,
 	if (mutex_lock_interruptible(&lp_table[minor].port_mutex))
 		return -EINTR;
 
-	lp_claim_parport_or_block (&lp_table[minor]);
+	lp_claim_parport_or_block(&lp_table[minor]);
 
-	parport_set_timeout (lp_table[minor].dev,
-			     (nonblock ? PARPORT_INACTIVITY_O_NONBLOCK
-			      : lp_table[minor].timeout));
+	parport_set_timeout(lp_table[minor].dev,
+			    (nonblock ? PARPORT_INACTIVITY_O_NONBLOCK
+			     : lp_table[minor].timeout));
 
-	parport_negotiate (lp_table[minor].dev->port, IEEE1284_MODE_COMPAT);
-	if (parport_negotiate (lp_table[minor].dev->port,
-			       IEEE1284_MODE_NIBBLE)) {
+	parport_negotiate(lp_table[minor].dev->port, IEEE1284_MODE_COMPAT);
+	if (parport_negotiate(lp_table[minor].dev->port,
+			      IEEE1284_MODE_NIBBLE)) {
 		retval = -EIO;
 		goto out;
 	}
 
 	while (retval == 0) {
-		retval = parport_read (port, kbuf, count);
+		retval = parport_read(port, kbuf, count);
 
 		if (retval > 0)
 			break;
@@ -456,11 +456,11 @@ static ssize_t lp_read(struct file *file, char __user *buf,
 		/* Wait for data. */
 
 		if (lp_table[minor].dev->port->irq == PARPORT_IRQ_NONE) {
-			parport_negotiate (lp_table[minor].dev->port,
-					   IEEE1284_MODE_COMPAT);
-			lp_error (minor);
-			if (parport_negotiate (lp_table[minor].dev->port,
-					       IEEE1284_MODE_NIBBLE)) {
+			parport_negotiate(lp_table[minor].dev->port,
+					  IEEE1284_MODE_COMPAT);
+			lp_error(minor);
+			if (parport_negotiate(lp_table[minor].dev->port,
+					      IEEE1284_MODE_NIBBLE)) {
 				retval = -EIO;
 				goto out;
 			}
@@ -470,18 +470,18 @@ static ssize_t lp_read(struct file *file, char __user *buf,
 			finish_wait(&lp_table[minor].waitq, &wait);
 		}
 
-		if (signal_pending (current)) {
+		if (signal_pending(current)) {
 			retval = -ERESTARTSYS;
 			break;
 		}
 
-		cond_resched ();
+		cond_resched();
 	}
-	parport_negotiate (lp_table[minor].dev->port, IEEE1284_MODE_COMPAT);
+	parport_negotiate(lp_table[minor].dev->port, IEEE1284_MODE_COMPAT);
  out:
-	lp_release_parport (&lp_table[minor]);
+	lp_release_parport(&lp_table[minor]);
 
-	if (retval > 0 && copy_to_user (buf, kbuf, retval))
+	if (retval > 0 && copy_to_user(buf, kbuf, retval))
 		retval = -EFAULT;
 
 	mutex_unlock(&lp_table[minor].port_mutex);
@@ -516,9 +516,9 @@ static int lp_open(struct inode *inode, struct file *file)
 	   should most likely only ever be used by the tunelp application. */
 	if ((LP_F(minor) & LP_ABORTOPEN) && !(file->f_flags & O_NONBLOCK)) {
 		int status;
-		lp_claim_parport_or_block (&lp_table[minor]);
+		lp_claim_parport_or_block(&lp_table[minor]);
 		status = r_str(minor);
-		lp_release_parport (&lp_table[minor]);
+		lp_release_parport(&lp_table[minor]);
 		if (status & LP_POUTPA) {
 			printk(KERN_INFO "lp%d out of paper\n", minor);
 			LP_F(minor) &= ~LP_BUSY;
@@ -543,18 +543,18 @@ static int lp_open(struct inode *inode, struct file *file)
 		goto out;
 	}
 	/* Determine if the peripheral supports ECP mode */
-	lp_claim_parport_or_block (&lp_table[minor]);
+	lp_claim_parport_or_block(&lp_table[minor]);
 	if ( (lp_table[minor].dev->port->modes & PARPORT_MODE_ECP) &&
-	     !parport_negotiate (lp_table[minor].dev->port,
+	     !parport_negotiate(lp_table[minor].dev->port,
 				 IEEE1284_MODE_ECP)) {
-		printk (KERN_INFO "lp%d: ECP mode\n", minor);
+		printk(KERN_INFO "lp%d: ECP mode\n", minor);
 		lp_table[minor].best_mode = IEEE1284_MODE_ECP;
 	} else {
 		lp_table[minor].best_mode = IEEE1284_MODE_COMPAT;
 	}
 	/* Leave peripheral in compatibility mode */
-	parport_negotiate (lp_table[minor].dev->port, IEEE1284_MODE_COMPAT);
-	lp_release_parport (&lp_table[minor]);
+	parport_negotiate(lp_table[minor].dev->port, IEEE1284_MODE_COMPAT);
+	lp_release_parport(&lp_table[minor]);
 	lp_table[minor].current_mode = IEEE1284_MODE_COMPAT;
 out:
 	mutex_unlock(&lp_mutex);
@@ -565,10 +565,10 @@ static int lp_release(struct inode *inode, struct file *file)
 {
 	unsigned int minor = iminor(inode);
 
-	lp_claim_parport_or_block (&lp_table[minor]);
-	parport_negotiate (lp_table[minor].dev->port, IEEE1284_MODE_COMPAT);
+	lp_claim_parport_or_block(&lp_table[minor]);
+	parport_negotiate(lp_table[minor].dev->port, IEEE1284_MODE_COMPAT);
 	lp_table[minor].current_mode = IEEE1284_MODE_COMPAT;
-	lp_release_parport (&lp_table[minor]);
+	lp_release_parport(&lp_table[minor]);
 	kfree(lp_table[minor].lp_buffer);
 	lp_table[minor].lp_buffer = NULL;
 	LP_F(minor) &= ~LP_BUSY;
@@ -629,9 +629,9 @@ static int lp_do_ioctl(unsigned int minor, unsigned int cmd,
 		case LPGETSTATUS:
 			if (mutex_lock_interruptible(&lp_table[minor].port_mutex))
 				return -EINTR;
-			lp_claim_parport_or_block (&lp_table[minor]);
+			lp_claim_parport_or_block(&lp_table[minor]);
 			status = r_str(minor);
-			lp_release_parport (&lp_table[minor]);
+			lp_release_parport(&lp_table[minor]);
 			mutex_unlock(&lp_table[minor].port_mutex);
 
 			if (copy_to_user(argp, &status, sizeof(int)))
@@ -804,31 +804,31 @@ static const struct file_operations lp_fops = {
 
 /* The console must be locked when we get here. */
 
-static void lp_console_write (struct console *co, const char *s,
-			      unsigned count)
+static void lp_console_write(struct console *co, const char *s,
+			     unsigned count)
 {
 	struct pardevice *dev = lp_table[CONSOLE_LP].dev;
 	struct parport *port = dev->port;
 	ssize_t written;
 
-	if (parport_claim (dev))
+	if (parport_claim(dev))
 		/* Nothing we can do. */
 		return;
 
-	parport_set_timeout (dev, 0);
+	parport_set_timeout(dev, 0);
 
 	/* Go to compatibility mode. */
-	parport_negotiate (port, IEEE1284_MODE_COMPAT);
+	parport_negotiate(port, IEEE1284_MODE_COMPAT);
 
 	do {
 		/* Write the data, converting LF->CRLF as we go. */
 		ssize_t canwrite = count;
-		char *lf = memchr (s, '\n', count);
+		char *lf = memchr(s, '\n', count);
 		if (lf)
 			canwrite = lf - s;
 
 		if (canwrite > 0) {
-			written = parport_write (port, s, canwrite);
+			written = parport_write(port, s, canwrite);
 
 			if (written <= 0)
 				continue;
@@ -846,14 +846,14 @@ static void lp_console_write (struct console *co, const char *s,
 			s++;
 			count--;
 			do {
-				written = parport_write (port, crlf, i);
+				written = parport_write(port, crlf, i);
 				if (written > 0)
 					i -= written, crlf += written;
 			} while (i > 0 && (CONSOLE_LP_STRICT || written > 0));
 		}
 	} while (count > 0 && (CONSOLE_LP_STRICT || written > 0));
 
-	parport_release (dev);
+	parport_release(dev);
 }
 
 static struct console lpcons = {
@@ -874,7 +874,7 @@ module_param_array(parport, charp, NULL, 0);
 module_param(reset, bool, 0);
 
 #ifndef MODULE
-static int __init lp_setup (char *str)
+static int __init lp_setup(char *str)
 {
 	static int parport_ptr;
 	int x;
@@ -932,17 +932,17 @@ static int lp_register(int nr, struct parport *port)
 		if (port->modes & PARPORT_MODE_SAFEININT) {
 			register_console(&lpcons);
 			console_registered = port;
-			printk (KERN_INFO "lp%d: console ready\n", CONSOLE_LP);
+			printk(KERN_INFO "lp%d: console ready\n", CONSOLE_LP);
 		} else
-			printk (KERN_ERR "lp%d: cannot run console on %s\n",
-				CONSOLE_LP, port->name);
+			printk(KERN_ERR "lp%d: cannot run console on %s\n",
+			       CONSOLE_LP, port->name);
 	}
 #endif
 
 	return 0;
 }
 
-static void lp_attach (struct parport *port)
+static void lp_attach(struct parport *port)
 {
 	unsigned int i;
 
@@ -972,7 +972,7 @@ static void lp_attach (struct parport *port)
 	}
 }
 
-static void lp_detach (struct parport *port)
+static void lp_detach(struct parport *port)
 {
 	/* Write this some day. */
 #ifdef CONFIG_LP_CONSOLE
@@ -989,7 +989,7 @@ static struct parport_driver lp_driver = {
 	.detach = lp_detach,
 };
 
-static int __init lp_init (void)
+static int __init lp_init(void)
 {
 	int i, err = 0;
 
@@ -1006,17 +1006,17 @@ static int __init lp_init (void)
 #ifdef LP_STATS
 		lp_table[i].lastcall = 0;
 		lp_table[i].runchars = 0;
-		memset (&lp_table[i].stats, 0, sizeof (struct lp_stats));
+		memset(&lp_table[i].stats, 0, sizeof(struct lp_stats));
 #endif
 		lp_table[i].last_error = 0;
-		init_waitqueue_head (&lp_table[i].waitq);
-		init_waitqueue_head (&lp_table[i].dataq);
+		init_waitqueue_head(&lp_table[i].waitq);
+		init_waitqueue_head(&lp_table[i].dataq);
 		mutex_init(&lp_table[i].port_mutex);
 		lp_table[i].timeout = 10 * HZ;
 	}
 
-	if (register_chrdev (LP_MAJOR, "lp", &lp_fops)) {
-		printk (KERN_ERR "lp: unable to get major %d\n", LP_MAJOR);
+	if (register_chrdev(LP_MAJOR, "lp", &lp_fops)) {
+		printk(KERN_ERR "lp: unable to get major %d\n", LP_MAJOR);
 		return -EIO;
 	}
 
@@ -1026,17 +1026,17 @@ static int __init lp_init (void)
 		goto out_reg;
 	}
 
-	if (parport_register_driver (&lp_driver)) {
-		printk (KERN_ERR "lp: unable to register with parport\n");
+	if (parport_register_driver(&lp_driver)) {
+		printk(KERN_ERR "lp: unable to register with parport\n");
 		err = -EIO;
 		goto out_class;
 	}
 
 	if (!lp_count) {
-		printk (KERN_INFO "lp: driver loaded but no devices found\n");
+		printk(KERN_INFO "lp: driver loaded but no devices found\n");
 #ifndef CONFIG_PARPORT_1284
 		if (parport_nr[0] == LP_PARPORT_AUTO)
-			printk (KERN_INFO "lp: (is IEEE 1284 support enabled?)\n");
+			printk(KERN_INFO "lp: (is IEEE 1284 support enabled?)\n");
 #endif
 	}
 
@@ -1049,7 +1049,7 @@ static int __init lp_init (void)
 	return err;
 }
 
-static int __init lp_init_module (void)
+static int __init lp_init_module(void)
 {
 	if (parport[0]) {
 		/* The user gave some parameters.  Let's see what they were.  */
@@ -1077,14 +1077,14 @@ static int __init lp_init_module (void)
 	return lp_init();
 }
 
-static void lp_cleanup_module (void)
+static void lp_cleanup_module(void)
 {
 	unsigned int offset;
 
-	parport_unregister_driver (&lp_driver);
+	parport_unregister_driver(&lp_driver);
 
 #ifdef CONFIG_LP_CONSOLE
-	unregister_console (&lpcons);
+	unregister_console(&lpcons);
 #endif
 
 	unregister_chrdev(LP_MAJOR, "lp");
-- 
2.11.0


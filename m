Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1265376-1520243795-2-12155313277225619963
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520243794; b=ZHVGrehLRvdweoYW8v6S4miBfHOlhds7r04+61878YngLly
    kobCDfXzfGHGOs3j6uHMBaK31ZPnb1Rh5bx7sC7bBwToBemxHZNqRX1eVPj1+ReP
    WcUkOQ6PJW7IFuIj3wsvFlcJ3TuYjRmk+VoFY2YMZrU0btmbCHzjVqzMleXC7N4l
    4BhQx/ocI9ktdgmEDMqFooRoAv2kCf1LerJF6FBdgA8cp5sj4v/IDLnnGLMzo9PJ
    XBrrlnxM8uMWvrJ1s6DhcwL8doOZiu1FjO5ORMD/o9WM3ykQsQWNV6CknFxCVPpV
    ialI5nknzd8Pg5C11KfLCuXK7Bsiz4QlYmXdnag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1520243794; bh=9mhPudNnFOTis9xdQqE0DPBvOW
    QNdthOVcv48BVPfus=; b=u9C66FpjeOWfYmqWK+YqSTfkpdATWUEW2gcCe9xvg7
    k6tEzJqnV/9ALRzGu3nTDdkhaolKji+o7lKAC8/trnqZ34le6zxEsWrUGnk+iO7M
    zZmm0+in+lyGn15kvU8IxT+punapjR3Ub7ajbVRNqT26T8zDl+HRLCOOlJTBiikZ
    T1mQhz8G7Ep1FSx8A8dM8aQk/GbhXXrLo5/zcA8H9rfU/5jABO4EEnXB8ZvnFk9a
    6JkX3sPLgtodgjVOrGi9T+vswVYjLwOWTTrZEomjyF7t6W0pziHGqVgHzVTDzqJN
    4r0Hnv0c2TGeHTLhwEQpKyDBnB7Qs6TeKUtf6lmkBhQg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=THvakpcd x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=IHhEMgbH;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=THvakpcd x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=IHhEMgbH;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932817AbeCEJ4d (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Mar 2018 04:56:33 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:46366 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933155AbeCEJ4b (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 5 Mar 2018 04:56:31 -0500
X-Google-Smtp-Source: AG47ELtfTsPllvpK9b7TNQApq522FaekbPc8v2JiBi8/LtHxSlDl6q3IRwFcgAeskjQw2kFt9FVpwA==
From: Romain Izard <romain.izard.pro@gmail.com>
To: Oliver Neukum <oneukum@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Romain Izard <romain.izard.pro@gmail.com>
Subject: [RFC PATCH] cdc-acm: do not drop data from fast devices
Date: Mon,  5 Mar 2018 10:55:39 +0100
Message-Id: <20180305095539.13698-1-romain.izard.pro@gmail.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

There are some devices using their USB CDC-ACM interfaces as a debug port
that are able to send data at a very high speed, but with the current
driver implementation it is not possible to receive it when using a
relatively slow embedded system without dropping an important part of the
data.

The existing driver uses the throttling mechanism of the TTY line
discipline to regulate the speed of the data transmitted from the port to
the upper layers. This throttling prevents URBs from being resubmitted,
slowing down the transfer on the USB line. But the existing code does not
work correctly when the internal bufferring gets filled.

The TTY buffer is 4096 bytes large, throttling when there are only 128
free bytes left, and unthrottling when there are only 128 bytes available.
But the TTY buffer is filled from an intermediate flip buffer that
contains up to 64 KiB of data, and each time unthrottle() is called 16
URBs are scheduled by the driver, sending up to 16 KiB to the flip buffer.
As the result of tty_insert_flip_string() is not checked in the URB
reception callback, data can be lost when the flip buffer is filled faster
than the TTY is emptied.

Moreover, as the URB callbacks are called from a tasklet context, whereas
throttling is called from the system workqueue, it is possible for the
throttling to be delayed by high traffic in the tasklet. As a result,
completed URBs can be resubmitted even if the flip buffer is full, and we
request more data from the device only to drop it immediately.

To prevent this problem, the URBs whose data did not reach the flip buffer
are placed in a waiting list, which is only processed when the serial port
is unthrottled.

Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>

--

This is working when using the normal line discipline on ttyACM. But
there is a big hole in this: other line disciplines do not use throttling
and thus unthrottle is never called. The URBs will never get resubmitted,
and the port is dead. Unfortunately, there is no notification when the
flip buffer is ready to receive new data, so the only alternative would
be to schedule a timer polling the flip buffer. But with an additional
asynchronous process in the mix, the code starts to be very brittle.

I believe this issue is not limited to ttyACM. As the TTY layer is not
performance-oriented, it can be easy to overwhelm devices with a low
available processing power. In my case, a modem sending a sustained 2 MB/s
on a debug port (exported as a CDC-ACM port) was enough to trigger the
issue. The code handling the CDC-ACM class and the generic USB serial port
is very similar when it comes to URB handling, so all drivers that rely on
that code have the same issue.

But in general, it seems to me that there is no code in the kernel that
checks the return value of tty_insert_flip_string(). This means that we
are working with the assumption that the kernel will consume the data
faster than the source can send it, or that the upper layer will be
able or willing to throttle it fast enough to avoid losing data.


---
 drivers/usb/class/cdc-acm.c | 80 ++++++++++++++++++++++++++++++++++++++++-----
 drivers/usb/class/cdc-acm.h |  4 +++
 2 files changed, 75 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
index 7b366a6c0b49..833fa0a43ddd 100644
--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -150,12 +150,18 @@ static inline int acm_set_control(struct acm *acm, int control)
 static void acm_kill_urbs(struct acm *acm)
 {
 	int i;
+	struct acm_rb *rb, *t;
 
 	usb_kill_urb(acm->ctrlurb);
 	for (i = 0; i < ACM_NW; i++)
 		usb_kill_urb(acm->wb[i].urb);
 	for (i = 0; i < acm->rx_buflimit; i++)
 		usb_kill_urb(acm->read_urbs[i]);
+	list_for_each_entry_safe(rb, t, &acm->wait_list, node) {
+		set_bit(rb->index, &acm->read_urbs_free);
+		rb->offset = 0;
+		list_del_init(&rb->node);
+	}
 }
 
 /*
@@ -454,14 +460,27 @@ static int acm_submit_read_urbs(struct acm *acm, gfp_t mem_flags)
 	return 0;
 }
 
-static void acm_process_read_urb(struct acm *acm, struct urb *urb)
+static int acm_process_read_urb(struct acm *acm, struct urb *urb)
 {
+	int flipped, remainder;
+	struct acm_rb *rb = urb->context;
 	if (!urb->actual_length)
-		return;
+		return 0;
+	flipped = tty_insert_flip_string(&acm->port,
+			urb->transfer_buffer + rb->offset,
+			urb->actual_length - rb->offset);
+	rb->offset += flipped;
+	remainder = urb->actual_length - rb->offset;
+	if (remainder != 0)
+		dev_dbg(&acm->data->dev,
+			"remaining data: usb %d len %d offset %d flipped %d\n",
+			rb->index, urb->actual_length, rb->offset, flipped);
+	else
+		rb->offset = 0;
 
-	tty_insert_flip_string(&acm->port, urb->transfer_buffer,
-			urb->actual_length);
 	tty_flip_buffer_push(&acm->port);
+
+	return remainder;
 }
 
 static void acm_read_bulk_callback(struct urb *urb)
@@ -474,17 +493,29 @@ static void acm_read_bulk_callback(struct urb *urb)
 	dev_vdbg(&acm->data->dev, "got urb %d, len %d, status %d\n",
 		rb->index, urb->actual_length, status);
 
-	set_bit(rb->index, &acm->read_urbs_free);
-
 	if (!acm->dev) {
 		dev_dbg(&acm->data->dev, "%s - disconnected\n", __func__);
+		set_bit(rb->index, &acm->read_urbs_free);
 		return;
 	}
 
+	if (status == 0) {
+		int rem = urb->actual_length;
+
+		usb_mark_last_busy(acm->dev);
+		if (list_empty_careful(&acm->wait_list))
+			rem = acm_process_read_urb(acm, urb);
+		if (rem) {
+			dev_vdbg(&acm->data->dev,
+				"queuing urb %d\n", rb->index);
+			list_add_tail(&rb->node, &acm->wait_list);
+			return;
+		}
+	}
+	set_bit(rb->index, &acm->read_urbs_free);
+
 	switch (status) {
 	case 0:
-		usb_mark_last_busy(acm->dev);
-		acm_process_read_urb(acm, urb);
 		break;
 	case -EPIPE:
 		set_bit(EVENT_RX_STALL, &acm->flags);
@@ -518,6 +549,8 @@ static void acm_read_bulk_callback(struct urb *urb)
 		acm_submit_read_urb(acm, rb->index, GFP_ATOMIC);
 	} else {
 		spin_unlock_irqrestore(&acm->read_lock, flags);
+		dev_vdbg(&acm->data->dev,
+			"urb %d is suspended by throttling\n", rb->index);
 	}
 }
 
@@ -549,8 +582,14 @@ static void acm_softint(struct work_struct *work)
 
 	if (test_bit(EVENT_RX_STALL, &acm->flags)) {
 		if (!(usb_autopm_get_interface(acm->data))) {
+			struct acm_rb *rb, *t;
 			for (i = 0; i < acm->rx_buflimit; i++)
 				usb_kill_urb(acm->read_urbs[i]);
+			list_for_each_entry_safe(rb, t, &acm->wait_list, node) {
+				set_bit(rb->index, &acm->read_urbs_free);
+				rb->offset = 0;
+				list_del_init(&rb->node);
+			}
 			usb_clear_halt(acm->dev, acm->in);
 			acm_submit_read_urbs(acm, GFP_KERNEL);
 			usb_autopm_put_interface(acm->data);
@@ -901,14 +940,32 @@ static void acm_tty_unthrottle(struct tty_struct *tty)
 {
 	struct acm *acm = tty->driver_data;
 	unsigned int was_throttled;
+	struct acm_rb *rb, *t;
+	bool processed = false;
+	int rem = 0;
 
 	spin_lock_irq(&acm->read_lock);
+
+	list_for_each_entry_safe(rb, t, &acm->wait_list, node) {
+		dev_vdbg(&acm->data->dev, "processing urb %d: %d/%d\n",
+			rb->index, rb->offset, rb->urb->actual_length);
+		rem = acm_process_read_urb(acm, rb->urb);
+		if (rem) {
+			spin_unlock_irq(&acm->read_lock);
+			return;
+		}
+		processed = true;
+		set_bit(rb->index, &acm->read_urbs_free);
+		rb->offset = 0;
+		list_del_init(&rb->node);
+	}
+
 	was_throttled = acm->throttled;
 	acm->throttled = 0;
 	acm->throttle_req = 0;
 	spin_unlock_irq(&acm->read_lock);
 
-	if (was_throttled)
+	if (was_throttled || processed)
 		acm_submit_read_urbs(acm, GFP_KERNEL);
 }
 
@@ -1430,6 +1487,8 @@ static int acm_probe(struct usb_interface *intf,
 	if (!acm->ctrlurb)
 		goto alloc_fail5;
 
+	INIT_LIST_HEAD(&acm->wait_list);
+
 	for (i = 0; i < num_rx_buf; i++) {
 		struct acm_rb *rb = &(acm->read_buffers[i]);
 		struct urb *urb;
@@ -1445,6 +1504,9 @@ static int acm_probe(struct usb_interface *intf,
 		if (!urb)
 			goto alloc_fail6;
 
+		rb->offset = 0;
+		rb->urb = urb;
+		INIT_LIST_HEAD(&rb->node);
 		urb->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
 		urb->transfer_dma = rb->dma;
 		if (usb_endpoint_xfer_int(epread))
diff --git a/drivers/usb/class/cdc-acm.h b/drivers/usb/class/cdc-acm.h
index eacc116e83da..cee849a79371 100644
--- a/drivers/usb/class/cdc-acm.h
+++ b/drivers/usb/class/cdc-acm.h
@@ -77,7 +77,10 @@ struct acm_rb {
 	unsigned char		*base;
 	dma_addr_t		dma;
 	int			index;
+	struct urb		*urb;
 	struct acm		*instance;
+	unsigned int		offset;
+	struct list_head	node;
 };
 
 struct acm {
@@ -96,6 +99,7 @@ struct acm {
 	unsigned long read_urbs_free;
 	struct urb *read_urbs[ACM_NR];
 	struct acm_rb read_buffers[ACM_NR];
+	struct list_head wait_list;
 	struct acm_wb *putbuffer;			/* for acm_tty_put_char() */
 	int rx_buflimit;
 	spinlock_t read_lock;
-- 
2.14.1


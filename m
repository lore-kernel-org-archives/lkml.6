Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-842223-1518038507-2-6759041562018675978
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518038506; b=PKxtwJAVyPqB5EC+1dXRu6bT2b+C8tGajSpodAoFFLIGbYD
    CMnhwC1l4qq6CiHJFPC+zKmX5LsCsLFbOWUpAne6UXMTTgV4FcvmWALux2PPw9ZH
    vkbr1vUy35qMO54rC2TgqP5WbP5PsU9WoA2e4xDWEQpzBl4WKHPthzqHyEOHzGNl
    70dR+IIE7iKz7cJRHt9EwrtNV32MqFdPyhz58wtQQGdZfs08cvHYc1PozcMTqUsV
    f6FYpgZpV593a8LSjNEfvL59TEMreLfqB6yK87xVq5g38eKo5kgg5s3IOIs0vBBq
    RhaDRMlhdtEGaa0v7LItXaI27OyMnEXj5g5Xa+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:in-reply-to:references:sender:list-id;
    s=arctest; t=1518038506; bh=EmDHotKcOixBssTR8eK7zdwaY/ksKHnI73X
    v2Sn472A=; b=GLpzVIfTieAc2p+1nIXcde///pr81s/ZYWVqZG5r6Fv/ApzIHWB
    HtqaU1j4DsXmPpRPaJaIUIlqiwQXqEks28oD4OvrLVI+v2Ix180N6VcCts7LKEme
    njtpEToyxGu0I4wXWBasXjJRQVJd0ma/UoHLXFpR/PejB7FEmNVRnMRZjxz6mbyZ
    RnoCpyBk8UkXGWuE006RB3pU8gv0y0Lz+edGmzTYdxoS29Tqq79zp/jDFOe2IqMb
    5ezIK7redOJPaYB+2nmZ+dmdD5/i1eWaSYGFUCxIhMdot4A4PV8anYs67AMeh3cN
    Sejbeqaw8DMXrQLMC8pTa7inE7L+CuIntjQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=osg.samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osg.samsung.com header.result=pass header_org.domain=samsung.com header_org.result=pass header_is_org_domain=no
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=osg.samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osg.samsung.com header.result=pass header_org.domain=samsung.com header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755115AbeBGVVb (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Feb 2018 16:21:31 -0500
Received: from osg.samsung.com ([64.30.133.232]:64463 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932326AbeBGVVG (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Wed, 7 Feb 2018 16:21:06 -0500
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
From: Shuah Khan <shuahkh@osg.samsung.com>
To: valentina.manea.m@gmail.com, shuah@kernel.org,
        gregkh@linuxfoundation.org
Cc: Shuah Khan <shuahkh@osg.samsung.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH 3.18 9/9] usbip: vhci: stop printing kernel pointer addresses in messages
Date: Wed,  7 Feb 2018 14:20:32 -0700
Message-Id: <3520c95a43a3170d274d41933cd7d4974aa38601.1518036867.git.shuahkh@osg.samsung.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1518036867.git.shuahkh@osg.samsung.com>
References: <cover.1518036867.git.shuahkh@osg.samsung.com>
In-Reply-To: <cover.1518036867.git.shuahkh@osg.samsung.com>
References: <cover.1518036867.git.shuahkh@osg.samsung.com>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Upstream commit 8272d099d05f ("usbip: vhci: stop printing kernel
pointer addresses in messages")

Remove and/or change debug, info. and error messages to not print
kernel pointer addresses.

Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/usbip/vhci_hcd.c | 10 ----------
 drivers/usb/usbip/vhci_rx.c  | 23 +++++++++++------------
 drivers/usb/usbip/vhci_tx.c  |  3 ++-
 3 files changed, 13 insertions(+), 23 deletions(-)

diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
index a57843e1173f..869938036248 100644
--- a/drivers/usb/usbip/vhci_hcd.c
+++ b/drivers/usb/usbip/vhci_hcd.c
@@ -469,9 +469,6 @@ static int vhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb,
 	struct vhci_device *vdev;
 	unsigned long flags;
 
-	usbip_dbg_vhci_hc("enter, usb_hcd %p urb %p mem_flags %d\n",
-			  hcd, urb, mem_flags);
-
 	/* patch to usb_sg_init() is in 2.5.60 */
 	BUG_ON(!urb->transfer_buffer && urb->transfer_buffer_length);
 
@@ -630,8 +627,6 @@ static int vhci_urb_dequeue(struct usb_hcd *hcd, struct urb *urb, int status)
 	struct vhci_device *vdev;
 	unsigned long flags;
 
-	pr_info("dequeue a urb %p\n", urb);
-
 	spin_lock_irqsave(&the_controller->lock, flags);
 
 	priv = urb->hcpriv;
@@ -659,7 +654,6 @@ static int vhci_urb_dequeue(struct usb_hcd *hcd, struct urb *urb, int status)
 		/* tcp connection is closed */
 		spin_lock(&vdev->priv_lock);
 
-		pr_info("device %p seems to be disconnected\n", vdev);
 		list_del(&priv->list);
 		kfree(priv);
 		urb->hcpriv = NULL;
@@ -671,8 +665,6 @@ static int vhci_urb_dequeue(struct usb_hcd *hcd, struct urb *urb, int status)
 		 * vhci_rx will receive RET_UNLINK and give back the URB.
 		 * Otherwise, we give back it here.
 		 */
-		pr_info("gives back urb %p\n", urb);
-
 		usb_hcd_unlink_urb_from_ep(hcd, urb);
 
 		spin_unlock_irqrestore(&the_controller->lock, flags);
@@ -701,8 +693,6 @@ static int vhci_urb_dequeue(struct usb_hcd *hcd, struct urb *urb, int status)
 
 		unlink->unlink_seqnum = priv->seqnum;
 
-		pr_info("device %p seems to be still connected\n", vdev);
-
 		/* send cmd_unlink and try to cancel the pending URB in the
 		 * peer */
 		list_add_tail(&unlink->list, &vdev->unlink_tx);
diff --git a/drivers/usb/usbip/vhci_rx.c b/drivers/usb/usbip/vhci_rx.c
index d656e0edc3d5..323aa7789989 100644
--- a/drivers/usb/usbip/vhci_rx.c
+++ b/drivers/usb/usbip/vhci_rx.c
@@ -37,24 +37,23 @@ struct urb *pickup_urb_and_free_priv(struct vhci_device *vdev, __u32 seqnum)
 		urb = priv->urb;
 		status = urb->status;
 
-		usbip_dbg_vhci_rx("find urb %p vurb %p seqnum %u\n",
-				urb, priv, seqnum);
+		usbip_dbg_vhci_rx("find urb seqnum %u\n", seqnum);
 
 		switch (status) {
 		case -ENOENT:
 			/* fall through */
 		case -ECONNRESET:
-			dev_info(&urb->dev->dev,
-				 "urb %p was unlinked %ssynchronuously.\n", urb,
-				 status == -ENOENT ? "" : "a");
+			dev_dbg(&urb->dev->dev,
+				 "urb seq# %u was unlinked %ssynchronuously\n",
+				 seqnum, status == -ENOENT ? "" : "a");
 			break;
 		case -EINPROGRESS:
 			/* no info output */
 			break;
 		default:
-			dev_info(&urb->dev->dev,
-				 "urb %p may be in a error, status %d\n", urb,
-				 status);
+			dev_dbg(&urb->dev->dev,
+				 "urb seq# %u may be in a error, status %d\n",
+				 seqnum, status);
 		}
 
 		list_del(&priv->list);
@@ -79,8 +78,8 @@ static void vhci_recv_ret_submit(struct vhci_device *vdev,
 	spin_unlock_irqrestore(&vdev->priv_lock, flags);
 
 	if (!urb) {
-		pr_err("cannot find a urb of seqnum %u\n", pdu->base.seqnum);
-		pr_info("max seqnum %d\n",
+		pr_err("cannot find a urb of seqnum %u max seqnum %d\n",
+			pdu->base.seqnum,
 			atomic_read(&the_controller->seqnum));
 		usbip_event_add(ud, VDEV_EVENT_ERROR_TCP);
 		return;
@@ -103,7 +102,7 @@ static void vhci_recv_ret_submit(struct vhci_device *vdev,
 	if (usbip_dbg_flag_vhci_rx)
 		usbip_dump_urb(urb);
 
-	usbip_dbg_vhci_rx("now giveback urb %p\n", urb);
+	usbip_dbg_vhci_rx("now giveback urb %u\n", pdu->base.seqnum);
 
 	spin_lock_irqsave(&the_controller->lock, flags);
 	usb_hcd_unlink_urb_from_ep(vhci_to_hcd(the_controller), urb);
@@ -168,7 +167,7 @@ static void vhci_recv_ret_unlink(struct vhci_device *vdev,
 		pr_info("the urb (seqnum %d) was already given back\n",
 			pdu->base.seqnum);
 	} else {
-		usbip_dbg_vhci_rx("now giveback urb %p\n", urb);
+		usbip_dbg_vhci_rx("now giveback urb %d\n", pdu->base.seqnum);
 
 		/* If unlink is successful, status is -ECONNRESET */
 		urb->status = pdu->u.ret_unlink.status;
diff --git a/drivers/usb/usbip/vhci_tx.c b/drivers/usb/usbip/vhci_tx.c
index 3e7878fe2fd4..a9a663a578b6 100644
--- a/drivers/usb/usbip/vhci_tx.c
+++ b/drivers/usb/usbip/vhci_tx.c
@@ -83,7 +83,8 @@ static int vhci_send_cmd_submit(struct vhci_device *vdev)
 		memset(&msg, 0, sizeof(msg));
 		memset(&iov, 0, sizeof(iov));
 
-		usbip_dbg_vhci_tx("setup txdata urb %p\n", urb);
+		usbip_dbg_vhci_tx("setup txdata urb seqnum %lu\n",
+				  priv->seqnum);
 
 		/* 1. setup usbip_header */
 		setup_cmd_submit_pdu(&pdu_header, urb);
-- 
2.14.1


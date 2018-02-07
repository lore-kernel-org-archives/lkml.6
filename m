Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-840750-1518038544-2-9702987292631154519
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
    t=1518038543; b=Ngf8NJJtqgvlcx014JGH2/pCT1GxwZaYRITlzLVWvELc7Qw
    jjG4kDPHgNLCeqpWRwqb+kucJAUDrxVH8bBL1As79OyDci7tOTZ9I0I6TktZwmUg
    vPvDHZIYVlZxfKT21QQHJz5f/2gJQy4eKmZ9QAb9sGOKpYxkgj7QiTR/SvjXBv8q
    mjeUIGXI9GkKEDqk1yZbISZeo3vjUlKEIDpdS8uUb7j4tyu1XfT7wi6VtlQqKaEA
    akhD/Uw1BhgiWBC4tn+7vyBbU12fI8qKkzo6exf5bRJedTx/kWGSPGTTrYgYuls1
    dN8hZNfrTku3JgrkSa4TOXqm3TgEfzqBzQ1Dqmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:in-reply-to:references:sender:list-id;
    s=arctest; t=1518038543; bh=HdynuiidQ3Wi/65VxLcL5nRkGsOt9Hu3reW
    Z524xa/Q=; b=NAmPd2HVIHFUxT6YRvmb5O7IrZa3KLCHGNuzvm2Ty4y+newRq2Y
    /Rz+YAwyLRKWiBjeYW60OHhq5CUPyQ//Xtqf5m4gBjqsbk8hYMlwP/HIUV0MfNdy
    Sp1M6m9nrgByNXA3ywNkW18BQoset2L5wNbKVdfphussMVzTgUo60jWI4WgAwJ5S
    gRY4lI0UnlU1VaI8d10u8sPCMXakVMOU0jBt920rzTzKCN9VGptIDw5D+9llCwDz
    2ftIOBVXG86aOynMxfoj0fnPGEKPKIIBkH9yPi2lEibkUH6S5xLsADb684zKGOuR
    VzhxBTTnHuLQmhZmBR5Ps45Dz1LUMGPY4Sg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=osg.samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osg.samsung.com header.result=pass header_org.domain=samsung.com header_org.result=pass header_is_org_domain=no
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=osg.samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osg.samsung.com header.result=pass header_org.domain=samsung.com header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932176AbeBGVVw (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Feb 2018 16:21:52 -0500
Received: from osg.samsung.com ([64.30.133.232]:60235 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932319AbeBGVVF (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Wed, 7 Feb 2018 16:21:05 -0500
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
From: Shuah Khan <shuahkh@osg.samsung.com>
To: valentina.manea.m@gmail.com, shuah@kernel.org,
        gregkh@linuxfoundation.org
Cc: Andrew Goodbody <andrew.goodbody@cambrionix.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Shuah Khan <shuahkh@osg.samsung.com>
Subject: [PATCH 3.18 5/9] usb: usbip: Fix possible deadlocks reported by lockdep
Date: Wed,  7 Feb 2018 14:20:28 -0700
Message-Id: <a4c1bbb48490f8ff8b974f0bb5c8f0a94ccb5be7.1518036867.git.shuahkh@osg.samsung.com>
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

From: Andrew Goodbody <andrew.goodbody@cambrionix.com>

Upstream commit 21619792d1ec ("usb: usbip: Fix possible deadlocks
reported by lockdep")

Change spin_lock calls to spin_lock_irqsave to prevent
attmpted recursive lock taking in interrupt context.

This patch fixes Bug 109351
  https://bugzilla.kernel.org/show_bug.cgi?id=109351

Signed-off-by: Andrew Goodbody <andrew.goodbody@cambrionix.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
---
 drivers/usb/usbip/usbip_event.c |  5 ++-
 drivers/usb/usbip/vhci_hcd.c    | 88 ++++++++++++++++++++++++-----------------
 drivers/usb/usbip/vhci_rx.c     | 30 ++++++++------
 drivers/usb/usbip/vhci_sysfs.c  | 19 +++++----
 drivers/usb/usbip/vhci_tx.c     | 14 ++++---
 5 files changed, 91 insertions(+), 65 deletions(-)

diff --git a/drivers/usb/usbip/usbip_event.c b/drivers/usb/usbip/usbip_event.c
index 64933b993d7a..2580a32bcdff 100644
--- a/drivers/usb/usbip/usbip_event.c
+++ b/drivers/usb/usbip/usbip_event.c
@@ -117,11 +117,12 @@ EXPORT_SYMBOL_GPL(usbip_event_add);
 int usbip_event_happened(struct usbip_device *ud)
 {
 	int happened = 0;
+	unsigned long flags;
 
-	spin_lock(&ud->lock);
+	spin_lock_irqsave(&ud->lock, flags);
 	if (ud->event != 0)
 		happened = 1;
-	spin_unlock(&ud->lock);
+	spin_unlock_irqrestore(&ud->lock, flags);
 
 	return happened;
 }
diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
index c02374b6049c..2c7bed7b19d6 100644
--- a/drivers/usb/usbip/vhci_hcd.c
+++ b/drivers/usb/usbip/vhci_hcd.c
@@ -121,9 +121,11 @@ static void dump_port_status_diff(u32 prev_status, u32 new_status)
 
 void rh_port_connect(int rhport, enum usb_device_speed speed)
 {
+	unsigned long	flags;
+
 	usbip_dbg_vhci_rh("rh_port_connect %d\n", rhport);
 
-	spin_lock(&the_controller->lock);
+	spin_lock_irqsave(&the_controller->lock, flags);
 
 	the_controller->port_status[rhport] |= USB_PORT_STAT_CONNECTION
 		| (1 << USB_PORT_FEAT_C_CONNECTION);
@@ -139,22 +141,24 @@ void rh_port_connect(int rhport, enum usb_device_speed speed)
 		break;
 	}
 
-	spin_unlock(&the_controller->lock);
+	spin_unlock_irqrestore(&the_controller->lock, flags);
 
 	usb_hcd_poll_rh_status(vhci_to_hcd(the_controller));
 }
 
 static void rh_port_disconnect(int rhport)
 {
+	unsigned long	flags;
+
 	usbip_dbg_vhci_rh("rh_port_disconnect %d\n", rhport);
 
-	spin_lock(&the_controller->lock);
+	spin_lock_irqsave(&the_controller->lock, flags);
 
 	the_controller->port_status[rhport] &= ~USB_PORT_STAT_CONNECTION;
 	the_controller->port_status[rhport] |=
 					(1 << USB_PORT_FEAT_C_CONNECTION);
 
-	spin_unlock(&the_controller->lock);
+	spin_unlock_irqrestore(&the_controller->lock, flags);
 	usb_hcd_poll_rh_status(vhci_to_hcd(the_controller));
 }
 
@@ -182,13 +186,14 @@ static int vhci_hub_status(struct usb_hcd *hcd, char *buf)
 	int		retval;
 	int		rhport;
 	int		changed = 0;
+	unsigned long	flags;
 
 	retval = DIV_ROUND_UP(VHCI_NPORTS + 1, 8);
 	memset(buf, 0, retval);
 
 	vhci = hcd_to_vhci(hcd);
 
-	spin_lock(&vhci->lock);
+	spin_lock_irqsave(&vhci->lock, flags);
 	if (!HCD_HW_ACCESSIBLE(hcd)) {
 		usbip_dbg_vhci_rh("hw accessible flag not on?\n");
 		goto done;
@@ -209,7 +214,7 @@ static int vhci_hub_status(struct usb_hcd *hcd, char *buf)
 		usb_hcd_resume_root_hub(hcd);
 
 done:
-	spin_unlock(&vhci->lock);
+	spin_unlock_irqrestore(&vhci->lock, flags);
 	return changed ? retval : 0;
 }
 
@@ -230,6 +235,7 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 	struct vhci_hcd	*dum;
 	int             retval = 0;
 	int		rhport;
+	unsigned long	flags;
 
 	u32 prev_port_status[VHCI_NPORTS];
 
@@ -248,7 +254,7 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 
 	dum = hcd_to_vhci(hcd);
 
-	spin_lock(&dum->lock);
+	spin_lock_irqsave(&dum->lock, flags);
 
 	/* store old status and compare now and old later */
 	if (usbip_dbg_flag_vhci_rh) {
@@ -402,7 +408,7 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 	}
 	usbip_dbg_vhci_rh(" bye\n");
 
-	spin_unlock(&dum->lock);
+	spin_unlock_irqrestore(&dum->lock, flags);
 
 	return retval;
 }
@@ -425,6 +431,7 @@ static void vhci_tx_urb(struct urb *urb)
 {
 	struct vhci_device *vdev = get_vdev(urb->dev);
 	struct vhci_priv *priv;
+	unsigned long flags;
 
 	if (!vdev) {
 		pr_err("could not get virtual device");
@@ -437,7 +444,7 @@ static void vhci_tx_urb(struct urb *urb)
 		return;
 	}
 
-	spin_lock(&vdev->priv_lock);
+	spin_lock_irqsave(&vdev->priv_lock, flags);
 
 	priv->seqnum = atomic_inc_return(&the_controller->seqnum);
 	if (priv->seqnum == 0xffff)
@@ -451,7 +458,7 @@ static void vhci_tx_urb(struct urb *urb)
 	list_add_tail(&priv->list, &vdev->priv_tx);
 
 	wake_up(&vdev->waitq_tx);
-	spin_unlock(&vdev->priv_lock);
+	spin_unlock_irqrestore(&vdev->priv_lock, flags);
 }
 
 static int vhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb,
@@ -460,6 +467,7 @@ static int vhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb,
 	struct device *dev = &urb->dev->dev;
 	int ret = 0;
 	struct vhci_device *vdev;
+	unsigned long flags;
 
 	usbip_dbg_vhci_hc("enter, usb_hcd %p urb %p mem_flags %d\n",
 			  hcd, urb, mem_flags);
@@ -467,11 +475,11 @@ static int vhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb,
 	/* patch to usb_sg_init() is in 2.5.60 */
 	BUG_ON(!urb->transfer_buffer && urb->transfer_buffer_length);
 
-	spin_lock(&the_controller->lock);
+	spin_lock_irqsave(&the_controller->lock, flags);
 
 	if (urb->status != -EINPROGRESS) {
 		dev_err(dev, "URB already unlinked!, status %d\n", urb->status);
-		spin_unlock(&the_controller->lock);
+		spin_unlock_irqrestore(&the_controller->lock, flags);
 		return urb->status;
 	}
 
@@ -483,7 +491,7 @@ static int vhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb,
 	    vdev->ud.status == VDEV_ST_ERROR) {
 		dev_err(dev, "enqueue for inactive port %d\n", vdev->rhport);
 		spin_unlock(&vdev->ud.lock);
-		spin_unlock(&the_controller->lock);
+		spin_unlock_irqrestore(&the_controller->lock, flags);
 		return -ENODEV;
 	}
 	spin_unlock(&vdev->ud.lock);
@@ -558,14 +566,14 @@ static int vhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb,
 
 out:
 	vhci_tx_urb(urb);
-	spin_unlock(&the_controller->lock);
+	spin_unlock_irqrestore(&the_controller->lock, flags);
 
 	return 0;
 
 no_need_xmit:
 	usb_hcd_unlink_urb_from_ep(hcd, urb);
 no_need_unlink:
-	spin_unlock(&the_controller->lock);
+	spin_unlock_irqrestore(&the_controller->lock, flags);
 	usb_hcd_giveback_urb(vhci_to_hcd(the_controller), urb, urb->status);
 	return ret;
 }
@@ -620,16 +628,17 @@ static int vhci_urb_dequeue(struct usb_hcd *hcd, struct urb *urb, int status)
 {
 	struct vhci_priv *priv;
 	struct vhci_device *vdev;
+	unsigned long flags;
 
 	pr_info("dequeue a urb %p\n", urb);
 
-	spin_lock(&the_controller->lock);
+	spin_lock_irqsave(&the_controller->lock, flags);
 
 	priv = urb->hcpriv;
 	if (!priv) {
 		/* URB was never linked! or will be soon given back by
 		 * vhci_rx. */
-		spin_unlock(&the_controller->lock);
+		spin_unlock_irqrestore(&the_controller->lock, flags);
 		return 0;
 	}
 
@@ -638,7 +647,7 @@ static int vhci_urb_dequeue(struct usb_hcd *hcd, struct urb *urb, int status)
 
 		ret = usb_hcd_check_unlink_urb(hcd, urb, status);
 		if (ret) {
-			spin_unlock(&the_controller->lock);
+			spin_unlock_irqrestore(&the_controller->lock, flags);
 			return ret;
 		}
 	}
@@ -666,10 +675,10 @@ static int vhci_urb_dequeue(struct usb_hcd *hcd, struct urb *urb, int status)
 
 		usb_hcd_unlink_urb_from_ep(hcd, urb);
 
-		spin_unlock(&the_controller->lock);
+		spin_unlock_irqrestore(&the_controller->lock, flags);
 		usb_hcd_giveback_urb(vhci_to_hcd(the_controller), urb,
 				     urb->status);
-		spin_lock(&the_controller->lock);
+		spin_lock_irqsave(&the_controller->lock, flags);
 
 	} else {
 		/* tcp connection is alive */
@@ -681,7 +690,7 @@ static int vhci_urb_dequeue(struct usb_hcd *hcd, struct urb *urb, int status)
 		unlink = kzalloc(sizeof(struct vhci_unlink), GFP_ATOMIC);
 		if (!unlink) {
 			spin_unlock(&vdev->priv_lock);
-			spin_unlock(&the_controller->lock);
+			spin_unlock_irqrestore(&the_controller->lock, flags);
 			usbip_event_add(&vdev->ud, VDEV_EVENT_ERROR_MALLOC);
 			return -ENOMEM;
 		}
@@ -702,7 +711,7 @@ static int vhci_urb_dequeue(struct usb_hcd *hcd, struct urb *urb, int status)
 		spin_unlock(&vdev->priv_lock);
 	}
 
-	spin_unlock(&the_controller->lock);
+	spin_unlock_irqrestore(&the_controller->lock, flags);
 
 	usbip_dbg_vhci_hc("leave\n");
 	return 0;
@@ -711,8 +720,9 @@ static int vhci_urb_dequeue(struct usb_hcd *hcd, struct urb *urb, int status)
 static void vhci_device_unlink_cleanup(struct vhci_device *vdev)
 {
 	struct vhci_unlink *unlink, *tmp;
+	unsigned long flags;
 
-	spin_lock(&the_controller->lock);
+	spin_lock_irqsave(&the_controller->lock, flags);
 	spin_lock(&vdev->priv_lock);
 
 	list_for_each_entry_safe(unlink, tmp, &vdev->unlink_tx, list) {
@@ -746,19 +756,19 @@ static void vhci_device_unlink_cleanup(struct vhci_device *vdev)
 		list_del(&unlink->list);
 
 		spin_unlock(&vdev->priv_lock);
-		spin_unlock(&the_controller->lock);
+		spin_unlock_irqrestore(&the_controller->lock, flags);
 
 		usb_hcd_giveback_urb(vhci_to_hcd(the_controller), urb,
 				     urb->status);
 
-		spin_lock(&the_controller->lock);
+		spin_lock_irqsave(&the_controller->lock, flags);
 		spin_lock(&vdev->priv_lock);
 
 		kfree(unlink);
 	}
 
 	spin_unlock(&vdev->priv_lock);
-	spin_unlock(&the_controller->lock);
+	spin_unlock_irqrestore(&the_controller->lock, flags);
 }
 
 /*
@@ -825,8 +835,9 @@ static void vhci_shutdown_connection(struct usbip_device *ud)
 static void vhci_device_reset(struct usbip_device *ud)
 {
 	struct vhci_device *vdev = container_of(ud, struct vhci_device, ud);
+	unsigned long flags;
 
-	spin_lock(&ud->lock);
+	spin_lock_irqsave(&ud->lock, flags);
 
 	vdev->speed  = 0;
 	vdev->devid  = 0;
@@ -841,14 +852,16 @@ static void vhci_device_reset(struct usbip_device *ud)
 	}
 	ud->status = VDEV_ST_NULL;
 
-	spin_unlock(&ud->lock);
+	spin_unlock_irqrestore(&ud->lock, flags);
 }
 
 static void vhci_device_unusable(struct usbip_device *ud)
 {
-	spin_lock(&ud->lock);
+	unsigned long flags;
+
+	spin_lock_irqsave(&ud->lock, flags);
 	ud->status = VDEV_ST_ERROR;
-	spin_unlock(&ud->lock);
+	spin_unlock_irqrestore(&ud->lock, flags);
 }
 
 static void vhci_device_init(struct vhci_device *vdev)
@@ -938,12 +951,13 @@ static int vhci_get_frame_number(struct usb_hcd *hcd)
 static int vhci_bus_suspend(struct usb_hcd *hcd)
 {
 	struct vhci_hcd *vhci = hcd_to_vhci(hcd);
+	unsigned long flags;
 
 	dev_dbg(&hcd->self.root_hub->dev, "%s\n", __func__);
 
-	spin_lock(&vhci->lock);
+	spin_lock_irqsave(&vhci->lock, flags);
 	hcd->state = HC_STATE_SUSPENDED;
-	spin_unlock(&vhci->lock);
+	spin_unlock_irqrestore(&vhci->lock, flags);
 
 	return 0;
 }
@@ -952,15 +966,16 @@ static int vhci_bus_resume(struct usb_hcd *hcd)
 {
 	struct vhci_hcd *vhci = hcd_to_vhci(hcd);
 	int rc = 0;
+	unsigned long flags;
 
 	dev_dbg(&hcd->self.root_hub->dev, "%s\n", __func__);
 
-	spin_lock(&vhci->lock);
+	spin_lock_irqsave(&vhci->lock, flags);
 	if (!HCD_HW_ACCESSIBLE(hcd))
 		rc = -ESHUTDOWN;
 	else
 		hcd->state = HC_STATE_RUNNING;
-	spin_unlock(&vhci->lock);
+	spin_unlock_irqrestore(&vhci->lock, flags);
 
 	return rc;
 }
@@ -1058,17 +1073,18 @@ static int vhci_hcd_suspend(struct platform_device *pdev, pm_message_t state)
 	int rhport = 0;
 	int connected = 0;
 	int ret = 0;
+	unsigned long flags;
 
 	hcd = platform_get_drvdata(pdev);
 
-	spin_lock(&the_controller->lock);
+	spin_lock_irqsave(&the_controller->lock, flags);
 
 	for (rhport = 0; rhport < VHCI_NPORTS; rhport++)
 		if (the_controller->port_status[rhport] &
 		    USB_PORT_STAT_CONNECTION)
 			connected += 1;
 
-	spin_unlock(&the_controller->lock);
+	spin_unlock_irqrestore(&the_controller->lock, flags);
 
 	if (connected > 0) {
 		dev_info(&pdev->dev,
diff --git a/drivers/usb/usbip/vhci_rx.c b/drivers/usb/usbip/vhci_rx.c
index 00e4a54308e4..d656e0edc3d5 100644
--- a/drivers/usb/usbip/vhci_rx.c
+++ b/drivers/usb/usbip/vhci_rx.c
@@ -72,10 +72,11 @@ static void vhci_recv_ret_submit(struct vhci_device *vdev,
 {
 	struct usbip_device *ud = &vdev->ud;
 	struct urb *urb;
+	unsigned long flags;
 
-	spin_lock(&vdev->priv_lock);
+	spin_lock_irqsave(&vdev->priv_lock, flags);
 	urb = pickup_urb_and_free_priv(vdev, pdu->base.seqnum);
-	spin_unlock(&vdev->priv_lock);
+	spin_unlock_irqrestore(&vdev->priv_lock, flags);
 
 	if (!urb) {
 		pr_err("cannot find a urb of seqnum %u\n", pdu->base.seqnum);
@@ -104,9 +105,9 @@ static void vhci_recv_ret_submit(struct vhci_device *vdev,
 
 	usbip_dbg_vhci_rx("now giveback urb %p\n", urb);
 
-	spin_lock(&the_controller->lock);
+	spin_lock_irqsave(&the_controller->lock, flags);
 	usb_hcd_unlink_urb_from_ep(vhci_to_hcd(the_controller), urb);
-	spin_unlock(&the_controller->lock);
+	spin_unlock_irqrestore(&the_controller->lock, flags);
 
 	usb_hcd_giveback_urb(vhci_to_hcd(the_controller), urb, urb->status);
 
@@ -117,8 +118,9 @@ static struct vhci_unlink *dequeue_pending_unlink(struct vhci_device *vdev,
 						  struct usbip_header *pdu)
 {
 	struct vhci_unlink *unlink, *tmp;
+	unsigned long flags;
 
-	spin_lock(&vdev->priv_lock);
+	spin_lock_irqsave(&vdev->priv_lock, flags);
 
 	list_for_each_entry_safe(unlink, tmp, &vdev->unlink_rx, list) {
 		pr_info("unlink->seqnum %lu\n", unlink->seqnum);
@@ -127,12 +129,12 @@ static struct vhci_unlink *dequeue_pending_unlink(struct vhci_device *vdev,
 					  unlink->seqnum);
 			list_del(&unlink->list);
 
-			spin_unlock(&vdev->priv_lock);
+			spin_unlock_irqrestore(&vdev->priv_lock, flags);
 			return unlink;
 		}
 	}
 
-	spin_unlock(&vdev->priv_lock);
+	spin_unlock_irqrestore(&vdev->priv_lock, flags);
 
 	return NULL;
 }
@@ -142,6 +144,7 @@ static void vhci_recv_ret_unlink(struct vhci_device *vdev,
 {
 	struct vhci_unlink *unlink;
 	struct urb *urb;
+	unsigned long flags;
 
 	usbip_dump_header(pdu);
 
@@ -152,9 +155,9 @@ static void vhci_recv_ret_unlink(struct vhci_device *vdev,
 		return;
 	}
 
-	spin_lock(&vdev->priv_lock);
+	spin_lock_irqsave(&vdev->priv_lock, flags);
 	urb = pickup_urb_and_free_priv(vdev, unlink->unlink_seqnum);
-	spin_unlock(&vdev->priv_lock);
+	spin_unlock_irqrestore(&vdev->priv_lock, flags);
 
 	if (!urb) {
 		/*
@@ -171,9 +174,9 @@ static void vhci_recv_ret_unlink(struct vhci_device *vdev,
 		urb->status = pdu->u.ret_unlink.status;
 		pr_info("urb->status %d\n", urb->status);
 
-		spin_lock(&the_controller->lock);
+		spin_lock_irqsave(&the_controller->lock, flags);
 		usb_hcd_unlink_urb_from_ep(vhci_to_hcd(the_controller), urb);
-		spin_unlock(&the_controller->lock);
+		spin_unlock_irqrestore(&the_controller->lock, flags);
 
 		usb_hcd_giveback_urb(vhci_to_hcd(the_controller), urb,
 				     urb->status);
@@ -185,10 +188,11 @@ static void vhci_recv_ret_unlink(struct vhci_device *vdev,
 static int vhci_priv_tx_empty(struct vhci_device *vdev)
 {
 	int empty = 0;
+	unsigned long flags;
 
-	spin_lock(&vdev->priv_lock);
+	spin_lock_irqsave(&vdev->priv_lock, flags);
 	empty = list_empty(&vdev->priv_rx);
-	spin_unlock(&vdev->priv_lock);
+	spin_unlock_irqrestore(&vdev->priv_lock, flags);
 
 	return empty;
 }
diff --git a/drivers/usb/usbip/vhci_sysfs.c b/drivers/usb/usbip/vhci_sysfs.c
index f05f1e0a2baf..78fd6bae9a72 100644
--- a/drivers/usb/usbip/vhci_sysfs.c
+++ b/drivers/usb/usbip/vhci_sysfs.c
@@ -32,10 +32,11 @@ static ssize_t status_show(struct device *dev, struct device_attribute *attr,
 {
 	char *s = out;
 	int i = 0;
+	unsigned long flags;
 
 	BUG_ON(!the_controller || !out);
 
-	spin_lock(&the_controller->lock);
+	spin_lock_irqsave(&the_controller->lock, flags);
 
 	/*
 	 * output example:
@@ -73,7 +74,7 @@ static ssize_t status_show(struct device *dev, struct device_attribute *attr,
 		spin_unlock(&vdev->ud.lock);
 	}
 
-	spin_unlock(&the_controller->lock);
+	spin_unlock_irqrestore(&the_controller->lock, flags);
 
 	return out - s;
 }
@@ -83,11 +84,12 @@ static DEVICE_ATTR_RO(status);
 static int vhci_port_disconnect(__u32 rhport)
 {
 	struct vhci_device *vdev;
+	unsigned long flags;
 
 	usbip_dbg_vhci_sysfs("enter\n");
 
 	/* lock */
-	spin_lock(&the_controller->lock);
+	spin_lock_irqsave(&the_controller->lock, flags);
 
 	vdev = port_to_vdev(rhport);
 
@@ -97,14 +99,14 @@ static int vhci_port_disconnect(__u32 rhport)
 
 		/* unlock */
 		spin_unlock(&vdev->ud.lock);
-		spin_unlock(&the_controller->lock);
+		spin_unlock_irqrestore(&the_controller->lock, flags);
 
 		return -EINVAL;
 	}
 
 	/* unlock */
 	spin_unlock(&vdev->ud.lock);
-	spin_unlock(&the_controller->lock);
+	spin_unlock_irqrestore(&the_controller->lock, flags);
 
 	usbip_event_add(&vdev->ud, VDEV_EVENT_DOWN);
 
@@ -180,6 +182,7 @@ static ssize_t store_attach(struct device *dev, struct device_attribute *attr,
 	int sockfd = 0;
 	__u32 rhport = 0, devid = 0, speed = 0;
 	int err;
+	unsigned long flags;
 
 	/*
 	 * @rhport: port number of vhci_hcd
@@ -205,14 +208,14 @@ static ssize_t store_attach(struct device *dev, struct device_attribute *attr,
 	/* now need lock until setting vdev status as used */
 
 	/* begin a lock */
-	spin_lock(&the_controller->lock);
+	spin_lock_irqsave(&the_controller->lock, flags);
 	vdev = port_to_vdev(rhport);
 	spin_lock(&vdev->ud.lock);
 
 	if (vdev->ud.status != VDEV_ST_NULL) {
 		/* end of the lock */
 		spin_unlock(&vdev->ud.lock);
-		spin_unlock(&the_controller->lock);
+		spin_unlock_irqrestore(&the_controller->lock, flags);
 
 		sockfd_put(socket);
 
@@ -231,7 +234,7 @@ static ssize_t store_attach(struct device *dev, struct device_attribute *attr,
 	vdev->ud.status     = VDEV_ST_NOTASSIGNED;
 
 	spin_unlock(&vdev->ud.lock);
-	spin_unlock(&the_controller->lock);
+	spin_unlock_irqrestore(&the_controller->lock, flags);
 	/* end the lock */
 
 	vdev->ud.tcp_rx = kthread_get_run(vhci_rx_loop, &vdev->ud, "vhci_rx");
diff --git a/drivers/usb/usbip/vhci_tx.c b/drivers/usb/usbip/vhci_tx.c
index 409fd99f3257..3e7878fe2fd4 100644
--- a/drivers/usb/usbip/vhci_tx.c
+++ b/drivers/usb/usbip/vhci_tx.c
@@ -47,16 +47,17 @@ static void setup_cmd_submit_pdu(struct usbip_header *pdup,  struct urb *urb)
 static struct vhci_priv *dequeue_from_priv_tx(struct vhci_device *vdev)
 {
 	struct vhci_priv *priv, *tmp;
+	unsigned long flags;
 
-	spin_lock(&vdev->priv_lock);
+	spin_lock_irqsave(&vdev->priv_lock, flags);
 
 	list_for_each_entry_safe(priv, tmp, &vdev->priv_tx, list) {
 		list_move_tail(&priv->list, &vdev->priv_rx);
-		spin_unlock(&vdev->priv_lock);
+		spin_unlock_irqrestore(&vdev->priv_lock, flags);
 		return priv;
 	}
 
-	spin_unlock(&vdev->priv_lock);
+	spin_unlock_irqrestore(&vdev->priv_lock, flags);
 
 	return NULL;
 }
@@ -136,16 +137,17 @@ static int vhci_send_cmd_submit(struct vhci_device *vdev)
 static struct vhci_unlink *dequeue_from_unlink_tx(struct vhci_device *vdev)
 {
 	struct vhci_unlink *unlink, *tmp;
+	unsigned long flags;
 
-	spin_lock(&vdev->priv_lock);
+	spin_lock_irqsave(&vdev->priv_lock, flags);
 
 	list_for_each_entry_safe(unlink, tmp, &vdev->unlink_tx, list) {
 		list_move_tail(&unlink->list, &vdev->unlink_rx);
-		spin_unlock(&vdev->priv_lock);
+		spin_unlock_irqrestore(&vdev->priv_lock, flags);
 		return unlink;
 	}
 
-	spin_unlock(&vdev->priv_lock);
+	spin_unlock_irqrestore(&vdev->priv_lock, flags);
 
 	return NULL;
 }
-- 
2.14.1


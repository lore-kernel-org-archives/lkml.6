Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AH8x225l3lneNlFOEdYSQ/eXlubt30G3Kva9++NwMRZiV7JGHtJcawzgAsYwQdEICTnbAt8RksF/
ARC-Seal: i=1; a=rsa-sha256; t=1519831339; cv=none;
        d=google.com; s=arc-20160816;
        b=CaaE6N2Q5pR45R8cdJM3Xlg7FUdkHf5fWcntxDdcwTt+W0Ao3MTfOyfSyXTae74sGd
         hG4BmGXer87eJUIMKuuOnbNWTREZoBc6Cu1uefXP+oMUFHKvlDADWrLPEnZOTggmR58k
         lfiA5LeXI4xUILOzVwaW5D94BOMPdtmcrkdx9h02Jha1rKA9+h3acQ8pHC/BGTgEP5Jx
         HNDrLLVrOQ/KmHHS5vp9XM5VhfiB7oCxkhvy+4CpxDTw1A0K3Nm9ynS97WbxhhhDBWK4
         Wmv/cAw8ZEM2sFI7W1PbqR5Vvbr5IFSdWmCz5OM6uLLy0F+iOxJk7c1M23a2L5OiCjH7
         /A3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=MpMB9KhS8gmJAO8FwWV5ZXsPJBz18VwoKspuBgdXf9o=;
        b=FCmOC0yC/0GWbHYeB6+gP3U/JjIue5aJ9yGwR2SfQQUDNRr93mOMFhjNFk0epXGQpa
         sN0awsoQyFGDlak9OW6lwaNOHdgZXVzk2UKnDzseewpE+s+mOwbPThp2w1ZYFKQg29H/
         +NJpSUqyCciOoHqc6XYikxshS+uao33yzUDQIOQ+aColXHbtwA4omxdLLYEw6aaSbSiN
         pVxMmwJfm+k/ZDPjRwkZna3SLyK8yel+jQCJfCG8RYL1LUGtL1ZPDcYGS0RubuNdXt2r
         bH86FpMM/JOI2nztD2i3t3RfTYx7bjPCRFL1hZnJBrnbNEb7ygaD8ZQxENuqNK5vapeg
         ziTQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
 "Shuah Khan" <shuahkh@osg.samsung.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Date: Wed, 28 Feb 2018 15:20:21 +0000
Message-ID: <lsq.1519831221.257453393@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 058/140] usbip: vhci: stop printing kernel pointer
 addresses in messages
In-Reply-To: <lsq.1519831221.703311959@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593658666875750097?=
X-GMAIL-MSGID: =?utf-8?q?1593658666875750097?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.100-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Shuah Khan <shuahkh@osg.samsung.com>

commit 8272d099d05f7ab2776cf56a2ab9f9443be18907 upstream.

Remove and/or change debug, info. and error messages to not print
kernel pointer addresses.

Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[bwh: Backported to 3.2: adjust filenames, context, indentation]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/staging/usbip/vhci_hcd.c | 10 ----------
 drivers/staging/usbip/vhci_rx.c  | 23 +++++++++++------------
 drivers/staging/usbip/vhci_tx.c  |  3 ++-
 3 files changed, 13 insertions(+), 23 deletions(-)

--- a/drivers/staging/usbip/vhci_hcd.c
+++ b/drivers/staging/usbip/vhci_hcd.c
@@ -516,9 +516,6 @@ static int vhci_urb_enqueue(struct usb_h
 	unsigned long flags;
 	struct vhci_device *vdev;
 
-	usbip_dbg_vhci_hc("enter, usb_hcd %p urb %p mem_flags %d\n",
-			  hcd, urb, mem_flags);
-
 	/* patch to usb_sg_init() is in 2.5.60 */
 	BUG_ON(!urb->transfer_buffer && urb->transfer_buffer_length);
 
@@ -677,8 +674,6 @@ static int vhci_urb_dequeue(struct usb_h
 	struct vhci_priv *priv;
 	struct vhci_device *vdev;
 
-	pr_info("dequeue a urb %p\n", urb);
-
 	spin_lock_irqsave(&the_controller->lock, flags);
 
 	priv = urb->hcpriv;
@@ -707,7 +702,6 @@ static int vhci_urb_dequeue(struct usb_h
 
 		spin_lock_irqsave(&vdev->priv_lock, flags2);
 
-		pr_info("device %p seems to be disconnected\n", vdev);
 		list_del(&priv->list);
 		kfree(priv);
 		urb->hcpriv = NULL;
@@ -719,8 +713,6 @@ static int vhci_urb_dequeue(struct usb_h
 		 * vhci_rx will receive RET_UNLINK and give back the URB.
 		 * Otherwise, we give back it here.
 		 */
-		pr_info("gives back urb %p\n", urb);
-
 		usb_hcd_unlink_urb_from_ep(hcd, urb);
 
 		spin_unlock_irqrestore(&the_controller->lock, flags);
@@ -751,8 +743,6 @@ static int vhci_urb_dequeue(struct usb_h
 
 		unlink->unlink_seqnum = priv->seqnum;
 
-		pr_info("device %p seems to be still connected\n", vdev);
-
 		/* send cmd_unlink and try to cancel the pending URB in the
 		 * peer */
 		list_add_tail(&unlink->list, &vdev->unlink_tx);
--- a/drivers/staging/usbip/vhci_rx.c
+++ b/drivers/staging/usbip/vhci_rx.c
@@ -35,21 +35,19 @@ struct urb *pickup_urb_and_free_priv(str
 			urb = priv->urb;
 			status = urb->status;
 
-			usbip_dbg_vhci_rx("find urb %p vurb %p seqnum %u\n",
-					  urb, priv, seqnum);
+			usbip_dbg_vhci_rx("find urb seqnum %u\n", seqnum);
 
 			/* TODO: fix logic here to improve indent situtation */
 			if (status != -EINPROGRESS) {
 				if (status == -ENOENT ||
 				    status == -ECONNRESET)
-					dev_info(&urb->dev->dev,
-						 "urb %p was unlinked "
-						 "%ssynchronuously.\n", urb,
-						 status == -ENOENT ? "" : "a");
+					dev_dbg(&urb->dev->dev,
+						"urb seq# %u was unlinked %ssynchronuously\n",
+						seqnum, status == -ENOENT ? "" : "a");
 				else
-					dev_info(&urb->dev->dev,
-						 "urb %p may be in a error, "
-						 "status %d\n", urb, status);
+					dev_dbg(&urb->dev->dev,
+						"urb seq# %u may be in a error, status %d\n",
+						seqnum, status);
 			}
 
 			list_del(&priv->list);
@@ -75,8 +73,8 @@ static void vhci_recv_ret_submit(struct
 	spin_unlock(&vdev->priv_lock);
 
 	if (!urb) {
-		pr_err("cannot find a urb of seqnum %u\n", pdu->base.seqnum);
-		pr_info("max seqnum %d\n",
+		pr_err("cannot find a urb of seqnum %u max seqnum %d\n",
+			pdu->base.seqnum,
 			atomic_read(&the_controller->seqnum));
 		usbip_event_add(ud, VDEV_EVENT_ERROR_TCP);
 		return;
@@ -99,7 +97,7 @@ static void vhci_recv_ret_submit(struct
 	if (usbip_dbg_flag_vhci_rx)
 		usbip_dump_urb(urb);
 
-	usbip_dbg_vhci_rx("now giveback urb %p\n", urb);
+	usbip_dbg_vhci_rx("now giveback urb %u\n", pdu->base.seqnum);
 
 	spin_lock_irqsave(&the_controller->lock, flags);
 	usb_hcd_unlink_urb_from_ep(vhci_to_hcd(the_controller), urb);
@@ -165,7 +163,7 @@ static void vhci_recv_ret_unlink(struct
 		pr_info("the urb (seqnum %d) was already given backed\n",
 			pdu->base.seqnum);
 	} else {
-		usbip_dbg_vhci_rx("now giveback urb %p\n", urb);
+		usbip_dbg_vhci_rx("now giveback urb %d\n", pdu->base.seqnum);
 
 		/* If unlink is succeed, status is -ECONNRESET */
 		urb->status = pdu->u.ret_unlink.status;
--- a/drivers/staging/usbip/vhci_tx.c
+++ b/drivers/staging/usbip/vhci_tx.c
@@ -83,7 +83,8 @@ static int vhci_send_cmd_submit(struct v
 		memset(&msg, 0, sizeof(msg));
 		memset(&iov, 0, sizeof(iov));
 
-		usbip_dbg_vhci_tx("setup txdata urb %p\n", urb);
+		usbip_dbg_vhci_tx("setup txdata urb seqnum %lu\n",
+				  priv->seqnum);
 
 		/* 1. setup usbip_header */
 		setup_cmd_submit_pdu(&pdu_header, urb);

Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AH8x224P+DWyNFgZIzqH4th7Hba0hgztbxBixtxfW+QJDvv4gy+U8el6E0ZqwHePlI1A0bG2LlsZ
ARC-Seal: i=1; a=rsa-sha256; t=1519831347; cv=none;
        d=google.com; s=arc-20160816;
        b=WSSXLHiMuf4f3PGWMz9x//Lty5vtLXRo5be27CRdBVIHmjS5SPw/NN2U24Ytvp0duR
         FH/6EjykSHbxcnl12E+QItTu+29V/CbjI3/Xtb669fjShwsZfDQMth4M+Zw2erdp8u9+
         vkZmJCg/s3J8+TB5UgbtdkBGKrgbDchAGfurzszCn5vqwJdXbNTNfmELl9iggjIviaYO
         LGcpWGRIYZFu76mcO1CGKdcJxGP30jq7d9AMrTeFi/99l8duD43obI+9NTLZWYPQr/a0
         wu7q1rpf3XHFMGZZ04wM1HXZzgXhGzZm01tw/YDSl5iBGmt32tdTKZDa+FopNVaplT+P
         1n5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=OPk4gRrI3wXxWkWp8ibnNJ3Mbvg2FDcRxXBsB3QVDco=;
        b=wKB11uTesr4a2dxFIMlPnGEZcnIrex7RqsTJtCwVyhpCdkziqb06809VNDLel5akeK
         Sks9Gxx4+daUSYfiFjAksWQZWMn2IMKefH/Qwr/rt2GqRENrc9vaKQvrOA31K7MGaLUh
         mKJ5yNyJvD9JLT7+/zWawN3HWMj9zPpd97ZZdqkA1490FUmsVTUjtcQ6VUckptfiWLQw
         SrPpmpH9xBsfTEpUR8mXwzRevjAbUpf+iDkP87L+1dTSd2T6Kjphulu5O91nzbBCvpks
         SHulur+iWmttg9Kc32GHEiUvn1aROzA3CS0Dl5GsnxUcW3rPZmgOD919lzIyWa9ijbMl
         kK3g==
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
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.569196534@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 127/254] usbip: vhci: stop printing kernel pointer
 addresses in messages
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593658666875750097?=
X-GMAIL-MSGID: =?utf-8?q?1593658674346204441?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.55-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Shuah Khan <shuahkh@osg.samsung.com>

commit 8272d099d05f7ab2776cf56a2ab9f9443be18907 upstream.

Remove and/or change debug, info. and error messages to not print
kernel pointer addresses.

Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[bwh: Backported to 3.16: adjust filenames, context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/staging/usbip/vhci_hcd.c | 10 ----------
 drivers/staging/usbip/vhci_rx.c  | 23 +++++++++++------------
 drivers/staging/usbip/vhci_tx.c  |  3 ++-
 3 files changed, 13 insertions(+), 23 deletions(-)

--- a/drivers/staging/usbip/vhci_hcd.c
+++ b/drivers/staging/usbip/vhci_hcd.c
@@ -466,9 +466,6 @@ static int vhci_urb_enqueue(struct usb_h
 	int ret = 0;
 	struct vhci_device *vdev;
 
-	usbip_dbg_vhci_hc("enter, usb_hcd %p urb %p mem_flags %d\n",
-			  hcd, urb, mem_flags);
-
 	/* patch to usb_sg_init() is in 2.5.60 */
 	BUG_ON(!urb->transfer_buffer && urb->transfer_buffer_length);
 
@@ -626,8 +623,6 @@ static int vhci_urb_dequeue(struct usb_h
 	struct vhci_priv *priv;
 	struct vhci_device *vdev;
 
-	pr_info("dequeue a urb %p\n", urb);
-
 	spin_lock(&the_controller->lock);
 
 	priv = urb->hcpriv;
@@ -655,7 +650,6 @@ static int vhci_urb_dequeue(struct usb_h
 		/* tcp connection is closed */
 		spin_lock(&vdev->priv_lock);
 
-		pr_info("device %p seems to be disconnected\n", vdev);
 		list_del(&priv->list);
 		kfree(priv);
 		urb->hcpriv = NULL;
@@ -667,8 +661,6 @@ static int vhci_urb_dequeue(struct usb_h
 		 * vhci_rx will receive RET_UNLINK and give back the URB.
 		 * Otherwise, we give back it here.
 		 */
-		pr_info("gives back urb %p\n", urb);
-
 		usb_hcd_unlink_urb_from_ep(hcd, urb);
 
 		spin_unlock(&the_controller->lock);
@@ -697,8 +689,6 @@ static int vhci_urb_dequeue(struct usb_h
 
 		unlink->unlink_seqnum = priv->seqnum;
 
-		pr_info("device %p seems to be still connected\n", vdev);
-
 		/* send cmd_unlink and try to cancel the pending URB in the
 		 * peer */
 		list_add_tail(&unlink->list, &vdev->unlink_tx);
--- a/drivers/staging/usbip/vhci_rx.c
+++ b/drivers/staging/usbip/vhci_rx.c
@@ -37,24 +37,23 @@ struct urb *pickup_urb_and_free_priv(str
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
@@ -78,8 +77,8 @@ static void vhci_recv_ret_submit(struct
 	spin_unlock(&vdev->priv_lock);
 
 	if (!urb) {
-		pr_err("cannot find a urb of seqnum %u\n", pdu->base.seqnum);
-		pr_info("max seqnum %d\n",
+		pr_err("cannot find a urb of seqnum %u max seqnum %d\n",
+			pdu->base.seqnum,
 			atomic_read(&the_controller->seqnum));
 		usbip_event_add(ud, VDEV_EVENT_ERROR_TCP);
 		return;
@@ -102,7 +101,7 @@ static void vhci_recv_ret_submit(struct
 	if (usbip_dbg_flag_vhci_rx)
 		usbip_dump_urb(urb);
 
-	usbip_dbg_vhci_rx("now giveback urb %p\n", urb);
+	usbip_dbg_vhci_rx("now giveback urb %u\n", pdu->base.seqnum);
 
 	spin_lock(&the_controller->lock);
 	usb_hcd_unlink_urb_from_ep(vhci_to_hcd(the_controller), urb);
@@ -167,7 +166,7 @@ static void vhci_recv_ret_unlink(struct
 		pr_info("the urb (seqnum %d) was already given back\n",
 			pdu->base.seqnum);
 	} else {
-		usbip_dbg_vhci_rx("now giveback urb %p\n", urb);
+		usbip_dbg_vhci_rx("now giveback urb %d\n", pdu->base.seqnum);
 
 		/* If unlink is successful, status is -ECONNRESET */
 		urb->status = pdu->u.ret_unlink.status;
--- a/drivers/staging/usbip/vhci_tx.c
+++ b/drivers/staging/usbip/vhci_tx.c
@@ -82,7 +82,8 @@ static int vhci_send_cmd_submit(struct v
 		memset(&msg, 0, sizeof(msg));
 		memset(&iov, 0, sizeof(iov));
 
-		usbip_dbg_vhci_tx("setup txdata urb %p\n", urb);
+		usbip_dbg_vhci_tx("setup txdata urb seqnum %lu\n",
+				  priv->seqnum);
 
 		/* 1. setup usbip_header */
 		setup_cmd_submit_pdu(&pdu_header, urb);

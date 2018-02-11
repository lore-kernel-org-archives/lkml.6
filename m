Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AH8x227IIqUL2F/vS59ZKjSu5e7Ac2C0gpfKjnBe6un5b1QJdaIvTfQIqQdNqlsr80sM49B6vOx9
ARC-Seal: i=1; a=rsa-sha256; t=1518323622; cv=none;
        d=google.com; s=arc-20160816;
        b=TWMUf1EiZKZcy/MJ/AigCr3RYO3p+sIX3b5qQEbz5tup/bSa8eIT+2chOQ12XFyBJA
         r+1LzRoANwZGNR8p6lXYPd0VBQ09E0977dDgvOnuIPLLA3L0iMdz91p3DNgQYN29AlL9
         IWu5ZnCOeC7L0REHw4WgMpj7tNGUWG8lSgF3IvOE3dWe+gzHkwEPq93tIwDn7bt4xXv9
         3pWj1kaiqr4NYW0WdETrmPPlqsfGHkhS4GSnDDTcmq/pUIb/zwTUb3CuOvjCnz2vtnL1
         zvmMzs8+juje9H4n1oNop1fS3t7Bksr6DTLwKGUYRIRFekW91z9EDk7GnLxfafnI+FVv
         7vbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=eHVDf1Jsccrrlr7KujAOZwJyP+3R5znqraePdRp55yA=;
        b=uPLvBk1E0PegTowwOSFivSaD02RYqZLkrJRZddJ4/bO/M8l0U7UMsQpYIj7p8FqqMb
         SXSPcTt8681DzDCpaus0YgkT4BteKqqWnDnOYGi3pitg5XtQBwsvpGDbVPI+akHo9Ce9
         dt113Q7k9kMisaJo92rUTRt3N0ROJoJhJv8zn7ZTzKgRY6ygYh5w8CiNbkmhDaYf82sC
         0llqkmITJi5GOep5Fi1aKJOYuSqylG9O/8Ud5hnqOw5A3SWrpcoOd8eZS8300kueVDLs
         6ooHPSzGgLgT9k/agv7IJBsqQQOw3vrLCLuLvgTGt/mfk/fbp0JTJ4eQwqU7aIb/nTzc
         DVUw==
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
 "Bart Westgeest" <bart@elbrys.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Date: Sun, 11 Feb 2018 04:20:06 +0000
Message-ID: <lsq.1518322806.620833136@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 70/79] staging: usbip: removed #if 0'd out code
In-Reply-To: <lsq.1518322802.943358572@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592077710405660120?=
X-GMAIL-MSGID: =?utf-8?q?1592077710405660120?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.99-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Bart Westgeest <bart@elbrys.com>

commit 34c09578179f5838e5958c45e8aed4edc9c6c3b8 upstream.

Signed-off-by: Bart Westgeest <bart@elbrys.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/staging/usbip/stub_rx.c  |  9 ---------
 drivers/staging/usbip/vhci_hcd.c | 39 ---------------------------------------
 2 files changed, 48 deletions(-)

--- a/drivers/staging/usbip/stub_rx.c
+++ b/drivers/staging/usbip/stub_rx.c
@@ -367,15 +367,6 @@ static int get_pipe(struct stub_device *
 	}
 
 	epd = &ep->desc;
-#if 0
-	/* epnum 0 is always control */
-	if (epnum == 0) {
-		if (dir == USBIP_DIR_OUT)
-			return usb_sndctrlpipe(udev, 0);
-		else
-			return usb_rcvctrlpipe(udev, 0);
-	}
-#endif
 	if (usb_endpoint_xfer_control(epd)) {
 		if (dir == USBIP_DIR_OUT)
 			return usb_sndctrlpipe(udev, epnum);
--- a/drivers/staging/usbip/vhci_hcd.c
+++ b/drivers/staging/usbip/vhci_hcd.c
@@ -391,29 +391,6 @@ static int vhci_hub_control(struct usb_h
 				dum->port_status[rhport] |=
 					USB_PORT_STAT_ENABLE;
 			}
-#if 0
-			if (dum->driver) {
-				dum->port_status[rhport] |=
-					USB_PORT_STAT_ENABLE;
-				/* give it the best speed we agree on */
-				dum->gadget.speed = dum->driver->speed;
-				dum->gadget.ep0->maxpacket = 64;
-				switch (dum->gadget.speed) {
-				case USB_SPEED_HIGH:
-					dum->port_status[rhport] |=
-						USB_PORT_STAT_HIGH_SPEED;
-					break;
-				case USB_SPEED_LOW:
-					dum->gadget.ep0->maxpacket = 8;
-					dum->port_status[rhport] |=
-						USB_PORT_STAT_LOW_SPEED;
-					break;
-				default:
-					dum->gadget.speed = USB_SPEED_FULL;
-					break;
-				}
-			}
-#endif
 		}
 		((u16 *) buf)[0] = cpu_to_le16(dum->port_status[rhport]);
 		((u16 *) buf)[1] = cpu_to_le16(dum->port_status[rhport] >> 16);
@@ -430,15 +407,6 @@ static int vhci_hub_control(struct usb_h
 		case USB_PORT_FEAT_SUSPEND:
 			usbip_dbg_vhci_rh(" SetPortFeature: "
 					  "USB_PORT_FEAT_SUSPEND\n");
-#if 0
-			dum->port_status[rhport] |=
-				(1 << USB_PORT_FEAT_SUSPEND);
-			if (dum->driver->suspend) {
-				spin_unlock(&dum->lock);
-				dum->driver->suspend(&dum->gadget);
-				spin_lock(&dum->lock);
-			}
-#endif
 			break;
 		case USB_PORT_FEAT_RESET:
 			usbip_dbg_vhci_rh(" SetPortFeature: "
@@ -449,13 +417,6 @@ static int vhci_hub_control(struct usb_h
 					~(USB_PORT_STAT_ENABLE |
 					  USB_PORT_STAT_LOW_SPEED |
 					  USB_PORT_STAT_HIGH_SPEED);
-#if 0
-				if (dum->driver) {
-					dev_dbg(hardware, "disconnect\n");
-					stop_activity(dum, dum->driver);
-				}
-#endif
-
 				/* FIXME test that code path! */
 			}
 			/* 50msec reset signaling */

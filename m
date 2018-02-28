Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AG47ELtMDA7PYzvQehG0AfLCc0cxZln5a/YxLvN5H4MRhCmgPa6eOVkvRlBtq5z+9Y8HKN2MTHxA
ARC-Seal: i=1; a=rsa-sha256; t=1519831337; cv=none;
        d=google.com; s=arc-20160816;
        b=qo+h8ySgMV2gKIY9YzGzzOuHbgSj1DBaB3b4mD7D/tILBtCBhBXmnJyD6NegsAS5V0
         LoTpswege7KtQyiUcwwOQUYxTk1DpO2TPcqAFm+Nn9BFkHeravALwNS7nH3G415towtB
         7zJnxwrOCLPt6qVzgR00O4bkVaEhgVdCcorghygMgfLPSQo3UyS3H1oFGjtIBJ7rQP5h
         Gh8u9PaEjv6I0iSB2+uljN00kOVXfgwQ0J0Df0Lfo2w1jfxs9GioqA6Pbjshk/vUctZD
         9kxWyDf77uPjdXebT7+2URigPWcd9OiX+SN1V53Yrz03BrzyGaf20hz7SvPbEpEIOrXd
         an6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=A/CPOAbFoZC5JbOSbVri6UtZXbYSSgrC4oq+PKhcUrk=;
        b=ab3QOk89HwSNZoaDWBKEch778IAIfw87oi5KZDCmFgF6f/pikBxq7OVW4eCyjwdDfh
         PXEKDQ9ont0cvc3WvrxbFonx0z1jxBC+jkV0bPDsoSPZd4RJ1nzuH5oOJcqvV6cdqks6
         xlsUvnne36fnHWUpHKTfJqi2umgEdbKQOsE8+inCbB1HHjZxcl89kEuKhq7pNql1c/XO
         0NkGC8TXPeKyoZlQ0UE9CdDzD1QvkC9UM/vxZxsq11v+0pEZ/iX8kRDXoXmNJS+/JsXv
         dF0jvbAbQF37R0nZ2SI9KLzoiu5rXluILNMYr5EWnPPOdnz+aXlBZbIGOVxu9wtzOwk6
         XlbA==
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
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Shuah Khan" <shuahkh@osg.samsung.com>
Date: Wed, 28 Feb 2018 15:20:21 +0000
Message-ID: <lsq.1519831221.472115808@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 059/140] usbip: stub: stop printing kernel pointer
 addresses in messages
In-Reply-To: <lsq.1519831221.703311959@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593658664414227382?=
X-GMAIL-MSGID: =?utf-8?q?1593658664414227382?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.100-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Shuah Khan <shuahkh@osg.samsung.com>

commit 248a22044366f588d46754c54dfe29ffe4f8b4df upstream.

Remove and/or change debug, info. and error messages to not print
kernel pointer addresses.

Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[bwh: Backported to 3.2:
 - Drop change in stub_complete()
 - Adjust filenames, context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/staging/usbip/stub_main.c | 5 +++--
 drivers/staging/usbip/stub_rx.c   | 7 ++-----
 drivers/staging/usbip/stub_tx.c   | 6 +++---
 3 files changed, 8 insertions(+), 10 deletions(-)

--- a/drivers/staging/usbip/stub_main.c
+++ b/drivers/staging/usbip/stub_main.c
@@ -227,11 +227,12 @@ void stub_device_cleanup_urbs(struct stu
 	struct stub_priv *priv;
 	struct urb *urb;
 
-	dev_dbg(&sdev->udev->dev, "free sdev %p\n", sdev);
+	dev_dbg(&sdev->udev->dev, "Stub device cleaning up urbs\n");
 
 	while ((priv = stub_priv_pop(sdev))) {
 		urb = priv->urb;
-		dev_dbg(&sdev->udev->dev, "free urb %p\n", urb);
+		dev_dbg(&sdev->udev->dev, "free urb seqnum %lu\n",
+			priv->seqnum);
 		usb_kill_urb(urb);
 
 		kmem_cache_free(stub_priv_cache, priv);
--- a/drivers/staging/usbip/stub_rx.c
+++ b/drivers/staging/usbip/stub_rx.c
@@ -239,9 +239,6 @@ static int stub_recv_cmd_unlink(struct s
 		if (priv->seqnum == pdu->u.cmd_unlink.seqnum) {
 			int ret;
 
-			dev_info(&priv->urb->dev->dev, "unlink urb %p\n",
-				 priv->urb);
-
 			/*
 			 * This matched urb is not completed yet (i.e., be in
 			 * flight in usb hcd hardware/driver). Now we are
@@ -280,8 +277,8 @@ static int stub_recv_cmd_unlink(struct s
 			ret = usb_unlink_urb(priv->urb);
 			if (ret != -EINPROGRESS)
 				dev_err(&priv->urb->dev->dev,
-					"failed to unlink a urb %p, ret %d\n",
-					priv->urb, ret);
+					"failed to unlink a urb # %lu, ret %d\n",
+					priv->seqnum, ret);
 			return 0;
 		}
 	}
--- a/drivers/staging/usbip/stub_tx.c
+++ b/drivers/staging/usbip/stub_tx.c
@@ -201,8 +201,8 @@ static int stub_send_ret_submit(struct s
 
 		/* 1. setup usbip_header */
 		setup_ret_submit_pdu(&pdu_header, urb);
-		usbip_dbg_stub_tx("setup txdata seqnum: %d urb: %p\n",
-				  pdu_header.base.seqnum, urb);
+		usbip_dbg_stub_tx("setup txdata seqnum: %d\n",
+				  pdu_header.base.seqnum);
 		/*usbip_dump_header(pdu_header);*/
 		usbip_header_correct_endian(&pdu_header, 1);
 

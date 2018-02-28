Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AG47ELuVpnSYEUL9JykhjIRtSvUQOq6Ig3spHsodMuE5C1v2Jb4VvLH4HqFYu0GupdiCiB6XE4tP
ARC-Seal: i=1; a=rsa-sha256; t=1519831344; cv=none;
        d=google.com; s=arc-20160816;
        b=I5DapMNRPRTe+en1q/TSEatHMMY0n35vHA+pX4kPhHxIMoBAybNmClV7bPwhFbOBJj
         z1xX2UGyRI5W9E7QgNnvicfJ9NXndrT/DCAaxeyGIPaWJ3NWMDTAv+LJKWBSc5s6sA/+
         XC5wFSauVhNU7VV4Vjl2dJdPKoIgMYlcfcLYa8jJ3b3n3ChAUdsGBU6CYRmlIW6FEKlv
         GyvC4iFqLH86QhsdMuQmjVAQcaD1UEPvD+SRi39dfpF/2T8byeQRTua5pOjTTbs46P04
         yFu9uGJ9aRwEVfWiIcKawOMcbm1eTtQWpmzW7Kf4LeUP0eNJhy4euReLNfTQbQl2L6Jg
         TIEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=SmfHUqHirySy5Er1Zf/s4X3OQbs6O/cEYv7kMTme39M=;
        b=jL+uSGSzcmkH0BWNgBbk+sQ2MekeCFnJjjnK6Jh6AoIzK4JWtF1MXo46cA6FHjZIyi
         CCGPx6RuybJ9RjIsTUiI0oyQ7/wG54JzR9r1z7cr3yxgX4OYFqu72bXj12KerjWQ7P5R
         IMuQJ0ZS1m8KznIbQcWDVkX7q+q1uIzQvWW4+1XN574wU8RwsD05WMw3Y3CfXshz6mV2
         BylNZo53Na5EJ3Tl5DKLOlKy8uEbsfpqm8zBgbNdzHsWcmxEn6nEgI7NSFcJmCcDqYnS
         hCQuZn8Z+ZCDN5LnhDmuTitVLOgjl0HRjwyGkqOqO36eIxNEfpL4EgOw9aQRj4vVCydA
         8HOA==
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
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.420930271@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 128/254] usbip: stub: stop printing kernel pointer
 addresses in messages
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593658664414227382?=
X-GMAIL-MSGID: =?utf-8?q?1593658671803805142?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.55-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Shuah Khan <shuahkh@osg.samsung.com>

commit 248a22044366f588d46754c54dfe29ffe4f8b4df upstream.

Remove and/or change debug, info. and error messages to not print
kernel pointer addresses.

Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[bwh: Backported to 3.16:
 - Drop change in stub_complete()
 - Adjust filenames]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/staging/usbip/stub_main.c | 5 +++--
 drivers/staging/usbip/stub_rx.c   | 7 ++-----
 drivers/staging/usbip/stub_tx.c   | 6 +++---
 3 files changed, 8 insertions(+), 10 deletions(-)

--- a/drivers/staging/usbip/stub_main.c
+++ b/drivers/staging/usbip/stub_main.c
@@ -256,11 +256,12 @@ void stub_device_cleanup_urbs(struct stu
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
@@ -225,9 +225,6 @@ static int stub_recv_cmd_unlink(struct s
 		if (priv->seqnum != pdu->u.cmd_unlink.seqnum)
 			continue;
 
-		dev_info(&priv->urb->dev->dev, "unlink urb %p\n",
-			 priv->urb);
-
 		/*
 		 * This matched urb is not completed yet (i.e., be in
 		 * flight in usb hcd hardware/driver). Now we are
@@ -266,8 +263,8 @@ static int stub_recv_cmd_unlink(struct s
 		ret = usb_unlink_urb(priv->urb);
 		if (ret != -EINPROGRESS)
 			dev_err(&priv->urb->dev->dev,
-				"failed to unlink a urb %p, ret %d\n",
-				priv->urb, ret);
+				"failed to unlink a urb # %lu, ret %d\n",
+				priv->seqnum, ret);
 
 		return 0;
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
 		usbip_header_correct_endian(&pdu_header, 1);
 
 		iov[iovnum].iov_base = &pdu_header;

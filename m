Return-Path: <daniel@gimpelevich.san-francisco.ca.us>
ARC-Seal: i=1; a=rsa-sha256; t=1521543562; cv=none;
        d=google.com; s=arc-20160816;
        b=qd0WH+x1yGSc/HMZsKkKg8SkzZl8jUW1SzaD4xHJ+zuJXwFsRsLWpIY8ya6slj5f1i
         CXClAkc1UwO0fZfGrsxvV9sE5x+QBxMadihjHGId0ThaR0m4KuD6ypDy6ECunxA6GLkV
         m0zhcodVFd27DXQToslg5gtcmwNdFoJIefUCnHqktbOY4az/AJNPh57BpsQoUd0AsfIl
         YZRyhibnO4TNWRqJmoL52S86zTfqf63QnuXhx8BT3Ia03I/SXAu8+VzQdcmY/JOmv1Cj
         fwbF0p6eyPKvkDrz4cJQ4k5O7XOm4hQHZkt1huUV5ml/tkHEkRmhwgKRYi4J97Fb2SqS
         Xw+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=Ll0XmxD2S4kKK8tqrNAsoNbQR2GSfZqIusYEK9jZakM=;
        b=yuySajLD+WavTrG4Eh8nuoOs6fOomE3LZivJYoaAQp8iMhqNDKSesXOPpujrlG/hy/
         dqdu0+wvi02f872sPzpL0Flm/T7m2U16PLSNUV+jAVNs1BbxsIN4DWX6DA5TwmMrVIal
         wsLaZ1xKONfOW6RrvmCm4moGCyaLeyAPVRI7UpnYdBwNrSbVnnAXYWAINr9OZ4d5nC++
         jpRioaJF9xHMVp4MACLxHlBcIRy1Mxvy0T6/HXDMb51RWmktZMR3YvZoMs4aieItFOYh
         ag9qmzmMqLP2nuAlx52swGaHQ2L4RcM7pgHN9ddYCDrNNYL/JWhLFQyiC9kBkyQ2tsmK
         /8PA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gimpelevich-san-francisco-ca-us.20150623.gappssmtp.com header.s=20150623 header.b=biC/Lp52;
       spf=pass (google.com: domain of daniel@gimpelevich.san-francisco.ca.us designates 209.85.220.65 as permitted sender) smtp.mailfrom=daniel@gimpelevich.san-francisco.ca.us
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gimpelevich-san-francisco-ca-us.20150623.gappssmtp.com header.s=20150623 header.b=biC/Lp52;
       spf=pass (google.com: domain of daniel@gimpelevich.san-francisco.ca.us designates 209.85.220.65 as permitted sender) smtp.mailfrom=daniel@gimpelevich.san-francisco.ca.us
X-Google-Smtp-Source: AG47ELvMm241WraB34wiTqZhDf5IDMhIcQz9MiJEqJObvb4zuzDZo1YT08FlZnRdq3ham4sezyQEpg==
From: Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>
To: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: johan@kernel.org,
	richard.leitner@skidata.com,
	felipe.balbi@linux.intel.com,
	Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>
Subject: [PATCH v2] USB: misc: uss720: more vendor/product ID's
Date: Tue, 20 Mar 2018 03:58:47 -0700
Message-Id: <1521543527-12914-1-git-send-email-daniel@gimpelevich.san-francisco.ca.us>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <20180320093759.GA22605@kroah.com>
References: <20180320093759.GA22605@kroah.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595454061878710663?=
X-GMAIL-MSGID: =?utf-8?q?1595454061878710663?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Reporting two more VID/PID pairs that work with this driver, having used
an informational webpage <http://reboots.g-cipher.net/lcd/> as a buying
guide now. The page listed additional working VID/PID pairs but did not
include these two. None were upstreamed. Also taking this opportunity to
sort the pairs numerically.

Of the two such cables now in my possession, one is white, bearing the
In-System Design ISD-103 label on one side, sold as an Epson CAEUL0002
"USB to Parallel Smart Cable For Apple Macintosh Computers" (04b8:0002),
and the other is black, bearing the In-System Design ISD-101 label on one
side, sold as an early Belkin F5U002 (05ab:0002).

Signed-off-by: Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>
---
 drivers/usb/misc/uss720.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/misc/uss720.c b/drivers/usb/misc/uss720.c
index 263c97f..de9a502 100644
--- a/drivers/usb/misc/uss720.c
+++ b/drivers/usb/misc/uss720.c
@@ -769,10 +769,15 @@ static void uss720_disconnect(struct usb_interface *intf)
 /* table of cables that work through this driver */
 static const struct usb_device_id uss720_table[] = {
 	{ USB_DEVICE(0x047e, 0x1001) },
+	{ USB_DEVICE(0x04b8, 0x0002) },
+	{ USB_DEVICE(0x04b8, 0x0003) },
+	{ USB_DEVICE(0x050d, 0x0002) },
+	{ USB_DEVICE(0x050d, 0x1202) },
 	{ USB_DEVICE(0x0557, 0x2001) },
+	{ USB_DEVICE(0x05ab, 0x0002) },
+	{ USB_DEVICE(0x06c6, 0x0100) },
 	{ USB_DEVICE(0x0729, 0x1284) },
 	{ USB_DEVICE(0x1293, 0x0002) },
-	{ USB_DEVICE(0x050d, 0x0002) },
 	{ }						/* Terminating entry */
 };
 
-- 
1.9.1

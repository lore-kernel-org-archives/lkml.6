Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AG47ELuhVczGfPYzNa56tfBXF7+YLQYLWiS45qCXV62E8pNfLJWaPStsOjmC7W7KYHXEiMWH0VCF
ARC-Seal: i=1; a=rsa-sha256; t=1519831336; cv=none;
        d=google.com; s=arc-20160816;
        b=oxWAtZsjv9BB2a1Rjr+Y1zNuDLjFmqyP/qUP4ELRBucbPVFE/ZG0+QkZSJB43jGKI2
         j0mWcBVStrdxB0YwDmyKTwa2s/tYUywHXK9D71f3A/PQFnSKMwyQOAfONI0E45FSLxUs
         TnMU9422Tw2kt877KHTU6lVPoD1ngJctk91cf9x6UCQH3wWZl4rorja4V9M8/5uCp0AO
         2YakZi5h06sXPiLNBiUeDp2VCUfAW3fqUlQyrHBmzB68ztFTUFV/fM05UudQqtIe03rQ
         IR7Yn8GgxQ+yBCy2f6HPKFbBDXAPWNoNQDa8eH2uZ3FDRcv0oxW/lNY5CK2cHE8vm0A+
         UvSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=stWkUm3B6fN71vj/2lnO8GOCTMc+9obiXysDx3TpGuw=;
        b=n3jaNCpjHVKXZQh+f94D9M09vvpIGGRh8ugy1VsXTWpuL1Ns2aDxC4w0AWy/CzuX/4
         mVfbK3wIC3LStsL9FIYVPHxF40/SPWKqvwylmH69/IwORDpuqNSk8AdUUN7MkjFI+KKu
         2dvawgqjTQvfl2SBCI/rRx2phUEuoZqRoVHODVzHl7N8s/3Z6k/EZBGnMsufdzfpUVT4
         saqactU1rXN/1HIGtqJwGBnCS/0G52x6RJThy8sYfXBv2pue3VB7LveofOssT+LJCObF
         liV19hVBE0VVOhhD3RNz4ecDLQv+QLDBz8mZN0JTNlZoblV6gAXhQcMLQM+J9oh74+u9
         jeXA==
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
 "Dmitry Fleytman Dmitry Fleytman" <dmitry.fleytman@gmail.com>
Date: Wed, 28 Feb 2018 15:20:22 +0000
Message-ID: <lsq.1519831222.630668146@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 063/140] usb: Add device quirk for Logitech HD Pro
 Webcam C925e
In-Reply-To: <lsq.1519831221.703311959@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593658663305028477?=
X-GMAIL-MSGID: =?utf-8?q?1593658663305028477?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.100-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Fleytman Dmitry Fleytman <dmitry.fleytman@gmail.com>

commit 7f038d256c723dd390d2fca942919573995f4cfd upstream.

Commit e0429362ab15
("usb: Add device quirk for Logitech HD Pro Webcams C920 and C930e")
introduced quirk to workaround an issue with some Logitech webcams.

There is one more model that has the same issue - C925e, so applying
the same quirk as well.

See aforementioned commit message for detailed explanation of the problem.

Signed-off-by: Dmitry Fleytman <dmitry.fleytman@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/usb/core/quirks.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -53,10 +53,11 @@ static const struct usb_device_id usb_qu
 	/* Microsoft LifeCam-VX700 v2.0 */
 	{ USB_DEVICE(0x045e, 0x0770), .driver_info = USB_QUIRK_RESET_RESUME },
 
-	/* Logitech HD Pro Webcams C920, C920-C and C930e */
+	/* Logitech HD Pro Webcams C920, C920-C, C925e and C930e */
 	{ USB_DEVICE(0x046d, 0x082d), .driver_info = USB_QUIRK_DELAY_INIT },
 	{ USB_DEVICE(0x046d, 0x0841), .driver_info = USB_QUIRK_DELAY_INIT },
 	{ USB_DEVICE(0x046d, 0x0843), .driver_info = USB_QUIRK_DELAY_INIT },
+	{ USB_DEVICE(0x046d, 0x085b), .driver_info = USB_QUIRK_DELAY_INIT },
 
 	/* Logitech ConferenceCam CC3000e */
 	{ USB_DEVICE(0x046d, 0x0847), .driver_info = USB_QUIRK_DELAY_INIT },

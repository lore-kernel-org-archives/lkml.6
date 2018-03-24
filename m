Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2530676-1521851639-2-12997475793851298971
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES endaro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521851638; b=PsPJUh5KmAfeybK8bIsJ6J9jcVIYnpreZm7Eomk+2YosYuX
    IvhYnvvQ8nmplCtnE/EJxhxrXEBozgC/wMfIp0qhlGf9HgQm+6PrdxCF4sz2ujtS
    4seYqjmB/OQZd33TwyvL94LrVYnBsgmqOCULW+ndTB/YrTLTPkXy7w+FFIXWb3Ci
    7YLto554xr7/Di0KkPebwjncMXVfYBka+V/t1mD6PvbrCrsIhPRYE8IlGRTncrPG
    jHj7L7f33wFP84uILPOHX1RvW6sAeqr3gW248VGxmujlnEmFB+Mvmn9KjurIlbxc
    WxznqLjQa6Xr21vtZmbrk5x5h2wewOj/tG5tm+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1521851638; bh=DbJLkgz/Wn62g8adgOgpJ1PF1b
    0rXAQjL/1+odn7TfA=; b=btdQEJ0mLAPIRTvuzC5J9j0IlLuYFGpQxu32V0cWQ0
    oDstPilJT8zqrvLs9ifSafy1mC6iLcLLAL4QQZRFcl66VsBvE3p/XR3l1LWg3bm3
    n6nb8Et9DXc2APgHbHRTqcj5CPFszPDo8tAarFetP2dJakrivBX4dGZcvCPNbWMK
    w56qfWL96VhkBKByydjmTQtPkdEuxQcBtclfHgOPXdMKNcwEit9CraHVEYweCK6Q
    F3QfBE+ks3ybAuwSWu+jiaIpAXoLLWAMKwiGFJVFTsJ9Lf23uHQtla+MVRsG6QAG
    zT9eJdcqY/9r62oDMMmEDfyVVJeFqBXluL331kA7j4eA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=chromium.org header.i=@chromium.org header.b=hxM1RjwT x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ncIYag8I;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=chromium.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=chromium.org header.i=@chromium.org header.b=hxM1RjwT x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ncIYag8I;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=chromium.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751985AbeCXAd4 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 20:33:56 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:39689 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751868AbeCXAdz (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Fri, 23 Mar 2018 20:33:55 -0400
X-Google-Smtp-Source: AG47ELvcqNMuV62qacjGiARGnZvHFbpVSsDAwvTqZmbhVq6QYHfL7NXz1hz5umrkUCgxhkMKfJVX1Q==
From: Benson Leung <bleung@chromium.org>
To: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: achant@google.com, bleung@google.com,
        Benson Leung <bleung@chromium.org>
Subject: [PATCH] USB: announce bcdDevice as well as idVendor, idProduct.
Date: Fri, 23 Mar 2018 17:33:30 -0700
Message-Id: <20180324003330.180726-1-bleung@chromium.org>
X-Mailer: git-send-email 2.17.0.rc0.231.g781580f067-goog
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Print bcdDevice which is used by vendors to identify different versions
of the same product (or different versions of firmware).

Adding this to the logs will be useful for support purposes.

Signed-off-by: Benson Leung <bleung@chromium.org>
---
 drivers/usb/core/hub.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index aaeef03c0d83..739d599814b6 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -2192,14 +2192,16 @@ static void show_string(struct usb_device *udev, char *id, char *string)
 
 static void announce_device(struct usb_device *udev)
 {
-	dev_info(&udev->dev, "New USB device found, idVendor=%04x, idProduct=%04x\n",
-		le16_to_cpu(udev->descriptor.idVendor),
-		le16_to_cpu(udev->descriptor.idProduct));
 	dev_info(&udev->dev,
-		"New USB device strings: Mfr=%d, Product=%d, SerialNumber=%d\n",
-		udev->descriptor.iManufacturer,
-		udev->descriptor.iProduct,
-		udev->descriptor.iSerialNumber);
+		 "New USB device found, idVendor=%04x, idProduct=%04x, bcdDevice=%04x\n",
+		 le16_to_cpu(udev->descriptor.idVendor),
+		 le16_to_cpu(udev->descriptor.idProduct),
+		 le16_to_cpu(udev->descriptor.bcdDevice));
+	dev_info(&udev->dev,
+		 "New USB device strings: Mfr=%d, Product=%d, SerialNumber=%d\n",
+		 udev->descriptor.iManufacturer,
+		 udev->descriptor.iProduct,
+		 udev->descriptor.iSerialNumber);
 	show_string(udev, "Product", udev->product);
 	show_string(udev, "Manufacturer", udev->manufacturer);
 	show_string(udev, "SerialNumber", udev->serial);
-- 
2.17.0.rc0.231.g781580f067-goog


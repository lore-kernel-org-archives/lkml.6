Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2656133-1521855141-2-6147082845393302577
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
    t=1521855140; b=OS4I24uDCyNMlrEGmmHyM5zoCXkGRKN5hLY/PtQEy6iUqRe
    nAK+S87huqN28ykwe6TBKrOiOsONhEEPXv9vQ9iraWlBdxOHreKm/UZZNp9oTUYO
    6PcghGXk+WmLJFwREjZ4urr1V+iPM7GRj9+X5dkXQRyPGWybDrpcxWXaQh43q1IH
    wpBLUsPij4i+LNa+YZfxJevPezlYu+HKAcwhPN3WHR1zFJCicnzi6JQKM4dHTYcR
    zkaCTmpqZzZC1SMeK/2+DSnDxwXyZod4Ik2pzXMlCK5lVG5LxeoiRezdOHds+rEi
    i3fiyTSOiOgUkSOXimzwaUxFMlQYL6k0wb1G1bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1521855140;
    bh=rXze6nESJWUKzY+LUjpIp20RvR/dkNE4rxNbd2BMImw=; b=LZco9OtkoIgO
    I45EqwMkgLjvmDzDJ3dCw2jvdxmsRWgpOWpG/4A1BN9RE6nC0QiwOGABISowIdoU
    6LKk4BRXHzq0BhcnQrtJHuxHXaybNS60LciXErZXViB3l194ARIc2+7sitd1RIm7
    NnUjjZAcc2wb03GavoDaP30XWXBkOl7ZWnEiDxfOqw+eZQRc+7owU/xFl76BNvsj
    Ef6OMaNzrKRV3Bu/5XOt6olvhU/bakVwKezrBnp91PSwzHcQ2D2YffToCxd+QkFR
    6IoNOCf9kukwF/A5GRZ6fzcLWahrI5SX4PnRSH9yfH0A164wSX9dIBotildHA3OC
    Sz/V+650cg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=chromium.org header.i=@chromium.org header.b=WYKb0I52 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=cgkdHKuW;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=chromium.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=chromium.org header.i=@chromium.org header.b=WYKb0I52 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=cgkdHKuW;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=chromium.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751926AbeCXBcG (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 21:32:06 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33808 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751657AbeCXBcF (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Fri, 23 Mar 2018 21:32:05 -0400
X-Google-Smtp-Source: AG47ELuavSOsjYYOeMRPS8t7e2byuystG5Rw4DDspPVoEGi3qlNMZfptjBgW5uVSEuY81xFEvAJ2aQ==
From: Benson Leung <bleung@chromium.org>
To: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: achant@google.com, bleung@google.com,
        Benson Leung <bleung@chromium.org>
Subject: [PATCH v2] USB: announce bcdDevice as well as idVendor, idProduct.
Date: Fri, 23 Mar 2018 18:31:54 -0700
Message-Id: <20180324013154.230119-1-bleung@chromium.org>
X-Mailer: git-send-email 2.17.0.rc0.231.g781580f067-goog
In-Reply-To: <20180324003330.180726-1-bleung@chromium.org>
References: <20180324003330.180726-1-bleung@chromium.org>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Print bcdDevice which is used by vendors to identify different versions
of the same product (or different versions of firmware).

Adding this to the logs will be useful for support purposes.

Match the %2x.%02x formatting that's used by lsusb -v for this same value.

Signed-off-by: Benson Leung <bleung@chromium.org>
--
v2: Format for decimal output.
---
 drivers/usb/core/hub.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index aaeef03c0d83..624cde7ffcea 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -2192,14 +2192,19 @@ static void show_string(struct usb_device *udev, char *id, char *string)
 
 static void announce_device(struct usb_device *udev)
 {
-	dev_info(&udev->dev, "New USB device found, idVendor=%04x, idProduct=%04x\n",
-		le16_to_cpu(udev->descriptor.idVendor),
-		le16_to_cpu(udev->descriptor.idProduct));
+	u16 bcdDevice;
+
+	bcdDevice = le16_to_cpu(udev->descriptor.bcdDevice);
+	dev_info(&udev->dev,
+		 "New USB device found, idVendor=%04x, idProduct=%04x, bcdDevice=%2x.%02x\n",
+		 le16_to_cpu(udev->descriptor.idVendor),
+		 le16_to_cpu(udev->descriptor.idProduct),
+		 bcdDevice >> 8, bcdDevice & 0xff);
 	dev_info(&udev->dev,
-		"New USB device strings: Mfr=%d, Product=%d, SerialNumber=%d\n",
-		udev->descriptor.iManufacturer,
-		udev->descriptor.iProduct,
-		udev->descriptor.iSerialNumber);
+		 "New USB device strings: Mfr=%d, Product=%d, SerialNumber=%d\n",
+		 udev->descriptor.iManufacturer,
+		 udev->descriptor.iProduct,
+		 udev->descriptor.iSerialNumber);
 	show_string(udev, "Product", udev->product);
 	show_string(udev, "Manufacturer", udev->manufacturer);
 	show_string(udev, "SerialNumber", udev->serial);
-- 
2.17.0.rc0.231.g781580f067-goog


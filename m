Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1883814-1518710757-2-10001259041058056238
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518710756; b=sgY5aokgUDeB1Hch6APwSQVudqY5AROh0qDNGWHR2k1ThsA
    Siy2BY+tSGQV0syUmff85yAfKfcc414ytrZfrJ6IusODafaGDgNoJ2q81bHUJ59H
    rfunU4BjzEDFn2OSSc6Uo6UJFUYcloNTrD845GRoaJxVVSndMxINheQtwgJF4xVp
    P/MKPSnBgDhTwW67RX2DGj14h7qaRsj4AS3UmrerjZU+0LlLrxFWhMsIO2tOKoaL
    xhbd2jGZ2xZ3+pVOxeJE5O53nfmwadh5sZgSdI+2NTGOP6D1UXOHrQXY+KR0vHCZ
    4oCY1oJLdsUwpKKLwcJaJ2bRWKy1wejZjIRxA3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518710756; bh=3k7PTG5q5ZLe3i5k55Z2q2qQ+V
    RFuRqHlGewlwKxF9E=; b=gkBoOKBG4MBYz3PB6JsXmI4yqvELj4gZm+iCjcqzdm
    yHaHutBWEMKyA12Rao0arb1xfD4w71EbtrjavwGJYjVBOzkRsIM79ISk4Rx4OL5B
    trT6jeWf1gaYOR6oxGq+yzOSfupQHlqLFMoLqvqLX4JyyorjsseaVVs/HLe/3W4f
    6VH+z3V6QLanGt7+wGw4ge0IZD6VEAkmK1V8iyEvEeL9aFt36oxeIL0vOh3+oxss
    gk3I+9AWIsPqw2/ivlwZ8m8E/GWPs4HybnfZYeXvKSG7xA4GeSu2y6wSca9QGEY5
    Xl68IgZgLKeDNQiU+MkzUoGJKWphJSwEPkiswvVZeONw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424610AbeBOPqJ (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 10:46:09 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:35228 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424599AbeBOPqE (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:46:04 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH 4.15 161/202] HID: quirks: Fix keyboard + touchpad on Toshiba Click Mini not working
Date: Thu, 15 Feb 2018 16:17:41 +0100
Message-Id: <20180215151721.304163229@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

commit edfc3722cfef4217c7fe92b272cbe0288ba1ff57 upstream.

The Toshiba Click Mini uses an i2c attached keyboard/touchpad combo
(single i2c_hid device for both) which has a vid:pid of 04F3:0401,
which is also used by a bunch of Elan touchpads which are handled by the
drivers/input/mouse/elan_i2c driver, but that driver deals with pure
touchpads and does not work for a combo device such as the one on the
Toshiba Click Mini.

The combo on the Mini has an ACPI id of ELAN0800, which is not claimed
by the elan_i2c driver, so check for that and if it is found do not ignore
the device. This fixes the keyboard/touchpad combo on the Mini not working
(although with the touchpad in mouse emulation mode).

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hid/hid-core.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2643,7 +2643,6 @@ static const struct hid_device_id hid_ig
 	{ HID_USB_DEVICE(USB_VENDOR_ID_DELORME, USB_DEVICE_ID_DELORME_EARTHMATE) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_DELORME, USB_DEVICE_ID_DELORME_EM_LT20) },
 	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, 0x0400) },
-	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, 0x0401) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ESSENTIAL_REALITY, USB_DEVICE_ID_ESSENTIAL_REALITY_P5) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ETT, USB_DEVICE_ID_TC5UH) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ETT, USB_DEVICE_ID_TC4UM) },
@@ -2913,6 +2912,17 @@ bool hid_ignore(struct hid_device *hdev)
 			strncmp(hdev->name, "www.masterkit.ru MA901", 22) == 0)
 			return true;
 		break;
+	case USB_VENDOR_ID_ELAN:
+		/*
+		 * Many Elan devices have a product id of 0x0401 and are handled
+		 * by the elan_i2c input driver. But the ACPI HID ELAN0800 dev
+		 * is not (and cannot be) handled by that driver ->
+		 * Ignore all 0x0401 devs except for the ELAN0800 dev.
+		 */
+		if (hdev->product == 0x0401 &&
+		    strncmp(hdev->name, "ELAN0800", 8) != 0)
+			return true;
+		break;
 	}
 
 	if (hdev->type == HID_TYPE_USBMOUSE &&

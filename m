Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-516026-1519834616-2-13467340237658282841
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enfrca,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519834616; b=RoZ7BXiSrI4RQm194zyk8i1gVSFu5phAPL2q1PYnJKh2Xx8
    /RqAVS+8rkQ8oF2qkd9bI5EoToKPxJRxddYA3vZhdDMiprIM78Vwh4KNcEMOU+r6
    PRKWBU/BNx4/hZ7jgqOSz/Ab8gt9p8a4o5+TNoubE45mkJHtK+0TSeGlyFHdJhDn
    GzVW79+iabFaphnJp1gTBj1aNtRnvtnQ0veYO0RaM4W9XphuIKWnmY2bkt2JTgMs
    QdQtXg0MKn8bU7byIE2tOZmxWXV47j8PDljDwg2V+khK1OcLGXQ/+B8ncvir9qcv
    dQliSxYzNmSOVZv8eOjW/vcBkVUKHJkQqty2U0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519834616; bh=MXSAylwXMitIisyShzH
    M5n2QAjfCxRd0JOArVRk98Dw=; b=O9XfXxwCLgFkziITx2xEvwG3E+4ytzqFmBT
    wAqCkv6KFHHhw2Tot3jcwG0bbv4hEjt4+XSEu3njWSZIMmTGmfXrYz3KIfS+4rBf
    IQ9kYhaMHzcb7E4wba6usP8g9A/HK96vdL09ns0533lBmQcGrq0HqvhHtjSoUhqt
    O6tt9lwqY7alKlA3W38EOgc13G9Ka3MP3AWtytyCvsu/VYNmqPpHN/pLoUzhpk7V
    dS5e7eVAZj/8Ex26lmtRxI2lh8gxXPf5ec/JYFGwrQxLYfRDrRhqcjdl8nqlZm0H
    z25W3Kx64FwckjIyhgZUxIQ4uWUX39g1LYBzvK/+2OfPnaktqlA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934982AbeB1QQj (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:16:39 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35245 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934980AbeB1QQi (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:16:38 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Dmitry Fleytman Dmitry Fleytman" <dmitry.fleytman@gmail.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.118255032@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 132/254] usb: Add device quirk for Logitech HD Pro
 Webcam C925e
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.55-rc1 review patch.  If anyone has any objections, please let me know.

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
@@ -57,10 +57,11 @@ static const struct usb_device_id usb_qu
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

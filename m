Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2921988-1521731975-2-12253718659474662961
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521731975; b=G/qzXjwVBOV+kY3e2vY0EbmUZ6NnLELkbB3bNqiUrTijoGD
    8n9mFHXKc6psEW49gDgS7p3SCe8F/hdeWXVibQ78KgzfKxCjwhLjPsgmPRFXGmFO
    XUhPop8M+UHSCe1kXkKQ6mh/8fxEMSsYpTrxdsJTYDxOLGh54IslX9qgptmaK/WA
    +8vMT1yCHWZoLUqx6QJ1AqCf9wlQqn6G0VapTHBnZ1in0tRkEjU0XwZcUWwpAV0Q
    sH0ffcQ/R4zYLqm1JJv5BgvdAWrpN19NTpxOZgaUTJwDrlKyUuIqGraOAI9jewu/
    B/v88jMIKay14SVyyTYqKTawmE8sxNhsUQpw6UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1521731975; bh=UJQke882+LGkG4t+z6zUggGfOH
    5XPIKAfYhcEAkAeww=; b=sb4nozpVCaOL1Y5PuMfjeO+xwXHXjkUwjtBZMyljDb
    R7UpPKnnANW6aNFA5nDu+97KdUS80AlWlXMCVBFsaoup57sZ5j1ZqVp9HzAjv1BD
    1If5HsFniVbbxrpudfblRN4VbULlC4aSr6EPHyrWExh6mGuEvcuxFaw/sgarNphl
    YCyfaNW55kHyNEJJs7LI7hw+MssRffwC31NqFB+Q3qJP7MGarX/yWQQY/1Fr/+98
    Bngz8KvcZf9OAl71PJ2i+i6bDc7zUPtq12V1LRit9Uz6hfCF3XwE4phvH+1cCqpW
    wnDj8Sn2+VAv9Vd/e1W7B07bVux0BAFZdsDHEXp/cOfQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=tvkmMppf x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=collabora.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=N3r6OTdZ;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=collabora.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=tvkmMppf x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=collabora.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=N3r6OTdZ;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=collabora.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755152AbeCVPTB (ORCPT <rfc822;greg@kroah.com>);
        Thu, 22 Mar 2018 11:19:01 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:39023 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755096AbeCVPS4 (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 22 Mar 2018 11:18:56 -0400
X-Google-Smtp-Source: AG47ELueZy7oZ4dQDkdAgkEJjNXinnfN7cohX/xuqUJzhRxxD/1UyM0uBVEYz0RNfWe1Q7nAvfJxZA==
From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: Alan Stern <stern@rowland.harvard.edu>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Subject: [PATCH] usb: hub: Reduce warning to notice on power loss
Date: Thu, 22 Mar 2018 16:18:32 +0100
Message-Id: <20180322151832.21198-1-tomeu.vizoso@collabora.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Currently we warn the user when the root hub lost power after resume,
but the user cannot do anything about it so it should probably be a
notice.

This will reduce the noise in the console during suspend and resume,
which is already quite significant in many systems.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---
 drivers/usb/core/hub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index ac7bab772a3a..5964008003b4 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -3655,7 +3655,7 @@ static int hub_reset_resume(struct usb_interface *intf)
  */
 void usb_root_hub_lost_power(struct usb_device *rhdev)
 {
-	dev_warn(&rhdev->dev, "root hub lost power or was reset\n");
+	dev_notice(&rhdev->dev, "root hub lost power or was reset\n");
 	rhdev->reset_resume = 1;
 }
 EXPORT_SYMBOL_GPL(usb_root_hub_lost_power);
-- 
2.14.3


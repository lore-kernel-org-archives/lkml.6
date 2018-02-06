Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-716755-1517907054-2-1943027251860282374
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES ensk.us-ascii,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517907054; b=Uk5xD8MYGz2rCnERoV+Tg3cGuEXUW7kwXqAhWsvjN/myzm3
    C6BxyDPUoNT/t7qqTh6NRV0RUZ9L3v+yYIhkuEnKDdMdEO7BnPybxcdXLTOEhGts
    Anne+UKYEwCaV7Qm7GCwUIuAHdT+8EYOUBGhqWHKe9kYrVVIpuxgMIDPvDOzoEpF
    D3WdlJqrvoRFzO+0gmWQCNWzeLNVztuj8mc/gnGEIS/Y6/pdYUfl1Mlz6rjsSLhi
    zITaJnfMOyXYALtzyx+Zykv+au0Ii4yNKLXPFg7c3qJUGPIX4rW4RUX6MWJnWfWH
    fORxycJynnPCUIfNLP10VwXGSnrz/UUbHIh4IjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1517907054; bh=4zkoldY6p/4zBtbwuj3tQQb0QR
    6CsPZE1jHvbY5vL2U=; b=Ic5COwmZxG+QZw5j6jrZiWTOawTgrXscvg7dbbfOzJ
    eIh2VE3yDvkkh3UOksgj93wK2J2TVCZOczCU5rCSWNoWrGQd0eJ7XMu1cQ0/mZ2V
    /bo5LUAk4lPPXdWz+TWa9aVJChieOgDnxg1Fi4RxFkBRfKUlMSGszXklk6gOZX+7
    +wlBl+fRArWpSPlloxUx7AoQuB+Vjbe/Od3DO97j6N+l4u1Q8FIRVmd4hRLh27VD
    LoDtGr+h6FkogwsF7qR+OrfgEASl33FUAM1RmQNhMIbq4CqIRXr1r3XbkTKt/2Pd
    XGG/dlxND6lmGmhDjjbEpC54Njw3Y538BsfJnU0XYYdA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=sang-engineering.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=sang-engineering.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=sang-engineering.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=sang-engineering.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752256AbeBFIus (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Feb 2018 03:50:48 -0500
Received: from sauhun.de ([88.99.104.3]:36825 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751835AbeBFIus (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Tue, 6 Feb 2018 03:50:48 -0500
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-kernel@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Subject: [PATCH] usb: gadget: udc: change comparison to bitshift when dealing with a mask
Date: Tue,  6 Feb 2018 09:50:40 +0100
Message-Id: <20180206085040.3018-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Due to a typo, the mask was destroyed by a comparison instead of a bit
shift.

Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
Only build tested.

 drivers/usb/gadget/udc/goku_udc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/goku_udc.h b/drivers/usb/gadget/udc/goku_udc.h
index 26601bf4e7a935..70023d40107997 100644
--- a/drivers/usb/gadget/udc/goku_udc.h
+++ b/drivers/usb/gadget/udc/goku_udc.h
@@ -25,7 +25,7 @@ struct goku_udc_regs {
 #	define INT_EP1DATASET		0x00040
 #	define INT_EP2DATASET		0x00080
 #	define INT_EP3DATASET		0x00100
-#define INT_EPnNAK(n)		(0x00100 < (n))		/* 0 < n < 4 */
+#define INT_EPnNAK(n)		(0x00100 << (n))	/* 0 < n < 4 */
 #	define INT_EP1NAK		0x00200
 #	define INT_EP2NAK		0x00400
 #	define INT_EP3NAK		0x00800
-- 
2.11.0


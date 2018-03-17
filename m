Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-946666-1521271982-2-3345840254420700069
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521271981; b=FnFZxQcxfF/6keWa92dmgFS/rEqRE+DXtQs1XDnPDFr/6sM
    u1nLnY2WKyyPwfIMmDsr0OXUHrKlSJi/vpCBSXlEUKLap9dRVGSKhj/Hi/Gu3Q/8
    kQuSI0MHDuU/n5SDbbC0n64R/h3fvOgYuNUsRaDGZUijDyetQglE1jtjqfBCSQTN
    KfOY5X3q4X5L8wBcGfst9+ERK6EIvg+pa2181+RSzuw3VzDZFUUkeT8PbHCrKxXD
    CJWinS9mKWPMNjMvcC3gGMNNHO1gAtmEnPR5ndjzzjtK3g9fKoRQcC0hu+b5PhdD
    OM1fInwxQz/CBqfPPyC9oehzWY3QpCgt8LOqqmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1521271981;
    bh=ol29rStr/P1WZb870qbqGJy8hWwpO/b2GdXTWM4rkdw=; b=kLmYzPRlOs3+
    Vhbr2fa3XW8kGWyz0twWbsiLV3Wm4zxNeDIQ2TwlLlKjxg9a7lvCj1G4DVB4/C6W
    k623nDWGMHxwrwc41DkaBDx9Od7OpOJHTkbwfU+IoBa8Mbqmh0PwwfZxsd41Vcw2
    MyhhsK56/SwJImpGJQgZbr3aducfEsRDRGcHf6847n9RPfD3jizNUn7h1CaCwsBq
    9JEKUV/nyv6udhUZ9/RRupbCAacMGOFaxiiz2p1YrnoVsvIegWB4qZeFGEuTugk/
    43pqc6CaV3GoRQlpGkCCu+sTRpbctjOKz5CPAeCVaV0XfPSDiAoxR8xMINgP8ufN
    J8vZcNNObg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=nvch5Pm9 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=uZ44R9Xm;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=nvch5Pm9 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=uZ44R9Xm;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752049AbeCQHdA (ORCPT <rfc822;greg@kroah.com>);
        Sat, 17 Mar 2018 03:33:00 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37949 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751139AbeCQHch (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 17 Mar 2018 03:32:37 -0400
X-Google-Smtp-Source: AG47ELstMLIR4GD3mwsMar9F6dxDHiqMi+LsK7Ft9NNukW4CSRdx/qtL8bV2s1yuWM4mV//VIk0giQ==
From: Jacek Anaszewski <jacek.anaszewski@gmail.com>
To: stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, pavel@ucw.cz,
        jacek.anaszewski@gmail.com
Subject: [PATCH 4.9 1/2] Revert "led: core: Fix brightness setting when setting delay_off=0"
Date: Sat, 17 Mar 2018 08:31:01 +0100
Message-Id: <1521271862-4599-2-git-send-email-jacek.anaszewski@gmail.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1521271862-4599-1-git-send-email-jacek.anaszewski@gmail.com>
References: <1521271862-4599-1-git-send-email-jacek.anaszewski@gmail.com>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This reverts commit 86b9fa2190907f4f550d9d6bf490c5f89ca33836.

The commit being reverted has two flaws:
 - it introduces a regression, fixed in the upstream
   commit 7b6af2c53192f1766892ef40c8f48a413509ed72.
 - it has truncated commit message
---
 drivers/leds/led-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/leds/led-core.c b/drivers/leds/led-core.c
index d70d4a5..3bce448 100644
--- a/drivers/leds/led-core.c
+++ b/drivers/leds/led-core.c
@@ -186,7 +186,7 @@ void led_blink_set(struct led_classdev *led_cdev,
 		   unsigned long *delay_on,
 		   unsigned long *delay_off)
 {
-	led_stop_software_blink(led_cdev);
+	del_timer_sync(&led_cdev->blink_timer);
 
 	led_cdev->flags &= ~LED_BLINK_ONESHOT;
 	led_cdev->flags &= ~LED_BLINK_ONESHOT_STOP;
-- 
2.1.4

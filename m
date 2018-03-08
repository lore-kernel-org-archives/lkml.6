Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2969271-1520547628-2-13622474455145824079
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520547628; b=PUFBO564TkEaiIVQ9lrQE/2EYoUWdf0gCrX0hePPtPHjAOB
    qUYexyCR324OwkJXoguC26j1PcXfpbFQ88m71LQ5n9niY/Cb4druxuFQH0R7wHyY
    DFbBjlzXS1DZBoKVQhvg4/d/ci1x0Yu+gKu8FwKfa/TeORT1zih4/ih22zrwlI63
    1zsWxft/U7Q6zNYZ9LxpWl/JS+69Vp5uFJoclhNv9azpdFdmCZTy5b3PRQDXou4Y
    ZbGxVwoMROCnCwIgi3cxM2q7H9FaOoMayUGLxNsC+sLzBnNWbESK9qIoGnDzAzUj
    EdH6RKWv+Ow671Mntz6T7/EkdTV/Zy0qTXPwm+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1520547628; bh=7cW28rh100o/EM3scRpTxC05p/
    0wwlqFxB3aDObX+5s=; b=xCgVWJ8LKR/Qt1T5HiqxEYKlGQBzV75iCT2hDd027d
    JNrKUG2nM1tTYFc23hzRChSfbHdHrPcrrIkfoZYnQZrRxHIQsxiZx3liU/REmLFp
    XprKxUsrYRDr3hMbAB27n5aqPiMYaxou03DOzH8AxZf2TuozDjILAQ/HfmK8g56Z
    2j5jQdDtc4DaqDDpzqVJ+3vStnuQzhD2ZI7gHNncqWNsAQmLr8yuYDioOahZOkMX
    zdQ/ng2HtAd+WZlrra51R0aEx8JnSiAoslZP9093jJLOT1OEip91LtOdUtpsuya6
    ULWMGHVfuxQeWV53oZZwWyWsK8b5RVgvRrS64xqbCP4w==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=wizzup.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=wizzup.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=wizzup.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=wizzup.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750867AbeCHWUO (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 17:20:14 -0500
Received: from nala.villavu.com ([188.165.243.101]:53430 "EHLO
        nala.villavu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750713AbeCHWUO (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 8 Mar 2018 17:20:14 -0500
From: Merlijn Wajer <merlijn@wizzup.org>
To: b-liu@ti.com
Cc: merlijn@wizzup.org, ivo.g.dimitrov.75@gmail.com,
        linux-omap@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] usb: musb: Fix external abort in musb_remove on omap2430
Date: Thu,  8 Mar 2018 23:19:48 +0100
Message-Id: <20180308221949.12054-1-merlijn@wizzup.org>
X-Mailer: git-send-email 2.16.2
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This fixes an oops on unbind / module unload (on the musb omap2430
platform).

musb_remove function now calls musb_platform_exit before disabling
runtime pm.

Signed-off-by: Merlijn Wajer <merlijn@wizzup.org>
---
 drivers/usb/musb/musb_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index e2e95071328a..fb1d88183ea1 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -2474,11 +2474,11 @@ static int musb_remove(struct platform_device *pdev)
 	musb_disable_interrupts(musb);
 	musb_writeb(musb->mregs, MUSB_DEVCTL, 0);
 	spin_unlock_irqrestore(&musb->lock, flags);
+	musb_platform_exit(musb);
 
 	pm_runtime_dont_use_autosuspend(musb->controller);
 	pm_runtime_put_sync(musb->controller);
 	pm_runtime_disable(musb->controller);
-	musb_platform_exit(musb);
 	musb_phy_callback = NULL;
 	if (musb->dma_controller)
 		musb_dma_controller_destroy(musb->dma_controller);
-- 
2.16.2


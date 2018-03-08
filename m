Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1581632-1520501544-2-15693503010694366036
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520501543; b=qAjHclGQJD0Jwp8lDHkIVqMjP4zie+uLrRDv33VYkoJf5EW
    JK3JWoocW+zTm8mD2lp3aj27FXExhNtxBRdI25g2M34PvjZ3/yOLuFXeoYxRfl6h
    CYA1phEtctWr8y7q2gsL7kG0bstVlbR4EAx/rVVdvqaYazibJ3yQM8dQ563S/ZSU
    6UmPkuiq3Dts2mXn26jqBs1v4uJGAQuboffPCgphqHBpaPvJi5plcT9tQ2VJvDMN
    6NNvXsiYrreg4pYZeRHrm91a82vm2yrfvy5+A7B3jct+yKIDMzVyGwv0t2lpLqVT
    US9GNBw/OdIC3IOiaI2OuhqMFjNHwj0FlPo4GYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1520501543; bh=052ZgMlu26DU06lrmBqa/TU+yb
    V6UbEYEIHaBM1IkSE=; b=MozPVGeSHIw90CV33OQaFVjdiU7IINh0b8TqLpw6Om
    3JN7b7SIpVHiWfq+UpEbD4HWyxYssBixaKC6lxYcDYAhNyh+L9uZbSJM0IwuUZiE
    dnv5U5rBpA7s3X6omeJXlxef9IvG96Megg2fk0Utx7Q03axmePgzBzMvUDqrwz+s
    AcAymG8MujDhT9xNdSWsu1UHiIGIe3pqnc6HnG7/+PsvsHr5fJn60XNJvMxO0XoC
    ETSXSm2a3kdRkfl7iYfp2rGnJiNXSC6p2HDsCEthH9wQqcAggu2fa+k+sxFiL30Z
    WlyYUpUzRE7OMhNvcccAFNERuIAODwbb3Kjzn9hCS72A==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=wizzup.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=wizzup.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
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
        id S1755586AbeCHJcB (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 04:32:01 -0500
Received: from nala.villavu.com ([188.165.243.101]:45479 "EHLO
        nala.villavu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755564AbeCHJb7 (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 8 Mar 2018 04:31:59 -0500
From: Merlijn Wajer <merlijn@wizzup.org>
To: b-liu@ti.com
Cc: merlijn@wizzup.org, ivo.g.dimitrov.75@gmail.com,
        linux-omap@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH] usb: musb: Fix external abort in musb_remove
Date: Thu,  8 Mar 2018 10:31:21 +0100
Message-Id: <20180308093121.11943-1-merlijn@wizzup.org>
X-Mailer: git-send-email 2.16.2
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This fixes an oops on unbind / module unload. The fix is similar to the
one in this commit: 0c3aae9bd59978fb8c3557d7883380bef0f2cfa1 (USB: musb:
fix late external abort on suspend), which only fixes the issue for
musb_suspend.

musb_remove function now also flushes any work and also calls
musb_platform_exit before disabling runtime pm.

Signed-off-by: Merlijn Wajer <merlijn@wizzup.org>
---

If I understand commit 0c3aae9bd59978fb8c3557d7883380bef0f2cfa1 correctly,
this patch should also be backported to 4.9 (and newer kernels).

I have verified that this works on the Nokia N900, RX-51. The problem did not
occur on the Motorola Droid 4, but I have yet to test if this patch causes
issues there.

 drivers/usb/musb/musb_core.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index e2e95071328a..4fb0f345c04e 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -2472,13 +2472,19 @@ static int musb_remove(struct platform_device *pdev)
 	musb_platform_disable(musb);
 	spin_lock_irqsave(&musb->lock, flags);
 	musb_disable_interrupts(musb);
+
+	musb->flush_irq_work = true;
+	while (flush_delayed_work(&musb->irq_work))
+		;
+	musb->flush_irq_work = false;
+
 	musb_writeb(musb->mregs, MUSB_DEVCTL, 0);
+	musb_platform_exit(musb);
 	spin_unlock_irqrestore(&musb->lock, flags);
 
 	pm_runtime_dont_use_autosuspend(musb->controller);
 	pm_runtime_put_sync(musb->controller);
 	pm_runtime_disable(musb->controller);
-	musb_platform_exit(musb);
 	musb_phy_callback = NULL;
 	if (musb->dma_controller)
 		musb_dma_controller_destroy(musb->dma_controller);
-- 
2.16.2


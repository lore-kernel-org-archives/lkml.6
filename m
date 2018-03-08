Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2846663-1520541712-2-11648586713604949222
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520541712; b=MkKUhCZVpD5wMjROMjUW58YRBAS6x9XnvlSfIecLXBhk9OJ
    4n4pOd37d8XHLjzS9rRjbQxCP11QpP+PbtE1VbEb6Ds5q80s7XLX0CYLSkj28Bw0
    KLeFK1z2EXeOn1OiUroDUdHDUOPEaegcjQcZesGTbiHH31df2L+yUlA0+AmWzF6T
    RXYp5psr/hZ8XTowOjSLmiP6B/Zyi04+TFOceWEmCd1qP4lbRJUKCISKtM64Edef
    wgzbd0knGENLOwvPU4bkOS9f4QIV8STc1AG8uuxrx8gk7hLwDO+P08oMsBotEVm5
    UdsBNHVvmfT6LT1wXgNXBx4k0HW6HNMplkxVKgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1520541712; bh=CKnFdvwLXUdGFtZUH+AW2qplPO
    ysgd1C6Pum1KfCs7Q=; b=oS1IHFOWgrgm6ViY6V1lbtYUeYxzHsFjNZiKapTXlA
    VaRWGiQjpGfV1190LiXBPHH7bof3CKFUjToPpWzOHoRnFPzx5NvYZhFW63WzN7O5
    hViTDjq/WB3xe+gRRrhuI0g+MZ3TSe10RZedqW1hL05IjJpfq5gHEtAKtTA/wZrU
    LuK2C7G5WxNex3HHfNK6PzfqF4ODqyV/IcUR0qJoCHIMH592AI8gchY4M2DefFDh
    YIVUqFTzi9Pq2NXhnBlda/8EKdS/9M3qw6MXaYLq+My5Mse30AiMaL34ufnQmmdE
    KDS0nE4pHGcwCYsP2iANaeTIZL60nIhAknyRC4JhxzmQ==
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
        id S1751229AbeCHUlX (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 15:41:23 -0500
Received: from nala.villavu.com ([188.165.243.101]:50909 "EHLO
        nala.villavu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751225AbeCHUlV (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 8 Mar 2018 15:41:21 -0500
From: Merlijn Wajer <merlijn@wizzup.org>
To: b-liu@ti.com
Cc: merlijn@wizzup.org, ivo.g.dimitrov.75@gmail.com,
        linux-omap@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: musb: Fix external abort in musb_remove
Date: Thu,  8 Mar 2018 21:40:47 +0100
Message-Id: <20180308204049.29474-1-merlijn@wizzup.org>
X-Mailer: git-send-email 2.16.2
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This fixes an oops on unbind / module unload.

musb_remove function now calls musb_platform_exit before disabling
runtime pm.

Signed-off-by: Merlijn Wajer <merlijn@wizzup.org>
---
 drivers/usb/musb/musb_core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index e2e95071328a..cf90d34f7199 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -2472,13 +2472,14 @@ static int musb_remove(struct platform_device *pdev)
 	musb_platform_disable(musb);
 	spin_lock_irqsave(&musb->lock, flags);
 	musb_disable_interrupts(musb);
-	musb_writeb(musb->mregs, MUSB_DEVCTL, 0);
 	spin_unlock_irqrestore(&musb->lock, flags);
 
+	musb_writeb(musb->mregs, MUSB_DEVCTL, 0);
+	musb_platform_exit(musb);
+
 	pm_runtime_dont_use_autosuspend(musb->controller);
 	pm_runtime_put_sync(musb->controller);
 	pm_runtime_disable(musb->controller);
-	musb_platform_exit(musb);
 	musb_phy_callback = NULL;
 	if (musb->dma_controller)
 		musb_dma_controller_destroy(musb->dma_controller);
-- 
2.16.2


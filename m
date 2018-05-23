Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3988127-1527065072-2-8740034660413159236
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: cc='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527065071; b=H05vknYrjj6dk5EoiH1Bwtkzh1qo0dLk5kNK9JMBNkY+/bQyAa
    QRaDvNt8SjQn6158yJwE4cm+tM51D1WRLi+mpKpr4SROmlhQ+iqSMwArsZ50UKCj
    3LpIjzMxlAD6LkAb85rXqZrjILQPQjdEKYqqON2VbJ7WxIMuYNLmdwbAUf2ecSeP
    yrcwT/cVAb8/La00bDjt6BhQEtnvPC6XbclkgnmyXMdeE0Hw700lYrNE5WXTYn1n
    +JWlHyJrW93j8yw/n+7fWs+1ccP1tDoBpm8pPj3dxWTvxMmBCMsf5m1KKjbRMzjX
    mW55Niee039UMc8fg7+st1eOZlJ+F2jHNXlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1527065071; bh=pl/Pc5CH6hD/a6oTdlaPF6T/9Mwcz+
    27vSDKHzwIvFM=; b=amcuHzNQt7U6O2uFbWQkfyPg8O/sidQh9dyjhfjD+xwFZJ
    l9XLnbTF775SsP3ZveDW8Frclw3TCagmtwIUuNf7x4uzsHmtY785GBUMymjna2h/
    jNAsOnJafuQoR1gnhnwJlZlc0FDT4MfT1vp6PohwXxszTXjc3em2YwhZC+to1CMa
    iocU+HJf15hZJJQrd1cRc+FN77GVtqyDH68MBtnpkgrP7mQHVJOWhCEYQLMdD5Xq
    71rh713xNV8lsTzLVi/VZYPJj4517Xno5akvk1d+YVp8i9BmwQ9vhaK+JDiQ2xHd
    y3FQ5my2AvdmY3yxnp20w07wBBP6O9nnVCSNI54Q==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=bootlin.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=bootlin.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=bootlin.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=bootlin.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOX8lhoyLYxXKQES92hiS5rwvMIGhh4Y3tAC+JQkSmuKUdKL23eTHfJTTU0HLmfkyb9fLj03oTGqiAvbuQR6g/SDL4bSxd0e7K9gOg2afYri+z8Ud53+
    Th+gUEaQI055vBD8NSHCew/ViXAqgvQvuVLr4cr2wMVqSRFi/k8HRq2vQcDpMXlJuEziTz15Z6ttNL+bJg1ywEFIDeVgWT2vq+0ToTQOVZamJe09BILMUvbp
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=M5GUcnROAAAA:8
    a=P-IC7800AAAA:8 a=VwQbUJbxAAAA:8 a=Qvy2bbh07FCWGXFziCMA:9
    a=OBjm3rFKGHvpk9ecZwUJ:22 a=d3PnA9EDa4IxuAV0gXij:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754473AbeEWIo2 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 23 May 2018 04:44:28 -0400
Received: from mail.bootlin.com ([62.4.15.54]:58787 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754307AbeEWIo1 (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 23 May 2018 04:44:27 -0400
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on mail.bootlin.com
X-Remote-Spam-Level: 
X-Remote-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED,SHORTCIRCUIT
        shortcircuit=ham autolearn=disabled version=3.4.0
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        =?UTF-8?q?Miqu=C3=A8l=20Raynal?= <miquel.raynal@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>,
        Victor Gu <xigu@marvell.com>, Marcin Wojtas <mw@semihalf.com>,
        Wilson Ding <dingwei@marvell.com>,
        Hua Jing <jinghua@marvell.com>,
        Neta Zur Hershkovits <neta@marvell.com>,
        Terry Zhou <bjzhou@marvell.com>, stable@vger.kernel.org
Subject: [PATCH] pinctrl: armada-37xx: Fix spurious irq management
Date: Wed, 23 May 2018 10:44:05 +0200
Message-Id: <20180523084405.14410-1-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.17.0
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Terry Zhou <bjzhou@marvell.com>

Until now, if we found spurious irq in irq_handler, we only updated the
status in register but not the status in the code. Due to this the system
will got stuck dues to the infinite loop

[gregory.clement@bootlin.com: update comment and add fix and stable tags]
Fixes: 30ac0d3b0702 ("pinctrl: armada-37xx: Add edge both type gpio irq support")
Cc: <stable@vger.kernel.org>
Signed-off-by: Terry Zhou <bjzhou@marvell.com>
Reviewed-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 drivers/pinctrl/mvebu/pinctrl-armada-37xx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c b/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
index 5b63248c8209..7bef929bd7fe 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
@@ -679,12 +679,13 @@ static void armada_37xx_irq_handler(struct irq_desc *desc)
 					writel(1 << hwirq,
 					       info->base +
 					       IRQ_STATUS + 4 * i);
-					continue;
+					goto update_status;
 				}
 			}
 
 			generic_handle_irq(virq);
 
+update_status:
 			/* Update status in case a new IRQ appears */
 			spin_lock_irqsave(&info->irq_lock, flags);
 			status = readl_relaxed(info->base +
-- 
2.17.0

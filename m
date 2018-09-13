Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AFAFFA374C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 17:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9A5221523
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 16:51:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AD9YfyLC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9A5221523
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbeIMWB0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 18:01:26 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37129 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726835AbeIMWB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 18:01:26 -0400
Received: by mail-pg1-f194.google.com with SMTP id 2-v6so3021944pgo.4;
        Thu, 13 Sep 2018 09:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=q2xjXa9tXM8hHCQQp1h1B9WXJr7pdXE3pUUxfr42lOE=;
        b=AD9YfyLCkpFCWACwtWbAEEvQzuVzMep7NaVBS5EJkeS0KFfPiJnp6CDV3VjUefk9Oj
         0Mv2B5/E7Xv6GvXHGA1Vpsnxu4secGe94hxY/6NSow1LYbvmUgg+kLBr45V4DNJ0svmC
         7ELyhUcZwhunfgFtV79laDpGI9GwVVp88sB5FtdyN55G8VNrP80tXRVtPos6ixU8iZkY
         CeKzdMYeeQzsXRe1L0NLVMZzPBTwLP11bBjMPWGHmmCGWr3mywePTr8mvAcO5MImCBUc
         9hQIA3IwJWZ3JsTcyzIS2qtOTIdcSTrXLVzePxcTZd9uRfvezqKwmbWNtvw+uwIJcCJs
         mx1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=q2xjXa9tXM8hHCQQp1h1B9WXJr7pdXE3pUUxfr42lOE=;
        b=Kt8C3IwBPxWMS+GA2i+/3Kf686KYIKmqFe8OfRBzGIrHVbltWIv2jPXeul0EE77lee
         GWQphADwHE3IjXAmlZcr2nriosu73D4Ill3ICoBTQZYewEB0JTloWXfyD2KtfSYHwD+5
         snMHn+u2Q9z80GxFTkimWvQJh44F0V7TUsyS6A3+E8WyWu9joofgLGa0MXYv8bnlZMj0
         puAFGhJ4HHf5BS/otg8SWeuMxPpURxtZKJ9+qhoneBCimFAN7xBSUY0X2izfXH+reHXP
         flAnrxoKRkTI/5WZasTZX721u02U/Qt2pGDJsIKbIEuKzHGiZUbNIC92VGrMICk3SjqF
         qi/Q==
X-Gm-Message-State: APzg51AuSjyoBRvdUVyIcFthvHgKUbTPtdkE2blFFdz+NeYZw8A7fo4g
        Er73YA48M7atNiYE5VOYBAzEddln
X-Google-Smtp-Source: ANB0VdZTnUt5G/VR2ipb6i+/1ofMNIOiQh7+VV3PiQNEr21IEvn8n5kC5UfpdENBvYnjHzqsx0MuzQ==
X-Received: by 2002:a62:280a:: with SMTP id o10-v6mr8242787pfo.129.1536857466933;
        Thu, 13 Sep 2018 09:51:06 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id v26-v6sm5988790pfe.57.2018.09.13.09.51.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Sep 2018 09:51:05 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next] net: dsa: b53: Do not fail when IRQ are not initialized
Date:   Thu, 13 Sep 2018 09:50:45 -0700
Message-Id: <20180913165045.3802-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the Device Tree is not providing the per-port interrupts, do not fail
during b53_srab_irq_enable() but instead bail out gracefully. The SRAB driver
is used on the BCM5301X (Northstar) platforms which do not yet have the SRAB
interrupts wired up.

Fixes: 16994374a6fc ("net: dsa: b53: Make SRAB driver manage port interrupts")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/dsa/b53/b53_srab.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/b53/b53_srab.c b/drivers/net/dsa/b53/b53_srab.c
index 321052732799..90f514252987 100644
--- a/drivers/net/dsa/b53/b53_srab.c
+++ b/drivers/net/dsa/b53/b53_srab.c
@@ -415,7 +415,13 @@ static int b53_srab_irq_enable(struct b53_device *dev, int port)
 {
 	struct b53_srab_priv *priv = dev->priv;
 	struct b53_srab_port_priv *p = &priv->port_intrs[port];
-	int ret;
+	int ret = 0;
+
+	/* Interrupt is optional and was not specified, do not make
+	 * this fatal
+	 */
+	if (p->irq == -ENXIO)
+		return ret;
 
 	ret = request_threaded_irq(p->irq, b53_srab_port_isr,
 				   b53_srab_port_thread, 0,
-- 
2.17.1


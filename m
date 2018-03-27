Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752620AbeC0XUN (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 19:20:13 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:38171 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752552AbeC0XUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 19:20:10 -0400
X-Google-Smtp-Source: AIpwx49X3a/YxyDK0VyFloOm+POB2QWxwd+bstTpTIgoQwqSvle1+0VLbFJblxzhFJUN9NRwn8F3eQ==
From: Florian Fainelli <f.fainelli@gmail.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Scott Branden <scott.branden@broadcom.com>,
        Abhishek Shah <abhishek.shah@broadcom.com>,
        Florian Westphal <fw@strlen.de>,
        linux-kernel@vger.kernel.org (open list),
        bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH net-next 1/2] net: bgmac: Use interface name to request interrupt
Date: Tue, 27 Mar 2018 16:20:01 -0700
Message-Id: <20180327232002.29399-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180327232002.29399-1-f.fainelli@gmail.com>
References: <20180327232002.29399-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the system contains several BGMAC adapters, it is nice to be able
to tell which one is which by looking at /proc/interrupts. Use the
network device name as a name to request_irq() with.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/ethernet/broadcom/bgmac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bgmac.c b/drivers/net/ethernet/broadcom/bgmac.c
index 8eef9fb6b1fe..46d7b8068425 100644
--- a/drivers/net/ethernet/broadcom/bgmac.c
+++ b/drivers/net/ethernet/broadcom/bgmac.c
@@ -1190,7 +1190,7 @@ static int bgmac_open(struct net_device *net_dev)
 	bgmac_chip_init(bgmac);
 
 	err = request_irq(bgmac->irq, bgmac_interrupt, IRQF_SHARED,
-			  KBUILD_MODNAME, net_dev);
+			  net_dev->name, net_dev);
 	if (err < 0) {
 		dev_err(bgmac->dev, "IRQ request error: %d!\n", err);
 		bgmac_dma_cleanup(bgmac);
-- 
2.14.1

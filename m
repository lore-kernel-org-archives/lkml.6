Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752133AbeEUSsI (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 14:48:08 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:41529 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751154AbeEUSql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 14:46:41 -0400
X-Google-Smtp-Source: AB8JxZpn0Se5iGfHYLvxoB/8rD5gWYn+jtOfc83G3XGdcqpJ/RwuE2Jpe3BdQNfG1i811JHgazbklg==
From: Florian Fainelli <f.fainelli@gmail.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>, Keerthy <j-keerthy@ti.com>,
        Bhumika Goyal <bhumirks@gmail.com>,
        =?UTF-8?q?Hern=C3=A1n=20Gonzalez?= <hernan@vanguardiasur.com.ar>,
        Richard Cochran <richardcochran@gmail.com>,
        Lukas Wunner <lukas@wunner.de>, Rob Herring <robh@kernel.org>,
        linux-omap@vger.kernel.org (open list:TI ETHERNET SWITCH DRIVER (CPSW)),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 4/5] net: ethernet: davinci_emac: Fix printing of base address
Date: Mon, 21 May 2018 11:45:54 -0700
Message-Id: <20180521184555.21555-5-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180521184555.21555-1-f.fainelli@gmail.com>
References: <20180521184555.21555-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use %pa which is the correct formatter to print a physical address,
instead of %p which is just a pointer.

Fixes: a6286ee630f6 ("net: Add TI DaVinci EMAC driver")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/ethernet/ti/davinci_emac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ti/davinci_emac.c b/drivers/net/ethernet/ti/davinci_emac.c
index abceea802ea1..be0fec17d95d 100644
--- a/drivers/net/ethernet/ti/davinci_emac.c
+++ b/drivers/net/ethernet/ti/davinci_emac.c
@@ -1930,8 +1930,8 @@ static int davinci_emac_probe(struct platform_device *pdev)
 
 	if (netif_msg_probe(priv)) {
 		dev_notice(&pdev->dev, "DaVinci EMAC Probe found device "
-			   "(regs: %p, irq: %d)\n",
-			   (void *)priv->emac_base_phys, ndev->irq);
+			   "(regs: %pa, irq: %d)\n",
+			   &priv->emac_base_phys, ndev->irq);
 	}
 	pm_runtime_put(&pdev->dev);
 
-- 
2.14.1

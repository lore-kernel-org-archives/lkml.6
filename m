Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0907EC43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 14:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B18642754D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 14:38:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Tho2VFEo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B18642754D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966910AbeF1OiS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 10:38:18 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:41621 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966652AbeF1OdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 10:33:20 -0400
Received: by mail-wr0-f194.google.com with SMTP id h10-v6so5751856wrq.8
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 07:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zArp1LhynJj6PtR0vOEIzjnAxQ8D1ftfqwxGbTe1BC8=;
        b=Tho2VFEoma3gScYSolCFaegTDcAIdusxa2EyCbSnryNnBYTkvc3NpDVGCVjQQ2PGAY
         ULGBFNug8kWtxZJRj90BdRMzf6Mvlad8HUo+8D3+5shfUxzmQIx2p2K79apVTIueBa9d
         aOXBePlopH3HMkhdrt2LkH0xAZNNxUymq/E8kUaEj+QCJBeRqf0Y7gvT3pY1fLldJIKY
         FTh+SV3eu3oG+WlwUMzG6Bj+As5XJvCBsgOl87Fh76guefu1RyMLFFieCdaNAlPwCeL2
         2DwX3Mq7UzagZ0YDkuQTNl80rhpAUFtxrFgndhbpmUKyVgRUv1bh19dbVjoaduMS6or3
         FQEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zArp1LhynJj6PtR0vOEIzjnAxQ8D1ftfqwxGbTe1BC8=;
        b=aFay5opMcJx7rWj+Alw3dYlT2FsZqim5W6TCxFkccC75yqESsAmNsH84fK0V20B4/N
         Gbf6/rYMFyive4AeI5/nEQ5DHy+cFRgT1AlOOmex+NqOYo6V41/+1/cn59w+D9Ik2qpD
         1qWxiYIOgYUohn4OvZhLEFRcW4dxuJCD1+twW2yhF130vKeRzQQnaxdk6xB7s5LzSRJO
         DugP6JsLIyBQpaVUoshm2MSnv2asvVtnYdCZ1tDMYEsQNcsLZnvnjw6MJf2jigNbdFLk
         wqWRkHGDDE6tgUQpZD5PoFWLUHt40Ybxx/hJ67rhrJxjDXrpe4rOz4D3Kyd2MONRKHyO
         oF/w==
X-Gm-Message-State: APt69E1mM6/PwrGHNkT3XMgcHxOyM0gPK+cRInv0P7cOkWTQNG/XjL+j
        IjTYtS0ydJ0lG74tJ+t6JFMOGg==
X-Google-Smtp-Source: AAOMgpferG7vInksNBqhlY07+BTByLC8v82b1odTpS39rwpuYeArbh8M1LBoj1wWwfwtvwXArHAa1w==
X-Received: by 2002:adf:ba8c:: with SMTP id p12-v6mr2223104wrg.139.1530196399185;
        Thu, 28 Jun 2018 07:33:19 -0700 (PDT)
Received: from brgl-bgdev.baylibre.local (AStLambert-681-1-87-41.w90-86.abo.wanadoo.fr. [90.86.29.41])
        by smtp.gmail.com with ESMTPSA id 4-v6sm8037499wmh.14.2018.06.28.07.33.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 07:33:18 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S . Miller" <davem@davemloft.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Lukas Wunner <lukas@wunner.de>, Rob Herring <robh@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        David Lechner <david@lechnology.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Lunn <andrew@lunn.ch>, Jonathan Corbet <corbet@lwn.net>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 08/18] net: davinci_emac: potentially get the MAC address from MTD
Date:   Thu, 28 Jun 2018 16:32:34 +0200
Message-Id: <20180628143244.4561-9-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180628143244.4561-1-brgl@bgdev.pl>
References: <20180628143244.4561-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

On da850-evm board we can read the MAC address from MTD. It's currently
done in the relevant board file, but we want to get rid of all the MAC
reading callbacks from the board file (SPI and NAND). Move the reading
of the MAC address from SPI to the emac driver's probe function.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/net/ethernet/ti/davinci_emac.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ti/davinci_emac.c b/drivers/net/ethernet/ti/davinci_emac.c
index a1a6445b5a7e..17cfe093b8cf 100644
--- a/drivers/net/ethernet/ti/davinci_emac.c
+++ b/drivers/net/ethernet/ti/davinci_emac.c
@@ -67,7 +67,7 @@
 #include <linux/of_irq.h>
 #include <linux/of_net.h>
 #include <linux/mfd/syscon.h>
-
+#include <linux/mtd/mtd.h>
 #include <asm/irq.h>
 #include <asm/page.h>
 
@@ -1783,7 +1783,10 @@ static int davinci_emac_probe(struct platform_device *pdev)
 	struct cpdma_params dma_params;
 	struct clk *emac_clk;
 	unsigned long emac_bus_frequency;
-
+#ifdef CONFIG_MTD
+	size_t mac_addr_len;
+	struct mtd_info *mtd;
+#endif /* CONFIG_MTD */
 
 	/* obtain emac clock from kernel */
 	emac_clk = devm_clk_get(&pdev->dev, NULL);
@@ -1815,6 +1818,18 @@ static int davinci_emac_probe(struct platform_device *pdev)
 		goto err_free_netdev;
 	}
 
+#ifdef CONFIG_MTD
+	mtd = get_mtd_device_nm("MAC-Address");
+	if (!IS_ERR(mtd)) {
+		rc = mtd_read(mtd, 0, ETH_ALEN,
+			      &mac_addr_len, priv->mac_addr);
+		if (rc == 0)
+			dev_info(&pdev->dev,
+				 "Read MAC addr from SPI Flash: %pM\n",
+				 priv->mac_addr);
+	}
+#endif /* CONFIG_MTD */
+
 	/* MAC addr and PHY mask , RMII enable info from platform_data */
 	memcpy(priv->mac_addr, pdata->mac_addr, ETH_ALEN);
 	priv->phy_id = pdata->phy_id;
-- 
2.17.1


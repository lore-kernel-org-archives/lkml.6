Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 446A4C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 10:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6706268DE
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 10:23:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="aGsMNjy0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6706268DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934861AbeFZKXd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 06:23:33 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:39665 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934768AbeFZKXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 06:23:24 -0400
Received: by mail-wr0-f196.google.com with SMTP id b8-v6so11219548wro.6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 03:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8THROwGSGnXk0hxHJP7Nf3jSGvqc/RQbpn6H4owB8co=;
        b=aGsMNjy08uHjD4ofvmWtbY1E6u2AQOk76ycLsIrEaZIshKVxIGeebxZ5N/PxsDRwUZ
         3MuIPfKAa7aRmWEi76HxdWwo7qGesRHyJLwDjBJb9gl2iTdQw1MX8WTvlmpFTPYIZg5A
         Nl0xzsfWM86wXA86ocjUfEVU88Rt6B4eJ0cncpPVeKVk1Wz2CsEDR/ddGVFqlgDN2rFY
         Uk5fnZ3Z0j7EsSswYbCt8LBklU+YJyGVbZzF3EY8V5xSFBo6R0Md0vKFSiSWV5DAIxyy
         5XlVPFl4M8b0SEnbekTnsgGkwAOpF9G1ToDcVNJdqLSV2T8yGDepZ+u4eRJTifcm7dpB
         pSPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8THROwGSGnXk0hxHJP7Nf3jSGvqc/RQbpn6H4owB8co=;
        b=mYqRGcJ//jAkBdV9IkNuM9AL7FJ8oyIlT/ILgJtFtAIby4XHP7dbatjkYPalRHSBPn
         itWFJi2pNT9jAJ47/0DNzh4Y3j1oBOQlBXajs17DyJtllvGq6S9cB9cJkMZvsgXsDsR9
         LKx8d9p2XoeLoP8iiuZMt6lmHmwWzDnk/0ue1iZQ4hlobr5UO0HgMtFslKXD8kL8nZjO
         Q1zrFEUVNkWP9P6Km2hQ7qz33ErAQQgj20aY45AnGVe4hzq7DjtiLCRQr0eur3CbnWAC
         xt6KVF5vqzkVAMCDAD2OMjyASB1RaQ39InwCCcIy3Y+oIn/PciHEbRd5+/XK8KINll4M
         qlTg==
X-Gm-Message-State: APt69E2KM7Io8xrA/NbhMek7AJ+FrZ7dil3bAeutum1YsICM8w0Bz6Qa
        gienZJAHHw+jYQGo5XEaftyG0w==
X-Google-Smtp-Source: AAOMgpdVYc+IqN4X9kgs8dpvGni7fx/bjOfkd2kLBmertfyyFHwPcsNmIDG96JwGY+M8nzGkVNUTgw==
X-Received: by 2002:adf:fed2:: with SMTP id q18-v6mr960764wrs.165.1530008603619;
        Tue, 26 Jun 2018 03:23:23 -0700 (PDT)
Received: from brgl-bgdev.lan (LFbn-NIC-1-55-10.w2-15.abo.wanadoo.fr. [2.15.147.10])
        by smtp.gmail.com with ESMTPSA id 203-v6sm2573852wmp.23.2018.06.26.03.23.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 03:23:22 -0700 (PDT)
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
        Andrew Lunn <andrew@lunn.ch>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 07/15] net: davinci_emac: use nvmem to retrieve the mac address
Date:   Tue, 26 Jun 2018 12:22:37 +0200
Message-Id: <20180626102245.30711-8-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180626102245.30711-1-brgl@bgdev.pl>
References: <20180626102245.30711-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

All users which store the MAC address in EEPROM now register relevant
nvmem cells. Switch to retrieving the MAC address over the nvmem
framework. If we can't get the nvmem cell then fall back to using
the device tree.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/net/ethernet/ti/davinci_emac.c | 33 ++++++++++++++++++--------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/ti/davinci_emac.c b/drivers/net/ethernet/ti/davinci_emac.c
index a1a6445b5a7e..48b70bc7b9cf 100644
--- a/drivers/net/ethernet/ti/davinci_emac.c
+++ b/drivers/net/ethernet/ti/davinci_emac.c
@@ -67,7 +67,7 @@
 #include <linux/of_irq.h>
 #include <linux/of_net.h>
 #include <linux/mfd/syscon.h>
-
+#include <linux/nvmem-consumer.h>
 #include <asm/irq.h>
 #include <asm/page.h>
 
@@ -1696,7 +1696,6 @@ davinci_emac_of_get_pdata(struct platform_device *pdev, struct emac_priv *priv)
 	const struct of_device_id *match;
 	const struct emac_platform_data *auxdata;
 	struct emac_platform_data *pdata = NULL;
-	const u8 *mac_addr;
 
 	if (!IS_ENABLED(CONFIG_OF) || !pdev->dev.of_node)
 		return dev_get_platdata(&pdev->dev);
@@ -1708,12 +1707,6 @@ davinci_emac_of_get_pdata(struct platform_device *pdev, struct emac_priv *priv)
 	np = pdev->dev.of_node;
 	pdata->version = EMAC_VERSION_2;
 
-	if (!is_valid_ether_addr(pdata->mac_addr)) {
-		mac_addr = of_get_mac_address(np);
-		if (mac_addr)
-			ether_addr_copy(pdata->mac_addr, mac_addr);
-	}
-
 	of_property_read_u32(np, "ti,davinci-ctrl-reg-offset",
 			     &pdata->ctrl_reg_offset);
 
@@ -1783,7 +1776,9 @@ static int davinci_emac_probe(struct platform_device *pdev)
 	struct cpdma_params dma_params;
 	struct clk *emac_clk;
 	unsigned long emac_bus_frequency;
-
+	struct nvmem_cell *cell;
+	const void *mac_addr;
+	size_t mac_addr_len;
 
 	/* obtain emac clock from kernel */
 	emac_clk = devm_clk_get(&pdev->dev, NULL);
@@ -1815,8 +1810,26 @@ static int davinci_emac_probe(struct platform_device *pdev)
 		goto err_free_netdev;
 	}
 
+	cell = nvmem_cell_get(&pdev->dev, "mac-address");
+	if (!IS_ERR(cell)) {
+		mac_addr = nvmem_cell_read(cell, &mac_addr_len);
+		if (!IS_ERR(mac_addr)) {
+			if (is_valid_ether_addr(mac_addr)) {
+				dev_info(&pdev->dev,
+					 "Read MAC addr from EEPROM: %pM\n",
+					 mac_addr);
+				ether_addr_copy(priv->mac_addr, mac_addr);
+			}
+			kfree(mac_addr);
+		}
+		nvmem_cell_put(cell);
+	} else {
+		mac_addr = of_get_mac_address(np);
+		if (mac_addr)
+			ether_addr_copy(priv->mac_addr, mac_addr);
+	}
+
 	/* MAC addr and PHY mask , RMII enable info from platform_data */
-	memcpy(priv->mac_addr, pdata->mac_addr, ETH_ALEN);
 	priv->phy_id = pdata->phy_id;
 	priv->rmii_en = pdata->rmii_en;
 	priv->version = pdata->version;
-- 
2.17.1


Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75037C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 09:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2546027C7E
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 09:41:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="uMyVrERE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2546027C7E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935839AbeF2JlK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 05:41:10 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:43379 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935714AbeF2Jk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 05:40:58 -0400
Received: by mail-wr0-f195.google.com with SMTP id c5-v6so8198659wrs.10
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 02:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hsENybKG2M2NmdzWNb8guNW4ZYSvpwsjSUupTY9rPg0=;
        b=uMyVrEREEXe6AHnH4t3GsFxlQAZVfHlAkS/pUAPhPyhTWgUEPVMMDKE9mIfNbGum+n
         4ci6E+9sxf6uBmheoJKteTLgSvUPbH1xbH3YCp2duPIrpILHIvMW8ysLlRga+EufhR5e
         /dDO1Sw079TUNVw01veLAemiVMEYFyfdN3GF1DPnDyQLop3Mg+fx9rrAI4q0pCpAaARo
         IPkVXBxxfDfwcyyM2e5ieiNcH+oscKgXVkjIZOjpJTTjPQ4ecHsDp5rOAb7Q4SnU2zoP
         DOqdMrkQ40pDhx2XlUTeClUgPgBvPQShu3kUKp38UEQihyHLq4i50bdcbELc8yloRJDB
         O+Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hsENybKG2M2NmdzWNb8guNW4ZYSvpwsjSUupTY9rPg0=;
        b=hB0XuVQKLdndLfPI0+dFNXD6hrHkddUgJO8HkQBpgWhFNIeMUhHR3gn3U45F1DiOtI
         xa0XA34LWdRRp5xwCfA68+qNb0fUSX6Iydtk6ocIQAulL+Rieh3Hpp2u1bBN4oYNzPt2
         HnQmgB6/6KdmlXhsSv+anJqBoaOmS6lY22gJ1JAJdYfWfU9KB9+AqCoT3D91Q9Aj8uTJ
         1147yhjLfbgVcWabjBqakYONFuYMFk1KTlMgqQay1uxHw41VugPsDcRNWuHmRbtzYQ6m
         JXeOz625sQBljBEw9af9v4NcEAksnXOA4BNS2ICA2arDUoakXaVP+z1smRDEpkd+mwBP
         Yevg==
X-Gm-Message-State: APt69E07jRs4f8wF7VDlUMKcry7taAP9lh5dbKy/dIjlYQ/BuRpmKB2C
        d3UdAFuicEXBooEWp5qyRfk1sw==
X-Google-Smtp-Source: AAOMgpcENGOBuHt5Befq9QsZygoVpxBr85bXf50QQLN9ueTuI9gkiLWod/DiCykSnHfHMsjrEKDOMQ==
X-Received: by 2002:adf:8546:: with SMTP id 64-v6mr11081081wrh.223.1530265257456;
        Fri, 29 Jun 2018 02:40:57 -0700 (PDT)
Received: from brgl-bgdev.lan (LFbn-NIC-1-55-10.w2-15.abo.wanadoo.fr. [2.15.147.10])
        by smtp.gmail.com with ESMTPSA id d102-v6sm1386394wma.10.2018.06.29.02.40.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Jun 2018 02:40:56 -0700 (PDT)
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
Subject: [PATCH v4 10/18] net: davinci_emac: use nvmem to retrieve the mac address
Date:   Fri, 29 Jun 2018 11:40:31 +0200
Message-Id: <20180629094039.7543-11-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180629094039.7543-1-brgl@bgdev.pl>
References: <20180629094039.7543-1-brgl@bgdev.pl>
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
 drivers/net/ethernet/ti/davinci_emac.c | 35 +++++++++++++++++++-------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/ti/davinci_emac.c b/drivers/net/ethernet/ti/davinci_emac.c
index 48e6a7755811..ea303e1f7916 100644
--- a/drivers/net/ethernet/ti/davinci_emac.c
+++ b/drivers/net/ethernet/ti/davinci_emac.c
@@ -68,6 +68,8 @@
 #include <linux/of_net.h>
 #include <linux/mfd/syscon.h>
 #include <linux/mtd/mtd.h>
+#include <linux/nvmem-consumer.h>
+#include <linux/nvmem-consumer.h>
 #include <asm/irq.h>
 #include <asm/page.h>
 
@@ -1696,7 +1698,6 @@ davinci_emac_of_get_pdata(struct platform_device *pdev, struct emac_priv *priv)
 	const struct of_device_id *match;
 	const struct emac_platform_data *auxdata;
 	struct emac_platform_data *pdata = NULL;
-	const u8 *mac_addr;
 
 	if (!IS_ENABLED(CONFIG_OF) || !pdev->dev.of_node)
 		return dev_get_platdata(&pdev->dev);
@@ -1708,12 +1709,6 @@ davinci_emac_of_get_pdata(struct platform_device *pdev, struct emac_priv *priv)
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
 
@@ -1783,10 +1778,12 @@ static int davinci_emac_probe(struct platform_device *pdev)
 	struct cpdma_params dma_params;
 	struct clk *emac_clk;
 	unsigned long emac_bus_frequency;
-#ifdef CONFIG_MTD
+	const void *mac_addr;
 	size_t mac_addr_len;
+#ifdef CONFIG_MTD
 	struct mtd_info *mtd;
 #endif /* CONFIG_MTD */
+	struct nvmem_cell *cell;
 
 	/* obtain emac clock from kernel */
 	emac_clk = devm_clk_get(&pdev->dev, NULL);
@@ -1831,8 +1828,28 @@ static int davinci_emac_probe(struct platform_device *pdev)
 	}
 #endif /* CONFIG_MTD */
 
+	cell = nvmem_cell_get(&pdev->dev, "mac-address");
+	if (IS_ERR(cell) && PTR_ERR(cell) == -EPROBE_DEFER) {
+		return -EPROBE_DEFER;
+	} else if (!IS_ERR(cell)) {
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


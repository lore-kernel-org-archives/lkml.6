Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 085B2C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B06D125D69
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:54:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="hqJ+9FUe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B06D125D69
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755725AbeFYPyb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 11:54:31 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:38507 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754112AbeFYPv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 11:51:29 -0400
Received: by mail-wm0-f66.google.com with SMTP id 69-v6so10570377wmf.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 08:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=N/Du8nAZW4V9CZ8iTrJZf89xsDxWDMDJG9gzGrzquaA=;
        b=hqJ+9FUeb2kdZtI80CafheMPD2rBntwQhXKOHOB5dYFd6y7vNhB9U2qHWhgmvR5V2H
         iCi/3lCIALlwNbgMw66rx+3ur0fYI45DbFFiRhs0etz2cs7tCB5ZXMiivDKfw+yR2+vQ
         DcrbrHx+dpbIMBv+gXvJVbpUStJacdNgUZKlA/ifK0lDXM37ZJCn7Uzb0wo/uQg7TArM
         slb67JSp+9KsKrVhsLuP1h6a2m4aMhUJkmp3bmEiMalzTqYEus1JOPHZS91Mao27GFLU
         YkuUAfz/fsJWw1/TWPnvAAUyOJVj/OdTnzqP6qL3Mxs9NT1sUjfZrofyM2xrrVzeOZey
         w8Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=N/Du8nAZW4V9CZ8iTrJZf89xsDxWDMDJG9gzGrzquaA=;
        b=VqZvWt29R/j5MX76ETUnbF0XhWQ5MluM7Tlhf4J9DvhVMrXyWJb/jV15d9jxeMDT5V
         wpbiiJ0W+LoPvDYcZRKelo496XvjwfYYuRc5VXCj97UBZbisW9IdO4HQ9xBSEOPEL4ad
         DDAZ0k9J6WoqiFB8M341W0T8bvnVMoy8f+kkGWTzpjglF09YjK6ikk3G8z8jqj4jVXvS
         dk8peqE8Ukom+5cEnNmtHJ2ziUTRkh+3nFRG0hrVBK39DZHLtW6/GeKj3aLEp0TqZHyT
         m1Q9g8pOSZNJlxuZJ+WIPwN28sRDI4iCiqRfANR/2m/onOg74eCZo1XAQ6vjxDvKBhek
         GMxQ==
X-Gm-Message-State: APt69E189bKTSiPutHm2yXikzdhbHmPxht9Hs9ALyRv1hwZQNq2MvlKg
        /9dtOgNGaU1aPGMHIPoqw0mo3w==
X-Google-Smtp-Source: ADUXVKLSExRoxdKaLbCRM/aUBc94luSMthfsjKww1IOg3+MLFmH03LsrywH84zbxlm29nr1Ayhi93w==
X-Received: by 2002:a1c:928c:: with SMTP id u134-v6mr1427576wmd.106.1529941887867;
        Mon, 25 Jun 2018 08:51:27 -0700 (PDT)
Received: from brgl-bgdev.home ([2a01:cb1d:af:5b00:e837:b8d5:48c1:571b])
        by smtp.gmail.com with ESMTPSA id x16-v6sm3523737wro.13.2018.06.25.08.51.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 08:51:27 -0700 (PDT)
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
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 07/14] net: davinci_emac: use nvmem to retrieve the mac address
Date:   Mon, 25 Jun 2018 17:50:18 +0200
Message-Id: <20180625155025.12567-8-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180625155025.12567-1-brgl@bgdev.pl>
References: <20180625155025.12567-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

All users which store the MAC address in EEPROM now register relevant
nvmem cells. Switch to retrieving the MAC address over the nvmem
framework.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/net/ethernet/ti/davinci_emac.c | 29 +++++++++++++++++---------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/ti/davinci_emac.c b/drivers/net/ethernet/ti/davinci_emac.c
index a1a6445b5a7e..22c2322e46be 100644
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
+	void *mac_addr;
+	size_t mac_addr_len;
 
 	/* obtain emac clock from kernel */
 	emac_clk = devm_clk_get(&pdev->dev, NULL);
@@ -1815,8 +1810,22 @@ static int davinci_emac_probe(struct platform_device *pdev)
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
+				memcpy(priv->mac_addr, mac_addr, ETH_ALEN);
+			}
+			kfree(mac_addr);
+		}
+		nvmem_cell_put(cell);
+	}
+
 	/* MAC addr and PHY mask , RMII enable info from platform_data */
-	memcpy(priv->mac_addr, pdata->mac_addr, ETH_ALEN);
 	priv->phy_id = pdata->phy_id;
 	priv->rmii_en = pdata->rmii_en;
 	priv->version = pdata->version;
-- 
2.17.1


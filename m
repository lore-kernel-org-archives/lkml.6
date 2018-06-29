Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 200DBC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 09:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD71027CBA
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 09:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="x/WEF9td"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD71027CBA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933634AbeF2JpU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 05:45:20 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:39315 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933673AbeF2Jkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 05:40:55 -0400
Received: by mail-wr0-f194.google.com with SMTP id b8-v6so8196759wro.6
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 02:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IZodCBu9RKMn5bFdKnytyBJMiPRX8pbpaHzSg3Yr4PI=;
        b=x/WEF9tdkTIPNp8gGgda7AZpr+Rrrq1SRL5EtViKu9NTHGAeUxTeH5jYOQdWgt3bvp
         pq9lBoZ5+SpaF4MxXYEb/NnbrEJtF4JUdhsLzciZYZ8KZdKYNpLEWQ9NC0HwIcP4aXEs
         9CELn3SYbmI3SI97JiE32gcvrH1Smxs2fvhsopZfuEstt1Bbyn74APd8KEpwbzw8wvkt
         3GtPQooYFw4nL9xQ65Sz8ASqUtgKGTzI/pKx0MxCJcZemnElAOs8fc66fwk4qD8fHYLh
         9auMuUlWp2lJU9GqD0w4rIo/yDj0p66NYiF8u5NXMQXxOT4EvHC+eU7oqUNy9fL5mwwH
         ZkHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IZodCBu9RKMn5bFdKnytyBJMiPRX8pbpaHzSg3Yr4PI=;
        b=OCzX1GcVlJIynktykk2l42enuC5/+NBQrFb2Wlri7S23Ox6jbhQL/brL/xr+fLTPHb
         Bwnm4lp7ymStssiLENBAEPB8J6bR3c+VB3fkBEEfjnK8+MvF/fL5hpC+1dvHbC/+ZxYt
         bFB0KG/2cZ3jW/nzWdhBvI4YkMxeuvzsh+OZig650dDMjPdSE9PPHLWkPsrLjtIAUgYn
         9/LLWaFw7cZft8WPQ87nr9OpctwhM+4DLJ+Pia4dFef9SZBzot5iR/5bSKLqHKrEihaL
         DzIQCQMpqGq2TNa4h5jypXZOaAPWFZ7v81bzQ61DhH1NcOYBII9Rf/5v29Yy71ORuFEt
         N2OA==
X-Gm-Message-State: APt69E22Cesbs3R29NBL7SlrK4mLKt68u1+fKeyn0WwDI+5I/kK0ZgOq
        sB5vdyONkFGSYPCnD7ZcA0MMlA==
X-Google-Smtp-Source: AAOMgpf/NLsHK+8sIjJYmGbtzgismMHaApEg8+FYA31F6K6e7Mvd8eLYMT/zdS8GIcQgRO+2FRRbBg==
X-Received: by 2002:adf:ef50:: with SMTP id c16-v6mr10829163wrp.182.1530265254611;
        Fri, 29 Jun 2018 02:40:54 -0700 (PDT)
Received: from brgl-bgdev.lan (LFbn-NIC-1-55-10.w2-15.abo.wanadoo.fr. [2.15.147.10])
        by smtp.gmail.com with ESMTPSA id d102-v6sm1386394wma.10.2018.06.29.02.40.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Jun 2018 02:40:53 -0700 (PDT)
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
Subject: [PATCH v4 08/18] net: davinci_emac: potentially get the MAC address from MTD
Date:   Fri, 29 Jun 2018 11:40:29 +0200
Message-Id: <20180629094039.7543-9-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180629094039.7543-1-brgl@bgdev.pl>
References: <20180629094039.7543-1-brgl@bgdev.pl>
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
 drivers/net/ethernet/ti/davinci_emac.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ti/davinci_emac.c b/drivers/net/ethernet/ti/davinci_emac.c
index a1a6445b5a7e..48e6a7755811 100644
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
@@ -1815,6 +1818,19 @@ static int davinci_emac_probe(struct platform_device *pdev)
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
+		put_mtd_device(mtd);
+	}
+#endif /* CONFIG_MTD */
+
 	/* MAC addr and PHY mask , RMII enable info from platform_data */
 	memcpy(priv->mac_addr, pdata->mac_addr, ETH_ALEN);
 	priv->phy_id = pdata->phy_id;
-- 
2.17.1


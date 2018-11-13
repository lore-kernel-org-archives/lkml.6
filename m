Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 143BBC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 14:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3B752080D
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 14:04:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="oGMfCF5O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3B752080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388278AbeKNACk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 19:02:40 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53064 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387934AbeKNAAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 19:00:35 -0500
Received: by mail-wm1-f65.google.com with SMTP id r11-v6so12019324wmb.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 06:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f7gfNo0gVKcDfyj3+9h+7K8WG/3dMlnqMt9RiFsd5OU=;
        b=oGMfCF5OK/DFgVAZh3Rr9U5F+3+4HDDdwtYaoNXWsvJdQ9FPpc2idSDfHlsKVgZbuH
         RejXdfaoXgVLoZjHBw6+KgD+sHBNqrCqQmLJDDmfMvb0M3lSpvjp37Cgl8pwaAE1XKtY
         WqEdsMolG/O8VhNJHsbYh45O7FRUPQ14M1cA5mLypKrVYs7lh8Q5Kk0CBiKNMG1qHt1Y
         hVnqj5V+4roGp6UtwBUgpWh6Njxh1UgU7jAlakCED4RMksvPt7S5mHVZRaUmBZc2P6f0
         xWdQfvqe33aZjMryRKn6M/RVxTuu4AG3Q2C54iWIHLxK/Ik6I19JRTSM0lUIX4+UVrP/
         QXlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f7gfNo0gVKcDfyj3+9h+7K8WG/3dMlnqMt9RiFsd5OU=;
        b=olKtx6eDanhJNSLBeSPx9kN4chvwd1j8IIg4FuzZRWqdLoKKaJ5Mbrk196X51WXBEM
         OuG5hssnwbFnJf+CXAhDV53DqFTtmNtGBA6pGBsAQvN2LAdYQw/CXEa7hg15EWb3dRgN
         Z2YAWucxIAFYvQW0X8HwHN9c74FHcTMG5sqjgch/4i0S0iQLGSNV70tramxWsL7Pt3Mf
         LQkJ3XkPaP6yf1zFBm26hAP4BUBfb8MIS65wXrv1ZBOweGDxQXOTg1HsdAD7xUcKxhxu
         v2udmUdNkfjxxSJ1iF9JvzrW/2f8AwMkAC3YPOKi7XVmWYbvaY9S0ExAOBbE54rkS3nb
         8bRQ==
X-Gm-Message-State: AGRZ1gL8Kw9ynK6PCrx4LNato22bdkys5pvdeA6kBDtbcVdw4HLex2CU
        UKkV6L+voTT9T5S475tgmHVd2g==
X-Google-Smtp-Source: AJdET5eC/isFPP/JoAHtDczboZRSpAdwg7+nsuETdSWEk/5qbg/R9UpvhswrRmqH3RC9hQD4j2v5tw==
X-Received: by 2002:a1c:2746:: with SMTP id n67-v6mr3358593wmn.116.1542117737445;
        Tue, 13 Nov 2018 06:02:17 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id m69-v6sm16604122wmb.8.2018.11.13.06.02.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 06:02:16 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "David S . Miller" <davem@davemloft.net>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Wolfram Sang <wsa@the-dreams.de>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-i2c@vger.kernel.org, linux-mtd@lists.infradead.org,
        netdev@vger.kernel.org, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 13/25] net: davinci_emac: use nvmem_get_mac_address()
Date:   Tue, 13 Nov 2018 15:01:21 +0100
Message-Id: <20181113140133.17385-14-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181113140133.17385-1-brgl@bgdev.pl>
References: <20181113140133.17385-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

All DaVinci boards still supported in board files now define nvmem
cells containing the MAC address. We want to stop using the setup
callback from at24 so the MAC address for those users will no longer
be provided over platform data. If we didn't get a valid MAC in pdata,
try nvmem before resorting to a random MAC.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/net/ethernet/ti/davinci_emac.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/ti/davinci_emac.c b/drivers/net/ethernet/ti/davinci_emac.c
index 9153db120352..840820402cd0 100644
--- a/drivers/net/ethernet/ti/davinci_emac.c
+++ b/drivers/net/ethernet/ti/davinci_emac.c
@@ -1912,11 +1912,15 @@ static int davinci_emac_probe(struct platform_device *pdev)
 		ether_addr_copy(ndev->dev_addr, priv->mac_addr);
 
 	if (!is_valid_ether_addr(priv->mac_addr)) {
-		/* Use random MAC if none passed */
-		eth_hw_addr_random(ndev);
-		memcpy(priv->mac_addr, ndev->dev_addr, ndev->addr_len);
-		dev_warn(&pdev->dev, "using random MAC addr: %pM\n",
-							priv->mac_addr);
+		/* Try nvmem if MAC wasn't passed over pdata or DT. */
+		rc = nvmem_get_mac_address(&pdev->dev, priv->mac_addr);
+		if (rc) {
+			/* Use random MAC if still none obtained. */
+			eth_hw_addr_random(ndev);
+			memcpy(priv->mac_addr, ndev->dev_addr, ndev->addr_len);
+			dev_warn(&pdev->dev, "using random MAC addr: %pM\n",
+				 priv->mac_addr);
+		}
 	}
 
 	ndev->netdev_ops = &emac_netdev_ops;
-- 
2.19.1


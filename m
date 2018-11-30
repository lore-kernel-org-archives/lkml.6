Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E63CBC65BAE
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC7C620868
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:21:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="w3qBpdwx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC7C620868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbeK3T3x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 14:29:53 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51477 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727115AbeK3T3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 14:29:52 -0500
Received: by mail-wm1-f65.google.com with SMTP id s14so4848436wmh.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 00:21:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hgb7Jf4JzQq+BZf3FS+sr7z0n9uuyVnC5JrBI/ymMjs=;
        b=w3qBpdwxixKSwtAr2cNDwRPb862aZc1l5jZUSeftGTT+U5xnaxdDyMnk0xCVgQ6Qr1
         SIpGBUmLI2/wwgvA7w/IDXtewl1fq4HIJLwy/U+iipgBZWPVgRk90vzPSB2AHS6MZhq9
         SPiMYg05c7lYy/rudI0Zsfq36kIQPgV3HJVlrjDKDeYId4r3huxbFbhvYt8GHoB7sd6J
         9U7QDoWPPlrCdFuVh11U8e7SRCNXcYGPlT6M2ZeBZot1EJCdo/qabOEUO8BIYDHo81BV
         WAdl3WIDrqfHscg45CxbMYHTcHzQRscZqOg0P/CXmAHugm8/xjTrJp0BAwDYN89bjRoI
         nGQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hgb7Jf4JzQq+BZf3FS+sr7z0n9uuyVnC5JrBI/ymMjs=;
        b=RvsnqqvSKj5zDa7V5xoZFXuqEr/6kz1Nzdss9k1xZtLxrEebMaI9xIzU48A84pV7jt
         EodPAO1Xqb4uDiMa8/pF/d3u5qXbvvtFS8Lep+8PW7b3bVbALjxBlaP75josMsJ9bDJF
         AHmgAziGI5HBFqp+YEumhEIXPhvQotMCbqACUChcX59+HtzcnKE8S/3uqYONkTtW8XhZ
         t1sTJH6PxXptaPW+pgE3U6fbeKonZQpHvvzgSm1Uw9DUdAEndnNzA3tJrCJZrEkXTxK9
         pEEcRL1REanfi7WeiYGYfYqqGm26BwoYFpStNau0k+sCDMiUq7hYzZkxsPMWk37b/GrU
         iqag==
X-Gm-Message-State: AA+aEWZDd71cb59KWBzg9I4Bys1jJKAPQBRERTIsEIQcXJqJBo08hlwH
        C0jOeNbfwoSEwm9mAJQVAKGGiw==
X-Google-Smtp-Source: AFSGD/ViqOg8nrUwEf+F8iUN8aKfzpJNyeWswKQvwjj7Pb3cp37fFbccS3X9uNfsKPQHRgnDZzfwuQ==
X-Received: by 2002:a1c:df46:: with SMTP id w67mr3264485wmg.51.1543566080748;
        Fri, 30 Nov 2018 00:21:20 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id x197sm6473374wmd.2.2018.11.30.00.21.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 00:21:20 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Grygorii Strashko <grygorii.strashko@ti.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "David S . Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [net-next][PATCH 3/4] of: net: kill of_get_nvmem_mac_address()
Date:   Fri, 30 Nov 2018 09:20:59 +0100
Message-Id: <20181130082100.6241-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181130082100.6241-1-brgl@bgdev.pl>
References: <20181130082100.6241-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We've switched all users to nvmem_get_mac_address(). Remove the now
dead code.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 drivers/of/of_net.c    | 39 ---------------------------------------
 include/linux/of_net.h |  6 ------
 2 files changed, 45 deletions(-)

diff --git a/drivers/of/of_net.c b/drivers/of/of_net.c
index 53189d4022a6..810ab0fbcccb 100644
--- a/drivers/of/of_net.c
+++ b/drivers/of/of_net.c
@@ -81,42 +81,3 @@ const void *of_get_mac_address(struct device_node *np)
 	return of_get_mac_addr(np, "address");
 }
 EXPORT_SYMBOL(of_get_mac_address);
-
-/**
- * Obtain the MAC address from an nvmem provider named 'mac-address' through
- * device tree.
- * On success, copies the new address into memory pointed to by addr and
- * returns 0. Returns a negative error code otherwise.
- * @np:		Device tree node containing the nvmem-cells phandle
- * @addr:	Pointer to receive the MAC address using ether_addr_copy()
- */
-int of_get_nvmem_mac_address(struct device_node *np, void *addr)
-{
-	struct nvmem_cell *cell;
-	const void *mac;
-	size_t len;
-	int ret;
-
-	cell = of_nvmem_cell_get(np, "mac-address");
-	if (IS_ERR(cell))
-		return PTR_ERR(cell);
-
-	mac = nvmem_cell_read(cell, &len);
-
-	nvmem_cell_put(cell);
-
-	if (IS_ERR(mac))
-		return PTR_ERR(mac);
-
-	if (len < ETH_ALEN || !is_valid_ether_addr(mac)) {
-		ret = -EINVAL;
-	} else {
-		ether_addr_copy(addr, mac);
-		ret = 0;
-	}
-
-	kfree(mac);
-
-	return ret;
-}
-EXPORT_SYMBOL(of_get_nvmem_mac_address);
diff --git a/include/linux/of_net.h b/include/linux/of_net.h
index 90d81ee9e6a0..9cd72aab76fe 100644
--- a/include/linux/of_net.h
+++ b/include/linux/of_net.h
@@ -13,7 +13,6 @@
 struct net_device;
 extern int of_get_phy_mode(struct device_node *np);
 extern const void *of_get_mac_address(struct device_node *np);
-extern int of_get_nvmem_mac_address(struct device_node *np, void *addr);
 extern struct net_device *of_find_net_device_by_node(struct device_node *np);
 #else
 static inline int of_get_phy_mode(struct device_node *np)
@@ -26,11 +25,6 @@ static inline const void *of_get_mac_address(struct device_node *np)
 	return NULL;
 }
 
-static inline int of_get_nvmem_mac_address(struct device_node *np, void *addr)
-{
-	return -ENODEV;
-}
-
 static inline struct net_device *of_find_net_device_by_node(struct device_node *np)
 {
 	return NULL;
-- 
2.19.1


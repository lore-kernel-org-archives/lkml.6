Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39821C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 14:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E78FA2086A
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 14:04:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="bv00UTRt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E78FA2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387948AbeKNAAf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 19:00:35 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37565 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387924AbeKNAAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 19:00:34 -0500
Received: by mail-wm1-f68.google.com with SMTP id p2-v6so11485235wmc.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 06:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ow7Ut1GNJ0NN6XzS8yWgikbMVrG9z5cqZIlLq+KQDIE=;
        b=bv00UTRtZfOTTESxlTwAP96Arhu8T5PCHrwxCFRnOc/Oew7CX7onM+8BVynHJ1ewPq
         H92YdHhZJxvAxuAQViJWKmgjAYYpAyxssPxW2bS73xu6kVuE1MeguhWX5zNNROFNt5IK
         Wkpq52HSVVGrkcsAPWyg78ES3X1G5fTD/xfkeux4KNE7/MgHAiXOzTffGrcjtKm9Zk3S
         7XDqtNs/D3ERfaLn5rWXejg1atmqKKw22zrgVFAfiUhB7fq1hrNHA6aSNaav0JxqDX+2
         eg51yFk5xxxQu8pxQgxFilbzRAe8Y2ynr3AO/XWyZVecGLfYoGdDWW7TlTuMAHRMwADY
         TCyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ow7Ut1GNJ0NN6XzS8yWgikbMVrG9z5cqZIlLq+KQDIE=;
        b=oGOAbzs4N8q4Z2vMidJZndSGyqD8DTmkOgiI/xIrBkzhcF/7dCVY5Krug3f5RBT0Dg
         t9sBcMc6pyrsz2tEN4TNrXkTFTGRVdmXMHw0C1W5mRMdEtPiQXMwSqaDd5lmncdz/AYM
         /tRhnWIDXln0Gg8Ii+Omwp8pbCG+v5lL3CS2/6RATkRsmh/XPGwsNllLs+izK+25nx3D
         o+SOHwP4QsSgeWiOd4a+SDAEU6HT+C04iNt74KEwwIjH1zJ53VdnFETws7GDTiuIJKUr
         UdPF/mq7tfPXbXd3xy/iTgAzkR3bXEioVUFVYE3lznTkidplBVUU/3JpK/9mSPf0D3EE
         stcA==
X-Gm-Message-State: AGRZ1gJXnrw1Pg/ejdPMpq3a4Ni9jciQBHr7a9Z7ELETKCKR21Joa23U
        1Y+pU72TH1AAS7jGCrr1bkvb6g==
X-Google-Smtp-Source: AJdET5f1p898rgta//ar53TLhYOFfejlqpL3mlIo0fcQPy1QiZ+3q7s7/E75x/rDi2YpkEA93n4W2A==
X-Received: by 2002:a1c:3c83:: with SMTP id j125-v6mr3222964wma.65.1542117735429;
        Tue, 13 Nov 2018 06:02:15 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id m69-v6sm16604122wmb.8.2018.11.13.06.02.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 06:02:14 -0800 (PST)
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
Subject: [PATCH v2 12/25] of: net: kill of_get_nvmem_mac_address()
Date:   Tue, 13 Nov 2018 15:01:20 +0100
Message-Id: <20181113140133.17385-13-brgl@bgdev.pl>
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

We've switched all users to nvmem_get_mac_address(). Remove the now
dead code.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
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


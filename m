Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B8B1C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25039208B3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:28:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="uO9X2bjw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25039208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754260AbeFTI2y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 04:28:54 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35411 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754166AbeFTI2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 04:28:46 -0400
Received: by mail-wm0-f66.google.com with SMTP id j15-v6so5224736wme.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 01:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VX6K7u7qWji4zJugSW5OO83CLqi3CHnY/zhW1WkICh0=;
        b=uO9X2bjwdnNhGe8khgQKeiQ6uv9RU0NgRdpgPFndN5q1j8q4HeaFVANrH9ozsuXq5i
         cLZ9NCWwRdepANzNHt75tR7aEcXzKGGBgtKcBIyYlJsJekv3/uLC9MgKrENRfVZzwPTg
         W4+SB6b3kb1fzfwHsNKX9OUsk5z7YCCeGFfQcr/VQWE91GGm7LzgLIfgIHfOvn8A7oD+
         Chh1GiT1j2ZtfqSfBIfeNyGIY9jVa6L2MxttaE9evFrsskjAcD8qWT6mrivi+j9nIqr5
         RWm0CLOM+KC5+xf7msVZInXh2e5JAQz4ua+kol3TtYXZV2ajsLIwCjIQUPVWWZvZldup
         2Mww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VX6K7u7qWji4zJugSW5OO83CLqi3CHnY/zhW1WkICh0=;
        b=QX6mM4oUt+C4UX6z/iGGJOpvmR9sG4f6PHyHVt1NisDdjKCTEXWhO9tP0HGWbBbEa0
         TxdhEaaPyrT7DbNkzkhJ8u9STnXvCgt8IJwcATvneWStnTtWYIb/3K4lnam/L4fFT5jQ
         pYiIaOu9Va8ityI/HiTfanQfNoe1WIQeQJSMSR2sSEJGVIKD1BZfnFAMl5ldusOvKjec
         A1BosTUUSXkr0Ox+8o9AnTg3kbShN8mqMwOmyjabIdPb7z02fgVan2vEGM3SKXfybijy
         zWWaQmbGfTYTouJA3o45camQ1jW78Kmj4apOyyo7VkA5cPjjHp4FFOm6CV3IEOGe7XKi
         QB6Q==
X-Gm-Message-State: APt69E3vjL/Nv6yMWHYdiLr/q4RBjxnFh7TCOoIDbEbzM4sLpePXW/rN
        plvHt7SRt/zdc2rU8nZ9moLikw==
X-Google-Smtp-Source: ADUXVKIBf/IQJqDsp0CsZWpgs/AJDY/kKFl/9ykSNhQNx1Tj2hCzjis4UQdTbXQvUJ42/YlNaxQwSw==
X-Received: by 2002:a1c:9d49:: with SMTP id g70-v6mr865653wme.134.1529481844169;
        Wed, 20 Jun 2018 01:04:04 -0700 (PDT)
Received: from brgl-bgdev.baylibre.local (AStLambert-681-1-13-249.w90-86.abo.wanadoo.fr. [90.86.134.249])
        by smtp.gmail.com with ESMTPSA id t14-v6sm2131704wrm.79.2018.06.20.01.04.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jun 2018 01:04:03 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S . Miller" <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        Rob Herring <robh@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Kevin Hilman <khilman@kernel.org>,
        David Lechner <david@lechnology.com>,
        Sekhar Nori <nsekhar@ti.com>, Andrew Lunn <andrew@lunn.ch>
Cc:     linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        stable@vger.kernel.org
Subject: [PATCH v2 1/2] net: ethernet: fix suspend/resume in davinci_emac
Date:   Wed, 20 Jun 2018 10:03:55 +0200
Message-Id: <20180620080356.11900-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180620080356.11900-1-brgl@bgdev.pl>
References: <20180620080356.11900-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This patch reverts commit 3243ff2a05ec ("net: ethernet: davinci_emac:
Deduplicate bus_find_device() by name matching") and adds a comment
which should stop anyone from reintroducing the same "fix" in the future.

We can't use bus_find_device_by_name() here because the device name is
not guaranteed to be 'davinci_mdio'. On some systems it can be
'davinci_mdio.0' so we need to use strncmp() against the first part of
the string to correctly match it.

Fixes: 3243ff2a05ec ("net: ethernet: davinci_emac: Deduplicate bus_find_device() by name matching")
Cc: stable@vger.kernel.org
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Acked-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/net/ethernet/ti/davinci_emac.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ti/davinci_emac.c b/drivers/net/ethernet/ti/davinci_emac.c
index 06d7c9e4dcda..a1a6445b5a7e 100644
--- a/drivers/net/ethernet/ti/davinci_emac.c
+++ b/drivers/net/ethernet/ti/davinci_emac.c
@@ -1385,6 +1385,11 @@ static int emac_devioctl(struct net_device *ndev, struct ifreq *ifrq, int cmd)
 		return -EOPNOTSUPP;
 }
 
+static int match_first_device(struct device *dev, void *data)
+{
+	return !strncmp(dev_name(dev), "davinci_mdio", 12);
+}
+
 /**
  * emac_dev_open - EMAC device open
  * @ndev: The DaVinci EMAC network adapter
@@ -1484,8 +1489,14 @@ static int emac_dev_open(struct net_device *ndev)
 
 	/* use the first phy on the bus if pdata did not give us a phy id */
 	if (!phydev && !priv->phy_id) {
-		phy = bus_find_device_by_name(&mdio_bus_type, NULL,
-					      "davinci_mdio");
+		/* NOTE: we can't use bus_find_device_by_name() here because
+		 * the device name is not guaranteed to be 'davinci_mdio'. On
+		 * some systems it can be 'davinci_mdio.0' so we need to use
+		 * strncmp() against the first part of the string to correctly
+		 * match it.
+		 */
+		phy = bus_find_device(&mdio_bus_type, NULL, NULL,
+				      match_first_device);
 		if (phy) {
 			priv->phy_id = dev_name(phy);
 			if (!priv->phy_id || !*priv->phy_id)
-- 
2.17.1


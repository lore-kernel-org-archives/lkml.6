Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA4BC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 12:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D9E62075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 12:44:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="DS04Srdu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D9E62075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937825AbeFSMoS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 08:44:18 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:53663 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937771AbeFSMoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 08:44:15 -0400
Received: by mail-wm0-f68.google.com with SMTP id x6-v6so140596wmc.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 05:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=ADA5Q+NCfXV/mZjpNHccIMsB+3ZlXTeJHda7DVng7Y8=;
        b=DS04SrduV2R7sqXC3OLvfJD5CreVPYyANC5MhFbo85eF0TURJ+93PKyhdbjNoK1pkF
         f9rOxGf+M6G+LHws+ARD3Fn1PqK1vo7fTtPFLSVNhuvhRsa9iC2cm6H6HkcUQhPjNbAS
         i6uVLwCuQ4g2v9L+A5tSdm1MxuLvTgSPVO65AnlD7PWB9aBNcj4pw2KCxixuKgij/Eul
         DVkOgdocTOP5Xs5KZ/3r49R4PTeUyCe7XBVjnYOAJ+CrZllVI8xuTPL/HulFtM8Xz3Tg
         FWgitD3FS5LZud43iEpagM4rgcG+jBvEdmE82fDZ2EwNhe6KcdpuYyGlQPgm5a/633b0
         yfcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ADA5Q+NCfXV/mZjpNHccIMsB+3ZlXTeJHda7DVng7Y8=;
        b=kX4qzWqqo+7b0D/zVx7m14zIQFgWCUreuVRev4U2rT1uq3OE9cucdDxPpgm+zyKCf8
         AZ64dx81IhfFhqJQeZqnbdmOSRlvBayc/D71wtsyuW1/+RO4JOd5hvW0WbCgKCUc2ref
         MiwYkx5XZq1w2ifr0UiUCNd0Vvd2tQZVTbsQUV3WU+xBaCjsQPcB0NCReNi0u2TSqgfb
         kPN+83KASFus1NvYSQYjN8B1Bo4oT9MVajmUDssHL6JmEjE93VAfPtWReswmB/nYBgYD
         U8NZPCzJ7LJ3cvw1QmzW/gJ9eaZoWshUGp2GQy2hL8AusitTRULKm8/gNeI9msRDQTiu
         B5Vw==
X-Gm-Message-State: APt69E1IyuYon/PeCZp8NOk0kCHbPdqOugTX9cvB8LFnw/pDGAEX+mca
        XAM8RZOxyQNpPCNIAUv6s6/iuTfWoC4=
X-Google-Smtp-Source: ADUXVKKQpPIPK8mrPit/VRmMLzzYbEfPEv5OJbXjpCzhHvc0cQvGbDZ048SYPbIikItePVqcqrSekQ==
X-Received: by 2002:a1c:3504:: with SMTP id c4-v6mr11009875wma.59.1529412254584;
        Tue, 19 Jun 2018 05:44:14 -0700 (PDT)
Received: from brgl-bgdev.lan (LFbn-1-7080-22.w90-116.abo.wanadoo.fr. [90.116.249.22])
        by smtp.gmail.com with ESMTPSA id r2-v6sm18591142wrq.55.2018.06.19.05.44.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 05:44:13 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S . Miller" <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        Rob Herring <robh@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Kevin Hilman <khilman@kernel.org>,
        David Lechner <david@lechnology.com>,
        Sekhar Nori <nsekhar@ti.com>
Cc:     linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        stable@vger.kernel.org
Subject: [PATCH] net: ethernet: fix suspend/resume in davinci_emac
Date:   Tue, 19 Jun 2018 14:44:00 +0200
Message-Id: <20180619124400.11878-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.1
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


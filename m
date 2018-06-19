Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E31C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:11:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4971120661
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:11:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Pup7JuNJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4971120661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967104AbeFSQLL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 12:11:11 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:39002 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967036AbeFSQKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 12:10:01 -0400
Received: by mail-wr0-f196.google.com with SMTP id w7-v6so233691wrn.6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 09:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=V0eszlvvLll1jSCx8Hip/81hnp7ScaDxD1FHTBML81M=;
        b=Pup7JuNJPsFQJmBrceWSEs+VH9dBEmsCHIYo2HIu9Idvbh6YdnURDYkuFxMr7Ytwxv
         tAZv5dtEUoOtyTfU9ql3NxGHIvNRGDFrKyWbudD0Nw8Sw0pJdysfFVPphv8n44sEtUrJ
         6a1fWvEFihfJ9NkPkPK5askHHnsxZzPpyYsK0XPnRSn1UUQ/aCWnKeW9J3QMKdJjvCFq
         VMXXaAu8CjKt72VPhjNkeWTG0KnI8RRuj8B9pAoJuojHiy9ivab2bkrLMeFpcqoTVfIR
         AuJOn95quBCl0vT09/c4U6JZ7pTVXksL+zfVrCRYmZUniK/dNqyNE9340bII+azBDwUw
         KMgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=V0eszlvvLll1jSCx8Hip/81hnp7ScaDxD1FHTBML81M=;
        b=aJ35VybXHWARBFbRCyGEPsa6aHPpB1IcdGeLFcFQdh4nRX7VyIxOtxIE9NUQXmUER0
         iU+qNhw/6yTjUDzqWnhrbCpUCvUwzOHUPLXX8iv1/PBK8s5ZubJ+j3vJhEo2Swp86xRj
         IL5JzNiprZvgAXgPIKG5EcDM1iPYv8SiKca/l/OCCLPKVDKFBRJS7ila4OKjieXBAUER
         esHqMlPkj0fD8kJdVbnn0V0tFJhVfEYVt6u//ziNzhbqqlqwa+vjb6K5Cbtu/J1Wqvcf
         U9ORW0ghDgVSLH/qAhmix6jW4V3EYlrLEWxNQLZ0t7Dc7vGOgANXi1Mk6zQopfXI3tuC
         Cc+Q==
X-Gm-Message-State: APt69E01KkTXKBfetXK8ev0IXqoZQs5AxnsA05zoSiZCdPMTyOFhSDuY
        F0b8p0K6VP9fx9EtNp/EWqtICQ==
X-Google-Smtp-Source: ADUXVKJaVTiPlCpUoa36dwe6ePAOa5b4c+uRNPD+J7LeANUR0YkLK+UR85RMFB6VUBfCqhNpOhlt6g==
X-Received: by 2002:adf:9187:: with SMTP id 7-v6mr15765097wri.69.1529424600789;
        Tue, 19 Jun 2018 09:10:00 -0700 (PDT)
Received: from brgl-bgdev.lan (LFbn-1-7080-22.w90-116.abo.wanadoo.fr. [90.116.249.22])
        by smtp.gmail.com with ESMTPSA id 74-v6sm619327wmt.31.2018.06.19.09.09.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 09:10:00 -0700 (PDT)
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
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 2/3] net: phy: set the of_node in the mdiodev's struct device
Date:   Tue, 19 Jun 2018 18:09:49 +0200
Message-Id: <20180619160950.6283-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180619160950.6283-1-brgl@bgdev.pl>
References: <20180619160950.6283-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Copy the of_node over from mii_bus's struct device. This is needed
for device-tree systems to be able to check the mdio device's
compatible string.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/net/phy/phy_device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index bd0f339f69fd..a92d5ee61813 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -411,6 +411,7 @@ struct phy_device *phy_device_create(struct mii_bus *bus, int addr, int phy_id,
 	mdiodev->dev.parent = &bus->dev;
 	mdiodev->dev.bus = &mdio_bus_type;
 	mdiodev->dev.type = &mdio_bus_phy_type;
+	mdiodev->dev.of_node = bus->dev.of_node;
 	mdiodev->bus = bus;
 	mdiodev->bus_match = phy_bus_match;
 	mdiodev->addr = addr;
-- 
2.17.1


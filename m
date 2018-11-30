Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B15EAC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72C8D20868
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:21:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="SMCP04mH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72C8D20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727238AbeK3T3y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 14:29:54 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51128 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727037AbeK3T3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 14:29:53 -0500
Received: by mail-wm1-f65.google.com with SMTP id 125so4853129wmh.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 00:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f7gfNo0gVKcDfyj3+9h+7K8WG/3dMlnqMt9RiFsd5OU=;
        b=SMCP04mHX+HN8lYdExPwcBsPbSlvChP1SxdIPmKX1Ytvz+rpx1Z3k8xyxXiPGngx/I
         H89wzBI3hdnwTm1QfaKyi8iw2uOQLhtULTlj7Ado1sEL21QYE3mTpH+B9jJegADwpFby
         yANRPw/WRGlMgMO2r60UnuamjqMVnj5NyYWAPIuYhjgc9NIcYJhaoDmqq3QwMKT3ujnE
         rZ/wi2HNq5JuIlAlgQtUbU+CMSUsZRrVtXTh0xk/gW50jqOgsNd5OJWkbKgxMgG6vjIH
         aZTwe2oxlqmSTIMNFnf3DAnAQmdpEheCmYeZCPfnpTvFjyjhjRr3ZDSQlopIc7VYFTka
         8FWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f7gfNo0gVKcDfyj3+9h+7K8WG/3dMlnqMt9RiFsd5OU=;
        b=cTeuS3hNKQKuvCjz9cW2jxN1eraQPlWZXBX8PnaK26lA3iNck/u9kpo2vvvn2mZS3s
         HKAWLPXTUoZe6X/1Whf8pnqsDxPY4XJdVbZF4n0f5Zg0zor2RttzVEuEGdxyxzKlM7wd
         7osoa59L+bNnbGhVxbqSzBenUPN5QokRZBiFXTfOjC6bnH46Cp2R+zAHtayegGHKU0YW
         3hagMtFKx/OzgGxnhQD4HbgDZA1UrPRr4z0RkJz/kFcvTAO9EN35C3R0pQQYOKA4Cugn
         VcVjdMRTqUQ5Bey/4OgFyWfYU6hFHVUvbDO5gP2DKral1fVgqnaL1ksNtw7momCKeTTV
         ZU6w==
X-Gm-Message-State: AA+aEWaTV4DNm2r1W3bZ6jdb9ECOnqZ6p1dtM/qExfiKetKsa+Lrck70
        U1ujnY8QB+r1sP+iNLv++qLysw==
X-Google-Smtp-Source: AFSGD/VMhw3YbQrfCsu4V97PPFHUfcGIZvfrQo5y1/MLySEQGXyveI40+Q3kqQ5zsLdpXeB5yysX5Q==
X-Received: by 2002:a7b:c095:: with SMTP id r21mr4650862wmh.118.1543566081898;
        Fri, 30 Nov 2018 00:21:21 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id x197sm6473374wmd.2.2018.11.30.00.21.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 00:21:21 -0800 (PST)
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
Subject: [net-next][PATCH 4/4] net: davinci_emac: use nvmem_get_mac_address()
Date:   Fri, 30 Nov 2018 09:21:00 +0100
Message-Id: <20181130082100.6241-5-brgl@bgdev.pl>
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


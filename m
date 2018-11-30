Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F46C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:21:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4822F2146D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:21:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Uylz24i3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4822F2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbeK3T3w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 14:29:52 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44269 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727037AbeK3T3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 14:29:51 -0500
Received: by mail-wr1-f65.google.com with SMTP id z5so4360883wrt.11
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 00:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lJyx3gFlIK2rFy1vMeWyk8uHK8wEfTaZ3rmQd4bUKx4=;
        b=Uylz24i3Z8nlWHeBua5/oHwAl1P6w3quwD9Ohz1BD7tzbovLsSPX9/gU9WLtYyEEMx
         S2tiG67UL2pbV869G763TIQKa2F1V5hz4g3yM3NodQngSVXkUEUXNi64u4KgufleykUi
         V8EkFPjKtwDZUujFd8RZ/M+CYn46fOZYOZln3gx4ejhJs/3oaDaNzuNwzMx5kmitOMhF
         DCtdNFV5jUmjMAh8UyXQ07tRoVqXvmenQluwTtOOTMtRQElRvJYSJUttk2zdyMfXg9lj
         Re3rhLZuC3nCllfCtphzsm90GDYQ9RRNlp6OSLov6GU249/RNbg61TtuBAMJsr77FpDl
         VL2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lJyx3gFlIK2rFy1vMeWyk8uHK8wEfTaZ3rmQd4bUKx4=;
        b=Bdn/zxZuHuy3CLgPK2saG0lrzx3Ki0cjNQTN8o0e+V5X4ZHk5oDlLtyV4Tbqo2tsj0
         DxwKVPs0oXIzGCBvRMCS4fWj1NgOcgOKZkwe5mZS6iQj4D5qSRJj9ccjOFWrnzwiMEPV
         zDoaisb1eSWrJ+LHkqjwEBnL+8L+EgN4uWPX9+QgA9PiMZyNHVD0BwPOzY+z+FIS2KHh
         /U6N2JArq9/2GOhHLlZj/oXoaXPuW9ey5z1yId1Db6JxGW2BReaVPbf6iVhGau1/GSmG
         DwfJ2Ni0cKMlrgKcKojOrVYkZDMDOFArnpptP00nS+h/T3CVICMUQSi52Ue7ouF/+R2k
         P0pg==
X-Gm-Message-State: AA+aEWbgfMV7z5RBqYLz8j315aFEyFI5HFYaFv/vFGKNdm2Pv5mLfxVo
        vJ8pvC/L+YMS4RhD/1EF58GP5Q==
X-Google-Smtp-Source: AFSGD/WEGYJST2pq6nf7GYDCkLFIHvejs7k2Oh5l/VtmBG8TP/pq/RFvdlPU9WEumMa0mH5hI9KRnQ==
X-Received: by 2002:adf:cf0f:: with SMTP id o15mr4163625wrj.253.1543566079516;
        Fri, 30 Nov 2018 00:21:19 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id x197sm6473374wmd.2.2018.11.30.00.21.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 00:21:19 -0800 (PST)
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
Subject: [net-next][PATCH 2/4] net: cadence: switch to using nvmem_get_mac_address()
Date:   Fri, 30 Nov 2018 09:20:58 +0100
Message-Id: <20181130082100.6241-3-brgl@bgdev.pl>
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

We now have a generalized helper routine to read the MAC address from
nvmem which takes struct device as argument. The nvmem subsystem will
then try device tree first before all other potential providers.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 1d86b4d5645a..d9a208f7bb40 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -4055,7 +4055,7 @@ static int macb_probe(struct platform_device *pdev)
 	if (mac) {
 		ether_addr_copy(bp->dev->dev_addr, mac);
 	} else {
-		err = of_get_nvmem_mac_address(np, bp->dev->dev_addr);
+		err = nvmem_get_mac_address(&pdev->dev, bp->dev->dev_addr);
 		if (err) {
 			if (err == -EPROBE_DEFER)
 				goto err_out_free_netdev;
-- 
2.19.1


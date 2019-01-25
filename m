Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD794C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 12:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99C022146E
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 12:35:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="NH+D9D2T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728892AbfAYMfR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 07:35:17 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36638 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbfAYMfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 07:35:17 -0500
Received: by mail-wm1-f66.google.com with SMTP id p6so6480142wmc.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 04:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C6cgbyQOUygv1hbfYKYPxO9z/p0h3opFDof9GJvHFEQ=;
        b=NH+D9D2T5GW4Vs0VkLnExSuNpYivwmgcTLI08VNabC08LjYnYeqMvQbriHkVrM4HHa
         +T1isesimnHjV7c7ga2dN3k1s+W1Jz7/9Nhv2ATUQwIqJltAN2Y4osuCKOiOjAS24vqF
         9Fg0UUv6TtzRyYmRKHBdDXRn+4c7xKZdlEHpC/Iv6cdQHfyC+fYK9zAWAn5Dp68FjL8W
         eGyHSIgXR8dqtfebdO3s/mVv7bL8n65dpah/eSC2r3t8ddR474ofF/cvq+CRGcmq//ue
         ndqWxGfPCLkjd0SACUjvQgR4S0hIXJ17hDVHvrZIcWXerVzK77K+Zlg8kuQcpAou/SCm
         9gpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C6cgbyQOUygv1hbfYKYPxO9z/p0h3opFDof9GJvHFEQ=;
        b=lzoSByH5usxdn98huzUPtbO1l/g5HEepXP6VAeqUp6U2xz7bUufOk/SwBSb9Ddyy5C
         kqbTM44UzvMJWVpT5WQJrWX2CBemlBsf/FNBBYzwfeX8dS9bje2T8FKEazOT3efHqfOb
         kfuWme+ycmGXz1lVtrVfzTvgBMEBaNiHD5GWVAPlqdog6d7BigS9vj9/HqShZnuPxBpj
         IqA9c00RACtwCA+gPuFGhBrHjp71w/Je9UKopR0Vgd4LIQXOsWFknLEFz90w6UjCf273
         DwsCTNi4G7pvPjM3JL3BsVbIwqeDNuKLoonBYryp6MyBThlVn/0rtPAmsBixTn71PMdj
         7gJQ==
X-Gm-Message-State: AJcUukeqiRNRNriXWbx+tOo/2SfTH2YY8Mlcx36Q15g9KHpbW2aBqovJ
        7rE018sEPXJyXV3fimm/EJ/yVApjngc=
X-Google-Smtp-Source: ALg8bN4nqv304eoF6XK2gTlGMnhwmpViJgY9EhYZkBb+okpT+Y98qwqX+8mppvjw8d1mmC6PGNyLCA==
X-Received: by 2002:a1c:c008:: with SMTP id q8mr6130074wmf.99.1548419715738;
        Fri, 25 Jan 2019 04:35:15 -0800 (PST)
Received: from xps.expressvpn ([2a00:23c4:f7a1:ce00:5105:4b7b:c922:7c6])
        by smtp.gmail.com with ESMTPSA id n127sm72645352wmd.20.2019.01.25.04.35.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 04:35:14 -0800 (PST)
From:   Carlo Caione <ccaione@baylibre.com>
To:     andrew@lunn.ch, f.fainelli@gmail.com, hkallweit1@gmail.com,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Carlo Caione <ccaione@baylibre.com>
Subject: [PATCH] net: phy: at803x: Use helpers to access MMD PHY registers
Date:   Fri, 25 Jan 2019 12:35:10 +0000
Message-Id: <20190125123510.20511-1-ccaione@baylibre.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Libphy provides a standard set of helpers to access the MMD PHY
registers. Use those instead of relying on custom driver-specific
functions.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 drivers/net/phy/at803x.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
index f9432d053a22..23ba76f8d950 100644
--- a/drivers/net/phy/at803x.c
+++ b/drivers/net/phy/at803x.c
@@ -39,9 +39,6 @@
 #define AT803X_LOC_MAC_ADDR_0_15_OFFSET		0x804C
 #define AT803X_LOC_MAC_ADDR_16_31_OFFSET	0x804B
 #define AT803X_LOC_MAC_ADDR_32_47_OFFSET	0x804A
-#define AT803X_MMD_ACCESS_CONTROL		0x0D
-#define AT803X_MMD_ACCESS_CONTROL_DATA		0x0E
-#define AT803X_FUNC_DATA			0x4003
 #define AT803X_REG_CHIP_CONFIG			0x1f
 #define AT803X_BT_BX_REG_SEL			0x8000
 
@@ -168,16 +165,9 @@ static int at803x_set_wol(struct phy_device *phydev,
 		if (!is_valid_ether_addr(mac))
 			return -EINVAL;
 
-		for (i = 0; i < 3; i++) {
-			phy_write(phydev, AT803X_MMD_ACCESS_CONTROL,
-				  AT803X_DEVICE_ADDR);
-			phy_write(phydev, AT803X_MMD_ACCESS_CONTROL_DATA,
-				  offsets[i]);
-			phy_write(phydev, AT803X_MMD_ACCESS_CONTROL,
-				  AT803X_FUNC_DATA);
-			phy_write(phydev, AT803X_MMD_ACCESS_CONTROL_DATA,
-				  mac[(i * 2) + 1] | (mac[(i * 2)] << 8));
-		}
+		for (i = 0; i < 3; i++)
+			phy_write_mmd(phydev, AT803X_DEVICE_ADDR, offsets[i],
+				      mac[(i * 2) + 1] | (mac[(i * 2)] << 8));
 
 		value = phy_read(phydev, AT803X_INTR_ENABLE);
 		value |= AT803X_INTR_ENABLE_WOL;
-- 
2.19.1


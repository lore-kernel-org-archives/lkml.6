Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F3B1C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 10:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A1512184B
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 10:18:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="epch7Spf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbfAYKSS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 05:18:18 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39372 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbfAYKSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 05:18:18 -0500
Received: by mail-wm1-f65.google.com with SMTP id y8so6041452wmi.4;
        Fri, 25 Jan 2019 02:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QyQ9AIdVUJwCwqOKWtdmmXq8oE0L7KN5hHznG/uIXeQ=;
        b=epch7SpfSwcuY6VvlKah10EdsYIQElZi3ZzoD8q6yIli3BuMzDE4KNPuM5U+ZID1p5
         5ZZjOjDZEvD67RO9cYPav6acEGshxj2At2nXMwiL8RIvhE+0OHJE2tVKneGBKChoHS3r
         UDSMmrC5/w6GK5zfft2i6G4RMQzxTNe2b3Ni73/a3Y+5iMSPYHtQ+tV1BUewy7oGhmqd
         H7DNgdWBjpZdKoOP3xhwqHGnN3hf0rW5jbMtBnfFLQxLjtNnqEA/HaX8w4aWLAn3cRWk
         9vSgPKEcMk55d+tj4LvGjGdSNa9LSBufcxqzj9zzav3qQG2C74LsmhjhejY5T9NnL6Zd
         /6Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QyQ9AIdVUJwCwqOKWtdmmXq8oE0L7KN5hHznG/uIXeQ=;
        b=hBPC27/WNzogY8bcAs3ksAi/M1Vg5Qg+AjRAYA0BlMwxV2KbHYi+O59xtnesO5uKjl
         QzWgw41V110QDEmCJXBaRVnezbv9BzXRLeW4vNoRlMUqiT9UzWQLnJg+6u3bcAy47qEt
         chqcn6trT+Ml3EeWOSm3JG3roYmH7HDEd4j//Uy15USQPFcPDJkc/gUOrVSxE3ja6JT5
         hW89nCfr6p8xdM8lFlh5sS7goFFwZI4wPq4PUUk8rkGwTIxeDpOCcuti8+yxB2QZ/Tk+
         +zeYuBKFghZMOt1nbvPRpu3edhPHsMeXtASOOJk+hLI9KYPReFp5eqhij/h9SgHtp4A/
         1/cw==
X-Gm-Message-State: AJcUukcTGpEplHS+qppYWkqoIncOI9LJ1shqBGf2HDGmdu8cEwjg4VtA
        hyFv0wTXHyoVtwp6GrfvOklkKKVfz9M=
X-Google-Smtp-Source: ALg8bN6qHNVBCgQo9bybkbNZWFZkwAkS2zJzJ+YX8UmcYzGLLQHpGjA9t5O3NpHepBDX7f2MSK8ANw==
X-Received: by 2002:a1c:2804:: with SMTP id o4mr6563990wmo.150.1548411495904;
        Fri, 25 Jan 2019 02:18:15 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id y1sm81389205wme.1.2019.01.25.02.18.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 Jan 2019 02:18:15 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        Realtek linux nic maintainers <nic_swsd@realtek.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] r8169: Load MAC address from device tree if present
Date:   Fri, 25 Jan 2019 11:18:14 +0100
Message-Id: <20190125101814.6262-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

If the system was booted using a device tree and if the device tree
contains a MAC address, use it instead of reading one from the EEPROM.
This is useful in situations where the EEPROM isn't properly programmed
or where the firmware wants to override the existing MAC address.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Based on net-next.

 drivers/net/ethernet/realtek/r8169.c | 35 +++++++++++++++++-----------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169.c b/drivers/net/ethernet/realtek/r8169.c
index f574b6b557f9..fd9edd643ca5 100644
--- a/drivers/net/ethernet/realtek/r8169.c
+++ b/drivers/net/ethernet/realtek/r8169.c
@@ -6957,6 +6957,21 @@ static int rtl_alloc_irq(struct rtl8169_private *tp)
 	return pci_alloc_irq_vectors(tp->pci_dev, 1, 1, flags);
 }
 
+static void rtl_read_mac_address(struct rtl8169_private *tp,
+				 u8 mac_addr[ETH_ALEN])
+{
+	/* Get MAC address */
+	switch (tp->mac_version) {
+	case RTL_GIGA_MAC_VER_35 ... RTL_GIGA_MAC_VER_38:
+	case RTL_GIGA_MAC_VER_40 ... RTL_GIGA_MAC_VER_51:
+		*(u32 *)&mac_addr[0] = rtl_eri_read(tp, 0xe0, ERIAR_EXGMAC);
+		*(u16 *)&mac_addr[4] = rtl_eri_read(tp, 0xe4, ERIAR_EXGMAC);
+		break;
+	default:
+		break;
+	}
+}
+
 DECLARE_RTL_COND(rtl_link_list_ready_cond)
 {
 	return RTL_R8(tp, MCU) & LINK_LIST_RDY;
@@ -7148,6 +7163,7 @@ static int rtl_get_ether_clk(struct rtl8169_private *tp)
 static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	const struct rtl_cfg_info *cfg = rtl_cfg_infos + ent->driver_data;
+	u8 mac_addr[ETH_ALEN] __aligned(4);
 	struct rtl8169_private *tp;
 	struct net_device *dev;
 	int chipset, region, i;
@@ -7252,20 +7268,13 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	u64_stats_init(&tp->rx_stats.syncp);
 	u64_stats_init(&tp->tx_stats.syncp);
 
-	/* Get MAC address */
-	switch (tp->mac_version) {
-		u8 mac_addr[ETH_ALEN] __aligned(4);
-	case RTL_GIGA_MAC_VER_35 ... RTL_GIGA_MAC_VER_38:
-	case RTL_GIGA_MAC_VER_40 ... RTL_GIGA_MAC_VER_51:
-		*(u32 *)&mac_addr[0] = rtl_eri_read(tp, 0xe0, ERIAR_EXGMAC);
-		*(u16 *)&mac_addr[4] = rtl_eri_read(tp, 0xe4, ERIAR_EXGMAC);
+	/* get MAC address */
+	if (eth_platform_get_mac_address(&pdev->dev, mac_addr))
+		rtl_read_mac_address(tp, mac_addr);
+
+	if (is_valid_ether_addr(mac_addr))
+		rtl_rar_set(tp, mac_addr);
 
-		if (is_valid_ether_addr(mac_addr))
-			rtl_rar_set(tp, mac_addr);
-		break;
-	default:
-		break;
-	}
 	for (i = 0; i < ETH_ALEN; i++)
 		dev->dev_addr[i] = RTL_R8(tp, MAC0 + i);
 
-- 
2.19.1


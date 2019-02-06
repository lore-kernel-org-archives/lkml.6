Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA98C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 12:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77E1D218A4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 12:30:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iU3wLvID"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730414AbfBFMaX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 07:30:23 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40077 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727710AbfBFMaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 07:30:22 -0500
Received: by mail-wr1-f68.google.com with SMTP id p4so7336095wrt.7;
        Wed, 06 Feb 2019 04:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XocHWDy3JkZ230roSe3THeQ0tWX1M8J9RndFd/nyPiA=;
        b=iU3wLvIDIn1V03I2qpz/8uvH657etNti2xYmuQtzLZiNBTIx+JxpdRvUUEwV+2pt4Q
         zhgkgivv8KjE27gBd/ps3m9ScmQ4zrowUF8BNXBtjolJTRdxXXjbraUkChgLWMzHkPa5
         gPG/fz8L5daD1OG4mw/WXTVAN58yjHmMXvLa2pVntWwohhbVx6CCfoGZ/6U03zct4j5W
         OE3JgDRqH4cGrlnPQ19jt9y6uT1nlknvmcozyvS+9577h9I8E0Psy+/9typWHzOHLURe
         u6UxGmxxXJC6NQdue0cif1LChtxcEKcbEjpQ7KxAaNnOZ7BliRg6dCWbs/KG9SuGyKk3
         TUoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XocHWDy3JkZ230roSe3THeQ0tWX1M8J9RndFd/nyPiA=;
        b=gqqbxqM1ZKx1WrOtQeTi//ncutSCEr0jsqyeAfxZiJO9pd7nhUbu+eLuZxcZON/7cV
         5tE495HdmNKrcmttSPDe1FLO0zhqOk0cf2+zJ2Wc9qhjysn60cIUoG6hhcGa+uSWMvCW
         iOkh5INTWgJx6MFlYl6E7kx9L5nmmxEdwMxwGu2mwPS6PITrgGWh3ZE6Jar3+AUdTW+k
         LAhh51T7vk1YkWKX7LZS92Fuvthry9X/13D/odtK27HQZN9Uzo9rmF+V83fsZtw+Czox
         XNqai1Xdg93hiLWCSQZ7MWKfKmWh3SqNdFb97Hlt/9QY2DMjM141sRzE2oy/ZNwOdZHS
         4e6g==
X-Gm-Message-State: AHQUAuabTvnxnrsaYPI+n4ILTKqeg9I4VWf/uhNd+Nv5A+hjBw/kYvnw
        JpCxYWyr3BIcl0dKZs0DBzA=
X-Google-Smtp-Source: AHgI3IZAdyWmFS2kHzphCquPPW9IcbrdW4bZ8ePa8ygSAwRkMHmsTpPFtLl8Xdixdw/1FEwuWDgJQA==
X-Received: by 2002:adf:c505:: with SMTP id q5mr7606109wrf.84.1549456220083;
        Wed, 06 Feb 2019 04:30:20 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id a132sm33860801wmh.5.2019.02.06.04.30.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 04:30:19 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>, Joe Perches <joe@perches.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Paul Zimmerman <pauldzim@gmail.com>,
        Michal Kubecek <mkubecek@suse.cz>,
        Realtek linux nic maintainers <nic_swsd@realtek.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] r8169: Load MAC address from device tree if present
Date:   Wed,  6 Feb 2019 13:30:17 +0100
Message-Id: <20190206123018.24802-1-thierry.reding@gmail.com>
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
Applies on net-next.

Changes in v2:
- rewrite error check for readability
- initialize mac_addr array

 drivers/net/ethernet/realtek/r8169.c | 36 ++++++++++++++++++----------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169.c b/drivers/net/ethernet/realtek/r8169.c
index e8a112149a62..501891be7c56 100644
--- a/drivers/net/ethernet/realtek/r8169.c
+++ b/drivers/net/ethernet/realtek/r8169.c
@@ -7110,6 +7110,21 @@ static int rtl_alloc_irq(struct rtl8169_private *tp)
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
@@ -7301,6 +7316,7 @@ static int rtl_get_ether_clk(struct rtl8169_private *tp)
 static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	const struct rtl_cfg_info *cfg = rtl_cfg_infos + ent->driver_data;
+	u8 mac_addr[ETH_ALEN] __aligned(4) = {};
 	struct rtl8169_private *tp;
 	struct net_device *dev;
 	int chipset, region, i;
@@ -7403,20 +7419,14 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
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
+	rc = eth_platform_get_mac_address(&pdev->dev, mac_addr);
+	if (rc)
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


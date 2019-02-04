Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEFF3C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 16:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EF7520823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 16:42:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BUK18UxN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729753AbfBDQmT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 11:42:19 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45350 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728791AbfBDQmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 11:42:18 -0500
Received: by mail-wr1-f65.google.com with SMTP id q15so496540wro.12;
        Mon, 04 Feb 2019 08:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vEZh4Vb6WlyoK2dCleg7LPen3l6UpLhkjMsz2qZaOGI=;
        b=BUK18UxNtJ+kZOUiGR461VP2bqm1ZW7kvthWjRS7igqj+rLNPnSYGj1aUAZtLWw9bv
         fFojEX656a0Jvx14wSy1tQkncEAe5V2DCjz1duwg+JDbBcHQJJPq0JfeIF2MRnGZAu8r
         DnG8ruTmvNSylif07bXhEHdsqaAlBB7lZNEa7jOZzXJhG78Znt7P8ii+JWhDEW/cEArU
         bZ13ZI2hFj+1jaZU8P9RaenIMn8g8P9YlQYhZ+30TIn3dQUolEqGhjgmgYD4zZxQ3/eB
         URu6UwoyF6q3WpvojSPdOkDkdBKj4ZklkRIrSUoZK0xzx+lbfATGdBf5sB0Zwj0VtT7P
         ezCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vEZh4Vb6WlyoK2dCleg7LPen3l6UpLhkjMsz2qZaOGI=;
        b=cWMHG175Yjxa3TJQxUSlk7kOUu4BSVFz4xtPrMTbWsdvCnHHc9BQnhxDRx1bmhY1uI
         QionKI8a3hczUE9+ie0iwwA1HRifTzDZmGjuqTg+z+CQzzldjO0vr6u9YVNJQsMVshf8
         RJ+jK43oBRLFrMy/60vqlLoCFz3jRsoIozCOBAuuguWYjYNTmbUdTbli4uNGDlEe8v77
         eNFnSiHqylHuDC5nRxfPO3cY3/h38G3to6m535NgfgBw0ElbRxePVfHn6Eic4hliJ/YT
         ZQTPAnKdCMnfg22n52ZC/Zf223hzdba9FZimoCEWE7KUvSg519lxRZq+GhOTmQk5Y3b1
         cX9g==
X-Gm-Message-State: AHQUAub13OVqfo9P/3dDbhQr5o/NpLLsyFoEVvOYQZRSorNOT5is1iBB
        +fuQDlO2zcI30bCUb3iKxx0=
X-Google-Smtp-Source: AHgI3Ib/Hl2uaVprS8tjLSqG4wAflaDC8nPwp4LcZ8KCvk+UGcZV+uF0DqnIBEXJqRUG6k/PwVzIxg==
X-Received: by 2002:a5d:530a:: with SMTP id e10mr192150wrv.151.1549298535558;
        Mon, 04 Feb 2019 08:42:15 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id g188sm18521604wmf.32.2019.02.04.08.42.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Feb 2019 08:42:14 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Realtek linux nic maintainers <nic_swsd@realtek.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 1/2] r8169: Load MAC address from device tree if present
Date:   Mon,  4 Feb 2019 17:42:12 +0100
Message-Id: <20190204164213.30727-1-thierry.reding@gmail.com>
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
Applies to net-next.

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


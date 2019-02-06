Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ACEDC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 12:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5796A20B1F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 12:30:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="utJhRuLq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730472AbfBFMa0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 07:30:26 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35960 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728167AbfBFMaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 07:30:23 -0500
Received: by mail-wr1-f67.google.com with SMTP id z3so7363133wrv.3;
        Wed, 06 Feb 2019 04:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p+V+ugKLmy1ndrNliBfqiopLtR1Ests8dXxdeFR9BBs=;
        b=utJhRuLqjsE0TQIzdZfoW29ZLUG3Ys/qOs74lzpfuny257ZbdvxMQWwxL4/+/HJxap
         aPClm2CY6SFZk3eydMqrGAKJWvLj81OYk045+mtKuby2N4W0lXHXHXTaLv1AO5jb1hhP
         CjUP9bkhTgbJFw+xyECkk5sM/3XV3S/HEnxLW4D/hKQL2sqWiibslRv7iHOSvuIEK8Ml
         Z1q1FtP+Zosoi8ZIQbFmgpVhMJRFbVLxI6oY2f/pejd32wpqQFEwb1S8iSp2rYcK/r5c
         CUt7SZ6WgF66fb0gFNij1fQcCtT0LRQatkzoAOcTSIJD10edQAK0BbyIWH/J7TotJedq
         SG0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p+V+ugKLmy1ndrNliBfqiopLtR1Ests8dXxdeFR9BBs=;
        b=efkbHOucmTCtZgQz6aIEfk3sbht1nonNOkhxiTaHItRmMmjow8gFGq+pCzq/CqSo5p
         txEe8G8WM//Mf+1OjdLGXl5uwXJ6TyEKK1I7847EvhcBjboE5r/GO/lYJ9Zt3fdENTC9
         bhRu9BUh6HJOwnaaM1CN2A7lLcSuvk5FX3j/g2QsdQPtFmKlOJ63u0FY9oCnQOOZdd1a
         sXOVz3T0z36FhzuWf0+eygdFgq94YxGfeC3qLBQlxvNLQJrdbDvO6fFECCfL/VeeRSwb
         drB7z+TLAogJICrLLW74xVKUA81as3gr1+24RFgQYknqw8J8ZlUADV/RuHE1IKMGnIg5
         U29g==
X-Gm-Message-State: AHQUAubqOkaQvsWhLGfDBXwT/9apFkvwVLbTd7w9qfOiHVIutIYLlNdm
        Lhyl6FpVkgz/8+O0j+N76ic=
X-Google-Smtp-Source: AHgI3IZMKEuaHFpSRJE348VNK/JYaycjUA+1v0IpGqweptfYndOMZLbriZHwwrL4rsTm1I5ofPUzDg==
X-Received: by 2002:a05:6000:1144:: with SMTP id d4mr7572918wrx.136.1549456221584;
        Wed, 06 Feb 2019 04:30:21 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id x12sm18283182wrt.20.2019.02.06.04.30.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 04:30:21 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>, Joe Perches <joe@perches.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Paul Zimmerman <pauldzim@gmail.com>,
        Michal Kubecek <mkubecek@suse.cz>,
        Realtek linux nic maintainers <nic_swsd@realtek.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] r8169: Avoid pointer aliasing
Date:   Wed,  6 Feb 2019 13:30:18 +0100
Message-Id: <20190206123018.24802-2-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190206123018.24802-1-thierry.reding@gmail.com>
References: <20190206123018.24802-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Read MAC address 32-bit at a time and manually extract the individual
bytes. This avoids pointer aliasing and gives the compiler a better
chance of optimizing the operation.

Suggested-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Applies to net-next.

I tested this on a Jetson TX2 with an add-in Realtek ethernet card that
has a properly programmed OTP to verify that I got the endianess right.
Seems like everything works and the device behaves the same with or
without this patch.

Changes in v3:
- align MAC address to u16 for is_valid_ether_addr()

 drivers/net/ethernet/realtek/r8169.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169.c b/drivers/net/ethernet/realtek/r8169.c
index 501891be7c56..1dd72137fd53 100644
--- a/drivers/net/ethernet/realtek/r8169.c
+++ b/drivers/net/ethernet/realtek/r8169.c
@@ -7113,12 +7113,21 @@ static int rtl_alloc_irq(struct rtl8169_private *tp)
 static void rtl_read_mac_address(struct rtl8169_private *tp,
 				 u8 mac_addr[ETH_ALEN])
 {
+	u32 value;
+
 	/* Get MAC address */
 	switch (tp->mac_version) {
 	case RTL_GIGA_MAC_VER_35 ... RTL_GIGA_MAC_VER_38:
 	case RTL_GIGA_MAC_VER_40 ... RTL_GIGA_MAC_VER_51:
-		*(u32 *)&mac_addr[0] = rtl_eri_read(tp, 0xe0, ERIAR_EXGMAC);
-		*(u16 *)&mac_addr[4] = rtl_eri_read(tp, 0xe4, ERIAR_EXGMAC);
+		value = rtl_eri_read(tp, 0xe0, ERIAR_EXGMAC);
+		mac_addr[0] = (value >>  0) & 0xff;
+		mac_addr[1] = (value >>  8) & 0xff;
+		mac_addr[2] = (value >> 16) & 0xff;
+		mac_addr[3] = (value >> 24) & 0xff;
+
+		value = rtl_eri_read(tp, 0xe4, ERIAR_EXGMAC);
+		mac_addr[4] = (value >>  0) & 0xff;
+		mac_addr[5] = (value >>  8) & 0xff;
 		break;
 	default:
 		break;
@@ -7316,7 +7325,8 @@ static int rtl_get_ether_clk(struct rtl8169_private *tp)
 static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	const struct rtl_cfg_info *cfg = rtl_cfg_infos + ent->driver_data;
-	u8 mac_addr[ETH_ALEN] __aligned(4) = {};
+	/* align to u16 for is_valid_ether_addr() */
+	u8 mac_addr[ETH_ALEN] __aligned(2) = {};
 	struct rtl8169_private *tp;
 	struct net_device *dev;
 	int chipset, region, i;
-- 
2.19.1


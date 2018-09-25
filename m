Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D153DC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 18:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A1A6206B6
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 18:29:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PG2gNWUG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A1A6206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727616AbeIZAi2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 20:38:28 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35609 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbeIZAi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 20:38:28 -0400
Received: by mail-ed1-f65.google.com with SMTP id y21-v6so7932523edr.2;
        Tue, 25 Sep 2018 11:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5dOxKPyVnFpCd5drbktOqSHez7b5osKhJ2rFvkyz2FY=;
        b=PG2gNWUG57N8wNHZiYK0ikolC7or3gW4WROclZAZMxq9ild2M5qN9HiBp+jkht/F3i
         AVAsXj1pBGHYLzIZ4pgMV92CJQZA0d5y0urtpj8uAEnICYl4pP4mGR3aejlx8qg75C65
         4ePApO52Eu3UnB2VGJNWHBxBYe3XucUXRH+Ze7hqt0w9f9nHfsHLPwIaJkRchCTFsxU4
         /Z2yQQbkGnca005EuoF4n9y4crvWiMN+glpbKFVEIaXC/mwpjhn87Sw61ULxEir1JVNI
         AYVMXBG5Mss4wsxhm3iECeAn9SXHgLMVTczQwG5V9Y3MuWPJ4FdDu0RlWcELCTx80g76
         MPjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5dOxKPyVnFpCd5drbktOqSHez7b5osKhJ2rFvkyz2FY=;
        b=oFe52PefYD8phsh5yN9xgfYWCo5LUcU0fybjLJ1/J1koJ8RLCJwlmoUm6E8BlE9YuC
         1N9Sg0AL0Yf7cE2Vus9cO1H8y4RyA9yrC9CKEawLM5ANWantV8uWoUVdGQglTqnTCP0C
         wJS+dwd5q0t0//irRpbntSMmMAWyt6HUCizsNiNdhKPkzFWvM9vseoIFFRW7MWk4NavN
         2cy2sVkm4fjdMjbG5nUWu+p1vlQOJk/eMX1iME8CFTiy77dD6CSo4MYIKEU7DUr/aD93
         CawWUMb2a1GVG0B7rQ2ZLzXnoHD4oJF6ahcy1X+jwO3GgTgzpm5ykYVsGalAixrQhL3+
         hfvw==
X-Gm-Message-State: ABuFfog8Mv2rX4IxxZhgClyZLB3OLXSN+1saYYjlUCC4imjBtTkK0Mwp
        fe67zc1Fqp89xJXihVc9l70y780y
X-Google-Smtp-Source: ACcGV61wF2muCbAOd7jrYlfUNR/+erfTBz/2oxe3viHV3/14sAbqpC2pUQtgFJRnMyfIUY5aNRk69A==
X-Received: by 2002:a50:f489:: with SMTP id s9-v6mr3554502edm.172.1537900178198;
        Tue, 25 Sep 2018 11:29:38 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id g38-v6sm7834882edc.40.2018.09.25.11.29.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 11:29:37 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org (open list),
        dongsheng.wang@hxt-semitech.com, cphealy@gmail.com,
        clemens.gruber@pqgruber.com, hkallweit1@gmail.com, nbd@nbd.name,
        harini.katakam@xilinx.com
Subject: [PATCH net-next 2/2] net: phy: marvell: Avoid unnecessary soft reset
Date:   Tue, 25 Sep 2018 11:28:46 -0700
Message-Id: <20180925182846.30042-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180925182846.30042-1-f.fainelli@gmail.com>
References: <20180925182846.30042-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The BMCR.RESET bit on the Marvell PHYs has a special meaning in that
it commits the register writes into the HW for it to latch and be
configured appropriately. Doing software resets causes link drops, and
this is unnecessary disruption if nothing changed.

Determine from marvell_set_polarity()'s return code whether the register value
was changed and if it was, propagate that to the logic that hits the software
reset bit.

This avoids doing unnecessary soft reset if the PHY is configured in
the same state it was previously, this also eliminates the need for a
m88e1111_config_aneg() function since it now is the same as
marvell_config_aneg().

Tested-by: Wang, Dongsheng <dongsheng.wang@hxt-semitech.com>
Tested-by: Chris Healy <cphealy@gmail.com>
Tested-by: Andrew Lunn <andrew@lunn.ch>
Tested-by: Clemens Gruber <clemens.gruber@pqgruber.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/phy/marvell.c | 63 +++++++++++++--------------------------
 1 file changed, 21 insertions(+), 42 deletions(-)

diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
index f7c69ca34056..b55a7376bfdc 100644
--- a/drivers/net/phy/marvell.c
+++ b/drivers/net/phy/marvell.c
@@ -265,7 +265,7 @@ static int marvell_set_polarity(struct phy_device *phydev, int polarity)
 			return err;
 	}
 
-	return 0;
+	return val != reg;
 }
 
 static int marvell_set_downshift(struct phy_device *phydev, bool enable,
@@ -287,12 +287,15 @@ static int marvell_set_downshift(struct phy_device *phydev, bool enable,
 
 static int marvell_config_aneg(struct phy_device *phydev)
 {
+	int changed = 0;
 	int err;
 
 	err = marvell_set_polarity(phydev, phydev->mdix_ctrl);
 	if (err < 0)
 		return err;
 
+	changed = err;
+
 	err = phy_write(phydev, MII_M1111_PHY_LED_CONTROL,
 			MII_M1111_PHY_LED_DIRECT);
 	if (err < 0)
@@ -302,7 +305,7 @@ static int marvell_config_aneg(struct phy_device *phydev)
 	if (err < 0)
 		return err;
 
-	if (phydev->autoneg != AUTONEG_ENABLE) {
+	if (phydev->autoneg != AUTONEG_ENABLE || changed) {
 		/* A write to speed/duplex bits (that is performed by
 		 * genphy_config_aneg() call above) must be followed by
 		 * a software reset. Otherwise, the write has no effect.
@@ -350,42 +353,6 @@ static int m88e1101_config_aneg(struct phy_device *phydev)
 	return marvell_config_aneg(phydev);
 }
 
-static int m88e1111_config_aneg(struct phy_device *phydev)
-{
-	int err;
-
-	/* The Marvell PHY has an errata which requires
-	 * that certain registers get written in order
-	 * to restart autonegotiation
-	 */
-	err = genphy_soft_reset(phydev);
-
-	err = marvell_set_polarity(phydev, phydev->mdix_ctrl);
-	if (err < 0)
-		return err;
-
-	err = phy_write(phydev, MII_M1111_PHY_LED_CONTROL,
-			MII_M1111_PHY_LED_DIRECT);
-	if (err < 0)
-		return err;
-
-	err = genphy_config_aneg(phydev);
-	if (err < 0)
-		return err;
-
-	if (phydev->autoneg != AUTONEG_ENABLE) {
-		/* A write to speed/duplex bits (that is performed by
-		 * genphy_config_aneg() call above) must be followed by
-		 * a software reset. Otherwise, the write has no effect.
-		 */
-		err = genphy_soft_reset(phydev);
-		if (err < 0)
-			return err;
-	}
-
-	return 0;
-}
-
 #ifdef CONFIG_OF_MDIO
 /* Set and/or override some configuration registers based on the
  * marvell,reg-init property stored in the of_node for the phydev.
@@ -479,6 +446,7 @@ static int m88e1121_config_aneg_rgmii_delays(struct phy_device *phydev)
 
 static int m88e1121_config_aneg(struct phy_device *phydev)
 {
+	int changed = 0;
 	int err = 0;
 
 	if (phy_interface_is_rgmii(phydev)) {
@@ -487,15 +455,26 @@ static int m88e1121_config_aneg(struct phy_device *phydev)
 			return err;
 	}
 
-	err = genphy_soft_reset(phydev);
+	err = marvell_set_polarity(phydev, phydev->mdix_ctrl);
 	if (err < 0)
 		return err;
 
-	err = marvell_set_polarity(phydev, phydev->mdix_ctrl);
+	changed = err;
+
+	err = genphy_config_aneg(phydev);
 	if (err < 0)
 		return err;
 
-	return genphy_config_aneg(phydev);
+	if (phydev->autoneg != autoneg || changed) {
+		/* A software reset is used to ensure a "commit" of the
+		 * changes is done.
+		 */
+		err = genphy_soft_reset(phydev);
+		if (err < 0)
+			return err;
+	}
+
+	return 0;
 }
 
 static int m88e1318_config_aneg(struct phy_device *phydev)
@@ -2067,7 +2046,7 @@ static struct phy_driver marvell_drivers[] = {
 		.flags = PHY_HAS_INTERRUPT,
 		.probe = marvell_probe,
 		.config_init = &m88e1111_config_init,
-		.config_aneg = &m88e1111_config_aneg,
+		.config_aneg = &marvell_config_aneg,
 		.read_status = &marvell_read_status,
 		.ack_interrupt = &marvell_ack_interrupt,
 		.config_intr = &marvell_config_intr,
-- 
2.17.1


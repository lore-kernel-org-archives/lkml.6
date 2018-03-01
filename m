Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967448AbeCAKXT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 05:23:19 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:52776 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966865AbeCAKXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 05:23:13 -0500
From: Colin King <colin.king@canonical.com>
To: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
        Russell King <rmk@armlinux.org.uk>, netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][net-next] net: phy: Fix spelling mistake: "advertisment"-> "advertisement"
Date: Thu,  1 Mar 2018 10:23:03 +0000
Message-Id: <20180301102303.6795-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in comments and error message text.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/phy/bcm7xxx.c    |  2 +-
 drivers/net/phy/marvell.c    |  2 +-
 drivers/net/phy/marvell10g.c |  2 +-
 drivers/net/phy/phy-c45.c    |  8 ++++----
 drivers/net/phy/phy-core.c   |  4 ++--
 drivers/net/phy/phylink.c    | 12 ++++++------
 6 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/net/phy/bcm7xxx.c b/drivers/net/phy/bcm7xxx.c
index 421feb8f92fe..29b1c88b55cc 100644
--- a/drivers/net/phy/bcm7xxx.c
+++ b/drivers/net/phy/bcm7xxx.c
@@ -565,7 +565,7 @@ static int bcm7xxx_28nm_set_tunable(struct phy_device *phydev,
 	if (ret)
 		return ret;
 
-	/* Disable EEE advertisment since this prevents the PHY
+	/* Disable EEE advertisement since this prevents the PHY
 	 * from successfully linking up, trigger auto-negotiation restart
 	 * to let the MAC decide what to do.
 	 */
diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
index 22d9bc9c33a4..98fd6b7ceeec 100644
--- a/drivers/net/phy/marvell.c
+++ b/drivers/net/phy/marvell.c
@@ -860,7 +860,7 @@ static int m88e1510_config_init(struct phy_device *phydev)
 			return err;
 
 		/* There appears to be a bug in the 88e1512 when used in
-		 * SGMII to copper mode, where the AN advertisment register
+		 * SGMII to copper mode, where the AN advertisement register
 		 * clears the pause bits each time a negotiation occurs.
 		 * This means we can never be truely sure what was advertised,
 		 * so disable Pause support.
diff --git a/drivers/net/phy/marvell10g.c b/drivers/net/phy/marvell10g.c
index 8a0bd98fdec7..c56c9ed55c0e 100644
--- a/drivers/net/phy/marvell10g.c
+++ b/drivers/net/phy/marvell10g.c
@@ -317,7 +317,7 @@ static int mv3310_read_status(struct phy_device *phydev)
 		if (val < 0)
 			return val;
 
-		/* Read the link partner's 1G advertisment */
+		/* Read the link partner's 1G advertisement */
 		val = phy_read_mmd(phydev, MDIO_MMD_AN, MV_AN_STAT1000);
 		if (val < 0)
 			return val;
diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
index a4576859afae..74285756a17b 100644
--- a/drivers/net/phy/phy-c45.c
+++ b/drivers/net/phy/phy-c45.c
@@ -163,11 +163,11 @@ int genphy_c45_read_link(struct phy_device *phydev, u32 mmd_mask)
 EXPORT_SYMBOL_GPL(genphy_c45_read_link);
 
 /**
- * genphy_c45_read_lpa - read the link partner advertisment and pause
+ * genphy_c45_read_lpa - read the link partner advertisement and pause
  * @phydev: target phy_device struct
  *
  * Read the Clause 45 defined base (7.19) and 10G (7.33) status registers,
- * filling in the link partner advertisment, pause and asym_pause members
+ * filling in the link partner advertisement, pause and asym_pause members
  * in @phydev.  This assumes that the auto-negotiation MMD is present, and
  * the backplane bit (7.48.0) is clear.  Clause 45 PHY drivers are expected
  * to fill in the remainder of the link partner advert from vendor registers.
@@ -176,7 +176,7 @@ int genphy_c45_read_lpa(struct phy_device *phydev)
 {
 	int val;
 
-	/* Read the link partner's base page advertisment */
+	/* Read the link partner's base page advertisement */
 	val = phy_read_mmd(phydev, MDIO_MMD_AN, MDIO_AN_LPA);
 	if (val < 0)
 		return val;
@@ -185,7 +185,7 @@ int genphy_c45_read_lpa(struct phy_device *phydev)
 	phydev->pause = val & LPA_PAUSE_CAP ? 1 : 0;
 	phydev->asym_pause = val & LPA_PAUSE_ASYM ? 1 : 0;
 
-	/* Read the link partner's 10G advertisment */
+	/* Read the link partner's 10G advertisement */
 	val = phy_read_mmd(phydev, MDIO_MMD_AN, MDIO_AN_10GBT_STAT);
 	if (val < 0)
 		return val;
diff --git a/drivers/net/phy/phy-core.c b/drivers/net/phy/phy-core.c
index 4083f00c97a5..c7da4cbb1103 100644
--- a/drivers/net/phy/phy-core.c
+++ b/drivers/net/phy/phy-core.c
@@ -190,10 +190,10 @@ size_t phy_speeds(unsigned int *speeds, size_t size,
 }
 
 /**
- * phy_resolve_aneg_linkmode - resolve the advertisments into phy settings
+ * phy_resolve_aneg_linkmode - resolve the advertisements into phy settings
  * @phydev: The phy_device struct
  *
- * Resolve our and the link partner advertisments into their corresponding
+ * Resolve our and the link partner advertisements into their corresponding
  * speed and duplex. If full duplex was negotiated, extract the pause mode
  * from the link partner mask.
  */
diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 27327c917a59..ff38d72c7b84 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -364,7 +364,7 @@ static void phylink_get_fixed_state(struct phylink *pl, struct phylink_link_stat
 }
 
 /* Flow control is resolved according to our and the link partners
- * advertisments using the following drawn from the 802.3 specs:
+ * advertisements using the following drawn from the 802.3 specs:
  *  Local device  Link partner
  *  Pause AsymDir Pause AsymDir Result
  *    1     X       1     X     TX+RX
@@ -684,7 +684,7 @@ static int phylink_bringup_phy(struct phylink *pl, struct phy_device *phy)
 	linkmode_copy(pl->supported, supported);
 	linkmode_copy(pl->link_config.advertising, config.advertising);
 
-	/* Restrict the phy advertisment according to the MAC support. */
+	/* Restrict the phy advertisement according to the MAC support. */
 	ethtool_convert_link_mode_to_legacy_u32(&advertising, config.advertising);
 	phy->advertising = advertising;
 	mutex_unlock(&pl->state_mutex);
@@ -889,7 +889,7 @@ void phylink_start(struct phylink *pl)
 
 	/* Apply the link configuration to the MAC when starting. This allows
 	 * a fixed-link to start with the correct parameters, and also
-	 * ensures that we set the appropriate advertisment for Serdes links.
+	 * ensures that we set the appropriate advertisement for Serdes links.
 	 */
 	phylink_resolve_flow(pl, &pl->link_config);
 	phylink_mac_config(pl, &pl->link_config);
@@ -1076,7 +1076,7 @@ int phylink_ethtool_ksettings_set(struct phylink *pl,
 
 	config = pl->link_config;
 
-	/* Mask out unsupported advertisments */
+	/* Mask out unsupported advertisements */
 	linkmode_and(config.advertising, kset->link_modes.advertising,
 		     pl->supported);
 
@@ -1121,7 +1121,7 @@ int phylink_ethtool_ksettings_set(struct phylink *pl,
 	if (phylink_validate(pl, pl->supported, &config))
 		return -EINVAL;
 
-	/* If autonegotiation is enabled, we must have an advertisment */
+	/* If autonegotiation is enabled, we must have an advertisement */
 	if (config.an_enabled && phylink_is_empty_linkmode(config.advertising))
 		return -EINVAL;
 
@@ -1608,7 +1608,7 @@ static int phylink_sfp_module_insert(void *upstream,
 	iface = sfp_select_interface(pl->sfp_bus, id, config.advertising);
 	if (iface == PHY_INTERFACE_MODE_NA) {
 		netdev_err(pl->netdev,
-			   "selection of interface failed, advertisment %*pb\n",
+			   "selection of interface failed, advertisement %*pb\n",
 			   __ETHTOOL_LINK_MODE_MASK_NBITS, config.advertising);
 		return -EINVAL;
 	}
-- 
2.15.1

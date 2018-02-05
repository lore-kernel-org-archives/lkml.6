Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753116AbeBEMsi (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 07:48:38 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:49321 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752955AbeBEMsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 07:48:03 -0500
From: Colin King <colin.king@canonical.com>
To: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
        netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] net: phy-micrel: remove redundant initialization of pointer of_node
Date: Mon,  5 Feb 2018 12:47:59 +0000
Message-Id: <20180205124759.19046-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Pointer of_node is initialized with a value that is never read, of_node
is later updated with a new value instead, hence the initialization is
redundant and can be removed.  Also remove unused pointer dev and
remove an empty line.

Cleans up clang warnings:
drivers/net/phy/micrel.c:393:28: warning: Value stored to 'of_node'
during its initialization is never read
drivers/net/phy/micrel.c:532:28: warning: Value stored to 'of_node'
during its initialization is never read

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/phy/micrel.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 0f45310300f6..a86ecccde924 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -389,8 +389,7 @@ static int ksz9021_load_values_from_of(struct phy_device *phydev,
 
 static int ksz9021_config_init(struct phy_device *phydev)
 {
-	const struct device *dev = &phydev->mdio.dev;
-	const struct device_node *of_node = dev->of_node;
+	const struct device_node *of_node;
 	const struct device *dev_walker;
 
 	/* The Micrel driver has a deprecated option to place phy OF
@@ -401,7 +400,6 @@ static int ksz9021_config_init(struct phy_device *phydev)
 	do {
 		of_node = dev_walker->of_node;
 		dev_walker = dev_walker->parent;
-
 	} while (!of_node && dev_walker);
 
 	if (of_node) {
@@ -528,8 +526,7 @@ static int ksz9031_enable_edpd(struct phy_device *phydev)
 
 static int ksz9031_config_init(struct phy_device *phydev)
 {
-	const struct device *dev = &phydev->mdio.dev;
-	const struct device_node *of_node = dev->of_node;
+	const struct device_node *of_node;
 	static const char *clk_skews[2] = {"rxc-skew-ps", "txc-skew-ps"};
 	static const char *rx_data_skews[4] = {
 		"rxd0-skew-ps", "rxd1-skew-ps",
-- 
2.15.1

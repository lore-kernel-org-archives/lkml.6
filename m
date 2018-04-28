Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933376AbeD1Adb (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 20:33:31 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:43193 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933309AbeD1Ac5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 20:32:57 -0400
X-Google-Smtp-Source: AB8JxZo0k5pvBMNSZXYj3KKKiiHE/rKIMXaeDhfft/Nq0bOlU4uzl/1/D6zfhW7vZUKHspvAFrqZpQ==
From: Florian Fainelli <f.fainelli@gmail.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Russell King <rmk@armlinux.org.uk>,
        linux-kernel@vger.kernel.org (open list), davem@davemloft.net,
        cphealy@gmail.com, nikita.yoush@cogentembedded.com,
        vivien.didelot@savoirfairelinux.com, Nisar.Sayed@microchip.com,
        UNGLinuxDriver@microchip.com
Subject: [PATCH ethtool 1/2] ethtool-copy.h: Sync with net-next
Date: Fri, 27 Apr 2018 17:32:36 -0700
Message-Id: <20180428003237.1536-7-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180428003237.1536-1-f.fainelli@gmail.com>
References: <20180428003237.1536-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This brings support for PHY test modes (not accepted yet)

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 ethtool-copy.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/ethtool-copy.h b/ethtool-copy.h
index 8cc61e9ab40b..42fb94129da5 100644
--- a/ethtool-copy.h
+++ b/ethtool-copy.h
@@ -572,6 +572,7 @@ enum ethtool_stringset {
 	ETH_SS_TUNABLES,
 	ETH_SS_PHY_STATS,
 	ETH_SS_PHY_TUNABLES,
+	ETH_SS_PHY_TESTS,
 };
 
 /**
@@ -1296,6 +1297,25 @@ enum ethtool_fec_config_bits {
 #define ETHTOOL_FEC_RS			(1 << ETHTOOL_FEC_RS_BIT)
 #define ETHTOOL_FEC_BASER		(1 << ETHTOOL_FEC_BASER_BIT)
 
+/**
+ * struct ethtool_phy_test - Ethernet PHY test mode
+ * @cmd: Command number = %ETHTOOL_GPHYTEST or %ETHTOOL_SPHYTEST
+ * @flags: A bitmask of flags from &enum ethtool_test_flags.  Some
+ *      flags may be set by the user on entry; others may be set by
+ *      the driver on return.
+ * @mode: PHY test mode to enter. The index should be a valid test mode
+ * obtained through ethtool_get_strings with %ETH_SS_PHY_TESTS
+ * @len: The length of the test specific array @data
+ * @data: Array of test specific results to be interpreted with @mode
+ */
+struct ethtool_phy_test {
+        __u32   cmd;
+        __u32   flags;
+        __u32   mode;
+        __u32   len;
+        __u8    data[0];
+};
+
 /* CMDs currently supported */
 #define ETHTOOL_GSET		0x00000001 /* DEPRECATED, Get settings.
 					    * Please use ETHTOOL_GLINKSETTINGS
@@ -1391,6 +1411,9 @@ enum ethtool_fec_config_bits {
 #define ETHTOOL_GFECPARAM	0x00000050 /* Get FEC settings */
 #define ETHTOOL_SFECPARAM	0x00000051 /* Set FEC settings */
 
+#define ETHTOOL_GPHYTEST        0x00000052 /* Get PHY test mode(s) */
+#define ETHTOOL_SPHYTEST        0x00000053 /* Set PHY test mode */
+
 /* compatibility with older code */
 #define SPARC_ETH_GSET		ETHTOOL_GSET
 #define SPARC_ETH_SSET		ETHTOOL_SSET
-- 
2.14.1

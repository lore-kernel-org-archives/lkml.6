Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753330AbeCEWHf (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 17:07:35 -0500
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:44384 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753117AbeCEWHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 17:07:33 -0500
From: Brandon Streiff <brandon.streiff@ni.com>
To: Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>
CC: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Brandon Streiff <brandon.streiff@ni.com>
Subject: [PATCH net-next] dt-bindings: net: dsa: marvell: describe compatibility string
Date: Mon, 5 Mar 2018 16:05:22 -0600
Message-ID: <1520287522-308-1-git-send-email-brandon.streiff@ni.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-05_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two compatibility strings for mv88e6xxx, but it isn't clear
from the documentation why only those two exist when the mv88e6xxx driver
supports more than the 6085 and 6190. Briefly describe how the compatible
property is used, and provide guidance on which to use.

The model list comes from looking at port_base_addr values (0x0 vs 0x10)
in drivers/net/dsa/mv88e6xxx/chip.c.

Signed-off-by: Brandon Streiff <brandon.streiff@ni.com>
---
 Documentation/devicetree/bindings/net/dsa/marvell.txt | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/dsa/marvell.txt b/Documentation/devicetree/bindings/net/dsa/marvell.txt
index 1d4d0f4..caf71e2 100644
--- a/Documentation/devicetree/bindings/net/dsa/marvell.txt
+++ b/Documentation/devicetree/bindings/net/dsa/marvell.txt
@@ -13,9 +13,18 @@ placed as a child node of an mdio device.
 The properties described here are those specific to Marvell devices.
 Additional required and optional properties can be found in dsa.txt.
 
+The compatibility string is used only to find an identification register,
+which is at a different MDIO base address in different switch families.
+- "marvell,mv88e6085"	: Switch has base address 0x10. Use with models:
+			  6085, 6095, 6097, 6123, 6131, 6141, 6161, 6165,
+			  6171, 6172, 6175, 6176, 6185, 6240, 6320, 6321,
+			  6341, 6350, 6351, 6352
+- "marvell,mv88e6190"	: Switch has base address 0x00. Use with models:
+			  6190, 6190X, 6191, 6290, 6390, 6390X
+
 Required properties:
 - compatible		: Should be one of "marvell,mv88e6085" or
-			  "marvell,mv88e6190"
+			  "marvell,mv88e6190" as indicated above
 - reg			: Address on the MII bus for the switch.
 
 Optional properties:
-- 
2.1.4
